Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461B0430CCA
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 17:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791395908; cv=none; b=Rm/tFp7v+v2TTpC79P3mak/cy/dLznRVz8pL5WObNDhghTtdeBNrvNg9cJwdCBmi4rqv8ZITJPgOPDGymmiukbZuTO7UhMqvZEmsNUJq7vtMBVLNKSxFR4opbnwYVuAE8eo8L3/GJx/NL/JF3gvEBD5WUOUktcsXx0kpRpb+r0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791395908; c=relaxed/simple;
	bh=Mp07QHO3Rs8Udlyr/Za9T3j9vLxUxD8S3ynso79mBTE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CPWJxE7/bCXjPTb7Oq3RcApn+vTKdg669rpNQX3fEDSwSmUZwPufVEuw4Qr/ZhlqGdoM1UTYwupzLAt7Z9VrahOSXtrQr5WxvCCz7oUoHRCemm5WLbGHAu88/UwXQtMoXc54wdhxOGQFWLaDBB7+4zJ7SRn06f2AdgVuBtSxLaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A6vJR+i9; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6vJR+i9"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-8ac8a2ac52bso26983647b3.0
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 10:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791395906; x=1792000706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Oey5yCw08dubStuWszvMPd3Sd2g9hpqjq3h1IrdDEpU=;
        b=A6vJR+i921YQ/xL/X13Kxm2CFHZQH+8O7QbBjR86RsQgx594XfBqxM9ysPc1Dbr0Hm
         6j2QI4Twj8j8CAq9e86YRvztriVmRzKQw/Bi74vWEL2Fh4JXa6/DR+OS5vYNiuGXZrNN
         4bXAqTI5UvWrLM9lce2iekbEghEndyeK3CcgsBkT8wd6feW1dwYI9Wniariws+SoO56S
         cBZZ1lp08mSLSogVNBci/VjvuT+2Zy/wTzClx6Oovb5/osR561HyL6gxWQ68K05HKddA
         /JYWQRAAuqbOsu+1NbHBol07j0qZq6HVyB+80mFjxGuADqHTJq5xhJkYCytV4o0QxO+C
         ghdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791395906; x=1792000706;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Oey5yCw08dubStuWszvMPd3Sd2g9hpqjq3h1IrdDEpU=;
        b=q1TOW1KMPETWE37XlXWtxAG8xJH3e6QpQ+YUqlkAWgndJPi+Z1n5qbAyNhKz133Qz6
         El5EF5s5avSoSpxPE8xzQjB05nfisoAudvMUZPdInmhZvp52ns8S4KCqjBmdQklDZqpn
         Dx+9CyWMsNPa8xGUcXhT71cXZkvJ7dF8MRaBiz52+LZwzglkQq2pcPE6+gTRXxUB3Uav
         2vq3nKVU+h7e2+fK9XArHjRu9gehMuvUOTazQULZ7NEG7GBX269L6u6nxayPeKFBtREA
         0aGhMSA02LFzuGbr7KUY88GLHVjlt+7ftW2iV83u6FmFXF9oDKFPCi7alS8rffjmk9rO
         +H6Q==
X-Gm-Message-State: AFuF++lLYVawmQ4CyFiK/DU4VWLQ0Ou84mKqjTALwHIAa9RIacnfJkIK
	KejqHCkWLo4jfS5gioekpZ3Hq9pmLuijldE+CRurusljyCqTyO3mWHMjTrknoQ==
X-Gm-Gg: AYBFou0rvSguqDUIOsWIS+HRXUfY9W7AMcyKlG/MEObxoXgyJe9kz4hqq6AFFu6RcIS
	04y+u6DracnCO3cCV3YX7IoqX4q6rwnU85u61W+L2mGt5pSjBsB/c5rePcrPLWjjh3xnFvdD3A0
	lb7XMIX1+HMfBR7Uuw80KOE6QwcAJgaeU9K+FHOc7jFomzyp8AI5Qldzoq38CeM4MnwnZ1dFD3v
	fpwn0U1IZfSLDm1mjMzkBqad+cloULmb4S1epAbqDpIH66fWTbraulBP5jAFWvfgsZbW7et8Bdd
	C4IPe8HE1VLLquUEEOemmuGd8ACVVLcVGprpEUPWyTMrXR1Zpjdr+EbAKSFMNB57JBi/1Aw+ujD
	kuRFHDHd0hzaaoFwtWCvKiBEfM0sLjOrEHAY2COmPKKs13Bg0R3sEnTMLZ5JM17TNetZXzacUXl
	kAiXc/37HOl9uOEJdiIZ5XIzGFVQpJPPVmuyQNQBqQxYVvkD2G9A/2Ay3MnivGftYB20Cccedv2
	904pLc6a7/r2TgLRAuPlUPrhXdOs6ez7v+zjHrDd+dm+YvWtMApG5ufESR43TXK365HPn9OmxJi
	6YPWMELwnxGpOBh4KASRXt8z9XlZUcMjM3HO6QMdDlzgVSioOVdaQ08XjkXV
X-Received: by 2002:a05:690c:2606:b0:8a4:af9c:2612 with SMTP id 00721157ae682-8af720b8ad1mr42562147b3.23.1791395906148;
        Wed, 07 Oct 2026 10:58:26 -0700 (PDT)
Received: from willemb.c.googlers.com.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b05abd093asm11174257b3.37.2026.10.07.10.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 10:58:25 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	mst@redhat.com,
	liuhangbin@gmail.com,
	wei.fang@nxp.com,
	Willem de Bruijn <willemb@google.com>,
	Junnan Zhang <zhangjn_dev@163.com>
Subject: [PATCH net] net/packet: call packet_parse_headers after virtio_net_hdr_to_skb
Date: Wed,  7 Oct 2026 13:57:30 -0400
Message-ID: <20261007175816.3138556-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.56.0.360.g66cac248cb-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

SOCK_RAW packet sockets incorrectly drop VLAN-tagged GSO packets
without VIRTIO_NET_HDR_F_NEEDS_CSUM.

packet_parse_headers() sets skb->protocol to VLAN but advances
skb->network_header past the VLAN tags. virtio_net_hdr_to_skb()
then flow dissects these packets, which parses the network header as a
VLAN tag, and fails.

Call packet_parse_headers() after virtio_net_hdr_to_skb() instead.

This matches tun_get_user() and tap_get_user() and thus simplifies
overall complexity.

Commit 01fdecc0480d ("net: packet: fix wrong transport_header when
sending VLAN-tagged frame") fixed the same issue for the transport
header probe in packet_parse_headers(). That probe is now skipped if
virtio_net_hdr_to_skb() already set the transport header, avoiding a
redundant dissection.

Implementation details:
- Do not set skb->protocol to the RX wildcard ETH_P_ALL. SOCK_RAW then
  derives it from the link layer header, as before. SOCK_DGRAM now
  leaves it 0, or derives it from gso_type for GSO with NEEDS_CSUM.
- Keep virtio_net_hdr_set_proto() last, so that the link layer protocol
  takes priority over gso_type.

Reported-by: Junnan Zhang <zhangjn_dev@163.com>
Closes: https://lore.kernel.org/netdev/20260821085722.24036-1-zhangjn_dev@163.com/
Fixes: dfed913e8b55 ("net/af_packet: add VLAN support for AF_PACKET SOCK_RAW GSO")
Signed-off-by: Willem de Bruijn <willemb@google.com>

---

This was discovered through the report linked in the Closes: tag.

Also independently reported by LLM code reviews as pre-existing issue,
and verified with a reproducer.
---
 net/packet/af_packet.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 6ff16eef24f4..52ae3d875e97 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -1943,8 +1943,7 @@ static void packet_parse_headers(struct sk_buff *skb, struct socket *sock)
 	/* On TX skb->data is the L2 header; anchor it for all socket types. */
 	skb_reset_mac_header(skb);
 
-	if ((!skb->protocol || skb->protocol == htons(ETH_P_ALL)) &&
-	    sock->type == SOCK_RAW)
+	if (!skb->protocol && sock->type == SOCK_RAW)
 		skb->protocol = dev_parse_header_protocol(skb);
 
 	skb_probe_transport_header(skb);
@@ -2614,7 +2613,8 @@ static int tpacket_fill_skb(struct packet_sock *po, struct sk_buff *skb,
 	struct page *page;
 	int err;
 
-	skb->protocol = proto;
+	if (proto != htons(ETH_P_ALL))
+		skb->protocol = proto;
 	skb->dev = dev;
 	skb->priority = sockc->priority;
 	skb->mark = sockc->mark;
@@ -2678,8 +2678,6 @@ static int tpacket_fill_skb(struct packet_sock *po, struct sk_buff *skb,
 	if (unlikely(!skb->len))
 		return -EINVAL;
 
-	packet_parse_headers(skb, sock);
-
 	return tp_len;
 }
 
@@ -2919,9 +2917,13 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 				tp_len = -EINVAL;
 				goto tpacket_error;
 			}
-			virtio_net_hdr_set_proto(skb, &vnet_hdr);
 		}
 
+		packet_parse_headers(skb, po->sk.sk_socket);
+
+		if (has_vnet_hdr)
+			virtio_net_hdr_set_proto(skb, &vnet_hdr);
+
 		uarg = kmalloc(sizeof(*uarg), GFP_KERNEL);
 		if (unlikely(!uarg)) {
 			if (likely(len_sum > 0))
@@ -3122,7 +3124,8 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
 		goto out_free;
 	}
 
-	skb->protocol = proto;
+	if (proto != htons(ETH_P_ALL))
+		skb->protocol = proto;
 	skb->dev = dev;
 	skb->priority = sockc.priority;
 	skb->mark = sockc.mark;
@@ -3131,16 +3134,18 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
 	if (unlikely(extra_len == 4))
 		skb->no_fcs = 1;
 
-	packet_parse_headers(skb, sock);
-
 	if (vnet_hdr_sz) {
 		err = virtio_net_hdr_to_skb(skb, &vnet_hdr, vio_le());
 		if (err)
 			goto out_free;
 		len += vnet_hdr_sz;
-		virtio_net_hdr_set_proto(skb, &vnet_hdr);
 	}
 
+	packet_parse_headers(skb, sock);
+
+	if (vnet_hdr_sz)
+		virtio_net_hdr_set_proto(skb, &vnet_hdr);
+
 	err = packet_xmit(po, skb);
 
 	if (unlikely(err != 0)) {
-- 
2.56.0.360.g66cac248cb-goog

