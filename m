Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012030.outbound.protection.outlook.com [52.101.48.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D146B481FCD;
	Wed, 29 Jul 2026 12:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785329065; cv=fail; b=Tup7fybSrbVIEjmLEXKz6SaJQoj3RVL7Iwx+iFuWPTyKK9U57Zd42DlPBM5DiNo3HwECbvs0LFst7igkLxEEjcPZ4uwgUT2VctogkHTQs1QkxNffqKU+PsD1SkxzLbUPkTZFpf1m+z0zlV+HzJGjbEoCDkeRRQwOwLeMMRlqztI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785329065; c=relaxed/simple;
	bh=hZatOBow3+ukWJjRr0bzDFvXNVBS0KVUJ1Ml9Yl0sDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YXrjYuImcn2QdZH06uZa56famkhanAE+ZDbQW0o1AZE2Z+OZ5KyRbhyzuPwFSRUw2tgFrk19IbSH+dQavMFxjXthkjEkVfcZf5pIRowLqygIk5hC5d8sAy6ZqWlo/QNQhjXjFVNsysFk9bYcA17JeBw+98tc9Y6+g6XUTwWoX6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p3BY3kfP; arc=fail smtp.client-ip=52.101.48.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p3BY3kfP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bfc4h271GGKbfeSKznEJXHF0cR0gzxXYvmaDkQeXnkzatdUV08fAlHx+vyzq0Ctu7X8ZKHlLXb+AtJLilZK94uOX/q0L63q0D4Wy5iyYN9Tv6u1j5I+rkElN+3l/OnTUZ5BZyDp1i07IthQJ5kxJPQ7QZsNr4mORRK+GciuTmFRNRnySH9DnfyLXBdU4djgi+kbDSIrkNCf+Zlh2HFcDxxnCkZ6cKyUcLWBwMRfpjQN3v6GK1XvTC5U1VHEBM6aQMA+mXQAVApmfGGGZmGOJmaCSOz8vDxyzbt32i2Sc/6YScURgyCxgneRz+XfT47G6rpm6rvikpGlk3wGW9RQSgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qvc5gv3rgWPOWWinPYtKQ8yVEqHn9PiQOw9xGFPat6o=;
 b=nv+8AkCOTZrdq2wDcFAS0q8e0bNssXYpoMikLfo67c7YkqshU6EZT/i6SBKBhGit6Hmh/uRdHLkzo/OXTGPj+OPnPsQ5UpX1CPXWc/dA8wKfZ+STh1d5NFm2LS+jNoiliwWd2kYxYvYvxPzUa5zKRhxfFmWXvjwe59eI/jUxgu8LNc9BV8ljJen5KxbqlhcmEBECHm+RncP4jok3gP7I8MORe/ZzJHics6kvQcbBJNLKqGRkXh21MXqavXflZ0NJ3+6/i2apridYvV9hh/FEdLALDVfitL26c+52/vlTs2TSGOaMgy4ap+fvgMHlyPoKuercY1aeS4ciyiUbgJV06w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qvc5gv3rgWPOWWinPYtKQ8yVEqHn9PiQOw9xGFPat6o=;
 b=p3BY3kfPpipMEru7zMc8KJiJIuqwbVTyJqrETydZ+eomK8kig5Rv6YrhXwqUuNTJO2khThGvXnXXxXkhjVOuj6q7948RrUaYKrFhKVhCrGvJjtZuJ5+b0eTmLO714UCNmJtaCRmLKg0bJOC8PbLbrYju7erqX8FXFh+KrDBNi11XFlORiujBrDnZvCMVVYYKphNE6OP0y4H0hFkjY0uW3fT/QXg/OlWdLdKhLRgevDMCQf0Clan+HMhMvhKo997MFzwaRJ/j+XprhSMT6AZLY7AGGC9oznwT+dxNRD/NGKqRKKqBoZa7A6ulP/3bFUHReHZABB9wAsD7FF8ogPxxpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SA0PR12MB7075.namprd12.prod.outlook.com (2603:10b6:806:2d5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 12:44:09 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 12:44:09 +0000
Date: Wed, 29 Jul 2026 15:44:00 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ipv6: release fib6_null_entry on subtree failure
Message-ID: <20260729124400.GA1365523@shredder>
References: <20260727185339.1545169-1-shuangpeng.kernel@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727185339.1545169-1-shuangpeng.kernel@gmail.com>
X-ClientProxiedBy: FR5P281CA0032.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::6) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SA0PR12MB7075:EE_
X-MS-Office365-Filtering-Correlation-Id: cc15ea2d-d3bc-467d-c4a0-08deed6f1564
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	EoRA43kZFRzQiuE/ypXbXn7WA8T8+Ho7YPeUYT/8Yl/8Fmma8bhB5n7DcURO6PtwI5kFJ3tJ/evTc7GGQ1Pwl0OCF4FC3J/NzN21i5Nuuo4xVhAo6pHXM8ccg3pJ7VufX55jQ6mBWXwH2STi7n/op0Pqwl8u2c69hV/R8qBL8/CD7PpbTF5BdNCCRlECaooW6KGyOab8CtF201gvrHi1Q0jZK3egVKZpDfShUurf4taMRi2Gnfd87Y1dJdQSi05n8T9OeRqmDa0dZUV8UpGsZvU8QJVRcapqZUiwKeCyN/gqb/X7riWWhAcIA13zbDbanBavsHvicgQWkpPDM+D496tylCP42VGZKFg5RCa+dnbOO5NhVhoD1jMwv2BZGJNEARusV7AUK5houlM95O/ZybrHeiTH2L+rxJVtEEtH3lhfIERnoe2BpGD6VUjTLw+FQCIseaxXBkt+4fXwePsy9afj6jlrWeXbCN7a2maWFuAVduvpN5tocehH9LYcG9TWFMjC9Ej19D2ARMEsx/Pj1aKAc8Zph9BcUj5Bg+WXBAJyyk81SKMxoNXs9tSxIMyH927MBF0QWB4G5uWirjcupbmKTjc0Z1+CMk4DVjtLG389XXNGAkA/HOqE2WYSWuAsja/3C0EyeWKxJ1LxNNP8x+jBsm8R9c+f8kNQ4YH3REE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JU//mxCgBw5BNesGFUwSjA1MmTE/LcOeXx4O/g575eQO2CCW3K4sD5l8z8Hz?=
 =?us-ascii?Q?UmvLVcsLxoubNOdxJeeCu3/KVw5Qf/qZODN9/7yTePgCOIliqVFeixNI4iEm?=
 =?us-ascii?Q?zGKPutj2Hq0y7PJ/PW8AOaysoq2edSnRI8MMC6Tw5yvFg4iVOekCIwmKczEZ?=
 =?us-ascii?Q?f/Iyo95ljrPtRGEKgk8ojh4OtrhndXPwBFq6DcSGmkss6xx4XtiVeVrfhMO8?=
 =?us-ascii?Q?mR5eX33hsfKkXLP6CpA2bu6noNhoxLXCHDs3yj8q+K3NmS6akMNo4SVveFQx?=
 =?us-ascii?Q?qM3ynhhKauuql+HgUTbXGttJVBmBhrr+lVmNkYHWvHyuoRIQCjkb8HfX7tVF?=
 =?us-ascii?Q?SGYA1M2vF4OyQJR+56WNCn1x9hiIOK7i5Mds152uzmqHbU9sH4/mvUweM916?=
 =?us-ascii?Q?IboaqaZM3pfg5+jVdh15vAEM07Oc5WWWAsTZp0wrdsDvqCDcyX6/3tZK4y0Q?=
 =?us-ascii?Q?CHSoAo7u2ki/HsRnDFSp5DYT7HsWzeW4kWNiemU3W7zBwzi/bOWLS/haYa4S?=
 =?us-ascii?Q?ENIZpRYf4d9KApQ//jYlK6aSjC0hKCHM3TWeIfUz7/l7QBE4bpbSVRKR4TZH?=
 =?us-ascii?Q?sywKUoOL425pgKcBl35b6PQRnazMdTjFI0VNcn/nc/H9owBCBwQqLb2ovesJ?=
 =?us-ascii?Q?pXlpKjnsg1aUtN9cOydZAPcYMlgO6t0g36dwvVo3Vd7WUotRPiW5eyRVpfCc?=
 =?us-ascii?Q?n9woj2Zb8l/rCbNQ9ZawMuxMIUv+TROBh5O8FS5Cjwce+DR28KIgEG4GY7Gx?=
 =?us-ascii?Q?9J5z+u/B10sjE0hnTJYM8kb/YmUwqyS/l3nyI83MReD6CbFMJ7GWrZlqwwQk?=
 =?us-ascii?Q?q4fSlh4gxlxlMLx129StPzPVY08/FEKQdpBTyasnfO1aw6NjPvqLLU79DdD7?=
 =?us-ascii?Q?Q5HrjsL9J+7OROUCr0gyYg55QZywk//2QJp2Ff00kgzi6PZSjLkabqYxoRAX?=
 =?us-ascii?Q?BnvfaEESZSZCgcZ3w7ARSzrWYned9W328kpQvmVJrDMxfKQNq1+JkE3iecMF?=
 =?us-ascii?Q?LrufQPm0DbKXPt6/YRO5rpaiIAuysk+G1O97tKGNFb7wfGDtLEUaaM7Y6VFc?=
 =?us-ascii?Q?kLVILg/WMVee+CUr+qp8S3RZZINiaEYXJYdolzuyarHVVywrcrsyh6RYpi76?=
 =?us-ascii?Q?Tn+sP0W8v2+GqGiQEp1fXfaQjINkxSqcvJVdNQf+2uLf2eOSwLhc5KXRShAI?=
 =?us-ascii?Q?thU6jNk+h9TGouQd0BdsVTZLSavOmRzu9QTs4ITaEhoYSyhKB/lytX8AAIB7?=
 =?us-ascii?Q?ZbkliOSkhi5h3qE1XyFIZqOFxmPw29tBr1Bns7zIuAlb4IjrmSByGjno/c26?=
 =?us-ascii?Q?Addu+g4W4CrJYlqzU0dKIJstSGylJvHyMU5tk/mkXMA5ulQO58IDuCLARfjR?=
 =?us-ascii?Q?lZjTFmlkZnxc5lC281NWU/bes38sVDC/zYfzRdMlaLsqngI/Ir8Cfp6xeiQl?=
 =?us-ascii?Q?UWJ9Vd4r2lHeqDnvyjl8ZTooDmByHIei+qaI6nVcqCRf91djTmIXvJ5XRLgs?=
 =?us-ascii?Q?vvhlkBDNACZfUV9PPaE9KpykCsDHEz5eWKG6upbRgLMJ1e5l27F30gc76WYG?=
 =?us-ascii?Q?RJU/7/woNKKe0Jgta0NFEzjt5ymhn2ZVeqFaUYP/A9GHXbvHFltcX0iTmPOb?=
 =?us-ascii?Q?i0kojbUwMVsc5PseZ45hSyd6f3tP9TzlKFrpPssnMlr+tT/SBw5v0rFPVoJT?=
 =?us-ascii?Q?pOgshmmazX0HYYljKMvCI4TouiyxDaRHGclC/t5SgHMydejS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc15ea2d-d3bc-467d-c4a0-08deed6f1564
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 12:44:09.0375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kYWmiCgeE3FCdiGQNbak8XXGPhmMK/op/UVZQ0sze1MjozWfmA2U1j+Qinxqh0Vtf83w+RpKI6EnbCwrztN6UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7075

On Mon, Jul 27, 2026 at 02:53:39PM -0400, Shuangpeng Bai wrote:
> When adding a source-specific route creates a new subtree, fib6_add()
> installs fib6_null_entry as the temporary leaf of the new subtree root
> and takes a fib6_info reference for that holder.
> 
> If adding the first source leaf fails, the code frees the just allocated
> subtree root but leaves that hold behind. fib6_null_entry is a per-netns
> sentinel and is freed directly at netns teardown, so this does not keep
> the object alive. However, it leaves its visible refcount permanently
> elevated and can eventually saturate the refcount on repeated failures.
> 
> Drop the null-entry reference before freeing the unlinked subtree root.
> 
> Fixes: 5ea715289af6 ("ipv6: broadly use fib6_info_hold() helper")

Should be:

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

> Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
