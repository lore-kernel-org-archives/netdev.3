Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D067157ED8D
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 18:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792090554; cv=none; b=GbM5ZINfL3kLiYc0qA2oumOwvTT09UNOSIIuf3kNEtam2SUqv3e9GLNu05NusViF9RKEKbesw7Qc3D6xj9Lmwcwp8MJ7pV6CqLpE8cDbAJHtfcojjOpa5qOv/KLD2gUPKJwzrqT5+nGyzYnNNnvppMUbdCE6mSjb07sPsaTTu3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792090554; c=relaxed/simple;
	bh=17/ph5hdXxMyb0bsC/FFNxo1M2RseRCNM2CCCBPNbj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ADgTiPROynTMLNfUzRZQ52k4NrNfx0OHJOz9lx529O4DI5o9m4QgnehNh5tmcKvv853M0AVJVT/SxyMX9WzhANUwUX3VGZ5uEqtXAIKCSE6eG4vsmpexVdh/3uA9uhqTF6DoFp0fDHnl+7692aTS7VW/77abnMMY4BJzIV5293E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZlYE1vWL; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZlYE1vWL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792090550; x=1823626550;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=17/ph5hdXxMyb0bsC/FFNxo1M2RseRCNM2CCCBPNbj4=;
  b=ZlYE1vWLm6Nd970ikIp++3z5ScWrvcbSydbiKMWVOnXNQ3k33VR/JohB
   25aOrbsEQ2NDbiqfkqhrSpOzURuUv34POe+VqmmS5FvYFTIH084P12lyQ
   k4CCCf2kAAw1WEE7QSnjlWmDRM2qnfOieVSbuP/zEAJLbl+vhudHVeFqu
   8ReCDNPd+on+vSnzU1aJBIfhwCjKx6dBHOSo1Aw1cfSsDosHW4r6JpF+f
   s2XIfxctfpdP+uKA/4bb6BlvjvR9KQkALpsI1501sai0EQPyxJKexpvRu
   PiIVPYfgDjWTEEY+Mr+5vSD67VatkPTwyWV9n52Emf1+YHkjMVQIBV3Di
   g==;
X-CSE-ConnectionGUID: cgI/nq9YTz6e/azLeS2LgA==
X-CSE-MsgGUID: H9/e8xuaT7WqfjyXmsia4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="758084"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="758084"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 11:55:38 -0700
X-CSE-ConnectionGUID: FHDeAz2mRZ+5q3euymM7lw==
X-CSE-MsgGUID: nnCOHXIbR+OhbvQ/1dgZZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="2003199"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa001.fm.intel.com with ESMTP; 15 Oct 2026 11:55:34 -0700
Received: from pkitszel-desk.tendawifi.com (unknown [10.245.244.208])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id C8B1532ECD;
	Thu, 15 Oct 2026 19:55:31 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Michal Schmidt <mschmidt@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
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
	jtornosm@redhat.com,
	ohartoov@nvidia.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next v3 14/15] devlink: add devlink_alloc_drv()
Date: Thu, 15 Oct 2026 20:51:25 +0200
Message-ID: <20261015185454.6332-15-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20261015185454.6332-1-przemyslaw.kitszel@intel.com>
References: <20261015185454.6332-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
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

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
v3:
 * new patch
---
 include/net/devlink.h |  4 ++++
 net/devlink/core.c    | 20 ++++++++++++++++++++
 2 files changed, 24 insertions(+)

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
index bddbbbf000fe..8590a22b0d93 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -531,6 +531,26 @@ struct devlink *devlink_alloc_ns(const struct devlink_ops *ops,
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

