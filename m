Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793967055;
	b=Gz6wNUFL5LtqZrg84St96HPR56ucIAXNvCzr9sTEjtEaXwRDwYTaEbzZlARFwnAz67GH
	 rdoVplSQc8GQGKg+b9tCPXyHoCmHkr80ONilSGxWWq8mje1kWjS7HeOjxmzM809Q9LkTs
	 iT4qP9AFz2a+zQ9EEx1csvih7Khkw+cbsrtW1WkKlQoOgvVmeT9lOEBMXTsrVBtCDSUKY
	 UYgKl3SV2/fCpxftv00RPZzpq8CiL3WDW6SuoKOx5dDsMqKwjmnub25v9iCofsmGGmcpN
	 PNeE92yDvW6d1JUvD+J6MEoquhweXEMP/oQalzwzJjqavm0P5150iURDeh23RuR88RQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793967055;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=gI1o1qxSYBOaohnqk/YYE7iYx1Va0OR5pEWv8sulDCc=;
	b=RHkM4V2Btwh3s22YQKuLaRhEZW9ls9/Qab2nkxi+1OQVDr2cw9kD/pqR0wi/rousn5cH
	 F3k6jmQr3xgs8j9FgZ/sVSdrM4+f7KKOKEHodqfzX5qM4w1X0PdtkduJDoB9DvJN2xur/
	 sVp+yOZFK6vuYH6Gtn8J5HtvPio759KH+14D4Yay68n1J+tZCC8iy0lnO1x1qymBYc19W
	 N7YzyX3fXpw/qZzMh0giejJcO5NOp/3BbFzIWwIBuQQNwN4Jq9MkxFOpfhT88SBKJRnMq
	 49Pg2zZ1ys+IVS6pnqYEE4e5tojTfsq4E9/Fl1Vn8LEVKwPsebA1HlpEcJGeP9QCmvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KkWNWuVG;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6859F606D82D
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 12:10:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6859F606D82D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KkWNWuVG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793967053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gI1o1qxSYBOaohnqk/YYE7iYx1Va0OR5pEWv8sulDCc=;
	b=KkWNWuVGLshJLVK/K/hanrdrRfVO1N9XbZVlDbieneeJONVvR4QI1+DRCRz2Ew0X3yRbhD
	TAvM0uC+0VCFEJfQeXstXGXxVsBYH5WHfZi3bfYmdynuklHd1TxhwmJrzyCSx1155w006I
	4ZISs1TFPy+F+V4DXc6kh5s3owckb5o=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-257-d1T1LgwiOraQGBGyi4TU4w-1; Fri,
 06 Nov 2026 07:10:48 -0500
X-MC-Unique: d1T1LgwiOraQGBGyi4TU4w-1
X-Mimecast-MFC-AGG-ID: d1T1LgwiOraQGBGyi4TU4w_1793967046
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2C5571800607;
	Fri,  6 Nov 2026 12:10:46 +0000 (UTC)
Received: from ivecera-thinkpadp16vgen1.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 76DD5187C36C;
	Fri,  6 Nov 2026 12:10:40 +0000 (UTC)
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
Subject: [PATCH net-next 05/10] dpll: convert dpll_lock to rwsem
Date: Fri,  6 Nov 2026 13:10:00 +0100
Message-ID: <20261106121005.1327603-6-ivecera@redhat.com>
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

Driver callbacks are now serialized by domain locks, so dpll_lock only has
to protect the topology and lifetime of devices and pins.

Convert it to an rwsem. Core functions changing the topology take it for
write. Netlink requests, each part of a dump and change notifications take
it for read, for their whole duration, so objects found by a lookup stay
valid. This is the patch that lets callbacks of different domains run
concurrently.

A callback running for long still blocks topology changes, and a waiting
writer blocks new readers, so a stuck callback stalls the subsystem while
a device is being probed or removed. This is no worse than the global
serialization it replaces.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/dpll_core.c    | 93 +++++++++++++++++--------------------
 drivers/dpll/dpll_core.h    |  3 +-
 drivers/dpll/dpll_netlink.c | 32 ++++++-------
 3 files changed, 61 insertions(+), 67 deletions(-)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index dd09f528170994..8eb74682343156 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -19,8 +19,12 @@
 #include "dpll_core.h"
 #include "dpll_netlink.h"
 
-/* Mutex lock to protect DPLL subsystem devices and pins */
-DEFINE_MUTEX(dpll_lock);
+/* Protects the topology and lifetime of DPLL devices and pins. Taken for write
+ * to change them and for read for the whole netlink request, part of a dump or
+ * change notification that uses them. Driver callbacks are serialized by domain
+ * locks, which are only taken under this lock.
+ */
+DECLARE_RWSEM(dpll_lock);
 
 DEFINE_XARRAY_FLAGS(dpll_device_xa, XA_FLAGS_ALLOC);
 DEFINE_XARRAY_FLAGS(dpll_pin_xa, XA_FLAGS_ALLOC);
@@ -459,7 +463,7 @@ dpll_device_get(u64 clock_id, u32 device_idx, struct module *module,
 	struct dpll_device *dpll, *ret = NULL;
 	unsigned long index;
 
-	mutex_lock(&dpll_lock);
+	down_write(&dpll_lock);
 	xa_for_each(&dpll_device_xa, index, dpll) {
 		if (dpll->clock_id == clock_id &&
 		    dpll->device_idx == device_idx &&
@@ -475,7 +479,7 @@ dpll_device_get(u64 clock_id, u32 device_idx, struct module *module,
 			dpll_device_tracker_alloc(ret, tracker);
 	}
 
-	mutex_unlock(&dpll_lock);
+	up_write(&dpll_lock);
 
 	return ret;
 }
@@ -492,9 +496,9 @@ EXPORT_SYMBOL_GPL(dpll_device_get);
  */
 void dpll_device_put(struct dpll_device *dpll, dpll_tracker *tracker)
 {
-	mutex_lock(&dpll_lock);
+	down_write(&dpll_lock);
 	__dpll_device_put(dpll, tracker);
-	mutex_unlock(&dpll_lock);
+	up_write(&dpll_lock);
 }
 EXPORT_SYMBOL_GPL(dpll_device_put);
 
@@ -540,16 +544,16 @@ int dpll_device_register(struct dpll_device *dpll, enum dpll_type type,
 	if (WARN_ON(type < DPLL_TYPE_PPS || type > DPLL_TYPE_MAX))
 		return -EINVAL;
 
-	mutex_lock(&dpll_lock);
+	down_write(&dpll_lock);
 	reg = dpll_device_registration_find(dpll, ops, priv);
 	if (reg) {
-		mutex_unlock(&dpll_lock);
+		up_write(&dpll_lock);
 		return -EEXIST;
 	}
 
 	reg = kzalloc_obj(*reg);
 	if (!reg) {
-		mutex_unlock(&dpll_lock);
+		up_write(&dpll_lock);
 		return -ENOMEM;
 	}
 	reg->ops = ops;
@@ -559,13 +563,13 @@ int dpll_device_register(struct dpll_device *dpll, enum dpll_type type,
 	first_registration = list_empty(&dpll->registration_list);
 	list_add_tail(&reg->list, &dpll->registration_list);
 	if (!first_registration) {
-		mutex_unlock(&dpll_lock);
+		up_write(&dpll_lock);
 		return 0;
 	}
 
 	xa_set_mark(&dpll_device_xa, dpll->id, DPLL_REGISTERED);
 	dpll_device_create_ntf(dpll);
-	mutex_unlock(&dpll_lock);
+	up_write(&dpll_lock);
 
 	return 0;
 }
@@ -586,12 +590,12 @@ void dpll_device_unregister(struct dpll_device *dpll,
 {
 	struct dpll_device_registration *reg;
 
-	mutex_lock(&dpll_lock);
+	down_write(&dpll_lock);
 	ASSERT_DPLL_REGISTERED(dpll);
 	dpll_device_delete_ntf(dpll);
 	reg = dpll_device_registration_find(dpll, ops, priv);
 	if (WARN_ON(!reg)) {
-		mutex_unlock(&dpll_lock);
+		up_write(&dpll_lock);
 		return;
 	}
 	list_del(&reg->list);
@@ -599,11 +603,11 @@ void dpll_device_unregister(struct dpll_device *dpll,
 	kfree(reg);
 
 	if (!list_empty(&dpll->registration_list)) {
-		mutex_unlock(&dpll_lock);
+		up_write(&dpll_lock);
 		return;
 	}
 	xa_clear_mark(&dpll_device_xa, dpll->id, DPLL_REGISTERED);
-	mutex_unlock(&dpll_lock);
+	up_write(&dpll_lock);
 }
 EXPORT_SYMBOL_GPL(dpll_device_unregister);
 
@@ -771,9 +775,9 @@ int register_dpll_notifier(struct notifier_block *nb)
 {
 	int ret;
 
-	mutex_lock(&dpll_lock);
+	down_write(&dpll_lock);
 	ret = raw_notifier_chain_register(&dpll_notifier_chain, nb);
-	mutex_unlock(&dpll_lock);
+	up_write(&dpll_lock);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(register_dpll_notifier);
@@ -782,9 +786,9 @@ int unregister_dpll_notifier(struct notifier_block *nb)
 {
 	int ret;
 
-	mutex_lock(&dpll_lock);
+	down_write(&dpll_lock);
 	ret = raw_notifier_chain_unregister(&dpll_notifier_chain, nb);
-	mutex_unlock(&dpll_lock);
+	up_write(&dpll_lock);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(unregister_dpll_notifier);
@@ -812,7 +816,7 @@ dpll_pin_get(u64 clock_id, u32 pin_idx, struct module *module,
 	struct dpll_pin *pos, *ret = NULL;
 	unsigned long i;
 
-	mutex_lock(&dpll_lock);
+	down_write(&dpll_lock);
 	xa_for_each(&dpll_pin_xa, i, pos) {
 		if (pos->clock_id == clock_id &&
 		    pos->pin_idx == pin_idx &&
@@ -827,7 +831,7 @@ dpll_pin_get(u64 clock_id, u32 pin_idx, struct module *module,
 		if (!IS_ERR(ret))
 			dpll_pin_tracker_alloc(ret, tracker);
 	}
-	mutex_unlock(&dpll_lock);
+	up_write(&dpll_lock);
 
 	return ret;
 }
@@ -844,9 +848,9 @@ EXPORT_SYMBOL_GPL(dpll_pin_get);
  */
 void dpll_pin_put(struct dpll_pin *pin, dpll_tracker *tracker)
 {
-	mutex_lock(&dpll_lock);
+	down_write(&dpll_lock);
 	__dpll_pin_put(pin, tracker);
-	mutex_unlock(&dpll_lock);
+	up_write(&dpll_lock);
 }
 EXPORT_SYMBOL_GPL(dpll_pin_put);
 
@@ -859,10 +863,10 @@ EXPORT_SYMBOL_GPL(dpll_pin_put);
  */
 void dpll_pin_fwnode_set(struct dpll_pin *pin, struct fwnode_handle *fwnode)
 {
-	mutex_lock(&dpll_lock);
+	down_write(&dpll_lock);
 	fwnode_handle_put(pin->fwnode); /* Drop fwnode previously set */
 	pin->fwnode = fwnode_handle_get(fwnode);
-	mutex_unlock(&dpll_lock);
+	up_write(&dpll_lock);
 }
 EXPORT_SYMBOL_GPL(dpll_pin_fwnode_set);
 
@@ -885,7 +889,7 @@ struct dpll_pin *fwnode_dpll_pin_find(struct fwnode_handle *fwnode,
 	struct dpll_pin *pin, *ret = NULL;
 	unsigned long index;
 
-	mutex_lock(&dpll_lock);
+	down_write(&dpll_lock);
 	xa_for_each(&dpll_pin_xa, index, pin) {
 		if (pin->fwnode == fwnode) {
 			__dpll_pin_hold(pin, tracker);
@@ -893,7 +897,7 @@ struct dpll_pin *fwnode_dpll_pin_find(struct fwnode_handle *fwnode,
 			break;
 		}
 	}
-	mutex_unlock(&dpll_lock);
+	up_write(&dpll_lock);
 
 	return ret;
 }
@@ -950,7 +954,7 @@ dpll_pin_register(struct dpll_device *dpll, struct dpll_pin *pin,
 		      DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE)))
 		return -EINVAL;
 
-	mutex_lock(&dpll_lock);
+	down_write(&dpll_lock);
 
 	dev_ops = dpll_device_ops(dpll);
 	if (WARN_ON(ops->measured_freq_get &&
@@ -974,7 +978,7 @@ dpll_pin_register(struct dpll_device *dpll, struct dpll_pin *pin,
 
 	ret = __dpll_pin_register(dpll, pin, ops, priv, NULL);
 out_unlock:
-	mutex_unlock(&dpll_lock);
+	up_write(&dpll_lock);
 
 	return ret;
 }
@@ -1028,9 +1032,9 @@ void dpll_pin_unregister(struct dpll_device *dpll, struct dpll_pin *pin,
 	if (WARN_ON(!xa_empty(&pin->parent_refs)))
 		return;
 
-	mutex_lock(&dpll_lock);
+	down_write(&dpll_lock);
 	__dpll_pin_unregister(dpll, pin, ops, priv, NULL);
-	mutex_unlock(&dpll_lock);
+	up_write(&dpll_lock);
 }
 EXPORT_SYMBOL_GPL(dpll_pin_unregister);
 
@@ -1064,7 +1068,7 @@ int dpll_pin_on_pin_register(struct dpll_pin *parent, struct dpll_pin *pin,
 	    WARN_ON(!ops->direction_get))
 		return -EINVAL;
 
-	mutex_lock(&dpll_lock);
+	down_write(&dpll_lock);
 	ret = dpll_xa_ref_pin_add(&pin->parent_refs, parent, ops, priv, pin);
 	if (ret)
 		goto unlock;
@@ -1076,7 +1080,7 @@ int dpll_pin_on_pin_register(struct dpll_pin *parent, struct dpll_pin *pin,
 		}
 		dpll_pin_create_ntf(pin, parent->clock_id);
 	}
-	mutex_unlock(&dpll_lock);
+	up_write(&dpll_lock);
 
 	return ret;
 
@@ -1089,7 +1093,7 @@ int dpll_pin_on_pin_register(struct dpll_pin *parent, struct dpll_pin *pin,
 		}
 	dpll_xa_ref_pin_del(&pin->parent_refs, parent, ops, priv, pin);
 unlock:
-	mutex_unlock(&dpll_lock);
+	up_write(&dpll_lock);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(dpll_pin_on_pin_register);
@@ -1111,7 +1115,7 @@ void dpll_pin_on_pin_unregister(struct dpll_pin *parent, struct dpll_pin *pin,
 	struct dpll_pin_ref *ref;
 	unsigned long i;
 
-	mutex_lock(&dpll_lock);
+	down_write(&dpll_lock);
 	xa_for_each(&pin->dpll_refs, i, ref) {
 		reg = dpll_pin_registration_find(ref, ops, priv, parent);
 		if (!reg)
@@ -1120,7 +1124,7 @@ void dpll_pin_on_pin_unregister(struct dpll_pin *parent, struct dpll_pin *pin,
 		__dpll_pin_unregister(ref->dpll, pin, ops, priv, parent);
 	}
 	dpll_xa_ref_pin_del(&pin->parent_refs, parent, ops, priv, pin);
-	mutex_unlock(&dpll_lock);
+	up_write(&dpll_lock);
 }
 EXPORT_SYMBOL_GPL(dpll_pin_on_pin_unregister);
 
@@ -1141,13 +1145,13 @@ int dpll_pin_ref_sync_pair_add(struct dpll_pin *pin,
 {
 	int ret;
 
-	mutex_lock(&dpll_lock);
+	down_write(&dpll_lock);
 	ret = xa_insert(&pin->ref_sync_pins, ref_sync_pin->id,
 			ref_sync_pin, GFP_KERNEL);
 	mutex_lock(&pin->domain->lock);
 	__dpll_pin_change_ntf(pin);
 	mutex_unlock(&pin->domain->lock);
-	mutex_unlock(&dpll_lock);
+	up_write(&dpll_lock);
 
 	return ret;
 }
@@ -1254,23 +1258,12 @@ const struct dpll_pin_ops *dpll_pin_ops(struct dpll_pin_ref *ref)
 
 static int __init dpll_init(void)
 {
-	int ret;
-
-	ret = genl_register_family(&dpll_nl_family);
-	if (ret)
-		goto error;
-
-	return 0;
-
-error:
-	mutex_destroy(&dpll_lock);
-	return ret;
+	return genl_register_family(&dpll_nl_family);
 }
 
 static void __exit dpll_exit(void)
 {
 	genl_unregister_family(&dpll_nl_family);
-	mutex_destroy(&dpll_lock);
 }
 
 subsys_initcall(dpll_init);
diff --git a/drivers/dpll/dpll_core.h b/drivers/dpll/dpll_core.h
index 630c5a1ca572c2..e212e53528e33b 100644
--- a/drivers/dpll/dpll_core.h
+++ b/drivers/dpll/dpll_core.h
@@ -12,6 +12,7 @@
 #include <linux/mutex.h>
 #include <linux/refcount.h>
 #include <linux/ref_tracker.h>
+#include <linux/rwsem.h>
 #include "dpll_nl.h"
 
 #define DPLL_REGISTERED		XA_MARK_1
@@ -129,7 +130,7 @@ const struct dpll_pin_ops *dpll_pin_ops(struct dpll_pin_ref *ref);
 struct dpll_pin_ref *dpll_xa_ref_dpll_first(struct xarray *xa_refs);
 extern struct xarray dpll_device_xa;
 extern struct xarray dpll_pin_xa;
-extern struct mutex dpll_lock;
+extern struct rw_semaphore dpll_lock;
 
 void dpll_device_notify(struct dpll_device *dpll, unsigned long action);
 void dpll_pin_notify(struct dpll_pin *pin, u64 src_clock_id,
diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index 1b4e3a0166a744..9d8f5d1ce97248 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -910,11 +910,11 @@ int dpll_device_change_ntf(struct dpll_device *dpll)
 {
 	int ret;
 
-	mutex_lock(&dpll_lock);
+	down_read(&dpll_lock);
 	mutex_lock(&dpll->domain->lock);
 	ret = __dpll_device_change_ntf(dpll);
 	mutex_unlock(&dpll->domain->lock);
-	mutex_unlock(&dpll_lock);
+	up_read(&dpll_lock);
 
 	return ret;
 }
@@ -1004,11 +1004,11 @@ int dpll_pin_change_ntf(struct dpll_pin *pin)
 {
 	int ret;
 
-	mutex_lock(&dpll_lock);
+	down_read(&dpll_lock);
 	mutex_lock(&pin->domain->lock);
 	ret = __dpll_pin_change_ntf(pin);
 	mutex_unlock(&pin->domain->lock);
-	mutex_unlock(&dpll_lock);
+	up_read(&dpll_lock);
 
 	return ret;
 }
@@ -1795,7 +1795,7 @@ int dpll_nl_pin_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 	unsigned long i;
 	int ret = 0;
 
-	mutex_lock(&dpll_lock);
+	down_read(&dpll_lock);
 	xa_for_each_marked_start(&dpll_pin_xa, i, pin, DPLL_REGISTERED,
 				 ctx->idx) {
 		if (!dpll_pin_available(pin))
@@ -1821,7 +1821,7 @@ int dpll_nl_pin_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 		}
 		genlmsg_end(skb, hdr);
 	}
-	mutex_unlock(&dpll_lock);
+	up_read(&dpll_lock);
 
 	if (ret == -EMSGSIZE) {
 		ctx->idx = i;
@@ -2019,7 +2019,7 @@ int dpll_nl_device_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 	unsigned long i;
 	int ret = 0;
 
-	mutex_lock(&dpll_lock);
+	down_read(&dpll_lock);
 	xa_for_each_marked_start(&dpll_device_xa, i, dpll, DPLL_REGISTERED,
 				 ctx->idx) {
 		hdr = genlmsg_put(skb, NETLINK_CB(cb->skb).portid,
@@ -2038,7 +2038,7 @@ int dpll_nl_device_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 		}
 		genlmsg_end(skb, hdr);
 	}
-	mutex_unlock(&dpll_lock);
+	up_read(&dpll_lock);
 
 	if (ret == -EMSGSIZE) {
 		ctx->idx = i;
@@ -2056,7 +2056,7 @@ int dpll_pre_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
 	if (GENL_REQ_ATTR_CHECK(info, DPLL_A_ID))
 		return -EINVAL;
 
-	mutex_lock(&dpll_lock);
+	down_read(&dpll_lock);
 	id = nla_get_u32(info->attrs[DPLL_A_ID]);
 	dpll = dpll_device_get_by_id(id);
 	if (!dpll) {
@@ -2067,7 +2067,7 @@ int dpll_pre_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
 	mutex_lock(&dpll->domain->lock);
 	return 0;
 unlock:
-	mutex_unlock(&dpll_lock);
+	up_read(&dpll_lock);
 	return -ENODEV;
 }
 
@@ -2077,14 +2077,14 @@ void dpll_post_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
 	struct dpll_device *dpll = info->user_ptr[0];
 
 	mutex_unlock(&dpll->domain->lock);
-	mutex_unlock(&dpll_lock);
+	up_read(&dpll_lock);
 }
 
 int
 dpll_lock_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
 	       struct genl_info *info)
 {
-	mutex_lock(&dpll_lock);
+	down_read(&dpll_lock);
 
 	return 0;
 }
@@ -2093,7 +2093,7 @@ void
 dpll_unlock_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
 		 struct genl_info *info)
 {
-	mutex_unlock(&dpll_lock);
+	up_read(&dpll_lock);
 }
 
 int dpll_pin_pre_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
@@ -2102,7 +2102,7 @@ int dpll_pin_pre_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
 	struct dpll_pin *pin;
 	int ret;
 
-	mutex_lock(&dpll_lock);
+	down_read(&dpll_lock);
 	if (GENL_REQ_ATTR_CHECK(info, DPLL_A_PIN_ID)) {
 		ret = -EINVAL;
 		goto unlock_dev;
@@ -2119,7 +2119,7 @@ int dpll_pin_pre_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
 	return 0;
 
 unlock_dev:
-	mutex_unlock(&dpll_lock);
+	up_read(&dpll_lock);
 	return ret;
 }
 
@@ -2129,5 +2129,5 @@ void dpll_pin_post_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
 	struct dpll_pin *pin = info->user_ptr[0];
 
 	mutex_unlock(&pin->domain->lock);
-	mutex_unlock(&dpll_lock);
+	up_read(&dpll_lock);
 }
-- 
2.56.0

