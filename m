Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012034.outbound.protection.outlook.com [52.101.43.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F76F34D90D
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 14:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789481138; cv=fail; b=Fir02BDrB4ZxAgfVa3UQPeWG0Lrch2AkX0x6oZEieGHTM5IithVOAhPBd7x0Q58jKWuNYZOJPufDGOCSkpLuuNI93KhgY81NYl8DIXY7Eg6juSIcgooJ1dTBWXCgSYdxgvRFEnWhv1kawJ0m65Gkr8+ZdeJMN5hHxU0MQWRTyZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789481138; c=relaxed/simple;
	bh=eq/BwiQiZiwk4CifNXaO1A98xX274O9UPU4T/Q55sXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=l175nMkZ5e9TsJYIFEphoJMt32Yeo5jVqnVXSBdVmtT0MC/ETQ+jcCqWDGvDFdo9io11ho/uoic7vDY8rSh3FpieRokNBI5u18Zq500ocDE39jth/fG0KOhoC/aetVmb2bgDNRva4p514yIjkdJULFD7jcK1MqkyMY2/et49UAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EXg7aSvW; arc=fail smtp.client-ip=52.101.43.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EXg7aSvW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZZfiu/WlvzKaPwIxgwArtv/ZBu9osTo31UZZXKsr5cT8MYvhmEOUrDEzhP0HrZsfNSxy2Ki0SiBzKsDOPCkiBENHdxSxbT0mEV5ixMoxoCMd2FZG8XmUg9GR2jtoPPfIStaC34WSaP38gwKzcGFy+Ygz0OYWsnG/QKhhIB3YU6m5vL29eMIn7+MEtVsvSK9MvtdN3JFeCJ4GzMzdKGmExFj2GSMhscP4QwJ0p00xBq/wEE9dU51w98X7Wb12/rPtL0fm1ZHUWI6mc1pAgT8g49xdCvQ9QoXTn83VwEEi2wCgTuadY6you0hKB2fDD+Sf6Z17n9k9XC7BEsUmaagbZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y7IR7eX2gmkPuvWmM8heGD5O+zafeQGVHtffkKzWBPI=;
 b=q1Hst/PqAQW8ypvqByC39LzbQpRulzwDwv+KOqjQ08/SQM6JmGW2qtmLl0zFLRSxWCUniUAwAAHPZOJXszaa9OfiMt/1y5B3sEUFJVX4yecI6fM68/lxIDK5KLgisjtRBTzr2kYk9O6hotqHILfbOaZFXNTl8EnmiQ93Reqpcrf81dsgKro0sUlL34dyFUVQCJxKDCDQoxefeaEu98lHAdmMnGGguEds/qAoPlZuou2Q9V4p9wpizloA9frRKQtYWfdBt1EiJz7VANZr52NvTkcGl4L3gUMFiFYzvfyWT2mwoxrRm4/jH9b8b8RARYJRfi6hiQmFYutYsn7R9CAiMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7IR7eX2gmkPuvWmM8heGD5O+zafeQGVHtffkKzWBPI=;
 b=EXg7aSvWFfLAmZVAh4T2XGhgrxNMia998rFX33eCsT5FfdbHO2U1kFYBajWEknZbdNHpM8dAqgO48zL1QEvT8ToVE5OiRHuavGcR8kY87nz0U05sFYydD8AcHncDMRKy6tbRjgiEXDrrEBLtjsu9HmaHZx3GVQzUyk4fv/98u5FN69L4l3v1pUdk46nrGxe9jE0BrpscebpycZYMH4BMjO2Gv5GWN7dCtyb6ab5uVr50csvrdjUgVGWjUmL78f6Jhiw42mRTAJ5xKTIcxGIN2gMMvADVvvGn75nThObOC8lkGYT77C2w0SuReKcxWPIB43nD7Yv6lYS10C1VTiFJpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by DM6PR12MB4372.namprd12.prod.outlook.com (2603:10b6:5:2af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 14:05:27 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 14:05:27 +0000
Date: Tue, 15 Sep 2026 17:05:18 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Quentin Armitage <quentin@armitage.org.uk>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH v2] net: parsing IFLA_INET_CONF broken since 7.1 if
 NLA_F_NESTED not set
Message-ID: <20260915140518.GA687229@shredder>
References: <24158a1c7c9d7fc28d42a0be53f3b9d1919caa1b.camel@armitage.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24158a1c7c9d7fc28d42a0be53f3b9d1919caa1b.camel@armitage.org.uk>
X-ClientProxiedBy: TL0P290CA0015.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::7)
 To PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|DM6PR12MB4372:EE_
X-MS-Office365-Filtering-Correlation-Id: 44960a83-9f73-4bdc-4b30-08df13326503
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|56012099006|11063799006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	xI9rpLmuqwbvP/aKXXDcSxW1jtLovtD2rJS5VzuweJFPWU4SPyagrA9vi8TAo0/vNgkK2rQgb+bBv9WPNT4o3uFhBBXkU2RrzcRIym2/WA76YfCfyN3EZqqRDdvnOMMIuEyqztiB4xC6rq/zVBcK/zovK1z8Zxe0S8wayV9yBaro5+JyfyKHMWV23O1MDSHQrLrS5WRbDKfKh6Hdo7RAQEr01VQijd5GdLW90gYyUS725/TSsUccCD6qVzJMPg15zJLQs2cLNm5LbzaZ1qdYTm7Xi7wNqpnDWw+rM4COcXlc72iHrOPHLU98aEWXTg7oCaWQ05KYfh5r/I+iUgFJmgByeA1nXekU80AR+TMJ0PWHb/g1wN/mmaWOE2k32aoq1UZGNR2NgXu+kvO4gYXBZ48q8dRi58xg6IRSwaztmbD5x82WbP2kvx4uGf7dfspdDwST2lpbYtkVg1BrIjtNCYsvJyEWwbFz2fWiGNfJh3Ld3jedEBWzWscMsLTukqwwei5DP0oVOZ8vO3S/gnNJyO/dlydiWCnGnVOy9tqGIEJBt6KHaBTIdiahcRofb/ujmJ36uQ2FbojmakF/6+gkqApfZFTePomI7Uk5EuGDn0M5VZMbPuEgEhS+lB3hpvqbgZ3ruk1YzSRXGbrlSpnU63lU5OsPon9GhcNR3fOFU1c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(11063799006)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ryyQPdqXGb65zUshR9UlkUk9g//PNLGuiYyzx7DcDeSIc6jxSNZwL04j+QwW?=
 =?us-ascii?Q?NED3zvuslBVoRKIRawGp9pJg+3GOHAIwEK17j8BnLm0Pu3NkPHqKXWLvvozo?=
 =?us-ascii?Q?7GyJha0k6FRHiLHlDZrq7CHW5jfTrbE8qrT0t2D1Rg4h501XYRCECPIr4gVs?=
 =?us-ascii?Q?HStW1RDEcEMhJ50B1Aox3yAZe0pmwnsat7oj7X9den4SOXYT1MjFOzXKVZYk?=
 =?us-ascii?Q?Sy91IRoEINESdghyj3MFCEBSjJ8GSsytU0InhYyarzrFQeh79FsGTi3eCxAY?=
 =?us-ascii?Q?j3BnCyI0um5TUz4Mbg+InxeHVtJdIIoMTpydDeEGbv5kXntauGSUSbsZ+FyF?=
 =?us-ascii?Q?JvNWn7VIW5B/jKhBX4v9ACycPXVuWTcuBhEirt0i7xpYK09s88dd+jJiFwPj?=
 =?us-ascii?Q?KS7v7pmtts6PzyOC92wVsjSJ1z4Q6IvqGobT/Mu2GfBH6GegLKtrIoRiyGsh?=
 =?us-ascii?Q?VWA3CsohvbehKp3V5Hgw86uwIRvBBIc/SnkZL1dKWvCdzugUsXj/raiVEo4Z?=
 =?us-ascii?Q?D9iQGTh0bR19ae/gcnOPSrJ2MtbAPMECQqss+k6bpI6p4CPavHmaQB4xaUNg?=
 =?us-ascii?Q?Hu/eYkNvJxngOz0qUxLcoymkYWCHeFbBx7jes8/BgwSa9CwdIeYag6v44zEH?=
 =?us-ascii?Q?D0LvyiWmmpsCHE7/w69DlLU0EV83UyTSGpmQHxlmrN2r1MCo5FWZyNOi/XjK?=
 =?us-ascii?Q?GnGGEEjihm80JGmiKX/mCmimj7X980VO32yYhN9xo5NBqLMKh0jLfkO2+ceh?=
 =?us-ascii?Q?k1blWdQLf6Gch85KwlY6fIYUWNMfOcTHGkcxN8NTa06/VZp1e2J5gisCZmcP?=
 =?us-ascii?Q?W09GReUgNmrjsu6TBdIOUMUqo/f4iPxYljpAl0BlHXWEPEUfN6f/Lh5dvvOs?=
 =?us-ascii?Q?sctbdNNJ3MZYKXQYTHQmu+CSjXpBhP218gYRyftqK+hIXazQtrYQR6m5s4fW?=
 =?us-ascii?Q?C6ThcaChgEvC9HSxFIYBI2a0HzfbyC9ZXmMkFUI4Y8ENSa+YZVi9z8V9HeWp?=
 =?us-ascii?Q?l++yUBWZuAZKSKkLIrMO7L4PkHwDjVItNbaF9afm29YwUnJ6rCC1y3VP6tWW?=
 =?us-ascii?Q?ne4XNtbUlKpTgoDBtyXGCZcp4PTghe1P6vrU/GPiNFjzTZmNI1uQ7AeR3r1F?=
 =?us-ascii?Q?DCIpesg6P/oiIO8RFzK0bOTz7bocC+VTgvV0l0VtPlKjO1SfA75yEE6yS1vu?=
 =?us-ascii?Q?nY3DPE8hwqcV0BMRxSf3y4A8oubqxxxMDdJj2tUSDLHc65Sm9t9Hiic+gYjH?=
 =?us-ascii?Q?VxGIPtaMIOiisjCMp62A2j0/iknG10UwKVIfYLsAuPUMIg8w78RkptlJOZt/?=
 =?us-ascii?Q?fOzmkWf+yc3ysVPxz0gCzJV7/HIp+TPDlypxbVHbROYs1Ys0KQC6NGQ5+NZd?=
 =?us-ascii?Q?+mYm+CzwEnvjw3q1r2HEGcAe+fSizVYpHgfa6y0bjI3R7txZvpM48fTXBzmd?=
 =?us-ascii?Q?15AYcq1uHgJc1zTVpSE1CpoS6+Um1ZSOciQ8E8hPMxkN/ItGM05+K14ByczR?=
 =?us-ascii?Q?25QX/AKD9sRaYzdqlr4lkPlXrszafG0WRdqDFLnJJCh5sUJkMegTZH0rbd3Z?=
 =?us-ascii?Q?J2TheJulQRdtpadCjUvSNJBKXBHajv1UD+tq2cECNc83yhPxMkNNCOZ/04y3?=
 =?us-ascii?Q?toV6/IQBMKsA30d3B61ZFnlTNxyXRbD5GUySNA9OFwu+Py0a8GnFp5akZcHq?=
 =?us-ascii?Q?pk8dBj1ZYnD5m/o+X7sYs6fKg6s4BFlsU2TsBiTUhJKuF5CcF1WHG/Sgr3Ww?=
 =?us-ascii?Q?KWhm2UnOmg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44960a83-9f73-4bdc-4b30-08df13326503
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 14:05:27.5055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bmzclPdjcrn4IbXmIU52FBWZ1j6L2O5byNJ4ULo5o4UGXLVB2938C7QQWdymUqFZSEsMalLsOkUSEA1F+cVv9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4372

On Mon, Sep 14, 2026 at 08:02:07PM +0100, Quentin Armitage wrote:
> Commit fa8fca88714c ("ipv4: validate IPV4_DEVCONF attributes properly") changed
> inet_validate_link_af() to call nla_parse_nested() rather than
> nla_for_each_nested() for IFLA_INET_CONF. A side effect of this change is that
> the code now checks that NLA_F_NESTED is set for IFLA_INET_CONF, and rejects the
> message if it is not, whereas previously there was no check for NLA_F_NESTED
> being set.
> 
> The consequence of this is that code which worked prior to Linux 7.1, albeit
> erroneously not setting NLA_F_NESTED now fails.
> 
> In order to maintain backward compatibility, rather than calling
> nla_parse_nested(), nla_parse() is called.
> 
> From 498a8cffcdbbc3265d2a4747ba5ded6f562af3a7 Mon Sep 17 00:00:00 2001
> From: Quentin Armitage <quentin@armitage.org.uk>
> Date: Mon, 14 Sep 2026 18:19:53 +0100
> Subject: [PATCH v2] net: allow IFLA_INET_CONF messages when NLA_F_NESTED unset
> 
> Commit fa8fca88714c ("ipv4: validate IPV4_DEVCONF attributes properly")
> added validation of IFLA_INET_CONF attributes, and in the process
> changed the call of nla_for_each_nested() to nla_parse_nested(). A
> side effect of this change is that the IFLA_INET_CONF option is now
> tested for NLA_F_NESTED being set, and fails if it is not. Prior to the
> commit there was no check of NLA_F_NESTED.
> 
> Change nla_parse_nested() to nla_parse(). This restores the previous
> functionality of not checking NLA_F_NESTED, thereby allowing code that
> (incorrectly) doesn't set NLA_F_NESTED to continue to work.
> 
> Signed-off-by: Quentin Armitage <quentin@armitage.org.uk>

1. The code looks fine, but the patch is corrupted and cannot be
applied:

$ b4 shazam 24158a1c7c9d7fc28d42a0be53f3b9d1919caa1b.camel@armitage.org.uk
[...]
Applying: net: parsing IFLA_INET_CONF broken since 7.1 if NLA_F_NESTED not set
Patch failed at 0001 net: parsing IFLA_INET_CONF broken since 7.1 if NLA_F_NESTED not set
error: corrupt patch at /home/idosch/code/linux/.git/rebase-apply/patch:10

2. Missing a Fixes tag just above your SoB:

Fixes: fa8fca88714c ("ipv4: validate IPV4_DEVCONF attributes properly")

3. Since Jakub asked, please mention in the commit message that this
change broke keepalived.

4. See more info about how to correctly format a patch here:

https://docs.kernel.org/next/process/maintainer-netdev.html
https://docs.kernel.org/next/process/submitting-patches.html
