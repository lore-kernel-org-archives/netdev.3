Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792465783;
	b=jy5X+BYc7PF6B7z1It9dvwLqpq2mIjKytKCafrACLDKrYnPZ9gcUwA5Bg5NEzECdZ4wb
	 OEmEgFLA/cIsJo+GgPoQfX9/lN9w8ls+Mj0OZ0lHy2b3IwBuq5fr7vVRD1Qa1yBj9i4pb
	 JOqLQnUsUt6lLlaM9m1dM06TdCC5uqf+iB07oM12VuK1uWj+h/Ip6LSCmJU78gJDW875R
	 PP4mWs8jyPoVyfYbM98aqUqdFdSMcvIcRPv5Qe28k+OTPOcZauo+iN3l9A9onBVxtw3NA
	 LEwV/71XD/CLk2XX++rHTC43x2LidElH/HI1oQKL8qAsrXUxZg06pTVhoX3I2Mut2WQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792465783;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=qbpZGi0YGb8gkNMJY4SAhVtoMuzmifcUepo1w9gCPD0=;
	b=mDlfSct3xxd/QOYSBjb4djzJTGgq+VTtimONu+UC8N1Gswf4mAndDV2etZB4VpIpz10G
	 EyGtgTn2aTFzFhmECLzS65TYobqR1bUoRpKR7eaaZL8pGHP7Rw3QFyl3/fO4EbKVB5Wtb
	 2hwJlp5e9NAMWTMvsqAx4Q3u80OeQD/wwht3CbOVEfcdUJiwf4npb5OPc+6tXI8/33rru
	 2ZtJfg8bwZAjOXGgqMZpPiLZRf0XsWIz4uhGnvSGbNU8eyB0n+/COq4DfY///OxEWPRW2
	 UwKFYYE8CIdy6njp0TAivaIjt9eOnTZ1SahdM2ea+ywKn2OCNVBtZpHoC4JuT+JFKgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BylbAY1A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA3E60A381C;
	Tue, 20 Oct 2026 03:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BylbAY1A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C7EA1F00AE3;
	Tue, 20 Oct 2026 03:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792465783;
	bh=qbpZGi0YGb8gkNMJY4SAhVtoMuzmifcUepo1w9gCPD0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=BylbAY1Ab4GY2ExyvXa+TS7dmT2cvzllQZ6c2Ke2AkM045JgxFSs0D1YS8k9lVSxW
	 YwmvrR1sdp2MJzmqTG9fbPt5JBUa6nky/znqIdfzN6BtmA5PcAbrFfot3QbmUh/Ale
	 jNUPtauTyK0/OkhArSacpWm5gJNw8jNc025isze32MV5YToyFttqG6AXdLRaxvxJuA
	 aY/L/prhyho3zQpbL9xkTolefNQ+lRn75fdwWfatAJ2tpJ14QzDUmrDF2aAyBkI7iD
	 b2CoUQ6hR+PUQACiwG3ybvAy5wDyVoG7ytHG/XvFO1Vm2V2/V3rvkXojhvdmz5yHS6
	 8qwb6ASFGsSFA==
Subject: Re: [PATCH net-next v14 04/12] dpll: sit9531x: read DPLL types and
 pin properties from system firmware
From: netdev-bot+sashiko@kernel.org
To: arouhi@sitime.com
Cc: jiri@resnulli.us, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, ivecera@redhat.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 prabhakar.mahadev-lad.rj@bp.renesas.com, cjubran@nvidia.com,
 Oleg.Zadorozhnyi@devoxsoftware.com, devicetree@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 20 Oct 2026 03:09:41 +0000
Message-ID: <179246578175.3135.10886310963157005206@kernel.org>
In-Reply-To: <20261016005823.13690-5-arouhi@sitime.com>
References: <20261016005823.13690-5-arouhi@sitime.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] On the SiT95317, sit9531x_prop_pin_package_label_set() builds
  the user-visible DPLL package_label as "OUT%u" from…

--

dpll: sit9531x: read DPLL types and pin properties from system firmware

This commit adds prop.c, which builds DPLL device types and per-pin
properties for the SiT9531x from the firmware node. The properties are
package and board labels, pin type, capabilities and supported
frequencies, with defaults when the node does not describe them. Input
labels are derived from the pair and lane layout, and output labels from
the variant's clkout_map.

> diff --git a/drivers/dpll/sit9531x/prop.c b/drivers/dpll/sit9531x/prop.c
> new file mode 100644
> index 0000000000000..8dd1d3fefbb54
> --- /dev/null
> +++ b/drivers/dpll/sit9531x/prop.c

[ ... ]

> +	if (dir == DPLL_PIN_DIRECTION_INPUT)
> +		sit9531x_input_pin_label(sitdev, props, id);
> +	else
> +		/*
> +		 * Name the chip pin, not the driver's index for it.  The
> +		 * two differ on the variant whose outputs are bonded out
> +		 * from a subset of the twelve slots, and a package label
> +		 * that named the index would point at a pin that is not
> +		 * the one being driven.
> +		 */
> +		snprintf(props->package_label, sizeof(props->package_label),
> +			 "OUT%u", sitdev->info->clkout_map[id]);

[Severity: Medium]
On the SiT95317, does this label name the package pin from the
datasheet, or the internal die slot?

In sit9531x_prop_pin_package_label_set() the label comes from
clkout_map[id], and in core.c that is:

    static const u8 clkout_map_95317[] = {0, 3, 4, 5, 7, 8, 9, 11};

So the 8 outputs are advertised in DPLL_A_PIN_PACKAGE_LABEL as OUT0,
OUT3, OUT4, OUT5, OUT7, OUT8, OUT9 and OUT11.

The sitime,sit95316.yaml binding in this series describes the vddoN
supplies like this:

    The SiT95317 has one per output, VDDO0 to VDDO7, numbered as that
    part's datasheet numbers its outputs; in the pin numbering of this
    binding those are outputs 0, 3, 4, 5, 7, 8, 9 and 11, in that order.

If that is right, the 95317 datasheet numbers its outputs 0..7. Labels
such as OUT9 and OUT11 would then not exist on that package.

Some labels would also point at a different physical pin. Driver index 3
gets the label OUT5, but the datasheet's OUT5 is driver index 5, which
gets the label OUT9.

The top-level binding text ("the SiT95317 bonds out OUT0, OUT3, ...")
uses the slot naming instead, so the two descriptions disagree. Which
numbering does the 95317 datasheet use?

If it uses 0..7, should the package label use the driver index (or a
separate per-variant package name table) on this variant? The label is
visible to userspace through netlink, so it would be hard to change once
released. This code is unchanged at the end of the series.

> +
> +	props->dpll_props.package_label = props->package_label;
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016005823.13690-1-arouhi%40sitime.com
