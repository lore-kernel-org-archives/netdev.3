Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7E63563D4
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 06:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781849645; cv=none; b=cKY3jnTku8Yrn5/C8ZzcjwHi32/CQrrbmkF5S9Fxx97yvljPKTz5fJQJGsxel8SqyEGnZlYfwDbJcypaKkeYu97x9vGRxXNu7ZxeA+4JHpaHa/1TM8XkLPUo3VUIkyJweADNGCNSTlCYI0zmumrFDvzWOH9T2jcTXzvMCVuW+1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781849645; c=relaxed/simple;
	bh=5gTf0D/kZbxpMwf2NbUuNqiS0F8FbLNZTRIysb3NvII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hQXJZnVIl2ZzCZbLMdwnWSLCt0EKxiCHkwTKTvYd6I23L/WjbqmZsCLCsnpGV9SHglMF/6xCfeFmLmqAxC5pf/JeMUn9Ao8AgJSw4/RlmFNEtTe8ajF0Y43tQCZEvbA39eJdfzvDqO9R+5HAI5R2fLQ0ugK1w5GPILliY4bt9Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AZApYOHD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AZApYOHD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781849643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EnHOx5jThfx6icAHSSrKrfmAgOd3d6MwT6ky6oBJZN0=;
	b=AZApYOHDajBI0z+Bxmf0a00cC3b/6z5Awp4S85nmaqL8OVRggaw5sCBfclKcj/OBolkRgb
	USEJUpwjbjnrtrv9dUu3UNdSBDZdLkY+lWlonm5Tf0tG6qFCtZgeY26hJqjSEk2V1KRBVZ
	AZ3IcCziNAikP1fsuwwDvGyOx9Rx5ts=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-711-sM7DC1uLMEWhLDVDXjfV8Q-1; Fri,
 19 Jun 2026 02:13:59 -0400
X-MC-Unique: sM7DC1uLMEWhLDVDXjfV8Q-1
X-Mimecast-MFC-AGG-ID: sM7DC1uLMEWhLDVDXjfV8Q_1781849638
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 03B171800741;
	Fri, 19 Jun 2026 06:13:58 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.65])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 62F22195608C;
	Fri, 19 Jun 2026 06:13:53 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org,
	przemyslaw.kitszel@intel.com,
	aleksandr.loktionov@intel.com,
	jacob.e.keller@intel.com,
	horms@kernel.org,
	jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Subject: [PATCH net v6 4/4] ice: skip unnecessary VF reset when setting trust
Date: Fri, 19 Jun 2026 08:13:19 +0200
Message-ID: <20260619061321.8554-5-jtornosm@redhat.com>
In-Reply-To: <20260619061321.8554-1-jtornosm@redhat.com>
References: <20260619061321.8554-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Similar to the i40e fix, ice_set_vf_trust() unconditionally calls
ice_reset_vf() when the trust setting changes. While the delay is smaller
than i40e, this reset is still unnecessary in most cases.

When granting trust, no reset is needed - we can just set the capability
flag to allow privileged operations.

When revoking trust, we only need to reset (conservative approach) if
the VF has actually configured advanced features that require cleanup
(MAC LLDP filters, promiscuous mode). For VFs in a clean state, we can
safely change the trust setting without the disruptive reset.

When we do reset, we maintain the original ice pattern that has been
reliable in production: cleanup LLDP filters first, then set vf->trusted,
then reset. This ensures the privilege capability bit is handled correctly
during reset rebuild.

When we don't reset, we manually handle the capability flag via helper
function, eliminating the delay.

Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
v6: AI review identified issues with v5's reset-before-cleanup approach. Revert
    to original reset procedure (cleanup before reset) which has proven reliable,
    just adding the conditional check to skip reset when VF has no advanced
    features configured.
v5: https://lore.kernel.org/all/20260429102426.210750-5-jtornosm@redhat.com/

 drivers/net/ethernet/intel/ice/ice_sriov.c | 33 +++++++++++++++++++---
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index 7e00e091756d..XXXXXXXXXXXXXXXX 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -1364,6 +1364,23 @@ int ice_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac)
 	return __ice_set_vf_mac(ice_netdev_to_pf(netdev), vf_id, mac);
 }

+/**
+ * ice_setup_vf_trust - Enable/disable VF trust mode without reset
+ * @vf: VF to configure
+ * @setting: trust setting
+ *
+ * Update VF flags when changing trust without performing a VF reset.
+ * This is only called when it's safe to skip the reset (VF has no advanced
+ * features configured that need cleanup).
+ */
+static void ice_setup_vf_trust(struct ice_vf *vf, bool setting)
+{
+	if (setting)
+		set_bit(ICE_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps);
+	else
+		clear_bit(ICE_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps);
+}
+
 /**
  * ice_set_vf_trust
  * @netdev: network interface device structure
@@ -1399,11 +1416,19 @@ int ice_set_vf_trust(struct net_device *netdev, int vf_id, bool trusted)

 	mutex_lock(&vf->cfg_lock);

-	while (!trusted && vf->num_mac_lldp)
-		ice_vf_update_mac_lldp_num(vf, ice_get_vf_vsi(vf), false);
-
+	/* Reset only if revoking trust and VF has advanced features configured */
+	if (!trusted &&
+	    (vf->num_mac_lldp > 0 ||
+	     test_bit(ICE_VF_STATE_UC_PROMISC, vf->vf_states) ||
+	     test_bit(ICE_VF_STATE_MC_PROMISC, vf->vf_states))) {
+		while (vf->num_mac_lldp)
+			ice_vf_update_mac_lldp_num(vf, ice_get_vf_vsi(vf), false);
+		vf->trusted = trusted;
+		ice_reset_vf(vf, ICE_VF_RESET_NOTIFY);
+	} else {
+		vf->trusted = trusted;
+		ice_setup_vf_trust(vf, trusted);
+	}
-	vf->trusted = trusted;
-	ice_reset_vf(vf, ICE_VF_RESET_NOTIFY);
 	dev_info(ice_pf_to_dev(pf), "VF %u is now %strusted\n",
 		 vf_id, trusted ? "" : "un");

--
2.43.0

