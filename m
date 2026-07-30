Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214D83B5820
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 22:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785450006; cv=none; b=Z1Vp9CCO43k9X1TMJWus0FYoWnsDhV64g44pBQI/ji/4Pb3AL+zy8RLI47D/RudmRO6V6rZt4H2aDLTriKnR10yMHFTerwPurVxrQfGHWFdu0zdDJ/QVbRKHryNbFC9q+irAX+PShW73EhgJkkPdty0cMA2hli5RmzK/HiZrry4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785450006; c=relaxed/simple;
	bh=fhyEAwRgPCc5c916Q+I/wm8pbitZmx4LANPnJJwdpwI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UXHkLTusCDrqdsvvl3QR2PHPFrsxyWQTBrhptlWfE0pX7N7pkrWad5ARBf7oPRtvVzuuc2C2k3xRy8QFgr9Y+ZW9cxcR24MBM7D1bNFuy6qgVunEmBlAjVavTZ0efEQjWE3NON3SyEqXkXUN4P7YP1Lt2anRBWsKVnzwuQCeEiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f4U8FhPF; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f4U8FhPF"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-81ed2a00f12so4971037b3.2
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 15:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785450004; x=1786054804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vB1dn6n1NNKuzBV/L+HJypGV+E1W0vhkQDqiEoxhKgs=;
        b=f4U8FhPFK7nmgo4zzyuz8dpPImyuOG/FlLrCi7r3rrAzrkraIV2dpZ44wZYga8DQWo
         8hhZ1ZTVY201u4ntRjyK7JhUcpdsapmK2LQAVnQmFfjsB4+Bxbjsl9d1q2fLxD/qInYJ
         H1wdyQ3LL4w4vo4VcEyOR7Evl6w+cmqaJMoytIDzp274I9wTf5FiTElYbtmRqW5TlJtK
         X2d6MBe0NA6CNplz7+JVBC+60VEXQm2bHKaDHk6ef3AXux7LMZwpeCZJqLrDRaaObe1R
         MNKVl7vfpO+qSdSunq7bK84SiRJVxfAlA8BVoAlgrt7OHfKAP5v6WEm3HMF76wb2GDxM
         JW1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785450004; x=1786054804;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vB1dn6n1NNKuzBV/L+HJypGV+E1W0vhkQDqiEoxhKgs=;
        b=C1UvoOBy1dzG8WXjPMYbw+Ii/kRYDZn1T7F+iv3xh36iH65oBVTfAQr2R4hYNW+j3/
         sNENUHq5vkJDecioMNC2IQqm0mC/31P1mU+oCfs9tmJFB4h6RnGyR1Ywv9t16QPW9BPK
         VaY6PfmhJLJcJhrxFewrgNEQk4ELJcJI+acX62GeahraUvT196nv6SkOCdPGLBflfB+N
         VoVW6+l3uXA/kwCY+bZ0jls/a1K/taJOhM+9f6nKoZLeXEcottDbFA1nCOMzrgZlkF7N
         i7s1845qxFX6n6JYCIBhwsuu7A0LKYItF3FGURUartT/PWTS/2OPDHthQw9+joggmCvd
         qBvA==
X-Gm-Message-State: AOJu0Yz06/DpPfYBmQgouwIUI5mn+DzQgGCBqWcYNZn87LR9+7ksEakk
	/FwJVIXgy9mSnPorNRq7VFl2d6VR1urFfUO72Uehz82n7WcvmQXMhRc7
X-Gm-Gg: AR+sD11oPq2k+4TnKwVa6nFyt6RJPneIzt9p2FWSG8iX/xncajOjUjG4VxpmNUbY6Ye
	R/lcfsl/rlZU3HiQ40PUeExm4EZWyidtr6OC1JIHV7gu6T9oYFU6b2FlASu9oOPr/33a4CleDJv
	4Bi1U1hvA0pTtJjxBQoO2Ek0bhozllSfb6cGYlWCmfpplvFiXvQZRxWq2qRO5RhqTGl99ItI/Na
	n8PIo1qbKN2bK2xX5XLTlHcWmBOgKdmKvYLbdKs8w/biK22y2NFlDmrDoc2uVRyfgJHUZDExutS
	cnvg7/sWKqBF7sWl4E6HbwiQmE174zX7RDQnmd/oNrF+dcC2GB7dh7O+JnCFvMCCtAqhyc/S52J
	As44TIUP5aHF4mShIfXZxfgHMMv6oTyB8UHFuPLANIiesHdpw0sbuFFnmUy/rppyKybEEu0h5BH
	hKUZnhzAuo0QPGuJnQ/X9ky0UBKl8XPZlT+8aoKbMV7iMTtOlXGuY4kbyZ5+mEXPckuG8/PZh7v
	NDqWkzygqvENws0Kb7pZsFh2+OnchXu20m1NiGUdFZkig3bWKr8JO0XKrM=
X-Received: by 2002:a05:690c:498d:b0:81e:69c7:3536 with SMTP id 00721157ae682-81fb8a39731mr32498237b3.46.1785450003648;
        Thu, 30 Jul 2026 15:20:03 -0700 (PDT)
Received: from LAPTOP-83ECOPAB.localdomain (76-204-101-112.lightspeed.tukrga.sbcglobal.net. [76.204.101.112])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fb8abd448sm18139727b3.34.2026.07.30.15.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 15:20:03 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: aconole@redhat.com,
	echaudro@redhat.com,
	i.maximets@ovn.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	dev@openvswitch.org,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	blbllhy@gmail.com
Subject: [PATCH net v5] net/openvswitch: check Ethernet header length in  key_extract()
Date: Thu, 30 Jul 2026 18:20:06 -0400
Message-ID: <20260730222006.118652-1-blbllhy@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a packet arrives on an ARPHRD_NONE device (e.g. TUN),
ovs_flow_key_extract() trusts the user-provided skb->protocol field: if
it is ETH_P_TEB, the packet is classified as MAC_PROTO_ETHERNET and
key_extract() is called without ensuring the skb has ETH_HLEN (14) bytes
of linear data. key_extract() unconditionally pulls 2 * ETH_ALEN bytes
for MAC addresses and parse_ethertype() pulls 2 more, either of which
triggers a kernel BUG in __skb_pull() when the linear area is too small.

  kernel BUG at include/linux/skbuff.h:2848!
  RIP: 0010:key_extract+0xa7e/0xd90 net/openvswitch/flow.c:933
  ovs_flow_key_extract+0x419/0xa70
  ovs_vport_receive+0x222/0x390
  netdev_frame_hook+0x3e0/0x630
  tun_get_user+0x2d0c/0x38e0

Fixed by calling check_header() in key_extract() before accessing the
Ethernet header.

Fixes: 217ac77a3c25 ("openvswitch: allow L3 netdev ports")
Reported-by: AutonomousCodeSecurity@microsoft.com
Reviewed-by: Eelco Chaudron <echaudro@redhat.com>
Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
---
v5: Separate err declaration and initialization per review.
v4: Update documentation and move variables into the Ethernet block.
v3: Use check_header() per review, fix format issue.
v2: Moved the check into key_extract() per Ilya Maximets.
Link: https://lore.kernel.org/r/20260725043128.193164-1-blbllhy@gmail.com

 net/openvswitch/flow.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/openvswitch/flow.c b/net/openvswitch/flow.c
index 66366982f604..46c1d66aad8c 100644
--- a/net/openvswitch/flow.c
+++ b/net/openvswitch/flow.c
@@ -889,8 +889,6 @@ static int key_extract_l3l4(struct sk_buff *skb, struct sw_flow_key *key)
  * Ethernet header
  * @key: output flow key
  *
- * The caller must ensure that skb->len >= ETH_HLEN.
- *
  * Initializes @skb header fields as follows:
  *
  *    - skb->mac_header: the L2 header.
@@ -910,8 +908,6 @@ static int key_extract_l3l4(struct sk_buff *skb, struct sw_flow_key *key)
  */
 static int key_extract(struct sk_buff *skb, struct sw_flow_key *key)
 {
-	struct ethhdr *eth;
-
 	/* Flags are always used as part of stats */
 	key->tp.flags = 0;
 
@@ -926,6 +922,13 @@ static int key_extract(struct sk_buff *skb, struct sw_flow_key *key)
 		skb_reset_network_header(skb);
 		key->eth.type = skb->protocol;
 	} else {
+		struct ethhdr *eth;
+		int err;
+
+		err = check_header(skb, ETH_HLEN);
+		if (unlikely(err))
+			return err;
+
 		eth = eth_hdr(skb);
 		ether_addr_copy(key->eth.src, eth->h_source);
 		ether_addr_copy(key->eth.dst, eth->h_dest);
-- 
2.53.0

