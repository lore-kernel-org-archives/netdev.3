Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C48845FFC7;
	Mon, 12 Oct 2026 08:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791793821; cv=none; b=AVnSPE4KGRsEk1jkYwBlq2uos2K1AvlEneDy9hJPboncU2q7TsvE2/OIR/KYbyUOuc56fsKYgOs2wJFGAKW4z8lNy50Ulzt/nOye2nS00+N8hWWYmPtWJy/g3vWEjQrmDD0ah0LCOQlC4k3mUI5DItA2ivLEA0KHl5OBnvNYtlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791793821; c=relaxed/simple;
	bh=atkKp1Ug09t6FC57/JzSaN2rzxlVDbFpPdEAccjsnKo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F8Uj5R3Egtm3Gl7KKjcKMnYZ2TialV5ENCEMvSPflf1yB+VWtDBUtIB4ADFse1VJF0jBVLdsDQMFmU/cxqtcVRsGJ0FL8fEbWDU0deM3/vm+V0sYO0EFc8GWJer2EzKsbRm9VxgD3JzNBjTJyKL0ZPibXJrbvaJO89TyMSY4Ekc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=MWJUXpCH; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="MWJUXpCH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=/a
	rq3bSiNUhGTgx5pBQcL/wrpeLjPO31tz1LQ4YP/D4=; b=MWJUXpCH8MV8b2ZjXV
	T6V1yMhz/BkgyCoZfS27C7lmG/tmk4F2801CG27mceAPC/gDMhnBDdeecqLW/61X
	w3ZZlgVAkHW1vMZrGW8pRUwYIi5sJ18ATp3XP+t551w1x25JtAEbmXuAwQsdWKu1
	+1teoQolx0YcCAEsIFoSHC9fU=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3NzBXmsxquD7DBA--.7129S2;
	Mon, 12 Oct 2026 16:29:12 +0800 (CST)
From: Linkui Xiao <xiaolinkui@126.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linkui Xiao <xiaolinkui@kylinos.cn>
Subject: [PATCH iwl-net] ice: do not report success for a VF setting that was not applied
Date: Mon, 12 Oct 2026 16:29:10 +0800
Message-Id: <20261012082910.283229-1-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3NzBXmsxquD7DBA--.7129S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCFWUArW8tr4kJFyxCw45Wrg_yoWrtr1fpF
	Z5KFWqqr4DXF4I93sIgF4UZFWYka4FqFWUGr95GFyFkws8ArnYvFWFyrZFvFy8A3yxCa43
	tFsru34DuFyDWaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07ULFxUUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBlRiKYWrMmlh3xAAA3x

From: Linkui Xiao <xiaolinkui@kylinos.cn>

__ice_set_vf_mac(), ice_set_vf_trust() and ice_set_vf_port_vlan() all
check that the VF is ready for configuration, take vf->cfg_lock and then
call ice_reset_vf() to push the new setting into hardware. The result of
ice_reset_vf() is not looked at, and it could not be: it returns 0 both
when the reset ran and when it bailed out because the VF is disabled.

The check runs before the lock is taken, so a reset can disable the VF
in between. ice_reset_all_vfs() raises ICE_VF_DIS in pf->state before it
walks the VF table, rebuilds every VSI and clears the bit again. An
ndo_set_vf_mac() that passed ice_check_vf_ready_for_cfg() just before
that then waits for cfg_lock, stores the new address in vf->dev_lan_addr
and vf->hw_lan_addr and calls ice_reset_vf(), which sees the VF
disabled, stops its queues and returns 0 without reprogramming anything.
__ice_set_vf_mac() reports success, so ip link and the devlink port
function now show a MAC address the hardware never got, and the switch
keeps enforcing the previous one until something else resets the VF.

ice_set_vf_trust() and ice_set_vf_port_vlan() have the same shape: the
port VLAN lands in vf->port_vlan_info and the trust flag in vf->trusted
before the reset is skipped.

Re-check ice_is_vf_disabled() once cfg_lock is held and fail with
-EINVAL, the same code ice_check_vf_ready_for_cfg() returns for a
disabled VF. The VF is being reset or removed at that point, so the
caller should retry rather than be told the setting is in place.
Changing what ice_reset_vf() returns on that path is not an option, too
many callers rely on it meaning "nothing to do".

The race was found by code inspection of the ndo VF handlers, it was not
reproduced at runtime and no error message was observed.

Fixes: e6ba5273d4ed ("ice: Fix race conditions between virtchnl handling and VF ndo ops")
Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
---
 drivers/net/ethernet/intel/ice/ice_sriov.c | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index e04de0215596..de0631673149 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -1327,6 +1327,15 @@ int __ice_set_vf_mac(struct ice_pf *pf, u16 vf_id, const u8 *mac)
 
 	mutex_lock(&vf->cfg_lock);
 
+	/* The VF can have been disabled by a reset after the check above, and
+	 * ice_reset_vf() then skips the reprogram and still returns 0. Fail
+	 * here instead of reporting a MAC address that hardware never got.
+	 */
+	if (ice_is_vf_disabled(vf)) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
 	/* VF is notified of its new MAC via the PF's response to the
 	 * VIRTCHNL_OP_GET_VF_RESOURCES message after the VF has been reset
 	 */
@@ -1345,6 +1354,8 @@ int __ice_set_vf_mac(struct ice_pf *pf, u16 vf_id, const u8 *mac)
 	}
 
 	ice_reset_vf(vf, ICE_VF_RESET_NOTIFY);
+
+out_unlock:
 	mutex_unlock(&vf->cfg_lock);
 
 out_put_vf:
@@ -1401,6 +1412,14 @@ int ice_set_vf_trust(struct net_device *netdev, int vf_id, bool trusted)
 
 	mutex_lock(&vf->cfg_lock);
 
+	/* See __ice_set_vf_mac(), the VF can have been disabled after the
+	 * check above and ice_reset_vf() would skip the reprogram.
+	 */
+	if (ice_is_vf_disabled(vf)) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
 	while (!trusted && vf->num_mac_lldp)
 		ice_vf_update_mac_lldp_num(vf, ice_get_vf_vsi(vf), false);
 
@@ -1409,6 +1428,7 @@ int ice_set_vf_trust(struct net_device *netdev, int vf_id, bool trusted)
 	dev_info(ice_pf_to_dev(pf), "VF %u is now %strusted\n",
 		 vf_id, trusted ? "" : "un");
 
+out_unlock:
 	mutex_unlock(&vf->cfg_lock);
 
 out_put_vf:
@@ -1721,6 +1741,14 @@ ice_set_vf_port_vlan(struct net_device *netdev, int vf_id, u16 vlan_id, u8 qos,
 
 	mutex_lock(&vf->cfg_lock);
 
+	/* See __ice_set_vf_mac(), the VF can have been disabled after the
+	 * check above and ice_reset_vf() would skip the reprogram.
+	 */
+	if (ice_is_vf_disabled(vf)) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
 	vf->port_vlan_info = ICE_VLAN(local_vlan_proto, vlan_id, qos);
 	if (ice_vf_is_port_vlan_ena(vf))
 		dev_info(dev, "Setting VLAN %u, QoS %u, TPID 0x%04x on VF %d\n",
@@ -1729,6 +1757,8 @@ ice_set_vf_port_vlan(struct net_device *netdev, int vf_id, u16 vlan_id, u8 qos,
 		dev_info(dev, "Clearing port VLAN on VF %d\n", vf_id);
 
 	ice_reset_vf(vf, ICE_VF_RESET_NOTIFY);
+
+out_unlock:
 	mutex_unlock(&vf->cfg_lock);
 
 out_put_vf:
-- 
2.25.1

