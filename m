Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869B1435A97
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 13:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785417727; cv=none; b=TH5EFCkrmiYPFqyExPZY05IlQisAS2f67hZ4ypzkBAKQocmMVsLFf3AmDYSlVoLnzV5xgfIi1df2bNFHxpXWViYiEEDIttjKGie74tvtztSlsntqQI/rktIVSP8cHVJRbA6iuohChQrFPnkhWPanoSv1rjATvK/kbs8xSDJP1I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785417727; c=relaxed/simple;
	bh=uYZZoulugHz8EtHXPjcqrh0Vt5PlvRJS1wDdh9ye8ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Me1akHubw8npiEUXF0DEmvniXFGakykoE0K9qT0mh9Pa1nig21Y/ekCHFJpUPSKbXi7QEsaKFOAH7071JTnQ3Osj3T9CQbMG1+rUiYbOl7nVa3NhBMHzBRLlNo0cm6TXUX0sUp20dBgVBb4y+783+AKfrbHOwFJ/6ea8lqS5ncA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jD4D6m8B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jD4D6m8B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785417725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D3fNS+QycR5ulOcMEzb/XijHmQkPgXnx1CB0Jw+QIio=;
	b=jD4D6m8BYJzGgNVzcPW4UV4jpsxvZPvKOVQcWuXb4gNwrZBwkImyrI2XD0N6s9X4UQkogf
	28jCAocGCfxi4kOLQuJeDxYW7yU7eM4yX3YFPR4yh+CacFJhSeggkviiAmVeG7fN2QfYYe
	Qwdk5tHh6DGeIz1BPu+zhvq1h7qFOJU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-349-wTDzwaVMMsylHdWgIFexCA-1; Thu,
 30 Jul 2026 09:22:04 -0400
X-MC-Unique: wTDzwaVMMsylHdWgIFexCA-1
X-Mimecast-MFC-AGG-ID: wTDzwaVMMsylHdWgIFexCA_1785417722
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 38B7A1944DFD;
	Thu, 30 Jul 2026 13:22:02 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.33.108])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 056A81956089;
	Thu, 30 Jul 2026 13:21:58 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	Chris du Quesnay <Chris.duQuesnay@microchip.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Paolo Abeni <pabeni@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 2/3] dpll: zl3073x: refactor output pin frequency set for internal use
Date: Thu, 30 Jul 2026 15:21:49 +0200
Message-ID: <20260730132150.371376-3-ivecera@redhat.com>
In-Reply-To: <20260730132150.371376-1-ivecera@redhat.com>
References: <20260730132150.371376-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Extract the frequency-setting logic from the dpll_pin_ops callback into
a separate unlocked helper __zl3073x_dpll_output_pin_frequency_set()
that can be called internally while the per-DPLL lock is already held.
The original callback becomes a thin wrapper that acquires the lock and
delegates.

This prepares for the PTP clock support patch where ptp_enable() needs
to set output pin frequency from an already-locked context.

Reviewed-by: Petr Oros <poros@redhat.com>
Tested-by: Chris du Quesnay <Chris.duQuesnay@microchip.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/dpll.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index 0488ae6ac486c8..79433ba8bb4a4f 100644
--- a/drivers/dpll/zl3073x/dpll.c
+++ b/drivers/dpll/zl3073x/dpll.c
@@ -935,21 +935,17 @@ zl3073x_dpll_output_pin_frequency_get(const struct dpll_pin *dpll_pin,
 }
 
 static int
-zl3073x_dpll_output_pin_frequency_set(const struct dpll_pin *dpll_pin,
-				      void *pin_priv,
-				      const struct dpll_device *dpll,
-				      void *dpll_priv, u64 frequency,
-				      struct netlink_ext_ack *extack)
+__zl3073x_dpll_output_pin_frequency_set(struct zl3073x_dpll *zldpll,
+					struct zl3073x_dpll_pin *pin,
+					u64 frequency)
 {
-	struct zl3073x_dpll *zldpll = dpll_priv;
 	struct zl3073x_dev *zldev = zldpll->dev;
-	struct zl3073x_dpll_pin *pin = pin_priv;
 	const struct zl3073x_synth *synth;
 	u32 new_div, synth_freq;
 	struct zl3073x_out out;
 	u8 out_id;
 
-	guard(mutex)(&zldpll->lock);
+	lockdep_assert_held(&zldpll->lock);
 
 	out_id = zl3073x_output_pin_out_get(pin->id);
 	out = *zl3073x_out_state_get(zldev, out_id);
@@ -1010,6 +1006,21 @@ zl3073x_dpll_output_pin_frequency_set(const struct dpll_pin *dpll_pin,
 	return zl3073x_out_state_set(zldev, out_id, &out);
 }
 
+static int
+zl3073x_dpll_output_pin_frequency_set(const struct dpll_pin *dpll_pin,
+				      void *pin_priv,
+				      const struct dpll_device *dpll,
+				      void *dpll_priv, u64 frequency,
+				      struct netlink_ext_ack *extack)
+{
+	struct zl3073x_dpll *zldpll = dpll_priv;
+
+	guard(mutex)(&zldpll->lock);
+
+	return __zl3073x_dpll_output_pin_frequency_set(zldpll, pin_priv,
+						       frequency);
+}
+
 static int
 zl3073x_dpll_output_pin_phase_adjust_get(const struct dpll_pin *dpll_pin,
 					 void *pin_priv,
-- 
2.54.0

