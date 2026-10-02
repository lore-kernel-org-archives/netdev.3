Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB98349B207
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 13:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790946528; cv=none; b=h21XcLxaismo547gaPtXw3XaYzNmTVS99R5ioun9faVenMQ0KFKpwAte4besjSuFP6sFyUbJ3xfQfbnTcJfBzA0/8TgAPASFBP0gKbMT/lKqNilzL/Cv+xBfOSxlswdoC/mjLOoKvB+0osdESo8vTwond4DWYMiYCqN2LHmp8ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790946528; c=relaxed/simple;
	bh=ThYM+Cb0UPvXejry89ZS7usDzAHNwrgtQvYbDxz7njo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q7dcCmcXwUS0JF7kU7kGMbLc+UZrjJMYd4ojJMWw+UNKEd3KpG5wQNBjmTbv85QwDKyx+L3werMqNp+khtR3IF7v0sKX4JIYj0BB5l9WilIRmPKDoKIpXUumZIeWE+e9E+ERBZx8AeBa0VkCAasjHNTQZUyPcpgfbPydxsFyz4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aZf9ziIv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aZf9ziIv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790946518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YulG5bJgMGBjiytjh2Hc9hcOj+okxOhkE66bat0zKVI=;
	b=aZf9ziIvGrRxaVvt/EXbdZGrF36MbEelnyh1i9cil3KGPRxnPeuQ7qL7vlTJAT2GrJu1Pn
	8esCz5XpgMsJbbqjijzY1kiZE+1vspJGGgD0un+oFNEM2cz9eorefxcqDjHKeRzyRF7zIR
	JBRT1sa//ortn9FpRR/VWffwj3GUI1I=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-353-HZ9L1NsWNp6DG-FSepvN4g-1; Fri,
 02 Oct 2026 09:08:35 -0400
X-MC-Unique: HZ9L1NsWNp6DG-FSepvN4g-1
X-Mimecast-MFC-AGG-ID: HZ9L1NsWNp6DG-FSepvN4g_1790946511
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4B3151955D9F;
	Fri,  2 Oct 2026 13:08:31 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.32.39])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 33670754;
	Fri,  2 Oct 2026 13:08:25 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Henry Tieman <henry.w.tieman@intel.com>,
	Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Jesse Brandeburg <jbrandeb@kernel.org>,
	Preethi Banala <preethi.banala@intel.com>,
	Kiran Patil <kiran.patil@intel.com>,
	Dan Nowlin <dan.nowlin@intel.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH iwl-net 04/10] ice: restore the default XPS map after a netdev TC change
Date: Fri,  2 Oct 2026 15:07:46 +0200
Message-ID: <20261002130752.2597259-5-poros@redhat.com>
In-Reply-To: <20261002130752.2597259-1-poros@redhat.com>
References: <20261002130752.2597259-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

ice_cfg_xps_tx_ring() programs the default XPS map only once per ring,
guarded by ICE_TX_XPS_INIT_DONE. netdev_reset_tc() and
netdev_set_num_tc() drop all XPS maps of the device, but the bit is never
cleared, so the default map is not programmed again.

Since commit 122045ca7704 ("ice: config netdev tc before setting queues
number") ice_vsi_open() calls ice_vsi_cfg_netdev_tc() after the Tx
queues have been configured, so the map is wiped right after it was
written on every open and stays empty:

  # cat /sys/class/net/enp4s0f0np0/queues/tx-*/xps_cpus
  0000
  0000
  ...

A DCB reconfiguration ends the same way through ice_vsi_cfg_tc().

Clear ICE_TX_XPS_INIT_DONE in ice_vsi_cfg_netdev_tc(), which resets the
netdev TC state, and configure the netdev TCs in ice_vsi_open() before
the Tx queues so the default map is applied after the reset, not before
it.

i40e fixed the same stale bit in commit 82e0572b2302 ("i40e: Fix not
setting default xps_cpus after reset").

Fixes: 122045ca7704 ("ice: config netdev tc before setting queues number")
Assisted-by: LLM
Signed-off-by: Petr Oros <poros@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c  | 6 ++++++
 drivers/net/ethernet/intel/ice/ice_main.c | 6 +++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 5e183314e0d792..416e2d6a6f1709 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -3218,6 +3218,12 @@ void ice_vsi_cfg_netdev_tc(struct ice_vsi *vsi, u8 ena_tc)
 	if (vsi->type == ICE_VSI_CHNL)
 		return;
 
+	if (vsi->tx_rings)
+		ice_for_each_txq(vsi, i)
+			if (vsi->tx_rings[i])
+				clear_bit(ICE_TX_XPS_INIT_DONE,
+					  vsi->tx_rings[i]->xps_state);
+
 	if (!ena_tc) {
 		netdev_reset_tc(netdev);
 		return;
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index e62a8f544345a3..8a21f87eb6ca21 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -7559,6 +7559,9 @@ int ice_vsi_open(struct ice_vsi *vsi)
 	if (err)
 		goto err_setup_rx;
 
+	if (bitmap_empty(pf->txtime_txqs, pf->max_pf_txqs))
+		ice_vsi_cfg_netdev_tc(vsi, vsi->tc_cfg.ena_tc);
+
 	err = ice_vsi_cfg_lan(vsi);
 	if (err)
 		goto err_stop_tx;
@@ -7569,9 +7572,6 @@ int ice_vsi_open(struct ice_vsi *vsi)
 	if (err)
 		goto err_stop_tx;
 
-	if (bitmap_empty(pf->txtime_txqs, pf->max_pf_txqs))
-		ice_vsi_cfg_netdev_tc(vsi, vsi->tc_cfg.ena_tc);
-
 	if (vsi->type == ICE_VSI_PF || vsi->type == ICE_VSI_SF) {
 		/* Notify the stack of the actual queue counts. */
 		err = netif_set_real_num_tx_queues(vsi->netdev, vsi->num_txq);
-- 
2.55.0

