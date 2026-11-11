Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415275;
	b=Qwftxb4iq3LS6KfYd3ufCw8ddbavPpWa21FALgKayrLqmY0HU0BZ0IeH3RbKhUpGyAob
	 CytWKhjCuiMZ/a9kMdsy3LanFLPRMSlCNaenP9VV0v+HN8hRiinRyycO7S4mMoNfmjCiQ
	 Z7DN05cl2X4K5yIUd4xx63Qx/jciIzqmQwr38MFGKI6gF1XNy3N20vIpN//QKQLjsTx+P
	 13uQNudrzOq8tBx6ol9hDbwFPxp/TlXXS4JssAwo0Qr71lKmE7T4NaeEFvLrggxUWqnLd
	 S7nJwrS6zNQqyey4hn6ISiSw5xMwuOgWAl4yFJWLBIddTjyDfzogCTiqVYUWPfqsa8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415275;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=YVBnk+tKGuQmlOeutGxL0dvsVwIL5GEniKA9KvwsYEE=;
	b=SxMGdyIGpaVbTUF43usi3uDzRTkLLyjTn3s/GpuY9LO50bz2J7cGOcek62x59xSWCAk/
	 QsQ90XcZ1fl7FdpAjhv52K3Nbvzjbb5ps+KJJbOB3X4ufkG7LJvIl8DMUFwTReKP8llPy
	 /P4X9s+IQzZrbQKnNOzc4sQvBGF5LlJ/p8hQwOSPgfVZc5NMcequjblKMk5FTXemCJdMo
	 J1CE6Sy4WO1TxeD67DfQR2Wy32lamO2ohOkZ4q89VmHV77KCBVvv8f02JFxIx+X9mMsem
	 2UYvf4B+Q3waFQksCPt7VuK9XZCJmVNzSLkXurPukPvE+IqN99DfCoQS6S4ahqZwuWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bkdlyR4t;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394B8606A8AC
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 16:41:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 394B8606A8AC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bkdlyR4t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794415274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YVBnk+tKGuQmlOeutGxL0dvsVwIL5GEniKA9KvwsYEE=;
	b=bkdlyR4tbz3AHKh5ujoIhxHivxwYFdS/psLlrwnHpQEIsQjFcdHoQOkdn9iGHgliO8hLPZ
	PiZn3T80NfVLQX/9q9kp90OvmxPL2XBAf/xfVVINzIIK81c1bZAkX2bHTimHutwi1tUn8f
	LBosWDvnFnN33g2JpoAiNTW7DLNNId8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-674-vuk2LXO-MVGBwJ0yhq-E7g-1; Wed,
 11 Nov 2026 11:41:09 -0500
X-MC-Unique: vuk2LXO-MVGBwJ0yhq-E7g-1
X-Mimecast-MFC-AGG-ID: vuk2LXO-MVGBwJ0yhq-E7g_1794415266
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 00C711955E7E;
	Wed, 11 Nov 2026 16:41:06 +0000 (UTC)
Received: from ivecera-thinkpadp16vgen1.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 731AB421;
	Wed, 11 Nov 2026 16:41:00 +0000 (UTC)
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
Subject: [PATCH net-next v2 6/9] dpll: reject measured_freq_get for foreign and on-pin registrations
Date: Wed, 11 Nov 2026 17:40:17 +0100
Message-ID: <20261111164021.273409-7-ivecera@redhat.com>
In-Reply-To: <20261111164021.273409-1-ivecera@redhat.com>
References: <20261111164021.273409-1-ivecera@redhat.com>
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

A message about a pin with .measured_freq_get calls .freq_monitor_get of
a dpll of the pin. For a pin of another domain, this device callback
would run outside the domain of the dpll, so dpll_pin_register() now
rejects such ops.

dpll_pin_on_pin_register() checks nothing about them. The message would
call .freq_monitor_get with no NULL check, on a dpll of the parent pin
that can belong to another driver, so reject them there as well.

No in-tree driver passes such ops. Add KUnit tests: the ops work on a dpll
of the domain of the pin, and are rejected on a dpll of another domain and
under a parent pin.

Reviewed-by: Petr Oros <poros@redhat.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
No changes since v1
---
 drivers/dpll/dpll_core.c       |   6 +-
 drivers/dpll/dpll_core_kunit.c | 112 +++++++++++++++++++++++++++++++--
 2 files changed, 111 insertions(+), 7 deletions(-)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index 2b1dfe2929647e..a73abb0772cc6b 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -958,7 +958,8 @@ dpll_pin_register(struct dpll_device *dpll, struct dpll_pin *pin,
 
 	dev_ops = dpll_device_ops(dpll);
 	if (WARN_ON(ops->measured_freq_get &&
-		    (!dev_ops || !dev_ops->freq_monitor_get ||
+		    (pin->domain != dpll->domain || !dev_ops ||
+		     !dev_ops->freq_monitor_get ||
 		     !dev_ops->freq_monitor_set))) {
 		ret = -EINVAL;
 		goto out_unlock;
@@ -1065,7 +1066,8 @@ int dpll_pin_on_pin_register(struct dpll_pin *parent, struct dpll_pin *pin,
 
 	if (WARN_ON(!ops) ||
 	    WARN_ON(!ops->state_on_pin_get) ||
-	    WARN_ON(!ops->direction_get))
+	    WARN_ON(!ops->direction_get) ||
+	    WARN_ON(ops->measured_freq_get))
 		return -EINVAL;
 
 	down_write(&dpll_lock);
diff --git a/drivers/dpll/dpll_core_kunit.c b/drivers/dpll/dpll_core_kunit.c
index 21f941a5fdec4e..d575eed160700f 100644
--- a/drivers/dpll/dpll_core_kunit.c
+++ b/drivers/dpll/dpll_core_kunit.c
@@ -87,6 +87,7 @@ struct dt_reg {
 	struct dt_dev *dev;
 	struct dt_pin *parent;
 	struct dt_pin *notify;
+	const struct dpll_pin_ops *ops;
 	struct dpll_domain *forbid;
 	enum dpll_pin_state state;
 	enum dpll_pin_direction direction;
@@ -276,11 +277,33 @@ static int dt_lock_status_get(const struct dpll_device *dpll, void *priv,
 	return 0;
 }
 
+static int dt_freq_monitor_set(const struct dpll_device *dpll, void *priv,
+			       enum dpll_feature_state state,
+			       struct netlink_ext_ack *extack)
+{
+	return 0;
+}
+
+static int dt_freq_monitor_get(const struct dpll_device *dpll, void *priv,
+			       enum dpll_feature_state *state,
+			       struct netlink_ext_ack *extack)
+{
+	struct dt_dev *dev = priv;
+
+	dt_dev_enter(dev, dpll);
+	*state = DPLL_FEATURE_STATE_ENABLE;
+	dt_leave(dev->dom);
+
+	return 0;
+}
+
 static const struct dpll_device_ops dt_dev_ops = {
 	.mode_get = dt_mode_get,
 	.mode_set = dt_mode_set,
 	.supported_modes_get = dt_supported_modes_get,
 	.lock_status_get = dt_lock_status_get,
+	.freq_monitor_set = dt_freq_monitor_set,
+	.freq_monitor_get = dt_freq_monitor_get,
 };
 
 static int dt_frequency_get(const struct dpll_pin *pin, void *pin_priv,
@@ -433,6 +456,21 @@ static int dt_ref_sync_get(const struct dpll_pin *pin, void *pin_priv,
 	return 0;
 }
 
+static int dt_measured_freq_get(const struct dpll_pin *pin, void *pin_priv,
+				const struct dpll_device *dpll, void *dpll_priv,
+				u64 *measured_freq,
+				struct netlink_ext_ack *extack)
+{
+	struct dt_reg *reg = pin_priv;
+
+	dt_pin_enter(reg, pin);
+	atomic_inc(&reg->freq_gets);
+	*measured_freq = 1;
+	dt_leave(reg->dom);
+
+	return 0;
+}
+
 static const struct dpll_pin_ops dt_pin_ops = {
 	.frequency_get = dt_frequency_get,
 	.state_on_dpll_get = dt_state_on_dpll_get,
@@ -446,6 +484,13 @@ static const struct dpll_pin_ops dt_pin_ops = {
 	.ref_sync_get = dt_ref_sync_get,
 };
 
+static const struct dpll_pin_ops dt_pin_ops_measured = {
+	.measured_freq_get = dt_measured_freq_get,
+	.state_on_dpll_get = dt_state_on_dpll_get,
+	.state_on_pin_get = dt_state_on_pin_get,
+	.direction_get = dt_direction_get,
+};
+
 static const struct dpll_pin_properties dt_prop = {
 	.type = DPLL_PIN_TYPE_EXT,
 	.capabilities = DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE |
@@ -570,9 +615,9 @@ static void dt_reg_release(void *data)
 
 	if (reg->parent)
 		dpll_pin_on_pin_unregister(reg->parent->pin, reg->pin->pin,
-					   &dt_pin_ops, reg);
+					   reg->ops, reg);
 	else
-		dpll_pin_unregister(reg->dev->dpll, reg->pin->pin, &dt_pin_ops,
+		dpll_pin_unregister(reg->dev->dpll, reg->pin->pin, reg->ops,
 				    reg);
 }
 
@@ -588,12 +633,14 @@ static void dt_reg_add(struct kunit *test, struct dt_reg *reg,
 	reg->parent = parent;
 	reg->state = DPLL_PIN_STATE_SELECTABLE;
 	reg->direction = DPLL_PIN_DIRECTION_INPUT;
+	if (!reg->ops)
+		reg->ops = &dt_pin_ops;
 
 	if (parent)
-		ret = dpll_pin_on_pin_register(parent->pin, pin->pin,
-					       &dt_pin_ops, reg);
+		ret = dpll_pin_on_pin_register(parent->pin, pin->pin, reg->ops,
+					       reg);
 	else
-		ret = dpll_pin_register(dev->dpll, pin->pin, &dt_pin_ops, reg);
+		ret = dpll_pin_register(dev->dpll, pin->pin, reg->ops, reg);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test, dt_reg_release,
 							reg), 0);
@@ -1438,6 +1485,59 @@ static void dt_test_ref_sync_pair(struct kunit *test)
 	dt_expect_events(test, (void *[]){ ctx->p.pin }, 1);
 }
 
+/* A pin with a measured frequency must be in the domain of its dpll */
+static void dt_test_measured_freq_foreign(struct kunit *test)
+{
+	struct kunit_suppressed_warning *w;
+	struct dt_ctx *ctx = test->priv;
+	struct dt_reg *reg;
+	int ret;
+
+	dt_dev_add(test, &ctx->e0, &ctx->dom_e, DT_CLOCK_ID_E, 0,
+		   DPLL_TYPE_PPS);
+	dt_dev_add(test, &ctx->f0, &ctx->dom_f, DT_CLOCK_ID_F, 0,
+		   DPLL_TYPE_PPS);
+	dt_fwnode_pin_add(test, &ctx->x, DT_CLOCK_ID_E, DT_PIN_IDX_X);
+
+	reg = &ctx->reg_x_e0;
+	reg->ops = &dt_pin_ops_measured;
+	dt_reg_add(test, reg, &ctx->dom_e, &ctx->x, &ctx->e0, NULL);
+	atomic_set(&reg->freq_gets, 0);
+	KUNIT_EXPECT_EQ(test, dt_run(test, dt_pin_ntf, &ctx->x), 0);
+	KUNIT_EXPECT_GT(test, atomic_read(&reg->freq_gets), 0);
+
+	w = kunit_start_suppress_warning(test);
+	ret = dpll_pin_register(ctx->f0.dpll, ctx->x.pin, reg->ops, reg);
+	kunit_end_suppress_warning(test, w);
+
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+	if (!ret)
+		dpll_pin_unregister(ctx->f0.dpll, ctx->x.pin, reg->ops, reg);
+}
+
+/* A pin under a parent pin cannot have a measured frequency */
+static void dt_test_measured_freq_on_pin(struct kunit *test)
+{
+	struct kunit_suppressed_warning *w;
+	struct dt_ctx *ctx = test->priv;
+	struct dt_reg *reg;
+	int ret;
+
+	dt_on_pin_add(test);
+	dt_pin_add(test, &ctx->y, DT_CLOCK_ID_G, DT_PIN_IDX_Y, &dt_prop);
+	reg = &ctx->reg_c_m;
+
+	w = kunit_start_suppress_warning(test);
+	ret = dpll_pin_on_pin_register(ctx->m.pin, ctx->y.pin,
+				       &dt_pin_ops_measured, reg);
+	kunit_end_suppress_warning(test, w);
+
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+	if (!ret)
+		dpll_pin_on_pin_unregister(ctx->m.pin, ctx->y.pin,
+					   &dt_pin_ops_measured, reg);
+}
+
 static struct kunit_case dt_cases[] = {
 	KUNIT_CASE(dt_test_domain_sharing),
 	KUNIT_CASE(dt_test_domain_per_module),
@@ -1462,6 +1562,8 @@ static struct kunit_case dt_cases[] = {
 	KUNIT_CASE(dt_test_set_on_pin),
 	KUNIT_CASE(dt_test_device_set_ntf),
 	KUNIT_CASE(dt_test_ref_sync_pair),
+	KUNIT_CASE(dt_test_measured_freq_foreign),
+	KUNIT_CASE(dt_test_measured_freq_on_pin),
 	{}
 };
 
-- 
2.56.0

