Received: from mail-pz2-f28.google.com (mail-pz2-f28.google.com [74.125.228.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8880C412266
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 20:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790109049; cv=none; b=dyEwecn5/omKj8Xvk8C8sz1yq2YCXKdG24n15DkzBVNVWeBWaK3uIVVs0lDTA2/t+vz4A2jsiM5Sk3xtTYdk/g05T1rfAlnUWhskAHvDG6n8+6WMUNpj7pxR2JAh+l+BUjC92QppVnyRpafFHe6Z0p+73j88OdOOmcWMX2+yIKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790109049; c=relaxed/simple;
	bh=NXHr06+m8fKcBbVdqgzfwCvwksgvw1yhgxhdVlQe4EI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=opxdTmLuDtKjRr9TBQdSr5DOOy4BrRMvxAHj+6cps9pVEgBV03gmK/GO+gxZ/9n/xwiGEVmZLRnKPIjBU62Dx58L4nkZgWasbZnwysVD7HmOz95+K0+QD/779jDrxNUwvLoTmCB3xFzNCapLZ+WYcCJzL0yiou5rUzFBtSAqXoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZkRISFFi; arc=none smtp.client-ip=74.125.228.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZkRISFFi"
Received: by mail-pz2-f28.google.com with SMTP id 41be03b00d2f7-cc745abb731so211434a12.2
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 13:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790109041; x=1790713841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NXHr06+m8fKcBbVdqgzfwCvwksgvw1yhgxhdVlQe4EI=;
        b=ZkRISFFisvHM4Y8fMfyPRZdt+bu4x0Uy0DTV3VakD8p4It9qPmejlYBxBECvqNjmLg
         tZug0tqDLq/Q+hyjv9hCmEimnv0wV7UWah76YAIi/MzSpeWjJRUxgL/hIetNwFRrPl5S
         SfALGyc5XhZwwpK95rI+g0OEZ91UGAvuBYtBObF6kTicFJk0Jyq6pkuYwmQVte4917Rf
         9jfKZblDbUQ0Q1ZXkC4wVCHBA/v5K48Cah2Mn7MAVvaBJ7m8ud7/IvIQY0TTeoI/zmVx
         SmE2gOK+66uZqHpaYerp4yJ4SWbtKj1REuYUBaS9AoLWjQ+YM3U4yLDt3PNqP/S8YSz1
         Ni6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790109041; x=1790713841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NXHr06+m8fKcBbVdqgzfwCvwksgvw1yhgxhdVlQe4EI=;
        b=syplu/z2PcRR8l3eFOjCW03bD5RUqjK1zP6UZHZkea+pk60J8x170u7hWsO1Obyl7s
         zXPBLKa+CvSCHGCFcntGY9Nvy6ZDUVfwINjYLtjwVMEJlYArZyTI8RefWgwd1Uk3084s
         eixfx3jgaw/VEfJGdppgZus0EpXZPAYHGmNvwIanQJOp2mtq0IWCdAS47aS2pFVZScJN
         6vrdEYK7Hcs0FMr0JzJVVMZ1PTknCm1v5t+cDOJ54FX1h1paXO25Xo2G9vQcq2HkWXOm
         B4YJ1Dha1B3Qe0k6SHbOAsQGE1GNNcbr4dUJa8GXES5XxO+1wfvrlDAqhssA1ghnwYw8
         UQgA==
X-Forwarded-Encrypted: i=1; AKwUvBxbAUaATQX6iOJ/u54Q6+ERRgXCX34LVtGCrwkonIoXms3pJKMpjGiLIoD5sgzNGTGiuBcm/vo=@vger.kernel.org
X-Gm-Message-State: AFuF++mV2fxGyJlU+LknRuJzpcMxuwTxqE6YXIX3oX2R8df4UJ48fRQo
	8mfwSq9QZLcMBU06ChsdWuM2+hWRbG3SWNFFrgMNF3r2+BKaZHt2au1x
X-Gm-Gg: AYBFou3cfCFWiU+38lkslQpuKZmz8PlGIupl9e1Wvu5cCsqFygCahQDB5PWcpw74W0d
	vVu4IwjzsbUKEBwvTQv+mZZmYg2H/cDaPX62NqwpVxVQ2DIsOSBTqYcWp78VEF4JKNu+Img1SBT
	dclO6fXc7nMfyl0SBEhKd4w5DvN44CrUnTh8i9vBBRy9g4Jl0LtbiHUls+3B4DGaJ/Vs0zHsSPe
	ajNaaVx7lHJXx5EFADJvcp8xuhDEuhfBCTgaBA7qsZqPlqCk8icCMRe3K0qdFD0dVFjGaEkdDOf
	YIizEnf+z+LnpJQe6pstmMjmjt8bQ/08ktC273vGGcwx5Qnb5WZ+S19p+aZq61mkoQhOpkPA7sN
	wdrAvUq9sw8NSD24tojAbAYriFT2dULgDslA8L+x9e1V+6wMu0PMk8pjhx/PoTVQW2hb4TIFaor
	xjh5dubzr1Irht8NRBoSrZ9UR65TVVnKWjCPCH+XK0sN39CUDQpeufULdVHa1UuGSJAWSPikl3s
	Uz/jimL4hNcE2nSuO5aWfKo6opyf3O6tO8FZQutJnfs13ElH0z8I01KQXsCZvGi21XP6iM5p5qe
X-Received: by 2002:a17:90b:164c:b0:39d:e9b6:cec9 with SMTP id 98e67ed59e1d1-3a07e4f35d7mr512229a91.7.1790109041020;
        Tue, 22 Sep 2026 13:30:41 -0700 (PDT)
Received: from Inspiron-14-5420.. ([2402:e280:21c6:671:f16e:2102:25ad:9cdb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a07dc5f3d7sm1046121a91.16.2026.09.22.13.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 13:30:40 -0700 (PDT)
From: "Hemendra M. Naik" <hemendranaik@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	hemendranaik@gmail.com,
	horms@kernel.org,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	tahiliani@nitk.edu.in,
	vishy0777@gmail.com
Subject: Re: [PATCH net-next v6 3/3] net/sched: pie: correct tc_pie_xstats field documentation
Date: Wed, 23 Sep 2026 02:00:32 +0530
Message-Id: <20260922203032.26774-1-hemendranaik@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <179002341024.2160803.17066887333412185241@kernel.org>
References: <179002341024.2160803.17066887333412185241@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thank you for the review. Replies are inline below.

> Is the microsecond description accurate for all values the kernel can
> report here? pie_dump_stats() [...] truncates the nanosecond value to
> u32 before dividing [...] a qdelay above roughly 4.295 s wraps modulo
> 2^32 ns [...] Would it make sense to convert sch_pie.c to div_u64() in
> the same series so the two ABI producers agree with the comment being
> added here?

Agreed, this wrap is real, and microseconds is the correct unit
pie_dump_stats() is supposed to produce. But this patch is meant to be
comment-only. We'd rather fix pie_dump_stats() with div_u64() in its own
separate series right after this series, instead of mixing such a fix into
this series on fq_pie.

> Does the bytes/second wording hold on 32-bit kernels? pie_dump_stats()
> does the scaling without widening [...] On ILP32 both operands stay
> 32-bit, so the product wraps once avg_dq_rate exceeds [...] roughly
> 16.8 MB/s. [...] Could the same (u64) cast be added to
> pie_dump_stats()?

Same answer as above: this is a real bug too, and we'll fix it in a
separate follow-up series.

