Received: from mail-yx2-f39.google.com (mail-yx2-f39.google.com [74.125.224.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501B945C709
	for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 14:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790431517; cv=none; b=PgnNYUyH1i2hfwxhQgLjRdLbrjtcSm6ZAfNJ0okeR986WXsMDcN4MhSevBYw/Q5ZTZr4CIx1+agWedKvCIfXEIu5fGnV8TcOxXrGu/vZqm9dt8RTaisoSmGeAMhYEPvt/des7MS1UO9XlYj9GSO0j8BIgkTsIebcQeHPq9pTMBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790431517; c=relaxed/simple;
	bh=lQpuo4FGgPmLQs3mAV5SxZ/Lpy+3GOiBj50vxZ6OhZc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=apVHHZda1sOjvs/gt3SQAfJh5wLvLdRJBAtIoUdQI1drMTJHxD/VIKlImP09jkPT8ZUhvYjdYmBmE2zXnlHizReYy6k98u31bMjou6mEpSTxONS7DHBHaTUKHw7Jxb6WLZyhNEBrKVW9D9HMAuS+f+6sXqBWhLkSGgMbuXRqSlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fw8Z6sSt; arc=none smtp.client-ip=74.125.224.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fw8Z6sSt"
Received: by mail-yx2-f39.google.com with SMTP id 00721157ae682-8a9d7f097c2so388517b3.0
        for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 07:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790431512; x=1791036312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tHj/j6Uv8TSALZRcpj1pkMBGD52mXy91EaUjyEl5MY8=;
        b=fw8Z6sStaYk9BV7VVs+e8xByye5PqscNB6WaK3BJN9wjW0ETE+qA/+/Cjqu6WHv1us
         eUJTRI0iTQQYzwAl+dooYiZdm4a15rAQvW5WIWpGInsXK0H1WwgECbRy9er1Tyg5t6zO
         bSd0+1+1W4mmFsPnNfd5ey+1HTgsYNLSxCVUbz2kRhsFtMNoGtv/jVgUm9Yu9aB+PVJc
         m2t4oBZQ7ntrFDnyVq5pHNuHuL0hVyVTHWJIHCIz2i9UNGwNYugsAbXzZaWYeW1KY9jw
         dI6pqPMTHz9k4KoWZlwnFBTfdywSSetW/B8zDG6HLdjOcuOHhSrdIamNeKy6TXBHa0pO
         Ynbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790431512; x=1791036312;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tHj/j6Uv8TSALZRcpj1pkMBGD52mXy91EaUjyEl5MY8=;
        b=HuRPDJDl70gXzPxQ+Fb33Rbci2f4ZTzOUb3x/srqh88gMsNVPCbCdMCVpSi0/ZSagQ
         bfMq/W/LDrfWxIuOecy87qX1zMJL6EaHVY2I/Gbd/VPOZKSo2eP5Vsa7Jtt7Qva3RZdc
         c1hVJrhXYvCJqQTG6C0sd8C+p0t16PZIQfbx01LeiWUYiM1idLeuIDqDyVL8qAzju0ED
         vKrcGXnELp9SEH7BCt6HT7O1+ZFanlG2csmxC8zUuTwLsz8G4GQrjlVAfiAemYyl1Jvt
         74Id9Six1yHS2ZcmnVp+ntzcQ4EN/o48ykycnTY/m6ZkZBQ7ZMxhOUh7EjZwB7AMx6Sq
         8t1g==
X-Gm-Message-State: AFq9FYIfQwsbh6Baqr8WcvHI2hipd1iDYpY9Mj0QCMGQm4F+4DcUm/6U
	/u9OQtwfk9dJAP6A6ta0h252y7aSm0MI84Y2lCaYDYTK8bXFrk+YhkPKQYe4tQ==
X-Gm-Gg: AYBFou0+Y+NO+3QQhIbYiX6rUBsIXhgd8Bp4mnk7zasMB0t//qEgkFd5EXXadsfBjwW
	nOJoqHCIDOEIsxPyPVXkqfO+puZiu8ri5lCtxyCT9JEOSFMnhI7SnjDkCyy9V/7QwmwMswKlnTo
	wJYUpqsDdj4oyXwe9rbMlLCVAGLhK3CGfN2YhToFS1Hgxbq6RpclZhpgc/P1p0LRjEDeTDUdumn
	4cfUYamOdomgt6bDbSclkafHCzjr41jujf/XN3bTZf4W/i04EHwQbAgX/mRWchXUwFdAUXRbjv5
	hadFficXv0U3x0Zcs/uR7j8ZAjziZ2oHBKILzE2Hh5O7nrrSmF1XFNDZxANDhSNzm8S8Jbe2+qB
	OCqby+WmWCHikHIz0HzVV8ibHURpwtaTWW7QrbFR285+8UfUuFBgjRxDEb8E5Scmda63YdK7yKc
	pR8I6zGr9QCXmMyKodFpXGIIrgWAqAvSR01zsTuQ4yduClLlZCROtd1GuiDWBpgWlnWF740ltpI
	OPe9DenhWJhZ7pjyihdUFNUcC26+I4vYrnPktdinhznvp3TvKtNb8LWBkLiN3tXdhWRQkAC9SQ=
X-Received: by 2002:a05:690c:ec7:b0:873:5c6b:a31f with SMTP id 00721157ae682-8a64e7eaa4dmr38576617b3.25.1790431512374;
        Sat, 26 Sep 2026 07:05:12 -0700 (PDT)
Received: from willemb.c.googlers.com.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8a860322637sm20989587b3.4.2026.09.26.07.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 07:05:10 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	xietangxin@yeah.net,
	Willem de Bruijn <willemb@google.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2] net: extend IPv6 exthdr detection of tunneled packets
Date: Sat, 26 Sep 2026 10:04:54 -0400
Message-ID: <20260926140506.2335137-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

Commit c4336a07eb6b ("net: correctly handle tunneled traffic on IPV6_CSUM
GSO fallback") split skb_gso_has_extension_hdr() into mutually exclusive
branches on skb->encapsulation. This did not yet address all paths:

1. With skb->encapsulation set, the outer header is not checked. IPv6
   tunnels such as ip6_gre and ip6_tunnel add an outer Destination
   Options header by default (encap_limit). Their GSO packets skip
   software GSO, then skb_csum_hwoffload_help() sees the outer extension
   header and calls skb_checksum_help() on the GSO skb, which warns and
   drops it.

2. Tunnels over IPv6 without an outer transport header, such as
   ip6_tunnel, leave skb->transport_header at the inner transport
   header. skb_network_header_len() then spans the outer IPv6, tunnel
   and inner IP headers, a false positive.

3. UDP tunnels without an inner network header, such as SCTP-in-UDP or
   PSP, have no inner IPv6 header to check. Decide on the outer header
   alone.

4. Directly dereferencing inner_ip_hdr(skb)->version without
   skb_header_pointer() is unsafe.

Instead, check ipv6_ext_hdr(nexthdr) on the outer IPv6 header and, if
set, on the inner IPv6 header. Read the headers with skb_header_pointer().
Keep the skb_network_header_len() check when !skb->encapsulation to also
catch encapsulated packets without skb->encapsulation (e.g., virtio).

Use the same helper in skb_csum_hwoffload_help(). Its open coded test
has the false positive of (2) and ignores the inner header.

Background: checksum offload of tunneled packets invariants:

Non-GSO skb:
- If the inner packet is CHECKSUM_PARTIAL, Local Checksum Offload computes
  the outer checksum in software and the device offloads only the inner L4
  checksum.
- If the inner packet is CHECKSUM_NONE (e.g., SCTP-in-UDP, ESP-in-UDP,
  Remote Checksum Offload), the device offloads the outer UDP or GRE
  checksum instead.

GSO skb:
- A device with NETIF_F_GSO_UDP_TUNNEL_CSUM or NETIF_F_GSO_GRE_CSUM
  computes both inner and outer checksums per segment.
  The outer checksum is seeded with only the pseudo-header checksum.

A NETIF_F_IPV6_CSUM device must parse through the outer headers to
reach the inner ones.

Fixes: c4336a07eb6b ("net: correctly handle tunneled traffic on IPV6_CSUM GSO fallback")
Cc: stable@vger.kernel.org
Signed-off-by: Willem de Bruijn <willemb@google.com>

---

  v1 -> v2
  - Keep skb_network_header_len() check when !skb->encapsulation to
    support tunnels without skb->encapsulation (e.g., virtio).

  v1: https://lore.kernel.org/netdev/20260924192128.1197118-1-willemdebruijn.kernel@gmail.com/

Stable: trees before commit 1676ebba391d ("net/ipv6: Remove jumbo_remove
step from TX path") must keep the BIG TCP jumbo exemption on the outer
check, or BIG TCP loses TSO (see 68e068cabd2c):

	if (vlan_get_protocol(skb) == htons(ETH_P_IPV6) &&
	    !ipv6_has_hopopt_jumbo(skb)) {
		if (__skb_has_ipv6_ext_hdr(skb, skb_network_offset(skb)))
			return true;

		/* Catch tunnels without skb->encapsulation (e.g., virtio). */
		if (!skb->encapsulation &&
		    skb_transport_header_was_set(skb) &&
		    skb_network_header_len(skb) != sizeof(struct ipv6hdr))
			return true;
	}

Tested with gre_gso.sh over veth with NETIF_F_IPV6_CSUM:
- GREv6 without extension headers
- GREv6 with inner dstopts
- GREv6 with outer encaplimit, and
- SCTP-in-UDPv6.

That needs a test-only feature added to veth to advertise
NETIF_F_IPV6_CSUM (mutually exclusive with NETIF_F_HW_CSUM).

If no one objects, we can follow up with those veth and selftest patches to
net-next later.
---
 net/core/dev.c | 49 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 17 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 0292a16e16c2..91b8a57fad96 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3818,20 +3818,36 @@ static netdev_features_t dflt_features_check(struct sk_buff *skb,
 	return vlan_features_check(skb, features);
 }
 
-static bool skb_gso_has_extension_hdr(const struct sk_buff *skb)
-{
-	if (!skb->encapsulation)
-		return ((skb_shinfo(skb)->gso_type & SKB_GSO_TCPV6 ||
-			 (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
-			  vlan_get_protocol(skb) == htons(ETH_P_IPV6))) &&
-			skb_transport_header_was_set(skb) &&
-			skb_network_header_len(skb) != sizeof(struct ipv6hdr));
-	else
-		return (!skb_inner_network_header_was_set(skb) ||
-			((skb_shinfo(skb)->gso_type & SKB_GSO_TCPV6 ||
-			  (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
-			   inner_ip_hdr(skb)->version == 6)) &&
-			 skb_inner_network_header_len(skb) != sizeof(struct ipv6hdr)));
+static bool __skb_has_ipv6_ext_hdr(const struct sk_buff *skb, int nhoff)
+{
+	const struct ipv6hdr *ip6h;
+	struct ipv6hdr _ip6h;
+
+	ip6h = skb_header_pointer(skb, nhoff, sizeof(_ip6h), &_ip6h);
+	return ip6h && ip6h->version == 6 && ipv6_ext_hdr(ip6h->nexthdr);
+}
+
+static bool skb_has_ipv6_extension_hdr(const struct sk_buff *skb)
+{
+	if (vlan_get_protocol(skb) == htons(ETH_P_IPV6)) {
+		if (__skb_has_ipv6_ext_hdr(skb, skb_network_offset(skb)))
+			return true;
+
+		/* Catch tunnels without skb->encapsulation (e.g., virtio). */
+		if (!skb->encapsulation &&
+		    skb_transport_header_was_set(skb) &&
+		    skb_network_header_len(skb) != sizeof(struct ipv6hdr))
+			return true;
+	}
+
+	/* Tunnels without an inner network header, such as SCTP-in-UDP or
+	 * PSP, have no inner IP header and thus no inner extension header.
+	 */
+	if (skb->encapsulation && skb_inner_network_header_was_set(skb) &&
+	    __skb_has_ipv6_ext_hdr(skb, skb_inner_network_offset(skb)))
+		return true;
+
+	return false;
 }
 
 static netdev_features_t gso_features_check(const struct sk_buff *skb,
@@ -3886,7 +3902,7 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
 	 * so neither does TSO that depends on it.
 	 */
 	if (features & NETIF_F_IPV6_CSUM &&
-	    skb_gso_has_extension_hdr(skb))
+	    skb_has_ipv6_extension_hdr(skb))
 		features &= ~(NETIF_F_IPV6_CSUM | NETIF_F_TSO6 | NETIF_F_GSO_UDP_L4);
 
 	return features;
@@ -3988,8 +4004,7 @@ int skb_csum_hwoffload_help(struct sk_buff *skb,
 		return 0;
 
 	if (features & (NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM)) {
-		if (vlan_get_protocol(skb) == htons(ETH_P_IPV6) &&
-		    skb_network_header_len(skb) != sizeof(struct ipv6hdr))
+		if (skb_has_ipv6_extension_hdr(skb))
 			goto sw_checksum;
 
 		switch (skb->csum_offset) {
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

