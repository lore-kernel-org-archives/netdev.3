Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF562435515
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 12:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791464153; cv=none; b=L/GqkIOpG2JsjDtZHfj8+S02auOlzndXU92Wjeh+fLJ+ee4+5jqbUDHexwGRprPfJ3BoTJpv+nggW3BubEPKxFNf1mZ6Obp3mau/qdKNrwn1kNHoYQcahQzYl6JYpn1koj7TIExT+blzfwiOms5olC3z5/TBJJg/jMN3kwPT/CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791464153; c=relaxed/simple;
	bh=hcMe2LEaGKIqGNVLs9Ml3fZ/uvrjzyPZHHynwgsJCEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V7RTjxgMr3iQCHizOgbT4+E2ePyfUjdeNQqyIX03tO//LWojerZngXKf5p/LdYMmgyy5biEOMeBPZX6ZxXu2GILtazDeVaTGnGECHZUqgRxKaXDMHKiqK4ThkGdkF1urazaTiDIjotQdxU+Y02sRiTz81jtcJzhaLLNZ+DwTCh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=duglzlqV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LIKnxodr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="duglzlqV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LIKnxodr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791464150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pHDa4z9jnDXGGb+hEZleBywrVCv4SURdHVsUl7weYzs=;
	b=duglzlqVS+r4Hqg4+wVLNm89KIQ9mvGWKdjTf/r0tWpy7b9eLhaP0IUuhr8HjzlhVHFc/D
	3MFQnh41QyfwVVqst/hqbuppU3F3mghPXGnCOCEWsvNkcHRyfZRUtst+9jifWhFDMHyfoR
	reIRG406jLX1XnJn7ME54HOzeh9x7ss=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-bt_oE6SGOYifk_EMOw7_0w-1; Thu, 08 Oct 2026 08:55:49 -0400
X-MC-Unique: bt_oE6SGOYifk_EMOw7_0w-1
X-Mimecast-MFC-AGG-ID: bt_oE6SGOYifk_EMOw7_0w_1791464148
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49fcc575709so52510175e9.3
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 05:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791464148; x=1792068948; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pHDa4z9jnDXGGb+hEZleBywrVCv4SURdHVsUl7weYzs=;
        b=LIKnxodr/CWkMz1CD+ALEe491w//nAbbbwUtReQ/ISs9FnQgWA1bO5jAsvwbTnHpYV
         M2OUda2LDGGRXciJhGYb70drbK9JnAa4B7FmIIbzAIH+KGg0vr8VbF9MwetG1Jot5uoH
         1jB7plwoJ9xYZq6PyemJXGNzNP7Lm+M14k/9nE50bOfIYXqdNleJrfYQuf5oKZrWiDRY
         e9lyEAQoildubV0S1JmEpZQTn1JqfliYs/mG8t2rzl188Xed+3j7c1x9/KkFUj0W9U3j
         qQoSXS7IhXYBgMyYCO1NNnMZPeZXjycI7fe3UgcqMUy0FZTpEKpVmvOQw/Bp9V5JH0vE
         f+CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791464148; x=1792068948;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pHDa4z9jnDXGGb+hEZleBywrVCv4SURdHVsUl7weYzs=;
        b=h3FDK3E6d8CLXSxCOeWj+HbXOjDNP83jjInpclkqE/x4N2imV5m92mnSsqjS5kGMjD
         sZeYcPkdDdSC2IunINIKD2Nb6wlWlnl3ZcDXn7TTnD70odlQ5KC992kF5r7Cbh8VbqLs
         evjJeQNYlgIX3CtqCDBhjzI5fLsFgmW5zx5fP+mDN/FY/yNMNQIfmpF+FUTE8vJXyyD1
         K4CvBYIJV0AfDW/9jodoE56DBpDbiWRejXkmlXhuNERBcvgcH348nwfAeMRJsPpFL2bC
         BOZBOqUcvL+gD5poWjXHfrxZIb8QEtRIJgNI8MgKZ5CJn/IAgvdSXbzV5/MGhImbbswr
         nTZQ==
X-Forwarded-Encrypted: i=1; AKwUvBziHcWBYse8X+Mb+Ja98U9BKUk22vYqNPc4Ka2bunUtA5EiqzzRMzgaIVSNUcxg1nrpcNHyLUA=@vger.kernel.org
X-Gm-Message-State: AFuF++lUwbDzHWpx/UXpqut6IKz35wkkp0zWFYd/7+9XMSe5FA59b6Gg
	mq8jWaqXY/joZMj5KsRQP2hy8RcGR630N230gqNsGCmBvCJe28pL6RwozGCBhdJRRLAUvaT7JLJ
	nOXLez0pxohgQzD63MzQuWPZg2EEjG3kV1ugcQ7NV6upqncUoCO6w4UOYtQ==
X-Gm-Gg: AYBFou2cyBNjT2lr445LrgUO8ZPLTJI6EstwinCYyAXkzF0Qm0g5kodjKvO481UNNEW
	+xxEIlGWfur8xNSb1Oe4n5gmYN1uwhpFs8wJgbVZUSokGatu1NSUdRURiTIu+o9BVHVIvJ0N05g
	uTRwLWFqJGmIWP983R2R6hghJAMfBvrN02SYChP/PzGZoMg6OF1bCHhA5SPLdGYIKWdXcVm5xQt
	o7u7sBa8weW/m3F4wc8XO3dtILVd7kIlKa3ZQqH9P/p7y2Kw0KNDVjLw3MFFzQCPIVtX9ZzCZUV
	bzAgETm+oKtz8MDuvlJwyfAQlrOz9EkTdBbt/+pNXB+hpZjFsOgkCOtZg5WCk3/+DYGndSrQyQI
	9hO9qWiW+KEBmlbgB73QIVZd384C136T3
X-Received: by 2002:a05:600c:e548:10b0:4a1:813f:2a65 with SMTP id 5b1f17b1804b1-4a1813f2d75mr65665225e9.15.1791464147974;
        Thu, 08 Oct 2026 05:55:47 -0700 (PDT)
X-Received: by 2002:a05:600c:e548:10b0:4a1:813f:2a65 with SMTP id 5b1f17b1804b1-4a1813f2d75mr65664965e9.15.1791464147562;
        Thu, 08 Oct 2026 05:55:47 -0700 (PDT)
Received: from mheib-thinkpadp16vgen1.rmtil.csb ([216.128.14.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1802cdf24sm93045815e9.2.2026.10.08.05.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 05:55:47 -0700 (PDT)
Date: Thu, 8 Oct 2026 15:55:19 +0300
From: Mohammad Heib <mheib@redhat.com>
To: netdev-bot+sashiko@kernel.org
Cc: anthony.l.nguyen@intel.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, edumazet@google.com, andrew+netdev@lunn.ch, 
	netdev@vger.kernel.org, przemyslaw.kitszel@intel.com, jiri@resnulli.us, horms@kernel.org, 
	corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org, 
	linux-doc@vger.kernel.org, sx.rinitha@intel.com
Subject: Re: [PATCH net-next 1/3] i40e: move ATR sample rate from ring to PF
 level
Message-ID: <aseRoSoLr-obT5Ms@mheib-thinkpadp16vgen1.rmtil.csb>
References: <20260917204541.3072415-2-anthony.l.nguyen@intel.com>
 <179002634029.2160803.4618287131417011270@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179002634029.2160803.4618287131417011270@kernel.org>

On Mon, Sep 21, 2026 at 09:32:20PM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 · Medium: 1 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] Concern (discarded on baseline verification): removing the per-
>   ring atr_sample_rate decoupled the software ATR gate from…
> - [Medium] Undisclosed user-visible behaviour change: "i40e: move ATR
>   sample rate from ring to PF level" is written as a pure storage…
> 
> --
> 
> i40e: move ATR sample rate from ring to PF level
> 
> This moves atr_sample_rate out of struct i40e_ring and into struct i40e_pf,
> initializing it once in i40e_sw_init() instead of in i40e_configure_tx_ring().
> i40e_atr() now reads the PF-level value, and ring->atr_count grows from u8 to
> u32.
> 
> > diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> > index abbc71e815ae3..0a4272e1ab070 100644
> > --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> > +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> > @@ -3458,12 +3458,7 @@ static int i40e_configure_tx_ring(struct i40e_ring *ring)
> >  		ring->xsk_pool = i40e_xsk_pool(ring);
> >  
> >  	/* some ATR related tx ring init */
> > -	if (test_bit(I40E_FLAG_FD_ATR_ENA, vsi->back->flags)) {
> > -		ring->atr_sample_rate = I40E_DEFAULT_ATR_SAMPLE_RATE;
> > -		ring->atr_count = 0;
> > -	} else {
> > -		ring->atr_sample_rate = 0;
> > -	}
> > +	ring->atr_count = 0;
> 
> [Severity: Medium]
> The commit message describes this as a storage relocation: "Since the sample
> rate is a global policy that applies uniformly across all rings, it makes more
> sense to store it at the PF level."  Does dropping this conditional also change
> when the writable "flow-director-atr" private flag takes effect?
> 
> Before this patch, the per-ring rate was latched from I40E_FLAG_FD_ATR_ENA at
> the time the Tx ring was configured, and i40e_atr() bailed out on
> !tx_ring->atr_sample_rate.  i40e_set_priv_flags() does not add
> I40E_FLAG_FD_ATR_ENA to reset_needed and only handles the disable direction:
> 
> 	/* Flush current ATR settings if ATR was disabled */
> 	if (test_bit(I40E_FLAG_FD_ATR_ENA, changed_flags) &&
> 	    !test_bit(I40E_FLAG_FD_ATR_ENA, new_flags)) {
> 		set_bit(__I40E_FD_ATR_AUTO_DISABLED, pf->state);
> 		set_bit(__I40E_FD_FLUSH_REQUESTED, pf->state);
> 	}
> 
> So on a live interface whose rings were configured while ATR was off,
> "ethtool --set-priv-flags ethX flow-director-atr on" did not resume sampling
> until an ifdown/ifup or a PF reset.  With the PF-level rate now always
> non-zero, the flag alone re-enables descriptor generation immediately.
> 
> Could the commit message mention this user-visible semantic change, and should
> it carry a Fixes tag if the old latching behaviour was considered a bug?

Yes, this is a real behavior change. The v5 commit message now documents
it explicitly.
> 
> [ ... ]
> 
> > @@ -12740,6 +12735,8 @@ static int i40e_sw_init(struct i40e_pf *pf)
> >  		}
> >  	}
> >  
> > +	pf->atr_sample_rate = I40E_DEFAULT_ATR_SAMPLE_RATE;
> > +
> >  	if ((pf->hw.func_caps.fd_filters_guaranteed > 0) ||
> >  	    (pf->hw.func_caps.fd_filters_best_effort > 0)) {
> >  		set_bit(I40E_FLAG_FD_ATR_ENA, pf->flags);
> 
> [Severity: High]
> This assignment is unconditional and happens before the Flow Director
> capability detection below it.  Can that decouple the software ATR gate from
> the Flow Director enable bit programmed into the Tx queue context?
> 
> i40e_configure_tx_ring() still snapshots the flags into the HMC context:
> 
> 	if (test_bit(I40E_FLAG_FD_SB_ENA, vsi->back->flags) ||
> 	    test_bit(I40E_FLAG_FD_ATR_ENA, vsi->back->flags))
> 		tx_ctx.fd_ena = 1;
> 
> The matching software snapshot (ring->atr_sample_rate) is what this patch
> removes, so after toggling "flow-director-atr" on without a reconfiguration,
> i40e_atr() would pass the new gate:
> 
> 	sample_rate = READ_ONCE(pf->atr_sample_rate);
> 	if (!sample_rate)
> 		return;
> 
> and go on to write an I40E_TX_DESC_DTYPE_FILTER_PROG descriptor and advance
> tx_ring->next_to_use on a queue whose context was programmed with fd_ena = 0.
> Would that produce an MDD event or bogus FD programming status on that queue?
> 
> For completeness, the later patch in this series, "i40e: trigger PF reset when
> re-enabling ATR via ethtool", adds a reset on the enable transition in
> i40e_set_priv_flags(), which re-programs the queue contexts and addresses this
> for the series as a whole.  It does leave a window between
> bitmap_copy(pf->flags, new_flags) and i40e_do_reset(), and it means this
> intermediate commit alone is not bisect-clean in that respect.  Would it make
> sense to fold the reset change into this patch, or to order it first?

Addressed in v5 by folding the PF reset patch (was 3/3) into this
commit. The reset on ATR re-enable now lands in the same commit that
removes the per-ring gate, so the tree is bisect-clean at every commit.

> 
> [ ... ]
> 
> > diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> > index 7f68adb5109b0..e045f9c71c944 100644
> > --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> > +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> > @@ -2882,7 +2883,8 @@ static void i40e_atr(struct i40e_ring *tx_ring, struct sk_buff *skb,
> >  		return;
> >  
> >  	/* if sampling is disabled do nothing */
> > -	if (!tx_ring->atr_sample_rate)
> > +	sample_rate = READ_ONCE(pf->atr_sample_rate);
> > +	if (!sample_rate)
> >  		return;
> >  
> >  	/* Currently only IPv4/IPv6 with TCP is supported */
> 
> [ ... ]
> 
pw-bot: cr
> -- 
> Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917204541.3072415-1-anthony.l.nguyen%40intel.com

