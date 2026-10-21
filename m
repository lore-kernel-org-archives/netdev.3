Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792620822;
	b=CkP1xc0YhJwy4ndeyu1hcKZFPbvRGrBtgX/+KFzPVznzGZU0M7xY52FEau3Pw1gCWBlj
	 7DG2jto7ghS+zKqxcLIuKqBb25t9OwGgfoNy+KKzTtuk+T51qy2tkmSBoWIFjBrcnAzoL
	 aAX/ir8FZ0uDOZVw510J1U18ouldSR/Ufwx2suIl7LyP498KDJMmdcRKoYG2yBbsJtMB8
	 pLctOCfyH1YtIS1+OaXqc+prsg0XfLV5+x0iJ1SuBRgnbBD86CrR3BBU66vMDxpS9XelX
	 QX+vJToRU1AXD77ic3j7fEKbWs0weTZoPGNdC9ZB1SBoEPy3aQw+Jbbwqxev46mFtSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792620822;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=40ngp+o3wkVyzuCqy8jYvTbJZDNfdfTCNBfgR0/3LIc=;
	b=n6aD+3s9pe4bhSz0BFfOWnXOsEMY6SMSFwpOnio4M+5iq3EJ098dHCNtFzLst6WTfpSl
	 BE485TkUMoq/oSFFFGgYdX5D6Au1S6iyAnG9Hnn1kEddildkk3IsEhEyBV7Sv1e5E9fal
	 QeDaAkJK03OYjGssx08DSxEn6R86Kwl53ge7A/7RIfvAirhvnBFVUNz8Ib2ZC1mHVvY3U
	 CD4mEqwp+DeoRCFbf+LXuk0KzLaw5vftkKdi7cqd7LwRkJ6MjvhoyqEHorJ/krbn1i5/M
	 ur9ryrO0xhrohPnee/XPQxLBHQPZAfQt5FhE3ngCZnPw6NaBneQWS9DjxRO0EaT6bfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=R8gohqi+;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D785B606A323
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 22:13:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D785B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=R8gohqi+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792620818; x=1824156818;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=7Oyw+MBD/YlH+xn/wMnkU59QtXDXpP9/dLkY2Q7Afrs=;
  b=R8gohqi+ZIgWG8PI3Tz2m8K2OXi3QnjpBnhFvB6lqSrSQfy/dgpyngsu
   mJRgUraLc5/OWmAHV4o36bhkawVNxLrvVZ6/njMG8PuXgeeul7k8q2+Df
   oIalXU5lliTXp5hf43rEUbdtvXK0nQS8/9BYnw2Q6xtClqO+4H8ora2nc
   EQ6pNR6wSYlDPRsZVkbHZfZScT/5HdCyHkPBk7dibt2VzmYzD8vcDJy0r
   FxPfKLA7QAwEXLs3jCzEnQugpkfoKeY/NUvZxrgkefaOn27Yx6TN++zOO
   hzf+wUQm5w9kSvLM5dFEb0cul13W1RYFyFqIK/Y+po5uBV8SLrdsk1Bkh
   A==;
X-CSE-ConnectionGUID: stCRfPRRRr29B4ag1P25Bg==
X-CSE-MsgGUID: 1A74clFgSn2xf2ZeDa0iEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1363237"
X-IronPort-AV: E=Sophos;i="6.27,171,1787036400"; 
   d="scan'208";a="1363237"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 15:13:14 -0700
X-CSE-ConnectionGUID: hdY70rnRQrq7cTuks15BQw==
X-CSE-MsgGUID: Qak6URyfSh2nO5lLp2I+Ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,171,1787036400"; 
   d="scan'208";a="3275494"
Received: from orcnseosdtnuc.amr.corp.intel.com ([10.166.241.20])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 15:13:12 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 21 Oct 2026 15:12:57 -0700
Subject: [PATCH net v5 12/13] ice: skip reading Tx ready bitmap on ports
 with no timestamps
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
Message-Id: <20261021-jk-e825c-timestamp-processing-logic-fixes-srcu-v5-12-72289a4ac8eb@intel.com>
References: <20261021-jk-e825c-timestamp-processing-logic-fixes-srcu-v5-0-72289a4ac8eb@intel.com>
In-Reply-To: <20261021-jk-e825c-timestamp-processing-logic-fixes-srcu-v5-0-72289a4ac8eb@intel.com>
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
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqybFh8Cngs8nSJ3mN90mYZ3/tasU+8K+NL/zJltJe7bJ
 X3CV529o5SFQYyLQVZMkUXBIWTldeMJYVpvnOVg5rAygQxh4OIUgIlsNGL4H/1t8r94n28Zx//M
 f2x96Oqziftn/H7AfepXmdyV2T9EvtgxMty0iWFjaTy69cyWNQ3bc5wefPI5267rekKJr+2/jv6
 rR9wA
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

