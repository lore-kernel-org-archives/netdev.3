Received: from mail-pz2-f1.google.com (mail-pz2-f1.google.com [74.125.228.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC0C2ED84A
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 01:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787275764; cv=none; b=n9PrmLHJdi1r0fUXmJpUv4jcdPNgfsHSakDsSjznF7Mb5cUr/yjll7r4uGEDDVGF/o5ydRK9gPWuA/wogCzQFNisO5vThDCS4oVm/y0VuZ6Ad0b9u04XSf97qH9ppB3A0MRW0qb8hlRSjoeVThey5svQmqPV7+FbQPgCp/8vAkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787275764; c=relaxed/simple;
	bh=gqWMHjglpbHY/2tqJjSk/6W2N13etU+sr8bVJuTM4ZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gcOQfOpWLgEs7IzouTgfSRHdoEMbnPjZMD3ZDoNg3D/eA9BBNqkCMjGHS+7arW6afRXBNz/Cg6BvDvSkC71evKVGPFd8g3BiHigiMAnStd/p+qS12xtpheqBT5TVR/j83mgeyG2hxuiZ4vvoN6KsBzvei91VgWzUSPQ0zpJfAk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KBE9ytoq; arc=none smtp.client-ip=74.125.228.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBE9ytoq"
Received: by mail-pz2-f1.google.com with SMTP id 41be03b00d2f7-ca7d1dc4554so126377a12.1
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 18:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787275762; x=1787880562; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PL4vLuVN0ieJR1wtgaFdgTaFWontBf4roejCfLnzVDs=;
        b=KBE9ytoqGNRk0tgsofHNaXiCHOv08zLHV/Tn5QNqEU6FbejhbPTrmHgiSqd9X/lPhA
         ftwsSblQvDRaoeBW7p4WSTkipw5AvSJo+hqSQ8z8EliowpercQxBHDEikzcLz2Jw+jqH
         1KjueGhPQSH5C9YUHHziDB+0+ChuUzDr0UDHUQqD0Ix7M22vFwKqC51lV70ZXuUj27Bg
         F6Ul/NxR1NK60cC2O6pEGr9nd2YMcym/hXGdpIADJpJIKHRzFG/0rQnK52RmLCY5q/Se
         bszGnLCoc7fHLzHo0qTFAMWd27RHLEODylghyZYDHllFAbTFxi3wSHVQfLcnw76hiUCS
         HrWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787275762; x=1787880562;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PL4vLuVN0ieJR1wtgaFdgTaFWontBf4roejCfLnzVDs=;
        b=Fs9fScc5K1jBxHbtmqMCJGFkrS3ltLyX2jGFJiCebtlvYEykH8XijiKhQAkxgsRoUG
         INzpucRXQljJtYMkH/6EyQYvsQQigM2sDKl4s6TO18GRUz6bcXb50ErQTeBqkMv/c4RD
         1To3wgHexSp9dkQtCJ9Pod0hQYs2+wo6LF25giz0u0EOV/bB/Yl68y9IqyIpTdPcT+Kp
         F6Sv4HAK2c1zlnSukQ1ev/OjzeT3Qc23IDNAtvWXveCRF/66vtetE/MeDaK1h5LB990o
         kJ2q0ZpKJp/8l0lZ7cjWXBpT/QDjKyD/+spjpb8ZXW6HThVbdcEwttnv0TJbTcVuT0HT
         2vVg==
X-Gm-Message-State: AFuF++likGXwXfyqGgtTr2RiDX6zge66ggdHqXOn9D/XM4JpyRlu/g+F
	xyPhd25QPeHTvE8ocPW8FH3cRinJ/U4xt9s8Bak9V6AAsYVL97vvdbrF
X-Gm-Gg: AR+sD112tfkEDwidYnjx0Q/vcXhlh/upOyg+68hYp0083lJw/QLYFppHFpVHUAmQBIK
	rAU2IjDRZ4w4zQcqI0uLC9psFCqV+qW5bVx/1sz5H5hjEjxIkQP90StLKln1JazX4sGIad93w7X
	kJlS6lPOHiar1mJeHUBdxIYskZuejHWsAIM0R28onqI7AImMvHgk3XNDSrLeHhHK3D/mCZIopMl
	etIkjCj1QrbZa9qJ8mAhBcfY7U3cmfq5r1C+xa39C+GrnH7DRY5b95Yxp2nKRSvZgGCBbkVXLNM
	0CrcVQlrmCtDlwraCY7bAWctJk2TN/TZc8IZ66rU7/TaYNfddbxyEpBBAW0fkAuHMeQ6tsk+QWM
	S20z2ZV1HwVx8tBwARTYr2Oq2evUu2GXMuu9Wyj2RUMxulHg/e8k1zTnfVTT21ZVxi9bJR3FIRr
	zbVKy+EdxpGa1wrPJCLvjB06K8iZRqzQ6vUlnfCvmaWtRy/9dZHYYhg612+mr8Ft4E
X-Received: by 2002:a05:6a00:170c:b0:845:e440:d0ca with SMTP id d2e1a72fcca58-851f9f0db82mr3439334b3a.8.1787275761986;
        Thu, 20 Aug 2026 18:29:21 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:2::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-851d3640dd4sm2169685b3a.41.2026.08.20.18.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 18:29:21 -0700 (PDT)
Date: Thu, 20 Aug 2026 18:29:16 -0700
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
Message-ID: <aoeoJ6-njBxcWs4w@devvm7509.cco0.facebook.com>
References: <20260819160535.1472459-1-sdf@fomichev.me>
 <20260819160535.1472459-4-sdf@fomichev.me>
 <aoceSoSFMx69Z9up@boxer>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aoceSoSFMx69Z9up@boxer>

On 08/20, Maciej Fijalkowski wrote:
> On Wed, Aug 19, 2026 at 09:05:35AM -0700, Stanislav Fomichev wrote:
> > stmmac drops AF_XDP zero-copy frames that exceed taprio's queueMaxSDU
> > after xsk_tx_peek_desc() has reserved their completion entries.
> > 
> > Completing a rejected descriptor is unsafe because AF_XDP completions are
> > ordered: xsk_tx_completed(pool, 1) would complete the oldest outstanding
> > descriptor, which may still be owned by hardware. Instead, leave the
> > completion pending so the ring eventually wedges and increment the drop
> > counter to expose the application error without risking hardware
> > misbehavior.
> > 
> > Document this intentional ring imbalance at the check.
> > 
> > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index 62de03e65a90..6a532747c039 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -2713,6 +2713,10 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
> >  		if (priv->est && priv->est->enable &&
> >  		    priv->est->max_sdu[queue] &&
> >  		    xdp_desc.len > priv->est->max_sdu[queue]) {
> > +			/* Completions are ordered, so this descriptor cannot
> > +			 * be completed safely. Wedge the ring to expose the
> > +			 * application error instead.
> > +			 */
> >  			priv->xstats.max_sdu_txq_drop[queue]++;
> >  			continue;
> 
> Hmm. I read the discussion on v2. Maybe we could cancel cq entry here in
> this branch? Also it feels like something achievable at bind time when
> taprio is configured and vice versa?
> 
> Otherwise we over-commit cq entries.

What do you want to achieve with the cancel here? IIUC it will make it look
as if some (if the user has posted many) tx descriptor has not been consumed
by the kernel?

I do agree that a better idea is to probably do these checks during control
paths, but it's a bit more involved (and not sure if it's possible? if we
have a bunch of xsk sockets and we change that max_sdu, do we go over all
sockets on the system somehow?). My main motivation with this patch was
to make our LLM reviewers less chatty about preexisting issues.
