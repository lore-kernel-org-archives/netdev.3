Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E3140B6E0;
	Fri,  5 Jun 2026 06:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780641203; cv=none; b=B60Ix224oRm0+NMXc3BY6OkD7HoNMIRniaFwiu+jI3+u8p461FFpf1iyiBxFCrfEz/Dj51pf3VjuK+HN2PVhrOcz7yb8fj3wtuxN3Wkt8444PRlqAEE/dajoNm9/GfXh1oRt5ATywwvFiXj43LZN5Yjv9Hb3PZHbB4NMXrZfQqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780641203; c=relaxed/simple;
	bh=tH3gpipaaf6zuzf8TbSjpYAS5YH8WLfKDKVYxfRj0us=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=syp+Liud4JVWxuD1KQiCMEu8fMvejorNU1kveS6ZXdxCIAnr9A7S401hkGSq+mr+kfZSn9xsan/WYUR6RgY4VbO8xFH63X+p+aRHgvoMNMS6hLvS2l9wmIdVPswNb/HhtNdo0xWhUI1uumpZWeqanpDC+nq9xUjdBTpdHANjQ9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=KNPWDj/7; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="KNPWDj/7"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 654LQTOJ3892410;
	Thu, 4 Jun 2026 23:33:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=r
	kDUHU6kRBibHWT4gD5lvpI1GvEbstr+RjZ4RIUDcvY=; b=KNPWDj/7yEDfLi7HT
	l2VppbeTbVmnCrOvZ4TF0Zq7eEiD66Ogn8wphIu6nc3TVZvKV8KTUCiqfUDCnoHQ
	rJuZxQya7CWImxgN8xP32wMZqDmANIi2oljimDTXSIfEWXvqZO2P9PZMAwJ7zICw
	AUQtdQHIW+yn1yR7qHfg8qpXSkt4S6mw78X2vtZ77GJ3VwTJDc/2B8IiExofmMdw
	ogO+N1AikmDuWHV3oCv3NbK/EuJMdK+qRE7DiKXN6l+mieUjYCPTc1McVamCY7oR
	7Px3AobG6kKcX4T2HhuDld20PgYLgj/T7/HfVCQgjTb2IDgBUHoj65EetT0fBcCW
	/+DZA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4ekh8x9b55-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2026 23:33:12 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 4 Jun 2026 23:33:11 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 4 Jun 2026 23:33:11 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 708D83F7074;
	Thu,  4 Jun 2026 23:33:07 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <donald.hunter@gmail.com>,
        <edumazet@google.com>, <horms@kernel.org>, <jiri@resnulli.us>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH v19 net-next 3/9] devlink: heap-allocate param fill buffers in devlink_nl_param_fill
Date: Fri, 5 Jun 2026 12:02:39 +0530
Message-ID: <20260605063245.3553861-4-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260605063245.3553861-1-rkannoth@marvell.com>
References: <20260605063245.3553861-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: uDM72DtcRSBpg9bI4uCz0mv99HlLQYNA
X-Authority-Analysis: v=2.4 cv=DqNmPm/+ c=1 sm=1 tr=0 ts=6a226da8 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=QAS8UgIW8qh4FKEizQ4A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDA2MSBTYWx0ZWRfX9GNtx7sEYoLn
 H22pDb0YyKxN4n2vvHgVx9fYtRunwe2H3h/njShAkJ/Fh8E5uApux2o8oLTVDwTCbcwH07WR92/
 v5oaLEPxK9WFMQ6MzIj2QCiK664KN+HKcgtHwU67jx8LHWskyqb3lL+6MTBOFiD9/AY5yuZso25
 Jsz3gIGDA1JjuPM9e56mOhPH0BwRHFCwm5b5LupA7ftGwfiVioOlMlHOl8pS4X5S+26BL1TWYmp
 AbwMn+SZCSx00Ox0LerpDGBvdQNP3jfvFoQXJqGSmnRK0FH649w0QFQERb4Hx1LAVtyWIzJB846
 2nP4AvAj4bYg7AC1BcCpvOZLMLLQMRXQFb7dpJN4xL7w7fyGsDAVC5taooeukGZvPeO5nYvlSUb
 XPv98UZmMwECeSk/9DmmU4Bz8Z0nS38XbRxnH+YY6N6D/IVHkKbYAVa71DrK602hhCU1E/o+NVL
 CT2bkd+7IJnWDuS6Lqg==
X-Proofpoint-GUID: uDM72DtcRSBpg9bI4uCz0mv99HlLQYNA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-05_01,2026-05-28_03,2025-10-01_01

devlink_nl_param_fill() kept two per-configuration-mode copies of
union devlink_param_value plus a struct devlink_param_gset_ctx on the
stack while building the Netlink reply. Allocate those with kcalloc()
and kzalloc_obj() instead, and route failures through a single cleanup
path so temporary buffers are always freed.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 net/devlink/param.c | 62 +++++++++++++++++++++++++++++++++------------
 1 file changed, 46 insertions(+), 16 deletions(-)

diff --git a/net/devlink/param.c b/net/devlink/param.c
index 1a196d3a843d..bd3881349c60 100644
--- a/net/devlink/param.c
+++ b/net/devlink/param.c
@@ -304,56 +304,79 @@ static int devlink_nl_param_fill(struct sk_buff *msg, struct devlink *devlink,
 				 u32 portid, u32 seq, int flags,
 				 struct netlink_ext_ack *extack)
 {
-	union devlink_param_value default_value[DEVLINK_PARAM_CMODE_MAX + 1];
-	union devlink_param_value param_value[DEVLINK_PARAM_CMODE_MAX + 1];
 	bool default_value_set[DEVLINK_PARAM_CMODE_MAX + 1] = {};
 	bool param_value_set[DEVLINK_PARAM_CMODE_MAX + 1] = {};
 	const struct devlink_param *param = param_item->param;
-	struct devlink_param_gset_ctx ctx;
+	union devlink_param_value *default_value;
+	union devlink_param_value *param_value;
+	struct devlink_param_gset_ctx *ctx;
 	struct nlattr *param_values_list;
 	struct nlattr *param_attr;
 	void *hdr;
 	int err;
 	int i;
 
+	default_value = kcalloc(DEVLINK_PARAM_CMODE_MAX + 1,
+				sizeof(*default_value), GFP_KERNEL);
+	if (!default_value)
+		return -ENOMEM;
+
+	param_value = kcalloc(DEVLINK_PARAM_CMODE_MAX + 1,
+			      sizeof(*param_value), GFP_KERNEL);
+	if (!param_value) {
+		kfree(default_value);
+		return -ENOMEM;
+	}
+
+	ctx = kzalloc_obj(*ctx);
+	if (!ctx) {
+		kfree(param_value);
+		kfree(default_value);
+		return -ENOMEM;
+	}
+
 	/* Get value from driver part to driverinit configuration mode */
 	for (i = 0; i <= DEVLINK_PARAM_CMODE_MAX; i++) {
 		if (!devlink_param_cmode_is_supported(param, i))
 			continue;
 		if (i == DEVLINK_PARAM_CMODE_DRIVERINIT) {
-			if (param_item->driverinit_value_new_valid)
+			if (param_item->driverinit_value_new_valid) {
 				param_value[i] = param_item->driverinit_value_new;
-			else if (param_item->driverinit_value_valid)
+			} else if (param_item->driverinit_value_valid) {
 				param_value[i] = param_item->driverinit_value;
-			else
-				return -EOPNOTSUPP;
+			} else {
+				err = -EOPNOTSUPP;
+				goto get_put_fail;
+			}
 
 			if (param_item->driverinit_value_valid) {
 				default_value[i] = param_item->driverinit_default;
 				default_value_set[i] = true;
 			}
 		} else {
-			ctx.cmode = i;
-			err = devlink_param_get(devlink, param, &ctx, extack);
+			ctx->cmode = i;
+			err = devlink_param_get(devlink, param, ctx, extack);
 			if (err)
-				return err;
-			param_value[i] = ctx.val;
+				goto get_put_fail;
 
-			err = devlink_param_get_default(devlink, param, &ctx,
+			param_value[i] = ctx->val;
+
+			err = devlink_param_get_default(devlink, param, ctx,
 							extack);
 			if (!err) {
-				default_value[i] = ctx.val;
+				default_value[i] = ctx->val;
 				default_value_set[i] = true;
 			} else if (err != -EOPNOTSUPP) {
-				return err;
+				goto get_put_fail;
 			}
 		}
 		param_value_set[i] = true;
 	}
 
+	err = -EMSGSIZE;
 	hdr = genlmsg_put(msg, portid, seq, &devlink_nl_family, flags, cmd);
 	if (!hdr)
-		return -EMSGSIZE;
+		goto get_put_fail;
 
 	if (devlink_nl_put_handle(msg, devlink))
 		goto genlmsg_cancel;
@@ -393,6 +416,9 @@ static int devlink_nl_param_fill(struct sk_buff *msg, struct devlink *devlink,
 	nla_nest_end(msg, param_values_list);
 	nla_nest_end(msg, param_attr);
 	genlmsg_end(msg, hdr);
+	kfree(default_value);
+	kfree(param_value);
+	kfree(ctx);
 	return 0;
 
 values_list_nest_cancel:
@@ -401,7 +427,11 @@ static int devlink_nl_param_fill(struct sk_buff *msg, struct devlink *devlink,
 	nla_nest_cancel(msg, param_attr);
 genlmsg_cancel:
 	genlmsg_cancel(msg, hdr);
-	return -EMSGSIZE;
+get_put_fail:
+	kfree(default_value);
+	kfree(param_value);
+	kfree(ctx);
+	return err;
 }
 
 static void devlink_param_notify(struct devlink *devlink,
-- 
2.43.0

