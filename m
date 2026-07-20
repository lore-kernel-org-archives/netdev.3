Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB34B42E014
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 13:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784555340; cv=none; b=efTX9uUstzbaTLQS/TjqwRPnxDLqE6onMJ8CxwxJ4WcHt3YyU7v4MiCz+ykFPI4RXbg9+01MVprUdsZFyaUl8NpmRUhl8uKF2OYZu2wi6hp3hruGHEcJo/FCzI/EvLvu0TjLSHfJS69PpxaNGYS3ugsOTeJeHJmsmq8LMPf3ppU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784555340; c=relaxed/simple;
	bh=sHKsOvktHornLe+ZeU8u/20dX6bNatlr37qX8toUr58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T6ucw/RkNpJZTIkR3+fBV9T7mN7DJuF3zn7quSO8lyg+6Is4Wi5+UV/lfAIqzcuztMrEOsIQzPu02W7gIHfMwcMcAo+8HCO249y8E5Ftm6LBcQP3y4/e1jkcAsAdqwfQph1WbTYybkZkGa/3//vo5DnJRa9CywEZxayNIcUeGqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=xC6+8zLl; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="xC6+8zLl"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-848882fdb18so7329034b3a.0
        for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 06:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1784555334; x=1785160134; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=exgSZUy4mQ+gBayEGCoSCzUgfoiRVrcGM1wITQ8aelo=;
        b=xC6+8zLl7S7krs4wKiFhDBEIIGvkvZsRjZ072BSOldbfflGkE2NGRVx5dlPl52to+n
         ouLVNs1J945DC/anYL1rhXOhdP5rPzPljJdEF4H7LYEhOqFBNsr/lwNJ6CnXfNNcCobd
         2sGzX7XIoLXNuw4rmmCqO2CFCqb6SqYgreIo1/4KSrxDWy5tHINhtSKcgdUn6c6s0CNy
         bC8JQHUsjFOHTX+kakFeAGDbr1gukkybITiyFXmML15h2eMBIkzLjoeZGh0JoYrtA4iy
         0FuXRJpS1hsJ0kHWM24Tz8xJPtEgmeQ0Ej1I6X8Om1qYXBRHL2ZuEEQ0S+YFP+iTreWj
         aaOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784555334; x=1785160134;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=exgSZUy4mQ+gBayEGCoSCzUgfoiRVrcGM1wITQ8aelo=;
        b=pzvUsqggYgArrCNObemck9PZl44NM7Y2iVdMiXDLK72WnHaiU0bCpo9Se03YYjxVEl
         8UVLFlOH0JmCwPlwJqXp5SpW1HbP52GOafymBpSmhb1CVakv2AxK6gn5zC42OQPDUM+3
         FuBdXe2gU5/6OA/jwFd6279KwxAFTzpi647G75Ii9jV7E5z2piJHngxpliFOykYm3Tim
         uU81F+joDyVEtdg4LNGb4TbO/CASVoar7cfzKWoC9uhcbOdI37avWJ9FB8IC21o2xGhg
         ylMMM/b95zPnjbe0L8U/PYd9AbC5116eOUjgqa9yy1XpuNpYuf8QSYLIJXRO7cdvGNmB
         Pm6A==
X-Forwarded-Encrypted: i=1; AHgh+RoDGr7C+tiGhVXYpH0bEYPua6bBt4dP/Fo/Z/ArCcNCyfbqujJSjRQcyh+kLt7JZDq9zQLKBDM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkk05DprFSCUe3twrFwTIYYKGOTqH26Srg12/TSJKVUe7frtEJ
	UeNLiR2TBGtGE7gMS7PG/QecXIzqYWojXuC2Fwx0IlPGyku+3IStbBzfoFzqm0k9mRk=
X-Gm-Gg: AfdE7clIptIRqsKCt47o99XXx62P+l9eQUmlKwyWUvNededfDCSunvG0QOHmvzSAtBd
	Gd0Fd8gIwys/ShuxX4h9CO2MLptGjYxet+moP6lJR0imbebhwK1qgcqLh4ymSXZ3j1N8JCYZWmj
	MHTVc+WXA8YvItvujnQo1M6PFqjTwt0/WihaYD/Yg6gPWjP0BESQ3d50k87aChkpRBbv6SO+rE5
	iN4TL8nQWdPhMJS8K2lcOeYD04ljY+9uZ4h4UByuiImWu7oJTuDjLrVXsF8Ow8cRfWsgNS0Qk9A
	qvhkwOmNpug2ZRkYxDhVBuidFToDgjod5p6ODaGVHqEwCNrREEkKZ5HEvdyDo2W8ClI1x6GT6zm
	MwPlqQVqBSWJJ73GexcXiFRXmxLF1UdVl4cdx7WokIBpK3fguhuiGRGE=
X-Received: by 2002:a05:6a00:998:b0:845:eb73:411c with SMTP id d2e1a72fcca58-84c2946f027mr14586475b3a.45.1784555334640;
        Mon, 20 Jul 2026 06:48:54 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2adc3466sm5844378b3a.15.2026.07.20.06.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 06:48:53 -0700 (PDT)
Date: Mon, 20 Jul 2026 06:48:53 -0700
From: Joe Damato <joe@dama.to>
To: wei.fang@oss.nxp.com
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
	wei.fang@nxp.com, chleroy@kernel.org, maxime.chevallier@bootlin.com,
	imx@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RESEND v4 net-next 14/14] net: enetc: use kzalloc_flex()
 for enetc_psfp_gate allocation
Message-ID: <al4nRS6hB8siUx3f@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>, wei.fang@oss.nxp.com,
	claudiu.manoil@nxp.com, vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux@armlinux.org.uk, wei.fang@nxp.com, chleroy@kernel.org,
	maxime.chevallier@bootlin.com, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
References: <20260720014317.1059359-1-wei.fang@oss.nxp.com>
 <20260720014317.1059359-15-wei.fang@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720014317.1059359-15-wei.fang@oss.nxp.com>

On Mon, Jul 20, 2026 at 09:43:16AM +0800, wei.fang@oss.nxp.com wrote:
> From: Wei Fang <wei.fang@nxp.com>
> 
> Replace the open-coded struct_size() + kzalloc() pattern with the
> kzalloc_flex() helper when allocating struct enetc_psfp_gate. This
> removes the intermediate entries_size local variable and makes the
> allocation site more concise.
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  drivers/net/ethernet/freescale/enetc/enetc_qos.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_qos.c b/drivers/net/ethernet/freescale/enetc/enetc_qos.c
> index 7b17bca24f26..2aa0fcaafcd2 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_qos.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_qos.c
> @@ -1135,7 +1135,6 @@ static int enetc_psfp_parse_clsflower(struct enetc_ndev_priv *priv,
>  	struct flow_action_entry *entry;
>  	struct action_gate_entry *e;
>  	u8 sfi_overwrite = 0;
> -	int entries_size;
>  	int i, err;
>  
>  	if (f->common.chain_index >= priv->psfp_cap.max_streamid) {
> @@ -1242,8 +1241,7 @@ static int enetc_psfp_parse_clsflower(struct enetc_ndev_priv *priv,
>  		goto free_filter;
>  	}
>  
> -	entries_size = struct_size(sgi, entries, entryg->gate.num_entries);
> -	sgi = kzalloc(entries_size, GFP_KERNEL);
> +	sgi = kzalloc_flex(*sgi, entries, entryg->gate.num_entries);
>  	if (!sgi) {
>  		err = -ENOMEM;
>  		goto free_filter;

Reviewed-by: Joe Damato <joe@dama.to>
