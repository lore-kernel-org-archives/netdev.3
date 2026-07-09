Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819B83932D3;
	Thu,  9 Jul 2026 03:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783569049; cv=none; b=OnguIqTbLL+wGWZvjAKzuCA2jIcgt3pfM8IOLvlua526luvF57XdTViBDjfhe24WRBWsHvbS9yCl5KmH8DEehaBVrCuefAqXzzdYbkjbFukVfeAHy0ZBXbx18im4ZeiNuRsAu8juuEsbK/OdmQMFzke+UfgZJ7+ocmiYNwddD/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783569049; c=relaxed/simple;
	bh=JednrzXnDxkafOhtty2lkU/oY2wK64ws0iG8VhUIDOE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dvlf0iybqldU/jZN/01CUBWbzpTLfOOn7kmZvSF503UFyKVWlRJBfSW45fxsw94L0aYDWrJLXxe9rjPrwYAKc+iGsbIy7kMWiVOSDReJ2KLCvZRJ9o5n4xFAkYSr7HyIaUTtBTRVKg2GPeb4oTGyOzxuLgjQHcvevTN3HxEEF5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=EdzzAUmi; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="EdzzAUmi"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668N8cWU2286152;
	Wed, 8 Jul 2026 20:50:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=7
	AvdgVr3QRDIWeldWDM0dtGdNKHEk1MnEyC3CdIAFNM=; b=EdzzAUmix0d7xWxyF
	9SN4v8jRrD8DtAqyFOGCcSDU4bUg1dqWzQWILeQeispJzmcN+IiYepX2V7NLzs6X
	U9xSGgAYvoNSsLgQZxJEqj2DDzg7Ea++WBat/AGIPg/1isjWHRoe70YDX6r8y6eK
	6iTylFXCuuawUHC3qPRODGIGPQLj+1bn0Uk2op1e2aftjXeurwgB/PV2y+4/2QQY
	8gfqAlMnpei/L1RCfO/Ja/YLNx+UBPU9PmmTnGnVACQE5WQMutWTYcyrL9x8Tbjq
	xm3BJF7SeNcRjbqsXv6ztb089vkLfhKCjLaI7i2FpNPtvxfGssPblB8pKYgmapxy
	devSw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4f9jwmu871-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 20:50:27 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 8 Jul 2026 20:50:26 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 8 Jul 2026 20:50:26 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 47D5A3F7097;
	Wed,  8 Jul 2026 20:50:23 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <stephen@networkplumber.org>, <dsahern@kernel.org>, <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <rkannoth@marvell.com>, <andrew+netdev@lunn.ch>, <edumazet@google.com>,
        <pabeni@redhat.com>, <jiri@resnulli.us>
Subject: [PATCH v5 iproute2-next 1/2] devlink: use DEVLINK_VAR_ATTR_TYPE_* in param show/set
Date: Thu, 9 Jul 2026 09:20:15 +0530
Message-ID: <20260709035016.911607-2-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260709035016.911607-1-rkannoth@marvell.com>
References: <20260709035016.911607-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDAzMiBTYWx0ZWRfXw1WNOPq0Z4SX
 Yzj7/wTCbtSXhZZ6SfeN+3gCTUzrqcWLZ+h/LMjaubLXnyjGW65OlzMS1w4D7+H0wSKI3ASt7aF
 cURc/QvyNT0syRvE66PGaN2VgNSIv7c=
X-Proofpoint-GUID: R4w-tvc5vpOAU0_veCXNXHdaZZ7hh1CV
X-Proofpoint-ORIG-GUID: R4w-tvc5vpOAU0_veCXNXHdaZZ7hh1CV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDAzMiBTYWx0ZWRfX1W7iQ/oeWN42
 fNjrOuPYcJSqXWubigewkaXWtq+o5dq432Ijt5YyUEPWDXtHQ6ZylHv/un1uLnRgTc2WBCUfBij
 3ofwK1hOEBCgWstRTo+YvXw/Ypq8wphG8dhiyV4wuCrwFBbo1gL/3K4dOACO2VRicZ2Lq2yWO9d
 ukPb2/kEvJM4/rqGYC0ofCR94ky1C5SS04xQIqaVJGolPjjzTdwZne8gOpRdJgc2c+Si5Ddpahw
 LKBwxZZpJheJ2vDi7ZmIWefjOYb0LEwrZ07yENk6dOFHojvd6Xwf1iKBqZw/OfD1Tr3qiAQ7PEo
 qlSNsVaFPe45iY2IDDr5QTN7jqop2rxAH3XMetJuJHd9HXi5claY2i9kVeBc+3Uw12M3LsiTLSR
 kn0BjhBWYRlaH/rCprrjmscMmoyA1C4l2cX9g2N0Y4FZ14DCG3M1yK7VVI+Oo+RpQri2vUblC7H
 C4QZ1syy+UPbylUXEtg==
X-Authority-Analysis: v=2.4 cv=aPDAb79m c=1 sm=1 tr=0 ts=6a4f1a83 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=GRCvF58QQ8dbGe4S3LoA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_05,2026-07-08_01,2025-10-01_01

Replace MNL_TYPE_* constants with DEVLINK_VAR_ATTR_TYPE_* when
handling DEVLINK_ATTR_PARAM_TYPE in param value display and set
paths. The kernel uAPI now exposes these values directly via
devlink_var_attr_type.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 devlink/devlink.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index 434a91fe..803ea5d7 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -3526,7 +3526,7 @@ static int pr_out_param_value_print(const char *nla_name, int nla_type,
 	print_string(PRINT_FP, NULL, " %s ", label);
 
 	switch (nla_type) {
-	case MNL_TYPE_U8:
+	case DEVLINK_VAR_ATTR_TYPE_U8:
 		if (conv_exists) {
 			err = param_val_conv_str_get(param_val_conv,
 						     PARAM_VAL_CONV_LEN,
@@ -3541,7 +3541,7 @@ static int pr_out_param_value_print(const char *nla_name, int nla_type,
 				   mnl_attr_get_u8(val_attr));
 		}
 		break;
-	case MNL_TYPE_U16:
+	case DEVLINK_VAR_ATTR_TYPE_U16:
 		if (conv_exists) {
 			err = param_val_conv_str_get(param_val_conv,
 						     PARAM_VAL_CONV_LEN,
@@ -3556,7 +3556,7 @@ static int pr_out_param_value_print(const char *nla_name, int nla_type,
 				   mnl_attr_get_u16(val_attr));
 		}
 		break;
-	case MNL_TYPE_U32:
+	case DEVLINK_VAR_ATTR_TYPE_U32:
 		if (conv_exists) {
 			err = param_val_conv_str_get(param_val_conv,
 						     PARAM_VAL_CONV_LEN,
@@ -3571,11 +3571,11 @@ static int pr_out_param_value_print(const char *nla_name, int nla_type,
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
@@ -3753,22 +3753,22 @@ static int cmd_dev_param_set_cb(const struct nlmsghdr *nlh, void *data)
 			ctx->cmode_found = true;
 			val_attr = nla_value[DEVLINK_ATTR_PARAM_VALUE_DATA];
 			switch (nla_type) {
-			case MNL_TYPE_U8:
+			case DEVLINK_VAR_ATTR_TYPE_U8:
 				ctx->value.vu8 = mnl_attr_get_u8(val_attr);
 				break;
-			case MNL_TYPE_U16:
+			case DEVLINK_VAR_ATTR_TYPE_U16:
 				ctx->value.vu16 = mnl_attr_get_u16(val_attr);
 				break;
-			case MNL_TYPE_U32:
+			case DEVLINK_VAR_ATTR_TYPE_U32:
 				ctx->value.vu32 = mnl_attr_get_u32(val_attr);
 				break;
-			case MNL_TYPE_U64:
+			case DEVLINK_VAR_ATTR_TYPE_U64:
 				ctx->value.vu64 = mnl_attr_get_u64(val_attr);
 				break;
-			case MNL_TYPE_STRING:
+			case DEVLINK_VAR_ATTR_TYPE_STRING:
 				ctx->value.vstr = mnl_attr_get_str(val_attr);
 				break;
-			case MNL_TYPE_FLAG:
+			case DEVLINK_VAR_ATTR_TYPE_FLAG:
 				ctx->value.vbool = val_attr ? true : false;
 				break;
 			}
@@ -3841,7 +3841,7 @@ static int cmd_dev_param_set(struct dl *dl)
 
 	mnl_attr_put_u8(nlh, DEVLINK_ATTR_PARAM_TYPE, ctx.nla_type);
 	switch (ctx.nla_type) {
-	case MNL_TYPE_U8:
+	case DEVLINK_VAR_ATTR_TYPE_U8:
 		if (conv_exists) {
 			err = param_val_conv_uint_get(param_val_conv,
 						      PARAM_VAL_CONV_LEN,
@@ -3858,7 +3858,7 @@ static int cmd_dev_param_set(struct dl *dl)
 			return 0;
 		mnl_attr_put_u8(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, val_u8);
 		break;
-	case MNL_TYPE_U16:
+	case DEVLINK_VAR_ATTR_TYPE_U16:
 		if (conv_exists) {
 			err = param_val_conv_uint_get(param_val_conv,
 						      PARAM_VAL_CONV_LEN,
@@ -3875,7 +3875,7 @@ static int cmd_dev_param_set(struct dl *dl)
 			return 0;
 		mnl_attr_put_u16(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, val_u16);
 		break;
-	case MNL_TYPE_U32:
+	case DEVLINK_VAR_ATTR_TYPE_U32:
 		if (conv_exists) {
 			err = param_val_conv_uint_get(param_val_conv,
 						      PARAM_VAL_CONV_LEN,
@@ -3892,7 +3892,7 @@ static int cmd_dev_param_set(struct dl *dl)
 			return 0;
 		mnl_attr_put_u32(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, val_u32);
 		break;
-	case MNL_TYPE_U64:
+	case DEVLINK_VAR_ATTR_TYPE_U64:
 		if (conv_exists)
 			err = param_val_conv_uint_get(param_val_conv,
 						      PARAM_VAL_CONV_LEN,
@@ -3907,7 +3907,7 @@ static int cmd_dev_param_set(struct dl *dl)
 			return 0;
 		mnl_attr_put_u64(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, val_u64);
 		break;
-	case MNL_TYPE_FLAG:
+	case DEVLINK_VAR_ATTR_TYPE_FLAG:
 		err = str_to_bool(dl->opts.param_value, &val_bool);
 		if (err)
 			goto err_param_value_parse;
@@ -3917,7 +3917,7 @@ static int cmd_dev_param_set(struct dl *dl)
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

