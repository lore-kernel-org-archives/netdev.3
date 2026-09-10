Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531674A92F9
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 15:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789055332; cv=none; b=timz0Y40mlztI62iy+IQ+PcYS1XAYMHwcFsJvGhmG15QPdu//AXoUQkN5zl8zkGnkMMIcwKPnkD+aiWlcj7ZbQqPr8d1RCgQh7gW+RI2/uXcRrblQktMgB5w17cxJFI6DEeY5LqwrmfwrIwqJ+Fd0hlIx0tbB4XYr6M2bOgnabk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789055332; c=relaxed/simple;
	bh=OsaYz3oipNjuhj3nAFwbDhrJQWTYlcva4aHDMGQHetU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VhgSUFDUgydW40y2GXgJThmrtISmACe6vyjFhzS3XxxFqGgPqWjkt41HnmnVvk+AbxZfvY5nqV3wVIcJRNYohScHGgcL+Y/xS7F86mSG/9/sja1PUztXZKBA8GaCkh5hN+KHN6z889rF5QiM0g1LDcYgUcc3otypdolL6MgaK+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bjbm7+oI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bjbm7+oI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789055329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WAXlfc/tf1p3QsrX+UCCT6KufH9ClSZnpXl6HvO2Sbw=;
	b=Bjbm7+oI74f+q6HcBZvCkaqet7gr4RF/K0Q37oBEMqPE8xEAvr2iOsgB9e+vsswS4Nho6r
	PqVTPpEmP9HXe7kCNpo3IfgRV+uJkX8p4aKd66tr0QuEt897PPaqG9gbPc+8YsEnKzOA6x
	3vjAhm/dzjERxmywNtfk095sKws2IcI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-711-1o1SDbTBONCmACAp4nDEcA-1; Thu,
 10 Sep 2026 11:48:46 -0400
X-MC-Unique: 1o1SDbTBONCmACAp4nDEcA-1
X-Mimecast-MFC-AGG-ID: 1o1SDbTBONCmACAp4nDEcA_1789055324
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4DD2B180059D;
	Thu, 10 Sep 2026 15:48:44 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.48.140])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 45360418;
	Thu, 10 Sep 2026 15:48:39 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
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
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-next 1/2] ice: fix TC flower filters matching more than the ip_proto key
Date: Thu, 10 Sep 2026 17:48:23 +0200
Message-ID: <20260910154824.3603687-2-poros@redhat.com>
In-Reply-To: <20260910154824.3603687-1-poros@redhat.com>
References: <20260910154824.3603687-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

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
Signed-off-by: Petr Oros <poros@redhat.com>
---
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

