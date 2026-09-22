Received: from mail-pz2-f11.google.com (mail-pz2-f11.google.com [74.125.228.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12A8517BCA
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 20:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790109861; cv=none; b=l1XmvzKUHodaKZeKkG4laYTZcUqvotbSgK2vOfxoJlcLkf0g/4Ax2ziM7O6IFj+uKXJTsOeDWpaJHoQ1v8vfcKGGXIxO4Sg6FRe1h8PAn0dTb8nP5AbI2FAYyhyzyqRk56YVAJheERAV7Nz2mXzyRi4/5FeRW2mqbPKGS1YMtcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790109861; c=relaxed/simple;
	bh=CvPWprNtj2/h7qYd3ZKQiVW+cdulTxr3CaN7at07Ro4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qydcf8T5HOsZyK4+b3TPA/yqBpM0o6QFsBasJ/dIsKoRVpWct8yXp2b3kc5YJhhfaD36zlWNMlRQN9JuolUEXiZGN67LLq1feIF/34+76k635W4JXAtbMX9S485ohPSIHkm52jUjE4OZ0DNSLDJBSM2ZEpZlj9M3gtjAjpJ/82I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bAANVfL+; arc=none smtp.client-ip=74.125.228.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAANVfL+"
Received: by mail-pz2-f11.google.com with SMTP id 41be03b00d2f7-cc1c2963c92so109110a12.0
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 13:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790109830; x=1790714630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gMpSTn93NNFEOpIjn813NWg6HwKgpaeEXImngFElSS8=;
        b=bAANVfL+RXtqnSbOnA2QMuo0fAQDAC98/9wUjefyttPpqXsPVWmh7OjlESXRXHbokY
         I8yfmpKqZnzJV7PssTgmWGNkG9LLhYXhfR+eFoGwG62IzdfM0sagVP+Hj39tHQNL1BFQ
         rkG2Eg+cyKQzwzJQQ9HMvdsO5fIV5sDRxz81j8irJgAhwx4fA5QNAfhm2gziWf/MjZlP
         Cz3YNLcFYRjRxKnH2B+Op6WWqZEwpl+6NUD0D5EGd+Mr1VZffwMnYIdSV98APmPoXhyN
         6s4erbfPcI8H4O8/pK4Bcweb6bM9Wf8RJUVQUa1gdi09otXZaH+GwP2UjXNWgd6JDEoA
         2yCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790109830; x=1790714630;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gMpSTn93NNFEOpIjn813NWg6HwKgpaeEXImngFElSS8=;
        b=2PSVIxMENzjxlk4cVkuOzVlvvNQmf+E4r0ggl5n11Mn4Yx+K5q9CkWOYmqcHZo2cwo
         PlEhFO7imCmbBbP6L3xok5aduSbtHwlf656V555nqQy8KAF54dmmXBwzFiy0Kr/K/k30
         AcCNO0tv1QduDFM1DxdJXaMJSdNyfZFKrEiUDBFqB0OSrAVGNCIYwPK+xx5YpnHR9Xf5
         iHKULL42Vg4uxTipdTl/0r5rngFpSajVDk4Yorq0Ws5Nzf3QMAusHrmZoeuOU3q6z5p6
         dVebQqgdWLONX6dxP/0RO7C5e9K1ikXG8OecM6LfSVeTYLl+Nh1tp9lyPYfGZwjvfUNO
         6NSw==
X-Gm-Message-State: AFuF++kDfnCpI8TXbKzF1urefZsqppDvsz2kA+D6kCanx218bZ4RibkA
	ztDW6nE+Fa5yvBsainRk4+E3jHV6iZ3QntlXLJRdbKL9OYi0X5prAhG+guFuVca7
X-Gm-Gg: AYBFou1ZT4p1Hc8vqBsK43g2DajeHpZzVzlHN3AtTv3P5TrexZo8ibwbRZq5q1hF+gb
	o0TIui11S05GdjYAte4ORXNyN0HBWzmPT8HIb5kUibYd2qiau/UD1rKHzViOaBhNGUre5AIjlVE
	IfEaqidyFi3qjFVv7ZnfVwn/kUQzIEwizDKGKxVNelWENV8xZNfSrHO84NTeTjiybUIKxXFMv0Y
	NWCuhtIEYYe/IJI3b2R14JbAaVx2Q9Rojpo22bxO7jEo+T442YjZbDQI6mdvArdpG4QqwPs+POP
	V7UIlpn4pp/HhETh3V9Hon3CKT1cvlDNTj4tAGT/tzyfvadvrRijAB5iQoxtViyJbUAHuN3MlJC
	yb5N1DC3uGmGPfVexH0BQJyJSzsTpFWI8DF87sy2LkTEkhxRkOVsuqbnwSh1tg/xzmudI73JAe8
	G/IASjw5gSvg8W4uttlLmnVgAxUmrVtI7FOE2E9CgkDLX5/PDYbugZ4W7KGiQn2nU=
X-Received: by 2002:a05:6a00:854:b0:87c:9094:b72f with SMTP id d2e1a72fcca58-87d1a7af70bmr703595b3a.12.1790109829787;
        Tue, 22 Sep 2026 13:43:49 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:8::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87d1d4c483asm289145b3a.21.2026.09.22.13.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 13:43:49 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	asml.silence@gmail.com,
	axboe@kernel.dk,
	sdf@fomichev.me,
	bobbyeshleman@meta.com,
	almasrymina@google.com,
	kaiyuanz@google.com,
	linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org
Subject: [PATCH net-next 0/3] net: consolidate net_iov freelist and DMA handling
Date: Tue, 22 Sep 2026 13:43:45 -0700
Message-ID: <20260922204348.717198-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Follow up on the recently merged devmem gen_pool removal by consolidating
the remaining net_iov freelist and DMA-address handling.

- move shared freelist state and operations into net_iov_area
- switch devmem to public memory-provider helpers and reject DMA
  addresses that cannot be represented
- decode stored DMA addresses for TX on 32-bit systems with 64-bit
  dma_addr_t

Stanislav Fomichev (3):
  net: netmem: add net_iov_area freelist helpers
  net: devmem: use memory provider helpers for net_iovs
  net: devmem: decode DMA addresses for TX

 include/linux/skbuff.h          |  7 ++-
 include/net/netmem.h            | 55 ++++++++++++++++++++++-
 include/net/page_pool/helpers.h | 10 +----
 io_uring/zcrx.c                 | 25 ++++-------
 io_uring/zcrx.h                 |  4 --
 net/core/devmem.c               | 77 +++++++++++++++------------------
 net/core/devmem.h               |  7 ++-
 net/core/page_pool_priv.h       | 14 +-----
 8 files changed, 108 insertions(+), 91 deletions(-)

-- 
2.53.0-Meta

