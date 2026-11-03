Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793709489;
	b=yDgw8Z1biYbP6bPv90Kp+OCso08xxsrb1mdijgBXjTq+8+6/4B9nVUSxHh22veUj5r9/
	 FU4HjbijwdtQaELRXp8LWHJIJ7wBoaWHSZfLn7Nv8nFjH7VX17u+oyCdaLHLufTPdGP40
	 uE7VUXpfWGMn3pCYDJeVQPGuo76wrPM1DU1BkJDG6HDQizPPkpITreYlYQG6A3EDHd+yT
	 0Py4mVgaVJ0cIVo7WvLSiXnLzyLGrvDfaHzyP5/PSEop161yDKbtE5fOt9NDZuMQC2Boq
	 UAL+X+AUZQuSbrTZ/Zc6C8adh/Pl/GSNMid+Ew6Ufm94/9IsbBoG2o4I0YGdrAQXBPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793709489;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=CDlQiMXhUNPNhhqn9TBhkvMinNnQa9MeH6T/dw8iW5A=;
	b=3KBvFhP5Ls+gujNlKP/ZJShqDo4F9FR8L/NyBwLpbiVwnlJTPFBMKuszDysYU5JD41hI
	 UsldytyTqg/ms1X35qdkUF1D7jrEDjdIzrXB4zhi3fEvck+pS89orvO0Kc9y7ByyuOsGS
	 RIYItY368iV2aW7wqDbrQuwWXEonNcRW2HH0apj/qVfImKoDDTmcOQhva5IPkdP+Wcvn6
	 7siu9vWfPmPUBQJMf+8uqeTckUZ3xYb1J0zomgDni3+3JLRCxJAQM8LoQTNvou8qQXbaB
	 xbjwsnFbArM2i7wc9IvvbLBsd0RSVTN2apegfL2oVVDsrnJ/EnzX04BnBl3I+ylUtAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=hw85KDdi;
	arc=none smtp.remote-ip=209.85.216.99
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209B7606D838
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 12:38:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 209B7606D838
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=hw85KDdi
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-3ab752f6244so4406925a91.2
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 04:38:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793709488; x=1794314288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CDlQiMXhUNPNhhqn9TBhkvMinNnQa9MeH6T/dw8iW5A=;
        b=mT/WpUE69ALVauJsLKphGASR8NDnbseuCtJ1XmOYW7+3uwG4h2nQdVIqXPrjuHSk2W
         L3rx/JbzArgjZpfgZRlXrsVhA6lmJTOWEbzWTNO/0u0mSyvqTTmdGU5ZpvqeYq8MmhNh
         xL4FqUxpZ5xgQPxFEaHd88htvz/z85yBLjMma0DWyyyRe6pYJvgchRFNnBqxm70zdSXw
         JWSMiGzcNu3bQnbgiP8BrCe4kM3HC86aklvTwCg6vfa87mahgEY1WSzVfrwDItZOyMfm
         3mpodkREycaiIghEo7rNHo4zs4H8a/b2jAeSrX8xnTD3ACU669IvGJr9BqXpXeZAeNlv
         XEIQ==
X-Gm-Message-State: APuU4Z8dv0ft+molHej745Db+UPd0C2XVFB+XXWP7B6QgvozO7dCr0iD
	LBmtUd7fyDiZ8xYNKZnOvTcb3k9KW9HbnlVyyBiZMaktEMJ1MmKr7uKhfeMtEY3p0fxF+nuGLGs
	diGBg5XO1hybTTP9BaCSyGQaMCfpSDBf0vM+N+5ML6jZp68419QDVeSB0oeSkSM1IYQMAgE1BfZ
	sFc0lNgRCsELhCXEnQ27fVw5sdGHVm/bwZ4tPqi373iukUWM9a4lIoNhLm/vaIf4gBxc+6uk4Sx
	v7e8LBccw==
X-Gm-Gg: AYBFou0CgyL3iVmJzjHi/HD3xgFCVEHhgZ/7PDwZxBSxNUd+eiGVzvYKr7UJy3ubd1Y
	5rs5qjhGDV+rYcjM8pYy4lmMs6G8Leb3B0C8bfAdUu3DICmrugDrYcCbZpK8Vznax1H45ASytln
	BNHht4N+IGX7z0HrhdM4AoLMLVtc+xMxY3ez5e8gIVUJG3FGvlK1/fZIRCV4oS3uNqwsSTQvH7b
	eN8Bth6U0Y3e981EHk6OWYwEoeWZRv3H0CrYDDXcH7bly5nCFxWSXKh317Uu7hdC4iESuf2R1yv
	DcH0Xm6FHJLXzAWnZD1e6PTMKHunyBXvFQMyuK5vBgm/V4LYYgarqBACY7D/F704O8KqgYxkkBe
	qe2DwvsyBeF0aehy712DTAQkrihccDCt62np9QxsJIbYWNbLKgNmuhBWixuI3NIN2UsxYPC3+P9
	ckzA2s0/KPGI7f5NRmVcxPXEz8celLHsew9w==
X-Received: by 2002:a17:90b:390c:b0:3ab:e588:c2a8 with SMTP id 98e67ed59e1d1-3ae8985c4e4mr10484760a91.64.1793709488465;
        Tue, 03 Nov 2026 04:38:08 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae87f5d1c3sm3965861a91.3.2026.11.03.04.38.06
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Nov 2026 04:38:08 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3aed1b64104so1868114a91.0
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 04:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793709485; x=1794314285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CDlQiMXhUNPNhhqn9TBhkvMinNnQa9MeH6T/dw8iW5A=;
        b=hw85KDdiqihUXSwGrRXhw0LiqDcrbFQpBiDk0+rIpHyaSyDtel53GdTQbUY21sRKdk
         5PS7F3bXJwgi52JH/UoK8+Ww1i9sUTNp/w18Qru28xzweBTSKbzOu5Ck00+9zWjRmEwi
         tEvOvwxyvJVmfOjxBrmBbI2D4uzBNY3dpKN3M=
X-Received: by 2002:a17:90b:4a83:b0:3a8:c0cd:57fa with SMTP id 98e67ed59e1d1-3ae897c834emr10795587a91.11.1793709485105;
        Tue, 03 Nov 2026 04:38:05 -0800 (PST)
X-Received: by 2002:a17:90b:4a83:b0:3a8:c0cd:57fa with SMTP id 98e67ed59e1d1-3ae897c834emr10795550a91.11.1793709484452;
        Tue, 03 Nov 2026 04:38:04 -0800 (PST)
Received: from H5-S1 ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b08759344dsm2131567a91.13.2026.11.03.04.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 04:38:03 -0800 (PST)
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
Subject: [PATCH net-next v5 08/10] bnge: add NTUPLE filter support in ethtool
Date: Tue,  3 Nov 2026 18:06:48 +0530
Message-ID: <20261103123651.442893-9-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261103123651.442893-1-vikas.gupta@broadcom.com>
References: <20261103123651.442893-1-vikas.gupta@broadcom.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Introduce ethtool rx flow classification (rxnfc) operations for
NTUPLE filter management.

User filters stay in software while the interface is down.
bnge_cfg_usr_fltrs() programs them in firmware again on open, and
bnge_clear_usr_fltrs() deletes them when NTUPLE is turned off.

bnge_hwrm_l2_filter_alloc() sets CFA_L2_FILTER_ALLOC_REQ_FLAGS_TRAFFIC_L2
only for user ETHER_FLOW ring rules. The default and unicast MAC
filters keep the traffic type they had before this patch.

User ETHER_FLOW rules and the unicast address filters share the L2
filter table, so the result depends on the order in which a MAC is
added. If the rule is added first, a later unicast address for the same
MAC (a macvlan, for example) is left to the rule and is delivered only
to the rule's ring, not through the default VNIC. If the unicast address
is added first, adding a rule for the same MAC fails with -EEXIST.

When such a rule is deleted, bnge_del_usr_l2_filter() programs the
unicast filter of the MAC that the rule had been serving. If the
firmware refuses it, a warning is logged and the address is left
without a filter until its address list changes.

The unicast address filters and the user ETHER_FLOW rules share the
same L2 filters. After the old unicast filters are freed,
bnge_cfg_rx_mode() counts the free L2 filters, and when the
addresses do not fit it receives them in promiscuous mode, as
it already does for more than BNGE_MAX_L2_FLTRS - 1 addresses.

BNGE_MAX_UC_ADDRS (4) is removed. The per-VNIC l2_filters[] array and
the uc_list buffer are sized by BNGE_MAX_L2_FLTRS, the number of L2
filters of a function, because the unicast address filters and the user
rules share that pool and the free-L2-filter check above is what limits
them.

Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Dharmender Garg <dharmender.garg@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_ethtool.c | 607 ++++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_filter.c  | 112 ++++
 .../net/ethernet/broadcom/bnge/bnge_filter.h  |   3 +
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.c    |   9 +-
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  |  23 +-
 .../net/ethernet/broadcom/bnge/bnge_vnic.h    |   5 +-
 6 files changed, 752 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c b/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
index c370686e2b38..dfffb3efc333 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
@@ -7,6 +7,7 @@
 #include <net/devlink.h>
 #include <linux/ethtool.h>
 #include <linux/etherdevice.h>
+#include <linux/if_vlan.h>
 #include <linux/ethtool_netlink.h>
 
 #include "bnge.h"
@@ -15,6 +16,7 @@
 #include "bnge_resc.h"
 #include "bnge_ethtool.h"
 #include "bnge_hwrm_lib.h"
+#include "bnge_filter.h"
 
 static int bnge_nway_reset(struct net_device *dev)
 {
@@ -1243,6 +1245,609 @@ static int bnge_remove_rxfh_context(struct net_device *dev,
 	return 0;
 }
 
+#define BNGE_IP_PROTO_FULL_MASK	0xFF
+#define BNGE_IP_PROTO_WILDCARD	0x0
+
+static int bnge_get_all_fltr_ids_rcu(struct bnge_net *bn,
+				     struct hlist_head tbl[],
+				     u32 tbl_size, u32 *ids, u32 start,
+				     u32 id_cnt, u32 offset)
+{
+	u32 i, j = start;
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
+			if (j == id_cnt)
+				return -EMSGSIZE;
+			ids[j++] = fltr->sw_id + offset;
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
+	int count;
+
+	cmd->data = BNGE_MAX_L2_FLTRS + bn->bd->max_fltr;
+	rcu_read_lock();
+	count = bnge_get_all_fltr_ids_rcu(bn, bn->l2_fltr_hash_tbl,
+					  BNGE_L2_FLTR_HASH_SIZE, rule_locs, 0,
+					  cmd->rule_cnt, 0);
+	if (count >= 0)
+		count = bnge_get_all_fltr_ids_rcu(bn, bn->ntp_fltr_hash_tbl,
+						  BNGE_NTP_FLTR_HASH_SIZE,
+						  rule_locs, count,
+						  cmd->rule_cnt,
+						  BNGE_MAX_L2_FLTRS);
+	rcu_read_unlock();
+	if (count < 0)
+		return count;
+
+	cmd->rule_cnt = count;
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
+		fs->ring_cookie = fltr->base.rxq;
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
+		if (ip_mask->tos)
+			goto err_free_fltr;
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
+		if (ip_mask->tclass)
+			goto err_free_fltr;
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
+	/* A rule with no address or port mask is accepted only as an ICMP or
+	 * ICMPv6 protocol match; the verify helpers above admit no other
+	 * protocol-only rule.
+	 */
+	if (!memcmp(&BNGE_FLOW_MASK_NONE, fmasks, sizeof(*fmasks)) &&
+	    !((flow_type == IP_USER_FLOW || flow_type == IPV6_USER_FLOW) &&
+	      fkeys->basic.ip_proto))
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
+	if (ethtool_get_flow_spec_ring_vf(fs->ring_cookie))
+		return -EOPNOTSUPP;
+
+	if (!is_broadcast_ether_addr(m_ether->h_dest))
+		return -EINVAL;
+
+	if (!is_zero_ether_addr(m_ether->h_source) || m_ether->h_proto)
+		return -EOPNOTSUPP;
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
+		if (m_ext->vlan_etype || m_ext->data[0] || m_ext->data[1])
+			return -EOPNOTSUPP;
+
+		key.vlan = ntohs(h_ext->vlan_tci) & VLAN_VID_MASK;
+		if (m_ext->vlan_tci != htons(VLAN_VID_MASK) || !key.vlan)
+			return -EINVAL;
+	}
+
+	flags = BNGE_ACT_RING_DST;
+	vnic_id = bn->vnic_info[BNGE_VNIC_NTUPLE].fw_vnic_id;
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
+		bnge_del_usr_l2_filter(bn, l2_fltr);
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
+		cmd->data = (BNGE_MAX_L2_FLTRS + bd->max_fltr) |
+			    RX_CLS_LOC_SPECIAL;
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
@@ -1275,6 +1880,8 @@ static const struct ethtool_ops bnge_ethtool_ops = {
 	.create_rxfh_context	= bnge_create_rxfh_context,
 	.modify_rxfh_context	= bnge_modify_rxfh_context,
 	.remove_rxfh_context	= bnge_remove_rxfh_context,
+	.get_rxnfc		= bnge_get_rxnfc,
+	.set_rxnfc		= bnge_set_rxnfc,
 };
 
 void bnge_set_ethtool_ops(struct net_device *dev)
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_filter.c b/drivers/net/ethernet/broadcom/bnge/bnge_filter.c
index 3ebb3cae4829..9b3ed0733623 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_filter.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_filter.c
@@ -584,3 +584,115 @@ int bnge_hwrm_set_vnic_filter(struct bnge_net *bn, u16 vnic_id, u16 idx,
 	bnge_del_l2_filter_rcu(bn, fltr);
 	return rc;
 }
+
+/* bnge_cfg_rx_mode() installs no filter for a unicast address that already
+ * has a user L2 rule; reinstall it once the user rule is gone.
+ */
+void bnge_del_usr_l2_filter(struct bnge_net *bn, struct bnge_l2_filter *fltr)
+{
+	u8 mac[ETH_ALEN] __aligned(2);
+	struct bnge_vnic_info *vnic;
+	int i, off;
+	bool vlan;
+
+	ether_addr_copy(mac, fltr->l2_key.dst_mac_addr);
+	vlan = !!fltr->l2_key.vlan;
+	bnge_del_l2_filter_rcu(bn, fltr);
+
+	if (vlan || !test_bit(BNGE_STATE_OPEN, &bn->bd->state))
+		return;
+
+	vnic = &bn->vnic_info[BNGE_VNIC_DEFAULT];
+	for (i = 1, off = 0; i < vnic->uc_filter_count; i++, off += ETH_ALEN) {
+		if (vnic->l2_filters[i] ||
+		    !ether_addr_equal(vnic->uc_list + off, mac))
+			continue;
+		if (bnge_hwrm_set_vnic_filter(bn, 0, i, vnic->uc_list + off))
+			netdev_warn(bn->netdev,
+				    "failed to restore uc filter %pM\n", mac);
+		break;
+	}
+}
+
+static bool bnge_usr_fltr_ring_lost(struct bnge_net *bn,
+				    struct bnge_filter_base *fltr)
+{
+	if (fltr->flags & (BNGE_ACT_DROP | BNGE_ACT_RSS_CTX) ||
+	    fltr->rxq < bn->bd->rx_nr_rings)
+		return false;
+
+	netdev_warn(bn->netdev, "filter id %d: rx ring %u no longer exists\n",
+		    fltr->sw_id, fltr->rxq);
+	return true;
+}
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
+		if (bnge_usr_fltr_ring_lost(bn, fltr) ||
+		    bnge_hwrm_cfa_ntuple_filter_alloc(bn->bd, ntp_fltr)) {
+			netdev_err(bn->netdev,
+				   "restoring previously configured ntuple filter id %d failed\n",
+				   fltr->sw_id);
+			bnge_del_ntp_filter_rcu(bn, ntp_fltr);
+		}
+	} else if (fltr->type == BNGE_FLTR_TYPE_L2) {
+		l2_fltr = container_of(fltr, struct bnge_l2_filter, base);
+		fltr->fw_vnic_id = bn->vnic_info[BNGE_VNIC_NTUPLE].fw_vnic_id;
+		if (bnge_usr_fltr_ring_lost(bn, fltr) ||
+		    bnge_hwrm_l2_filter_alloc(bn->bd, l2_fltr)) {
+			netdev_err(bn->netdev,
+				   "restoring previously configured l2 filter id %d failed\n",
+				   fltr->sw_id);
+			bnge_del_usr_l2_filter(bn, l2_fltr);
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
+	netdev_assert_locked(bn->netdev);
+
+	/* bnge_fix_features() ensures NTUPLE can only be toggled while the
+	 * interface is administrative down (!netif_running). At this point,
+	 * all NAPIs and softirqs are disabled, sp_task is locked out under
+	 * netdev_lock() and gated by !BNGE_STATE_OPEN, and the device is
+	 * closed with no active hardware filters in firmware. Therefore,
+	 * synchronous deletion of retained software filter entries here has
+	 * no concurrent readers and leaks no firmware filter resources.
+	 */
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
index 87d66266a9f5..9c5453d5b50a 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_filter.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_filter.h
@@ -106,6 +106,7 @@ bnge_lookup_ntp_filter_from_idx(struct bnge_net *bn,
 				struct bnge_ntuple_filter *fltr, u32 idx);
 void bnge_del_l2_filter(struct bnge_net *bn, struct bnge_l2_filter *fltr);
 void bnge_del_l2_filter_rcu(struct bnge_net *bn, struct bnge_l2_filter *fltr);
+void bnge_del_usr_l2_filter(struct bnge_net *bn, struct bnge_l2_filter *fltr);
 __le64 bnge_lookup_l2_filter_rcu(struct bnge_net *bn,
 				 struct bnge_l2_key *key,
 				 u32 idx);
@@ -120,4 +121,6 @@ void bnge_del_ntp_filter(struct bnge_net *bn,
 			 struct bnge_ntuple_filter *nfltr);
 void bnge_del_ntp_filter_rcu(struct bnge_net *bn,
 			     struct bnge_ntuple_filter *fltr);
+void bnge_cfg_usr_fltrs(struct bnge_net *bn);
+void bnge_clear_usr_fltrs(struct bnge_net *bn);
 #endif /* _BNGE_FILTER_H_ */
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
index 33cbdd6d8276..bb6233351484 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
@@ -906,15 +906,18 @@ int bnge_hwrm_l2_filter_alloc(struct bnge_dev *bd, struct bnge_l2_filter *fltr)
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
+		CFA_L2_FILTER_ALLOC_REQ_FLAGS_OUTERMOST;
+	if (BNGE_L2_FLTR_IS_NTP_MAC(fltr))
+		flags |= CFA_L2_FILTER_ALLOC_REQ_FLAGS_TRAFFIC_L2;
+	req->flags = cpu_to_le32(flags);
 	req->dst_id = cpu_to_le16(fltr->base.fw_vnic_id);
 	req->enables =
 		cpu_to_le32(CFA_L2_FILTER_ALLOC_REQ_ENABLES_L2_ADDR |
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index ff6573b5e60e..f72b912d52f6 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -1108,7 +1108,7 @@ static int bnge_alloc_vnic_attributes(struct bnge_net *bn)
 		vnic = &bn->vnic_info[i];
 
 		if (vnic->flags & BNGE_VNIC_UCAST_FLAG) {
-			int mem_size = (BNGE_MAX_UC_ADDRS - 1) * ETH_ALEN;
+			int mem_size = (BNGE_MAX_L2_FLTRS - 1) * ETH_ALEN;
 
 			vnic->uc_list = kmalloc(mem_size, GFP_KERNEL);
 			if (!vnic->uc_list)
@@ -2056,6 +2056,7 @@ static int bnge_cfg_rx_mode(struct bnge_net *bn, struct netdev_hw_addr_list *uc,
 	int i, off = 0, rc, uc_count = 0;
 	struct bnge_dev *bd = bn->bd;
 	struct netdev_hw_addr *ha;
+	int l2_free;
 
 	if (!uc_update)
 		goto skip_uc;
@@ -2063,6 +2064,8 @@ static int bnge_cfg_rx_mode(struct bnge_net *bn, struct netdev_hw_addr_list *uc,
 	for (i = 1; i < vnic->uc_filter_count; i++) {
 		struct bnge_l2_filter *fltr = vnic->l2_filters[i];
 
+		if (!fltr)
+			continue;
 		bnge_hwrm_l2_filter_free(bd, fltr);
 		bnge_del_l2_filter_rcu(bn, fltr);
 	}
@@ -2079,7 +2082,12 @@ static int bnge_cfg_rx_mode(struct bnge_net *bn, struct netdev_hw_addr_list *uc,
 	netdev_hw_addr_list_for_each(ha, uc)
 		if (!ether_addr_equal(ha->addr, dev->dev_addr))
 			uc_count++;
-	if (uc_count > BNGE_MAX_UC_ADDRS - 1) {
+	/* The unicast addresses and the user ETHER_FLOW rules share the L2
+	 * filters. Receive the addresses that do not fit in promiscuous mode.
+	 */
+	l2_free = BNGE_MAX_L2_FLTRS -
+		  bitmap_weight(bn->l2_fltr_bmap, BNGE_MAX_L2_FLTRS);
+	if (uc_count > BNGE_MAX_L2_FLTRS - 1 || uc_count > l2_free) {
 		vnic->rx_mask |= CFA_L2_SET_RX_MASK_REQ_MASK_PROMISCUOUS;
 	} else {
 		netdev_hw_addr_list_for_each(ha, uc) {
@@ -2095,6 +2103,11 @@ static int bnge_cfg_rx_mode(struct bnge_net *bn, struct netdev_hw_addr_list *uc,
 
 	for (i = 1, off = 0; i < vnic->uc_filter_count; i++, off += ETH_ALEN) {
 		rc = bnge_hwrm_set_vnic_filter(bn, 0, i, vnic->uc_list + off);
+		if (rc == -EEXIST) {
+			/* Already delivered by a user L2 rule */
+			vnic->l2_filters[i] = NULL;
+			continue;
+		}
 		if (rc) {
 			if (rc == -EAGAIN)
 				netdev_warn(dev, "FW busy while setting vnic filter, will retry\n");
@@ -2281,6 +2294,8 @@ static void bnge_hwrm_clear_vnic_filter(struct bnge_net *bn)
 	for (i = 0; i < vnic->uc_filter_count; i++) {
 		struct bnge_l2_filter *fltr = vnic->l2_filters[i];
 
+		if (!fltr)
+			continue;
 		bnge_hwrm_l2_filter_free(bn->bd, fltr);
 		bnge_del_l2_filter_rcu(bn, fltr);
 	}
@@ -2805,6 +2820,7 @@ static int bnge_open_core(struct bnge_net *bn)
 	bnge_get_port_module_status(bn);
 
 	bnge_hwrm_realloc_rss_ctx_vnic(bn);
+	bnge_cfg_usr_fltrs(bn);
 
 	return 0;
 
@@ -3177,6 +3193,9 @@ static int bnge_set_features(struct net_device *dev, netdev_features_t features)
 	    !(flags & BNGE_NET_EN_NTUPLE) && bn->num_rss_ctx)
 		return -EBUSY;
 
+	if (!(flags & BNGE_NET_EN_NTUPLE))
+		bnge_clear_usr_fltrs(bn);
+
 	bn->priv_flags = flags;
 
 	return 0;
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_vnic.h b/drivers/net/ethernet/broadcom/bnge/bnge_vnic.h
index 58f17579db3d..e615690e6b93 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_vnic.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_vnic.h
@@ -4,6 +4,8 @@
 #ifndef _BNGE_VNIC_H_
 #define _BNGE_VNIC_H_
 
+#include "bnge_filter.h"
+
 struct bnge_net;
 struct bnge_dev;
 struct bnge_l2_filter;
@@ -20,7 +22,6 @@ struct bnge_l2_filter;
 #define BNGE_MAX_CTX_PER_VNIC	8
 
 #define BNGE_MAX_MC_ADDRS	16
-#define BNGE_MAX_UC_ADDRS	4
 
 #define BNGE_VNIC_ID_INVALID	0xffffffff
 
@@ -46,7 +47,7 @@ struct bnge_vnic_info {
 	u16		fw_rss_cos_lb_ctx[BNGE_MAX_CTX_PER_VNIC];
 	u16		mru;
 	/* index 0 always dev_addr */
-	struct bnge_l2_filter *l2_filters[BNGE_MAX_UC_ADDRS];
+	struct bnge_l2_filter *l2_filters[BNGE_MAX_L2_FLTRS];
 	u16		uc_filter_count;
 	u8		*uc_list;
 	dma_addr_t	rss_table_dma_addr;
-- 
2.52.0

