Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D2147DFB6
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 09:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784713346; cv=none; b=rZQT2qg91LOg6ryZiIEiHwm53mAuDjV7qmkpXl6UYmUlkA7i81EM+62MLsM89scWAJHUKdHvdsdym7MSMe8DsKvwzkBPRSbcHI+6M/pa3y2ZEPkYWg/bF3Kooqk1gbl+ICBcuxzUENq+eBgLXELq/ycWYtBVxWBFBaFBd6pdjgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784713346; c=relaxed/simple;
	bh=lV2TH5JFeo658sAQoo8B9k/C5PBNzfn6fQJmlaOnMDo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U+h71Zd3ogPgiAyGWfX5Wj4oW5bW7wEw4MrWQm4O94oa+NfLszQ6iP9UAJUrNGXVeZkgt6ZFqYUbOjgT+ZrsfCQFIWzjsEJMa+17nSUl+7jQTFTgye6IYF/KkWGIJs9a35wvkUw6XVbosjd3aJ1LXPaUaE1unpgRYWGVxhK40y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ItrjHZZ1; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ItrjHZZ1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784713339; x=1816249339;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lV2TH5JFeo658sAQoo8B9k/C5PBNzfn6fQJmlaOnMDo=;
  b=ItrjHZZ1wGQECPmCdNu7y/9rAH0WHZVOrLRCOxsfKfQsicK00mXT/dsI
   eVbbxIM8YZ/zfrWNptMM7OOhXri32w+6HDMpmb++s9R3I3ElOWhjCp0Tn
   HVzqpx0m+8jG1ntnPyXSxvcjm6hvThfgHWhv6da26dJVQRuCN5p1ai2Dl
   yhezFr6AO2WMEoAgNT3Fe6z6EotSj7zQab3idlXJdytsS5uCzNfrA420Y
   1zSp5ZePpT90tYsmPGP8ahyopqrnOP7rZ2EIiByu5Hsmfe7DURzjUBs0L
   isd4iXrAT1xNglHKTtKblam7zkqRxwFu5KRawM6tW++svf8UIEEHXu6Pa
   Q==;
X-CSE-ConnectionGUID: lWba7/xSQk23mi4ud2eIWg==
X-CSE-MsgGUID: T8pe8914QVyNskKDB6gFRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="95706065"
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; 
   d="scan'208";a="95706065"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 02:42:14 -0700
X-CSE-ConnectionGUID: HdtI5MTHQdyUDholT7uFXA==
X-CSE-MsgGUID: j7mIpx3+Q12j78GLFfEOhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; 
   d="scan'208";a="254647365"
Received: from rtauro-desk.iind.intel.com ([10.190.238.50])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 02:42:08 -0700
From: Riana Tauro <riana.tauro@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	netdev@vger.kernel.org
Cc: aravind.iddamsetty@linux.intel.com,
	anshuman.gupta@intel.com,
	rodrigo.vivi@intel.com,
	joonas.lahtinen@linux.intel.com,
	kuba@kernel.org,
	simona.vetter@ffwll.ch,
	airlied@gmail.com,
	pratik.bari@intel.com,
	joshua.santosh.ranjan@intel.com,
	ashwin.kumar.kulkarni@intel.com,
	shubham.kumar@intel.com,
	ravi.kishore.koppuravuri@intel.com,
	raag.jadav@intel.com,
	maarten.lankhorst@linux.intel.com,
	mallesh.koujalagi@intel.com,
	soham.purkait@intel.com,
	Riana Tauro <riana.tauro@intel.com>
Subject: [PATCH v6 0/2] Add drm_ras netlink error event support
Date: Wed, 22 Jul 2026 15:11:35 +0530
Message-ID: <20260722094134.3036087-4-riana.tauro@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define a new netlink event 'error-event' and a new multicast group
'error-report' in drm-ras. Each event contains device name, node and
error information to identify the error triggering the event.

Add drm_ras_nl_error_event() to trigger an event from the driver.
Wire this support to xe_drm_ras to report to userspace whenever a
correctable/uncorrectable error occurs on CRI.

$ sudo ynl --family drm_ras --output-json --subscribe error-report

{
    "name": "error-event",
     "msg": {
         "device-name": "0000:03:00.0",
         "node-id": 1,
         "node-name": "uncorrectable-errors",
         "error-id": 1,
         "error-name": "core-compute",
         "error-value": 1
     }
}

Rev2: use ynl in document and commit message
      fix cosmetic review comments
      simplify caller

Rev3: replace error-event with error-report
      had has_drm_ras check
      add support for correctable errors in CRI

Rev4: send an event at most once per component for each interrupt
      add xe_warn for unexpected values from firmware
      fix sashiko reported issues

Rev5: Remove has_listeners
      send netlink event to all network namespaces

Rev6: Add additional checks for event
      remove unnecessary checks in xe_ras

Riana Tauro (2):
  drm/drm_ras: Add drm_ras netlink error event
  drm/xe/xe_ras: Report correctable/uncorrectable error events to
    userspace

 Documentation/gpu/drm-ras.rst            |  21 +++++
 Documentation/netlink/specs/drm_ras.yaml |  48 +++++++++++
 drivers/gpu/drm/drm_ras.c                | 101 +++++++++++++++++++++++
 drivers/gpu/drm/drm_ras_nl.c             |   6 ++
 drivers/gpu/drm/drm_ras_nl.h             |   4 +
 drivers/gpu/drm/xe/xe_drm_ras.c          |  31 +++++++
 drivers/gpu/drm/xe/xe_drm_ras.h          |   3 +
 drivers/gpu/drm/xe/xe_ras.c              |  68 +++++++++++++++
 include/drm/drm_ras.h                    |   5 ++
 include/uapi/drm/drm_ras.h               |  15 ++++
 10 files changed, 302 insertions(+)

-- 
2.47.1

