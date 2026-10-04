Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5093655D1
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 19:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791143052; cv=none; b=kAjfNzpkmayKYGO6QD7PwOaYe90W+WNOqIYn5yjEH3A9l0VPGjguqOziZBA/aOtECKgafaKwXO1sxG0CjD7O1Mu9QUnxyvE7vW1Qz9DnU9kSW5U50iOxR7s1OtKWWewmBaMwT1qg6DdvoKNi3PjMm5k/Ca4k24vO386kQRbn13U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791143052; c=relaxed/simple;
	bh=imrdfYDk0VENbFWm3P3TRfhlP2/Qano50es+05xhvX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RIYru3jdM6CnCVI8CcxzDutZ9Iqz82KtWxRQAJ93g04WvCjNbohX3S/tYOVDmHsZq9f28wIVJRk+8NWNXgDCPy1HDSPFxhCdgr5xvjBBzDDriu5NcZWoEJupzIvA8p+kptOk0Hy3Tn64lN7f+4/+vwX2zp7CB7xB0OP5NJCT5Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 9666347984;
	Sun, 04 Oct 2026 21:44:01 +0200 (CEST)
From: Thomas Lamprecht <t.lamprecht@proxmox.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
	Don Skidmore <donald.c.skidmore@intel.com>,
	Radoslaw Tyl <radoslawx.tyl@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Viacheslav Tyryshkin <s@tyryshkin.me>,
	Melissa Romanus <melissa.romanus@proton.me>
Subject: [PATCH iwl-net 1/2] ixgbe: fix NULL pointer dereference on MDD event without VFs
Date: Sun,  4 Oct 2026 21:36:59 +0200
Message-ID: <20261004193704.2895700-2-t.lamprecht@proxmox.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261004193704.2895700-1-t.lamprecht@proxmox.com>
References: <20261004193704.2895700-1-t.lamprecht@proxmox.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1791143040562

ixgbe_check_mdd_event() treats every flagged pool as a VF: it clears
adapter->vfinfo[pool].clear_to_send and pings the pool's mailbox. But
PF queues can be flagged too, and ixgbe_msg_task() calls it on every
mailbox interrupt, also with SR-IOV disabled, where vfinfo is NULL. An
MDD event on a PF queue then crashes the host in interrupt context:

  ixgbe 0000:01:00.0: Malicious event on VF 0 tx:80000 rx:1
  BUG: kernel NULL pointer dereference, address: 000000000000004c
  RIP: 0010:ixgbe_check_mdd_event+0x124/0x160 [ixgbe]

With SR-IOV enabled, the PF pools follow the VF pools, so an event on
one of them writes past the end of vfinfo instead.

Keep releasing the queues of every flagged pool, as PF queues would
otherwise stay blocked, but only notify VFs. Check num_vfs under
vfs_lock, like ixgbe_msg_task() does, as SR-IOV disable frees vfinfo
after clearing num_vfs under that lock.

Fixes: da3ab95f9b06 ("ixgbe: check for MDD events")
Reported-by: Melissa Romanus <melissa.romanus@proton.me>
Closes: https://lore.kernel.org/netdev/bqzPMb-F5iRWe7S2DWkQDhsK8u9ZoIaK34sF2pHpAjP6WHFb70Weq3pc8ZIVUoIx2EbPHd6HLBzz1HHd3xb5rxRZ9F3w1L6TQAd87S18CPQ=@proton.me/
Reported-by: Viacheslav Tyryshkin <s@tyryshkin.me>
Closes: https://lore.kernel.org/all/abc23ed3-f194-4546-bf99-7152464b93e2@intel.com/
Link: https://bugzilla.proxmox.com/show_bug.cgi?id=7874
Signed-off-by: Thomas Lamprecht <t.lamprecht@proxmox.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
index 431d77da15a5f..7edb84986a312 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
@@ -1444,6 +1444,7 @@ bool ixgbe_check_mdd_event(struct ixgbe_adapter *adapter)
 {
 	struct ixgbe_hw *hw = &adapter->hw;
 	DECLARE_BITMAP(vf_bitmap, 64);
+	unsigned long flags;
 	bool ret = false;
 	int i;
 
@@ -1466,11 +1467,16 @@ bool ixgbe_check_mdd_event(struct ixgbe_adapter *adapter)
 
 			hw->mac.ops.restore_mdd_vf(hw, i);
 
-			/* get the VF to rebuild its queues */
-			adapter->vfinfo[i].clear_to_send = 0;
-			ping = IXGBE_PF_CONTROL_MSG |
-			       IXGBE_VT_MSGTYPE_CTS;
-			ixgbe_write_mbx(hw, &ping, 1, i);
+			/* indexes >= num_vfs are PF queues, no VF to notify */
+			spin_lock_irqsave(&adapter->vfs_lock, flags);
+			if (i < adapter->num_vfs) {
+				/* get the VF to rebuild its queues */
+				adapter->vfinfo[i].clear_to_send = 0;
+				ping = IXGBE_PF_CONTROL_MSG |
+				       IXGBE_VT_MSGTYPE_CTS;
+				ixgbe_write_mbx(hw, &ping, 1, i);
+			}
+			spin_unlock_irqrestore(&adapter->vfs_lock, flags);
 		}
 
 		ret = true;
-- 
2.47.3


