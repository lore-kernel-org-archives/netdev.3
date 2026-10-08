Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B053D3D11
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 12:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791463099; cv=none; b=YvQLU+hsO9b8FwIexPNFf8+yWsEEMzSXPpOV9zGelMl+8kdqFnohlvBqPIaboazpLwG5sNluroQA18ApXKm0DmoA9QO3PrpkLBaglXo5kgWywj2mkonMj3THDvNg8xqF0kBAbwszGaKTDjS3nDng9OpHpgXwHCaRTor4uLqQoNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791463099; c=relaxed/simple;
	bh=uaUgrtOhSdZnks9Rln5dnaL/6PCnkPqMWWVsQqsqfJk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uVz+Wvw1bMmXQo+j0Txwk/hd2fvLtf8jyEubyeTSdnQ7wob/IRCt/rlvthteZUqvQG9zMD1QOG2k5hdcug4fZ2lqgoIHDMOkYWsgfJ3gAy2YBu2ChYPNRDF4RFUbakrlKORgT1PrfrVjC7u/pG2cwcxTT4576r65usVzhNC2Yig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZCxk2F3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZCxk2F3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C6421F000FF;
	Thu,  8 Oct 2026 12:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791463097;
	bh=g7qot7RPgEaAHaBfRpgw0bEL/W8bOXpb51ThKc8rtGE=;
	h=From:To:Cc:Subject:Date;
	b=EZCxk2F38f6VhJKlgmFwjBgDqb7SOzNgbSLq2TuiLyDueq5lwR3/fix3CeHToylu8
	 8zihmvBSboKeh4VRULSxmbVjlxmKUpJrda+M0phSqzILy2B3XRT8Bx3/5bkdmUnLZM
	 OKoTiz3dF9y3oXu6uH0XD7yd3dSmc6ZdiKn6Ex/GyZOFdbntPEMABaWAyuB2m/Sy76
	 UmYGYr7d+CAB0aYMDSETwHOWOY8G+aihirNi2+xAERbQbRKpFjZIqXFs0dN0+lyEtK
	 FhSYfBFfOOkIy1/3iAmCqqi5159WfcISJ6YKFyhj3hpyPmJTvvHqchSA6Yh4ikvQ6z
	 8H/kwlR/wev/g==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Eric Dumazet <edumazet@kernel.org>,
	sairon <sairon@users.noreply.github.com>,
	hitchin999 <hitchin999@users.noreply.github.com>,
	Stefan Agner <stefan@agner.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2 net] vlan: do not insert the vlan header in vlan_dev_hard_header()
Date: Thu,  8 Oct 2026 14:38:11 +0200
Message-ID: <20261008123812.554729-1-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 447cbe95ebb9 ("vlan: fix skb_under_panic and races when toggling
HW VLAN offload") replaced vlan_passthru_header_ops with vlan_header_ops
unconditionally to avoid lockless data races when modifying
hard_header_len dynamically under RTNL.

Prior to that commit, vlan devices on top of a real device capable of
HW VLAN TX offload used vlan_passthru_header_ops, which never inserted
the 802.1Q header in the frame. vlan_header_ops was only used when the
real device had no such offload.

However, vlan_dev_hard_header() retained its legacy path:

	if (!(vlan->flags & VLAN_FLAG_REORDER_HDR)) {
		...
		vhdr = skb_push(skb, VLAN_HLEN);
		...
	}

With vlan_header_ops used unconditionally, creating a VLAN with
reorder_hdr=off (as done by Home Assistant OS / NetworkManager when
flags are omitted over D-Bus) causes vlan_dev_hard_header() to push
an in-band 802.1Q header in software, even if the real device supports
HW VLAN TX offload.

This is a regression for r8169 users (Realtek RTL8168h), who report
transmit queue timeouts (NETDEV WATCHDOG): this NIC stalls when asked
to offload checksum and/or TSO for frames carrying an in-band tag.

Reverting the blamed commit, disabling TX checksum offload (which
also disables TSO), or setting reorder_hdr=on were all reported to
work around the issue.

This insertion is also inconsistent with dev->hard_header_len, which
does not account for VLAN_HLEN.

The in-band insertion is not needed: validate_xmit_vlan() inserts the
tag in software right before ndo_start_xmit() when the real device
lacks HW VLAN TX offload.

Remove it, and make vlan_dev_hard_start_xmit() always set the hwaccel
tag. The (veth->h_vlan_proto != vlan->vlan_proto) test it used to skip
tagging with reorder_hdr=off only made sense together with the
insertion in vlan_dev_hard_header(). Without it, stacked VLANs (Q-in-Q)
and AF_PACKET SOCK_DGRAM frames using ETH_P_8021Q would lose our tag.

The TX path now behaves as it always did with reorder_hdr=on (the
default). VLAN_FLAG_REORDER_HDR only controls whether vlan_do_receive()
reinserts the tag on RX.

Note that AF_PACKET SOCK_RAW users of a reorder_hdr=off VLAN building
frames that already carry our tag will now send them double tagged,
as they would with reorder_hdr=on.

Fixes: 447cbe95ebb9 ("vlan: fix skb_under_panic and races when toggling HW VLAN offload")
Reported-by: sairon <sairon@users.noreply.github.com>
Reported-by: hitchin999 <hitchin999@users.noreply.github.com>
Reported-by: Stefan Agner <stefan@agner.ch>
Closes: https://github.com/home-assistant/operating-system/issues/5019
Closes: https://lore.kernel.org/netdev/CAPa5EdCj3v17tB-SF2JNecq5Q8s1Pranr-XzAFWNpNTBPgPG7w@mail.gmail.com/
Assisted-by: LLM
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>
---
v2: Always set the hwaccel tag in vlan_dev_hard_start_xmit(): with the
    (veth->h_vlan_proto != vlan->vlan_proto) test kept, the outer tag was
    lost for Q-in-Q and SOCK_DGRAM ETH_P_8021Q with reorder_hdr=off
    (reported by sashiko).
v1: https://lore.kernel.org/netdev/20261007073027.459868-1-edumazet@kernel.org/

 net/8021q/vlan_dev.c | 60 ++++++++------------------------------------
 1 file changed, 11 insertions(+), 49 deletions(-)

diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index c949c6a829456c2f75d6c514b35a85ff64c493d8..bd98c191a66f96acc958f52e6fae2337b410ef3b 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -35,11 +35,15 @@
 #include <linux/netpoll.h>
 
 /*
- *	Create the VLAN header for an arbitrary protocol layer
+ *	Create the hard header for an arbitrary protocol layer
  *
  *	saddr=NULL	means use device source address
  *	daddr=NULL	means leave destination address (eg unresolved arp)
  *
+ *  The VLAN tag is not inserted here: vlan_dev_hard_start_xmit() sets
+ *  the hwaccel tag, and the core inserts it in software if the real
+ *  device can not.
+ *
  *  This is called when the SKB is moving down the stack towards the
  *  physical devices.
  */
@@ -49,47 +53,14 @@ static int vlan_dev_hard_header(struct sk_buff *skb, struct net_device *dev,
 				unsigned int len)
 {
 	struct vlan_dev_priv *vlan = vlan_dev_priv(dev);
-	struct vlan_hdr *vhdr;
-	unsigned int vhdrlen = 0;
-	u16 vlan_tci = 0;
-	int rc;
-
-	if (!(vlan->flags & VLAN_FLAG_REORDER_HDR)) {
-		unsigned int hlen = READ_ONCE(dev->hard_header_len) +
-				    READ_ONCE(dev->needed_headroom);
-
-		if (skb_cow_head(skb, hlen) < 0)
-			return -ENOMEM;
-		vhdr = skb_push(skb, VLAN_HLEN);
-
-		vlan_tci = vlan->vlan_id;
-		vlan_tci |= vlan_dev_get_egress_qos_mask(dev, skb->priority);
-		vhdr->h_vlan_TCI = htons(vlan_tci);
-
-		/*
-		 *  Set the protocol type. For a packet of type ETH_P_802_3/2 we
-		 *  put the length in here instead.
-		 */
-		if (type != ETH_P_802_3 && type != ETH_P_802_2)
-			vhdr->h_vlan_encapsulated_proto = htons(type);
-		else
-			vhdr->h_vlan_encapsulated_proto = htons(len);
-
-		skb->protocol = vlan->vlan_proto;
-		type = ntohs(vlan->vlan_proto);
-		vhdrlen = VLAN_HLEN;
-	}
+	struct net_device *real_dev = vlan->real_dev;
 
 	/* Before delegating work to the lower layer, enter our MAC-address */
 	if (saddr == NULL)
 		saddr = dev->dev_addr;
 
 	/* Now make the underlying real hard header */
-	dev = vlan->real_dev;
-	rc = dev_hard_header(skb, dev, type, daddr, saddr, len + vhdrlen);
-	if (rc > 0)
-		rc += vhdrlen;
-	return rc;
+	return dev_hard_header(skb, real_dev, type, daddr, saddr, len);
 }
 
 static inline netdev_tx_t vlan_netpoll_send_skb(struct vlan_dev_priv *vlan, struct sk_buff *skb)
@@ -106,22 +77,13 @@ static netdev_tx_t vlan_dev_hard_start_xmit(struct sk_buff *skb,
 					    struct net_device *dev)
 {
 	struct vlan_dev_priv *vlan = vlan_dev_priv(dev);
-	struct vlan_ethhdr *veth = (struct vlan_ethhdr *)(skb->data);
 	unsigned int len;
+	u16 vlan_tci;
 	int ret;
 
-	/* Handle non-VLAN frames if they are sent to us, for example by DHCP.
-	 *
-	 * NOTE: THIS ASSUMES DIX ETHERNET, SPECIFICALLY NOT SUPPORTING
-	 * OTHER THINGS LIKE FDDI/TokenRing/802.3 SNAPs...
-	 */
-	if (vlan->flags & VLAN_FLAG_REORDER_HDR ||
-	    veth->h_vlan_proto != vlan->vlan_proto) {
-		u16 vlan_tci;
-		vlan_tci = vlan->vlan_id;
-		vlan_tci |= vlan_dev_get_egress_qos_mask(dev, skb->priority);
-		__vlan_hwaccel_put_tag(skb, vlan->vlan_proto, vlan_tci);
-	}
+	vlan_tci = vlan->vlan_id;
+	vlan_tci |= vlan_dev_get_egress_qos_mask(dev, skb->priority);
+	__vlan_hwaccel_put_tag(skb, vlan->vlan_proto, vlan_tci);
 
 	skb->dev = vlan->real_dev;
 	len = skb->len;
-- 
2.53.0

