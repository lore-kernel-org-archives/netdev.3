Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2436E3A4F35
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 03:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789528202; cv=none; b=OlbQIbAescRJU4wS1FcHyzZEILTEqajl3jylR1y7eWhdzs1QNI54S3ONdAdSfFJnX0SE2XwD8Nt/bmi+psUD04ZhbKkmD2KhN3nInp97Ld2hNVNow4rSEZ8j0OK3h4WpuqMhvR1j/72DycjtHdZfZPMVy12X4TUtBNXKkNNZESI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789528202; c=relaxed/simple;
	bh=s3onKEyrT+0WHtiaDzpK2XQ5j/0XZyztY0aypjYq4dE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k/VgMEySl2g9rWLyFfcUqSeO301aiRjTlOOK6ri6bB520LDUA1tpo5+Uv2ru4o5ND/P6qxJGj53HKkJIOAOAlVomO4+pKXBeTm/IajjdhhMkgV0QtyYHke0+W+idz8UBVxZjp4lePasu727N+JSlvYrv9NNC3MXA5QSE4G5A5h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JTuSBm/W; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTuSBm/W"
Received: by mail-pz2-f41.google.com with SMTP id 41be03b00d2f7-cc1cea4bfb6so202709a12.3
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 20:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789528199; x=1790132999; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Xo/F38+zAwDZOYgaXngSmzbr3sc8wNw9Tr/i8NiK348=;
        b=JTuSBm/WipSCDtIsyDkAXXnr4lekbxN0M/G0OXJAq2pQx6qoLk/QEFCBpsFbfESfNU
         nGdL9umXrre0dDHQWnmrJzQXQw69/74CkqzB38gGf+riHLFcf02mcx+A+sWByGJ0PqIb
         FeM61oI5hLLwiMF6DiWjafX1Q396Y8v0n+1p0g+mxYGfLQ1Xui/L91UhrEd4W9XMtpQ+
         warOOBaKdz+V/0ncqm8CxhchItw2B4ndN1a4Wyl71bjXfbB8J1ZmsH8Ge0diVp5UHrIl
         PekM+6NaV3Ohn85DZH2ns6++euHQl2Lm2YLNLKoJT/lAKhX8hKml9N+Io/sEmaOVHpPV
         /Oag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789528199; x=1790132999;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xo/F38+zAwDZOYgaXngSmzbr3sc8wNw9Tr/i8NiK348=;
        b=I3IsTAezZv6oiBMr1hdY1XRf5wv8piRFia+rdvKnJpei8F5kmnbT5Twvu5zadGlEIh
         NKfTGgBU8R+W22+tTAIJTdO1rrAAEqEcbaS62p9XU1cl5uVgnG2GeN7Bm/jiuay08L0G
         UhThfJbVGC+VHCnVISgJYM5mfHLzz8q5dFX30/rxtLgm6fQB8z11fne70Y85Q0L/kynq
         g56K6RxtM9yo/r02HvuhPxahkOFRhd9aV3KJXXUxvbMSy2L9toSit7xnYDvx+EEAqd/Q
         8WGy/UxcJQa1AV7MWv9m/MdtaH/AfrHG0xXO/M2B6uaVF0jtMX59FLYTnEOJQZOLAWou
         tqdA==
X-Forwarded-Encrypted: i=1; AKwUvBxcBb3wWShR+hyIfJFDGL9OQUiTaQUWTnEo0jGiW8k1az4a4P1BEXW/8rH2WCE2acKVhJdDYLw=@vger.kernel.org
X-Gm-Message-State: AFuF++kYCNIdE2ohecStrCmfWQ7URIOYf+xeIqAe2NhDb1UavtPXYvWz
	sAtJbdhIYlhMcJLmsO6tFxlSSW0wWzYU4UYnoS5EIbzB2UxH1wlNc39P
X-Gm-Gg: AYBFou0MB5ZWx9EDlmHGIvD3Sb+7lWa02lNMJtM9Z3+58C2Kt+Yophbpv7SvCnCXMdp
	DE2xiRknebdW+pKwUCd4vO8d1ZRqbQ53mNUG2SVPlFDZp6O2nTnJzBNu3C7o0Zg0mFN9C9wIwIH
	JMWnb3m0Zgrwc+pbzFx3GKF8WRzkTfHsV6hIl/GVGcHATz+MhVBCnG0Vdrbf22FZoN1K5vW2/pi
	Bk5jBeZTXh0Hq7XNnwnW8gD4rKkIDx0PYouUO3XI6M6lozGEEOcavcDKzMdgitCJZEWrOi5el/x
	RZ56zSXhCMLtYrU83gt8TdOFFmoKZ3L5Muy17LmNiF89v8fx/dHCo6JhU6X7elrnocS/G3qef0g
	bMeWxB+vSZSI6AWAE6TduLcIIffOXTbfJAyEJtLA5h0sDXvB0AKqNBT3eqpH1LaXhpswzAfcAXE
	trNLBGpC9dAT/EjtlMIT3tQZkBN7B9fpNKusc2p2I20zIwxP9I77ST6sWmDoa1gSUQSig7Ki2aN
	3B2NTvrTWinuCNuQarX4hDfVM8pybqOzzFsKGrWPaUnbZftdXqZ/INk87jS//avPloWrBWPABJk
	EQ==
X-Received: by 2002:a17:90b:2744:b0:398:ba56:b926 with SMTP id 98e67ed59e1d1-39e1e5770b9mr2371994a91.25.1789528198934;
        Tue, 15 Sep 2026 20:09:58 -0700 (PDT)
Received: from Inspiron-14-5420.. ([2402:e280:21c6:671:13da:4baf:148d:4ebb])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14397197dc8sm1984591c88.3.2026.09.15.20.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 20:09:58 -0700 (PDT)
From: "Hemendra M. Naik" <hemendranaik@gmail.com>
To: kuba@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	hemendranaik@gmail.com,
	horms@kernel.org,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	tahiliani@nitk.edu.in,
	vishy0777@gmail.com
Subject: Re: [PATCH net-next v5 3/3] net/sched: pie: correct tc_pie_xstats field documentation
Date: Wed, 16 Sep 2026 08:39:50 +0530
Message-Id: <20260916030950.6667-1-hemendranaik@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260904231758.4082471-1-kuba@kernel.org>
References: <20260904231758.4082471-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi @Jakub,

Thank you for the review. Replies are inline below.

> Should the vendored copy in tools/include/uapi/linux/pkt_sched.h be
> updated in the same patch? [...] So after this change the two in-tree
> copies of the same structure describe the same field with different
> units. [...] Would a resync of tools/include/uapi/linux/pkt_sched.h,
> or at least of the tc_pie_xstats comments, be appropriate so the stale
> documentation the commit message aims to eliminate is actually gone
> from the tree?

We would prefer to leave this out of v6. The v4 review asked us to drop
that, and we did; adding it back now would undo that. The copy is
stale well beyond this one comment (u32 prob, no dq_rate_estimating, no
FQ-PIE additions at all), so fixing a single unit comment there would
not help much. A proper resync feels like its own patch.

> This isn't a bug introduced by this patch, but does the exported value
> always match the newly documented microsecond unit? [...] a qdelay
> whose nanosecond value exceeds 2^32-1 (roughly 4.295 s) wraps modulo
> 2^32 ns and then gets divided, reporting a small microsecond number
> for a large delay. [...] Would moving the cast after the division in
> both sch_pie.c and sch_fq_pie.c be worth a follow-up, so the code
> matches the microsecond contract this comment now states?

Thank you for catching this; the bug is real, and you already flagged
the same issue for sch_fq_pie.c on patch 1 — we will fix it there with
div_u64(). No code change is needed for this patch itself; it is 
comment-only and correct as posted. We will send the sch_pie.c fix as 
a follow-up after this series.




One more query: I see that the counterpart iproute2 v5 patches are currently
marked as "Awaiting Upstream". In that case, is it necessary to post a v6 of 
the iproute2 series, or can we wait for the v5 patch to be reviewed?



Thanks,
Hemendra


