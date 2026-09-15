Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazolkn19011034.outbound.protection.outlook.com [52.103.33.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A96D3A9D99;
	Tue, 15 Sep 2026 08:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789462796; cv=fail; b=gjedWtisjA8X2EWO4/mOt1WVJNqsPl6/fuD1emQ18scv1bcCjWhD2voj+hoi8+miyk569d9nVwo+717m7Gq1f5crsErdJvcg3BcmbxbHAMyRq+NMB8OMjYPyrmp8g1PjDuOhZrGVjZ2+Z3U+qbfv6bpBz9gcWrZPkySuSLkJm4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789462796; c=relaxed/simple;
	bh=jmraQDb42aqW6DYaceHFy2Rb0dRpfKOPtqQXicTiNl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aUCpHPOxEa/6GJZRra5iFHeFq68IENa/IdwpuV0UNeHlXpP1Va0fcTxF4A8NL8D9BjG4o+A8YIj0zwlS9bfMNh6sxwSTDFvuPKbCeS8nPfF2rIaiungw+XRpGQ9gwKlDmurFPZlkh2rKqLdWH8lytkbpeugXKozsmh3Nfc5B15o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk; spf=pass smtp.mailfrom=hotmail.co.uk; dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b=rqDVJlXA; arc=fail smtp.client-ip=52.103.33.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b="rqDVJlXA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aKs+tAN+11YCVvalKjKGGGdO7TCbosf1xMDJzjKJmNV3zH68RMcMesMnNoymeW+Mg6y/pm/86lx8XFwBWudmaHyasw7cwfDIvuL0/juoR+bWZX/FXrwyanc52/0Ka/NNtAkcLY0VeVit7I9ZAEnXraxj086cCyfoNPXjiujYObenlo3tlYbkQbLnptd453NHYj/dz0jjpfAwQZ/n5XL1LX4k7rZnlnVCBGjnuaKus0KGJAsZbHF8iWIDqGZkvAyTZLHv9Fgtm8+MwAwk+YA/HPIr9TJceqVvShNjnzZEJULLqkijsHcdj/8LzWx3xzpoplmdYiz7Ol2b+JAebX97Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jmraQDb42aqW6DYaceHFy2Rb0dRpfKOPtqQXicTiNl4=;
 b=jjdDflmgLm5xeCs487ob06JErLhTllxpDsBi5OmsKEyMOSfdKkBkgbzZByn+Vwn3u1xkXcU9l1hLDsv1lcb5FU3XxYj3TPlojCbZWpcVHoaOozZoAzlKeOJR+nVo/o70pGRt64zCtlercuGthHcbSbZwGNDZKPh8L8etWObvYTyZkzPRdsLe+p6NA5b1Eoz8cuLyo2wQZZmXn/dEj0LYiFZ/WHWtxzqR3P93lqtguE/WZH/9alobHRmzxd4ZUpq+7UDTIeBsPvmHBz2PiIcVjdZ6l47QlNT/iZVz7VBf5qZxvwZ7lf6Kvc07UfXKA7eqsdSpFD8LjqY4FFKO5MgvzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.CO.UK;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jmraQDb42aqW6DYaceHFy2Rb0dRpfKOPtqQXicTiNl4=;
 b=rqDVJlXAJUHzpy2xcygV8L3fXFzgzvF5RFbIX4Fzf1XJGHuJ5QC8VkdwtjDGso/W4BglLf0UaLk4gLSxVwQxQlLWG3qs2cPkcclxo23RxJXQ5SATELkrUY6rND6v6b3dNal/Okr1g0hZdTGvhicV7hEIbMQ8Q3ipD1WOpvjSl1YDueAHaN2Qd24N1L3Po3uepNHBFoDylM+UHQHkENpIhS1iRseRGB0m3V5ylOb80F512Ivztw8HWQnqqm7AbnDh2YgalVsZCrsK2+7683/jUn8Vj0z7v91rhoNO2WFV356q1Ign+L1kI/yB8WfoNJaGypz22OeBBCVSLvZcaDqF2g==
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:344::22)
 by DB9P251MB0667.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:333::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 08:59:52 +0000
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352]) by AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352%3]) with mapi id 15.21.0428.008; Tue, 15 Sep 2026
 08:59:52 +0000
From: Aamir Ahmed <elb12345@hotmail.co.uk>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Aamir Ahmed <elb12345@hotmail.co.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Lucas Stach <dev@lynxeye.de>,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: usb: asix: reject a truncated Data header in rx_fixup
Date: Tue, 15 Sep 2026 09:59:47 +0100
Message-ID:
 <AS8P251MB000100297C073F6DFAFB1190C8BA2@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0.windows.1
In-Reply-To: <aqj1X8aIEs5SqEAK@ashevche-desk.local>
References: <AS8P251MB000193C798F98A11C73C3E9DC8BB2@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM> <aqj1X8aIEs5SqEAK@ashevche-desk.local>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0027.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::17) To AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:344::22)
X-Microsoft-Original-Message-ID: <20260915085948.449-1-elb12345@hotmail.co.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P251MB0001:EE_|DB9P251MB0667:EE_
X-MS-Office365-Filtering-Correlation-Id: 59cae67f-d4ca-4bc9-6ff5-08df1307b42a
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|51005399006|37011999003|25031999004|15080799012|25010399006|23021999003|5072599009|19110799012|8060799015|24021099003|55001999006|40105399003|2607281247196008|56899033|440099028|26104999009|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iLazmh5as0msW6h28a9J43xz341VET4C+3cq7WEpN/hJxYJMjKXf10/xkYBn?=
 =?us-ascii?Q?zUWQm12i78kU6blS1XGkZ5aioDfc5MxGL+M0SZx1kBqyZEvxQ8u0nuRsIs8T?=
 =?us-ascii?Q?zViVaJdgeDAqq1rdERHv5BAEQDTEQSlC+K2ezlWq3kYMXcDyiX/v9cT/IGpR?=
 =?us-ascii?Q?a6ic++0Cy0YniIRxWMlP5BNSd7GfFjSrGKfLOr0laSZ767p36qQ05sNpx7Ut?=
 =?us-ascii?Q?V1HF8TIrop/LOATRzJLQbN5edDID007NWMhlNAiXOZMmtYX3hu5rOWbVsfne?=
 =?us-ascii?Q?FuhjTVPY7rWstRY0KGwJWn0b+RWMd8cgld4BOVahRfbNCbq+PVyvZTw1Tny5?=
 =?us-ascii?Q?hDX4dLC/cEn3xaQowqIHeaBH4Xin3GaoOvCgToFiUqkoH3PzEmBV6UYKsnB+?=
 =?us-ascii?Q?WNPmZ+lbEtDwmAVU3EluMnR64L5d9z+c2paNNCx8b+OLJBkea0MDYN+hbJo+?=
 =?us-ascii?Q?06mV+rwDk9dVtSLxYkcnU9Cigultp+DzhZjMA6qiWYe4D1iJTB2nOWACy3up?=
 =?us-ascii?Q?C2xgK6r+Tty8Q+6T/QfQPgKR2INc4EdQzcQUA8Gay3D/evd0NXfPmzCCG7rj?=
 =?us-ascii?Q?Ed5K4OCJ4985UMh6ClNIwABXrCS3YiRWrC6aB/EOQbM62i8nhmF3G/wuji52?=
 =?us-ascii?Q?ZaIknsjHKVjGpn3GD/E2J2jo+31j9OoT/lBjufAQOA9vgsXX7JBVzoYEg21I?=
 =?us-ascii?Q?RujKbBvA9xHFfnWvbys7sSdjzX0yeO4SaAa4jTgyKhZ183jWYZ67z/ed26GW?=
 =?us-ascii?Q?hfYef6inPlA7VM2Ksp5HE8+Sr44nRJHRLb4szNPoM2+p3LVXCLH6TY/yLBDr?=
 =?us-ascii?Q?xni4/noUjI1jrRkn7sMV5f8uGMeus3hLn/nnfA0L4iUBsQmNyHLtdXvaizIF?=
 =?us-ascii?Q?nxC5hDHtMBwiRvhW8THSVclrM27XB1sDBPTz3ZWqbliDng8T2246cbixLL+c?=
 =?us-ascii?Q?yZq0k899p26RprulqthVT85FT7AGnOFe40KtnOtMAuiN8f80T0WjtlPsDFJc?=
 =?us-ascii?Q?oDBq+D/HQk8s+WCxJ5EjTwgAu934S8pAbk6OBCehy2iATa5SmarNWKm4vqwB?=
 =?us-ascii?Q?eZ6VNkZx?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eq7sFw9LQVHH7Dr03kT+Z2bpEwl8WsLAibjQovqm/qfxDZ7PRFWiynrDjBbI?=
 =?us-ascii?Q?Trs+RDbJ4BNLdRmWzUpfPE+Lw7BANppsZWFhGA8mbVoRlFAisV9WAWcps6O3?=
 =?us-ascii?Q?HsKgWV+PQ0SeWSMYm+j9jXpsd8o36Fn71f1wbbCws4kniQUQtrDYcmVh21P8?=
 =?us-ascii?Q?knGyUPGbxV0mUCddr1PK4kjO04SiGxXjsQRnm/AdB3BSFNwFVqjMNAfJygcd?=
 =?us-ascii?Q?3CN9qKo75UZVTRXgYd0Qgo7i0EmFHoD7SL5At0i4BODdG0GqRcdFVse/gRx/?=
 =?us-ascii?Q?JdppQ0DNTjd3WHlHKGE1Zxn+X/5jrz6Z+Y49ZjMu5thL6GZFTZLkJnwrxXlw?=
 =?us-ascii?Q?GPneUen+402HyfIgZwu6T5Xo9JHYbqUzndQ1y6yi1UfBcF7bETlnrILA2xoE?=
 =?us-ascii?Q?UK1+0BIdM+tb9p/kTn9t6hQXFGM+72vDCnY3rcjTrH+fOdQm2mZJoiotQXH4?=
 =?us-ascii?Q?wRPzrK3intP+HMAn6uREnSOLyqNex0RYXa8P95wYGbW6aOBXhTadCe/OaSpf?=
 =?us-ascii?Q?Cm3JhzM4rBYTA9rUY6fbJED7LPA7oKOC/3/4lF2xPTvi9KXRMtFn9iTbByR/?=
 =?us-ascii?Q?19NUFQEjRE6RcVM3utVd/kN+1ROVvx/tFdMWz2OaRQKIxPuerfcFuu7HicBz?=
 =?us-ascii?Q?vJl/0voTIx4EoQe4u+0p7Fw/JPJu8y4v0622oBLnWvFmtQf/fJFYvoYkK7Mi?=
 =?us-ascii?Q?ZDUsxTIet4Om6zHsVQAFBGIwJSr6fWsTY2I1bDpt4wLPXTVOTC8sDkGMJV1O?=
 =?us-ascii?Q?N/aW1ll7KguWcdZb65Gwyyi1NaqW6y+kBsX40gB8O7ri0jKnT/Au7VopL2V6?=
 =?us-ascii?Q?wWKJ3pcyC62j2XNvM0qOgeygQRWok8olD9v2Ro82HyRrbix9hm+GJagjvgNx?=
 =?us-ascii?Q?gyZ0omGaSSHzy//RhzaezQPtfX/Sj6o2BKfcOw2W0g8e1c73hKQRT+78O34g?=
 =?us-ascii?Q?Plq634y/qXtB7PE/pkbFnF7djlPofwoz5tf1kFEoXp1t8PYehY+ZOmQiYebn?=
 =?us-ascii?Q?OQnSvvBZY4SwNiu/wBw41wV03x+xbbedzBItF7b/MyC4J7vkRUFZi/7d36G8?=
 =?us-ascii?Q?1SH5FElJo2JeIOxHbBmfsmw1YkgT2xXBypuJnPWmxvjrP4wJzaCYmtPUKRCR?=
 =?us-ascii?Q?Zg9jcPjCe3LEa6q4PV6eF0PWinxe4SyucKYiy2wnYxK7RM31E9jDt+1p223Y?=
 =?us-ascii?Q?qklyCb2nYGiX6NBBmixUOrpuFXyrkAKmQzLFyDfyL2qS7k26UupYX1MGeJjR?=
 =?us-ascii?Q?AbI/szxDX5RhPzd0YKOln5O/CU9MSN94DZSYXjPHqfN1zN6lUw36IVOsHXup?=
 =?us-ascii?Q?EQQiIicJJtBfqNAyIQJ76r2zbVMpUrJZzmMkQXHCvcXP60kAmE93XmzkoOWM?=
 =?us-ascii?Q?GgHHrqI8U5wSQC57L1Cjo/7KxiF3JSIl7UsD0d0Zkta6TolgNQ0+VpreLcqv?=
 =?us-ascii?Q?Hy2U00Cspm/seIg+6YrzD1iTwbCnkpBl?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 59cae67f-d4ca-4bc9-6ff5-08df1307b42a
X-MS-Exchange-CrossTenant-AuthSource: AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 08:59:52.1772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P251MB0667

On Tue, Sep 15, 2026 at 10:35:59AM +0300, Andy Shevchenko wrote:
> On Mon, Sep 14, 2026 at 10:23:45PM +0100, Aamir Ahmed wrote:
> > Only a device emitting an odd skb->len can get there - every asix
> > rx_urb_size is even and offset always advances by an even number of
> > bytes - so this is net-next material rather than a stable backport.
> >
> > Fixes: 8b5b6f5413e9 ("net: asix: handle packets crossing URB boundaries")
>
> If it's a fix, why net-next and not net in the Subject?

Yes, on review this should be on net ideally. I'll raise a v3 later
with this correction. Thank you.

pw-bot: changes-requested

Kind Regards
Aamir A.
