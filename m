Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243452ECE93
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 01:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788398264; cv=fail; b=ZVsnOB1ROTK8GnNU31yojwreA0lWX12cIzOUGwhDs/LdkD09/ujU19+VYHxk5S1uos4lY7OHPddDwpftegERl3xXxDJUnBJ486yE8nBsyeIcvF8P+Bcqi0IWR/UOzfA72cOa9pY2MFWRdGASEAVwpoIpOsOV4P31cQH6vhJnryg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788398264; c=relaxed/simple;
	bh=Wz6jTqSy21woH/YCd0uOb2MfFzVSVnX47qE4UofdqTk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bHSdCLk/wU05HCk8J9RanhrFMUm9L9sUkPOC3qbwoGD14ghlc1fqrMJSpytyu0JmmlBRnBlYPToBXfhy7KksMBqiLqQ/6TDbAOQwiZeyu//ED5S26rnHaCU5I89Aiy3SzNKjHEbRhbhzwjxC6q1tjFWk48gl5SBQhaLr3UupOjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XviioMXD; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XviioMXD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788398262; x=1819934262;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Wz6jTqSy21woH/YCd0uOb2MfFzVSVnX47qE4UofdqTk=;
  b=XviioMXDMN+tFmBRXEysgCqqLDGlNDfJnEZ5DB1i08BQH8bdyafbv95K
   LPIl/GIHXpPGCkJMruJBIfUkK6jnEAyQekn41INRhs/cufppDf7J+rePF
   tXKp5n+x9F7eUj5Vi+obWk4oFU4vj7eq5IsimIwue653yzWaIgaoHZabH
   ZiolI1H0VGEb3f15kcHOMhsm83EQ0EQxlzNYtsJIc5NT1q1qNWsoxcBoz
   TJI6biTBtA89UtHjdHwh9S+aOsdIb7C/BvPX3dPKB8Lv2uGLJlnjk0A+P
   UY8Bk+P+9xMT8jMGf3Z4Lf8c1951O0Rl2ZhU+Zw4S2ZYcZPRI9PVrKuLQ
   A==;
X-CSE-ConnectionGUID: WnkDcexSTjuXC3OhFqY41g==
X-CSE-MsgGUID: KlN5x3/DQ9+SMOGw91N2WQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="88793319"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="88793319"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 18:17:41 -0700
X-CSE-ConnectionGUID: MaQ68o9ZRPiob/JX6PkKXg==
X-CSE-MsgGUID: pEPzKSRTSb643ZBNqmrkHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="294425178"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 18:17:41 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 18:17:40 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 2 Sep 2026 18:17:40 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.29)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 18:17:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x2zHP9ZhYasNjj9l9nHtXGtF9vDj/8kSsqJ9d3uk1MOuroloDOBObZ2/DuQBOMF7B6VXCfgCk8iX/nBZcIarjPlSJ9GZyZyqJLjQebdgnMYynNbLaNJ3HmcWaUqsQtwgs3VJBJZQMJyyRhenkXHfXPQdrsXk53PhVhdK03GApxybarpyZgYkg7es+UuKTovLSXKgWmB33aUYNOPlQZ7WDjnlEemH1y+jj7uMmQcOAvEu3c+DMSYOQT/J+273ukI6zLl2/Ix+g3MJ2WnDezFbh1TlrpuPt/mJpQIMl1TuEa2aYyCXExMg/SiH3WgaNGC+XQfT+ydq+MnbgGAMRJCwyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=osmz9MH2/6atGWrik1m5WewD1nlFoBYp7252qZWF6jE=;
 b=FuU3oL4YLKfgxrTZ/xhArhUkAyhdYMEl9PdGZI/RO1M+qSZARV/jd4DQ9yUxsGgfKK9UH24JEoAudOit9UCxLUvsg1CTaCA3NI1imQD2oz/jCBT/UpYKAc0wxLfevnmstjZL+tkAX9QE5lyk7QR7oNUgAL/imHwUIB79qYWgAe7qXdifOtMoz8rFrdmP/kiZesl1s8d8S9jBVd+AVP8nancTvnTChB+II5MKRi1xp0Wi8CgFBq8Goun4hZL+3WDUw+LCWg48nE7RFGCRvKokFp9cIAQ+btizoWXVciylZZOrtfhJZ1QWPbSYT+6YC7Iu2GA/4vvtsi9v/fg2H2c2PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com (2603:10b6:a03:458::8)
 by IA3PR11MB9328.namprd11.prod.outlook.com (2603:10b6:208:579::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 01:17:32 +0000
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::6f05:5b37:2440:556e]) by SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::6f05:5b37:2440:556e%3]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 01:17:32 +0000
From: "Salin, Samuel" <samuel.salin@intel.com>
To: Simon Horman <horms@kernel.org>, "Tantilov, Emil S"
	<emil.s.tantilov@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "Hay, Joshua A"
	<joshua.a.hay@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net] idpf: fix possible race on
 remove during a reset
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net] idpf: fix possible race on
 remove during a reset
Thread-Index: AQHdKbVexRBI0LQwjUad5CHa9QlLt7ab/18AgCAxHDA=
Date: Thu, 3 Sep 2026 01:17:32 +0000
Message-ID: <SJ1PR11MB6297204BCF0232701D48BC9C9BB62@SJ1PR11MB6297.namprd11.prod.outlook.com>
References: <20260811171751.22165-1-emil.s.tantilov@intel.com>
 <20260813134108.GC265046@horms.kernel.org>
In-Reply-To: <20260813134108.GC265046@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6297:EE_|IA3PR11MB9328:EE_
x-ms-office365-filtering-correlation-id: db9246be-40a3-4570-6ad5-08df0959212a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|38070700021|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: 4pfhvZwXqd7i2IbiuhTJMzB5oo2AgFp8iqNU+cLkPrWcghYZg2OCOcfkn/nAfkVoBPXG5L4ztvnvQ6GHQpNQ+SSuKg9gTfnWwToIyoPWpVdhQCmuc0GDREVYJisNmCIaFPqXzsCVRLZwqLHkp4B3wAZ9KpC+M42WhADc3z1xb7B5KeAGSgSqap+yvFsgFUz6mmCRcI9JqruFJIUMEHW9iBo5gYq3Y0YLz0xfJyBYsiVAdmklhUoIjCotoiQbokH6snWKYbYdic5PG742c5BPECdcQOdIj3KeP14ejQw0GJz/7tWAT1oJBOI375dSDH14S/Mbq+I3/nScJZa/xZ2UiBWMcifZWtKv5uoLV3P+bYRLrxDNpP/WmwW3wVo9JT34SXeEJJTIgzUgo/kOpaeN4PB147C3OwAteb1+HrXNERxcDdvZB7O/9AnXSREQOCoFIArL/fjTpKNB5tE3ugrKsQAq7dWLrXjh5ih2e0X3flKQYchNMnBY4/k/YFSUV6lue6GbBWrVFg12OHzoGDesvTv+Mv5VFiSpJtinVifuKUMjMuF55hYrOcLUXR81Ien8rCl0MyMZI+e2NeX9W2RGX8+IL2OVFngYp4Rwlf3nxPvl7VKjXejnfLdif4OXTSeNsY/knalrtcCDQGudyQFaVz5PBhENdcSZ9EfAAYrWgzIMVuOEpDsFqglxtHJ+aqS/hn2DArI7j4h2Aje2SglE90GAqY4Wzv4o3LKLGtlW7Vo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6297.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(38070700021)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mJXf8UPctsjiiO/Ct94lJ08o16N9Q8Iy9hy1JNX0se3SHrRavAddUKMQ0vvO?=
 =?us-ascii?Q?qih0vsrVz05KshEy6oGcJodheG91VIRr1BXzKamIC/o/ha/BWZBWiOi/ag9O?=
 =?us-ascii?Q?n/deg/vOOWxUag4I4+07xC1NE0FPENXMwxjITcXS6LiBNpxpSdMZaw5w2gox?=
 =?us-ascii?Q?7sKVm0SrVu1QseRTf17mMVfRrxdWbkZvzmCnPIKmBeGadWSF1efIALgVOuqF?=
 =?us-ascii?Q?auZWNONp7cimR3VsmtA84hgsN382wqeoYeccn6H9TMKET+f6FlcC3tbFTz8N?=
 =?us-ascii?Q?BpbqPMQvgiv9F0XW30CSZtOfCF38UP2Hz+GvFSXJzpnRSCp2KywZo3yU3xhJ?=
 =?us-ascii?Q?ufTVzxpnxRoipjMPfWjNhqoq+rnsUE7LeDCVTsq31Kt/qMDUZM01F2Ybls68?=
 =?us-ascii?Q?aWA9DGBSeJeWCp5r3lvFKoAAu4EE/AXP1LzvkDM2fy7qpJe83MVMONkT6ahA?=
 =?us-ascii?Q?8vzLxG1BJpsikaJNVCwRXlAxUTIW1eLO6KBQGa0rhlUXZqLhElCq1EE9R8gQ?=
 =?us-ascii?Q?8GZXId91y+qhlKyAKTFXiAIzcQYrU7AiEHlmwPFYpd03pxit++IFXEWId4pG?=
 =?us-ascii?Q?SKk2TJUuCz3KsVELa68V1AqzMfYxDhOs/WuG/8M+UlZ9gbNl5D6+9PaIDcGf?=
 =?us-ascii?Q?6GfDgLJHlBWJ91t27IOLZFAko2tynHdfKnHydpnbw/Xai6fNDmQhH4WxlY0p?=
 =?us-ascii?Q?e17NVFc42uaS+5cEu0tc+WR6DL3aQHMssz4ToKr75jCwMqqpSvx6nAS5zHjm?=
 =?us-ascii?Q?zVlCAIA0q0X5HzVAGIrLkbIeZJPZht9Z3XdS+14kaAWiTqxOIWikWHfXGtJV?=
 =?us-ascii?Q?JwulQUfGWHXXQLwMJ8cXNGVEHac0VpzuSfi5fSS/3I1rVhDUgLDbfHtSGaKz?=
 =?us-ascii?Q?JuwasTehd2fsF8zFLBu3Ibyzt9uZkmoVfczuSg9g0pBH2v9aDvyX2MZKK07u?=
 =?us-ascii?Q?8YUJ6s0kX7qcqjrEx4XItDfDracMHC1xsRhOnSsGU9pv+EwL4bBZLEBi7wa4?=
 =?us-ascii?Q?w3NlTd+y0taSgCq/tButNw8InQmoKE+qfM2/3EZ8duZqLFgqbQx4bXmtsZYb?=
 =?us-ascii?Q?9rPCBFkvOaIM2RKLo9tmj8uW9OsHqjit/C0wiVmdrphHxG98S+/t29EdEvXe?=
 =?us-ascii?Q?iVeFhfZ0NPCIY+3nhvNPPxMsPhsdJfrwkosAknbBW8H/gGO6cQgOWwa7iGfs?=
 =?us-ascii?Q?I+DNQoqGdTP5Q42TbgbRj8tdXavRpAgPIqDUhSOd4lSRPbpPmjZ4AsUEjZu6?=
 =?us-ascii?Q?fqB4RPXCM3/hJ8lJCTGkaR8lJnXjR4lZOugZyD+V45SnyNt2lfuDSsowskTL?=
 =?us-ascii?Q?v07H0MMrgZeAov+F8n8LxiCwXSavYwSIDdJ2cuDtl7WFguuZLtPQmM7IoFlK?=
 =?us-ascii?Q?0R2n0aqflp5CbCakd2vu+vDfC9f3bdoeLVf1z8uQZtUPINNkjvcuA5BUZG1E?=
 =?us-ascii?Q?/S//9evb9E/mCGWcdE9MZzfTUJM297HErQXaqbjPo48WnewFPUVGE6uToP8f?=
 =?us-ascii?Q?/xacQRakN/oMsLAqhOROpntcpKxh/d1MjbfazthG51Q/cBDQMeoPiFE6w47k?=
 =?us-ascii?Q?RCRUV1ItvmOxLiRprzmws8vjwdxOJ69WEvIpcxW4mnYt1gX41QLPll32Oopk?=
 =?us-ascii?Q?CdOo+rI0bCIohRsajj8v7TdedqAM6nIIUxo6mp+tpoBoXeydk7WavhK2pcil?=
 =?us-ascii?Q?ty4w/SsHpflopNvlwvLI1Mi1SllmkrbhYiTm3vy+reofXt4+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: M3nBzk37ks/K3rgzPoGj1Mle5v3VqpYkaTPwUOPtWtYDzknRYiVkUdapeFt7k8mDty50RYN9f4btgsjQYVKOSOH8PPfCNtBDXbDK5a/Qp5CtJAE87jPWDhaYJwW7ifPMjAOYBy63ZcQW/d4eWVMGYbFtSXBGg9SEzfh2PFSFhGbfL5U+y3jjrb49gNgjTgM3GHxnBupL2qq6MTQCLYhTNS0NlUcrIhktFfR7CZxatWyX1YG4nF9sayXBrLsBp0uPDcMcmsczrSIuOxhW9/NRqq82qbVwoN/U4eJJWNRcNI1F8RcqaCE5k939V7cqc1m7bWfhit9/AIks8adbbdjWkQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6297.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db9246be-40a3-4570-6ad5-08df0959212a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 01:17:32.2532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Og0z/4Uj4mlyADs6IJJCCLpnc7NNNKBXMP7BizEZCKDbc76hBErnrs6YQExVhqIKPFDP4+qoN9WfkmV8jCnbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9328
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Simon Horman
> Sent: Thursday, August 13, 2026 6:41 AM
> To: Tantilov, Emil S <emil.s.tantilov@intel.com>
> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; Nguyen,
> Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; Hay, Joshua A <joshua.a.hay@intel.com>
> Subject: Re: [Intel-wired-lan] [PATCH iwl-net] idpf: fix possible race on=
 remove
> during a reset
>=20
> On Tue, Aug 11, 2026 at 10:17:51AM -0700, Emil Tantilov wrote:
> > Reset and remove can race, leaving NAPI registered and enabled:
> >
> > modprobe idpf& sleep 1; ip link set eth0 up& rmmod idpf
> >
> > [145561.805104] WARNING: net/core/dev.c:7699 at
> > __netif_napi_del_locked+0x11a/0x130, CPU#30: rmmod/22393 ...
> > [145561.810238] RIP: 0010:__netif_napi_del_locked+0x11a/0x130
> > ...
> > [145561.817678] Call Trace:
> > [145561.818125]  <TASK>
> > [145561.818653]  free_netdev+0x110/0x2a0 [145561.819109]
> > idpf_vport_dealloc+0x452/0x460 [idpf] [145561.819668]  ?
> > enable_work+0x9f/0x100 [145561.820133]  idpf_deinit_task+0x51/0x70
> > [idpf] [145561.820694]  idpf_vc_core_deinit+0x32/0x170 [idpf]
> > [145561.821193]  idpf_remove+0x40/0x200 [idpf] [145561.821667]
> > pci_device_remove+0x40/0xa0 [145561.822132]
> > device_release_driver_internal+0x1a9/0x210
> > [145561.822691]  driver_detach+0x4b/0x90 [145561.823161]
> > bus_remove_driver+0x70/0x100 [145561.823721]
> > pci_unregister_driver+0x2e/0xb0 [145561.824207]
> > __do_sys_delete_module.constprop.0+0x190/0x2e0
> > [145561.824715]  ? kmem_cache_free+0x312/0x550 [145561.825213]
> > do_syscall_64+0xc8/0x6b0 [145561.825709]  ? clear_bhb_loop+0x30/0x80
> > [145561.826216]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > [145561.826602] RIP: 0033:0x7fe628130beb
> >
> > Make sure to call idpf_vport_stop() in idpf_stop(), irrespective of
> > the IDPF_REMOVE_IN_PROG state, to allow a reset racing with remove to
> > tear down NAPI in idpf_detach_and_close(), which runs under RTNL lock.
> >
> > Fixes: 2e281e1155fc ("idpf: detach and close netdevs while handling a
> > reset")
> > Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> > Reviewed-by: Joshua Hay <joshua.a.hay@intel.com>
>=20
> Reviewed-by: Simon Horman <horms@kernel.org>

Tested-by: Samuel Salin <Samuel.salin@intel.com>
