Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5C82E7392;
	Mon, 15 Jun 2026 04:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781496670; cv=none; b=R1pS6AmnHvOHZovrVNf6XAL301+GMY121LIaOi0m58Nu95R4j/MjBunjP7JE7mpskFZWM7J/hOXhwZ3n/lcYaiFV8RdW3xvSrzeeemeTIzLU+aV4cdfDzGtj1BwGHQVEetR1dIQGUcEDu9kYICplROo5+NsRPNF7TVq7cfwQqWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781496670; c=relaxed/simple;
	bh=aog5QSyuPZj78VvYT5GarDMPkG7YfuWdmAAth6qp678=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I1fbmCKKmPEQlmZML6gKKCp11JzzKsONwGf/7o89u0DgOxIz0V09q8RQ0QGNXgZhLymWXhxLdgkLVNAUsIL2wkDg3QikWA379eJxd4tpEZQoKGjWHaASmt/JtyOnjnMmWc/7YZB9oHnI08DQwK0uL+8/uO0oSmHwCN/dfwzpIE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=LqT+pKax; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="LqT+pKax"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65F1lQub3665057;
	Sun, 14 Jun 2026 21:11:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=r/eVr+VMxVsX4Htxts73dSE
	BM6h8TCkFfGSi+OM32mM=; b=LqT+pKaxPef4I+LPNe7fGCQXzXAbsiTBr+E4mzk
	9TFCs3cxsojoA+BFWhOnk0NxMgMDcWSB7qHN+Z1+8BFidrH2fHITM6MLxRUknTFs
	d5uzP8BR8BbW7vofFiNpX52s6BnOI6+lUqBGUFD/AYi2A2cvOXDpBSOfcSaoz7hV
	Kvufp+AxvCYfGfo1iJmG3b6fguduhuRsbfDFv4ngzt2VTr6M45ubGBoEk+79uIYe
	Z/bkuEdzYg3zIp1LYXE5mq2+vvDXbw9Jm1ufDPwprC9RpDIDMnoOLIQBOeiDeJAu
	O0ZfPLIuopkTd1b9cSyzlR2ArKMSqvfZ8fa+goPpvBceNQw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4es6qedcsw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Jun 2026 21:11:00 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 14 Jun 2026 21:10:59 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 14 Jun 2026 21:10:59 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 2BC623F704E;
	Sun, 14 Jun 2026 21:10:55 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <stephen@networkplumber.org>, <dsahern@kernel.org>, <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <rkannoth@marvell.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: [PATCH iproute2-next] devlink: support u32-array values in devlink param show/set
Date: Mon, 15 Jun 2026 09:40:42 +0530
Message-ID: <20260615041042.549715-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Si1Yv7KjOA5GttXhfON-fA-0I2zTJ44W
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDAzOSBTYWx0ZWRfX1mYeszqojyrs
 Jgc7aMVOWkvzIJCiXTAb9Sa5LNKfdrmHuFNcZDbMjATcJlbBJMYM9PvFyiOTiqPVfKOGTRpmOav
 iGnyIxRSMC4Niy7051Tx0sB8XuKDP0I=
X-Authority-Analysis: v=2.4 cv=TuXWQjXh c=1 sm=1 tr=0 ts=6a2f7b54 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=bza--CHlKw4mGccpSsIA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: Si1Yv7KjOA5GttXhfON-fA-0I2zTJ44W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDAzOSBTYWx0ZWRfX7pG9z4homE2c
 NjO0IfE2yuNOl4qCUjs89DuWtoYYQBJhmk2BdrkCslomozE99qybBhHnkcT3lM9azuGvLtrWTNH
 UCN6pATjfp9Hh+j+3TZ2K5c/gJbomHEu1qJnrA/U9mR59yQQ0DpiHlTIAsXxBqhjBkBVQ65NA7Y
 /dkIFA/Nf4haKYu9pKtBMr9knFom7N4aEwaWbsY0FNzHyyqMlXQ5eDK8HBUXBQpH4DfGixB/q4w
 IdlYzNYEtzJCCOKZYNzm+zQXekprIGWXHPcdWC1tdeFUoUaMdYWz50i28iorrPIgr/bEzhkTBri
 TAJYPTqorwzKcmRrE0ZQaWVaVhCIG2msBm2s/+7+Dt0F2JGWenprc9BTExEKYuU14jMI1VWPEYh
 EqpoW1qaIlicsEuuLRk7Y+s9MhIx5wvZOQ9tlAvr9DIeeLXuQm3Txi+QK1sewumKfAfz2UHyHmo
 zkOzyku4VcZM9NFqZWQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_01,2026-06-12_03,2025-10-01_01

Teach param value printing about MNL type 129 by walking nested attributes,
collecting u32 elements, and formatting them for output

For param set, accept a space- or comma-separated list of integers and encode
it as multiple DEVLINK_ATTR_PARAM_VALUE_DATA u32 attributes.

Pass the enclosing netlink attribute into pr_out_param_value_print so nested
payloads can be parsed alongside the existing scalar types.

  - Show search order

  devlink dev param show pci/0002:01:00.0 name npc_srch_order
  pci/0002:01:00.0:
    name npc_srch_order type driver-specific
      values:
        cmode runtime value  value  0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31

   - Set search order

   devlink dev param set pci/0002:01:00.0 name npc_srch_order value 31,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,\
		22,23,24,25,26,27,28,29,30  cmode runtime

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 devlink/devlink.c | 47 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 43 insertions(+), 4 deletions(-)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index b4deba30..efb558c5 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -3497,12 +3497,28 @@ static const struct param_val_conv param_val_conv[] = {
 
 #define PARAM_VAL_CONV_LEN ARRAY_SIZE(param_val_conv)
 
+struct devlink_param_u32_array {
+	uint32_t size;
+	uint32_t val[32];
+};
+
+static int param_value_nested_u32_attr_cb(const struct nlattr *attr, void *data)
+{
+	struct devlink_param_u32_array *arr = data;
+
+	arr->val[arr->size++] = mnl_attr_get_u32(attr);
+
+	return MNL_CB_OK;
+}
+
 static int pr_out_param_value_print(const char *nla_name, int nla_type,
 				     struct nlattr *val_attr, bool conv_exists,
-				     const char *label, bool flag_as_u8)
+				     const char *label, bool flag_as_u8, struct nlattr *nl)
 {
+	struct devlink_param_u32_array u32_arr = { };
 	const char *vstr;
-	int err;
+	char buffer[1024];
+	int err, cnt = 0;
 
 	print_string(PRINT_FP, NULL, " %s ", label);
 
@@ -3563,6 +3579,18 @@ static int pr_out_param_value_print(const char *nla_name, int nla_type,
 		else
 			print_bool(PRINT_ANY, label, "%s", val_attr);
 		break;
+	case 129:
+		err = mnl_attr_parse_nested(nl, param_value_nested_u32_attr_cb,
+					    (void *)&u32_arr);
+		if (err != MNL_CB_OK)
+			return -EINVAL;
+
+		for (int i = 1; i < u32_arr.size; i++)
+			cnt += snprintf(buffer + cnt, sizeof(buffer) - cnt, "%u ", u32_arr.val[i]);
+
+		print_string(PRINT_ANY, "value def", " value  %s", buffer);
+
+		break;
 	}
 
 	return 0;
@@ -3595,14 +3623,14 @@ static void pr_out_param_value(struct dl *dl, const char *nla_name,
 					    nla_name);
 
 	err = pr_out_param_value_print(nla_name, nla_type, val_attr,
-				       conv_exists, "value", false);
+				       conv_exists, "value", false, nl);
 	if (err)
 		return;
 
 	val_attr = nla_value[DEVLINK_ATTR_PARAM_VALUE_DEFAULT];
 	if (val_attr) {
 		err = pr_out_param_value_print(nla_name, nla_type, val_attr,
-					       conv_exists, "default", true);
+					       conv_exists, "default", true, nl);
 		if (err)
 			return;
 	}
@@ -3685,6 +3713,7 @@ struct param_ctx {
 		uint64_t vu64;
 		const char *vstr;
 		bool vbool;
+		struct devlink_param_u32_array u32arr;
 	} value;
 };
 
@@ -3764,12 +3793,14 @@ static int cmd_dev_param_set(struct dl *dl)
 {
 	struct param_ctx ctx = {};
 	struct nlmsghdr *nlh;
+	char delim[] = " ,";
 	bool conv_exists;
 	uint64_t val_u64 = 0;
 	uint32_t val_u32;
 	uint16_t val_u16;
 	uint8_t val_u8;
 	bool val_bool;
+	char *token, *buf;
 	int err;
 
 	err = dl_argv_parse(dl, DL_OPT_HANDLE |
@@ -3904,6 +3935,14 @@ static int cmd_dev_param_set(struct dl *dl)
 		if (!strcmp(dl->opts.param_value, ctx.value.vstr))
 			return 0;
 		break;
+	case 129:
+		buf = (char *)dl->opts.param_value;
+		token = strtok(buf,  delim);
+		while (token) {
+			mnl_attr_put_u32(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, atoi(token));
+			token = strtok(NULL, delim);
+		}
+		break;
 	default:
 		printf("Value type not supported\n");
 		return -ENOTSUP;
-- 
2.43.0

