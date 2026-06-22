Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6500C38E8DB
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 08:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782115854; cv=none; b=WCl5vxerSrnXEbzjW1E5eqnUgrpz0REUrINRwCfXxkIaKFeRc0Y4N2caGiQGwwhXQ5yuNziSFMwWKnwmQ6+sN/zyl2eVW+ZkccSHpsckRTNcRsKBFI7HhFz+F8qCm8qsf+FsRst/vH528oixPAqeZKROhNgrj5bVfpKljPquoOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782115854; c=relaxed/simple;
	bh=ateawJDkKwiFOaq9JN50+EGdsUZifNWa2864obkdk88=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rI03PbdY2gk7Kk6umRXqFK3388NwDs8j/FsAncPZKIBnlW0EsGYevFIgG2CyGj5EMXHup8OH5VO1VaGVXwDSGkjhUPI2ZVOq3DTzLCU4jjKCkr3CwzokWR4rCxTbmvfCx22zSDp0S8ds9qAWNIEbq7wdRzcCSztZNsJYaSgGzlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uaqb02Wa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uaqb02Wa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782115852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UXZOP+NwpCh1BuWnj4b2yaRK6yxmJd5wVcCu1u/UBKQ=;
	b=Uaqb02WacSY9wficPyUe6qYu4OaqzHJxyJedaEQaUK483K9XiCSM3Z+z4UYx4WLq41xIxZ
	OayHsAkGfTi0RzdpjZIyOXohcFt6KPXqixPIh3U+semHvwKwlpdI57tRyAvMk1hV0cXSoI
	D3LvRlw5CnAzoTs6As6RX5LxdSXKd68=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-117-aggsJLFBNk-VKOQ9s2tteA-1; Mon,
 22 Jun 2026 04:10:48 -0400
X-MC-Unique: aggsJLFBNk-VKOQ9s2tteA-1
X-Mimecast-MFC-AGG-ID: aggsJLFBNk-VKOQ9s2tteA_1782115847
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 493E21955E88;
	Mon, 22 Jun 2026 08:10:46 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.33.83])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 82C9318005B5;
	Mon, 22 Jun 2026 08:10:42 +0000 (UTC)
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
	Jacob Keller <jacob.e.keller@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-net] ice: clear the default forwarding VSI rule when releasing a VSI
Date: Mon, 22 Jun 2026 10:10:30 +0200
Message-ID: <20260622081030.2312129-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

When a VSI is configured as the switch's default forwarding VSI
(ICE_SW_LKUP_DFLT) and is then torn down, the rule is left behind in
the switch. ice_vsi_release() no longer removes it, and the SR-IOV VF
free path (ice_free_vfs() -> ice_free_vf_res() -> ice_vf_vsi_release()
-> ice_vsi_release()) does not disable promiscuous mode either, which
only happens on VF reset in ice_vf_clear_all_promisc_modes().

A trusted VF that enters unicast promiscuous mode becomes the default
forwarding VSI (this is the default mode, when the PF does not have VF
true-promiscuous mode enabled). If the VFs are then destroyed without
the VF first leaving promiscuous mode, the ICE_SW_LKUP_DFLT rule for
the now-freed VSI is leaked. When VFs are recreated, a VSI reuses the
freed hw_vsi_id. If it is assigned a different VSI handle than the
leaked rule holds, ice_set_dflt_vsi() does not recognize it as
already-default, and ice_add_update_vsi_list() folds the dangling
(freed) handle into a VSI list, which the firmware rejects. The VSI
handle assigned on re-creation varies, so the failure is intermittent
rather than every cycle.

Reproduce by repeatedly running the cycle below on the two ports of the
same card, where $VF0 and $VF1 are the netdevs of vf 15 once they
appear. The VF must be brought up so iavf actually pushes the unicast
promiscuous request, and the rule must settle before the VFs are torn
down again:

  echo 16 > /sys/class/net/$PF0/device/sriov_numvfs
  echo 16 > /sys/class/net/$PF1/device/sriov_numvfs
  ip link set $PF0 vf 15 trust on
  ip link set $PF1 vf 15 trust on
  ip link set $VF0 up
  ip link set $VF1 up
  ip link set $VF0 promisc on
  ip link set $VF1 promisc on
  sleep 1
  echo 0 > /sys/class/net/$PF0/device/sriov_numvfs
  echo 0 > /sys/class/net/$PF1/device/sriov_numvfs

Within a few cycles the ice PF and iavf VF log:

  Failed to set VSI 25 as the default forwarding VSI, error -22
  Turning on/off promiscuous mode for VF 63 failed, error: -22
  PF returned error -53 (IAVF_ERR_ADMIN_QUEUE_ERROR) to our request 14

This cleanup used to live in ice_vsi_release() but was dropped by the
referenced refactor. Restore it. Clear the default forwarding VSI rule
in ice_vsi_release() when this VSI owns it, which covers every teardown
path.

Fixes: 6624e780a577 ("ice: split ice_vsi_setup into smaller functions")
Signed-off-by: Petr Oros <poros@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 2717cc31bff8fe..408464434506ef 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2872,6 +2872,9 @@ int ice_vsi_release(struct ice_vsi *vsi)
 		return -ENODEV;
 	pf = vsi->back;
 
+	if (ice_is_vsi_dflt_vsi(vsi))
+		ice_clear_dflt_vsi(vsi);
+
 	if (test_bit(ICE_FLAG_RSS_ENA, pf->flags))
 		ice_rss_clean(vsi);
 
-- 
2.53.0

