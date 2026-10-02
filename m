Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CA647F3AE;
	Fri,  2 Oct 2026 10:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790935247; cv=none; b=rFzrIo8xrQCNzIz5xOlX5ux1/+KE9FXjhy0/fJoAw9YrYEQRzDXdqoCeb8BE+H4OEoX8etLjGuhZky2PcSO8G0MeiOCL2bcp7+EGkG5RJa8AhH54rElqMymUfCKKn3a7nWL1SMW5GVYkqoMO4bJLAq7xr02/0yY7kv2aghe2/UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790935247; c=relaxed/simple;
	bh=E/aONn2SlVFmx520yzRdIWKAL2vHgqm+IjN3aDrSRAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kv3FtVSEqxbZV3oHtx9J4+TNwMHGT5hxSvYtnIykZd4Xfnbsm2hLARMKHmEYM14b+DaHxVjGTvCpupSpNJ9pK0Yzgsoa2MetwKohtJ0rrlXtF3brLikBWICw/ngJaCVXmmrkxAb9FnY/WcKXsXA036y20ISb2N93aMbhKXTCbBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ep0a1yXV; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ep0a1yXV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790935246; x=1822471246;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E/aONn2SlVFmx520yzRdIWKAL2vHgqm+IjN3aDrSRAs=;
  b=Ep0a1yXVCSMrRQFwXxifuRHehgs2vrNy1KNgY6g6B/cdG0QkEiNVwa57
   1OTOLzw9dzPkMyiiTuh2h0I3nl3A0rlr5mP4fHPRLxfKkEuMC1TqWBLt7
   F9sa2gvMYgeX5Q4i4D149fRIkpOMY3bhtr22pkZi+oP8y32SmxaPHVtkf
   gVhL3g/KF0SeIfgpi5mWCOo+CKtBqUajgWMkJhs4r42HvulIptWnZWOIj
   TSP7gLEVJsTL+kDU39XwZnPpFZWYwf3PT7ui9cxQlBn/q5wGlaz0DjbdW
   hxfYIdsxfWTddBH4zJ4DWol/sXyDk6VusxqCR6Ti+fj1+/m2/u6JI8MZp
   g==;
X-CSE-ConnectionGUID: rWayf470RSS+6DDEVgxk+w==
X-CSE-MsgGUID: cmXrPHHJT8qBAew7rrRciw==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="113484712"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="113484712"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 03:00:43 -0700
X-CSE-ConnectionGUID: nqny98MISRyeURU7ttyxBg==
X-CSE-MsgGUID: uJpgmZvJQ0yOelQGcZnb6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="279959905"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa005.jf.intel.com with ESMTP; 02 Oct 2026 03:00:41 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 5CDA6A2; Fri, 02 Oct 2026 12:00:36 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Wen Gu <guwen@linux.alibaba.com>,
	Philo Lu <lulie@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH net-next v2 5/5] eea: Use 2-argument strscpy()
Date: Fri,  2 Oct 2026 11:59:23 +0200
Message-ID: <20261002100035.863275-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261002100035.863275-1-andriy.shevchenko@linux.intel.com>
References: <20261002100035.863275-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andy Shevchenko <andy.shevchenko@gmail.com>

Use 2-argument strscpy(), which is not only shorter but also provides
an additional check that destination buffer is an array.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/net/ethernet/alibaba/eea/eea_adminq.c  | 4 ++--
 drivers/net/ethernet/alibaba/eea/eea_ethtool.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/alibaba/eea/eea_adminq.c b/drivers/net/ethernet/alibaba/eea/eea_adminq.c
index f493afbcc41b..942f1f1911af 100644
--- a/drivers/net/ethernet/alibaba/eea/eea_adminq.c
+++ b/drivers/net/ethernet/alibaba/eea/eea_adminq.c
@@ -512,8 +512,8 @@ void eea_adminq_config_host_info(struct eea_net *enet)
 	cfg->pci_bdf            = cpu_to_le16(eea_pci_bdf(enet->edev));
 	cfg->pci_domain         = cpu_to_le32(eea_pci_domain_nr(enet->edev));
 
-	strscpy(cfg->os_ver_str, utsname()->release, sizeof(cfg->os_ver_str));
-	strscpy(cfg->isa_str, utsname()->machine, sizeof(cfg->isa_str));
+	strscpy(cfg->os_ver_str, utsname()->release);
+	strscpy(cfg->isa_str, utsname()->machine);
 
 	err = eea_adminq_exec(enet, EEA_AQ_CMD_HOST_INFO,
 			      cfg, sizeof(*cfg), rep, sizeof(*rep), NULL);
diff --git a/drivers/net/ethernet/alibaba/eea/eea_ethtool.c b/drivers/net/ethernet/alibaba/eea/eea_ethtool.c
index 479779aa2dd8..15f4c7b2d898 100644
--- a/drivers/net/ethernet/alibaba/eea/eea_ethtool.c
+++ b/drivers/net/ethernet/alibaba/eea/eea_ethtool.c
@@ -40,8 +40,8 @@ static void eea_get_drvinfo(struct net_device *netdev,
 	struct eea_net *enet = netdev_priv(netdev);
 	struct eea_device *edev = enet->edev;
 
-	strscpy(info->driver,   KBUILD_MODNAME,     sizeof(info->driver));
-	strscpy(info->bus_info, eea_pci_name(edev), sizeof(info->bus_info));
+	strscpy(info->driver, KBUILD_MODNAME);
+	strscpy(info->bus_info, eea_pci_name(edev));
 }
 
 static void eea_get_ringparam(struct net_device *netdev,
-- 
2.50.1

