Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010012.outbound.protection.outlook.com [52.101.193.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AC51096F;
	Mon, 17 Aug 2026 03:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786935749; cv=fail; b=TL9z6deaY8I+Vws0Ao+Bnqh/LJ/jsVOsEZ6JR2cDfHkxDOfE9IXQiVG29MbfYP8V+cMSFqfj+5fMdP8xv30boEUTDNhGfR2QH/8+4uFQNS8wr0OXR+Ojirck+XpErNF7Gq5+sCUUjyAh6nxXb3P5kspTa7XpDMLZxFvvStIKs54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786935749; c=relaxed/simple;
	bh=+sX3tQS0Aa1prq59muET6r0GQuzYugJKrYiwO25jVYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iGrYUj76Q7XNAvA5ZA2d2bLJ1AkQV0SEyyj5h7EgzJ1LG6M6E85vkvLLOax5Kuct+Te+oqxrhrfFGEkwC3snq8k5DmqWPfVmGNbHuEfmco93wqZBfVGDOVO1EO3fsIITCg7T4po5HmV0HpJrMjEeZkZbScm9JIEA0Dl4dvsJfo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=O1XP5NVS; arc=fail smtp.client-ip=52.101.193.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="O1XP5NVS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u2PQOyg1atfswmFXp0voWR8Okxs1li6T6wgPLTThns2M3+egM17q70oi6WhEkz8uwvYByMprV8VdV9meFRoz5RvKspYnWNnWspTIDCG0qPGOD6guLwA0Q3hcpmELfTtTi1HHLIccAayVqjZdsuIKfZLmWYyc2Zn3ddl3stidvRBCpIQqGtBn3uXCb5lsyXVJDOFZ51DLaUTRe0aXIjlEZippBrdUhFOE+T3rVs9uy0I1+pmkgXqUMQV8WcwsKz3cvgkR1OMV003pjxS58HfHUoxEhT2M+lxxIa6TUtE5Vq5cp6DPKg+gUcJThmeuUt/D7LwwhbTQyVv23VesebXZfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fS+CM0a6Fga7JhNc5fDVOvDCKoIOMQ7R5N9GWmGVxqw=;
 b=uxMN4HYRJ359ovKvYurq6/oHZs3wbjoY7Is0VKMC+jONrTxKuq1M3UKcICkxRFN3CLfXT1Eu4pQ1b+cuU4iboRrmsqiXOls80M+a1Y3p//Dd70UaA3mD1f6pAsi3qiXWSRRurH4ulK1sGL2lR59wrTfCjebpKpLkkuzV5ZsnN7OzdBGtVz8lX+f/cuzrPFPctiUXFY4Hmckxy9LZig327egFKuUa++RgKKi4LQrwGP/NA4FISNII7CmV3fJ5F8xvjJstUtZDwzugNiwtAMTrQ7t3QDsz3U+2EixNGdRQFKKjxAEzS4vY+t7RkYyl4HxMjYml+RO9JsYUDjoHh0NG7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fS+CM0a6Fga7JhNc5fDVOvDCKoIOMQ7R5N9GWmGVxqw=;
 b=O1XP5NVSznFWbe8ic01mxMUjmOquUS2sRXor/onFigk95saTN+iEwQ7wbXl41JPQ7UeAkWVxp92lqwhNpsVA9uQhaPOJHqI6/UaYCP58yJ93jAtc5dLxNOL3RO3LDYBDzVLy7dLshq8XFupmp0HFB5/gwYnIinBHAU4eE0IdHnBq6xC7ayge5MG2jrjtTo83hIhE0G+88Nzne6iblV5jNa9v3pMYBoTea85FRFYBorbga9WaZPdVaDXOgzGiDPjtbEPPy81Dp4IiS+zG7TZnxszGURrocCOpuuprg3tS+9/BVGeRlNCZiX1bmrSqTRkqo+Wl3MK0csonICuCWVfRug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by LV4PR03MB8355.namprd03.prod.outlook.com (2603:10b6:408:2da::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 03:02:18 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 03:02:18 +0000
From: muhammad.nazim.amirul.nazle.asmade@altera.com
To: dinguyen@kernel.org,
	maxime.chevallier@bootlin.com
Cc: rmk+kernel@armlinux.org.uk,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	robh@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/4] dt-bindings: net: altr,socfpga-stmmac: Add altr,socfpga-stmmac-agilex5-tsn compatible
Date: Sun, 16 Aug 2026 20:02:12 -0700
Message-ID: <20260817030213.6769-4-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260817030213.6769-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
References: <20260817030213.6769-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0096.namprd05.prod.outlook.com
 (2603:10b6:a03:334::11) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|LV4PR03MB8355:EE_
X-MS-Office365-Filtering-Correlation-Id: 339b0d17-25a2-4692-f68d-08defc0bf2c2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|56012099006|10067099003|11063799006|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	EY44IdCSdAgVMkJLDapHxKFJpzOjwfJWXwXUH5S0UUGgJskcQ/CAFjPGRle49lMsR10g4zRJup5h1GRlMYDIvqAUV7D1XEVvOhfNMzoI2IGYpo0U8/itiqLnWaaiBw+1xjLIzPbMnFHKF+gLOFUBPsvbdnXwPZvr1/X9hObt4KT/o9aWuTXObiV0IXW/nssKkW74B636d2xgy7z7FhctvYpcxaKAVvVTTcFN8N5KjuOlsv05pH/x0Ur+G19Ug+Mp5Ll9JtVbiUNXrzdsq8BcpNj3+ZhMk+yXXuCwf5YgH1u8uZssS5Pj7IS5VdRt6SVRBrlmeztmgIQmDsNtOWniIkmoIL4hIerOLNUKxS3iT/hpWMxvUDpZ/uc/cOZNN24Fgy/5hXYst4xd4vyTObxfOrT7NzsDzTPbKJPidSpo0mqFH4ZkMh7nDYe/6yItVmZJSpk1lzJ94RNfv+QhNzSTM8V5VMQe/qxi14/BSeayS5k+Xn2FTaKsXVOdb9J5Jmvrqta78Dz2RYtBJ3LBqEu9NQZlFjVhFNiMspIgmAzqVLfP+Y1f3/T7TYvupUstrxnJE/9rnL16Bdab+2MLUgB9A0vC1hxS+EdRW7hUdBUNIs1Si0y4JwLPXAXaqSdb136YmmRnw2IajHFzHN8esv2Yj7ZYjzLDCcNM7RbN3pWSh7c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2ycn4M0hkBeKv4x2sxMDyy0BmgqPaJCqXsdHoSRMnAeLJ8Z//FH6iQuYlC3x?=
 =?us-ascii?Q?t0EOOclmYpPB0KNZVkoj2tt3/kxTFjhGrRRtHu4UD+AeeWn2dsj1NqOwtAQr?=
 =?us-ascii?Q?2E/ohJNRbhtGvek4OBAcoG2XpMXChQJiNsCccVoPmHXijZ3eEfgz2GHc6gXU?=
 =?us-ascii?Q?vmCisJSGiX+JR/tijz9xlCBlQ84coJ3PYZSlOCYW/tu/PpzE7OqhgYcwyc1q?=
 =?us-ascii?Q?fI6ItHSBWm+fc/vEVPGTC8xh1/+t1ocHk3xDyW0xPcx5wac10Vq7xq7RsNAx?=
 =?us-ascii?Q?zXJC5526MCkT+2YLsWEb33zARBvWXmQF0CUGJMpHnnB6dUf+H/ngdhFbhQdm?=
 =?us-ascii?Q?ys+KaeOapT1oJa803n1gYZlCFtueDaBCeqxuWT0xRJzxa7/N+iC3YN7EGg/k?=
 =?us-ascii?Q?4wtp+ghI7QwLBor0hmlJNYsTQ89OH7A+61lu2aqio+dJZTWdG4RICetfpaQ9?=
 =?us-ascii?Q?kRjztWWpp0bJ9j/nV7yqR3aJ3U09wmn85YlIRIQcHgBV9J2nfHUVhVwIu2CD?=
 =?us-ascii?Q?osyYSuvwwcCQPKeXRFNKtMxfZhOndwIIZc66Ox37COfMaGFmxqUr+gIYKvHS?=
 =?us-ascii?Q?MJxFfYkXasnvo17wsm2CFV4OYHeQ142ByLzntnWWxf1O8WOp/V5sw+OrqOBY?=
 =?us-ascii?Q?6eb8ZddzAwhvxei0EaNOSE1oI2Xnm+kZfSHiLYuO1fov+N2IxXpMPFu13ha7?=
 =?us-ascii?Q?UjaHoE7arGlimBgCUjd8dSFMX60f83BX7Khs8hlczDtn3TySY+J2abVMccM5?=
 =?us-ascii?Q?6TK24/1YGBKNY5NBW0ysiHwNPZb2MTbTHst2wO/NzGfxPQhEwlwaCb26ZY9N?=
 =?us-ascii?Q?ILoI+B3OMBk3OAezgYK+NHnSpFIla7r2LMTRNBovpxDgsHn+mO0AfIRJFdAl?=
 =?us-ascii?Q?8jf/cNPbraRd7rNf7JvTIdQAvS0cCw/j9uQiPqDk1qTiuRK5wyUC2TDoczAd?=
 =?us-ascii?Q?8tE47Sf/wNulJNG+MdvylrmH8utcTAcb3pWG95APjTLVNtwAPOP/a0TxJhqh?=
 =?us-ascii?Q?1MouYCCK77N99BHr7jSphDBJjQfwOYYLp8apt8McExoZOCA9yxycm6fxmAj3?=
 =?us-ascii?Q?AJgikTW7gIjoH6av5bxM5hmzPuB1W9ZxBI/8AqFGl3/87gQpglGM8bPBnIyB?=
 =?us-ascii?Q?YId8/AxZlGqvsmFE1D5kJ5NDbGkfh3ium9onZMHtfMCFDeyq+aNAzaX9kSLA?=
 =?us-ascii?Q?usvJLiBs4utFScAP2eccavudH8cmgCLRTWC0F98td+gOSD2nSe1nzmxTx6Ni?=
 =?us-ascii?Q?5HwQHEDW95tbs8V+n4cAlVUQ9G6Y6tQhdTWT8hkHExSZEx/mAnuKUVxBKNI6?=
 =?us-ascii?Q?dFOcBuT8FAZsTFvt8iQHEtszYw4zVh6ebUy2XpUcrryItTzNte7TdQJsOyYO?=
 =?us-ascii?Q?UOFmSuqOmj4vIp/Yy+7ePss/mYLmTz2Towwy/ySJc10XvViNo1KjTG/ccTPu?=
 =?us-ascii?Q?cZP6Pay2fQtJPYIpddElVuOkKVLQkutjn0f+aQsj+yRBGkVTgmW71mlsBkAy?=
 =?us-ascii?Q?MYCijwWLF+0gF7iIBPh+kwwYrrHNRB/4AZl71mbSvPlMauOro1O2Fr7kHJtF?=
 =?us-ascii?Q?teAkthq0GmK4zC1L50ixY3AGY1zDAm28rz6Ue06VKANoVebbZgnF5bvD3nK+?=
 =?us-ascii?Q?/fc1cdbsk0mCKsBb7qXZBibPsFLGfCoGVIOIH1P0QtlliZ2kwPI3aPqhcP39?=
 =?us-ascii?Q?xotW56b/bo3BBhPaJ/sAjf0IArt6SEiM+MPnDq19hFStQomclWcLc2i2zrop?=
 =?us-ascii?Q?R9PTvdjQh/4l1XvlrH7XOcZHj5LC38iBoUk2gtcT+OYW9KPZeBUi8G6XrVWw?=
X-MS-Exchange-AntiSpam-MessageData-1: EFLhHhftKSm2Hw==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 339b0d17-25a2-4692-f68d-08defc0bf2c2
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 03:02:18.2606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AQanyGRXXmSNgZnQ66eiO/K79RpIGKki+QkuRlzDhJDDNaPOSS6kWPaEx03mB9YkP2wRFOljvDyBYOVK9P5/LJWGPpyICPmo1L0niWcOXK9KQcrCyfoFY+5QKj7woj/8ZU7+FROUJQFfqTEg0G0btg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PR03MB8355

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

The Agilex5 SoCDK TSN Config2 gmac1 path includes an FPGA soft-IP
GMII-to-RGMII converter between the DWXGMAC and the PHY. The converter
provides the RGMII TX/RX delays and presents GMII toward the MAC, unlike
a plain altr,socfpga-stmmac-agilex5 port with no such converter.

Add altr,socfpga-stmmac-agilex5-tsn for that integration. It is not
listed as compatible with altr,socfpga-stmmac-agilex5 because the
converter presents GMII to the MAC and supplies the RGMII delays,
unlike a plain Agilex5 GMAC port.

Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
---
v5: Drop altr,socfpga-stmmac-agilex5 fallback and rewrite commit message
    to explain hardware incompatibility, per Krzysztof Kozlowski.
v4: No changes from v2.

 .../devicetree/bindings/net/altr,socfpga-stmmac.yaml          | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml b/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
index 63084f762373..7db6a7102994 100644
--- a/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
+++ b/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
@@ -24,6 +24,7 @@ select:
           - altr,socfpga-stmmac
           - altr,socfpga-stmmac-a10-s10
           - altr,socfpga-stmmac-agilex5
+          - altr,socfpga-stmmac-agilex5-tsn
 
   required:
     - compatible
@@ -46,6 +47,9 @@ properties:
       - items:
           - const: altr,socfpga-stmmac-agilex5
           - const: snps,dwxgmac-2.10
+      - items:
+          - const: altr,socfpga-stmmac-agilex5-tsn
+          - const: snps,dwxgmac-2.10
 
   clocks:
     minItems: 1
-- 
2.43.7

