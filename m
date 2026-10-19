Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792443971;
	b=FfmxXLWQLktNOGVgue4a/e6lEZ27fo3p6AaFiKllm/UhGyQjcyfikBQi0TQCAY5H7+2+
	 DV5UgctFlaVQGBRKEFU6gYbAc1xcWLxguKhvGinZZc9GpSm3ARQd8iJVafoGxxClbKeLG
	 PVzbSEE9bLIups/tGG5VwK2piYBOTIvCo1/kAv6V4CFEW8o1dw33hs4xPAF/ydGYaFbe9
	 eAy8iH6S3HCF4SxFzu5PWZtxziFSga4/wSntNGSWzAh7lW4AgUVO+JGLZE70UDNihrptP
	 UDIknkj/3GAKonagRMMIbEz5q5e50RZfJ4ysEuKc7LHdsK/5n/RPbKiG1mias1s7XQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792443971;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=9MAmvIn08RerEdZ3pqVcuDHmjNgJDApJ50B7PsC0yxA=;
	b=3Ze9fHPEJGZ1UXqwOwVkEQMmWOOXtQXNk794GHnkxmalWPftxqVqFn/4ZP+cf/hlo2lW
	 XS9EBFZ1FMsbTXvO4v8jghHui9lhINEHUFpjLojOC25kpHGsssrXWEt6LaBe5kxW8CabU
	 dMgdGI1kOMyq+CJG0quMkRwAxoMw/RhUt1aBJd1Yt7y5qYnzv8lcY7bjwQonK1QhfrYYE
	 ewSWkgbBQauEO7FyRUgVyx7Bwe8oiT2rZBVFtZS4edM3cnepvAnEePH1hX+ewXzWGzwBm
	 +Xrj9fQuDMV8mKnUrvNX0PJAWOh7iRoyCbi6d48EZVlxWL9ZNg1YV8oplKSqd/QnXyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=aVHZ9bvT;
	arc=none smtp.remote-ip=209.85.208.70
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE04C606A319
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 21:06:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE04C606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=aVHZ9bvT
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-6b1d35e3c0fso2158253a12.3
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 14:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792443969; x=1793048769; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9MAmvIn08RerEdZ3pqVcuDHmjNgJDApJ50B7PsC0yxA=;
        b=aVHZ9bvT+GAk2MN8y6KUiGpMemjJ3Sqzfu1NGkwM1zMiY7e/fRsvy0CG/t2b/7448H
         WcYyR74Rne/rwQSVZSFVV3jIw2Y2iElBCeuqMxCYQrbHUKDasUuQUWW7D1f1FBZ5EpAf
         x9XgVKvIkNSOKoac4yrZldcfcqAZSXe17lCpot5uxtLRJNWUX7kY+J44ssawbw3VR8Ry
         IQle1kXpcra9tUJmsTmiJTkBu9TK618H1Y72e8G5Sxauw+vXHqkVlqV0mekur5XgUKcJ
         jWOl3hgWktw3TE4vKIEpwu0jO4hJRRY9gIOkvVilzTRCZ3ifndJKeW8BRu8aUeNgfUR+
         O/yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792443969; x=1793048769;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9MAmvIn08RerEdZ3pqVcuDHmjNgJDApJ50B7PsC0yxA=;
        b=EWEQJFM01uymuF3qWgk1oGOde89DDlHhTdSjkf46E9XwX4sYIOhooWSWuhPEvlcxSC
         D6MG6ovI0jj6ordjIFl6smffX7jE4tdNMjRNKxktNDu+7J+fRBFEPXkeAGMxCSBn6uLP
         0JT94WzqCMTsCu7lT8D9if04kJ2g8S1sHzP7lufy6ic60aNWJytE3tD45uSZ6S43FKfI
         QG+YYmCiNTtVp3Gx6fDYdrlpjr0tjZ9chbOQuz+rc2I8XHWRTLwau23xwwWbwt7UC7Bo
         T1mllIUFa8s6VnrrKXd0G0Zz+q2sSmueVt/CRSeaxURxq5kyHB4zGcmnXSXBJq38dPP9
         lWsA==
X-Gm-Message-State: AFq9FYJjj3xwiSJdfL9IzSgd5uIb4QswYO24yDs2in+G35xQz//psFXL
	IMCKTwJrxKhFnF83f98fu1zW0+oC7RVmJNjTPM/XH6v88SUnNhhl8DrIc/60rZ0SuqxSfcl7Z+8
	VyW83EA==
X-Received: from edvi20.prod.google.com ([2002:aa7:dd14:0:b0:6ae:14cc:13c4])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:354f:b0:6aa:f14f:5571
 with SMTP id 4fb4d7f45d1cf-6b3a81f6f9amr5851038a12.45.1792443968890; Mon, 19
 Oct 2026 14:06:08 -0700 (PDT)
Date: Mon, 19 Oct 2026 21:06:02 +0000
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261019210604.2433620-1-lrizzo@google.com>
Subject: [PATCH iwl-next v2 0/2] libeth, idpf: use GFP_KERNEL for the initial
 Rx ring fill
From: Luigi Rizzo <lrizzo@google.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Luigi Rizzo <rizzo.unipi@gmail.com>, Brian Vazquez <brianvv@google.com>, 
	Joshua Hay <joshua.a.hay@intel.com>, Larysa Zaremba <larysa.zaremba@intel.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"

libeth_rx_alloc() always allocates with GFP_ATOMIC, including when a
driver fills its Rx rings at open or on queue reconfiguration. That
fill runs in process context, right after page_pool_create() and before
the queues' NAPI is enabled, so it may sleep, and GFP_ATOMIC is
needlessly restrictive there: it can neither reclaim nor compact, while
the initial fill can allocate tens of thousands of buffers across all
queues.

Patch 1 adds libeth_rx_alloc_gfp() taking a gfp_t parameter and turns
libeth_rx_alloc() into its GFP_ATOMIC wrapper.
Patch 2 switches idpf's initial Rx ring fill (both splitq and singleq)
to GFP_KERNEL.

v2:
  - split into two patches (libeth helper and idpf consumer)
v1: https://lore.kernel.org/r/20261016151835.2500807-1-lrizzo@google.com/

Luigi Rizzo (2):
  libeth: add libeth_rx_alloc_gfp() to specify allocation flags
  idpf: use GFP_KERNEL for the initial Rx ring fill

 .../ethernet/intel/idpf/idpf_singleq_txrx.c   |  7 +++---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  9 +++++---
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  2 +-
 include/net/libeth/rx.h                       | 23 +++++++++++++++----
 4 files changed, 30 insertions(+), 11 deletions(-)

-- 
2.56.0.212.g129ede20d9-goog

