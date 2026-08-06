Received: from outbound-ip173b.ess.barracuda.com (outbound-ip173b.ess.barracuda.com [209.222.82.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8441480328;
	Thu,  6 Aug 2026 15:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786031695; cv=fail; b=VobMNOvIwtiojlacT9tzahjvgdzNpZBoiawkTz1xhkzRfHdVK+vQSUPvqA7lyjv3s/asDJnDXg2Rr4YXMrE89b587yYBY2hhDfjZCERQiGtfrvEEGL04ZQJLfPMhCCga+ja99+TY65rhPcyJyDQWBTuAjxrGmpKtO+w/X2MOKGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786031695; c=relaxed/simple;
	bh=F8WAOASE5pfJgLnJYV/ldxyLldrqscV4+BHzbANXd28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MplaZDv8BL8iSeFJg4t39WxdTdAPdgmanuEW9E4ems4as3LsDLGFICXgAPBA7WPMcXUmeG+c4dWmTM06BxJRbfVf5jTQgy4ZUEpe6F0zLsnR/cg21eqvHl+Rvthwa4pT0JUQKhZG3/wXGEPTy1C3v/vt6TgRspTH14hxBtJ9pl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com; spf=pass smtp.mailfrom=digi.com; dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b=HJsK0RVK; arc=fail smtp.client-ip=209.222.82.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b="HJsK0RVK"
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11021115.outbound.protection.outlook.com [40.93.194.115]) by mx-outbound21-228.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 06 Aug 2026 15:54:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qVKIG258cLZ+7ZwAnIQS36rD+N2DLuKP3Afe9U/XBS83VUMfd0Ncgm64nUBf96XP5uGm1yThmZWg7G2ryAnISfHi/tT6bdE6s/1hQsF2n1/sGqLjmrXeJwhAw6xUpGjLV0i/ZdokumR+6h1GN0K4TcntIyGQkwRqRB62w8QV3Ojh/WUCNcvAPVy8+ofAJ9Pb1ETlQkePnpHEToSOT9ZC09FVrvC0TIMS/nYtryhdte466hDNsrIql1nECY0i9Bofy5Xww+92SJNx1B1ow7aZcQhKxN+e78Vp4OVp8bUrPsOev5qDRceOpMSfUvIna6T9HcffMQJDT0UdGtmPwWs+PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZrXf8ytQN9M0y6knN7vGj8cIepeXbdx7GRq+XuirlEc=;
 b=CuGESj4gXwE4QQpnCxHE8DKUs/ltH2gkJxQPiIDBKxHg1srNPzBYF4B3EiKWX8xKCApnwX4fZiL2EXtbLH6MsjaMP5FUtovdnpgzCxy9TWeXayi35o6VyqN/5CJWTLXL0/ZGXU0Gvui2Iiw1ab1mrUCNnyVGW1jNJjKjkj7V1wEY9xH8yqYV8YN+dQhrkmP0F3hGIfiaX/psCuKL5UMGyWOXXuAlmwsDnb/pxgcuTD8XGz6hICzPMOiVS9A/t5Ab3anW9Ev3YL5zbYgP5zsBEmVaxYpvqQTWVqeuaHXLAKIo4Y9jL8q1W/ne6XwDA2UHVtLCJwJHlf9MDj8BlGdX8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=opengear.com;
 dkim=pass header.d=opengear.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opengear.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZrXf8ytQN9M0y6knN7vGj8cIepeXbdx7GRq+XuirlEc=;
 b=HJsK0RVK/+18zpHTAvtj4VV+n/Z0RYM8VavvU6PeVRYcYvVdm2PsTQRXWfN3gl0lxIXswbJeJm0uEUXtCpvy1IX9yylBJV3RiuGrk2y89BEXlxys4TQou8uM+8WFdUx/zBga9jI/Q0DNwuZjLSZeQolahL4tI+IoYFNfMyaUBrDsNekWimZmwvo0FhNFwi8qQ1iDF64EKM+rR+WBjZPcYeB17HlcINBXzaorHL9crou9TFy6IpRE0i5QU2J+24brbRlZLsKCpBS3XkQLXivZDyK2JWIhaavftMd81Rm0r3bGgXth2H1JQ8qiBAfuY7wLuf3BEJsdS2zg2qMPnAQm2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opengear.com;
Received: from DM6PR10MB4139.namprd10.prod.outlook.com (2603:10b6:5:21d::24)
 by IA1PR10MB5900.namprd10.prod.outlook.com (2603:10b6:208:3d4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.16; Thu, 6 Aug
 2026 15:53:03 +0000
Received: from DM6PR10MB4139.namprd10.prod.outlook.com
 ([fe80::19e9:d558:fd6c:8e5a]) by DM6PR10MB4139.namprd10.prod.outlook.com
 ([fe80::19e9:d558:fd6c:8e5a%6]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 15:53:00 +0000
From: Peter Hunt <peter.hunt@opengear.com>
To: mani@kernel.org,
	loic.poulain@oss.qualcomm.com,
	ryazanov.s.a@gmail.com
Cc: johannes@sipsolutions.net,
	netdev@vger.kernel.org,
	mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peter Hunt <peter.hunt@opengear.com>
Subject: [PATCH net-next v2 1/3] net: wwan: core: propagate modem control signals to port drivers
Date: Thu,  6 Aug 2026 09:52:51 -0600
Message-ID: <20260806155253.3378294-2-peter.hunt@opengear.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806155253.3378294-1-peter.hunt@opengear.com>
References: <20260806155253.3378294-1-peter.hunt@opengear.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH3P220CA0002.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1e8::13) To DM6PR10MB4139.namprd10.prod.outlook.com
 (2603:10b6:5:21d::24)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4139:EE_|IA1PR10MB5900:EE_
X-MS-Office365-Filtering-Correlation-Id: 819c1cb7-5368-416a-912f-08def3d2ca7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|6133799003|11063799006|56012099006|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	CzCvueTKjF8r4qEVgZ4cbkzsYVQgiUjy+nf8IsphkmuBev5D5QBKgVvodS0+654/WEmu9+eVW9YURt5nwWGFqZ1p5UkJNBNdfKyuGrV8C1o7Z8EGQ9gETHgRmchMQh64/0iAVbYbhFn0tpYKeDb3hNEatFbLYIgekeQNK2KqmR8sWengg9kuPwRPpmkl/jZ11RnD3rmQQcIdLYdlsuTdOcIy0UeDXzqaWwoNoUOQcnEncCVxHTtnGeyiazQIw/Q9n6vPW2Vb8xO5XgYcHQnDApw/EdzqlOct+5LIVCmgzolxrbIFr0cl0rMXXASt92AN7bNbj+/GEsSVi3LwdDUQWSWJcY4MWrZ+p8oDbbM6QAaYp0+J4UOjDg9zfvfK/wnj1dejMnFH5ouh+GuGuoygQOVGYt3XZKSc8oL5rlrTwVgzkEQdLBfx1Y6lQw2hcIgYuSbmrmliRSWwvLCb6YfK6HNNe0YBR9Uf5Ym952azDWRli7kxtPndDcxNEnHG55z57Akkge8qlpspSqxv6AK7lNaEv7syZp5MaLf5K1M0k55rZ5eInxko9N2heTp2D1mZ4iF3tCcRILfKGL5vFAiitmPP7yrcXvLDOkk+PAxohpITwpMVAd4yM60wywFiOzMAVvmtNnx7HfjJ+K5crC78tLm11mkWnSYvHvROcDmtBGg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4139.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e6RTGyVvKqZ9CpipTsb5FY8cCBCLt3fFKsgyLs9T0WP/+oPgAfgv+2KPXOau?=
 =?us-ascii?Q?MaJjVwnMufZhIL3LF+zW2sGcFYrsdGWyC/jDoodsQXCHcCC8jj6ld+dNSSj3?=
 =?us-ascii?Q?gnInRQZmE9Szsqk738ne5MT1wSXHo3ZmsAZtpE08H6zXzCv/pmQLH/f53wMx?=
 =?us-ascii?Q?tP0hVUDibFZldveC4fFlBSEiLgpxcyvzFXJKqmqWXPrlyuFPUF26/CoGlvPx?=
 =?us-ascii?Q?77V0rM00hX6ecdhx5BFG1+P9lSFa+cKRMaY9/LImFjxbQxdVR0Ln+JHVpAWo?=
 =?us-ascii?Q?yS4Uz3tLxZwJoEu8QhloumvbWFvpXnJfgHDAMcdM+EmYJmGFYiWZYO6HtrTM?=
 =?us-ascii?Q?zx+7qtuLwaLkl3V3itbxJXd+v4tiLBRk7LbD3L/EM2dT1BH6TWJBpxurU2yS?=
 =?us-ascii?Q?YNggKI2USQIuEK9+EDHOg4EtCIBTPhPr6S62bExWWjfugxeCSGAeDIunNMlA?=
 =?us-ascii?Q?8tv5x6oeDz6fikF1lplF/mt0bvhQUR6F1O4fptYboy0ihJZrHHyLnPGke+BY?=
 =?us-ascii?Q?8kv1CJ6OEQFGXSG3btJd0r70k9qWwzAglUM0mTW4JVSLL20sydjXcv2GqJT6?=
 =?us-ascii?Q?PtuDshvY6TRashTXvygV2waUTYXXrMc21ONfZselgod4YD8s0MQ0PSLwDemm?=
 =?us-ascii?Q?Wq5LkEkgDTEr4XQDDr+Wnrl7bAqeRcFUN5G2UPdZPIbq5DIPrUb9NcSBPTCh?=
 =?us-ascii?Q?uwm5RIZmoB5O5K2htiVSw93T3jx85qKxCVr4/FJqiugnRXkh4V5laqu6REV+?=
 =?us-ascii?Q?8b372sfa9qiPTrcZMwtbM3/kauEcLUbkZGacEOhvWlp7QIcl+jL0BtFyW9XH?=
 =?us-ascii?Q?oKzkN5C59X7ScZ47AkX0HOX9OoRh1ueFQdWRSZjkYJiCzaBKKU3Oni4ai3fb?=
 =?us-ascii?Q?VYrLsdgUeL66hJPn/9U9upo9VZd3E+8ZPWvWl9sypbWXRtmH9kxM3/BAdciq?=
 =?us-ascii?Q?eQAxIOOQtjZVd69cPzCrAbOTnfDm88F5pra6dZh4beKCaSllEQeCMNdbbvT6?=
 =?us-ascii?Q?DKVBWHtuRHyB4kGV7Ro1fS2V9IxY+Kd0CqHC4Fq4YX8hHT+gMBslQ5jeaaxe?=
 =?us-ascii?Q?rAG3sMp2sNzq3/HHcpdw1sE9BYzdDanUJ+xvVTuorgbhiGICYhxbhfHTUP6b?=
 =?us-ascii?Q?ocivipxrHOMQLuaq7GWq0+e4FKV3TBKd5bSOsaOh1ykym6kAeZuBvsOgmTNI?=
 =?us-ascii?Q?gjru+8Yr+LRh5hftmQvVlLt9E7nuDQZ8UCMdLsiFknc3V2hO5EEhycVyfXHZ?=
 =?us-ascii?Q?+eqKzzeufIHw3yY3h8qH+iynZhn3pJ/A82nnGPGKK3ANMLVneo6a1/LKShtj?=
 =?us-ascii?Q?rS8co6G6NzkzMiMFndCq7fc9YUXRB6wKUt4XjeH3Ml1cWLZ3Vz5DxOVmzwTZ?=
 =?us-ascii?Q?qBXePSfTlUnyHP5ppEnEnhk431EoCVWZVQJF+gyVuWvzw1zqpyoSjAYRItdm?=
 =?us-ascii?Q?Ep1aYqghK4g8VajUp6klC3vL0ZzpHMrT+QhhZSaAZkCBbJIpUPum4YPMXK7y?=
 =?us-ascii?Q?Ab0M/stj6y28YI/2V17Vr/IQvsbNwXcD1q4nuH37U3pwtLyWHQpMvm7E/MYB?=
 =?us-ascii?Q?m8TMK0NqM42/jXGTt5nBpPaYZ/7He5TCQ8pi3LmnQucP1C2MKRtwKRUvuEEv?=
 =?us-ascii?Q?CEH6UAgrYLA3vLN4FCwVo4MvbVF+mEk0X/YRHYx3hiiPc1YzxkmyFCbPFReI?=
 =?us-ascii?Q?JyUjl4AW85Y3PRnvJlA+QsOibwOKoBVOH7sPQB+/yRX3t05J?=
X-Exchange-RoutingPolicyChecked:
	i6ug8cAfPJ8KL8xjI4nrQhGrrF7eFBhI6kfallpq48Ogxzs2Ba//OSfdiZoxHX8jNbRJoELPbKz6/l244JpWQJsOaNzY1RLaoEN5Xk/93nwcMETaGjlS2vlOOB5JCkPsdvZW5OTN0y+Tx0PwCj602S/WwMIgsA/Rso9W2sjTM9qXQyLyT3kVgqAPtEm8TVRpXro7cXGSnAQCX0jCedcqJ++JX5dDM5VuMz9WQmGuU1kPXGOWUSTbfqiksHfw3zs877xac9uptyfSH3yNpBWuUuohBF6IIKmbNoOjNc29I4Gphkyy2bcjSPGf9NsXJvxcXnc3v9u53gYO3y84hEL+Ug==
X-OriginatorOrg: opengear.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 819c1cb7-5368-416a-912f-08def3d2ca7b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4139.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 15:53:00.0557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 59jzLCAfiN85AoAWa6ILZwKI/vaW+RriMs71dP5UpCotiuEu+BnCXCIuRWkG/ydU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5900
X-BESS-ID: 1786031625-105604-7725-24966-2
X-BESS-VER: 2019.1_20260804.2006
X-BESS-Apparent-Source-IP: 40.93.194.115
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkYWloZAVgZQ0MTUwtwgzSLFPM
	UgJc00ycw81SzFxNzI0DTV0MTE2NBSqTYWAO3BwnBBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.275190 [from 
	cloudscan9-227.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS112744 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

The WWAN character device emulates the TTY modem-control ioctls
(TIOCMGET/TIOCMSET/TIOCMBIC/TIOCMBIS) for AT and QCDM ports, but the
result is only stored in port->at_data.mdmbits and never reaches the port
driver. A driver therefore cannot act on the host raising or dropping
DTR/RTS, even though some modems depend on it (e.g. they withhold
unsolicited AT result codes until the host asserts DTR).

Add optional ->tiocmget/->tiocmset operations to struct wwan_port_ops and
call them from the AT/QCDM ioctl path. ->tiocmset is passed the resolved
TIOCM_* bitmask after BIC/BIS/SET has been applied; ->tiocmget, when
provided, refreshes the cached bits from the device. Drivers that do not
implement them keep the previous store-only behaviour.

Signed-off-by: Peter Hunt <peter.hunt@opengear.com>
---
 drivers/net/wwan/wwan_core.c | 12 +++++++++++-
 include/linux/wwan.h         |  4 ++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
index ffbcf11e4e68..bf83eb5790fe 100644
--- a/drivers/net/wwan/wwan_core.c
+++ b/drivers/net/wwan/wwan_core.c
@@ -1018,7 +1018,15 @@ static long wwan_port_fops_at_ioctl(struct wwan_port *port, unsigned int cmd,
 #endif
 
 	case TIOCMGET:
-		ret = put_user(port->at_data.mdmbits, (int __user *)arg);
+		if (port->ops->tiocmget) {
+			ret = port->ops->tiocmget(port);
+			if (ret >= 0) {
+				port->at_data.mdmbits = ret;
+				ret = 0;
+			}
+		}
+		if (!ret)
+			ret = put_user(port->at_data.mdmbits, (int __user *)arg);
 		break;
 
 	case TIOCMSET:
@@ -1036,6 +1044,8 @@ static long wwan_port_fops_at_ioctl(struct wwan_port *port, unsigned int cmd,
 			port->at_data.mdmbits |= mdmbits;
 		else
 			port->at_data.mdmbits = mdmbits;
+		if (port->ops->tiocmset)
+			ret = port->ops->tiocmset(port, port->at_data.mdmbits);
 		break;
 	}
 
diff --git a/include/linux/wwan.h b/include/linux/wwan.h
index 1e0e2cb53579..bac02521e274 100644
--- a/include/linux/wwan.h
+++ b/include/linux/wwan.h
@@ -57,6 +57,8 @@ struct wwan_port;
  * @tx_blocking: Optional blocking routine that sends WWAN port protocol data
  *               to the device.
  * @tx_poll: Optional routine that sets additional TX poll flags.
+ * @tiocmget: Optional routine that reads the modem control lines.
+ * @tiocmset: Optional routine that sets the modem control lines.
  *
  * The wwan_port_ops structure contains a list of low-level operations
  * that control a WWAN port device. All functions are mandatory unless specified.
@@ -70,6 +72,8 @@ struct wwan_port_ops {
 	int (*tx_blocking)(struct wwan_port *port, struct sk_buff *skb);
 	__poll_t (*tx_poll)(struct wwan_port *port, struct file *filp,
 			    poll_table *wait);
+	int (*tiocmget)(struct wwan_port *port);
+	int (*tiocmset)(struct wwan_port *port, unsigned int mdmbits);
 };
 
 /** struct wwan_port_caps - The WWAN port capbilities
-- 
2.43.0

