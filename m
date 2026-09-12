Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazolkn19011037.outbound.protection.outlook.com [52.103.39.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE1138398F;
	Sat, 12 Sep 2026 18:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.39.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789236583; cv=fail; b=CN1w59NCpOL1YLMjXWN0bxn6IhCxQ/xYKGR4zPh5p5vLG0dSWgnK8wNuIDP6CUulW8Tek7J2+5gdL5CFcOF+EhAdUcwgCzJIfMDVc/YiUcguTRf/ICWHYoSdppPhzsD9i2EF3+fnNIYCTxNh8zzUUj4yQ9o2X648Yn6/RL2J36A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789236583; c=relaxed/simple;
	bh=Z2n5cFYpRYUqX0FXEdKhFocz4HEWsi/YcQ+qbANKXBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ib5wKQqQTvYs0sjSqBkdsq/P+5+egy9xrujuo95BZ3DXu+0H9UeTbIOws3VkyKPPeJTcIPUU/dVBFgc5nWKcmC0M7mZnJYCuOqXrBwNyMDzFNeq+2KjLYF2qMXx/7taKUAmiEKXEXbI/IZhiJZk5pNPwnhHckw3INDPCiLf+rc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk; spf=pass smtp.mailfrom=hotmail.co.uk; dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b=mvC5S52g; arc=fail smtp.client-ip=52.103.39.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b="mvC5S52g"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YT0O2AnNx7O+q3u4UUhpj5vyP3HFZBPjVz/MUgViy1FIkIMMi1z6nIKTNSoDIsntaciR5fMF67lgz8v3IcKEO55/FiIxRf3qHlnr13aFe/RrSmM1uH8szH/P6mGJzSiBDghA1teYbU9TfNDHnDE1CFUMXqlqGYAOQHmwLIgsI1uYfzaPVUHrgdG6uISPzC1O4D00m6uFbhoAp7dXhIL4qklCVAESwRfUowtwiAKEQu2zd9Dq2ynnF0NV9nNtHi563eLOiZcRlV7mjqXUPLNhI/4SPrsl9CvRloV8LE8gzsNRefjFgVl+1qi+Fx5BPX0qNyavTsSGVRo3fRC7qetqoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k99JQC1JoYDDMH1bDQNsjfqBc8mQCrO0T142QLFr6JI=;
 b=RfxgMi0lT0zKTpC5nlizAd/5YE2ycmXSdV8N7UQMdSk9c/zqSUroUv+eIfvfnFO7kcv5KiUDZCQ5ZuYHPvIVkjHAlNaam5Vrr0xkSD3RcSjXoMqRNpnofDod08zx77z29ti3AOQtvztet2UMZMajt8GqMu6rFKmiTPCcu2CnXwELwRwguJqSiVRAgmIbBKsHd1zktF+XXnC4e93+AvsBFalj7JA7JpXhJSohvV0Sg4wcqSnviBZVdZlME7WaOKvnwwFYP53b0EekxG/+lWg1eG+In0TMP64ddUlD0yHf3emR+bnCFVO4+1PVmjYIzl4MI1ZjYmSuEQXe6aPMQddcWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.CO.UK;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k99JQC1JoYDDMH1bDQNsjfqBc8mQCrO0T142QLFr6JI=;
 b=mvC5S52g+pNGQXvEj9vld9JE2EwRzq1T6APT0h6v2kSWhUYGqCCo5cSYODuF1eFoDHXZg6SoEEx0IRZEEfOj3Vfd1UiygCVCbgSlFefHo1dQ42XYfGqLUfMRuRCzKPPpPqkC8792IqLd/Mv9FRPRn1OIAxtQNMDyu5AwldvdYWwDxR+uAebeV93pAeSL/SbK7249pDjS7qryXxhTbdOlem++HkquKEXw698zuO6bIn5oQddWXcWNPJsROepk94rPl8UJBLykVnOwa8/qn657Vem5+A0ufLIxYIqv7vh8R+9FVF9CGKYaP/8k1XmI6Jg9JbrUpnYdpgOOtDwju2gVDw==
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:344::22)
 by PAXP251MB0494.EURP251.PROD.OUTLOOK.COM (2603:10a6:102:28d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.11; Sat, 12 Sep
 2026 18:09:39 +0000
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352]) by AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352%3]) with mapi id 15.21.0406.007; Sat, 12 Sep 2026
 18:09:39 +0000
From: Aamir Ahmed <elb12345@hotmail.co.uk>
To: Samuel Mendoza-Jonas <sam@mendozajonas.com>,
	Paul Fertser <fercerpav@gmail.com>
Cc: Simon Horman <horms@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 1/2] net: ncsi: validate response packet length before accessing fields
Date: Sat, 12 Sep 2026 19:09:37 +0100
Message-ID:
 <AS8P251MB000151B1FA33EDC00D8275D2C8BD2@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0036.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::23) To AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:344::22)
X-Microsoft-Original-Message-ID:
 <20260912180937.60250-1-elb12345@hotmail.co.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P251MB0001:EE_|PAXP251MB0494:EE_
X-MS-Office365-Filtering-Correlation-Id: 0313ec6d-0830-4e89-cb2a-08df10f902c4
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|4140399003|15080799012|37011999003|23021999003|12121999013|25031999004|25010399006|55001999006|24021099003|41001999006|5072599009|51005399006|5062599005|19110799012|8060799015|40105399003|2607281247196008|12091999003|1602099012|10035399007|3412199025|4302099013|440099028|26104999009;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cUm3CiYbw6NTrz4FzssRUsKFTUl7mdBBi2J0/II7l8g9swI65HsmoMaJtpKe?=
 =?us-ascii?Q?ZwN74E5/vLAygh9SoQy9L7MrnYyG+Zpte0ES7MWIb3p/TNNx5qsOs3agcC8+?=
 =?us-ascii?Q?faMj2HOy1cnyX2OjWz6aANC8vY2k1vz6sMbPPwfgKx1jSl+Wx3wZv2kEC3AA?=
 =?us-ascii?Q?j2NeiqePh9b7X/zjLGbDCHQSJrAhPzo6iW99RKf+G1hADuDotqic5z96Ol2X?=
 =?us-ascii?Q?A6ehVIEOVJpsWMO+mCO/dVKhLciM8j/yNZ0jL6+vrD9wXtbd69Zih3sgI6gn?=
 =?us-ascii?Q?ZbT5kOwJEohG7ABOiPiQ5y1Fuc8SKPkqhJKIxUszCluHTOgIFgNtVq3LSGQ6?=
 =?us-ascii?Q?B42+pclBkbgfIJtYBXnBKPEP0EjAr34ZHCABMNuwTG+FZEM0quV0hiG2riUU?=
 =?us-ascii?Q?+SM9qKu01yRB5T1MW+J2THaS8tHoMKwMJ9eV+bgpDDnLI3VsJshStrL6rukW?=
 =?us-ascii?Q?6s6/MlTU+DW/+jk0HYcy9IWtH1IrlHFfD/4QTW4FxpkMahRZ7+Z2O4uuVYAS?=
 =?us-ascii?Q?x6Pa6polk8zQZ9Jvn/BIBpw95GxvuJlC/BHvzW7JWnjjJCt7/WDKBzab3NXS?=
 =?us-ascii?Q?1HgLXeO5KgFuL3RbFGuByT+bDPtpi4pgHUHp4UBa5cfPyh1QzByqq/7Qo+Zc?=
 =?us-ascii?Q?b+iRC5erj0iQ/EuJoWFHZY5a5sZxkeFFMPCH6V+jkdxwKK+5iXu5krg/rfay?=
 =?us-ascii?Q?Ye5XlgbuD7/9gEK5HkCqzrQ+S94wHfUvWciavroX/foCQQOM3CHtSASadG45?=
 =?us-ascii?Q?AxE99A1VscgOTSdEHQEUdDcXkTTWcX6XgX01sBtXUMPibicr0U78kM9DZhf3?=
 =?us-ascii?Q?7W+rgSoGr3bg0cxR2YzcrM8HE51917fqKFwls54KjqE1D2wquNxs76SYAEZv?=
 =?us-ascii?Q?IrU7u/WpvThZzmy2+T267a6oOi/GokyHWr7ivDvMmfyj2sAriAN1u5pRT6MU?=
 =?us-ascii?Q?wyeNzdg4qT8bvmFaTzbyyVsFAMPygd/JggxKgelN/nVPoBzIpf9RRKvbiJlX?=
 =?us-ascii?Q?ZMmNzcA2KpXG1/mjWqr0td14Q0ast9fUZ/uQj046xXvaG7b8FVRmXQNcXiuF?=
 =?us-ascii?Q?f8yYITUjvtkASLFUNmKjPq2g/MdWtm+pEGZ+/chHtCQSqXp3M8frhqJJ/1Cv?=
 =?us-ascii?Q?zgV7DLLoKTaGZ1hMeGDWxonrs3aBcAS7xmGCI8txbOx8OzV578uf80/a6dW9?=
 =?us-ascii?Q?lY6aGE0PQ/YDXZdI7aW+bxDTbgPK9HIWFSttGYA9wLpjC9H7lLmflKqxp6dK?=
 =?us-ascii?Q?IXKkhF1a+voMXzLyVQhb?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TerRqLzM2FTechkl/YhnapwRSGkSGVXm8mmlQ6uGdmKpzU3GKz4jIyzSRioY?=
 =?us-ascii?Q?Mp+DQS46ueWKj5DZRUHPAN837Tori3lPQz/1UVV5q6nOxPVMnpME6HmpDl9l?=
 =?us-ascii?Q?IxJPQXJunsoaFVQr91aUYV1KjNxkEUuL2n+fTeiQKJZ6gLXb2QZ63VT/I05f?=
 =?us-ascii?Q?yC+avERwq0PR0h63fd5VJ9xbtKHjXd4gWgLhkgkfR5A6HIDmF4O6NW/eNPl2?=
 =?us-ascii?Q?NxVow3UJOuLkhUYTRgyW/TuhYvxraTxBQpuEJi7SYIbvfTQqa8jXlvE6jk29?=
 =?us-ascii?Q?iGDiri90nNC9Dazj4rcw1S0U+ijoqCSJy280KbeEqeKdNGIgn5xaZUEXctHy?=
 =?us-ascii?Q?4shR9oK33LNdOxRfmw8UkJVh4EELCevHBb9XZQX+FMbhuyC8224jXQrVpCQc?=
 =?us-ascii?Q?TVg8sXI/3Mi+1dOuNiswAJ6AnE/mDlmIS+SDADJqfHn2nTmqhppgLizxcq3t?=
 =?us-ascii?Q?6rBoCXBaPPYFpDaZQ8veFyDCtkjqNijLWe38ieQkkRj/nnjQ4dGt+shqDgjI?=
 =?us-ascii?Q?29hQ5V1Lhp+M+pnHOy8v1EbvzeQzF8f2rM2h3c/xTcL58WTOc7BhNveOyhDL?=
 =?us-ascii?Q?L/e0HrKCaOXBxlnZ8EIWsRl2opZex8PIixMP0rEn5MsDwe/AcqVmLXhSHqBb?=
 =?us-ascii?Q?EXrnfsXqzAB3LmhmxigNydPuvAcXUml3OCbOrgsCvKQ0H4LUzgfPPuvDprcL?=
 =?us-ascii?Q?ZKBMVdfZQe3+4HiLYYmvwglykNYXFV3ZURRAPH+gQ3FUH6dk4JjFnDlne9Zm?=
 =?us-ascii?Q?LlM4XgfCiAOEGI86cZThkVNs567/75w2fQk3upTb3zuEfas1/ksA9/QnvvZf?=
 =?us-ascii?Q?eU9sa2hKOQ58f2fPFxsIwZDhloSPL09tY5RPx7zsaFTsvEEMNNSpFfDvaS3U?=
 =?us-ascii?Q?81AcAUyQfAHqxSUoiE/5Mvfj8pb6nYeyMGGND2wp6NPxvU/9TjxcCRpuTVov?=
 =?us-ascii?Q?hcO1Yej8mXvveCWEDDWeQYFkixWGICFlJdoMWcOcQZRyHDzo2pOEahasJLdw?=
 =?us-ascii?Q?s36zqfTW+rgGaj5SkJ1G9NpQBxJx1X1CWfJS6ukYhIbvxQNwRh8tt0ivpu21?=
 =?us-ascii?Q?03UI2j86KbEW1qXecehYEkJsgl54PFPqYbLV6i+j4vKjvj45w4uLwECAAZWt?=
 =?us-ascii?Q?vyKk2Ke5BhTKLriSTm4O/6racqWkA7AOG2Cs2ad/vN1wpAv5OSS7txQauZbn?=
 =?us-ascii?Q?olvRxMxGvMuALX7Awl13W+67cT7QGqG5HoCpR8u6MOPuHfPd5zrGh9LzBlM5?=
 =?us-ascii?Q?Cn5reFQkGc+X8yLgRY65iW8sMazOpa6lr7vpxgF9bP3dwTdVHZO+eijv1o8q?=
 =?us-ascii?Q?GYyYy5j3HDISEFvcV3JoDmllUbVbSzbqH+mQrCD1Jd5Q9B2r6ApYHQRS2h1T?=
 =?us-ascii?Q?NQlXseNzE5fdj8kjGMT2hJbitxbahEq6DzTxI97LR+nvpQMMOM9JDv8Ku3pB?=
 =?us-ascii?Q?l7+HtE731F8GF4Y870OEsGTz3kOcY2UI?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 0313ec6d-0830-4e89-cb2a-08df10f902c4
X-MS-Exchange-CrossTenant-AuthSource: AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2026 18:09:39.1682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP251MB0494

ncsi_validate_rsp_pkt() takes a pointer to the response header and then
reads the checksum at the end of the padded payload, without checking
that the skb holds either. ncsi_rcv_rsp() reads the common header the
same way before that.

For response types with a fixed payload the header length check is not
enough: a short frame whose header claims the expected length passes it.
For the variable-length types (GP, OEM, PLDM, GMCMA) the payload comes
from the header itself, so the check is tautological.

The response skb is not guaranteed to be linear, so use pskb_may_pull()
rather than testing skb->len, and take the header pointers afterwards -
pskb_may_pull() may move the data. The payload is padded to four bytes
and the checksum occupies the last four, so the validator pulls
ALIGN(payload, 4) rather than payload. ncsi_rcv_rsp() keeps a copy of
the packet type for its error paths, as its own header pointer does not
survive the validator.

Fixes: 138635cc27c9 ("net/ncsi: NCSI response packet handler")
Assisted-by: LLM
Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>
---
v2:
  - use pskb_may_pull() instead of testing skb->len, and take the header
    pointer after the call (Simon)
  - pull ALIGN(payload, 4), not payload: the checksum sits in the last
    four bytes of the padded payload, so the v1 bound did not cover it
  - guard the common-header read in ncsi_rcv_rsp() too, and keep a copy
    of the packet type, since its header pointer does not survive the
    validator's pull
  - correct the Fixes: tag; v1 quoted a hash that does not resolve, and
    the blame for this file is the commit that added it
  - drop the GMCMA hunk; it belongs with its own handler
  - add the Assisted-by: LLM tag (Simon, Greg)
  - name the target tree in the subject
v1: https://lore.kernel.org/netdev/AS8P251MB0001E6ABBE0B6809D3E21B9DC8B32@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM/

 net/ncsi/ncsi-rsp.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
index fbd84bc8026a..e4264a028acb 100644
--- a/net/ncsi/ncsi-rsp.c
+++ b/net/ncsi/ncsi-rsp.c
@@ -42,7 +42,14 @@ static int ncsi_validate_rsp_pkt(struct ncsi_request *nr,
 	/* Check NCSI packet header. We don't need validate
 	 * the packet type, which should have been checked
 	 * before calling this function.
+	 *
+	 * The response is not guaranteed to be linear, so make the
+	 * header and the padded payload - the checksum sits in its last
+	 * four bytes - available before taking a pointer into the skb.
 	 */
+	if (!pskb_may_pull(nr->rsp, sizeof(*h) + ALIGN(payload, 4)))
+		return -EINVAL;
+
 	h = (struct ncsi_rsp_pkt_hdr *)skb_network_header(nr->rsp);
 
 	if (h->common.revision != NCSI_PKT_REVISION) {
@@ -1172,6 +1179,7 @@ int ncsi_rcv_rsp(struct sk_buff *skb, struct net_device *dev,
 	struct ncsi_pkt_hdr *hdr;
 	unsigned long flags;
 	int payload, i, ret;
+	unsigned char type;
 
 	/* Find the NCSI device */
 	nd = ncsi_find_dev(orig_dev);
@@ -1181,9 +1189,15 @@ int ncsi_rcv_rsp(struct sk_buff *skb, struct net_device *dev,
 		goto err_free_skb;
 	}
 
+	if (!pskb_may_pull(skb, sizeof(*hdr))) {
+		ret = -EINVAL;
+		goto err_free_skb;
+	}
+
 	/* Check if it is AEN packet */
 	hdr = (struct ncsi_pkt_hdr *)skb_network_header(skb);
-	if (hdr->type == NCSI_PKT_AEN)
+	type = hdr->type;
+	if (type == NCSI_PKT_AEN)
 		return ncsi_aen_handler(ndp, skb);
 
 	/* Find the handler */
@@ -1230,7 +1244,7 @@ int ncsi_rcv_rsp(struct sk_buff *skb, struct net_device *dev,
 	if (ret) {
 		netdev_warn(ndp->ndev.dev,
 			    "NCSI: 'bad' packet ignored for type 0x%x\n",
-			    hdr->type);
+			    type);
 
 		if (nr->flags == NCSI_REQ_FLAG_NETLINK_DRIVEN) {
 			if (ret == -EPERM)
@@ -1250,7 +1264,7 @@ int ncsi_rcv_rsp(struct sk_buff *skb, struct net_device *dev,
 	if (ret)
 		netdev_err(ndp->ndev.dev,
 			   "NCSI: Handler for packet type 0x%x returned %d\n",
-			   hdr->type, ret);
+			   type, ret);
 
 out_netlink:
 	if (nr->flags == NCSI_REQ_FLAG_NETLINK_DRIVEN) {
@@ -1258,7 +1272,7 @@ out_netlink:
 		if (ret) {
 			netdev_err(ndp->ndev.dev,
 				   "NCSI: Netlink handler for packet type 0x%x returned %d\n",
-				   hdr->type, ret);
+				   type, ret);
 		}
 	}
 

base-commit: df2908090cda368b01ff43709f51890076c56157
-- 
2.55.0

