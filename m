Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazolkn19011030.outbound.protection.outlook.com [52.103.33.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B62D43CE4B;
	Wed, 16 Sep 2026 08:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789546776; cv=fail; b=a0o4CyKyg6lY7OHpb4CHAuOqg6ja1PHmyRmxyZFPsflWbgZvc6t0P8KSO6kZkHDTjn8sdfpW5hBZz7l8/B8f3ytk9zpxm+Xe9XTi/n/RycaeqUsOdGeHNRA6rutDnkjJVh7yKLrIk4DOgpKTLUwXUM7G1goa3l8ZDi1WwLBF3VE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789546776; c=relaxed/simple;
	bh=gHFRNhUNweHuC9U6BQX9K6Vni3D9fjb1ZmqgBsJ6yMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KRHZgrYa3KbZREIXWE2Q52rzjrnF7ujNX5LOpBsEjAZRa3VTDJHiPyPBtFwt+zNg7MnkMu9oAsw23mbgQdx/CUi+G0BJEomzV0kmjrfAb0uAO1IXlDiRNbKYh68fQF/TqS+q9JtLdokD96e3uImzaBamlM1DAkOZ3FZwRMEgvdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk; spf=pass smtp.mailfrom=hotmail.co.uk; dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b=u+bzk+cy; arc=fail smtp.client-ip=52.103.33.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b="u+bzk+cy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ECKuRMAs9TBwAqwXurB5p0rOWIUSsw/zXnBbQ5aVHFasV6Su3b0MimzFD235HtOloE0BjG8PCalsCvs6nikkR/I5SOrcwRYxSEIQWYM5rw1lgRV24BZBku+myepoNIrlUQqdKFRkJcEYWz1K1Qj0A6kYJTJxSIXv5jTuRLUMKA225tUwf7kURyIVutqubD1s68vatiXKYt1jVkzalo0aSt/lH0PWKe+wRztcOXvUHre/5dPc7peIn1sCbxa2hxj7iA/jmcNBHd93OxQxmDNwq+MDLYECeNHzfBia7gTG7H1CBLr4+Gr8+Yov1LoCYH5zomU2Ap/8LE6y2sqb2ldSYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1KHLYxYd8DjqRo5xO31ANrShFj/xyYJrGAaUWJjFZi4=;
 b=IomRMPPyYLLFhvOSL5ir4/uTLxqyqaEMGn6pWOWYNXPnTR7cRo7F52hRm97GQR0RnxtBM1s7BVtU7+BG58KUus//r/EU0hhoaKNjK7f6u2pZCOZW0BVwAk0nhRZTu202GZuIfMYJ1NlWf0tqjXxr1lZ4OYRS5RPTSpoW550QQD7tFQxPx3xbnxJmrGiyZ+N18Sy+8AGowm9kB5VoG7OUZyHfyeZOincf1fXYPxo9Rf+/MG4osyQgFELTipH3S7KBpjm/WPH5T80obmZEYEZVoUeKY6rmDeNj5gJzuMScJfIzjBR9mmrZWtosVZbqLzeJvQRBqXVNNUA6VjN21yxAlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.CO.UK;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1KHLYxYd8DjqRo5xO31ANrShFj/xyYJrGAaUWJjFZi4=;
 b=u+bzk+cyztJw/qxT+Bc4XY6h0qXnpc2ISnZSb4ubK2yuwCtXE6of6F1sfuoeZzKR+CU3uf0IMRqx9fR280O2bpeX08eBso0Ywtu2F3vnYDamH+Dc3tbhNnYCJ1Nk584OEkZGEee5J3k4V/4NTMWCzeGcgO5iHn1PqMy7R1m9eMLPNPhME+VdEhBUyIlDQr2T9NhQ1FsMtXjtpCyZP/FCl/bgSh9JcWbnCF6BBwyBaWdiMEm0rS+xAqY7+zDznKzRzrMijHud0iTdE7KTKxd24zPDiZwUcJOpYO1HxmfFPWN7dCf4XVaCR8ueMpeq2oKHQEZIA0Rq3oxX+EBfnmxqrw==
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:344::22)
 by AS4P251MB0895.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:577::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 08:19:17 +0000
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352]) by AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352%3]) with mapi id 15.21.0428.008; Wed, 16 Sep 2026
 08:19:17 +0000
From: Aamir Ahmed <elb12345@hotmail.co.uk>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Aamir Ahmed <elb12345@hotmail.co.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Lucas Stach <dev@lynxeye.de>,
	Peter Korsgaard <peter@korsgaard.com>,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] net: usb: asix: reject a truncated Data header in rx_fixup
Date: Wed, 16 Sep 2026 09:19:13 +0100
Message-ID:
 <AS8P251MB000156CD4ABF9B3E03324492C8B92@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0.windows.1
In-Reply-To: <aqpKPXiVESngnVhp@ashevche-desk.local>
References: <AS8P251MB0001D5442318B9E58797D230C8BA2@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM> <aqpKPXiVESngnVhp@ashevche-desk.local>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0235.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::12) To AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:344::22)
X-Microsoft-Original-Message-ID:
 <20260916081913.16658-1-elb12345@hotmail.co.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P251MB0001:EE_|AS4P251MB0895:EE_
X-MS-Office365-Filtering-Correlation-Id: 47822aff-86cd-4eee-98fb-08df13cb3308
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|25031999004|25010399006|15080799012|23021999003|37011999003|55001999006|24021099003|51005399006|8060799015|19110799012|5072599009|2607281247196008|40105399003|440099028|3412199025|26104999009|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PsWSS58FbM7s4Y9QB/KY4y9RACX1p6WjNUeBqG5EQScVgAM2vQx3Sg/+KPI3?=
 =?us-ascii?Q?zoUVLSqYQXqOUwIw8ZL18RkmoxAsG9WWGxdaAYJPwIh7YINwic2Yp3dhNrCc?=
 =?us-ascii?Q?jrXFPxgoGggErSTs4S6tLXSuMnR51CaTg4kQxBzPnj+wMOqlsuO7NdZvdvPE?=
 =?us-ascii?Q?0iEQP9K/l5eYZwI7Q/6cZLol60Y4AjZvuPyiVUQ02pqQcHv8ZbXrW7RVJMFa?=
 =?us-ascii?Q?MzBzcFM7VGgWvl6K1Mwen822lWrVvvSmbPqgHVgBDn/Tf6O3WBN3/ivuKKG3?=
 =?us-ascii?Q?g++10rYGO/uWtkvntj65IYx4ZqG8/PeUiBSvr8VKw7TwlhTerFmyKVrb8GNP?=
 =?us-ascii?Q?1KkVVJ9dvwlw7Jsi2Bojze0R0Wy3VKMQkCq5eKOQRMqvtPDUWULBhha/04jO?=
 =?us-ascii?Q?I8nh1n4AUEiOYRA/e1PO7Y3zDIFYh1HC7LiNBqJf3IBnq+O04NxpeVoPQVOg?=
 =?us-ascii?Q?/+A1GHuiPFJJQrXJ6IKPdimiK64N6h3WKH7oXcwPA/QeJPF6M8cmAm5sB476?=
 =?us-ascii?Q?YekJD06FFDFcMrjMxt0Xm6HhU2iqWAZacgadf72Cn9TAN5fgCTPe8RErvFLx?=
 =?us-ascii?Q?wYKA+47eNCujwOPq+IjsoQa3pxhBrzvZMDkDtwgftdXU11o5tVQ82fMIxmIg?=
 =?us-ascii?Q?+UJTN27v6CGvs9l4IvlYMuyZSRebKWg4rwqpXo2R4J8O/n2f6xbUAlQpPwOA?=
 =?us-ascii?Q?PML/rJVzAuaWruxJn1fHrUaXW5FOhCz9ZVi928++diJTHEuEhpxf4ZnGD0+H?=
 =?us-ascii?Q?OyyRaQAt3d3rDismnj1MsmpCXCIT5SDJ2GzJvPDUHGpZaezwSHS94NToGY6O?=
 =?us-ascii?Q?JZbeZWkUhBEqOoIO8q/80AGnE6EHjf3A2MbHiNOJIRmCYvv4FVzFvEvv1ag5?=
 =?us-ascii?Q?0WJ5qS6ypaxvPksvWfsEQ9CC/3fPwjxNb7PNsjVDXbxcuyX3P+EMurUOaC1W?=
 =?us-ascii?Q?3GHSnH2Ip7YoNOIarv8AZGRmOrW6wiCLBHD9BE6TEx+MJMird+C9eFG8ySQ0?=
 =?us-ascii?Q?gGB0Xx3ud3R0cG65xnS0QvpnJjAwd9vzm+Lzq1SftMCfC+QfZb73uRV4wbEc?=
 =?us-ascii?Q?yIOiFvjE?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EknnhUn6hUNAA1LsXhEJACaKDb3EGYj4Jk4/MJ3p+p31p3/vu5P7Mb9y/SBg?=
 =?us-ascii?Q?/b+Bj7og6avD4x0cTifZhbfAjg2AHSZ3r+kRA4jn5i6EttMVuGGspO26iD1B?=
 =?us-ascii?Q?3RRXcSbRn+zBuMwnepgK8DSfQ5lf52c4PoPj1/cu7IkgHOEGx9EF6e2Sb8un?=
 =?us-ascii?Q?ZYjS2dwjdczWo8PLPC0JCKiQZiK5fvsicfH7+jWni1fyAvlBP84r9qP1RsGE?=
 =?us-ascii?Q?zC2A1Wux5CdkRibrefL/D8xj6XCNkpP1JXU5G6abLUZDL77uu7BXq6F0Xnvr?=
 =?us-ascii?Q?g1SmUYTRAECRLQHnme0d3WkcotiWMlOFYZG1stpE04UaIuv9Hu0eoqwDXorm?=
 =?us-ascii?Q?++d5LHVPWXiXkaMghTXG2k2IHTH0V5zDKQ4ClguUozCv/JxRO8rkWV6XaWMZ?=
 =?us-ascii?Q?DvXfGiZBUrs0/eHa3CjFWlJkKguMf1IM2t9vdLFg2pqhY2LNU1wIPDBKHmtn?=
 =?us-ascii?Q?ajZySLq8x7KMayBBXfhUFLD5A6F4V7n/TyxL480OCvtl2RoQR4jNPHzYwLYK?=
 =?us-ascii?Q?0kXZVL7/gBTFJ5bRGNNnmdtkL9UHA9/or40aNE3gyi1y51VUK2H9mIXOlKBQ?=
 =?us-ascii?Q?mkIUlzp/7sRlfbKCihLDHL6CILnafgg/pURXwlyoXmkBKQvVtXdWFWNXS6jO?=
 =?us-ascii?Q?u+umLmnjLbow4zNHhTD0d76/VjQuS1WJFcj+DQ2oaIGDiz0DWKCVdRUUMC2l?=
 =?us-ascii?Q?M6h85YhG+hkZOjc/KleYPJ9DArtpiGrW3RMnbREKvtuPwdYVFyeg+Y8ztFco?=
 =?us-ascii?Q?kSnLTKSUuEFR35BbCoTmjW6s5DZkk7hUh53/jAnCnXgS526uvExWU9oJsYUh?=
 =?us-ascii?Q?ZTQ1FocdmJaZx9RiZix5Emt/vyYlX7WT+dbOEDVJdYIlga0hkRYWnKG3l2ac?=
 =?us-ascii?Q?bNRlhgvqG3UDnwTBnNXdi9mL/n1Yxadl7IMWF6byOIKsRqzPd9bp2XLhbUmU?=
 =?us-ascii?Q?kPgcQG1wWMCIyEJGTgOGAj40EV4w/E/rLh+ajtAbJXXbidXqhqisUDTLNLOX?=
 =?us-ascii?Q?qPOa2Dp5vPwJ95Jvsnz3MCbDVjAmmcCrMqfHRSRVai367RoBVK+hND1+s7hu?=
 =?us-ascii?Q?Zn/USO6725ohOs7FoqhyYaVi5O2kJ5MMtRaa3UKRUQXG24qutNEsvyMrT/5F?=
 =?us-ascii?Q?FySiehOMdrEuImswXGWX3h8pr9RRpaYXIbkeMCdsJnx72lMyaetJWOiZlmGq?=
 =?us-ascii?Q?JjFnScUssK1grCKgnwolY7SOU87lI79pgzPTLzbml78AcVGgWB/MTWdru+FA?=
 =?us-ascii?Q?6KlzuUiaFoL41LisTEQJAOwHjqNgLmLxC/EsyC1wAGARzNTQC8uegsDA9m3Y?=
 =?us-ascii?Q?PKAcpThrTzQfTPgARp2ibnHHKmhQ4d7KGZQMOr35g3JJeOHYlSAUXkDVdk8l?=
 =?us-ascii?Q?YTUWptOFXqZJ0LIupeVMjauhhe5BL1OWvZ7yAeFzXkt1IiLVLwl25hjhwafi?=
 =?us-ascii?Q?WCQ30JMtLCevgRH6RvZvq8fRyDOUZcVq?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 47822aff-86cd-4eee-98fb-08df13cb3308
X-MS-Exchange-CrossTenant-AuthSource: AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 08:19:17.6200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P251MB0895

On Wed, Sep 16, 2026 at 09:50:21AM +0300, Andy Shevchenko wrote:
> I don't know the rules about __func__ in the error messages in net, but above
> may be simplified as
>
>     netdev_err(dev->net, "%s(): Short Data header, offset %d, len %d\n",
>                __func__, offset, skb->len);

I've based the error messages on others I found in this function, here
are some examples:

  netdev_err(dev->net, "asix_rx_fixup() Data Header synchronisation was lost, remaining %d\n", ...);
  netdev_err(dev->net, "asix_rx_fixup() Bad Header Length 0x%x, offset %d\n", ...);
  netdev_dbg(dev->net, "asix_rx_fixup() Bad RX Length %d\n", ...);
  netdev_err(dev->net, "asix_rx_fixup() Bad SKB Length %d, %d\n", ...);

__func__ here expands to asix_rx_fixup_internal, the internal helper
rather than the asix_rx_fixup() the others name.

Kind Regards
Aamir A.
