Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FFA42D75F
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 22:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789164674; cv=fail; b=NT82dhdJ2REw7daNJNvzTGWWdiPVvBEfyJ/iOK2zzT6ERStByLYP+Y1c6DUMdeHTDh/mWMW0xKysc91A2aD6g77kkGCUkeYW6xgYbDFLle0eOQ32uRDyOfqaf/RUlqtbgKfFbNoKFu/ys6LMT5Ygyun6tq+s2JAHRmcJWlADlOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789164674; c=relaxed/simple;
	bh=vfNwfLLSfUYTidjYV6wJYdWs5UeaeRXIAQs2axnm/2A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kL/PCqy6epzI/68zWGQGEG57YHwwDpnxnK7TGC54ThdGwT/cmOJ5woyF9ZdA5cCH3VTCJeNihTPUuMOF0ZhKIBx5Oi0zKiaW6jmIh4hwm0IwQVsRuUiqosi2j8eGQ7Hnf2LPunJ/8Aoi0UngwPKZB9H6zkB9HBQeEXMRfdOZlhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B7tcCTkr; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B7tcCTkr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789164669; x=1820700669;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vfNwfLLSfUYTidjYV6wJYdWs5UeaeRXIAQs2axnm/2A=;
  b=B7tcCTkrELPnWNx/5hKxcbRNDLdcZU1X5/53tPjsFu8vxDJInIyNzhFk
   uUfmOkGPgXv7sX9KVGbJq2HiebMYJHXz61ySc17PB0JEQlVpBfFcWwZDa
   ytS/S0XbdANKlQdkqODCY8YQDLLPbab1lSzUFEQIDD+As+PR6/VuVamdK
   qXjMuJiITYu2as8z4Rya/f344M/k3uwDF8p+ipnBZ06gxJ86vTrkX9/O1
   4NJ56OevX57hJvJUrr4Zr4+PiK+cY8skHQhmdsxOK6PI+eAzRZXon/j7m
   IL7h5580StzLnceRDgcZgKMzdD1gnTygk+jha0AI9IBLQ3EEl9qPZd2bJ
   w==;
X-CSE-ConnectionGUID: GoEFRfb6QH+m3dVre6dw0g==
X-CSE-MsgGUID: VbC3UQNcQFqSyoe+yxe9ZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="89472419"
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="89472419"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 15:11:08 -0700
X-CSE-ConnectionGUID: JHcwptmPTLG68Z+BwwgGYg==
X-CSE-MsgGUID: m6Wd/+wKTW2reqDGAXYUMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="272010249"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 15:11:09 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 15:11:08 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 11 Sep 2026 15:11:08 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.22)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 15:11:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KwBXhrM/OdF4H/xdDdZo5gvIN4t3dGpTO2Ef8LW9JMe+7Ir8+6bNk0BT8yNM283KjJ06YKO4uincu9+1+7DPv0D/PIh3aUS6wja5EjO1brCDVBXzajhCWwfINoOZDMq57Qh/4PxGeveIGSGebRRUlfLL0WfWVEuhFkRs5T2MDSG4uXF9uNa3+/Wqa8JePgQuKIBTDUZI3uhWJKxMO0OYFsEYVY6VNixcJadKtVoZxtxCZ8d0nFOYkhzARzYCnn4KI6sB+GdI7LPXw5wHZ8oZim/BsMxf6cp6brNb6vJM+RhYS0SX1g8+UCrxGYj0NwL7wlinFTtTfVglrvT5W+kQbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPpWPR3h+Zy3S9RnL5pKRcIJNA8NQqPHwKjUwdNeux0=;
 b=JzezcDHWyjFYmw/+z+cUUZCzcoNWFltgZAjbaYV401iDNU0KitL1l97GTvFyu+03DjHzz4PHrpC4f1jxEHZk/ejy0jDAfvYezO/5E+rIkK9My3SlHdawdh8MJ1hfi+oJsXl/ze7RGheFKCOMaesFTFN0ubR0RPtf1sw8P6Yvohv5U48oMwp2NEgXI814Ks+PENGXrcvC7QDz0HdT7tcd5MgG2zl6iXI+7DSphvjn3VRBrod7QrXHhpLdgqInBiv8K8LGgBWpXDmTFfU6CTuBSPUwV+kY9ZkVjXOOeZSSSXjaDbYgVB56rBpJcRi92HelNhpKAfFiY6/1hYArigEoQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7522.namprd11.prod.outlook.com (2603:10b6:510:289::8)
 by CY8PR11MB7800.namprd11.prod.outlook.com (2603:10b6:930:72::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 22:11:04 +0000
Received: from PH0PR11MB7522.namprd11.prod.outlook.com
 ([fe80::ba5b:e8f1:5eb8:3ca3]) by PH0PR11MB7522.namprd11.prod.outlook.com
 ([fe80::ba5b:e8f1:5eb8:3ca3%2]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 22:11:04 +0000
From: "Mekala, SunithaX D" <sunithax.d.mekala@intel.com>
To: "Temerkhanov, Sergey" <sergey.temerkhanov@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH iwl-next v5 3/6] ice: dpll: Use switch statements to
 handle pin states
Thread-Topic: [PATCH iwl-next v5 3/6] ice: dpll: Use switch statements to
 handle pin states
Thread-Index: AQHdOVgXk5/N9sFWvEmIM3s1zmcjbbbJ/9Fg
Date: Fri, 11 Sep 2026 22:11:04 +0000
Message-ID: <PH0PR11MB752201ECE05556C37ABB6177A0BE2@PH0PR11MB7522.namprd11.prod.outlook.com>
References: <20260831145005.191040-1-sergey.temerkhanov@intel.com>
 <20260831145005.191040-4-sergey.temerkhanov@intel.com>
In-Reply-To: <20260831145005.191040-4-sergey.temerkhanov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7522:EE_|CY8PR11MB7800:EE_
x-ms-office365-filtering-correlation-id: 9ab1fb5d-f5b6-4948-42e3-08df10519270
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|38070700021|3023799007|10067099003|4143699003|11063799006|22082099003|56012099006|18002099003;
x-microsoft-antispam-message-info: qxCmWg5jQbxmWtbEkhuPkJu1M+zIhd/q3QFLaUo2yfvt6eppiGh8xBYyoOD23VjqKv9fquswqPmOtHDt7181CVtP3pi5kXuJJvkLy1WuWaJKlIpDGxVWWi/zjLuCCrfzvwEd11W0W24KWPm0UB2PSQcS7PLH/gD1Xm+kWTV9HoR0imOE27Uf3iuIw3h2cMw1TWKDyFt46XlM+zMmz5iScUfG5SljTaprhX83PrGp+Y/d+aeWL4yDqYpBdAINkXaz9abj6sfOJm2qTe69cgOe1UUDDq32iNR9YMbOAkavA5AZexUd8BEYG9lYyNPOTlCl4jaVsE6qjrXwvUj1OMcl1n+nHA6gK9q/GmFRFVa4bZxPRV/snWFxo1SeiCe6VmcqDtosmlATfWr+K91MtRAiFE99HPdjKB10N70idCQBvdHQadZ2oWU9uzd3aESglVoL5pUCVzQ25Jo0gDU/50hzALxl2rAJZVlGI4GZThgED98TC4WkC1wCrwZ2fGmJazU1nne0ueXmcIZia6lOsb2bMm9+XexIMAaPSt1kTLiDaISzqGzlFJ8uq0qBKi9cpUI/24QJsQDj25KLLhscPPMJ8UKU8bKgv2WPtS1vl0g+fqjn/3UXuuYBuLz+HY6DGw3sQVACCalL8DpKx2i1sgH2iOEeAk4BLeNZjf3WJMGHqu+J9oQkwlWLwS3d48HuXbYcsB+yRZCFz80HhEaK5CuRtkPo5tS/PzeUYGcUuxzpIy4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(38070700021)(3023799007)(10067099003)(4143699003)(11063799006)(22082099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sfOd6AUpUbQ3O+qx5Ce2eSb69glk2Bwn7Sma6mjutIbi7olNv8DtdyMBh62Y?=
 =?us-ascii?Q?WVrxeCkB8B6Pemed0rfzdPKpC5+gCJVu9Z2JqPSI0MgJ8UGeeqiXEQLL2rgJ?=
 =?us-ascii?Q?DXKD1U8/srGoQsTtt64NtMwlDu1HXRqpgBWLrRf0JC6oK6zRf3jjjLAvz+cY?=
 =?us-ascii?Q?aQqkzi/R6oT8j+sbO2W/ldfyoKBMPE+fptWVmHHFa111tQ4xS/PWVJu66fYZ?=
 =?us-ascii?Q?TSI26qFKoZjgdpDCKYiYgOxfLBPv1AGArpS0XUnq0E958XbUdBkVyeHXhgaQ?=
 =?us-ascii?Q?STVGN5Bj10ekh3wkj4nLYYYan90aEWqQm9ERHGa4s4LukYeh3Ey3O9KwuLT0?=
 =?us-ascii?Q?EgtBgQKH/HDBsYI8v/Xo/mUfC7In4RMWkOcPG1nBI10U6IoKvbGgST/72nqN?=
 =?us-ascii?Q?1AtX0qGT4/XLyW5wV3aoSzfKNCLp4NDD1bIPZ9sN59B2vz2eYr+bwiz4YxuI?=
 =?us-ascii?Q?Nhcrh+pA9TZqL5ZHCD8jYd1GqJ419I3r0SXCT9mhLiRTW8n3LFMWeyJ0KzL4?=
 =?us-ascii?Q?mtmTImJWIggy6uY/fypXDYF3FbGq9sN3jaF7SWOKFdfVU58DXZe/tG5hdV6s?=
 =?us-ascii?Q?C9M+0jUcM6seAP4uQxS/fX0/ml1EVcp8DKUsD8h7+AwoZ0Sp0Nah0Ileu6kr?=
 =?us-ascii?Q?T6q/2agP7C3KyDqPUFgyQiVUBX9QGJYz5Uv+BkBN/3LuhB2hJsXw0lMcu6Ql?=
 =?us-ascii?Q?RCF3iEkXBH/7B8TfT54wlxdy0CkaYTJKrBBE2ycS6jmVyVNvlWoy30VlRY3J?=
 =?us-ascii?Q?p8YA36ueWij3fuWBckXMj/0mApklJz08SR5CzAdPaVx372B/fNlS2rkxeBHi?=
 =?us-ascii?Q?GCsQs/lwNmpdo/vZU9h8LaF1HYtB1sfk2iCt4sxwjo9r7vq00gBSfo4Nz98v?=
 =?us-ascii?Q?DCd3wJszPlj20bnPFvI7EQV/b1Imwj1rAHsC6n/YokXtKmNS0GMf+Zghfj6F?=
 =?us-ascii?Q?l0Dm72QCaBLDV72Ur1OSNn4B9SAFV2s3CVqeu64uxfqva78huZZfxT+xSAQQ?=
 =?us-ascii?Q?UG4D9zKSkQFEvRP+++tZ5fFhDS0dWvv9Ua/mg0ZzMWMIVm8AG+mclhsaRS4G?=
 =?us-ascii?Q?1v2+y5IeByGo2HisT8P7Qc5qfrA7lMJHfzhAbp3WKLJ0rYUWWWM57L3edq0x?=
 =?us-ascii?Q?VSXh6n0jn0EgCwXa9X5ljfu6u8vXHPrzJSo2KkcKnsZ7DkhGp2mw5mWVP/TN?=
 =?us-ascii?Q?+nmAT0Vnaz5IXpo8dQGuMzG9P7kWE1N3mJ+zhIP8101nxUnYhmWUB4IsRXP0?=
 =?us-ascii?Q?gUWuDrTr+XvpU3SSXy0SJCN+Q8vE4UaU/5meqG9IortQKU+s72sSZCDzNrbZ?=
 =?us-ascii?Q?4BMpgx9WuUiJ2gxZ1tJ04AUxRzsnd6a7PALpb8SoXqQS0fe1b2OTjFX7TNZb?=
 =?us-ascii?Q?x1cIAzfmoggDp670a7tBN5tAveBU9ERwZKufgwo0Xx29zSrVadZlo3NnQ+Cp?=
 =?us-ascii?Q?CbJNo2NoK8UUpaZrhxTeEwTJCuPP9wo3Dd3mDQ3xsrYFDCA+Cui/AJAtfvgi?=
 =?us-ascii?Q?7os1UtRsBXhTrXMq8i9ZGdPfBJ2JlnneGqzm7mI9jxigqqHllnHjb6Jk315q?=
 =?us-ascii?Q?NipNS+vBJNPawtw4W7bQCXypr/9y0d/7vqGL+O7xTRNQ+2CmjqNK1GEU6dAU?=
 =?us-ascii?Q?njBpXxSCvRY/cIoAohQdO1jGPeqZY+fuDxjWWWEWNpkYIM0Eu1rkzO6eE3JK?=
 =?us-ascii?Q?+ufLaPgoE67hBoCe7ovmvL0t19fpLRHcGdhqwJPuAed1meLLyZV6hVJUAGHF?=
 =?us-ascii?Q?BfjktBrHbQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: vjkYXYClfFPPvxTRmXYSlFA1mTCMgA2O7exiuDEMHx/2R5a266X00dDBw8yEBqsyx8Y/+Y7i8bqHFwAiGyxyXSnXPzf6dk1g/kzaTsGeK214MZQnRuUnjbyKOAnDbjjPksdKmBYFtHpwR6rJjbvn6GN9DKIJy0cMZsABpnBGZ5ANp0nYZHXMLMW6DH68GGEFMyw7g0FMcYFC7pBJv0r3LrFHXpnRQCeeyER36G97L++S3jARxorpvOJZ4v3T9zTTgpQ7uZnujAbrvRWhCV2Sn5KGzYSW5Tyh1BjEmnjJ41tKdD+CYyfyTN2tH/vMBinGK8DtnC+f8WI0sIgqREfNiA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ab1fb5d-f5b6-4948-42e3-08df10519270
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2026 22:11:04.4742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: odIRno676WJK24LBfqCTtV56IDIGBCrlidJTgM2q3fm08l942caANQ1UhV9Ot+xOOeEOryMP2YDuuF11NWXHRq1WOZ82VG/H+qPe98Rum3s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7800
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>=20
> Sent: Monday, August 31, 2026 7:50 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org
> Subject: [PATCH iwl-next v5 3/6] ice: dpll: Use switch statements to hand=
le pin states
>
> Use switch statements to handle pin states to make the code more
> readable. This also makes this code more future-proof, should any
> new states appear.
>
> This also changes how direction-mismatched state requests are handled in
> ice_dpll_sma_pin_state_set(). Previously, requesting CONNECTED on an
> INPUT-direction SMA pin or SELECTABLE on an OUTPUT-direction pin would
> fall through to ice_dpll_pin_disable() and return success. After this
> change those requests return -EINVAL without issuing a firmware command.
> Because the DPLL netlink core does not filter pin states by direction
> before calling the driver, this is a user-visible netlink API change.
>
> Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_dpll.c | 72 ++++++++++++++++++-----
>  1 file changed, 57 insertions(+), 15 deletions(-)

Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worke=
r at Intel)
