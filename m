Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010015.outbound.protection.outlook.com [52.101.84.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7054BA1CD;
	Mon, 28 Sep 2026 12:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790597122; cv=fail; b=qhYsEJS/pUaZdhe2spT0neZCmk+2EXgtWkNlV/0doWbBtHKANpVUjm5v4y7f8khncoIzeWe9HL5cg89NNqEq9vqrlSv9bZBMWcyVtfOgjfHx9ogzHhqN+obs4WZPBAHclj9wr1VE8pGyzV9rYrZ6m0AmQag1j5Lytfsblz5Zp0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790597122; c=relaxed/simple;
	bh=WmI00m8CalFN9TahTJ/mE3uZpxoU9d93oI0e+BCykns=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=HeUgnicAw+7JaE7YIaNFDQEbZtvKp45eljDE/R8UTnIuo8XSla0+XXFNwjfckb6D+1iKxb88onoLOf5/VpiSlX2dTWmGk8ulEarCK4a26xpArlzuBcEQfm2QF9p9m39oPtkbqEqymoVhrFNuYbzquM3LaIGtlK6i9qYeIaT4qwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=cOPXkPub; arc=fail smtp.client-ip=52.101.84.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="cOPXkPub"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gf7FbCCQ78QeajbIlGkvOve4wVkaMYeVrpUpgL2b89RQmoW61gMAN4lpp7eoizAgBOHUch2IqEk9PeGPbMz0fpT5XpRxsmuryMHRbdSV1A0gHUjwBOeVxC23XgCkEChQ3VyNUluqTnkLowA9T4e6nkpTI5k1iokWsv+0Eqcb4e2IfcPyNcblQBtvkWHmI4JZGv1Pwgvt1X1qCuDR1hUo3+Y2J05fK0T7s+BvSlPUrXh+oFlhjGSyazy/yQiX2sgRRlmPRJTX1PzIoFvLbMnlOcF/kvjNkJkyXxE1MfSdFZReAkjTHQeRitosWL3cA+s8bC/xCXyOQRgrBfkC4PvwgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nokt0XJRN2+T+131qPoS12+01a2qFEAM3m08xG7EIX4=;
 b=WlK+myXn1lgTHbMw/qP8/x69n47+2Qv2Q33f/lyF/h92+U5jFayBAijqBNz88/r4aQfsJnNAiYISAuLp8rW4kkRqxAEprifITnORQv9tzJCFOKBhdrqvwp5ulOSzAZ2t5zn3JQIr+aCjVZdvkgU5tC2UKotpURA8V8jylLoyWEOzpd6IXdGuKgT4G13Jat41HQC2xw7cysna4kYg1YuaypFftSgMc/+jQEmbG+y7PmyYMBYVU65UvTr7OOR7IBlxRgpv2P17CEVna2yRT8CjQAzjcLHb3gsQxXLRQPbqSBf5GBka5KTwWpjjIZG0OCbYK1YLUGOk9USM+QLEKeGk5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nokt0XJRN2+T+131qPoS12+01a2qFEAM3m08xG7EIX4=;
 b=cOPXkPubxIPaQqpc6m/qQwccShrEEJrqK7Q5lFC8q/dyh2LhryVFm5K9icLBCLhtXm8//dpjjqWqVs1rKk+Fs/mE8pdM+hSoEQL0yfg7HjwC5LT+K4JTh9FioeZTok/zF6h6mQ8BFIaeIt5UHrArZlkIQEFLRqXT4OoVq7vqwWg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from GV2PPFBD14D17F4.eurprd02.prod.outlook.com
 (2603:10a6:158:401::5df) by VI0PR02MB10536.eurprd02.prod.outlook.com
 (2603:10a6:800:1b9::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 12:05:16 +0000
Received: from GV2PPFBD14D17F4.eurprd02.prod.outlook.com
 ([fe80::9ac:6f90:5998:69d6]) by GV2PPFBD14D17F4.eurprd02.prod.outlook.com
 ([fe80::9ac:6f90:5998:69d6%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 12:05:16 +0000
From: Henrik Grimler <henrik.grimler@axis.com>
Subject: [PATCH 0/7] ARM: dts: artpec: cleanup with the help of
 dt-check-style
Date: Mon, 28 Sep 2026 14:04:46 +0200
Message-Id: <20260928-b4-artpec6-cleanup-v1-0-e3b75e10acc6@axis.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN5XumoC/yXMTQqDMBBA4avIrDuQRgnaq0gX+Zm0IyWGJIog3
 t1Ul9/ivR0yJaYMr2aHRCtnnkPF89GA/erwIWRXDVJIJQbZo+lQpxLJKrQ/0mGJ2DpvWqGlMoO
 DGsZEnrdrOr5v58VMZMv/BMdxAqdhyap2AAAA
X-Change-ID: 20260928-b4-artpec6-cleanup-3dfb30a26b9d
To: Jesper Nilsson <jesper.nilsson@axis.com>, 
 Lars Persson <lars.persson@axis.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: linux-arm-kernel@axis.com, kernel@axis.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Henrik Grimler <henrik@grimler.se>, 
 Henrik Grimler <henrik.grimler@axis.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2677;
 i=henrik.grimler@axis.com; h=from:subject:message-id;
 bh=WmI00m8CalFN9TahTJ/mE3uZpxoU9d93oI0e+BCykns=;
 b=owEBbQGS/pANAwAKAbAHbkkLcWFrAcsmYgBqulfiFzHch4UdryP5wqfyVzY08FcRgygj6J54P
 F1wWfpBwxCJATMEAAEKAB0WIQQsfymul4kfZBmp4s2wB25JC3FhawUCarpX4gAKCRCwB25JC3Fh
 axMBCAC3MvJEV1qhfrmfN18doBXkKsdhFGqW2BDPfy2I3CaqoxVmmprW5rR6NiwBBeCyDPc7a1u
 dG9uWlV3UKfC28rBcQBCRDM94ayetgFH9iR7AqfhA/4BwhNEFASwX+2ic9Wf1W9p9g0pWs64Ne5
 yG2KPRk1j5MFj1O5REhK6EJhhRMGBjicNEssWD3/0k+3xABk8FWo2MrduHI6v/bRWJPs2beU2Ty
 QFk2G8YDRwNx9DD5V+aSbd57dLIi8NgKWILuZ2uQZcfrKLO0VJIS47XDr9ajyga+iEoYUGPVesR
 DN8csBjE/4etNA9chfwYUXz6+ogdqt3mHk7FVq9HAtWNQjwy
X-Developer-Key: i=henrik.grimler@axis.com; a=openpgp;
 fpr=2C7F29AE97891F6419A9E2CDB0076E490B71616B
X-ClientProxiedBy: GVYP280CA0043.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:f9::18) To GV2PPFBD14D17F4.eurprd02.prod.outlook.com
 (2603:10a6:158:401::5df)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PPFBD14D17F4:EE_|VI0PR02MB10536:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d4d7ea3-67c2-4139-0a16-08df1d58c1ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|11063799006|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	hsWrzpd1VYdURvhR74RkjkXClVL81TpAM4AcaP19TBmEJQwJAB383DAohEZNkOFTz6ACDxvcsC4OSpLY3KynuiOBVE3kZqeFXGR9JuC0Z67whUAe2/8p7c6CMRwLIyjY1X3W3rTXeCeU082E2XiAfqRwceOFaER4Wx6xgLSyD5i1mc7xAJx1VcAM4VwlcGK8qOuJTP71A4G/wOKCgU0uzyadTRwPHq+C5XPZ0/RjmEFq9ruo5K6uYmvEJWUQglninaPspt+yLJofoGGd7WVkIs+DAdjO/w8rInOqWXxN0FcWY9zc6Lmq0bpvLYoWK8qAZxpZXWk3sH0zykF90yhE76Dp96wjuOWq/frXo1CtL/KZx/+TzmX9aodhCePCdhq6sVh59XAALzkW70e7DYXaXGdntyFOlmwNsCLkqkfZ0m5PQdfzXzPwwWe71OhA21y1N1EausMy6vplpc03FfwxWDdnXGETpYc2WIyUIFKz++F38QgLCkrGrDZKwTmqbl5CcDjxEX5gkrdLPal7D921bfVNyiiQFOvNZaTd7XW9i1E++lkdgUatyWLj9Xk0x8VNUSPUTepMbFfmuJ2UfXC8AXSE9FVhm6yMUdEyxH/6KVfWm/Aaq9QGruJTt5jltIkuiITfnb9GZozcPPlbhvFn8ESjFt7cdyYF8tZK87O2hV8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PPFBD14D17F4.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(11063799006)(56012099006)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L2NCU1ZlWFNDQmsyUEpUSDBjZ0lKK1BrK3lEWHBacVpPcVhjMTl0TWMwU2hB?=
 =?utf-8?B?M21XTXJyQ0lBNU9QM0R4cnErNzlLWU5XUlhackQ2aTFlTXFncDZVQ1Roelpa?=
 =?utf-8?B?TUtBMkwwcDkxeDhubnFrTGV1bUJSNGwyMWhqSzROKzNtamtmYkl2L0hicjVE?=
 =?utf-8?B?TzJyczdReUZkSGQ5ZzVkSUZlZzJGbzBTaUk3ZHVDeHIvVlA2Uy90cjJDOXln?=
 =?utf-8?B?ODhCYmJxbWZ1aHBUWnV2L2ZtZDN6VmR4eE53d0NzbUN3ZGxnczExL2x1TTV1?=
 =?utf-8?B?cFNWMzRrQ1M4N2w3Q29VQUh2d0taRTUzVXhZc1A3ZS9KUjZYS0VVQXBJNnA4?=
 =?utf-8?B?TzltYjhkRHgyM1BrL0ZQYmpDOThSU2dqUkVCNm9SSHhSRnJ3U2VsWXVHcEVw?=
 =?utf-8?B?UUdxZDZHRTNoMTYyZUJoQ1pUTGJNUHdBemloeTRYU1VUMmplRjJSb1MyMDl3?=
 =?utf-8?B?M2NLSnQ3TVZGVHZidkJROHB4REtabGFpZGpBM3d1cHAvR1h6YzhhWDBsdCtq?=
 =?utf-8?B?cVBrajBOZWRudHNiUlRKaHJLNGRZRG94SUlMRlc2eVJPT3g1MjY1NTVLeVJE?=
 =?utf-8?B?TitrMEJ2VldYR3NZN1MwV3ZLSEM5ZURML3VhVmgxelpPVGpCc3hjTGEyOGd2?=
 =?utf-8?B?NENEMm9HRFpBUHc3eC9odkkwUVhHV0RPN3ZXUG1lN2pmZnF0dlBEOGR1L3pr?=
 =?utf-8?B?cUpjWCtxdWRQVXhGeHlrK2ZFTUFOVk1XTTUrd0Q0dWhIK0JuTG5uUHhLMWNq?=
 =?utf-8?B?WElMdGVzVHFqL1ViR0VBbGtkanNOSytiTTNKT1hRamxlaXhwZ0MwTm4yNVpq?=
 =?utf-8?B?WjBPYUY5em4vVVZtcW5UcUVFUjBPRU5ueXRiQlYxK0h1U3NCMUVSb3Q5dDM3?=
 =?utf-8?B?N2Yyb1NJZDdUeCtiLzBZUXR5Uk0zOVFyT1hzRjhkMHh1Y2U0NFVlYkxGODlN?=
 =?utf-8?B?Y3pPdUNYMkhCb3RHcE9SQXl3NFVGSzdqemdGL1J0a1cvLzVHcXFQY2YwVXNk?=
 =?utf-8?B?QUNOaStZQTlyNkRvZXlwM1Nwb0ljdUlkN0kwVDBsNU5TZWNmMWFPdU96aHVS?=
 =?utf-8?B?TllkV01RTlBBN1JTdURudjlhZHYyUjNEODBWem5waUdiZktZMitwTEhpRWRL?=
 =?utf-8?B?SjJndnNEL0sxd0NENWFYUFRPOFNLRGFFTnJrcXpUVWk5cWo5MGZoL0pyVWh4?=
 =?utf-8?B?b2ZGYzRRaDZMSHc4N09qREZ4a0xoMWJ3VkhxcHVjS2Q5anNVYXAyN0JEcnEx?=
 =?utf-8?B?SWtHdnp6YldJVHdHelJYdHRHR2QzanE5ZnhHdm94RHROSWFUYm9TTGhpaWlN?=
 =?utf-8?B?VncwNEwxWVhTRWJWUGU5ZGpGQ0t2K1FtclV1NGpOWGhjWFpoUTkya21ubEVm?=
 =?utf-8?B?bnRLMFVScVJBR1pQbDFvaEd4VGpMOHUwK3V1WUpobHFNdFIxREw5WXlsUzl0?=
 =?utf-8?B?M3Q5NmVvTEthME5SaXdYOU1vN0JLU2FrR082c3BYWjlod1R1L3VjZldzdS9U?=
 =?utf-8?B?YkJBV3BSNkxpcnVBc3QyOHltenF3MXk0NjFuWHFWN09FRzZ3NHpKZ1lEY2du?=
 =?utf-8?B?MGpHQnBTd0dzRGlhUDB1M1IrMFdDbVJha0phT3UxbXAvMHFFcWxiYTFCaE1w?=
 =?utf-8?B?dGFBTGZEMFY4K1hwZlBybG03Z3RGLzVqemIyY0wxTlZkaENRUnpwRlJ0Nkg2?=
 =?utf-8?B?RlpkdHc5VCt6ak9aSEVpZXQ3bDQxby84WWF1eVdZL3RxMCtvbWhOYW1nSmZK?=
 =?utf-8?B?cmRJVm9kelEwMVhjakpISzVzTGZzNFQzUnFEUTJHMmg0a2RTNC9KdG5lL0No?=
 =?utf-8?B?RThCZGFnVElhdWFFUnBnUW9iQmxIVEFuK2tTSi9CVjJ6MFdtakRXdWw1RUFv?=
 =?utf-8?B?RjlKdXVYR1owNmFSQWZqZWh2Uy9LL0NiNnlYM3ZkeHZjcTA1Z0V2UUU1cFBM?=
 =?utf-8?B?TXlQRzVrOGlnTmxPdHFHRHJEZ3I5UENxdHF2OVUxTWMzUVhxdlZYN2VLMVZv?=
 =?utf-8?B?bzdsUXN0L2xMdzdBdWphMEZvZFlWRUx6M25zWHc4bzBTNWVsSU5ldUtkR0x1?=
 =?utf-8?B?NzB4dXBjZVVhYVRGREhvL2tnWjFJWVlYUDZ0cDFHM1hvbFI1VEU0Z3VZNS9I?=
 =?utf-8?B?QzZOYkhOSlVCOWMrY3hxSUpjQkpWeUNVeWFSK01MQjdrZ3UxVitzMys0SWZB?=
 =?utf-8?B?TVBTa0JrOXNjT2o3bkNOcHAyQ3BPRGxpNEJjbWhxVmhGd3RDKzZWOWhjL3lz?=
 =?utf-8?B?OFE1dG1WMDduK2ovTDByMDF0VDVFd1ljeGIzQk80MkJORGV4bDFtb3ZMNWFz?=
 =?utf-8?B?Zk1zbDdNeGRYbWxUb2ZOTzVldlA5YlNkeGR5RkltZTdsNHVmblh5Zz09?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d4d7ea3-67c2-4139-0a16-08df1d58c1ba
X-MS-Exchange-CrossTenant-AuthSource: GV2PPFBD14D17F4.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 12:05:15.9279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9FOnfiMbkPUMsbOGOUK5So7LJutfmtNg5vItxHekHAUJ3ZmAA62B1Of+bQBD+1aHPFolpu4gc1t0Kl64VC8LXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR02MB10536

Fix most of the warnings that are reported by
scripts/dtc/dt-check-style, to make the files use the preferred
style. By doing so the files become easier to read and maintain.

Sorting of nodes have been left out from this patchset, as that
creates a huge, un-reviewable, patch. After the patches some warnings
remain when dt-check-style (with Krzysztof's recent fixes [1]) is run
in strict mode:

  axis/artpec6.dtsi:77: [child-name-order] child node 'psci' out of name order
  axis/artpec6.dtsi:80: [property-name] property name "psci_version" is using discouraged style
  axis/artpec6.dtsi:82: [property-name] property name "system_reset" is using discouraged style
  axis/artpec6.dtsi:91: [child-name-order] child node 'ext-clk' out of name order
  axis/artpec6.dtsi:97: [child-name-order] child node 'eth-phy-ref-clk' out of name order
  axis/artpec6.dtsi:103: [child-name-order] child node 'clkctrl' out of name order
  axis/artpec6.dtsi:127: [child-name-order] child node 'interrupt-controller' out of name order
  axis/artpec6.dtsi:134: [child-name-order] child node 'cache-controller' out of name order
  axis/artpec6.dtsi:163: [child-name-order] child node 'pcie' out of name order
  axis/artpec6.dtsi:233: [child-name-order] child node 'amba' out of name order
  axis/artpec6.dtsi:292: [child-address-order] child node @f8010000 out of address order
  axis/artpec6.dtsi:314: [property-name] property name "snps,wr_osr_lmt" is using discouraged style
  axis/artpec6.dtsi:315: [property-name] property name "snps,rd_osr_lmt" is using discouraged style
  axis/artpec6.dtsi:324: [child-name-order] child node 'rx-queues-config' out of name order

Fixing these are left for the future.

[1] https://github.com/krzk/linux/tree/b4/dts-style-checker-blank-lines

Signed-off-by: Henrik Grimler <henrik@grimler.se>
---
Henrik Grimler (7):
      ARM: dts: axis: artpec6: avoid _ in node names
      ARM: dts: axis: artpec6: align all continued lines
      ARM: dts: axis: artpec6: use multiple tuples in regs and ranges
      ARM: dts: axis: artpec6: sort all properties
      ARM: dts: axis: artpec6: add more blank lines
      ARM: dts: axis: artpec6: put inline comments on same line as entries
      ARM: dts: axis: artpec6: add empty lines before empty queue nodes

 arch/arm/boot/dts/axis/artpec6-devboard.dts |   9 +--
 arch/arm/boot/dts/axis/artpec6.dtsi         | 100 ++++++++++++++++------------
 2 files changed, 64 insertions(+), 45 deletions(-)
---
base-commit: f5f84daefcd92d7a630066635ecea1433ed5eac7
change-id: 20260928-b4-artpec6-cleanup-3dfb30a26b9d

Best regards,
--  
Henrik Grimler <henrik.grimler@axis.com>

