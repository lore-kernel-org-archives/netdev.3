Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A70434EF0C
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 16:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791736209; cv=none; b=QZAIm3c+4oy6Zkr1Ge/DaEI3GPnR+3q9yys1BD2gjcflb3muYLprPLflWk6H7dSmnNZ7tOMtMr2Exv6qu83dkpuOlQOdIB3pXtBMs7NWuualKbRbm7d/nCSA1JJ3pIzKbaFdRXlTJnVa35SfkFvb5RD8cxCdiGskOxc7gVjRph4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791736209; c=relaxed/simple;
	bh=WX8vHDmYmID6zeBr7+d02huHyl3ktS0CUyF+dqIWnWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PqwMxwMiNXPzD6+oCuI7f2lrvCcbiyFz/xdeGSW1Hx+3TCZQP48+eGTuW+mL8mvkM4LMFL9DBzdlNHiCcpAAPYsEr1uwKWn0G2JEXahUmSyEYue9H0Sw/leoSRoI4m9znU96xErOqZxGRS/GXlPHOVXLE/99dHP+6Nb5+Y8e1To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de; spf=pass smtp.mailfrom=bairaktaris.de; dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b=A+w2JYf4; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b="A+w2JYf4"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48afcd7ba9bso638345f8f.3
        for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 09:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1791736205; x=1792341005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l5z1jnf6sSEmZnFFBuO6KI3hu21IqBP1eDhtrGsyWbc=;
        b=A+w2JYf4ue8mH+iwSrck5C97l5ZUnARiejL8JPWx8R2nTDPWWXNRN4EwkrfM+Lk3A+
         ZXOMjRuWvunWXFOisfkFYFZfC+KLl1qk0TRk+NWqIVX0RIAnngBIPZzI+52Xm8JtDpA/
         QanJjWgM29nkxb23Ez7KjYiLGVnUl1rxfeDIF9BVFBI1t1Jq+n219Tq4258hyg7pMeaW
         2tt0J3du+l0byAHAgUwO2gpoh7lLiAc3KB1iQBVrA/Qf/JK1AXY8efNuXe/dhS2HpGt/
         A5VsoU8By6g1lFmiqUvMImTwfsvQxPSkFd+4hp4JpYcPQCprY905t/82NO+MG8o+KtrZ
         0wvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791736205; x=1792341005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=l5z1jnf6sSEmZnFFBuO6KI3hu21IqBP1eDhtrGsyWbc=;
        b=AwwhWTZO4svS8byddujwF4pP+3v9Bfrh6PqhwzN9Jm/j9kB6B1RbYdFO/VSB5h/J07
         X6MO7+FSf3aiMskJIT55J4Ky5/zmsBV+5ekElcgHetzKr28QWLQ5ftjlDLsmyfkyxhQG
         giphi1GKjX46vg3KkGfHvxasBw+NFEVMITpEFVFP5H3Bl8Mn4qXmshLvsghMM6OsixAv
         gWfGpDmC6JCROxq0UJB9/qUfGFp18O6+TUqt1Q9EIplGs+ftKLhq4RybbQobV2hIu9am
         q7mtIdbwcfmzkX4xlkCWKO9VhpUItzaD6Aq9HeBIKHSn/75xjjbMRBct+g0GBFMcEToS
         DQmw==
X-Gm-Message-State: AFq9FYLYHwdoazd2rNCurH4MppmtJgHBdTgSNX8nWN4gIxpw5FjyGLMf
	kn8LOw85vfepYznOaiy4RDrvb+sfqC49WAUq4Mk47hIGbpYqivvRhgzB/j3NTMbaYZkXLW2ZjtS
	jdUEVjQ==
X-Gm-Gg: AYBFou0oVm064g49mftZukE/kXKB9gvnYSjYxuhieI9YEHcGaZJ67Nnqm21bIzgLkYq
	MM5Oh5HIu9MciQKqmWTTp2rumZVrT6FEdJvEO8Duq5INviAkN2OH3SDpc9KHIF8U6XuwuNiYAbH
	MiglB+A4Imtv3T87UdFyUOSaFXiGhPm2QuqBGuMwWiJ/A8VwusJs8Z8tSY+tkwsPuiBetW8vkV/
	A8yp8NOvqD2Su0mMNyvZAR09X7m4xppXFiLzRDTmrjIHrlLcplqOV0KW7stYI2YbhYu5kLgDlBU
	S3gUAs2gSs0Hy0zuQVvfAPneK8qOOVh0WstG8d4Lw5jvy8cAGqGliADgDG6qAVTiEHZroADp8Hw
	PDeMNaUPmLQ8L/uoDTTC2EdyfRlfBTQbf1Y84WRuHqt+DPo26Thw1qVAGfjDGlPwmYTFoFxqoif
	7cE2xlZWAOXP1mgOqdgFDqH4RqOQOsSPm/WiiHbK7CX7wa6OJjaTmIIWIYLvOeWt6uAMxw2tCOZ
	NKRJ3EmZw0M+R/2FAxR1Uta73IDTtTIy6H3G2AI6nUN0XyKi8zJwz0FqHaQU0pyuLSWKKWd+sI1
	9CR++M52IGEBC9v3+92umD1INyto5XfJapD75rJEjb+BL4hRkKy17bAgdIlEg1hR3NBTBP49I71
	CTskbmQAj+gK9iNjBF7YoA/n3we+a29iIVd1HWKH8qNksWs33hrE0e0OH8ayEaUmrzQlLzWpuH7
	2Q2/9YAY3ReUhSBolff0UrsPReuh+m6eijMOX2AyN7z+iBfywF
X-Received: by 2002:a05:6000:299c:10b0:48a:fb3e:d93c with SMTP id ffacd0b85a97d-48dba784b80mr9543093f8f.5.1791736204398;
        Sun, 11 Oct 2026 09:30:04 -0700 (PDT)
Received: from Desktop.vpn.uni-hamburg.de (dhcp-40-52.vpn.uni-hamburg.de. [134.100.40.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db9acc936sm14657920f8f.44.2026.10.11.09.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 09:30:03 -0700 (PDT)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	steffen.klassert@secunet.com,
	willemb@google.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 2/3] ipmr: set up GSO state for tunnel vifs
Date: Sun, 11 Oct 2026 18:29:56 +0200
Message-ID: <20261011162957.1328474-3-julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261011162957.1328474-1-julius@bairaktaris.de>
References: <20261011162957.1328474-1-julius@bairaktaris.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ip_encap() pushes the outer IPv4 header but does not set SKB_GSO_IPXIP4,
skb->encapsulation or the inner headers. A GSO packet forwarded to a
VIFF_TUNNEL vif is then rejected by ipip_gso_segment() and dropped in
validate_xmit_skb(), after being counted as sent. A device with UDP
segmentation offload is handed a GSO packet whose transport header
points at the inner IP header.

Call iptunnel_handle_offloads() and skb_set_inner_ipproto() as
ipip_tunnel_xmit() does.

Fixes: 9fd1ff5d2ac7 ("udp: Support UDP fraglist GRO/GSO.")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Julius Bairaktaris <julius@bairaktaris.de>
---
 net/ipv4/ipmr.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index b9c544d48c452..f0666749b14a7 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -1835,12 +1835,17 @@ static struct notifier_block ip_mr_notifier = {
  * This avoids tunnel drivers and other mess and gives us the speed so
  * important for multicast video.
  */
-static void ip_encap(struct net *net, struct sk_buff *skb,
-		     __be32 saddr, __be32 daddr)
+static int ip_encap(struct net *net, struct sk_buff *skb,
+		    __be32 saddr, __be32 daddr)
 {
+	const struct iphdr *old_iph;
 	struct iphdr *iph;
-	const struct iphdr *old_iph = ip_hdr(skb);
 
+	if (iptunnel_handle_offloads(skb, SKB_GSO_IPXIP4))
+		return -1;
+	skb_set_inner_ipproto(skb, IPPROTO_IPIP);
+
+	old_iph = ip_hdr(skb);
 	skb_push(skb, sizeof(struct iphdr));
 	skb->transport_header = skb->network_header;
 	skb_reset_network_header(skb);
@@ -1860,6 +1865,7 @@ static void ip_encap(struct net *net, struct sk_buff *skb,
 
 	memset(&(IPCB(skb)->opt), 0, sizeof(IPCB(skb)->opt));
 	nf_reset_ct(skb);
+	return 0;
 }
 
 static inline int ipmr_forward_finish(struct net *net, struct sock *sk,
@@ -1968,7 +1974,8 @@ static int ipmr_prepare_xmit(struct net *net, struct mr_table *mrt,
 	 * What do we do with netfilter? -- RR
 	 */
 	if (vif->flags & VIFF_TUNNEL) {
-		ip_encap(net, skb, vif->local, vif->remote);
+		if (ip_encap(net, skb, vif->local, vif->remote))
+			return -1;
 		/* FIXME: extra output firewall step used to be here. --RR */
 		DEV_STATS_INC(vif_dev, tx_packets);
 		DEV_STATS_ADD(vif_dev, tx_bytes, skb->len);
-- 
2.53.0

