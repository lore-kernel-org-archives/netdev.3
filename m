Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazolkn19013010.outbound.protection.outlook.com [52.103.33.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997D439281F;
	Sat, 12 Sep 2026 13:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789219191; cv=fail; b=g36T3HWeQcyG5z1qrQOStOKZMv6ezWaVQQJnPS8rcvy88gFGDAKBBNXwlvcfdWXxKB+51sU5d/cJTl4bmnkQgdkg74GNpqQwptg8/jIt6w82q0suDjTrdgJW9bXydTGwx0tRRg+xmnNfecY9CHXbtgfIbwq1YnmelOqGnnaCk6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789219191; c=relaxed/simple;
	bh=Bkp15FuTIjX0Yq7SSmDJ5Na+uzyriYOI7SCEmsJQH3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=P3bvlsmQ60619NbTDEUPjPXIfPpURUZY7jPXZInkaZI1OF94Jx90s6IXeqOUHjYStkicfy84KvA45qhzHJTxFAJIxtrI72FDKsQVR/PtxEFU/m8zQfQOgSn7hkNhQWorV0vKGBxp7b3YPbQkLOA5fr2bqnoBbo7gLHi8fRzVEZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk; spf=pass smtp.mailfrom=hotmail.co.uk; dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b=hPsLgphI; arc=fail smtp.client-ip=52.103.33.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b="hPsLgphI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g76EiTvqDBX2In9x0HKnOk+cbsf6ENkMlwCtXWGtUtcjQa3CiVCxZjH5sBVmmB9l91CnpmN0oxtzyZJeMN6vsOhdrYLDv9AT6qkaQehU2TpbFOWvSz6Jry3AXAxZ4ju6qZrN9fl0xoD1Maclw5Tacalp5prgL32do7ZBe5v18BS7tAA+TDWNeP0GwoEI1mloismM98oW3MTYpWTyTzQLx14vvWu1g838iasBfeJIm7LdAvoFEZ5OIw5XhrrIvxfeF1ACM6Vh0r7xZOsNEgvvX0TwwtlBtpaRr3BQx3OanMuvPi7Lmja9GU66Dlxp5Dp7S79Y+BlqbpgGR0JUyTG+Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/7tYDJEGBzqa6N+hTu0e0g/njA6UEQ3vWc3fLKnteM=;
 b=Ttzf9nITruxwNLbd/1N62RlK+wvWxGxemZCuQo3J0oHlATyoNNUF/somF/XE6V8CAhWlp4jU5HxVLuYe8DWVZx1JOsHqq1WnJDlv8Ultyk6HCYu46XNHn+kLDu0dJG+odR1FOD4+DOUmq0XsmP9pXq8b+Z3VHmGeoC/VrBQ1JVQQtf96BR9rQB7rE0X7YJzWRTYc+OlH7o1IbYYOWDHoMh18QtbRA/7RUp6VLXEb96wYKp0PHLHZjBqqlxo4B/taybJFPWLYDMq9pk9Zdsu7F/P/65SBOtRecatayD3wONcBvM2IIETeDDgGig+QFlkSsv0VdiGVRCUW02yoZSb/Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.CO.UK;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/7tYDJEGBzqa6N+hTu0e0g/njA6UEQ3vWc3fLKnteM=;
 b=hPsLgphIbIMycaagk2ZnNEhKR73HsFYg9Cnob1kkSJ0Zq10nGsOmMRCk0XVBEiiRlrdGwzD/HDlIdSm8Xni1kIUD0723dAsItCVypDRVK0pGoAQpfZ4iro2ucks3sayKUrRYKaZ4OEFXYCuMy9w4gp2ZAa4Xf+KBurOTEC76nbotYrMI4PMvOf67iDCML6/XuvwsXEucAY/aaxkpdKrglDQKEMbeJRyRC+TbuPOdvkAjMNrqjPZfVx1Cwr4Oi+KcmDe59qe6o7+pYt2FSV9plZaEJEm5JDfYG8cVNWDxh1SOvM1qj5DSeE7Udc06ZOYw+ggm8bK6/57qwQLJZ+BWig==
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:344::22)
 by GVXP251MB1056.EURP251.PROD.OUTLOOK.COM (2603:10a6:150:1b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Sat, 12 Sep
 2026 13:19:45 +0000
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352]) by AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352%3]) with mapi id 15.21.0406.007; Sat, 12 Sep 2026
 13:19:45 +0000
From: Aamir Ahmed <elb12345@hotmail.co.uk>
To: David Heidelberg <david@ixit.cz>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] nfc: digital: check DEP_REQ length before reading DID byte
Date: Sat, 12 Sep 2026 14:19:43 +0100
Message-ID:
 <AS8P251MB0001F45C42BBD0D16D7B30ABC8BD2@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0382.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::9) To AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:344::22)
X-Microsoft-Original-Message-ID:
 <20260912131943.14056-1-elb12345@hotmail.co.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P251MB0001:EE_|GVXP251MB1056:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bcbf333-f0a6-450f-f208-08df10d08324
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5062599005|5072599009|15080799012|55001999006|24021099003|8060799015|19110799012|12121999013|25010399006|23021999003|51005399006|41001999006|25031999004|37011999003|440099028|3412199025|4302099013|26104999009|1602099012|40105399003|2607281247196008|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3Km0F2nfQDIN8RkFyp2/YTeKAQohdc5TU2gRTy1Gi8d52Kvm4CmK5F2Ya1CQ?=
 =?us-ascii?Q?9L/+VVG87+bK/w7j+kswI8HkSEiGVs3J4I7JC/1keZtTo5m/55R4hIi3D4Cn?=
 =?us-ascii?Q?7SagBJgTTGyWYMo1TSWgDyJkDdMuMzsN+cbaP4/htUdbDj/SCWyqVO2g6FKi?=
 =?us-ascii?Q?CB74GOec469U0XgzTTkDul9fwj/XSxNfySlGKzY9nOvGktkkL6vhVVmo2e2e?=
 =?us-ascii?Q?uaD0gqLuAxyv85rDPTGDFcPrw9ex/gARv0LvaOEXfgY2H+2WPQ32XpZDght3?=
 =?us-ascii?Q?LjcqpdCiAom0JIc5uauxFGJJFFZX2XxgElWu9EoWppoHSf23YD4AI9uV1OQ3?=
 =?us-ascii?Q?Yef16lFWxlxqts5VgBBByGPUVCXgIsh1nEaTvD1UxltRt/DdZuT0eCw+fkxS?=
 =?us-ascii?Q?Ynu1DpBoHc8QDiJmgd0vdvx91YsS6DHypnAgf6ptnmh5bdSYiuKmzen3jrgI?=
 =?us-ascii?Q?xRqMhHz0QqG9Cbe3dT8WSNipVhRGcaME1FvbcS4j6z64++lihuyi9ovj6wgx?=
 =?us-ascii?Q?ovQWllTb7QF5EOv67UVBW81wdMz8NfC0moqclug3EV6BdpgW0pluisBY7pV4?=
 =?us-ascii?Q?M2Q17JPU/a9VDdtHcuIQiqsyXgoBrkM0j27vxU7d307Wq7zNRMXGwR29bY45?=
 =?us-ascii?Q?jKj9yz+PGr3xvyE0hSYkDqUh3k1Lth+CN2UBAjRTs0zaP6DnjQfSF6ta4cpk?=
 =?us-ascii?Q?CO7cjxK2uS48boOtYFXPdlMQ4PfM+2edqjz1L6Mkqd162fHyO8OKhNOoAHvg?=
 =?us-ascii?Q?7aEfPTSqcgTSXTG72mzS1VA9cStXvJf58kBQ7VCaBzx2xiF2+on7kvZolA1F?=
 =?us-ascii?Q?dqTBsUnPQPmOi7jrtjnfk1wGi2HeYbos/vH6gk33eFk51uDxs/CNsWUoK8G2?=
 =?us-ascii?Q?qo26nP9yCUEQL+JN5ftuAQRuv0pnR5Gaw81+g0ssAPaWGwOAlXWePkpc4+UB?=
 =?us-ascii?Q?Qi8IVvhXPqSDpRTEPigw3c5iA2gk/czjr1DZp6CjQzOGELrmjwKZLkqzPFAQ?=
 =?us-ascii?Q?hWI+FXvq0nR7G+P7H/zdt9R75LquhAqA4zJ8q4ZYA0E38A/BaDEXmj9zIEm9?=
 =?us-ascii?Q?SwPMzbUkRRaLXGRu25iv6eI7qaom05H5ctkKVlmKzl7InxcgaCdQlYeVDR2q?=
 =?us-ascii?Q?X+gVZ64YmCbXgx2hVJFSkBE7TwUz/b2FvWiApbV1/0rlgJIONkcMmXFG26H/?=
 =?us-ascii?Q?gWOqSGIXyeXMNSx1cd8JuMvtNucEs9eGfEEZBw=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hbQYQJQbpXFsJbPSTtkAlQnt3kMhGcVAqUzldhqV/QfGCDfoFWvjLHCIW7A8?=
 =?us-ascii?Q?D5q9QYZwX6X5NMl8FVCDTfe7tdyjyQISg2HY0Hn6qhP+WT0Exz1ec480W9QR?=
 =?us-ascii?Q?5vKBcXraT6g7quqOpmj1EHQmsTSLV8NLxk9e7fAjajcq2TICx/Ittu5fQeho?=
 =?us-ascii?Q?2UG7o4twaInKh94XDLSmYFeQIcDhrOgbRQWf/ahPj0JL6Ye6j7EGlS/mknv/?=
 =?us-ascii?Q?95tGCRCVu6z78zH2kV+9g9Tmu5VPiBxEKiD1YWKlWoGumuSmH2/Ni+ydZm+D?=
 =?us-ascii?Q?ZW3qHN8OGTxPUZkxB6N91ae0uFGy8u2uyDCZ8oFJ92UUsjgpnHB3OvzeS1Hm?=
 =?us-ascii?Q?2v56KUA5DGaWkZh/LZRr1f1TJVyxMBYyDgWW84C/FlMGg6phMClhaqWnuXPB?=
 =?us-ascii?Q?0NyI4+X1x+5xWsEi85jQONL3zXCfM+d7TPWE8r7yf2Ca/RLzz3WV5kjQtrrG?=
 =?us-ascii?Q?2+Jg78GOMouVwLzujO0O008eUZz4dw7vn6ZrPRXOR5KvgVW/C2hMXHsbr64n?=
 =?us-ascii?Q?lfiZNgDUu6Mxn9dg1i69+fEsHufMTcHdXBuk5SlMaGJ82KESILDIZyAwqyPc?=
 =?us-ascii?Q?le6l5eKacnPSs/BngNtAMyguggXrMih/+9d/cdh6Qt9G47FMuy4abWbHBMCN?=
 =?us-ascii?Q?CdZAqbSGW/TOxaTJaEAbP8zcX1m6yk3vAYKdLtjMJZLumK4m4DXG+QICXowy?=
 =?us-ascii?Q?KZoJgBrNXjHKwV0y5UFMNBQcn+ywMqtPOGMVn9UaRdNEbzDJaH3a0WSFD0MQ?=
 =?us-ascii?Q?2wDLJpCOtMqnN0rypM+zAT4aCrQ30V5k0g7Ack9pACo1wKDq2Vk7t2ZLgtTN?=
 =?us-ascii?Q?oZz6kvaVMhWJD4A1Axh6f3rqGUV/xo0tRzlvGLXtxZtW9JqreeDaPfI1QIgI?=
 =?us-ascii?Q?cIcI6CfdvIIDZhK2b9qlOSutfUpwcCmDMn5/YWWlffTIpGD4Kq51qAgrYosM?=
 =?us-ascii?Q?SlicxrpKHRjrv5dw5odWBqmGd93/QztnewmE15cLpNZOHBkRW2u6BkmgYzL9?=
 =?us-ascii?Q?EatwICxqm/Y4VfbyuO+6NBXATF7CXuIGiddJawptZDUtxGm61GMct4LIdv1H?=
 =?us-ascii?Q?ezbGPDTCcnZTKZr7RlLDYQJ6R2luT3CNe9ywyiZtnR7n7jjqchLRvhDBOEMW?=
 =?us-ascii?Q?6PlMNCsN7CVM/vk6Cg5iIXsZOABdRX+agWa5Oz1SKNA5LyCuuZ1q1XdrpNbJ?=
 =?us-ascii?Q?KlNXBUCdJl1OY5OEiDskLPCDko/prm+oZ3i/3D3oQEjCVqr0yXoCVphGkrlX?=
 =?us-ascii?Q?Kcel7uPiik0d9xwBAfgjrUrc3J9y2aZ4NTtA9g/hzgYABz3kGauuJLkI0QWM?=
 =?us-ascii?Q?VZhCk4cxJwC7AP1MIU1unX70/4QXesgRg7tKgWcrG5IYftFiyYMHnuWBiR9o?=
 =?us-ascii?Q?46SM6R5i2aBQ+o8BPrD0/khV7FiWP/Dc/RqJH1orVj1MkO0nq6CTvJO8rxy0?=
 =?us-ascii?Q?93YSiwI4g0crbq5USosHBznCVVnnS+5Z?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bcbf333-f0a6-450f-f208-08df10d08324
X-MS-Exchange-CrossTenant-AuthSource: AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2026 13:19:45.2296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP251MB1056

digital_tg_recv_dep_req() reads resp->data[3] when the DID bit is set
in the PFB, but only sizeof(struct digital_dep_req_res) bytes (3) are
guaranteed by the preceding length check.  A crafted DEP_REQ that is
exactly 3 bytes long with the DID bit set causes an out-of-bounds read
past the valid skb data.

This read can happen on every DEP_REQ from a malicious NFC initiator
when the target device has a non-zero DID.  The stale byte is compared
against ddev->did, so in practice the mismatch causes an -EIO return,
but the read itself is undefined behavior and accesses data past the
buffer.

Reorder the condition so that the length check (resp->len < size + 1)
comes first and short-circuits before resp->data[size] is accessed.
The existing fallthrough to the later "size > resp->len" check is
preserved for the NAD case.

Fixes: 1c7a4c24fbfd ("NFC Digital: Add target NFC-DEP support")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>
Reviewed-by: Simon Horman <horms@kernel.org>
---
v2:
  - add the Assisted-by: LLM tag (Simon)
  - designate the target tree in the subject
  - collect Simon's Reviewed-by
No code change.
v1: https://lore.kernel.org/netdev/AS8P251MB000196084524EB27D62162B8C8B32@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM/

Compile-tested only; I have no NFC hardware.

 net/nfc/digital_dep.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/nfc/digital_dep.c b/net/nfc/digital_dep.c
index 3982fa084737..ae5407fca12d 100644
--- a/net/nfc/digital_dep.c
+++ b/net/nfc/digital_dep.c
@@ -1117,12 +1117,12 @@ static void digital_tg_recv_dep_req(struct nfc_digital_dev *ddev, void *arg,
 	pfb = dep_req->pfb;
 
 	if (DIGITAL_NFC_DEP_DID_BIT_SET(pfb)) {
-		if (ddev->did && (ddev->did == resp->data[3])) {
-			size++;
-		} else {
+		if (resp->len < size + 1 || !ddev->did ||
+		    ddev->did != resp->data[size]) {
 			rc = -EIO;
 			goto exit;
 		}
+		size++;
 	} else if (ddev->did) {
 		rc = -EIO;
 		goto exit;

base-commit: df2908090cda368b01ff43709f51890076c56157
-- 
2.55.0

