Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792570442;
	b=fx/PCpdS+mqb7ru95G2gT3zWrGr/J6Lt9O0tKaf8EC2bs/FzypqSTUhP0basfeHOOUgW
	 GmOXUutu3WDbYFlOh47rPcKfeke5Lq2hHbrqlSl5Ak+jykS96G+NDfMIhp3Hs03eU9TWv
	 3KierSl65hHNAak+g1sroNi/1ylM7pfuyvNHv1xsuy0vhoLQghmnPS4oZMd3hOqwzXrRG
	 iMp5nhiINin9iJpVROyuaYj7T/fydrNGTn3b+itXyVCX0E+H56kUVYGAMUg+XWvFUTFl2
	 jGCnH1BTv2vser7IMLn4q3MXqAXQGue/1dE4dE29yBJhDoccIXuTyZGe7b/iRba+r+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792570442;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=h+5upotpbWkKS616EbYzkO2U/9HTbe1gim62mBYsONU=;
	b=SQy0CX+NrF3HEoSsUR2S0i35mWdIvALGOAMmQHzsOxndTYNNV+lcHN6TCwGfZ7pc+S3t
	 nFbYiURadX0EFlW1qirUDOKUB2e+BcLpu9Rb0m2UT3fyoBAWN8Ex8g3MaNfcFCKp+3/1O
	 KHyGIjbpa13Hy1Fu7V1s9bz8zk7chm/JJu12C+Ql3NQvmOYwKVw8vnOZVC4Zazl1PKqD4
	 TPqonOQiePqizFPAAyraoDWVzju8xcZN1DhPRVLZ4XuhfgI0H5NfueGufrepI4NSS6RDC
	 wEe1HPiRklTGIW8w5NPtGlctI9NKXl60sDqaZC31FRS0y1+TTtU/SdtjhM3y0h5dQ4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=126.com;
	spf=pass smtp.mailfrom=126.com;
	dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=lfb7Cbno;
	arc=none smtp.remote-ip=220.197.31.6
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249E5606A319;
	Wed, 21 Oct 2026 08:13:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 249E5606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=lfb7Cbno
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=h+
	5upotpbWkKS616EbYzkO2U/9HTbe1gim62mBYsONU=; b=lfb7CbnoLB9U7z4b8R
	4kjVpGXiCb0abK8fxvA5mwgVV6tHHOhEVNZmPaG2tl5oBNWTlZwLrCzCn0Oo45UG
	rBilBAYzZi/WqQUf+7feezCXyemW1XmOFORiyI1qBrONoZWOok5hBGe0zpMsMvWY
	lIi11CoG/wUhCzO3myduYZ9pA=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PikvCgCnPuwBdNhqu2DIBw--.9989S2;
	Wed, 21 Oct 2026 16:12:51 +0800 (CST)
From: Linkui Xiao <xiaolinkui@126.com>
To: jacob.e.keller@intel.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linkui Xiao <xiaolinkui@kylinos.cn>
Subject: [PATCH iwl-net v2] ice: do not report success for a VF setting that was not applied
Date: Wed, 21 Oct 2026 16:12:48 +0800
Message-Id: <20261021081248.261762-1-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
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
X-CM-TRANSID:PikvCgCnPuwBdNhqu2DIBw--.9989S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Gw1ruF47tFWxKr1DWFy7trb_yoW3JrW5pa
	9YgrZ0gr4DGrW29342qw47ZryYkw1rKay5Jr1rGayYkws8Grs8ZFWrK342gry8A3yfGa43
	tFsrZryDuryDWaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UpVb9UUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBlAPtxGrYdAPd+gAA3c

From: Linkui Xiao <xiaolinkui@kylinos.cn>

__ice_set_vf_mac(), ice_set_vf_trust() and ice_set_vf_port_vlan() store
the new setting in the VF structure and then call ice_reset_vf() to push
it into hardware. The result of ice_reset_vf() is not looked at, and it
could not be: it returns 0 both when the reset ran and when it bailed
out because the VF is disabled.

Whether the reset is skipped is decided by ice_is_vf_disabled(), while
the readiness check that guards these handlers runs before cfg_lock is
taken:

	ret = ice_check_vf_ready_for_cfg(vf);
	if (ret)
		goto out_put_vf;

	mutex_lock(&vf->cfg_lock);

A PF-wide reset can therefore start in between. ice_reset_all_vfs()
raises ICE_VF_DIS in pf->state, rebuilds every VF under its cfg_lock and
only clears the bit again once the last one is done. A handler that
passed the check just before that still gets cfg_lock, and two
interleavings follow:

 - It wins the lock before the rebuild loop reaches this VF. It stores
   the setting, its own reset is skipped, and ice_reset_all_vfs() then
   rebuilds the VF and replays the stored setting through
   ice_vf_rebuild_host_cfg(). Nothing is lost.

 - It gets the lock after this VF has already been rebuilt but before
   ICE_VF_DIS is cleared. ice_vf_set_initialized() has run, so the VF
   looks fully initialised and only the PF-wide bit betrays the reset
   still in flight. The setting is stored, the reset is skipped, and
   ice_reset_all_vfs() is done with this VF, so nothing replays it.

For a MAC address that leaves the switch without a filter for the new
vf->hw_lan_addr, while ip link and the devlink port function already
report it, and vf->pf_set_mac makes ice_vc_can_add_mac() refuse the
address the VF would otherwise choose for itself. The VF stays
unreachable until something else resets it. vf->trusted and
vf->port_vlan_info are stored the same way without being applied.

Repeat the readiness check with cfg_lock held, so that the second
interleaving fails with -EINVAL instead of reporting a setting that
hardware never got. The caller can retry once the reset is over. Only
the flag tests can move inside: ice_check_vf_ready_for_cfg() starts with
ice_wait_on_vf_reset(), which sleeps up to 40 x 20 ms polling for
ICE_VF_STATE_INIT, and the resets that clear that bit set it again from
ice_vf_post_vsi_rebuild() with cfg_lock held. Waiting under cfg_lock
could never observe that transition, it would only stall the reset and
the VF mailbox, which ice_vc_process_vf_msg() serves under the same
lock. The wait therefore stays outside and the flag tests are repeated
inside.

Changing what ice_reset_vf() returns on the skipped path is not an
option, too many callers rely on 0 meaning "nothing to do".

The race was found by code inspection of the ndo VF handlers, it was not
reproduced at runtime and no error message was observed. 

The change has not been tested on real hardware, it was only build tested.

Fixes: e6ba5273d4ed ("ice: Fix race conditions between virtchnl handling and VF ndo ops")
Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
---
v2:
 - Rebased: ice_set_vf_trust() changed under the patch, see 0a01e1df137f
   ("ice: skip unnecessary VF reset when setting trust").
 - Move the readiness check inside the mutex as suggested. Only the flag
   tests can move there: ice_check_vf_ready_for_cfg() starts with the
   sleeping ice_wait_on_vf_reset(), which polls for ICE_VF_STATE_INIT, a bit
   the reset paths set again with cfg_lock held. Under cfg_lock it would
   always time out and stall the reset and the VF mailbox for the full
   800 ms before failing with -EINVAL anyway. The wait stays outside the
   lock and the flag tests are repeated inside it by the new
   ice_check_vf_ready_for_cfg_locked(), which replaces the three ad-hoc
   ice_is_vf_disabled() tests of v1.
 - Extend the changelog with both interleavings, including the one where
   ice_reset_all_vfs() replays the stored setting after the skipped reset.

v1: 
 - Link: https://lore.kernel.org/netdev/20261012082910.283229-1-xiaolinkui@126.com/
 drivers/net/ethernet/intel/ice/ice_sriov.c | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index f893dff39aac..6c5d5b332d09 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -1289,6 +1289,30 @@ ice_get_vf_cfg(struct net_device *netdev, int vf_id, struct ifla_vf_info *ivi)
 	return ret;
 }
 
+/**
+ * ice_check_vf_ready_for_cfg_locked - re-check VF readiness under cfg_lock
+ * @vf: VF to check
+ *
+ * The flag tests of ice_check_vf_ready_for_cfg(), repeated with vf->cfg_lock
+ * held. ice_wait_on_vf_reset() is left out on purpose: it sleeps while it
+ * polls for ICE_VF_STATE_INIT, and the resets that clear that bit set it
+ * again from ice_vf_post_vsi_rebuild() with cfg_lock held, so the wait could
+ * never observe the transition and would only hold the lock for its full
+ * timeout.
+ *
+ * Return: 0 if the VF can still be configured, -EINVAL if it is disabled or
+ * -EBUSY if it is in reset.
+ */
+static int ice_check_vf_ready_for_cfg_locked(struct ice_vf *vf)
+{
+	lockdep_assert_held(&vf->cfg_lock);
+
+	if (ice_is_vf_disabled(vf))
+		return -EINVAL;
+
+	return ice_check_vf_init(vf);
+}
+
 /**
  * __ice_set_vf_mac - program VF MAC address
  * @pf: PF to be configure
@@ -1327,6 +1351,10 @@ int __ice_set_vf_mac(struct ice_pf *pf, u16 vf_id, const u8 *mac)
 
 	mutex_lock(&vf->cfg_lock);
 
+	ret = ice_check_vf_ready_for_cfg_locked(vf);
+	if (ret)
+		goto out_unlock;
+
 	/* VF is notified of its new MAC via the PF's response to the
 	 * VIRTCHNL_OP_GET_VF_RESOURCES message after the VF has been reset
 	 */
@@ -1345,6 +1373,8 @@ int __ice_set_vf_mac(struct ice_pf *pf, u16 vf_id, const u8 *mac)
 	}
 
 	ice_reset_vf(vf, ICE_VF_RESET_NOTIFY);
+
+out_unlock:
 	mutex_unlock(&vf->cfg_lock);
 
 out_put_vf:
@@ -1415,6 +1445,10 @@ int ice_set_vf_trust(struct net_device *netdev, int vf_id, bool trusted)
 
 	mutex_lock(&vf->cfg_lock);
 
+	ret = ice_check_vf_ready_for_cfg_locked(vf);
+	if (ret)
+		goto out_unlock;
+
 	/* Reset only if revoking trust and VF has advanced features configured */
 	if (!trusted &&
 	    (vf->num_mac_lldp > 0 ||
@@ -1431,6 +1465,7 @@ int ice_set_vf_trust(struct net_device *netdev, int vf_id, bool trusted)
 	dev_info(ice_pf_to_dev(pf), "VF %u is now %strusted\n",
 		 vf_id, trusted ? "" : "un");
 
+out_unlock:
 	mutex_unlock(&vf->cfg_lock);
 
 out_put_vf:
@@ -1743,6 +1778,10 @@ ice_set_vf_port_vlan(struct net_device *netdev, int vf_id, u16 vlan_id, u8 qos,
 
 	mutex_lock(&vf->cfg_lock);
 
+	ret = ice_check_vf_ready_for_cfg_locked(vf);
+	if (ret)
+		goto out_unlock;
+
 	vf->port_vlan_info = ICE_VLAN(local_vlan_proto, vlan_id, qos);
 	if (ice_vf_is_port_vlan_ena(vf))
 		dev_info(dev, "Setting VLAN %u, QoS %u, TPID 0x%04x on VF %d\n",
@@ -1751,6 +1790,8 @@ ice_set_vf_port_vlan(struct net_device *netdev, int vf_id, u16 vlan_id, u8 qos,
 		dev_info(dev, "Clearing port VLAN on VF %d\n", vf_id);
 
 	ice_reset_vf(vf, ICE_VF_RESET_NOTIFY);
+
+out_unlock:
 	mutex_unlock(&vf->cfg_lock);
 
 out_put_vf:
-- 
2.25.1

