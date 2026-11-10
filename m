Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794303848;
	b=gg10Gzd4+LE2iaPCKpXJ/7ONf01JYnUQrmB+lWW6iBB31lg00M1pkun9rJ1bo0bWUveS
	 IskMBYyIci8JquxJJRdNadGzRsnhaYLVf4kTxUtmHWiegT8WLnEP4FGONr1AD5rUPNQ4h
	 WGMKGq1PqRQ8a801Ikp6F6AVstzNEpYUo2gIRaGU9PxobuyVU31zp7vI+UFxo3q6/Kgyu
	 5F0R67NMD+xCYT8Q42FEBM2oLFQS3OIzfr/HA3AV4+4pfPOt7nK+hyKRehT3jQi2kjNOV
	 sKrxEg97NDPmg5D1Emi/zakH8JhFMlTmBQ0Nz95KQ8sYuu5e24ctEbURTa6ZTAlgCrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794303848;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=QoCfxPMOWfQDwXRUjbvy3Iz8utcB6F5OyaB/2RzTL8s=;
	b=sOHd/Rzmw6vRTsgpMlelnxrCqf6OlvQdUM4qn80hLhGLc4lmc4JY/PpGyaIoJCWSlGc8
	 gUYIDcf8GFHt+U4YMex+hSjHmePt2xaLD3KUlB4LsFGED2UYH5tyFWnS/cETSr1iyhnEk
	 K76W8Lh6+EPF/SAclGyf9rWlGGiplJ9oQg5I70SxDbH1J2BgUnkgtbIq+9QlIdlxKQT/D
	 JF0ovsbiRRxy+Zc9Ff3mkn4OqwJ6K6ZcfRpAT9TcU4bzHCdUBWCg5Z/0J1LE5ziECa+Ii
	 NFuHsn2LGzeNG+flC0D57zFUhwdDWgtJfqdjfrU2TtekWhj41wpL+Olcl/m9nHi2kMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Gi5sS4qd;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D996079C28
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 09:44:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41D996079C28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Gi5sS4qd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794303847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QoCfxPMOWfQDwXRUjbvy3Iz8utcB6F5OyaB/2RzTL8s=;
	b=Gi5sS4qdqtMF8vbFQioWLqqdfOrcrJ2E/MD+M0TBVOy3xRwwQsAtWWBswIJ9WZd17lJhxH
	Ml9ekVDavXFyJHcbPPztZFF71GiJvu6FxrI8uZFm+5Oqg4bkJp+5T4X/AtZd2fi33ExCh5
	QeV4CtC6cTqu189moROnoIOeNdpfMi0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-OmKicfkHMbGuTq-bmqS7uA-1; Tue,
 10 Nov 2026 04:44:03 -0500
X-MC-Unique: OmKicfkHMbGuTq-bmqS7uA-1
X-Mimecast-MFC-AGG-ID: OmKicfkHMbGuTq-bmqS7uA_1794303841
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D84AD195605A;
	Tue, 10 Nov 2026 09:44:00 +0000 (UTC)
Received: from ivecera-thinkpadp16vgen1.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C53D47E2;
	Tue, 10 Nov 2026 09:43:56 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Grzegorz Nitka <grzegorz.nitka@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Petr Oros <poros@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Michal Schmidt <mschmidt@redhat.com>,
	Jakub Ramaseuski <jramaseu@redhat.com>,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 1/2] ice: dpll: serialize changes of the SyncE CGU registers
Date: Tue, 10 Nov 2026 10:43:49 +0100
Message-ID: <20261110094350.184185-2-ivecera@redhat.com>
In-Reply-To: <20261110094350.184185-1-ivecera@redhat.com>
References: <20261110094350.184185-1-ivecera@redhat.com>
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
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

All E825C PFs share the CGU registers R10 and R11. On dual complex E825
the second complex reaches the CGU of complex 0 through cgu_peer. RCLK pin
callbacks read, modify and write these registers under dpll_lock and the
pf->dplls.lock of their PF. ice_ptp_link_change() rewrites R10 under the
pf->dplls.lock of its PF only, so a link change on one PF can write back
a stale R10 and undo an RCLK pin change made by another PF.

Add a mutex to struct ice_adapter, which all E825C PFs share, and hold it
around these sequences.

Tested on GNR-D with dual complex E825, with a 2 to 4 ms delay after the
read of R10 in the link change path to widen the window. Toggling the
RCLK pin of one port while another port of the same complex went down
and up 143 times lost 120 of 86814 updates of the mux in R10 without
this patch, and none of 76992 with it.

Fixes: ad1df4f2d591 ("ice: dpll: Support E825-C SyncE and dynamic pin discovery")
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_adapter.c |  2 ++
 drivers/net/ethernet/intel/ice/ice_adapter.h |  4 ++++
 drivers/net/ethernet/intel/ice/ice_dpll.c    | 11 ++++++-----
 drivers/net/ethernet/intel/ice/ice_dpll.h    |  4 ++++
 drivers/net/ethernet/intel/ice/ice_ptp.c     |  2 ++
 drivers/net/ethernet/intel/ice/ice_tspll.c   |  4 ++--
 6 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.c b/drivers/net/ethernet/intel/ice/ice_adapter.c
index 536923b6ae979d..aa2d8addae5bef 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.c
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.c
@@ -72,6 +72,7 @@ static struct ice_adapter *ice_adapter_new(struct pci_dev *pdev)
 	spin_lock_init(&adapter->txq_ctx_lock);
 	for (int i = 0; i < ARRAY_SIZE(adapter->cpi_phy_lock); i++)
 		mutex_init(&adapter->cpi_phy_lock[i]);
+	mutex_init(&adapter->cgu_synce_lock);
 	refcount_set(&adapter->refcount, 1);
 
 	spin_lock_init(&adapter->ports.lock);
@@ -85,6 +86,7 @@ static void ice_adapter_free(struct ice_adapter *adapter)
 	WARN_ON(!list_empty(&adapter->ports.list));
 	for (int i = 0; i < ARRAY_SIZE(adapter->cpi_phy_lock); i++)
 		mutex_destroy(&adapter->cpi_phy_lock[i]);
+	mutex_destroy(&adapter->cgu_synce_lock);
 
 	cleanup_srcu_struct(&adapter->ports.srcu);
 
diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.h b/drivers/net/ethernet/intel/ice/ice_adapter.h
index c61bd645e460de..fd5585005d91ba 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.h
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.h
@@ -41,6 +41,8 @@ struct ice_port_list {
  * @txq_ctx_lock: Spinlock protecting access to the GLCOMM_QTX_CNTX_CTL register
  * @cpi_phy_lock: Per-PHY mutex serializing CPI REQ/ACK transactions.
  *               Index 0 = PHY0, index 1 = PHY1. Used on E825C devices.
+ * @cgu_synce_lock: Mutex serializing changes of the CGU registers R10 and R11,
+ *                  which all PFs reach. Used on E825C devices.
  * @ctrl_pf: Control PF of the adapter
  * @ports: Ports list
  * @index: 64-bit index cached for collision detection on 32bit systems
@@ -53,6 +55,8 @@ struct ice_adapter {
 	spinlock_t txq_ctx_lock;
 	/* Serialize CPI REQ/ACK transactions per PHY (E825C only) */
 	struct mutex cpi_phy_lock[ICE_E825_MAX_PHYS];
+	/* Serialize changes of the SyncE CGU registers (E825C only) */
+	struct mutex cgu_synce_lock;
 
 	struct ice_pf *ctrl_pf;
 	struct ice_port_list ports;
diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index ade1fb3dd06743..5148e419f49a07 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -2027,7 +2027,7 @@ ice_dpll_phase_offset_get(const struct dpll_pin *pin, void *pin_priv,
  *
  * DPLL subsystem callback. Set proper signals to recover clock from port.
  *
- * Context: Called under pf->dplls.lock
+ * Context: Called under pf->dplls.lock, acquires adapter->cgu_synce_lock
  * Return:
  * * 0 - success
  * * negative - error
@@ -2035,14 +2035,15 @@ ice_dpll_phase_offset_get(const struct dpll_pin *pin, void *pin_priv,
 static int ice_dpll_synce_update_e825c(struct ice_hw *hw, bool ena,
 				       u32 port_num, enum ice_synce_clk output)
 {
+	struct ice_pf *pf = hw->back;
 	int err;
 
+	mutex_lock(&pf->adapter->cgu_synce_lock);
 	/* configure the mux to deliver proper signal to DPLL from the MUX */
 	err = ice_tspll_cfg_bypass_mux_e825c(hw, ena, port_num, output);
-	if (err)
-		return err;
-
-	err = ice_tspll_cfg_synce_ethdiv_e825c(hw, output);
+	if (!err)
+		err = ice_tspll_cfg_synce_ethdiv_e825c(hw, output);
+	mutex_unlock(&pf->adapter->cgu_synce_lock);
 	if (err)
 		return err;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.h b/drivers/net/ethernet/intel/ice/ice_dpll.h
index bce0bea9a664bc..3f9a993129acef 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.h
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.h
@@ -158,6 +158,7 @@ struct ice_dpll {
  *     txclk_notify_rwsem (read)
  *       -> pf->dplls.lock
  *         -> ctrl_pf->dplls.lock
+ *         -> adapter->cgu_synce_lock
  *
  *   - @lock serializes all DPLL state mutations on this PF. When the
  *     controlling PF's lock must also be taken (e.g. updating the shared
@@ -169,6 +170,9 @@ struct ice_dpll {
  *     dpll_*_change_ntf() calls. ice_dpll_deinit() takes the write side
  *     standalone (not nested under any other lock) to drain in-flight
  *     readers before pins and the TXC DPLL device are freed.
+ *   - adapter->cgu_synce_lock serializes changes of the CGU registers R10 and
+ *     R11. All E825C PFs reach one CGU, so @lock, which is per PF, does not
+ *     cover them.
  */
 struct ice_dplls {
 	struct kthread_worker *kworker;
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 7980eaf9ce2535..449819cf8c8791 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1368,7 +1368,9 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
 				break;
 			}
 
+			mutex_lock(&pf->adapter->cgu_synce_lock);
 			err = ice_tspll_cfg_synce_ethdiv_e825c(hw, clk_pin);
+			mutex_unlock(&pf->adapter->cgu_synce_lock);
 			if (active && err) {
 				dev_err_once(ice_pf_to_dev(pf),
 					     "Failed to configure SyncE ETH divider for pin %d, err %d\n",
diff --git a/drivers/net/ethernet/intel/ice/ice_tspll.c b/drivers/net/ethernet/intel/ice/ice_tspll.c
index 85bacb7c3a7903..b99e02cfe559bd 100644
--- a/drivers/net/ethernet/intel/ice/ice_tspll.c
+++ b/drivers/net/ethernet/intel/ice/ice_tspll.c
@@ -792,7 +792,7 @@ int ice_tspll_bypass_mux_active_e825c(struct ice_hw *hw, u8 port, bool *active,
  *
  * Set reference clock source and output clock selection.
  *
- * Context: Called under pf->dplls.lock
+ * Context: Called under pf->dplls.lock and adapter->cgu_synce_lock
  * Return:
  * * 0 - success
  * * negative - error
@@ -898,7 +898,7 @@ static int ice_tspll_get_div_e825c(u16 link_speed, unsigned int *divider)
  *
  * Set the correct CGU divider for RCLKA or RCLKB.
  *
- * Context: Called under pf->dplls.lock
+ * Context: Called under pf->dplls.lock and adapter->cgu_synce_lock
  * Return:
  * * 0 - success
  * * negative - error
-- 
2.56.0

