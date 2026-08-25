Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BEB4908AB
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 22:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787698511; cv=none; b=hqz36R7HHtn0oOcl42mck2z6/SXpDI59/HRhnTyqZBa26nmowOpTbTYDTxgLz7jcmXg56TYPpoyBTUxeVw9bQGqutCn7zE8y8jCaI9G8Fv4/X+2LexnwjwVq91IG87oRkqjfisBRbK5C0rbVZWoZtFH6HWlDqsl2Dn9zURb34xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787698511; c=relaxed/simple;
	bh=a99FOWCs/bYkfVBGeGgPD01SSReMylnTPDv5YtBzeVc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DzxoaWqQJ6mqHHh0tcuF3zKvmdOaoRuill5te0sKO9E2add+m3ATHIoNCKkb6ekYjpJhvJcEvsREQKoXpMNwnliLRtwkJ635c5JZPdklw/osOoDf3UpJFjfULbNRXylLdGskCkp4+Wv9N2opyJ/eNdyPO5jus1ArU0Oxh8ZzKXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I7tCfZOR; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I7tCfZOR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787698510; x=1819234510;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=a99FOWCs/bYkfVBGeGgPD01SSReMylnTPDv5YtBzeVc=;
  b=I7tCfZORbbKkqnSb7iav2rQRSa6oDinHwMHzYoIOgmrlgW4+/b/uL+p7
   IBOKk1OO5l+350fsrHWOMq6bg0YG2yZyeusfLIhL1FBZk+eZubdCGzTGg
   a+2CFvEozazkbwEqtTm+bUVcLvXvXHWqktMjNSIlkuDsNXx7ETP3qfFRf
   og4BT9fVXj6IqrP6oq+ZqciGryD9emIC7jDb6gBzeeZU0DdOl3Qw2G7gq
   iWfbHXZaY1ID+DANTWb0aEmb0gelhS5AiDJuJ3JDgOmUcXbp1Tk/Hye3x
   vH99CWk7RjWY7JIcr82+bbtoBa9ZA2qVLmUDwB0t2WrGs9rKNyDPq50hM
   A==;
X-CSE-ConnectionGUID: nINF5fRnSMCCOP0yCDFP+A==
X-CSE-MsgGUID: FmxSZvvfQxi0APeNiB8Tjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="87120426"
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="87120426"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 15:55:06 -0700
X-CSE-ConnectionGUID: 1CrmWsfjTx6o9PQX3SXUqQ==
X-CSE-MsgGUID: Mx03oinZQwWGg7qg4zNNUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="264789674"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 15:55:05 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 25 Aug 2026 15:53:29 -0700
Subject: [PATCH iwl-net v2 05/14] ice: E822: cancel offset verification
 work during reset preparation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-jk-e825c-minimized-fixes-v2-5-8223f95d26e3@intel.com>
References: <20260825-jk-e825c-minimized-fixes-v2-0-8223f95d26e3@intel.com>
In-Reply-To: <20260825-jk-e825c-minimized-fixes-v2-0-8223f95d26e3@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Cc: netdev@vger.kernel.org, 
 Maciej Machnikowski <maciej.machnikowski@intel.com>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, Petr Oros <poros@redhat.com>, 
 alexander.nowlin@intel.com, kevin.bross@intel.com, ranjit.cavatur@intel.com, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 Karol Kolacinski <karol.kolacinski@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, 
 Maciek Machnikowski <maciej.machnikowski@intel.com>
X-Mailer: b4 0.17-dev-c276d
X-Developer-Signature: v=1; a=openpgp-sha256; l=2262;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=K87Sta57oonzmfFQbJSMEr1vapfGSR0f3s8Z4O6rPj8=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqw+WRuLzL9yXWffv77wcAX3gnk5k6V0jltnr1hV/y3Kv
 Efwnd3rjlIWBjEuBlkxRRYFh5CV140nhGm9cZaDmcPKBDKEgYtTACZy7B4jw2tBnRVmvtt5uh7Z
 OE4xfS6jcSrZI4Lbdfb5rEXmByR+rWJkuPzmwsrNy3zn2jvemGySYJ5cm79sceSPdpfofK+CWNv
 PXAA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

From: Karol Kolacinski <karol.kolacinski@intel.com>

Cancel the offset verification delayed work (ov_work) during PTP reset
preparation to prevent it from running concurrently with the reset
sequence.

Without this, ice_ptp_wait_for_offsets() can execute during a reset,
find that ice_is_reset_in_progress() is true, and re-queue itself in a
tight loop. Meanwhile, the reset path in ice_ptp_rebuild_owner() calls
ice_ptp_port_phy_restart(), which starts a new ov_work. This results in
two ov_work instances running simultaneously, racing over the PHY offset
registers and the calibrating flag.

Cancel ov_work in ice_ptp_prepare_for_reset() alongside the existing
cancellation of the Tx tracker. The comment in the existing code already
documents that ov_work interference during reset is a concern but only
cancels it during ice_ptp_release().

Fixes: 4809671015a1 ("ice: Fix E810 PTP reset flow")
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
Reviewed-by: Maciek Machnikowski <maciej.machnikowski@intel.com>
Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index d018f02f700d..9bf3bac552f1 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2998,6 +2998,14 @@ void ice_ptp_prepare_for_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
 	if (reset_type == ICE_RESET_PFR)
 		return;
 
+	/* Cancel the offset verification work for E82x before releasing the
+	 * Tx tracker. If ov_work is running during reset, it may issue
+	 * sideband queue commands that will fail or timeout, and may
+	 * reference state that is being torn down.
+	 */
+	if (hw->mac_type == ICE_MAC_GENERIC)
+		kthread_cancel_delayed_work_sync(&ptp->port.ov_work);
+
 	if (ice_pf_src_tmr_owned(pf) && hw->mac_type == ICE_MAC_GENERIC_3K_E825)
 		ice_ptp_prepare_rebuild_sec(pf, false, reset_type);
 

-- 
2.55.0.814.gc42f45431d0f

