Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010020.outbound.protection.outlook.com [52.101.193.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7D73F0AAC
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 07:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784793012; cv=fail; b=BGp8dLaCNlbUWYIuCxoOqA+PABTgz5KbUpSSjjdmYQpzGczHN3Zj8SeRdNBlYE/NFZ9ugNPS7JEpvTZRFES8aELhsxyNpE9mQvvSY8AZZo0AZ9kaX+H/m0v4lYghS27p4SIc2ttBSKE717pjwYOp+7kyeDG1jnTvTiNww2df688=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784793012; c=relaxed/simple;
	bh=rPnploxEcsjMbzwM4yhFoiqDfdnk30ekqkKGU+7YhQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=huEJvD/TZAKYUozxwrTZ7/rSlgNlQHvRRQ14OShlyIbXXrvRoZ6r7wsLL59ww2HoQMO8xQwPDdcSPninIJiUUt8sTWjeJmZkpvUiFL7t/e3sRaHpBnuU6C9TCvfbMWRCuE5UHCpsL964T9E/efz+qAqso/ufbPhcqnVTqGpuB9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G1EFBfov; arc=fail smtp.client-ip=52.101.193.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G1EFBfov"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PtKNuvo2mCsN/gxRGR8AWr9K2xVV2lUu21EQvErULcY9S0wVyU8w4KmnyIqFdjStG8l9/UPrUjRhoEB+GpdlKVipUeVY2Q1ZyJkOCCHcBy+1s8Lb21N94DVAPb3YRqc0uTtAbXEmHJXvNfkkQLqX/va1FrS4magzMMxDg1OPXwKFLyNelyak8i2jC7xpy+WdfC2hF0hwPUjsoH2Ry6a1i+wqr1ijo6XpvnEFTAuycs8LLa0ah2JUU0A+hAWQyfVn2cHjiVkl4YvbZrt8G4lN4hzbSEkHaztk482iqyIaJStxNP7yoH6WyjereDKjwhri0MFxsXrNQO46lF6GPKFr6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ez489TdkCQyqUhXVn7OVgoV7C2+iQlTtX9bqACrb6pE=;
 b=R31ktfWxgmxKmOr9GdUyWzzrzvyfKyXpGsg94xXpcdZqF5Xs2wuVgnTn/Lo7X1txHnKlvk0+DwS3fcVBtBDM00Rvdz7a0PJdBZ5ijb3mMFLjSVu5G9BGD9+nd8Pfh3ETvvtDTekhnbX/EHssjpXwYx26DwcbVdnDRk5U7COE+RM9xl4qfGzn05x6y9pu60hRSOAo61RLeNAfe+yZ7gUYPbjJmS4/banGAm3Kygi2AItK4+GLWs588Cx+v+9jvXBetg2fJvQvFIug27Cu2ju3470MGhz/OUv/u34msBqiOzp+aoUstO7Vr3TpyhVTdEDwDDVce7DOOI+R0zVp/++Syg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ez489TdkCQyqUhXVn7OVgoV7C2+iQlTtX9bqACrb6pE=;
 b=G1EFBfovohLcndk0l5h0OMusgHsqBoQNHf0e8QaoBFLiXtP5SBSP5xWev5gKCYEncey9bPhX9EkP4sKxU6OjPA7Oy/N3ZHxigSg6QbBzCozUXsXFajByiSxDrRT+DMhGiiMuosMvdikA3+/h121z+Bz4EylSaFTblCsDgBDPTIxeKlLxPMkii0kaC7DhXsDJ9JR81wus4O1daoSxHPaxEDcoAZd7YCeHnrPFAqcefAalrQxaKHNcmzMqRzjYxMlzW8Q21Vnr0kyA2ZKl2NHzNaGv+xW2uK1npANqjw1aLodnSUAZ4l6xuCbGGTNEOdQbOkApFjB82UT5Ti2Z7MXaAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SJ0PR12MB8614.namprd12.prod.outlook.com (2603:10b6:a03:47d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 07:50:05 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 07:50:05 +0000
Date: Thu, 23 Jul 2026 10:49:52 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Jack Ma <jack4it@gmail.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH iproute2-next v2 2/2] ip nexthop: support fdb destination
 port
Message-ID: <20260723074952.GD3189375@shredder>
References: <20260723-b4-vxlan-fdb-port-iproute2-v2-0-9012ac01b49e@gmail.com>
 <20260723-b4-vxlan-fdb-port-iproute2-v2-2-9012ac01b49e@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723-b4-vxlan-fdb-port-iproute2-v2-2-9012ac01b49e@gmail.com>
X-ClientProxiedBy: TL0P290CA0014.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::8)
 To SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SJ0PR12MB8614:EE_
X-MS-Office365-Filtering-Correlation-Id: a97d592a-87ba-4d38-4c32-08dee88f026f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|6133799003|11063799006|4143699003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	REu20gQerTWTfsDIVyaUxj6kBcjZd8Q+/RDL75+uPxzj8J6ap1+LZkjTi3dWl4QQJRrh7xlicekD91Yv7QpEgXmkrtwfnzfy5+AcvDjnPEd2tFXXwrLZkrbymF+CoobfnmCaB+QvnGqxThKVtTuIFeJ9z2iAsx/WN2i1p0FvXWyA/gtJ3q3Fqpm9Xzl0zDwe6bdhGBkhTF+KWtTx/blprRd2Q6MInuKrvs8Im6DqXEPPV1k6gRWIQXpqIyufrqTfe75e1yFXI+8pTb2kRTDYx54g0BDqCEP7GazhW61sFWJ4owtq/6JQFB7W+dPWuuL8AFZAFkpldPlNLJuLVkp0Hmgh493pjeTd1Wj5w5njxu10dmaMP1nP/M+uGI9CIIH1rO9ihBDoAow7KhxWtKBQpVyZ/uKwYQ/WNSWrceidgZRmJ1klvz1wfZ8TbMN4uWIZGtZb1oska9Hugzqd7bVi69QdQbXB9wkps5r1BgdhhazApOmpXHk3J9RN0GF3hqdVpWx0v0GyzFwl7eeiIQ3j+ULADzHAR29exAi/qXVes/rfy0Px2NbETaEP93WofR5v80Yzp9WEJeAT42g4H/QDSvBPg8A10TgcUcoZM950E43GPUDt3qB+LUeUTYH0W1HeXeiP14KF15RQb0R/hyE5BX3QQqUkr97PWgqebTEELoQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(6133799003)(11063799006)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t25P9WjuGabm86j+njzy8S7SvJpFDvJSVX/q8NKCAqcPj2MzSGjgokrOA3lK?=
 =?us-ascii?Q?XOpmfMzlUZZj2Xu6ReUzsgbjXi1HPB2aZGE3LOWc6UoPuQcj+Mkfslneo7jq?=
 =?us-ascii?Q?GaAF55VBOR8fDlpz9+vBxfp75gLUlNeodre7aWJxYpmJZBO/+QvH0RyRMYcE?=
 =?us-ascii?Q?kP0/riatsmeagjM4wd69dPjQAEqYry3pcA9mKX2QcCbd1G02nZKIv2rhdmPl?=
 =?us-ascii?Q?UMR73b4iE9sNUNZqFAGPBLO5rRkefGR8JuFoCOdxHw2Y4zbCOE30l4TgMuA7?=
 =?us-ascii?Q?ZJTAs3Ho1AX7Ix0ZzfvXUs2x06/XoUpfumc1r3i45l6qEzKLjvcHZpWUWEZn?=
 =?us-ascii?Q?SZJrMdY+mlFx4nNX8wnF1+caRlJkFZaSKlz9MOPZkYFrTZAeW8WtJOwixze8?=
 =?us-ascii?Q?j048VthB+Pn80pU/vybYD+H58w7Rf/xtlNmLXV55APQp+AYhwfosOHHFH4Ci?=
 =?us-ascii?Q?lOK7rBFzpO35Ow0XZs0J9INhrmH4+sM8WFipxDpjsJ3U+qFlbPzta2fFJ7AV?=
 =?us-ascii?Q?HPDTCES3gOkaevy+Hys+yihyp3RQpynqagnRSSG+rB+uyU+WL4VlS8C5YTG8?=
 =?us-ascii?Q?HZONWq519vUxLeJYW/MQ4XQJZe1zi3JxRjQ8LulTkqa+Fx+sE/imQ3jl18/E?=
 =?us-ascii?Q?ouqvfueqe57vSpHsZ4rtG7dLS1CKgbmIfuT/kPNCnkngT3Qrwrj9q9QEOFRx?=
 =?us-ascii?Q?HE4SMK4yXHUTvznRRXpjn6RQ6+qVMXOOl3EdwGLSuJuT8PaMTs3WJzyND1aF?=
 =?us-ascii?Q?UtThdDcBKFYgel7vB0ewmU+VMj4tgRcYFXaPfJ7qcQyEpGpDa5ltIj+cijPB?=
 =?us-ascii?Q?LZXKQFXcIHwZS+rjWwc9EWRJkcnkJ/UOKD8BE5Vag1b5cmyg2ojqRqXMk8Hq?=
 =?us-ascii?Q?K0VpJEk+SN1qTWHYvgVsTeoZQ3rlk+uim625NK2I1MMZJY0ChLr5XDePENBU?=
 =?us-ascii?Q?HsiutHiIhWVJzxY8mmfEA1DNCpJW1Cde3B7oJruiSmjlccQXLF2V9gsBITt4?=
 =?us-ascii?Q?sECSgNJIx6t10FiztekGv3VtP2FdMoi9BigRBl13035uLP0qxExzSfpubqVZ?=
 =?us-ascii?Q?GxL/fEVqXaoAwtvRXlxENp1BLMN31VOA9jSBnS2XwIXZhpfH4gOehcrk0x1Z?=
 =?us-ascii?Q?sGKI3yLIIMjh7u+RD0NEn/FIPp+EGXigGPryYGyI6K2vGn/VjsBsRIoXoiya?=
 =?us-ascii?Q?zSQwF+ze/+q6TsGMsSJJWNsO3PoBQw9hso6Nhm651J85P/umuHww/AhL+q6H?=
 =?us-ascii?Q?61U0Z4tVLlDVkaSfrL2+1UN/nu/SnRIpjzcwhWaN5y5TwwlXiMc20Qvcuwej?=
 =?us-ascii?Q?9lQl9LeNyZ1GmGQ5T9ilEvhonGhJneNXIt1j5tlEdYzhgWOeug9cK27G04So?=
 =?us-ascii?Q?sv/KQrrKcCG19TCPFgu8cjHvY2x0ObQ2423J5ZZAtdVCdxdwPhqHRFnuHxln?=
 =?us-ascii?Q?pwRIUQqwO3dOoVaONYe9m168QoSQUl4tIwPWZw/8fe1VOl4jQOpAs6c5wKIi?=
 =?us-ascii?Q?SwRd8OzseOgBY0ep7DV0tXjVvIgP7WDCsAQ86Y4tsGqALIso0yG+1nmHf365?=
 =?us-ascii?Q?iEPTET+hl8axlmcPzaDs7V1ObQbL706NsRkfdfD1E78RDvsuqdV4ji6ELWWN?=
 =?us-ascii?Q?mVUwoOHTqTxxj+Cu9bvgIw37xZ6TZinvRQcRtOdIa0xYoC9/1oJdX61lmb+P?=
 =?us-ascii?Q?fLVbbVn2KPXUkzeETikjafdXsrAr4pPfv3F2rz+3Uxz5HrpmY49NoZFVKlUn?=
 =?us-ascii?Q?uZDZxFmDDg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a97d592a-87ba-4d38-4c32-08dee88f026f
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 07:50:05.4312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Clv8HXsm/Z3Haq6R9uA5ThTGyXpHiG/vAXCLENb8sd8s9yJEonFqo5sRGQP46ZjKKE0vxv3IiQIWOjWZLfes3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8614

On Thu, Jul 23, 2026 at 01:25:08AM +0000, Jack Ma wrote:
> The kernel gained NHA_DST_PORT, an optional per-nexthop UDP destination
> port for fdb nexthops.  VXLAN uses it to reach several receivers that
> share an underlay IP but listen on different ports, load-balancing a
> flow across (IP, port) legs of one nexthop group.
> 
> Wire it into `ip nexthop`:
> 
>   ip nexthop add id 1 via 192.0.2.1 fdb dst_port 4790
> 
> The port is parsed on add (sent as NHA_DST_PORT, __be16, network order)
> and printed back on dump/get.  The kernel only accepts it together with
> fdb and a gateway.
> 
> Signed-off-by: Jack Ma <jack4it@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
