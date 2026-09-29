Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8111743BDA1
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 23:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790723605; cv=none; b=VDpGr6l7Nm5A1qc6zclb03+uThmLCwvcfKqEgIDoVgoVYr6E96nUCKJgmGMQ8NhoLT1soWoPf4immFm0ZD72DQirsaAF8vEwXRts+UOkyILY/cxPKa2T2nyrjpVrAp/n9cNHpcztCPwjOV4AzCaqR4JFE0AzBPUiLZ+RL4/CUBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790723605; c=relaxed/simple;
	bh=UBjn62ZV2B/zgbMSDM4gtxWkTZ3nQ1lCWhqWHUXW7/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XWhO7/l/PAEg9S+5Xl1zO1t0k4tbaEyZCoXymfgxiOKKREwDHrD7N7MGwWVgQmAy/+1QDRjrqHu2V3HKi9eKzRJ9mukYbx+SS8G8A8pkIou9dyeXIvOc0PtUCuHDB+OGqYzJ9l/S0qAczND4CeNJFlSin1z++HHW+OQ/Dj19KUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CpPGiT8b; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CpPGiT8b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790723603; x=1822259603;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UBjn62ZV2B/zgbMSDM4gtxWkTZ3nQ1lCWhqWHUXW7/c=;
  b=CpPGiT8bNZF9AkaF7nEYGArR550OqCMFFesC4xoEbRciEav7C0PiVyZH
   nFaP2nMD/dt2bH2+smxgLvYsrxUF5qea/UYquuruRnEED46XPQHYqcncN
   /kN2M201zKVDn1R0uBMxGnw5EmP0XZziDUI2+sfmgTHgMCVZ0YTVgcsDn
   t1s2msxgJXGnbAWlTtUcPPJ/NmDPdYdzrXQOM6a2ODPoS9nCb2xJmIuuL
   CuDnDKBAtzuuzVetxXqrCorjqyRAzlwLUEDGMKx1XJMXtej9dLGNoxQup
   EqGBMinOGtH/CXkCrsq4WkejMWZvNkX8CggikzAL7SqDJ/GfEiF9FjJRY
   g==;
X-CSE-ConnectionGUID: i5ywD6KzTUOAnK+dV9Icnw==
X-CSE-MsgGUID: v4SjXIMWQ2Kvwdd1KdHkKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="91550423"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="91550423"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 16:13:21 -0700
X-CSE-ConnectionGUID: INiUhw6gS+i0f+1PtLtlMg==
X-CSE-MsgGUID: rudN6au+SYSZyAqfs9mwWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="280264670"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa004.fm.intel.com with ESMTP; 29 Sep 2026 16:13:21 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Li Li <boolli@google.com>,
	anthony.l.nguyen@intel.com,
	aleksander.lobakin@intel.com,
	sridhar.samudrala@intel.com,
	emil.s.tantilov@intel.com,
	decot@google.com,
	brianvv@google.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH net-next 2/2] libie: log more info when virtchnl fails
Date: Tue, 29 Sep 2026 16:13:01 -0700
Message-ID: <20260929231305.1515873-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260929231305.1515873-1-anthony.l.nguyen@intel.com>
References: <20260929231305.1515873-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Li Li <boolli@google.com>

Virtchnl failures can be hard to debug without logs. Logging the details
of virtchnl transactions can be useful for debugging virtchnl-related
issues.

Tested: Built & booted on a test machine and synthetically produced a
virtual failure to produce the following log:

idpf 0000:01:00.0: Non-zero virtchnl ret val 6 (msg op: 1, data_len: 8);
xn id: 0, cookie: 0
idpf 0000:01:00.0: Transaction failed (op 1, xn state:
3, id: 0, cookie: 0, size: 8)

Signed-off-by: Li Li <boolli@google.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/libie/controlq.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/intel/libie/controlq.c b/drivers/net/ethernet/intel/libie/controlq.c
index 6214fc036ce5..5fce6d9db1e2 100644
--- a/drivers/net/ethernet/intel/libie/controlq.c
+++ b/drivers/net/ethernet/intel/libie/controlq.c
@@ -835,6 +835,13 @@ libie_ctlq_xn_process_recv(struct libie_ctlq_xn_recv_params *params,
 		return false;
 	}
 
+	if (ctlq_msg->chnl_retval) {
+		dev_err_ratelimited(params->ctlq->dev,
+				    "Non-zero virtchnl ret val %u (msg op: %u, data_len: %u); xn id: %u, cookie: %u\n",
+				    ctlq_msg->chnl_retval, ctlq_msg->chnl_opcode,
+				    ctlq_msg->data_len, xn->index, xn->cookie);
+	}
+
 	if (xn->state != LIBIE_CTLQ_XN_ASYNC &&
 	    xn->state != LIBIE_CTLQ_XN_WAITING) {
 		spin_unlock(&xn->xn_lock);
@@ -1088,6 +1095,10 @@ int libie_ctlq_xn_send(struct libie_ctlq_xn_send_params *params)
 		params->recv_mem = xn->recv_mem;
 		break;
 	default:
+		dev_err_ratelimited(params->ctlq->dev,
+				    "Transaction failed (op %u, xn state: %u, id: %u, cookie: %u, size: %zu)\n",
+				    params->chnl_opcode, xn->state, xn->index,
+				    xn->cookie, xn->recv_mem.iov_len);
 		ret = -EBADMSG;
 		break;
 	}
-- 
2.47.1

