Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793058442;
	b=Pob1PsgNiQi1KqGH40a0DW4TmXtKY+CxNgAgYEDuNIr5HkI+cGnYFcr6/GauwnRqKHWP
	 IDp03EtdeZgM6Qk+OA5LwxiFJBjonVkDXX//Qc1YSg6LJRYJUFKZhXmGkT+J/xmGWuWxv
	 7vh72tT4elxw8lVnJ8IuKx1LPN5qoylpuxvlulgWRxdK20japYEPK5/gUhtHVOjsnRq4d
	 l6n59WKOYNVD1DX2ZlvFtBS8BdeEZFev6dNrD0vvsF+gKGWF87q5t8w2Vka2m0PaaTf+K
	 EJqS1X4RVCumRiE2nLOSoJf/N4RuNaoNuu4L5PgYWTFn3jSEsugVW4bgOLVfKHuKwnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793058442;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=B/oSu2EKH6i22Xlv4haLMuDha3LfKPHn3W2qbY11TH4=;
	b=s5aNAN/DrwYgK+w7oW1f9DYYmqPC6vxCcRAWsp/MpqndEUWBVA1YootxPHcaEn4kPf9s
	 0F6qQfGo4fkZTPEfRDmUyOSzdL4i4aIPxQHb5iHoiSto2qx7UFgh8a9EbRtVgnL6Znipp
	 5qAdEbU43QIBI2CvbOcXqGhTPdJGwP5ERYgQp+ks8WRDsy3OZAMXi2ylwn2jjU/ARfjF2
	 8Cl4Dphozq9i9u7cRe4H1nobne5OJxh6qQlRkRqUOrNHm3tWeJNwE2xqmsMPiEZzYuAxj
	 +p7Lxv1OwrkZQUE4H4jhneQJTfFjOcreXOc1HVVFvsbyb9/J802SXSGt1JplZjMYRaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QTFRBCwm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F56B606A332;
	Mon, 26 Oct 2026 23:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QTFRBCwm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D5581F01829;
	Mon, 26 Oct 2026 23:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793058441;
	bh=B/oSu2EKH6i22Xlv4haLMuDha3LfKPHn3W2qbY11TH4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QTFRBCwmPyNe3M9qvwqtUX+2Puu363qqH+aEMf6UbuNrt8G7tNXgaqRdSsNVQgh/t
	 uQnaX0DFpEebIedF5FOs8hIlo40huUj0nvtlkae6FsXU5QEoOCwM0xNuvq/dU0c2Cl
	 oPuOzMnPmOd78Z/jmJfNW0r+kYT+pxdeH+qzQ9Z1nZm/d48Y7nk/KJYFWBxgeASOfZ
	 qLC31gSdSywLjQb85YSh5a2DTLo2wMMs/dkjx9UJ4WgiE2u2I1ZnPqJRj1KMzn4Ord
	 EtXDZ0HVouvFIVqzeVsEF9V/YxLjKnO4RyBUT6Kb8aHnYKELUDLTlqFN0CvvKw0WYc
	 ywzQ7PRWzE7Mw==
Subject: Re: [PATCH net 4/6 RESEND] net: dsa: b53: configure PCS negotiation
 and forced link parameters
From: netdev-bot+sashiko@kernel.org
To: florian.fainelli@broadcom.com
Cc: netdev@vger.kernel.org, jonas.gorski@gmail.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, linux@armlinux.org.uk, rmk+kernel@armlinux.org.uk,
 linux-kernel@vger.kernel.org
Date: Mon, 26 Oct 2026 23:47:20 +0000
Message-ID: <179305844003.3134.7429976502843350858@kernel.org>
In-Reply-To: <20261022225656.1387306-5-florian.fainelli@broadcom.com>
References: <20261022225656.1387306-5-florian.fainelli@broadcom.com>
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

- [Low] b53_serdes_config() ignores permit_pause_to_mac.

--

net: dsa: b53: configure PCS negotiation and forced link parameters

This commit makes b53_serdes_config() program the advertisement, the BMCR
autonegotiation enable, the protocol selection and SGMII MAC mode based on
phylink's negotiation mode. It adds pcs_inband_caps(). It also adds a
pcs_link_up() handler that forces speed and duplex when in-band negotiation
is disabled.

> diff --git a/drivers/net/dsa/b53/b53_serdes.c b/drivers/net/dsa/b53/b53_serdes.c
> index d521050d7c8f7..fc20e211e67e1 100644
> --- a/drivers/net/dsa/b53/b53_serdes.c
> +++ b/drivers/net/dsa/b53/b53_serdes.c

[ ... ]

>  static int b53_serdes_config(struct phylink_pcs *pcs, unsigned int neg_mode,
>  			     phy_interface_t interface,
>  			     const unsigned long *advertising,
>  			     bool permit_pause_to_mac)
>  {

[ ... ]

> +	bmcr = neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED ? BMCR_ANENABLE : 0;
> +	/* phylink requests Clause 37 restarts separately, but not SGMII. */
> +	if (bmcr && changed && interface == PHY_INTERFACE_MODE_SGMII)
> +		bmcr |= BMCR_ANRESTART;
> +	ret = b53_serdes_modify(dev, lane, B53_SERDES_MII_REG(MII_BMCR),
> +				SERDES_MII_BLK,
> +				BMCR_ANENABLE | BMCR_ISOLATE | BMCR_ANRESTART, bmcr);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* The MAC applies phylink's resolved pause policy in mac_link_up(). */

[Severity: Low]
Is this comment accurate at this point in the series?

b53_serdes_config() ignores permit_pause_to_mac and relies on this comment
to justify that. However, b53_phylink_mac_link_up() in b53_common.c has no
MLO_AN_INBAND branch. Its MLO_AN_PHY branch only programs pause on 63xx
RGMII ports:

drivers/net/dsa/b53/b53_common.c:b53_phylink_mac_link_up() {
    ...
	if (mode == MLO_AN_PHY) {
		/* Re-negotiate EEE if it was enabled already */
		p->eee_enabled = b53_eee_init(ds, port, phydev);

		if (is63xx(dev) && in_range(port, B53_63XX_RGMII0, 4)) {
			b53_force_port_config(dev, port, speed, duplex,
					      tx_pause, rx_pause);
			b53_force_link(dev, port, true);
		}

		return;
	}
    ...
}

As a result, SGMII and 1000BASE-X SerDes ports in in-band or PHY mode never
get phylink's resolved tx_pause/rx_pause applied to the MAC. This is not a
change in behavior, since pause was not applied before this patch either.

A later patch in this series, "net: dsa: b53: apply resolved link settings
to serial port MACs", adds b53_phylink_mac_needs_override(). That helper
covers SGMII and 1000BASE-X in every mode and calls b53_force_port_config()
with tx_pause and rx_pause, which makes the comment correct.

Could the comment be added in that later patch, or could this commit
message note that the MAC side is handled later in the series?

> +	return changed | ret;
>  }

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261022225656.1387306-1-florian.fainelli%40broadcom.com
