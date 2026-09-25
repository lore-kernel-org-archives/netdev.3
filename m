Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013041.outbound.protection.outlook.com [40.107.162.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8094E80C2;
	Fri, 25 Sep 2026 16:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790354560; cv=fail; b=SruIX9+H1Wft/akgcbWabp6ikJqdQJ0bqJBEDihUCsrINrePMESBVVeZdgn9ADRTyKmLjyCbdTCFJ7v1t8OAvrNKl3UXn3diF8uHdoaqEWPF4oJRWW7pEeouKHCWAEnZ1MOCpY0cjHMBAve2IjvxzWjtE35NrABj3d6FONp7bqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790354560; c=relaxed/simple;
	bh=Yb92edyofeyMdyp1piviBRwnQRVP98UszCh3Y3qhzks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=klTPRQ8rg63BjM4oxuienhrWUj/IHs2E6Sl6lX5svBaf7tRpWtmNLrKFtlBBrGYyFWKsiCR6qQvKmllDdSKu+iL03Is5qPx0KdBneuZOA/9kwB1c723OG1To6JPsCsbj5hYERg0YApSUMW1g0eqxXj5jAmIqmLWon+OsW+5JH14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=a1ePw7kP; arc=fail smtp.client-ip=40.107.162.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="a1ePw7kP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uuxJq55m+4dQP3xaxkWdXkQVsGU7rzNrPzcZmxv6bhEQY6LWeK9Nboy07zl5eL1jbhsBoNJjt87KraIBeE5Pl8vUEMVHtFdDrsHMPIANvWbX80/mVvtAJiimEdNSbiRK3HrUNgw3rAl1a7zu9OWnY0pmBW3DNQRkFNcNK/2ioukSfl4MbdH9ZoH+iL1t8wUqCB1lb6TKUeBtSxpKlxxlDU2ip/Az1crR3mMWdubL937kPRZt2BIPlyPtaCBKA+wjhzh0YA74YfftfSNbcpLN5ol2ihu/ANSleseC7Trs8k/DripfDeK9ho0MNd7UXlQt88jHKNP3zwQrEvIdudeqlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TsISMOawkJElqZC6K6ExilC/m1deyH+mvdvsIPSom4U=;
 b=bBBIjRqjk31P+B7poCqyxrq+5PcgC5qWwIna0Rov4kLQ32gOIxgG8kWIITDgOf4CXfLjUaBhiqlexfL1N4yIb+epojiTR2V+HQYla0Ve4n44O5Bi8kzPBGf/qe1TttplQFiYWtGyqv8I6Bn4NJZj37JwhX2Bc8wOAhmpRrzzGOsFeLhx6iGvOlE4ZjO/74LS4m9YIB8whUmWxBbIlR9Bg90CuTifm8BnSlH3KX4shy9HtOy2gfASEUVcuYXLu/4zJncNN4jap2sVAq8HQOw3yQKO2D8+JhFxxTtDdbi2lGI2qJBSIMOX05SeuvIdw8SejoXfkZRWkKl7TkrCDuaUtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TsISMOawkJElqZC6K6ExilC/m1deyH+mvdvsIPSom4U=;
 b=a1ePw7kPiYMZM+Ek+CDqhBv6aaaEphT3RcuxMReH50YhnxThNDedeH5U56Jg9mwAmPT/IF2M76Mfx4HnMPorYQLvXbWqbPyhSmHVVsYPzReqtxyPdnO5kqT8pPBjex6ilO9g6h+w8P8A7LpxeJ2DXpVyigmMqsDToH/bGjVjS1K/3jv/+nzMIOqxccia/VMDpWcJvtAHjkfMx5hcMMdhNbQd4ll9P3iKjNCq5bkIxf3YP0eE80vxOmoYViSjgD3VKWoWi81HpeUANbiVfsIqEy99y2baFT1kZP4DFrjggKZCsucsxI0yvkHjsQw/Od/nGJjWnM+85Kc3nMQjHgtT3A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GVXPR04MB10517.eurprd04.prod.outlook.com (2603:10a6:150:1e1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 16:42:17 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 16:42:17 +0000
Date: Fri, 25 Sep 2026 11:42:04 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Stefano Radaelli <stefano.radaelli21@gmail.com>
Cc: Frank Li <Frank.Li@nxp.com>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, pierluigi.p@variscite.com,
	Stefano Radaelli <stefano.r@variscite.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Joseph Guo <qijian.guo@nxp.com>, Josua Mayer <josua@solid-run.com>,
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
	Mehmet Fide <mehmet.fide@screeningeagle.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	Maud Spierings <maudspierings@gocontroll.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v1 04/11] ARM: dts: imx6ul: Add Variscite audio codec
 files
Message-ID: <arakXE94ZONxduMU@SMW015318>
References: <cover.1790344389.git.stefano.r@variscite.com>
 <ef56f98137eb9d1e0af3aa1b801186d829dba521.1790344389.git.stefano.r@variscite.com>
 <araMJFirhP86Dcb6@SMW015318>
 <araZ8pJGmDVXMjvE@Lord-Beerus.station>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <araZ8pJGmDVXMjvE@Lord-Beerus.station>
X-ClientProxiedBy: CY8PR22CA0012.namprd22.prod.outlook.com
 (2603:10b6:930:45::13) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GVXPR04MB10517:EE_
X-MS-Office365-Filtering-Correlation-Id: 2db0adbc-274e-48fe-9292-08df1b23f5f6
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|19092799006|366016|11063799006|56012099006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 cT8zj6J4Nd6VE6i62fKOsAp6ZCkNXLp2I/8hg5Du6Th5wVyv7MUtUhSKTB+lqiij1l8fSQKPKU/DGVBtxQTklIBJS8tASm5Ba6TYGxctdshvjpPI0Wsl9oQeMegQJ6CSygNq2selkglzm2Fi+B3m2rNyZWk0isfIpvAL0F5aKs8NKBOKZ8ZJoD6rP4zeTIgqNffewExiaX/KO9PziEaKeNyAn1KWgeeNqD+gTLeXBqoE3WMn8px5EbQ9NRQfAHtiZa4n8ARCqikWwdGxJu/lu3iVehhfHwThJgIlDMndzUDZVj8rMKY0WqthjzpfZRtYywLjABboW4xekSbLXIxOtDR2ZBAyCOpDavSzzPSihqtGX3gVHogv+gJYtyIKMWZogs7DUao34pCtopshqTv+kU68vHWLryNml4X11jA3wlNEQf8Qr401KCSSmwnBpcx7ktHhNfhx0iwo5++nUH577jrmYpooEJOMYUMHXBhhi0MP60o+XfHgpaadme05DEC+j41ehhZ1y0RWUFVGJVn8s+W3uIZC4TCMExEgM1+NN+Uh78+ORgjqW24QtMSxqBNSEF1DLqQPwXHDYaIZkoFm9GY7c4B15SHx2Oc8kmViuYEZyxN16cS8FjGpDoD+pjMIvCc0E8yIhetwzDdquF2ZKWypfXwSf/9IH95Eo9ThAKM=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(19092799006)(366016)(11063799006)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?5vBCOJ6Ht+JhVxEbu+ouHxJPnRNd00x4hvQ3fGvpmHVbbJEUyqaewv7WfnfV?=
 =?us-ascii?Q?KdUKpIpW3JS07zRmcw+kt0rzmoFxykKQYwWIpqhQC6GZEhsE22DBkRcbvT+R?=
 =?us-ascii?Q?rZ0YeVOpW7ZGOzEnMdiXL3q+Yh2BsOH2lPwGn7mxlmum/HD5F4OxkZ0XrWel?=
 =?us-ascii?Q?aP/P/PLR5IxVqFKZaMRi/Xn0syo8rpxp4UY40fMIrS9Lh7bawkbVgBtC2ktE?=
 =?us-ascii?Q?6KFyKhhui+97sEuJVTV5hQ1dwiNqGlnHggMhgDvcPh47hTxuWYt0NhfZM+eP?=
 =?us-ascii?Q?W+/rfkKTO7M9gak82jbc9ZOyjnn5HTzubcDxBDbPd9SVhksUc3KxkEbFo8PP?=
 =?us-ascii?Q?Lsk0FBAbtftSNPPCJKsXhUR1gEZopLdacfktyEll8KLGVQtjiw0cQP61KgpF?=
 =?us-ascii?Q?aHQWXOLmS/ifv3C411e3jVUOMMqh9zM212gqkvIKDAD+3fZBIGpjhSwq+Sue?=
 =?us-ascii?Q?+ZGiRG/NDqxYiheKhZgbM0m3HUpz4/a5Lvdzq+WrT7I7KxCV0n6P20R7NBo+?=
 =?us-ascii?Q?lP7YoYAGu20usurcvBbTCBOIrZNLeU31MOLSmy5N9+648F7Zpuzmi1w7sOlq?=
 =?us-ascii?Q?mwYFr3ps6gRky4GsO9aqQR//Dce5zar7GZRPCjvGZ725H1GIcskjNs5RoxID?=
 =?us-ascii?Q?vTthg6I2/xXgTP4qmdA1fpCGtjlSAE2wIVt6gRK92OedPUJl9QsCpoYJB0Vj?=
 =?us-ascii?Q?vtgKX7lc3tZZvcppqutOImAvDI7sSjJ/SGsbcGwWcBBATm9p20k8A82aSLhJ?=
 =?us-ascii?Q?o1F3IbOgbRMxnW7FOLAFHEIZC+UuQUiQPDljPnmlKPaNGqL7L0UsSG0VCj/r?=
 =?us-ascii?Q?FqXfQ70VIjNJPkTHKh1xCl00uSmFOl+GwPvVFTFAWfAMXQw0IlBA0kVrdvpC?=
 =?us-ascii?Q?8GU8qk9gDGcY8vgdqZkg/jAKwGGH7kApKERx7VeOEMxII3pCwGEiV5kYOoR8?=
 =?us-ascii?Q?ILGhyeizriSDo29twhkfty1eyghV4U4YEU8Nq5Qc8/luqSWY+T15P5JwOSKu?=
 =?us-ascii?Q?fnk1qa3c8FDvruhZohi1n/VCzD7mt53bJrsmRu/fQU9j5L5fiD0yyUADo5iy?=
 =?us-ascii?Q?xl0/CIosefUUaFHnGLgmUcj7hlJKa9qBlbqzXF9ptCOGfgJkmJGZOs19SR06?=
 =?us-ascii?Q?4iHtLJYzoTrZBy3m6MTBVCXQcb+CL5IliDk7O0MxhXVVN2LlTEcZSHmttbUJ?=
 =?us-ascii?Q?V+7MjPibaCtgn4T49TIvDSGnkkm678VrHxZv116Stvt3xsOVaCBtnS5+ZyJ4?=
 =?us-ascii?Q?u/sR6oz45C1tvQTUhssFu4SuO1Q0Cf5oLIG4A7kguC/StPTz+I1MFrN0b5nN?=
 =?us-ascii?Q?DIKuFpmuA8q3uchgBRwmNfBe7wiWTlbpXhLK5D+sIsWMO68V91BgFagkjkXN?=
 =?us-ascii?Q?A8pRaLyRl7dLID9fGjmUJbMzjWyMlGXxtWp09557EtUQAMx1M1jc2/2KEO6D?=
 =?us-ascii?Q?ivcTWQ2S4Ob2JfALRjUuzU3kCOMriOO4cPLQm95Dxljzv4LTaOPO5bWeEF1l?=
 =?us-ascii?Q?Bxh3kSYTkrZ1LEU6VQJ+rpRzFSga6NLMWyvXj18tx7MsXqo+sXVH5WLX1lqk?=
 =?us-ascii?Q?jWcUSaXfPwe80+kb941s9ui+7fe+816kO0vVNmUPZKMjb+oaFHmmHCcvGYKl?=
 =?us-ascii?Q?3QyRHdNqhjyxNpmLRSXUotTpEFOjxhL0QQLjL4dlgevy+JUn24cYciu+7Kxl?=
 =?us-ascii?Q?JM9cDh+affii6czCrKebr72eKZeqiuu8bTZ+cy8vLXpJeIy9/IiRDglpP2l8?=
 =?us-ascii?Q?IUEHVE5pHBmRUyceG2H9O/qdUFJiC0FHTJgz6MW8eVxcMwcn5HlL?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2db0adbc-274e-48fe-9292-08df1b23f5f6
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 16:42:17.7299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ceojtp3Qfm8Q4Z9KuaGVAQk7iGcAz6eDPPOcAhZiU3IkSaDsdH70NuPple+eGFqL4tYcH2rVdY0LmVw+09+lHw2ps+bHKs6/hKQtLUQ9w3Uv2hn0dPYxGUnhspcJ4M+I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10517

On Fri, Sep 25, 2026 at 05:57:38PM +0200, Stefano Radaelli wrote:
> On Fri, Sep 25, 2026 at 09:58:44AM -0500, Frank Li wrote:
> > On Fri, Sep 25, 2026 at 04:02:21PM +0200, Stefano Radaelli wrote:
> > > From: Stefano Radaelli <stefano.r@variscite.com>
> > >
> > > Add separate DTSI files for the WM8904 and WM8731 audio options on
> > > VAR-SOM-6UL and DART-6UL modules.
> > >
> > > Put each codec node, the SAI2 setup and its pinctrl in the selected
> > > audio DTSI. This makes the WM8904 option explicit instead of placing
> > > it in the shared module base.
> > >
> > > Signed-off-by: Stefano Radaelli <stefano.r@variscite.com>
> > > ---
> > >  .../imx/imx6ul-imx6ull-var-dart-wm8731.dtsi   | 71 +++++++++++++++
> > >  .../imx/imx6ul-imx6ull-var-dart-wm8904.dtsi   | 88 +++++++++++++++++++
> > >  .../imx/imx6ul-imx6ull-var-som-wm8731.dtsi    | 71 +++++++++++++++
> > >  .../imx/imx6ul-imx6ull-var-som-wm8904.dtsi    | 85 ++++++++++++++++++
> >
> > what's difference between imx6ul-imx6ull-var-som-wm8904.dtsi and
> > imx6ul-imx6ull-var-dart-wm8904.dtsi?
> >
> > Frank
> >
> Hi Frank!
> Thank you for taking the time to review this huge patch.
>
> The difference is in simple-audio-card,routing:
> on DART-6UL, the microphone jack is routed to IN2L, IN2R and MICBIAS;
> those routes are absent on VAR-SOM-6UL.

Is possible to share most part?

Frank

>
> Best Regards,
> Stefano
