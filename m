Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1D92E9729
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 16:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781108330; cv=none; b=Wvp70q5ENBU/DrivSyxqBTz7iA+N+uFUnuzhiBBqQ5v3ObknNb/dl7C1qfcVLv+ELgZvDSTLfigeTSCFPXiMWT8bE3LvwFikMYg5xTLWPYbM3JVg8dOky0Yd7AED86bEsdDxWQev7DQTj7djbIHSftqdgINYiC6diVLmrAw21ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781108330; c=relaxed/simple;
	bh=KVQDHPFdCfmYV8CVU0u8paMAbhS8jCaMhqDWllHJD6I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=apJguRHaSYIQ3wpxg11jw48Y5FeVzU4LVZR+5AY9+5tFTGUlE///5la/KGwa8hAlpLfSikYZ6O+Aowj1tdqtpWdNvR2ZDwlhA73O0HyVAUsemLlvl3EBrYIVVCHGuTf8RzlNo6idrANKYInlPyFWG2myUN9EGBykxNQh5l7rxDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hfqm8rJw; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hfqm8rJw"
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-915c8347cd5so168522285a.0
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 09:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781108328; x=1781713128; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tNTOcUI+St3YpbLpSN+OSV2cXCoRKjLVo1x1PwnabNM=;
        b=Hfqm8rJwAEPwNk6EEP+Zdq2wqjTmRE8unSYIIHmQq5mnteIBuGzLvWyR/p1U5TYJyS
         4ZIT5zwE2Vt1tCedicLrmFGfQn3d0RbRyLb/HaW36a5fFYGGncsxCNYnaFzCsPg2GF2y
         nmNQ8Pcid+t3FTrmawEC8Ida9hsXN2yDXipPQgQMe00bojRaiq3atXD70nl6RDS4jIAJ
         K/jd/FQSaL4RNLA7H5QNi84hkiEojQKUjy2Q0QvhQ9x8wBY8mRSNMc/FKDssrkkdx2xU
         cbvMTuAYx3wfPo2UiWrjO2MIzvUrq3nEUuqwwmzC2bnv+jTjvQfnixGGCcQznhVQT3BM
         q18Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781108328; x=1781713128;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tNTOcUI+St3YpbLpSN+OSV2cXCoRKjLVo1x1PwnabNM=;
        b=Xe+3tEpTaOcubqndtbITVsvmn9/CNNJxbQranthuV40MU2Nphngnm5EOgUueU9ctNZ
         noA8hqndEsTYOfTV04FlQ7rk+MhbwVUQg5mxGYdd2DXEEYo67LP7SJiMA0BowjRQFSJM
         0QSkker0bPg/3d94r5u6R4yRSD/xCFl88Zxk+3Yb9Q5eNbwqV5SXTtf1Z42pTSqbk1j9
         vJ8XXqqi4Haqi1+5nq1M4K5f0M0vkdX2AakLll7qg1ZK2T6S5KpX4HcZmNPPa5TPGsiE
         GZh6NdJ6utzfmW38j0RcyXLHxcITFu77C+Sgo3u0d2wr+ZQ62TEDjQa4yX7/cCciqWd5
         FlFw==
X-Forwarded-Encrypted: i=1; AFNElJ9cBvhNoibAE829VaJeIppzEVGTT7A9GwUiJEARWFDllWsueIwEd0IASxCG03NXB6WYJcPZc64=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIJX6LqXg892Zt7yfCY+3E+fDAiUKIILWXZEysfAcvbiqs0j2R
	R0ddFo4gl7Ly9YSYWnJ5ntHgGfemVKstHDU0Anhhtt+yP6BDiXqVotu5a/84soSgHazAjYHUp2X
	h5nFNM3dje1J/xQ==
X-Received: from qkpt4.prod.google.com ([2002:a05:620a:4504:b0:915:825a:debe])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:f12:b0:915:89d4:df17 with SMTP id af79cd13be357-915a9d76032mr4246418185a.33.1781108327479;
 Wed, 10 Jun 2026 09:18:47 -0700 (PDT)
Date: Wed, 10 Jun 2026 16:18:31 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <20260610161836.1275531-1-edumazet@google.com>
Subject: [PATCH v2 net-next 0/5] net: bridge: take care of p->flags accesses
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

(struct net_bridge_port)->flags can be read/written locklessly,
and thus can fire KCSAN warnings, or real bugs.

Prefer atomic operations (test_bit(), clear_bit(), set_bit())
and use READ_ONCE() for the remaining uses.

v2: addressed Nikolay's feedback on patches 3 & 4.

Eric Dumazet (5):
  bridge: use atomic ops to read/change p->flags in sysfs
  bridge: use atomic ops to read/change p->flags in br_netlink.c
  net: bridge: use atomic ops to read/change p->flags (I)
  net: bridge: use atomic ops to read/change p->flags (II)
  net: bridge: use atomic ops to read/change p->flags (III)

 net/bridge/br_arp_nd_proxy.c | 22 +++-----
 net/bridge/br_fdb.c          |  2 +-
 net/bridge/br_forward.c      | 15 +++---
 net/bridge/br_if.c           |  2 +-
 net/bridge/br_input.c        | 12 ++---
 net/bridge/br_mrp.c          | 20 ++++----
 net/bridge/br_mrp_netlink.c  |  8 +--
 net/bridge/br_multicast.c    |  5 +-
 net/bridge/br_netlink.c      | 99 +++++++++++++++++++-----------------
 net/bridge/br_stp.c          |  4 +-
 net/bridge/br_stp_bpdu.c     |  2 +-
 net/bridge/br_switchdev.c    |  8 +--
 net/bridge/br_sysfs_if.c     | 61 ++++++++++++----------
 net/bridge/br_vlan_options.c |  2 +-
 14 files changed, 134 insertions(+), 128 deletions(-)

-- 
2.54.0.1099.g489fc7bff1-goog

