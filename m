Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3000035AC14
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 14:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784729869; cv=none; b=d2sNyk6jarKzvZNMKwoBZ6Y5eQNCCEEBVNQuFcpMaTlEUm0oZd3x1YlHj+Oa4BwwmMMsLHYdHu8AS/BvrktZNfWPJrRctQZQ1tz+RFU35Llq78I2wXPNA7j3d3ugF/1ayqu3FGOlk4GEEVuy0yfJpRMxBmC/euW1cigDmT3pRec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784729869; c=relaxed/simple;
	bh=OJ8K3uO2J5MpBBDiNAFjJ2NgKTrzqWJXwfrSHE36eEw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jBbCEzhRxHPByT+3JWDd2j5G5pVVjfZcv18U2QxSST7RScALYSBM5br+lHdi4U1r4GTNUXg271HwOLxHhTBYEclMfR9vqLYOt5z27EilDBHKdRaJ3nctDQoaVmr50ymmbAyY5u4O223xbkT3sXMpMPZK5nmctzoRRnkDrz1YRrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DQsFn9ul; arc=none smtp.client-ip=209.85.160.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DQsFn9ul"
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c1c7f135bso189878051cf.0
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 07:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784729867; x=1785334667; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CC+UCmOoVHVObH3rec+a2txjD1M7EoVw5X2+Q0ebe+M=;
        b=DQsFn9ul6JrLJ5XKdexaxmk+mZJLLgbH4zwSl8Rhe5BlUFmD4x56o5XbH3K9vf1OMt
         JAPP4O1Y30++YM9AwPupKCVTBk01OvDeWHNtgdhbqGsZKZoUQykYubDcCsJfnhk6Xot+
         7OU2+/ydH2B24x3xD10yvAUnX3fROjdnqr/G8rOUPMwGr9DHhKbUBsRglnYZf/2InjUZ
         P5PGtklfrMvvGmHvZvqqn43y5hvRlQt84cGRzNvfAMqo85t0RSa6B3FuiCX95d1IJlSZ
         TsSXhxH68WvbCSfGutBkvvr+GJaatmN6RaHY0RUUhpoPCK/sCKnUNJFX7eHPFOKGcKfZ
         7cOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784729867; x=1785334667;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CC+UCmOoVHVObH3rec+a2txjD1M7EoVw5X2+Q0ebe+M=;
        b=RD/5hf500KUSlQKrO+MtKsz0kZCXt17Ps4bUuADf4WzHXZxSRuzkd/5fiR0oqXnyHJ
         tiuabuSQc5DZvQWoHiH0qz5TjbnNgorIfDj1HCUHE+mg2JeECWU+3aHN7GchvpKSWKKU
         +N8FGmWn2ypC4dskgH3o3+4/sA2kE3ddZ/o+yvZhn6Rv5jMuP3b1etUPNFIYvBZ0/VIO
         pOnuJgCHFnZULbkWHmjRrNz9w+cd8MfSyq1jQzuTM0pVfPbHNnrCIsovRwMJiTq+krQa
         gG3KJ0PtlqgAPh4qaiGceWoPTsKK7/Lf2p5G6Sk+S9LSrs5/Zp2BrI04yGgjdW1aGmex
         4Zkw==
X-Forwarded-Encrypted: i=1; AHgh+RpdgE+bE1mp/oFvGaTQYLIuFrq4PKPgiSJVSmGDX5oCqoCiNeR8Di9z/mFpE0qqSQCUmOucV0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYvi/CqucUgsIFbydpLW5bWnyFjhpcCFNAoblkL9dvoiiE71u0
	sJ18Hu4CjPNpae4vklMXLQERkqmu+92ccFC/xqFtSV4q7FWEjuAQBWLXuUu+CFg2mJ0N8B8Dhhx
	TZQUl3w/ZtmOKcQ==
X-Received: from qtbe13-n1.prod.google.com ([2002:a05:622a:e14d:10b0:526:627e:6435])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:94:b0:517:c6b1:bffa with SMTP id d75a77b69052e-5213f66b3a8mr223593161cf.48.1784729866528;
 Wed, 22 Jul 2026 07:17:46 -0700 (PDT)
Date: Wed, 22 Jul 2026 14:17:42 +0000
In-Reply-To: <20260722141743.3266924-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260722141743.3266924-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260722141743.3266924-2-edumazet@google.com>
Subject: [PATCH v2 net 1/2] drop_monitor: fix size calculations for 64-bit attributes
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

net_dm_packet_report_fill() and net_dm_hw_packet_report_fill() use
nla_put_u64_64bit() to append 64-bit attributes (NET_DM_ATTR_PC and
NET_DM_ATTR_TIMESTAMP).

On 32-bit architectures without CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS,
nla_put_u64_64bit() may append a 4-byte NET_DM_ATTR_PAD attribute for
64-bit alignment.

However, net_dm_packet_report_size() and net_dm_hw_packet_report_size()
used nla_total_size(sizeof(u64)) instead of nla_total_size_64bit(sizeof(u64)),
budgeting 12 bytes instead of up to 16 bytes.

This under-estimation of SKB size can lead to an skb_over_panic() when
__nla_reserve() or skb_put() is subsequently called.

Fix this by using nla_total_size_64bit(sizeof(u64)) in both size calculations.

Fixes: ca30707dee2b ("drop_monitor: Add packet alert mode")
Fixes: 5e58109b1ea4 ("drop_monitor: Add support for packet alert mode for hardware drops")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/drop_monitor.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/core/drop_monitor.c b/net/core/drop_monitor.c
index 2bf3cab5e557a15dd3fa7197098d6b0abcc01fab..5d63cf2c230b4368e8a84e52413d37da26fb279a 100644
--- a/net/core/drop_monitor.c
+++ b/net/core/drop_monitor.c
@@ -566,13 +566,13 @@ static size_t net_dm_packet_report_size(size_t payload_len)
 	       /* NET_DM_ATTR_ORIGIN */
 	       nla_total_size(sizeof(u16)) +
 	       /* NET_DM_ATTR_PC */
-	       nla_total_size(sizeof(u64)) +
+	       nla_total_size_64bit(sizeof(u64)) +
 	       /* NET_DM_ATTR_SYMBOL */
 	       nla_total_size(NET_DM_MAX_SYMBOL_LEN + 1) +
 	       /* NET_DM_ATTR_IN_PORT */
 	       net_dm_in_port_size() +
 	       /* NET_DM_ATTR_TIMESTAMP */
-	       nla_total_size(sizeof(u64)) +
+	       nla_total_size_64bit(sizeof(u64)) +
 	       /* NET_DM_ATTR_ORIG_LEN */
 	       nla_total_size(sizeof(u32)) +
 	       /* NET_DM_ATTR_PROTO */
@@ -768,7 +768,7 @@ net_dm_hw_packet_report_size(size_t payload_len,
 	       /* NET_DM_ATTR_FLOW_ACTION_COOKIE */
 	       net_dm_flow_action_cookie_size(hw_metadata) +
 	       /* NET_DM_ATTR_TIMESTAMP */
-	       nla_total_size(sizeof(u64)) +
+	       nla_total_size_64bit(sizeof(u64)) +
 	       /* NET_DM_ATTR_ORIG_LEN */
 	       nla_total_size(sizeof(u32)) +
 	       /* NET_DM_ATTR_PROTO */
-- 
2.55.0.229.g6434b31f56-goog

