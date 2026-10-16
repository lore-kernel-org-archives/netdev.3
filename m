Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3187130EF89;
	Fri, 16 Oct 2026 00:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.129.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792112149; cv=fail; b=VwQOXESu6oEu+bTYcYmiLodtIBT2/8rWa5F6EzCztddSCtuqFxtkWDTYwtuGt7TR8oFCErozNpo8YFlna3XEG2o+gpvs1RKdj8bIElsjaM3XsbUvfjWdtmdNL9I6KkqjRwJdOR5tlxmCd/RPe0lsNKkzhPnUhi/MHDekURWUuzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792112149; c=relaxed/simple;
	bh=nM9LfiCV6vUo86MOEQT62ahnyen3lSpLZI0oA4tEmwU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BibXyV8OVIjv2p0SxCng+lY68nGAABG7IFPRnxD0sSIkemDKHspJboqWUmr7/P3RisBNnqx5Jn3kIe4FXkWsJaACfsmCwmKQl/ZH5s4eGoB6xzD9iFbzOU+DGdhClYteQG1Kza3DeAx4DaMnGd3OeFTCRHAyFYZ4/iZRIn1H3mA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=nW/j3HHm; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=hX1B9fq4; arc=fail smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="nW/j3HHm";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="hX1B9fq4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=nM9LfiCV6vUo86MOEQT62ahnyen3lSpLZI0oA4tEmwU=;
 b=nW/j3HHmOcA3E/4//VGrWmEiy/E/pvB9/e3VNmBmhTBcso7NA0WTrYZaQnM5vHZidGyrPHP3rFQtk5pD6nJ49Il+F6F0Vf/bYMMzFwRrILdv/mXTcX5dVCGnEskYryZAvja+5RZWoEPzck09d6mQPhd4QsQb0boS++AYhK8NQvy9vT22hW6hYq8v6lgcV6KsOXDiixX7Eu5lO0i90RrLMpsbXJfNOUbUmr0tXBr5ky8xA+qqDhe6yLVpX2dlhUUGulD7hqjQpGAZ3QyuDgssc5l8s6nK1XO5S9EAirCYqtqMd24/6dbqtXDUUXZr+rCWbmTj+y4V0HxIDxNTl4hL4A==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11020104.outbound.protection.outlook.com [40.93.198.104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 4C692C006C;
	Fri, 16 Oct 2026 00:55:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bkgbBytOMsKOLQ7vbb4AvSUNrnbSjg9QS6YXoMkCHDCHqT1zOF+ISHiENZtTg9aMqcPjj44nCo84+ENk8iHs0gNQ7ngP/TQhJYybO5frTnj1V/9d/RyCoKHIojOnFcQwyyoqdPACGa5SDSaVyfnsONDz5C2JWV6XIr4pviv+Zxzuzkc+Se/30TTkkI5JzO9pp6zS+cA9i8AjH4QyXyWQmjV6S3a/VmvVa9I7gpVS3FZUuIPJJpxzl6DMvx38xQHcrQtTQRgmyEYdqTMi30iE4d5d6Pr3mWCUkvAnuxnUPbSmdbhP1urLSueatmvO5MhwY1qzEwFsgN+qGsbxHF29sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nM9LfiCV6vUo86MOEQT62ahnyen3lSpLZI0oA4tEmwU=;
 b=YiZYa22TGc2k37/toiA/GtLLO6qhbLHRF17vcC2W2rzJpg52M7QeskE7vdQtstV7HGiP8ggIVnQvGqquDxZO1DH9NLhyKlMJ+Xcwi/pNtnzDstuH840x1Ljf2g8QjI7JSQ3bXsVuwPVJgK9iyqliWy6ZTJRj9F/qBLcBSN79K146Xkbz+UNheAxniPMj8FdlrzcXU3ozjRdNCPerwcpq8irJ/sK1beWJSTzt/CdoImS1V016ChW8MPa/cfGHIaqMpmemIbMzFaSJmAn+d7UjZbZKxq8SubpD5tnPmWh+D2ePFzpcSe/GPejXsWwGGNa7D/dfX07ghierqgpMVHlfgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nM9LfiCV6vUo86MOEQT62ahnyen3lSpLZI0oA4tEmwU=;
 b=hX1B9fq4I9OWV5DL8URxZjEH0pnFqgjPFXUqC0jDl11tRAfz5c/IFAn6Ly84TPWsO6vWeBJDAYPlxmUtAXsp41ytTOohDIVRSrBEWCZhIxFKynRa4e0l7cl3MaGa5eNbsCr904QDvN2LOxYPdfCyQ7bqzKMQWtMIXur/LcvobPyvZs/jY9L/wcrSIN7Rtwkfihk2S//fmmKNGrio4pLvcsdRdmknhydFhNdjSyatg54njJaso4fkOlaIh5FngCVc5E5hEjEE31nuSqSY+RTcFuzcWNY7diwj/78npu1AZC306mjPsudl5Cf1Jq2ry2sjLObvR9BVWR5l7vs2SpLJKA==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by MN0PR20MB4789.namprd20.prod.outlook.com
 (2603:10b6:208:3c7::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 16 Oct
 2026 00:55:44 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 00:55:43 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: Jiri Pirko <jiri@resnulli.us>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Arkadiusz Kubalewski
	<arkadiusz.kubalewski@intel.com>, Ivan Vecera <ivecera@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Lad Prabhakar
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, Carolina Jubran
	<cjubran@nvidia.com>, Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v13 05/12] dpll: sit9531x: register DPLL devices
 and pins
Thread-Topic: [PATCH net-next v13 05/12] dpll: sit9531x: register DPLL devices
 and pins
Thread-Index: AQHdW2QAhUmiPv7I8Ue/k9AppfvsxLb9o5mAgAG3vQA=
Date: Fri, 16 Oct 2026 00:55:43 +0000
Message-ID: <20261016005541.11374-3-arouhi@sitime.com>
References: <20261013224131.27149-1-arouhi@sitime.com>
 <20261013224131.27149-6-arouhi@sitime.com> <sashiko-outbox-171990@kernel.org>
In-Reply-To: <sashiko-outbox-171990@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|MN0PR20MB4789:EE_
x-ms-office365-filtering-correlation-id: 855fda0b-e786-4079-c03c-08df2b203516
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|38070700021|5023799004|56012099006|261009223027099003|4143699003|18002099003|10067099003|6133799003|22082099003;
x-microsoft-antispam-message-info:
 jgjv/EBFJjXv4aJ7LO4DTLbW0xqYUYchRBzoMH0LhR3UFGwmQWEsMU7JKhx+Rc+8373Q7pMZVvyyH+DIfqrnwd1jwqQnyABkrO+PCzkp+AtIZGbRG+ALwNxqz9l4F7Fe9Pkf9Dnu1wGE1y3Q1dxL3Gk3FJUFJ5nyrJPTy903X1LJ1wV8rF+NYw04WJYEHpTO9VCJmI6DQ9+4CILT+W2mLNGR7c5DCVPJQaA9gPmX1cNOOefwIfjcPXZnfKQLM+D6wI1y2dYiAglWjGBf85yKfMwv6oMj6aBm0KbWSDoLotIcrww2UR/ZeGXOm48ACGWBpdaxaJPeUWfd7lOA45UjcsBamHsbu4jxuwlMj/0JkZ20pB9f8NPuECbGGheeRWsQQd5eq8dAirw4yZPxJeVNb+axbyYd5h0WCO0MzBxKmgUE6G1moTOFoC8Ivnu5IPLNKZlv7TxkNOmGLJ2PQOe3wiVDlFbTStOhAPspODSxvKzcmhP9GXLah+rmpFYqcG8W/Zm6lqUgpep0q9qMDXXttn77Ib1rIjDBHFThMmXEt39budVV5PFgaOqaerZPKHW8S+C1lhCJQ+MSISHZ9qlyIauDS0wnlCnrnbxorHMjP95jKaqPd128O5MrnEt6pDmXsYPTvRWCR9t6K5D7xgjH1fKpI3P2SGzO1Vb36Q93JiuXHU8zLjbAKzqsCvufrUC294WynC/O0GlTnl6VNywaLkjZW5QwqsVZ1uktoP9rxn8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(38070700021)(5023799004)(56012099006)(261009223027099003)(4143699003)(18002099003)(10067099003)(6133799003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a3dLRUJtbzF5Z01QOGk0RXZadG80MmNXR09DNHcxS2FpNnRXNVNDaU04MEph?=
 =?utf-8?B?LzNsQUhvOFNBcHo0MDhvYWl0cHMrOTRKN1hlNjJwTTJtSnB0eHR3S2lPaW1x?=
 =?utf-8?B?elFxVW50YllsWWdqMzZsK1BreHI0bXJZYzJCd1A1MU1ZTzhjTmxTZkx0dk1M?=
 =?utf-8?B?MFpwUHgrVkQ3Z21tOWpPcHY5WHlNSWROYUFsODk2eDhVMzBZc3h0Q1dhNzNr?=
 =?utf-8?B?czFnZG9Ua1NxOHVzQUNrZGlodnIraEQ3NmMwdWJaNEFXc2FUeFZGUG1JNWZR?=
 =?utf-8?B?ZXpzbTJMY04yZWhYcHNseFd0MWFuMmRjQ1dZbjNITUZpN1UyOHpKYVZSdTlS?=
 =?utf-8?B?YWxzMHEzTlBhcEt1dnNhejkyZXd0ZjgvZllVWHFyWU91aXczZkJzemFwK1A0?=
 =?utf-8?B?ZHJwZ3dTRW5YZnRUYlJyWGVBTStJb1B3Znhwbk81Q2hLQWJmazZsTmRhUERm?=
 =?utf-8?B?d2tJVEpkd1JmdFBQL3liYktrTmFYenNha0hEVnlITXllSDVMc3VRaUxmZ3R1?=
 =?utf-8?B?RWZFcEV2ZFVNNDE2bDUxZkFURGZmUmd4dnZ4MitwWVVIR1c2Q1gxY1lzSStS?=
 =?utf-8?B?MVpuanVWekxFand4SDFRcUk1SXk0bis4SW9ONWNFUjRIYlUvcGlYeElSL2Vm?=
 =?utf-8?B?aDNzWUx5OVY5bW9rQUVuTjB5MmQwKy84d0RubWtvOEIzV08zYUYyblVGT2Jr?=
 =?utf-8?B?TFpoYm94VTQ2aS9EL1BzRlV4Z3NRdWtyWW9ZVmJuZXVza0pqUkcxZEJRZzFR?=
 =?utf-8?B?RVJXeXp2MUxSMW9EQkQ5cUtyVktHSjRxN3NETzRTNTdJZ09yVnVCanFMRnJK?=
 =?utf-8?B?T3F2dWNLR2ZINnExWGVHVE1jVmhCU29ndzBPTEkzUXRxYmNjQmJ5M2FmamFU?=
 =?utf-8?B?MHVzaE9mUU5GSDE4Tkp0VDBGby94by9jNnI1alJvcG5VVENuWmxLY2V3cU9X?=
 =?utf-8?B?ZG8ySFpnZFdQYmNTeExybDZJNnZEMi9wTGlDbi8wbnBheXJHaVZqQVVPeVBa?=
 =?utf-8?B?MndxTllwS01lM2ViR21aY0VOSGFBT2hzUmU5VGMzOG4vZVJuWnh0NmliNmhP?=
 =?utf-8?B?a1lBZHZWUGZEc1U1dGkydlo0WHd5bnVaNkYvU0lGTEQ5YVZURXhpaEZCYXdR?=
 =?utf-8?B?MFZVYzRBZVMzTktvVTkzdDhLR3JRQkg3R29TcTJGVGN6U2NubE92d2F1dmxl?=
 =?utf-8?B?ME5SRnllNzh0RnR0cGdCbnFYNXg3VkN6UlBwb0RLMXkvRm9lMnVvTmV1aHVa?=
 =?utf-8?B?WkJZb3JKcmxwMUxhc3l4aHVxSlFyVG5XQjBNazRraTNHMXpENjhVd3E5YTU3?=
 =?utf-8?B?TjZBczV1RnNpbmNLeEQyeld1R1RmbXJURlZsR2NrNzlaRGp5SWFnc2FRSDRS?=
 =?utf-8?B?MXFFNkFFWU01THM3U1VheFJkMzZLZXk2RlM2K1BvZzZhRnd0UmZyWHBTcXVN?=
 =?utf-8?B?azZwYVRyVlJsaUJmeXdQZ2VQNTQrMnJNMXEvTEVtdkQ3RDFnbkNNS3A2eTZk?=
 =?utf-8?B?Mkl5ekdPbHBqNkoyTGhvcmxXSzV6SUJMa2p5RThSZ1BUekQ4QW92cHplOSt3?=
 =?utf-8?B?MHlOWlpmMWxIanp5Z1R6b2YxQUc3NnNlNDRoM1ZieXU4VERoY0t3NHVuUms5?=
 =?utf-8?B?a3lTQWVTR25BN3RLY0VrRU94dzJFSDRIM1dUVy9ZNldqd3RlS1dFcmV3dmxI?=
 =?utf-8?B?a3BHSkhZclRjWVhwb3diRG9IUHlXeVlCQzlDZnZSWFp5eHVaV0psYStuZ3Nn?=
 =?utf-8?B?OXV2UmFjUzJVQ0tGMGhzaFdsbTN4RkU5TGI1YzVMY1pSeW5SZTZ0Tk5MVGh0?=
 =?utf-8?B?ZUhPVGUyMHM3ZW50MkFlMWI0UW5SU2VwcmpVeWlXM3VyQ1ZmbFhHalBGM1JF?=
 =?utf-8?B?Mi9GWWtwOUd2RVFtZkkvcHBWUVJVWHBGMUxOUVdOSTN4UVA4U0I5UkpUOWFt?=
 =?utf-8?B?bkFJM2hQWUsrSUFUWFIwTkxVQXJPYWxaTUdkT1Fuc1lvMjNkSXMwb2RRZXcy?=
 =?utf-8?B?WCtidEY1WmFuakRvOWIyUEplalhTbWErNXIzWWtLUENwbFhjS0ZlVUR5WU8y?=
 =?utf-8?B?YlRiRUpROXI4d0VCSDg0WEhtNmdheHdSSVY3NUJkdGVUdG1Kd0JZL0dSeWl1?=
 =?utf-8?B?WW5NUkxtZWhvZG5CMjJwZUZhYjM4Z0t6bmFDSlNuaUdPQmdzTThhSUp1bEcy?=
 =?utf-8?B?WmVudEp0QVNBaUd3VnRJQ1drb1lkN2pRWlM1VWhGR0wrTjJYbVYvMFZhK3hS?=
 =?utf-8?B?UnBvUzgxVUpKRnNvZkdVdTgvODEwK0RvTTViS0pOTDRsV0oweExGYXRTYmw4?=
 =?utf-8?Q?gA9Mtt6NrAWMQ4g7sT?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	jM8u9MPJUnIyVgDezjGieo8z6J8Qqk7rqiYtKMqP5iG5jA6F+t5b4UvglVRZwFt0Z/ayZCKCTn6ybUJhNhtQm7ezIaJg0H15gkzsG0Ohv+ynHGR066EsPoJVefReWn9V0HDMDNiDTt4Fpf4MWdfgv/lBjQ930Jik+tr/d8dqIO4jFtujDgusNDIBpSMGqqJSbk6h5+JwcbEUfCZ3JFpWR/bvbbzkes4VF2SxBa7URBUaTdlwRkxF17EGb6t9HXilJWE/SiC6eUeVNdYQpnYnWW3n+UnnolwJAyeX5Ca0yiRLdhjOdLvonnG4WgFA1wc+Alj+eRvJ49WvrJG8wijx6w==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 855fda0b-e786-4079-c03c-08df2b203516
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2026 00:55:43.9414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z5x513KRyI81Uwzfq5bJT0Uzh1T0OOoj2nrjax13bKf/1LGGU+GsFmyBE+Uv/NXmJMrUpD+m+5Nv/M+r9wMN7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR20MB4789
X-MDID: 1792112147-A2o2BMMYG2h5
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1792112147;A2o2BMMYG2h5;<arouhi@sitime.com>;ba04557de9d2da8490f5f1e6de07b967
X-PPE-TRUSTED: V=1;DIR=OUT;

T24gV2VkLCAxNCBPY3QgMjAyNiwgc2FzaGlrby1ib3RAa2VybmVsLm9yZyB3cm90ZToKClJlcGx5
IGlubGluZS4KCj4gPiAgICAgICAgICAgICAgICAgcmMgPSBzaXQ5NTMxeF9jaGFuX3N0YXRlX2Zl
dGNoKHNpdGRldiwgaSk7Cj4KPiBbU2V2ZXJpdHk6IExvd10gc2l0OTUzMXhfY2hhbl9zdGF0ZV9m
ZXRjaCgpIGV4cGxpY2l0bHkgaW52b2tlcwo+IHNpdDk1MzF4X3ByaW9fdGFibGVfcmVhZCgpLCB3
aGljaCBpcyBkb2N1bWVudGVkIGFzIHJlcXVpcmluZyB0aGUKPiBjYWxsZXIgdG8gaG9sZCBzaXRk
ZXYtPm11bHRpb3BfbG9jayB0byBwcm90ZWN0IHBhZ2VkIEkyQyByZWdpc3Rlcgo+IGFjY2Vzc2Vz
LiBJcyBpdCBpbnRlbnRpb25hbCB0byBvbWl0IHRoZSBsb2NrIGFjcXVpc2l0aW9uIGhlcmU/IFRo
ZQo+IGFkamFjZW50IGxvb3BzIGluIHRoaXMgaW5pdGlhbGl6YXRpb24gc2VxdWVuY2UgYWNxdWly
ZSB0aGUgbG9jawo+IGJlZm9yZSBjYWxsaW5nIHRoZSBzdGF0ZSBmZXRjaGVycy4KCk5vdCBpbnRl
bnRpb25hbCwgYW5kIHYxNCB0YWtlcyB0aGUgbG9jayBoZXJlLgoKVGhlIGxvY2sgd2FzIHByZXNl
bnQgb25lIHBhdGNoIGxhdGVyOiBmcm9tIDA2LzEyIG9ud2FyZHMgdGhpcyBsb29wCnJ1bnMgdW5k
ZXIgbXVsdGlvcF9sb2NrLiAgUmVhZCBvbiBpdHMgb3duLCAwNS8xMiByZWFjaGVzCnNpdDk1MzF4
X3ByaW9fdGFibGVfcmVhZCgpIHdpdGhvdXQgdGhlIGxvY2sgaXRzIGtlcm5lbC1kb2MgcmVxdWly
ZXMsCm5leHQgdG8gdHdvIGZldGNoZXJzIGluIHRoZSBzYW1lIHNlcXVlbmNlIHRoYXQgdGFrZSBp
dC4gIHYxNCBtb3ZlcyB0aGUKbG9jayB0byB0aGUgcGF0Y2ggdGhhdCBpbnRyb2R1Y2VzIHRoZSBj
YWxsZXIuCgpObyBzZWNvbmQgdGhyZWFkIGNhbiByZWFjaCB0aGVzZSByZWdpc3RlcnMgaW4gZWl0
aGVyIGFycmFuZ2VtZW50LgpQcm9iZSBydW5zIGJlZm9yZSB0aGUgRFBMTCBkZXZpY2VzIGFyZSBy
ZWdpc3RlcmVkLCBiZWZvcmUgdGhlIHBlcmlvZGljCndvcmsgaXMgcXVldWVkIGFuZCBiZWZvcmUg
dGhlIGludGVycnVwdCBpcyBlbmFibGVkLCBzbyBpdCBpcyB0aGUgb25seQpjb2RlIHRvdWNoaW5n
IHRoZSBkZXZpY2UgYXQgdGhhdCBwb2ludC4gIFRoZSBwb2ludCBzdGFuZHMgcmVnYXJkbGVzczoK
dGhlIGZ1bmN0aW9uIHN0YXRlcyB0aGUgcnVsZSwgYW5kIHRoaXMgY2FsbGVyIGRpZCBub3QgZm9s
bG93IGl0LgoKPiA+ICsgICBwaW4gPSBremFsbG9jX29iaigqcGluLCBHRlBfS0VSTkVMKTsKPgo+
IFtTZXZlcml0eTogTG93XSBJcyBremFsbG9jX29iaiBkZWZpbmVkIHNvbWV3aGVyZSBpbiB0aGUg
dHJlZT8gSXQgZG9lcwo+IG5vdCBhcHBlYXIgdG8gZXhpc3QgaW4gdGhlIHN0YW5kYXJkIGtlcm5l
bCBBUEksIHdoaWNoIHdpbGwgcmVzdWx0IGluCj4gYSBidWlsZCBmYWlsdXJlIGR1cmluZyBjb21w
aWxhdGlvbi4gU2hvdWxkIHRoaXMgYmUgcmVwbGFjZWQgd2l0aAo+IGt6YWxsb2Moc2l6ZW9mKCpw
aW4pLCBHRlBfS0VSTkVMKT8KCkl0IGV4aXN0cy4gIGt6YWxsb2Nfb2JqKCkgaXMgaW4gaW5jbHVk
ZS9saW51eC9zbGFiLmgsIGFsb25nc2lkZQprbWFsbG9jX29iaigpIGFuZCBremFsbG9jX29ianMo
KS4gIFRoZSBzZXJpZXMgaXMgYmFzZWQgb24gNDVhZDg0ZDI4MDBlLAp3aGljaCBoYXMgaXQsIGFu
ZCBldmVyeSBwYXRjaCBidWlsZHMgdGhlcmUgd2l0aCBXPTEgYW5kIHNwYXJzZS4KClRoZSBzYW1l
IGFwcGxpZXMgdG8gdGhlIHNlY29uZCBpbnN0YW5jZSBvbiBzaXRkcGxsLgo=
