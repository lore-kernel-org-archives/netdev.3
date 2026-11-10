Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794303852;
	b=TkLTcU6sWGEB7TMvhLCnEa6W6k9+VLzg9gRWMW8JL5YU2pX8bFzXGzTV2zLyY+GumrQD
	 9WpT/ZwZo85XwP+VZUQrbMxS/OCYw+7GHB3fRZrOQ5WTooJ/3HYHF5Egb+qO1dTbtnca3
	 hqbFdobcDeic0qbp4/CzmqEMR2Ai3nNBYyryVSKYsvi1qvuwwDIPB7SGE25TcBxVtY5g4
	 /fgg/i7S4iCPb3b3PlSm8vAPmuCDEnb3B1ESQGiLB0HcnlUFWrkL07TIQc2PgX1Zq8csM
	 An6tTwD3yb1MrhyzF9NI4JPL3dFReaV3Pwl2cS1DXhyNCgEcQSTVWwANGrh3Am/iylQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794303852;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=o4T17MbHTeQzZp8NC0qUA3fYEjHxMSXAptJLm7Ag5Fs=;
	b=mNw3LC3QrRYBwTVSOFXZVnXXGBmB9orV2snp/vYHIi7539DFVUyKL9Idmi404680DK1F
	 je6AI/O18RlCGV36Q57q93I1aj0GpCdIShLxPSKOUqDosrJO7fNcqdmbJEr8TEtzr0LU+
	 ppr/XOOn2Slj4lnr8ldadlNhtGX+cj+9pdWE+O9q5LORJyzyWlm8CCS37AQWGWpyhPzcZ
	 DcEBYv/DGVAxb/gtS0/tC0mvAjIjoHfuUK9xlA71K7KHt/i8lajncWvbGtFbI/WIOLESm
	 BqqGdj344wMnGlC5gBmPjojomKOMU+q01TRjV2WihFr7BAVWIgjsqmQq1nPI3yAu2zA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=c6R5l9AT;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112A860A2621
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 09:44:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 112A860A2621
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=c6R5l9AT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794303851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o4T17MbHTeQzZp8NC0qUA3fYEjHxMSXAptJLm7Ag5Fs=;
	b=c6R5l9ATShvAHBRGGYXFWEQ196X/S9MhkMSRbfGrmb7vKbPRAdaoBOgRVS22Fr/frXlwic
	tEgSHQL3IoYGgrdH1Fwe9jURSqQdiJDXJAeYrxsDfdRpEVd0FQD0n3bG0O2m7jpl79/tO6
	PHji/hpN1wP+lsKEtIhX4r0zqIBlog4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-341-baJkrLcjPzezrI-Y_vi9wg-1; Tue,
 10 Nov 2026 04:44:07 -0500
X-MC-Unique: baJkrLcjPzezrI-Y_vi9wg-1
X-Mimecast-MFC-AGG-ID: baJkrLcjPzezrI-Y_vi9wg_1794303845
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5AD841956089;
	Tue, 10 Nov 2026 09:44:05 +0000 (UTC)
Received: from ivecera-thinkpadp16vgen1.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3E33E3920B;
	Tue, 10 Nov 2026 09:44:01 +0000 (UTC)
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
Subject: [PATCH net 2/2] ice: dpll: set the SyncE divider only for the port driving the output
Date: Tue, 10 Nov 2026 10:43:50 +0100
Message-ID: <20261110094350.184185-3-ivecera@redhat.com>
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

R10 holds one divider for each recovered clock output, shared by all
ports. ice_ptp_link_change() sets it from the link speed of its own port
even when another port drives the output, and checks the mux only to
decide whether an error is worth reporting. With ports running at
different speeds, a link change on one port leaves the output of another
port with a wrong divider.

Skip the outputs that the port does not drive, and check the mux under
cgu_synce_lock, so that another PF cannot select its port in between.

The check computes the mux value as port % ports_per_phy + 3, while
ice_tspll_cfg_bypass_mux_e825c() and ice_dpll_rclk_update_e825c() use
port + 3. With the skip, a port from ports_per_phy up would never update
the divider, so use port + 3 as they do.

Tested on GNR-D with dual complex E825. With the RCLK pin of one port
connected, five down and up cycles of another port of the same complex
called ice_tspll_cfg_synce_ethdiv_e825c() 20 times without this patch
and never with it. Five cycles of the port driving the output still
called it 10 times. Both ports ran at 25 Gb/s, so the divider value did
not change on this setup.

Fixes: ad1df4f2d591 ("ice: dpll: Support E825-C SyncE and dynamic pin discovery")
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c   | 10 +++++++---
 drivers/net/ethernet/intel/ice/ice_tspll.c |  4 ++--
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 449819cf8c8791..81565bbb692e9a 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1350,6 +1350,7 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
 		int pin, err;
 
 		mutex_lock(&pf->dplls.lock);
+		mutex_lock(&pf->adapter->cgu_synce_lock);
 		for (pin = 0; pin < ICE_SYNCE_CLK_NUM; pin++) {
 			enum ice_synce_clk clk_pin;
 			bool active;
@@ -1368,16 +1369,19 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
 				break;
 			}
 
-			mutex_lock(&pf->adapter->cgu_synce_lock);
+			/* The divider is shared, set it only for our port */
+			if (!active)
+				continue;
+
 			err = ice_tspll_cfg_synce_ethdiv_e825c(hw, clk_pin);
-			mutex_unlock(&pf->adapter->cgu_synce_lock);
-			if (active && err) {
+			if (err) {
 				dev_err_once(ice_pf_to_dev(pf),
 					     "Failed to configure SyncE ETH divider for pin %d, err %d\n",
 					     pin, err);
 				break;
 			}
 		}
+		mutex_unlock(&pf->adapter->cgu_synce_lock);
 		mutex_unlock(&pf->dplls.lock);
 
 		if (linkup)
diff --git a/drivers/net/ethernet/intel/ice/ice_tspll.c b/drivers/net/ethernet/intel/ice/ice_tspll.c
index b99e02cfe559bd..0bfbea43529523 100644
--- a/drivers/net/ethernet/intel/ice/ice_tspll.c
+++ b/drivers/net/ethernet/intel/ice/ice_tspll.c
@@ -746,6 +746,7 @@ int ice_tspll_init(struct ice_hw *hw)
  *
  * Check if given port is selected as recovered clock source for given output.
  *
+ * Context: Called under pf->dplls.lock and adapter->cgu_synce_lock
  * Return:
  * * 0 - success
  * * negative - error
@@ -774,8 +775,7 @@ int ice_tspll_bypass_mux_active_e825c(struct ice_hw *hw, u8 port, bool *active,
 		return -EINVAL;
 	}
 
-	if (active_clk == port % hw->ptp.ports_per_phy +
-			  ICE_CGU_BYPASS_MUX_OFFSET_E825C)
+	if (active_clk == port + ICE_CGU_BYPASS_MUX_OFFSET_E825C)
 		*active = true;
 	else
 		*active = false;
-- 
2.56.0

