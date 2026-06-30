Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B188C280A20;
	Tue, 30 Jun 2026 01:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782784634; cv=none; b=lMG3Ez6nQj9Vxsexf8o/FoGJAMYW2R1BFbJOF1ABYHW119ijUR+N0dR/WQB1+UFSPVaVe4dGAVHvLetNrbALpvFUGyxwksqLKQzPJZjUPcrMrh92OOmk1547YduOVWI1X5r2r2zPM+hpJYaAThSDugYQBlSDrp3s9rSHa2iN66M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782784634; c=relaxed/simple;
	bh=Vs3Zqucg9bgJAyhvH4HtFpE559QAadACxaWeXOLY/10=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Su4WcACzJZ45BXB5DBSMPhVkzC9A7BE3NaeMAENrOGxdsuQwYSkbCMerx03TD7Fdy6TEsMGwXpZy7rfGWlgtQYZSmbGyGLaZmbtkNtKvQN1qqt3SlkVM/Y7ZSa36PWmahcX0e4B68PiPHTdP/nWG7nmnmEnB+p3w6Tcu2RKGIjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=P1GcS8rt; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="P1GcS8rt"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U1IPqj3489287;
	Mon, 29 Jun 2026 18:50:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=7
	rCQ5rFehI+c6eagJi54xkn+Opzozq7vEl8C9HFYePk=; b=P1GcS8rt1ahdnB+kS
	rKxlRnxtABfMXrDvPOnLUs2KqwtwV5nkCVJnAYoDsjdGmsXCKakQmfcpf2nlXh6+
	BGQlCIaIQxDUmwRyhDLJaHo5566QE1uumlY4tywA3XvuDl0iyugLQyhY+RylsS3y
	nAwbzKX42hsNKXxe0PPgPInWb5GiZGm40oyscteal6C39Utujwq30oQ+tLRQAVT6
	pAF43iLsgjN9AQSlWuwRsCrX2Revza/Dl7WpQhqIzcllakNN/M1MH2fdGthUJNqM
	J6tkhFqkX7jVF5lxbduarCtLpHxDtFwMyZ5g5UMrArBEQXHj1gTdTrDP6QO5ywkn
	xumOA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4f2e1h7uhk-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2026 18:50:34 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 29 Jun 2026 18:50:32 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 29 Jun 2026 18:50:32 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id E34CD3F7081;
	Mon, 29 Jun 2026 18:50:28 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <stephen@networkplumber.org>, <dsahern@kernel.org>, <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <rkannoth@marvell.com>, <andrew+netdev@lunn.ch>, <edumazet@google.com>,
        <pabeni@redhat.com>, <jiri@resnulli.us>
Subject: [PATCH iproute2-next v2 1/2] devlink: use DEVLINK_VAR_ATTR_TYPE_* in param show/set
Date: Tue, 30 Jun 2026 07:20:11 +0530
Message-ID: <20260630015012.3728870-2-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630015012.3728870-1-rkannoth@marvell.com>
References: <20260630015012.3728870-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: g_yr6KPyOChuZk8K09eW7FCSp6jJHkWx
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDAxNCBTYWx0ZWRfX+k6tZd0Y4dU2
 4qVW01wYadKsHRaFSBpu6mKud9ZATHLMYFgMsO9psF70JfueaiRDfr3TjSWaAUnRlBVbacKSjmm
 b27KqId6svzgEOvLfm9QqYgdtfSBQfw=
X-Authority-Analysis: v=2.4 cv=e802j6p/ c=1 sm=1 tr=0 ts=6a4320ea cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=voOhfFORqQuKaeI7gG4A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: g_yr6KPyOChuZk8K09eW7FCSp6jJHkWx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDAxNCBTYWx0ZWRfX4b4sTDERSRyX
 q//q06XYGyx3QO5b5bmgDchLjvKwrvs5WodFQkt4ALORgWc/jWoxQ0UwDhNPSgnh+h0LkXb48PG
 2orD08XOKArFLG7u1FGtETjxt5pmkqyFZn6Cizllcl3WBR2Q4JMIc5fabSgFZ6n0jiOaDiKQcXA
 KvyK3YYTQ6Cr2k7RZpeQ19zijVElFhxLnbW5NqW4gRyT2R6ebmMkZAWDh2+v/vycjigh3HXcgT+
 LO5/xP1I0pBJteLlg9e9kn9gngW6eUVzeEGJ20HLe9+fGpeW/QcrlEixqCYKK5M0cjEyw1VmeMb
 y42Vr6hYZheqWG+PYwyxOqcIFZwRncD3Y92fsOpH1ZpgpLmi/N/fr9Zh4ksFM2IHeYYNEbTv/1o
 I641qxH5krx7NdxZIBR8TZs/zAgLzvzvpaR+29c1WIeCGKu79VBkmK+/RcHRube62lo+xuVmdk1
 7c1dFLKpZiEjmX5NkTw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_01,2026-06-26_01,2025-10-01_01

Replace MNL_TYPE_* constants with DEVLINK_VAR_ATTR_TYPE_* when
handling DEVLINK_ATTR_PARAM_TYPE in param value display and set
paths. The kernel uAPI now exposes these values directly via
devlink_var_attr_type.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 devlink/devlink.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index b4deba30..9372e92f 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -3507,7 +3507,7 @@ static int pr_out_param_value_print(const char *nla_name, int nla_type,
 	print_string(PRINT_FP, NULL, " %s ", label);
 
 	switch (nla_type) {
-	case MNL_TYPE_U8:
+	case DEVLINK_VAR_ATTR_TYPE_U8:
 		if (conv_exists) {
 			err = param_val_conv_str_get(param_val_conv,
 						     PARAM_VAL_CONV_LEN,
@@ -3522,7 +3522,7 @@ static int pr_out_param_value_print(const char *nla_name, int nla_type,
 				   mnl_attr_get_u8(val_attr));
 		}
 		break;
-	case MNL_TYPE_U16:
+	case DEVLINK_VAR_ATTR_TYPE_U16:
 		if (conv_exists) {
 			err = param_val_conv_str_get(param_val_conv,
 						     PARAM_VAL_CONV_LEN,
@@ -3537,7 +3537,7 @@ static int pr_out_param_value_print(const char *nla_name, int nla_type,
 				   mnl_attr_get_u16(val_attr));
 		}
 		break;
-	case MNL_TYPE_U32:
+	case DEVLINK_VAR_ATTR_TYPE_U32:
 		if (conv_exists) {
 			err = param_val_conv_str_get(param_val_conv,
 						     PARAM_VAL_CONV_LEN,
@@ -3552,11 +3552,11 @@ static int pr_out_param_value_print(const char *nla_name, int nla_type,
 				   mnl_attr_get_u32(val_attr));
 		}
 		break;
-	case MNL_TYPE_STRING:
+	case DEVLINK_VAR_ATTR_TYPE_STRING:
 		print_string(PRINT_ANY, label, "%s",
 			     mnl_attr_get_str(val_attr));
 		break;
-	case MNL_TYPE_FLAG:
+	case DEVLINK_VAR_ATTR_TYPE_FLAG:
 		if (flag_as_u8)
 			print_bool(PRINT_ANY, label, "%s",
 				   mnl_attr_get_u8(val_attr));
@@ -3822,7 +3822,7 @@ static int cmd_dev_param_set(struct dl *dl)
 
 	mnl_attr_put_u8(nlh, DEVLINK_ATTR_PARAM_TYPE, ctx.nla_type);
 	switch (ctx.nla_type) {
-	case MNL_TYPE_U8:
+	case DEVLINK_VAR_ATTR_TYPE_U8:
 		if (conv_exists) {
 			err = param_val_conv_uint_get(param_val_conv,
 						      PARAM_VAL_CONV_LEN,
@@ -3839,7 +3839,7 @@ static int cmd_dev_param_set(struct dl *dl)
 			return 0;
 		mnl_attr_put_u8(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, val_u8);
 		break;
-	case MNL_TYPE_U16:
+	case DEVLINK_VAR_ATTR_TYPE_U16:
 		if (conv_exists) {
 			err = param_val_conv_uint_get(param_val_conv,
 						      PARAM_VAL_CONV_LEN,
@@ -3856,7 +3856,7 @@ static int cmd_dev_param_set(struct dl *dl)
 			return 0;
 		mnl_attr_put_u16(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, val_u16);
 		break;
-	case MNL_TYPE_U32:
+	case DEVLINK_VAR_ATTR_TYPE_U32:
 		if (conv_exists) {
 			err = param_val_conv_uint_get(param_val_conv,
 						      PARAM_VAL_CONV_LEN,
@@ -3873,7 +3873,7 @@ static int cmd_dev_param_set(struct dl *dl)
 			return 0;
 		mnl_attr_put_u32(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, val_u32);
 		break;
-	case MNL_TYPE_U64:
+	case DEVLINK_VAR_ATTR_TYPE_U64:
 		if (conv_exists)
 			err = param_val_conv_uint_get(param_val_conv,
 						      PARAM_VAL_CONV_LEN,
@@ -3888,7 +3888,7 @@ static int cmd_dev_param_set(struct dl *dl)
 			return 0;
 		mnl_attr_put_u64(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, val_u64);
 		break;
-	case MNL_TYPE_FLAG:
+	case DEVLINK_VAR_ATTR_TYPE_FLAG:
 		err = str_to_bool(dl->opts.param_value, &val_bool);
 		if (err)
 			goto err_param_value_parse;
@@ -3898,7 +3898,7 @@ static int cmd_dev_param_set(struct dl *dl)
 			mnl_attr_put(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA,
 				     0, NULL);
 		break;
-	case MNL_TYPE_STRING:
+	case DEVLINK_VAR_ATTR_TYPE_STRING:
 		mnl_attr_put_strz(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA,
 				  dl->opts.param_value);
 		if (!strcmp(dl->opts.param_value, ctx.value.vstr))
-- 
2.43.0

