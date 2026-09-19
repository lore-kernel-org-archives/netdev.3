Received: from mail-pz2-f27.google.com (mail-pz2-f27.google.com [74.125.228.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8E5327BEC
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 23:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789859081; cv=none; b=RlBuTMFlERnUv3BYXow9aUTJS6SFqQQqkxMM53ZdPqTiZP0tvGLyg9/VRT5xzN1ImllA8Bg7aF/Rap80gOg6CHw+K9kWbNsKPHQZ3+npftbj1r4kOBcLkHCBss8GZy318prhGaJ+9Alig53D7k8JRVUge/4zPautNTsYsFhkevk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789859081; c=relaxed/simple;
	bh=6KNhT31o5zRZlBikaD83+Uhw1ackzuUh5nI4RX6iEm0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jbmm5m58byxcQRkD6t0j/l08qh7booachtAY9YiUGnSg2lUuPLuLmCpw1VHV1hCOq2VtY2M8lmfd5+W65nDLvRmDScRsSu4TtULlnBC6zBLFZDhFqQfgWlrZsOm2+pesAuAviTnX9OUupitzCu1hBhqRy5vAexjsFeupaHUhWFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=bgxa0EXC; arc=none smtp.client-ip=74.125.228.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="bgxa0EXC"
Received: by mail-pz2-f27.google.com with SMTP id 41be03b00d2f7-cc1cea50dc3so1262946a12.3
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 16:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1789859079; x=1790463879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vOgQMCXk7YRJ+fy9ep1+G1HisvU5nbN7UnWeqV3aj6k=;
        b=bgxa0EXCrnPs951IJu4Oxuh+fnByZb3tWvqQdTyyFSI2bYA3cGpMds48I5eczvPvux
         qUvchHQnm3Qu6gVCl6C0kjv7JXcqawVc+/RBR/+j+xHyThgvvwHedSTPLcnTtk6/CRyL
         mOM1zoOA2FBac/BhQQbR3Fs9ZgDjVQid6VcxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789859079; x=1790463879;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vOgQMCXk7YRJ+fy9ep1+G1HisvU5nbN7UnWeqV3aj6k=;
        b=sF3Yoq+2piFFGNE05KwcXbcGShSBmfRlxVGlJ/FftNMsN9Ki2qZTaj0Os1Tsiuapr3
         udInEq/BE4ggcQHd6t3wtLxOvzfoIcPMdb6lYO5w68ILbHsaoQtZaKMWOV6iqIjv3J1H
         dWwjmvoFruOATGkT5eaSgrtFuiBc/sLySaG6gGV0CGM3nOZFywEMn55mLaPJTZD8eRek
         dhWoyZih17bKL+BxbZmnNjJr0uJ2IWN2dxVfBHsRcqRORs+wz+qqkYUhFUhDXvOxpq6L
         KlBvVOzKm7npU4TkGhrVYCeRb2YwEpkY7crRehuw/iqgtWTI7gtiEpXfPwDNtFhH365L
         4nSg==
X-Forwarded-Encrypted: i=1; AKwUvBx4nVVzIfUAH+plhiOZqd0KG0oBDzw2f6r4ljSwDxi5z9L5JrKRsCU85IsExjwR9Bofi6PrfWg=@vger.kernel.org
X-Gm-Message-State: AFuF++mzMRBbgZErZgnLMiiTas3J+01qIOBCwvl5KqymZQLtwn+/l5SY
	ZLwIi4VtIqUv0QMBSNuXufOSkhn20Ti2LMv0r9dMfLRBVSRkmrwzmJ9d2/XrCXGMLA==
X-Gm-Gg: AYBFou0rHbXpm49ROhvPy4V6bnRF7TtdYWgu8d1iRQEW0XA0GLwEUOGjpwo5h/4Q+Nj
	L/znBPD/8rgmjdDqHUHQmYmKsGtR0C9NXEbZkLcAMJXJ6uTePjUjZtcLi3dl8FwKXUtWgDNEm3N
	LRsfOXNeu47MAx+dgdj2YHctmrbyA4kDciXhqtFWAgBuun3CPqDsf6UThHlHoV+AZaUNluBLKR8
	/VqQhpPi/tQuCXOQWSNLZJ2sv/3yvZZU6C1TLgaGtrM+92+OSHIxecW+q1MggXANnk5YVAemfqG
	x+kqyV4OL1OcxDbwBE4PHttzY0h3Vi9FCcbYuCA89ZrSBnwwRgumftbN0JNMfh44ItzSOfozPoC
	2v+KgsIU5JhKlTr1oLbRdVLaLZT98rSmreEITLSkQGw14OYMRlgaoiOZ5jQAWv7PYqxb9NfcDJn
	xHhrUgKiyrsHqf4DbacSqLfe8jl85UE9Vde+WxXAlC3mrlEbGcRw6v24iIduBPRNPnllxGBQq3J
	NCtdMIT13RCTAM=
X-Received: by 2002:a17:90b:4fcf:b0:39e:6a7e:ee17 with SMTP id 98e67ed59e1d1-39e6a7eef23mr5369344a91.35.1789859079497;
        Sat, 19 Sep 2026 16:04:39 -0700 (PDT)
Received: from exu-caveira.tail33bf8.ts.net ([2804:14d:5c54:4d67::2000])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144d55aaf1csm8804599c88.3.2026.09.19.16.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 16:04:38 -0700 (PDT)
From: Victor Nogueira <victor@mojatatu.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	netdev@vger.kernel.org
Cc: horms@kernel.org,
	hybris@mojatatu.ai,
	sashiko-bot@kernel.org
Subject: [PATCH net-next 0/3] net/sched: complete action notification accounting
Date: Sat, 19 Sep 2026 20:04:26 -0300
Message-ID: <QDISC-RYTB.v1.20260918093205@mojatatu.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The action notification paths size their skb from each action's
get_fill_size() callback, but three gaps remain: one callback undercounts
(TCA_MIRRED_BLOCKID), five actions have no callback at all, and the
TCA_ROOT_EXT_WARN_MSG attribute is unbudgeted.

Patch 1 fixes the mirred callback for TCA_MIRRED_BLOCKID.
Patch 2 adds get_fill_size() to act_simple, act_mpls, act_nat, act_skbmod
and act_connmark, the five actions that still lack one.
Patch 3 budgets TCA_ROOT_EXT_WARN_MSG.

Victor Nogueira (3):
  net/sched: act_mirred: account for TCA_MIRRED_BLOCKID in get_fill_size
  net/sched: add get_fill_size() to the five actions that lack one
  net/sched: act_api: budget TCA_ROOT_EXT_WARN_MSG in notify skbs

 net/sched/act_api.c      | 15 +++++++++++++--
 net/sched/act_connmark.c |  6 ++++++
 net/sched/act_mirred.c   |  3 ++- 
 net/sched/act_mpls.c     | 11 +++++++++++
 net/sched/act_nat.c      |  6 ++++++
 net/sched/act_simple.c   |  7 +++++++
 net/sched/act_skbmod.c   |  9 +++++++++
 7 files changed, 54 insertions(+), 3 deletions(-) 

-- 
2.43.0

