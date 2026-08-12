Received: from alln-iport-4.cisco.com (alln-iport-4.cisco.com [173.37.142.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751AB3BCD14;
	Wed, 12 Aug 2026 12:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786538921; cv=none; b=cLD2i7T/ODG0jsRFJxccvb02qaI6PFLPWfu/XC794qc2YCEiD0x76YSzZ000Pmgk8p+E+jTGpiNb51+5F/IAYlbkbJ5JQH+u/NY40Qr1PyKzoIHpIBO1TOm9AP66OSi81P1m709b+qM8BCNhNzvx0ILoJ9OsKf7AOqRphl/nSlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786538921; c=relaxed/simple;
	bh=AnzgqdSmR2Ey+mMrubH8tuGlJO0Z2nRaXXkyb3doOG0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ku5A+HEs/f3lBkvjBi8PYavFA/PjkndMrkbZTCgD3pgTWqGYd+KmvLyuLtlNPsiJegt1gSwh7boDUN7sIDmIEbo/MuAwYdsbHaI/PSsVBh+Xrvoo+QMH0VS9GwoGaudPULmDyV4il44wc4FGOySn8hEMS2re3jfLfitwiWgoynI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=W8XbYZT5; arc=none smtp.client-ip=173.37.142.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="W8XbYZT5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=2833; q=dns/txt;
  s=iport01; t=1786538919; x=1787748519;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=wlj9gkpcLkbLuXYiJKZW0iLPPiZZxYq74ymflDS5mDI=;
  b=W8XbYZT5bDkDOxBhHrHQm1WuXBhDnfCeQAw4zIBm2IrKOCyalpj225HJ
   PH1JPJDg4mudU9smAg8jB9weVqfD0r7wJu2uB4Jb8XmeCiQwSZKvTRSwR
   +3iH76Ir2/b0ZY6FiTs/j3l7o/Kc5GnBh8MrR+8HBvkqEmJWxhBj/EAD1
   VyWCCz5MJRipJXiO971uxj354XKoKv6pMQOiixAUR8wr1tnn+rVeKDuqi
   7+396ntJPmky83/hRspUQdNXBfcnY0kSHuUsr9qnanZXDqdAMA6T/PSLg
   0saP9HmShki7s6Kn/L2EVE6CF9vhpdAhAbrPFAdeyeNUnFzOjpQD4o0/s
   Q==;
X-CSE-ConnectionGUID: 9UE+xJKrT1Kft+N9dpxUAQ==
X-CSE-MsgGUID: kxBtyOJkSRmpE0WnpmPV2g==
X-IPAS-Result: =?us-ascii?q?A0BFAgDWanxq/5EQJK1aHgEBCxIMggULgleBUkNJhFePU?=
 =?us-ascii?q?oIhnh6Bfg8BAQEPUQQBAYUFAo1nAiY0CQ4BAgQDAgMBAQEBAQEBAQEBAQsBA?=
 =?us-ascii?q?QUBAQECAQcFgQ4ThlyGWwIBAyMEUhAlAiYCAkYQBgESgwKCdQPDK3p/M4EBh?=
 =?us-ascii?q?H3ZSYFmAQsUAYEKLoVxgmwBgXCECDuEQScbgUlEgRWDaYQKhBSCagSDHBKTA?=
 =?us-ascii?q?Ak/gQIcA1ksAVUTDQoLBwVhUjMDIAoLEhIYFQIULw8EFjIdcAwnEiwXNVgbB?=
 =?us-ascii?q?gWBHX0UBBOENiMZNnyBCWGBKyplARIXgQmCJAKCdoEqYQIBHgsYDUgRLDcGD?=
 =?us-ascii?q?hkEPQFuB44IIIFUcT1Sgj8pKZNAgzKNX2uhD4QogWagDwEyl2eTBSyYXCOkA?=
 =?us-ascii?q?DeEaYFoPIFZMxoIGxWDIlMZD44tFhzPfScyPwcCBw8CkXOBfgEB?=
IronPort-Data: A9a23:V3Qpt6DOUpS5wBVW//viw5YqxClBgxIJ4kV8jS/XYbTApDojhjFUy
 WAdW2/VbPveZjbweN4kPNm3p0kHvJCDxodkOVdlrnsFo1CmBibm6XV1Cm+qYkt+++WaFBoPA
 /02M4eGdIZvCCeA+n9BC5C5xVFkz6aEW7HgP+DNPyF1VGdMRTwo4f5Zs7ZRbrVA357jXmthh
 fuo+5eBYA/8gWYtWo4pw/vrRC1H7ayaVAww5jTSVdgT1HfCmn8cCo4oJK3ZBxPQXolOE+emc
 P3Ixbe/83mx109F5gSNy+uTnuUiG9Y+DCDW4pZkc/HKbitq+kTe5p0G2M80Mi+7vdkmc+dZk
 72hvbToIesg0zaldO41C3G0GAkmVUFKFSOuzXWX6aSuI0P6n3TEkshDT1EUHpcko8V5HSJop
 PAAOA0kV0XW7w626OrTpuhEj8AnKozveYgYoHwllWGfBvc9SpeFSKLPjTNa9G5v3YYVQ7CHO
 YxANWcHgBfoO3WjPn8MAY4/h+erhlH0ciZTrxSeoq9fD237nFQsiui9b4KPEjCMbcZFtFqJg
 UDFxF78GjxCC9qHzAK7qH3504cjmgu+Aur+DoaQ+vd0jVi7ymUNBRgSUlWn5/+0liaWX99eN
 0UT0iYjp6k78gqsVNaVdxC0vXuNrBMAc9VXFOI+5UeGza+8ywWEDGEsTTNbbtEi8sgsSlQC3
 1mFhd72RjpirLGYV1qZ67GS6ziyUQANJGUPYy4sVwYJ49D/5oo0i3rnStdlDb7wjdDvHzz06
 y6FoTJ4hLgJi8MPkaKh8jjvhT+wqpXXZhA66x+RXW+/6A59Iom/aOSVBUPz5PJEKsOdC1KGp
 nVBw5jY5+EVBpbLnyuIKAkQIIyUCz++GGW0qTZS81MJrlxBJ1bLkVhs3QxD
IronPort-HdrOrdr: A9a23:qpN6La9hFFlwHsoQw6Fuk+AuI+orL9Y04lQ7vn2ZhyYlFvBw8P
 rOoB1773HJYVkqNU3I9errBEDEewK/yXcX2+Ys1MmZPDUO0VHAROpfBMnZsl7d8kbFmtK1u5
 0QFpRWOZncAUd3iMDi7BL9MdoxqeP3iZyAtKPyw2hgSAdyZ7ol1Qd2DQ6HDlZ7LTM2Y6bRbK
 DsgfZvln6HZWkdaNi9Cz0uWujOoMCOqbfdCCR2fyLOLGK1/EmVAHmQKWni4isj
X-Talos-CUID: =?us-ascii?q?9a23=3A2EyV22lHWEHjjrykrxhXERe5XV3XOSzg4TTAAWy?=
 =?us-ascii?q?iNT9KRqHWbw6c4LNZuvM7zg=3D=3D?=
X-Talos-MUID: 9a23:vYeTIglHRNZEsb55HvI7dnphJO108oOMC3s3lI0r4/aCLSlIBW2S2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,219,1779148800"; 
   d="scan'208";a="805288702"
Received: from alln-l-core-08.cisco.com ([173.36.16.145])
  by alln-iport-4.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 12 Aug 2026 12:48:30 +0000
Received: from [127.0.0.1] (unknown [10.25.129.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by alln-l-core-08.cisco.com (Postfix) with ESMTPS id 837CB1800075D;
	Wed, 12 Aug 2026 12:48:29 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Wed, 12 Aug 2026 05:48:01 -0700
Subject: [PATCH net-next v13 01/11] enic: verify firmware supports V2
 SR-IOV at probe time
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-enic-sriov-v2-admin-channel-v2-v13-1-b3809e448aba@cisco.com>
References: <20260812-enic-sriov-v2-admin-channel-v2-v13-0-b3809e448aba@cisco.com>
In-Reply-To: <20260812-enic-sriov-v2-admin-channel-v2-v13-0-b3809e448aba@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, Sesidhar Baddela <sebaddel@cisco.com>, 
 Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786538908; l=2882;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=AnzgqdSmR2Ey+mMrubH8tuGlJO0Z2nRaXXkyb3doOG0=;
 b=dc/skw7YVrDKtYGa7yQ+kcyLFDSy/gPKCJpTimMwJcO/BIe7ajtUrigOZ0ylJtXKtwsa8aG8K
 iOKfewQdJs0DWG+QaaxL/BCh+0PIrGKxGZ4zGHjcRgIwudJhYcTlAVO
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.129.245];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.129.245, [10.25.129.245]
X-Outbound-Node: alln-l-core-08.cisco.com

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
index d98f7e7ccab9..b56e5c75ade3 100644
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

