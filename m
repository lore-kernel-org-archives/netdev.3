Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31ACD3E9584
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 03:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784692020; cv=none; b=ZhIWhoP32vnqFv2qKEIvXT5Y9yhxRB2j0wJokweIBnKg78QEujsuuZdVp4fYewBZBYAVLfWlHn62cnWixHk29DyXNZhsdcbsQUUUKGSYrf7OcFZexZqqCF/fGiakR+LdzLKdJUGXiVAgNBtpwINXFh6OCCMINiY+KIyAUphwPBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784692020; c=relaxed/simple;
	bh=jphEUn+V0fxllnoZ5af6Dr2zVgNJMkQRQy+87xcGvNo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mgDOt8t3rJgqInKBmWNZhp5zliyRQAR1PsUv5Rbi9LJlKI7MsH+qrSnKsf6Izc6wHnWIY0SKQnx+uy4YIuBYwDsSHeAWWwqFH2HvdH/Dr4RlGwO3pflvthtPqm9iSFRDySlRsr7c0PoBGmgRS+vdPseOweY7ZkLQ/DQ0D5gbBwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bI7xxNV4; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bI7xxNV4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784692018; x=1816228018;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jphEUn+V0fxllnoZ5af6Dr2zVgNJMkQRQy+87xcGvNo=;
  b=bI7xxNV4FG+IQdb60vnyEi0Zu29SxLHN7zI7vBiNqyYDEYMwE2UGHJw5
   ohG0A1Nj+/H2tVkX93UzypPvq+4MXd85GyxYqhD45YKalZteMvrt2dX8p
   ig3Pozwl5ivbK/pYCAmhSvcVrp+gMyehJ3lzFcIl35UEhf0yB3RAACJs6
   batuQ6DHlkXesH0VjUJsc7khutVr0PUnUj/xKbuzT7+76y9pgBCVDrrxH
   0MqxRjGwRwp9PRsvMSqj3KGQKjMhsrQxENsgD+AVai2GT95PDWt1Pu7Ni
   HCF9fwYck8Y/qcmNf98WCOefwMoOxfrXSDJBIHq3vz6T22mxXfRuw7Vwp
   Q==;
X-CSE-ConnectionGUID: GKlcnGc0TbOC71v2myR84w==
X-CSE-MsgGUID: 7iM3BM/7Qd6djrusH52R6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="85433973"
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="85433973"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 20:46:57 -0700
X-CSE-ConnectionGUID: tE/MOuHjQ5idJEB0UCu+7g==
X-CSE-MsgGUID: e092KibvRECW19p+5gVBZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="257421662"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by orviesa008.jf.intel.com with ESMTP; 21 Jul 2026 20:46:52 -0700
From: Raag Jadav <raag.jadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	netdev@vger.kernel.org
Cc: simona.vetter@ffwll.ch,
	airlied@gmail.com,
	kuba@kernel.org,
	lijo.lazar@amd.com,
	Hawking.Zhang@amd.com,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	dev@lankhorst.se,
	zachary.mckevitt@oss.qualcomm.com,
	rodrigo.vivi@intel.com,
	riana.tauro@intel.com,
	michal.wajdeczko@intel.com,
	matthew.d.roper@intel.com,
	mallesh.koujalagi@intel.com,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v5 0/5] Introduce error threshold to drm_ras
Date: Wed, 22 Jul 2026 09:11:10 +0530
Message-ID: <20260722034228.662746-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series introduces error threshold to drm_ras infrastructure. This
allows user to get and set the error threshold of a specific counter.

Detailed description in commit message and documentation.

v2: Document threshold definition (Riana)
    Return -EOPNOTSUPP on threshold callbacks absence (Riana)
    Cancel and free genlmsg on failure (Riana)
    Document threshold bounds checking responsibility (Riana)
    Add RAS operation status codes (Riana)
    Use goto (Riana)

v3: Move documentation from yaml to rst file (Riana)
    s/value/threshold (Riana)
    Use goto for error handling (Riana)
    Reuse status codes and uapi mapping from counter series (Riana)
    Access request/response counter using local pointer (Riana)
    Mark unused field as reserved (Riana)
    Return -ENOENT on info absence (Riana)

v4: Clarify 0 threshold expectations (Riana)
    Drop redundant wrapping (Riana)
    Make debug logs consistent (Riana)
    Update kdoc (Riana)

v5: Drop redundant documentation (Riana)
    Aesthetic adjustment (Riana)

Raag Jadav (5):
  drm/ras: Cancel and free message on get counter failure
  drm/ras: Introduce error threshold
  drm/xe/ras: Add support for error threshold
  drm/xe/drm_ras: Wire up error threshold callbacks
  drm/xe/sysctrl: Reuse xe_sysctrl_create_command()

 Documentation/gpu/drm-ras.rst                 |  18 ++
 Documentation/netlink/specs/drm_ras.yaml      |  32 ++++
 drivers/gpu/drm/drm_ras.c                     | 175 +++++++++++++++++-
 drivers/gpu/drm/drm_ras_nl.c                  |  27 +++
 drivers/gpu/drm/drm_ras_nl.h                  |   4 +
 drivers/gpu/drm/xe/xe_drm_ras.c               |  34 ++++
 drivers/gpu/drm/xe/xe_ras.c                   | 105 +++++++++++
 drivers/gpu/drm/xe/xe_ras.h                   |   2 +
 drivers/gpu/drm/xe/xe_ras_types.h             |  50 +++++
 drivers/gpu/drm/xe/xe_sysctrl_event.c         |  28 +--
 drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h |   4 +
 include/drm/drm_ras.h                         |  29 +++
 include/uapi/drm/drm_ras.h                    |   3 +
 13 files changed, 484 insertions(+), 27 deletions(-)

-- 
2.43.0

