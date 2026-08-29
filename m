Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D176238159
	for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 15:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788016528; cv=none; b=TTWwd323g9blrOk16WfTnJzpKNaMRw9K5OmRRhcpmwVe2bAqNmvFcjeHtnIN0DdNTXGRFvG24/tf9ECLKNegCfbXpDgWUxqhFwa7m3hpuDZEt+Z1HxAq2XRtdCZpi4dKPgfiaj1XA/HJxPZiJdOH3a0caa2xyjjBb3Apl9p/bMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788016528; c=relaxed/simple;
	bh=2g1jcR6uSj/fLbQ1ZfTuZpbVq4hnSBK93DtZe1wTTjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KFlLxxFmd3fefrcnNLG4UhmpS6zzxJgaBGBbPGmHxxBsnImxRfw1zgTB0u+lMCeHLi5KJeq+stfOrDfCz+qfViJnBlHXx4kxQgVTqJpT5cD4spEsBTutV0pFEFjBOLA0wktLRsOFe3NEfi3jLw+KC7KxPBEplSuTLJVaa9o7cak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=b+kY+nOf; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="b+kY+nOf"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-39682983a0fso2455700a91.3
        for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 08:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1788016526; x=1788621326; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tTPBv+P5dDJ4eNQ72046GHeSjyxFhgiVslksovlmkwc=;
        b=b+kY+nOfElOO/fWTPDDuN7H+JailJNLDawMA5VRAlY6rFZpJOWLLpAY0+0eq0rAacm
         ASf3fEx/sBnde/+uI9sS+xS/PVwqlWBRzb/lY5jxZx4yyvGWu++f1HM7OYq9Dd7cbxHV
         Rg5yEZfK9VkRqwjktqWvXgJ1qaH8ixHvf+8K6kN7bCY60ck8UQWLUxRSy9ierlSd8aiU
         ltrmTmzSqf6gXtzPwGBTfEAQlwdJ5Fi7+WS8mM+WvRcIYWt98FbXhU5viD/SJTnARLMo
         AtmUbbJPKGrtfn+KmmRrIu0Zb7QVRzvvoKOtq1K+zQMj8piPqIvcckSnbCaHgOeoci4O
         WTeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788016526; x=1788621326;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tTPBv+P5dDJ4eNQ72046GHeSjyxFhgiVslksovlmkwc=;
        b=pUqpZDveWnKUqZhoMvFYtfEk/lTNIdQRW9FjHnR2F9MCXxV5niDuBLoL2jJ/a41i0U
         Eyk4IToF7vdhSkihnBQTdNi7OmVELFBkj03QzFBsohVqMD3hTKeLEodYufWEQoWBpz/T
         3y6N0DsaV59XmAh3vMK5mbnPV2KiAnnYxGRvgZRjjcCAaQSo6jf/5reeittGXmNQx5sT
         1JIOlFoaRLwUDKbkai2K30Ft1a4DAoy/Y/51WMp7JpxNqPbjVu9vJyngCj75sR7OkrWO
         alVPIKKY8Chl6gfqPgLYDgmXGx5ofbyTJ8amjbrR48VGgJiOinwKVBE6KgTvu6M+5253
         61Ew==
X-Gm-Message-State: AFuF++nk+C9qI8+QmbTALZu7G67qZzt8QDL9WJA0udpFmrUFkteAT+rm
	snf+tRaEXlusEjW+WFeJgGUiQC1PIHtn9ym8TvSSyuj3geBBs1wn83O9HErPdnRubzCjsSXoXH5
	TODNg
X-Gm-Gg: AYBFou3DJUpBv9Sbjb7X3ME8mSSia3OmOdgEFq5AOI4ni0AQvpBSy/vkeW2da1VvlEN
	x1kkX1MaxStml8CpufUSkqZOMKGzAB2mE24vQcRsdfvggEd46qVpuBrx2/V56yaS8Vax12MZcm3
	V9XlkN0ZbRVf/afQysCZ1dLgQaDPPwxWplK6dW730lYEOhOtboiduhNrw4hATtc4s9QTtE8ppCA
	tLJLX4d4ssqlKS35XZDAsN49bzAPiibJHgXKCQs+vEtr3IUnIBlLJpO4587NHuxid9/OFfujdoS
	KwFmWGb5kZFecJVSENDyrhDKv1YbAibQA58PPV/fhA3bGnem4x95PAGMpNCX9IJgHwBd7BmBV3q
	jiF941dnhDzhtGJTQctnKpXDJBxv7FHsvZDW3yyVGVIswiK03SyeTzUYW3SC4VkUo4tRGbl4Zsa
	w/84Rdfalu0dUANdICQCg+e6iiD3JREu2ci0GUjx5ykQ==
X-Received: by 2002:a17:90b:5443:b0:395:4de0:b78f with SMTP id 98e67ed59e1d1-396d0d4cf4emr24828890a91.1.1788016525770;
        Sat, 29 Aug 2026 08:15:25 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4f::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396ddc58f3dsm7464280a91.16.2026.08.29.08.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 08:15:25 -0700 (PDT)
Date: Sat, 29 Aug 2026 08:15:24 -0700
From: Joe Damato <joe@dama.to>
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	horms@kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] bnxt_en: Prevent queue stop with deferred completions
Message-ID: <apL3jDnQuMfifkj6@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>, netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	horms@kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
References: <20260827230233.94878-1-joe@dama.to>
 <CALs4sv1v7E_pxmdcNzxf8GyR7=-B26J5Z1YZ7fc4Y2Oc7Le8yg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALs4sv1v7E_pxmdcNzxf8GyR7=-B26J5Z1YZ7fc4Y2Oc7Le8yg@mail.gmail.com>

On Sat, Aug 29, 2026 at 02:57:59PM +0530, Pavan Chebbi wrote:
> >         if (unlikely(bnxt_tx_avail(bp, txr) < bds_needed)) {
> >                 netif_txq_try_stop(txq, bnxt_tx_avail(bp, txr),
> >                                    bp->tx_wake_thresh);
> > -               return NETDEV_TX_BUSY;
> > +               goto tx_busy;
> >         }
> >
> >         /* BD backpressure alone cannot prevent overwriting in-flight
> > @@ -77,7 +77,7 @@ netdev_tx_t bnxt_sw_udp_gso_xmit(struct bnxt *bp,
> >          */
> >         if (!netif_txq_maybe_stop(txq, bnxt_inline_avail(txr),
> >                                   num_segs, num_segs))
> > -               return NETDEV_TX_BUSY;
> > +               goto tx_busy;
> >
> >         if (unlikely(tso_dma_map_init(&map, &pdev->dev, skb, hdr_len)))
> >                 goto drop;
> > @@ -235,4 +235,17 @@ netdev_tx_t bnxt_sw_udp_gso_xmit(struct bnxt *bp,
> >         dev_kfree_skb_any(skb);
> >         dev_core_stats_tx_dropped_inc(bp->dev);
> >         return NETDEV_TX_OK;
> > +
> > +tx_busy:
> > +       if (txr->kick_pending) {
> > +               u16 kick_prod = txr->kick_prod;
> > +               struct tx_bd *txbd0;
> > +
> > +               txbd0 = &txr->tx_desc_ring[TX_RING(bp, kick_prod)]
> > +                                         [TX_IDX(kick_prod)];
> > +               txbd0->tx_bd_len_flags_type &=
> > +                       cpu_to_le32(~TX_BD_FLAGS_NO_CMPL);
> 
> Should we not do a bnxt_txr_db_kick() also? It maybe a good idea to do
> it in success case also instead of bnxt_db_write..

When this function returns, the caller writes the doorbell, so we should be
good. 
