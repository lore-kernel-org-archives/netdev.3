Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794320176;
	b=U1E7tVLyiDGlLIqlQRQhovcK2Tg7yP93PwEEa5rI3vSm5SWp7ocPmqC48wNuDDXa2Ze5
	 ZLGMPPAdInUL+xhZxETTVYnkBnz3QFlh224IBwxxsW4CnpWMv5xpe/Kkhl4nJ34b6mrtg
	 Y6xrPx1YOTqCaGzR/8YCeQG+eKJF+73L42k0UPVJ0Gzgxm1EsUhZJJx9ICEWF/eCIY6zL
	 sUxIhPau8bu6EpV4bfsFmEVdvWLrfUMMBN1U9sVC7y+nFPQrHyePswfxUo3A8HnKe+f4E
	 6lqgjdf5JPqRNQaYBviFlbQeI18RSjT19hGizJJg/6GB3gNwWnv+XZrm5UXWESs3l4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794320176;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=izSUfxKd6dpHrZ2HluV6tGvbB14A6G9yE/pB2+OCf8g=;
	b=j4XE2dCzLPDxZZgf1ke7ffeYVbjoz8Mvi1Bg75TcWoRyKxg0QDGw4MxKO1rtpSbEwGzv
	 LnzJtICoXzANjw6SQTe0Dc32kRO96K1+IYeawFDJ5KQCgWwJl+TbsSYI/ot8oBm1VVtno
	 65Bzeqh9q9oCY+gTffhutfJbjVISm29pxlpIHbs10RzqZY1CJ8N75QZo10zLeXD6zTWjR
	 wjb8AtCiqunU+anrFKMdcP9uoWdjuZUHFI5+81dw+BZSxklKLWtqVt3tpZyV2pnuKXNbi
	 vHNjHT2McEG/a2TWvsJoIAfFMrz9d89C+bI2TWenruiBAXa/nxBM55/zgoueT/wmr3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ElPj3a1n;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5C760A2621
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 14:16:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B5C760A2621
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ElPj3a1n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794320175; x=1825856175;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k5Jwp5jS5CKa8GO7E0EUouk8YBhlJ1hq55LDY4GsRm0=;
  b=ElPj3a1nGFouol41mEG20peLMg3U9+DrqHRmxIO2qEUDfXwtXt2rokGn
   XjrCIdLsl6UJKLiCXB48VFmQLabRUTVczqOTwUQDXBNr8uFveADqH92ez
   PW+QPD0/Nxs+Mkt1eAD4K8Uo0t3bzx0PyFIYiOhGnyytK87kKUqc1EQL+
   fRUV+3FIUKFQ5aT1lkCBZL+B702ZGNnv7Oek6DXKEgRo0WVXd69LH6ob3
   CjejslkX2wS5dtJl+BVEHGZ6ENOfIkmSyBMuEqcevxZxp9FY8TRlJPtVr
   +zeEK8LhK1ddyjTvmnMhP/BWEY8MBzxXO8izmu02icC7D1pGDkPrGofIa
   g==;
X-CSE-ConnectionGUID: AEm/BRcDR92yN0XHpcijZw==
X-CSE-MsgGUID: P9mRluaZQDy+oxfbkauSYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="3091223"
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="3091223"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 06:16:15 -0800
X-CSE-ConnectionGUID: Yy9r+N9dQpu/JcWf1qyVig==
X-CSE-MsgGUID: Ed+MeENWS+mCw5tLZ2QwyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="8327672"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa003.fm.intel.com with ESMTP; 10 Nov 2026 06:16:10 -0800
Received: from pkitszel-desk.tendawifi.com (unknown [10.245.244.251])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 5E0652FC5F;
	Tue, 10 Nov 2026 14:16:08 +0000 (GMT)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Michal Schmidt <mschmidt@redhat.com>,
	edumazet@kernel.org,
	horms@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	andrew+netdev@lunn.ch,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	leon@kernel.org,
	mbloch@nvidia.com,
	jacob.e.keller@intel.com,
	jedrzej.jagielski@intel.com,
	anzaki@gmail.com,
	brett.creeley@amd.com,
	ohartoov@nvidia.com,
	Petr Oros <poros@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next v5 14/15] devlink: add devlink_alloc_drv()
Date: Tue, 10 Nov 2026 15:07:23 +0100
Message-ID: <20261110141534.95614-15-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20261110141534.95614-1-przemyslaw.kitszel@intel.com>
References: <20261110141534.95614-1-przemyslaw.kitszel@intel.com>
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

devlink_alloc() records the driver bound to @dev at the time of the
call as the owner of the new instance. That fits the common case of
a driver creating an instance for the device it is bound to, but not
a PF driver that creates instances for its VFs, as the VF device could
be:
 * not bound to any driver yet (VF driver not loaded, or
   sriov_drivers_autoprobe disabled), what triggers the WARN_ON() in
   __devlink_alloc();
 * bound to another driver (VF driver, or vfio-pci), which could be
   unloaded while the instance is still registered, leaving the stored
   driver pointer dangling (it is used to report the driver name in
   devlink dev info).

Add devlink_alloc_drv(), a variant of devlink_alloc() that takes the
owning driver explicitly, as devlink_shd_get() already does.

The first user is ice, in the next patch, which creates a devlink
instance for each of its VFs.

Such an instance reports the owning driver in devlink dev info, not the
one bound to the device in sysfs. Document that in devlink-info.rst.

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
v5:
 * document @drv lifetime and device lock rules in kernel-doc (me)

v4:
 * document in devlink-info.rst that an instance created for another
   device reports the name of the creating driver (Sashiko)

v3:
 * new patch
---
 .../networking/devlink/devlink-info.rst       |  2 ++
 include/net/devlink.h                         |  4 ++++
 net/devlink/core.c                            | 24 +++++++++++++++++++
 3 files changed, 30 insertions(+)

diff --git a/Documentation/networking/devlink/devlink-info.rst b/Documentation/networking/devlink/devlink-info.rst
index dd6adc4d0559..7ac5625e2934 100644
--- a/Documentation/networking/devlink/devlink-info.rst
+++ b/Documentation/networking/devlink/devlink-info.rst
@@ -25,6 +25,8 @@ versions is generally discouraged - here, and via any other Linux API.
      - Description
    * - ``driver``
      - Name of the currently used device driver, also available through sysfs.
+       For an instance that a driver creates for another device, e.g. a PF
+       driver for its VFs, the name of the creating driver.
 
    * - ``serial_number``
      - Serial number of the device.
diff --git a/include/net/devlink.h b/include/net/devlink.h
index d01128ef393d..5c90edf9a92d 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -1693,6 +1693,10 @@ static inline struct devlink *devlink_alloc(const struct devlink_ops *ops,
 	return devlink_alloc_ns(ops, priv_size, &init_net, dev);
 }
 
+struct devlink *devlink_alloc_drv(const struct devlink_ops *ops,
+				  size_t priv_size, struct device *dev,
+				  const struct device_driver *drv);
+
 int devl_register(struct devlink *devlink);
 void devl_unregister(struct devlink *devlink);
 void devlink_register(struct devlink *devlink);
diff --git a/net/devlink/core.c b/net/devlink/core.c
index 9b844e0c1bd2..e2a7169287ec 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -531,6 +531,30 @@ struct devlink *devlink_alloc_ns(const struct devlink_ops *ops,
 }
 EXPORT_SYMBOL_GPL(devlink_alloc_ns);
 
+/**
+ * devlink_alloc_drv - Allocate new devlink instance resources for given driver
+ * @ops: ops
+ * @priv_size: size of user private data
+ * @dev: parent device
+ * @drv: driver that owns the instance
+ *
+ * Variant of devlink_alloc() for a driver that creates an instance for
+ * a device bound to another (or no) driver, e.g. a PF driver for its VFs.
+ *
+ * @drv must not be NULL and must outlive the instance, only a pointer to it
+ * is kept. Operations that take the device lock, like reload, lock @dev,
+ * not a device bound to @drv.
+ *
+ * Return: new devlink instance, NULL on failure.
+ */
+struct devlink *devlink_alloc_drv(const struct devlink_ops *ops,
+				  size_t priv_size, struct device *dev,
+				  const struct device_driver *drv)
+{
+	return __devlink_alloc(ops, priv_size, &init_net, dev, drv);
+}
+EXPORT_SYMBOL_GPL(devlink_alloc_drv);
+
 /**
  *	devlink_free - Free devlink instance resources
  *
-- 
2.51.1

