Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com [209.85.215.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE82D4F4754
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 09:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788859927; cv=none; b=gmKCs1Hs9utI2/LJ1MWCkrDpfgYavVIfcxb67W/DA969pDFVk0ICvSbTSQ+Dzn4xu1BRK2MdUBCMFaKdaRe4WXBHbGWgLCpVdrjWgLrxL0V0g0acjcuJoHFtXf5sOyGqcr/LgMfDTdm0hyn8H32XysG8IY6AMCEetpd9Hco9q0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788859927; c=relaxed/simple;
	bh=XhYip2lJvVJnY3n+PW7miG36zcRu0facNUobplCNI9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SshDt/VXjuj7hgfzBRGJDg6N7eybmgmYW7IU99BBCqR8KzxL6OJDSw3/hcd7mQwkst0UecxJ2WcMRxk7bNpuC7wZ4RZauLbYlT8aD9qAdNhJmDWD7dElE8Vgwlx5HoaSiFJygFHdKqGmSoht2hkKf8ezOxuIAumr80j7zl3+PTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=TivFEdMA; arc=none smtp.client-ip=209.85.215.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TivFEdMA"
Received: by mail-pg1-f225.google.com with SMTP id 41be03b00d2f7-cbedf433a99so4152202a12.2
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 02:32:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788859925; x=1789464725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hi7jVeXN+qT344NTNV57pVwIX7/GDKUmSQ9nHvmOkzE=;
        b=ITG8ntLY3774XuTdhcmy5ovjmmJioaD+YWdeWYa6PCZ8p6+0JlRwdJEhV3bxculxlA
         H4wmXNy8fQKxzXBtkM2SbFOjSL7Qjt1rjUQrVeVYGRWMTRtBR2A4o0bu502HJmzEIZHn
         UC1nLZGJ3442i5DY3tQDFKeWbFaPDFeYGnV04HEj2zl3UETxU4LX5ZzyCNmljjLcJteK
         8eik0LkkfhEorEEys374o29rCyVAG45BL07IATw3qGDiowpo9LufkDE5EC5yA7q3YJcX
         iaRGMztJSILoxqntuWkRrFd+YqFl0HAvWl2lJCSRKmAOfv0P1wKuilBzT71zq24AVdrC
         jN/w==
X-Gm-Message-State: AFuF++njTH0MLAyzNMnhBL+dPn48tLYOmpV20Ko33FEsteEzRQ+HL+BX
	QLz/pWt6KiCjleYfrleKXCp+x0NrumH1ivOgkUhQulvwz4Q4cq+fGiSsZiZIFyEWgtGQQLXaI/S
	Qn4Tb32HdNjs8ju1JHP6Cl9Ugba7KKM6b2YVqtc23mARkGRWG7HE73LsU2c2tbrSmudGRC3VNEw
	sc2UHx4372MfrMM6sO8koJTx4/vfuunSXEBefeSj8cRQi8+6bAlXxmZS0yRUDgTWYHBV+tQEeCq
	H+ZKXevIg==
X-Gm-Gg: AYBFou34AtVNDeAv3ttZwTRjAkmqHStM9yl5Hj06qTX3OhWZP8S4DcSkL8Nz0cNGA2c
	FVoWYIYjrYMMAxUkvzN3dDuJ25Lg30P+RdSS4jTfX401SsHvCeD10zO8p7e3GFLsNpN/vqOcqe9
	UOsu1Gk2lpp6i/6ejAGPjLJVW8u70Cd48xZRxoE0uqgRkruUcjrWBq5MvHP7DKJxR6+7WPZDxTG
	1Ige9J82Jvd7nGQ0qbeemPg24Fyo9wJEvpEKt45bkZ1V+xZ/5EH9W6SvT+4BaQfyD6JfBhOECX+
	JRpgJa1wSSeTbTtP6Jx45KMYJKrX0CJOYin9alezaSChdz6sBCoUg8PgOZWRcjd8xgpJulrfMta
	4D1L09/sVmfrfV4b/3RzhnHuH19qlb0b4CgZ34x1Q1Ks9h385AKaPkRI29lhrLY3khRGWZYRiwG
	e9KJrxrBe/HBSeE0BvMBBEuaWQfjJWUkebBg==
X-Received: by 2002:a17:90b:3943:b0:398:d8eb:cb2a with SMTP id 98e67ed59e1d1-39b26273e31mr45415992a91.23.1788859924578;
        Tue, 08 Sep 2026 02:32:04 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-39b2614561fsm8739914a91.8.2026.09.08.02.32.03
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Sep 2026 02:32:04 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2d6f75c1219so18043095ad.3
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 02:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1788859923; x=1789464723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hi7jVeXN+qT344NTNV57pVwIX7/GDKUmSQ9nHvmOkzE=;
        b=TivFEdMA/eHKctqa3uQ7zA+oXIeEN7ap84GLdW2LDGPJya2FTY8zMnccJRQNxCoSOU
         P9Bu0Sksh23EfRAcsApS3RB5t70BXOAur9xwlgRE/va2L0mbWVfzrv/NFM0PQsU8Ehte
         fOEC+Dcl3LmryrKIg6m6eVhVkfJ8RX/13Clyk=
X-Received: by 2002:a17:90b:4c52:b0:396:d27b:89b9 with SMTP id 98e67ed59e1d1-39b2612ccddmr41702202a91.10.1788859922401;
        Tue, 08 Sep 2026 02:32:02 -0700 (PDT)
X-Received: by 2002:a17:90b:4c52:b0:396:d27b:89b9 with SMTP id 98e67ed59e1d1-39b2612ccddmr41702150a91.10.1788859921485;
        Tue, 08 Sep 2026 02:32:01 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08ca63b3sm31493316a91.11.2026.09.08.02.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 02:32:01 -0700 (PDT)
From: Vikas Gupta <vikas.gupta@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bhargava.marreddy@broadcom.com,
	rahul-rg.gupta@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	rajashekar.hudumula@broadcom.com,
	dharmender.garg@broadcom.com,
	ajit.khaparde@broadcom.com,
	Vikas Gupta <vikas.gupta@broadcom.com>
Subject: [net-next, v2 09/11] bnge: add NTUPLE filter support in ethtool
Date: Tue,  8 Sep 2026 15:00:51 +0530
Message-ID: <20260908093053.2596020-10-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260908093053.2596020-1-vikas.gupta@broadcom.com>
References: <20260908093053.2596020-1-vikas.gupta@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Introduce ethtool rx flow classification (rxnfc) operations for
NTUPLE filter management.

Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Dharmender Garg <dharmender.garg@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_ethtool.c | 586 ++++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_filter.c  |  58 ++
 .../net/ethernet/broadcom/bnge/bnge_filter.h  |   2 +
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.c    |   8 +-
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  |   4 +
 5 files changed, 655 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c b/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
index 460e66da6d1c..63acf27d8e4b 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
@@ -15,6 +15,7 @@
 #include "bnge_resc.h"
 #include "bnge_ethtool.h"
 #include "bnge_hwrm_lib.h"
+#include "bnge_filter.h"
 
 static int bnge_nway_reset(struct net_device *dev)
 {
@@ -1135,6 +1136,589 @@ static int bnge_remove_rxfh_context(struct net_device *dev,
 	return 0;
 }
 
+#define BNGE_IP_PROTO_FULL_MASK	0xFF
+#define BNGE_IP_PROTO_WILDCARD	0x0
+
+static u32 bnge_get_all_fltr_ids_rcu(struct bnge_net *bn,
+				     struct hlist_head tbl[],
+				     u32 tbl_size, u32 *ids, u32 start,
+				     u32 id_cnt, u32 offset)
+{
+	u32 i, j = start;
+
+	if (j >= id_cnt)
+		return j;
+
+	for (i = 0; i < tbl_size; i++) {
+		struct bnge_filter_base *fltr;
+		struct hlist_head *head;
+
+		head = &tbl[i];
+		hlist_for_each_entry_rcu(fltr, head, hlist) {
+			if (!fltr->flags ||
+			    test_bit(BNGE_FLTR_FW_DELETED, &fltr->state))
+				continue;
+			ids[j++] = fltr->sw_id + offset;
+			if (j == id_cnt)
+				return j;
+		}
+	}
+	return j;
+}
+
+static struct bnge_filter_base *bnge_get_one_fltr_rcu(struct bnge_net *bn,
+						      struct hlist_head tbl[],
+						      u32 tbl_size, u32 id,
+						      u32 offset)
+{
+	u32 i;
+
+	for (i = 0; i < tbl_size; i++) {
+		struct bnge_filter_base *fltr;
+		struct hlist_head *head;
+
+		head = &tbl[i];
+		hlist_for_each_entry_rcu(fltr, head, hlist) {
+			if (fltr->flags && fltr->sw_id + offset == id)
+				return fltr;
+		}
+	}
+	return NULL;
+}
+
+static int bnge_grxclsrlall(struct bnge_net *bn, struct ethtool_rxnfc *cmd,
+			    u32 *rule_locs)
+{
+	u32 count;
+
+	cmd->data = bn->user_fltr_count;
+	rcu_read_lock();
+	count = bnge_get_all_fltr_ids_rcu(bn, bn->l2_fltr_hash_tbl,
+					  BNGE_L2_FLTR_HASH_SIZE, rule_locs, 0,
+					  cmd->rule_cnt, 0);
+	cmd->rule_cnt = bnge_get_all_fltr_ids_rcu(bn, bn->ntp_fltr_hash_tbl,
+						  BNGE_NTP_FLTR_HASH_SIZE,
+						  rule_locs, count,
+						  cmd->rule_cnt,
+						  BNGE_MAX_L2_FLTRS);
+	rcu_read_unlock();
+
+	return 0;
+}
+
+static int bnge_grxclsrule(struct bnge_net *bn, struct ethtool_rxnfc *cmd)
+{
+	struct ethtool_rx_flow_spec *fs =
+		(struct ethtool_rx_flow_spec *)&cmd->fs;
+	struct bnge_filter_base *fltr_base;
+	struct bnge_ntuple_filter *fltr;
+	struct bnge_flow_masks *fmasks;
+	struct bnge_dev *bd = bn->bd;
+	struct flow_keys *fkeys;
+	int rc = -EINVAL;
+
+	if (fs->location >= BNGE_MAX_L2_FLTRS + bd->max_fltr)
+		return rc;
+
+	rcu_read_lock();
+	fltr_base = bnge_get_one_fltr_rcu(bn, bn->l2_fltr_hash_tbl,
+					  BNGE_L2_FLTR_HASH_SIZE,
+					  fs->location, 0);
+	if (fltr_base) {
+		struct ethhdr *h_ether = &fs->h_u.ether_spec;
+		struct ethhdr *m_ether = &fs->m_u.ether_spec;
+		struct bnge_l2_filter *l2_fltr;
+		struct bnge_l2_key *l2_key;
+
+		l2_fltr = container_of(fltr_base, struct bnge_l2_filter, base);
+		l2_key = &l2_fltr->l2_key;
+		fs->flow_type = ETHER_FLOW;
+		ether_addr_copy(h_ether->h_dest, l2_key->dst_mac_addr);
+		eth_broadcast_addr(m_ether->h_dest);
+		if (l2_key->vlan) {
+			struct ethtool_flow_ext *m_ext = &fs->m_ext;
+			struct ethtool_flow_ext *h_ext = &fs->h_ext;
+
+			fs->flow_type |= FLOW_EXT;
+			m_ext->vlan_tci = htons(0xfff);
+			h_ext->vlan_tci = htons(l2_key->vlan);
+		}
+		if (fltr_base->flags & BNGE_ACT_RING_DST)
+			fs->ring_cookie = fltr_base->rxq;
+		rcu_read_unlock();
+		return 0;
+	}
+	fltr_base = bnge_get_one_fltr_rcu(bn, bn->ntp_fltr_hash_tbl,
+					  BNGE_NTP_FLTR_HASH_SIZE,
+					  fs->location, BNGE_MAX_L2_FLTRS);
+	if (!fltr_base) {
+		rcu_read_unlock();
+		return rc;
+	}
+	fltr = container_of(fltr_base, struct bnge_ntuple_filter, base);
+
+	fkeys = &fltr->fkeys;
+	fmasks = &fltr->fmasks;
+	if (fkeys->basic.n_proto == htons(ETH_P_IP)) {
+		if (fkeys->basic.ip_proto == BNGE_IP_PROTO_WILDCARD) {
+			fs->flow_type = IP_USER_FLOW;
+			fs->h_u.usr_ip4_spec.ip_ver = ETH_RX_NFC_IP4;
+			fs->h_u.usr_ip4_spec.proto = BNGE_IP_PROTO_WILDCARD;
+			fs->m_u.usr_ip4_spec.proto = 0;
+		} else if (fkeys->basic.ip_proto == IPPROTO_ICMP) {
+			fs->flow_type = IP_USER_FLOW;
+			fs->h_u.usr_ip4_spec.ip_ver = ETH_RX_NFC_IP4;
+			fs->h_u.usr_ip4_spec.proto = IPPROTO_ICMP;
+			fs->m_u.usr_ip4_spec.proto = BNGE_IP_PROTO_FULL_MASK;
+		} else if (fkeys->basic.ip_proto == IPPROTO_TCP) {
+			fs->flow_type = TCP_V4_FLOW;
+		} else if (fkeys->basic.ip_proto == IPPROTO_UDP) {
+			fs->flow_type = UDP_V4_FLOW;
+		} else {
+			goto fltr_err;
+		}
+
+		fs->h_u.tcp_ip4_spec.ip4src = fkeys->addrs.v4addrs.src;
+		fs->m_u.tcp_ip4_spec.ip4src = fmasks->addrs.v4addrs.src;
+		fs->h_u.tcp_ip4_spec.ip4dst = fkeys->addrs.v4addrs.dst;
+		fs->m_u.tcp_ip4_spec.ip4dst = fmasks->addrs.v4addrs.dst;
+		if (fs->flow_type == TCP_V4_FLOW ||
+		    fs->flow_type == UDP_V4_FLOW) {
+			fs->h_u.tcp_ip4_spec.psrc = fkeys->ports.src;
+			fs->m_u.tcp_ip4_spec.psrc = fmasks->ports.src;
+			fs->h_u.tcp_ip4_spec.pdst = fkeys->ports.dst;
+			fs->m_u.tcp_ip4_spec.pdst = fmasks->ports.dst;
+		}
+	} else {
+		if (fkeys->basic.ip_proto == BNGE_IP_PROTO_WILDCARD) {
+			fs->flow_type = IPV6_USER_FLOW;
+			fs->h_u.usr_ip6_spec.l4_proto =
+				BNGE_IP_PROTO_WILDCARD;
+			fs->m_u.usr_ip6_spec.l4_proto = 0;
+		} else if (fkeys->basic.ip_proto == IPPROTO_ICMPV6) {
+			fs->flow_type = IPV6_USER_FLOW;
+			fs->h_u.usr_ip6_spec.l4_proto = IPPROTO_ICMPV6;
+			fs->m_u.usr_ip6_spec.l4_proto =
+				BNGE_IP_PROTO_FULL_MASK;
+		} else if (fkeys->basic.ip_proto == IPPROTO_TCP) {
+			fs->flow_type = TCP_V6_FLOW;
+		} else if (fkeys->basic.ip_proto == IPPROTO_UDP) {
+			fs->flow_type = UDP_V6_FLOW;
+		} else {
+			goto fltr_err;
+		}
+
+		memcpy(fs->h_u.tcp_ip6_spec.ip6src,
+		       &fkeys->addrs.v6addrs.src,
+		       sizeof(struct in6_addr));
+		memcpy(fs->m_u.tcp_ip6_spec.ip6src,
+		       &fmasks->addrs.v6addrs.src,
+		       sizeof(struct in6_addr));
+		memcpy(fs->h_u.tcp_ip6_spec.ip6dst,
+		       &fkeys->addrs.v6addrs.dst,
+		       sizeof(struct in6_addr));
+		memcpy(fs->m_u.tcp_ip6_spec.ip6dst,
+		       &fmasks->addrs.v6addrs.dst,
+		       sizeof(struct in6_addr));
+
+		if (fs->flow_type == TCP_V6_FLOW ||
+		    fs->flow_type == UDP_V6_FLOW) {
+			fs->h_u.tcp_ip6_spec.psrc = fkeys->ports.src;
+			fs->m_u.tcp_ip6_spec.psrc = fmasks->ports.src;
+			fs->h_u.tcp_ip6_spec.pdst = fkeys->ports.dst;
+			fs->m_u.tcp_ip6_spec.pdst = fmasks->ports.dst;
+		}
+	}
+
+	if (fltr->base.flags & BNGE_ACT_DROP) {
+		fs->ring_cookie = RX_CLS_FLOW_DISC;
+	} else if (fltr->base.flags & BNGE_ACT_RSS_CTX) {
+		fs->flow_type |= FLOW_RSS;
+		cmd->rss_context = fltr->base.fw_vnic_id;
+	} else {
+		fs->ring_cookie = fltr->base.rxq;
+	}
+	rc = 0;
+
+fltr_err:
+	rcu_read_unlock();
+
+	return rc;
+}
+
+static bool bnge_verify_ntuple_ip4_flow(struct ethtool_usrip4_spec *ip_spec,
+					struct ethtool_usrip4_spec *ip_mask)
+{
+	u8 mproto = ip_mask->proto;
+	u8 sproto = ip_spec->proto;
+
+	if (ip_mask->l4_4_bytes || ip_mask->tos ||
+	    ip_spec->ip_ver != ETH_RX_NFC_IP4 ||
+	    (mproto && (mproto != BNGE_IP_PROTO_FULL_MASK ||
+			sproto != IPPROTO_ICMP)))
+		return false;
+	return true;
+}
+
+static bool bnge_verify_ntuple_ip6_flow(struct ethtool_usrip6_spec *ip_spec,
+					struct ethtool_usrip6_spec *ip_mask)
+{
+	u8 mproto = ip_mask->l4_proto;
+	u8 sproto = ip_spec->l4_proto;
+
+	if (ip_mask->l4_4_bytes || ip_mask->tclass ||
+	    (mproto && (mproto != BNGE_IP_PROTO_FULL_MASK ||
+			sproto != IPPROTO_ICMPV6)))
+		return false;
+	return true;
+}
+
+static int bnge_add_ntuple_cls_rule(struct bnge_net *bn,
+				    struct ethtool_rxnfc *cmd)
+{
+	struct ethtool_rx_flow_spec *fs = &cmd->fs;
+	struct bnge_ntuple_filter *new_fltr, *fltr;
+	u32 flow_type = fs->flow_type & 0xff;
+	struct bnge_l2_filter *l2_fltr;
+	struct bnge_flow_masks *fmasks;
+	struct flow_keys *fkeys;
+	u32 idx;
+	int rc;
+
+	if (!bn->vnic_info)
+		return -EAGAIN;
+
+	if (fs->flow_type & (FLOW_MAC_EXT | FLOW_EXT))
+		return -EOPNOTSUPP;
+
+	if (fs->ring_cookie != RX_CLS_FLOW_DISC &&
+	    ethtool_get_flow_spec_ring_vf(fs->ring_cookie))
+		return -EOPNOTSUPP;
+
+	if (flow_type == IP_USER_FLOW) {
+		if (!bnge_verify_ntuple_ip4_flow(&fs->h_u.usr_ip4_spec,
+						 &fs->m_u.usr_ip4_spec))
+			return -EOPNOTSUPP;
+	}
+
+	if (flow_type == IPV6_USER_FLOW) {
+		if (!bnge_verify_ntuple_ip6_flow(&fs->h_u.usr_ip6_spec,
+						 &fs->m_u.usr_ip6_spec))
+			return -EOPNOTSUPP;
+	}
+
+	new_fltr = kzalloc_obj(*new_fltr, GFP_KERNEL);
+	if (!new_fltr)
+		return -ENOMEM;
+
+	l2_fltr = bn->vnic_info[BNGE_VNIC_DEFAULT].l2_filters[0];
+	new_fltr->l2_filter_id = l2_fltr->base.filter_id;
+	fmasks = &new_fltr->fmasks;
+	fkeys = &new_fltr->fkeys;
+
+	rc = -EOPNOTSUPP;
+	switch (flow_type) {
+	case IP_USER_FLOW: {
+		struct ethtool_usrip4_spec *ip_spec = &fs->h_u.usr_ip4_spec;
+		struct ethtool_usrip4_spec *ip_mask = &fs->m_u.usr_ip4_spec;
+
+		fkeys->basic.ip_proto = ip_mask->proto ? ip_spec->proto
+						       : BNGE_IP_PROTO_WILDCARD;
+		fkeys->basic.n_proto = htons(ETH_P_IP);
+		fkeys->addrs.v4addrs.src = ip_spec->ip4src;
+		fmasks->addrs.v4addrs.src = ip_mask->ip4src;
+		fkeys->addrs.v4addrs.dst = ip_spec->ip4dst;
+		fmasks->addrs.v4addrs.dst = ip_mask->ip4dst;
+		break;
+	}
+	case TCP_V4_FLOW:
+	case UDP_V4_FLOW: {
+		struct ethtool_tcpip4_spec *ip_spec = &fs->h_u.tcp_ip4_spec;
+		struct ethtool_tcpip4_spec *ip_mask = &fs->m_u.tcp_ip4_spec;
+
+		fkeys->basic.ip_proto = IPPROTO_TCP;
+		if (flow_type == UDP_V4_FLOW)
+			fkeys->basic.ip_proto = IPPROTO_UDP;
+		fkeys->basic.n_proto = htons(ETH_P_IP);
+		fkeys->addrs.v4addrs.src = ip_spec->ip4src;
+		fmasks->addrs.v4addrs.src = ip_mask->ip4src;
+		fkeys->addrs.v4addrs.dst = ip_spec->ip4dst;
+		fmasks->addrs.v4addrs.dst = ip_mask->ip4dst;
+		fkeys->ports.src = ip_spec->psrc;
+		fmasks->ports.src = ip_mask->psrc;
+		fkeys->ports.dst = ip_spec->pdst;
+		fmasks->ports.dst = ip_mask->pdst;
+		break;
+	}
+	case IPV6_USER_FLOW: {
+		struct ethtool_usrip6_spec *ip_spec = &fs->h_u.usr_ip6_spec;
+		struct ethtool_usrip6_spec *ip_mask = &fs->m_u.usr_ip6_spec;
+
+		fkeys->basic.ip_proto = ip_mask->l4_proto ? ip_spec->l4_proto
+					: BNGE_IP_PROTO_WILDCARD;
+		fkeys->basic.n_proto = htons(ETH_P_IPV6);
+
+		memcpy(&fkeys->addrs.v6addrs.src, ip_spec->ip6src,
+		       sizeof(struct in6_addr));
+		memcpy(&fmasks->addrs.v6addrs.src, ip_mask->ip6src,
+		       sizeof(struct in6_addr));
+		memcpy(&fkeys->addrs.v6addrs.dst, ip_spec->ip6dst,
+		       sizeof(struct in6_addr));
+		memcpy(&fmasks->addrs.v6addrs.dst, ip_mask->ip6dst,
+		       sizeof(struct in6_addr));
+		break;
+	}
+	case TCP_V6_FLOW:
+	case UDP_V6_FLOW: {
+		struct ethtool_tcpip6_spec *ip_spec = &fs->h_u.tcp_ip6_spec;
+		struct ethtool_tcpip6_spec *ip_mask = &fs->m_u.tcp_ip6_spec;
+
+		fkeys->basic.ip_proto = IPPROTO_TCP;
+		if (flow_type == UDP_V6_FLOW)
+			fkeys->basic.ip_proto = IPPROTO_UDP;
+		fkeys->basic.n_proto = htons(ETH_P_IPV6);
+
+		memcpy(&fkeys->addrs.v6addrs.src, ip_spec->ip6src,
+		       sizeof(struct in6_addr));
+		memcpy(&fmasks->addrs.v6addrs.src, ip_mask->ip6src,
+		       sizeof(struct in6_addr));
+		memcpy(&fkeys->addrs.v6addrs.dst, ip_spec->ip6dst,
+		       sizeof(struct in6_addr));
+		memcpy(&fmasks->addrs.v6addrs.dst, ip_mask->ip6dst,
+		       sizeof(struct in6_addr));
+
+		fkeys->ports.src = ip_spec->psrc;
+		fmasks->ports.src = ip_mask->psrc;
+		fkeys->ports.dst = ip_spec->pdst;
+		fmasks->ports.dst = ip_mask->pdst;
+		break;
+	}
+	default:
+		rc = -EOPNOTSUPP;
+		goto err_free_fltr;
+	}
+	if (!memcmp(&BNGE_FLOW_MASK_NONE, fmasks, sizeof(*fmasks)))
+		goto err_free_fltr;
+
+	idx = bnge_get_ntp_filter_idx(bn, fkeys, NULL);
+	rcu_read_lock();
+	fltr = bnge_lookup_ntp_filter_from_idx(bn, new_fltr, idx);
+	if (fltr) {
+		rcu_read_unlock();
+		rc = -EEXIST;
+		goto err_free_fltr;
+	}
+	rcu_read_unlock();
+
+	new_fltr->base.flags = BNGE_ACT_NO_AGING;
+	if (fs->flow_type & FLOW_RSS) {
+		struct bnge_rss_ctx *rss_ctx;
+
+		new_fltr->base.fw_vnic_id = 0;
+		new_fltr->base.flags |= BNGE_ACT_RSS_CTX;
+		rss_ctx = bnge_get_rss_ctx_from_index(bn, cmd->rss_context);
+		if (rss_ctx) {
+			new_fltr->base.fw_vnic_id = rss_ctx->index;
+		} else {
+			rc = -EINVAL;
+			goto err_free_fltr;
+		}
+	}
+	if (fs->ring_cookie == RX_CLS_FLOW_DISC)
+		new_fltr->base.flags |= BNGE_ACT_DROP;
+	else
+		new_fltr->base.rxq = ethtool_get_flow_spec_ring(fs->ring_cookie);
+	__set_bit(BNGE_FLTR_VALID, &new_fltr->base.state);
+	rc = bnge_insert_ntp_filter(bn, new_fltr, idx);
+	if (!rc) {
+		rc = bnge_hwrm_cfa_ntuple_filter_alloc(bn->bd, new_fltr);
+		if (rc) {
+			bnge_del_ntp_filter_rcu(bn, new_fltr);
+			return rc;
+		}
+		fs->location = BNGE_MAX_L2_FLTRS + new_fltr->base.sw_id;
+		return 0;
+	}
+
+err_free_fltr:
+	kfree(new_fltr);
+	return rc;
+}
+
+static int bnge_add_l2_cls_rule(struct bnge_net *bn,
+				struct ethtool_rx_flow_spec *fs)
+{
+	u32 ring = ethtool_get_flow_spec_ring(fs->ring_cookie);
+	struct ethhdr *h_ether = &fs->h_u.ether_spec;
+	struct ethhdr *m_ether = &fs->m_u.ether_spec;
+	struct bnge_l2_filter *fltr;
+	struct bnge_l2_key key;
+	u16 vnic_id;
+	u8 flags;
+	int rc;
+
+	if (!is_broadcast_ether_addr(m_ether->h_dest))
+		return -EINVAL;
+
+	if (is_broadcast_ether_addr(h_ether->h_dest) ||
+	    is_multicast_ether_addr(h_ether->h_dest))
+		return -EINVAL;
+
+	ether_addr_copy(key.dst_mac_addr, h_ether->h_dest);
+	key.vlan = 0;
+	if (fs->flow_type & FLOW_EXT) {
+		struct ethtool_flow_ext *m_ext = &fs->m_ext;
+		struct ethtool_flow_ext *h_ext = &fs->h_ext;
+
+		if (m_ext->vlan_tci != htons(0xfff) || !h_ext->vlan_tci)
+			return -EINVAL;
+		key.vlan = ntohs(h_ext->vlan_tci);
+	}
+
+	flags = BNGE_ACT_RING_DST;
+	vnic_id = bn->vnic_info[BNGE_VNIC_DEFAULT].fw_vnic_id;
+
+	fltr = bnge_alloc_user_l2_filter(bn, &key, flags);
+	if (IS_ERR(fltr))
+		return PTR_ERR(fltr);
+
+	fltr->base.fw_vnic_id = vnic_id;
+	fltr->base.rxq = ring;
+	rc = bnge_hwrm_l2_filter_alloc(bn->bd, fltr);
+	if (rc)
+		bnge_del_l2_filter_rcu(bn, fltr);
+	else
+		fs->location = fltr->base.sw_id;
+	return rc;
+}
+
+static int bnge_srxclsrlins(struct bnge_net *bn, struct ethtool_rxnfc *cmd)
+{
+	struct ethtool_rx_flow_spec *fs = &cmd->fs;
+	struct bnge_dev *bd = bn->bd;
+	u32 ring, flow_type;
+	int rc;
+
+	if (!netif_running(bn->netdev))
+		return -EAGAIN;
+	if (!(bn->priv_flags & BNGE_NET_EN_NTUPLE))
+		return -EPERM;
+	if (fs->location != RX_CLS_LOC_ANY)
+		return -EINVAL;
+
+	flow_type = fs->flow_type;
+	if ((flow_type == IP_USER_FLOW ||
+	     flow_type == IPV6_USER_FLOW) &&
+	    !(bd->fw_cap & BNGE_FW_CAP_CFA_NTUPLE_RX_EXT_IP_PROTO))
+		return -EOPNOTSUPP;
+
+	if (flow_type & FLOW_MAC_EXT)
+		return -EINVAL;
+
+	flow_type &= ~FLOW_EXT;
+
+	if (fs->ring_cookie == RX_CLS_FLOW_DISC && flow_type != ETHER_FLOW)
+		return bnge_add_ntuple_cls_rule(bn, cmd);
+
+	ring = ethtool_get_flow_spec_ring(fs->ring_cookie);
+	if (ring >= bd->rx_nr_rings)
+		return -EINVAL;
+
+	if (flow_type == ETHER_FLOW)
+		rc = bnge_add_l2_cls_rule(bn, fs);
+	else
+		rc = bnge_add_ntuple_cls_rule(bn, cmd);
+	return rc;
+}
+
+static int bnge_srxclsrldel(struct bnge_net *bn, struct ethtool_rxnfc *cmd)
+{
+	struct ethtool_rx_flow_spec *fs = &cmd->fs;
+	struct bnge_filter_base *fltr_base;
+	struct bnge_ntuple_filter *fltr;
+	u32 id = fs->location;
+
+	rcu_read_lock();
+	fltr_base = bnge_get_one_fltr_rcu(bn, bn->l2_fltr_hash_tbl,
+					  BNGE_L2_FLTR_HASH_SIZE, id, 0);
+	if (fltr_base) {
+		struct bnge_l2_filter *l2_fltr;
+
+		l2_fltr = container_of(fltr_base, struct bnge_l2_filter, base);
+		rcu_read_unlock();
+		bnge_hwrm_l2_filter_free(bn->bd, l2_fltr);
+		bnge_del_l2_filter_rcu(bn, l2_fltr);
+		return 0;
+	}
+	fltr_base = bnge_get_one_fltr_rcu(bn, bn->ntp_fltr_hash_tbl,
+					  BNGE_NTP_FLTR_HASH_SIZE, id,
+					  BNGE_MAX_L2_FLTRS);
+	if (!fltr_base) {
+		rcu_read_unlock();
+		return -ENOENT;
+	}
+
+	fltr = container_of(fltr_base, struct bnge_ntuple_filter, base);
+	if (!(fltr->base.flags & BNGE_ACT_NO_AGING)) {
+		rcu_read_unlock();
+		return -EINVAL;
+	}
+	rcu_read_unlock();
+	bnge_hwrm_cfa_ntuple_filter_free(bn->bd, fltr);
+	bnge_del_ntp_filter_rcu(bn, fltr);
+	return 0;
+}
+
+static int bnge_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
+			  u32 *rule_locs)
+{
+	struct bnge_net *bn = netdev_priv(dev);
+	struct bnge_dev *bd = bn->bd;
+	int rc = 0;
+
+	switch (cmd->cmd) {
+	case ETHTOOL_GRXCLSRLCNT:
+		cmd->rule_cnt = bn->user_fltr_count;
+		cmd->data = bd->max_fltr | RX_CLS_LOC_SPECIAL;
+		break;
+
+	case ETHTOOL_GRXCLSRLALL:
+		rc = bnge_grxclsrlall(bn, cmd, (u32 *)rule_locs);
+		break;
+
+	case ETHTOOL_GRXCLSRULE:
+		rc = bnge_grxclsrule(bn, cmd);
+		break;
+
+	default:
+		rc = -EOPNOTSUPP;
+		break;
+	}
+
+	return rc;
+}
+
+static int bnge_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd)
+{
+	struct bnge_net *bn = netdev_priv(dev);
+	int rc;
+
+	switch (cmd->cmd) {
+	case ETHTOOL_SRXCLSRLINS:
+		rc = bnge_srxclsrlins(bn, cmd);
+		break;
+
+	case ETHTOOL_SRXCLSRLDEL:
+		rc = bnge_srxclsrldel(bn, cmd);
+		break;
+
+	default:
+		rc = -EOPNOTSUPP;
+		break;
+	}
+	return rc;
+}
+
 static const struct ethtool_ops bnge_ethtool_ops = {
 	.cap_link_lanes_supported	= 1,
 	.get_link_ksettings	= bnge_get_link_ksettings,
@@ -1167,6 +1751,8 @@ static const struct ethtool_ops bnge_ethtool_ops = {
 	.create_rxfh_context	= bnge_create_rxfh_context,
 	.modify_rxfh_context	= bnge_modify_rxfh_context,
 	.remove_rxfh_context	= bnge_remove_rxfh_context,
+	.get_rxnfc		= bnge_get_rxnfc,
+	.set_rxnfc		= bnge_set_rxnfc,
 };
 
 void bnge_set_ethtool_ops(struct net_device *dev)
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_filter.c b/drivers/net/ethernet/broadcom/bnge/bnge_filter.c
index 88d0ed57a448..9da3c976cf3a 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_filter.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_filter.c
@@ -563,3 +563,61 @@ int bnge_hwrm_set_vnic_filter(struct bnge_net *bn, u16 vnic_id, u16 idx,
 	bnge_del_l2_filter(bn, fltr);
 	return rc;
 }
+
+static void bnge_cfg_one_usr_fltr(struct bnge_net *bn,
+				  struct bnge_filter_base *fltr)
+{
+	struct bnge_ntuple_filter *ntp_fltr;
+	struct bnge_l2_filter *l2_fltr;
+
+	if (list_empty(&fltr->list_node))
+		return;
+
+	if (fltr->type == BNGE_FLTR_TYPE_NTUPLE) {
+		ntp_fltr = container_of(fltr, struct bnge_ntuple_filter, base);
+		l2_fltr = bn->vnic_info[BNGE_VNIC_DEFAULT].l2_filters[0];
+		ntp_fltr->l2_filter_id = l2_fltr->base.filter_id;
+		if (bnge_hwrm_cfa_ntuple_filter_alloc(bn->bd, ntp_fltr)) {
+			netdev_err(bn->netdev,
+				   "restoring previously configured ntuple filter id %d failed\n",
+				   fltr->sw_id);
+			bnge_del_ntp_filter_rcu(bn, ntp_fltr);
+		}
+	} else if (fltr->type == BNGE_FLTR_TYPE_L2) {
+		l2_fltr = container_of(fltr, struct bnge_l2_filter, base);
+		if (bnge_hwrm_l2_filter_alloc(bn->bd, l2_fltr)) {
+			netdev_err(bn->netdev,
+				   "restoring previously configured l2 filter id %d failed\n",
+				   fltr->sw_id);
+			bnge_del_l2_filter(bn, l2_fltr);
+		}
+	}
+}
+
+void bnge_cfg_usr_fltrs(struct bnge_net *bn)
+{
+	struct bnge_filter_base *usr_fltr, *tmp;
+
+	list_for_each_entry_safe(usr_fltr, tmp, &bn->usr_fltr_list, list_node)
+		bnge_cfg_one_usr_fltr(bn, usr_fltr);
+}
+
+void bnge_clear_usr_fltrs(struct bnge_net *bn)
+{
+	struct bnge_filter_base *usr_fltr, *tmp;
+	struct bnge_ntuple_filter *ntp_fltr;
+	struct bnge_l2_filter *l2_fltr;
+
+	list_for_each_entry_safe(usr_fltr, tmp, &bn->usr_fltr_list, list_node) {
+		if (usr_fltr->type == BNGE_FLTR_TYPE_NTUPLE) {
+			ntp_fltr = container_of(usr_fltr,
+						struct bnge_ntuple_filter,
+						base);
+			bnge_del_ntp_filter(bn, ntp_fltr);
+		} else if (usr_fltr->type == BNGE_FLTR_TYPE_L2) {
+			l2_fltr = container_of(usr_fltr, struct bnge_l2_filter,
+					       base);
+			bnge_del_l2_filter(bn, l2_fltr);
+		}
+	}
+}
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_filter.h b/drivers/net/ethernet/broadcom/bnge/bnge_filter.h
index 050e7988d026..4e9a4e661017 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_filter.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_filter.h
@@ -117,4 +117,6 @@ void bnge_del_ntp_filter(struct bnge_net *bn,
 			 struct bnge_ntuple_filter *nfltr);
 void bnge_del_ntp_filter_rcu(struct bnge_net *bn,
 			     struct bnge_ntuple_filter *fltr);
+void bnge_cfg_usr_fltrs(struct bnge_net *bn);
+void bnge_clear_usr_fltrs(struct bnge_net *bn);
 #endif /* _BNGE_FILTER_H_ */
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
index 883f3f6fbfd4..8a35bc5600d0 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
@@ -906,15 +906,17 @@ int bnge_hwrm_l2_filter_alloc(struct bnge_dev *bd, struct bnge_l2_filter *fltr)
 {
 	struct hwrm_cfa_l2_filter_alloc_output *resp;
 	struct hwrm_cfa_l2_filter_alloc_input *req;
+	u32 flags;
 	int rc;
 
 	rc = bnge_hwrm_req_init(bd, req, HWRM_CFA_L2_FILTER_ALLOC);
 	if (rc)
 		return rc;
 
-	req->flags = cpu_to_le32(CFA_L2_FILTER_ALLOC_REQ_FLAGS_PATH_RX);
-
-	req->flags |= cpu_to_le32(CFA_L2_FILTER_ALLOC_REQ_FLAGS_OUTERMOST);
+	flags = CFA_L2_FILTER_ALLOC_REQ_FLAGS_PATH_RX |
+		CFA_L2_FILTER_ALLOC_REQ_FLAGS_TRAFFIC_L2 |
+		CFA_L2_FILTER_ALLOC_REQ_FLAGS_OUTERMOST;
+	req->flags = cpu_to_le32(flags);
 	req->dst_id = cpu_to_le16(fltr->base.fw_vnic_id);
 	req->enables =
 		cpu_to_le32(CFA_L2_FILTER_ALLOC_REQ_ENABLES_L2_ADDR |
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index eee01777bc3d..3ecbc95772cb 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -2797,6 +2797,7 @@ int bnge_open_core(struct bnge_net *bn)
 	bnge_get_port_module_status(bn);
 
 	bnge_hwrm_realloc_rss_ctx_vnic(bn);
+	bnge_cfg_usr_fltrs(bn);
 
 	return 0;
 
@@ -3156,6 +3157,9 @@ static int bnge_set_features(struct net_device *dev, netdev_features_t features)
 	    !(flags & BNGE_NET_EN_NTUPLE) && bn->num_rss_ctx)
 		return -EBUSY;
 
+	if (!(flags & BNGE_NET_EN_NTUPLE))
+		bnge_clear_usr_fltrs(bn);
+
 	bn->priv_flags = flags;
 
 	return 0;
-- 
2.47.1

