Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF6C531AFE
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 14:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789569719; cv=none; b=o8/40NwNCA5TOtIxSKq+0mVRS0k3sswJlb4Jn7oxLWYinyGt6SNKI2Jpdmyi7TUK9YmeBG7IKSCUhCFC+gtKKSPiVBADnxKGE8wnzGvg0SgFnTdEcL8a+JhGzxEfTy1/QWFpvc0yvI1f0x6tJmka/TNPS8yt+qYPZ697d/Eqdy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789569719; c=relaxed/simple;
	bh=/eadboLx+rlXWD1XZjOpLtieB9u0rVDCmpcNd7CMykk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j4MHEcnnnLzrkBSAvIyb0OcX3Kf1OeMvDTBpS5qdv4T2g/CXrX9NnoOj8X00WVUDsKMbhFjivvfh4giLecKyO7/xQ9NgFMcz4KoWLtR9rEeynxAxpeWf/XQxNkIFi0z1dg6NFhQt3Vg44lqqwwV7XR2x2LpF+MyhM/NZiXGsPoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dmoy5X0h; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dmoy5X0h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789569715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bNH5x7SAmY4O0QWV34BUPLPeM7OS4osc8Eq3+VpugLg=;
	b=Dmoy5X0hVDGyqzb4YzCC98A2SJK7V1NBx0gR13t65UkvTI9oKNpG0CToAdoio3OYRbrc42
	vhXLSzf4nOa2enodS0FIIVsSPJirHbblS0VE+4w5Gvli3yF973c/P/TrG69OtfrkYJxx6i
	wwx6wxZuKSeGvGkIsUO9Nv6XOO7qXGc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-534-kwagSBRrN1ytxlZg2GJkZQ-1; Wed,
 16 Sep 2026 10:41:52 -0400
X-MC-Unique: kwagSBRrN1ytxlZg2GJkZQ-1
X-Mimecast-MFC-AGG-ID: kwagSBRrN1ytxlZg2GJkZQ_1789569710
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B1744195F14F;
	Wed, 16 Sep 2026 14:41:49 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.49.1])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 28D14195604D;
	Wed, 16 Sep 2026 14:41:44 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Priyalee Kushwaha <priyalee.kushwaha@intel.com>,
	Kiran Patil <kiran.patil@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Simon Horman <horms@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-next v2 1/2] ice: fix TC flower filters matching more than the ip_proto key
Date: Wed, 16 Sep 2026 16:41:29 +0200
Message-ID: <20260916144130.2699902-2-poros@redhat.com>
In-Reply-To: <20260916144130.2699902-1-poros@redhat.com>
References: <20260916144130.2699902-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

ice_parse_cls_flower() stores the ip_proto key from the flow rule but
never programs a matching lookup unless the filter also matches on L4
ports or the L2TPv3 session ID. A filter like:

  tc filter add dev $pf ingress protocol ip flower skip_sw \
      ip_proto udp action drop

is silently programmed into the hardware as a match on eth_type ipv4
alone and drops every IPv4 packet, not just UDP.

Program the IP protocol match through the protocol field of the IPv4
header lookup and the next header field of the IPv6 header lookup, the
same lookups that are already used for ToS and TTL. The OS default and
comms DDP packages provide no profile that extracts the IPv6 next
header word, so the IPv6 rule programming currently fails with
"Required profiles not found" and the filter falls back to software
evaluation instead of over-matching, and the offload starts working
with a DDP package that can extract it. Note that the lookup matches
the next header byte of the base IPv6 header, so packets carrying
extension headers are not matched in hardware and fall back to
software evaluation, which under-matches only for skip_sw filters.

GTP tunnel and PPPoE filters rewrite the parsed ethertype, the IP
header lookups are not available there, so reject an unconsumed
ip_proto for them instead of silently widening the match. Filters where
ip_proto is implied by an L4 ports or L2TPv3 session ID lookup are not
affected. Based on an earlier unapplied patch from Michal Swiatkowski
that implemented the IPv4 part [1].

Link: https://lore.kernel.org/intel-wired-lan/20240222123956.2393-3-michal.swiatkowski@linux.intel.com/ [1]
Fixes: 0d08a441fb1a ("ice: ndo_setup_tc implementation for PF")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Petr Oros <poros@redhat.com>
---
v2:
- no code changes, collect Reviewed-by from Aleksandr Loktionov

v1: https://lore.kernel.org/all/20260910154824.3603687-2-poros@redhat.com/
 drivers/net/ethernet/intel/ice/ice_tc_lib.c | 37 +++++++++++++++++++--
 drivers/net/ethernet/intel/ice/ice_tc_lib.h |  1 +
 2 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.c b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
index d20357c0412731..fbd8cbad150a98 100644
--- a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
@@ -78,7 +78,8 @@ static int ice_tc_count_lkups(u32 flags, struct ice_tc_flower_fltr *fltr)
 		     ICE_TC_FLWR_FIELD_DEST_IPV6 | ICE_TC_FLWR_FIELD_SRC_IPV6))
 		lkups_cnt++;
 
-	if (flags & (ICE_TC_FLWR_FIELD_IP_TOS | ICE_TC_FLWR_FIELD_IP_TTL))
+	if (flags & (ICE_TC_FLWR_FIELD_IP_TOS | ICE_TC_FLWR_FIELD_IP_TTL |
+		     ICE_TC_FLWR_FIELD_IP_PROTO))
 		lkups_cnt++;
 
 	/* are L2TPv3 options specified? */
@@ -552,7 +553,8 @@ ice_tc_fill_rules(struct ice_hw *hw, u32 flags,
 	}
 
 	if (headers->l2_key.n_proto == htons(ETH_P_IP) &&
-	    (flags & (ICE_TC_FLWR_FIELD_IP_TOS | ICE_TC_FLWR_FIELD_IP_TTL))) {
+	    (flags & (ICE_TC_FLWR_FIELD_IP_TOS | ICE_TC_FLWR_FIELD_IP_TTL |
+		      ICE_TC_FLWR_FIELD_IP_PROTO))) {
 		list[i].type = ice_proto_type_from_ipv4(inner);
 
 		if (flags & ICE_TC_FLWR_FIELD_IP_TOS) {
@@ -567,11 +569,19 @@ ice_tc_fill_rules(struct ice_hw *hw, u32 flags,
 				headers->l3_mask.ttl;
 		}
 
+		if (flags & ICE_TC_FLWR_FIELD_IP_PROTO) {
+			list[i].h_u.ipv4_hdr.protocol =
+				headers->l3_key.ip_proto;
+			list[i].m_u.ipv4_hdr.protocol =
+				headers->l3_mask.ip_proto;
+		}
+
 		i++;
 	}
 
 	if (headers->l2_key.n_proto == htons(ETH_P_IPV6) &&
-	    (flags & (ICE_TC_FLWR_FIELD_IP_TOS | ICE_TC_FLWR_FIELD_IP_TTL))) {
+	    (flags & (ICE_TC_FLWR_FIELD_IP_TOS | ICE_TC_FLWR_FIELD_IP_TTL |
+		      ICE_TC_FLWR_FIELD_IP_PROTO))) {
 		struct ice_ipv6_hdr *hdr_h, *hdr_m;
 
 		hdr_h = &list[i].h_u.ipv6_hdr;
@@ -592,6 +602,11 @@ ice_tc_fill_rules(struct ice_hw *hw, u32 flags,
 			hdr_m->hop_limit = headers->l3_mask.ttl;
 		}
 
+		if (flags & ICE_TC_FLWR_FIELD_IP_PROTO) {
+			hdr_h->next_hdr = headers->l3_key.ip_proto;
+			hdr_m->next_hdr = headers->l3_mask.ip_proto;
+		}
+
 		i++;
 	}
 
@@ -1737,6 +1752,9 @@ ice_parse_cls_flower(struct net_device *filter_dev, struct ice_vsi *vsi,
 		headers->l2_key.n_proto = cpu_to_be16(n_proto_key);
 		headers->l2_mask.n_proto = cpu_to_be16(n_proto_mask);
 		headers->l3_key.ip_proto = match.key->ip_proto;
+		headers->l3_mask.ip_proto = match.mask->ip_proto;
+		if (match.mask->ip_proto)
+			fltr->flags |= ICE_TC_FLWR_FIELD_IP_PROTO;
 	}
 
 	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_ETH_ADDRS)) {
@@ -1910,6 +1928,19 @@ ice_parse_cls_flower(struct net_device *filter_dev, struct ice_vsi *vsi,
 		}
 	}
 
+	if (fltr->flags & (ICE_TC_FLWR_FIELD_DEST_L4_PORT |
+			   ICE_TC_FLWR_FIELD_SRC_L4_PORT |
+			   ICE_TC_FLWR_FIELD_L2TPV3_SESSID))
+		fltr->flags &= ~ICE_TC_FLWR_FIELD_IP_PROTO;
+
+	if ((fltr->flags & ICE_TC_FLWR_FIELD_IP_PROTO) &&
+	    headers->l2_key.n_proto != htons(ETH_P_IP) &&
+	    headers->l2_key.n_proto != htons(ETH_P_IPV6)) {
+		NL_SET_ERR_MSG_MOD(fltr->extack,
+				   "IP protocol match is not supported with GTP or PPPoE");
+		return -EOPNOTSUPP;
+	}
+
 	/* Ingress filter on representor results in an egress filter in HW
 	 * and vice versa
 	 */
diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.h b/drivers/net/ethernet/intel/ice/ice_tc_lib.h
index 8a3ab2f22af9ba..752af65e70b7bf 100644
--- a/drivers/net/ethernet/intel/ice/ice_tc_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.h
@@ -38,6 +38,7 @@
 #define ICE_TC_FLWR_FIELD_CVLAN_PRIO		BIT(28)
 #define ICE_TC_FLWR_FIELD_VLAN_TPID		BIT(29)
 #define ICE_TC_FLWR_FIELD_PFCP_OPTS		BIT(30)
+#define ICE_TC_FLWR_FIELD_IP_PROTO		BIT(31)
 
 #define ICE_TC_FLOWER_MASK_32   0xFFFFFFFF
 
-- 
2.55.0

