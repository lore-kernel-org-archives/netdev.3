Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4150F1DF748;
	Thu,  8 Oct 2026 00:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791418953; cv=none; b=uWDEm2vTx/HXTE1ZEwlqIzjOLoerKDWM6UYbANhe455u8n3Jy1EZxFiAiArPHjBU+Nv/glft8XGd9b1rkuHbVKV+99drmFqWDxnFK8vXuj40zBb/hAqpxNiJ/RpasD+5HqyWYkogr77puigJYXCLTlJd5xSt/zKGm1KhwwVp38Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791418953; c=relaxed/simple;
	bh=/z6FyeObSyox00fvFAVa/G0dfkhRFZtmrIoFAREHD78=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sC5rrmNua8wzcpIBtmxgufLSc7s0DQHtbI2/z6IrN4jt0u3SGG3YxIhIC1aBjLx5Lvic+lxC6zBiMriz3GHai0fzZltpwsI9CPNkf9x7v8EAct84Ann2xqktnHcos8g25U5om9FuWhr6eDaMauzYZur3IR8oprrNGcczRtHtvYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WKocWaFI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WKocWaFI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 754781F000FF;
	Thu,  8 Oct 2026 00:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791418951;
	bh=1PsUH/ABqcyvYmj6q4VB1BamtgWi2MZnSafY+eqOoWU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WKocWaFItHceD2ATKPCK6L9xuFQlA/kc8soJN8CjGr9lehMTuYvUyTugbgsk/oebe
	 ZLP4yaLTHgmCt7ySAWNAG8Y34/4OCAnsEC6PEOKd7efBRoVpzASDUexYAtvSpoNFJu
	 1RB3CGJYRu3DUT1q4qagwMEg6zjMJfLUzncEAgUBAIjCOyq5fnTT8jmvHPGBizftCc
	 CgJsa5hilxkTuVrBHeKOklhtZsBNEuTMQesdkGXnBP4mDtZBZmYpCcBCbYNCZFX6Qs
	 Ss/bv2vN3GFfxmhMvobZ/MSg+NTpvU9mWd/5bE0TG0I0qLJQo3muEIC4bN3L7zaE3a
	 VlK3m0NTtkEmA==
Date: Wed, 7 Oct 2026 17:22:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: marex@nabladev.com, netdev@vger.kernel.org, davem@davemloft.net,
 andrew+netdev@lunn.ch, xiaoning.wang@nxp.com, claudiu.manoil@nxp.com,
 edumazet@google.com, pabeni@redhat.com, vladimir.oltean@nxp.com,
 wei.fang@nxp.com, imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [net-next,PATCH] enetc: Set eMDIO MDC rate to 2.5 MHz only on
 i.MX95
Message-ID: <20261007172230.53347039@kernel.org>
In-Reply-To: <179121421089.434549.4883192954268711704@kernel.org>
References: <20261001223947.60189-1-marex@nabladev.com>
	<179121421089.434549.4883192954268711704@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 05 Oct 2026 15:30:10 +0000 netdev-bot+sashiko@kernel.org wrote:
> > -#define ENETC_EMDIO_CFG \
> > +#define ENETC_EMDIO_CFG(mdc_div) \
> >  	(MDIO_CFG_HOLD(2) | \
> > -	 MDIO_CFG_CLKDIV(66) | \
> > +	 MDIO_CFG_CLKDIV(mdc_div) | \
> >  	 MDIO_CFG_NEG)  
> 
> [Severity: High]
> What divider do the other users of these accessors get?
> 
> The exported enetc_mdio_read_c22(), enetc_mdio_write_c22(),
> enetc_mdio_read_c45() and enetc_mdio_write_c45() are shared with several
> bus constructors. Only enetc_pci_mdio_probe() sets mdc_div.
> 
> These constructors install the same accessors but set only hw and
> mdio_base:
> 
>   enetc_mdio_probe() in enetc_pf_common.c (PF external MDIO, LS1028A
>   and ENETC4)
>   enetc_imdio_create() in enetc_pf_common.c (internal Lynx PCS MDIO)
>   netc_port_create_emdio_bus() in drivers/net/dsa/netc/netc_main.c
>   vsc9959_mdio_bus_alloc() in drivers/net/dsa/ocelot/felix_vsc9959.c
> 
> For example:
> 
> enetc_pf_common.c:enetc_mdio_probe() {
>     ...
>     bus = devm_mdiobus_alloc_size(dev, sizeof(*mdio_priv));
>     ...
>     mdio_priv->hw = &pf->si->hw;
>     if (is_enetc_rev1(pf->si))
>         mdio_priv->mdio_base = ENETC_EMDIO_BASE;
>     else
>         mdio_priv->mdio_base = ENETC4_EMDIO_BASE;
>     ...
> }
> 
> mdiobus_alloc_size() allocates the priv area with kzalloc(), so mdc_div
> stays 0. MDIO_CFG_CLKDIV(x) is ((((x) >> 1) & 0xff) << 8).
> 
> As a result, every C22/C45 transaction on these buses would write a zero
> clock divider into ENETC_MDIO_CFG. Before 587acb86d646 the value was 258,
> and after it the value was 66.

Looks legit.
-- 
pw-bot: cr
