Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793967037;
	b=xHjIpjuHmp2MlRfVFqiEZ8HwZ9Ls4Na77tSo4Ngfr1olOBWWL+qb6tmikwKHymprYHeU
	 FoKGV9Y2hPxTve9CrDz7aDWKNdF3kB20qhA/JJ/0VcHqX/QN9ZwZRlcUrPXoJiVoFtMa8
	 XpPjEUeqI3EJr6WYimRd9YDNFBAXtOoE1+GnxU6Qpdw9OZtqpHMt3Whsy7x2Jvm1ECFBV
	 uxvARIOIwPJbucXC4yW/65fbLzg6DA11XXbIWbNYSMrcZlpluIf0wW08jgJ38OfawvxG4
	 nvzWmEbdL6A2/n7MwEO1v3Ae7suQX83wC5IP7rT6lhLlWHFWuSo24mCc67Wyfcx1B1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793967037;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=7VqcSi1dSXj2faifoXjrJP8/CE3Zo8Lvj74KnRYzfxs=;
	b=3bZb9YvUo6unVWXjlBe/ttmUL3l2ENB8lBPCpI6CWstCqhLxwGG7cHSFuRkZTS6NlgZG
	 B0q8WLMybAiIEqXMpqRj0zD0R4FBlm+iCiexSHmuEIlY2JCIQ34yIe77poygL1lRhqdUL
	 /LgciQXOTkrVlLiChFxdxSULt2zKbXPEqqD+Hdi8QAo6A8UwNF5zQMndOgSQFnoT5a28Y
	 Zrz5Es3JJC4rOTdl3ZLmIwFIcSS3WLBA/QdGUwA2GR9g9OLekISE4z9RFMrVeoHsGvXJH
	 35FlbfDVPzXML5zr8jqMCetKyLJEdxvibSBDIjxa6EVMQjeg2SuYBKwXF+++frSIr/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LYoQeWcD;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DD0606EEA8
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 12:10:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3DD0606EEA8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LYoQeWcD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793967035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7VqcSi1dSXj2faifoXjrJP8/CE3Zo8Lvj74KnRYzfxs=;
	b=LYoQeWcD9jaEb7BwR86yi/tkiEPoxIfmXk0Mg2kXsHdH51xL9pnYPyKpJicWp72i0ufEVr
	8gbv72yIF0gg76rVSlnzBkUWgiU8xaSIBrLh49itgM6cP/Hip1mrcsC5c7Q2c1edNzq+n7
	y4ryFBoii5bhkgJIS4HfUStlbK4TRJs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-oIK7eakaNg2ep2EGY3sRbg-1; Fri,
 06 Nov 2026 07:10:30 -0500
X-MC-Unique: oIK7eakaNg2ep2EGY3sRbg-1
X-Mimecast-MFC-AGG-ID: oIK7eakaNg2ep2EGY3sRbg_1793967027
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 25F331955EAD;
	Fri,  6 Nov 2026 12:10:27 +0000 (UTC)
Received: from ivecera-thinkpadp16vgen1.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D004F18004D2;
	Fri,  6 Nov 2026 12:10:20 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Min Li <min.li@microchip.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	Grzegorz Nitka <grzegorz.nitka@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Petr Oros <poros@redhat.com>
Subject: [PATCH net-next 02/10] ice: dpll: serialize changes of the SyncE CGU registers
Date: Fri,  6 Nov 2026 13:09:57 +0100
Message-ID: <20261106121005.1327603-3-ivecera@redhat.com>
In-Reply-To: <20261106121005.1327603-1-ivecera@redhat.com>
References: <20261106121005.1327603-1-ivecera@redhat.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On dual complex E825 only complex 0 has a functional CGU and the second
complex reaches it through cgu_peer, so PFs of both complexes share the
CGU registers R10 and R11. They read, modify and write them when the
state of an RCLK pin changes, and ice_ptp_link_change() rewrites R10 when
a link changes, under the pf->dplls.lock of their own PF only.

ice_ptp_link_change() does not hold dpll_lock, so it can already overwrite
an update of another PF. RCLK callbacks are serialized by dpll_lock, but
the DPLL core is going to serialize callbacks per (module, clock_id), and
each complex has its own DSN and so its own clock_id. With that change, a
test toggling RCLK pins of both complexes lost an update.

Add a mutex to struct ice_adapter, which all E825C PFs share, and hold it
around these sequences.

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
index bdbcf7af296eb4..d6302409a2dacf 100644
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
index bce0bea9a664bc..4ba76e2e2e0b01 100644
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
+ *     R11. All PFs of a dual complex E825 reach one CGU, so @lock does not
+ *     cover them.
  */
 struct ice_dplls {
 	struct kthread_worker *kworker;
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 3df08714510da5..4d4b6aaaf30c29 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1395,7 +1395,9 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
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

