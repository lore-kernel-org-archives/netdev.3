Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D9E3921E4
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 05:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785822053; cv=none; b=c9MQjGwXcjvVk/1kS6r8nZJFZdHftHwGtL3g18sd5UDY4+QtSlAWont4SrFaivFSiHnmZfly6MBn4vWA7amHOwShG88mJJi5nNqa1AlDAc31jK/EQcIwOGH8i+1gqZoSBzskks0d0AoT0tsJeUGGeh0PYIoXE+xJ5WQWetrNrKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785822053; c=relaxed/simple;
	bh=+iFlrJXpKZea2WpVSqgTdGJ9PXsZFLdRtx/hAx9zsIo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MA27tb+syvhttgdP3zef6rGbIn3ThoC84VG/Qx5rlsFhYIsKbGQG6NNW8eBG/CpB0IqkYP5nH+3I4wpzrR3VvOfVw/ocb14pn47UrCKFQWQVbqJoxlAqllEOw5FdhbF538pJIg2HvbsHthGo4KZV2DyAWykq79+GCB89sRvv7hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vouc4WK6; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vouc4WK6"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84e3007a2b7so2980612b3a.0
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 22:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785822052; x=1786426852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mQ6IM8oB7QK336HOBIobZgU5qGVsb0MhAguyi+0VAXU=;
        b=Vouc4WK6vmg02d/Oh6dHRdRA0g6DAHggtYMr1U7g2gDvo9/ro5MNv9C3OU3r/WyPMo
         3NJ2Kc1Wg8UQA0PVUoD1FGnuhXro+WXCxt1eicXbK7VwngQv8FwlX8PV5fEWNgBCqmJY
         PBuh5D94aAmEyuEHkd0an4mEFib5HVN4pesSnI1UMb26J/MT1CzZ0IDBBbrQN+UFWqh1
         7z4NEU2fr50Ix6GDVxxvIVuC638dz9E7kmv4xmfuQBtdgJz16FyOGtl1ZeoNNFyZhxnT
         uW3kv2Rvcq8bGibX1JgADOG5Xy68/pjqsfrVQYXdDdj47Wo60OFP/zfXQEmwVnzQgJQZ
         dF9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785822052; x=1786426852;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mQ6IM8oB7QK336HOBIobZgU5qGVsb0MhAguyi+0VAXU=;
        b=gq6d20vNNwiWhax8rRa/i/DYH5A5dcoNoVu0c2xJnzaq4wRRJXBhiloJNTR85c9ReH
         pe8SM4DycE93pkhxdQjzqA127FSovYaHu7vrxzkHqCa2q5fa/gfvW91DHdt+BjRKnVo3
         +cLvDTnE4RPu1swRVmScy6Ez2WlVtmGbDd6NXJ39f12VNSo9R1HrcCnE3pE54+dDTmTg
         hEuSHM1Lleza6NyWHeLDTDCIca9wP45SWK46LNVk7hpVY5PujaAm/lN1wXSoCFbjof6n
         /AltmdzunDXAUavblCmPEtqjbb6Mkc2IzAiJiXYsA7ylstZQM1ayYq7D10ufQb855NA/
         S8kg==
X-Gm-Message-State: AOJu0Yx5819iFdNnprHzPyUyr5wNMv1Q8z74mFcrA96Od8pUp3L04mzl
	Nyxk63poP+TsIawZozX3qmYDf1tY9vYKpJTYS0MgJOsjHuhNRFkbzFopd8JoSXQFbHk=
X-Gm-Gg: AR+sD12PAARrJhGSB3eaUwUcVOL+LdqvmnRs9Kt7L6yiZlp8Ie4bCf1Ja396CwFumnS
	iupR5cWWAYhQ6t5vwR//2OU3NyXbFbVNHQic5/LDkjqYKvPTOTJDk2JMQT0XYjlC0v9O7Asic17
	m9ayNCHiU2bilKmssBvxx2eEMIam+RmG884MP092EuYfo5kMUmx2Bki0wWsdqxovmWzm553I2VH
	g9GiGBxMqbnr5LWyIDa1AAYcCLQZn52w+O2d3kgBgUMTxoup3eJfJk6upP6G0A9RdCytQjgOHXj
	sTseyKGV0mZDBUwqH7Z877tLIBOGMcrS8kGoDK8MB9Ub0jXPmJqwZ/hx4TFutVWKM+tf3wg0ExS
	3U/vKfkfGoQU7oVJ/KDYkM8uMVfmJZbaqygn/iNzFPOHAvz8PytOsy3Qkx1hSac5d7uP0rP4EZs
	U2987aUZDdHIBd9mqtCTzeElQtyHbz/UGBKhEI6FJ5g0AHkQNMYXUs6bJPxYH7Ies/5VRRL1efL
	iDIh3BX2C1axZs5k75/GVHF3qKDgB2W6hC3vLFRR7Mu2pvXRwi2z4LEw/r+Al2iE7VFhL0CpK10
	iUEBc6Y5YORd5Q==
X-Received: by 2002:a05:6a00:2343:b0:848:7e85:f208 with SMTP id d2e1a72fcca58-84ee4954d26mr11791266b3a.37.1785822051598;
        Mon, 03 Aug 2026 22:40:51 -0700 (PDT)
Received: from u2404-VMware-Virtual-Platform.localdomain ([60.168.97.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edbe5702bsm4678737b3a.16.2026.08.03.22.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 22:40:51 -0700 (PDT)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: netdev@vger.kernel.org
Cc: Sun Jian <sun.jian.kdev@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	bpf@vger.kernel.org (open list:XDP (eXpress Data Path):Keyword:(?:\b|_)xdp(?:\b|_))
Subject: [PATCH net v3 0/2] fix skb length accounting after XDP frag adjustment
Date: Mon,  3 Aug 2026 22:40:37 -0700
Message-ID: <20260804054040.613675-1-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes skb length accounting after an XDP program adjusts its
fragment area, in both the generic XDP path (net/core/dev.c) and the veth
native path (drivers/net/veth.c). When the fragment area is resized,
skb->len and skb->data_len can go out of sync, and in the reproduced UDP
receive path this leaked skb_shared_info contents (including a kernel
pointer) to userspace while truncating real payload.

v2:
https://lore.kernel.org/bpf/20260731032357.6114-1-sun.jian.kdev@gmail.com/

v1:
https://lore.kernel.org/bpf/20260727032535.13469-1-sun.jian.kdev@gmail.com/

Changes since v2:
- 2/2: replace __skb_put() with skb_set_tail_pointer() and explicit
  skb->len accounting. As Mohsin pointed out, bpf_xdp_pull_data() can
  advance data_end while leaving frags present; __skb_put() would then
  hit SKB_LINEAR_ASSERT() on a still-nonlinear skb. Following Lorenzo's
  suggestion, use the same approach as bpf_prog_run_generic_xdp():
  skb_set_tail_pointer() carries no linearity requirement. The v2
  comment claiming a changed data_end implies no remaining frags was
  incorrect and has been dropped.
- 1/2: add Mohsin Bashir's Reviewed-by and Lorenzo Bianconi's Acked-by.

Tested with a local 8-case test harness (generic and native, each covering
bpf_xdp_adjust_tail shrink variants plus a bpf_xdp_pull_data partial pull),
all pass. A forced-tailroom debug reproducer confirms that v2's __skb_put()
path panics with SKB_LINEAR_ASSERT() when bpf_xdp_pull_data() leaves frags
while advancing data_end, and that this series does not.

Link: https://lore.kernel.org/bpf/al9T9Eto%2FhRIzP5W@boxer/

Sun Jian (2):
  net: fix skb length accounting after generic XDP frag adjustment
  veth: fix skb length accounting after XDP frag adjustment
 drivers/net/veth.c | 14 ++++++++++----
 net/core/dev.c     | 10 +++++++---
 2 files changed, 17 insertions(+), 7 deletions(-)
-- 
2.43.0

