Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4ADD3C0602
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 09:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784195359; cv=none; b=CNWVag0m57mhhGhnKazaJxjPNHkW0wG4QI7vx19RAKZ+b98gIGclWg9ocUZ783flqL6FKidLkjtZ4nkma3NlYGGX8sWKMlTfct9oc+FTx1JxnlYVdC4Sv4p1+2sb+yTG4ExTc+BgZs9drAWxn0wlwbNZK3h7yKayKeV/azAdXOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784195359; c=relaxed/simple;
	bh=dVeFNYKVg+1XMkICLe7KlD3H7IplzJfaKfK3j0AbkdU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ibIC1c0v77GE8iDcldrO2Q6Lt6G1rjO2RFzv1hRcA25g/frLli1//5ru14/IdXTzQ/oyJ06+gi8wGqEHCGELYSm9DBReaLE5YeNDvIzVkJ6UlGvPWw+xfYIZ0nSXgEItnGuqaD6I5u45Fm//IwjmW1Hw5WkVWSvWSI/M/F6e2ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NASJPBKV; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NASJPBKV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784195356; x=1815731356;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dVeFNYKVg+1XMkICLe7KlD3H7IplzJfaKfK3j0AbkdU=;
  b=NASJPBKVuA8HvVROzT1B10Fw6+O2MK/ccN8jdBpAIotiUgGyB4KGVZSl
   z+VcT3RQrVk+KJ9cHssXGqPaucvuP7CJ7ix9mH7Kn+tvHTAPowL6VbFDZ
   g0q0VDWKqWphDRwg/5X2E2EUcP+tKRA9vygoNPFrO+32JSCoS3a0M1Gzk
   Oz/bC1Ig9pDEzfnUWXtrybijWCT+ht8C0LE9u14H26xn5ffIX6Nif7+do
   Cog17SKB7iqUP6uUtKK1kntYy5099mTdBFiLTX/WnJaZdp2Jcevu3E6Ss
   JeGGMg/4nnRGtG4bq24k7bV78VVCMFM6TyHSosrMPbRHALK74royp6Gs8
   A==;
X-CSE-ConnectionGUID: +BI3jTVCSUestrDr4kdKJQ==
X-CSE-MsgGUID: wQXDC12/RVGDWb4Du2Qyww==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="84963873"
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="84963873"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 02:49:14 -0700
X-CSE-ConnectionGUID: xNnUz+eMQ4iFSB5pYsv2Xw==
X-CSE-MsgGUID: fTo6yVdnSuCZmTiA/Fgtfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="256501621"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
  by orviesa007.jf.intel.com with ESMTP; 16 Jul 2026 02:49:13 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next  v1 0/4] Rework and fix ice dpll pin control
Date: Thu, 16 Jul 2026 09:49:07 +0000
Message-ID: <20260716094912.1210865-1-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series reworks and clarifies ice DPLL control logic.
Contains refactoring changes for better readability and
maintainability as well as the changes making the pin
controls compliant to design requirements.

Sergey Temerkhanov (4):
  ice: dpll: Rework multiplexed pin notifications
  ice: dpll: Use switch statements to handle pin states
  ice: dpll: Rework U.FL muxed pin (SMA) control
  ice: dpll: Rework the SMA control logic to match the requirements

 drivers/net/ethernet/intel/ice/ice_dpll.c | 248 +++++++++++++++++-----
 drivers/net/ethernet/intel/ice/ice_dpll.h |   1 +
 2 files changed, 193 insertions(+), 56 deletions(-)


base-commit: bf696cf19d64727a5a95126733603269ed8c42c2
-- 
2.53.0

