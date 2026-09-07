Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC2C4854F7
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 11:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788781972; cv=none; b=M34BzEXF+m5Hw/DPEH3OJKzIGjHN6QOqCa0Kq3ip9ZV159d/sU+Nv/Eewislz/bjOIKbJV40XYfrnm3NU6GvwmtO3Y2lKgFw/otOvUBzjc8Qwgw8wOS25N8TqHcHbAoRi7zSTBZHB1HqQ9IUAGrWEkmrgYPZe9BQ5Lrm7/q+UxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788781972; c=relaxed/simple;
	bh=j+kR/2Re7fKviRsbkqKbZ9oXq6/pkpPaLWbKg3fVXIs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YKzXVQlcOeR/+GuNZF40efRG+Z0NVNMhNT0Yt7oc8zsW46LRlPV5SGdMeidAPOXANa43jt+CwuvEzts9dAlkqSvClv6X+QL0w2oxmKz+O6/SpO0H59tm34xQXRldMvoyzrJQriIbqJosGA51YHy5wdlorxQ7eqwp2UhcLA2zHog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=crItAjf4; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="crItAjf4"
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id DCFA83F4C1
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 11:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1788781966;
	bh=t3fkNHFm1RR4RErP9CR45D7pPPNRjAdZ1eP2jcftRKs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=crItAjf4t+qa6L6x7N9addrM0OkHNh2XkTzg45dJVRubBz0mEKerfAbfcs+lKpS4f
	 SSA6e+LsNqfEJoTW+tBefdVdW+yjNsCpPFWgcyys0Hxtn4U228qnIs8T0AZI/6gCUY
	 9mkgHrm0g5LR8JK5ZvMSDbgK0k2vXJJt3ZqkZpckMe1etQe373WOzny9Jh7/pSiy+p
	 d/mYWvJ2nyQwvR8iZKrlq0lkeymgB+AvlZSaf92LdGMElRQuKll1aenDtJS6Jzs1ec
	 tXvvuuL03ZTKzPpYRedtPfXtDdiB3YARLgqmbxyzBWbhwT5JI8JhuWx4Kaa+uyCXt+
	 qvIm7ZoJe867IrEb0QKh34QI8VcdaUH4U8c9cPVhvVf/JGGh110LN7f+w5m1FPznCN
	 Wd7RpLkiAue8GgSdTbvpXUvAB3VpfWqSqgf13YeoHsNuk//jRtp9sVmVu+gZtnaadI
	 iL3ddRhErNEODXvptSDj9cSsgcYAcuIGvcIXKk9ACA95fqDaI94EZ7KducYlrJYiPv
	 vjEJJKQAcgYdFfCTqtySI/c9sBqXZgNLIHuLjPrCtxZ/03sPYxnDr22lC/XLIjFZv4
	 viBXIumSHyRJ0qGhyLtxHSncYAhhUACMSwk4vqQ88jenV+gEB/o/qZXEFJPjC3cph+
	 JY48yWqYkqLwTy0tH7ZfNptg=
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-39aee9b4cf2so5536867a91.0
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 04:52:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788781965; x=1789386765;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t3fkNHFm1RR4RErP9CR45D7pPPNRjAdZ1eP2jcftRKs=;
        b=J/D//LBd8x2jByIYOHPL8ifUrMTidiQRTHvcSii5kM36dsvalFY2hQUcpybNqiVeyq
         B9CbO+nlumgu3xbwwHJ7Iz+8wml+F5PiE9M929fBktCkYK3C3HvcPlT2aChpgCUh9nkV
         h12S58fTQWsXW21hCRUWqr77ycTPNft+arpZA6YWIWNkmfkH/J4379wbUBg1SEW6VjSi
         7OMDk1GzLi8zxZvFhc0p2A7vdbntphMnwrJaIeAsykv2kTNY/P1lUQ8xAJdU0U/68K8B
         OhDsIl4oadKduBR4DXu4UkJ5sva/auEx3tAHqbJPNSxxqPY/9W/P/HKicZTdLFtc7S5P
         hYZw==
X-Forwarded-Encrypted: i=1; AKwUvBymBbmUsSWsVRY9Ob4Ht6ivHFBDnv6TTsc+Nmt1vU0Z/5+0XeNvlKcs747pgTiFi1oDFdFk4eE=@vger.kernel.org
X-Gm-Message-State: AFuF++nWeF9HXQdNh25Qj2pzicQdObu1zOQTTGuukK/k9TGyrIqF8J2r
	P+dmo7RzaSWyRJuCYUuipkke24k3NBil31ZODrrJm1vhnj5s19yvhYxMGY63OncHv0gujBB6pwR
	j9SssjuwGQ4LmQlQOLjPsDKyxPFctpCsU+iHRJ63u/Sfvvk787laS2mxU3ynh+wynMkqSzxU8qw
	==
X-Gm-Gg: AYBFou27AMOt5WPbYkFq4bdQ8yp+m7dSkpzXfzmCp+k8AvrurVytXAVIphzgX1eAUc7
	wGJhoHQKTgERr3KytNFjhBDveOtL0NpKCV1ptj6o5Is0JwyJUKSnDhPmAGViyUMbmTG/k7KQhpo
	f2wPaI7JHFQNvRER5Lkv7RTUQKfTpAv7iI1VcY/RHdxLU/9Nr71nJU/BIlg6zQSL0YH0koF27JO
	YSYzFQsmBn11RphRhDBLBHZaldWwg10v7EdJz5xA9LmCfkFwTezGGVDxhZ7M8qG6jQbyaF77i5i
	WaeGlLVYVhQkWLOT2ZlO3FvI5qaHcU50pJd2F/mtlB5LZ2BdWqg43WrnTPGxOZ2g4XG/w6FxFmc
	j4kMcE8aTUlLmP+H7CCZ9ZfX/iHVT1vmaVa/0GPAMdNYwLeTuIPBAQjXqgeXnrznm3c54gEl20F
	TgmGZioePI4/1G7CRrGDhHoLKpAb2OqzT6BpVJ/34=
X-Received: by 2002:a17:90b:3b8c:b0:398:9bd4:d13 with SMTP id 98e67ed59e1d1-39b26242a75mr31038768a91.18.1788781965260;
        Mon, 07 Sep 2026 04:52:45 -0700 (PDT)
X-Received: by 2002:a17:90b:3b8c:b0:398:9bd4:d13 with SMTP id 98e67ed59e1d1-39b26242a75mr31038666a91.18.1788781964421;
        Mon, 07 Sep 2026 04:52:44 -0700 (PDT)
Received: from u-ThinkPad-X1-Extreme-Gen-4i ([103.155.100.15])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08c39227sm26922513a91.9.2026.09.07.04.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 04:52:43 -0700 (PDT)
From: Aaron Ma <aaron.ma@canonical.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Henry Tieman <henry.w.tieman@intel.com>,
	intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS)
Subject: [PATCH v2 1/2] ice: restore DDP state during PFR recovery
Date: Mon,  7 Sep 2026 19:52:20 +0800
Message-ID: <20260907115221.926007-1-aaron.ma@canonical.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The firmware package and switch recipes are shared by all PFs of an
adapter. However, each PF rebuilds independently after system resume. The
resulting package downloads and recipe updates can interleave, causing
firmware timeouts and leaving interfaces unusable.

PFR also clears package-derived firmware state on affected devices. The
existing PFR path only rebuilds the driver's block tables, so VLAN recipe
programming can fail after the reset.

The failure is reported as:

  ice 0000:04:00.0: Update pkg failed: err -5
  ice 0000:04:00.0: package load failed, -12
  ice 0000:04:00.0: Rebuild failed, unload and reload driver

This was observed on an Intel E810-XXV-2 adapter (PCI ID 8086:159b,
revision 02) with NVM package 1.0.0.18 and ICE OS Default DDP package
1.3.43.0.

Serialize rebuilds across PFs of the same adapter, while allowing each PFR
to complete independently. Reload the DDP package from its cached copy and
restore the default DVM recipes before rebuilding the remaining PF state.
Abort recovery if either operation fails.

In addition, stop the service task before tearing down resources in
ice_remove() so that an in-flight rebuild completes and cannot dereference
pf->adapter after ice_adapter_put().

Fixes: 462acf6aca85 ("ice: Enable DDP package download")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
v1 -> v2:
- Stop service task early in ice_remove() to prevent use-after-free on
  pf->adapter if rebuild is in flight.

 drivers/net/ethernet/intel/ice/ice_adapter.c  |  2 ++
 drivers/net/ethernet/intel/ice/ice_adapter.h  |  3 ++
 drivers/net/ethernet/intel/ice/ice_main.c     | 35 ++++++++++++++-----
 .../net/ethernet/intel/ice/ice_vlan_mode.c    |  2 +-
 .../net/ethernet/intel/ice/ice_vlan_mode.h    |  1 +
 5 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.c b/drivers/net/ethernet/intel/ice/ice_adapter.c
index 2dc3629d6d0f6..7de9223e971a7 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.c
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.c
@@ -64,6 +64,7 @@ static struct ice_adapter *ice_adapter_new(struct pci_dev *pdev)
 	spin_lock_init(&adapter->txq_ctx_lock);
 	for (int i = 0; i < ARRAY_SIZE(adapter->cpi_phy_lock); i++)
 		mutex_init(&adapter->cpi_phy_lock[i]);
+	mutex_init(&adapter->rebuild_lock);
 	refcount_set(&adapter->refcount, 1);
 
 	mutex_init(&adapter->ports.lock);
@@ -77,6 +78,7 @@ static void ice_adapter_free(struct ice_adapter *adapter)
 	WARN_ON(!list_empty(&adapter->ports.ports));
 	for (int i = 0; i < ARRAY_SIZE(adapter->cpi_phy_lock); i++)
 		mutex_destroy(&adapter->cpi_phy_lock[i]);
+	mutex_destroy(&adapter->rebuild_lock);
 	mutex_destroy(&adapter->ports.lock);
 
 	kfree(adapter);
diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.h b/drivers/net/ethernet/intel/ice/ice_adapter.h
index 4f695f32da3d8..f9265de973efc 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.h
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.h
@@ -37,6 +37,7 @@ struct ice_port_list {
  * @cpi_phy_lock: Per-PHY mutex serializing CPI REQ/ACK transactions.
  *               Index 0 = PHY0, index 1 = PHY1. Used on E825C devices.
  * @ctrl_pf: Control PF of the adapter
+ * @rebuild_lock: serialize PFR recovery across PFs of the same adapter
  * @ports: Ports list
  * @index: 64-bit index cached for collision detection on 32bit systems
  */
@@ -48,6 +49,8 @@ struct ice_adapter {
 	spinlock_t txq_ctx_lock;
 	/* Serialize CPI REQ/ACK transactions per PHY (E825C only) */
 	struct mutex cpi_phy_lock[ICE_E825_MAX_PHYS];
+	/* Serialize PFR recovery touching shared FW global state */
+	struct mutex rebuild_lock;
 
 	struct ice_pf *ctrl_pf;
 	struct ice_port_list ports;
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index d88835482d3aa..abb6e850ec09f 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -659,7 +659,9 @@ static void ice_do_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
 	 */
 	if (reset_type == ICE_RESET_PFR) {
 		pf->pfr_count++;
+		mutex_lock(&pf->adapter->rebuild_lock);
 		ice_rebuild(pf, reset_type);
+		mutex_unlock(&pf->adapter->rebuild_lock);
 		clear_bit(ICE_PREPARED_FOR_RESET, pf->state);
 		clear_bit(ICE_PFR_REQ, pf->state);
 		wake_up(&pf->reset_wait_queue);
@@ -704,7 +706,9 @@ static void ice_reset_subtask(struct ice_pf *pf)
 		} else {
 			/* done with reset. start rebuild */
 			pf->hw.reset_ongoing = false;
+			mutex_lock(&pf->adapter->rebuild_lock);
 			ice_rebuild(pf, reset_type);
+			mutex_unlock(&pf->adapter->rebuild_lock);
 			/* clear bit to resume normal operations, but
 			 * ICE_NEEDS_RESTART bit is set in case rebuild failed
 			 */
@@ -5374,6 +5378,8 @@ static void ice_remove(struct pci_dev *pdev)
 		return;
 	}
 
+	ice_service_task_stop(pf);
+
 	if (test_bit(ICE_FLAG_SRIOV_ENA, pf->flags)) {
 		set_bit(ICE_VF_RESETS_DISABLED, pf->state);
 		ice_free_vfs(pf);
@@ -7674,14 +7680,27 @@ static void ice_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
 		goto err_init_ctrlq;
 	}
 
-	/* if DDP was previously loaded successfully */
-	if (!ice_is_safe_mode(pf)) {
-		/* reload the SW DB of filter tables */
-		if (reset_type == ICE_RESET_PFR)
-			ice_fill_blk_tbls(hw);
-		else
-			/* Reload DDP Package after CORER/GLOBR reset */
-			ice_load_pkg(NULL, pf);
+	if (!ice_is_safe_mode(pf) && reset_type == ICE_RESET_PFR) {
+		enum ice_ddp_state state;
+
+		state = ice_init_pkg(hw, hw->pkg_copy, hw->pkg_size);
+		ice_log_pkg_init(hw, state);
+		if (!ice_is_init_pkg_successful(state))
+			goto err_init_ctrlq;
+	} else if (!ice_is_safe_mode(pf)) {
+		/* Reload DDP Package after CORER/GLOBR reset */
+		ice_load_pkg(NULL, pf);
+	}
+
+	/* PFR can lose DVM recipes after system suspend. */
+	if (!ice_is_safe_mode(pf) && reset_type == ICE_RESET_PFR &&
+	    ice_is_dvm_ena(hw)) {
+		err = ice_dvm_update_dflt_recipes(hw);
+		if (err) {
+			dev_err(dev, "failed to restore default DVM recipes: %d\n",
+				err);
+			goto err_init_ctrlq;
+		}
 	}
 
 	err = ice_clear_pf_cfg(hw);
diff --git a/drivers/net/ethernet/intel/ice/ice_vlan_mode.c b/drivers/net/ethernet/intel/ice/ice_vlan_mode.c
index fb526cb847764..58fb191903a75 100644
--- a/drivers/net/ethernet/intel/ice/ice_vlan_mode.c
+++ b/drivers/net/ethernet/intel/ice/ice_vlan_mode.c
@@ -240,7 +240,7 @@ static struct ice_update_recipe_lkup_idx_params ice_dvm_dflt_recipes[] = {
  * ice_dvm_update_dflt_recipes - update default switch recipes in DVM
  * @hw: hardware structure used to update the recipes
  */
-static int ice_dvm_update_dflt_recipes(struct ice_hw *hw)
+int ice_dvm_update_dflt_recipes(struct ice_hw *hw)
 {
 	unsigned long i;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_vlan_mode.h b/drivers/net/ethernet/intel/ice/ice_vlan_mode.h
index a0fb743d08e20..5dc705435f56a 100644
--- a/drivers/net/ethernet/intel/ice/ice_vlan_mode.h
+++ b/drivers/net/ethernet/intel/ice/ice_vlan_mode.h
@@ -8,6 +8,7 @@ struct ice_hw;
 
 bool ice_is_dvm_ena(struct ice_hw *hw);
 int ice_set_vlan_mode(struct ice_hw *hw);
+int ice_dvm_update_dflt_recipes(struct ice_hw *hw);
 void ice_post_pkg_dwnld_vlan_mode_cfg(struct ice_hw *hw);
 
 #endif /* _ICE_VLAN_MODE_H */
-- 
2.43.0

