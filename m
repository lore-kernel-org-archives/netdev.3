Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE373C4561;
	Thu, 25 Jun 2026 09:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782380210; cv=none; b=pI430n0Lg0B2k0tEBwNiiP/LKIqGBdZa2qiLaL0lLsYbd9CSowVmqU/TfcTPCQppEU5Knn47uUtgUtgJG91QuV5goztahxc5kOtWwWEO/QlX0j41GQrmE9SUthjMuoQrXlL39NXvqBGDqg+XrzMyu8mzOOwFly/srII/sWpq9SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782380210; c=relaxed/simple;
	bh=rRSe5UYdtgXfPf6q+vol8JdWJLCMuNhMqAGBv48tzMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=utHRQlF6vMDWcxDE9MbglF5zUaR3Nd8XYSr2J1vmTVQsv64wrnGrloJBQZ4ByvWPaxO3jiQgN/jhThQq0FZICsVfphhCk7WK3242/qpeHv5hnOIMBOc4C3bOPQPx9GqwGXvvw3AB7899kt6GUu6b8hnp8Si5raeVD6zghbiujZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jn6uZ+c4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jn6uZ+c4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 293181F00A3A;
	Thu, 25 Jun 2026 09:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782380205;
	bh=5HYdIY8TNsk1uqNwTmIODhGmVb8Ia7VxVemmKMt3jDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Jn6uZ+c4nsQjq9TL+Fp+V2EP/G6D40LDP78kTyS59CJpyGxFrwSOWf2UQOh7sB1oX
	 Uy3/+4XvGY8SNX1SiNJOQYNZtfsssUvQn5vhJnYZxCR4a9caG4wtw0u99+zcCA0xiQ
	 a4rQETpiAcLK+7xt7U1ULqoSDn4syJDaDUB6oe/tNOgbpe2/WPcZbOu8jvr9T18fsH
	 qtJdlB/jnZjqRzLcXGfQHEIZyNZ1JywwxeAZEzDywuh5sGE55DuR+AmxlefQDlTINy
	 C0PJ9EcEGfQf5UQrN8stzCUwBTeKJibbJthkIuBkvfC3S+rBvBMdjRs9Mv7Pcbw192
	 bkVeFfjbYIdiw==
From: Simon Horman <horms@kernel.org>
To: rosenp@gmail.com
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	claudiu.manoil@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	afleming@freescale.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: gianfar: use of_irq_get()
Date: Thu, 25 Jun 2026 10:36:30 +0100
Message-ID: <20260625093630.1173136-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260624032122.986986-1-rosenp@gmail.com>
References: <20260624032122.986986-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
net: gianfar: use of_irq_get()

This patch switches gfar_parse_group() from irq_of_parse_and_map() to
of_irq_get() and widens the irq field in struct gfar_irqinfo from
unsigned int to int. The stated goals are to fix a leak from a missing
irq_dispose_mapping() and to enable -EPROBE_DEFER propagation.

> diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
> index 3271de5844f8..17a0d0787ed2 100644
> --- a/drivers/net/ethernet/freescale/gianfar.c
> +++ b/drivers/net/ethernet/freescale/gianfar.c
> @@ -514,15 +514,15 @@ static int gfar_parse_group(struct device_node *np,
>  	if (!grp->regs)
>  		return -ENOMEM;
>
> -	gfar_irq(grp, TX)->irq = irq_of_parse_and_map(np, 0);
> +	gfar_irq(grp, TX)->irq = of_irq_get(np, 0);
>
>  	/* If we aren't the FEC we have multiple interrupts */
>  	if (model && strcasecmp(model, "FEC")) {
> -		gfar_irq(grp, RX)->irq = irq_of_parse_and_map(np, 1);
> -		gfar_irq(grp, ER)->irq = irq_of_parse_and_map(np, 2);
> -		if (!gfar_irq(grp, TX)->irq ||
> -		    !gfar_irq(grp, RX)->irq ||
> -		    !gfar_irq(grp, ER)->irq)
> +		gfar_irq(grp, RX)->irq = of_irq_get(np, 1);
> +		gfar_irq(grp, ER)->irq = of_irq_get(np, 2);
> +		if (gfar_irq(grp, TX)->irq < 0 ||
> +		    gfar_irq(grp, RX)->irq < 0 ||
> +		    gfar_irq(grp, ER)->irq < 0)
>  			return -EINVAL;
>  	}

[High]
Does this change miss the 0-return mapping failure case?

The kernel-doc on of_irq_get() in drivers/of/irq.c says it returns:

    Linux IRQ number on success, or 0 on the IRQ mapping failure, or
    -EPROBE_DEFER ..., or error code in case of any other failure.

The old test rejected an irq value of 0 with !gfar_irq(grp, *)->irq,
which caught both irq_of_parse_and_map()'s and of_irq_get()'s
zero-on-failure. The new test only rejects values strictly less than
zero, so a 0 returned from of_irq_get() is now stored as the IRQ and
later flows into request_irq()/free_irq() during probe and unbind.

Should the test be <= 0, or split so that negative errors are
propagated and 0 still triggers a failure?

[High]
Is -EPROBE_DEFER lost here?

The commit message states:

    Changed irq to an int as required by the of_irq_get API as it
    supports -EPROBE_DEFER.

However, the only error path is:

    if (gfar_irq(grp, TX)->irq < 0 ||
        gfar_irq(grp, RX)->irq < 0 ||
        gfar_irq(grp, ER)->irq < 0)
            return -EINVAL;

of_irq_get() returns -EPROBE_DEFER when irq_find_host() cannot yet
locate the parent interrupt controller. Collapsing every negative
return into -EINVAL prevents the driver core from retrying the probe
once the interrupt controller appears.

Should the actual error from of_irq_get() be propagated, for example:

    int ret = gfar_irq(grp, TX)->irq;
    if (ret < 0)
            return ret;

so that -EPROBE_DEFER reaches gfar_of_init() and then gfar_probe()?

[Medium]
Can the commit message description be revisited?

The message states:

    of_irq_get() differs from irq_of_parse_and_map() in that the latter
    requires calling irq_dispose_mapping() when done, which is missing
    in the driver. Meaning it leaks memory.

    No need to map it anyway. Just need the value stored in the irq
    field.

Looking at of_irq_get() in drivers/of/irq.c:

    int of_irq_get(struct device_node *dev, int index)
    {
            ...
            rc = irq_create_of_mapping(&oirq);
            ...
    }

of_irq_get() ends with the same irq_create_of_mapping() call that
irq_of_parse_and_map() makes, so the resulting virq mapping is created
identically by both APIs.

If the previous code leaked, does the new code not leak in the same
way? And does the Fixes: b31a1d8b4151 tag accurately describe this
change, given that it may cause stable-tree selection on the basis of a
leak that does not appear to exist?
