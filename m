Received: from outbound-ip173a.ess.barracuda.com (outbound-ip173a.ess.barracuda.com [209.222.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D21B2701B8;
	Wed,  5 Aug 2026 00:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785888547; cv=fail; b=ith5V81nzD0+7GGEZHOc8jWqqVy+Ifz65/jRj+vnsCgNxcPu5cSZFxEFKGSZnVw+LBEpmMojnRHXbEa4N6AghKzhGlEz5sJhjev8QGMcVDxEFiWzt26oh0h0Pk+CDR7xiDERkqGpmwA/isjYU/w4SuezUDA2Lhv7XdvBGCLCno0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785888547; c=relaxed/simple;
	bh=F8WAOASE5pfJgLnJYV/ldxyLldrqscV4+BHzbANXd28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YL9lfjYk3u5iqtMqRh5iPXGgearg3wIm7ZeBzCzvrV20CinaLMPS1Tgm7MDWAlN0foDhlWDJHdvcEMQFm4P1bo0mL70Zpor8UMf4ngCwnNljdSlZEMDav39fcWpJpm703JCrunl1G79UG/9AjuSFQDgfTdKiUArp2gwDxBPBrV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com; spf=pass smtp.mailfrom=digi.com; dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b=mVLxvnMG; arc=fail smtp.client-ip=209.222.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b="mVLxvnMG"
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021123.outbound.protection.outlook.com [52.101.62.123]) by mx-outbound44-90.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 05 Aug 2026 00:09:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NxVNUt4BBCBoq+sEPzAZILfWEBRs9RaGqXZ0OwP0u4SpNYf3Zrw+hK9Ff+Nd99E1stnM9rv89Rutl26s9dVHzaXNWGJ77Y0xbCi1Pi/78JFOwUpVftF6Q4bXAC+bnsTm1KfcV9TCCM2dNoFn7OSbO6WPpP3rpY68iWrYFJMSyk7OveKYBgd4PqjXlamGTL1tHrFi2UYZKFacKnDcdavZknWjj7G4+IjTFut8N4vtQWcz1w9pBR+hLx8n4eaEUdaA7lIY0Q1cVV8W8mgjHOt5sT6W4DsxeAtniECKOeFZ9KSOyD9PtyJlv55e8ExShRjfy+kQr37iKZf0mwoFEIZkBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZrXf8ytQN9M0y6knN7vGj8cIepeXbdx7GRq+XuirlEc=;
 b=ShBI26AOs7XvAugUOmxKgUMjBqWa1InNJGeEBv1NOmA/+ozhhPpumIQg4La+iD8/r/+3ITf1SePWdKIEs5xLXZjnI5vxFtCZG7APyppMYh2ay2fPjSlC5hEFKOAC06P/7d7GuQJb2rtZ0g2cUnW4fos42dscVdibFUOc41AAIpSGDyFCQ2xTt0SYpPfQlH4LtfwBXQUTgcnfG5/fl3197nPRt7GSVR/DxhiTPEr1WxEKNjnwmTVAAUPOT8RVfeH6NF9kN4fo/tLPKxplnjNEagy+TgsANJPEpqLAhMgE0nbcAljYI7dJXlGJFG+imf0wf6y+lkLUb1XlY6olltsnGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=opengear.com;
 dkim=pass header.d=opengear.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opengear.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZrXf8ytQN9M0y6knN7vGj8cIepeXbdx7GRq+XuirlEc=;
 b=mVLxvnMGw1FWBAZU30XzeHd3CRy2hHJ9qFn0naMQhmzLh9uarw7C380L9qrHXY3bwrsJ6PG4f8yxWGeurCAZd2LYU93yHhet8+Uy7H6cjWmHTLoIw5/bNj9t5DY8FlOTQ5yez358ScUk4zA51Ezh02EZ3Ys1/i2MzFA1I+rZcYaTZsrfAw0KCy/PN/b3is05pKXTO5ywp7zn3tb9B8RJualYPRL83RoaQwuqjBJLjVNWsaw/5ZeQ5l/yp9IEJHKwaoTjCBmN5wrFNDc96GQKRiKg5UAMQ23vuKLmgU+vJ4VXGPp8RnoAiHa9f22tgAKFKT9o0KOlfb09SQhduNcBwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opengear.com;
Received: from DM6PR10MB4139.namprd10.prod.outlook.com (2603:10b6:5:21d::24)
 by IA0PR10MB7352.namprd10.prod.outlook.com (2603:10b6:208:40b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Tue, 4 Aug
 2026 23:34:18 +0000
Received: from DM6PR10MB4139.namprd10.prod.outlook.com
 ([fe80::19e9:d558:fd6c:8e5a]) by DM6PR10MB4139.namprd10.prod.outlook.com
 ([fe80::19e9:d558:fd6c:8e5a%6]) with mapi id 15.21.0270.016; Tue, 4 Aug 2026
 23:34:18 +0000
From: Peter Hunt <peter.hunt@opengear.com>
To: mani@kernel.org,
	loic.poulain@oss.qualcomm.com,
	sergey.ryazanov@gmail.com
Cc: johannes@sipsolutions.net,
	netdev@vger.kernel.org,
	mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peter Hunt <peter.hunt@opengear.com>
Subject: [PATCH net-next 1/3] net: wwan: core: propagate modem control signals to port drivers
Date: Tue,  4 Aug 2026 17:34:09 -0600
Message-ID: <20260804233411.1953445-2-peter.hunt@opengear.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804233411.1953445-1-peter.hunt@opengear.com>
References: <20260804233411.1953445-1-peter.hunt@opengear.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7P220CA0097.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:25a::6)
 To DM6PR10MB4139.namprd10.prod.outlook.com (2603:10b6:5:21d::24)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4139:EE_|IA0PR10MB7352:EE_
X-MS-Office365-Filtering-Correlation-Id: 086cd107-cd7c-4906-d930-08def280e707
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|56012099006|11063799006|10067099003|6133799003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 JRSi2/6TQ3Auyiz44zWxbx681wNZYzBaZCuoUjExywryBG0ajeTJ4ggZi9cYWdbZxvXSwuCxtAg6PjVaBC92lQWLFr7ImryMcHcdCLTh7+DKDG2z12YF6iIsnuIs4egQuWbxJM+xUSThPhZbpaR/rtNeRSyi2Cicq1kseLYJm6/HCJ/PtR3qIPgO8gw2GOri2TUzXgb1ovWw/qquOkB0m5Hm0rxZpCYIqwijiQQRw9BdllFpKL25xSG90//AHG/n9Y0YhkAqzEYanJ3ig9XV3U3S3s1eHg0mIYjPSMvgJ0m8hfFhE15NPPJ9q3ozQ2VBlj9Bps41Ig2vchgJbGEELfhKW1dmtKKoZ8+jTGD6HaNQSa1GItvq88Y/YnbSiiKfu1G3pygseCUluP0f2Vwnk7lwcLQ2u2dwCHfZ1RQKzre4uAvhhumzKyEb8EdmnZWSCHYd+0485Ylzw2sJCCztcz++esm8vHC5uG4OeciJe4+AfUQJzGcNzpR7cuNL705e3f3Rd/0ZTKkFYxGkI3wEwu3ajUEclFDjXhx7InrR6MN0fh9qrEyKg1tPAufiRnyb+XS2gIOe111epvLVWUNLbsIH1JqpEbgq5Xd7VpB/z55R/1Tqk/+3pTNjOh1xnQECCFSOfY67Ya7ig0KEiU0Wchpjw6SVf9xjGxjFE9ogdts=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4139.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(56012099006)(11063799006)(10067099003)(6133799003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?igRDNPBucpuZ5Kzap1kdCrLSChE0Uee1qaO4qB6s2y2xMYsltHq4PgscpBVc?=
 =?us-ascii?Q?Cn9vfRRRfCd8zn++EpS6AVSkuXCfmg6D7Uwta6BEqmRRQSBsAFO0ZMPOoHtZ?=
 =?us-ascii?Q?+Kwwz8WkdcjhMo2ms54o5/zfQs8A5oElhp24PQFGA9uYdKapSuXywPrXE4ti?=
 =?us-ascii?Q?1almAMFBXQtMt9fAdqQ4QUS6E4LiQaKQDj/QqYzKZRAZlCojMnF1jpQyqtzQ?=
 =?us-ascii?Q?nh1PdOYyfA66McWH4zFQnb9zB3TolqdVhPz3keusJd63oNsc64Xns0VJVDfL?=
 =?us-ascii?Q?D9IPtp8P2Qlb+mJ7O2oVNAlCIyibq5PwyXis5DfFSGzF/QlIZTiKRTmRk5WJ?=
 =?us-ascii?Q?sFnSsQoyvsXPnYcYDGtjhSW6LF4DxUGhvcPuP35krVuoCjwkVpUz3b2b6V6x?=
 =?us-ascii?Q?sw+8z4j+ayqdfCbb6/F3MfRjO8bf/jBk9jytXU1O99OEQ9T1JQgRKeqNAA4j?=
 =?us-ascii?Q?STPwsyoOZQBU7DrfSbq2CT3KEGrgIiVpHyOPtAGJTSZ5f9Woe8M3FirjHs4q?=
 =?us-ascii?Q?7GKhPMv5i9HFrysYjOsFTB6u6FtTOLmGG2vZsQLCHNtermxA3Uyj5y9etncN?=
 =?us-ascii?Q?a/RoUxF+GxFbiNuAZOgWFy/Z2MOEWQAvsVk+CFEdn7xeU5K3Pg/IzcTzKOXR?=
 =?us-ascii?Q?u4RtkThn7FuW4cLIoCfnTWJr1HkPOCcfBqSdrLiDHDLGujFvGoZVzG8j1yNv?=
 =?us-ascii?Q?Ri1Ftn1stszYKkC/24QyAb0FKHtGHDF6iLrfD07ojygCMIgQVrxlnluBjEUc?=
 =?us-ascii?Q?VxVSC0ifC2b3cWYEHhp8MkdEZXCBXf7PUHwPr4/ltpR2LK3UJCcbgp0tZgLe?=
 =?us-ascii?Q?ch+VKciM+B6zf+iE8KO6wGBuQ9pw3uJPdD1LluT6kTSVYG3f1BGQqK3GmRXT?=
 =?us-ascii?Q?qGa/eT5Kcap+Ghy3Blf6Qmnl+9z3Atnug4IUj0tWTvcbSoLLl/2furCz+dnD?=
 =?us-ascii?Q?e8s/zlTGov1F5CBYsgE2hW4GWpfbDWXqh7CgB7LbSidmucEXlqOjjQmH5PrS?=
 =?us-ascii?Q?OUsjL9EBF30HAuGF2OBBO1Hcb53Zbsfpg5ybkA3NN9ceb4Gv0aFgatggVbiM?=
 =?us-ascii?Q?9hdrONghmzpXhcInSyDojb6w3JxGXfKmNG2u+NhdoPHCS5A2FDtMU4UomzI8?=
 =?us-ascii?Q?FGd7aUzCS02IasCM2/4nk3IOpSQmtns5HMsDMB/Pc+viKK2rVRzjmp2V+Nl3?=
 =?us-ascii?Q?Xx1Q1kS7iVfugrlnLV976fvRToGwoDjTmLjL12uv7LCt8b/PShDSGzL7bXmW?=
 =?us-ascii?Q?xh0OQAU+EsdmBXklE5H2ERPCSbqiosWLnalzZq24HMSdBe8GPgtZKPsf6hl0?=
 =?us-ascii?Q?wzN0Be/xU8Z4tDuukO3P0TjTVRTiXvChiNmU/8QiKq8elE0nK4iavWnff54S?=
 =?us-ascii?Q?/Ely798KYP/Z3P2ENKruh3PcDHC4RBxStFgLHveLLMgrwAH3SjNc7y23diN3?=
 =?us-ascii?Q?LY2J6hzBqaNg7TyGedKp0YxPAhmzsRIFYokXOSCNn6f24aSERFYDk2e4zFu1?=
 =?us-ascii?Q?ozTKMlW7glqVZFxRLGpUY0ye9E7D0LFf1HbcDGfF7wse6K9oCHPFla9CiSyv?=
 =?us-ascii?Q?elfm03w1naYr0Motl7VMQaEHgqSvDLUh/daxlRPSnbXyOXPR4awVOLynvvL3?=
 =?us-ascii?Q?9sb9og1ude2tQv32rGuY/ecgSeNkPgoA/glqH97P4AVYjqDV+XqJegPotFtq?=
 =?us-ascii?Q?3DQuVulfCxicKI9RwBGsQtabSqKBgl6yZzwXi0ykE/m6/QWv?=
X-Exchange-RoutingPolicyChecked:
 fHkphSvUktB12YIrtI4hMJAKilvYdbLHMCHrvAA1B1CNDDKwsJcrrLvIvPzHkFhOdibMHJ7z5YkQ2VVDhJ48syDGr5150bePtpSB+22mDWSfRljfAOmg6o7cQbmy8lTgPUjquCpyFerz4o7d8/Mb7GVKXFW69jCSmZBAiJcmWBM8tY0LdPlraZXQMFpxXAFFyptjvN3A9YPh3KU27W2cN6Gjab9hKtwfy3YilsIb6hCeE4avfEACnpirA1AOGfeeMS6J7hVNBOKeAYOH80x70RAXdCGtBuqeXdlIh6IahuQgGdQ1WFrHNIZLHGNlRJ4AA2MX6OSaIxuhC9pHN+ABsA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 086cd107-cd7c-4906-d930-08def280e707
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4139.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 23:34:18.0739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qe9zWM1wTVuXzmQDCDSUlpqWWxYQqZGaDKnBjuW1/k1gcThrMWE2pCj8urdnmr15
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7352
X-OriginatorOrg: opengear.com
X-BESS-ID: 1785888543-111354-22197-21903-1
X-BESS-VER: 2019.1_20260804.2006
X-BESS-Apparent-Source-IP: 52.101.62.123
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkYWloZAVgZQ0MTUwtwgzSLFPM
	UgJc00ycw81SzFxNzI0DTV0MTE2NBSqTYWAO3BwnBBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.275152 [from 
	cloudscan12-236.us-east-2a.ess.aws.cudaops.com]
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

