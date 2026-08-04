Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D655E378D6B
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 22:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785882140; cv=none; b=lAevCncgVNf8Bw7Vb/ZtmQ1hfGQGpKi3QBWHmqJvsp34MxfbHhtD8fCexjnPHWcPRigcgIuijB8yt5CEk8qbtFdgDM6cZq1TehOvltIfBpMW7GnkIFnyrxrgrfC6Vo5B2lOdj5vq30ec3FRptD0EGPTKFd28Pc5//pQ6TappWco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785882140; c=relaxed/simple;
	bh=0rYOLMo4ukcedW9FgwPW5csDLI8wptNpe3twaodXtuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MsVr5YWbjIWuz0aaVUH4Rv416SnoSkHZaHIyK8lBzc9XL6wn0Ay2J4uBFdOGTo5bez402fe5GB4rLiTVl4oSSlQQx6T1z4MMMo8Uht4LXLnNb8QnUML4aZDqVHiCLv2E8nSQ3pdxBM4FR2peDTe6AFEfs7sF6994iSU747FWYOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PqCNWFdM; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PqCNWFdM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785882139; x=1817418139;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0rYOLMo4ukcedW9FgwPW5csDLI8wptNpe3twaodXtuE=;
  b=PqCNWFdMiTpPTmJ0jvYPkVoz4nIfzRSl5+IsooO62v+EO8aU7V32GNRx
   Dcc2pvjLiok5Wq0yEeggse1tERg4gtXuGy+zRBoReI8Ua3exvqTLsfoTf
   odkB3eIYqbURbSwBM5ZRhkwZ+TdKAoiYFbkr+O0232/f66F5ed1AoNe+k
   rrwUliwhQECKKz4mepjZV2uVc3qiZZPHrpOpnwkEUidJuzkMI58V65B5x
   jXS4I3e+9bwatS62CBOVAEb2G7uZeALBEgEvUWYbMdx9roGsww41Ip75n
   CEQE5IL+HsSIkS8SJN1qoDAQMgFvKxZFm/vCZR/VYYGSd/rZyZ4TBxpEJ
   w==;
X-CSE-ConnectionGUID: mmDzOopZTr62KLgYABHWXQ==
X-CSE-MsgGUID: LxuarDeDRO+BFTuITyrBdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="96803405"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="96803405"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 15:22:17 -0700
X-CSE-ConnectionGUID: c9ruN2aRSfimh0vU/+Fgig==
X-CSE-MsgGUID: coRzY52aRK27/FiCgwH6Ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="257307956"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa006.fm.intel.com with ESMTP; 04 Aug 2026 15:22:16 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
	anthony.l.nguyen@intel.com,
	jacob.e.keller@intel.com,
	aleksandr.loktionov@intel.com,
	rafal.romanowski@intel.com,
	horms@kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net 01/10] iavf: return EBUSY if reset in progress or not ready during MAC change
Date: Tue,  4 Aug 2026 15:21:54 -0700
Message-ID: <20260804222205.1580328-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260804222205.1580328-1-anthony.l.nguyen@intel.com>
References: <20260804222205.1580328-1-anthony.l.nguyen@intel.com>
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
index 29b8403a066b..630388e9d28c 100644
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

