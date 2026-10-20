Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792478392;
	b=PpclyNm9ORUcCMudxCqmLOk9CsxD50e1C7Ivg19DIwAPCHJpQar/WSK09lfwRSAn1AKJ
	 nfIZWV+qXGZhMr2ETk2LfwlN595d7x9WgZyUBq4SMXWwW9hyjdnTkTjkRvXhIHEyxeT0F
	 PDx6OLA0BzPZaoYtipDOv5Gwx6u5xLPMBpuQtj/LJpGbs+c946GT1aGLxwg2r177pzd92
	 WLhfOG82tNVijtRGJIkSRqwrA7YFq+c6QRWYXZh1OOmjur8Q+z/1Ka54v2HoPPnCtGz5y
	 rKt3lwMbgmEoisrLVp5k02Z5dCO0udFEPhmOcc1sEGeeJqI8UQPV3GGWJok+Kw9RuWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792478392;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=5iI5PNeVbQEUqr3hAZKQHzFxgFEtzpfFqWhPp5m8Sg4=;
	b=saFfDtKcibRq0ENlLNIPm7ZsxlOa7lcVOfwsw/tpCXLlkbxf28unxLBEo644Tttzat3p
	 w9zo4NL1rFPEKFCFbaVaZYx6QpzwYXJYx4zsiXrklz5CjIO/s7YjlxPe6jrltRmvM8EnG
	 MrL/cltgx+IEKCp9l6/GfNxj2Opc/K82tkW02wRG6DVmvHiSvgHalNVB2+ZbY1QEN/yGR
	 EmiNmwMwAzMeonWvQVnyeCJeF5hAP2bE2P7kKOASqOfBVtgdU2zhMA2fn+55VKdOKk7YV
	 VvW0c+xRNcTCoXEzsGeuKz0rhmBmALus6Z8l8v1whcjd3sTv51LU9Y3QH0tChUZHecA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=o+ZwwRGQ;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5166B606A31B
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 06:39:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5166B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=o+ZwwRGQ
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-33fb4680717so5250999eec.1
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 23:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1792478391; x=1793083191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5iI5PNeVbQEUqr3hAZKQHzFxgFEtzpfFqWhPp5m8Sg4=;
        b=o+ZwwRGQGbo7hT8GxhTGav/Iq6/9t1egHoWxi8XXObpNsFt55gM+z4uojT6pWt8awD
         UqXK/fnyh8Y1RyndOt3++ICYV3VWLCio0KCwpqm8p+2TXMY2aaZgE/CIF5WcaWOZm5Jv
         OwA+vG8Zt3EB6uJO5toECXXFBVqfSN82sMYQlDWeDq0b5atCdcS1QaipcN6IT28VZOa+
         +6qoJrQgzLwBwC0CynALEbhX00edKp/NgwZGVqSRcpPrJ2vvz7u4dUm87OMJq/CPlyuj
         C8WfSlV75G28BfUhLk0CyuuFC2GQg4oIlBY6o2tez9Thu7k7U0vOcLFucGnl6uqy9u0k
         2WBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792478391; x=1793083191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5iI5PNeVbQEUqr3hAZKQHzFxgFEtzpfFqWhPp5m8Sg4=;
        b=ojulfFn1ZYRUgS6udoFdpOjT7u4hqSizDii0SjqfSw2V+B4Gj0jMrCOUVQDgXdF5DL
         a1k9okjQZ5ULB9vJsuidcUa3mbKkaiGJUVcHUeiOmY6UfaqLmHkXjIftex2WRw59bojC
         BFSmPQ1643qpk8yCcTPbVHUmvGR3ooQMjklOAgnJe50YF/GUqb7pXi2CK6x8kRKK8yHA
         FCvpudTY0wck1fFoSP1dRVmohuiFkWbHcNVY3uZ/QOkoph8gOitHQIh1oc5R+4algq9T
         3EWvNcNiCzDBdbcWHje+gF/C/hDFpiLz7vBuItooHSeHyNiPRvNwy/O61XC/z/2GK4Lo
         LSxA==
X-Forwarded-Encrypted: i=1; AKwUvBycuM7A6X7c/lLNNiGRmcNPTQ/bB4yZewbBpMwZLPd2sT4Jfa9NxHy2ON85floYDGhtmPi5Cg8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIlL7Uu3X66vAJOhC6quK0fGnLaaN2oJbGGhZWXFEKTJNo7eaXi
	KAsXfbVtmlC1iSYjKyRuchB5RtoluFw6cJLeFHksX8mEoL6AmiUiMTFv4VDmtIbKcGTw
X-Gm-Gg: AYBFou3J+smOxSKqL6mCI8FcIsbhfbHsFgmW/DqQOPdSI/v7+hrhomCFbaa/ERydLpH
	Wi+aqdbIhYrWqjpW5xwhKUiOJtJ7U1GS+lz5kZd6pqzHcNchzfJVbBo1tiL7WXXDvOLcUUtCTPK
	3eRWtXirXzz4Q7BYYeEPKwqkdaeriBvWVlWGAgNired37rJ57lvn36iH5P0XziUrmVEftNx2+ya
	SfMZH3m2FXRpisNCThP1qlP+j92xN9h+RMFZj9FKNv7c8blSG4SgG8cXM/FZRt5y3IoldjPgFBM
	KwooN5EmnD7ogtAbPTzvFxpM5yXx16gfzcG0czC/hjsdNig/p0T7yByfsqgLQ9YY0p5OpEpX2Jv
	O4Vy3gbsDvglJ0t5q6214DQBGoebrO3Pz3DvFI8MzgEb3R+YvvCoGzR6JCwImGKPAcxHbMHADXD
	AQgFPdW3SborcTGQYSv0wXtNnN7FuSN67s+AFIJB1cQYQVmz7RG85/bAPv5OeKu/rgD9XDLBDA/
	DUcU2ReOlqgCw==
X-Received: by 2002:a05:693c:69ce:b0:361:39c0:c393 with SMTP id 5a478bee46e88-361a195a17bmr11944634eec.13.1792478391201;
        Mon, 19 Oct 2026 23:39:51 -0700 (PDT)
Received: from Roxy.sysu.edu.cn ([203.175.14.54])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36081bafa7asm37435014eec.14.2026.10.19.23.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 23:39:50 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: idosch@nvidia.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	horms@kernel.org,
	leone4fernando@gmail.com,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net v6 1/1] ipmr: only copy pktinfo to cache reports
Date: Tue, 20 Oct 2026 14:39:36 +0800
Message-ID: <0545f0c83f5ee2f6696210f87268e811ef655715.1792476357.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1792476357.git.zhilinz@nebusec.ai>
References: <cover.1792476357.git.zhilinz@nebusec.ai>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
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

Clear the report skb control block. Only prepare and copy pktinfo when the
input skb has an IPv4 header. Synthetic route-query skbs use NETLINK_CB,
not IPCB, so leave their report control block zeroed. Restore pkt->cb after
preparing pktinfo for regular IPv4 packets.

Fixes: bb7403655b3c ("ipmr: support IP_PKTINFO on cache report IGMP msg")
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Link: https://lore.kernel.org/netdev/20260903113055.GA90787@shredder/
Suggested-by: Ido Schimmel <idosch@nvidia.com>
Suggested-by: Eric Dumazet <edumazet@google.com>
Assisted-by: LLM
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
---
changes in v6:
- Skip ipv4_pktinfo_prepare() for synthetic route-query skbs, whose cb
  contains NETLINK_CB rather than IPCB, and leave report skb->cb zeroed.
- v5 Link: https://lore.kernel.org/netdev/192b5c65be8b370c1e6e4f6a31edf03d2606f427.1792215075.git.zhilinz@nebusec.ai/

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

 net/ipv4/ipmr.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index b9c544d48c452..6635ea6b9209a 100644
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
@@ -1124,6 +1123,15 @@ static int ipmr_cache_report(const struct mr_table *mrt,
 		skb->transport_header = skb->network_header;
 	}
 
+	memset(skb->cb, 0, sizeof(skb->cb));
+	/* Route queries from ipmr_get_route() carry NETLINK_CB, not IPCB. */
+	if (ip_hdr(pkt)->version) {
+		memcpy(pkt_cb, pkt->cb, sizeof(pkt_cb));
+		ipv4_pktinfo_prepare(mroute_sk, pkt, false);
+		*PKTINFO_SKB_CB(skb) = *PKTINFO_SKB_CB(pkt);
+		memcpy(pkt->cb, pkt_cb, sizeof(pkt_cb));
+	}
+
 	igmpmsg_netlink_event(mrt, skb);
 
 	/* Deliver to mrouted */
-- 
2.55.0

