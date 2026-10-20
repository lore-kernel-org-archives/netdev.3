Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792491923;
	b=nEly4dyyzxDjSQ813CMr3bl1gbJGC4MeaTuAfSiM9fWHDh1C2L+yT+N6y7wmiBtxH4Yr
	 yfwcn+xwahJIfKIgoQpNdzQE9H5FZ63krmJF0buzHHXOaScA8VWtgpN3pQcmuT4hpMwXp
	 MyySVFvbGVVuGBsilK3XGUNFzKgB1/7vBQ1YyXCID0h/jscki9GosO6JBnEdX+LJM7ymF
	 kFH7A7GHKj71fdtFuCpFvOJI6rtL3ETmVDk2Y75P7zHG+vVRGg8WBby4+oULxU98QFhjJ
	 RWW0b6Stc2NxGJP2+LkYqpJoYghsrbS2AQtb6jazJihjTVxgTfan95DnLYyrSkyIREQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792491923;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NeXzTwoaQQsPfza4T2NcSCi4eYTRjgEtdtZmqGwt2Jc=;
	b=JywP/p4uc/vPaSYXIXrt2PhouVUHCecknHIHzuTbpkkHKTsZWJ48kOCpJp3kny7Y1GxP
	 vFoqj2oOltrP1s4BHrxlkfNHuPmGewpQhaKl0/51ZrTZJibwU38wf+twdmFtDkLbXA/bu
	 QoW2Ld+NFFqvBGxRAlV3Ew3e8KBFuhJXcjWpaldWRYnEEC+JFCjimRDjDw8/S9WYdZOUL
	 VeNdbCHGx+BqYLlElDD+nNNFVr/WLAkHMFXkm1I/fAS5d2IqoXzCnkRyZ5o6JicBkw2/7
	 a20U8gdLaSxwwJLAg/cGb4xI2cZ1zK3mgiAxnVqQRdT4UfoNHt0OrpKfEkEJK4a25Wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hgzCAqZI;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7BB606A31B
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 10:25:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A7BB606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hgzCAqZI
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a1d293b293so17556305e9.2
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 03:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792491922; x=1793096722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NeXzTwoaQQsPfza4T2NcSCi4eYTRjgEtdtZmqGwt2Jc=;
        b=hgzCAqZIJGESdXYWWGcjsj1KblLotcZdKXwuiV3LomaQCXNTnkafzqR1LT1mS6Y7fY
         D88Hat3EUlSgnlKepZFEH/T1/Li7EPJT8SOaX6xEOCffujYSXgSfetvrkI70izHAhArF
         blf+2HnLqeZXb+nL2nEHQu1YRhcswiXNJxGlIL8a07Ys0oTJeW5w7eFW5uutNDYTD4Pq
         NUGgNdI1aXqAlxkhkzPCpY7H/1laasN7FXjAyTXitHHE7ufsylYzCuCfwSvTWn6VoqQt
         SRj4oYwKtdVuCu2wVe8Grfyt08aVcOMidxOT8/v+asobMPgrvJEm/yQxFEAaohDA1M49
         OwyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792491922; x=1793096722;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NeXzTwoaQQsPfza4T2NcSCi4eYTRjgEtdtZmqGwt2Jc=;
        b=nxNaiRsgamKgLwXORSbkT40zTzTdAVIW1/Abfbai0fXfM7cUZnV9AJeEK+ROl0hw+C
         L3utBXuYOYPTCEh4RD/6BSv/eTxuzXs12cJSqlimI+7HSpJHLDEA29sVZRcE8v7f57gi
         1NPRBYzFh17GcA1qon4jVDTF3SH7tRnemiPvqBKUwNObU98q7ebJwhHnb2xWu2uyA3dN
         WeuXWBvi+zHuDnTP+XVfyCXm1DaZyoV94kjE941ph/LWcasFVceYYUZn8JHzieCddrKX
         cQ3eCT+UXo633eBt5dGE1tzC+oJU+VcOHBCkLdmeDHiJsDWaz7Z4EhYuf0ajuAe8hUfq
         Fbxg==
X-Forwarded-Encrypted: i=1; AKwUvBwLbRa1Hm4WaR4ohaPi22o2XdUBBxyn0Xr3GrxmgNB4zbhUk5YKubkvHNRf9G4awlsqDKHWook=@vger.kernel.org
X-Gm-Message-State: AFq9FYIMffUZ00wkDvu7MHgXLWntFyFhlCmyruEd41ZC/R74IotFtOTD
	tiuLqwyToD141r7n2l4rL+EkRqRDQYYh/afkRTEVj14IKJTtIAijs8wu
X-Gm-Gg: AYBFou0U6/mgqe+l60EuD52eBp2zz4EQOEc3oOlfhRfTJuhJi2oAjDyJcAW8tK6ytGz
	Kzb0LVSJdEV9fwn8IiwrT0kru6GdiWJQrrfsGpmz2VrYu/bKp16Jv4nfROTNUZEE81nx4N/KfMc
	HlUtrEVibkqsJo1fLaunfmUiYyf7pA6+hCxh9oA9OgT2QaUDuhx7wEwSt3GFxOftTKgxm0D5JTd
	UjQmYobWqkwkB3uLViMShVRDYss6o15igOfMzAIfsPjSRidltcxI8uoZjM6tAqBZgtOO/ly88KY
	G/BYdEDZSIeKu7wWm6iLvjqpuPQKtEab408nZnclGBva5TbSF/Uj2jRyq9MxQqMbBJilm/5G1L3
	Ycpt8j9binnqlP7/mM0quYOqcuZZGsws+NcphW5Wj8M5BeiQIVfiUmnIKvShPBE0FZtFppwOkiq
	LLR4v14yOO9VpBEGBUL8HcwxVTIiGiKchwe7fGnpNOOeN+h7zz7avOs4diPgpq+XGE2CgdfCmVr
	uP6xylv8cCK7nmC4dFvFPfOxW5wz9wCKImgs5xtHkOOXg==
X-Received: by 2002:a05:600c:b86:b0:4a1:d459:db4b with SMTP id 5b1f17b1804b1-4a1d7610722mr208729645e9.24.1792491921643;
        Tue, 20 Oct 2026 03:25:21 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4a1f69d9b1esm37544825e9.7.2026.10.20.03.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 03:25:21 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	willemb@google.com,
	eddyz87@gmail.com,
	edumazet@google.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	horms@kernel.org,
	liamwisehart@meta.com,
	martin.lau@linux.dev,
	pabeni@redhat.com,
	song@kernel.org,
	netdev@vger.kernel.org,
	sdf.kernel@gmail.com,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	kuniyu@google.com,
	memxor@gmail.com,
	emil@etsalapatis.com,
	almagui@kernel.org,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next 0/8] bpf: Expand ksock send-path support
Date: Tue, 20 Oct 2026 10:25:04 +0000
Message-ID: <20261020102512.518479-1-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.43.0
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

This patch series improves the bpf_ksock infrastructure in line with the
work proposed during Prague Plumbers 2026 presentation[^1]:
* refine the LSM verifier filter
* allow bpf_ksock_connect() to be called in the send path
* add bpf_ksock_sendto() kfunc to complement to bpf_ksock_send()

This is useful when using ksock to reply to differents peers while
reusing the same UDP socket and generally works toward the goal of ksock
to support the basic socket operations.

[^1]: https://lpc.events/event/20/contributions/2430/

Mahe Tardy (8):
  bpf: improve ksock_kfunc_set LSM recursion filter
  selftests/bpf: Test allowed bpf_ksock operations at send LSM attach
  bpf: move ksock_connect() out of init kfunc set
  selftests/bpf: Test verifier filter for ksock connect on LSM attach
  selftests/bpf: Test ksock connect/send combinations
  bpf: add bpf_ksock_sendto() kfunc
  selftests/bpf: Test forbidden bpf_ksock_sendto() LSM attach
  selftests/bpf: Test ksock sendto()

 net/core/bpf_ksock.c                          | 129 +++++++++++++-----
 .../testing/selftests/bpf/prog_tests/ksock.c  |  53 +++++--
 .../selftests/bpf/prog_tests/ksock_sendto.c   | 108 +++++++++++++++
 .../selftests/bpf/progs/ksock_common.h        |   2 +
 tools/testing/selftests/bpf/progs/ksock_lsm.c |  32 +++--
 .../selftests/bpf/progs/ksock_lsm_verifier.c  |  98 ++++++++++++-
 .../selftests/bpf/progs/ksock_sendto.c        |  59 ++++++++
 7 files changed, 432 insertions(+), 49 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/ksock_sendto.c
 create mode 100644 tools/testing/selftests/bpf/progs/ksock_sendto.c

--
2.43.0

