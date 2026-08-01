Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86E837A856
	for <netdev@vger.kernel.org>; Sat,  1 Aug 2026 10:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785580006; cv=none; b=I8xCAeGdG7m0PSTjTw00GGmnv2N0bihtioNbTIXiSfKI6kwIy4DYqAKJHcZ4mJtZP9cjNCtqLmsTCdTFC2izuoqSk42+7keyrvef4UTY2fLVdPvi0jrttq3oeFK2JQLzYPbaPyn2mmTKkknBqaqv3EkirRGzY9HvNOAEH2h04qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785580006; c=relaxed/simple;
	bh=Zwc86HUtruMG/EmLSrSa+RpCw92UAOseOeQ8S/PILIo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ws0R5TxJczU4rMXf6ZVmOi0mfdgpJmHp0oKvdKudiy6/scguqHIROAvudRhRX+pJtX2fJt5YqXbaDvKXu6sPdT7N22mHFrgDmYC/VcaeB/d1wf6hE6xk0DsS1+8JMAlgiLTGVTvfksKvNOt+mV/z2C9cqmnneBsarWuhcDmNWw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SUQkvjJF; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUQkvjJF"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84830c774a0so1860390b3a.1
        for <netdev@vger.kernel.org>; Sat, 01 Aug 2026 03:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785580004; x=1786184804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=loteGSmf6bFZ3Hf8K/Dm/4Iq7ljKU7ceZ3pBEFBprz4=;
        b=SUQkvjJFqCXD9tXAOjgkk/NpkBzbJ+uhGzhebIE+nFMOPYJKTR4zQ184dtdTQHHrCB
         hMpOxOsDuihQ5lUUIpcvulgbt/o+DHqnBdkV7/w1US38ivyrj5/n/qwdC94smNV3ysEY
         qHM9fYj4XkJILIlt4v/SkA/HP1r4RX5qBAUbmVwUdMTS9qne4ZjazLmRkrO4EPB+8uCd
         5mtqNLjQZ5Oh82x1nVUDiawScqSVWgkDFupbuu9i/yOKLzTSr+f4OL+xcfV4/J1SXhaf
         Gs1sKNlH3omYRIBouRzfB4WOCAA3eN3GU5Uf/IuUy6id4xXtkYR9d2wnXH73vkpciq9X
         y7oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785580004; x=1786184804;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=loteGSmf6bFZ3Hf8K/Dm/4Iq7ljKU7ceZ3pBEFBprz4=;
        b=nKXvjPuA+HA16Xhkbexufx9GjOScyS8e8qzuMsVFypQLQ8wY1Jl/f8YmiLF4shaZio
         8dzYcBS+Xb5C7OurM8szxqQv35JXwrrL7eeXV3LqXOxRFUyE0FDEIC/CY+e3nnREC4Dw
         ZBPtOmQMZlENgpXm6qfvOzHoMGUqpn1Pzskjo6k7PyqndOCplsUuPEaZK+EMsDl4pEYg
         u04LKWM39ISWZI5GwddYsDSfZwmoVyEqoVdSou0CEpVGFMbm+Uat8PQWQ9mX14zxUTTh
         yruermGpm5NxDDTdabxoB/ZQ1XxRrYZzhfPoSaEAFIE6TrkDIUA4VVV6BnT/gjFw/vEK
         hggg==
X-Forwarded-Encrypted: i=1; AHgh+RoBwSbMVPzSWfUubKbDtMIRFGoJ6Ee2D0iDGvrR2AM8P3IPJI0YYyYn2lloYXaFlKM/bmctdlY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6SliaG2PnXHmYkcuBa1xytMLCUsw/hfJNwMi764LHEMCeS2UC
	12GNDz6b73oLGNSQrA5fD3I96/S0z26cg5SzIgp3irk3YgZE8JaXb3sB
X-Gm-Gg: AR+sD10q+VS958gAOFV9Yxsn/umtlszEjGIeAkuIHdxn+GSntMllReTp7NnWdr5ESla
	OodzleM9CPMe/wD+3SG+XwXGMP94b08sGfNAhTzhvdUpi6NQcTYOiH6vIilEUq2cV3tRpZIrF0p
	H2xxxQxQmhLfXZLaGCxPKM7BpNmmL8eRbBELkg32/JVVYypgWjo+879FEh4yOUHRvvu9zhQtPKr
	0qo0RYza5JE2ARXo9Po8reYPgZNCP7bdmxa4cf2jtbk5P/OG9ysVdzJx7EPknueO5mVRofnEhae
	FQg1s8DFMuQR4eQeg4jCQ/rSNiu1Av3OKHqXcEa1dIWgwpqFW6sDfr2eBIitsMilJsYo+7rgzgm
	VFvLVa3Fg7xdCI1GcZhaCyIyIhWirITlDg+aHNiidNLXZFRvoLo3fMYTE7vDqJaSrVuWsXfL0Nu
	5ox2igrqdCdMFP7O+Ivo5SzulmBwheOWbMlma4LfFF/kKGP/6Sviih6lm+7ZDDykc6Cw==
X-Received: by 2002:a05:6a00:8d1:b0:847:9c06:2bef with SMTP id d2e1a72fcca58-84ee47f2c8fmr2410929b3a.29.1785580004050;
        Sat, 01 Aug 2026 03:26:44 -0700 (PDT)
Received: from omen-arch ([147.46.174.207])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edc51cca2sm1526886b3a.61.2026.08.01.03.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 03:26:43 -0700 (PDT)
From: Junseo Lim <zirajs7@gmail.com>
To: John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Sechang Lim <rhkrqnwk98@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Junseo Lim <zirajs7@gmail.com>
Subject: [PATCH bpf v2 0/2] bpf, sockmap: fix forward allocation accounting in strparser self-pass path
Date: Sat,  1 Aug 2026 19:26:31 +0900
Message-ID: <20260801102633.1872012-1-zirajs7@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The strparser SK_PASS path can queue cloned skbs back to the same socket.
When one TCP receive skb is split into many strparser messages, repeated
receive-owner transitions can leave sk_forward_alloc in deficit before
the next skb_set_owner_r() charge. Teardown can then uncharge more memcg
pages than were reserved and trigger a page_counter underflow warning.

Fix this by settling any existing sk_forward_alloc deficit with
sk_rmem_schedule(sk, skb, 0) before skb_set_owner_r() for strparser
self-pass skbs. The same handling is used when retrying from the psock
backlog.

Patch 2 adds a sockmap_strp selftest using a one-byte stream parser and
an SK_PASS verdict program. The test checks INET_DIAG_MEMINFO to verify
that sk_forward_alloc does not go negative after exercising the self-pass
delivery path.

Changelog:
v1 -> v2:
- Keep skb_set_owner_r() and use sk_rmem_schedule(sk, skb, 0) to settle
  sk_forward_alloc instead of skipping the owner transition.
  (Emil Tsalapatis)
- Apply the same handling to psock backlog retries.
- Add a sockmap_strp selftest based on the reproducer.
- Add a Reported-by tag.
- Change the Fixes tag to point to the commit that introduced the issue.

v1: https://lore.kernel.org/bpf/20260723065244.186916-1-zirajs7@gmail.com/T/

Junseo Lim (2):
  bpf, sockmap: settle sk_forward_alloc for strparser SK_PASS
  selftests/bpf: Cover strparser self-pass forward allocation

 net/core/skmsg.c                              |  33 ++--
 .../selftests/bpf/prog_tests/sockmap_strp.c   | 171 ++++++++++++++++++
 .../selftests/bpf/progs/test_sockmap_strp.c   |   6 +
 3 files changed, 199 insertions(+), 11 deletions(-)

-- 
2.55.0

