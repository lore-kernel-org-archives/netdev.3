Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792489582;
	b=WQjSztTQ4x5/ov9gqJWY6LHz0xVcOigOHtZqIQ4FxrJjgSqDAfDnKgZJ5kRnH4QfXMyn
	 8epC06jSVvSpIJu6ksXm5wFwDQuDDDrmjYyRfPzHWrOJZ3ecq2ebVwPTMg+s6WUDHKds5
	 1I+T+PvQgp1WjVXaNwLiUffVNsLEekSp37WUzC2Snrg1jLDtthbU9LbDzVdOJR1/7tsU1
	 kJutobA0+KQ1Lm1OTgE1lPirv06l2kz5Lp4tze/i2NXL4ZlckJzkLGZi1wH/L4N9cxr1D
	 dPzp6jDKrYKHQYizYGvHFRXh7dEkMKEWdzycZCAgwSpMrraBzwU5AZ845UmzhXC8RMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792489582;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=Z/Pa94rFYlPtV3j48C83OMNuEjMwJ0fSIZ0h8P0yQq8=;
	b=CBTGYZz5q+U5N2AAUz/yOO8jUkf+sUmOi+5m5N/2I4CsRdEGWcYWrqPaJRVDJ65f3s1i
	 LvDymmQymViLA630RfOr9nwfP+kkkCRhLTMZQDy2qsWbtj0HngSGpZGOLrnUG1Yi9FAOT
	 fyZT+eTwe4tTn3NtNcDlaJJXvf34PKc2+itxYwv0qxzGDpfHp1EeDKw7/v0cthU3htRxL
	 udfwcYdrIaz6sqJCDJTqL3+tOHqU58cjU2glc9Inqcn6nH8SwM7uAlFZl7efSYdORLv6B
	 A13kVbKcjKpDoOycS8TPOyAP8jnRo23Mzh5nYfjmdNKl6AnOu+M0FbTAK86iDI3ftoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZHj1SFWx;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B92F60A2617
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 09:46:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B92F60A2617
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZHj1SFWx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792489580; x=1824025580;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=XsjetVIii/93DQtAsL6Rw9RDyeifpQ7+LPMqyDF+Rw8=;
  b=ZHj1SFWx8lLVpIAxSOzokg6AAjdW1zgsnfNRdP73SriK4TsFZhDpAVoW
   qL6KXJbtQtFulb3QuzCD2+TK4+NtzAIaP9tQygYsiA0RjZhQliCuGGbKe
   SSXJIqRoq6g/ijPwjxVYvAkFbPuNoZVJ6aR7IByXRr3ZS26vu/fih3Qjq
   K5ycd/+66u59dAe7RxzpShPRYO/28TInz5BioLC6IfTY7q69oalSTpkgZ
   askjCCUQalXVxDBRjVsqU30YWs+1G31vnHLu4uDgbDxSZp/QAXaBOZLUA
   aaFkZb+Oma6wtYtuA1CCoD6m3Swv3bTgNKdvN08fpafuSdrtSNkqc9Ft9
   g==;
X-CSE-ConnectionGUID: d2PSgtN5SmqhD7dIzPSexw==
X-CSE-MsgGUID: lr08zRh6QFWqeNoGHvV86Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1287927"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1287927"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 02:46:15 -0700
X-CSE-ConnectionGUID: nCx2AvZNRQy48fr5z4MNTg==
X-CSE-MsgGUID: b2sQCMc6S2qsLNoUqEzPmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2723916"
Received: from orcnseosdtnuc.amr.corp.intel.com ([10.166.241.20])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 02:46:15 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 20 Oct 2026 02:45:41 -0700
Subject: [PATCH iwl-net v4 10/13] ice: E825: perform a soft reset when
 starting the PHY timer
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
Message-Id: <20261020-jk-e825c-timestamp-processing-logic-fixes-srcu-v4-10-3e30fc9adc73@intel.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2050;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=XsjetVIii/93DQtAsL6Rw9RDyeifpQ7+LPMqyDF+Rw8=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqzrFvF7TzzUeirvff3iWWcVtobgb7bb1dlM1KtmLN9/+
 31PrU5ZRykLgxgXg6yYIouCQ8jK68YTwrTeOMvBzGFlAhnCwMUpABNRdWH4p9Xg81Vr8XRz3qOq
 UXGCr1rvuO9LN16rXs7Cu/i+1plVPYwMHxWLM87u3N9rdObcoiqWrXnali97HVOPvznx+/+EjZJ
 ubAA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

To ensure that the E825 PHY timer begins in a clean state, initiate a PHY
soft reset prior to programming the PHY. This ensures that we clear any
outstanding Tx timestamp memory, and ensures that the PHY internal state
including its timestamp counter has been reset.

Note that despite the name, this PHY soft reset only impacts the timer
block of the PHY, and not its regular Tx/Rx functionality. Additionally,
many configuration registers such as the PHY_REG_TS_INT_CONFIG and
PHY_REG_TX_OFFSET_READY are not reset.

Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products")
Reviewed-by: Maciek Machnikowski <maciej.machnikowski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 5637925c0e68..2d000251b185 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -2128,9 +2128,11 @@ int ice_stop_phy_timer_eth56g(struct ice_hw *hw, u8 port)
  * @hw: pointer to the HW struct
  * @port: the PHY port to start
  *
- * Start the clock of a PHY port. This must be done as part of the flow to
- * re-calibrate Tx and Rx timestamping offsets whenever the clock time is
- * initialized or when link speed changes.
+ * Perform a PHY soft reset and then start the clock for the PHY port.
+ *
+ * This must be done as part of the flow to re-calibrate Tx and Rx
+ * timestamping offsets whenever the clock time is initialized or when link
+ * speed changes.
  *
  * Return:
  * * %0     - success
@@ -2150,6 +2152,10 @@ int ice_start_phy_timer_eth56g(struct ice_hw *hw, u8 port)
 	if (err)
 		return err;
 
+	err = ice_ptp_phy_soft_reset_eth56g(hw, port);
+	if (err)
+		return err;
+
 	ice_ptp_src_cmd(hw, ICE_PTP_NOP);
 
 	err = ice_phy_cfg_parpcs_eth56g(hw, port);

-- 
2.56.0.212.g129ede20d986

