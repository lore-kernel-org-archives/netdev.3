Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010071.outbound.protection.outlook.com [52.101.85.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B1A34F24E;
	Sun, 20 Sep 2026 16:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789920189; cv=fail; b=ndf8nxG8LUF3lFp8QCDkKeg87A8X/hxI4KaSdfTiEL/xHttbIGeaiPFv/lWyV4rCOFTKf0Bda/EJSUv67DnOkyVb/2oD++/++WJAn96CHWlxr3arL2nccHD+1B1VE4h0YkNpTiy7ePj4+13VVGfgF8naxis+Pv1+VrxQqO1YjYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789920189; c=relaxed/simple;
	bh=7UqR/xKL9IVy3RYUWA6IFuS/Ul0/Zj1rUtwHf99izDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SQTTTUWUrCQMiux6f5yL8DAjmrdTc0hiSM+cBgYB2Z/DUOXh30VIXnT4kYVpKVklqfJZ3q4L4QHpm5q3rBEQDwOJvjakielgJbxpb7yipNQtFNjfybL+GezMN3zGkxWr1ADXmiGBiABzAkSdO05/HuiPOdfyUwUTON7ENcGGK1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F23GL6+z reason="signature verification failed"; arc=fail smtp.client-ip=52.101.85.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F23GL6+z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AOI7+BVxjU2CVcDKTJSJxDiITTkzMF7M0qfvJzhmgpVyLn/4UwCW1a/0+H3N6s2hJkXwXq5kNz19jgpD0mx9iVyybQmJyL3UzCscHnPIk9n279NJNdN0WfsIXT0pcqwc6d06HuOnmtOVn3+a1g/x/kFbA64Sog69Hxk6rWSLOCjHjLtGAhFtcHP1+3KqXM/DvfgyO4faRjxBnm5QaUWGl7+/ud30g9Y4qzAhgcUHMScbkKS0xGQqk+/bL21SehcK6GG5f0b9CP8QQJPRPqKpiAg0tz2I2NXLJJDx0AKn5tzuqu20ulgg2WSY5OC1QUZB8IQjH/4KtkZnBSYH6dNS2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yL846swHNIoaQkALLiRQtXREcvQi4RVeEVsDbQHysSc=;
 b=bDPr+TxZOd0cuiBXHRt4WoGnkTGlZ6NS8SG2ARJ4xcWf/NWh1RAC0jMUN4Rbyyb1WR1G82FkTb/iIiq6+yciTcoLzQ/NXYL3CBZLdOrUJZISNtbUAeSom9dc28JFxzONHH1/lJJ1Uxh1F/3igS3bL2I18gIjq2uF9Cwe14jD8YpEPm9jd/IkMHbSIJbDejnD6wkWwVD2RnbNGWz1/9TrFgY5uKcmTIGNaA1fi1jyOyM5OkCtu/wReogUAKZIeEM4W79rAZVmSNwVERCR2vL8XnQJnpnL30XpholzRFJ7DKVdKtcJdn6ORUV62Ldo5MxwB8lNspEN1ExI+E732z4/aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yL846swHNIoaQkALLiRQtXREcvQi4RVeEVsDbQHysSc=;
 b=F23GL6+zRboeaubIZmyBZmpKI6c/GdN7CQZHvDMpY+99mx675trlV9WdUjXrtt1RgUXp0Im9+jOjG8Oy0u5EuPGzWNQtfye+PtW/iZYg9yBJKiugc5tKir/0vicSBXJ/Dbl5LsB0N684HKXMzbH9F2i57YHnovVpzA1m7hM9v3pepyJA8FSsAZEWmSjFTJNRslGpUQued25peAZTqKPfJLP5MMyrJ8WjgmbHITY+RdujPkp8bzKNZIeelkqY8p/Q5cTGU+jRUgZQ2V02mEa6b1bb6+gr8LaB/mYTlP8B7N0/bXDSOP/GUV8cGDbbMFaEStjVYJKyAOXq5rAKmSBIwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by IA1PR12MB8264.namprd12.prod.outlook.com (2603:10b6:208:3f5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Sun, 20 Sep
 2026 16:03:04 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0406.007; Sun, 20 Sep 2026
 16:03:04 +0000
Date: Sun, 20 Sep 2026 19:02:54 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Adriano =?iso-8859-1?Q?C=F3rdova?= <adrianox@gmail.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipv6: check per-interface proxy_ndp in forwarding and NA
 paths
Message-ID: <20260920160254.GA2024427@shredder>
References: <20260918151405.716075-1-adrianox@gmail.com>
 <20260920063412.GA1777922@shredder>
 <CAMGU2hXurKGhL5rhDQnT6uTKST=YhzQCuC5yHKZOpnmdV+vxRg@mail.gmail.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMGU2hXurKGhL5rhDQnT6uTKST=YhzQCuC5yHKZOpnmdV+vxRg@mail.gmail.com>
X-ClientProxiedBy: TLZP290CA0014.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::13) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|IA1PR12MB8264:EE_
X-MS-Office365-Filtering-Correlation-Id: c9e1b799-7ff7-409a-4d6a-08df1730a77f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|10067099003|18002099003|22082099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	WgZhLukLJVWy6HOso2qL2mbiMrX+BsNxKo+fNKoNynzSYolYZJGxTHNXencyNUltCcUbUlON3h28KfvsQyP44jBPym2vI/7cD92W3L620dPCsxq9kQwOaFUPIIqFvp+ODrOEvHmDitElsgsi9Ped+sxpzaJWb42LWX204es2WmCCsrL21GL/jMnOxuWkmnxNbiaQCoeY/UDbUsCA2eef09s3AeXqGCNRS5Aq9h0IKxtKLw4BG0NqOZtE86ttsUNgtmDXH4ptyfcpBj/+YqSsnDY7h4TJm3qdNNNfSNh1oTew8RCISc+Hd+ENMR02xK+LVarN6CexCVcd5tP7BL06U0Aad2NkZYZzFqpuuF3Ks44nGAWQS9b2BDabK5FCOyqsuJKpidulrn76BWJJ6x1OwQCaDVyCEy7ZkuVl5U1IwZBdHZEnCH97z/yAE+tUzUw7YZNJRPT9getlFFu8Mj2l/fpIak3GmUttPsEs7BVTdlQ+OAhxBsQGN/qLmWKm1R23LkMkCw7CGH2v++QXjRurFnyQYDgOkn2XHar3SQaMBYZ7rROAbOQ2N0vh8ETuSCwvTNLL4sSRoCBKog9W5QAzOw39wjW4wS1cS2/V7cRxcjkrgRuTyCd24rScnt1PK8CsfDMxNGf+LB5T2YuBoxgOk/CshjkLZwr+z7iuLwU6Fyo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?prnCdz0DOCOpt82vgqRl9Cwz1oaZCjBVperj5VMg4C3TdOCuv1qBGsoMmn?=
 =?iso-8859-1?Q?WPyZQhO2IFk5WR52pPO71gwNPRYdAYvlkL+JBcPOn3aWXCYc1D6lFN8JsC?=
 =?iso-8859-1?Q?dKkOXpYqE/W4cf4qgidFYs/MVqevgaeILqcTWYXHzRiKCbKQAmebOX5nN2?=
 =?iso-8859-1?Q?hR8gmJLEPRynLQHqtu7TPKpzbZTAzH2QItiqKmwC3IbvrTPGAAfVqCHkL1?=
 =?iso-8859-1?Q?59OxAWXloDJ9sdFDHAF57HVdWjxsIuwUk1lsrRKmtg6ox+6miIS3JdybOQ?=
 =?iso-8859-1?Q?Xa37z0GzCinBR7CQ3mmdGxHr+UAJsoghnLs85H0EAZRFr+Ai8MScOJoK2Z?=
 =?iso-8859-1?Q?V+L3NII+b2Y1yMtpPXeWp+B76atsUrtHPK0uRMzKkaOGXUWjKyTu6SGeGX?=
 =?iso-8859-1?Q?PHECy8Uz2T2A3S9L1ZD9eR+59qMbhCTjx6gtTH76MVqFSPMsNuCABeQxwk?=
 =?iso-8859-1?Q?4f2D0Djg/j+x6ko5d9O1nMHDEwgGg3fKmZ0qL7z8VQ3OmdvtWoZMmg1+9/?=
 =?iso-8859-1?Q?quTpmuvW/jcoko/+0srb0WQ6ZuNPTriCIo4ZqlMprS3Or5Ok0XA0bl0DLR?=
 =?iso-8859-1?Q?r9+WOYPHGSMXYkWBgBuiwq0e9uTEySE2qhjr/fg40s3mWClC5oQDagH1Nt?=
 =?iso-8859-1?Q?PGwxrtKRvxSKw4tjXuetQIxW0EMwx1fatRK4RBG+gNkoUcEfbwYLKKrv6q?=
 =?iso-8859-1?Q?iWWd9FyJUpDZJWSrNazM+aMt6xJlXR47zAb/ZwFv8B3twMB8tjRuJ3sAse?=
 =?iso-8859-1?Q?7dqkajyWek7QLHSE7OiF0lBCfCy/fvgtyqlPbbQ5D8YTJJbG3gjcM15jUG?=
 =?iso-8859-1?Q?1kfqSp3sDOzWp1qbccld1pevQrwfNDup5W+uUMTVR51ir4Kih9L0n5lwkG?=
 =?iso-8859-1?Q?fntv79OC7Z6rkBlNT5BbaeeI+SW1rtX5wvpfxUpSKuejyVAsfopVrnJpCf?=
 =?iso-8859-1?Q?gbGAgwweqS3may5Ug0ubb/TOU257wtHqkN4ajH9m0eeHziIUr9IIOE3AZo?=
 =?iso-8859-1?Q?RsE1NZktPWnkenby4dDyIU7V9bFwHBqGSxERGlbOODvjX8semDDaUjCNtq?=
 =?iso-8859-1?Q?V0tnofSoTwBDhXc0ESut9TpKHbNFs21RhJzCLuI3fPXw18hGsmEYnvvWpP?=
 =?iso-8859-1?Q?yNIonhA7q6yvJPJXc/m2bSG9OYIbG5CjXaaSgTVCDePztrDwWxXorceaw5?=
 =?iso-8859-1?Q?5iZeGZFNC0B9TjUfgPPUQQWp6Y4o3Spcw3GKlB8qOoXh52pNRCbxYsmJqX?=
 =?iso-8859-1?Q?A+JAhZKjEpcH7ZcBzsRy4CcPFx5bTTs8+B1vIFq3HDQ3kZq36bhIUAC0pT?=
 =?iso-8859-1?Q?m5GajBf6KQaEXbFLqEZ4I+YJkODnGoMvLwVSVM65oPtn9ZflK/xchSgiLC?=
 =?iso-8859-1?Q?uV6ygUNpAkiyLKnLOFWEOSLwIwCO3TxEWWplYOTlK8U0nturFudjF3vgbx?=
 =?iso-8859-1?Q?9GGU5W+oozQUf34+yezSrvLijRXj0/IfC/QxhFHUf5Rmz2NcgV5lW9cd0d?=
 =?iso-8859-1?Q?2G2nXHWkA5sn4nVq7arPLZw/FwnskFVTjL++jadzp5Ju961yNv+Pk5jUbd?=
 =?iso-8859-1?Q?HJj2ntYLWM4ux44XYuo0HXwFnYR2WdVgRdRxi8m/uxij0myYnuLXK1u9Ak?=
 =?iso-8859-1?Q?/tw+QipNwJbcNYBVWoTXMY4SgWFxDmBYDu8iBTNjzvF7vyS5ESiXJml9zg?=
 =?iso-8859-1?Q?7Lxv0tZP4F7rNrTYymiKaikrLSFxsta2I3QtNQf9Eyum9BY5kiLtwmZQTw?=
 =?iso-8859-1?Q?rqI+yKGExbgTAML/xSIacA7kKt8SZp9LZZYSawGQuFxe+2ClKetOBFV05C?=
 =?iso-8859-1?Q?EZWO8dqNEQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9e1b799-7ff7-409a-4d6a-08df1730a77f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2026 16:03:04.7575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WdZmCkFR4BWCqcKuyDRKnKmuUFmok+x6oQpyJA+17uquctLD6PKJdFqB2xscBb0JzQOlxDX9wmdgYDbd4m24Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8264

On Sun, Sep 20, 2026 at 10:46:24AM -0300, Adriano Córdova wrote:
> It does not hit any of the current selftests, but it would be possible to write
> one that would currently not proxy NDPs, I think the following config in the
> current code:
> 
> net.ipv6.conf.all.forwarding=1
> net.ipv6.conf.eth0.proxy_ndp=1     # all.proxy_ndp == 0
> ip -6 neigh add proxy 2001:db8::100 dev eth0
> 
> makes the initial multicast NS work but the subsequent unicast NS do not.

From the above I understand that you don't have a use case for this
patch and that you didn't even test it ("I think"). As such, I'm not
going to spend any more time on this submission. Also, please don't top
post.

Thanks
