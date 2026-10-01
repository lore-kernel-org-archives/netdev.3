Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFEF4AA3FA
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 19:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790881914; cv=none; b=I7TnI6fwV0fFD4Q+skM/m4bDbYNo3Ln166F6uN3U3XpuPxbfc5fE+s3QWXY3BvawQJG/Z2CA+2eVxL2kgMqZU4TVlKiLsYj2/aHVwdOLmV1mGPszDVRvMdvmLSof4KOwpOToCKo39PGX/89BpOUpLiKX1kdA6xGa3Q86A0KPv5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790881914; c=relaxed/simple;
	bh=lbvx+zFRzPT3eVVtT2zqSy1S0SdJN1tgQcPL5HiHxKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a97/J1HtpmcUU8q+59kjmny5xmJHyz6ylAAQ+ugMdqNMY334gEIKsqWMBkGvmCwA+wcPce4Bq0Rs4vBeZPdbN6qrc3eEWWPf2wCt+XJTH82dlz9ws4OcCMx7L1xF0nQNCwN1PzNkuXhnp8KTR4cEQLcQtnAQX3UIv+733dOS3eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VzkWrQYK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VzkWrQYK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 883331F00893;
	Thu,  1 Oct 2026 19:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790881908;
	bh=3lp2r2Y90effhGrHLPBLNtfeKZEAFFuMruVSCeH9LnY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VzkWrQYKQBcjgjZQt/ozBvg25wQ2jFvagl57kqami3q/BQTK9MSYxWoU3pU37u2rq
	 SbmJYBUTSgPxHaicOtU42fSVrameZcd6HCCEJmfJuo43Pb6t0Cj5H0WxpcLQXXa00j
	 mQH5LKb5PVvF6ZR4qpD/guARtSeMBxxcxnV5wjss7QbfOnLz2c8/pbPrV3FdHtWbgE
	 BmdNStfzWR1DZlTL97fMP40tMDkI7X7kJDCMtV4nJTfSpVaP1RuMdsAVKwblh+3SW2
	 GeOHKostfa8DzjGTRinbZHUxPZItu7oCH5iBOixxlLbw6efpxbuv5SHtIVQQvVHj9R
	 TbYsMthpuDYiw==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	edumazet@google.com,
	Eric Dumazet <edumazet@kernel.org>
Subject: [PATCH v3 net 1/3] flow_dissector: avoid u16 truncation of skb->len when computing thoff
Date: Thu,  1 Oct 2026 19:11:38 +0000
Message-ID: <20261001191140.2818991-2-edumazet@kernel.org>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
In-Reply-To: <20261001191140.2818991-1-edumazet@kernel.org>
References: <20261001191140.2818991-1-edumazet@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__skb_flow_dissect() computes key_control->thoff using:

  key_control->thoff = min_t(u16, nhoff, skb ? skb->len : hlen);

min_t(u16, ...) casts both arguments to u16 before comparing them.
Whenever skb->len (or hlen) modulo 65536 is smaller than nhoff, the
truncated length wins and thoff is set to a bogus small value, even
when the dissection succeeded. For example, an IPv4/TCP frame with
skb->len == 65540 and nhoff == 34 gets thoff == 4, so callers such as
skb_probe_transport_header() point the transport header inside the
Ethernet header.

Such skbs are not exotic:
- At the time of commit d0c081b49137 ("flow_dissector: properly cap
  thoff field"), AF_PACKET with PACKET_VNET_HDR could already build GSO
  skbs larger than 64KB (MTU checks are skipped for GSO, and
  alloc_skb_with_frags() accepted up to MAX_SKB_FRAGS (17) order-0
  pages on top of the linear part).
- BIG TCP now makes skbs larger than 64KB common.
- The following patch makes tun_get_user() dissect IFF_TAP frames
  before eth_type_trans() pulls the Ethernet header, so a GSO frame
  carrying a 65522..65535 byte L3 packet will be dissected with
  skb->len in [65536, 65549].

Compare as u32 instead. If the resulting offset cannot be represented
in the u16 key_control->thoff, cap it to U16_MAX and report the
dissection as failed rather than silently returning a wrong transport
offset. thoff is still set on failure, as some callers (such as
eth_get_headlen()) use it regardless of the return value.

Fixes: d0c081b49137 ("flow_dissector: properly cap thoff field")
Assisted-by: LLM
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
 net/core/flow_dissector.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 8aa4f9b4df81016a3d9a97e0d561f6dfc51aa88d..27d8a01bc92306ff043389b4fde2d24af97d3106 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -1071,6 +1071,7 @@ bool __skb_flow_dissect(const struct net *net,
 	int mpls_lse = 0;
 	int num_hdrs = 0;
 	u8 ip_proto = 0;
+	u32 thoff;
 	bool ret;
 
 	if (!data) {
@@ -1692,7 +1693,13 @@ bool __skb_flow_dissect(const struct net *net,
 	ret = true;
 
 out:
-	key_control->thoff = min_t(u16, nhoff, skb ? skb->len : hlen);
+	thoff = min_t(u32, nhoff, skb ? skb->len : hlen);
+	if (unlikely(thoff > U16_MAX)) {
+		/* Cannot be represented in key_control->thoff. */
+		thoff = U16_MAX;
+		ret = false;
+	}
+	key_control->thoff = thoff;
 	key_basic->n_proto = proto;
 	key_basic->ip_proto = ip_proto;
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

