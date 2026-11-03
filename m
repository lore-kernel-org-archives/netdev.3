Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793692488;
	b=XUy+zMPku8XMvMRv6TjS14xsjcnF25SvFY6Ax+xy+9+r5inV0uybiNwpyUPtZ1OWpkU2
	 YfNpVLp4TnzgypccGNJdXwquS5deVb9x/WkCvlqz6LCw7IoYksFKVoepo/XnToDTKHLT/
	 eFUSlJk5VHn6cymN8enV+8ESbWTxrDW4zvKtSkqv5DXPAQukx/+06o8Iv4aPuniLlYh1n
	 IVTSQDgfAQTnbIN/poa+lCZ16DXgoQV60KtNjmiufd/C72tElEA6xD443yveNmMLq5cJW
	 HhwsAyX2HDI/rgezqJXnvdkN7qtERK+3lHP8iM74G72vs0EZhHZmPLkVUBsQfwFT4sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793692488;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LrPtbrewofDNM9Dsgj1ZDWN+FRXhLMYsDsPjwvet0xk=;
	b=nxrXrXSRm137HRRWJ+BgrAzU/gI4nMaRwOV7SonU+4r3cvOpAoO9fg2dc6XazwPh83UV
	 V860LxLLEHYLt0JyrOQInS36arsAJ9W+VxWt5mqM20wrrc2vofBGEA40DrJ/9jE41eVZT
	 cFRkrLRGV0w5Pr6edHZmu6vzGpI3GuWPPf6zXP84lNls33gimcXrsOTN6DGcZzW3KGH8I
	 VF66KGUjCgjVyz9xRIVxZrCRuCdiQfthXPnHBHW+G/WDYkThFX1Y1hzYnzPfIqtZtTyam
	 u5HAUlfFRLu55zEKmcGvQCWzt/bOFweOO5iWDZdWb8uNrs2u1ZLrdW/Zdk9ID0ZdgJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="A+NltS/+";
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458CB606A33C
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 07:54:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 458CB606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A+NltS/+
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3b08a162d4bso33446a91.3
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 23:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793692488; x=1794297288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LrPtbrewofDNM9Dsgj1ZDWN+FRXhLMYsDsPjwvet0xk=;
        b=A+NltS/+jPhAYvvzarKlry0yMkwBCxwa5kIiJmNYRVfMUngWtga347Sh8yJbbeLhYz
         Yq6HxUTN4+Ws4hREwp7gh1vXMppzNkZLi+DzTdSUWvwiN2P9Sp1lzabDirQQl/92UWMO
         61yHAIrkcjPdkpglu5bpucX7EGSte0IomLKOBqCREBy31wTF11897YtsMegroXZiDkdb
         ZT7BIXcNUjEsEp0tQdO2B4Gb/WRIhh+KIaKLA73fAOWeGIMZ+NINi2xd9XDzsZfwYlP2
         xIo1A39252rPXDudjX5MjVg6pdfi1TRyg7TLVvA7Bk+ZJG9Tu8wJOfMnQM0FS1sog/IY
         dh3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793692488; x=1794297288;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LrPtbrewofDNM9Dsgj1ZDWN+FRXhLMYsDsPjwvet0xk=;
        b=TP9EgLsHNZbwbfXYTejPMpQYnrqrX/R7Oa60QZh2vcrP4WCukLFSy1qzf9vo5gknHf
         M/3Bf896iaIZh0IkEjm2wTFROzR5SgiveztF9G6KLHyk1K9x52CfTslbCmYYVBHdM4Ai
         iWCtu2fBB8DFTQx60UXyWfqY1gf9K8noPR3gp6Qh632UmqY353FPQggpsP8f2c+pOfp1
         V3juqP1xNvS7PBtHPoRKwO/3L+CV909cb3SSP4ntpsSC8hdgQ9g71W0ikxH/VHK2U4S9
         bTqsD6lHpjZZb+HWB11NuZsig0lMFhE+Bwg/YiUZ/mQSrIV5rPD+0lrMgK8LaQieClda
         SLWA==
X-Forwarded-Encrypted: i=1; AKwUvBywM6jHlf//QzAuR+lMJ8n8LXCQk/S6bWBh7gvcO9XyS1YQ3OqBy992Ce1DZVdjTKe3wSenQe8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9N/rSKOYzDKjBxBAmTf4ZTAXtomn8D8bKBppiPKRYZ+52SpkSV
	WnRdq2pJnAOuTYzHMkPDXYPVmP3dU0JhazpPm7yNhTqNGYyqHNIu+kpY
X-Gm-Gg: AYBFou3TwUFxjG2T2KzQ5z+6IbGg2HKNNIs7T1jKdjuBWg030663eqbW5j1IZDAKFFu
	nlXQZkLguFhat4MGIiEvm9N3AFqtSqQBrwXE+vspJcssoLHM11HfUvzNkoRmhj98WKAITVWI4ao
	qO+jKObnQ7MQAE03DoOaVCPU7tAXvT3/E8d5UA2ES4AxmvU2cFdZg0Qn1di6ri8wA4MxkHu5Jxy
	5EgKoltRyK/GQ3WBxLDYQFOhMNhVroDQ/gjKyy3K81G2KZv94xo8CWFkeEQmJIjEGFYFUWXhH8l
	aEAd9dolmWw+4v+9O/ZpHL1TuiNzbQi6xC3TBb0akbqM6DIL/JkWLh7ihzQxdP9IrQboVSYviBm
	rs9CWQShUZ/xZ8yc8zUIfxdlHzTpkqGVknC4bv15eVfMekmCpTMw93JypilsMFgrElPNYnyzhwM
	qGDL5PZtMLAzqD1CHkNSR9ZwinCBlRxkf6MrS6kwCM56yViu+lfSX08Vdf2Gs7MqrdE8Pd/Gn+/
	EHuAR6Wv7E5htPvMZKf7ueZuITOS8SBd5EmyQy8BA2ZAzHa6bphKNPoGdDvyYV6j7CZNqmQjEnz
	GjcfI5o3MKgfefEdYe473kGmv1V6eevVshShcNoY+bHNxjo6DvhmN8HkKpjHr4EZkq+7Xd72J+u
	Yzs+w/KaFoI64aw==
X-Received: by 2002:a17:90b:57cb:b0:39e:4c81:6c5f with SMTP id 98e67ed59e1d1-3ae897f6192mr10394588a91.26.1793692487076;
        Mon, 02 Nov 2026 23:54:47 -0800 (PST)
Received: from JUNVYYANG-MC1.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb364a987esm829086a12.22.2026.11.02.23.54.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Nov 2026 23:54:46 -0800 (PST)
From: Jun Yang <juny24602@gmail.com>
To: razor@blackwall.org,
	idosch@nvidia.com
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	roopa@cumulusnetworks.com,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	Jun Yang <junvyyang@tencent.com>,
	stable@kernel.org,
	TencentOS Corvus AI <corvus@tencent.com>
Subject: [PATCH net] net: bridge: use one headroom snapshot for ND replies
Date: Tue,  3 Nov 2026 15:54:37 +0800
Message-ID: <20261103075439.43644-1-juny24602@gmail.com>
X-Mailer: git-send-email 2.54.0
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

From: Jun Yang <junvyyang@tencent.com>

br_nd_send() calls LL_RESERVED_SPACE(dev) once to size the reply skb and
again to reserve its headroom. When a port requiring more headroom is
added to the bridge, br_add_if() can increase dev->needed_headroom
between the two calls. The reserved headroom can then exceed the space
accounted for by alloc_skb().

Take one headroom snapshot and use it for both the allocation size and
skb_reserve().

Fixes: ed842faeb2bd ("bridge: suppress nd pkts on BR_NEIGH_SUPPRESS ports")
Cc: stable@kernel.org
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Assisted-by: tencentos-corvus-ai:hy4-preview
Signed-off-by: Jun Yang <junvyyang@tencent.com>
---
A KASAN reproducer for this issue is available if requested.

 net/bridge/br_arp_nd_proxy.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_arp_nd_proxy.c b/net/bridge/br_arp_nd_proxy.c
index 87a40e2f1c50..985ed43f7e30 100644
--- a/net/bridge/br_arp_nd_proxy.c
+++ b/net/bridge/br_arp_nd_proxy.c
@@ -262,6 +262,7 @@ static void br_nd_send(struct net_bridge *br, struct net_bridge_port *p,
 	struct sk_buff *reply;
 	struct ipv6hdr *pip6;
 	int na_olen = 8; /* opt hdr + ETH_ALEN for target */
+	int headroom;
 	int ns_olen;
 	u8 *daddr;
 	bool dad;
@@ -271,7 +272,8 @@ static void br_nd_send(struct net_bridge *br, struct net_bridge_port *p,
 	if (!dev)
 		return;
 
-	len = LL_RESERVED_SPACE(dev) + sizeof(struct ipv6hdr) +
+	headroom = LL_RESERVED_SPACE(dev);
+	len = headroom + sizeof(struct ipv6hdr) +
 		sizeof(*na) + na_olen + dev->needed_tailroom;
 
 	reply = alloc_skb(len, GFP_ATOMIC);
@@ -280,7 +282,7 @@ static void br_nd_send(struct net_bridge *br, struct net_bridge_port *p,
 
 	reply->protocol = htons(ETH_P_IPV6);
 	reply->dev = dev;
-	skb_reserve(reply, LL_RESERVED_SPACE(dev));
+	skb_reserve(reply, headroom);
 	skb_push(reply, sizeof(struct ethhdr));
 	skb_set_mac_header(reply, 0);
 

base-commit: ffdf678dd16610e3f006dac904bd37c09684673c
-- 
2.54.0 (Apple Git-157)

