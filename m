Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D79742376E
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 07:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788505246; cv=fail; b=P6LTHYhE/2/iRt4FJibhdfHRaBebcNv4JHPRFKDNLM8hYWVv59/4t+WEiaY+rKcckz6vzYwZbwI1uyMg5/wd+g+tmeBcNk5m+0DGMfZcBaelhvcQx7ImumoETQ0dH2LfF5FRnSw+G6GZVWzTUMC/d9p/fCAr3pbqdG+cmGXlj7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788505246; c=relaxed/simple;
	bh=z3LKNAH0oPKeO+TsGYo4MlwCkIIplqJcL3NQQPeqooc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dKAH8k0qQt4+e2NPVx0oWcFxD/QYeoR7IpbOJnRsXRY+dxNl5WnEi9h/RTYEIMnr5CZ6ZhImg3WNZms18gsdYrZLWaxr/hea3ZF5hqDZmw8GhJ4dk1aWRNf7ekZ5GjCe+mC0JWDVN0+o4dGz0O2UgQxByKLrIpLs9bPp3G+zBA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E5HNAksF; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E5HNAksF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788505244; x=1820041244;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=z3LKNAH0oPKeO+TsGYo4MlwCkIIplqJcL3NQQPeqooc=;
  b=E5HNAksFemuRr2BbSpUCdB20EMX71RooYa9LdALN7skprbtYMn586i1/
   lqD4snXEQMYcj6LhjBeVfhSMmYcjMum8GcvhuHPPVdleIoXpqQ5q/drcv
   GGsup11O9HTYA7AJcF0pF6Kaxnjn0zKU5jCELrfgIeoDJzvLL4MkDSKFs
   yYxmVO66I/D25/0X9kq8zr15t3iflfSKm0OT8D78KD8VKcct+/6WLpd4G
   fsSmpnROBBneNKRu1tQspBGJkKQUrESnSC/OrA+25fP/e2ue2RunSTRrN
   mrtQjrLY2B25afGRu7FNCH43pgxIXznDZcSGOjnPx7/44vqXJuGJXUo1b
   w==;
X-CSE-ConnectionGUID: 44DzEa6BTU6bsGcBbH2onw==
X-CSE-MsgGUID: Jtapf8JaS1iCI2cPfnYSIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="91514582"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="91514582"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2026 00:00:43 -0700
X-CSE-ConnectionGUID: +dExi0bSRVm6yePQRpS23g==
X-CSE-MsgGUID: uA35sVnxSuynjTwu8M1+Rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="294846931"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2026 00:00:43 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 00:00:42 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 4 Sep 2026 00:00:42 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.69) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 00:00:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hJJC39NWOBIFLBfMNZQZoyVXe9VCkwtxn6vYc/8UymlAphZlPwKZhayPxbsAhB7Absm7B1nOEyDS5zJq6cb+Jy0USgQ+RPkrYg+CyPQ3aH3xYauyN0AXV/s+3te7xTb8NXb4oNaFh7EXNBA1XibX4z5Si5QyWvUs4lnw8bJKRUt9XFu0x9a+PwBV0KNeWu+IYtwQNIPRBmNMuGLySobWT9f5sr16zhzJfs9xCvQQSPf8HMvXXZiXX8aZ7RJv7zeh8pgrYkHF0wJsjOejrvUuGpB/AA2mFqt8mtuntV6eHdSY/I8cZZjrdyH/YkE29/mGloVWLwtFgR1RPUYuKdvfEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mk8+IaCwB8UeGssxRJLRd1doAC6PTGXg5e7irJ+uMTY=;
 b=R9jsQx2d2ucu83ZkMeBB9g4ouv1XOG7p4lmqCaLPro79/xl1jnC3JxLm3NxmXxAqXnSH1/TfrraMpwYxc2wfYUkvG4ZpmIMo+z3UN1W7GtCFvrttqwCdv7k+WKEsaGrQOuo5LmsHpocbJF257G/Pw3HHmL0xdwGX+jIrVB7WCXlfOOS1fIl0Zpc14VAoeh1OhDjMP1smIbaTMiOcboVDAupSlQ4uG/75mfzp65D0ZyIGaeue0KgkV5X9+gKGYqNIQLtEd7SqPjXJckXusZQLN3r6bdYOtKeb5V81Vo0JM/WPKqdDlL43FBICwmu9YHyW/mJUFQVHTZdo1hqL0sttow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by IA0PR11MB7355.namprd11.prod.outlook.com (2603:10b6:208:433::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 07:00:39 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%3]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 07:00:39 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: Marcin Szycik <marcin.szycik@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Penigalapati, Sandeep"
	<sandeep.penigalapati@intel.com>, "S, Ananth" <ananth.s@intel.com>,
	"alexander.duyck@gmail.com" <alexander.duyck@gmail.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v5 06/12] Revert "ice: remove
 unused ice_flow_entry fields"
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v5 06/12] Revert "ice: remove
 unused ice_flow_entry fields"
Thread-Index: AQHdChZKQ0XE+IupgE6In1m2XWxLT7a+UqKA
Date: Fri, 4 Sep 2026 07:00:38 +0000
Message-ID: <IA1PR11MB624194314E42A737B653E1EA8BB52@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20260702103007.97020-1-marcin.szycik@linux.intel.com>
 <20260702103007.97020-7-marcin.szycik@linux.intel.com>
In-Reply-To: <20260702103007.97020-7-marcin.szycik@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|IA0PR11MB7355:EE_
x-ms-office365-filtering-correlation-id: 240cfa17-bc5a-47bd-fe48-08df0a523a2f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|10067099003|56012099006|4143699003|11063799006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: tgJwwOQH4FT6yw+PGm8XF1JFWpaiD7VmIfQ1RveK0xsa5o+EEGqkCxW6kX6Tynm/SvwmkYfD2KV1ZNCfuxtQqkJHrqFL5CGeqgRDbyvRl+xTGOs4YHQBUCyYP1QaTyoGSglJ4T0Gp9twprhg4igVZhKAcFSU7RVwGQ4Sudc0Sh8xgFtCTPdfAEVsphl3URjJBB35mJDHPmumn3HIrFEo5mSUeWoG35aVYMoJ82/taD8v8bYMBUbDamSIazKhcAep2QW+FG3SrLGEenQfq325p4bnW/3fLh1B/prn26saNHB7YBEVl0b38sMSsfqv84deKYqSp7i6+b/MXukVK/1iDoRQ3RdmRg0Gz2y7RvFCoDe8FBG3QsLozHoy/dSU7Dw0PFW84oDJSyIV139GHe1AuX00mxzeo+WckCMC+BA6zqwsZ/gfztPPYvTexl9yRsQtWAq2XH1I44yVwMt5HA3llVg4QUyeGp+IgqmUIg2Rp9PEB4ZbfIjmxOpeTJSrPq/a0Ro4i5nR9qQUaDRGpqsVQfgKqQzIVRDvTwz5ca72/tzMfo5YfnUb9J3kq2aNI4fbYgUCk8ZZuPqdDv4NPe4Cda8Q8AfrvEQP/AD1jZG+1Pw49vhnNlRttps2C4WytKX3/cCTLWSev3F81tP58oQW1zAMtWVeAOLRp06LWbNZD1g9enbAny/hPolnJLngfd/UMClKbyJfPdZbAdxa9upWzg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gtlQeJ8lM9dMmDY0tVQ4KZhZa8L0vLV47fPFgW89dZH04lhGNh+nQOYdA15f?=
 =?us-ascii?Q?4GNZ+h68QFbO4SyA7G4ArxtSOjjIdW8A6NZtmg8j4JBIBUcWHFKh91UmnGXJ?=
 =?us-ascii?Q?hVft6MbHfc8iCjPDhkPTECO5dC1WkmHGrbmovtIQYMo6uNynCOWz5QIo46xG?=
 =?us-ascii?Q?i5G8vgYKYq06ssrcr9EKAyeJmVZPR4Sin7/8tFsb1xEg6c7bnEbINceQCMhE?=
 =?us-ascii?Q?3rIR72wvefHxDitQPrlW1SEzJqkQFdUUg2WX2JPu+FU+kC3K00c78MmQpsY2?=
 =?us-ascii?Q?xlW0P2JJBfdmJcJ+07L1XJHcpsyCzOK/ct6iZcnRcdzFSaCPc6KGjsg37qfN?=
 =?us-ascii?Q?Gs4/XUwqnaqkAQQlvSSD0/IjmITHvEkDVRBXcQYyMhqznW7/nXYjAX8bB1tj?=
 =?us-ascii?Q?jmouBoSHwtS9CTV9pe7BcYducA1mOQtDBgDGBGE0dAfkgzUVtMYwhTaz//eY?=
 =?us-ascii?Q?MnUG/1wyxqvd1oUTmMt45yMJ0gIvkxy+yJgwOF9oP2YqP0ekmndCks1BBlvM?=
 =?us-ascii?Q?JqyVrbPqtODcs5l6g/nG6VxUE3LzfbYADJiwLrqNWioDzkAGdTKkF6vBYAJw?=
 =?us-ascii?Q?UB8Kw8Wo5ZAwMkLJAbcYnDQw5/OMdW7SNkIh11v97zhTcXMukdoCPzh4Lsi8?=
 =?us-ascii?Q?Ds6VGGHfSgEgefUonDTC22HRj13JO6yjyi2JTn30iGRoY6mvGfDUBIbD/NJp?=
 =?us-ascii?Q?+PGUgCiku+plyb+sLBrJUb75iIfpeS0sUVPe62Fuvz29HuuVmSSObF7WPrW8?=
 =?us-ascii?Q?dK1xyTaAk/lSHHKXcW6yk2VFdUI4gmpP7+TIsUT5YoKrecFS+Djvz4gHs9nw?=
 =?us-ascii?Q?u32GEhAc9ENhJo7hye4zX/1I++JjBz9mx/fz60w2+DUPbwiQ64iCRDDu/lZZ?=
 =?us-ascii?Q?UjKqdDuRXjEglWSIluDHpaQ51rP67wA/RFUWreGl1ruFcS+dgDK3F/aQJMWm?=
 =?us-ascii?Q?vFj5JgrZxbS/hguWDilC4A/8ZL/smC7k+F1Y/v2OnSeia5zmslrhFeKGpynE?=
 =?us-ascii?Q?Ys7oRmTDIllA7F28Lipu9tEMIMHu3AVYpOp411p+/xC2/EW8nU4V6yEduaLq?=
 =?us-ascii?Q?07mh5LjcrkLB/A1efWU5SzUb7vg1er5mNy+mFAo2MavgFUNqel21/A4F8dq0?=
 =?us-ascii?Q?fpiy4NWOZnXsoNDcd86IaI7aa8d3e+zBit4QM5NU2wXsICikbRK/ynCGX9bd?=
 =?us-ascii?Q?APkJwpn7QzsdY3GSXOY+QwUl8uF679K3ZeOX0AScH42TbGNiiRBffa5qyM8Y?=
 =?us-ascii?Q?riNoYUl9JpRYOs6P1C2j9uzkeSXvXoLmurYsmeU9LFHdqVhDzbx7N1egPe47?=
 =?us-ascii?Q?Cd0VDg3xWy8mIiVt7VxypROCBk8HIsNR2KoUjWaaq3YD/js01Wbl+8mXxQLx?=
 =?us-ascii?Q?3zQAKSaxCVTcYz3Pe3hZ8DbQKPcpJCnEuSbTxHBvrn12bJ7lxlvBY9iTMRQk?=
 =?us-ascii?Q?ha9uG1cBBqRHTF3itjjAfQP3agMVbDF6h6byPb0u8tKULAkgV3kEWC3d8i5W?=
 =?us-ascii?Q?rOQbkJGXpcN6c9bi/0kRItIufw7eGNNgrW54TnYFaU4yo6PshZnIAt4NydgU?=
 =?us-ascii?Q?TN/asQgBt6lmUg8VOno+uwkXCyk0Obp/MCQ7EeZfwgfJKJAVBldRW7P2F67/?=
 =?us-ascii?Q?YY+NQvX3a+BzyMc0mnl4J/SEb0sqpfRTyHXQuKvwwcGZk3ur52R0qMbug6Dg?=
 =?us-ascii?Q?VpWrLBHGAqLX8AynQb2L5cPNOGJdXUEyNodJfEzeIjUp9UDv?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: xKwazP+mqFB+e1kqOjdsQhQSj+UOSsPMX1FBjPIMuyjGSThXedNYwTrKs6vbUNVS8OweKbBxxRCUlsdBdOVozhcveD78LrOd+02H/tRfGfP/3pBCbZWSorbcosQhbPvKJTtrFTFHKbxLG12iXBDkDYdLwsx4zIJq6bqSglxvKRoTiTkiTIgqlXTjgM1KesY1qcx5VP0OtnYGVHvIkK2dC+9JikcgrIKQzwT8cdrGInsvWHDnKJwkCHVp279NVnygvDfoPmNpu5HKmHTsDyl6MGXR6Q8p8vRx9Ej6SHAtZry3SPL+K8bKMO+1shMFbhCYBLaN4KxKy+hYS8rJj3V/SQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 240cfa17-bc5a-47bd-fe48-08df0a523a2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2026 07:00:38.9228
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Anic8Li+znVhUsyX73AMz6QGM33M5Yjs+lxTBNelrVmo/oM1+VAt3eeUvgdtpumfQZTGkHeEwJ0t2QtLUGLJkQ==
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
ux.intel.com>; Loktionov, Aleksandr <aleksandr.loktionov@intel.com>; Kitsze=
l, Przemyslaw <przemyslaw.kitszel@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v5 06/12] Revert "ice: remove =
unused ice_flow_entry fields"
>
> This reverts commit 4cd7bc7144ec2c0bb27208c3bb1f153dfd44b1c7.
> These fields will be needed in the following commits.
>
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
> v2:
> * Add this patch
> ---
> drivers/net/ethernet/intel/ice/ice_flow.h | 3 +++  drivers/net/ethernet/i=
ntel/ice/ice_flow.c | 5 ++++-
> 2 files changed, 7 insertions(+), 1 deletion(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
