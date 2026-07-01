Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689C149250B
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 13:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782912990; cv=none; b=TZ3X6TPT0fEN3OOAEco9z/kJVvOiCRs4Z6iYXtNwIlF90HSLrWhUcVUGfvry72QbvdgVlD/UAG+CmStNiXXaiulnybPs6/Ii1saIEINE5r5z8jRJlJHJ68vN/y6WhreW4IlHVjjykvpHzrwJUhCvYQCKR1nbymDmZXCBVLjHq6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782912990; c=relaxed/simple;
	bh=Hjw3sRrnHXJgJRf4LESpaU+TTsO62EHbXTHSieIZZX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BeVJfc3rPT+HiK9tTuNHdF8ickzxO0HLMgJMnY8KL8RPbBsTNYEKm1h1D/oVdPqaFeHGiNFSn0tWSDnXYnmcdPpdn+60ooTc9pgHRWHUxhBchJDFb76taeAbw9psuRrZ1iv/zMhUDus6Ar+++6xlmsaJzsDs7vkqYFkuyFt3RPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qmqlk3wO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qmqlk3wO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782912986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FaQqKWe1A+SJoHq5B5QalZHgHJG98WSXNQHkK70ytgM=;
	b=Qmqlk3wOOkn7k8ZGZFxDku0wOEHWHicNTEcVVS74FMI7E95Rz3cn1xBNC0BPkOAkBZrG8B
	IbuxH7Zm5Mlcl2jRZoerEhIviZ1/Jn3bHCYh0n0yYpfsXA6eTe30yuLGwwL413zfEU8xLu
	Fn1Dt37ZWLk5xjdgVUXvhzjBx14vo9A=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-297-FKf5wlHyPC2FqAvItdaLFg-1; Wed,
 01 Jul 2026 09:36:23 -0400
X-MC-Unique: FKf5wlHyPC2FqAvItdaLFg-1
X-Mimecast-MFC-AGG-ID: FKf5wlHyPC2FqAvItdaLFg_1782912980
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B5E5A1954237;
	Wed,  1 Jul 2026 13:36:19 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.49.212])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2EAD3180076D;
	Wed,  1 Jul 2026 13:36:14 +0000 (UTC)
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
	Ivan Vecera <ivecera@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Alice Michael <alice.michael@intel.com>,
	Simon Horman <horms@kernel.org>,
	Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-net v3 2/2] ice: preserve uplink DFLT Rx rule on switchdev release
Date: Wed,  1 Jul 2026 15:36:01 +0200
Message-ID: <20260701133601.2118382-3-poros@redhat.com>
In-Reply-To: <20260701133601.2118382-1-poros@redhat.com>
References: <20260701133601.2118382-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

When the uplink PF is promiscuous, ice_vsi_sync_fltr() installs an
ICE_SW_LKUP_DFLT catch-all Rx rule on the uplink VSI. Entering switchdev
re-affirms it through the idempotent ice_set_dflt_vsi(), but
ice_eswitch_release_env() removed both the Rx and Tx DFLT rules
unconditionally on teardown. That clobbered a promisc-owned Rx rule: it
disappeared while IFF_PROMISC was still set and the sync path was not
retriggered, leaving the uplink without the catch-all the netdev
requested.

Skip the Rx DFLT removal when the uplink is promiscuous, both in
ice_eswitch_release_env() and the err_def_tx unwind of
ice_eswitch_setup_env(); the Tx leg, owned by switchdev, is still removed.
Test the live netdev->flags, the same value ena_rx_filtering() ->
ice_cfg_vlan_pruning() above already keys on, so the preserved rule and
the pruning state stay consistent, including for a promisc change made
while switchdev ran (which never reached the gated filter sync).

Fixes: 5c07be96d8b3 ("ice: Avoid setting default Rx VSI twice in switchdev setup")
Signed-off-by: Petr Oros <poros@redhat.com>
---
v3:
- Corrected the Fixes tag from 1a1c40df2e80 ("ice: set and release
  switchdev environment") to 5c07be96d8b3 ("ice: Avoid setting default
  Rx VSI twice in switchdev setup"), the commit that made
  ice_eswitch_setup_env() use the idempotent ice_set_dflt_vsi(); before
  it a pre-existing promisc DFLT rule made setup fail with -EEXIST so the
  release path was never reached. No code change.

v2: https://lore.kernel.org/all/20260622113428.2565255-3-poros@redhat.com/
v1: https://lore.kernel.org/all/deef5756e534ef06c12d910c5305d3fd205d30a0.1781786935.git.poros@redhat.com/
---
 drivers/net/ethernet/intel/ice/ice_eswitch.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index c30e27bbfe6e25..07e2016fb9481f 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -66,8 +66,10 @@ static int ice_eswitch_setup_env(struct ice_pf *pf)
 	ice_cfg_dflt_vsi(uplink_vsi->port_info, uplink_vsi->idx, false,
 			 ICE_FLTR_TX);
 err_def_tx:
-	ice_cfg_dflt_vsi(uplink_vsi->port_info, uplink_vsi->idx, false,
-			 ICE_FLTR_RX);
+	/* keep the Rx DFLT rule if the uplink is promiscuous (see release_env) */
+	if (!(uplink_vsi->netdev->flags & IFF_PROMISC))
+		ice_cfg_dflt_vsi(uplink_vsi->port_info, uplink_vsi->idx,
+				 false, ICE_FLTR_RX);
 err_def_rx:
 	ice_vsi_del_vlan_zero(uplink_vsi);
 err_vlan_zero:
@@ -276,8 +278,16 @@ static void ice_eswitch_release_env(struct ice_pf *pf)
 	vlan_ops->ena_rx_filtering(uplink_vsi);
 	ice_cfg_dflt_vsi(uplink_vsi->port_info, uplink_vsi->idx, false,
 			 ICE_FLTR_TX);
-	ice_cfg_dflt_vsi(uplink_vsi->port_info, uplink_vsi->idx, false,
-			 ICE_FLTR_RX);
+
+	/* Keep the Rx DFLT rule if the uplink is promiscuous; it must outlive
+	 * the session. Test the live netdev->flags, the same value
+	 * ena_rx_filtering() -> ice_cfg_vlan_pruning() above keys its decision
+	 * on, so the preserved DFLT rule and the pruning state stay consistent.
+	 */
+	if (!(uplink_vsi->netdev->flags & IFF_PROMISC))
+		ice_cfg_dflt_vsi(uplink_vsi->port_info, uplink_vsi->idx,
+				 false, ICE_FLTR_RX);
+
 	ice_fltr_add_mac_and_broadcast(uplink_vsi,
 				       uplink_vsi->port_info->mac.perm_addr,
 				       ICE_FWD_TO_VSI);
-- 
2.54.0

