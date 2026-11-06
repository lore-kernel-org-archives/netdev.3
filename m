Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793967043;
	b=bdFTIdP/OjXvqFhWZFYgVyj74RLEV4LVjJtwpLzaCLhsGlgpb9E+9doyJyKljDXlkCQJ
	 aLBsVnfJZLgQgNUKN7eSy26+frPxSf3cSOrEkVIgI16oANpHrY7WXrJWXMOlK9gMtg+ZJ
	 sn5Do/0k1u13ppW8Mxdctbml1zGLFfg2IiSn+RW21LPko61MtYJ2V7MIqZUgaZvpYo6uM
	 MAJVtX9ARDrsW+lbxQJJ4O8qtmG9u0dsp7Pa9wzvrgI2APRU5dBb7hhPAwE17foqKCg45
	 x7Q9wY/OtW2n1Z3U6JouD8DhygpS1bZKjsfRgTBylSuSo91GaDNAY1pMvrme2Q6F5VA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793967043;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=DNMrUoJjtebq02qUQke1dSqKE2bqVQchCGuYtctyfYk=;
	b=no1998Ep/xQOPCgD0su3+DIoecTxctx0DpYkN3hRezu3T5eX/S1VyK5jYqMSXV+pIokB
	 Eq7vX2riREt17qG9dA7YpBN3N1RRQvhEhNB5l/hKndjmZi5i4QHal2UN3I+qDYoHxZ5EY
	 b1tvj55YcK6pynMJsvdvYIBeY3rVABy0piDUORGMKYCuppJxWnQRs3XxhL7Mq4F0ky5MG
	 +BbS3hkoRHpxjEHfWO7EkHAEILWcWVANZks1IfQBITimxsDfwaHRN0CjEs7atFsOKCUTE
	 WjsKbyXGPY364V+N6ZsEJxqjFdukoU3UwO80CDAE1tappPedVnCEozv+rbZPKO+sF5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bhukFN3i;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1F5606A338
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 12:10:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D1F5606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bhukFN3i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793967042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DNMrUoJjtebq02qUQke1dSqKE2bqVQchCGuYtctyfYk=;
	b=bhukFN3i3D3Bbk5AgTLt2rP4zeX704SnIynbpk11nh7mvh4O3rEF2TMy4RMTEM+PknqAnO
	Daw7msQyLLaXaLKxtfBl68JhIeJytbnjJOQ2Vw+dJCBlrtjhU3aydkBZbB5b5khnijbFP6
	cr53eQEeoVb2vypY7aCyVcD5gP4gs+c=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-128-4YJlmD3jNNuPK9NrCRiFRQ-1; Fri,
 06 Nov 2026 07:10:36 -0500
X-MC-Unique: 4YJlmD3jNNuPK9NrCRiFRQ-1
X-Mimecast-MFC-AGG-ID: 4YJlmD3jNNuPK9NrCRiFRQ_1793967034
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 99CAE1955F6D;
	Fri,  6 Nov 2026 12:10:33 +0000 (UTC)
Received: from ivecera-thinkpadp16vgen1.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8B0A7187C36C;
	Fri,  6 Nov 2026 12:10:27 +0000 (UTC)
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
Subject: [PATCH net-next 03/10] dpll: add domain object
Date: Fri,  6 Nov 2026 13:09:58 +0100
Message-ID: <20261106121005.1327603-4-ivecera@redhat.com>
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

All dpll device and pin callbacks are serialized by the global dpll_lock,
so a slow device stalls all others, whichever driver they belong to.

Add struct dpll_domain as a preparation for serializing callbacks per
driver instance. A domain groups all devices and pins created with the
same (module, clock_id) pair, which is in practice one chip or card. The
same pair already identifies the owner of a pin in
dpll_pin_own_dpll_ref_first().

Domains are kept in an xarray, like devices and pins, and they live only as
long as their objects.

No functional change.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/dpll_core.c | 61 ++++++++++++++++++++++++++++++++++++++++
 drivers/dpll/dpll_core.h | 27 ++++++++++++++++++
 2 files changed, 88 insertions(+)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index 8389983f425695..d39c4905172f2d 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -24,6 +24,7 @@ DEFINE_MUTEX(dpll_lock);
 
 DEFINE_XARRAY_FLAGS(dpll_device_xa, XA_FLAGS_ALLOC);
 DEFINE_XARRAY_FLAGS(dpll_pin_xa, XA_FLAGS_ALLOC);
+static DEFINE_XARRAY_FLAGS(dpll_domain_xa, XA_FLAGS_ALLOC);
 
 static RAW_NOTIFIER_HEAD(dpll_notifier_chain);
 static DEFINE_IDA(dpll_pin_idx_ida);
@@ -88,6 +89,50 @@ void dpll_pin_notify(struct dpll_pin *pin, u64 src_clock_id,
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
+	mutex_init(&domain->lock);
+	ret = xa_alloc(&dpll_domain_xa, &domain->id, domain, xa_limit_32b,
+		       GFP_KERNEL);
+	if (ret) {
+		mutex_destroy(&domain->lock);
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
+		mutex_destroy(&domain->lock);
+		kfree(domain);
+	}
+}
+
 static void dpll_device_tracker_alloc(struct dpll_device *dpll,
 				      dpll_tracker *tracker)
 {
@@ -120,6 +165,7 @@ static void __dpll_device_put(struct dpll_device *dpll, dpll_tracker *tracker)
 		xa_erase(&dpll_device_xa, dpll->id);
 		WARN_ON(!list_empty(&dpll->registration_list));
 		ref_tracker_dir_exit(&dpll->refcnt_tracker);
+		dpll_domain_put(dpll->domain);
 		kfree(dpll);
 	}
 }
@@ -159,6 +205,7 @@ static void __dpll_pin_put(struct dpll_pin *pin, dpll_tracker *tracker)
 		fwnode_handle_put(pin->fwnode);
 		dpll_pin_idx_free(pin->pin_idx);
 		ref_tracker_dir_exit(&pin->refcnt_tracker);
+		dpll_domain_put(pin->domain);
 		kfree_rcu(pin, rcu);
 	}
 }
@@ -366,6 +413,12 @@ dpll_device_alloc(const u64 clock_id, u32 device_idx, struct module *module)
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
@@ -374,6 +427,7 @@ dpll_device_alloc(const u64 clock_id, u32 device_idx, struct module *module)
 	ret = xa_alloc_cyclic(&dpll_device_xa, &dpll->id, dpll, xa_limit_32b,
 			      &dpll_device_xa_id, GFP_KERNEL);
 	if (ret < 0) {
+		dpll_domain_put(dpll->domain);
 		kfree(dpll);
 		return ERR_PTR(ret);
 	}
@@ -664,6 +718,11 @@ dpll_pin_alloc(u64 clock_id, u32 pin_idx, struct module *module,
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
@@ -678,6 +737,8 @@ dpll_pin_alloc(u64 clock_id, u32 pin_idx, struct module *module,
 	xa_destroy(&pin->dpll_refs);
 	xa_destroy(&pin->parent_refs);
 	xa_destroy(&pin->ref_sync_pins);
+	dpll_domain_put(pin->domain);
+err_domain:
 	dpll_pin_prop_free(&pin->prop);
 err_pin_prop:
 	kfree(pin);
diff --git a/drivers/dpll/dpll_core.h b/drivers/dpll/dpll_core.h
index da8a369556ed11..6705e81bc11de9 100644
--- a/drivers/dpll/dpll_core.h
+++ b/drivers/dpll/dpll_core.h
@@ -9,18 +9,42 @@
 
 #include <linux/dpll.h>
 #include <linux/list.h>
+#include <linux/mutex.h>
 #include <linux/refcount.h>
 #include <linux/ref_tracker.h>
 #include "dpll_nl.h"
 
 #define DPLL_REGISTERED		XA_MARK_1
 
+/**
+ * struct dpll_domain - group of dpll objects sharing a lock
+ * @id:			index of the domain in dpll_domain_xa
+ * @clock_id:		clock_id of the objects in the domain
+ * @module:		module of the objects in the domain
+ * @refcount:		number of dpll devices and pins in the domain
+ * @lock:		lock of the domain
+ *
+ * All dpll devices and pins created with the same (module, clock_id) pair
+ * belong to one domain, in practice to one chip or card.
+ **/
+struct dpll_domain {
+	u32 id;
+	u64 clock_id;
+	struct module *module;
+	refcount_t refcount;
+	/* Serializes the driver callbacks of all DPLL devices and pins
+	 * that share one (module, clock_id) pair.
+	 */
+	struct mutex lock;
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
@@ -32,6 +56,7 @@ struct dpll_device {
 	u32 device_idx;
 	u64 clock_id;
 	struct module *module;
+	struct dpll_domain *domain;
 	enum dpll_type type;
 	struct xarray pin_refs;
 	refcount_t refcount;
@@ -46,6 +71,7 @@ struct dpll_device {
  * @clock_id:		clock_id of creator
  * @module:		module of creator
  * @module_name:	module name of creator
+ * @domain:		domain the pin belongs to
  * @fwnode:		optional reference to firmware node
  * @dpll_refs:		hold referencees to dplls pin was registered with
  * @parent_refs:	hold references to parent pins pin was registered with
@@ -61,6 +87,7 @@ struct dpll_pin {
 	u64 clock_id;
 	struct module *module;
 	char module_name[MODULE_NAME_LEN];
+	struct dpll_domain *domain;
 	struct fwnode_handle *fwnode;
 	struct xarray dpll_refs;
 	struct xarray parent_refs;
-- 
2.56.0

