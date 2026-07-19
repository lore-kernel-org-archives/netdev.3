Received: from rcdn-iport-1.cisco.com (rcdn-iport-1.cisco.com [173.37.86.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54EE2F8E81;
	Sun, 19 Jul 2026 08:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784450718; cv=none; b=AyZs3rwKwwfBVg6T35xJ4REyXNyb/KN+q4auUkMC4UOYrNtwkV5GadMdsOB7v/Ih8EPEgU90fDAayzyeo+Ej6+Yj96SzCRn0RtR25yiPd1JlEL/Z+lMa3Qr63uVrrHVZ7y8PPPZ3tHpTQ3ox2tWvQThFUgP0kwfQKYPrXJZmt+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784450718; c=relaxed/simple;
	bh=Wz8F6wfgDYuYsjWvaq0nfBuoX9f5woDLyMTg1gEV52c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nlpFiGjhmRwx0X//tJXvcg3m5BbuiXeL6/tvMJrGqyRduetwCx2DYN0KRuCfq+EKo1MmOxzGHDa135X50pMyoKTP80CCmMyMC6pK88yWRMv4qHJPI3IO7GCPhxHWQpNnTvxd9wvLk58ccllcQiWLqevnih5hpPjRSxmBrP9jbEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=i5KG9jVH; arc=none smtp.client-ip=173.37.86.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="i5KG9jVH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=1225; q=dns/txt;
  s=iport01; t=1784450716; x=1785660316;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=9Vvmc0A1inRMr3zmhnwnNdpnC36sbR/RofUydw34CYw=;
  b=i5KG9jVHW1GOkHUgnlDGnWUy8rGNDSuDJN7r0ikSaoc93RfnsA6pnm19
   GTfgr0pZGRis1P8po9yn1Ilq0EtKtXoSz5iNK+nNuVVb2IXE92nBfTfAu
   4mo+bBvsFRwKHTugbnTKBxH7MQxVrymE90NyA7+tAp+Qg7yAI2l9uHzLr
   r7N+4M+ANxCuUX2eXylTI6SSSsh2eeGyLQ5T8QDirI6fmepIokDinoVOf
   Lq6GPNlQGE7XlXtfkYXWelY4MELHyH+QS/mgrPyH3aafBplul+8qkMGvd
   OWPZcZ7vCLRpNer0qvZj9RtRS/BlHszfHtkWUdmctp+vgxE3aPMCMCrMs
   w==;
X-CSE-ConnectionGUID: qh7vPOGJRqqOUhWXGdwKEA==
X-CSE-MsgGUID: XhRLJI28Suq31Qe7WwX7gg==
X-IPAS-Result: =?us-ascii?q?A0AmAAAEjVxq/5H/Ja1aHQEBAQEJARIBBQUBgXwIAQsBg?=
 =?us-ascii?q?laBUkNJhFeIG4c3giGeHhSBag8BAQEPUQQBAYUFAo1TAiY0CQ4BAgQDAgMBA?=
 =?us-ascii?q?QEBAQEBAQEBAQsBAQUBAQECAQcFgQ4ThlyGWwIBAyMEUhAlAiYCAkYQBgESg?=
 =?us-ascii?q?wKCdQO9C3p/M4EBhH3ZSIFmAQsUAYEKLgGFcIJrAYFwhAc7hEEnG4FJRIR+h?=
 =?us-ascii?q?CkBg3SCagSDHBKRbAk/gQIcA1ksAVUTDQoLBwVhUjMDIAoLEhIYFQIULw8EF?=
 =?us-ascii?q?jIdcAwnEiwXNFgbBwWBHX8WBCGBAoR2Ix8DOX+BMHVKdy1pARIXgS+CFIE6A?=
 =?us-ascii?q?gcDCxgNSBEsNwYOGQQ9AW4HjUAjgi8JB4EOFDiCV5ZhjV9roQ+EJ4FmoA8BM?=
 =?us-ascii?q?pdnkwUuh10JkHQjpDeEaYFoPIFZMxoIGxWDIlMZD44tFtI6JzI9AgcCBw4DC?=
 =?us-ascii?q?5FoBIF6AQE?=
IronPort-Data: A9a23:qd1zpq3ABNh0pCt1G/bD5Q5wkn2cJEfYwER7XKvMYLTBsI5bpzYEz
 WIdUGmDPf7bNmb9Lo9+Oti0800B6p/UyIQxSQo53Hw8FHgiRegpqji6wuYcGwvIc6UvmWo+t
 512huHodZ5yFjmH4E/xbtANlFEkvYmQXL3wFeXYDS54QA5gWU8JhAlq8wIDqtYAbeORXUXX5
 Lsen+WFYAX7g2EtYzpNg06+gEoHUMra6WtwUmMWPZinjHeG/1EJAZQWI72GLneQauF8Au6gS
 u/f+6qy92Xf8g1FIovNfmHTKxBirhb6ZGBiu1IOM0SQqkEqSh8ajs7XAMEhhXJ/0F1lqTzeJ
 OJl7vRcQS9xVkHFdX90vxNwS0mSNoUekFPLzOTWXcG7lyX7n3XQL/pGFUFpI7U/1cRNGHhpy
 PwnGB8BcTOurrfjqF67YrEEasULNsLnOsYb/3pn1zycVaZgSpHYSKKM7thdtNsyrpkRRrCFO
 IxDNGcpNUidC/FMEg9/5JYWh+60h2L/cD1wo1OOrq1x6G/WpOB0+OW0aoKPJ43QHa25mG6op
 lji3UWjUioHLYfG8DfazW2c2eDAyHaTtIU6UefQGuRRqFGa2GEWIBEfS1a+pf63lgi4Vs43A
 0gZ+zYnqoA++UaqR9+7WAe3yFaJsgMZUshdD8U17waCzqeS6AGcbkAHUzRIQN8rrsk7QXotz
 FDht9rvCSZir/6TRG6R+6m8qS60P24eLQcqfSYOQA0Ey8PurIE6klTESdMLOKq0iMDlXDL92
 TaHqAAgiLgJy80GzaO2+RbAmT3Ejp7EUgI4+C3JUW+/qAB0foioY8qv81ez0BpbBJySQl/Eu
 D0PnNKTqbheS5qMjyeKBu4KGdlF+sq4DdEVunY3d7FJythn0yfLkVx4iN2mGHpUDw==
IronPort-HdrOrdr: A9a23:uTH6864+h5HKxgHaswPXwD7XdLJyesId70hD6qm+c20wTiX+ra
 GTdZUguyMc5wx9ZJhNo7q90ey7MBHhHP1OjrX5Q43DYOCOggLBR72Kr7GSoAEIcBeTygcy79
 YET4FOTPD9ElR+i9/3+02bH8ZI+qj/zImYwcrT0HtpSxhncOVb7wl/AhuGCUEefnghOXNALu
 v62uN34xy9ZH8QcsO3QlMBX+TFupn3saiOW29/O/bigzP+9w9BL9XBYmOl4is=
X-Talos-CUID: 9a23:mglFqGGQwDZZSvOxqmJ+9BEKIucKUEfE1VDtI3CIJmp2a5C8HAo=
X-Talos-MUID: 9a23:yzy5+wgm7G3HGxWgu58oP8MpBMdSx4aPUhA2jIxd4vCJahNvC2iSg2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,172,1779148800"; 
   d="scan'208";a="512025920"
Received: from rcdn-l-core-08.cisco.com ([173.37.255.145])
  by rcdn-iport-1.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 19 Jul 2026 08:42:06 +0000
Received: from [127.0.0.1] (unknown [10.25.130.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-08.cisco.com (Postfix) with ESMTPS id ABFA818000472;
	Sun, 19 Jul 2026 08:42:04 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Sun, 19 Jul 2026 01:41:45 -0700
Subject: [PATCH net-next v12 01/12] enic: cancel tx_hang_reset work on
 device removal
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260719-enic-sriov-v2-admin-channel-v2-v12-1-6ff2c617001d@cisco.com>
References: <20260719-enic-sriov-v2-admin-channel-v2-v12-0-6ff2c617001d@cisco.com>
In-Reply-To: <20260719-enic-sriov-v2-admin-channel-v2-v12-0-6ff2c617001d@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, Sesidhar Baddela <sebaddel@cisco.com>, 
 Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784450523; l=1239;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=Wz8F6wfgDYuYsjWvaq0nfBuoX9f5woDLyMTg1gEV52c=;
 b=5XKYuKI506vAZNaNbnmHT4wQrP8Ib6GW49LUxyglbEAHgl2RMV0j0pwp4UUJ10pM8Xt2hMsnr
 eBuqdBk/z0EBVogVFAs7lpkgii2qcK+E7DoBwHpt8ekjio9g1DpfzhB
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.130.254];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.130.254, [10.25.130.254]
X-Outbound-Node: rcdn-l-core-08.cisco.com

enic_remove() cancels the reset and change_mtu_work items but does not
cancel tx_hang_reset.  A TX timeout that fires while the device is being
removed can schedule enic_tx_hang_reset() so that it runs after
free_netdev(), resulting in a use-after-free.

Cancel tx_hang_reset alongside the other work items before
unregister_netdev().

This is a pre-existing issue, not introduced by the SR-IOV V2 series;
it is included here as an independent fix.

Fixes: 937317c7c109 ("enic: do hang reset only in case of tx timeout")
Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index e7125b818087..b65796d96efc 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -3012,6 +3012,7 @@ static void enic_remove(struct pci_dev *pdev)
 		struct enic *enic = netdev_priv(netdev);
 
 		cancel_work_sync(&enic->reset);
+		cancel_work_sync(&enic->tx_hang_reset);
 		cancel_work_sync(&enic->change_mtu_work);
 		unregister_netdev(netdev);
 		enic_dev_deinit(enic);

-- 
2.43.0

