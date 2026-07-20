Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023C53CCA02
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 08:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784535746; cv=none; b=J0C4LL9/LLLrKLIdMeza00DRL8sdgZNpWmgOghR3EIMIgVhiGhm5Ay+nOsnQckb38qWSuRrq63C7m0T9vevlPItBUz0FiEpDX05SPDhwPb8YrReHWjI2a6SR1JFydyNJvzek6SJxc9HylHRMpPxbf/o1meE5WkOrIOcToiMXE54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784535746; c=relaxed/simple;
	bh=0q1JjJT+NyJ3KoGJBvEOCOT0C4whnoSf+Mg9FkxS1XI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mPANhByJSu6LzoOWtI2iZp/cY9zqOBlJ8PTBjX1HmIb0j1iiAUz9Bgo+jshu0/bJ43OffmaGdiPBifCSmD5S78o1Gf1twqT1nOGlWU74ET45jpY+g2ewoOwYBqtmRELf1pDF4WfH6BXCOOenjo9iFT8GWJ6NkSdhNoQMoOGsALc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TczRQXsn; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TczRQXsn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784535745; x=1816071745;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0q1JjJT+NyJ3KoGJBvEOCOT0C4whnoSf+Mg9FkxS1XI=;
  b=TczRQXsnyFseT2p4FFrG7GbhPPRkG7HurmqgfscagJtTQBNiVMWjx8s9
   CKNaKoFDCe6IKOCttL9u6HW/Vcoo3ud8W5bMLLVT2mwaH6f4IthdU261x
   qrkMm+Fmxg3r32sMB5Oj1cLxn4ZUILFhLzkOoHcgb8zwhnI0CYwxdhhi8
   dDLwMt0dbptUQrQ55SCl/qnMt4j/81McoFaXda+M08M9ET7vGmmMlDmeT
   2shcNCQkyMA1AfjorK9twz2u+bQbIL9CltTI6rayapy04bVxddTYKBfkq
   6tzMtvYaFdK39XYpyH7McOAe8xeYtXUhUTU3ZCyA9HaKn9xmIcw/l9csx
   Q==;
X-CSE-ConnectionGUID: hAIxEc/gRU+AJyFjAyfQDQ==
X-CSE-MsgGUID: NsBTmoKqTiCY+JbcI+ku5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="85228577"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; 
   d="scan'208";a="85228577"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 01:22:24 -0700
X-CSE-ConnectionGUID: xFMmqMuHQjGxdpCWUBrHDg==
X-CSE-MsgGUID: p68X0I5VQQ+yAaawjcofPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; 
   d="scan'208";a="258034723"
Received: from rtauro-desk.iind.intel.com ([10.190.238.50])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 01:22:20 -0700
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
Subject: [PATCH v5 0/3] Add drm_ras netlink error event support
Date: Mon, 20 Jul 2026 13:52:09 +0530
Message-ID: <20260720082208.2648279-5-riana.tauro@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define a new netlink event 'error-event' and a new multicast group
'error-report' in drm_-as. Each event contains device name, node and
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

Riana Tauro (3):
  drm/drm_ras: Add drm_ras netlink error event
  drm/xe/xe_ras: Report correctable error events to userspace
  drm/xe/xe_ras: Report uncorrectable error events to userspace

 Documentation/gpu/drm-ras.rst            | 21 ++++++
 Documentation/netlink/specs/drm_ras.yaml | 48 ++++++++++++++
 drivers/gpu/drm/drm_ras.c                | 84 ++++++++++++++++++++++++
 drivers/gpu/drm/drm_ras_nl.c             |  6 ++
 drivers/gpu/drm/drm_ras_nl.h             |  4 ++
 drivers/gpu/drm/xe/xe_drm_ras.c          | 42 ++++++++++++
 drivers/gpu/drm/xe/xe_drm_ras.h          |  3 +
 drivers/gpu/drm/xe/xe_ras.c              | 74 +++++++++++++++++++++
 include/drm/drm_ras.h                    |  5 ++
 include/uapi/drm/drm_ras.h               | 15 +++++
 10 files changed, 302 insertions(+)

-- 
2.47.1

