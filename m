Received: from rcdn-iport-2.cisco.com (rcdn-iport-2.cisco.com [173.37.86.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A232736D4E1;
	Sun, 19 Jul 2026 08:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784450596; cv=none; b=KVG/jPxpkrVLYCpmr5fPhiMk9sBRRH5KZXar4498ptYs7jr0cC0//2gXr3iTNYzjfJtuIriFmtVdh/6IfiQaXd2x8+ouWXanSYUFlT7t8H3z2EMQVMCV2eKCHOsC5gsJa54LujQb4+6MF5DtmN8jnr36ZXu7a14mSP2Wc6oLSD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784450596; c=relaxed/simple;
	bh=IsES+n+TKvyj9aUMCeVzccPUfuHCV8lfNTLLbzVDWrg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mEALKQdz2XHWdzyQjQwImXqvi1POLvZXDxMLkMPqn6DC1+PL1SiYXIK7KPsvsLxapPwmOxYYqTLzewuE1Pu+q0vgKKE7tkcoauk07KJ0w1tUXfPM0jRCBhpTZD6j4uATrsAYnpEk3JAGDcgnRgP+u3vSUl6WGEWAk34j2lxmS1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=PehwJYm2; arc=none smtp.client-ip=173.37.86.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="PehwJYm2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=2833; q=dns/txt;
  s=iport01; t=1784450594; x=1785660194;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=VOP1yf0LvjOJU23ulXauD+xcRUgLPP0kWs2v2oK4H8E=;
  b=PehwJYm2l4N2UltXxdLhmBZoUM7YAYuhd92bFwHr5vbHemcIAmHGZaoV
   Rji1kBJc8+qNPIM2IYcd6SnK5j/K3RvIzaJL9E5VT0Mp42nUl8+Y5jbhK
   oYCMwmWOBe3Q1Kdl++cMVALMXiExObcgkGgEqwRGUvClWEfpoTN1OzJfi
   o7f4vBMOb7gU8xVo7iioLDCx3kc6SdFPx9gfakmrMeZraSLs3Q0F5tr70
   s1qv5BibxJf9XOcLRq2zI3f51WuMXa+v5hSVeoTQcRLxzqXM+pmNgyuvW
   IMywUtpv/f09hwm8T2E2ZMihfB91IHfbq00qeCmNV3GVrlW2qxjkEO3rd
   g==;
X-CSE-ConnectionGUID: DaPteFQkTKye5CXSUxZXXA==
X-CSE-MsgGUID: XjZUp4fNQZ+ICat/KETKNA==
X-IPAS-Result: =?us-ascii?q?A0BFAgBUjFxq/5H/Ja1aHgEBCxIMggULgleBUkNJhFePU?=
 =?us-ascii?q?oIhnh6Bfg8BAQEPUQQBAYUFAo1TAiY0CQ4BAgQDAgMBAQEBAQEBAQEBAQsBA?=
 =?us-ascii?q?QUBAQECAQcFgQ4ThlyGWwIBAyMEUhAlAiYCAkYQBgESgwKCdQO9CXp/M4EBh?=
 =?us-ascii?q?H3ZSIFmAQsUAYEKLoVxgmsBgXCEBzuEQScbgUlEgRWDaYQKhBSCagSDHBKRb?=
 =?us-ascii?q?Ak/gQIcA1ksAVUTDQoLBwVhUjMDIAoLEhIYFQIULw8EFjIdcAwnEiwXNFgbB?=
 =?us-ascii?q?wWBHX8WBCGBAoR2Ix8DOX+BMHVKdy1pARIXgS+CFIE6AgcDCxgNSBEsNwYOG?=
 =?us-ascii?q?QQ9AW4HjUAjgU5xPVKCPykpk0CDMo1fa6EPhCeBZqAPATKXZ5MFLJhcI6QAN?=
 =?us-ascii?q?4RpgWg8gVkzGggbFYMiUxkPji0WHNIeJzI+AQcCBw8CgXOQAIF+AQE?=
IronPort-Data: A9a23:uRSOyqOjsnoIQgfvrR14lsFynXyQoLVcMsEvi/4bfWQNrUpz0TMHy
 WNOC2GHa/fZYGX0LookaoS380wDsJLSmNRhS3M5pCpnJ55oRWUpJjg4wmPYZX76whjrFRo/h
 ykmQoCeaphyFTmE+kvF3oHJ9RFUzbuPSqf3FNnKMyVwQR4MYCo6gHqPocZh6mJTqYb/WV7lV
 e/a+ZWFZgf6gm8sawr41orawP9RlKWq0N8nlgRWicBj5Df2i3QTBZQDEqC9R1OQapVUBOOzW
 9HYx7i/+G7Dlz91Yj9yuu+mGqGiaue60Tmm0hK6aYD76vRxjnBaPpIACRYpQRw/ZwNlMDxG4
 I4lWZSYEW/FN0BX8QgXe0Ew/ypWZcWq9FJbSJSymZT78qHIT5fj69lnNF07E7QbxsVmDDxlx
 cclOAI9XjnW0opawJrjIgVtrt4oIM+uOMYUvWttiGmJS/0nWpvEBa7N4Le03h9p2ZsIRqmYP
 ZdEL2MzMXwsYDUXUrsTIIk3gOazhnr/WzZZs1mS46Ew5gA/ySQtgei1bYCFJ4TiqcN9rkSqm
 3qa8ULAMFI7H9WDjhmozlGKr7qa9c/8cMdIfFGizdZmiUOew0QfAQMbUF+8r+X/jEOiM/pbJ
 k0I8y0GoaU49UWtCN7nUHWQrXKZuxcOVsZ4HOo95wWAjKHT5m6xBXUORxZCZcYguctwQiYlv
 neAmd/zCCMstrCJRX+D3rOJqzX0Mih9BXcLbyICTCMf7tXjqZ11hRXKJv5nEaionpj2FCv2z
 jSisicznfMQgNQN2qH9+krI6xqqq4TFQxAd+AraRCSm4xl/aYrjYJangWU39t5aJ4qfC13Et
 38elo3GvKYFDIqGk2qGR+Bl8KyV2stp+Qb02TZHd6TNPRz2k5J/Vei8OA1DGXo=
IronPort-HdrOrdr: A9a23:C3eVvKror7bkWpYhAq8s5G0aV5rdeYIsimQD101hICG9vPbo8/
 xG+8576faUslgssR4b9OxoVJPrfZqYz+8W3WBzB9iftXfd2FdARbsKheDfKn/bak7DH4VmuZ
 uIHZIObeHYPBxWgdn35Q+gH81l4tWWmZrY/Nv2/jNBQR5nbqd44xw8MAaUFUVqWBJLbKBJcq
 Z0nvA3wAaISDAwctmxAGUDUqzoot3Gk4+jXDs9biRXkDVnSViTmcTH+9/y5GZkbw9y
X-Talos-CUID: =?us-ascii?q?9a23=3A4g/sSWsTHH1W7GmNgauBuHIx6IsJe0XBwVnpIHO?=
 =?us-ascii?q?bGGs0Y42udE+iyJNNxp8=3D?=
X-Talos-MUID: 9a23:H6kdIAuAotdOV5yV982ntDNQCd807YKXOgMsupwa/OqpCQ9WEmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,172,1779148800"; 
   d="scan'208";a="498052850"
Received: from rcdn-l-core-08.cisco.com ([173.37.255.145])
  by rcdn-iport-2.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 19 Jul 2026 08:42:06 +0000
Received: from [127.0.0.1] (unknown [10.25.130.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-08.cisco.com (Postfix) with ESMTPS id 7218218000475;
	Sun, 19 Jul 2026 08:42:05 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Sun, 19 Jul 2026 01:41:46 -0700
Subject: [PATCH net-next v12 02/12] enic: verify firmware supports V2
 SR-IOV at probe time
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260719-enic-sriov-v2-admin-channel-v2-v12-2-6ff2c617001d@cisco.com>
References: <20260719-enic-sriov-v2-admin-channel-v2-v12-0-6ff2c617001d@cisco.com>
In-Reply-To: <20260719-enic-sriov-v2-admin-channel-v2-v12-0-6ff2c617001d@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, Sesidhar Baddela <sebaddel@cisco.com>, 
 Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784450523; l=2882;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=IsES+n+TKvyj9aUMCeVzccPUfuHCV8lfNTLLbzVDWrg=;
 b=S9m0uBg25fHJ3aQrrVhBaJi/zO3mfBXzmTTt1NndEONBULy/mYYNW99UAc8Z/sCM6MWSHAmhi
 4kchWvJIkfOBBuEMu4TXjX52BmdJ/yXPgxFLak4fr3FJl24706P5jTV
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.130.254];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.130.254, [10.25.130.254]
X-Outbound-Node: rcdn-l-core-08.cisco.com

During PF probe, query the firmware get-supported-feature interface
to verify that the running firmware supports V2 SR-IOV. Firmware
version 5.3(4.72) and later report VIC_FEATURE_SRIOV via
CMD_GET_SUPP_FEATURE_VER. If the firmware does not support the
feature, set vf_type to ENIC_VF_TYPE_NONE and log a warning so the
admin knows a firmware upgrade is needed.

The V2 admin-channel and MBOX bring-up added later in this series is
gated on ENIC_VF_TYPE_V2, so this downgrade keeps those paths from
running on firmware that does not support V2 SR-IOV.

VIC_FEATURE_SRIOV is assigned the explicit value 4 to match the
firmware ABI.  Slot 3 (firmware's VIC_FEATURE_PTP) is reserved with
a comment rather than a placeholder enum entry, since PTP is not
used by the upstream driver.

Suggested-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Satish Kharat <satishkh@cisco.com>
Reviewed-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/cisco/enic/enic_main.c   | 21 ++++++++++++++++++++-
 drivers/net/ethernet/cisco/enic/vnic_devcmd.h |  2 ++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index b65796d96efc..6992411bd3b5 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -2641,8 +2641,10 @@ static void enic_iounmap(struct enic *enic)
 static void enic_sriov_detect_vf_type(struct enic *enic)
 {
 	struct pci_dev *pdev = enic->pdev;
-	int pos;
+	u64 supported_versions, a1 = 0;
 	u16 vf_dev_id;
+	int pos;
+	int err;
 
 	if (enic_is_sriov_vf(enic) || enic_is_dynamic(enic))
 		return;
@@ -2669,6 +2671,23 @@ static void enic_sriov_detect_vf_type(struct enic *enic)
 		enic->vf_type = ENIC_VF_TYPE_NONE;
 		break;
 	}
+
+	if (enic->vf_type != ENIC_VF_TYPE_V2)
+		return;
+
+	/* A successful command means firmware recognizes
+	 * VIC_FEATURE_SRIOV; supported_versions is available
+	 * for sub-feature versioning in the future.
+	 */
+	err = vnic_dev_get_supported_feature_ver(enic->vdev,
+						 VIC_FEATURE_SRIOV,
+						 &supported_versions,
+						 &a1);
+	if (err) {
+		dev_warn(&pdev->dev,
+			 "SR-IOV V2 not supported by current firmware. Upgrade to VIC FW 5.3(4.72) or higher.\n");
+		enic->vf_type = ENIC_VF_TYPE_NONE;
+	}
 }
 #endif
 
diff --git a/drivers/net/ethernet/cisco/enic/vnic_devcmd.h b/drivers/net/ethernet/cisco/enic/vnic_devcmd.h
index 605ef17f967e..3b6efa743dba 100644
--- a/drivers/net/ethernet/cisco/enic/vnic_devcmd.h
+++ b/drivers/net/ethernet/cisco/enic/vnic_devcmd.h
@@ -734,6 +734,8 @@ enum vic_feature_t {
 	VIC_FEATURE_VXLAN,
 	VIC_FEATURE_RDMA,
 	VIC_FEATURE_VXLAN_PATCH,
+	/* slot 3 reserved for firmware VIC_FEATURE_PTP */
+	VIC_FEATURE_SRIOV	= 4,
 	VIC_FEATURE_MAX,
 };
 

-- 
2.43.0

