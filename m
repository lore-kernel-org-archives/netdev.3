Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6CA4DAFA6
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 10:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792407185; cv=none; b=LXNsb5VWqG37wGFfdXNnr0V6WXdKDa1+KYXtC/lhbq7ig5qrSj0AuSWXdf7JBpOa9/pSAJGU5FPI5E8bKDeQZPUPVZsxOANv/xYzQSt6+lnQR7ABqxTWMIAn/wdGobMiebLjdUOh10xr3QGQ4io//yimel1nAFGjLYYigxxnZHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792407185; c=relaxed/simple;
	bh=Z2QLHrS/ZE3adBnCPJ6iak/RhoXq89jMgA5LzYyQU2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X5tigyHkNmxLuKYluv32O7n/M/rG4Fax+a8q1gGRRSh7081b2nJY6/Es0OMR/K8JvKv8P7oo4GVmqpHau9He1IvuHaLnv40W+Z5aQ6lukg4QGcdrYQOSEEnkfuBwzZZgKpqpjZwX5F/fb07Nnjk1eQT2er1U+X7434iLd2vuGG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=ahqGaU97; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="ahqGaU97"
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id ADE853F2D7
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 10:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1792407178;
	bh=h86IyMUid2GM5Noch64kNmeW+U4IgmtnTp2NBhVlriI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=ahqGaU97sO85OGJE6bWiU2p5YroU7+NO7J6f2XDod3G5b7e352w5h1i8WTUyKwkNb
	 iGV++52CnYUV6jC8InYoUT8sqoI8xNMLtHsty8L3IYORqWcgpTg+0tZUrXGjAftq9l
	 FJIW+p0yhKEgMiX5qebmYoXmT3ToUHlh7BhxLQKeL1rqZ8tOrULao20zDK4pVXosfI
	 sDwq5DQyl+roQ5Wxtsz9i+SFUBNt8q58RIQ9gDGKjhiaU//kPFPV8AzCxlazIC13qR
	 IUte1vq0Ws5JLmVIQpS9HAe9tAxZrRzxgVYVzpRabrbAmNMwCv4l8fIgIQ3+MfJ8E0
	 sDKSo8u5UOUQxdMrBmbWKy6jdxfKe6zKYs7WegM8SWFtrX9UzdOjbFzeY7GHPhCv0S
	 sTlHd21uGX3kRbgbh1vImz5UzbSaSkJSX/Ow6WoMPUnQlJh5Sr1fjyh95b0dvQg7/a
	 eNkwgWzTS8y88QgbJmWL1n71h0Nxsp3UfvP0h9rPlPc5+m+ezWqTKuw9SG6TGtQlih
	 QoxcpwAJJTGX1RajDA/SVpPw4SaZfJJETKOi0/vBuWzt6mKvFgs/i5Hg6Jj7yGPXy9
	 TJikGsc7wC4z+JXO6WXgQBzO/02Psf9KS1KatgHO4MSX+ELALVB3bIcbsjHdrVfcC/
	 sekkwQVoQfVEh7TwZMwxpTZ8=
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4887e5afd67so1851831f8f.3
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 03:52:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792407178; x=1793011978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=h86IyMUid2GM5Noch64kNmeW+U4IgmtnTp2NBhVlriI=;
        b=vxCb9wCL20ETUhnzPzrJAZIe8sA4Zb9zNjcbK2PVsI9YUBfE5hJrPuNBJQIst0K0wg
         vMql6+YEXVdQYqiZv1Igidj5Xlz7E6pogIaennBPlpMDPmRdy6xydbJX/HN5DiNK9lxZ
         87HwPdbALJ4wCOxeHjRjvRjYGmaumVey30DgAoY9VgD+zxHcOHNibVttEpDk5lbQeoGE
         jE3fQhZxAKy367mFP8TcRzSYF36VHlfLCNKGCZEgo0evCUT+hFVlVPTJQKOphFamSpCw
         ak/6QlS7OCPUjtpHE1J7qps3MrLx2cewFuA9xPsmcs/irepcax/7a29AEnUGbnvPVTkV
         98bw==
X-Forwarded-Encrypted: i=1; AKwUvBy+WyQlm1ENuwOKRmeKtQ+eDh3HjYz2I+sXVER4kcEoHNJe6hyZhH30vDwzQt3zDgyDUZLMXVc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJokerbItjkxjrks7PLtbIHLXIpZvRuGW7EhsSmWwEsbKupSPsS
	V7Pmop7lZjSsHiGeNMML5RCDBTAModi5mqEo9wzjFSH3bY644zLq1+EdFFexmQZMauE7haqVuZh
	vlZgIZS2/r0YZIfR77tlcx4e2TpEYW68v4Tt+065NK0ZzZa1TaGh/6GBsR1cFTrtvtv/xbcmQtQ
	==
X-Gm-Gg: AYBFou1wqFvhLSZ+Ez4rbF7etxPPc00I/8IgwC0VJCzbP1yFAwFKeLxpquak5oLIhrP
	fHhKyIF8MiC9zxE4vz+yI072hXHfYLabOdEFIiuTH73D36DqmVhJrsPsXrykY7ADv+oJiJ8xz8W
	htv/zDRBKDJOyC+rsVb1JhJyMsPQOzv5Qf+DyMDvvdIXHWbjbVrmd4uL2X18Eh7oLIspWiLp0+A
	tF/BY/v+0ppRro524xzuxdZiI7A0aVbHwEJ9mVZIEfjhvZm0Hfc0k9gTvxr99N7Uqa8R2FtDdan
	3fpKO/mT3RV34cfWvCs5Mo8bEg6YtQm8eJLv/Zlkl3AFsMYJyGsCweWnxtRtpg64X/bOIe+OEDX
	8CkJb82Y0+a3EbY98niYdfdRaaByOVfjf3gLg3kjY1VclzHthOm5D692K8hJFjUg9Ajwi4dnNGU
	NuLhYisQ2gJJreV9jp2mr64W00uCa/y8KNKtHNRjIcHBMtkOhrOTh22rbb/uujwnWt678jbHtlf
	zAXvTa2JABrB4aMUs9quXPg557iDm1ckJO3PPkP
X-Received: by 2002:a05:6000:46cd:b0:48d:f014:63ee with SMTP id ffacd0b85a97d-48e07bbc7d5mr9009289f8f.20.1792407178057;
        Mon, 19 Oct 2026 03:52:58 -0700 (PDT)
X-Received: by 2002:a05:6000:46cd:b0:48d:f014:63ee with SMTP id ffacd0b85a97d-48e07bbc7d5mr9009260f8f.20.1792407177636;
        Mon, 19 Oct 2026 03:52:57 -0700 (PDT)
Received: from u-ThinkPad-X1-Extreme-Gen-4i ([103.155.100.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd510201sm23238930f8f.55.2026.10.19.03.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 03:52:56 -0700 (PDT)
From: Aaron Ma <aaron.ma@canonical.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Dan Nowlin <dan.nowlin@intel.com>,
	Brett Creeley <brett.creeley@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS)
Subject: [PATCH 3/5] ice: scope global configuration lock to the adapter
Date: Mon, 19 Oct 2026 18:51:53 +0800
Message-ID: <20261019105155.3793063-4-aaron.ma@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019105155.3793063-1-aaron.ma@canonical.com>
References: <20261019105155.3793063-1-aaron.ma@canonical.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ice_global_cfg_lock_sw is a module-global mutex, so a package download
on one E810 adapter blocks Admin Queue commands on unrelated adapters in
the same system. In addition, the mutex is acquired only after firmware
grants the Global Configuration Lock and dropped before firmware
releases it, while the opcode exemption list in ice_aq_send_cmd() does
not check whether the caller is the lock owner. Non-owning PFs on the
same adapter can therefore submit exempted Admin Queue commands or
sideband requests while another PF holds firmware ownership.

Move the software mutex to struct ice_adapter and record the owning task
across the entire Global Configuration Lock acquisition and release
sequence, including the core reset path in ice_cfg_tx_topo(). In
ice_aq_send_cmd(), require non-owning tasks to wait on the adapter mutex
while allowing the owning task to issue the permitted configuration
commands. Route the Admin Queue fallback in ice_sbq_send_cmd() through
ice_aq_send_cmd() as well.

This patch depends on the previous patch in this series.

Fixes: c76488109616 ("ice: Implement Dynamic Device Personalization (DDP) download")
Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
 drivers/net/ethernet/intel/ice/ice_adapter.c |  2 +
 drivers/net/ethernet/intel/ice/ice_adapter.h |  6 ++
 drivers/net/ethernet/intel/ice/ice_common.c  | 63 +++++++++++++-------
 drivers/net/ethernet/intel/ice/ice_common.h  |  3 +-
 drivers/net/ethernet/intel/ice/ice_ddp.c     |  7 +--
 5 files changed, 55 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.c b/drivers/net/ethernet/intel/ice/ice_adapter.c
index 7de9223e971a7..17819c3a172fa 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.c
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.c
@@ -65,6 +65,7 @@ static struct ice_adapter *ice_adapter_new(struct pci_dev *pdev)
 	for (int i = 0; i < ARRAY_SIZE(adapter->cpi_phy_lock); i++)
 		mutex_init(&adapter->cpi_phy_lock[i]);
 	mutex_init(&adapter->rebuild_lock);
+	mutex_init(&adapter->global_cfg_lock);
 	refcount_set(&adapter->refcount, 1);
 
 	mutex_init(&adapter->ports.lock);
@@ -79,6 +80,7 @@ static void ice_adapter_free(struct ice_adapter *adapter)
 	for (int i = 0; i < ARRAY_SIZE(adapter->cpi_phy_lock); i++)
 		mutex_destroy(&adapter->cpi_phy_lock[i]);
 	mutex_destroy(&adapter->rebuild_lock);
+	mutex_destroy(&adapter->global_cfg_lock);
 	mutex_destroy(&adapter->ports.lock);
 
 	kfree(adapter);
diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.h b/drivers/net/ethernet/intel/ice/ice_adapter.h
index f9265de973efc..6557fa0ee0ec3 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.h
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.h
@@ -13,6 +13,7 @@
 
 struct pci_dev;
 struct ice_pf;
+struct task_struct;
 
 /**
  * struct ice_port_list - data used to store the list of adapter ports
@@ -38,6 +39,8 @@ struct ice_port_list {
  *               Index 0 = PHY0, index 1 = PHY1. Used on E825C devices.
  * @ctrl_pf: Control PF of the adapter
  * @rebuild_lock: serialize PFR recovery across PFs of the same adapter
+ * @global_cfg_lock: serialize AQ access during global configuration
+ * @global_cfg_owner: task holding the global configuration lock
  * @ports: Ports list
  * @index: 64-bit index cached for collision detection on 32bit systems
  */
@@ -51,6 +54,9 @@ struct ice_adapter {
 	struct mutex cpi_phy_lock[ICE_E825_MAX_PHYS];
 	/* Serialize PFR recovery touching shared FW global state */
 	struct mutex rebuild_lock;
+	/* Keep other PFs off the AQ until firmware releases ownership */
+	struct mutex global_cfg_lock;
+	struct task_struct *global_cfg_owner;
 
 	struct ice_pf *ctrl_pf;
 	struct ice_port_list ports;
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 82b803e74aac0..1793abba8d2b2 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -7,6 +7,7 @@
 #include "ice_flow.h"
 #include "ice_ptp_hw.h"
 #include <linux/packing.h>
+#include <linux/sched.h>
 
 #define ICE_PF_RESET_WAIT_COUNT	300
 #define ICE_MAX_NETLIST_SIZE	10
@@ -1751,6 +1752,10 @@ static int
 ice_sbq_send_cmd(struct ice_hw *hw, struct ice_sbq_cmd_desc *desc,
 		 void *buf, u16 buf_size, struct ice_sq_cd *cd)
 {
+	if (!ice_is_sbq_supported(hw))
+		return ice_aq_send_cmd(hw, (struct libie_aq_desc *)desc,
+				       buf, buf_size, cd);
+
 	return ice_sq_send_cmd(hw, ice_get_sbq(hw),
 			       (struct libie_aq_desc *)desc, buf, buf_size, cd);
 }
@@ -1797,12 +1802,6 @@ int ice_sbq_rw_reg(struct ice_hw *hw, struct ice_sbq_msg_input *in, u16 flags)
 
 /* FW Admin Queue command wrappers */
 
-/* Software lock/mutex that is meant to be held while the Global Config Lock
- * in firmware is acquired by the software to prevent most (but not all) types
- * of AQ commands from being sent to FW
- */
-DEFINE_MUTEX(ice_global_cfg_lock_sw);
-
 /**
  * ice_should_retry_sq_send_cmd
  * @opcode: AQ opcode
@@ -1895,17 +1894,24 @@ ice_aq_send_cmd(struct ice_hw *hw, struct libie_aq_desc *desc, void *buf,
 		u16 buf_size, struct ice_sq_cd *cd)
 {
 	struct libie_aqc_req_res *cmd = libie_aq_raw(desc);
-	bool lock_acquired = false;
-	int status;
+	struct ice_pf *pf = hw->back;
+	struct ice_adapter *adapter = pf->adapter;
+
+	if (READ_ONCE(adapter->global_cfg_owner) != current) {
+		guard(mutex)(&adapter->global_cfg_lock);
+		return ice_sq_send_cmd_retry(hw, &hw->adminq, desc, buf,
+					     buf_size, cd);
+	}
 
 	/* When a package download is in process (i.e. when the firmware's
 	 * Global Configuration Lock resource is held), only the Download
 	 * Package, Get Version, Get Package Info List, Upload Section,
 	 * Update Package, Set Port Parameters, Get/Set VLAN Mode Parameters,
-	 * Add Recipe, Set Recipes to Profile Association, Get Recipe, and Get
-	 * Recipes to Profile Association, and Release Resource (with resource
-	 * ID set to Global Config Lock) AdminQ commands are allowed; all others
-	 * must block until the package download completes and the Global Config
+	 * Get/Set Tx Scheduler Topology, Add Recipe, Set Recipes to Profile
+	 * Association, Get Recipe, Get Recipes to Profile Association, and
+	 * Request/Release Resource (with resource ID set to Global Config
+	 * Lock) AdminQ commands are allowed for the owner; all others must
+	 * block until the package download completes and the Global Config
 	 * Lock is released.  See also ice_acquire_global_cfg_lock().
 	 */
 	switch (le16_to_cpu(desc->opcode)) {
@@ -1924,21 +1930,16 @@ ice_aq_send_cmd(struct ice_hw *hw, struct libie_aq_desc *desc, void *buf,
 	case ice_aqc_opc_get_recipe:
 	case ice_aqc_opc_get_recipe_to_profile:
 		break;
+	case ice_aqc_opc_req_res:
 	case ice_aqc_opc_release_res:
 		if (le16_to_cpu(cmd->res_id) == LIBIE_AQC_RES_ID_GLBL_LOCK)
 			break;
 		fallthrough;
 	default:
-		mutex_lock(&ice_global_cfg_lock_sw);
-		lock_acquired = true;
-		break;
+		return -EBUSY;
 	}
 
-	status = ice_sq_send_cmd_retry(hw, &hw->adminq, desc, buf, buf_size, cd);
-	if (lock_acquired)
-		mutex_unlock(&ice_global_cfg_lock_sw);
-
-	return status;
+	return ice_sq_send_cmd_retry(hw, &hw->adminq, desc, buf, buf_size, cd);
 }
 
 /**
@@ -2161,10 +2162,17 @@ ice_acquire_res(struct ice_hw *hw, enum ice_aq_res_ids res,
 		enum ice_aq_res_access_type access, u32 timeout)
 {
 #define ICE_RES_POLLING_DELAY_MS	10
+	struct ice_pf *pf = hw->back;
+	struct ice_adapter *adapter = pf->adapter;
 	u32 delay = ICE_RES_POLLING_DELAY_MS;
 	u32 time_left = timeout;
 	int status;
 
+	if (res == ICE_GLOBAL_CFG_LOCK_RES_ID) {
+		mutex_lock(&adapter->global_cfg_lock);
+		WRITE_ONCE(adapter->global_cfg_owner, current);
+	}
+
 	status = ice_aq_req_res(hw, res, access, 0, &time_left, NULL);
 
 	/* A return code of -EALREADY means that another driver has
@@ -2197,6 +2205,9 @@ ice_acquire_res(struct ice_hw *hw, enum ice_aq_res_ids res,
 		ice_debug(hw, ICE_DBG_RES, "resource acquire timed out.\n");
 
 ice_acquire_res_exit:
+	if (res == ICE_GLOBAL_CFG_LOCK_RES_ID && status)
+		ice_global_cfg_unlock(hw);
+
 	if (status == -EALREADY) {
 		if (access == ICE_RES_WRITE)
 			ice_debug(hw, ICE_DBG_RES, "resource indicates no work to do.\n");
@@ -2228,6 +2239,18 @@ void ice_release_res(struct ice_hw *hw, enum ice_aq_res_ids res)
 			break;
 		usleep_range(1000, 2000);
 	} while (time_before(jiffies, timeout));
+
+	if (res == ICE_GLOBAL_CFG_LOCK_RES_ID)
+		ice_global_cfg_unlock(hw);
+}
+
+void ice_global_cfg_unlock(struct ice_hw *hw)
+{
+	struct ice_pf *pf = hw->back;
+	struct ice_adapter *adapter = pf->adapter;
+
+	WRITE_ONCE(adapter->global_cfg_owner, NULL);
+	mutex_unlock(&adapter->global_cfg_lock);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_common.h b/drivers/net/ethernet/intel/ice/ice_common.h
index d1d674ca644f6..48b53f83aed3c 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.h
+++ b/drivers/net/ethernet/intel/ice/ice_common.h
@@ -98,6 +98,7 @@ int
 ice_acquire_res(struct ice_hw *hw, enum ice_aq_res_ids res,
 		enum ice_aq_res_access_type access, u32 timeout);
 void ice_release_res(struct ice_hw *hw, enum ice_aq_res_ids res);
+void ice_global_cfg_unlock(struct ice_hw *hw);
 int
 ice_alloc_hw_res(struct ice_hw *hw, u16 type, u16 num, bool btm, u16 *res);
 int
@@ -142,8 +143,6 @@ void ice_fill_dflt_direct_cmd_desc(struct libie_aq_desc *desc, u16 opcode);
 
 void ice_pack_txq_ctx(const struct ice_tlan_ctx *ctx, ice_txq_ctx_buf_t *buf);
 
-extern struct mutex ice_global_cfg_lock_sw;
-
 int
 ice_aq_send_cmd(struct ice_hw *hw, struct libie_aq_desc *desc,
 		void *buf, u16 buf_size, struct ice_sq_cd *cd);
diff --git a/drivers/net/ethernet/intel/ice/ice_ddp.c b/drivers/net/ethernet/intel/ice/ice_ddp.c
index 3b2d9c4369792..b71f3fb791db7 100644
--- a/drivers/net/ethernet/intel/ice/ice_ddp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ddp.c
@@ -1141,9 +1141,7 @@ static int ice_acquire_global_cfg_lock(struct ice_hw *hw,
 	status = ice_acquire_res(hw, ICE_GLOBAL_CFG_LOCK_RES_ID, access,
 				 ICE_GLOBAL_CFG_LOCK_TIMEOUT);
 
-	if (!status)
-		mutex_lock(&ice_global_cfg_lock_sw);
-	else if (status == -EALREADY)
+	if (status == -EALREADY)
 		ice_debug(hw, ICE_DBG_PKG,
 			  "Global config lock: No work to do\n");
 
@@ -1158,7 +1156,6 @@ static int ice_acquire_global_cfg_lock(struct ice_hw *hw,
  */
 static void ice_release_global_cfg_lock(struct ice_hw *hw)
 {
-	mutex_unlock(&ice_global_cfg_lock_sw);
 	ice_release_res(hw, ICE_GLOBAL_CFG_LOCK_RES_ID);
 }
 
@@ -2536,6 +2533,8 @@ int ice_cfg_tx_topo(struct ice_hw *hw, const void *buf, u32 len)
 	ice_check_reset(hw);
 
 reinit_hw:
+	ice_global_cfg_unlock(hw);
+
 	/* Since we triggered a CORER, re-initialize hardware */
 	ice_deinit_hw(hw);
 	if (ice_init_hw(hw)) {
-- 
2.53.0

