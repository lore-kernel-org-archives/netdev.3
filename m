Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2159455612;
	Sun, 11 Oct 2026 19:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791747910; cv=none; b=ueCaQwIvh8Exx5q2w6d+eD2iULG6Mpxhc5f0Sq0ldofg4+I/m+X0jKMfvdpH/qWsU1sn2dEBRpl/S2ZiHLu3dJ+xuu85njhf5ZRWHxLD884DuLXz5rkTY1iEWU1xjbpEM776XR9Wbg4ydKlVSW4piJ1AmtkXh1uMtUtmNYqxeXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791747910; c=relaxed/simple;
	bh=FPdpd8gT29Gh0zUNwmreQcIfpmq56TfSfjT+2tbPxa0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JKCW1TCKQ/cQFsK/fG3HkHiyKRAK30Xz6b09NMFYMx5lFqpJBEbPJ8hK8qY+u7lrCMqXaKZR/xwETQIj18JAFbwi8s7vlhOSATGnCCsMQzHSrHhXsa9kDYxaQ0+4AiyjsGRKpvY1WYXQNiPHj1tHFAv7Vyppy9pPc7g8Cej6DqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ExFVIFE2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ExFVIFE2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 797401F0089B;
	Sun, 11 Oct 2026 19:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791747901;
	bh=gSnuH3Zg6RqB1DjI+yADtKmzw9T8Yvd967cSZbfGAzw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ExFVIFE2EmlnUwD2LAH+ZI6sqT/DSZJSGrw6CIGFOBE8Tk+d96aHm55V9wz2UroZo
	 ySDWoHLnXdSpmrRtwYpx1U0etk7+7Ogxrs6l3mozzpqBVafapHJLhMoRh2RXRYZ/HN
	 8CUTJpz8F+chIWjbhbtvvr2siXTIntyyqTKOeqnBLwW2d7h+ohZTuU4e9NnlcaTV30
	 I6qnP67tm4zp/6LK1mq9RiM6td+d9QhhZ/UHMCcJv3sNgVVvsH1VnvTSolVljYBC/S
	 IRRxzQwViz7MMtTjIuUNN2YyF5md9ToaRSYVTEROrptFi00uFgB7/ctWwoaMNiKcyE
	 p5qTl9EHHt5wA==
Subject:
 Re: [PATCH net-next v7 3/3] arm64: dts: renesas: r8a779g0: Add gPTP node
From: netdev-bot+sashiko@kernel.org
To: niklas.soderlund+renesas@ragnatech.se
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 geert+renesas@glider.be, magnus.damm@gmail.com, richardcochran@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
 sergei.shtylyov@gmail.com, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Date: Sun, 11 Oct 2026 19:44:59 +0000
Message-ID: <179174789977.434549.2392596985462710897@kernel.org>
In-Reply-To: <20261007185920.4042783-4-niklas.soderlund+renesas@ragnatech.se>
References: <20261007185920.4042783-4-niklas.soderlund+renesas@ragnatech.se>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] dts: shared reset line between gptp and tsn0 causes probe
  failure and state corruption
- [Medium] The new `gptp: ptp@e6449000` node in r8a779g0.dtsi claims `reg
  = <0 0xe6449000 0 0x500>`, plus CPG clock 2723 and CPG reset 2723.

Pre-existing issues:
- [Low] Documentation/devicetree/bindings/ptp/renesas,rcar-gen4-gptp.yaml
  lists `resets` as required, and the new r8a779g0 node supplies `resets…

--

arm64: dts: renesas: r8a779g0: Add gPTP node

This adds a disabled gPTP node at 0xe6449000 to the R-Car V4H (r8a779g0)
SoC dtsi. The node uses CPG module clock and reset 2723 and the always-on
power domain. The commit message says the gPTP module is shared between
the RAVB and RTSN Ethernet devices.

> diff --git a/arch/arm64/boot/dts/renesas/r8a779g0.dtsi b/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
> index 8a291447b9045..7430b663cf92e 100644
> --- a/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
> @@ -606,6 +606,15 @@ mfis: system-controller@e6260000 {
>  			status = "disabled";
>  		};
>  
> +		gptp: ptp@e6449000 {
> +			compatible = "renesas,r8a779g0-gptp", "renesas,rcar-gen4-gptp";
> +			reg = <0 0xe6449000 0 0x500>;

[Severity: Medium]

Does this window overlap with the existing tsn0 node? The tsn0 node just
below is not changed by this patch. It still claims the same range as its
second reg entry and uses the same clock and reset:

	tsn0: ethernet@e6460000 {
		...
		reg = <0 0xe6460000 0 0x7000>,
		      <0 0xe6449000 0 0x500>;
		reg-names = "tsnes", "gptp";
		...
		clocks = <&cpg CPG_MOD 2723>;
		...
		resets = <&cpg 2723>;

Both drivers request this region exclusively. rtsn_probe() in
drivers/net/ethernet/renesas/rtsn.c does:

	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "gptp");
	...
	ptpaddr = devm_ioremap_resource(&pdev->dev, res);

It then registers its own PHC through rcar_gen4_ptp_register().

ptp_rcar_gen4_probe() in drivers/ptp/ptp_rcar_gen4.c does:

	priv->base = devm_platform_ioremap_resource(pdev, 0);

Both paths go through devm_request_mem_region(), so whichever driver
probes second fails with -EBUSY.

white-hawk-single.dtsi already enables tsn0. Suppose a V4H board like that
also enables &gptp so RAVB can reference it through ptp-timer in
ravb_gen4_ptp_probe(). Would one of the two devices then fail to probe?
The gptp node comes first in DT order, so RTSN would usually be the one
that fails, and the TSN Ethernet port would be lost.

The node is disabled and no board enables it yet, so nothing breaks at
this commit.

The commit message says:

  The gPTP module is shared between the RAVB and RTSN Ethernet devices on
  the SoC.

RTSN does not seem to be converted to use the shared node, though. It
still maps the window privately. Should tsn0 and rtsn.c be updated to
reference this node? If not, should the commit message say that enabling
&gptp together with &tsn0 is not supported?

> +			clocks = <&cpg CPG_MOD 2723>;
> +			power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
> +			resets = <&cpg 2723>;

[Severity: High]
The existing tsn0 node also uses reset 2723, and rtsn.c treats
that reset as its own. rtsn_probe() takes it with
devm_reset_control_get(&pdev->dev, NULL), which is an exclusive get.
rtsn_reset() then pulses it with reset_control_reset() every time
rtsn_hw_init() runs, which happens whenever the TSN port is brought
up.

This node makes the gPTP block a resource that RAVB can reference
through ptp-timer. Suppose RTSN brings its port up after
ptp_rcar_gen4 has programmed the timer. The reset pulse clears the
gPTP registers (PTPTMEC_REG and the rest) under ptp_rcar_gen4 and
under every RAVB user of that clock. Nothing reprograms them
afterwards, so PTP synchronisation is lost for the whole system.

This also blocks handing the reset to the gPTP driver later.
ptp_rcar_gen4_probe() does not request a reset today, but the
binding requires the property. If the driver ever requests it, the
second exclusive get of the same line fails with -EBUSY, and one of
the two devices will not probe.

The node is disabled, so nothing breaks at this commit. But this
description is what lets both consumers be enabled together. How is
reset 2723 meant to be owned once gptp and tsn0 are both enabled?
Should rtsn.c stop pulsing the shared block when an external gPTP
node is in use, for example by switching to a shared reset that is
only deasserted? Or should tsn0 drop its reset and its gptp reg
window and reference this node instead?

[Severity: Low]

This isn't a bug introduced by this patch, but the
renesas,rcar-gen4-gptp.yaml binding lists resets as required, while
ptp_rcar_gen4_probe() never gets or deasserts a reset control:

	priv->base = devm_platform_ioremap_resource(pdev, 0);
	...
	priv->clk = devm_clk_get(dev, NULL);
	...
	pm_runtime_enable(dev);
	pm_runtime_resume_and_get(dev);

Does the driver depend on the gPTP module already being out of reset when
it probes? Reset 2723 given here is also used by tsn0.

The binding and the driver both come from earlier patches in this series
("dt-bindings: ptp: renesas,rcar-gen4-gptp: Add R-Car Gen4" and "ptp: Add
driver for R-Car Gen4"). Listing the reset in the binding is correct for
describing the hardware.

> +			status = "disabled";
> +		};
> +

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261007185920.4042783-1-niklas.soderlund%2Brenesas%40ragnatech.se
