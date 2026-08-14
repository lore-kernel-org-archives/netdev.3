Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE9A342146
	for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 01:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786757176; cv=none; b=T9DW7XvRON1tI0P6WmaxaR75uzvcVcAoL7gNzG2oHpTxZO1SAHSK10jZOM3aRhgWJqP9mYk9sKKxmivhpToaDvEfaVlX1DB4C/5HK37FFjUwpzFCNbf/1jlf0TQWbfSOTAhbN6TGgPJgG+RanLkNajq4cNhZTpuHImGINli52Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786757176; c=relaxed/simple;
	bh=uId5g3DqFv4eHYhtqK7IUw6Taku6sM+8MhYTCS58Kv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bdtYmD8HMRyy5KhrtXRx6IwqaQb15MCHpaO5tXx0EYqIT87Y5MUoAfF9pBkTEFDfyvRBnYvsHIAFywQpt+9sU4oc2vWNzVimTwwDaofSXyamQCwtbfA+z9TWuNUFnStjAnyg9GL09UEG2UlVfPDl1jFuzkmBlot4fGd4AN8cEB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=brYD4rrh; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="brYD4rrh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786757174; x=1818293174;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uId5g3DqFv4eHYhtqK7IUw6Taku6sM+8MhYTCS58Kv0=;
  b=brYD4rrhHPiPlNq0b/yU6Hm5A2XXhUjfnsgPF6PnEFBLW+UfMqWOmr59
   uHu/w7TU+Xg6/YGRI8aMnLMmZ0V4nz1WzyvMZT0ITvA9Z2kalEHMkvyqq
   A/ZPbxfWn372Guj6M1GMkktGG7NrBYhV/L8ZaY7GiODA7DbPKSKp2QPm8
   Qh6Bux3VKTBS2g98TQwQSRV4oVS8zdTnRdjWP18bgmOu0dmlTIT64gJXT
   mC98To48zlyY+pBYBdSntaIdJfeAAQEq5ohMYskhCgmwZeLVAjSyUe9RN
   J6KEpz91LzNigccLDjmQndGrpRbppdw2/qDpA7g+MW9MvjXPjP5lp7i2O
   g==;
X-CSE-ConnectionGUID: vPjKBR24QkmppXXzQ2v4zw==
X-CSE-MsgGUID: QM44anZYQeGUGfXxzJPD4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11875"; a="87194379"
X-IronPort-AV: E=Sophos;i="6.25,224,1779174000"; 
   d="scan'208";a="87194379"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 18:26:13 -0700
X-CSE-ConnectionGUID: qJO4KlTBTPKnguV/y4uTNg==
X-CSE-MsgGUID: 6MQ8ykKgSAqWKDXNAnkRkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,224,1779174000"; 
   d="scan'208";a="287844731"
Received: from unknown (HELO fedora.jf.intel.com) ([10.166.5.147])
  by fmviesa002.fm.intel.com with ESMTP; 14 Aug 2026 18:26:13 -0700
From: Paul Greenwalt <paul.greenwalt@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Paul Greenwalt <paul.greenwalt@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-next 1/3] idpf: clear drvdata on probe error path
Date: Fri, 14 Aug 2026 13:49:17 -0400
Message-ID: <20260814174919.4177289-2-paul.greenwalt@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260814174919.4177289-1-paul.greenwalt@intel.com>
References: <20260814174919.4177289-1-paul.greenwalt@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If idpf_probe() fails after idpf_cfg_device() succeeds,
pci_set_drvdata() leaves a pointer to freed memory. Clear
it before freeing the adapter to prevent potential
use-after-free if anything accesses pci_get_drvdata().

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
index 807608899084..6f9579c39342 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_main.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
@@ -364,6 +364,7 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 err_init_wq:
 	idpf_decfg_device(adapter);
 err_free:
+	pci_set_drvdata(pdev, NULL);
 	kfree(adapter);
 	return err;
 }
-- 
2.52.0

