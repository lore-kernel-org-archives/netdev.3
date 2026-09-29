Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D8622F767;
	Tue, 29 Sep 2026 00:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790641923; cv=none; b=JqHJIhxSAcwH0576hvafOrnJalK1etfLkrq4XmOj2pSs8IKd29K5Zt6H76VDoa+GdmlYOAenWVuPKSSwhR8ZsCO19E9sapatTfqmmS0gdx1X2WDxt44Ea8vUAAubfSdXpuQy8SRIeOMyEDq+Mn0lq4QwdDzE+TPZnuckjbRZjOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790641923; c=relaxed/simple;
	bh=ZbckNXvV5uKiRT3U3L689/mCxd0VFD/hRzQ8ybLoP24=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eUxJUEOAjVl9wsr9wQnEn7TNGKE7jKKxdJ6Vtf5vEKntAPQsxfKBRob2l61Jwf8TAvBkS8iRTiC/jZb4Icg2krGA4If5EduheT8KGvdL9j72Z2sKd0W0f+6oNRtf+J0btIaw/agEcY+eVCMrddFjaM/tX+ll9CqOryrIZecS8zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QTeRpSY0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTeRpSY0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 849281F000FF;
	Tue, 29 Sep 2026 00:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790641921;
	bh=nY0fE+YQHjIgslNjpPF/UF5o9rAcDKDWb+akzffcQY8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QTeRpSY0++Y6kQgf8kmFBO05yjLxZn2zTEv39eXdZJyRbHJon58QMJl9zhMZY37Zk
	 Nu//t+5fBXOq7WyJ5ulFMte3z3aQSgkW+c9Te1FyCwJ4ej2yA/5BbPct4TDlVbWvzA
	 etj2i8qyj6wPLWpRuN9x04Ck9UNCNGka9SNrm43Bp/GuByO1s1s1MpxzVrvlGIZO5j
	 SFBaLm1BGuqrAIDLOGX1oD3UE44jveZ1rbgDz57SPR/kEcANSbQ6e+j8G41cexRGNL
	 RzYo1WS2KJ6hduCpSspQFUrDFaVz9ckRMpjsHeQhAiFzcxPoLJqBe9qBEPvQXUEsNc
	 o+aa/raFvhRaQ==
Subject: Re: [PATCH net-next v4 1/2] dt-bindings: net: ethernet-phy: add
 needs-host-firmware
From: netdev-bot+sashiko@kernel.org
To: f@lex.la
Cc: netdev@vger.kernel.org, linux@armlinux.org.uk, andrew@lunn.ch,
 andrew+netdev@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, conor@kernel.org,
 f.fainelli@gmail.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 29 Sep 2026 00:31:59 +0000
Message-ID: <179064191988.3145.13772240561731551467@kernel.org>
In-Reply-To: <20260925001209.2334139-2-f@lex.la>
References: <20260925001209.2334139-2-f@lex.la>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] For the only PHY the patch names, the new generic `needs-host-
  firmware` flag can be deduced from the compatible.
- [Low] Concern: the new `needs-host-firmware` property in
  Documentation/devicetree/bindings/net/ethernet-phy.yaml has no…

--

dt-bindings: net: ethernet-phy: add needs-host-firmware

This adds a generic needs-host-firmware flag to the ethernet-phy binding.
The flag says the host has to load firmware into the PHY before it can be
driven. A consumer that sees the flag keeps the port and connects the PHY
once its real driver binds, which fixes a dead lan4 port on a Keenetic
KN-1012 with an EN8811H PHY.

> diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> index c3ebb3af8b528..73827662ddce2 100644
> --- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> +++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> @@ -215,6 +215,12 @@ properties:
>        used. The absence of this property indicates the muxers
>        should be configured so that the external PHY is used.
>  
> +  needs-host-firmware:
> +    $ref: /schemas/types.yaml#/definitions/flag

[Severity: Low]
In this patch alone, nothing reads needs-host-firmware. Is anything in
this commit meant to consume it?

A later patch in the series, "net: phylink: wait for PHYs that are known
to probe late", appears to resolve this. There, phylink_fwnode_phy_connect()
checks:

    if (fwnode_property_present(phy_fwnode, "needs-host-firmware") &&
        !phylink_phy_is_usable(phy_dev)) {

When the check matches, it arms the phylink_late_phy_poll() delayed work
instead of attaching genphy. This is noted only for completeness, since
the binding lands before its user in the same series.

> +    description:
> +      This PHY runs firmware that the host must load before it can be
> +      driven, and is not usable until then.

[Severity: Medium]
For the EN8811H, doesn't the compatible already imply this flag?
Documentation/devicetree/bindings/writing-bindings.rst says:

  - DON'T add properties to avoid a specific compatible. DON'T add
    properties if they are implied by (deducible from) the compatible.

airoha,en8811h.yaml fixes the compatible to ethernet-phy-id03a2.a411. The
driver loads host firmware for every instance without any condition:

drivers/net/phy/air_en8811h.c:en8811h_probe() {
    ...
	ret = en8811h_load_firmware(phydev);
	if (ret < 0)
		return ret;
    ...
}

en8811h_load_firmware() always calls request_firmware_direct() for
EN8811H_MD32_DM and EN8811H_MD32_DSP. The AN8811HB probe calls
an8811hb_load_firmware() the same way.

The commit message says:

    The need is not derived from the compatible because the knowledge that
    an ID needs host firmware lives in the PHY driver, and that driver is a
    module not yet loaded when the MAC connects, so it has to come from the
    device tree.

Isn't that a question of Linux module loading and rootfs timing, rather
than something about the hardware? The ethernet-phy-id compatible is
already in the DT and can be seen before any PHY module loads.

The EN8811H binding is also not updated for the flag.
airoha,en8811h.yaml neither requires it nor shows it in its example, and
its required list only has:

    required:
      - reg

The existing in-tree EN8811H node in mt7981b-openwrt-one.dts does not get
the flag either:

    phy15: ethernet-phy@f {
        compatible = "ethernet-phy-id03a2.a411";

Would an EN8811H node without the flag still pass dt_binding_check? If so,
it would keep the dead-port behavior whenever the driver is a module that
loads late.

Could the late-connect behavior come from the compatible instead?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260925001209.2334139-1-f%40lex.la
