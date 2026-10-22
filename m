Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792692247;
	b=LUn/h9dkPMqjZU3TVapAQCxI3vvFRJH3SUm8es/eMPODihQugLs73WD9BlkO2JPAlhvH
	 x0hvh135qbBUu6uuNleq/OJdmG1wgSAHXPsJ6eR3SAJXpuP8/jixm0p/xIDXEMWhxBDXg
	 cV59E4uEPC83OOiSC0AU+n+Gcu1df/sDrj201eGUki4S5/i6DJF3v2lb8JSr3+xD/fTjD
	 iGHrG6FPFqThz+/+g8ADmSbE5Wdlu7oCPNQh36OuPYv7QRuzWnUw/6W3Lb8Wo8ENZB2pR
	 qaulUu0tD2ATjTU5bj6Mok9+mZ/yBP8481RiQTlVS7d6NUIuq2dyegRqd38yn2U3MOg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792692247;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
	 References:From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=5wE/ToRLvlp3zepo8XIizxGYwtr2tE6OxwdhO6jlpZM=;
	b=JCArCh7y7+vef9cJQIhSr8qGbVpGcu+g31YMd9nHcBcQu9clcyIxL0vABYzz1G3rPPNl
	 OgXCSkCGI6qLt/oyJOlh9EnexzTKph9gkC/ZjDGLt4u05r8+qCkqxUcuVK2xFowFEOYxU
	 EzM2JU7S8Bl3dibhLTyi2+QSU+NjP5cY+CzemcY24BBuAl1OQ4NfADRiu+6aE0uve7ZXV
	 nQascT4s07NVFMlyen70sdxEQZcmcvq9IMFlDVmtE+EMbskWRg56o/8+21QHTxrzbCsmt
	 iFFqE5nmbUixlQUBkTIFbjN1tk7rhpOjpoUS/TgtnaqoxgexS44ZrLr8NGVWHRIGhSw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JecGWb6H;
	arc=fail smtp.remote-ip=192.198.163.12
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A996606A31E;
	Thu, 22 Oct 2026 18:04:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A996606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JecGWb6H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792692246; x=1824228246;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=utPfeL5a5TwX252Us8MW8dLk2tko7t7qQToCxd8cUZo=;
  b=JecGWb6H5ylW15hM+u9AVusWZ0P1OYbwVJq/1WtAllw1vBk76nHrOzWv
   rxyMlPXDAPZhyOn+pBveYQmcK1iNvk4NWGr6PNPBJ3I79h+MHxbR9gN9U
   cmY8Y8u4LxclR7wAHpNHnqDyfUDEJQbHeSSNWU7AfaqMS6rqkGGCJdbgK
   TEMBsZmCdFVQGEF0pVs6jvCNkvMD5LLXXttWVl2E80qBgWZy3DMeBfgvJ
   Um8N0oOudqWKW7YKnPCZ53Y9ka3HczWc5lwBzpPCdB6F/QRhtjHcp2wum
   bEcgQXpgcGnVEeH1gzafudCpIz2auekFy/R9zQK0h0r92tROXWm/XW6xp
   g==;
X-CSE-ConnectionGUID: 7GOam7wpQxeB5p7wFX4GYg==
X-CSE-MsgGUID: WEIKT1ISTbmRH9JSa3boBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1351410"
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="1351410"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 11:03:46 -0700
X-CSE-ConnectionGUID: L1Mh0jznTYq4+4VkGEDjSg==
X-CSE-MsgGUID: LU+OEWczQnGiSpGM1buIkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="3409257"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 11:03:45 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 11:03:44 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 22 Oct 2026 11:03:44 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.24)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 11:03:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=njCYtS28JdQMobRn5NKrNeDn4c5rQGDga3fzdP0UYEfpWD09WdU98djZM20Om0vkj2yz2MIl8RgpDq7MuZR2LCIgptHwGBtMgI+uozTQh8znbf9vVoK14NPscSZ21Vbd5GrCBA1GiP7ccZYvZ78KXN2gnibD+YBRJQ+wzt4a8vW/EnoA99YhvzO+VEsKsy7eQTgK/1UlFQqCojsHjpZFMivoWBDQSxaVLkhtDlLkVDsvNsYSMf0B3QtS53iao7JE3nDtmFUtYBP3ef1639uHAAHwFQEP4NUw0FQkk2478mejjc47iFekFBfx+2iIgX/wuwXEVVSAYp9iS/PdjNreBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5wE/ToRLvlp3zepo8XIizxGYwtr2tE6OxwdhO6jlpZM=;
 b=bJsp8z+TUCxY4IROyt96/AVWTt0axFxyG69Bs4nDKp2OUJAqVCVibg31O4ZuIUkfxgs2tbbz8WIYlx1KF0kdaUNfNW/Rg7jhNWo6EUNu9Ym/MErhJBwFqdv4CuHvR2mBV70lS6OVaVM5RBgDcJuVNqS0Bq/qpkpqub066UQwDNku3ZYkknqbxtbHe8yKU23bBvHnZt5i4uTZKQUOeQH9+Jnc6cSEzKdzuBTuoqdjdtYGv0XHACRKbNPcgu71s8coIiVLeBWg/qcPKyVPTtpN+XOZaGXrFdOUFyZB/aJS6gPG1V4PFYYet82+5glT/B2pPmRJ31xGqQbAnse2uafKIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by PH5PR11MB320987.namprd11.prod.outlook.com (2603:10b6:510:500::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 18:03:42 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 18:03:40 +0000
Message-ID: <988c3316-82a6-4d81-aaef-b13e9e92fa01@intel.com>
Date: Thu, 22 Oct 2026 11:03:37 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ethernet: ti: am65-cpts: fix support for
 PTP_EXTTS_REQUEST2 ioctl
To: James Clark <jjc@jclark.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Richard Cochran <richardcochran@gmail.com>, Kory Maincent
	<kory.maincent@bootlin.com>, Siddharth Vadapalli <s-vadapalli@ti.com>,
	Chintan Vankar <c-vankar@ti.com>, Aksh Garg <a-garg7@ti.com>, "Sebastian
 Andrzej Siewior" <bigeasy@linutronix.de>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20261020003525.1237742-1-jjc@jclark.com>
 <179264023362.3135.17895429756190814680@kernel.org>
 <20261022035226.1388675-1-jjc@jclark.com>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <20261022035226.1388675-1-jjc@jclark.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0342.namprd04.prod.outlook.com
 (2603:10b6:303:8a::17) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
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
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|PH5PR11MB320987:EE_
X-MS-Office365-Filtering-Correlation-Id: b4a7d6b9-f4d4-4e39-c360-08df3066cd84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|10067099003|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: OBJS/iObnzIHHvGm1Q96Vcd+Sd/aFznNUSQqgAtaslaYTB4rDvyqdEPVdZHd0snIJCPDBCkkYER3m8C0QzYdut72ao+iMdLoIem6aZ0hYgiGsAOSHZ9mGqyXN7cw1gP7W9GuXaeEd/hJIRz5CqnXHMztTO2C63i45xffnR2uWLioN0DDhTp3zIZMwjZ6nkXbnW8eJvb6h9xgFoGNvAVFlLaNxXCxWyexLegaeYumquucgKYE/hBgJ4gO+KSKkQC4WrIupSd/5EoKW7r+2UVv/MxlCBi05HOeiSdF9Z4bhteY/+CvE9rf0j7SLIU3FW4fI4miVsgq55BfmaMbKyyrpwfjlcUVAiH3Q5wiTJW8sIfn5RiG7n4j8fA+AJXIWJ0zEz04kX6HAOsiEpjwog2gldRdeAHYpvZOJ/5uD2Thp8/r5iq9m9WJmdBX5qFvdjw36XB7HVY9L4CYSFu2uaFafJO6+7yX5iNKy74Run4LolGkiLTPJ0lMAan6tuIr+EqI0/X/DUSNaxXrG7ppvxZ1feQHktj1+X3G0hw9wQUeQtrfhEb9kym9gjj2lAIbbKlAl9ZsMvhp9kuchC8UxKCE6fUEOxbeEK/LQQaVH6rGaz0kauQ8i3UKZ4uqJHc4Z8FpnCtwRUG6nXDc74vRX/Bl++YShusyeBJpZ1xxgwHdwT8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(10067099003)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1pXVE12Y2h0UmRmZW80eFRxWElTc0tKTFp0Y1ArZW1DSXBpTHFtOU1vdS9B?=
 =?utf-8?B?Z3lUMWNsMHZ1Umh4bjFQTDRJeUhzUzEvZ1dRMldLZk5ZMzI1c3orTG1DQUNQ?=
 =?utf-8?B?YmZQRnhxVEZndXFIOU9DUFI3KzFBNDhnTHN2UFY4b21kT091REV1TUlFNjY2?=
 =?utf-8?B?M1czNlVvNDVBZTQ1R2E5WDNwN0swRHo0emtSNHc5YW5VQkpTSk1DcFEzdXM1?=
 =?utf-8?B?TTZ2anZNcmVReW9takJ6T1U2czdTUVU5U2tIZjRNM3dSYUgvb0dMclJja3dY?=
 =?utf-8?B?ZEJaUE03TmRDRi8yMmViL1RWQ3dzQ0hObFhhVCt6N2lWMDZIdk9pV2RQNC84?=
 =?utf-8?B?MUplWFVETmc2VUxJSmM3ck1vbUZiNUJUbXlFemJMb0VWSDd2amp5bm4wbVZv?=
 =?utf-8?B?VDR6LytHNzZvTm5iTnV1bFo4Y2lVeVVTeEVsUC9ld2s1d0RiTVRsZzdxWTNS?=
 =?utf-8?B?UFM1eXltcUdjTkRtMGtGSVpKTU1TVGJqdFZHTkg5ZldoaHB2S0o2eHZOYndE?=
 =?utf-8?B?am1mVm1xL2ZPZjhUeGc0YkxqNGlSNmYzRU9GcUtaN2oxQ0NNSy82Z0lsWFB3?=
 =?utf-8?B?cDhVZDdrN3NYL2dBQytpQmZWZU9xZVhHVUo0QU9jejN5anNGcGkvOXd2cFd4?=
 =?utf-8?B?VHlGRlk5QTJ1RTNsRXlGK20xUFU1aGdheHY1V2tac3oyQUJTRjYxUFVSMTcr?=
 =?utf-8?B?RVVOY3RXbG16OVNQTjBUNmsvN2c3RW5jMytiNGFJVVJOdmlDQlh4WG03Mlps?=
 =?utf-8?B?OHVHWHpQQVgzY2oyZmQzRVlyRzYrNVpQQmltZXBBMXpVa2Vwc2o3eGdzTkdY?=
 =?utf-8?B?QVFhWVMrUFRkU1dZNUlSOGFhVkRrckJwTnBnSWJjN2NidEd3bTNFMzNpNkw4?=
 =?utf-8?B?MDFLbjdOUFpveWEvU3JrOTY5Y25peHEzY3ljTUt3YVpjQ3F1OHRSVkZ3TTY0?=
 =?utf-8?B?V0I1Vmo3TkFkdWFuTWhPeW1JNWZiVG04ODBlSVo0WE8yeHMyMEkzSHpaR003?=
 =?utf-8?B?N3R6MG1LOW9UY1IwTnZ4ejlqOUR1a3Bmdm0yaGFqUE1iZlVlZHY3dDhETGx3?=
 =?utf-8?B?MHhHMld5ZlFrdkRRKzFCUUlpa1U4SGdUSTVZNVFqVGNFOXk4a29qLzVQWnlY?=
 =?utf-8?B?UEhxeEJIR3o0SmN3QjJUVU50N2FtbEg4RGw2cDlGczNaQmNVL2VBM2k1KzQy?=
 =?utf-8?B?eDlIOFJwbkdXRzJnMlQrd0hxRDFkeEVYVm5Yd2pQN2xaSXZ1QnZBSE8zSTUw?=
 =?utf-8?B?SktDTGV6MTVmNmtkaGluZ2xvZGdobkkrWlVIVWpxTm16YTZKblQva3dsaSt1?=
 =?utf-8?B?R3pKZlN6MDBRMzBmZWt0VkZFaDd1SUJ4Ym1PRytrUEc4Q0wzYSs0ZWdGaE13?=
 =?utf-8?B?WWpYMzhBd3I3elJpb0V3WERodjQxV0FIdjY4V3dlZTkzUUNUaFY2Q1dmOWJW?=
 =?utf-8?B?cllEalk1Q2JTTjlVRDBDQ29OY2ZzNWZtVUFMUzZISkUxblJNS3lsZUs4OFUy?=
 =?utf-8?B?UUErdlJMdEM1cEhDMTY2azdGS3BvZGt0b2NIWEZSb1JCSE9xQWYyVW9abDVX?=
 =?utf-8?B?bEloeEpjYU5aeGRtbDNLbkpoY2NqSnRveGh0V1lld2lzdGJLeW5wMSthaDlH?=
 =?utf-8?B?WDhwbGhKeU4xWWx2V2NDMXZGbElUdlNkM2tkVlBSOVYyMXNNQWMxWG9tWVVL?=
 =?utf-8?B?WHUvWkt5TFcyTytCS1NIeXhqbW4xNHZhbDdzSlhYbTFVYk54YlU0cHFCTXBO?=
 =?utf-8?B?c2d6N2g2b0lKQ3hZODhIbzUwWDhMQm9pK1M1RGp4V3lrVjVyZVNLLzA4ZkdU?=
 =?utf-8?B?MjM5SHZXNFBvY3B6cy9NZEc5TGttT3lHOUJvMStvZGZMQ2dZRFZUeElaMk94?=
 =?utf-8?B?YkVhYiszU3oxWlJwYlByQlVDSkJ1WWZpTDFYUkRlc1NsMzVYcHM1N2U2VlMy?=
 =?utf-8?B?bzEybDV4Q0tWZXUwUDJPTUQ1VFFIMW16eGNobjAxZGM1aU9rVnE3M2w3aVNq?=
 =?utf-8?B?ZmlNZXdrT3MrWVFmdUpGZ1lIYzlBZWtBb2RqTTRpYXBXckQ3SHFLVVJtbDVE?=
 =?utf-8?B?M2FETHBMYUNoMWU4Zmo1NldIM3NMTHJxRVgveG1GNUxibkl6SVk4TFlzREFw?=
 =?utf-8?B?Z2dZak43L1o1eVN6T2d6VEdZbmtFSi9DSUNNR0tpU0ZiS1d2N0FsTWt3cSt4?=
 =?utf-8?B?Ulh4UWpGWXRlU1Z1dGJuQ1NGWHA2TmxNOXV6L1U3RlR6VzFXZkZxcXVoT0Fp?=
 =?utf-8?B?dU03OGJSeml2WDd3Wmo4bDlDREFnZ3l6VFg5UThxVEpHcm5LaTRTdk8wemow?=
 =?utf-8?B?SmpqL1R4NnZyS1BhR2ZzMWJwQThwSVFOaXVnTDA5eW5EZmorY0M0VU5NUGNU?=
 =?utf-8?Q?tHY1ODCngErpL42Y=3D?=
X-Exchange-RoutingPolicyChecked: 00kxQoaH28E8pK4f87qK6Mzy7Kz3Bha8+TT/DhpKvHjhHP2Xo7gYkVc/CwUt0fH7kTtuZxvjEWCU+vi975SZpJ2+1qdnb6pN9Ye0YHvGUFmfcqZpm8Mrfxom6kljzxTivHAvKjcH8/9lm5WJ+C41yPOcpmEmcpKL+bnLZX8zCeVU6AM3FNzfn42PaUt/NxOF673S3/0Wiki+nQ1gtTZaQ2EJYLN6Wq+EWRdO1OmfEPTglRD9gmzQ0+TMMBg4ABYP8lGiGssmJgJsEnnj8c7hkNKQQNkuQ+QC69pwItHt/romS6N5P10Tylf6lKqeouFoN5kQSS46pV7CF9Auqhdcyw==
X-MS-Exchange-CrossTenant-Network-Message-Id: b4a7d6b9-f4d4-4e39-c360-08df3066cd84
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 18:03:40.5719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /cQSEAcXfyss7QP42BYkojVS5gYNa/vJbeumFWF70cI2D2F63VmGp3NrWi7iXYkJCYX5LLKkRIbgaLemhR0B3xOEu3vgiSQHIKSjZ9aSngw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH5PR11MB320987
X-OriginatorOrg: intel.com

On 10/21/2026 8:52 PM, James Clark wrote:
> On Thu, 22 Oct 2026 03:37:13 +0000, netdev-bot+sashiko@kernel.org wrote:
>> Before this patch, supported_extts_flags was 0 for am65-cpts. A v1 request
>> with PTP_ENABLE_FEATURE | PTP_FALLING_EDGE, or with both edges set, was
>> accepted and reached am65_cpts_extts_enable(), which ignores the flags.
>>
>> Now the mask has PTP_STRICT_FLAGS but not PTP_FALLING_EDGE, so those same
>> v1 requests return -EOPNOTSUPP before ops->enable() is ever called.
> [...]
>> However, the commit message says:
>>
>>     Only the PTP_EXTTS_REQUEST ioctl still works.
>>
>> This suggests v1 behaviour does not change. The patch has a Fixes: tag and
>> is likely to go to stable. Could the commit message say that v1 requests
>> carrying PTP_FALLING_EDGE are now rejected as well?
> 
> The sentence that Sashiko quotes is part of the paragraph describing the
> state before this patch, so it has no such implication.
> 
> With this patch, PTP_EXTTS_REQUEST rejects a request for PTP_FALLING_EDGE
> instead of accepting it and reporting rising edges. This is part of the
> purpose of 7c571ac57d9d. The equivalent bcm-phy-ptp fix, 3200fdd4021d
> ("broadcom: fix support for PTP_EXTTS_REQUEST2 ioctl"), made the same
> change without mentioning it.
> 
> I don't plan to do a v2 for this.

Yep, I agree with this assessment.

Acked-by: Jacob Keller <jacob.e.keller@intel.com>
