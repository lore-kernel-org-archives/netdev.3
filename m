Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EA052189B
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 14:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790172704; cv=none; b=OOdgahpjTNk3BBZgxQd1M1Y9tVNTopDMVBIc2eVhoRo0hIEa+ys0Ngu3uELzqMxk7XKwcx6FWKrXC6Z0QehwCt9VRfboD3x058+8gjFid9MGeS3QxBkGd/y8B4D6j/HMfqf4vYxMZI0spc9/VaBX3zLNPpkcYeuFvygO+SrYAoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790172704; c=relaxed/simple;
	bh=vNYHNG6OeTeuqeU/nO8DWT79ef2qPt1PBaqVBGp+BEM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JAtdUWJAL84oJ6yVM3ObyKaDIbMEC43D5ulb2bDIuYjYx7dhztElnXl9fm3ipgg+7Tx542bICbrMF2XQy4tbvZrzZO2z74qN4AdhjWWIIO2yr8c4kPFAAcFrY67roKucC8WSG9/GTSPDTdytVOTAGpW9jSXwir8V+8Q61DyQ+2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=varjosoft.com; spf=pass smtp.mailfrom=varjosoft.com; dkim=pass (1024-bit key) header.d=varjosoft.com header.i=@varjosoft.com header.b=iDNvN8hL; arc=none smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=varjosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=varjosoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=varjosoft.com header.i=@varjosoft.com header.b="iDNvN8hL"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b5e4f16cd1so896913e87.3
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 07:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=varjosoft.com; s=google; t=1790172701; x=1790777501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3NsQhwLSezJurr3EgmlkmEZwwa71aMkKfkQWcK+6KFM=;
        b=iDNvN8hLskfD68SFMxx11b2ql7rHHq/fVpA/zkos89VizMR6kSwWuZvlP27H5hjEiG
         p9NHAYxMzANra7xELlAUoUwGrDBb7AQeiP7QeXYS25Tzi5Yc1tY7nDw1WdM/cq6PNfpV
         LxProusVS1KfAk44o24vVshZUiFFk2FMgTPSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790172701; x=1790777501;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3NsQhwLSezJurr3EgmlkmEZwwa71aMkKfkQWcK+6KFM=;
        b=UGH5TQ/ylPQ7+5y5Tu/SpMta+EcM2Zrt7uwia8UBj9E1PMbhfLUGmzQm/oKWVtoJyJ
         jghqnT07ub0oIdK2BrK48zUC1bRpCr3zj/sFw+3uaWPAa4lBDDfJRSYlJKlxrZOZwuvc
         E2tY/R9wjeboz9hgwAiVXxJoOPfOBnuiNlGnRc19xvDwfO4dPomhX8thmtBhc1J4483T
         4oOKoEjBRjCSgqsd8sb0va8H6jDTQ6X4kVaEYptIHqjF6j972mmqNz6m0OEvxDiyLpTT
         1ITtUUJPOLLN95NL2hbxzAyphvG4ObOqKOpNZ03QipKT4kcM8xS+Byc21oObNO7jkdK5
         t4Lg==
X-Gm-Message-State: AFuF++mCSAKxNOFLOS3TIh/JQdGrwz28a9nYxhasjl7NUGzS9zGEO/9b
	rlg3QHG+iYEkWg5IP7tOpblfhAx44E7Ich/8k0J9GLP7h5/raFe1m8Uea4MI7kQ//nw=
X-Gm-Gg: AYBFou12ORJNq3JX5apT22SwhScRetwmbJI6DPt7AvpeSm3oAjuPjDzLJkykG9VgL1D
	U3rAFBbYjPCKnKvtcl/XJVkWrDetopJljTDuCzNTq7SXcesxSlGdPddGbap/2baxfZjQPcCSLKy
	60EIfnpC7l2DRMyyRM7nCZR9DaAzQsL0SYCqYboFX6lNpPjfbi2jhSrP8MHVm5vbDqTQSG51JJE
	8S517HzsQrtkeGK8Kh+dMHue++gPbmVpv4Dw7An+9d1uChoWPEKGb3A/wPqzztMvvyvU0x5ZZkX
	Uo0qb5IbMDSv582sSEX2stGUghXePzcseN1HXcGcJ27K/8TVEXtyzopIYNVszmm2cpjNnvAfldv
	aQE3OCs0HI+v/qOmXUvUbH/EKWHzLlCv9vLG9Px06R8l+iQYxMsN9eii5CEACalbk5Kr5OtSUKy
	5/GKLOZdLq+WMmkDSh1+rZMp0kw9sKC55RIOLk4lYtmO0pqsoRLeXoX9PS24eux80EBU3+YRF36
	DHF3cKdZw/jrTa9bsdybECg0cCay5tI0YcgS9OTvuI5T66/p9dSZ7uH1g==
X-Received: by 2002:ac2:4947:0:b0:5b6:1a7c:fd94 with SMTP id 2adb3069b0e04-5b8d89d1774mr735667e87.58.1790172700756;
        Wed, 23 Sep 2026 07:11:40 -0700 (PDT)
Received: from localhost.localdomain (82-181-149-15.bb.dnainternet.fi. [82.181.149.15])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8d8589e1csm647587e87.54.2026.09.23.07.11.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 23 Sep 2026 07:11:38 -0700 (PDT)
From: Hannu Varjoranta <hannu@varjosoft.com>
To: Joshua Washington <joshwash@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>
Cc: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ankit Garg <nktgrg@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>
Subject: [PATCH net] gve: DQO: accept TSO packets with non-protocol gso_type bits
Date: Wed, 23 Sep 2026 17:10:47 +0300
Message-ID: <20260923141047.14047-1-hannu@varjosoft.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 014c607f86ab ("gve: add support for UDP GSO for DQO
format"), gve_prep_tso() matches shinfo->gso_type exactly. gso_type is
a bitmask, though: SKB_GSO_DODGY is set on every GSO packet that comes
from tun/tap, packet sockets or other untrusted sources, and
SKB_GSO_TCP_ECN and SKB_GSO_TCP_FIXEDID can be set as well. Such packets
hit the default case, gve_tx_add_skb_dqo() fails and gve_try_tx_skb()
drops them, counting them in tx_dropped.

These packets do reach the driver: tcp_gso_segment() passes DODGY skbs
through unsegmented to devices that support TSO, after recomputing
gso_segs, so drivers must tolerate the bit.

This breaks virtual machines behind a tap on GCE instances using the DQO
queue formats. Every TSO packet forwarded from a guest (gso_type
SKB_GSO_TCPV4 | SKB_GSO_DODGY) is dropped, and guest uploads slow to a
crawl of retransmissions or stall entirely, while the host's own TSO
traffic (gso_type SKB_GSO_TCPV4) is unaffected. On an n4 instance
(DQO-QPL) with a Cloud Hypervisor guest, a 64 MB upload from the guest
went from a 60 s timeout at ~0.9 MB/s to 0.19 s with this change, with
tx_dropped no longer increasing.

Restore the bitmask test that commit 1b9f75634441 ("gve: ignore
nonrelevant GSO type bits when processing TSO headers") introduced for
the same problem, keeping the UDP GSO support.

Fixes: 014c607f86ab ("gve: add support for UDP GSO for DQO format")
Signed-off-by: Hannu Varjoranta <hannu@varjosoft.com>
---
 drivers/net/ethernet/google/gve/gve_tx_dqo.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_tx_dqo.c b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
index 80ab0a449ff5..675c7644817a 100644
--- a/drivers/net/ethernet/google/gve/gve_tx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
@@ -596,21 +596,20 @@ static int gve_prep_tso(struct sk_buff *skb)
 	l4_start = skb_transport_offset(skb);
 	paylen = skb->len - l4_start;
 
-	switch (shinfo->gso_type) {
-	case SKB_GSO_TCPV4:
-	case SKB_GSO_TCPV6:
+	/* gso_type is a bitmask: SKB_GSO_DODGY, SKB_GSO_TCP_ECN and
+	 * SKB_GSO_TCP_FIXEDID may be set alongside the protocol bit.
+	 */
+	if (shinfo->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6)) {
 		tcp = tcp_hdr(skb);
 		csum_replace_by_diff(&tcp->check,
 				     (__force __wsum)htonl(paylen));
 		header_len = skb_tcp_all_headers(skb);
-		break;
-	case SKB_GSO_UDP_L4:
+	} else if (shinfo->gso_type & SKB_GSO_UDP_L4) {
 		udp = udp_hdr(skb);
 		csum_replace_by_diff(&udp->check,
 				     (__force __wsum)htonl(paylen));
 		header_len = sizeof(struct udphdr) + l4_start;
-		break;
-	default:
+	} else {
 		return -EINVAL;
 	}
 
-- 
2.55.0

