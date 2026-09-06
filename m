Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81450366074
	for <netdev@vger.kernel.org>; Sun,  6 Sep 2026 22:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788734584; cv=none; b=EH0sJpIuVZxV8UuH7QbpEJ+K20RNOb28HRIrchG8zPZZJyKAK2a6sT7c4OxPH9GPSBWb07SFuj9Rm41Ryy+9YKO8pZcNr8tgXLl8+rwoz+WYYjzhHLWJxW/dlUGrC5YTvqXldsSDYtaHcF3iZJYfWKclRAR+VAIZcvzpcmjfUjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788734584; c=relaxed/simple;
	bh=gCMXErSOeYLLzDQ+jVcZw7bXtMUiDJXA+EfPOxQUYzs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XCE75mIm1j6+8ai+n9X+2hM5Mf34R0rnLMS7w47p8fMyA6p7NNLq3G/SttRmpZRVaRi6XU9+mW9Gb0h5ZeK4nuDgJV53yjVf6xP7tSGYJd1GKM/wE9tdOMKWF/0Jl3ieiCpMmS8g4e9Ricen7Sz+ROh672MhOfS2zVdt6Rfwc2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EQpTtO15; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQpTtO15"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5b523efb0bfso1553916e87.3
        for <netdev@vger.kernel.org>; Sun, 06 Sep 2026 15:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788734580; x=1789339380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4DyD2qirhTY5+nrRt4G0eEDykYAeKeTbEAO/xch2DGw=;
        b=EQpTtO15ffGUepntdTIFCdK85z/E2kvPYBHIw1qaBXg5FD+5DpqTdXohhAG36/UVg6
         H/MBYX2cj0PG8Rmmh45EX4M8+bJvYTqvWrX57f5uKQs8f3w/v8kcZQVXc3DhjOBcSn8H
         Dx4F6sF+u4z1sNFAP6qWF1KJz6rbwPSGh8vv6L9rz7Kc7+itQRNSugVRZ3+ebWyhm+Sb
         USye6q+/VLxxZLnntLf5zPLL4Q2p9b8gVbRAlgnF7he3q+7aQgWjYc/DW/QK7Uu8yh+M
         O6cLlDcpO+7bvfJoT2AIstMp+lJ/2DXSEWEdCa7hJ9gz+OXRWfH8ODM1nIM0ArYrAV5z
         sjZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788734580; x=1789339380;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4DyD2qirhTY5+nrRt4G0eEDykYAeKeTbEAO/xch2DGw=;
        b=pRaPYPyj05EtJn+l3kl2MF1vsLpaO/uYdsy9PF95qIN+05WbQnIqdTDKBoxOlGBY+p
         zDm0MXI0Ech5SFE/0qFPoHmTW7BzMW5T0SQfSO+KbQe5aWso+OdqvE1J0gLG5eSx9He1
         W6bUsgqu0qqi/tlo1x4NVbGfGzP932XhjOkF51dc96qThygTCRQdlef931KQvOBRJ44K
         2JEKsrVf5r4yEpAHuisalxo0JTI3WKIxOsNdx4C30e8l4eSanGTto+9SsK2MrSTgryHI
         rw+OPsvIR2pAQJsYTkI2TGqh9zxqmtPCW2MadqJBDxJu1xKGymsP+wy/vyiVGkgybBxf
         JUbw==
X-Gm-Message-State: AFuF++kGpwgkUxa8Y5nj2VCiV8mHVxNEFM5LUt7fxj9HjrdmbeC3+HCM
	EJlgvj5tREonmTviNYTocJoyzRIZLJ8Ev8iIu1CHAwaBoJCE7ZD0YHee6pqOpw==
X-Gm-Gg: AYBFou3Jd60o789qXi2nFUHPOibqGsp++3HhYIvJObROhMo+6zmN6h3/la08ahOvkjn
	U1MrklwkGqVVIP94FdsK2sTgK0fMwsUoYhlDAEgj/Wnf0O9YkYGPlP5xgqLnWRMK6xYQ/k2FAiN
	HkhpQ6e5sDphK0fDNPaD9B6b+eLPQCuAuIur1A6Wnze+M99m12Bwo72n7AWZ9bQTLsO7RCTXExJ
	RzxTgfKYf36glZf097N0DIABP6aMnr2NTFc47QGd1MyiSao1Npy+oCGg0dLaKIiij3g5KwQEIii
	dyW2E1xDkcTDeJWAMFSgdJ5+ftH+beVOsNRISW7L3AzzmmNULOoR08cXkkUy9mGqmcsQLB9O7is
	PR9R/b42ngI/mHyfNirfw59quGxHMTHjqNdvDl4QTArWXTUGi+oXsJR0JAsPLQl2dWyivXO0Srk
	ZKN5AhE17ogKFo4uwQOQhG4+LFqhcEWscCDhYgHiyz3pothhYBAgoDAc+Alnh7sfFuAC/n7M4vt
	JjG1xpq7GnbrEEmrP8SXrt0AiJ097afozA7EMVxNkdSwKc3xJw46VZ/QQ==
X-Received: by 2002:a05:6512:a88:b0:5ae:bd5e:95f7 with SMTP id 2adb3069b0e04-5b616ed488cmr5806877e87.4.1788734580102;
        Sun, 06 Sep 2026 15:43:00 -0700 (PDT)
Received: from localhost.localdomain (46-138-187-224.dynamic.spd-mgts.ru. [46.138.187.224])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b6167097cesm1838889e87.70.2026.09.06.15.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 15:42:59 -0700 (PDT)
From: Artem Lytkin <iprintercanon@gmail.com>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux.dev,
	razor@blackwall.org,
	idosch@nvidia.com,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	davem@davemloft.net,
	corbet@lwn.net,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: bridge: bound the port VLAN lists in the IFLA_AF_SPEC nest
Date: Mon,  7 Sep 2026 01:42:46 +0300
Message-ID: <20260906224246.21719-1-iprintercanon@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

br_fill_ifinfo() opens one IFLA_AF_SPEC nest, fills it with the VLAN
information of a bridge port and closes it with nla_nest_end(), which
stores the accumulated length into nla_len. That field is a u16, so for
a nest larger than 65535 bytes the stored length wraps modulo 65536.
The encoding has never been able to describe more than that; nothing
regressed.

Three per-VLAN lists share the one nest. An IFLA_BRIDGE_VLAN_INFO costs
8 bytes, an IFLA_BRIDGE_VLAN_TUNNEL_INFO 28 and an IFLA_BRIDGE_MST_ENTRY
20, on every architecture. A port takes at most 4094 VLANs, so the VLAN
list alone is at most 32752 bytes, but the other two reach 65535: 2341
tunnel mappings that are not consecutive in both VID and tunnel id, or
1821 with uncompressed VLAN information requested alongside, or 3277
distinct MSTIs. A VXLAN leaf switch with one VXLAN device maps thousands
of VLANs to VNIs, and "bridge vlan tunnelshow" and "bridge mst show"
read these lists through the link dump.

Nothing fails on the way there. br_get_link_af_size_filtered() accounts
for all three lists and feeds both rtnl_calcit() for RTM_GETLINK dumps
and nlmsg_new() in br_info_notify(), so the skb is large enough and no
nla_put() fails. Userspace then walks the message with RTA_NEXT(),
which advances by the stored length, so parsing resumes inside VLAN
payload and everything after the nest is read out of it. A
CONFIG_DEBUG_NET kernel warns once, in nla_nest_end(), via the check
added in commit ff205bf8c554 ("netlink: add one debug check in
nla_nest_end()").

Measured on a port with 4093 VLAN to VNI mappings: the RTM_GETLINK reply
for the port is 147776 bytes and carries an IFLA_AF_SPEC nla_len of
16280, and the top level attribute walk derails 16672 bytes in. The
notification path is worse, because it broadcasts. A port flag change
goes through br_ifinfo_notify(), which asks for compressed VLAN
information, and the resulting RTM_NEWLINK is 115048 bytes with an
nla_len of 49088; walking it yields 2342 attributes after the nest,
2341 of them read as IFLA_IFNAME, since IFLA_BRIDGE_VLAN_TUNNEL_INFO and
IFLA_BRIDGE_VLAN_TUNNEL_FLAGS carry the same numeric type. Every
RTNLGRP_LINK listener in the netns receives that. The DEBUG_NET warning
fired from br_fill_ifinfo() while the mappings were being added, in the
context of the process adding them, since each addition notifies too.

Bound the three lists by length: stop adding entries once the next one
would not fit in 65535 bytes, counted from the start of the nest so that
the lists and the inner IFLA_BRIDGE_MST nest share the budget, and
charge a range at its real cost of one or two entries. This is what
commit bdd39576bf50a ("net: bridge: prevent too big nested attributes
in br_fill_linkxstats()") did for the sibling nest in this file. A fixed
cap on the number of entries, as IFLA_VFINFO_LIST got in
commit 51e15308c6ae ("rtnetlink: cap IFLA_VFINFO_LIST at a documented
number of VFs"), does not fit here: the lists share one nest, 4094 VLAN
entries take half of it and 2340 tunnel entries fill it, so any set of
per-list caps that is safe in the worst case cuts configurations that
are described correctly today. The byte budget regresses none of them,
and it is still a limit userspace can compute, since the per-entry
costs are fixed. Documentation/networking/bridge.rst states them, along
with the RTM_GETVLAN interface that does not have this limit.

The MRP and CFM lists that br_fill_ifinfo() emits for the bridge device
itself are not touched. They live in the same nest but never next to
the port lists, and CFM peer status can grow past the limit on its own;
that is a separate change.

br_get_link_af_size_filtered() clamps the three lists to the same 65535
bytes, so a dump of such a port no longer sizes the skb at 147 KB for a
nest that holds 64 KB, and br_info_notify() no longer makes an
oversized GFP_ATOMIC allocation from STP timer context for a message
that would be truncated anyway. The clamp cannot cut into the MRP and
CFM information: for the bridge device the VLAN list is the only one of
the three and stays under 33 KB.

With the bound, the same port dumps as 65932 bytes with an nla_len of
65508, the notification is 65936 bytes with 65512, both walk to the
end, and nothing warns. A port above the bound reports shortened lists,
so "bridge vlan tunnelshow" and "bridge mst show" print the first
entries and stop instead of printing garbage, and the rest of the
message parses. Read such a port with RTM_GETVLAN, which gives each
entry its own attribute and continues in a new message once one fills
up.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Artem Lytkin <iprintercanon@gmail.com>
---
 Documentation/networking/bridge.rst | 17 ++++++++++
 net/bridge/br_mst.c                 | 12 +++----
 net/bridge/br_netlink.c             | 49 ++++++++++++++++++++++++-----
 net/bridge/br_netlink_tunnel.c      | 20 ++++++++++--
 net/bridge/br_private.h             | 23 ++++++++++++--
 net/bridge/br_private_tunnel.h      |  2 +-
 6 files changed, 104 insertions(+), 19 deletions(-)

diff --git a/Documentation/networking/bridge.rst b/Documentation/networking/bridge.rst
index c1e6ea52c9e59..49403fb4938b4 100644
--- a/Documentation/networking/bridge.rst
+++ b/Documentation/networking/bridge.rst
@@ -41,6 +41,23 @@ Bridge port netlink attributes
 .. kernel-doc:: include/uapi/linux/if_link.h
    :doc: Bridge port enum definition
 
+Size limit of the bridge IFLA_AF_SPEC attribute
+-----------------------------------------------
+
+An ``AF_BRIDGE`` RTM_GETLINK reply and an RTM_NEWLINK notification describe
+the VLANs of a port inside a single IFLA_AF_SPEC attribute. A netlink
+attribute length is a u16, so that one attribute can hold at most 65535
+bytes, and the three lists it carries share the budget: an
+IFLA_BRIDGE_VLAN_INFO costs 8 bytes, an IFLA_BRIDGE_VLAN_TUNNEL_INFO 28 and
+an IFLA_BRIDGE_MST_ENTRY 20, on every architecture. A port with a few
+thousand VLAN tunnel mappings or MST entries therefore does not fit. The
+kernel stops adding entries when the attribute is full, so such a port
+reports shortened lists while the rest of the message stays parsable.
+
+RTM_GETVLAN gives each VLAN entry its own attribute and continues in a new
+message once one fills up, so it has no such limit. Use it to read the VLAN
+and VLAN tunnel configuration of a port that is large enough to hit this.
+
 Bridge sysfs
 ------------
 
diff --git a/net/bridge/br_mst.c b/net/bridge/br_mst.c
index 43a300ae6bfaf..be71df10c73d1 100644
--- a/net/bridge/br_mst.c
+++ b/net/bridge/br_mst.c
@@ -252,12 +252,7 @@ size_t br_mst_info_size(const struct net_bridge_vlan_group *vg)
 		if (test_bit(v->brvlan->msti, seen))
 			continue;
 
-		/* IFLA_BRIDGE_MST_ENTRY */
-		sz += nla_total_size(0) +
-			/* IFLA_BRIDGE_MST_ENTRY_MSTI */
-			nla_total_size(sizeof(u16)) +
-			/* IFLA_BRIDGE_MST_ENTRY_STATE */
-			nla_total_size(sizeof(u8));
+		sz += BR_MST_ENTRY_SIZE;
 
 		__set_bit(v->brvlan->msti, seen);
 	}
@@ -265,7 +260,7 @@ size_t br_mst_info_size(const struct net_bridge_vlan_group *vg)
 	return sz;
 }
 
-int br_mst_fill_info(struct sk_buff *skb,
+int br_mst_fill_info(struct sk_buff *skb, const struct nlattr *af,
 		     const struct net_bridge_vlan_group *vg)
 {
 	DECLARE_BITMAP(seen, VLAN_N_VID) = { 0 };
@@ -277,6 +272,9 @@ int br_mst_fill_info(struct sk_buff *skb,
 		if (test_bit(v->brvlan->msti, seen))
 			continue;
 
+		if (!br_af_spec_has_room(skb, af, BR_MST_ENTRY_SIZE))
+			break;
+
 		nest = nla_nest_start_noflag(skb, IFLA_BRIDGE_MST_ENTRY);
 		if (!nest ||
 		    nla_put_u16(skb, IFLA_BRIDGE_MST_ENTRY_MSTI, v->brvlan->msti) ||
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index b2cd4e39326d0..643ae06f7df8c 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -20,6 +20,17 @@
 #include "br_private_tunnel.h"
 #include "br_private_mcast_eht.h"
 
+/* IFLA_BRIDGE_VLAN_INFO */
+#define BR_VLAN_INFO_SIZE	nla_total_size(sizeof(struct bridge_vlan_info))
+
+/* br_fill_ifvlaninfo_range() emits one entry for a single VLAN and two,
+ * marked RANGE_BEGIN and RANGE_END, for a range.
+ */
+static size_t br_vlan_range_size(u16 vid_start, u16 vid_end)
+{
+	return (vid_end > vid_start ? 2 : 1) * BR_VLAN_INFO_SIZE;
+}
+
 static int __get_num_vlan_infos(struct net_bridge_vlan_group *vg,
 				u32 filter_mask)
 {
@@ -117,11 +128,19 @@ static size_t br_get_link_af_size_filtered(const struct net_device *dev,
 		vinfo_sz += br_get_vlan_tunnel_info_size(vg);
 
 	/* Each VLAN is returned in bridge_vlan_info along with flags */
-	vinfo_sz += num_vlan_infos * nla_total_size(sizeof(struct bridge_vlan_info));
+	vinfo_sz += num_vlan_infos * BR_VLAN_INFO_SIZE;
 
 	if (p && vg && (filter_mask & RTEXT_FILTER_MST))
 		vinfo_sz += br_mst_info_size(vg);
 
+	/* These three lists share the IFLA_AF_SPEC nest, whose length is a
+	 * u16, and br_fill_ifinfo() stops once it is full. Do not size the
+	 * skb for entries that will not be emitted. The CFM size below is
+	 * only added for the bridge device, which carries no tunnel or MST
+	 * entries and so stays far below the clamp.
+	 */
+	vinfo_sz = min_t(size_t, vinfo_sz, U16_MAX);
+
 	if (!(filter_mask & RTEXT_FILTER_CFM_STATUS))
 		return vinfo_sz;
 
@@ -366,6 +385,7 @@ static int br_fill_ifvlaninfo_range(struct sk_buff *skb, u16 vid_start,
 }
 
 static int br_fill_ifvlaninfo_compressed(struct sk_buff *skb,
+					 const struct nlattr *af,
 					 struct net_bridge_vlan_group *vg)
 {
 	struct net_bridge_vlan *v;
@@ -395,6 +415,11 @@ static int br_fill_ifvlaninfo_compressed(struct sk_buff *skb,
 			vid_range_end = v->vid;
 			continue;
 		} else {
+			if (!br_af_spec_has_room(skb, af,
+						 br_vlan_range_size(vid_range_start,
+								    vid_range_end)))
+				return 0;
+
 			err = br_fill_ifvlaninfo_range(skb, vid_range_start,
 						       vid_range_end,
 						       vid_range_flags);
@@ -408,7 +433,9 @@ static int br_fill_ifvlaninfo_compressed(struct sk_buff *skb,
 		vid_range_flags = flags;
 	}
 
-	if (vid_range_start != 0) {
+	if (vid_range_start != 0 &&
+	    br_af_spec_has_room(skb, af, br_vlan_range_size(vid_range_start,
+							    vid_range_end))) {
 		/* Call it once more to send any left over vlans */
 		err = br_fill_ifvlaninfo_range(skb, vid_range_start,
 					       vid_range_end,
@@ -420,7 +447,7 @@ static int br_fill_ifvlaninfo_compressed(struct sk_buff *skb,
 	return 0;
 }
 
-static int br_fill_ifvlaninfo(struct sk_buff *skb,
+static int br_fill_ifvlaninfo(struct sk_buff *skb, const struct nlattr *af,
 			      struct net_bridge_vlan_group *vg)
 {
 	struct bridge_vlan_info vinfo;
@@ -432,6 +459,9 @@ static int br_fill_ifvlaninfo(struct sk_buff *skb,
 		if (!br_vlan_should_use(v))
 			continue;
 
+		if (!br_af_spec_has_room(skb, af, BR_VLAN_INFO_SIZE))
+			break;
+
 		vinfo.vid = v->vid;
 		vinfo.flags = 0;
 		if (v->vid == pvid)
@@ -536,12 +566,12 @@ static int br_fill_ifinfo(struct sk_buff *skb,
 			goto done;
 		}
 		if (filter_mask & RTEXT_FILTER_BRVLAN_COMPRESSED)
-			err = br_fill_ifvlaninfo_compressed(skb, vg);
+			err = br_fill_ifvlaninfo_compressed(skb, af, vg);
 		else
-			err = br_fill_ifvlaninfo(skb, vg);
+			err = br_fill_ifvlaninfo(skb, af, vg);
 
 		if (port && test_bit(BR_VLAN_TUNNEL_BIT, &port->flags))
-			err = br_fill_vlan_tunnel_info(skb, vg);
+			err = br_fill_vlan_tunnel_info(skb, af, vg);
 		rcu_read_unlock();
 		if (err)
 			goto nla_put_failure;
@@ -600,11 +630,16 @@ static int br_fill_ifinfo(struct sk_buff *skb,
 		if (!vg || !vg->num_vlans)
 			goto done;
 
+		/* Do not open the nest unless one entry can follow it */
+		if (!br_af_spec_has_room(skb, af,
+					 nla_total_size(0) + BR_MST_ENTRY_SIZE))
+			goto done;
+
 		mst_nest = nla_nest_start(skb, IFLA_BRIDGE_MST);
 		if (!mst_nest)
 			goto nla_put_failure;
 
-		err = br_mst_fill_info(skb, vg);
+		err = br_mst_fill_info(skb, af, vg);
 		if (err)
 			goto nla_put_failure;
 
diff --git a/net/bridge/br_netlink_tunnel.c b/net/bridge/br_netlink_tunnel.c
index e7eceab5b515d..8c8232618fbff 100644
--- a/net/bridge/br_netlink_tunnel.c
+++ b/net/bridge/br_netlink_tunnel.c
@@ -145,7 +145,16 @@ static int br_fill_vlan_tinfo_range(struct sk_buff *skb,
 	return 0;
 }
 
-int br_fill_vlan_tunnel_info(struct sk_buff *skb,
+/* br_fill_vlan_tinfo_range() emits one entry for a single VLAN and two,
+ * marked RANGE_BEGIN and RANGE_END, for a range.
+ */
+static size_t br_vlan_tinfo_range_size(const struct net_bridge_vlan *vtbegin,
+				       const struct net_bridge_vlan *vtend)
+{
+	return (vtend->vid > vtbegin->vid ? 2 : 1) * __get_vlan_tinfo_size();
+}
+
+int br_fill_vlan_tunnel_info(struct sk_buff *skb, const struct nlattr *af,
 			     struct net_bridge_vlan_group *vg)
 {
 	struct net_bridge_vlan *vtbegin = NULL;
@@ -169,6 +178,11 @@ int br_fill_vlan_tunnel_info(struct sk_buff *skb,
 			vtend = v;
 			continue;
 		} else {
+			if (!br_af_spec_has_room(skb, af,
+						 br_vlan_tinfo_range_size(vtbegin,
+									  vtend)))
+				return 0;
+
 			err = br_fill_vlan_tinfo_range(skb, vtbegin, vtend);
 			if (err)
 				return err;
@@ -178,7 +192,9 @@ int br_fill_vlan_tunnel_info(struct sk_buff *skb,
 		vtend = v;
 	}
 
-	if (vtbegin) {
+	if (vtbegin &&
+	    br_af_spec_has_room(skb, af,
+				br_vlan_tinfo_range_size(vtbegin, vtend))) {
 		err = br_fill_vlan_tinfo_range(skb, vtbegin, vtend);
 		if (err)
 			return err;
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index d337b1cfb980d..55dfa44269c90 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1954,6 +1954,13 @@ static inline bool br_vlan_state_allowed(u8 state, bool learn_allow)
 #endif
 
 /* br_mst.c */
+/* IFLA_BRIDGE_MST_ENTRY, holding IFLA_BRIDGE_MST_ENTRY_MSTI and
+ * IFLA_BRIDGE_MST_ENTRY_STATE
+ */
+#define BR_MST_ENTRY_SIZE	(nla_total_size(0) + \
+				 nla_total_size(sizeof(u16)) + \
+				 nla_total_size(sizeof(u8)))
+
 #ifdef CONFIG_BRIDGE_VLAN_FILTERING
 DECLARE_STATIC_KEY_FALSE(br_mst_used);
 static inline bool br_mst_is_enabled(const struct net_bridge_port *p)
@@ -1971,7 +1978,7 @@ void br_mst_vlan_init_state(struct net_bridge_vlan *v);
 int br_mst_set_enabled(struct net_bridge *br, bool on,
 		       struct netlink_ext_ack *extack);
 size_t br_mst_info_size(const struct net_bridge_vlan_group *vg);
-int br_mst_fill_info(struct sk_buff *skb,
+int br_mst_fill_info(struct sk_buff *skb, const struct nlattr *af,
 		     const struct net_bridge_vlan_group *vg);
 int br_mst_process(struct net_bridge_port *p, const struct nlattr *mst_attr,
 		   struct netlink_ext_ack *extack);
@@ -1999,7 +2006,7 @@ static inline size_t br_mst_info_size(const struct net_bridge_vlan_group *vg)
 	return 0;
 }
 
-static inline int br_mst_fill_info(struct sk_buff *skb,
+static inline int br_mst_fill_info(struct sk_buff *skb, const struct nlattr *af,
 				   const struct net_bridge_vlan_group *vg)
 {
 	return -EOPNOTSUPP;
@@ -2161,6 +2168,18 @@ static inline int br_cfm_peer_mep_count(struct net_bridge *br, u32 *count)
 #endif
 
 /* br_netlink.c */
+/* The IFLA_AF_SPEC nest that br_fill_ifinfo() builds is a single netlink
+ * attribute, so everything put inside it has to fit in the u16 nla_len.
+ * The entries have fixed sizes, so ask for room before adding one instead
+ * of closing the nest with a length that wrapped.
+ */
+static inline bool br_af_spec_has_room(const struct sk_buff *skb,
+				       const struct nlattr *af, size_t size)
+{
+	return skb_tail_pointer(skb) - (const unsigned char *)af + size <=
+	       U16_MAX;
+}
+
 extern struct rtnl_link_ops br_link_ops;
 int br_netlink_init(void);
 void br_netlink_fini(void);
diff --git a/net/bridge/br_private_tunnel.h b/net/bridge/br_private_tunnel.h
index efb096025151a..5923eb46f5c67 100644
--- a/net/bridge/br_private_tunnel.h
+++ b/net/bridge/br_private_tunnel.h
@@ -25,7 +25,7 @@ int br_process_vlan_tunnel_info(const struct net_bridge *br,
 				struct vtunnel_info *tinfo_last,
 				bool *changed);
 int br_get_vlan_tunnel_info_size(struct net_bridge_vlan_group *vg);
-int br_fill_vlan_tunnel_info(struct sk_buff *skb,
+int br_fill_vlan_tunnel_info(struct sk_buff *skb, const struct nlattr *af,
 			     struct net_bridge_vlan_group *vg);
 bool vlan_tunid_inrange(const struct net_bridge_vlan *v_curr,
 			const struct net_bridge_vlan *v_last);

base-commit: 31f961de2f90fbf52eb2d4e15b3eeaa09f9b4fc2
-- 
2.43.0

