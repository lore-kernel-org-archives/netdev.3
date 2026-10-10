Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B2239AD55
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 14:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791643876; cv=none; b=mUIDRlSqRpmRmMXR1+4ux6q5dzW5LJhSe+kncYN6/ENDpUBssaEZlBH44nSOUfaOJ/QCH2+lKFnmodo6+VNsDpcHqBhbzzAgylxbRhww+aEYP7VWP8cOv32P0IYULcoOsictMDhTATvzewYTFWyNDr1s664F9TC47B4GvHeUnaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791643876; c=relaxed/simple;
	bh=RkungKTENlB8faBl9z+l7owJ628l7YcD9t0bvfDDNPc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FwXio6v/yrzzoZdwBkDLrZtWe0TKPFzYfS6PP9R3YnBadZmCmLJYyn3iD4vTZYF0YCsXxIdlQxKESzWtUa1uSNJSWKTBTjYG3TWFpeNx0yvcjADJkXQMhP8WQMfPnMfQTnnnzrnf2p9fa8HjHBb1QV8U0o2H44y1vPA/qh3MG5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mupZ5Okz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mupZ5Okz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38BA61F000FF;
	Sat, 10 Oct 2026 14:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791643873;
	bh=sTLWcFEM1yZsaldHXdq9FfCrQoaPyUqLNVEXT8Lt9cI=;
	h=From:To:Cc:Subject:Date;
	b=mupZ5OkzvDKL70xC2Ob3tC+i+fZk2yHdsiSP1djTJvkVqPZle0hd9EnheeOe3elSA
	 TquXNqgLPXXYWN3U0e/jl4rx7+4RUTl4ZdchALe8hWREcRDX9xmAUlAGNt5RbmIuuW
	 NUirnIzhpUfDv1pcev9kioz8gNZmu6bdx6anantDjeWFXv2RPQjz/45CS6o6pFwqw+
	 KadWBz3wzSCeFzCosuMXEhuCVN/Tx3rv/xG5yhsKfZk7Opd+EF1Gxr2oBTgVkLCfXH
	 phGJ0O6oK5fdrV0WDLNqmd8cD6Tynm4oiax7nQ5ejqYEfJcNEVz/l1ina6ke7UbPBx
	 ghOCWTY0uK9Dw==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Eric Dumazet <edumazet@kernel.org>,
	=?UTF-8?q?Jan=20=C4=8Cerm=C3=A1k?= <sairon@sairon.cz>,
	Stefan Agner <stefan@agner.ch>,
	hitchin999 <hitchin999@users.noreply.github.com>,
	Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net v3] vlan: restore HW VLAN tag insertion with reorder_hdr off
Date: Sat, 10 Oct 2026 16:51:06 +0200
Message-ID: <20261010145106.773639-1-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit 447cbe95ebb9 ("vlan: fix skb_under_panic and races when toggling
HW VLAN offload") replaced vlan_passthru_header_ops with vlan_header_ops
unconditionally to avoid lockless data races when modifying
hard_header_len dynamically under RTNL.

Prior to that commit, vlan devices on top of a real device capable of
HW VLAN TX offload used vlan_passthru_header_ops, which never inserted
the 802.1Q header in the frame.

Now, with reorder_hdr=off (as done by Home Assistant OS / NetworkManager
when flags are omitted over D-Bus), vlan_dev_hard_header() always pushes
an in-band 802.1Q header, and vlan_dev_hard_start_xmit() hands the frame
to the real device as is, even if the real device supports HW VLAN TX
offload.

This is a regression for r8169 users (Realtek RTL8168h), who report
transmit queue timeouts (NETDEV WATCHDOG): this NIC stalls when asked
to offload checksum and/or TSO for frames carrying an in-band tag.

Reverting the blamed commit, disabling TX checksum offload (which
also disables TSO), or setting reorder_hdr=on were all reported to
work around the issue.

Keep vlan_dev_hard_header() as is: the in-band header keeps the frame
layout seen at the vlan device egress (taps, tc, netfilter) unchanged,
and is relied upon by stacked vlans (Q-in-Q) and by AF_PACKET SOCK_DGRAM
users sending ETH_P_8021Q frames.

Instead, when vlan_dev_hard_start_xmit() gets a frame carrying an
in-band tag with our protocol and the real device can insert tags,
move that tag to skb->vlan_tci with __skb_vlan_pop(), so that the real
device inserts it. Frames sent on the wire are unchanged, except that
frames shorter than 64 bytes with their tag now get up to 4 bytes of
extra padding, as with reorder_hdr=on and before 447cbe95ebb9.

skb_reset_mac_header() is needed first, because not all ndo_start_xmit()
callers set the mac header (e.g. AF_XDP copy mode, which uses
__dev_direct_xmit()).

vlan_set_encap_proto() may read the two bytes after the vlan header,
so frames shorter than VLAN_ETH_HLEN + 2 are sent unchanged, as before.
Shared skbs (e.g. from pktgen) are also sent unchanged, since popping
the tag modifies the skb.
If pulling or popping the header fails (memory allocation failure),
the frame is dropped and counted in tx_dropped, rather than handing
the real device a frame with an in-band tag.

tx_bytes is now sampled before the pop, so the vlan device statistics
do not change.

This also applies to frames provided by the sender with our tag
(AF_PACKET SOCK_RAW, or frames redirected from another reorder_hdr=off
vlan): the real device now inserts their tag too.

Fixes: 447cbe95ebb9 ("vlan: fix skb_under_panic and races when toggling HW VLAN offload")
Reported-by: Jan Čermák <sairon@sairon.cz>
Closes: https://lore.kernel.org/netdev/CAPa5EdCj3v17tB-SF2JNecq5Q8s1Pranr-XzAFWNpNTBPgPG7w@mail.gmail.com/
Reported-by: Stefan Agner <stefan@agner.ch>
Reported-by: hitchin999 <hitchin999@users.noreply.github.com>
Closes: https://github.com/home-assistant/operating-system/issues/5019
Assisted-by: LLM
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>
---
v3: Different approach. v1 and v2 removed the in-band header built by
    vlan_dev_hard_header(), which changed reorder_hdr=off behavior beyond
    the regression (sashiko). Keep it, and move it to skb->vlan_tci in
    vlan_dev_hard_start_xmit() when the real device can insert it.
    Tested with a veth based selftest (tx-vlan-hw-insert on/off,
    reorder_hdr on/off, Q-in-Q, AF_PACKET SOCK_RAW and SOCK_DGRAM),
    to be sent separately.
    r8169 can still be given in-band tagged frames with checksum or TSO
    offload requested by other paths (e.g. ethtool -K <dev> txvlan off).
    A driver hardening fix for rtl8169_features_check() will follow.
v2: https://lore.kernel.org/netdev/20261008123812.554729-1-edumazet@kernel.org/
v1: https://lore.kernel.org/netdev/20261007073027.459868-1-edumazet@kernel.org/

 net/8021q/vlan_dev.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index c949c6a829456c2f75d6c514b35a85ff64c493d8..684820c772289f1b73aa01255cc9ae5fadae95a9 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -110,6 +110,8 @@ static netdev_tx_t vlan_dev_hard_start_xmit(struct sk_buff *skb,
 	unsigned int len;
 	int ret;
 
+	len = skb->len;
+
 	/* Handle non-VLAN frames if they are sent to us, for example by DHCP.
 	 *
 	 * NOTE: THIS ASSUMES DIX ETHERNET, SPECIFICALLY NOT SUPPORTING
@@ -121,10 +123,34 @@ static netdev_tx_t vlan_dev_hard_start_xmit(struct sk_buff *skb,
 		vlan_tci = vlan->vlan_id;
 		vlan_tci |= vlan_dev_get_egress_qos_mask(dev, skb->priority);
 		__vlan_hwaccel_put_tag(skb, vlan->vlan_proto, vlan_tci);
+	} else if (skb->len >= VLAN_ETH_HLEN + sizeof(__be16) &&
+		   !skb_shared(skb) &&
+		   vlan_hw_offload_capable(READ_ONCE(vlan->real_dev->features),
+					   vlan->vlan_proto)) {
+		u16 vlan_tci;
+
+		/* The frame carries its outer tag in-band, either inserted
+		 * by vlan_dev_hard_header() or provided by the sender.
+		 * Let the real device insert it: some NICs can not offload
+		 * checksum or TSO for frames carrying an in-band tag.
+		 * Not all ndo_start_xmit() callers set the mac header.
+		 * vlan_set_encap_proto() may read two bytes after the vlan
+		 * header, so shorter frames are sent unchanged, as are
+		 * shared skbs (e.g. from pktgen).
+		 * On allocation failure, drop the frame rather than handing
+		 * it to the real device with an in-band tag.
+		 */
+		skb_reset_mac_header(skb);
+		if (unlikely(!pskb_may_pull(skb, VLAN_ETH_HLEN + sizeof(__be16)) ||
+			     __skb_vlan_pop(skb, &vlan_tci))) {
+			kfree_skb(skb);
+			this_cpu_inc(vlan->vlan_pcpu_stats->tx_dropped);
+			return NETDEV_TX_OK;
+		}
+		__vlan_hwaccel_put_tag(skb, vlan->vlan_proto, vlan_tci);
 	}
 
 	skb->dev = vlan->real_dev;
-	len = skb->len;
 	if (unlikely(netpoll_tx_running(dev)))
 		return vlan_netpoll_send_skb(vlan, skb);
 

base-commit: 37f12441f557468a56c1e27790413aa78c82afa2
-- 
2.43.0
