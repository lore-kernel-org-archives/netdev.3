Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0961939478B
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 05:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792215617; cv=none; b=euV45Rb2ciKuJxp6w73RL1nag08tU5Tjg4181CpPlWXPQMs3RdhLmLA0x9uguuVALAgXU8PKa5lx+vMhjgEXcD4GtbAVKWmXYaRtkpAqMXBSfsi/Sxz+ktzSsiLQho7MA1qPDkWTt8IoHHPQhhX42o8v7Szst+1miy0shXtYtT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792215617; c=relaxed/simple;
	bh=bLBZFFq+QsY6b2TYOCTgWsXMY+fbihZvHe3qDDLidsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lGBavAA5LtFzIIy0+AI/Dw5rtShzEwCSBSRBQ/go6qn4+EwFZ528Z/UoOyMvdpvNHPFl2DRE9QmVmlKkqOwEYXjbqiuzt2np0QttAr2e2SAdTAfQ6LFYHW5xmAC6PjZdZ4gu3mKhbWOpYPJZNuFaIhnuF6og8OZszdu96qBHc94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=GX+ugbtk; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="GX+ugbtk"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3ac7842c17dso398887a91.3
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 22:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1792215615; x=1792820415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VEGaVuZoxEBvnie+d/BeDyIhuqDNHos11nTgT0Y+4y0=;
        b=GX+ugbtkN//64JfXWS2r6R7Umj9PcGbN5VUBeZMQcwLy2WAd+aKzQ4Voeuyz9F10Co
         eH5YVAY9scV/0O+fESI0qQCUlcur/nV99jk4fN4csn1MAObtfjHNAC4OdTk9mOMiNQ4D
         HJER4RG+5eVBatsrLRgESB+htdH88oDa6mb3CPuZaFt661PA1myCGyqmh6U8PjO34h3x
         SBMCgPl++zwui2CIIt3kCFpq+rByaQEvXfHpKbiwn4oceIFTCSruyc72m/Dba2GfRxEs
         ExXyKxbEq72S7+5jkc7hrY41uAdmHdvlGo4pHptoj1vokWNp9nuOBdIQ006wWPP0E61h
         cfxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792215615; x=1792820415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VEGaVuZoxEBvnie+d/BeDyIhuqDNHos11nTgT0Y+4y0=;
        b=uZySp+abOiSwJtcoTeJhsnJCDk3wWjaqWVR25Y7DxyFxzq/8qCWJGq7UX98Vs14Hlf
         a9scXdcE57CXkCOt0obljxJ3tu+go9jz09i9xaoAPmUgFau4coYpNDxqPgmOUG+/Mvbl
         nKrTJlbO09V4ulNFsS6pXVdEvdolTMA+jTNCTcGh9P2I7mTpueQIb1FjSEP0xdtTNedf
         BSJEwJmK+f+X4Mg6sOWvmgN1xxQXCQogXSYS7ZMEBdln72NsDe5Q9od2ZI8AhEApi1yS
         IPYlXd0351GvCJc/aieI6bmtNS/lZaTfbEAcy9OYq+SyxPnaf4XMJ89UkT1JXuvRFmO4
         gMVg==
X-Gm-Message-State: AFq9FYICXyH0T1bUF/cuzByWxac0cbjecL1PmHHZA2why7GCBCpQBo6E
	fR0u8qVCG7Kjo5zlIskuAdvpjjeyQ5L1cWa8TOq1CEbzHfOyN1eCyxezs8FaluQByLxadXwGWOa
	xtOJR/nbC
X-Gm-Gg: AYBFou09DasGsRV4f94WtmVhtUkpVBqt9IT8PULxcnd0CLLD7rJsn0gZZ5ndUJ3tao/
	GIZQ/u3lW4jm/72HkpWKY2pW8MBdN2TjTnaQSTjntDkzzLLUAxEk/O3hI4fcpuxby5uSR0kSYN1
	8SjBVGxYrZORWXjgyMszjXdYlzI0HDCwwQJW0bylymuMY3Frm6zNsocAgk50Vxbzc5Gchqx6XBZ
	MBbaGsvj2+okp0XARQX/l4u0sXH9PHm/By4GeMftU7tpwTYcEUe0d5amM3NGKzoefiCLRO032DV
	85Qj5G/KwUFYIWCB+/CEjzDD6wwfvAmORX/n9WZx2wy5pnh1WFSZOqlt/oFvIF77jcRHoogZZiS
	ziNFv/XdtCZAAifY55cbM2n5RGVHlqvYZ+LKSkpTenD15jeCNEYk84CzTWw0836LdkFpn6F87Rz
	MnMnfo3ZoedML6Ek0lu6f0vCgkILpJys94TehOAQGKYahIkniLLl9QyQF6h18JN68hZX6kOrJ7I
	L2JhNr3HbYcvQ==
X-Received: by 2002:a17:90b:4b8c:b0:3ab:a188:b8ab with SMTP id 98e67ed59e1d1-3acee97ab66mr1704232a91.1.1792215615349;
        Fri, 16 Oct 2026 22:40:15 -0700 (PDT)
Received: from Roxy.sysu.edu.cn ([203.175.14.54])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acd0cde4fdsm3393509a91.4.2026.10.16.22.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 22:40:14 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: netdev@vger.kernel.org,
	idosch@nvidia.com
Cc: dsahern@kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	leone4fernando@gmail.com,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net v5 1/1] ipmr: only copy pktinfo to cache reports
Date: Sat, 17 Oct 2026 13:39:57 +0800
Message-ID: <192b5c65be8b370c1e6e4f6a31edf03d2606f427.1792215075.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1792215075.git.zhilinz@nebusec.ai>
References: <cover.1792215075.git.zhilinz@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ipmr_cache_report() prepares IP_PKTINFO on the original skb. The
ipv4_pktinfo_prepare() helper updates skb->cb and clears the pktinfo fields
when packet info is disabled. Since the skb can continue through the data
path, preserve and restore its original control block around the helper.

The original implementation copies the entire control block to the report
skb. For synthetic RTM_GETROUTE packets, NETLINK_CB data is interpreted as
IPCB by the raw IPv4 receive path. With IP_RECVOPTS or IP_RETOPTS enabled,
corrupted option offsets cause out-of-bounds reads or a stack buffer
overflow. WHOLEPKT and WRVIFWHOLE reports also inherit stale IP option
offsets when their header is prepended.

Clear the report skb control block and copy only the pktinfo fields
prepared by ipv4_pktinfo_prepare(). Doing this after both report branches
preserves the input skb metadata and clears inherited IP options.

Fixes: bb7403655b3c ("ipmr: support IP_PKTINFO on cache report IGMP msg")
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Link: https://lore.kernel.org/netdev/20260903113055.GA90787@shredder/
Suggested-by: Ido Schimmel <idosch@nvidia.com>
Assisted-by: LLM
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
---
changes in v5:
- Save and restore pkt->cb around ipv4_pktinfo_prepare().
- Prepare pktinfo after both report branches, clear skb->cb, and copy only
  the pktinfo fields; this also clears inherited IP options.
- Add the Fixes tag for the older WHOLEPKT/WRVIFWHOLE issue.
- v4 Link: https://lore.kernel.org/netdev/d8a36c317f6216d20f9cfd7e49f1888f62c35f7c.1788417128.git.zhilinz@nebusec.ai/

changes in v4:
- Clear IPCB(skb)->opt when prepending the 20-byte WHOLEPKT/WRVIFWHOLE
  header, so stale option offsets are not inherited from the original packet.
- v3 Link: https://lore.kernel.org/all/e93d0d2fa5725ddd06b20e3e4223ab68b93b48d1.1785719031.git.zhilinz@nebusec.ai/

changes in v3:
- Go back to the v1 scope and stop changing the common path.
- Remove memset(), since alloc_skb() already clears the control block.
- v2 Link: https://lore.kernel.org/all/1b809975e5bd9c0a1dd6fdd1db534e701fe5a4b6.1785379072.git.zhilinz@nebusec.ai/

changes in v2:
- Reword the commit message to say the entire 48-byte skb control block
  is copied.
- Mention that IP_RECVOPTS/IP_RETOPTS on the mrouted socket was unintended.
- Move the pktinfo copy to the common path to cover both report branches.
- v1 Link: https://lore.kernel.org/all/5bc7cd71c2d671b305f25497d88ae8a0aa663c08.1784894076.git.zhilinz@nebusec.ai/

 net/ipv4/ipmr.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index b9c544d48c45..ef0d73e45b70 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -1057,6 +1057,7 @@ static void ipmr_cache_resolve(struct net *net, struct mr_table *mrt,
 static int ipmr_cache_report(const struct mr_table *mrt,
 			     struct sk_buff *pkt, vifi_t vifi, int assert)
 {
+	unsigned char pkt_cb[sizeof(pkt->cb)];
 	const int ihl = ip_hdrlen(pkt);
 	struct sock *mroute_sk;
 	struct igmphdr *igmp;
@@ -1112,8 +1113,6 @@ static int ipmr_cache_report(const struct mr_table *mrt,
 		msg = (struct igmpmsg *)skb_network_header(skb);
 		msg->im_vif = vifi;
 		msg->im_vif_hi = vifi >> 8;
-		ipv4_pktinfo_prepare(mroute_sk, pkt, false);
-		memcpy(skb->cb, pkt->cb, sizeof(skb->cb));
 		/* Add our header.
 		 * Note that code, csum and group fields are cleared.
 		 */
@@ -1124,6 +1123,12 @@ static int ipmr_cache_report(const struct mr_table *mrt,
 		skb->transport_header = skb->network_header;
 	}
 
+	memcpy(pkt_cb, pkt->cb, sizeof(pkt_cb));
+	ipv4_pktinfo_prepare(mroute_sk, pkt, false);
+	memset(skb->cb, 0, sizeof(skb->cb));
+	*PKTINFO_SKB_CB(skb) = *PKTINFO_SKB_CB(pkt);
+	memcpy(pkt->cb, pkt_cb, sizeof(pkt_cb));
+
 	igmpmsg_netlink_event(mrt, skb);
 
 	/* Deliver to mrouted */
-- 
2.55.0

