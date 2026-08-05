Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788383C416B
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 17:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785951138; cv=none; b=hD+n2Q0dAM+LdJu0xJPX3G6tJ+Pvqi1PYDWhh2Xd5NHlHxBDEady31k8yZXyV0QfWwl0lc89tOZwWSv1OwoMsVzXLozZZ39vTMojbtbByS7B+9Da5/C/m+9ttunLt5XXaxdXWPp3thJr2gx4OiYvcfT5y6QXHNrByAfdl4Sgrtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785951138; c=relaxed/simple;
	bh=Y5xa6Xl3Vp0TBY5QB4nUf0nx4vI+TDodHlUbGUVI8hc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JBVFWIiKk4hZprY3+I57rWp4rFlAul3Ku5VySjBPNDv1pGYXkVvrH4LPIYj9bp1I9T+N60xohQSgNcqhI+ITN4z7s0qmFuRHDNMn3sBBCwaKNCtxC58PXwi6K/dZmzOrILLSDlvklLSgK/ml3y54w1N+rLpstS+FTrx5+fqmyF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JEZjDaZa; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cs5eZxwx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JEZjDaZa";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cs5eZxwx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785951136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MpFFANYWC8oF3BuUI/bTa1pYQgJbnIlCD1S9bFmjp4o=;
	b=JEZjDaZaRT/c45u31hxOoUiUkKokkS1+9jewnvGPNeChjGbeQAlCIjFwkewbkdj0UhOr+e
	x3CoAbUDQvio5ucg8IRtHh03ysAVkxNtohCduMg8eBy7RqQjNCQhRF/gnRFCuClCQYNQOH
	aRQyETfMBoH5B8WW07wpr7TL54N5LLQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-Q5noBexTMT-JVh399mkKoA-1; Wed, 05 Aug 2026 13:32:05 -0400
X-MC-Unique: Q5noBexTMT-JVh399mkKoA-1
X-Mimecast-MFC-AGG-ID: Q5noBexTMT-JVh399mkKoA_1785951124
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4994cf6cdb9so8418005e9.3
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 10:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785951124; x=1786555924; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MpFFANYWC8oF3BuUI/bTa1pYQgJbnIlCD1S9bFmjp4o=;
        b=cs5eZxwxhEYHoPw5gqNjqYG6No7T4eevXLVt//ffFAmOBYZiv6oBy0vzgEmqnU3rQP
         vwUQXBUDIp+y23RC/Tb36/4T+kDR4/725EcGaMqjOO3jXUQKqgVXmVubmVyydrFHZCeO
         QUGpXBxd6F2fNC1mOgDpwIoWo7bD2X/L1qSHTA4qL0oXLK8MGa279kj5ux9omldUgkrr
         B5t2SSBbPvIRG5e9sgXafL9A9l05wBi+AQe9ElMmVvRYSwzfr3YYOCnPBgvoPlQn50Fo
         fZQLeCIZUIgbleTFuOWCCRNUBcUAPNDHTv6835TW18rwOsFZ1aXOvSNPSCBUYWvpel65
         Ns1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785951124; x=1786555924;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MpFFANYWC8oF3BuUI/bTa1pYQgJbnIlCD1S9bFmjp4o=;
        b=PQKMKCNLk2U3SXBorOIykm+HBwolrptn5Qtzwq8NdMHctayLwwmDZtUXCF7vYF/scK
         WxKbpmDP1DRjz6xTyF6Rp9bJ2jSiJn9goVB8f1oQFu49x1C3DVL8UloSy5LIxsLfJ+rY
         mB0QLwKVBKPhyQz+8Siw8HhnRDeONHyflRlRSDOKEiCzmvTjrdok9Winawu35bZEoC8R
         auUkWkgoJd/5CKTvxQYtSty1tBW0c+9px4Fso9dZkMXg8HGbYxd9hh31onBRVNmIcPMu
         oWG8gXSb1C7JvbMClNkJDAP7AAXlYRrYGfvponMd9uXaFsMgePJhyHszVuCr7WNsfTMZ
         JVOQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq+sdaSaryWDJvpudmGTl5/PzYOB+0FwCCUvGwwKUSCjF0L1+qxcaH/ldgGs6e7+yyvLbz3Gtw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmvnQRJVKS6cmHQrEdKFs/IKUubSr1KsBSAHRDFGSEptGKIsoB
	vQ5EF643ZMAkWZX6fFAeYZ7AqiaOWbTHLPcqByTUOXm2l5PPfA/1DXpwWB3Pwu7Oq3GiBdXIR8h
	kEKbQEHbXsO7Xnr6n7p+eGXQRMMG0y+JzfBkcvpY9XCxYvHSw6CcxIds64Q==
X-Gm-Gg: AR+sD12Do2dqYy4JngzhrLME0OEweWGqBAJQmfXAy7ScXImRXKVSiH1BcivGWzzkK3w
	LV7kbOVyLtmfTAGxB2CzMQp76yrRr5M3DOCA7Nacq7mFJbL0Y/ReFy06WReUTbV+PBl7MdGpjNx
	fgVJdT35j7wJGkepCA5Nq7cTay5YGQaTdCFnIVZoDfeJqloU8PqTJHcZ/A4lIyyKPkD8ttRSC2I
	vSfVC7WE6ZOldyfSIHT3cPEs7nwQTDurruSg5+6SCLk+Bg2BWzzf0zbrvqm2GDFkKxftHoUIs12
	lhsZdrKMpraTQUGFF5DyIv4dHhqEfzvoPkvOJgie2Z/L3EtlVLHZ3lphWmrHHVkrcUot9hbtbMs
	=
X-Received: by 2002:a05:600c:22ca:b0:498:ee7:e40a with SMTP id 5b1f17b1804b1-4994e7d2c19mr94429745e9.16.1785951123746;
        Wed, 05 Aug 2026 10:32:03 -0700 (PDT)
X-Received: by 2002:a05:600c:22ca:b0:498:ee7:e40a with SMTP id 5b1f17b1804b1-4994e7d2c19mr94428975e9.16.1785951123249;
        Wed, 05 Aug 2026 10:32:03 -0700 (PDT)
Received: from localhost ([2a01:e11:1007:ea0:8374:5c74:dd98:a7b2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994e980559sm66252115e9.2.2026.08.05.10.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 10:32:02 -0700 (PDT)
Date: Wed, 5 Aug 2026 19:32:01 +0200
From: Davide Caratti <dcaratti@redhat.com>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Daniel Thompson <daniel@riscstar.com>,
	Alex Elder <elder@riscstar.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next] net: stmmac: add tc-ets qdisc offload
Message-ID: <anNzkcCXvOehhNcZ@dcaratti.users.ipa.redhat.com>
References: <20260804-stmmac-ets-offload-v1-1-f3a09169d22b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804-stmmac-ets-offload-v1-1-f3a09169d22b@oss.qualcomm.com>

On Tue, Aug 04, 2026 at 08:17:35PM +0200, Lorenzo Bianconi wrote:

[...]
 
> When all bands are strict priority, the MTL scheduler is programmed with
> SP scheduling; otherwise the requested weights are applied to the TX
> queues and the scheduler is switched to DWRR. The TC_ETS_STATS command
> is accepted and handled.
> 
> Export stmmac_set_tx_queue_weight() so the ETS path can reprogram queue
> weights, and wire TC_SETUP_QDISC_ETS into stmmac_setup_tc().
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

hello Lorenzo, thanks for your patch!

> ---
> +static int tc_setup_ets_sched(struct stmmac_priv *priv,
> +			      struct tc_ets_qopt_offload *qopt)
> +{
> +	struct tc_ets_qopt_offload_replace_params *p = &qopt->replace_params;
> +	struct plat_stmmacenet_data *pdata = priv->plat;
> +	int i, nstrict = 0;
> +
> +	if (p->bands > priv->plat->tx_queues_to_use)
> +		return -EOPNOTSUPP;
> +
> +	for (i = 0; i < p->bands; i++) {
> +		if (!p->quanta[i])
> +			nstrict++;
> +	}
> +
> +	if (p->bands && nstrict)
> +		return -EOPNOTSUPP;
> +
> +	if (nstrict) {
> +		tc_setup_sp_sched(priv);

From what I understood, this will fail configuring the strict priority case (the only one
possible according to the commit message, where all bands have quanta equal to 0). Maybe
the if() statement should be done like:

 if (nstrict && nstrict != p->bands)
	return -EOPNOTSUPP;

WDYT? thank you in advance!

-- 
davide

