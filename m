Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793716812;
	b=Oj31cj3Irh/TBDfKXzENlKWd/nmIucJPkkP6rvxTBpSvPwpCVVpxjMa1DlzWsN/3sWdK
	 Rb4MIaohCX6jcK1ozdTDYC+hkGaibXMbRawBvnzZ7qX7LB8kHA1SeXbwcCQhLjtVOzhVs
	 9T217Qv37NSKvh4WWNalz1p2+3BVT/MwptARUPDLd3PJR15UDtw3Ph9kQ2c5SJECJpWfL
	 ldoSZfSaSE/L+DweilSjWBVEOxHddVEp8b9LaGIretOokkmj0rsoqGVnQXNS6G5WleO14
	 KUo7g5OZcf0eZoCXJMu8LpqvDLuGgiPfQqp93DpEGZQfAKjD2p4ZYaEDC17GBZ0nojg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793716812;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=P0MvXjZrXWkrQfZgOw8XDw3pr8Sx1MoRjoeIUFPH8so=;
	b=Va7WjatC3rRUFLruBZmKAwZ69B9JqXzSrHcOBmH8j2e49XEM3p8ViJ9sEZbkBZgfVZAK
	 dEWI4p6+G1VsLPrBAcKr+kV2fDgYGe/uropqvMkatXXsp6S7pAkDtocc9HHvfTBlxwdSN
	 v19ZBiZwYjCXeBex1bWKzMhicTuRRSMzwzJm6INF6YKpBGrat4uYXSEyJNw5brlDENXYr
	 z11f4s77XY1vhnUztA66qCrENLJt/5MtvXNzCxfYVp5/lT74/28s7jSx0TOjUxoscRqbU
	 IbckLUWEz00pSbiBawsSHAmp3BlxxYWiKb40XBC7V1PTqb8uIqa4i5e8HdgAqm+gYpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lsBaVMEg;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DA5606A330
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 14:40:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55DA5606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lsBaVMEg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793716811; x=1825252811;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ndtKM5pOidHsUWwRe7gQYfiOfPgxt1HpXR0bdo0FaoQ=;
  b=lsBaVMEgI5SdY+BwozzxPImr53RjYiK7sMntztE+9haqkfK5aJMFIRsa
   zMVcxmF3JAG6sNnTLBuFziz5GRKxFR1yYXIx140fluTDtQQ+B6uLMaxqj
   6gMRxO5Y+oTMSk3cRuI5LM2cH3MwJd+kIQW8x5AtS+Io4mwrmgc1dG6C7
   IUIOB9Hon3rW5xR7w83j5RtLt4dP0t3dxbxhCBYZ8mxSCt57PCvO9TOJI
   ZOTeQfQeNq6cvH8d423PEBpIIJ/z/+k9i4HRpCbi45XAqEYMh8HTjxJ5f
   uKe0B6COyDqK3tD/bk3E/dXFjRXNdh7PlzrzgIWkBs4nWM+ouklv+AMgK
   g==;
X-CSE-ConnectionGUID: LZ1QuUZOSnKnHJPr3zdmtA==
X-CSE-MsgGUID: PUuqwmo5Qg+VmajCmaMVEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2324120"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2324120"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 06:40:10 -0800
X-CSE-ConnectionGUID: ILHJJmwFTkyfTfm6UV7c+g==
X-CSE-MsgGUID: mpTNajGuTWmy0m1IObsikQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="8290039"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa013.fm.intel.com with ESMTP; 03 Nov 2026 06:40:05 -0800
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 3C425312F1;
	Tue,  3 Nov 2026 14:40:03 +0000 (GMT)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>
Cc: intel-wired-lan@lists.osuosl.org,
	Simon Horman <horms@kernel.org>,
	Michal Schmidt <mschmidt@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	bruce.richardson@intel.com,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
	padraig.j.connolly@intel.com,
	ananth.s@intel.com,
	timothy.miskell@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Lukasz Czapnik <lukasz.czapnik@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-next v4 14/15] devlink: add devlink_alloc_drv()
Date: Tue,  3 Nov 2026 15:14:55 +0100
Message-ID: <20261103141646.303620-15-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261103141646.303620-1-przemyslaw.kitszel@intel.com>
References: <20261103141646.303620-1-przemyslaw.kitszel@intel.com>
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
v4:
 * document in devlink-info.rst that an instance created for another
   device reports the name of the creating driver (Sashiko)

v3:
 * new patch
---
 .../networking/devlink/devlink-info.rst       |  2 ++
 include/net/devlink.h                         |  4 ++++
 net/devlink/core.c                            | 20 +++++++++++++++++++
 3 files changed, 26 insertions(+)

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
index 9b844e0c1bd2..efad05e54ba9 100644
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
2.54.0

