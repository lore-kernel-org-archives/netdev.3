Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com [74.125.227.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABD538425A
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 17:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787333340; cv=none; b=es8RlGz2sKQICRUO7lc4m4arB9Laz/jJ4LB/moyVJXtiJNqE43xn+jo/pr81Eqq7Ltcs1wP7iKONdq9p4EtnKNdxLu2OXaxE1x3l/M0HV3BCgDPODsh0nC6mc9qkx4M6HYE3wDh3KojFaRj1dItstdbvCiNj9Q1YfH0AckSdJSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787333340; c=relaxed/simple;
	bh=8RUjnU6xRjcmNvUjJtxfa9pOtsNBEqKceMyc7GHbth8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ebn6d/bG4qZJ2FRG4FglakB5mTWi8cyhskJL40OHOknw8y3kA5eNc2LHgLYeE3B0mZp9Cb7zvvFP7Rw31k3ar2Us9ONyAjDwNa4vcfFvik+hc7e3COQH4mCEY4s4u3pshC1zrtsjKx2voz6HjnRqKvaWDeXir1BWdQqZS4+CKsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qNxgTY18; arc=none smtp.client-ip=74.125.227.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qNxgTY18"
Received: by mail-pj2-f11.google.com with SMTP id d9443c01a7336-2cf02ecb572so10804735ad.1
        for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 10:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787333332; x=1787938132; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+RpCheSrOdysr+r97ve0JN+xVtWYbZrCXCOuzISS1Oo=;
        b=qNxgTY18rOb7T0OC5VtF0SuhunEmmcsk/6gTTAGgDGaKIylfjtjTQnxeL6DngsqYDz
         zaDZTNMNmL/T82F72I3x60JxeumK3DKoSkRDl9R2GOaTyjmFXpQgDHi9UvURWtYAXQd8
         2Ym+Hdi/6vKrBTZyNSBXCXyYdtE2J6NY6FgBnWJRp2icp4f/riSus4fp5f/SMYasIHvV
         mqJsgQ+nEynE7aO+ose+SBqN2r+VRf4hYMzI8mhVJQpLi2ggGitsfJM6CK7BbkQmOV6r
         pARfwYuZ0INZ9cMXZIJmNRGWXAqWgWOrecA/GmoHT4mA4iccPhmirpXnopgjHt5Squ0K
         1rZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787333332; x=1787938132;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+RpCheSrOdysr+r97ve0JN+xVtWYbZrCXCOuzISS1Oo=;
        b=WEikkU1HoxLOOsOp8mizOCVhMu76KMU0BE+vhyL2IuMein/NLWeZOW5owI2/76xdZ3
         EZQVI7n/iwrGT9vfMb3w4JFDLNaxBHoonUHh3ewdLdS8SrfcD79SXDjuTLTPFhU/phLZ
         ZvtR85bzLFsT+f0h0nJ7RjXRuZ1SaYcelTh3zcW6y9whKMFAiTZS8HxW8MqzB7YwV7fO
         ExrDR61T6bwLZOk1pGQuOyB93OC/+C4XTHmHrfnpy5x2gvyNLVXEXWObJ8nOV2HavquQ
         TQT9Iv298sGIWWTwEmwGG66jc/zX6g0JfwR2A/VIP16bKDrTBQJwuNgF46+yI0JwA95C
         2ZOQ==
X-Gm-Message-State: AFuF++mZjuemdwjcp2fWUpGSjlDisVlAfs+TfPOgi7E4ccpYwE8HMzo8
	3P4JlYBvNeiV8h020pv9WOs29XVyEGr7k0Lrr1EDrLx5AkSJ8NRPdSf/
X-Gm-Gg: AR+sD11/Sic8VnhP2GVzMn6Y1ar1OP0HlNBOTEQog1WlnODxvQk+b03Qo3E4L/1e8lW
	vFYYA0NxtFDuZ+Ag1Ss80LKQQ7vi/UptnvwP/O1AcodxukD+svcvCeEq0rbLuAQCXw0WA89dwY/
	lHxcMtXCNbOFD0v9MapbXiHF66VprRgyYKCOseCre1bCWs6w0GbXdjbGou+Rla9JsWIlZDixbNu
	0kDat+ifLaSq8JE05H3sPRGJDYSxPi6RZsyab6Dzbnso8YF7gKiBAKbdpfpVUajYn0XShsRqZeR
	S2iK2bQYRwFUUoqf1QvkJrySWjzh1AH4XfuC1XCzS2hfEvyg6l8DnAzzWadUy/aR+r+5Zu/TXVO
	c/bbz8g8WGdMqsuqeBwk19hg4v+8XcY+MYVZaxp6X7M9+NBhmz7ApH+exY165MlBqc52F34BCFO
	BWSNWuOoDimqRSdq498bL0wmED7UvVt+kBe1hJkqs4jZATF6Vb1zTArw==
X-Received: by 2002:a17:902:e943:b0:2d6:3c2f:69b with SMTP id d9443c01a7336-2d64af6f8cemr156390915ad.8.1787333331890;
        Fri, 21 Aug 2026 10:28:51 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:48::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d62d555b51sm21790945ad.7.2026.08.21.10.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 10:28:51 -0700 (PDT)
Date: Fri, 21 Aug 2026 10:28:47 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, anthony.l.nguyen@intel.com, 
	przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, saeedm@nvidia.com, tariqt@nvidia.com, 
	mbloch@nvidia.com, maxime.chevallier@bootlin.com, mcoquelin.stm32@gmail.com, 
	alexandre.torgue@foss.st.com, aleksander.lobakin@intel.com, horms@kernel.org, 
	magnus.karlsson@intel.com, sdf@fomichev.me, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, guoren@kernel.org, dtatulea@nvidia.com, 
	witu@nvidia.com, martin.lau@kernel.org, yoong.siang.song@intel.com, 
	intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, 
	linux-csky@vger.kernel.org, leon@kernel.org
Subject: Re: [PATCH net v3 3/3] net: stmmac: document oversized AF_XDP frame
 handling
Message-ID: <aoiIarzdjk92RkCN@devvm7509.cco0.facebook.com>
References: <20260819160535.1472459-1-sdf@fomichev.me>
 <20260819160535.1472459-4-sdf@fomichev.me>
 <aoceSoSFMx69Z9up@boxer>
 <aoeoJ6-njBxcWs4w@devvm7509.cco0.facebook.com>
 <aogpDsa8hz6CPpD3@boxer>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aogpDsa8hz6CPpD3@boxer>

On 08/21, Maciej Fijalkowski wrote:
> On Thu, Aug 20, 2026 at 06:29:16PM -0700, Stanislav Fomichev wrote:
> > On 08/20, Maciej Fijalkowski wrote:
> > > On Wed, Aug 19, 2026 at 09:05:35AM -0700, Stanislav Fomichev wrote:
> > > > stmmac drops AF_XDP zero-copy frames that exceed taprio's queueMaxSDU
> > > > after xsk_tx_peek_desc() has reserved their completion entries.
> > > > 
> > > > Completing a rejected descriptor is unsafe because AF_XDP completions are
> > > > ordered: xsk_tx_completed(pool, 1) would complete the oldest outstanding
> > > > descriptor, which may still be owned by hardware. Instead, leave the
> > > > completion pending so the ring eventually wedges and increment the drop
> > > > counter to expose the application error without risking hardware
> > > > misbehavior.
> > > > 
> > > > Document this intentional ring imbalance at the check.
> > > > 
> > > > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> > > > ---
> > > >  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 ++++
> > > >  1 file changed, 4 insertions(+)
> > > > 
> > > > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > > index 62de03e65a90..6a532747c039 100644
> > > > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > > @@ -2713,6 +2713,10 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
> > > >  		if (priv->est && priv->est->enable &&
> > > >  		    priv->est->max_sdu[queue] &&
> > > >  		    xdp_desc.len > priv->est->max_sdu[queue]) {
> > > > +			/* Completions are ordered, so this descriptor cannot
> > > > +			 * be completed safely. Wedge the ring to expose the
> > > > +			 * application error instead.
> > > > +			 */
> > > >  			priv->xstats.max_sdu_txq_drop[queue]++;
> > > >  			continue;
> > > 
> > > Hmm. I read the discussion on v2. Maybe we could cancel cq entry here in
> > > this branch? Also it feels like something achievable at bind time when
> > > taprio is configured and vice versa?
> > > 
> > > Otherwise we over-commit cq entries.
> > 
> > What do you want to achieve with the cancel here? IIUC it will make it look
> > as if some (if the user has posted many) tx descriptor has not been consumed
> > by the kernel?
> 
> Oof. My bad. I meant completely different thing :D
> 
> Right now the semantics are that we post invalid/dropped addrs to cq (the
> rationale was that dropped descs are gone and unreachable which might
> eventually lead to dying traffic).
> 
> We should submit xdp_desc's addr to cq.
> 
> Regarding the comment included in code I must disagree. CQ entries no
> longer imply that 'this particular descriptor has been successfully sent
> by HW'.

But then we need to support some sort of out-of-order completions, no?
This looks similar to
https://lore.kernel.org/netdev/20260818162442.3980697-1-kuba@kernel.org/

We write desc to cq at xsk_tx_peek_desc, so when we get an error here
we might have already "queued" a bunch of cq entries (which will be
xsk_tx_completed(num) from sirq). So unless we rewrite the way
we do completions, there is no easy way to put that desc on cq without
breaking the order and racing with real completions from the HW.
Am I missing something here?

> > I do agree that a better idea is to probably do these checks during control
> > paths, but it's a bit more involved (and not sure if it's possible? if we
> > have a bunch of xsk sockets and we change that max_sdu, do we go over all
> > sockets on the system somehow?). My main motivation with this patch was
> > to make our LLM reviewers less chatty about preexisting issues.
> 
> I hear you, however I feel like we do not know this driver too much and
> probably we don't have a HW to test out such changes, so maybe let us try
> to fix existing behavior?

Let's definitely fix it properly if you have better ideas. But since we
don't have HW, I'm not super confident doing anything sophisticated
myself :-D
