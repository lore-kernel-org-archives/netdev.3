Received: from aer-iport-7.cisco.com (aer-iport-7.cisco.com [173.38.203.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9827645D93E
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 20:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.38.203.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791578651; cv=none; b=bxKi+DDUm3PiEBhar/A2rpAX/u0CcoJa83ozE8FXHQTZ+OmtiiFmSGcQcdW4s6EMtqTj5f+zWx0BrqhiYSYBZuI4Gd42+TETZpbjLfuGKu/GVSXC0RA1hgkDXt1nf1l04Cin96Rg8yMxG3buUUuLcXDZKoj67UmMF4twgDTiCng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791578651; c=relaxed/simple;
	bh=2vCv+xnWCKK52dgF7ON0YQaLNmpQBCQ/32Z+tRlUkos=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RqyqkdaC3WfePqTZPENphOd013p/pIjSCPE9iDcy0lbxsWTVoP3UATK+Rk+5XZqVt4qJKfSNr08LzOIKU6hTEgrqQIwdS1BPFLW35JkHKV7KN/ho5iBTkjzhLpSLDmSyX5DwSH+5uyjCMBKV/+IkzpvJd7XX5YCsw7e9tDph4uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=WSFJdxY1; arc=none smtp.client-ip=173.38.203.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="WSFJdxY1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=1415; q=dns/txt;
  s=iport01; t=1791578649; x=1792788249;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MFj/mOELH4XfYRBDkKtBQzj+Kmx/9lRFQz4MOlN9PAc=;
  b=WSFJdxY15w1SXB/zA/wzmVIRM7gZ6pHFKaAlFBF6UFv1GN9L5g0oZNen
   vEhRZyPrHtG8LKtp9Enj+wrYcKvPSaElVmqbhuFRHj3vhC83ACpQKeI5D
   d/+McPSU09RKFx2TAxxZon99UvGUPAK/p1pc9XbsIwT7nErLchHJ5c2tj
   sho0htHsbYi5u1KcpclAfdWDzaGZxXSK14XcSh5pkm9Cd0GbvU8aQeZFR
   m3C8+URg3nov5s9Ql13KPuEyVHr6pLu0dpvPum6AUMo0sBS+gHylnVNHe
   wXeOed3+NonMsLL7ZhEGLbCvmJjpHWUpz5L1g1qOjwWcqbB9zlRfo3Pme
   g==;
X-CSE-ConnectionGUID: nZFgwp0WRs+HGQ2CBEhcGA==
X-CSE-MsgGUID: 97234tCDSk2KI6OzfUjZFg==
X-IPAS-Result: =?us-ascii?q?A0DAAgCuUclq/9RK/pBaHgEBCxIMggULgleBVkJJlkqeH?=
 =?us-ascii?q?RSBag8BAQEPUQQBAYUFjhQCJjUIDgECBAMCAwEBAQEBAQEBAQEBAQoBAQUBA?=
 =?us-ascii?q?QECAQcFgQ4ThlyQFSsLAUaBSAiDAoJ1A7w+gXkzgQHeSIFoAQsUAYE4jWOFc?=
 =?us-ascii?q?icVBn2BEIQPb4QFGgtmhXgEgiKBDIJdky5IgR4DWSwBVRMNCgsHBYFmAzUSK?=
 =?us-ascii?q?hVuMh2BIz4XgQcbBgWBHYEgghYjGTZ6gQlegSspYAEQF4EJggcCglSCAAIBS?=
 =?us-ascii?q?UEOB0VTCSVDEkcmIggSCQETGjALgRs4PAkoQRcMdAwKGA1IESw3FRkEPm4Hk?=
 =?us-ascii?q?Qkegh5DewkKlgaSRYE4n1qEKKFcGjOqb5kIpFqEaYFpATqBWU0jFTuCZ1MZD?=
 =?us-ascii?q?44uFtABPDU/BwIHDwKSBIFtAQE?=
IronPort-Data: A9a23:Dm+inK6tmuEaOb8yNfNvvQxRtCbGchMFZxGqfqrLsTDasY5as4F+v
 mFKXG7SOviKYTSmettwOY+yoxhTvpbTn4cwHQNlpSowZn8b8sCt6fZ1gavT04J+CuWZESqLO
 u1HMoGowPgcFyGa+1H1dOex9RGQ7InQLpLkEunIJyttcgFtTSYlmHpLlvUw6mJSqYDR7zil5
 5Wo/KUzBHf/g2QqazpMuvrZwP9SlK2aVA0w7wRWic9j5Dcyp1FNZLoDKKe4KWfPQ4U8NoaSW
 +bZwbilyXjS9hErB8nNuu6TnpoiG+O60aCm0xK6aoD66vRwjnVaPpUTaJLwXXxqZwChxLid/
 jniWauYEm/FNoWU8AgUvoIx/ytWZcWq85efSZSzXFD6I0DuKxPRL/tS4E4eO7829flvWV507
 r84BwlXRTquh+mZ6efuIgVsrpxLwMjDNY4F/3UlxjbDALN/GNbIQr7B4plT2zJYasJmRKqCI
 ZBENXwwMFKaOkcn1lQ/UPrSmM+hinjufjtXoXqepLE85C7YywkZPL3FboOEIIHSHZw9ckCw9
 z2cpDjlKT0hN4a86GSi4HyRhN3hknauMG4VPPjinhJwu3WawHATDxsHE1/9p/akm0O4c9NZN
 0EQvCEpqMAa7Fa5Q9zsRBmxvziHvwIHSddUO+w89AyJjKHT5m6xB24YQzoEd908ucNzQTUs/
 luIhM/yQzt0rbqOTTSa7Lj8hTW/JSQYM0ccaiIeCwgI+d/upMc0lB2nczp4OKe4lJjxXDr32
 T3P9XF4jLQIhslN3KK+lbzavw+RSlHyZlZdzm3qsqiNt2uVuKbNi1SU1GXm
IronPort-HdrOrdr: A9a23:jApRcqFZiK8YwZtLpLqE3MeALOsnbusQ8zAXPo5KJSC9Ffbo9f
 xG88506faZslwssRIb6LO90de7IE80nKQdieIs1NyZMzUO1lHEEGgb1+vf6gylPTHi/ehA0q
 olWa1/BNrsSWVet6/BkWyF+xJK+qjhzEhu7t2uq0tQcQ==
X-Talos-CUID: =?us-ascii?q?9a23=3AcIi6eGiP6dPFKHCbtQ+OcoayozJudE/zw2jIe3C?=
 =?us-ascii?q?CEiVJZ4TPYnW9+KhLup87?=
X-Talos-MUID: 9a23:FLvLLQYNcy2H4eBT5mC2321+H+tT4P6NKR4qg5s7ufuqOnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,149,1787011200"; 
   d="scan'208";a="61925001"
Received: from aer-l-core-11.cisco.com ([144.254.74.212])
  by aer-iport-7.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 09 Oct 2026 20:43:54 +0000
Received: from bgl-ads-6462.cisco.com (bgl-ads-6462.cisco.com [173.39.34.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by aer-l-core-11.cisco.com (Postfix) with ESMTPS id CFCA4180001C9;
	Fri,  9 Oct 2026 20:43:52 +0000 (GMT)
From: Aadityarangan Shridhar Iyengar <adiyenga@cisco.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	netdev@vger.kernel.org,
	adiyenga@cisco.com
Subject: [PATCH net-next] ixgbevf: Warn when mailbox API negotiation fails
Date: Sat, 10 Oct 2026 02:13:46 +0530
Message-Id: <20261009204346.11223-1-adiyenga@cisco.com>
X-Mailer: git-send-email 2.35.6
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-Client-TLS: ANONYMOUS;bgl-ads-6462.cisco.com [173.39.34.78];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 173.39.34.78, bgl-ads-6462.cisco.com
X-Outbound-Node: aer-l-core-11.cisco.com

ixgbevf_negotiate_api() tries supported mailbox API versions from newest
to oldest. If all attempts fail, it continues without reporting the
failure, leaving the API version at its reset default. This makes mailbox
communication failures difficult to diagnose.

Warn when the version list is exhausted and include the error from the
final attempt. Do not warn about individual failed attempts, since a PF
rejecting a newer version before accepting an older one is expected.

This is a diagnostic improvement only; negotiation, fallback and recovery
behavior remain unchanged.

This is a diagnostic improvement only.

Signed-off-by: Aadityarangan Shridhar Iyengar <adiyenga@cisco.com>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 7ce46b4b4821..76c9ac3ac69a 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -2344,6 +2344,10 @@ static void ixgbevf_negotiate_api(struct ixgbevf_adapter *adapter)
 		idx++;
 	}
 
+	if (api[idx] == ixgbe_mbox_api_unknown)
+		netdev_warn(adapter->netdev,
+			    "Mailbox API negotiation with PF failed: %d\n", err);
+
 	ixgbevf_set_features(adapter);
 
 	if (adapter->pf_features & IXGBEVF_PF_SUP_ESX_MBX) {
-- 
2.35.6

