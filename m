Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646C64C9DF9;
	Thu, 15 Oct 2026 23:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.77.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792108540; cv=none; b=HdgGC1exsp3IjhdstKNaMrIDRZ7aerBmbw728EOqW0XOEOj3QXxl6D3uIpT9HOEqTrPUkTgGuzMhw8Lc83qHbNJnAvm8RQyCYVAt0QNwTAbu3ZWtgiNKqPtU7OSffoi/+0Qx4cqoyOWybVCKw/Ns3aGeyNuKIsMNC4JtPRDUmzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792108540; c=relaxed/simple;
	bh=fsy1HDXYDCBxoU8rw9mNSNkam/02fcI4sQoFMBYkvLY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GEfxf0qkFeAt5i6gJSEjJ07zWzVD2xBI+SJb+CxRaVaIGmoeVFjkV2WddsS2R2FJW3PjgO/pDNhLMi1aP7LSMrBPifIB7dK8To7YfGiRwAzCXBtlY2hzrXU8SNcSGq2vpCyHHcZICRnvqTdSJceegOPxA3Qw2cEk1+HS0vCxwtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=XrmJQZiy; arc=none smtp.client-ip=44.246.77.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="XrmJQZiy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1792108539; x=1823644539;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QP6nEgHVVunplixiZ+zcISbOTPZOCUNPX8lrOuRiGOA=;
  b=XrmJQZiyOU++C9HFxyWKYy1JGhwK/0Dwri/PZXMIThH2vp/K0jc4Bvol
   et2yUx+Em6YA6cnYoHxluEYrsq/19+3xyJY8LpSJiDIJfdV5K/Ju2xdiS
   DvHWH5Whyp9aRERt6P38CsPu4fHe2P1dYIIz1mfAGHP09W+JH5In/QU9a
   AWKrTNJCV7u/zy2xPL1q1/GlS2kK6YGHPdn5hxms7HHPaQlZ7JFJWedQD
   ObU3Xkw4uvIKQycUVZx3/LvaOV2PPj1VGwZzCDy9t+2u4UjILsMcckZdh
   NbonZi2lpqftl5K4PSu5R5bcDd240o7pn6XwB+0fV0s894ZCgYcb0e2h6
   Q==;
X-CSE-ConnectionGUID: e/2na6VVR2OUG5qNML2i8w==
X-CSE-MsgGUID: RoLWbN+QQCWpogSHu896rA==
X-IronPort-AV: E=Sophos;i="6.27,160,1787011200"; 
   d="scan'208";a="31383875"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 23:55:38 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:16334]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.12.154:2525] with esmtp (Farcaster)
 id b8147083-17ee-4bb2-b354-730e5a82730b; Thu, 15 Oct 2026 23:55:38 +0000 (UTC)
X-Farcaster-Flow-ID: b8147083-17ee-4bb2-b354-730e5a82730b
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Thu, 15 Oct 2026 23:55:37 +0000
Received: from dev-dsk-dkeogh-ai2-36d3b9a7.us-west-2.amazon.com
 (172.19.55.127) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53; Thu, 15 Oct 2026
 23:55:37 +0000
From: David Keogh <dkeogh@amazon.com>
To: <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Dumazet <edumazet@kernel.org>
CC: Dragos Tatulea <dtatulea@nvidia.com>, Nimrod Oren <noren@nvidia.com>,
	<nh-open-source@amazon.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC net-next 3/6] rtnetlink: add IFLA_TX_EXTRA_HEADROOM
Date: Thu, 15 Oct 2026 23:53:32 +0000
Message-ID: <20261015235335.4162993-4-dkeogh@amazon.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261015235335.4162993-1-dkeogh@amazon.com>
References: <20261015235335.4162993-1-dkeogh@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA002.ant.amazon.com (10.13.139.96) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Expose tx_extra_headroom through a new IFLA_TX_EXTRA_HEADROOM u16
attribute. The value is bounded to NETDEV_TX_EXTRA_HEADROOM_MAX
(512 bytes) by the netlink policy, which is plenty for several layers
of encapsulation while keeping the growth of per-packet allocations
modest.

The attribute can be given when creating a link and when changing one.
It is included in link dumps and a change triggers the usual link
notification. Zero is the default and resets the reservation.

IFLA_HEADROOM keeps reporting needed_headroom, the driver's own
requirement, so userspace can tell the two apart.

The setting applies to the device the packet is allocated for, that is
the device selected by the route, and is not inherited by stacked
devices. Document that together with the allocation-only semantics in
netdevices.rst and add the attribute to the rt-link spec.

Signed-off-by: David Keogh <dkeogh@amazon.com>
---
 Documentation/netlink/specs/rt-link.yaml | 12 +++++++++
 Documentation/networking/netdevices.rst  | 34 ++++++++++++++++++++++++
 include/uapi/linux/if_link.h             |  1 +
 net/core/rtnetlink.c                     | 19 ++++++++++++-
 4 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/rt-link.yaml b/Documentation/netlink/specs/rt-link.yaml
index 81b586339..9da363df5 100644
--- a/Documentation/netlink/specs/rt-link.yaml
+++ b/Documentation/netlink/specs/rt-link.yaml
@@ -1098,6 +1098,16 @@ attribute-sets:
         name: pacing-offload
         type: u32
         doc: Enable EDT pacing offload (0 - disabled, 1 - enabled).
+      -
+        name: tx-extra-headroom
+        type: u16
+        doc: |
+          Additional headroom, in bytes, reserved on top of the driver's
+          requirement when allocating locally generated packets for
+          transmission through this device. Zero (the default) disables
+          the extra reservation.
+        checks:
+          max: 512
   -
     name: prop-list-link-attrs
     subset-of: link-attrs
@@ -2471,6 +2481,7 @@ operations:
             - gso-ipv4-max-size
             - gro-ipv4-max-size
             - af-spec
+            - tx-extra-headroom
     -
       name: newlink-ntf
       doc: Notify that a link has been created
@@ -2567,6 +2578,7 @@ operations:
             - gso-ipv4-max-size
             - gro-ipv4-max-size
             - pacing-offload
+            - tx-extra-headroom
       dump:
         request:
           value: 18
diff --git a/Documentation/networking/netdevices.rst b/Documentation/networking/netdevices.rst
index 6a87f09e7..02d6b4d4b 100644
--- a/Documentation/networking/netdevices.rst
+++ b/Documentation/networking/netdevices.rst
@@ -441,6 +441,40 @@ from a notifier.
 
 Drivers **must not** generate nested notifications of the ops-locked types.
 
+TX headroom reservation
+=======================
+
+``needed_headroom`` is the driver's own additional header-space requirement.
+It is written by the driver, or by a stacked device inheriting the value of
+the device below it, and is reported read-only through ``IFLA_HEADROOM``.
+
+``tx_extra_headroom`` is a separate reservation configured by the
+administrator through the ``IFLA_TX_EXTRA_HEADROOM`` rtnetlink attribute, a
+byte count from 0 to 512 that defaults to 0. It can be supplied when a link
+is created or changed, is reported in link dumps and change notifications,
+and setting it back to 0 removes it.
+
+The extra reservation is only applied when the stack allocates a locally
+generated packet for transmission through the device. ``LL_ALLOC_SPACE()``
+is ``LL_RESERVED_SPACE()`` plus ``tx_extra_headroom`` and is used by the
+UDP, raw, AF_PACKET and AF_XDP transmit paths. Its purpose is to give
+programs attached at TC egress room to push additional headers without
+having to reallocate the packet first.
+
+The setting is deliberately not part of ``LL_RESERVED_SPACE()``, which
+remains the threshold for deciding whether an already existing packet must
+be expanded. Packets that reach the device with less than the extra
+reservation, such as forwarded packets or TCP segments, are therefore not
+reallocated because of it. Consumers must keep their usual headroom and
+clone checks.
+
+The setting is not inherited through stacked devices. Packets are allocated
+against the device selected by the route, so configure it on the VLAN,
+bond or bridge device the route points at rather than on the device
+beneath it. It survives link down/up and network namespace moves and is
+independent of any TC or BPF attachment. It does not change the MTU or
+the bytes on the wire.
+
 NETDEV_INTERNAL symbol namespace
 ================================
 
diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 245b36204..fb3a6b382 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -382,6 +382,7 @@ enum {
 	IFLA_HEADROOM,
 	IFLA_TAILROOM,
 	IFLA_PACING_OFFLOAD,
+	IFLA_TX_EXTRA_HEADROOM,
 	__IFLA_MAX
 };
 
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 15bffafbf..fb691db8e 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1403,6 +1403,7 @@ static noinline size_t if_nlmsg_size(const struct net_device *dev,
 	       + nla_total_size(4)  /* IFLA_PACING_OFFLOAD */
 	       + nla_total_size(2)  /* IFLA_HEADROOM */
 	       + nla_total_size(2)  /* IFLA_TAILROOM */
+	       + nla_total_size(2)  /* IFLA_TX_EXTRA_HEADROOM */
 	       + rtnl_dev_parent_size(dev)
 	       + 0;
 
@@ -2200,7 +2201,9 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
 	    nla_put_u16(skb, IFLA_HEADROOM,
 			READ_ONCE(dev->needed_headroom)) ||
 	    nla_put_u16(skb, IFLA_TAILROOM,
-			READ_ONCE(dev->needed_tailroom)))
+			READ_ONCE(dev->needed_tailroom)) ||
+	    nla_put_u16(skb, IFLA_TX_EXTRA_HEADROOM,
+			READ_ONCE(dev->tx_extra_headroom)))
 		goto nla_put_failure;
 
 	if (rtnl_fill_proto_down(skb, dev))
@@ -2361,6 +2364,8 @@ static const struct nla_policy ifla_policy[IFLA_MAX+1] = {
 	[IFLA_HEADROOM]		= { .type = NLA_REJECT },
 	[IFLA_TAILROOM]		= { .type = NLA_REJECT },
 	[IFLA_PACING_OFFLOAD]	= NLA_POLICY_MAX(NLA_U32, 1),
+	[IFLA_TX_EXTRA_HEADROOM] =
+		NLA_POLICY_MAX(NLA_U16, NETDEV_TX_EXTRA_HEADROOM_MAX),
 };
 
 static const struct nla_policy ifla_info_policy[IFLA_INFO_MAX+1] = {
@@ -3368,6 +3373,15 @@ static int do_setlink(const struct sk_buff *skb, struct net_device *dev,
 		}
 	}
 
+	if (tb[IFLA_TX_EXTRA_HEADROOM]) {
+		u16 val = nla_get_u16(tb[IFLA_TX_EXTRA_HEADROOM]);
+
+		if (dev->tx_extra_headroom != val) {
+			WRITE_ONCE(dev->tx_extra_headroom, val);
+			status |= DO_SETLINK_NOTIFY;
+		}
+	}
+
 	if (tb[IFLA_OPERSTATE])
 		set_operstate(dev, nla_get_u8(tb[IFLA_OPERSTATE]));
 
@@ -3859,6 +3873,9 @@ struct net_device *rtnl_create_link(struct net *net, const char *ifname,
 		netif_set_gso_ipv4_max_size(dev, nla_get_u32(tb[IFLA_GSO_IPV4_MAX_SIZE]));
 	if (tb[IFLA_GRO_IPV4_MAX_SIZE])
 		netif_set_gro_ipv4_max_size(dev, nla_get_u32(tb[IFLA_GRO_IPV4_MAX_SIZE]));
+	if (tb[IFLA_TX_EXTRA_HEADROOM])
+		dev->tx_extra_headroom =
+			nla_get_u16(tb[IFLA_TX_EXTRA_HEADROOM]);
 
 	return dev;
 }
-- 
2.50.1

