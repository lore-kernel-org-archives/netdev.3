Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648763CA48E
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 06:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787899980; cv=none; b=IQLXNBlu7e259fRK8xw63lnYWc4MA9RvCTqrYp/qp+T/r3xy4z3TRQE/kSpTNRqBKq3qAmVkn45z2lFIY1my5Foxg3L8EhnS6Ampe93gmE+pQupE2XLp8AZJSqr83WK+0AN52cVSP7n/seipMGPI3HWCRlA7/ZIiL+qyHBIuLt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787899980; c=relaxed/simple;
	bh=9Panq1zT+LS9VhnDPcBHUWdw9iHh3DGpGXcE3+Ojqb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LrbJ5zsYz6Z65UfvvjywRMh3miuAKhXveqboGFQofVYzN+jt3lOe/9OXCLuMcJhi69tABvDAKoSY5+GDcG9qWee/5hGN3aFcnA35VG80XRN9Mkp7Luh60kN7pXKRyl5pT1gPIL7eB4CcyHbuegSLn41y/pQvGp+qML9Ev2DfoNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=QKZnPidt; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="QKZnPidt"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2d71e253c90so6425305ad.0
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 23:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1787899974; x=1788504774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w6NOIIwhRVBbBiq++fjDRhLDbXTEcUDbCMW9A7eSR+c=;
        b=QKZnPidtkKA9Olx1871W5xKodKWrJgz7Lo52PFUXtJ2HxZG38UirwL+Jc+PXiKUYK7
         pvdpYU33GylgopTjt8RIqt64eSGmIsQsoFSVGyBHnPkCbzRp6Ll0w4/q2bim6gJUGd8z
         L7SwDZyv6zb5BplyKMSLY94/PuCMhTnSqPGYLlZELHiXf8AwSr0FPAWCeQKipnZ/rgoj
         SRpYURTqg0wA14XvlzXOXYc9/xwAzaTyMiglsc7nx2GkfoiuSUm+Ku/zHKfWGqRq51fQ
         jNx+6cbdZmbj6XYZnjd+TJhobitTCjSXD38psF5zun7TDT7OauYuLJpQTEbXk1x2m/UO
         4F/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787899974; x=1788504774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=w6NOIIwhRVBbBiq++fjDRhLDbXTEcUDbCMW9A7eSR+c=;
        b=p5qCBkhcGIZ8wswT3jk6kttYa4Rzf4ZZkq3NxYvEmdHyrfVcCWIHCrIzAnhVSmj9Qo
         zhmwRmZf1wfHH7nBL+jOabQa/Qud36f8QaJ4CHjaFPYUpjkSjCVAgem/h/AYU71KdO6t
         tundK38QyEgdSJ2XIkkA4tZMc08Wn2DJ3lzu/z5YezqnwWUj7x5sSESE1P7BgGp7HBO+
         kZCvZJw1+3GtOI0Wsd1RCBVyDFBYU2KT27voZ+Q/u/0CC/pJwsCA4stuVbvU1Kmcx56c
         7hLu035EG3cgEm1kVgZb6U9ZGNx2D7EnDRXDkMBI5IvSlGa/Jfu95Ar9UZLAPfeKfpXI
         eGGw==
X-Gm-Message-State: AFuF++lGaZhqzzf9zaSazV6cRmCR92d6flxvPwZbvCaamuHUXowDIvdd
	4SGLox/3Q5a7Z7dPwcuOQ5x0E6e6j5pG0hMbbsJ53dvbQzz0Qnxx//3xUAb3D3vw8lb68Bp3+mv
	2OTCwqeNXhnBrig==
X-Gm-Gg: AR+sD11zfv2wqjZmpobBAMP9TBXHjaHIm5TLfwMrZR/ws1yDo8pKVsq41HuFvOBUMQ7
	n0qx7yi3NkmwV74RZ9l3NafwqBGlMXvpd64ARZ6rv+3ZMjz0qsGxzjZYPsS2vMdOOaBcUzLeSTb
	5LTyx0pxQ/Y08UaBVR7/n4H4b3woChPFz8KLE6dj6Hzvrb1A+y/Cd1t0S07hBahNbuIcrUcG7gn
	moEai1M2L1fC1GGsZsMA4jGduikOlFuSdmLbesDM6rsldxdFXuj2Htow9fG6o/6MnT/yPn5I4FR
	9k/9T8uaajeSkiCecinIK/uR0wt9SCNZVHxAUA3nkRVX/FZ/xqr1fgKDoTVOMaeD/ETNk3NsIJ7
	xZjTJAQriFMgpSD68+/irpxk1j07W3lGgl483T0p2NM7SsSzEp5WaMjmodDD8CpXkEv1xuoQaa0
	rf5ARM3upkyc+pW/uOoWJwoJ3rmQ9UmAJTTQPMWLvefW6p+H5RozkNHx158N22S6mIoJQMikn0B
	fyaMIexOaanTErP2s0B2f+K
X-Received: by 2002:a17:90b:2d82:b0:38e:5c6:4db9 with SMTP id 98e67ed59e1d1-396d0f2f709mr10170367a91.11.1787899973886;
        Thu, 27 Aug 2026 23:52:53 -0700 (PDT)
Received: from gmail.com ([202.201.11.204])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39675867f73sm3896705a91.4.2026.08.27.23.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 23:52:53 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Zihan Xi <zihanx@nebusec.ai>,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>
Subject: [PATCH net 1/1] ipmr: restore a limit for unresolved cache entries
Date: Fri, 28 Aug 2026 06:52:35 +0000
Message-ID: <a31c6fb1ab9846c85e245fcf34948ac2bc27e521.1787854085.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1787854085.git.zihanx@nebusec.ai>
References: <cover.1787854085.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unresolved multicast cache entries retain up to four received skbs while
waiting for userspace to install an MFC route.  The cache entry count was
tracked but no longer bounded, so a stream of distinct source and group
pairs could retain packet memory until the system ran out of memory.

Restore the unresolved-entry limit for both IPv4 and IPv6 multicast
routing.  Reject new cache entries once the limit is reached while keeping
existing entries available for normal route resolution.

Fixes: 0079ad8e8dc3 ("ipmr: remove hard code cache_resolve_queue_len limit")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
 include/linux/mroute_base.h | 3 +++
 net/ipv4/ipmr.c             | 6 ++++++
 net/ipv6/ip6mr.c            | 5 +++++
 3 files changed, 14 insertions(+)

diff --git a/include/linux/mroute_base.h b/include/linux/mroute_base.h
index 4d55827e9705..af9247bb3f4d 100644
--- a/include/linux/mroute_base.h
+++ b/include/linux/mroute_base.h
@@ -224,6 +224,9 @@ struct mr_table_ops {
 	void *cmparg_any;
 };
 
+/* Bound unresolved MFC entries and their queued skbs. */
+#define MFC_UNRES_QUEUE_LEN_MAX	10
+
 /**
  * struct mr_table - a multicast routing table
  * @work: used for table destruction
diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index e5f2b1c6150d..3155ad921ddc 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -1165,6 +1165,12 @@ static int ipmr_cache_unresolved(struct mr_table *mrt, vifi_t vifi,
 
 	if (!found) {
 		/* Create a new entry if allowable */
+		if (mrt->cache_resolve_queue_len >= MFC_UNRES_QUEUE_LEN_MAX) {
+			c = NULL;
+			err = -ENOBUFS;
+			goto err;
+		}
+
 		c = ipmr_cache_alloc_unres();
 		if (!c) {
 			err = -ENOBUFS;
diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 3f2ed9b77deb..551b04d4fa7c 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -1207,6 +1207,11 @@ static int ip6mr_cache_unresolved(struct mr_table *mrt, mifi_t mifi,
 		/*
 		 *	Create a new entry if allowable
 		 */
+		if (mrt->cache_resolve_queue_len >= MFC_UNRES_QUEUE_LEN_MAX) {
+			c = NULL;
+			err = -ENOBUFS;
+			goto err;
+		}
 
 		c = ip6mr_cache_alloc_unres();
 		if (!c) {
-- 
2.43.0

