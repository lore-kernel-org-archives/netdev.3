Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011036.outbound.protection.outlook.com [52.101.65.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A1D3AB269;
	Wed, 23 Sep 2026 16:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790180303; cv=fail; b=WhRGZqS9q/6+6BK6TPSXHg3W5K1WNZ2NtbqiIoHQzClhrWgZYwCRPrRzNrkrYAJKbkMrMppgn9NXjw6/IU5rF025vtsvY5NeYt7YwN5uC09lAnIGlmcX9obf4lk5Z8yvDODyCErOFkc/vyq+aGcadht5GGzITOOIQkfMpCKBsnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790180303; c=relaxed/simple;
	bh=o89EbtLEdZ+a2l5FSsnNqFl4TEM3xqmbh8dAAW5SoD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kozRzmOtwtSDKvYqpxw4/H6qlApwUw8BpF0iAU6J3Z48yGSygH5z2UwISJJY7wqKeK4GU0/FtovQJe2mNw94OWSy6lQayH2TvFaPMhyCdmyLmzeHikaDF6Tr9aMk/F3IvSWt4KHRal33gCqrZoO62tNgQqLra+Lb15ZJU+ZZWbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ui6D0luY; arc=fail smtp.client-ip=52.101.65.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ui6D0luY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xF0Sy83LNB3c050cb6xO3VQC0BTfXQrWPZQ0n6cFSoYH8a3PIkEvbPwyqFfXg+3YSXDCuUCKck9OxIPBNnVlvcOmRh0+uZnAaTPtWd6Eowdi8I6C+sXKENIGT7QnV9IPRrsxKiQPGPDqSKM2OqtRM3cQp7ESvWira5MoQJCVzUQcNLWKk5BRPUzF5b5tajdVUi9uUpriDhMJPxy8bpf8j/6X7PvNncmnNsv/zDr+YUMLr9L/eY5skb+b4g/s1O1aUgmLasoEqUJhXoxdJmg6P5USG26gLa6GRODAkDY7xUH25g3QhBWJfvJquXobb02i26mtA/LGETGznsVCFHiBnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z5A+X8sMOYJbR9lZ5URub+pkgaH4rakh6oT/quT2+hg=;
 b=k663E4JCcXfIWLXGHzU9Iwqehjw9wamjhE3S/Dj4q4CFELyHqDHy5F2iQDATlQTRDHjOY28WufHpFrjF+lXw+Xb0hU1180LIiPWvkR172guYiNlHe2DYFyH6RkgLBgTeZbZngpo/J1YzkSjEOtFtM/puY4J39Nx3ldm8DPQf6F62fGitjprhL+GQGcDlkErXINdvQrOls9qjc66Sk/6hRN+zsvAeUR0ysycG9EyKD/sUIb/DYS6lNk0wYloA7Qm6og8NUodFg6Pk2ulmDibVakVI4C4jv9omw0Ja/q/xugxav+7tFLanZ41WTwN+6wUNWsztD6jeaL44UgYN6ZBu2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5A+X8sMOYJbR9lZ5URub+pkgaH4rakh6oT/quT2+hg=;
 b=Ui6D0luYnfG2pBVP/AQwb+T6e9CWMs1VQE9kGlPr/czFFCDy2wMGQR+SkKMtR9c8OY+j0vnP+f0iirsT0VrfZU+tDvkfRlcu3xZHZZr7JjzCmJ5sITuPzk7TF+gn9moJRoKh82y9WewKLOmEAFTkitRKSG7ErkYYudcSHKmawPC24HGMkQRKxABLHZPM2KFstrfywGQPKzeb2293Eg8MyWlhlpE5KeqOmwsJgoDGET7vxG33v6GuRJz4ZKxubUh+iqJe5gkYxTOZO6z704MJREW6J6kBw4kWe/7ncj/l9zKxSqqpaSshDHRGaoUhTVod02OEObDs2LXLrHgXhwpm0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB6902.eurprd04.prod.outlook.com (2603:10a6:20b:107::20)
 by DB9PR04MB8281.eurprd04.prod.outlook.com (2603:10a6:10:25f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 16:18:19 +0000
Received: from AM7PR04MB6902.eurprd04.prod.outlook.com
 ([fe80::6d09:9d2a:f8c2:25e6]) by AM7PR04MB6902.eurprd04.prod.outlook.com
 ([fe80::6d09:9d2a:f8c2:25e6%4]) with mapi id 15.21.0428.014; Wed, 23 Sep 2026
 16:18:18 +0000
Date: Wed, 23 Sep 2026 19:18:15 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Patryk Biel <pbiel7@gmail.com>
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4] net: pcs: lynx: enable autonegotiation for
 10g-qxgmii and usxgmii
Message-ID: <20260923161815.qakiviia7lxbu34r@skbuf>
References: <20260923-b4-fix-pcs-lynx-an-v4-1-3f7927606d12@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923-b4-fix-pcs-lynx-an-v4-1-3f7927606d12@gmail.com>
X-ClientProxiedBy: VI1P195CA0050.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::39) To AM7PR04MB6902.eurprd04.prod.outlook.com
 (2603:10a6:20b:107::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB6902:EE_|DB9PR04MB8281:EE_
X-MS-Office365-Filtering-Correlation-Id: 32a94c42-a9cb-4275-75b7-08df198e477c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|10070799003|7416014|1800799024|366016|376014|10067099003|11063799006|5023799004|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Qfh/jX4SSgXyuvKLOxYXHQF3vDIqvi1eQ960TVqsqmWVBhoxq0Gd05ME2JHc+lfqis6iLh3iXX9fjnVOaU/Edd+Q6SucBhhqpizMvrEMocbcCbs5qtywlhf6EPD7Eh4tFfXkGg+JhgMbTOw7K4mr6OR35ELsCZTxBsTOlrXTu9luJzs9LSTNP7AKRCZextUCpJ6PRwKJqO2Su/eyC3ciVJfY7jaWhcU8qxvbMrtSX+NY4ZX0Ug6/Oh2t+0ppYedlrvUsYWOoUJEDHuqchbBVCiaL3IMLT960DxjUvlm8P4ZVSrAPjRyakcLMLw5Fc6oqoxhIYxs1lhgh3icmuOFYGmZyEqMBeNbfOzlP9keJKNAJ7CK74Mhh/TKA4LRhb5WrIcGYpSk7crp6+EpxRDYo2jA7zQtDa5bvq1okp+z7acqAg+gOq8A7mgx0qiQz7gENeEqrc4bJ93LDBamCYTkQbaCBulN8NepOpXkg2n3BY3BNwY37c2BZVG4LjEvUDcBA2s+d7rpIipiLDGJIFOEBZ6jDO3b4diumwYd33cQVC/J/mmvPmLGP6KWjVHvJ4ppvr/jGQTmOiTjO88Sjjooei4gYz0AD95A3xDPt6NgdSnX09cWzxLhYvV1gFcMFiFTSigU4QWEs9bKvf0Rhv5hdKGX75oZMksZTBnG/v/iCHkY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6902.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(10070799003)(7416014)(1800799024)(366016)(376014)(10067099003)(11063799006)(5023799004)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N+mTLsKIrBp6U4hOaPe4TjJ/NLs/owAm8N8hurXYZVy9arBHL6y0bVVUPXI4?=
 =?us-ascii?Q?oHmzL1SiNnOAYDwzPo17L2uDVGeuXAjHc9IjrZbzmcy5La89p0G4P5/5Z0LP?=
 =?us-ascii?Q?0Z4qge51M0t7wtu4yYjqZHNWaVgwtr8mBRKSdHDYIyTuxoGwofiSLmVmu/k5?=
 =?us-ascii?Q?pp/bAYPp+jYPIIyxFeQkn0gMR//nITbiFEM8Gm9G6FUN/z83eLj7pXo+RF2n?=
 =?us-ascii?Q?EnrZ40NgQ6GjsQQJpr1JlZBVcOq4I8WpmGkIqncweWfOcnrNRNxsFLYcMgzx?=
 =?us-ascii?Q?OZiHPgkMi7GqXF/Pnrw4DcShxkFwtIml0+IXqCe6p6G/F1M14bTKAU9ZgtBt?=
 =?us-ascii?Q?YvBldRpU9OkBmu9vpEfECT9p45lOSOOTnVwReVjcaKf/ze/LrRsq9yhbLg0J?=
 =?us-ascii?Q?65ZAZuPpGmVgdrLRiJOLLg56YPBvoQkr6GwNrhwwVfakbURmfZnB33qsxyTs?=
 =?us-ascii?Q?lK5Zqml7MM+ykJb3vxRfYTXxP49P+RNdrBGcnRnUNDeEAwvvoQmV5v0JiZBO?=
 =?us-ascii?Q?IowU5l5uZ84V7pvc3/2YegWAl846CpWy4Rl6lCYbYrOm6WUi2Kl6Qmtni7M/?=
 =?us-ascii?Q?LR31WdnASpXGf4U+bDjCrzCi9b+FKh6aFg02ixdbdjv0KF4AX0nDZMycwpV1?=
 =?us-ascii?Q?rwEypvHaZ1mBjSI8Pufsc2zyjKohV74rrG0mxf1jBeSTKEKqDsstpGoz3rHs?=
 =?us-ascii?Q?emu0LKP0JYICdkASGzGTlOn6xmeMI4G4CAUFsIHzQIG/jiq2UuXBgWK8h75G?=
 =?us-ascii?Q?C251baqFzdNNWI6RnYlWZ2RTFvXIT8INUCO8WBuVFeby8BEolVKLp65XyGDi?=
 =?us-ascii?Q?UtbsXWY5ttuDbo3WhRRTCrz2cfnQQtnSx1sAovPjjvGqxdzwI6nzQtrAPuzx?=
 =?us-ascii?Q?upR5CzfU1uUf08p81TFH0feKAwZ5hrQHVNgz9qDUTIVuAt/T7eZyP+RbhBcH?=
 =?us-ascii?Q?V+b3aZcPuIei8WCG1eS3S1r/C9Xgo6hR/Mh3/IZZqUdML2yP3USdbgTznc8K?=
 =?us-ascii?Q?DFEPA/VYkJ7cHABNYv70Fst+zt+wCb/IsfnKh0mq134y1nOv4x0Q1Fvus/x2?=
 =?us-ascii?Q?hHl4Y1fzqWdHhcAHRrzlEEUd/KWUDIGNeeaCsgcYHAUa3+OykLx/Ud7if3Wv?=
 =?us-ascii?Q?zkkZrfKC5DHvCbFK99VIjnhQhM6IR7IJtO6bEvtdrM0MdxDe5ukD9ALaqEMb?=
 =?us-ascii?Q?VAM7bGS8ZE0kUCkU481QF8r+dQwrSGjG2L/Vsgl2UAGDtsxFehq8GnhTUNuN?=
 =?us-ascii?Q?yxBNrfTTfB5mZ6FugZkMo5vZA8ArvUHFIQlnkk5HE42jXcuV4B7hjE/f6LaB?=
 =?us-ascii?Q?8DUieu31FvVYgB1J3c7MzLeVEsiyhqVGgBtV9ye5Qsw4XDkkrtXkrnOGv2fT?=
 =?us-ascii?Q?QukhzODHsZfAA6js0hxav2EIJQhZGQwjyXjTV20fr2slqIDvl+KjjL0WGBq5?=
 =?us-ascii?Q?wqy8ij5STkcqKxd88rd94T30G6X59G8xSyzbs6Q9VF1wvQLF2kFcrwl4WcjV?=
 =?us-ascii?Q?QRXFDdnZCiMDvaaOKsqEVGKNLpITFjf099Mp7ZjHf/aQzkWWtfbepTOBbUcC?=
 =?us-ascii?Q?Rw59cuXHs3nzHb/PTd1SkPWL9zjKSIVGIoMzPxfO0kcUwBI3T6Tdw6UdFOHK?=
 =?us-ascii?Q?pOHEy2Jjmvnz2YnW5KAVsJxayJ9/O8KBX64k/UATWVOaaaRg1kriyFfr1I7n?=
 =?us-ascii?Q?dlUE5CCe+Drq10dtOPy0zyc8swGZ35qjvcjnvyT6PZ+W5KYcpwD8clv3lvSr?=
 =?us-ascii?Q?/c1DUBgUrJqts1ejZVcD/4r3gqKxhziio9CqDcnvmLX843PlhUFjtIZmTQd1?=
X-MS-Exchange-AntiSpam-MessageData-1: JHbVK05VK6xxsMq0aGPN4eKkK5uYH+8G68g=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32a94c42-a9cb-4275-75b7-08df198e477c
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6902.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 16:18:18.8881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cLzZbpuUgynfb+KaNUkGQr2zCgSXCxYrwr//gUK48C2T/jUbOxI+VcxDhjlW3cuCYD6wPy098ewPgxZ2Daaq6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8281

On Wed, Sep 23, 2026 at 06:14:12PM +0200, Patryk Biel wrote:
> The Lynx PCS setup for 10g-qxgmii and usxgmii programs the
> USXGMII replicator advertisement, but does not explicitly enable and
> restart in-band autonegotiation or program the replicator link timers.
> 
> This leaves the PCS dependent on firmware or bootloader state. Systems
> which do not get the USXGMII replicator preconfigured before Linux may
> therefore fail to negotiate the link correctly.
> 
> After programming the USXGMII device ability, configure the replicator
> BMCR with reset, autonegotiation enable and autonegotiation restart. Also
> program the replicator link timer registers using the value returned by
> phylink_get_link_timer_ns().
> 
> Co-developed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Patryk Biel <pbiel7@gmail.com>
> ---

You are supposed to carry over the received tags from previous patch
versions. In this case I'll just resend them myself to this version, so
you need to do nothing further, just keep that in mind for the future.

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
