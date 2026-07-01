Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150F03B27EE
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 09:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782899069; cv=none; b=ukL+COr94Nv4wqVQoS2owxegbmKZjbpJ++niRpPhiCYulpxmkiVfqsda39UUCDdVQuJBcyzrhclqJqBN9Bc5UZ6vzdrIAmxZOfYtJA6mwVaIUkWRmOBPngj4ibWifoHHTNAt01qalacd2m91hCjDuwm3VvH6od00Afv8NKRv2J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782899069; c=relaxed/simple;
	bh=SzGRVUx/UhtxQKhzuRLWM4IPr618Vp/qg2rRXZPAo/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B3EiGm9wXfGV9QkFejMhFkq/T1hActsixnX4lxzjxM17bycWgR8dbfRkZOT8L3raUjU+gHkZWRHxJzcGttlhhZ+VF5qZCFz8MQddQpKfV9lauBehHT/wvCS/zjmuGYaFpZlmkYF9v/l5ytmiIkBIjvPDr26fROiufnvT0b9AsZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MoLLrXMb; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MoLLrXMb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782899068; x=1814435068;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SzGRVUx/UhtxQKhzuRLWM4IPr618Vp/qg2rRXZPAo/Y=;
  b=MoLLrXMbC7MJSfkvxYekEsYlI7eVelDH4zevQcdgy0TKpAvftlrgXJJA
   OvOE1WzW3Lpl8FixbeAAy6iE9SCwn6C/qm/l/HybSjvrXZx30aDYa/o/R
   hRvlVjNBIMFIApMBJLQBKiPNaN9LB0mcfNqdBv38mMujDnYqe/EUFXqEL
   t8WLrtDPUdwe57nProSZGQiDEJKwRwHP73zOQ99jFcNzHzwxqYTFuVMKw
   Rvb1GRu/xydC9ENeYBHMa9F2Hi+ra3xS+gqqk38RF6YmL7W0VsPU4REog
   klMOPn4iJY8uNlYc9+ExaJx+eZDMEOi/2fwjsKkYvVtk758TPuI96wJ41
   g==;
X-CSE-ConnectionGUID: sWbTQHrORH6W7AIBJNpe3w==
X-CSE-MsgGUID: 8+TbGBsyR2+zbBC6hM6X9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="94781475"
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; 
   d="scan'208";a="94781475"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 02:44:28 -0700
X-CSE-ConnectionGUID: +jivjYheSgWCzNpYgbKnag==
X-CSE-MsgGUID: CEixi99XQIaiteWcAOxlsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; 
   d="scan'208";a="248541380"
Received: from rtauro-desk.iind.intel.com ([10.190.238.50])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 02:44:21 -0700
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
Subject: [PATCH v4 0/3] Add drm_ras netlink error event support
Date: Wed,  1 Jul 2026 15:14:10 +0530
Message-ID: <20260701094409.129131-5-riana.tauro@intel.com>
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

Rev4: send an event at most once per component for each interrupt
      add xe_warn for unexpected values from firmware
      fix sashiko reported issues
       
Riana Tauro (3):
  drm/drm_ras: Add drm_ras netlink error event
  drm/xe/xe_drm_ras: Add error-event support for PVC
  drm/xe/xe_ras: Add error-event support for CRI

 Documentation/gpu/drm-ras.rst            | 21 ++++++
 Documentation/netlink/specs/drm_ras.yaml | 48 +++++++++++++
 drivers/gpu/drm/drm_ras.c                | 87 ++++++++++++++++++++++++
 drivers/gpu/drm/drm_ras_nl.c             |  6 ++
 drivers/gpu/drm/drm_ras_nl.h             |  4 ++
 drivers/gpu/drm/xe/xe_drm_ras.c          | 32 +++++++++
 drivers/gpu/drm/xe/xe_drm_ras.h          |  3 +
 drivers/gpu/drm/xe/xe_hw_error.c         |  5 +-
 drivers/gpu/drm/xe/xe_ras.c              | 75 ++++++++++++++++++++
 include/drm/drm_ras.h                    |  5 ++
 include/uapi/drm/drm_ras.h               | 15 ++++
 11 files changed, 300 insertions(+), 1 deletion(-)

-- 
2.47.1

