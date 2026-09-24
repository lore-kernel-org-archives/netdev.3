Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA7B349CD6
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 08:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790238596; cv=none; b=DqBKRR9u/qNFONT7O7TUpfPdnWC0MdnSGXBBRx5V8NS5b2e9rVFrLs8NAABQYWuuVn+LGP7ljeV1DbtsF1oXcF9gK3b19rvWBvgVCvYHnzLS6OVka0LGl82MwpbNtRD+TfiWOEDPpRhmUnorU/2C3JQM0EMB2VcQoV+lWYcKRcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790238596; c=relaxed/simple;
	bh=XemExumd73GIA1RmmGUBS6dCA8I106FVJCnAgDJFs74=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=TACRXD6SVq/AebBPC62I8JJ7OVuyPNKMcLRgKgU1OLxNaUKuMXRdNCXKMkaw1yDCcUGzFsubmcNsu9WqqwFJ0uN9MWn25b+Ca6dDSKodtcIvWzWY7TOIXYnj0Yc6ASZEYXl91UmR6jRmhuFxPVQzGFEOgtyuLrrlNmLIQEq12Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G1Gz49mI; arc=none smtp.client-ip=209.85.128.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G1Gz49mI"
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-869553205a7so32481427b3.1
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 01:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790238593; x=1790843393; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8vHseU9aNH0DVGXDJM/cuMA6fQGZIm6Bi+QBx69Plvs=;
        b=G1Gz49mIcZzyKiXKiHLMqy1vFMKp0Evo9NxLCbju9yr+SSLDihxf5aHK8uTgta09YH
         z+CnnKHpKPgkJfg0VWzh3iua9RJVUhsTzuw1A+Sgb83EMNLwZ7HSBJFNDge5rqSJtI/n
         /GuifU1oR7J415RRJsu11oChCM/JZlTQ7YudnxxUSiGOrCn8Jzijjpyvv9BqIirRvkVL
         rJVs9viURgZvJXnjhrvyb7pYkZ/BwFCcVF1SApemey10xeexVdZL9FhM/GOCxMF4huhF
         PntwXOKoXmGJU6G47E0aKAPLBjGEZcgERokcihh3yKXwkbH5LFUYVwuH1i5CcmycwoU9
         xo7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790238593; x=1790843393;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8vHseU9aNH0DVGXDJM/cuMA6fQGZIm6Bi+QBx69Plvs=;
        b=liG3GL0uONzhQ7G3h9lR7pQx4LedfggQWkmqUeOkxqgqV/BwC1eSQIZTiGskyiBe7G
         +BRV0ryNsSNrunKzHI8LIWTn+IahbN0DZ0RBiCcRaGpt6YxrgdNVnfsDshWFiYRWPuka
         Nm+RUv6CnQ3MAvP4GPXJW/hni1T6xoc0DEX4g5m1fXBNwwQXlBXQTksWGkFTbUarunsB
         9F2nKBXRPF5o0AZW16omgc/1Uv6ub6RbTzwAC60ZjtX0GaFdSJnuLGy5/10Zk2twsm/s
         A/73yGBDK+wOw+6qSqD4Agskg6ABR58dN/UiS5tTCpm9VabYFcBx7FpSL6kyqn0fNiI1
         YIng==
X-Forwarded-Encrypted: i=1; AKwUvBxKgLRSOkJEeTCn0hcdHgtGAPrdpGX77WLKJifahMZaDVQv5Xhh5fh9fLFn1r+cc1O5/PX/xdc=@vger.kernel.org
X-Gm-Message-State: AFuF++nX3qRIYVonlbiQGm+emv2pF4pVRDORPkayHMsI7++gMqROIXPt
	LDI+nZPFNZrDapw7inJGndt3jdqstS/lBLm2MJVOP3zK/29TLSD3SZEykfZ5yp2tpPaP00DFISZ
	LSLxANtNRPJT3PQ==
X-Received: from ywee19.prod.google.com ([2002:a05:690c:a193:b0:893:c668:9cf3])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:e3e6:b0:858:d554:79e4 with SMTP id 00721157ae682-8a649976ea3mr10385677b3.20.1790238593114;
 Thu, 24 Sep 2026 01:29:53 -0700 (PDT)
Date: Thu, 24 Sep 2026 08:29:47 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260924082951.1599377-1-edumazet@google.com>
Subject: [PATCH v2 net 0/4] vlan: ensure sufficient headroom in vlan_dev_hard_header()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, edumazet@kernel.org, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Callers that only reserve ETH_HLEN or less, or skbs allocated before
dynamic device/headroom changes (such as toggling VLAN_FLAG_REORDER_HDR
or bonding/team switching slaves), can reach vlan_dev_hard_header() with
insufficient headroom and trigger skb_under_panic().

When vlan_dev_hard_header() returns -ENOMEM upon skb_cow_head() failure,
a few callers of dev_hard_header() / llc_mac_hdr_init() had pre-existing
error-handling bugs:

- Patch 1 fixes a UAF/double-free of skb and leak of nskb in
  llc_conn_ac_resend_i_xxx_x_set_0_or_send_rr(), as well as nskb leaks in
  llc_sap_action_send_xid_r() and llc_sap_action_send_test_r() when
  llc_mac_hdr_init() fails.
- Patch 2 checks the return value of llc_mac_hdr_init() in br_send_bpdu()
  and frees the skb on error.
- Patch 3 removes a shadowed 'int err;' variable in __teql_resolve() so
  negative errors from dev_hard_header() are properly returned as -EINVAL.
- Patch 4 uses skb_cow_head() in vlan_dev_hard_header() when
  VLAN_FLAG_REORDER_HDR is not set to ensure sufficient headroom for the
  VLAN header(s) and the underlying device hard header.

v2:
 - Add patches 1-3 to fix pre-existing error handling in llc, bridge, and
   sch_teql when dev_hard_header() fails (Sashiko).
 - Use READ_ONCE() when reading dev->hard_header_len and
   dev->needed_headroom in vlan_dev_hard_header(), and explain why
   LL_RESERVED_SPACE(dev) is not used here (Hangbin Liu, Sashiko).
 - Link to v1: https://lore.kernel.org/netdev/20260922113924.3165190-1-edumazet@google.com/

Eric Dumazet (4):
  llc: fix skb UAF and leaks on llc_mac_hdr_init() failure
  bridge: check llc_mac_hdr_init() return value in br_send_bpdu()
  net/sched: sch_teql: fix shadowed err in __teql_resolve()
  vlan: ensure sufficient headroom in vlan_dev_hard_header()

 net/8021q/vlan_dev.c     | 5 +++++
 net/bridge/br_stp_bpdu.c | 5 ++++-
 net/llc/llc_c_ac.c       | 2 +-
 net/llc/llc_s_ac.c       | 4 ++++
 net/sched/sch_teql.c     | 7 ++-----
 5 files changed, 16 insertions(+), 7 deletions(-)

-- 
2.56.0.rc1.310.g51773c2048-goog

