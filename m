Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDFE403E87;
	Fri, 11 Sep 2026 21:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789160418; cv=fail; b=UrmvyfpmAJd2ZrlG+jkwfdmbPEXP6S5Vlzzons0SiECMbNsu3vTK4/WdqqOCu9xNEhJqV7KNGS8jbH8kwGFcyv8jSO/DQJXYciw+1/JtsxN0no7isPxGwkZTfNSl7SKkQnQ82embsFvoW8sOqasejbe0x896kDBGVUfzM69RfsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789160418; c=relaxed/simple;
	bh=un36KDzLrvrPMyvoqFi5hR78XihV4TLABIe90s8Y3G8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nwMgqavCoCypvY9KC/UZW/e2+keAioA77BF/FE3649DjwzgcJkeirqna1feLKfdIy+d8E9YnRC4OAHdaZNermzjaE+INvyiSzykIzOFsYPmEI88+94dIg1Ibr7OItXY88IY0/pqDflVs+s3I4t8z8+uxkP6km2WQkdviF0Eh/1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eKxoVz/w; arc=fail smtp.client-ip=192.198.163.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eKxoVz/w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789160416; x=1820696416;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=un36KDzLrvrPMyvoqFi5hR78XihV4TLABIe90s8Y3G8=;
  b=eKxoVz/wtRm6v7P2PRvyuprv+cz+duxPA1SVQ1HUMH+LfNq/XuhLkL3J
   Woo09C+2lKeWjpCaFCXzl0o/z1XHZBtnMjZGA8j3LBGwdlm/qsokgIp3v
   11Bcr0qsj8JiKO8Z+RzVpoPA5GlrXJ4f8+ZAVGQ2N6AgSM5TP9wWWQKBy
   KUCqZh4dE11tVvz2ZxKv5vbonSD3eD6azgg9jGvxDuju+eDXXw+AuwmBs
   ooX4mdljuBe4Iu1ojO07zEs32E9xuWFjBpG55RpcErTWlj6212agahrgN
   LBiZEP4nIZsAF6samR+DebwUHb6rUkVYJpN5f0JEzguMWgIvRw96JP5/y
   g==;
X-CSE-ConnectionGUID: bGOgrgImQwSg1bh3VYfjkg==
X-CSE-MsgGUID: DS9ESQ6RRfapUMCp4KyHYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="139281"
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="139281"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 14:00:01 -0700
X-CSE-ConnectionGUID: jdbD4sB6SraKDE3kY7knYw==
X-CSE-MsgGUID: UBh8/P4dSbu4jIel7QDGIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="275776428"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 14:00:01 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 14:00:00 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 11 Sep 2026 14:00:00 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.1) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 14:00:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dzWZTHnQ/pp38mMUqAxW1dgLTR5jdhQtbBUdieVm9CCbJJoaqYWv2bHx2oOLKZhhur02hmws8tD28UDHA8RZYnHJ1oCFryB7P2WMWafFSNt+XlSHHPX4MLcBLLCVoP8jdcbBm/b0s450GXTBijy9T5oL681xzMqey/ADp9OY0jJsEtftwexl4hyjJNMVjv2opXkOqYwsJ2sjuMxZeei/3VkTdwUITVmKFuyFsl8bzZrbVBVmc5RDJcy0W79/FzwC4i59UVtmn3jTItUtd3Hci7bXQ7HHkItYy/wWsY4IV4OuHXl2i13bye0Dc6TxabX17QyOG8aksmclE4Jvulpw+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kcBCzC1gSCAHNQUBlY5MlcgI/dlYqN/yZars44cRTY8=;
 b=rqaGJrB05luVm8Y3AFli8OmmcekJcCoNGgP5un1sM3HTCQqGcXdLlZ0/F8AhYqBimXalG4ZZhSCivDusMhgQ8zQDFcwFAdKxfS51mCNRiwWD2WsuBPuqTi6Dk/cm6T0rzBR+M3nPqb5PP/VEu3akxsAFl/RJUcik6uyMpVJMte2y2w7s4L4A4TPrM8+9KbvbDxrzHAvy/e3h24guHXAsul5GSOyfVcu77hJ0zMJ5VUhQ/e7jtMPS5knwf7tLREhx4qhJgw2T94UFFbw2SJq8u65rHHj9JhqpON5Hfi0pL6sPZe56F9fCjYgrtlkqiw8OkqIAl4X+8LoPMVAyb8Neww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SA0PR11MB4655.namprd11.prod.outlook.com (2603:10b6:806:9d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Fri, 11 Sep
 2026 20:59:58 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 20:59:58 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Hemanth Selam <hemanth.selam@gmail.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [PATCH iwl-next v2 1/4] i40e: fix typos in comments
Thread-Topic: [PATCH iwl-next v2 1/4] i40e: fix typos in comments
Thread-Index: AQHdP6S9OtUIOkBngU2xLCAeq2zA87bJ4aTA
Date: Fri, 11 Sep 2026 20:59:58 +0000
Message-ID: <IA3PR11MB8986CB5E593515DABDB76727E5BE2@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260907095446.27290-1-hemanth.selam@gmail.com>
 <20260907095446.27290-2-hemanth.selam@gmail.com>
In-Reply-To: <20260907095446.27290-2-hemanth.selam@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SA0PR11MB4655:EE_
x-ms-office365-filtering-correlation-id: 6c3ea570-eae6-4fd4-8c29-08df1047a393
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|18002099003|22082099003|921020|38070700021|10067099003|11063799006|4143699003|56012099006;
x-microsoft-antispam-message-info: OFHvxpHMh9aMNn6hemgys5WOUAzaO69pu7/kHIJ8M/UPfHAG1xrDzW/9tb67Oeco+npRW/W/DK8sTeuAoP7rxJXXmkskDJEfFPvnm0Xp1izHIbYxqAxP5sM+r+FLESgsQW3Xk2d5m4UkIecjNg01jNmXBniRlG4/rX/Wpzw3PUF+4gi/fsLRVMY4wPEvzZqflhY9ak73KogHKmCzZ7pGVVWukWVuUdO5LWYootJXoNE6th99a0j6ppxJD2SaHcNfE7NRLLi+6WYcndcjs2FRN6f/x5lvjwCYwr8/rNXMyaxqnRz3MJ181VoZsnSeXx0P2wfiu2URwjN1BJ+P1ONuti5zjsz/S6UA7VRRlpJkWNr7K7NhCu0+ybdkCT1L/4hF7JM+aGLKgaN0w5Wqr+IsNyvfqlpDk5BUDdBM6KIWOrp4JUL1+V3ONl756cCoYnu742ocQZm8Ki4Isrk4Uq+pQ8SEJqN3Lb+cGxezSK6lK8W8pvdwW0ue8r1ZXliQqq7xpgeoWN3NIEO/H6EY1h8Z9gux0rrbgtmD/9diUgLr9uT4Vd2+wPtYMISRfFtQwyR6FL3MXWLU+1C5tGbfj3FrA0Xnozv528A98tS94DFraeOrMzEjjgM/odIr8TfCKJGx/D88DNG0A3DZMgbB0/hP2fau3kkhFFVnJlik06kRP8OzAVFzqhmxtdxuCGhQwwz/Z++UXr6zieK4HTlxaaUQ3H1NKDbyVlXbZzML1IKwswI16PzYBmmu26MhIsqYQrgr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(18002099003)(22082099003)(921020)(38070700021)(10067099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ySSkPkpmV+UDymFAskwAbZFNtwL4b0vvzg4PFau+ysPchtaBea46gsn1kqtc?=
 =?us-ascii?Q?+DbpJF0Mlswog6jNQ5wFQt5IHge4I1aRg9u1ryVhOkfOjHbQxU06UB5ZSLkO?=
 =?us-ascii?Q?N3Fa7YL4eO5JmhKctp07JP3O3Xw89G3OreViLkLt1dto4vf4H4ww7zxWuIJs?=
 =?us-ascii?Q?D1t0zX9O3XJgPXfP7ZKVYhrGNkMYo+JhAwihZ17yM/C1VC8aLWa6v0JzeN5q?=
 =?us-ascii?Q?YdXsAcWjT9LaRV9tgPowZwMQFSthRaqLzaNWkOad9YK2/tgJ+i7pn/pOJknI?=
 =?us-ascii?Q?nqLsGzU+YE6gOcQcoLTjjbAm0T7zpQ6sd3eGwayHfUZlgVBGcEURPH6UYsS2?=
 =?us-ascii?Q?t0Ftolkn+OGmbgcNSivhlujQs2XKgQcy7iBNuivi31qkWCv4rgq1n2s2il4F?=
 =?us-ascii?Q?bkdKKm1ECejpyFwYCf70se82fWEgFMXzNs7mMxhmQLYvk7Twd+6DAv7AlwbF?=
 =?us-ascii?Q?OTHS3gEDAVqPNEhv8SGAMe6N2P01SdkLQ6Yod0seSk2khfrVWUKmEbqb/M6v?=
 =?us-ascii?Q?1aSmz6TC368xFXuhEA8oj9QEJxfhu5yyawsZwxgzzaukjzqj8YLB5zp5F0UJ?=
 =?us-ascii?Q?nGEaLHlg54uk0HZS2ZpM5QB/bKLjyWOJeFxLuw/vN2YVKNCN/jXw9pCulZIF?=
 =?us-ascii?Q?wlq2qwwPSLU3aVDHPSeWoLXfx7PSDryxi1I+8JdBC+5Ktr4qfXQE+Y9P8HcQ?=
 =?us-ascii?Q?ljCU4ZcnYvU0zHEEzf0s1Ji/0Tn67iAeMo+pSYo7dyeyDuEl+Ww1oLiwy0Dc?=
 =?us-ascii?Q?GNkXT2mNQj4GP/WLWsX3tW75tOOuorBq7RZbmxzr6KCVuhAwGhWcOLPBxRU+?=
 =?us-ascii?Q?WEOvVvelZLmkrGnONJc3OcpV9/SsTqIv4ozKS7+5fKY0k83CpI98qmhL7TZu?=
 =?us-ascii?Q?NRwL59SzGhXf1sWiPtQTTl+cODYLF5+3Ry6+MPrAZURLJ+omsnTxAS/PIuJs?=
 =?us-ascii?Q?idHlEDHz28WQtNr+GSqW++8gzUEFCb9ashjziP08v3B5uWWsdVzg0bZ5GVDg?=
 =?us-ascii?Q?IsUcjcsuy8tOvkvpuKvRgP9lo5/AiXcdRBercj1rdxTDMFbtEHgvsZZGqP3V?=
 =?us-ascii?Q?jX/kXynpwHqDsZYJB/4dOwW6MBADhBmHv/6v9GxJvjssk52NbdpjL2Bw+avm?=
 =?us-ascii?Q?qClX1zZnfiRuwA7KBHNj35ejkSC0YXCNRf9rY0q0HhxI5blIL19LGj2uR6/5?=
 =?us-ascii?Q?NBWt1LphODsnDT5Q2OhpkFDb+44SLaKids397QRI/f2jSxc3fG+j8JEbH1zk?=
 =?us-ascii?Q?cBsXSBV3fQLjOrHFrYTZHmiOPh99lFr/yDVYX8Jnfl8GpaEX9NZxLP3nV1H0?=
 =?us-ascii?Q?JM0cEkR/qVl7SN4cq7pZQ7s87SqOQ6FyYFPxib6ubrdi+lyz1oG89dyV+yuU?=
 =?us-ascii?Q?dy2u9JDcNWGCXZnMXZ0bLth0+E6bGdEgbf6BkBE0GfgctMnr6lDalHELpVjG?=
 =?us-ascii?Q?VY/Xpk2o7m6hvwaF/qsfWhZ8ypN8ilF9xzbpsvDVRJC3CFObXpEHnECH0zvZ?=
 =?us-ascii?Q?3TGUvzxofDsnknkmjo4p45rhFK0x98s5Uesb9CBgyRk6DDlQ4oyNHmN7oBkt?=
 =?us-ascii?Q?5F03SkxN1F7Mml08iUcVYHvc6IJ104H6zWJyvV4D04z2CytDX2S3MQ/jhLsb?=
 =?us-ascii?Q?cOt6UR2ig23BtJpAeafjy1enqROgu/itFsMzPgIyMk4h/SbFD0v6nGGitxaH?=
 =?us-ascii?Q?NBbLDLw0Vqh1twTa28SQHd2rPOIyUPJQhVyIIvxbkNPXFHPHTvcmzfXsD80O?=
 =?us-ascii?Q?wmbNK3wRyA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: PzKG359IUBXNVc3VxNojnBoLQ+OZgzwibfCBas8SvtqXkeyH2FL8RnJgyyh+rgs/PdCwym5WZojLARGBCaiC7qBGCmVoS10Ofz+qSdRoHA0pe4bR8WgDL2v4PwN7SVomOJmLJ5Fw1WaGIP0cvxUfEwAMJ0gdE11et72c6mEf77r3Sjc2GtTmLNUoQEjlvPwScwZF93zER24VPyHVa97hlsXm3Osj9DFfuhoTLhSpIYg1CrRGRojCK8IUIPTzFF6neSgyN9W8khG7H2hFrRDuBfv0xKQyGdHexbIigTldbEJwMZM8WRlnrigZzvWthzFluCK2OuMMCPvZZOPyLtXzBg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c3ea570-eae6-4fd4-8c29-08df1047a393
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2026 20:59:58.2093
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ECcjrum+n3wFnqF7FkaEDtEbBmf4CekQhDckjBXNOMJFtOnTiS9pXnuTjv2Tcfzw/OLLV5gcsxOEOtjwuJkBg6wLER+wfpkccaz3JqFSK8s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4655
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Hemanth Selam <hemanth.selam@gmail.com>
> Sent: Monday, September 7, 2026 11:55 AM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; Simon Horman <horms@kernel.org>; Jonathan
> Corbet <corbet@lwn.net>; Shuah Khan <skhan@linuxfoundation.org>; Randy
> Dunlap <rdunlap@infradead.org>; intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> doc@vger.kernel.org
> Subject: [PATCH iwl-next v2 1/4] i40e: fix typos in comments
>=20
> Fix typos in comments, found with scripts/checkpatch.pl using the
> misspelling list in scripts/spelling.txt. Only touches comments, no
> code changes.
>=20
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
> ---
>=20
> Notes:
>     v2: designate the patch to iwl-next and use a subject prefix
> naming the
>     component, as maintainer-netdev.rst asks; v1 went out with a bare
>     [PATCH] and a "net:" prefix. Rebased onto iwl-next, diff
> unchanged.
>=20
>     v1: https://lore.kernel.org/all/20260907064528.6602-1-
> hemanth.selam@gmail.com/
>=20
>  drivers/net/ethernet/intel/i40e/i40e_common.c  | 2 +-
> drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c
> b/drivers/net/ethernet/intel/i40e/i40e_common.c
> index 8dadfef2c09f..026b35e5a000 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_common.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
> @@ -676,7 +676,7 @@ int i40e_pf_reset(struct i40e_hw *hw)
>  	grst_del =3D FIELD_GET(I40E_GLGEN_RSTCTL_GRSTDEL_MASK,
>  			     rd32(hw, I40E_GLGEN_RSTCTL));
>=20
> -	/* It can take upto 15 secs for GRST steady state.
> +	/* It can take up to 15 secs for GRST steady state.
>  	 * Bump it to 16 secs max to be safe.
>  	 */
>  	grst_del =3D grst_del * 20;
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> index 3da9ec49cc74..ef9d1e78c16a 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> @@ -2614,7 +2614,7 @@ static u64 i40e_eeprom_test(struct net_device
> *netdev, u64 *data)
>  	netif_info(pf, hw, netdev, "eeprom test\n");
>  	*data =3D i40e_diag_eeprom_test(&pf->hw);
>=20
> -	/* forcebly clear the NVM Update state machine */
> +	/* forcibly clear the NVM Update state machine */
>  	pf->hw.nvmupd_state =3D I40E_NVMUPD_STATE_INIT;
>=20
>  	return *data;

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

