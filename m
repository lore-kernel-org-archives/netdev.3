Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793145966;
	b=JlP9PUD5fPXRK5jz3gDl6vT124UQ1JeNnKKkftz/WMCLP1e1cJ0gf0MP75s+XdGFb7fz
	 WJYtD9bWatjSshxDQrTExoqWcANQcut+Q8RuIZKXCW77JmORy6cl8aj7LTUuyM1sUWDJR
	 mk5QCsM7taltimwbhkiBPbjQVpDm+uPztSDgv4AJ4HWC6dVJn4vVPXMH/xyIrKoejZ7hn
	 B8lt3CPej4eELVhyIQttiM5frxYLmFwFeyAmBj6eAalNBVUkJskP+8hZ6BrPfBs9G9u0p
	 kjBTjTato8/8TJBdUf6azGnG4PbyWh2JSq0nT4vYC/nGZlI2+1NgE4AWGkcQR/+Qf3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793145966;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=8GOJvuCEbuV2nR0AuPtBQxJmpAQ5cgg2pekYcOBwkiE=;
	b=AOAbeWVDRSjXy7MGS9ExNpap+QSSD2Q3zOdUvtpH991TFrQ7Ea7j+BHXxaWrMf198UHi
	 T1WWhbpCdlVZCfO4cMJ8cbEggaVGmFEV2ywz6pM3/MmGsRZNGFT8ZFZ1ceZ6mKQrg+3BV
	 DhI72vKaJhi2XGDPdFLQQhxdORYRrGNhwk8IQnf1rBVYQuk4TUi67WhoHQEyFPiPexCAY
	 62EyCvZAtM265GKpNew01LsJ+oRo3OMjlFqLxQI1Z8EZ07nWM8jizIAEvQfyF/evuDvIZ
	 7a1S+ZJ1HbvFDE4NYWEFRMzIWQ9pZiy0Q6IU8K1DBLHRh7stvwycGu9Sk4V5wihMltA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HDIOVJ3p;
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759D0606A337
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 00:06:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 759D0606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HDIOVJ3p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793145966; x=1824681966;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=TPWYmFFfMDYnlSZgR1cADI3bAo3eLihUZh25CLiBa58=;
  b=HDIOVJ3pUFmGco2nQPsv34deqKgLYat+E292n2PVNmlzFcWAsvQRbgyi
   /Ob6g06yq8ujrbXkmioPFwUom+CJ135aiGQWH3eiYYbj0Ai5pc70CVy89
   aSr5cWncOq2sOkFso3s+3XZmbzsy7N88/JSOeJYL1RUZcq0VS2egFfEPe
   lh7jYt4ppBJsVK8BYZCgz+UmsN542FHuiqn/Rw+gCGAS/Y0OCJcX/0Sjp
   lmACYNKMNd9oufB54C+7eZqUB8N1b1NiFWswUE5vU5/VcEYm5Q/XmSW2u
   m3Xxf1969WZbPujGOte4n/TqbpTsuTNywLo+1FVd4ET/Ifa+LT2cB4Vl9
   w==;
X-CSE-ConnectionGUID: G9pdvaswTzitUl6eMbmB/g==
X-CSE-MsgGUID: fIM3lcbVTse/r+pStUYLTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1747232"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1747232"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 17:06:04 -0700
X-CSE-ConnectionGUID: /NKepUygTvqZPd0lKa/EvQ==
X-CSE-MsgGUID: IxLx+bXUTNqytmipafZHvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4776670"
Received: from orcnseosdtjek.amr.corp.intel.com ([10.166.28.128])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 17:06:03 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 27 Oct 2026 17:05:42 -0700
Subject: [PATCH net 6/6] ice: skip reading Tx ready bitmap on ports with no
 timestamps
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
Message-Id: <20261027-reduction-v1-6-81237c67a361@intel.com>
References: <20261027-reduction-v1-0-81237c67a361@intel.com>
In-Reply-To: <20261027-reduction-v1-0-81237c67a361@intel.com>
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
 bh=TPWYmFFfMDYnlSZgR1cADI3bAo3eLihUZh25CLiBa58=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqyHNsmmGm9cqzv2bxaXWfivdO0inc1mWlxv1CYKnNi7Z
 tYtzVmHOkpZGMS4GGTFFFkUHEJWXjeeEKb1xlkOZg4rE8gQBi5OAZhIThrDP439egIn2zekV3Bx
 i+j4t86vvJ7Vfajj8JX/LAr3MxzTghgZrk1hmxV7tGZLZ8vsbm1+/87Jt9Rnrfcy+cx8d99po11
 CrAA=
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
index 3ba6632bb196..ecfde5bbca9f 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -572,7 +572,7 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
 	pf = ptp_port_to_pf(ptp_port);
 	hw = &pf->hw;
 
-	if (!tx->init)
+	if (!tx->init || bitmap_empty(tx->in_use, tx->len))
 		return;
 
 	/* Read the Tx ready status first */

-- 
2.56.0.215.g47fdf2208c5b

