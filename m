Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E9D3BB694
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 16:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785170705; cv=none; b=jWB62NymNQeBYgvDXQa2LNB6pjRs8U07o71vdZuDygm7x5aMmZ3J5Gy/uUNbx5EPeqV4r9WGBvAwRQ6Dp3F+1UPFpgn9WaK/F/UF/hV4pVY0uo97/QaojLRvbphksz3EDJ/401ONPJ5zv+5E3CmE5GzUDxiNBZW0WoBv1cbjHsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785170705; c=relaxed/simple;
	bh=YCpv2Gylr1hg96LZVxxPUkjdwAY2Pa0wPFyD+ZdvQoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qBX0K7m7uNpNlZZx/NRS7vs3nEwWbPtBXO+2EWRWcYiXvNjq8NVs+MuqI1yIibkp+w2An4XrZYPhOErIOKDcz10Ha5Kvcw/6Vsn2m2EtS7sKdVAYexK0HJdC8PzMlmTsNiWz1rGrw/RiTssg6WzVnicq+uGyIeqND4sgynWgB+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=klvCKW+d; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klvCKW+d"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38deea72eebso3326297a91.1
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 09:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785170703; x=1785775503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+4vveby/rWxBmzcPl8NY8jLfpkAEmRIE+Suel5NtF6s=;
        b=klvCKW+dK16Aqm1mmYGS+ry5IfEELuLR2ZkGXQnMm0WY323agCaXdr0vSTWfD5ErC2
         sm6TnnCoa04IhOeKV7VY2PcTBV8BUuI3NCi0k4fd2wywWGYB1e4sGWPA93E//lCvalI5
         HdLEBlpg6cAgR+/fgRNlN43/SEg2VYPF1XN7zb0sRJxapBy3PMJem48pWZM+vapSN0wq
         evnE0BEWGdfoGxz2psfJzypiPmIu2ovWls+LKPf8SGuLSucf/TSUlzmQY6sCe39QE4pV
         nWIrzdPRPXDMg4ZCWfiQ4u2qf11VrZWK1GUiqm3j6wYJZQ+mdic1I5pgVJwUqonpx+0g
         bNuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785170703; x=1785775503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+4vveby/rWxBmzcPl8NY8jLfpkAEmRIE+Suel5NtF6s=;
        b=ssZHEMU4cPdxe/RC0idcT7Unxvydc8rpxyis2Pqv3iV4iAEbbi4eGOeE+nOSfFyB39
         2Ke4z+dO7JyvGIaE6yfkz/WB1SiLaPIbzuazocvLLp+Uqjq7v/MOoMsh1OqbGndDePcj
         sABkllnmkwpG1mZFE/V/lArRuAr7VPfeJSgidqIs//YjB+z5OD26srpIH9RueM5x3U2P
         IEyBOxvw2eVFPseyEMsIrjuBxEXY5TXKTpm0WgILcMOqS588pD4RE/P2nEHKRMA+Gt2d
         eYP55K4nx+0J+JhU18SU5UNa3Zt1BN0rQ98YGao70Z+p2j8+Gcu1YMC5Erwg0gfq+I6f
         GT+w==
X-Gm-Message-State: AOJu0YzLUT/CL9jYgs8KzrwcqifkHqaxfPfDzCeBgxM7MDQfjvC4ODPg
	SycDWn7Mo0Ry2jLLbiQG/X4OXmbW5HGxIgxvuG+rPnV+QuTXcZoP9nPhTIyMOcfs8qE=
X-Gm-Gg: AR+sD13vfXO10qm+xObjMPbKR+aepFXvddSzyiff9zG3u98vfKriXkJvl/5OVvVEHJb
	cvaXIboGw26I+qLFDSdVGhBWIttUniQcRcqaBZzaTDiiVOSrYYKKpkHM3vakoXCHVXZKfIB0Olv
	BmiiodaiI/N8e6dW97sbM2ldoC09qOt9r9ioGeA1cNFFGK5YMAuCjnxBihNbIq0bELeHa7KFOjl
	JdBokjVQ9VG7djb+IoR57E+fficYWhSE6MMZhU/rGzU26EYOClFpLhK1gdIVLWNPBTbI0l/dRD2
	XniqXPk3y1JgfLTkh9szTPlWuYBvQFL0PDLdtx/sQei6tzGXjy4qw5izflTSpQg7/TwaebLr3vi
	pV9gISNsyqf1GAAxbK1i/7Ty0PHb2G6coARSo7q/6cm5lAqqYaFbMh6N/+knE8ZpoolQpiaeXHf
	d9NHfs0GIktOHkK8gi1eNY
X-Received: by 2002:a17:90b:3c07:b0:38e:3fdc:62e5 with SMTP id 98e67ed59e1d1-38f29535ce4mr8155813a91.19.1785170703317;
        Mon, 27 Jul 2026 09:45:03 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([219.141.235.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f64041358sm122139a91.0.2026.07.27.09.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 09:45:02 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	leone4fernando@gmail.com,
	vega@nebusec.ai,
	zhilinz@nebusec.ai,
	enjou1224z@gmail.com
Subject: [PATCH net 1/1] ipmr: only copy pktinfo to cache reports
Date: Tue, 28 Jul 2026 00:44:49 +0800
Message-ID: <5bc7cd71c2d671b305f25497d88ae8a0aa663c08.1784894076.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1784894076.git.zhilinz@nebusec.ai>
References: <cover.1784894076.git.zhilinz@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhiling Zou <zhilinz@nebusec.ai>

ipmr_cache_report() builds short IGMP reports for mrouted from a packet
that may be a synthetic RTM_GETROUTE query. That query skb stores the
netlink requester portid in NETLINK_CB(), but the report is delivered to
a raw IPv4 socket, whose receive path interprets skb->cb as IPCB().

Commit bb7403655b3c ("ipmr: support IP_PKTINFO on cache report IGMP
msg") added IP_PKTINFO support by calling ipv4_pktinfo_prepare() on the
original packet and then copying the whole control buffer to the report
skb. For synthetic route-query packets, this copies NETLINK_CB bytes
into IPCB and lets a controlled portid corrupt IPCB(skb)->opt. With
IP_RECVOPTS or IP_RETOPTS enabled, the raw socket receive path can then
copy past the short report packet or overflow the stack option buffer.

Keep the IP_PKTINFO support, but initialize the report skb control buffer
and copy only the pktinfo fields prepared by ipv4_pktinfo_prepare().

Fixes: bb7403655b3c ("ipmr: support IP_PKTINFO on cache report IGMP msg")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.6-terra
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
Signed-off-by: Ren Wei <enjou1224z@gmail.com>
---
 net/ipv4/ipmr.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 1d9a4ac14fcef..783de5de02ddd 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -1061,6 +1061,7 @@ static int ipmr_cache_report(const struct mr_table *mrt,
+	struct in_pktinfo *info;
 	struct sock *mroute_sk;
 	struct igmphdr *igmp;
 	struct igmpmsg *msg;
 	struct sk_buff *skb;
 	int ret;
 
@@ -1113,7 +1114,10 @@ static int ipmr_cache_report(const struct mr_table *mrt,
 		msg->im_vif = vifi;
 		msg->im_vif_hi = vifi >> 8;
 		ipv4_pktinfo_prepare(mroute_sk, pkt, false);
-		memcpy(skb->cb, pkt->cb, sizeof(skb->cb));
+		info = PKTINFO_SKB_CB(skb);
+		memset(skb->cb, 0, sizeof(skb->cb));
+		info->ipi_ifindex = PKTINFO_SKB_CB(pkt)->ipi_ifindex;
+		info->ipi_spec_dst = PKTINFO_SKB_CB(pkt)->ipi_spec_dst;
 		/* Add our header.
 		 * Note that code, csum and group fields are cleared.
 		 */
-- 
2.43.0
