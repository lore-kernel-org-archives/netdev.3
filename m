Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415252;
	b=aeUmsoBaot7CS+YuV9HYhyWUfbr5NoJ4oZ7PH015qhr/yyuc6EIV2ahabt5AvnWR8k6u
	 8OBmF1Lzjp5w/EaSjvRLsCDKRs4fyFIvZTYApHh3ohdk8gDWlI01SHf6XBQI8n4eWBbLU
	 eCnxHFIG7ZOIt0jwQp67e9bk2vhOhwIU4ivxoE1is4fsJp1kVeIB7sAVQAVWrYxCxPKb7
	 floJUJloNcGIkRjTRH9coM7435mhxZzh+mnZ9mQJRKAK35NzoGL2qc8yh02cbrpvVSVS+
	 WglpQj5IkkkjH9prCLAKg/nhqRle1mTmYTZWSBAgqsbcn1E2c3jYMpOzsKyjgf1Qjcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415252;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=GVpqEQdeZ6Xl2N3ggskm2E4WT2d/uk/VeOOShN/bjqU=;
	b=Swy6MwEVAXCosRJ1xegSa4yMWBpwG2v8vF5Gr34Es72fKzKafo+xE9AREhTZ6Dbvzc2a
	 bG4IT7diIuauTwYRFH7VCtE9zINbF+DO06ciKMA3iMTMONbg6hAGE4cPjj5ZEnbSTBQeP
	 hXfL71e4Ozvp0wvmA4UyFzEmwKdyHQJnm4ObdlK81QFOzNhaQmtzN1T8KY8pxey7j29vY
	 mC793cXTpvrudH4GOFHDtCs3oFcrVRb9xOcqVyyjuZPyjbGiGZMCOld4jffRtylroR6e7
	 S8LPBIXjxEOrfJEUNX2Ncf4yDRjgZRldIn52lqZTFkEl2Q+GYqfRVq40uqGevfGifOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SiiC84n1;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AF9606A89E
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 16:40:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13AF9606A89E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SiiC84n1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794415251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GVpqEQdeZ6Xl2N3ggskm2E4WT2d/uk/VeOOShN/bjqU=;
	b=SiiC84n1Rki3QbOC7uTK5/c/GhYl68nkeUl/ZaPlSGpJfiDi5oQwqeo4Z+WpbhA2/cC2fs
	hizqVcI0mEDDwSDbVPJfKmHQ/eSrDpZwRakn8peJmnXW9dgANhNU/1bNBk+BOQavHto+6p
	WJ6DxHhuYDTKqBJWIw90jyd9S/aw1kM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-262-DB1KiW41P76NTV8Fl0A1NA-1; Wed,
 11 Nov 2026 11:40:44 -0500
X-MC-Unique: DB1KiW41P76NTV8Fl0A1NA-1
X-Mimecast-MFC-AGG-ID: DB1KiW41P76NTV8Fl0A1NA_1794415242
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9EDF0180054D;
	Wed, 11 Nov 2026 16:40:41 +0000 (UTC)
Received: from ivecera-thinkpadp16vgen1.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6E68B428;
	Wed, 11 Nov 2026 16:40:35 +0000 (UTC)
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
Subject: [PATCH net-next v2 2/9] dpll: add domain object
Date: Wed, 11 Nov 2026 17:40:13 +0100
Message-ID: <20261111164021.273409-3-ivecera@redhat.com>
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

All dpll device and pin callbacks are serialized by the global dpll_lock,
so a slow device stalls all others, whichever driver they belong to.

Add struct dpll_domain as a preparation for serializing callbacks per
driver instance. A domain groups all devices and pins created with the
same (module, clock_id) pair, which is in practice one chip or card. The
same pair already identifies the owner of a pin in
dpll_pin_own_dpll_ref_first(), which now compares the domains instead.

Domains are kept in an xarray, like devices and pins, and they live only as
long as their objects.

No functional change.

Reviewed-by: Petr Oros <poros@redhat.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
Changes in v2:
- Moved the mutex to the next patch, which first takes it (Sashiko)
- dpll_pin_own_dpll_ref_first() compares the domains
---
 drivers/dpll/dpll_core.c | 71 ++++++++++++++++++++++++++++++++++++----
 drivers/dpll/dpll_core.h | 21 ++++++++++++
 2 files changed, 85 insertions(+), 7 deletions(-)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index 8389983f425695..c1b54e6ba430bf 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -24,6 +24,7 @@ DEFINE_MUTEX(dpll_lock);
 
 DEFINE_XARRAY_FLAGS(dpll_device_xa, XA_FLAGS_ALLOC);
 DEFINE_XARRAY_FLAGS(dpll_pin_xa, XA_FLAGS_ALLOC);
+static DEFINE_XARRAY_FLAGS(dpll_domain_xa, XA_FLAGS_ALLOC);
 
 static RAW_NOTIFIER_HEAD(dpll_notifier_chain);
 static DEFINE_IDA(dpll_pin_idx_ida);
@@ -88,6 +89,47 @@ void dpll_pin_notify(struct dpll_pin *pin, u64 src_clock_id,
 	call_dpll_notifiers(action, &info);
 }
 
+static struct dpll_domain *dpll_domain_get(u64 clock_id, struct module *module)
+{
+	struct dpll_domain *domain;
+	unsigned long i;
+	int ret;
+
+	lockdep_assert_held(&dpll_lock);
+
+	xa_for_each(&dpll_domain_xa, i, domain) {
+		if (domain->clock_id == clock_id && domain->module == module) {
+			refcount_inc(&domain->refcount);
+			return domain;
+		}
+	}
+
+	domain = kzalloc_obj(*domain);
+	if (!domain)
+		return ERR_PTR(-ENOMEM);
+	domain->clock_id = clock_id;
+	domain->module = module;
+	refcount_set(&domain->refcount, 1);
+	ret = xa_alloc(&dpll_domain_xa, &domain->id, domain, xa_limit_32b,
+		       GFP_KERNEL);
+	if (ret) {
+		kfree(domain);
+		return ERR_PTR(ret);
+	}
+
+	return domain;
+}
+
+static void dpll_domain_put(struct dpll_domain *domain)
+{
+	lockdep_assert_held(&dpll_lock);
+
+	if (refcount_dec_and_test(&domain->refcount)) {
+		xa_erase(&dpll_domain_xa, domain->id);
+		kfree(domain);
+	}
+}
+
 static void dpll_device_tracker_alloc(struct dpll_device *dpll,
 				      dpll_tracker *tracker)
 {
@@ -120,6 +162,7 @@ static void __dpll_device_put(struct dpll_device *dpll, dpll_tracker *tracker)
 		xa_erase(&dpll_device_xa, dpll->id);
 		WARN_ON(!list_empty(&dpll->registration_list));
 		ref_tracker_dir_exit(&dpll->refcnt_tracker);
+		dpll_domain_put(dpll->domain);
 		kfree(dpll);
 	}
 }
@@ -159,6 +202,7 @@ static void __dpll_pin_put(struct dpll_pin *pin, dpll_tracker *tracker)
 		fwnode_handle_put(pin->fwnode);
 		dpll_pin_idx_free(pin->pin_idx);
 		ref_tracker_dir_exit(&pin->refcnt_tracker);
+		dpll_domain_put(pin->domain);
 		kfree_rcu(pin, rcu);
 	}
 }
@@ -366,6 +410,12 @@ dpll_device_alloc(const u64 clock_id, u32 device_idx, struct module *module)
 	dpll = kzalloc_obj(*dpll);
 	if (!dpll)
 		return ERR_PTR(-ENOMEM);
+	dpll->domain = dpll_domain_get(clock_id, module);
+	if (IS_ERR(dpll->domain)) {
+		ret = PTR_ERR(dpll->domain);
+		kfree(dpll);
+		return ERR_PTR(ret);
+	}
 	refcount_set(&dpll->refcount, 1);
 	INIT_LIST_HEAD(&dpll->registration_list);
 	dpll->device_idx = device_idx;
@@ -374,6 +424,7 @@ dpll_device_alloc(const u64 clock_id, u32 device_idx, struct module *module)
 	ret = xa_alloc_cyclic(&dpll_device_xa, &dpll->id, dpll, xa_limit_32b,
 			      &dpll_device_xa_id, GFP_KERNEL);
 	if (ret < 0) {
+		dpll_domain_put(dpll->domain);
 		kfree(dpll);
 		return ERR_PTR(ret);
 	}
@@ -664,6 +715,11 @@ dpll_pin_alloc(u64 clock_id, u32 pin_idx, struct module *module,
 	ret = dpll_pin_prop_dup(prop, &pin->prop);
 	if (ret)
 		goto err_pin_prop;
+	pin->domain = dpll_domain_get(clock_id, module);
+	if (IS_ERR(pin->domain)) {
+		ret = PTR_ERR(pin->domain);
+		goto err_domain;
+	}
 	refcount_set(&pin->refcount, 1);
 	xa_init_flags(&pin->dpll_refs, XA_FLAGS_ALLOC);
 	xa_init_flags(&pin->parent_refs, XA_FLAGS_ALLOC);
@@ -678,6 +734,8 @@ dpll_pin_alloc(u64 clock_id, u32 pin_idx, struct module *module,
 	xa_destroy(&pin->dpll_refs);
 	xa_destroy(&pin->parent_refs);
 	xa_destroy(&pin->ref_sync_pins);
+	dpll_domain_put(pin->domain);
+err_domain:
 	dpll_pin_prop_free(&pin->prop);
 err_pin_prop:
 	kfree(pin);
@@ -1156,11 +1214,11 @@ void *dpll_pin_on_pin_priv(struct dpll_pin *parent,
  * dpll_pin_own_dpll_ref_first - find the first owner dpll ref of a pin
  * @pin: pointer to a dpll pin
  *
- * Search pin's dpll_refs for a ref whose dpll matches the pin's
- * (module, clock_id) tuple, i.e. the dpll registered by the driver
- * that created the pin. This ensures pin-level attributes are
- * reported and modified using the owner's ops even when the pin is
- * also registered with dplls from other drivers.
+ * Search pin's dpll_refs for a ref whose dpll belongs to the domain of
+ * the pin, i.e. the dpll registered by the driver that created the pin.
+ * This ensures pin-level attributes are reported and modified using the
+ * owner's ops even when the pin is also registered with dplls from other
+ * drivers.
  *
  * Return: pointer to the owner's dpll_pin_ref, or NULL if no
  * owner ref is found.
@@ -1171,8 +1229,7 @@ struct dpll_pin_ref *dpll_pin_own_dpll_ref_first(struct dpll_pin *pin)
 	unsigned long i;
 
 	xa_for_each(&pin->dpll_refs, i, ref) {
-		if (ref->dpll->module == pin->module &&
-		    ref->dpll->clock_id == pin->clock_id)
+		if (ref->dpll->domain == pin->domain)
 			return ref;
 	}
 
diff --git a/drivers/dpll/dpll_core.h b/drivers/dpll/dpll_core.h
index da8a369556ed11..6edf7edf7a9539 100644
--- a/drivers/dpll/dpll_core.h
+++ b/drivers/dpll/dpll_core.h
@@ -15,12 +15,30 @@
 
 #define DPLL_REGISTERED		XA_MARK_1
 
+/**
+ * struct dpll_domain - group of dpll objects
+ * @id:			index of the domain in dpll_domain_xa
+ * @clock_id:		clock_id of the objects in the domain
+ * @module:		module of the objects in the domain
+ * @refcount:		number of dpll devices and pins in the domain
+ *
+ * All dpll devices and pins created with the same (module, clock_id) pair
+ * belong to one domain, in practice to one chip or card.
+ **/
+struct dpll_domain {
+	u32 id;
+	u64 clock_id;
+	struct module *module;
+	refcount_t refcount;
+};
+
 /**
  * struct dpll_device - stores DPLL device internal data
  * @id:			unique id number for device given by dpll subsystem
  * @device_idx:		id given by dev driver
  * @clock_id:		unique identifier (clock_id) of a dpll
  * @module:		module of creator
+ * @domain:		domain the device belongs to
  * @type:		type of a dpll
  * @pin_refs:		stores pins registered within a dpll
  * @refcount:		refcount
@@ -32,6 +50,7 @@ struct dpll_device {
 	u32 device_idx;
 	u64 clock_id;
 	struct module *module;
+	struct dpll_domain *domain;
 	enum dpll_type type;
 	struct xarray pin_refs;
 	refcount_t refcount;
@@ -46,6 +65,7 @@ struct dpll_device {
  * @clock_id:		clock_id of creator
  * @module:		module of creator
  * @module_name:	module name of creator
+ * @domain:		domain the pin belongs to
  * @fwnode:		optional reference to firmware node
  * @dpll_refs:		hold referencees to dplls pin was registered with
  * @parent_refs:	hold references to parent pins pin was registered with
@@ -61,6 +81,7 @@ struct dpll_pin {
 	u64 clock_id;
 	struct module *module;
 	char module_name[MODULE_NAME_LEN];
+	struct dpll_domain *domain;
 	struct fwnode_handle *fwnode;
 	struct xarray dpll_refs;
 	struct xarray parent_refs;
-- 
2.56.0

