Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5703D25A2DD
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 20:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781210097; cv=none; b=SG+RSOqMdPaQyzkHN0JnpF/PTu0E/R9T3gfyxJZV8ZWj+/GLIi8H+XIp87O8piXfGcFMn0NhoPsSH6QlyoPVW1QjRgOUKSOIkgFKSYxvYk17Z6fK/babNggPt0e/dEoonxd7hsaTJvNWB3wNRCk44Wv1uO33L2+qLMKYsAsZFmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781210097; c=relaxed/simple;
	bh=7VfpZ8dgZUIdt5b4gRulfd8Mi+d5+Ac8mVUrYifKbQU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=OnSMRmxheHmP8P6E7idSn/f6TF9AFFZNoNsl1PnQ1AZoiLOdjQqeYj87MOJBu64e3IRlQQAaoliOMiBnot73f0WxtXLmAqfXVlYfWLYfq3VYx7B+fB6N570L8JJTmgGGPL4SVT6PyLlICaSeDmtIovzYWH8tFWPM8e4adfEGeFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IH1VT3MY; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IH1VT3MY"
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-517ac42d958so3485151cf.0
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 13:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781210095; x=1781814895; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ArBJBBLrMDUi4Q9RUdtcTsCIfKVynO6jif8Gq9I/YJY=;
        b=IH1VT3MYlGU4CkNPWn//2igseow8w7gsyLfPi1b8tX9I+4Lj+NhrBEufPJfYXBRvZB
         vsZNcags2cRUGgZ7XhBxhpyBN5GDV/ZxbUK1gMxKHH1llr+s2YtPJURur9QYhSSesydd
         JzRiPDcYebdxYtPY5Sf/2O80fWAJW5YtvpnpRCHlZaJVLGzM7CLQmI6oylDka2ykXdju
         3OtFdKfERv5+B+hzsf9dK8wIhc0J3gb6GpAIEZZ8b7FpMXkzw3mrKDg37Eu3arsiG2cP
         7fwIBClW5viycXEdoFaAeak5N6QW4r8OgF4+ht4s+PFHJ5Lg/v9Z5SWBZ17wYym0CPU6
         eZ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781210095; x=1781814895;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ArBJBBLrMDUi4Q9RUdtcTsCIfKVynO6jif8Gq9I/YJY=;
        b=h9CUwct3p6gdzaMhVGFsC59coVtPtrvh1lFGQWJkAEOq9ivcP1r7tHbsgolzxctP6x
         zhxcBJYCc4tSxFWHFjJrvIYEF159mnBbr0voBCDAJ+rMWiq0gvhhB9Pm2lnBlc9mT8R1
         FSgcjmEh9XSt1UuEg5IB7el1uyN7WD4m02D0tiZoigJsxDGZXRoHlnaV+f2pHtiKzQV4
         Do0jArpajMY4l+MhBXKeypv04F6TATQ64KqMRbAWaJrGK7mEueB9ivmkiizfhhl2Tb/l
         TUSX+ElBT360hI6cXb1+1VET/UA0GfKVwAui06uFOW5tqShNxztBAlQOGuLF82qntLdQ
         CZZw==
X-Forwarded-Encrypted: i=1; AFNElJ/4yzG4XqNkVU4Cxp/jI710qEA/3igvROnz9WebiqCWiOR0mLnsIeOcqr3Pqr9+cTadQJpeaHI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+dO8AlMUgqtU4J6MWqtnrJpLZCvP+Ptbw4ozGsfWaBXzNDzVI
	758NtI/JPeEIUQSQmjGucKgpy4RNJuu7Chpc9QksdSar/0Mka8R4wStfQwRMNy8txNiQaQGkjAG
	ja61oMoxfcGsYDg==
X-Received: from qtkk6-n2.prod.google.com ([2002:a05:622a:a946:20b0:50e:41ac:5218])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:1786:b0:517:7e26:369b with SMTP id d75a77b69052e-517ee23cb4cmr69651421cf.35.1781210094685;
 Thu, 11 Jun 2026 13:34:54 -0700 (PDT)
Date: Thu, 11 Jun 2026 20:34:48 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260611203453.3067462-1-edumazet@google.com>
Subject: [PATCH v3 net-next 0/5] net: bridge: take care of p->flags accesses
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

(struct net_bridge_port)->flags can be read/written locklessly,
and thus can fire KCSAN warnings, or real bugs.

Prefer atomic operations (test_bit(), clear_bit(), set_bit())
and use READ_ONCE() for the remaining uses.

v3: addressed Sashiko's feddback on patch 2.
v2: addressed Nikolay's feedback on patches 3 & 4.

Eric Dumazet (5):
  bridge: use atomic ops to read/change p->flags in sysfs
  bridge: use atomic ops to read/change p->flags in br_netlink.c
  net: bridge: use atomic ops to read/change p->flags (I)
  net: bridge: use atomic ops to read/change p->flags (II)
  net: bridge: use atomic ops to read/change p->flags (III)

 net/bridge/br_arp_nd_proxy.c | 22 +++------
 net/bridge/br_fdb.c          |  2 +-
 net/bridge/br_forward.c      | 15 +++---
 net/bridge/br_if.c           |  2 +-
 net/bridge/br_input.c        | 12 ++---
 net/bridge/br_mrp.c          | 20 ++++----
 net/bridge/br_mrp_netlink.c  |  8 ++--
 net/bridge/br_multicast.c    |  5 +-
 net/bridge/br_netlink.c      | 93 ++++++++++++++++++++----------------
 net/bridge/br_stp.c          |  4 +-
 net/bridge/br_stp_bpdu.c     |  2 +-
 net/bridge/br_switchdev.c    |  8 ++--
 net/bridge/br_sysfs_if.c     | 60 ++++++++++++-----------
 net/bridge/br_vlan_options.c |  2 +-
 14 files changed, 132 insertions(+), 123 deletions(-)

-- 
2.54.0.1136.gdb2ca164c4-goog

