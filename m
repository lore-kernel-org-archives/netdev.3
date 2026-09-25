Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B4D423E9F
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 11:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790337178; cv=none; b=LcSw9n+cuKFjlAUfABLwBJ8tGoR1wOyVUMrRJWBXMjxHAn+l6OUBwyKdrfZ8fiUSNz2oSOz5R6ujHwSUVoiuZQZZREa8t+kyt9po+8GxRSq+59SIYUzxq/jmuPeXyJeS6XAWPkvstyYUhiWNbGOkJpAP2Kxl7q000E5i/58Br8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790337178; c=relaxed/simple;
	bh=xwTvwyg3Pz92z+JaaSVjM8oPd/6RTxQDfs4QTPudtWU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m+km2WBU6O9G6NFEjKZ8LIuBxCsD+N3xahI/lI2AhZifCoo06/J/QszR9Un6+mJFTKeLmUvAi5/FfK4v+/Jlo3DjoO/PBz+o80ObxOnmfBL7KVf5AHSK1rnB869EWuC+Us6be53CQIg1Ck29ucvynqvNohTkad9ImZ+icscENM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=varjosoft.com; spf=pass smtp.mailfrom=varjosoft.com; dkim=pass (1024-bit key) header.d=varjosoft.com header.i=@varjosoft.com header.b=ir94oEIr; arc=none smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=varjosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=varjosoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=varjosoft.com header.i=@varjosoft.com header.b="ir94oEIr"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b74e0c2e4dso883038e87.0
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 04:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=varjosoft.com; s=google; t=1790337175; x=1790941975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XC14MEiSoCJarpcJk0TmGICtxWCtxqLpOUSXIexu2So=;
        b=ir94oEIrwSKAQk9d3/vgTC8d3O0VkpUQQ+6+MBuYuvGN8GsvgQ2v06Ah9YJH4qEGGO
         5V3um8IM/fEW1OSD47NVnBWCFLXJImj2kVXNGENViHlbr5O2yjmU/WinOtKWHD0bYoLJ
         ACzM6mcDD5LvzfuXaf53wruH2SCxvDWA0YTHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790337175; x=1790941975;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XC14MEiSoCJarpcJk0TmGICtxWCtxqLpOUSXIexu2So=;
        b=N8zRbNAmfwO/iPK/gB7uXDojiJbme+Jcu1K+rw6nInOLV58EXhN+2297LDak3YMFc3
         28DVGHVPDYgzUdD3LNF9URBM2Ne4x3jkHnEZT4/cgf5RMXhQ94A7NSzRYxBO4Aj3cPps
         CO5TJ/dAuBpO320Lulnl4Jitiz4Jpojb1x7JT1J/ay2n9P9GpJ2cTRh6ymCjXtbBdnum
         FenSjvVkGAKDXnUCVKUcwZI4m3eNmjfv2nbsBdkuUQtmy23IK3xHHrIaNOhj4K2UyAzd
         anCydMnP9NLrq8buLwxZj16bhp9rvUjS+5LeOQVZ6K1dTV68CXA3+0La9Fhu7f8a66n2
         PeXQ==
X-Gm-Message-State: AFuF++mNrmORAP58BJE5FW6K9tMFT7jozTVgkO+yShoka3q9GfWkxSAY
	pR/xwDT+lYpiw7EU2wuOpxZqCxcXkl+X8rDRGWl74VJSlWCwGZ+A+crOg7a2+ShWswsrhBqc+Mx
	WeV/k+7HW0w==
X-Gm-Gg: AYBFou2OESI+ZQpPuftJfNjr4NvcaS+GLHzn+syfJN6ndTvQUIyXkR3e7ORbOe0IcmF
	iYcTjRpkv614MiWz866Ph4U0XupOgHuND+wg5bbxBXtPEZfK8Xj40hINbB5LQ0Xui7eBcbvpneW
	sB1IMwH0Qr6Dhm9+V6j+IdDjVRXJ7TaaDzN+etvMUSI6dPN/yuAfEkPUYQHv0+ptwUbteZv4nMX
	fvdSPFifoBVFqO9TounQtKR49pIcbAbW9wxS8JMIrkKyH4AUFtDv4bMnrky3FO2fKvN7d5w0IgO
	hK5JvKpD1DEo0zA3H3BHSw2oZA3WWizbNqnW8fm8tbJdB63WzP0Vw9/+qJxSPVEzEX0Gf487zs9
	havV4qx0gJQWSt9BK2QebNL0iuIOMJyQ/ldpNZPIywwzrMZzDzxR99ooFSE+kMRaLXr/IuPf/zm
	hX34i+lIumaVeQmbEECIV2uY+jnI+c68aUSlukFMTnap5qXoHhOecGHxA5LXWxDUaPKlOYk7gRm
	DXNoxf6mB2Fx7iNjN5DpvfoyAQ0HX6Y7prvPuAqMc5fI9juOSnc+qgfAsLlgUdF
X-Received: by 2002:a05:6512:1394:b0:5b8:bc5e:b56e with SMTP id 2adb3069b0e04-5b8df1f3c41mr1675024e87.38.1790337174668;
        Fri, 25 Sep 2026 04:52:54 -0700 (PDT)
Received: from localhost.localdomain (91-157-138-212.elisa-laajakaista.fi. [91.157.138.212])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8e6a8c93bsm501228e87.7.2026.09.25.04.52.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 25 Sep 2026 04:52:54 -0700 (PDT)
From: Hannu Varjoranta <hannu@varjosoft.com>
To: Joshua Washington <joshwash@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>
Cc: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ankit Garg <nktgrg@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Eric Dumazet <edumazet@google.com>
Subject: [PATCH net v2] gve: DQO: accept TSO packets with non-protocol gso_type bits
Date: Fri, 25 Sep 2026 14:52:37 +0300
Message-ID: <20260925115237.56465-1-hannu@varjosoft.com>
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

Host TCP with ECN is hit as well: gve advertises NETIF_F_TSO_ECN, so a
TSO packet carrying CWR has SKB_GSO_TCP_ECN set and is dropped too.

Restore the bitmask test that commit 1b9f75634441 ("gve: ignore
nonrelevant GSO type bits when processing TSO headers") introduced for
the same problem, keeping the UDP GSO support.

While here, reload shinfo after skb_cow_head(). If the head was cloned,
pskb_expand_head() moves skb_shared_info to the new head, and the
pointer cached at function entry can then refer to memory that another
clone frees.

Fixes: 014c607f86ab ("gve: add support for UDP GSO for DQO format")
Signed-off-by: Hannu Varjoranta <hannu@varjosoft.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Ankit Garg <nktgrg@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
v2:
- Reload shinfo after skb_cow_head() (Eric Dumazet, Sashiko review)
- Mention host TCP with ECN in the changelog (Eric Dumazet)
- Rebase on net, on top of commits 83769c23fb18, 3b430ea62340 and
  296c83b5ccc8 (gve_can_send_tso() header length, MSS range checks)
- Carry Reviewed-by tags from v1

v1: https://lore.kernel.org/netdev/20260923141047.14047-1-hannu@varjosoft.com/

 drivers/net/ethernet/google/gve/gve_tx_dqo.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_tx_dqo.c b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
index 616c1921a..ad99cbb77 100644
--- a/drivers/net/ethernet/google/gve/gve_tx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
@@ -595,25 +595,25 @@ static int gve_prep_tso(struct sk_buff *skb)
 	err = skb_cow_head(skb, 0);
 	if (err < 0)
 		return err;
+	shinfo = skb_shinfo(skb);
 
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
 

base-commit: 11536ee3d3e0b1bd35b6f3f8df55a6053eb0c71d
-- 
2.54.0 (Apple Git-157)

