Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDB051D505
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 21:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788903914; cv=none; b=TOZpU6tvsBJ2EHzMVTloCMqLBt8ZqZNIN2X4e5OdI1onlOyVEcAm/eFdsmCA+XgRlT75+FOkTVJKpyRcByPKcIfJXe3m/TKNrYuAH8l7p0uW0MpEl63BgT82SxuVcNYwtgE93RhIJzi/0VbIEma7LRemeAAZDFKWhMeSM37KShM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788903914; c=relaxed/simple;
	bh=EoRQdi8oenN8LkB8wQ2f+fGp3ZnLiftibaWr4ZefDbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ml8ihkONuXmnWwbAfEWJEzfbEsC3y01O8pVWyx6SCbOt/fYBiQ03PRTFnuS3n8ez1U+e8bApO0whnGhT2OFQ3CjK1otUgJcOk89HvG8wRY4xV408FEvKbu/JP3xexL1lCLZSro6jK73pfKgpRhnR5jrndkQGwzAHLkwTlMiVejg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OY/Fxsy0; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OY/Fxsy0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788903912; x=1820439912;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EoRQdi8oenN8LkB8wQ2f+fGp3ZnLiftibaWr4ZefDbU=;
  b=OY/Fxsy0fZ+p0CnWyhS6alKp2qLo+bubKliAW8rq8XVDaCOhQDZi5Z9S
   rmZM957Op/CiLnuLtCPdRqxG4ISKNpSaaAXk+sfrafiJ190RZAix+2qT8
   Gwhb5KkAWDE5MjHdvrjpxdjvNKSHQ8f2orDrFN8+9pFPZ0nmrznDVxHdp
   1RSqqrT0YvWLU0aCxaWTgv+Xn3R6IFT2QjI+fdduWxkT5Xg9jHPOIgGWg
   /jHlPfizV1/rI9n084Nj0CXDqmv+F6HrJ/r5hY8b9wJSJY8FD0QgJAtc7
   vQHSPy3WVrV9nZgfE+EN7Ad2Z/LDYk51CST9ResOdugawhyEK46PDbTic
   w==;
X-CSE-ConnectionGUID: vWFoKxPUT/yvbzV6Ux1ffw==
X-CSE-MsgGUID: GrkFm1wIS4SXrZ8WEk09Mw==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="106836227"
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; 
   d="scan'208";a="106836227"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 14:45:09 -0700
X-CSE-ConnectionGUID: erGl89KzRuWQswXwRPeUew==
X-CSE-MsgGUID: FzeVBU55RjWrffgRHLhu1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; 
   d="scan'208";a="269782512"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 08 Sep 2026 14:45:08 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Myeonghun Pak <mhun512@gmail.com>,
	anthony.l.nguyen@intel.com,
	ae878000@gmail.com,
	joshua.a.hay@intel.com,
	sridhar.samudrala@intel.com,
	milena.olech@intel.com,
	vadim.fedorenko@linux.dev,
	willemb@google.com,
	jacob.e.keller@intel.com,
	przemyslaw.kitszel@intel.com,
	jbrandeb@kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH net 2/5] idpf: disable PTM on probe failure and on remove
Date: Tue,  8 Sep 2026 14:44:57 -0700
Message-ID: <20260908214502.528440-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260908214502.528440-1-anthony.l.nguyen@intel.com>
References: <20260908214502.528440-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Myeonghun Pak <mhun512@gmail.com>

idpf_probe() enables PCIe Precision Time Measurement with
pci_enable_ptm(), which takes a reference on the device and on every
PTM-capable device up the path to the PTM Root.

Neither the probe error path nor idpf_remove() drops that reference, so
the PTM enable counts of this device and of its upstream path stay
elevated with no bound driver, and the device's PTM control bits remain
set. pcim_enable_device() only arranges for pci_disable_device() and
does not undo the PTM enable.

Add the matching pci_disable_ptm() to the common unwind path.
pci_enable_ptm() failure is not fatal here, so guard the call with
pcie_ptm_enabled(): pci_disable_ptm() decrements dev->ptm_enable_cnt
unconditionally and then recurses upstream, so calling it after a failed
enable would drive this device's count negative and wrongly decrement
parents shared with other endpoints.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: 8d5e12c5921c ("idpf: add initial PTP support")
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
[TN moved call due to commit 6b284aa2ddf3 ("idpf: refactor idpf to use libie_pci APIs")]
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
index 9840580fbe51..129bccaa6baa 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_main.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
@@ -106,6 +106,11 @@ static int idpf_dev_init(struct idpf_adapter *adapter,
  */
 static void idpf_decfg_device(struct idpf_adapter *adapter)
 {
+	struct pci_dev *pdev = adapter->pdev;
+
+	if (pcie_ptm_enabled(pdev))
+		pci_disable_ptm(pdev);
+
 	libie_pci_unmap_all_mmio_regions(&adapter->ctlq_ctx.mmio_info);
 }
 
-- 
2.47.1

