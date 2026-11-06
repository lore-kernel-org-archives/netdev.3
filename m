Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793967048;
	b=rs+w54ucAYZf2Vyn+hd2B7ijjXnX3cNYBT1iZMXtOrKnpq0i3BVQR/rvlhQ5qLxklNcG
	 H2dqsZUz877u56oHGdMhtNOIhm+dM7/vKXzCirkkSSkAp/uZWp47nrEiPkMDjp+Uz5H+L
	 ql9skJseyX3w1lzuyECRthOJam4mO3j7uWLRiRKupwT1XFwsxxL3N57yioTAx7DC8rtPg
	 u5NF2+btUnBcnzphmQEVdokz6Sea4mpcLmre2FpG0Zj55bMsuvyBx6gnUdSCG2sIpMVXJ
	 r8gkqGrjwrFImKU0Bb2U/Cu3cqejS5NMxslFOrr57wnQwpR/B2fiKhjrUbzvoWE0UnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793967048;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=FPrz5nzve1zBtnElji4BauW4ex0IqNh9eMI6SKDae4Y=;
	b=pEA8RCXR3+TvIJeSbBSLM+jvw19MsubCt/yfdmPDU4g5UOZARJldwddUQn6M5Tr5EtuW
	 1doioIRsDJ6ind+D3PFd2wC1bH0tOuh4NT+zLYwtKiTubrjRhribkKM2Zj0aIPWKA+YxN
	 hJSNBO/gC9UueSXVULgFZLIA7k1YvAM8xdavb42QtZ6huzASLCuEVFODpTVIrROt4e33C
	 tIlsOsInMZc/DT7AHljAfvYyk5FHE1pvSivmZYHBQc+PmU78nqWAx6GMkSmaV0cez1K1K
	 3xF31XTijsUVetMXFdCJcxhq7INwZuqcjHrs8IQ2GCZwe6Nuxe5sfOJwMVysk/854Ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=G51z+f3g;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A73606A33E
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 12:10:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48A73606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=G51z+f3g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793967047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FPrz5nzve1zBtnElji4BauW4ex0IqNh9eMI6SKDae4Y=;
	b=G51z+f3gmjna0Gm8aVhb0uuIUAfDwFn2oAcP0UstP6sdnVDlmrMmYu+6sMLgXk9IPSWJI9
	B0Euw3DUU2OrwmXs3rrPkb7wadx+agWx74+Atx0ZPLlaPHWiWfpU/Y4B9JA/3e8AWP8nZ7
	NuTFElO+1JuCPn332bbgQz99DqDSUN4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-317-HaYKK88hPRGjTUyj_YGInA-1; Fri,
 06 Nov 2026 07:10:43 -0500
X-MC-Unique: HaYKK88hPRGjTUyj_YGInA-1
X-Mimecast-MFC-AGG-ID: HaYKK88hPRGjTUyj_YGInA_1793967040
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2B088180057E;
	Fri,  6 Nov 2026 12:10:40 +0000 (UTC)
Received: from ivecera-thinkpadp16vgen1.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0AF1718004D2;
	Fri,  6 Nov 2026 12:10:33 +0000 (UTC)
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
Subject: [PATCH net-next 04/10] dpll: take domain locks around driver callbacks
Date: Fri,  6 Nov 2026 13:09:59 +0100
Message-ID: <20261106121005.1327603-5-ivecera@redhat.com>
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

Hold the domain lock of the addressed object wherever driver callbacks can
run:

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

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/dpll_core.c    | 18 +++++----
 drivers/dpll/dpll_core.h    |  6 ++-
 drivers/dpll/dpll_netlink.c | 78 ++++++++++++++++++++++++++++---------
 3 files changed, 76 insertions(+), 26 deletions(-)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index d39c4905172f2d..dd09f528170994 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -520,7 +520,7 @@ dpll_device_registration_find(struct dpll_device *dpll,
  *
  * Make dpll device available for user space.
  *
- * Context: Acquires a lock (dpll_lock)
+ * Context: Acquires dpll_lock and the domain lock of @dpll
  * Return:
  * * 0 on success
  * * negative - error value
@@ -579,7 +579,7 @@ EXPORT_SYMBOL_GPL(dpll_device_register);
  *
  * Unregister device, make it unavailable for userspace.
  * Note: It does not free the memory
- * Context: Acquires a lock (dpll_lock)
+ * Context: Acquires dpll_lock and the domain lock of @dpll
  */
 void dpll_device_unregister(struct dpll_device *dpll,
 			    const struct dpll_device_ops *ops, void *priv)
@@ -928,7 +928,7 @@ __dpll_pin_register(struct dpll_device *dpll, struct dpll_pin *pin,
  * @ops: ops for a dpll pin ops
  * @priv: pointer to private information of owner
  *
- * Context: Acquires a lock (dpll_lock)
+ * Context: Acquires dpll_lock and domain locks
  * Return:
  * * 0 on success
  * * negative - error value
@@ -989,7 +989,9 @@ static void dpll_pin_ref_sync_pair_del(u32 ref_sync_pin_id)
 		ref_sync_pin = xa_load(&pin->ref_sync_pins, ref_sync_pin_id);
 		if (ref_sync_pin) {
 			xa_erase(&pin->ref_sync_pins, ref_sync_pin_id);
+			mutex_lock(&pin->domain->lock);
 			__dpll_pin_change_ntf(pin);
+			mutex_unlock(&pin->domain->lock);
 		}
 	}
 }
@@ -1016,7 +1018,7 @@ __dpll_pin_unregister(struct dpll_device *dpll, struct dpll_pin *pin,
  * @priv: pointer to private information of owner
  *
  * Note: It does not free the memory
- * Context: Acquires a lock (dpll_lock)
+ * Context: Acquires dpll_lock and domain locks
  */
 void dpll_pin_unregister(struct dpll_device *dpll, struct dpll_pin *pin,
 			 const struct dpll_pin_ops *ops, void *priv)
@@ -1042,7 +1044,7 @@ EXPORT_SYMBOL_GPL(dpll_pin_unregister);
  * Register a pin with a parent pin, create references between them and
  * between newly registered pin and dplls connected with a parent pin.
  *
- * Context: Acquires a lock (dpll_lock)
+ * Context: Acquires dpll_lock and domain locks
  * Return:
  * * 0 on success
  * * negative - error value
@@ -1099,7 +1101,7 @@ EXPORT_SYMBOL_GPL(dpll_pin_on_pin_register);
  * @ops: ops for a dpll pin
  * @priv: pointer to private information of owner
  *
- * Context: Acquires a lock (dpll_lock)
+ * Context: Acquires dpll_lock and domain locks
  * Note: It does not free the memory
  */
 void dpll_pin_on_pin_unregister(struct dpll_pin *parent, struct dpll_pin *pin,
@@ -1129,7 +1131,7 @@ EXPORT_SYMBOL_GPL(dpll_pin_on_pin_unregister);
  *
  * Once pins are paired, the user-space configuration of reference sync pair
  * is possible.
- * Context: Acquires a lock (dpll_lock)
+ * Context: Acquires dpll_lock and domain locks
  * Return:
  * * 0 on success
  * * negative - error value
@@ -1142,7 +1144,9 @@ int dpll_pin_ref_sync_pair_add(struct dpll_pin *pin,
 	mutex_lock(&dpll_lock);
 	ret = xa_insert(&pin->ref_sync_pins, ref_sync_pin->id,
 			ref_sync_pin, GFP_KERNEL);
+	mutex_lock(&pin->domain->lock);
 	__dpll_pin_change_ntf(pin);
+	mutex_unlock(&pin->domain->lock);
 	mutex_unlock(&dpll_lock);
 
 	return ret;
diff --git a/drivers/dpll/dpll_core.h b/drivers/dpll/dpll_core.h
index 6705e81bc11de9..630c5a1ca572c2 100644
--- a/drivers/dpll/dpll_core.h
+++ b/drivers/dpll/dpll_core.h
@@ -22,10 +22,14 @@
  * @clock_id:		clock_id of the objects in the domain
  * @module:		module of the objects in the domain
  * @refcount:		number of dpll devices and pins in the domain
- * @lock:		lock of the domain
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

