Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793967077;
	b=qQNXHaIOIxXN1Miljqj7XIQCsIlthswhDt5kZsR3KaLovxWUfJM2+Vm6HYMDTv1U/kTm
	 Iac4j88nqzRUHifuFxThS/0VmsB3taS6EbLS/58qOmuLMGqXZ5gyl0FnD10LQLA4MRPTi
	 E6bys7YcUPbmp0aDOPu9nZTB0j7VtWvW4+ZRnn2J7MjdfqLggmEwnigHnTLZ8nAMMLv3T
	 dwew8tAMwwXLXZDIDSYvZoSlIvPGOhZtMIDHLcPK8MaAL7eyvN65FOcO83NFY1EdR/g1x
	 GMLLu7/hTVrrcQX1WennCKjcQxcOjn6wKN0TLZt66MIPelT6A7bnWhNik0y8qE0Vmsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793967077;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=vSoK9k8Jjl0Fge7FipT1654PSTW1jRBxZt2UfEkmOE8=;
	b=OtCkoLxndhC7nYDY//USscFBFb99OrVO1g2ucJb6YtJkWXqUk1GK/ZYFrww7u1jE4G4b
	 LvN3wIS6zuZ8rRk+YXp/xvCEl15m7ik1tAsdWRtGcSSy26Lq0DvcnC/7YyzLAWkolok/m
	 UV/vaW9UueucbT/tU4E4++nzM8f/v82cvMJCVT0A0YmV3tDEZ1O+ePnxR/fq9BUpogLeK
	 qygSD3RXPBNrqJVOSKGMUP0F6rsiv0CaZl15xCKYMsIplQ+q+Yz8sn4XQEA0V5Y6PJoWu
	 +Tw4J+5PFNSd4OUitBsKWn5z1gW3b1cPmaN13K7UxXWvBtAk+XHGQ5Bfq17gDRh4WcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EvVlrAZl;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAE36082BFC
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 12:11:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AAE36082BFC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EvVlrAZl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793967075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vSoK9k8Jjl0Fge7FipT1654PSTW1jRBxZt2UfEkmOE8=;
	b=EvVlrAZleDwc2KRAqfArukUd6ESJKNE7/VyiYHRPahxs/JlJzufXP3fld53zS/LZusQGSt
	NYDaYLbfiDxsJhddTAx5Aapyc7KiXKB/rvhL5SSiXwmdqz2TVhCu+nTDMX7d7/xJD8FDhj
	xX49d0T/TFPSbIzIXy7afVygBjW2x8M=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-387-C4dsfAmUOR6APzuVeSqlQQ-1; Fri,
 06 Nov 2026 07:11:14 -0500
X-MC-Unique: C4dsfAmUOR6APzuVeSqlQQ-1
X-Mimecast-MFC-AGG-ID: C4dsfAmUOR6APzuVeSqlQQ_1793967071
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 783D21800576;
	Fri,  6 Nov 2026 12:11:11 +0000 (UTC)
Received: from ivecera-thinkpadp16vgen1.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A537318001CA;
	Fri,  6 Nov 2026 12:11:05 +0000 (UTC)
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
Subject: [PATCH net-next 09/10] ice: dpll: update locking comments
Date: Fri,  6 Nov 2026 13:10:04 +0100
Message-ID: <20261106121005.1327603-10-ivecera@redhat.com>
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

Callbacks run under the DPLL core domain locks instead of dpll_lock. Note
that callbacks of pins of an external DPLL run under the domain of that
DPLL, so only pf->dplls.lock serializes them with the rest of the driver.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 4 ++--
 drivers/net/ethernet/intel/ice/ice_dpll.h | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index d6302409a2dacf..07cbd4cf0160ca 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -1178,8 +1178,8 @@ ice_dpll_input_state_get(const struct dpll_pin *pin, void *pin_priv,
  * peer via dpll netlink learn about the update.
  *
  * Context: Called from dpll_pin_ops callbacks after pf->dplls.lock is
- *          released.  Uses __dpll_pin_change_ntf() because dpll_lock is
- *          still held by the dpll netlink layer.
+ *          released.  Uses __dpll_pin_change_ntf() because the domain lock
+ *          is still held by the dpll core.
  */
 static void ice_dpll_sw_pin_notify_peer(struct ice_dplls *d,
 					struct ice_dpll_pin *changed)
diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.h b/drivers/net/ethernet/intel/ice/ice_dpll.h
index 4ba76e2e2e0b01..39e041a30090d0 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.h
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.h
@@ -165,6 +165,9 @@ struct ice_dpll {
  *     tx_refclks usage map), acquire pf->dplls.lock first, then
  *     ctrl_pf->dplls.lock. Skip the second acquire when pf == ctrl_pf
  *     to avoid recursive locking.
+ *   - Callbacks of the SYNCE and TIME_REF pins of an external DPLL run under
+ *     the DPLL core domain lock of that DPLL, not of the TXC and TSPLL DPLLs,
+ *     so only @lock serializes them with the callbacks of these DPLLs.
  *   - @txclk_notify_rwsem is held for read across
  *     ice_txclk_update_and_notify(), including the out-of-lock
  *     dpll_*_change_ntf() calls. ice_dpll_deinit() takes the write side
-- 
2.56.0

