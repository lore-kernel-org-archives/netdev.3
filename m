Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C3F30C37C
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 18:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785952968; cv=none; b=uqEz2AZXI42DGiA+HHIf6pxhIrpFE5aE9wxK+atobhsqnTpKq6fNaVx6WUHtJOp2jsTLr6WzaIBg1DVCLJTcoYND5OS/mk7KRR0EYiZABuG9YYiKD2LAJSA697REszD3hK/daIWcj948RNESXOySJuEqhKZGFnIaXLcOdYkxhJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785952968; c=relaxed/simple;
	bh=CfOz8hvaovr9pnh/tIEhdCV3DNZOu4TSR7PEerhlrYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uQq5tv7muyatfZbHNz9nSIuQZSIJ8zidTVOJN+xUzD9cxoUTHbRtc6n3NkzOaI3YSnJJmnhLxtntcIwXCaDJF2e9HLmZ/mh7lgRYBctLNWo8i86xjORIAe3W3+7foyqeXjNxB70Hp4ziIT14SvYaBOA1wIMkzl3mqZ1cWDzDLGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gP7TTxLL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kTWhI9xy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gP7TTxLL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kTWhI9xy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785952966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/g0aAQ3sTV3pEk/c08ymRkyu+vrncQM0ftrLofpZAv8=;
	b=gP7TTxLL/eqKLEGsRj4fs7t+oEVs0mA8W8FZmcagCbIc2hahkUoHi0vqav/HbPo+wOB49k
	YQQWLqj8yau92tvkjyu3x+lWjKUvmIbO9/XMSTmVszqKcY4SvHtD8/y8JU1tbt60+jxy3E
	fWT/D5I1Ta0P4Yhi86K/z+CdvMjDHVc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-xKhcngTNO56oFa3DIUxdgA-1; Wed, 05 Aug 2026 14:02:27 -0400
X-MC-Unique: xKhcngTNO56oFa3DIUxdgA-1
X-Mimecast-MFC-AGG-ID: xKhcngTNO56oFa3DIUxdgA_1785952947
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4954c2d4081so9846805e9.2
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 11:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785952946; x=1786557746; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/g0aAQ3sTV3pEk/c08ymRkyu+vrncQM0ftrLofpZAv8=;
        b=kTWhI9xyPf/YZgRcbqt0KwrlotWqGy7y9ENg/kpBOdB54pv9dBL+0VZVoUQEjeehm8
         j4HzRgjoYBuvLIVznr27lEewpaXpo9I3arjnY0jrt+hR8xSb0GblB1adjC9XH0jJF9UR
         CqZcgkcrK/BiHqbkufrqPK6Fr8VpOmb+TN0PKCPJvQywR1ovpi9EzKjAh+3ZGYbjlFcp
         RDTAJJTthudPjVVJ4aIrEnx52paDXg5r3TfPPhjd8F54qVq2VujEhSv754peUj/Q5tFf
         LkqL+grD5QKKDvpw1IBnYIk4YdALo6rx1P/tcQPzGmKb1i+KJDl/sBhjXN9/ZHGxX5IT
         sTLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785952946; x=1786557746;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/g0aAQ3sTV3pEk/c08ymRkyu+vrncQM0ftrLofpZAv8=;
        b=WMrMJxzuSoa36dZc2QCUmprTWMBNxj/s8jS0E/GhlztI6k+Si2LLtNiztQp0iBp3Mi
         EpqmVr2Z6QlSh1t6S7CyNkh3RUnWDZs+BZdB5jNGyKYyX5Iz1rgmjhw2soLtGBOWxYyJ
         2vg8Y060S1aZfFdywPcJoeLG88/kyW/CRfdT/4w3/GSr+XYg0UMP7ptU9aO4grNL41Yi
         G7KHR+6MsQL/EcjmXMskG+YVlVT1fe2ALq2jAJRtCnYofWlCp+PEwj8mgA+dUoZoTe6v
         OB5hH1E/rprYJd6Fh4B0/qJClFF95df4qH/GVvYEFrNO7cG1caw10l299S7HhAJcxQ3O
         N/mw==
X-Forwarded-Encrypted: i=1; AHgh+RoSM4j90aNAZCwI6yD/8oIKS3dm0sqfPQ+pZChi41X+hjwPeR64NluUB1jAa5nn0OHcH09Nut4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRq8ixeJYGbUJCqNuTyaIZLIEDCHLCQENHscPoZ58+OqslZhAs
	SvmAdCAhA/JZFRZ4A6LSENXGwfjhZUM8iuaQDlxLe/rEykDCFUNlxx5H8J/LceQ1U30xNDaNVHB
	0g5F1w4/EQtZysIH9ynt4deJMrpKYR92OlLhtIfnfqW+tGLL3AoUOgefacw==
X-Gm-Gg: AR+sD10qB94LZ8M7QbpeCmt3cFVt5o0KcmMF7Qm9vukSTq41Dojl5GCLxQIPG1rWRF7
	kd4bL4ohT4G4ogRDCZVPRPz/IA/IBcmLnefFiPyUeKl+mdD831S9MopvJKzSxpgS243MmJDa6Yd
	5wyyOXo9Bs7vOajo5+gjka+htL98P5sZAttdaXLQTBwe7t7qhVVxp//hZQ6AQ13qhRKStRnX9ia
	MU/SeNmUwNVnLTMOxtq8vAgUyFLbmVyh//RV5yuTkfeLAoQfntPZ5EwPtFuW8Vvd4hugq+sgb2T
	3FsChUxYxCtSHgHPQ+wn/EPiWKFp7FILq0SZuGhbM6zxSw5v0g/6+IrFAklDh9QWKfv1IDGcByc
	=
X-Received: by 2002:a05:600d:8492:b0:495:69eb:27fe with SMTP id 5b1f17b1804b1-4994e7bb193mr87767755e9.11.1785952946357;
        Wed, 05 Aug 2026 11:02:26 -0700 (PDT)
X-Received: by 2002:a05:600d:8492:b0:495:69eb:27fe with SMTP id 5b1f17b1804b1-4994e7bb193mr87766805e9.11.1785952945804;
        Wed, 05 Aug 2026 11:02:25 -0700 (PDT)
Received: from localhost ([2a01:e11:1007:ea0:8374:5c74:dd98:a7b2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49949fd4bbcsm199485675e9.7.2026.08.05.11.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 11:02:25 -0700 (PDT)
Date: Wed, 5 Aug 2026 20:02:24 +0200
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
Message-ID: <anN6sHZt47dRZeaE@dcaratti.users.ipa.redhat.com>
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
> SP scheduling; 

... and I replied too early _ sorry for the noise _ there is another small thing
w.r.t. SP scheduling:

> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> @@ -1210,6 +1210,73 @@ static int tc_setup_etf(struct stmmac_priv *priv,
>  	return 0;
>  }
>  
> +static int tc_setup_sp_sched(struct stmmac_priv *priv)
> +{
> +	struct plat_stmmacenet_data *pdata = priv->plat;
> +	int i;
> +
> +	for (i = 0; i < pdata->tx_queues_to_use; i++)
> +		pdata->tx_queues_cfg[i].weight = 0;
> +	stmmac_set_tx_queue_weight(priv);
> +
> +	pdata->tx_sched_algorithm = MTL_TX_ALGORITHM_SP;
> +	stmmac_prog_mtl_tx_algorithms(priv, priv->hw,
> +				      pdata->tx_sched_algorithm);
> +
> +	return 0;
> +}

The above function configures the stmmac SP queues to a well-known state where all
queues are SP. However,

[...]

> +
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

This is not necessarily what the user wants when setting up the ETS qdisc.
The driver should parse 'priomap' (like in [1] or [2]) so that only 'nstrict'
queues are involved, and selected based on the packet priority. Otherwise, the
offloaded ETS is going to behave very differently from its full-software
implementation _ which is something we probably want to avoid.

[1] https://elixir.bootlin.com/linux/v7.1.5/source/drivers/net/ethernet/microchip/lan966x/lan966x_ets.c#L36
[2] https://elixir.bootlin.com/linux/v7.1.5/source/drivers/net/ethernet/airoha/airoha_eth.c#L2281
	
WDYT? Any feedback appreciated!

-- 
davide

