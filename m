Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E962BFC85
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 11:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791892229; cv=none; b=ImIFzFBcHfPpV/Nnl+aNdsEUpG8EU0lIyjkiLjhBHu8aTb2Q3TEOLCBqzdUxHB9DMkes2g/lHH4euDN6r3kRjNMKtb70r5fBCHIl4Co3WboFUEmDQ9nI0R1KBAFEIi8bq+1//wUTj1RjCk85PPUJGQXYFaC+/hZfCw8ZUwOgtbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791892229; c=relaxed/simple;
	bh=DBTemxiWoOnRAFX2Pwljdb0lwH8+iBX756GwZjJBks4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YOVQ0WDp8uJRl/3YQEhGVQVaPDWKCzy6S/rHY89udSc/gWVeLCjDDJ/zOI4erZBl4NGdMd1oy1NC0BcfwS6LUVCcm3oNBsXAiAuNdWO+j+TyHGn9Cv0t6i1YJXgnx3YKipqn1eHYoarZe6UUb1LPMr2SFnknnYxbSrk5YCSLHJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YLW77vEV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLW77vEV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10F1F1F00898;
	Tue, 13 Oct 2026 11:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791892227;
	bh=e0eDUJaFQo0ItmAwPnAwfvEdf3XKnnNmLxf3oyMhGJ8=;
	h=From:To:Cc:Subject:Date;
	b=YLW77vEV/tklwU9oa5LAhlT2sZQGI6xlli+R1UMccIDBoAEXz5sdTOmgaKh6epO3u
	 e4UubPFoA1FY6SCAMHkb6uMl0kwZgAxEHRYfcTMTFibgyjRGQ80YwEOEPrIAVy8TMl
	 njGFO0EcZPpEHx8wHyWClFl0NNGHdBz5KP+iq3/Ks9dQJ0gvSALs7bXgZPrNNmTfVb
	 lXB26pt/b3tC/KiKbtlzE49lGMtpRz0I6rlK6KStmJ+Jx6estkFkN56mUQYcu20E9d
	 1EpuCy41Yr+xazPFLolb74MoEH7tXZxH4CCuXC4gkxyas0YK7QvSQYcckdA7SVKmRR
	 UiNvUNE9A1lSQ==
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
Subject: [PATCH net v4] vlan: restore HW VLAN tag insertion with reorder_hdr off
Date: Tue, 13 Oct 2026 13:50:22 +0200
Message-ID: <20261013115022.1043024-1-edumazet@kernel.org>
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
Users of r8152 based USB adapters were affected as well.

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
so frames whose linear part is shorter than VLAN_ETH_HLEN + 2 are sent
unchanged, as before. This also makes sure h_vlan_proto, read earlier
in the function, was in the linear part. Shared skbs (e.g. from
pktgen) are also sent unchanged, since popping the tag modifies the
skb, as are skbs already carrying a hwaccel tag (e.g. from generic XDP
redirect), whose tag must not be overwritten, skbs carrying XDP
metadata, which the pop would have to move, and CHECKSUM_PARTIAL skbs
whose csum_start lies within the first VLAN_ETH_HLEN bytes (only
possible with bogus offsets, e.g. from AF_XDP tx metadata), which the
pop would leave before skb->data.
If popping the header fails (memory allocation failure), the frame is
dropped and counted in tx_dropped, rather than handing the real device
a frame with an in-band tag.

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
Tested-by: Jan Čermák <sairon@sairon.cz>
Assisted-by: LLM
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>
---
v4: Use dev_kfree_skb_any() in the drop path, ndo_start_xmit() can run
    with IRQs disabled from netpoll (sashiko).
    Leave alone skbs already carrying a hwaccel tag, skbs carrying XDP
    metadata, skbs whose linear part is too short (this removes the
    pskb_may_pull()), and CHECKSUM_PARTIAL skbs with csum_start inside
    the popped header (sashiko).
    Mention r8152, add Jan's Tested-by (v3 on v6.18.54, r8152 adapter).
v3: https://lore.kernel.org/netdev/20261010145106.773639-1-edumazet@kernel.org/
    Different approach. v1 and v2 removed the in-band header built by
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

 net/8021q/vlan_dev.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index c949c6a829456c2f75d6c514b35a85ff64c493d8..2d775b4c84ce6176431e1264ec6991765bff4443 100644
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
@@ -121,10 +123,39 @@ static netdev_tx_t vlan_dev_hard_start_xmit(struct sk_buff *skb,
 		vlan_tci = vlan->vlan_id;
 		vlan_tci |= vlan_dev_get_egress_qos_mask(dev, skb->priority);
 		__vlan_hwaccel_put_tag(skb, vlan->vlan_proto, vlan_tci);
+	} else if (skb_headlen(skb) >= VLAN_ETH_HLEN + sizeof(__be16) &&
+		   !skb_shared(skb) && !skb_vlan_tag_present(skb) &&
+		   !skb_metadata_len(skb) &&
+		   (skb->ip_summed != CHECKSUM_PARTIAL ||
+		    skb_checksum_start_offset(skb) >= VLAN_ETH_HLEN) &&
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
+		 * header, so frames with a shorter linear part are sent
+		 * unchanged, as are shared skbs (e.g. from pktgen), skbs
+		 * already carrying a hwaccel tag (e.g. from generic XDP
+		 * redirect), skbs carrying XDP metadata, and CHECKSUM_PARTIAL
+		 * skbs whose checksum starts within the header to be popped.
+		 * On allocation failure, drop the frame rather than handing
+		 * it to the real device with an in-band tag.
+		 */
+		skb_reset_mac_header(skb);
+		if (unlikely(__skb_vlan_pop(skb, &vlan_tci))) {
+			dev_kfree_skb_any(skb);
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
