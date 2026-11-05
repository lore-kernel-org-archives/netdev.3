Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793884322;
	b=fc8gJ5Fqfbz2Ptx+jw2GBEbffe6RO+Qni6aRCYdkolb2gio5MG56hyRHxiDXmgXwh2Dj
	 zsm9qZhwtsv8XnoFzgRdNt6ceHteT+A5CICqBFCVXsojxhx0DLnXPQv8SdmJ1RT3bWePM
	 zupfpI8tNZq5LxqUp8w07Q2ElyfKByik46xZken61e1Qstg8MJn1Z7RD6Ml+p48dvW06J
	 wbJodqfOrY6a1DqzYE0Qn05dj1ktVVqzHuEieeb/da3kRcetnLAzYMpFeQuvJ0UMaL1WK
	 aU7tBKu3OK9EXPcV9HZ1bBYdfZkkBEcGiYUCO9ULeg58jD+60OftObKIWe7nlhbtutg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793884322;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=KJV2aHAxzTmAKp975nj65lhactQVP8SqboMoofJcno8=;
	b=XsKDrDflFJlPGzFGpkzyqTKcVXrsM9rYvqrxUKq5wil+hnvb4OsNF37T5VLYQs0I2dAP
	 Xr/hRnx2/MSyxtkV1o9Lal//k8AuZD7s0fYxp4Ir7zARw2BVq+D9nnt96WMfu9BFpJ4oC
	 ugsjgS0pUuefnXPcM3BNBX0vO920xwrFEeNr1YTn4mCkJNWDXFcEuFLtRCRlyaCvAHoSP
	 YLfw/WehH6Ok14LI/KVSlFdC2d98URo5HSLKKh7iYNgOQrh3C8Nn3mm1p4KTvETOeuC2t
	 c/d0d238BJ2CpwpfiOpcKsh9eviygZ4/3uZm1o22STkjNLk1hGHR9H3g+I7EJFEliwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aGElijva;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C10E606EEBA
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 13:12:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C10E606EEBA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aGElijva
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793884321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KJV2aHAxzTmAKp975nj65lhactQVP8SqboMoofJcno8=;
	b=aGElijvaUmnydLRyOIwgCPV2jxX0lYjcU9K2gEncWMK12fz49uZDGrJ9SHXr3uhgBoi3Xu
	Se0KWJkFbRwDya5CN90AvOchP9IegpkWzQwz7FCz28H7KWQSXAFFS7OIM4ht2WS2We+crP
	W+o3phpa5VeG9ON63nolT44WnOHX5Iw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-mNrQH3EmMlGkOfsxp8w4DQ-1; Thu,
 05 Nov 2026 08:11:57 -0500
X-MC-Unique: mNrQH3EmMlGkOfsxp8w4DQ-1
X-Mimecast-MFC-AGG-ID: mNrQH3EmMlGkOfsxp8w4DQ_1793884316
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2F0491800555;
	Thu,  5 Nov 2026 13:11:56 +0000 (UTC)
Received: from ivecera-thinkpadp16vgen1.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1C6A03001DA3;
	Thu,  5 Nov 2026 13:11:52 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Milena Olech <milena.olech@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Michal Michalik <michal.michalik@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 2/2] dpll: report dumps interrupted by topology changes
Date: Thu,  5 Nov 2026 14:11:45 +0100
Message-ID: <20261105131145.1010406-3-ivecera@redhat.com>
In-Reply-To: <20261105131145.1010406-1-ivecera@redhat.com>
References: <20261105131145.1010406-1-ivecera@redhat.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Pin and device dumps release dpll_lock between parts and resume from the
id saved by the previous part. An object registered in between is missed
if its id is below that one, as is the case for an object allocated
before the dump started. User space gets an incomplete dump and has no
way to tell.

Count registrations and unregistrations in a generation counter and pass
it to genl_dump_check_consistent() to set NLM_F_DUMP_INTR. Check it only
after a message is built, a cancelled message would consume the change.

Found by code review. Reproduced with a test module registering a device
or a pin with a low id between parts of a raw netlink dump: the object was
missing and no message had the flag set. With this patch the flag is set
when an object is registered or unregistered during a dump, and is not
set on dumps without such a change. Tested in QEMU and on a ZL30732A
board, where unbinding the driver during a dump sets the flag as well.

Fixes: 9d71b54b65b1 ("dpll: netlink: Add DPLL framework base functions")
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/dpll_core.c    | 19 +++++++++++++++++++
 drivers/dpll/dpll_core.h    |  1 +
 drivers/dpll/dpll_netlink.c |  4 ++++
 3 files changed, 24 insertions(+)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index 277692d12d3d1e..a68e8f5b609db8 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -22,6 +22,12 @@
 /* Mutex lock to protect DPLL subsystem devices and pins */
 DEFINE_MUTEX(dpll_lock);
 
+/* Changes with the topology of devices and pins, so that netlink dumps can
+ * detect it. Never 0, as netlink takes that for no sequence. Protected by
+ * dpll_lock.
+ */
+unsigned int dpll_generation = 1;
+
 DEFINE_XARRAY_FLAGS(dpll_device_xa, XA_FLAGS_ALLOC);
 DEFINE_XARRAY_FLAGS(dpll_pin_xa, XA_FLAGS_ALLOC);
 
@@ -53,6 +59,13 @@ struct dpll_pin_registration {
 	dpll_tracker tracker;
 };
 
+static void dpll_generation_inc(void)
+{
+	lockdep_assert_held(&dpll_lock);
+	while (++dpll_generation == 0)
+		;
+}
+
 static int call_dpll_notifiers(unsigned long action, void *info)
 {
 	lockdep_assert_held(&dpll_lock);
@@ -510,6 +523,7 @@ int dpll_device_register(struct dpll_device *dpll, enum dpll_type type,
 	}
 
 	xa_set_mark(&dpll_device_xa, dpll->id, DPLL_REGISTERED);
+	dpll_generation_inc();
 	dpll_device_create_ntf(dpll);
 	mutex_unlock(&dpll_lock);
 
@@ -549,6 +563,7 @@ void dpll_device_unregister(struct dpll_device *dpll,
 		return;
 	}
 	xa_clear_mark(&dpll_device_xa, dpll->id, DPLL_REGISTERED);
+	dpll_generation_inc();
 	mutex_unlock(&dpll_lock);
 }
 EXPORT_SYMBOL_GPL(dpll_device_unregister);
@@ -851,6 +866,7 @@ __dpll_pin_register(struct dpll_device *dpll, struct dpll_pin *pin,
 	if (ret)
 		goto ref_pin_del;
 	xa_set_mark(&dpll_pin_xa, pin->id, DPLL_REGISTERED);
+	dpll_generation_inc();
 	dpll_pin_create_ntf(pin, dpll->clock_id);
 
 	return ret;
@@ -941,6 +957,7 @@ __dpll_pin_unregister(struct dpll_device *dpll, struct dpll_pin *pin,
 	dpll_pin_delete_ntf(pin, dpll->clock_id);
 	dpll_xa_ref_pin_del(&dpll->pin_refs, pin, ops, priv, cookie);
 	dpll_xa_ref_dpll_del(&pin->dpll_refs, dpll, ops, priv, cookie);
+	dpll_generation_inc();
 	if (xa_empty(&pin->dpll_refs)) {
 		dpll_pin_ref_sync_pair_del(pin->id);
 		xa_clear_mark(&dpll_pin_xa, pin->id, DPLL_REGISTERED);
@@ -1005,6 +1022,7 @@ int dpll_pin_on_pin_register(struct dpll_pin *parent, struct dpll_pin *pin,
 	ret = dpll_xa_ref_pin_add(&pin->parent_refs, parent, ops, priv, pin);
 	if (ret)
 		goto unlock;
+	dpll_generation_inc();
 	xa_for_each(&parent->dpll_refs, i, ref) {
 		ret = __dpll_pin_register(ref->dpll, pin, ops, priv, parent);
 		if (ret) {
@@ -1057,6 +1075,7 @@ void dpll_pin_on_pin_unregister(struct dpll_pin *parent, struct dpll_pin *pin,
 		__dpll_pin_unregister(ref->dpll, pin, ops, priv, parent);
 	}
 	dpll_xa_ref_pin_del(&pin->parent_refs, parent, ops, priv, pin);
+	dpll_generation_inc();
 	mutex_unlock(&dpll_lock);
 }
 EXPORT_SYMBOL_GPL(dpll_pin_on_pin_unregister);
diff --git a/drivers/dpll/dpll_core.h b/drivers/dpll/dpll_core.h
index da8a369556ed11..c2ed0926de1b95 100644
--- a/drivers/dpll/dpll_core.h
+++ b/drivers/dpll/dpll_core.h
@@ -99,6 +99,7 @@ struct dpll_pin_ref *dpll_xa_ref_dpll_first(struct xarray *xa_refs);
 extern struct xarray dpll_device_xa;
 extern struct xarray dpll_pin_xa;
 extern struct mutex dpll_lock;
+extern unsigned int dpll_generation;
 
 void dpll_device_notify(struct dpll_device *dpll, unsigned long action);
 void dpll_pin_notify(struct dpll_pin *pin, u64 src_clock_id,
diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index e5380d95f238b3..87c8caef0f574b 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -1768,6 +1768,7 @@ int dpll_nl_pin_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 	int ret = 0;
 
 	mutex_lock(&dpll_lock);
+	cb->seq = dpll_generation;
 	xa_for_each_marked_start(&dpll_pin_xa, i, pin, DPLL_REGISTERED,
 				 ctx->idx) {
 		if (!dpll_pin_available(pin))
@@ -1789,6 +1790,7 @@ int dpll_nl_pin_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 			}
 			break;
 		}
+		genl_dump_check_consistent(cb, hdr);
 		genlmsg_end(skb, hdr);
 	}
 	mutex_unlock(&dpll_lock);
@@ -1990,6 +1992,7 @@ int dpll_nl_device_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 	int ret = 0;
 
 	mutex_lock(&dpll_lock);
+	cb->seq = dpll_generation;
 	xa_for_each_marked_start(&dpll_device_xa, i, dpll, DPLL_REGISTERED,
 				 ctx->idx) {
 		hdr = genlmsg_put(skb, NETLINK_CB(cb->skb).portid,
@@ -2004,6 +2007,7 @@ int dpll_nl_device_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 			genlmsg_cancel(skb, hdr);
 			break;
 		}
+		genl_dump_check_consistent(cb, hdr);
 		genlmsg_end(skb, hdr);
 	}
 	mutex_unlock(&dpll_lock);
-- 
2.56.0

