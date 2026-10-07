Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E287D361964
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 07:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791358237; cv=none; b=rFptzew3riHsQPoSDsEuXc5DfqpghcM9GC73Ho7KnawSakFbr/zEa6wp7qvfBSJoYEDXdNWolj68Zmj45BUH1ZtYWcpf3+VbiDcA2Sh1VuQv2R9N8hw/8MoOFbrJbFGsCx7VDH4/oLSWhp51lyki8Mg0W2waAA9UYaBqt8DqVNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791358237; c=relaxed/simple;
	bh=iXXGD1V/E+eFdb344QY2Q6mUZE0W6xj3N+eoMtrPsYI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yhvv/pmAHjZRa60IRSm0YrXbPsXUvSwADqz2Ju2+JjPIZYdj1wVZAXxI1CIZ23rg8vzU0XkoA24PBLOEVdMq7o+CJV69MtrD9+yd7ex13XHpYXgplBLGqSe9GEcbU9q1S1o+CJqMHtk/emFjs/8Vcf0l2IkVqZ3zzL0ONMnYHIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KndkQ53y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KndkQ53y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CA111F0089B;
	Wed,  7 Oct 2026 07:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791358235;
	bh=2ITO7PIJX4QQfL5gP+udlgPRGdieCRvJ+j8vobPuEFA=;
	h=From:To:Cc:Subject:Date;
	b=KndkQ53yAVJGlQY4wAV4hDXrNtatSI+QPaDSx8kdiklRwkvT0ziaI/gyCk8ICYdYC
	 RamsMaULKJ4JNNp9bo170WDCMjkhxeQJmT/eEnCre9t4gu8c16VTceGf6EQRu8dYgC
	 uwNC/II7s4BkLEDiq6Mt3EM3gwUkVzYZ3KeNb3qCmmxZ58CXGoG5zJlNJHpgdHmiJJ
	 q5j/TUkmlJHvSGaFd9FTUBfLQkzH2oAdva3jKat4MMfrJDt6zIynyJHqsaFiQhurlF
	 imRaqzRI0McGveckYQT/ZbByYYiip/2+d3OheeGTRldh0OSF6QlW+ak8/26qXKbYjo
	 Nud8PZna6aQPA==
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
Subject: [PATCH net] vlan: do not insert the vlan header in vlan_dev_hard_header()
Date: Wed,  7 Oct 2026 09:30:27 +0200
Message-ID: <20261007073027.459868-1-edumazet@kernel.org>
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

The in-band insertion is not needed: vlan_dev_hard_start_xmit() sets
the hwaccel tag on frames not already carrying the vlan protocol, and
validate_xmit_vlan() inserts it in software right before
ndo_start_xmit() when the real device lacks HW VLAN TX offload.

Remove it, so that vlan_dev_hard_header() behaves like the former
vlan_passthru_hard_header() for all real devices.

Frames sent on the wire are unchanged for real devices without
HW VLAN TX offload.

The (veth->h_vlan_proto != vlan->vlan_proto) test in
vlan_dev_hard_start_xmit() is left unchanged, so that frames already
carrying a vlan header (e.g. sent through AF_PACKET sockets) are
handled as before.

Fixes: 447cbe95ebb9 ("vlan: fix skb_under_panic and races when toggling HW VLAN offload")
Reported-by: sairon <sairon@users.noreply.github.com>
Reported-by: hitchin999 <hitchin999@users.noreply.github.com>
Reported-by: Stefan Agner <stefan@agner.ch>
Closes: https://github.com/home-assistant/operating-system/issues/5019
Closes: https://lore.kernel.org/netdev/CAPa5EdCj3v17tB-SF2JNecq5Q8s1Pranr-XzAFWNpNTBPgPG7w@mail.gmail.com/
Assisted-by: LLM
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
Cc: Heiner Kallweit <hkallweit1@gmail.com>
---
 net/8021q/vlan_dev.c | 43 +++++++------------------------------------
 1 file changed, 7 insertions(+), 36 deletions(-)

diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index c949c6a829456c2f75d6c514b35a85ff64c493d8..c3db1ac23e6a8e0a9eb655ccb547db6cd8139c1d 100644
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
-- 
2.53.0

