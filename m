Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792561568;
	b=ZiT10zKf98mmYvreF31utP5kBCW1fzCqWVp7GmnwXZLm9juJksGr5AknXZ/y4gRjl+3w
	 CgJXxVjSNkOAstwtyB/WzC1QyECdbyiELeHfWuAfjgTkGvH140J0AHcLfBoOVkPwau+72
	 DMtZgAWvt74426yoVxmqkJb8kXVnxwMFkJhfGWG9jVco/Jw4uuf+hZBtR2fwR010dFKDD
	 nOMtIyyAiwHLx1sRicC2ym9+pGFaBeRWv5xDBLitW9DXWT9l2vjXGU+iBNGKbiqsAQ6t1
	 baysZx1aZHbtb+QxLCjStXOqcAOF9umt3FtvWxj0qJMxKfQiLXF1QdBHOsZjX3b4sIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792561568;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=i+9UXU32eo1W6vF68Fm8xwvs5/xE61sfCBqy8D9x3MM=;
	b=Elq3bnQBI0OPkjoLC1rcxhQRjwbas7cDOQRmyq/Z2co65Sd4lo9vXpzxZNWzK8zzmdmF
	 zttYfMozSKmQ6qMg/Ha4iNhVlleR6wrekOzRWr+knpKzWIpIW72fDUNaC4/z0sSnvyeGR
	 uYT0nho+4L/rvlqn95oab+MPK6cxVB8nRXV7biyMeCqxepDhncrGA7hVNS+UEt9IHCMGO
	 zRdMh5jwJkzP9kTbV/JDzcIXBECbbPYlpwYZFUIFVd4TBmOgKutE2kW5tV50Q6k2eh5US
	 9M0i3c0hcgdc468FWwIfizenjq7Ax+Ron4SI/HxjJE87rL6GF4IzfA9KaEgyRDIlicw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jYHCIPLd;
	arc=none smtp.remote-ip=209.85.160.174
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54889606A319
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 05:46:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54889606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jYHCIPLd
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5365d26ccbdso5218821cf.0
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 22:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792561567; x=1793166367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i+9UXU32eo1W6vF68Fm8xwvs5/xE61sfCBqy8D9x3MM=;
        b=jYHCIPLdTvJg53TbEzuuRb8c53fEa9wHNb8E8RzuWZtENXwcvjwBclubqxZlY21SS3
         MbWM9Bwr3XRxW9Guh9qymGU4EvlbFo2eX0wkr9jxviEvCvwm0qe6FQdcgL9UNdXV7rHb
         KpERv52CGWFfZ94sXXAWxZ+XZtBPpdOthEO9asjlNsmcKUOsY4AxPz3gryeSpafRggMc
         o4TOqCEufC+cD2tCl5qzHTvLsiPZJeblvqEzA5GwJjKSXP1q1JudEnlQwo+nvCrm7v3F
         Yg7cn67/JHj0w2ZyGzpKgQlCOB8CUbRXoZCctc21oPSqMsaMBg/nmpWi/Pgv3dbAA6p3
         mx+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792561567; x=1793166367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=i+9UXU32eo1W6vF68Fm8xwvs5/xE61sfCBqy8D9x3MM=;
        b=MrVjYDJERvLtkWATynq5d87UNa5Dqp7BUXMFxPZaNioLCqUSXkkMquZWUE9G4keDco
         DEPRb56uVBRAuMSMLEVnMwxiDePBnSc2sl+Ur9iNLZizrRc+2j0MmwTkAp+UmSkh3Th1
         83iPkIq1MgUmZMHkY3p0IX0aHimvD4hErVy7RYcmIUAGiKLmwrivfT6wWvpJYB1NPtfN
         hCqOQpBSxsQ6FNQOAfW971m5HSuDLdU5y0Id+FTWoXQaTRpgA3qJ75Z9Y59Um/6s7dSf
         36iVtCKWHb6cAFwb+g/gBg2JZQEzB2OAjoaD9PwLjkI5ArZ6Z4WC6uZKITih8gYVJLOU
         sPcg==
X-Gm-Message-State: AFq9FYJBFKRNeiyc9Ha+aWs/diWO3/7Tpc32CxRo+SG9gGU9eOHJn1UH
	NO0XWtAzRMSZDmpTgTErC5Y8FpPp4a/uabBKrKonpP7bvoD8q+yma2W4
X-Gm-Gg: AYBFou2ZPJBziIMLZhwBto9dJn91tI/INFUhIEpWjf3XbjZc3RLHbhWwKlrXyAzzhhN
	nRkuQW2RA7JRJjlOoSqldAsHLnWrQv2CmfrJKlMvADtWa2UwwCcqKD7GgLT5Augc55prqNA5dyI
	OAo42xSihuT1MnncUE1fwRCg1ydIU3juS+h64LzhTJxsNKB4lCcXEWP4DktoHtGPkD/o0GKy6K9
	TgHl6r1wJEHiW/ZQLiuZGgXtAr1pib6KoaNBVV5PCqICCq8F48jN58jEIlHEahTH6g1RwikVVjk
	UDOoNK3/Yb/BM1LT8b5ZQd9lE8d/Zs5a4gtuFApH4mZ4yG4nWUoRpKTEjFu2BOTrsxQIVHmRLvG
	Pc0Jpz83C0XktJwqCfDXkrLqgS2hjp0uLtyjQ7lttzxoGTg9M4wbNJIC0pfPcqq4vLc02VzHXCg
	RyPS/kpuaCSk6rVcqL2gx0hX+VMDFceJfv1oTxsVrTmlX4q2VaAd0kA11Kw5OV4+jDaWK1lUHGk
	zRVimgRZu280DgvsQbr1PvpKmBba+Gd9qJkM8Oje7VX1TOftj4=
X-Received: by 2002:a05:622a:144b:b0:536:72b4:b84a with SMTP id d75a77b69052e-5369b8b7357mr15316451cf.42.1792561567199;
        Tue, 20 Oct 2026 22:46:07 -0700 (PDT)
Received: from houminxi ([61.170.224.204])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53698b7584csm12130351cf.17.2026.10.20.22.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 22:46:05 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: kuba@kernel.org
Cc: netdev@vger.kernel.org,
	donald.hunter@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org
Subject: Re: [PATCH net-next v3 2/2] netlink: specs: add ovs datapath and vport set operations
Date: Wed, 21 Oct 2026 01:45:49 -0400
Message-ID: <20261021054549.1858049-1-houminxi@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261020202442.1012753-1-kuba@kernel.org>
References: <20261015024132.698658-3-houminxi@gmail.com> <20261020202442.1012753-1-kuba@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 20 Oct 2026 16:24:42 -0400 Jakub Kicinski wrote:
> Should this doc also say that per-cpu-pids only takes effect when the
> same request sets OVS_DP_F_DISPATCH_UPCALL_PER_CPU in user-features?

I left that out on purpose. The doc covers the half that changes
state: a missing user-features attribute is treated as zero and clears
the features. per-cpu-pids is only read when that flag is set, and a
request without it succeeds with the pids dropped. The kernel already
behaves this way.

> Could these notifications be described in the specs, either here or
> in a follow-up?

A follow-up. new and del have the same gap in both specs: the handlers
send through ovs_notify(), so do() returns only an ack. Describing the
notifications means adding reply and notify to every write op, which is
more than this series set out to do.

> Should port-no be listed here too?

Not on set alone. lookup_vport() accepts a port number for new, del and
set, but the spec lists port-no only on del. Adding it to set would
make the three lookup keys disagree in a different way. I will fix all
three together, separately.

> Could options be dropped from this request, or could the doc mention
> these limits?

The doc now mentions them. The list stays: the handler reads both
attributes, rejects options with -EOPNOTSUPP, and rejects a type that
differs from the vport's type with -EINVAL. The list is what the
handler reads, not what it accepts.
