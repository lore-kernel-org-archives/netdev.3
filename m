Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB6E3A4F5B
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 10:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782123453; cv=none; b=tG8Lu4uaZWkXcPjYnaU/pbZJElS/jpDffPI0uzwygYduCcHjoZPih+G1dYrV8YN4S1dTYFcq7sz0TKWKHZvmhuyKUWx6+nXoM5/dI8PWP94jL1AJziF6bHUwXg+g5i/dk0gWHohqenDHToP9TWl53OXiJJpktpmW476ujDu8Rj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782123453; c=relaxed/simple;
	bh=NClfwZ1UZgm5zgrmEDx9DPwd4RXEjuAQYyZDKDQzYng=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jlfwOLJJ/k8N9UwzdY7AYpU+GJ1+JMwS0YN2Nqp1WIh/eOoV0EhE59pEJgieRPLqcuoB40dkBy49x/gJCXVyZvWcZVT9dMrK4I4pDfLtUeY+tQk0DVKfL8jyU1hHXa8FKQK4P3lXswaRaP5R+BOsPQganfsGr/ywb+dyXQiMTKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mYwPjxkt; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mYwPjxkt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782123452; x=1813659452;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NClfwZ1UZgm5zgrmEDx9DPwd4RXEjuAQYyZDKDQzYng=;
  b=mYwPjxktxEV0jsPow6p2hLbzBRVcwdFNFkuWGqzzUV3gXf7XOXj/KAHx
   TFXI8G3kq32zM3dzUjN97pRXeSLXIDQ4Xpn+u9iIIxn8qtogLgYmhxsNG
   L9rSlmWvphQSfXtPBCehdrOJvQlULeqzbrq9MFq1hF+Sl9k41gpQt3L7s
   N3tqmnAkbIP0DVLDB0P8ggm/WmHyz4usfzV1rbotYmTEL75hT1KM4mFc4
   c/Vs18raIn3DOVoMDAdEimu2xe3AaKqXWl6q+ZOlUI9rVaavFRgOThbhP
   3whxFhNpU9WmxrtQB3jQKc4B/lpU5DhhH+vaNn92L1EziIWQk6R+gEUq3
   w==;
X-CSE-ConnectionGUID: huxpXbe2QGujZK4jkgvx7w==
X-CSE-MsgGUID: lBBb+VZmR5iA6SkG6esaJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11824"; a="86532036"
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; 
   d="scan'208";a="86532036"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 03:17:32 -0700
X-CSE-ConnectionGUID: H+PgrnQYRR2BkeeRyMJ6oA==
X-CSE-MsgGUID: uHwEO3MXTkqtplOMVdRH3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; 
   d="scan'208";a="242832389"
Received: from rtauro-desk.iind.intel.com ([10.190.238.50])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 03:17:27 -0700
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
Subject: [PATCH v3 0/3] Add drm_ras netlink error event support
Date: Mon, 22 Jun 2026 15:47:17 +0530
Message-ID: <20260622101716.3313496-5-riana.tauro@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define a new netlink event 'error-event' and a new multicast group
'error-report' in drm_ras. Each event contains device name, node and
error information to identify the error triggering the event.

Add drm_ras_nl_error_event() to trigger an event from the driver.
Wire this support to xe drm_ras to notify userspace whenever a GT or
SoC error occurs in PVC. Also add support for correctable errors in
CRI.

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

Riana Tauro (3):
  drm/drm_ras: Add drm_ras netlink error event
  drm/xe/xe_drm_ras: Add error-event support for PVC
  drm/xe/xe_ras: Add error-event support for Crescent Island

 Documentation/gpu/drm-ras.rst            | 21 ++++++
 Documentation/netlink/specs/drm_ras.yaml | 48 +++++++++++++
 drivers/gpu/drm/drm_ras.c                | 87 ++++++++++++++++++++++++
 drivers/gpu/drm/drm_ras_nl.c             |  6 ++
 drivers/gpu/drm/drm_ras_nl.h             |  4 ++
 drivers/gpu/drm/xe/xe_drm_ras.c          | 30 ++++++++
 drivers/gpu/drm/xe/xe_drm_ras.h          |  3 +
 drivers/gpu/drm/xe/xe_hw_error.c         |  5 +-
 drivers/gpu/drm/xe/xe_ras.c              | 53 +++++++++++++++
 include/drm/drm_ras.h                    |  5 ++
 include/uapi/drm/drm_ras.h               | 15 ++++
 11 files changed, 276 insertions(+), 1 deletion(-)

-- 
2.47.1

