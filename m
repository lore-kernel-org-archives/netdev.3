Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D20278161
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 00:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787357711; cv=none; b=HtHOhfFEx4cHGeRhTTg2AuikN/fa7MvlJtJlUn9Ygt0M1PvJt5biKoTyic4BFy9+Dw/A+HGsHjyAgcHXGCX74ZHj4bIUs0/Lwk2kMlkGPizrt6Te7uHkqbR2+JF0X7pfXdF1qeYc+j1RG+lwI6aVDeuaCKsFz56Ms5HAyVFgh8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787357711; c=relaxed/simple;
	bh=JvDzS83PBknRIEyHfPW7Gn+NwkrtMco1LDnnUlRyC3E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bqF0XTGe99n4RXGLvNOil6FbhNqnz8Z9xpRD8UJX4Iuv03JMpBIlxDFMVS/dnyFvL8TxU2I55OJbyicZoTLnTbYKMjXsJszBvV2Bfi1pWKWq0YnUF+ASHLIGl+AyIeXIgyShV7+ZUOeqGI7fCTxLPfi3yYyJRBYgXV7D/ySVH8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Igvlycpl; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Igvlycpl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787357707; x=1818893707;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=JvDzS83PBknRIEyHfPW7Gn+NwkrtMco1LDnnUlRyC3E=;
  b=IgvlycpleS1y0TgaiwOn+ZPfx/WPE9ty96GOYbzRk9PQPKYePtfgFjZD
   MYgISxMvbdLwpqfanW97O15djza4i2S1PIucHXIlnx+ju0hQF6VSYOS93
   Gia6kOfha5Amsz/jBOElU2u1UGZtlyHfk2fThTFfrHBOcmsdKl133428P
   eNJMBTTNOVTutY3Mvmp5TlNEj4nrDzREVahCl2kEvGvxLCuXLQI4qXZXz
   jxt72zz3qwe5pO78wIqDSqE5VGkGZIvPGCs8uXNR1n/xEXEnBtCWorZXm
   9732wVbD8tluuHdrRIYPhzNKEv44Q4IMpdJRifxogdwj5tJ3nFBoIlUqz
   w==;
X-CSE-ConnectionGUID: lx/G/x1UQfOHko6sFIylpA==
X-CSE-MsgGUID: 2CW+l8HvR0mXPffrhIYB7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="91584788"
X-IronPort-AV: E=Sophos;i="6.25,236,1779174000"; 
   d="scan'208";a="91584788"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 17:15:00 -0700
X-CSE-ConnectionGUID: DfP/bP5iSiG0EAxGxbRTFw==
X-CSE-MsgGUID: sFCpXLl/SC+hpTr2RLymWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,236,1779174000"; 
   d="scan'208";a="263836497"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 17:15:00 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 21 Aug 2026 17:13:16 -0700
Subject: [PATCH iwl-net 11/12] ice: skip reading Tx ready bitmap on ports
 with no timestamps
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-jk-e825c-minimized-fixes-v1-11-9d0731eb4858@intel.com>
References: <20260821-jk-e825c-minimized-fixes-v1-0-9d0731eb4858@intel.com>
In-Reply-To: <20260821-jk-e825c-minimized-fixes-v1-0-9d0731eb4858@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Cc: netdev@vger.kernel.org, 
 Maciej Machnikowski <maciej.machnikowski@intel.com>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, Petr Oros <poros@redhat.com>, 
 alexander.nowlin@intel.com, kevin.bross@intel.com, ranjit.cavatur@intel.com, 
 Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.17-dev-75809
X-Developer-Signature: v=1; a=openpgp-sha256; l=2053;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=JvDzS83PBknRIEyHfPW7Gn+NwkrtMco1LDnnUlRyC3E=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqyOl7/PW999e3P11//P4w4Hskx1Fb4R2+3TKPKOO3NSo
 t/CYgG3jlIWBjEuBlkxRRYFh5CV140nhGm9cZaDmcPKBDKEgYtTACaSws7wm5X1Vfy1qH1PNrt8
 a/AqkMh9VaUppbCtsrnMbPULX43lFxgZlt02Y+Vg/OTRnzhjzunFP5+ca9HaIP335uHlyflnZb4
 XcQIA
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
without acquiring the lock. This is fine, as the only thread that can clear
in_use bits is the miscellaneous interrupt handler. Whether the thread sees
or fails to see a new outstanding timestamp does not affect correctness,
only determining whether or not it should do extra work.

Using the ice Tx timestamp traces, with a simple ptp4l setup the average
latency appears to be around 175 to 200 microseconds with a few outliers
taking hundreds of microseconds to be reported. With the check to skip
empty bitmaps (and thus skip reading the ready bitmap for inactive ports),
the average latency drops ~50 microseconds.

Fixes: d938a8cca88a ("ice: Auxbus devices & driver for E822 TS")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 8c2dd83d8d6c..b337247c94e0 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -573,7 +573,7 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
 	pf = ptp_port_to_pf(ptp_port);
 	hw = &pf->hw;
 
-	if (!tx->init)
+	if (!tx->init || bitmap_empty(tx->in_use, tx->len))
 		return;
 
 	/* Read the Tx ready status first */

-- 
2.55.0.814.gc42f45431d0f

