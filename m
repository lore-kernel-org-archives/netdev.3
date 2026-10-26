Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793058440;
	b=LLr9NXfa4C154ZlPOudHrCFby3WaWqmXc/KAZN29KvkgRlzlx7YQDf5rfc48VnpYCEhe
	 V3yQ+OlG2KllhL5ZfS6OH3uvgJ2FLfk+VhEgwxwssTRq8Z0lL6CkkuEoI0r9DQcK/2X54
	 C38m/efh455RSRuOb//CZsyfTrEBbUFexWf3q+KKzr3nYJAI/GCrldRv7NdtwDWTOQZaF
	 PouLT0wJApVKOQhx0TzvKrvYS9REASIVd4H70qy45irucNDlyB7cCHWrzKMxIlR31Wjcj
	 kKlO+Wu7whCHYaUCrANSnMxo/JsaY1/LJmut74WAH4/raV8o4f5NEqVL13MsAmoo9dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793058440;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Xl2aFOSwlmUDuTn64oTJ4FrZmnVFJWZ+b83126Q4tQQ=;
	b=1kMnHwXhF3WstWzlk+KVgicoO/nDPzv8VkUZnwYb0tbG6Z2/hJeyDwOiQRBcWDjNJI76
	 5bGmZjVZCDZVZ5Cs/5RBbMdZ4Fq6ufZLfCeNZSqtPwGpZWuqbwWvng5oQj7USYpDsFNpG
	 SobFKnvzXUFGVQMe7RGtnUHhykRCLt7AM8YLdr9Aq7Ih76r17VC00n0JU7hy7xbs0SSki
	 aloR5jXd76Gm2Dh38FD78BGDy66c8P/75xnT7O73jZ8yft1wac63HI/kBz2zJ4iAXEdRI
	 UW9qgrRPQfX1QgsOiJJR137LRjLx5K9P2Z1+wGY2kobm1BjZdjqOs7uqxv6S9lRK1VQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QpYJ+SfB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41372606A325;
	Mon, 26 Oct 2026 23:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QpYJ+SfB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38BD21F01825;
	Mon, 26 Oct 2026 23:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793058439;
	bh=Xl2aFOSwlmUDuTn64oTJ4FrZmnVFJWZ+b83126Q4tQQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QpYJ+SfBR0pQr9xblgF+FQA9dVOtc4K/nD+5RnpmB1V73VqwtYV1YhoWVXtzuzaiY
	 UJwVGmW9vjlbrkr8i8yowpzHv8bIMZc02RN4kXX+syr1bQrBBAXXl1SWYRbjD4SqtY
	 Ka5Q10JuZ5aDXfrtosGXyPcCvDyyidkt6Z9YXSVIBf9SDYAv1r7YoBqdNKQLcWecg3
	 MGLjcpQ0WmZOE7wNOrrhYPeZqGvi8Gtp4ClDo7aZ6deYt7akRys7QYdBIMvCT1qlnL
	 n26t/u2CzwMmeJpQNOZREnnu2FKA8YGET0UzujZJn31bgzL5vuDC63RMPNTHxToLo5
	 ZfBPkfCuO2ywg==
Subject: Re: [PATCH net 3/6 RESEND] net: dsa: b53: constrain SerDes interfaces
 to initialized PCSes
From: netdev-bot+sashiko@kernel.org
To: florian.fainelli@broadcom.com
Cc: netdev@vger.kernel.org, jonas.gorski@gmail.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, linux@armlinux.org.uk, rmk+kernel@armlinux.org.uk,
 linux-kernel@vger.kernel.org
Date: Mon, 26 Oct 2026 23:47:18 +0000
Message-ID: <179305843878.3134.5626134378768180663@kernel.org>
In-Reply-To: <20261022225656.1387306-4-florian.fainelli@broadcom.com>
References: <20261022225656.1387306-4-florian.fainelli@broadcom.com>
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

- [Medium] Ports muxed to SGMII now fail phylink creation when SerDes
  discovery fails or CONFIG_B53_SERDES=n.

--

net: dsa: b53: constrain SerDes interfaces to initialized PCSes

This patch stores a supported interface bitmap on each b53 PCS that is
discovered, and uses that bitmap for capability reporting and PCS
selection. On SRAB ports whose mux selects a SerDes, it clears the
parallel interfaces inherited from the common code. It also stops
advertising 2500BASE-X.

> diff --git a/drivers/net/dsa/b53/b53_srab.c b/drivers/net/dsa/b53/b53_srab.c
> index 9818b3922a377..3fabae80dc1a8 100644
> --- a/drivers/net/dsa/b53/b53_srab.c
> +++ b/drivers/net/dsa/b53/b53_srab.c
> @@ -451,9 +451,11 @@ static void b53_srab_phylink_get_caps(struct b53_device *dev, int port,
>  
>  	switch (p->mode) {
>  	case PHY_INTERFACE_MODE_SGMII:
> +		/* The mux connects this port to a SerDes, not a parallel bus. */
> +		phy_interface_zero(config->supported_interfaces);
>  #if IS_ENABLED(CONFIG_B53_SERDES)
>  		/* If p->mode indicates SGMII mode, that essentially means we
> -		 * are using a serdes. As the serdes for the capabilities.
> +		 * are using a SerDes. Ask it for the supported interfaces.
>  		 */
>  		b53_serdes_phylink_get_caps(dev, port, config);
>  #endif

[Severity: Medium]
Could an SGMII-muxed port end up here with an empty supported_interfaces
mask, so that phylink_create() fails for it?

b53_srab_mux_init() sets p->mode before it tries discovery. If discovery
fails, the loop continues with p->mode still set to SGMII and
pcs[lane].dev still NULL:

    case MUX_CONFIG_SGMII:
        p->mode = PHY_INTERFACE_MODE_SGMII;
        ret = b53_serdes_init(dev, port);
        if (ret) {
            dev_err(...);
            continue;
        }

In that state b53_serdes_phylink_get_caps() returns early on
!dev->pcs[lane].dev, so nothing goes back into the mask.

With CONFIG_B53_SERDES=n, the b53_serdes_init() stub in b53_serdes.h
always returns -ENODEV and the refill call is compiled out. Every
SGMII-muxed port then ends up in this state.

phylink_create() then rejects the port:

    if (phy_interface_empty(config->supported_interfaces)) {
        dev_err(config->dev,
            "phylink: error: empty supported_interfaces\n");
        return ERR_PTR(-EINVAL);
    }

DSA then sets the user port up as unused. Before this patch, these ports
kept GMII/MII/REVMII from b53_phylink_get_caps() and registered normally.

Ports that never select the PCS are hit as well. In
bcm958625-meraki-alamo.dtsi, SRAB port@4 and port@5 (sw0/sw1) use a
1000 Mb/s fixed-link with no phy-mode, so DSA passes
PHY_INTERFACE_MODE_NA. b53_serdes_phylink_mac_select_pcs() returns NULL
for that mode both before and after this patch.

These two ports are the conduits for the cascaded QCA8337 switches
(ethernet = <&sgmii0> / <&sgmii1>). Wouldn't those switches lose their
upstream link too?

The commit message says:

    A failed discovery must not leave a usable serial interface
    advertised without its PCS.

It does not mention that the port then fails to register at all, or that
fixed-link/NA ports are affected. Is that the intended result?

Later patches in the series do not change b53_srab_phylink_get_caps() or
b53_srab_mux_init(), so this still applies at the end of the series.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261022225656.1387306-1-florian.fainelli%40broadcom.com
