Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3832D3B775B
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 09:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773223060; cv=none; b=oiDQHzAbbe3vP2FcXtqJcvxPRdwC1uhg4cxX1sW0d4cdKW2QHKEb0DCGGHZ+nkNJXSkRJYpZC9xzfVLGAl2t7lJbRVH/XoDmiMi9IAEr0PQP9zaLFx0VWgXhRuSBd6uQq+IJxnNkR516CZAZJmD75NsDyDAcT/3E5m5hYQMWtyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773223060; c=relaxed/simple;
	bh=4bI/btbONON9G3trYcFCis9chSVGO43gW9VYlSHW2nU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oGfCW5bh/MEfUPwpUI2iOZ9sGrHzP0M2NFQt44sVR+H/+Z+xAHJBUkZAHVAC7TQ0cKU9d/7gmZcm6Qm+Zaj+Z39r9Dii0J7n89JijeBqwl+Mf9gIWtkub153m5jLAjMmyVt72WNgDbvL2URQmEbVXkkQ35bKkq7kmis7r+ZdjKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G/NhPocL; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G/NhPocL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773223058; x=1804759058;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4bI/btbONON9G3trYcFCis9chSVGO43gW9VYlSHW2nU=;
  b=G/NhPocLaFGepQ9OmLuxyj+9CvjAEU/L+WTX15SeSJApsRFwCcTB5bsv
   KnU2Gh561C8HUBEUW/CrT/yAZdURiexAHYeiAd6zJsM2sFy2hh+OK1m2h
   853kF2l33L8HROHAhQNVU5AskZW5znQR3kz6p7m1F/2SmKhxqUph41C+J
   azz+qAwUUOBFQc5OXAKbSZErU27Vk4Ca1k8gnjZP73+wtNNQkNkbHcSmo
   xxQF7I1423JUsn6PcsjJO/z9sbsuEsQGgY0jCRW3wqli1EvEjNQn+TwUH
   VIQT2yTgQFMyyOuHC9ool9Pk11LuzFTHCswZzY4xlkmriN9gYoNJqVJEb
   Q==;
X-CSE-ConnectionGUID: joNQ7bdJQR+8qpnTAEkPhA==
X-CSE-MsgGUID: WlFdASk3THWAbamiCqlXBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="74325902"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="74325902"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 02:57:38 -0700
X-CSE-ConnectionGUID: P1Np9L/jRPKDRQekogkxWg==
X-CSE-MsgGUID: o8q8qZd/TSavEXFw45L3UA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="217095711"
Received: from rtauro-desk.iind.intel.com ([10.190.238.50])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 02:57:33 -0700
From: Riana Tauro <riana.tauro@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	netdev@vger.kernel.org
Cc: aravind.iddamsetty@linux.intel.com,
	anshuman.gupta@intel.com,
	rodrigo.vivi@intel.com,
	joonas.lahtinen@linux.intel.com,
	simona.vetter@ffwll.ch,
	airlied@gmail.com,
	pratik.bari@intel.com,
	joshua.santosh.ranjan@intel.com,
	ashwin.kumar.kulkarni@intel.com,
	shubham.kumar@intel.com,
	ravi.kishore.koppuravuri@intel.com,
	raag.jadav@intel.com,
	anvesh.bakwad@intel.com,
	maarten.lankhorst@linux.intel.com,
	Riana Tauro <riana.tauro@intel.com>
Subject: [PATCH 0/4] Add support for clear counter and error event in DRM RAS
Date: Wed, 11 Mar 2026 15:59:14 +0530
Message-ID: <20260311102913.3387468-6-riana.tauro@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clear Error Counter : Add clear-error-counter command to DRM RAS to clear
a specific error counter of a node. Implement the callback in XE driver
to demonstrate usage.

Usage with both get-error-counter and clear-error-counter:

$ sudo ynl --family drm_ras  --dump get-error-counter --json '{"node-id":1}'
[{'error-id': 1, 'error-name': 'core-compute', 'error-value': 0},
 {'error-id': 2, 'error-name': 'soc-internal', 'error-value': 3}]

$ sudo ynl --family drm_ras  --do clear-error-counter --json \
'{"node-id":1, "error-id":2}'
None

$ sudo ynl --family drm_ras  --dump get-error-counter --json '{"node-id":1}'
[{'error-id': 1, 'error-name': 'core-compute', 'error-value': 0},
 {'error-id': 2, 'error-name': 'soc-internal', 'error-value': 0}]

Error Event Support:  Introduce `error-event` support in DRM RAS to notify
userspace whenever an error occurs.

Each notification includes the node-id and error-id to identify
the source and type of the error. To receive notifications,
userspace must subscribe to the 'error-notify' multicast group.

Userspace can receive the event by subscribing to multicast group.

$ sudo ynl --family drm_ras --subscribe error-notify
{'msg': {'error-id': 2, 'node-id': 1}, 'name': 'error-event'}

Riana Tauro (4):
  drm/drm_ras: Add clear-error-counter netlink command to drm_ras
  drm/xe/xe_drm_ras: Add support for clear-error-counter in XE DRM RAS
  drm/drm_ras: Add DRM RAS netlink error event notification
  drm/xe/xe_drm_ras: Add error-event support in XE DRM RAS

 Documentation/gpu/drm-ras.rst            | 17 +++++
 Documentation/netlink/specs/drm_ras.yaml | 27 ++++++-
 drivers/gpu/drm/drm_ras.c                | 91 +++++++++++++++++++++++-
 drivers/gpu/drm/drm_ras_nl.c             | 19 +++++
 drivers/gpu/drm/drm_ras_nl.h             |  6 ++
 drivers/gpu/drm/xe/xe_drm_ras.c          | 52 +++++++++++++-
 drivers/gpu/drm/xe/xe_drm_ras.h          |  7 ++
 drivers/gpu/drm/xe/xe_hw_error.c         |  5 ++
 include/drm/drm_ras.h                    | 13 ++++
 include/uapi/drm/drm_ras.h               |  4 ++
 10 files changed, 237 insertions(+), 4 deletions(-)

-- 
2.47.1

