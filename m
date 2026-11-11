Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415258;
	b=hUEJx88+v3CUl19s8Y6or2ntUC8RScmsbSlC9QnTdsAAXKflJDkUMDbPMfq/TS4rLqQT
	 b58ZHFjsdla4821emZubAWjo2WnRdnAh7mF77gw6hV//Z7X+zA85o+hKmR90oTYc2T+Hc
	 zc1tmWrjyVBsKuuEOfzR6KIvFWrfu+DZJnp1bUJ4+RaPk6b+QpSOkHq4c8cOevS8ln0Hu
	 ZO2b0KjsZW+ll/Y00Ys5m40DsnEdQIXMN/44EchIgQA5c4ePbRtc394IFQ5xuXGdIbL5T
	 3FvrAEj2fBmmHBXNP8+e7vFiMte2aLOX5PFizau1xb9SFpUg8+xEpjxFFqTZnS/GnMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415258;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=umDKtDCFGzYxk2dEeezIHi8PxghDJPE6q5xyw+RAb64=;
	b=3vnWYGfLEksbjEaMcgxwu0RkUnR5VCmd7VqN9mE4HqCvRwZxlq3SFI6J5RsJGb2+PwVs
	 r1h/Z5Ul84tKoCETHjU9nb5nwApgrwXzJ7JFZYxqp8w0bb1RreUqlBxvBHdbgHyhq73hg
	 AdoeqoRpoCihGp6A0XDbtqUFE2s5BkSoc1OvVI7ShThOBnW8g8xHT1LrfYxATY3yOOT3l
	 ynmpXb8wPUo5XFiRlZs02aQBVPUu2ca4fWRQ0e+/K6y7rt2fgq6yOdlpODKvGVMDMGRDT
	 uXvDaHXatNjFd9CQbAw9KaAs5FcEvhafToWAs3ND96uWDJ0FcNAcFsxo8uHwggpFrQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bEgvf4im;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB83606A881
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 16:40:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEB83606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bEgvf4im
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794415257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=umDKtDCFGzYxk2dEeezIHi8PxghDJPE6q5xyw+RAb64=;
	b=bEgvf4im1ZLOhdbeOKAeMtFPckt99F6H2h3LZXSI9cknQZSVPCXyajhGsk8BKSdF0w/o1M
	RRPOE7Pz58AJUUpubEeJMlYdFWCLAuOApK4BZMvuFCRvzrhFub3frg6cQFiB5E9W68Mlgu
	HF0W4Ta8T/Bup02hwZxY9McnKlzvUdg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-492-1Ws9ZcBfNfGujCZvMzrUiw-1; Wed,
 11 Nov 2026 11:40:50 -0500
X-MC-Unique: 1Ws9ZcBfNfGujCZvMzrUiw-1
X-Mimecast-MFC-AGG-ID: 1Ws9ZcBfNfGujCZvMzrUiw_1794415247
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A167A1954B12;
	Wed, 11 Nov 2026 16:40:47 +0000 (UTC)
Received: from ivecera-thinkpadp16vgen1.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0F4BE421;
	Wed, 11 Nov 2026 16:40:41 +0000 (UTC)
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
Subject: [PATCH net-next v2 3/9] dpll: take domain locks around driver callbacks
Date: Wed, 11 Nov 2026 17:40:14 +0100
Message-ID: <20261111164021.273409-4-ivecera@redhat.com>
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

Add a mutex to struct dpll_domain. Hold the domain lock of the addressed
object wherever driver callbacks can run:

- netlink requests addressing a device or a pin, from pre_doit to post_doit
- dumps, for each object
- notifications, while the message is being built and sent

Callbacks of a device run under the domain of the device. Callbacks of a
pin run under the domain of the pin, also when another driver registered
the pin with its dpll or under its parent pin. All callbacks a message
about a pin needs are thus covered by one lock, and only one domain lock
is ever held. Domains have no lock order, so registrations can connect
them in any way.

A request is atomic against other requests addressing objects of that
domain, and messages of one object are sent in the order they were built.

Requests resolving an id run no callbacks, so they do not take the lock.

__dpll_{device,pin}_change_ntf() now also require the domain lock of the
object. A callback can therefore only notify objects of the domain it runs
under.

Callbacks stay serialized by dpll_lock for now.

Reviewed-by: Petr Oros <poros@redhat.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
Changes in v2:
- Added the domain mutex here, moved from the previous patch (Sashiko)
---
 drivers/dpll/dpll_core.c    | 21 ++++++----
 drivers/dpll/dpll_core.h    | 12 +++++-
 drivers/dpll/dpll_netlink.c | 78 ++++++++++++++++++++++++++++---------
 3 files changed, 85 insertions(+), 26 deletions(-)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index c1b54e6ba430bf..b4b2b2dc449aec 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -110,9 +110,11 @@ static struct dpll_domain *dpll_domain_get(u64 clock_id, struct module *module)
 	domain->clock_id = clock_id;
 	domain->module = module;
 	refcount_set(&domain->refcount, 1);
+	mutex_init(&domain->lock);
 	ret = xa_alloc(&dpll_domain_xa, &domain->id, domain, xa_limit_32b,
 		       GFP_KERNEL);
 	if (ret) {
+		mutex_destroy(&domain->lock);
 		kfree(domain);
 		return ERR_PTR(ret);
 	}
@@ -126,6 +128,7 @@ static void dpll_domain_put(struct dpll_domain *domain)
 
 	if (refcount_dec_and_test(&domain->refcount)) {
 		xa_erase(&dpll_domain_xa, domain->id);
+		mutex_destroy(&domain->lock);
 		kfree(domain);
 	}
 }
@@ -517,7 +520,7 @@ dpll_device_registration_find(struct dpll_device *dpll,
  *
  * Make dpll device available for user space.
  *
- * Context: Acquires a lock (dpll_lock)
+ * Context: Acquires dpll_lock and the domain lock of @dpll
  * Return:
  * * 0 on success
  * * negative - error value
@@ -576,7 +579,7 @@ EXPORT_SYMBOL_GPL(dpll_device_register);
  *
  * Unregister device, make it unavailable for userspace.
  * Note: It does not free the memory
- * Context: Acquires a lock (dpll_lock)
+ * Context: Acquires dpll_lock and the domain lock of @dpll
  */
 void dpll_device_unregister(struct dpll_device *dpll,
 			    const struct dpll_device_ops *ops, void *priv)
@@ -925,7 +928,7 @@ __dpll_pin_register(struct dpll_device *dpll, struct dpll_pin *pin,
  * @ops: ops for a dpll pin ops
  * @priv: pointer to private information of owner
  *
- * Context: Acquires a lock (dpll_lock)
+ * Context: Acquires dpll_lock and domain locks
  * Return:
  * * 0 on success
  * * negative - error value
@@ -986,7 +989,9 @@ static void dpll_pin_ref_sync_pair_del(u32 ref_sync_pin_id)
 		ref_sync_pin = xa_load(&pin->ref_sync_pins, ref_sync_pin_id);
 		if (ref_sync_pin) {
 			xa_erase(&pin->ref_sync_pins, ref_sync_pin_id);
+			mutex_lock(&pin->domain->lock);
 			__dpll_pin_change_ntf(pin);
+			mutex_unlock(&pin->domain->lock);
 		}
 	}
 }
@@ -1013,7 +1018,7 @@ __dpll_pin_unregister(struct dpll_device *dpll, struct dpll_pin *pin,
  * @priv: pointer to private information of owner
  *
  * Note: It does not free the memory
- * Context: Acquires a lock (dpll_lock)
+ * Context: Acquires dpll_lock and domain locks
  */
 void dpll_pin_unregister(struct dpll_device *dpll, struct dpll_pin *pin,
 			 const struct dpll_pin_ops *ops, void *priv)
@@ -1039,7 +1044,7 @@ EXPORT_SYMBOL_GPL(dpll_pin_unregister);
  * Register a pin with a parent pin, create references between them and
  * between newly registered pin and dplls connected with a parent pin.
  *
- * Context: Acquires a lock (dpll_lock)
+ * Context: Acquires dpll_lock and domain locks
  * Return:
  * * 0 on success
  * * negative - error value
@@ -1096,7 +1101,7 @@ EXPORT_SYMBOL_GPL(dpll_pin_on_pin_register);
  * @ops: ops for a dpll pin
  * @priv: pointer to private information of owner
  *
- * Context: Acquires a lock (dpll_lock)
+ * Context: Acquires dpll_lock and domain locks
  * Note: It does not free the memory
  */
 void dpll_pin_on_pin_unregister(struct dpll_pin *parent, struct dpll_pin *pin,
@@ -1126,7 +1131,7 @@ EXPORT_SYMBOL_GPL(dpll_pin_on_pin_unregister);
  *
  * Once pins are paired, the user-space configuration of reference sync pair
  * is possible.
- * Context: Acquires a lock (dpll_lock)
+ * Context: Acquires dpll_lock and domain locks
  * Return:
  * * 0 on success
  * * negative - error value
@@ -1139,7 +1144,9 @@ int dpll_pin_ref_sync_pair_add(struct dpll_pin *pin,
 	mutex_lock(&dpll_lock);
 	ret = xa_insert(&pin->ref_sync_pins, ref_sync_pin->id,
 			ref_sync_pin, GFP_KERNEL);
+	mutex_lock(&pin->domain->lock);
 	__dpll_pin_change_ntf(pin);
+	mutex_unlock(&pin->domain->lock);
 	mutex_unlock(&dpll_lock);
 
 	return ret;
diff --git a/drivers/dpll/dpll_core.h b/drivers/dpll/dpll_core.h
index 6edf7edf7a9539..630c5a1ca572c2 100644
--- a/drivers/dpll/dpll_core.h
+++ b/drivers/dpll/dpll_core.h
@@ -9,6 +9,7 @@
 
 #include <linux/dpll.h>
 #include <linux/list.h>
+#include <linux/mutex.h>
 #include <linux/refcount.h>
 #include <linux/ref_tracker.h>
 #include "dpll_nl.h"
@@ -16,20 +17,29 @@
 #define DPLL_REGISTERED		XA_MARK_1
 
 /**
- * struct dpll_domain - group of dpll objects
+ * struct dpll_domain - group of dpll objects sharing a lock
  * @id:			index of the domain in dpll_domain_xa
  * @clock_id:		clock_id of the objects in the domain
  * @module:		module of the objects in the domain
  * @refcount:		number of dpll devices and pins in the domain
+ * @lock:		serializes driver callbacks of the domain
  *
  * All dpll devices and pins created with the same (module, clock_id) pair
  * belong to one domain, in practice to one chip or card.
+ *
+ * Callbacks of a device run under the domain of the device and callbacks of a
+ * pin under the domain of the pin, whichever driver registered them. Only one
+ * domain lock is held at a time, so domains have no lock order.
  **/
 struct dpll_domain {
 	u32 id;
 	u64 clock_id;
 	struct module *module;
 	refcount_t refcount;
+	/* Serializes the driver callbacks of all DPLL devices and pins
+	 * that share one (module, clock_id) pair.
+	 */
+	struct mutex lock;
 };
 
 /**
diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index e5380d95f238b3..1b4e3a0166a744 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -861,27 +861,39 @@ dpll_device_event_send(enum dpll_cmd event, struct dpll_device *dpll)
 
 int dpll_device_create_ntf(struct dpll_device *dpll)
 {
+	int ret;
+
+	mutex_lock(&dpll->domain->lock);
 	dpll_device_notify(dpll, DPLL_DEVICE_CREATED);
-	return dpll_device_event_send(DPLL_CMD_DEVICE_CREATE_NTF, dpll);
+	ret = dpll_device_event_send(DPLL_CMD_DEVICE_CREATE_NTF, dpll);
+	mutex_unlock(&dpll->domain->lock);
+
+	return ret;
 }
 
 int dpll_device_delete_ntf(struct dpll_device *dpll)
 {
+	int ret;
+
+	mutex_lock(&dpll->domain->lock);
 	dpll_device_notify(dpll, DPLL_DEVICE_DELETED);
-	return dpll_device_event_send(DPLL_CMD_DEVICE_DELETE_NTF, dpll);
+	ret = dpll_device_event_send(DPLL_CMD_DEVICE_DELETE_NTF, dpll);
+	mutex_unlock(&dpll->domain->lock);
+
+	return ret;
 }
 
 /**
  * __dpll_device_change_ntf - notify that the dpll device has been changed
  * @dpll: registered dpll pointer
  *
- * Context: caller must hold dpll_lock. Suitable for use inside device
- *          callbacks which are already invoked under dpll_lock.
+ * Context: caller must hold dpll_lock and the domain lock of @dpll.
+ *          Suitable for use inside callbacks running under these locks.
  * Return: 0 if succeeds, error code otherwise.
  */
 int __dpll_device_change_ntf(struct dpll_device *dpll)
 {
-	lockdep_assert_held(&dpll_lock);
+	lockdep_assert_held(&dpll->domain->lock);
 	dpll_device_notify(dpll, DPLL_DEVICE_CHANGED);
 	return dpll_device_event_send(DPLL_CMD_DEVICE_CHANGE_NTF, dpll);
 }
@@ -891,7 +903,7 @@ EXPORT_SYMBOL_GPL(__dpll_device_change_ntf);
  * dpll_device_change_ntf - notify that the dpll device has been changed
  * @dpll: registered dpll pointer
  *
- * Context: acquires and holds a dpll_lock.
+ * Context: acquires and holds dpll_lock and the domain lock of @dpll.
  * Return: 0 if succeeds, error code otherwise.
  */
 int dpll_device_change_ntf(struct dpll_device *dpll)
@@ -899,7 +911,9 @@ int dpll_device_change_ntf(struct dpll_device *dpll)
 	int ret;
 
 	mutex_lock(&dpll_lock);
+	mutex_lock(&dpll->domain->lock);
 	ret = __dpll_device_change_ntf(dpll);
+	mutex_unlock(&dpll->domain->lock);
 	mutex_unlock(&dpll_lock);
 
 	return ret;
@@ -941,27 +955,39 @@ dpll_pin_event_send(enum dpll_cmd event, struct dpll_pin *pin)
 
 int dpll_pin_create_ntf(struct dpll_pin *pin, u64 src_clock_id)
 {
+	int ret;
+
+	mutex_lock(&pin->domain->lock);
 	dpll_pin_notify(pin, src_clock_id, DPLL_PIN_CREATED);
-	return dpll_pin_event_send(DPLL_CMD_PIN_CREATE_NTF, pin);
+	ret = dpll_pin_event_send(DPLL_CMD_PIN_CREATE_NTF, pin);
+	mutex_unlock(&pin->domain->lock);
+
+	return ret;
 }
 
 int dpll_pin_delete_ntf(struct dpll_pin *pin, u64 src_clock_id)
 {
+	int ret;
+
+	mutex_lock(&pin->domain->lock);
 	dpll_pin_notify(pin, src_clock_id, DPLL_PIN_DELETED);
-	return dpll_pin_event_send(DPLL_CMD_PIN_DELETE_NTF, pin);
+	ret = dpll_pin_event_send(DPLL_CMD_PIN_DELETE_NTF, pin);
+	mutex_unlock(&pin->domain->lock);
+
+	return ret;
 }
 
 /**
  * __dpll_pin_change_ntf - notify that the pin has been changed
  * @pin: registered pin pointer
  *
- * Context: caller must hold dpll_lock. Suitable for use inside pin
- *          callbacks which are already invoked under dpll_lock.
+ * Context: caller must hold dpll_lock and the domain lock of @pin.
+ *          Suitable for use inside callbacks running under these locks.
  * Return: 0 if succeeds, error code otherwise.
  */
 int __dpll_pin_change_ntf(struct dpll_pin *pin)
 {
-	lockdep_assert_held(&dpll_lock);
+	lockdep_assert_held(&pin->domain->lock);
 	dpll_pin_notify(pin, pin->clock_id, DPLL_PIN_CHANGED);
 	return dpll_pin_event_send(DPLL_CMD_PIN_CHANGE_NTF, pin);
 }
@@ -971,7 +997,7 @@ EXPORT_SYMBOL_GPL(__dpll_pin_change_ntf);
  * dpll_pin_change_ntf - notify that the pin has been changed
  * @pin: registered pin pointer
  *
- * Context: acquires and holds a dpll_lock.
+ * Context: acquires and holds dpll_lock and the domain lock of @pin.
  * Return: 0 if succeeds, error code otherwise.
  */
 int dpll_pin_change_ntf(struct dpll_pin *pin)
@@ -979,7 +1005,9 @@ int dpll_pin_change_ntf(struct dpll_pin *pin)
 	int ret;
 
 	mutex_lock(&dpll_lock);
+	mutex_lock(&pin->domain->lock);
 	ret = __dpll_pin_change_ntf(pin);
+	mutex_unlock(&pin->domain->lock);
 	mutex_unlock(&dpll_lock);
 
 	return ret;
@@ -1780,7 +1808,9 @@ int dpll_nl_pin_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 			ret = -EMSGSIZE;
 			break;
 		}
+		mutex_lock(&pin->domain->lock);
 		ret = dpll_cmd_pin_get_one(skb, pin, cb->extack);
+		mutex_unlock(&pin->domain->lock);
 		if (ret) {
 			genlmsg_cancel(skb, hdr);
 			if (ret == -ENODEV) {
@@ -1999,7 +2029,9 @@ int dpll_nl_device_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 			ret = -EMSGSIZE;
 			break;
 		}
+		mutex_lock(&dpll->domain->lock);
 		ret = dpll_device_get_one(dpll, skb, cb->extack);
+		mutex_unlock(&dpll->domain->lock);
 		if (ret) {
 			genlmsg_cancel(skb, hdr);
 			break;
@@ -2018,6 +2050,7 @@ int dpll_nl_device_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 int dpll_pre_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
 		  struct genl_info *info)
 {
+	struct dpll_device *dpll;
 	u32 id;
 
 	if (GENL_REQ_ATTR_CHECK(info, DPLL_A_ID))
@@ -2025,11 +2058,13 @@ int dpll_pre_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
 
 	mutex_lock(&dpll_lock);
 	id = nla_get_u32(info->attrs[DPLL_A_ID]);
-	info->user_ptr[0] = dpll_device_get_by_id(id);
-	if (!info->user_ptr[0]) {
+	dpll = dpll_device_get_by_id(id);
+	if (!dpll) {
 		NL_SET_ERR_MSG(info->extack, "device not found");
 		goto unlock;
 	}
+	info->user_ptr[0] = dpll;
+	mutex_lock(&dpll->domain->lock);
 	return 0;
 unlock:
 	mutex_unlock(&dpll_lock);
@@ -2039,6 +2074,9 @@ int dpll_pre_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
 void dpll_post_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
 		    struct genl_info *info)
 {
+	struct dpll_device *dpll = info->user_ptr[0];
+
+	mutex_unlock(&dpll->domain->lock);
 	mutex_unlock(&dpll_lock);
 }
 
@@ -2061,6 +2099,7 @@ dpll_unlock_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
 int dpll_pin_pre_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
 		      struct genl_info *info)
 {
+	struct dpll_pin *pin;
 	int ret;
 
 	mutex_lock(&dpll_lock);
@@ -2068,14 +2107,14 @@ int dpll_pin_pre_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
 		ret = -EINVAL;
 		goto unlock_dev;
 	}
-	info->user_ptr[0] = xa_load(&dpll_pin_xa,
-				    nla_get_u32(info->attrs[DPLL_A_PIN_ID]));
-	if (!info->user_ptr[0] ||
-	    !dpll_pin_available(info->user_ptr[0])) {
+	pin = xa_load(&dpll_pin_xa, nla_get_u32(info->attrs[DPLL_A_PIN_ID]));
+	if (!pin || !dpll_pin_available(pin)) {
 		NL_SET_ERR_MSG(info->extack, "pin not found");
 		ret = -ENODEV;
 		goto unlock_dev;
 	}
+	info->user_ptr[0] = pin;
+	mutex_lock(&pin->domain->lock);
 
 	return 0;
 
@@ -2087,5 +2126,8 @@ int dpll_pin_pre_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
 void dpll_pin_post_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
 			struct genl_info *info)
 {
+	struct dpll_pin *pin = info->user_ptr[0];
+
+	mutex_unlock(&pin->domain->lock);
 	mutex_unlock(&dpll_lock);
 }
-- 
2.56.0

