Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9E53AA9F8
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 07:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788505262; cv=fail; b=AdgDPVSBWbyazb+OiQ3jxNX0h5dEMhEpWeJqX/Vx1s5GWej3zhfPBPjkhjZeu22YYgVNVU/5JySUntr/9rsJ/S8MaAhzoYvDxn0eUYvOrGfcI3fka9ap+1PmkdyK1JkEvPpryxkR8ftTSwpHGTvmh7YhNJ2u1cCR0VehiU230Kc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788505262; c=relaxed/simple;
	bh=kTqa2sU0lk68GvufnMlAsr1OuegjPzxJxQiys+ivnoQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sR+jVQn8jsoQ7pvkFLOYdE9y3We6+kBfBfdHoruK+cU4YAe2kxwVvWm2h2S0gMJOZjxdI6sSVMBoewyHK3ToM1Zunm56cOyAkyY2W2+rdcEV/qlfGp5kjbQQTwo/bv39xnZqhueliWLqKingUyrst28PFiFb9ibQQ37fLrDNzt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nt45TuuF; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nt45TuuF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788505260; x=1820041260;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kTqa2sU0lk68GvufnMlAsr1OuegjPzxJxQiys+ivnoQ=;
  b=Nt45TuuFyUm5byGwLBoJs1jyNJa4/ryTtg/2i29c5R0frJIEJemd2PHB
   MzejfURDO8SJXpJCwWKrdsVtqIhsVqa/kV8bW5ZZD3Pw77o9Bks5mC2Qa
   mMgPFCjfm1Dy1MrL4yD5omh8JwRCgxszTiYJ8Ek9xi9rWzUsQq6G0D0pM
   tKo2P1PqIJhjcsCbzYZOaMBV52cu+3p/xbQVZa1G0/wC6soQxIUmmOPIZ
   D4Nsj3fUt/I6uX7+HwB/G2vnRJ/xWg99Da0l4l+BFsdXiM65POCAa/VRU
   EMLfjFQgVvFyjuZHR2xv6uWT7SEHRISwmKY1r9thpLvgtBDFBF644QyPe
   g==;
X-CSE-ConnectionGUID: RjFzmLxuSLqQzdt3H6Vh9w==
X-CSE-MsgGUID: fRkNkZR6QmG7nSTq0rqd+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="89023126"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="89023126"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2026 00:01:00 -0700
X-CSE-ConnectionGUID: ZqrLgRP7RXmDfDCVKW1hYw==
X-CSE-MsgGUID: lxh0Jx1dSDmuGLyvpHQLYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="268225641"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2026 00:01:00 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 00:00:59 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 4 Sep 2026 00:00:59 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.68) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 00:00:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DFeguPPuHVfqBlTOSu9jbBI8w/FwmezHXnPgA1iLPiRECBhuqNYog81TfZj46vK2CWthX1GGn/WMeRQzUEEivgzHtYaZXZ12jnmRAd/bX+8lhCJeG+JAWxZU46UpxDGLKCU1vQ7rFEXA1rhSgeuwZTk1Y3KTnUzbv16Vof+zQLZhi60NOPvEsNSH7qUpiC7i4JqXmds5xYmlH8Cu+p/utj0MI0CTFbTVpfdhX0osNyPNgOgwkbpxImqzWPTYxMpj0LN4i528nfZ4WQ+fSKsS9qL280d8mvFw4jhBE96a5Z/TmRRHK8ltoB5ihs9j2NTLC94n3BEjR3/EeWqGV03RKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qL/b5vN1g/ND3L8COfQb97WFgTnc5Ho78Be2lhXnXck=;
 b=WO2WmJ/P+LYI54tLtZbYEhra0kDsVJ2vrJRMz1J1cehiYtOTf7RB29OmDGZEZZlPq/XSo+atnPqVCfuk2V4AXLlknhlboVHf2UHYz8Dt7FGCFWCDDXPwQ/Vp2sFVLgHIHCO6/hJ5gAFs91vBTRUBTyhrTLUF7btmdlxfCaYAadPMv9+6l1ONVDwFgUeiMCsqpMAQUh59bsTQ68/aNeuhOH1dOspwhY8Pnk1AexdOy6UP9z8Zb68XvXMJ8y09vsruBszUxYLFgwiItLm7RJ3RhR4Mj1lO76Al7VK40TLJRZTTN5hRy+Q7snVhbGbCE45t7bN5ilSuiGU6oBY1HNYzcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by IA0PR11MB7355.namprd11.prod.outlook.com (2603:10b6:208:433::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 07:00:56 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%3]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 07:00:56 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: Marcin Szycik <marcin.szycik@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Penigalapati, Sandeep"
	<sandeep.penigalapati@intel.com>, "S, Ananth" <ananth.s@intel.com>,
	"alexander.duyck@gmail.com" <alexander.duyck@gmail.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Cao, Chinh T" <chinh.t.cao@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v5 09/12] ice: program ACL
 entry
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v5 09/12] ice: program ACL
 entry
Thread-Index: AQHdChZMx73UbbaosUGIXoqVlH3i8ba+VkXw
Date: Fri, 4 Sep 2026 07:00:56 +0000
Message-ID: <IA1PR11MB6241A905E30ADA3D9AFC9D718BB52@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20260702103007.97020-1-marcin.szycik@linux.intel.com>
 <20260702103007.97020-10-marcin.szycik@linux.intel.com>
In-Reply-To: <20260702103007.97020-10-marcin.szycik@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|IA0PR11MB7355:EE_
x-ms-office365-filtering-correlation-id: 151bd5eb-bed0-426c-4b41-08df0a52446b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|10067099003|56012099006|4143699003|11063799006|22082099003|3023799007|18002099003|38070700021;
x-microsoft-antispam-message-info: Xy0n9Z8eD3AsEn/uF14oylDMhFn/5568qMV6Cl91CmncNviy2Qrm9ZNJHvGWdW4MtauSPsO2dxNbak7c71Buo7kK+Mz3489/80yjxHcMjEgabyp2TxDC/SbBeLz8S6PSXQdQ/wQMGuYuc5rryuam3udyEqjjjlDHyYVXLv1ulRtsxN0Ary3I2cupjN7Yksr/VrAcYXnkey4KLeC+v8OOTlK2nLiaZrEP3U2DDNXlGow06WuHDJVmAWMqDkZkPyVgZKQI5xyvaWlmMnHoHNCuZ8s0aNAP/BoqU6as/Cg9Vkn0JB1xBPwa9MtA4OspNP5Gr5/yOF9imnqZ0+iHU5W/AnUXS4Z3tjC0SX6QQdfVjXeZ1me79RadynBtn02EcBkFzf78O+3r66ilhtDPx3TYsNr8ngzfEWhiSa6JML5p0fJHp2VZTSkE+b+Q2wlqlklV/4HIjFJhqjVeryxQ9qzTwEgyGzggZJnJFpIm6cx9sH+1RyNrIc4o/x6YrDMt3tjiOifdd8AZl5Ikaw1k6nHjpwbhcl+K/sMAnjz49q1k6NwVhUTm4AdR+4QSA4xqA6zOQWTx7NlAWaYuNvSgxzaJs/ztGHlNhc+D4MR9bkOuAM5Rr4DmwvCu0EwR/8aihdRl2q2S9pZUz3OrQZ7G5yCD+Bo02v6Izv+mvbm7e3b6VXS2vsdXWkOxu5a+HJPcCpLI+Gj/yo0kxAsMjNil/7ciy0J+sRJn8L71+DMa/4nBsts=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(56012099006)(4143699003)(11063799006)(22082099003)(3023799007)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HyRDUT8a2e/Sz5pjKhnemszClHECs/kH0EptNrGESbOEvbpIGF2z+M/8TmGS?=
 =?us-ascii?Q?dMjYS4pYiuTbTRtuYDR6Afd4zJ8mshQG5GRBLzYHG23nVYwbhJlNhaUyh/6K?=
 =?us-ascii?Q?742ZWNkypyaMQPeH2c6bvlnV/QxzzDNPyJjcWRyxu4Jrj40f1PbJJ6QCBr9d?=
 =?us-ascii?Q?KOvmGgffXRGl2gnscKsp97zuqgU2S3pRbga/h14fFXh9kcfjjdl5O7kRZj3o?=
 =?us-ascii?Q?znZfphvqIMcHT/1Uc5HT+PeB/J/cZ7qUmm7RzR8j9Gyo6XuzU5I95Ruvzik1?=
 =?us-ascii?Q?I+PQscM2nB8QIKu2iEaHe6lmu1WWT182qO49XBeLDckqRGyfRCARFJujXcfp?=
 =?us-ascii?Q?w0qPZGINNl3z8FewhyjhbHfxtPMN5OHp8/69GsI8W3d/NOCyG/q9McOMlVWt?=
 =?us-ascii?Q?33UqFdlMgUvyUyDsTZW3AK+Ch1cyQFR20mOpFFG1Jq2n4jA5Baw6rBcQmdeF?=
 =?us-ascii?Q?CvBfXU6sh7UgQCxpKgSq+RV8bOM0t/UHKgjMcjUGb4hDR3w1An0oYrTUGMsN?=
 =?us-ascii?Q?Jrkg09Tk9wiXFT6WaDT9/UIpDLp2lp9zyzt19iqA9fPmastXjTNi3XLqndbz?=
 =?us-ascii?Q?qtzBOeBxjIOZxDCOeyCA0Py/DvZSX/HQToQQuOqydWh1tx7as3s02NPZDTvF?=
 =?us-ascii?Q?xuNfQ20stmbcJ4gK4HFBCrk72qHu+a6arO2uCLyp8K3/RnNyW65qVZ2ENdWD?=
 =?us-ascii?Q?qThz94JjYg8rm/LLMt0TfFt27S12A3urHXZkRsPhu1JCVtBmK3Nezn0h4qyB?=
 =?us-ascii?Q?0VN7a+H//ZK2vzQbBey66xPcVwftTMD0zhqwCiUGH9czW/NksrdWwKfeqNgg?=
 =?us-ascii?Q?vAv7Z9iZTp1I+hen6PYum8HQisT9lTRFdWcrgno3oVAcPHwQ6Y6IwMcVUVEm?=
 =?us-ascii?Q?tn/KeI7lVaDAO2euJRiqIxTNf+zrrK5EathpEaFxrR8tnNIml0ia7o14Eye7?=
 =?us-ascii?Q?BdCmuvV7X9hcQZqPXjSJLROdNf6wUHR6XtZ3DSEdquj3cELGAPrvE8U84jfL?=
 =?us-ascii?Q?927dJsvNjzoiRA9J+0mEIl8BE2yWo6mDRCo/Dk7Q4VaZPdYlcwaaIKTkrY0G?=
 =?us-ascii?Q?6q6SMHiA3Noz9TX5GimhcmfFgyy+e0rXGkirVKSSdXgVN7gSPtFi6EPcbHRJ?=
 =?us-ascii?Q?PGsYiMOwdrvVJ1yIiMW4GzslEtRadF4HxhQ5BijejB3wWxXdzxulfELsa/d6?=
 =?us-ascii?Q?FKIL9MhFB/HZ3090DRf+CFJS4/yztbtpaFvXl24s1m4StcnOmXxSV8Zv+Ig6?=
 =?us-ascii?Q?fPKdoowZwrSyE8PUp6I9aHTWXQb3Rf6lQMNxD0P3pwjzTDXWtb1wOREr0MHC?=
 =?us-ascii?Q?psGyyMlJTvAmRVvZx37Cr/1Jmnf+7+05Fq96M0hVdq4I10BgTAArlvOk2oyw?=
 =?us-ascii?Q?2p0u6xOj/IEs0yMs2TGSnelV7Uf5OjUa0SkErV92XGnrCgBpOrTt/c3LfWeb?=
 =?us-ascii?Q?OisX7n/BjOqudbQ35RVHqZCD044OE/Q1Id60JreInnrv6ZAFoVYiKGGzSlfj?=
 =?us-ascii?Q?TbWde06bdjsY61uJJa/R8FS5TCaiLVBmAsRwG+96JKE4XE0oXsHpZ15k/Wjh?=
 =?us-ascii?Q?if8cCS0LVs0YpCebloj8MLPL5toWC77Lo8H2TMjEchEbWDyZGGHBlCQ5hLwf?=
 =?us-ascii?Q?ZSiRXcTQaPtLvUQhTyPM2RhfjAV//taSO7zGuimtY7W8RRd5qMAvDVnSuutf?=
 =?us-ascii?Q?y4CTjgvzjm71vsgA9kf+dQMk9U0uzQ0CTa80uhjqkY3h3edj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gMFvuAmvkddv316Bz3sFWmL4Z3kmPQreuXzNquX3NCeBIb5k7lp9+xfCJNdFqpogK1XqrWaZ1CxgKG72MIsMKW/OEUModdvXfXMMG2aYP+xbBm3B1+afzMi2srwDVKBbrApz55kUwKSyt7Mas+136SEhYriaqXzXvdqb+0IsvJxJg+KBveKwXBkKWxL8ySdGX+ymvSumZuxf4CS+al8NJsq/W3rOIf0twl6es/29fFELlzzPNHg9OqyRPeIeQz+tVrSPeE65LwObt4koDnj3/6qPjF6WIXP8b/HQa+8shDhwiRBDN9XGFsK5SAiFBqK/pPXwAbsYoMTQrKaQjfCprg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 151bd5eb-bed0-426c-4b41-08df0a52446b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2026 07:00:56.1049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FxDVev11jsKlSFw3cKGQSFGbIHkqqYiV5CSZiX0sWEXxyzvat1X8XW/H9ICpk2Mptkuo7VKctp2fHwv4+1b/WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7355
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of M=
arcin Szycik
> Sent: 02 July 2026 16:00
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Penigalapati, Sandeep <sandeep.penigalapati@i=
ntel.com>; S, Ananth <ananth.s@intel.com>; alexander.duyck@gmail.com; Nguye=
n, Anthony L <anthony.l.nguyen@intel.com>; Marcin Szycik <marcin.szycik@lin=
ux.intel.com>; Cao, Chinh T <chinh.t.cao@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v5 09/12] ice: program ACL ent=
ry
>
> From: Real Valiquette <real.valiquette@intel.com>
>
> Complete the filter programming process; set the flow entry and action in=
to the scenario and write it to hardware. Configure the VSI for ACL filters=
.
>
> With this change, ACL implementation is complete. Filters can be programm=
ed by specifying the 'm' value of ethtool ntuple command for currently supp=
orted fields (src-ip, dst-ip, src-port, and dst-port).
>
> For example:
>   ethtool -N eth0 flow-type tcp4 dst-port 8880 m 0x00ff action 10 or
>   ethtool -N eth0 flow-type tcp4 src-ip 192.168.0.55 m 0.0.0.255 action -=
1
>
> At this time the following flow-types support mask values: tcp4, udp4, sc=
tp4, and ip4.
>
> Co-developed-by: Chinh Cao <chinh.t.cao@intel.com>
> Signed-off-by: Chinh Cao <chinh.t.cao@intel.com>
> Signed-off-by: Real Valiquette <real.valiquette@intel.com>
> Co-developed-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> ---
> v5:
> * ice_flow_rem_prof_sync(): reset profile extraction if it's unused
>   after removal
> * ice_ntuple_update_list_entry(): add a missing ice_fdir_rem_flow() call
>   for ACL filter
> * ice_acl_rem_entry(): set err in loops only on failure. This way, AQ
>   commands succeeding in the end won't override errors in the middle.
>   Final cleanup of entry index will now only happen if all AQ writes
>   succeeded
> * ice_acl_add_rule_ethtool(): remove old entry when updating an entry
>   (same filter location). Without it, old entry remains in hw after
>   update, in addition to the new entry. Repro:
>     ethtool -N $PF1 flow-type tcp4 src-port 8080 m 0x0fff action -1 loc 5
>     ethtool -N $PF1 flow-type tcp4 src-port 9090 m 0x0fff action -1 loc 5
>     ethtool -N eth0 delete 5
> * ice_flow_acl_add_scen_entry_sync(): free hw counters in exchange
>   actions and if the entry is being disregarded deallocated. This was
>   previously done in a later patch, but makes more sense here.
> * ice_flow_add_entry(): same as above, move the change from future
>   patch here
> * ice_flow_acl_add_scen_entry_sync(): store entry ID so it can be
>   properly deleted later
> * ice_flow_acl_add_scen_entry_sync(): zero e->acts_cnt on success, so
>   that ice_flow_acl_free_act_cntr() will be skipped. On failure, free
>   exist->acts so exist won't carry stale counter references
> * Commit message: add ethtool command examples (moved from patch 2)
> v4:
> * Remove last side effects of using struct ice_fd_hw_prof for ACL
> v3:
> * Cleanup comments in ice_acl_add_entry(),
>   ice_flow_acl_find_scen_entry_cond()
> * ice_acl_rem_entry(): clear entry from entry bitmap only if programming
>   succceeded
> * ice_acl_rem_entry(): catch ice_acl_scen_free_entry_idx() status
> * ice_acl_add_rule_ethtool(): add fdir_fltr_lock around
>   ice_ntuple_update_list_entry() call
> * ice_acl_add_rule_ethtool(): catch ice_ntuple_update_list_entry()
>   status, add unroll
> * ice_flow_acl_find_scen_entry_cond(): remove inner loop when checking
>   if actions match. Previously it was effectively checking if actions
>   match *and* are all the same. Note: ACL will always use 1 action in
>   current software implementation, but it can be extended in the future.
> * ice_flow_acl_add_scen_entry_sync(): set exist->acts_cnt =3D 0 on alloc
>   fail
> v2:
> * Use plain alloc instead of devm_ for ice_flow_entry::acts
> * Use FIELD_PREP_CONST() for ICE_ACL_RX_*_MISS_CNTR
> * Fix wrong struct ice_acl_act_entry alloc count in
>   ice_flow_acl_add_scen_entry_sync() - was e->entry_sz, which is an
>   unrelated value
> * Only set acts_cnt after successful allocation in
>   ice_flow_acl_add_scen_entry_sync()
> * Return -EINVAL instead of -ENOSPC on wrong index in
>   ice_acl_scen_free_entry_idx()
> ---
> drivers/net/ethernet/intel/ice/ice.h          |   2 +
> drivers/net/ethernet/intel/ice/ice_acl.h      |  21 +
> .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   2 +
> drivers/net/ethernet/intel/ice/ice_flow.h     |   3 +
> drivers/net/ethernet/intel/ice/ice_acl.c      |  53 ++-
> drivers/net/ethernet/intel/ice/ice_acl_ctrl.c | 256 ++++++++++  drivers/n=
et/ethernet/intel/ice/ice_acl_main.c |  31 +-
> .../ethernet/intel/ice/ice_ethtool_ntuple.c   |  51 +-
> drivers/net/ethernet/intel/ice/ice_flow.c     | 446 +++++++++++++++++-
> drivers/net/ethernet/intel/ice/ice_lib.c      |  10 +-
> 10 files changed, 862 insertions(+), 13 deletions(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
