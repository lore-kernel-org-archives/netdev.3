Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C264F3AFAF4
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 13:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786370047; cv=none; b=T/RD1oGcETGx4q36m42UdtfXu2LJqaWDLcRtOPPkABtuGgRo1VavEW+Fd1dbcqFqhsJpgsHT4RQOGWaa9WVCyWkx30JBfw3MTFq97Sn3Cvt3JfdTP2LpHjgs+9RB3PaW1GLAALm4bqK1SUJXVLTx17sVGPqv6H4UwXywZCdD0fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786370047; c=relaxed/simple;
	bh=EwbKzoUhneeGcWDUA8JuUVel6Fgx/Oo5AvuYrUI/NsA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cUiGuOPsCDO2a9fl1fsljJFctTqe0e58iouM1/tlmesvfQ+IlbqTLlG69GRtoiKLbqLeHkLLb5K/Ql/SR6j+SCtHDrubf8dCh7Cy+g7SsX0tdaMReRgWH4aI0LrNdIHnODQjgcrhFEQHXaOL7DLnkIo3JIinsJIe9bI25r3Pjd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ntAyXT77; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ntAyXT77"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47f7854678cso1281151f8f.1
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 06:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786370044; x=1786974844; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:subject:cc:to:from:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VgJBBQAfQwud2CBHM1vOxewj/JwZX0g9gZPthW2xd2U=;
        b=ntAyXT77FEm5O+Xt1xhfj2wmDOce/qTDhJ0YsEBue+5uQgYcGV8M0jnnDnVZaTKKBi
         6pqxFKEnE3iY7RZjnvL1bN4utmHILqE0YpfVDKhGJ2Q67p8EE7B68T+VAZEa8M9KLjie
         GWZ4z05XuGiNmsYn8j+z7AE48t1wQWV0hLo0TLIUJ0UJSOddUIsmmbVU2FZLr+3jZQCm
         URJ1J16Lc5WvWehRCiCL7cunT8o9DhOLt2GNTfAToLY5mu8uSSR/fjN67ZO8a7I5o3OJ
         WTPR+nsq+ENqgAbbKsX3YFp3aRdWPmtrVxsS9kzJxOkhZflJOIerpF4EuVjLnDO2kvhK
         A/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786370044; x=1786974844;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:subject:cc:to:from:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VgJBBQAfQwud2CBHM1vOxewj/JwZX0g9gZPthW2xd2U=;
        b=pepWqEmQeFwthsxs4eXFI826E2LLMhACV8YikRRU17TBWKk5HDgTlVA+vtvymOMYQj
         xYbPLCm/PqIL2LSHNREdC+l19j0s4Nbpx970gHMaOiRUZXUYtr3Ts31fpZKzByIDoD1O
         WLPm3y/5s/myAFuTim6AtdHCRu0p4KSYPB8JWkyfRgtYMMXMWEJra9hPpt2CeH13Qw29
         LLeJhgGROpdqinybBC3P9coSmXfucK2vaDKMP++oB0QZLpE4MkYf0Tp35qy7MG+ii/uU
         7hEtG8TJ/gVsbsIfEKL2K7rPL39LVhmT43GGJD/dpseX4K1e6/L6nxY9TBV/QLSOkLWt
         lwxQ==
X-Forwarded-Encrypted: i=1; AHgh+Rph44avSNqECU2aRGP9fUuuFRwyQpHpXkxQFHE38ycBZiTdmZtcHY/0eHdb7/mqS5otySDAY3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiNk7122aICOvoFNf/xuGa/IyQy9Icxy5jIsve/c4Lx2fdNr5V
	nxl4ghM/P9/LmOz/J6McmhVAhD3umUmRcOGJg0VQhwWOb65Sw3PYyO/2
X-Gm-Gg: AR+sD12VctgvABPJ4aa07gn0Kf541YIpGi04tBrwfjw//HxqIrdl4uZWIc9IhkEoFZg
	G7wU+aHSdc+esYVD2GfxpltNxCF6dhazBEDxngq6UlCQk8SUgtqVHytIN9diQe4VEiOqpcUZy0z
	PJ40CwpN7d5BpJ1XKk8DTTykxVv2FnH6EOlL5T0hDCukafZEKunU2PtBxjZstfUkabaW5d9faIx
	nob/u2xvKkmteldnjDTxL/GqOrDQIohX+nK4ujLpyZRu9nx7kjgbZveNh7dsg/Mhlt+AaZd9TK4
	OesxsojiWAuuBVxhf2LqUgbe8Z7NtfZnbvq8DCmQb2wK4UEjSVqlj5Xbpx/vkZUTDWkOeavRTcU
	X9MwVaAiXYDIFgMg8pk/JAroUIeIpn2JHrnjMpgYtG80dlfg/IMTPejh7necc6l6QZ/L1eg/Ujd
	U2ds+s+r2PxRoHn2i8VYi8k/HhoGDv5sLn5i3NLt6JwSc6dIqnJgw+MZbsAQ+XxOBzRX2JmrVsO
	szCvY4YimzNCbk5tCAQAySJZ4AsgNs=
X-Received: by 2002:a05:6000:46d0:b0:47f:93b6:8d08 with SMTP id ffacd0b85a97d-48130eea9f4mr19631047f8f.21.1786370043636;
        Mon, 10 Aug 2026 06:54:03 -0700 (PDT)
Received: from Ansuel-XPS. (host-87-20-3-207.retail.telecomitalia.it. [87.20.3.207])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021506desm33595891f8f.10.2026.08.10.06.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 06:54:02 -0700 (PDT)
Message-ID: <6a79d7fa.ebbd881c.2cd61f.2e0d@mx.google.com>
X-Google-Original-Message-ID: <annX9kdOCn4DotjK@Ansuel-XPS.>
Date: Mon, 10 Aug 2026 15:53:58 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: dsa: qca8k: Disable mgmt Ethernet for qca8327
References: <20260810061612.23745-1-kernel@kempniu.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260810061612.23745-1-kernel@kempniu.pl>

On Mon, Aug 10, 2026 at 08:15:53AM +0200, Michał Kępień wrote:
> While the qca8327 switch appears to support in-band mgmt Ethernet,
> prolonged use of that protocol (e.g. for polling link state) makes the
> device unstable: within minutes, ports randomly go down and no traffic
> is forwarded anymore.  The same issues do not occur when MDIO is used
> exclusively, so ensure mgmt Ethernet is not used on the qca8327.
> 
> Signed-off-by: Michał Kępień <kernel@kempniu.pl>
> ---
> I came across this while migrating an AR9344-based router with a QCA8327
> rev. 4 switch to a DSA-aware driver.  This glitch is a pain in the neck
> to troubleshoot any further as it occurs randomly, anywhere between a
> minute to an hour after the switch is set up; traffic load exerted on
> the switch does not seem to matter as the problem can be triggered on a
> virtually idle device.  Previously working links are reported as going
> down (one by one, not all at once), even though port LEDs still blink;
> no traffic is forwarded; reloading qca8k does not alleviate the problem,
> only power cycling seems to help.  Nothing like this happens when only
> MDIO is used.  However, qca8k currently only uses MDIO as a fallback.  I
> figured that simpler is better and that mgmt Ethernet should simply be
> disabled for the qca8327, but I would be happy to work on some
> configurable solution if that would be preferable.
>

This is a long standing issue and it seems to me disabling mgmt is just a
big workaround to a real problem.

Long time ago it was reported that there seems to be a problem with the
mdio master register for external and internall access and how mgmt was
actually sending mdio command... just done by the switch. Could the 2 issue
related?

One idea might be to verify that stuff gets actually written... as Andrew
said to verify if some packets doesn't get lost or just ignored.

Also as Andrew said I would still save this for the MIB part as the 2 thing
should be unrelated.
 
>  drivers/net/dsa/qca/qca8k-8xxx.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
> index 4c928983b8623..1d90a23aba6bb 100644
> --- a/drivers/net/dsa/qca/qca8k-8xxx.c
> +++ b/drivers/net/dsa/qca/qca8k-8xxx.c
> @@ -160,6 +160,11 @@ qca8k_set_page(struct qca8k_priv *priv, u16 page)
>  	return 0;
>  }
>  
> +static bool qca8k_mgmt_eth_disabled(const struct qca8k_priv *priv)
> +{
> +	return priv->switch_id == QCA8K_ID_QCA8327;
> +}
> +

Instead of this and return ENXIO I would just not install the relevant OPs
for the tagger and use the mdio path directly...

Makes the code cleaner and less CPU cycle (the target is ath79 and powerpc
stuff)

But as said above disabling the feature is the last solution after all the
verification are done.

>  static void qca8k_rw_reg_ack_handler(struct dsa_switch *ds, struct sk_buff *skb)
>  {
>  	struct qca8k_mgmt_eth_data *mgmt_eth_data;
> @@ -316,6 +321,9 @@ static int qca8k_read_eth(struct qca8k_priv *priv, u32 reg, u32 *val, int len)
>  	bool ack;
>  	int ret;
>  
> +	if (qca8k_mgmt_eth_disabled(priv))
> +		return -ENXIO;
> +
>  	skb = qca8k_alloc_mdio_header(MDIO_READ, reg, NULL,
>  				      QCA8K_ETHERNET_MDIO_PRIORITY, len);
>  	if (!skb)
> @@ -368,6 +376,9 @@ static int qca8k_write_eth(struct qca8k_priv *priv, u32 reg, u32 *val, int len)
>  	bool ack;
>  	int ret;
>  
> +	if (qca8k_mgmt_eth_disabled(priv))
> +		return -ENXIO;
> +
>  	skb = qca8k_alloc_mdio_header(MDIO_WRITE, reg, val,
>  				      QCA8K_ETHERNET_MDIO_PRIORITY, len);
>  	if (!skb)
> @@ -630,6 +641,9 @@ qca8k_phy_eth_command(struct qca8k_priv *priv, bool read, int phy,
>  	int ret, ret1;
>  	bool ack;
>  
> +	if (qca8k_mgmt_eth_disabled(priv))
> +		return -ENXIO;
> +
>  	if (regnum >= QCA8K_MDIO_MASTER_MAX_REG)
>  		return -EINVAL;
>  
> -- 
> 2.55.0
> 

-- 
	Ansuel
