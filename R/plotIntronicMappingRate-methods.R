#' @name plotIntronicMappingRate
#' @author Michael Steinbaugh, Rory Kirchner, Victor Barrera
#' @inherit bioverbs::plotIntronicMappingRate
#' @note Updated 2019-09-16.
#'
#' @inheritParams acidroxygen::params
#' @param ... Additional arguments.
#'
#' @examples
#' data(bcb)
#' plotIntronicMappingRate(bcb)
NULL



#' @rdname plotIntronicMappingRate
#' @name plotIntronicMappingRate
#' @importFrom bioverbs plotIntronicMappingRate
#' @usage plotIntronicMappingRate(object, ...)
#' @export
NULL



## Updated 2019-09-16.
`plotIntronicMappingRate,bcbioRNASeq` <-  # nolint
    function(
        object,
        interestingGroups = NULL,
        limit = 0.2,
        fill,
        labels = list(
            title = "Intronic mapping rate",
            subtitle = NULL,
            sampleAxis = NULL,
            metricAxis = "intronic mapping rate (%)"
        ),
        flip
    ) {
        validObject(object)
        assert(
            isNumber(limit),
            isProportion(limit),
            isGGScale(fill, scale = "discrete", aes = "fill", nullOK = TRUE),
            isFlag(flip)
        )
        labels <- matchLabels(
            labels = labels,
            choices = eval(formals()[["labels"]])
        )
        interestingGroups(object) <-
            matchInterestingGroups(object, interestingGroups)
        interestingGroups <- interestingGroups(object)
        p <- ggplot(
            data = metrics(object),
            mapping = aes(
                x = !!sym("sampleName"),
                y = !!sym("intronicRate") * 100L,
                fill = !!sym("interestingGroups")
            )
        ) +
            acid_geom_bar() +
            acid_scale_y_continuous_nopad(limits = c(0L, 100L))
        ## Labels.
        if (is.list(labels)) {
            labels[["fill"]] <- paste(interestingGroups, collapse = ":\n")
            names(labels)[names(labels) == "sampleAxis"] <- "x"
            names(labels)[names(labels) == "metricAxis"] <- "y"
            p <- p + do.call(what = labs, args = labels)
        }
        ## Limit.
        if (isPositive(limit)) {
            ## Convert to percentage
            if (limit > 1L) {
                ## nocov start
                warning("'limit': Use ratio (0-1) instead of percentage.")
                ## nocov end
            } else {
                limit <- limit * 100L
            }
            if (limit < 100L) {
                p <- p + acid_geom_abline(yintercept = limit)
            }
        }
        ## Fill.
        if (is(fill, "ScaleDiscrete")) {
            p <- p + fill
        }
        ## Flip.
        if (isTRUE(flip)) {
            p <- acid_coord_flip(p)
        }
        ## Hide sample name legend.
        if (identical(interestingGroups, "sampleName")) {
            p <- p + guides(fill = FALSE)
        }
        ## Return.
        p
    }

formals(`plotIntronicMappingRate,bcbioRNASeq`)[c("fill", "flip")] <-
    formalsList[c("fill.discrete", "flip")]



#' @rdname plotIntronicMappingRate
#' @export
setMethod(
    f = "plotIntronicMappingRate",
    signature = signature("bcbioRNASeq"),
    definition = `plotIntronicMappingRate,bcbioRNASeq`
)
