Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793058439;
	b=VMZwRlOspeJ+GxUidD0DMXLif5oUV0LnIoaGfgn1vd+UujW3z0a4kf4rnRNMwYXMdMGb
	 +s6Ky9kNJamZwDbqJdG766j1qan52eyfPh8DIsFgcy9/qdYvCaxWywh7+F7x9PvdfGfdp
	 Ge5dKWMSK5q5CmEiLR9/cQzfZL/sa3UIQs7AsIk3lSLzYby9FOmHqw5Kbnvlhww4ymfIv
	 J6iYwqlkMf/GEgpPWi0mYj1G7aCQ2st4Fl0qoxZ9e6cBdFGZSgOPKOdq6oJNOH6X0C+z5
	 d7VfqKG8Ifrj+3V/UgAtXLkSDACFRF7zRGuPgtL3XTdvJ+rBa+uoaw0A1G2am/dZoIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793058439;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ppFx90XeEhiQ+j8jf3QERNJ5cqKd4iFeH6V9C3NnjXU=;
	b=uvCDUu+3HJkZNWT+ChgirX2X4hSpI0iWlvkmq5luiQSHUaVK1TuZephxtFLoMA6WdQSI
	 Uez4iwsrhfm3mNXlQUhWhaui/h6ocHZaw0F0AEWErszAMF97r9IxVduQm/HDSfaLDxivH
	 XGakw9cfO/vu0aHSJ05YxSILdX3qNkc0+iMH8yZh7LFtUSL/gkrh+t/QFh++hiaHq/Cgq
	 9fNKOzXkIXkiX+ak/ILssh5njYERhILW18lgHWxxts+lwVA0FMk43r0ymzhROSQK5ce4Y
	 7epPE+euaMJPAY4yIUxBVq2eIOhzdYRLZSf0coQW+1eH9Ls8gtH9RYFvqfa7VkB/U9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P5PWzIZX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04447606A31A;
	Mon, 26 Oct 2026 23:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P5PWzIZX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08D9D1F031E0;
	Mon, 26 Oct 2026 23:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793058438;
	bh=ppFx90XeEhiQ+j8jf3QERNJ5cqKd4iFeH6V9C3NnjXU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=P5PWzIZXwHWKBE5Nsx5IUlUWD5u5limIJnX4/rhB5qwKnDiCc/VQ0AWpJ6EAsRQ2G
	 Kb3UUvNYWx5ZXeQT5fQn5qE4A498SjDl8pxyS8QpykhmAFcgq8DF9aVgi8a7bPbIzR
	 Y4qR+l7+t0MS0FjHKUizgv4RRvNcN7nI8m9Lv3iwnghXK0Zs11gSTAyMS8K+QB/7J1
	 2xrjXPeX3cg5QWwUJ70p8QAgiU6ejRAsHsYuNBkny0zwNS9oCisH86x568Zv7UvxSb
	 xg6e0dG9JSdkjYvOipXEA6IiHmeG567tyA+Ao1z+OQzH+k5Z+jKEBRJ91poabEVr2y
	 10i9ns9D7QKEg==
Subject: Re: [PATCH net 2/6 RESEND] net: dsa: b53: manage SerDes power through
 the PCS callbacks
From: netdev-bot+sashiko@kernel.org
To: florian.fainelli@broadcom.com
Cc: netdev@vger.kernel.org, jonas.gorski@gmail.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, linux@armlinux.org.uk, rmk+kernel@armlinux.org.uk,
 linux-kernel@vger.kernel.org
Date: Mon, 26 Oct 2026 23:47:17 +0000
Message-ID: <179305843757.3134.4007285132700969521@kernel.org>
In-Reply-To: <20261022225656.1387306-3-florian.fainelli@broadcom.com>
References: <20261022225656.1387306-3-florian.fainelli@broadcom.com>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] Baseline decision: discard.

Pre-existing issues:
- [Medium] Baseline decision: discard (pre-existing, medium).

--

net: dsa: b53: manage SerDes power through the PCS callbacks

This patch moves SerDes power management out of the b53 mac_link_down()
and mac_link_up() handlers and into new pcs_enable() and pcs_disable()
callbacks. It removes the serdes_link_set io op. It also adds a
b53_serdes_modify() helper that does read-modify-write of SerDes
registers under reg_mutex.

> diff --git a/drivers/net/dsa/b53/b53_serdes.c b/drivers/net/dsa/b53/b53_serdes.c
> index c90894877626e..87771e3788f7f 100644
> --- a/drivers/net/dsa/b53/b53_serdes.c
> +++ b/drivers/net/dsa/b53/b53_serdes.c

[ ... ]

> @@ -202,32 +235,31 @@ static void b53_serdes_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
>  		state->pause |= MLO_PAUSE_TX;
>  }
>  
> -void b53_serdes_link_set(struct b53_device *dev, int port, unsigned int mode,
> -			 phy_interface_t interface, bool link_up)
> +static int b53_serdes_enable(struct phylink_pcs *pcs)
>  {
> -	u8 lane = b53_serdes_map_lane(dev, port);
> -	int reg;
> +	struct b53_pcs *priv = pcs_to_b53_pcs(pcs);
> +	int ret;
>  
> -	if (lane == B53_INVALID_LANE)
> -		return;
> +	ret = b53_serdes_modify(priv->dev, priv->lane,
> +				B53_SERDES_MII_REG(MII_BMCR), SERDES_MII_BLK,
> +				BMCR_PDOWN, 0);
> +	return ret < 0 ? ret : 0;
> +}

[Severity: Low]
Should b53_serdes_enable() also pass the error to b53_serdes_error(), as
b53_serdes_disable() does below?

The phylink core ignores the return value of pcs_enable() in
phylink_major_config():

drivers/net/phy/phylink.c:phylink_major_config() {
    ...
	if (pl->pcs_state == PCS_STATE_STARTING || pcs_changed)
		phylink_pcs_enable(pl->pcs);
    ...
}

If clearing BMCR_PDOWN fails, the lane stays powered down and the link
won't come up until the interface is cycled.

b53_srab_op() and b53_srab_request_grant() already hit WARN_ON() before
they return -EIO, so the failure does show up in the log. This is mostly
about keeping the enable and disable paths consistent.

>  
> -	reg = b53_serdes_read(dev, lane, B53_SERDES_MII_REG(MII_BMCR),
> -			      SERDES_MII_BLK);
> -	if (reg < 0)
> -		goto out;
> +static void b53_serdes_disable(struct phylink_pcs *pcs)
> +{
> +	struct b53_pcs *priv = pcs_to_b53_pcs(pcs);
> +	int ret;
>  
> -	if (link_up)
> -		reg &= ~BMCR_PDOWN;
> -	else
> -		reg |= BMCR_PDOWN;
> -	reg = b53_serdes_write(dev, lane, B53_SERDES_MII_REG(MII_BMCR),
> -			       SERDES_MII_BLK, reg);
> -out:
> -	b53_serdes_error(dev, lane, reg);
> +	ret = b53_serdes_modify(priv->dev, priv->lane,
> +				B53_SERDES_MII_REG(MII_BMCR), SERDES_MII_BLK,
> +				BMCR_PDOWN, BMCR_PDOWN);
> +	b53_serdes_error(priv->dev, priv->lane, ret);
>  }

[ ... ]

> diff --git a/drivers/net/dsa/b53/b53_srab.c b/drivers/net/dsa/b53/b53_srab.c
> index b9939bbd2cd51..9818b3922a377 100644
> --- a/drivers/net/dsa/b53/b53_srab.c
> +++ b/drivers/net/dsa/b53/b53_srab.c
> @@ -493,7 +493,6 @@ static const struct b53_io_ops b53_srab_ops = {
>  #if IS_ENABLED(CONFIG_B53_SERDES)
>  	.phylink_mac_select_pcs = b53_serdes_phylink_mac_select_pcs,
>  	.serdes_map_lane = b53_srab_serdes_map_lane,
> -	.serdes_link_set = b53_serdes_link_set,
>  #endif
>  };

[Severity: Medium]
This is a pre-existing issue, not one introduced by this patch. The new
SerDes power paths go through the SRAB accessors, and the timeout check
in b53_srab_request_grant() does not match its loop bound:

drivers/net/dsa/b53/b53_srab.c:b53_srab_request_grant() {
    ...
	for (i = 0; i < 20; i++) {
		ctrls = readl(regs + B53_SRAB_CTRLS);
		if (ctrls & B53_SRAB_CTRLS_RCAGNT)
			break;
		usleep_range(10, 100);
	}
	if (WARN_ON(i == 5))
		return -EIO;
    ...
}

If all 20 polls time out, i ends up as 20 and the function returns 0. The
caller then goes ahead with the SRAB access without having seen RCAGNT.

If the grant shows up on the sixth poll, i is 5. The function then WARNs
and returns -EIO even though the grant was obtained.

Was the check meant to be i == 20? It dates back to commit 967dd82ffc52
("net: dsa: b53: Add support for Broadcom RoboSwitch"). It is reachable
from this patch's code through:

b53_serdes_enable()->b53_serdes_modify()->b53_serdes_write_blk()->
    b53_srab_write16()->b53_srab_request_grant()

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261022225656.1387306-1-florian.fainelli%40broadcom.com
