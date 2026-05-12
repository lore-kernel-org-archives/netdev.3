Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58443A542E
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 09:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778578275; cv=none; b=dWfYUn6I0ycwG/V/yKewfjd1g8dTEqm4KGgJmQZmwH6bHdqtJ0U8qwnzHmdZOg6nWnoRBcdzFkYsK9vlOTcUF5WAgZ6BjY3ugS6vP3+mlTZntIHIAqFi1drcdcox1MrVw/b3XSAJhKB+CHTmLImKwJtl1lT3e/lT7/NS16fPYlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778578275; c=relaxed/simple;
	bh=j/vnRdBUw140QYqM2h8/QOdevi4qqQ39qEJwrDFReuI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uAWjKByVXwY/uzNb1VgzI59pNbDroUM4NPF7vB98QC3ohV/7bIqJXtOvWxMUczDOZqUg+aHWM/MdCZs/qcx9/zAtqcpGBAhcYWC1w4VpNIEXSNA6ik1n6udW7de2O7leX82vzpYrk2C+yIKnlj6DustcO13mwh9If5fmKwpVEQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E6qMRO69; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E6qMRO69"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778578274; x=1810114274;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=j/vnRdBUw140QYqM2h8/QOdevi4qqQ39qEJwrDFReuI=;
  b=E6qMRO69B2sHznjqhdpHI7/dPjwPPt6wsz+2R4fS/GJ79JsSlPhZyc/N
   FgsuXtWfNZQaIu491ucGG18ALcza/6GTEI9zOlvBapiBIpIFcA66LJxob
   T5baMHL/dU/IfXdM+sybJJlhoxndk+2td2WnVbb7czlCnQe+CAa37t+Kp
   XRwQ0UMzWs0dYyZezA+NfVU0no+3MJnGIloxYrJs3GGPbhuHFWZYEeEhJ
   TNMPxgKckMctgRKYj16qGPJCnOfkh0crnYJID/Q23NSUwjlIvNSenCgay
   X/+Jh9igriNDYCgEaWUKrGJPQliOR3yO6oFel2zeucTHu6SLR8aXMoCif
   A==;
X-CSE-ConnectionGUID: AMXyuuy8RfOzXZbIID6PTw==
X-CSE-MsgGUID: hAINsK5SRRahDUaLp/m/jQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="79663240"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="79663240"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 02:31:13 -0700
X-CSE-ConnectionGUID: 7Q1uGT2FQ82tUUG+244+Cg==
X-CSE-MsgGUID: ohyL/FO3SRCGr7Exts/FGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="231323201"
Received: from os-delivery.igk.intel.com ([10.102.21.165])
  by fmviesa009.fm.intel.com with ESMTP; 12 May 2026 02:31:12 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [PATCH iwl-next v2 0/4] return value of skb_checksum_help()
Date: Tue, 12 May 2026 10:47:25 +0200
Message-ID: <20260512084729.1338557-1-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

most intel drivers ignore the return value of skb_checksum_help(). It
can fail, so pass this value to the caller, to allow dropping packet
without correct checksum.

Michal Swiatkowski (4):
  ice: pass the return value of skb_checksum_help()
  i40e: pass the return value of skb_checksum_help()
  iavf: pass the return value of skb_checksum_help()
  idpf: pass the return value of skb_checksum_help()

 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 18 +++++++--------
 drivers/net/ethernet/intel/iavf/iavf_txrx.c   | 17 +++++++-------
 drivers/net/ethernet/intel/ice/ice_txrx.c     | 20 ++++++++---------
 .../ethernet/intel/idpf/idpf_singleq_txrx.c   | 22 ++++++++-----------
 4 files changed, 34 insertions(+), 43 deletions(-)

-- 
2.49.0

