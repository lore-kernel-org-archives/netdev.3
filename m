Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3965D2E1746
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 10:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789984829; cv=none; b=VtEQcduXerog09fOiFRo9/zfMDMJdcdOXPcxCk1jB9mnoUN/DYWzvgnDAgfQN31tzbG7ZN6unsGZ1aD/0HEQ1Cw/cJqBgG+ClcsnBKL1IbKEuJJMzT7Roel3FC/x7VLFQQvElMLiBxnD6eT6ReaJsOgQJ/Q2W/ZlokjPajo0Uhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789984829; c=relaxed/simple;
	bh=jGvmlwUSbsp8x3X4MOA4gcbihfZLjlBgUOqmvFopaQU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nTAX5Zr4XcMZhxfhgVspzInXn88QAxWudwtjtZqEw9VVtFw77hblfkn3GMjPa82a5KpBb6p0XZeV6seASWFdTZEMe1KxMFPRszyVFfJc3Ffi5AGwGAaLY+Ap0x8siUmJYxLzsE/mFcR/TIkzV+rB8EGQ+KwXxcJ8paFme+0ttH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jb51o8tH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jb51o8tH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789984827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ajNNixQX6BV58KzbsrlG4634t7w42wShP27NzOztrV8=;
	b=Jb51o8tHkoaJBWm8ZcbgtLajNS3Brepa9H48GUzCN9rzE9mhsMeVUE8k4UgTWMUZEJ2QB6
	iTaXYWwHpl9I7ME7Zu2BllWTcdsUDcAaLHKCtwLpJsKrURYC0MhQ24C1VHI5Ul6hwXu5tx
	8NC9UnQpz0EZGSK8juuSg48FBmacg8s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-0I7bIq2YNmypL7FIiKE9kQ-1; Mon,
 21 Sep 2026 06:00:21 -0400
X-MC-Unique: 0I7bIq2YNmypL7FIiKE9kQ-1
X-Mimecast-MFC-AGG-ID: 0I7bIq2YNmypL7FIiKE9kQ_1789984819
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6619718007F7;
	Mon, 21 Sep 2026 10:00:19 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.32.56])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4DF0B40E;
	Mon, 21 Sep 2026 10:00:15 +0000 (UTC)
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
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-net] ice: restore double VLAN port parameters on devlink reload
Date: Mon, 21 Sep 2026 12:00:00 +0200
Message-ID: <20260921100000.1152575-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Set Port Parameters with the double VLAN flag is issued from probe and
from ice_rebuild(), but not from the devlink reinit path. ice_init_hw()
resets the PF there and the port ends up in single VLAN mode while the
driver keeps operating in DVM, so outer VLAN tags requested through the
Tx descriptor by the PF and by VFs are silently not inserted until the
next probe.

Move the call into ice_init_dev(), which is shared by probe and reinit.

Fixes: 31c8db2c4fa7 ("ice: implement devlink reinit action")
Signed-off-by: Petr Oros <poros@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 423adc138dd67c..8c4b0fbc790644 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4766,6 +4766,14 @@ int ice_init_dev(struct ice_pf *pf)
 	int err;
 
 	ice_set_pf_caps(pf);
+
+	err = ice_aq_set_port_params(pf->hw.port_info, ice_is_dvm_ena(&pf->hw),
+				     NULL);
+	if (err) {
+		dev_err(dev, "ice_aq_set_port_params failed: %d\n", err);
+		return err;
+	}
+
 	err = ice_init_interrupt_scheme(pf);
 	if (err) {
 		dev_err(dev, "ice_init_interrupt_scheme failed: %d\n", err);
@@ -4909,7 +4917,6 @@ static void ice_init_link(struct ice_pf *pf)
 
 static int ice_init_pf_sw(struct ice_pf *pf)
 {
-	bool dvm = ice_is_dvm_ena(&pf->hw);
 	struct ice_vsi *vsi;
 	int err;
 
@@ -4928,10 +4935,6 @@ static int ice_init_pf_sw(struct ice_pf *pf)
 	/* record the sw_id available for later use */
 	pf->first_sw->sw_id = pf->hw.port_info->sw_id;
 
-	err = ice_aq_set_port_params(pf->hw.port_info, dvm, NULL);
-	if (err)
-		goto err_aq_set_port_params;
-
 	vsi = ice_pf_vsi_setup(pf, pf->hw.port_info);
 	if (!vsi) {
 		err = -ENOMEM;
@@ -4941,7 +4944,6 @@ static int ice_init_pf_sw(struct ice_pf *pf)
 	return 0;
 
 err_pf_vsi_setup:
-err_aq_set_port_params:
 	kfree(pf->first_sw);
 	return err;
 }
-- 
2.55.0

