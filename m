Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792489583;
	b=Uq9s5Mh7UTLf1jZ0K7rmy2V8nd/2X12R5gS/Vc9HDnN1a5Qewjs3CCHuri6JErquBDU0
	 /NLMwpPeJXWeUkxMpaQv/oL73NrlyPM65GvhOnj5is6D2jrAU6vwgHk84l3xTIk1yJ2Ix
	 CA0UnNGYiaGwbpWB3PfLowyJMbid8PpGpZvmIAbM67SoTd5A1JvLlzgeRozNGJhQ+xZXe
	 FQsH8CeN4BW3A8uOScQ4VH1lk7FLSx7GSSWHAFslbi2MStCx5l0BBUj1jrBDSKpqc7skL
	 A8Mp5i0SJ96NnBre/9YmL/Mu8v9VCAt6vO965BVOfxPh9rhnV7Cj4AbN2gLlE2lFeSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792489583;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=40ngp+o3wkVyzuCqy8jYvTbJZDNfdfTCNBfgR0/3LIc=;
	b=s56ir5iVwCkWxBNJ0uHu2OWi7IAr444rMtFB2fM5TlWJsXesyfrqjfy6uof60gmcJ7b9
	 NHBlajje3PDrqcQyAYJIcarY49P3dilkQ9XOqO/2CXzTM9uLzIgDBx2kn4q4wM2pUypbh
	 QiHYk4CpM17qpBjnoWDyQJY3kOw0tO2Hf10qXx8KULI2uxAmw4RZ4vwSGuC7ciuwVKlCF
	 zzunWVs4XDykEiFo3Hs75zJyG8j2ZMS1+OkynoDd+v5h34kdD2AfBEFi2LAV4aavybhMF
	 XeIM4N178eLMzHF9zO0ZQBthwnE3wn1FX1v50CYIhu8FjIWrXAci2hGzlIDMmP9zC0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=W11TCWm7;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F0060A2634
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 09:46:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0F0060A2634
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=W11TCWm7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792489581; x=1824025581;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=7Oyw+MBD/YlH+xn/wMnkU59QtXDXpP9/dLkY2Q7Afrs=;
  b=W11TCWm7mRtoMSp/+x2jAk51jmGaS/5y/8MAsuHBlpd3dM/zzhrpQ4Xx
   Ujq2L7y8/FW5XBUN1FEg03zgL2gl3xXUxfZ3FScep1OfpB/uFUNZwslf3
   sG7dZrvmEHA6isYHjiPHyqREgfmwH0keDOGm3WBRUJtnWFBL1eQ5ZnryS
   qDMNZXDt02dhrkwTqbvfnLEoPAKoTBjKZAEmc/28gDCZvNU5xP+yXielT
   DavNIyrKpWeyAJ2Euvcioc22FAIoPf4ty0DFwqhNSfVwnUW5/iA/aiybq
   KtTQ7x7ckuYcetdG8/5G69kpjO0Chd37zE8H0VFitV0x3MoL3X6jpABWF
   w==;
X-CSE-ConnectionGUID: yAXuFMebSWWgpstCAYHT4A==
X-CSE-MsgGUID: 1qsIYUAWTR60dSeJcEbMmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1287938"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1287938"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 02:46:15 -0700
X-CSE-ConnectionGUID: nyf8n+yjTk2G3GeVGcxzPw==
X-CSE-MsgGUID: 0NpLVNgjRSCu99iQKCnoWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2723923"
Received: from orcnseosdtnuc.amr.corp.intel.com ([10.166.241.20])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 02:46:15 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 20 Oct 2026 02:45:43 -0700
Subject: [PATCH iwl-net v4 12/13] ice: skip reading Tx ready bitmap on
 ports with no timestamps
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-jk-e825c-timestamp-processing-logic-fixes-srcu-v4-12-3e30fc9adc73@intel.com>
References: <20261020-jk-e825c-timestamp-processing-logic-fixes-srcu-v4-0-3e30fc9adc73@intel.com>
In-Reply-To: <20261020-jk-e825c-timestamp-processing-logic-fixes-srcu-v4-0-3e30fc9adc73@intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Petr Oros <poros@redhat.com>, netdev@vger.kernel.org
Cc: Grzegorz Nitka <grzegorz.nitka@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Alexander Nowlin <alexander.nowlin@intel.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, jacob.e.keller@intel.com, 
 maciej.machnikowski@intel.com, przemyslaw.korba@intel.com, 
 sergey.temerkhanov@intel.com, arkadiusz.kubalewski@intel.com, 
 richardcochran@gmail.com, horms@kernel.org
X-Mailer: b4 0.17-dev-67df5
X-Developer-Signature: v=1; a=openpgp-sha256; l=2547;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=7Oyw+MBD/YlH+xn/wMnkU59QtXDXpP9/dLkY2Q7Afrs=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqzrFgmpl/9dDz9qviOEMaXSukv+5vlr0YW1J79NuFM3f
 9Wv3ob0jlIWBjEuBlkxRRYFh5CV140nhGm9cZaDmcPKBDKEgYtTACYy8yIjw0fLX2sebSnwP7rb
 PHwDx9Lk5kCX9RFfQ5SN9qryGLKdZ2H4K1UkEKuXbbPs19nfvzrdltxZalxeHna93XnelMY5XPN
 M2QA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

On E82x devices, the interrupt for Tx timestamps are handled by the clock
owner. When an interrupt with the Tx timestamp cause is fired, the clock
owner PF iterates the list of ports and checks for timestamps across all
ports.

The existing logic reads the PHY timestamp ready bitmap before iterating
the list of in-use timestamp indexes, even for ports which have no
timestamps waiting in the software timestamp tracker. This has a
significant and measurable latency impact on reporting Tx timestamps.

Check the bitmap and exit early in the event that there are no timestamps
waiting on a port. Observant reviewers may notice that the check is done
without acquiring the lock. This is fine, as whether the thread sees or
fails to see a new outstanding timestamp does not affect correctness, only
determining whether or not it should do extra work.

Skipping the check has the highest impact on E822 an E825 devices which
iterate all ports in a single thread, but it is applied universally to all
device types since the extra read is unnecessary regardless.

The average latency of a Tx timestamp is impacted by several factors
including system load, the number of timestamp requests, and some random
factors that are difficult to control. However for comparison on my system
with these changes, while operating ptp4l on a single port with a sync rate
of 16/second:

  Before: mean 317.43 microseconds, standard deviation 34.51
  After: mean 189.71 microseconds, standard deviation 43.24

Of course this level of improvement may not be indicative of a production
setup as one might expect timestamps to be operating out of multiple ports
on the device. However, even in that case an improvement is still likely
depending on the actual timestamp rates.

Fixes: d938a8cca88a ("ice: Auxbus devices & driver for E822 TS")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 309fa2877cc3..b0ea01cfcc4f 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -574,7 +574,7 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
 	pf = ptp_port_to_pf(ptp_port);
 	hw = &pf->hw;
 
-	if (!tx->init)
+	if (!tx->init || bitmap_empty(tx->in_use, tx->len))
 		return;
 
 	/* Read the Tx ready status first */

-- 
2.56.0.212.g129ede20d986

