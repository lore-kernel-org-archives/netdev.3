Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.34
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793200126;
	b=WRDcvLYaZRtg9rJmhihaQiSPnNFLDquDGGrYJ77YjiQDKHKemcZ9OxsEyhHlBNzBGQ90
	 1eH5pudyWvECd7hMKfudNNbWBL0LSzFkdRhPOiQ3970lKbYLQXGZBMeZyAO/WmnHrc7IW
	 Lvhz7rQGWXkSOATFBx5Ar8sdS97VczS6sLZjPy1pWfpFBGmw82TA434Rcf2HvWyDecThZ
	 4Ug5N/rH7IX+cdLQq7+LcblloZc8clizXJD96Ngp9t6G4xcRx7QDWPVQVItn1sOZggdEu
	 vOycICwx+3KibT5y7y0dOvyUQB7Em2NbE/zVacQxlGX3dYazLQIVxKVmGh8gU1eDiFw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793200126;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Rb9NDNOGetG/xQR9N1iA7tzn7ZTsDsps3DizNEqh1Us=;
	b=e4aXYcInm5/bZlRZe4D0SdoTwC+n0UNAAf7U+pM5hSLKiHZvrhDkRd3wZyCovkd5AZtf
	 UcxKIrkCiX+PUUeltHy2R93aCPm5od4l64naeHO+YUl3ZP4MoZH8bU1tqioHM2aDKW9Tr
	 Lt13MbXC2LKWXJEuZ1/I/mAnXWBF0EDvl62Z4tUoHYV491ROTD2XgjKOLxlL8CSroHXHG
	 IZs/4kgUDLQ5TUaF1f1jWBRb5dKq9QcwjOJmRTMikYF/wl4WgOBIJoetg/u3uvXBMJFQ2
	 dvHf1A0qfmMjmnUHnLldM69pKGOZOykyfWV3JksSbLvxIGR7K3S4J8Z0/XSTMrTMe9g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=U5rP5C4i;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.34
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010034.outbound.protection.outlook.com [52.101.46.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAAA606A31D
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 15:08:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAAAA606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=U5rP5C4i
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xh4d5vJWj7nKif9wsoXgbgtbC6GkehAgqWck4dApTaTCtM+gp24WcxQUe/MYRELfrIxJl0je39NV+eIsW1NRRcPFXZaq1MLQOR23/jSgsFNtG0SMYJoeTeowYKwpg2vWo1Mt7inRL33w5GSsN3QSopykHB8ulFZYdLhLvhzgep1xaEs1OKiklkz8EOZxPbXvF344z1bC1xXKGnp86dCbH1IB6ub0OJDN/J9pTrEmvY89I4Gp8c0NWjzsqO62Wlc0AfdYOv8upnO1b35Vz9Eeni77BkUv7pbVUaimBybA9fmUmFeEGp6FlmLnOWoY25VX8XEl/XCX1gZfletkxt7iSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rb9NDNOGetG/xQR9N1iA7tzn7ZTsDsps3DizNEqh1Us=;
 b=jTz4wwui/wR9J2PbSugfZGRRB04Ye0ZhtTD1VSAMS7bwmkUvNJ7K8LvbaMTMWzwSDlbg4e9h90AxOvmxvYhr9T4kCpaCkoKpV5qYYdL/Hf73I2qX7HAr4LekYax3HjzGxLnn0eGso+JatzYydpMEpWO/TPSol1DGKXmOwj0ymoOf1Zdx01KHeGrc8F8aQT15IeKIes/Wac7v6N0zXBP3hq6uDiaqPGS0fcScVLaLSosM+SSIKFtw3mKiECDkGeKpV+RCn/O8+FmlgjXi7EhNwklv/waoEX8aG3hKunmDRVHe2rJrGsnSy30CIUFgFuqPFwFSJKujfU8WXDV8GLV8ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rb9NDNOGetG/xQR9N1iA7tzn7ZTsDsps3DizNEqh1Us=;
 b=U5rP5C4iJ7xh6cH6Vn3TkUOv291t8MOPWzG6QvfjUUkChxe3ekCAv/IdHiO+K/HoY9xDmrSINgpUKoML/V9kB0pQPCbUYrUhhD2Vf9XmLIjzLQuMK+q2P6C4jogAxdep10tR8e1/g1sTSrHEeQNnT/7xg6x7UM3mmNLFPKPVzVFdE9HXMRobE99MUA1lkLjapqRj273/lh1yg4Eci0n5a0TSKDMEKjwemo/YiI6Q/4v745weWQlNBx35CDtPbqXdHmo/1wlTNlMUaZmKNjiY0s+J2OariS7W+DveukBXRn8R08E6i/M5YB0pS3sDWNG8X1hVDjCDt7/AneEw6xvZ7w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by DM4PR12MB6614.namprd12.prod.outlook.com (2603:10b6:8:bb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 15:08:36 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 15:08:34 +0000
Date: Wed, 28 Oct 2026 17:08:24 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Sascha Frey <sf@techfak.net>
Cc: netdev@vger.kernel.org, qotmddnjs@ajou.ac.kr, davem@davemloft.net,
	kuba@kernel.org, edumazet@google.com
Subject: Re: [REGRESSION] vxlan: duplicate ICMP replies with nexthop FDB
 entries after 3fa64d86fc64
Message-ID: <20261028150824.GA992905@shredder>
References: <20261028142928.GA8406@techfak.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028142928.GA8406@techfak.de>
X-ClientProxiedBy: FR4P281CA0079.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::9) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|DM4PR12MB6614:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f3beed7-2175-43df-14d2-08df350555f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|11063799006|56012099006|261026121527099003|261021121427099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	qeuiDF+HVtrg0JhQlnxbHdqgtmxdo0cIgC5iatS9Qa8uKLI84FVng09KhKKth4aDE82C6AnWyHFceuUgUakXyYN1pVUFpiFfySTbfPGlr/uZ4F7iHyShwcsbrqV0taywlUh9roxY43S2zmsT4wDofJsOj1Ja6UMyVf7IJlYH/P7A+YKl0xDXTu4yyDfbAz4maTl+JE6ZoKwXoGhCyU3+8RfUwZh2REzEImrj3S3TdqnPK7zG7w6yV2NGz/ArsBRRgOe+/ci4CktFOoMhJVXn9yQhxxjPnF2Zc9nkExbBl2ONs4NWcGyB+qqqdnzGWOe5ix3BPowruj3EBWTYYhafud27zMSXaCkaTei2KJwzyKuUbT/DUfYkiWayz2aetEWMfaIxomLaYLw9rbSmo7zVLs69c2Ehy314uVeSwUXQiDPjEn9GKH8zwLMGcS0kUaPJB7lCMfd59KlEDFSov3xDCtLYuniuAox1G7TUp+EjFzpLMeQv+NJHy0BSz8im1iqqNT/2yXXyXdcojQbIT4eU7rbpJXigqa9AFBzmHUjoNMX7sTY/YCWAsjgKp7YcacCGbrIhT4qaYXktKRjNeZ6+H6IkMuYmroYUoMLa6VPdomqADIpDMYXS7H9TrTCLGDfPzG40HmO1YcB7r+5dmCuX1PprONUhNXluiy9S9gD5K2Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(11063799006)(56012099006)(261026121527099003)(261021121427099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V555bWQEMM7U4E2L1L9XKZmSr80DY0hkgtdOTIdiXeFvdA9X9l6JBXhVIAwD?=
 =?us-ascii?Q?FlKGjHX2SYO3CHKzk3keoZP4Vrr3ecvnyDZ73RBcc1sPDEa2XJorNQ5r/270?=
 =?us-ascii?Q?DUJrHBKobbhsrXhZNSySz/4EI7b+eBSQva7WLeIoyF8z4klelOlMk1Cyril6?=
 =?us-ascii?Q?U8YHWLpoHKXD9Gxqp4oQQwVrMPIPmBSu74i6J5zdpwhZRfcPu2JvH9LYCwfT?=
 =?us-ascii?Q?DH6cjOBuTyoIvwHMKwhOBRysfN/A3m+JLbQtUb4XJBAE1rlBrDOJovgDjc2z?=
 =?us-ascii?Q?gApeXuA2bLCLPeCdkG8Ri5tuPH+9SHLwdnuQb26Bl2qtSeNrlwn6nJR1uT7x?=
 =?us-ascii?Q?fq+YZ37jmffTkJ4ygqq5NsPOyjnMyHeHs+y5W90jmWVGH6SXcqbr4nWFBrC+?=
 =?us-ascii?Q?mzAZTohWRAZA+QNsewTyRf3lztrcTP+3G4UOE5tuMHB4Zm5nhRPecKqm66zA?=
 =?us-ascii?Q?7L43iFZO5nnwvFUvhcKFdsBvsblMpTR2nL3PZSosjROaVu6N2TO04gqE8EEg?=
 =?us-ascii?Q?qdeiCHFX/VgCa3DLN32C0zXxBCbQ2XOlf59CQEryL2u2JlWFAzz+oli3ffD7?=
 =?us-ascii?Q?CdAUO2+653zXdcF8vsvs4/QMWmYDFIkZqf8e/9zBfdZ0wXB+H0VXJWF+/123?=
 =?us-ascii?Q?k5z0psvs8ABDN36MV0mywqkbP37ni3R+pxDgYcDWDUH6jPRfjLBU8+gnWHlk?=
 =?us-ascii?Q?+g9jHK7UXyx0/qaJ/uwIINYAviY6ltatpriPqN/Jkk2eiDtMC6eMezKlHVjp?=
 =?us-ascii?Q?hUCmnPLbKUogYYs2fB4Xyp2wzUroP9wP9VQA8T76pHQcRI+C1bksQwp+aqDY?=
 =?us-ascii?Q?s5pmDyKfFkBOcxlAulW7vYrYHN7DVUumyK3b2FdWiTEdtKRyBzwS0WXmLy2R?=
 =?us-ascii?Q?JxS/+AcU9DIwQeIMdPLJl1O4DxmzHd28ri4W61fYGRLTss4PlSOPqrzyxNOQ?=
 =?us-ascii?Q?UPS2y8Adqp42YXeIJTUl0Etk31P2xp+bk55Xvo6pL5zS3Wptq5Klsq5kqbu8?=
 =?us-ascii?Q?qkIBqJx3lEaiaOQ7gi1CsDSqKVYqUu7MIrUVYPixLWZRrH7K1Fx0iZikX5xR?=
 =?us-ascii?Q?mGefp0aSk+prQNeDKxi/85qHAL0SJzmCu7MXoydWLDpBZOueEjugvjr0GPt1?=
 =?us-ascii?Q?yB3i/RjS23m1qCtpnYCjIBfxKQPK00wdj01N1K1VPE9TGYk5284jPF0uOlYQ?=
 =?us-ascii?Q?DVl7u+4GUEZ3cUwxXal8oJnTfMUWqURoB/aOI1RD5vimFwdfKEEr8w/Aohss?=
 =?us-ascii?Q?VXcD0dGtzHo4QKT4OZjNehHALg9xoHuvCpcdBx+uDAykfHvyMTjX7GVlhKt8?=
 =?us-ascii?Q?/Wva0ev5sMD4i2vkKWn/44uCISF7BOMjFzU0+kWaesw+VmmO7shk+Qj7x7ty?=
 =?us-ascii?Q?SZl4W0pe+CJJobfKvjyDGzQL//nCnphg7g60dZmiHuP32NlGklAZVg6IAAKv?=
 =?us-ascii?Q?KjE5yvhMwuH66R6Jc9yNTy35SWOflI3h9UXkMKg/h+Zv3cO55s4Jy18E3tXs?=
 =?us-ascii?Q?dN+ry3I5aP4t65DBlWKmItL8xE/WPhQjdrGp8nnNKXJAeN6/ZrzPrX1pmbJ/?=
 =?us-ascii?Q?AJBr9cKVD+cErvpWt0z3XyXZM5rPT+hDU633xnyQvnR8aLnc/kHuBQKMBk/h?=
 =?us-ascii?Q?bSD+z4OQqbfxQaj6yruv1Ah1UMetotKI1HqZijSjaSypwPppeggsMlKWinTN?=
 =?us-ascii?Q?HwOql2uSNv0SxNeP22uqwo7GuPDZLXtervMV8unzDFAsTmDu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f3beed7-2175-43df-14d2-08df350555f6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 15:08:34.4497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xvjlg/CfbQK75bksAR7ojm3Hmv7F1ldrDqMup/WEmf8geJR0gvp2IwFfE9ZX/fRI6mfXVuy5xhGYLtSfwYCpPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6614

On Wed, Oct 28, 2026 at 03:29:28PM +0100, Sascha Frey wrote:
> Could someone help investigate whether the new checks can interfere with
> EVPN/FRR-installed nexthop FDB entries, or whether this exposes another
> issue in the VXLAN FDB handling?

I believe we need to relax the checks to allow "extern_learn" entries.
They are not subject to ageing (vxlan_cleanup() skips them), so they
cannot trigger the bug that commit 98fc57d16744 ("vxlan: reject dynamic
fdb entries that reference a nexthop id") fixed. Let me do some testing.
