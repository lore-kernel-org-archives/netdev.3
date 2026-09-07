Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazolkn19013012.outbound.protection.outlook.com [52.103.33.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2C923E35F
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 03:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788751338; cv=fail; b=I6U9TccUTXmBf0/kfNul6P4sRCtqj9dTCJVAjxmaR2IKMpyINES+ZYyayNsb6jRgo/Thz9vawW4famNCOzGTL8DuOKPEz9WXx3K3IdCp12ss9kwHz2hb07jl3mHedvr0aZz60KegyCfwqmwAePzpgyyt8KPkkGSpZ+fABymeJBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788751338; c=relaxed/simple;
	bh=UOjKza24fqHAu6vteDjogplNMKpKvQHRcEJXzlUc92w=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=aFIgpuRxWwCi3Ww/VsV0nlQMpukr5WmX6nvfkuavuW4fn7VG6mQJfGao37zMUjPbVyteaxJo/RUzoYFA6nGzYfXKvWt9S+gNw0SdzB0db8PyCUe+Qb/pNjw10INTvhgotskfz8gdj8eRnqGnbedisvOjhEnMT5uPvlbm3EjZKso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk; spf=pass smtp.mailfrom=hotmail.co.uk; dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b=MpCkFOqY; arc=fail smtp.client-ip=52.103.33.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b="MpCkFOqY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yd0l5DV8t7r92PaQKskgxW6FVr3ql/ldA76xTgXvSHsGT6UzMsMwYGA5RF2ZZRYFshw8NISiAXubQqM2jeW9zSWH2cnNT8b3I251HU4mzzHqNqxDx3YMzxbnlxwDL2nqDVsCobnifc0FkIrw6Zk/Urq9fUf826b4eiWdNBBuBNd1k0UQLK22WMdfcwmyRBsxLjuJWRas8JiVLM3+/Z5Pr6P0v9ztKjdIq+l/w0WD4LZMPyZZ1xaIQOpRNzUNo8aguZH20ChW4+r250Nk+XrOUUqVTbdYV/einovPrGsod2GHsc48WAv92QS6/5dhWT/JpbRbgvbX+8pXSEQzbfImug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dwNqe2ZlVEJUt9mVehMwVROnbTrpta0K0r+NKvUNUws=;
 b=dQGNQ1cQKgiXgp1TFmSuEyAdLT9Pc4+sbju75x4SozmdAaiiFT0sc1K4k+nxc/T3vLdIrMcEj2+owcJPRHhzWW34BrHGGCO3NatknGVd5yhp90i77Y5fiRzvkQRxOwcong+T4PB9we6B5VJF4VggNcnHLnTqfvvusKQhdFeViEMJesAS3GBjHDLivZpbV27J8gXKXKSUwZdg7cH2tFrWb3DuTZAfjc21Cvs5G5mMfdmgawpSb7aDbzgxm+uJ9F0AIsMrQCmtwwR+4aedSCTc/N3YBXxkgpqdZuIBs0ZyppE4FkaWmTz1pC8fPQEvgb78ByUHtma9MIqp8sZUID0UXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.CO.UK;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dwNqe2ZlVEJUt9mVehMwVROnbTrpta0K0r+NKvUNUws=;
 b=MpCkFOqYhrdAc1qxCMGzRiV04lJuM4wdaXEtDfzfgArjRHq7ADGqyroBJ9NLDuMBR16jIBJLnlMYqhKX//UQLenhWvHA4GLJJlDhNt8mbBdUJumlarK73m2H3jlkh6lfpVynLaPAq35uzqwitbK+/5wLswdrGaWn5WfQpsKp+3sI4oRDeE0VwBXGrwitJwsf3yGnV15DSuDA+i/InI3ngJOmP1GMcU4d5nh69c8PepMD/C2AbKbMZ9OuaVwj184eVnfy/87XcdZt+MPu/2iB8rRUseBHMmF4kOLE6+VpChp7JjRRShMFmLnD0Ue1fzS3BQOHb7CzPD1lK1SajYMKKA==
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:344::22)
 by AS1P251MB0679.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:4aa::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 03:22:15 +0000
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352]) by AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352%6]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 03:22:15 +0000
From: Aamir Ahmed <elb12345@hotmail.co.uk>
To: enachman@marvell.com,
	netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	Aamir Ahmed <elb12345@hotmail.co.uk>
Subject: [PATCH] net: prestera: validate num_counters in counter response
Date: Mon,  7 Sep 2026 03:22:12 +0000
Message-ID:
 <AS8P251MB0001CC8A4737B0CC46F41DDFC8B22@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0216.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::23) To AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:344::22)
X-Microsoft-Original-Message-ID:
 <20260907032212.515363-1-elb12345@hotmail.co.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P251MB0001:EE_|AS1P251MB0679:EE_
X-MS-Office365-Filtering-Correlation-Id: 95b2abec-fc78-4448-71a6-08df0c8f36c0
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5062599005|24021099003|4140399003|25010399006|5072599009|15080799012|19110799012|51005399006|8060799015|23021999003|2604032031799003|55001999006|37011999003|25031999004|12091999003|3412199025|440099028|26104999009|40105399003|2607281247196008|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KnqT1TXRzvNaVU/RVEE1D5oVPti/F0R7XxX3yHmwkOi/0kwZcJaA3BW+sVu8?=
 =?us-ascii?Q?GONaypQ2grRCjwD3cD3NK0g2NiQlUYbI9ZXTZS3NnjvirgcX+hFNmyTsdGG2?=
 =?us-ascii?Q?eaT5apzkkeYWHsGNokmOyrQM5glPVd2paeLcGOfWVlf36LvrEzr8qkhnXvsi?=
 =?us-ascii?Q?rjVRSUlV1+qqdKCc8uYPO5HCuEmi1DhbJMSDjzBY6uh1KWeKyWCdRZydZJpD?=
 =?us-ascii?Q?NIulxICO7v7p15x293hT55BFD8GgufrsMuE0JURET5q1eprQ/fvQR2meElJZ?=
 =?us-ascii?Q?wz1jm3PmePMWP3kSCaCkQXm1vjdZdI8+CEIKxBv0kisezvy1Nz8mZbkq3iQs?=
 =?us-ascii?Q?8M4HE7zpWauBTG6UwZ3uIIUKpOwDMNgKZW3QKjgLr99ATQQLE5JqECmWc9Jw?=
 =?us-ascii?Q?Q19X6CChVoknU2TI/H0YMfE9FH17zRIw1zEcWYBryqW/9cjIWP8AV7dxLyAd?=
 =?us-ascii?Q?Kdh6yGRMVK85VQbNk2TA2Bf8B8ArQL8IJctwvyngzo5JhaVMNir3tWqE7izy?=
 =?us-ascii?Q?X+T+lW72lrJzRRfQBle11ifC7cJmKlfQ7RHv1mSNPvGO6b4AJopowBjbP6lZ?=
 =?us-ascii?Q?QgLDzdFzK1limWZ41cQsLrat7v1tOTjag+LKm+TsiFPQiFu4m5O/BTsTqUzk?=
 =?us-ascii?Q?OL6Xr/p/HnqpK234Ak0v3iQ0EKGyCgZ1hqjOt6QDlatOn9DLdBv9ckXflB4z?=
 =?us-ascii?Q?9J2BdGdE/bmQBVJUNUI3uFl7AUovxolIf6Vi6MGWKDegd7Nurw0nIX3vA1dn?=
 =?us-ascii?Q?Uwbbu3Az7XLo3tfh5fSVRYH6hdfl2fQBKn3mM+y+LI+Z+NFvWp7nlh2ZOqW1?=
 =?us-ascii?Q?gHc6fQ2/oZpGuIVPT59AqaBnCZYzue8bnNS0DZnjgH54GnTHN/0sJbHQtBDB?=
 =?us-ascii?Q?lSKvSKAUpnj8c5FG42KDTZ6wrUn8wi+9PNZOuHymz/ijJg8ieDhpT24pGFH1?=
 =?us-ascii?Q?3bSzcGlmlr5kaauQretZFmLvPMrUcqtV0YU6gzEYwXdtllGMyHrjLTgTP+4J?=
 =?us-ascii?Q?t04ndTPdz3m+XuF6J1vijoUr+Umzcvd9YkiUqnD/uU925Jo5u28yOy8AT9qN?=
 =?us-ascii?Q?M4YEAlXzX7EskmiQl94+lkq2qtEd5IZK7wgHoAyLkUjIslOzOMtcP5BV75+c?=
 =?us-ascii?Q?pJ/jgQX9SdCaTAo5O0dAP7jni+q13Iy4Qohze0NExxjExg0mDvLapco=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MYgcHgFlF2UEL/O8qyaIzkecIox22TqMR9Xh1JBceL80Xzf1jCSFEeGivspK?=
 =?us-ascii?Q?O7wDIrR2+KPUNaZtgk+4yiEVFCBF52lhndWGkykzegVg2UkMkTGP/NrSJeKc?=
 =?us-ascii?Q?cJ8UDyRIG8rOYwOQ7aSn80m3qpqeixfQwp5Q5OUQoPWdPb7DQSCvubTJ9rya?=
 =?us-ascii?Q?peUUDLRnmGv8+642m9xa+7NSQALKs7mPI8fDcINRAXER6Cw+iOJlMlXpe5fz?=
 =?us-ascii?Q?3bqhG3fcqMhxNuf5+g8tyytXsEOPFUM4jYE7MhmsTHfZIYlWtJn8DMXksxuT?=
 =?us-ascii?Q?tcI516nzVonsl1P75riChWR3ueQPUWShwIUhL8D9nX57N9lX3unoZBahlc2c?=
 =?us-ascii?Q?sNM8WER2eO6PUU9/gZz9/KDPvQTZVXhRcKXQ9rAXA8AWQ4u8UEHuAedjpwlB?=
 =?us-ascii?Q?AoigD6y9Ci76osI41WxPavfzbAVXIE4yYwhJSKkZ1FPUhw1UuWzs58wlEZgM?=
 =?us-ascii?Q?A/mEfAeEunA2VYojO2rseFqyQ2xFBigHJ5xjB4dlqoVQ9tp9gdyg6UR7y0ea?=
 =?us-ascii?Q?jOq/vq4Kn6DcInWsYhh2fFGjemTSlxeFhgeptZ/Hr5frMTY0jUyamm5nb63t?=
 =?us-ascii?Q?C5CgFL4lOO2Qo3dlc/bjipZmy7vvtF1vwiUwJR7RhJOV0WvMKG29yGPeShmg?=
 =?us-ascii?Q?oPRAbD4tJBuX4qkGBItcGQ93gVAAlRLuK7olBPAxItBXdfG4NFuTsUcff+ao?=
 =?us-ascii?Q?YS1894bFU8RkQG+jM7Z3uC/qg9eJaBaoP/YjnXQU1RZYl7xa4ZCCDfIh5LCO?=
 =?us-ascii?Q?SgsrDdhACf6PF/slINKj1SYGbOQd/IFfjMYwdg85tIL4G7eeYPKNj59WMCQc?=
 =?us-ascii?Q?R+1Y2TJljsQWFCGAE3TDZdyLk0Y84u3YTaDYsmFLwuBtQEorJPQxRMBtIqvw?=
 =?us-ascii?Q?VpWnfz6EBixSqbErF1XeVvAAGY2U7Vrzr5lsri7NWH+8f9PM/w+p9xJj51FK?=
 =?us-ascii?Q?lkt7nIzL7OhY5ksj2+whoxTDwM1JBXrsKqa5Q3ah/ZJcQTB9r4yvVPN/Nqar?=
 =?us-ascii?Q?/xPg7oYVdBQhLhT4sYi5JIqykXwSJhwI+hVeC2EPj4xc3TGjafjSIc9qcrkC?=
 =?us-ascii?Q?9jmo1+jq477Wc1h2MSLphAdPByDv37XWiKCLhquz8lc07PNjLB3Tzo5DE/lg?=
 =?us-ascii?Q?JuQu+TTWSKZDpIxMoJJrVgeJ5t8dWI2TIE+ulWI4loLWhqy+fzogCrw4oKgd?=
 =?us-ascii?Q?EIIU9tJRvIb3bPJnPFqF21ytOT+b2sX/F96ZXSSuMAWzN6dLQ9ZKFq7W45Se?=
 =?us-ascii?Q?7QFSZfUpzOa/rE+oEDtXtSUNfu0mM3V9/rtpRGMLGa8hhEwkoeS4HEEjoGxj?=
 =?us-ascii?Q?j2qs+YXUK8D/4r6GcpFYcZU0jPb8oWwT6LvdVLSMqTlVx3Qpo6W4UeNyr7vQ?=
 =?us-ascii?Q?JIkxkxuVYEzEsfIbuc9qe5YYH08Z0BE0ronY0pTffHVdnb6hD3iDdJ/PAUxU?=
 =?us-ascii?Q?Z8nveHQkItEquXo7dDlrIHnBV5Ik6jya?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 95b2abec-fc78-4448-71a6-08df0c8f36c0
X-MS-Exchange-CrossTenant-AuthSource: AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 03:22:15.1483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1P251MB0679

prestera_hw_counters_get() iterates over resp->num_counters
entries from the firmware response without verifying it does
not exceed the number of entries requested. A firmware response
claiming more counters than requested causes out-of-bounds reads
from the response buffer and out-of-bounds writes to the caller
stats array.

Validate that num_counters does not exceed the requested count
before iterating.

Fixes: 6e36c7bcb461 ("net: prestera: add counter HW API")
Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>
---
 drivers/net/ethernet/marvell/prestera/prestera_hw.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/marvell/prestera/prestera_hw.c b/drivers/net/ethernet/marvell/prestera/prestera_hw.c
index 7695cbb2ce62..c4cb5f22893c 100644
--- a/drivers/net/ethernet/marvell/prestera/prestera_hw.c
+++ b/drivers/net/ethernet/marvell/prestera/prestera_hw.c
@@ -2324,6 +2324,11 @@ int prestera_hw_counters_get(struct prestera_switch *sw, u32 idx,
 	if (err)
 		goto free_buff;
 
+	if (__le32_to_cpu(resp->num_counters) > *len) {
+		err = -EINVAL;
+		goto free_buff;
+	}
+
 	for (i = 0; i < __le32_to_cpu(resp->num_counters); i++) {
 		stats[i].packets += __le64_to_cpu(resp->stats[i].packets);
 		stats[i].bytes += __le64_to_cpu(resp->stats[i].bytes);
-- 
2.43.0

