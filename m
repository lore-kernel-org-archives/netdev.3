Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C863A5426
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 18:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779302112; cv=none; b=k7rIuw6wRQAxzEC/e17NPUM4WFM/sdMSGzeRPDidID9iuQ3VcrzX6PhYHoL0eap68zJd1LcNSuFjs3A9Ic247uDDSAf37Hy+HWH4AHXy1TWKBRexhIxyXkQSoWfcBQYUqnkyekeItM9E8PGl7dTfnvAjH2xovWMhyLdsnOafaQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779302112; c=relaxed/simple;
	bh=xUGR7Z+W+6HPvyU9z5uuXhcelpLD7nwrHH0gFgBWfqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rb9MsG9QyKVpEYVQK30vuiqP6wWZwb3YsNoRzcAX1Ys0GixFc6ruuHbsdA5L+0pX0h/GCb2w6h5xsTmOYTc4kd/Hi5ZooKlKhmNCp3TptEEgTQdR6uwQaFj2pwZVItedifzaPEL+TuK5BS90t8HmWTG9Y52yxmRVcKqAFBLMWHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iqC9g8gn; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iqC9g8gn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779302110; x=1810838110;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xUGR7Z+W+6HPvyU9z5uuXhcelpLD7nwrHH0gFgBWfqw=;
  b=iqC9g8gnsnHRnv2Sdq+M+E2fQ/W4AaTEuAcUeyPFUYY64USbKoPGHdX8
   Hooi1KtoCgn1tZIvriIG9xBbcwR2j9VGvwILtHXaUPIP7jX+aH9Toms4i
   OZW7EqXqCPZVimvX+f3wy3FK+MGoNGYNP6BZxYXB1sGjzkzaZWyYbVgO5
   MRZoZnBSJ9JgqWjV1Ws7SDWLFcSiTm0zYTwWHlKrV4VU/AS1CyG1mA8c4
   /YW75mFH4MPdTenz8YpmjU7+LFTDssPo1trQaqXw2TXMwjTri+bcv6ATH
   wE+yS+YmpugopnHtpm4n8JMxLm5WnjhvQhrVXcCgdBfDrz6KfdZ1SusHd
   w==;
X-CSE-ConnectionGUID: JELWnI4NQ7aVRkfYW1wRgA==
X-CSE-MsgGUID: p6g5vNM5SqybUdnU57Djfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="80391757"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="80391757"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 11:35:08 -0700
X-CSE-ConnectionGUID: fJq7y32JRkiROxL7f7pDkQ==
X-CSE-MsgGUID: DC0rtfXdR7ODHxQdMXpW9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="239423892"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 20 May 2026 11:35:08 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com,
	horms@kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net 3/8] iavf: return EBUSY if reset in progress or not ready during MAC change
Date: Wed, 20 May 2026 11:34:51 -0700
Message-ID: <20260520183501.3360810-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260520183501.3360810-1-anthony.l.nguyen@intel.com>
References: <20260520183501.3360810-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

When a MAC address change is requested while the VF is resetting or still
initializing, return -EBUSY immediately instead of attempting the
operation.

Additionally, during early initialization states (before __IAVF_DOWN),
the PF may be slow to respond to MAC change requests, causing long
delays. Only allow MAC changes once the VF reaches __IAVF_DOWN state or
later, when the watchdog is running and the VF is ready for operations.

After commit ad7c7b2172c3 ("net: hold netdev instance lock
during sysfs operations"), MAC changes are called with the netdev lock
held, so we should not wait with the lock held during reset or
initialization. This allows the caller to retry or handle the busy state
appropriately without blocking other operations.

Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index d2914c511e1e..78c59a58e0b2 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -1042,6 +1042,9 @@ static int iavf_set_mac(struct net_device *netdev, void *p)
 	struct sockaddr *addr = p;
 	int ret;
 
+	if (iavf_is_reset_in_progress(adapter) || adapter->state < __IAVF_DOWN)
+		return -EBUSY;
+
 	if (!is_valid_ether_addr(addr->sa_data))
 		return -EADDRNOTAVAIL;
 
-- 
2.47.1

