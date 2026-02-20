Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C9F1F1932
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 00:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771548037; cv=none; b=rH3RPKAzcIk+EtiEcPUAhf9a+9k1QHuSNsyJiZ/D93tkOpu4n8RfHnnKvXryGELhmMbRrSaKne3+UZYR7NfL9ByHuY+siq4JsjZbjmLX32l4mGIq476NemDaV+dbRntt2LOonTD9ctycXpAyI3n4SRRUl3HQstH9XuxmOivEnnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771548037; c=relaxed/simple;
	bh=UcxmttI3/fPWN5YeNse0zzAKsxiVJgZ3rQajvidjvyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m4ie+bYaOSakbUSw3fwDC3XwU5i+lLiezbTJYuMfSevu/CFDBaMmLkNqo1KSgZf1KIp5CznLXm6PRdsSWjLm+YlP8Ojl3G0BPXrGdxJ/LDMorMThjlJ++yimAfQKYrY9fQWRwmEWF8SKL+s/sGmZ5tpWjQ4Sx5eerOXikqeC9BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nt7s8mnb; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nt7s8mnb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771548037; x=1803084037;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UcxmttI3/fPWN5YeNse0zzAKsxiVJgZ3rQajvidjvyg=;
  b=nt7s8mnb+XIL+TGdiwvDWo4ks3rcFgVhlm+SvLl19CLiy25HdCpwVB2O
   obi6w3Rnk+Lsdrf5UJnI/vzmoZy88o31UJqwQJiCMsDz6X0t6F26fWEru
   Kl3kjtOwzLTMMzw0jDh7FQZxAHHogDzleSu1tdoF6BpMKlzLv+PaYBXy5
   4/5W7boCO+HyS1ialg+CMG9HjL4M4+r0hVEQAsZmJi2JtQlz8i24NJ9f3
   P5StWphR1XbttkcHoXNzpnH5kDcBEiQ6H/CSl5rGOmWawMBt/gQIo5Dz4
   VNf+jGupX2a+TB3fFMYts7jaTeW0LNWBfg10nobwUA9Tbjy1x8iiu3+cr
   Q==;
X-CSE-ConnectionGUID: 57oWLa7rSiSrPz0YHqqcIA==
X-CSE-MsgGUID: h/n8zBOBRvOmf+povOO19w==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="76484189"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="76484189"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 16:40:34 -0800
X-CSE-ConnectionGUID: W12SF91HSjaJkokTEoJQ9w==
X-CSE-MsgGUID: 3+O3l29LQ2mbztqzAuk+Rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="218850471"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa003.jf.intel.com with ESMTP; 19 Feb 2026 16:40:33 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Li Li <boolli@google.com>,
	anthony.l.nguyen@intel.com,
	emil.s.tantilov@intel.com,
	sridhar.samudrala@intel.com,
	brianvv@google.com,
	decot@google.com,
	willemb@google.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH net 04/13] idpf: nullify pointers after they are freed
Date: Thu, 19 Feb 2026 16:40:16 -0800
Message-ID: <20260220004027.729384-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260220004027.729384-1-anthony.l.nguyen@intel.com>
References: <20260220004027.729384-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Li Li <boolli@google.com>

rss_data->rss_key needs to be nullified after it is freed.
Checks like "if (!rss_data->rss_key)" in the code could fail
if it is not nullified.

Tested: built and booted the kernel.

Fixes: 83f38f210b85 ("idpf: Fix RSS LUT NULL pointer crash on early ethtool operations")
Signed-off-by: Li Li <boolli@google.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 94da5fbd56f1..7ce6a0e4acb6 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1320,6 +1320,7 @@ static struct idpf_vport *idpf_vport_alloc(struct idpf_adapter *adapter,
 
 free_rss_key:
 	kfree(rss_data->rss_key);
+	rss_data->rss_key = NULL;
 free_qreg_chunks:
 	idpf_vport_deinit_queue_reg_chunks(adapter->vport_config[idx]);
 free_vector_idxs:
-- 
2.47.1

