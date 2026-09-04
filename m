Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3069B386568
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 07:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788505256; cv=fail; b=YzU+IJkxUjrP3ETRu2/cabim+z4dN/ZUytu1aTEy0NU68o8ji8HPK/EeXV6XTRjHqiCd/0ub7Dg9C6olKKxF6lpQFL3GTRmsDgAyRzAWKCIgDNhV04GIl6SCVi1B2NnHw/0K74S9ehAmwKVkxycyRa+FI9G93pW+Y3kzruJHHaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788505256; c=relaxed/simple;
	bh=BbTHNny3I2UpXVj+iy9pa3KQ6rB2UebCWRPeEGnrfpA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gGNT9UhRCoHNk6QMmAmaLCZrrnxZGnW9p/3xWGHuem3DFH7Bvhtea3r+jpr1M07FheMfYv8gEb91nD61dzFBm1MwIT8ca6/00aCmq4kA98kTTmfHCefmDyTANfE8qpduAuY23omxkNft1lzRreGr1QkTQPCTCpRsYdOqEk4wjOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AjkmL0+g; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AjkmL0+g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788505254; x=1820041254;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BbTHNny3I2UpXVj+iy9pa3KQ6rB2UebCWRPeEGnrfpA=;
  b=AjkmL0+gdi6dnHICH/A5dj9R6ZxCiORj+qVg+FPbUOxf9E0dbK7sndQ0
   /BoUbpXHfRTAR5HlgfizRjKtr93TghB4TxVobfbKrkkYPTEpoxLnzjVoc
   JUYrD4WJ7tbHTqo6MvEejlMJkp34vs+fVthq9ARiICfuRctJ4UYsG98Vo
   D8YPq2tmCJkrYdVhFKEh9SV1bY35ZhAovxmY8xc64gwM80izLh4p4NG+W
   psqu9l/tPBG9YTh+pjNjPwG0t81gHCMH7dmpOJiOkYirUArlCulzXkxYo
   vqTtYrjxGiQTehRify+gNxcBY+u3Bs9IDJV/633wCLV6ZGJ3QKxK481oB
   A==;
X-CSE-ConnectionGUID: 0PNeYxf3S7KhgJ/RaoMi0g==
X-CSE-MsgGUID: l2htyDsSTgyEeizhIzGc8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="89123670"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="89123670"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2026 00:00:54 -0700
X-CSE-ConnectionGUID: rMogjGm8SdmEEDmLx1ziYA==
X-CSE-MsgGUID: Ot9u5UgAQzOIeJRKras68Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="263760205"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2026 00:00:54 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 00:00:53 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 4 Sep 2026 00:00:53 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.42) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 00:00:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QY3VK7/UaMgmrU+RuYMR1OtkuSQO8z7v9nlx5ishEREQydOCUjlmNeLTf0AjLueSNvQKxcdboWC+J6O2LlDt/iR25ZlDrwVniJnw6v1VkBFIjsYO7W1C6fNJmlfZARP+K1jtdymhPFmYSQgH8tnN9kNRj4xX4bHTCXN4iKdrqFYfJ6395wHMcrmeMG+BC3fC3yG6kCs0sWZpLfrqZxWlgSt0lsLyfVCbtaXGy6rzHfIlfjaWd80p0MrMxjVavXarYa/9S64zOLKDIm43wFLoRPmWL2P80DMI4jlP15XvextlGffJGiXo77cIwqcmSyNPDaf7PQ/FLIb314MPGp0pyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wRnjYdeTuHgoAFi1KOk7J1Z5c0tmNxvZ61X41U9CV68=;
 b=uVRJ/6kbFQPPp3L5QLEjCUPcDqjwPviZ5fu4Kq8d9llg6g6OGgfh5nnp/ptB2lzJ55QJFJPs71XysYEqAIeYs8uOUW9wsPGZCync5mIv0UWdhNjA+LxqJAjW3PaejEiYnJrbxvkt5a8esNDXClDAvWkg2fkO/9fBD0jYfXOhHJYfJ1HlwmnTjeQGzA18JfsoJpLggd+7JFZEfN7vBZK/RSgvLYMUDzrPA0r0/a+h7YOS6rl03R/hxVoOjhhm2fMUdaDnHaTy24xhtrRXZalMVkCT+kbJ89G2x6D9oDhlrAHznUzHbnDnFcAa5xdgyywIKlbS3UhTuTF4r1SYWnUgeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by IA0PR11MB7355.namprd11.prod.outlook.com (2603:10b6:208:433::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 07:00:50 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%3]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 07:00:50 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: Marcin Szycik <marcin.szycik@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Penigalapati, Sandeep"
	<sandeep.penigalapati@intel.com>, "S, Ananth" <ananth.s@intel.com>,
	"alexander.duyck@gmail.com" <alexander.duyck@gmail.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Cao, Chinh T" <chinh.t.cao@intel.com>,
	"Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v5 08/12] ice: create ACL entry
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v5 08/12] ice: create ACL
 entry
Thread-Index: AQHdChZOr9r2FM5drk2R/gP82J2Z3ra+VF5Q
Date: Fri, 4 Sep 2026 07:00:50 +0000
Message-ID: <IA1PR11MB62419A92839BE85BB75C834C8BB52@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20260702103007.97020-1-marcin.szycik@linux.intel.com>
 <20260702103007.97020-9-marcin.szycik@linux.intel.com>
In-Reply-To: <20260702103007.97020-9-marcin.szycik@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|IA0PR11MB7355:EE_
x-ms-office365-filtering-correlation-id: 2994ec8b-dd65-4a88-1944-08df0a52414a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|10067099003|56012099006|4143699003|11063799006|6133799003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: z1aLCpG+KLls4h2jvCv34gzxz2ak1AOIdrIgyE9vW9l8/oW9QjvOeHDKzzpM3Y/dYHIJWuKMqECkUTEAhT+BMmbyRx2oSlBiXtou4njn9Fo7DxZHZOtzyotgqeMElJleG5Vt3l4UzfWfMSLHTgyCPs0xI6sIIjh+3/cnNFOIOdeKG9WmZ4AAR70EuRm3L00ui7XqMFLtrldtU9Syj+jVm7exrKsRnTeWZkkzI0Z5HccfuS3UM0jpB07CGHeYOoen/M7xChcJXKjUCHuZ1ZPk6467inPCwfvtbgSuVu12sseZsd4Cl8DCxTGsBHh2rD5kyqmSznI3JQ8Yw9imADZ3opE8F3sEAEsyexmGJw4YWj4Nct/YyfCydJH/lYDBF6KOqN+AzlT5HR3jajj8nk8N3ugAP99iAgWO0L0wn6SBIimwI7BzFVM68XmOMrq0/00MvO7ZgMwfzUQdP88X9/P5P38Cxac2T+twMzIMkyXMf/d+DcYlb6lIQP65CA6G4hLCaFrXgSZ5wTq2R66m+SUEc8Pn1CEC3GHWA4pXanJul+qLgkgXTmFkrPC9L3WEq+MkZ+uqztIcqizkCm8waod6+HvH4evpmy67D1dxGIXavt1SIDO2s9c6Lum2fH/LKREFahAPj/jpbx2NvxxeuyBf9rffz+SqEo7LcJFo35/lrRh4jPHoAmhcR36TmncJb81KnY/20/3FaOp4HzPwq6No1peqDbnPoDkqwWkH6bMHEd4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(56012099006)(4143699003)(11063799006)(6133799003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wn3KtTEaeLxLDr12LZsIZ/UrwhtR8IyZ1Ofi3KXrzFE8RJ9W0QiFn62KILB4?=
 =?us-ascii?Q?0ZTuNKpyf1oIBQJhi/5iIhSwLcu1OxV+jlpWqrX+Cyr3k7vJaTQKxXKdbpIx?=
 =?us-ascii?Q?f/RMdBT+ycHFpox+JwE+C97FoPuT9meRbHbJqp5OoXJDFHkUbOi5FmD+Ql3s?=
 =?us-ascii?Q?DSA6khCdSLaUpKnB6tV3UFHypYWbCXTKlEKosz4kduuyHF5EDFe1uFevT2/t?=
 =?us-ascii?Q?Tj2beVrIMjynRYm1Hhg55Dq5+AQgzoYzLHbCv+oli9W5rb7rH/yY0GTJueYd?=
 =?us-ascii?Q?93msZdLXu28Bqfa/fnhPOKITGCwV9GxC7vagH+tBH6EpCX5UoG5RvHrkfHBE?=
 =?us-ascii?Q?5HxbDr/zOZn0na8FskjHLMMZzhk6MoLv2HK+d6D6pv13VmuNxx8PepavrkFW?=
 =?us-ascii?Q?UwGTqLdt83Z4R8CVsGp5CZnNxmMbXcTs5xVQKQckLJeYGL5hV0dr6G4KAlaz?=
 =?us-ascii?Q?FonTBAiwshX0gjdUNkh/wHeEPPa/QktdSQtswKTI/uWQkmdZ42539l1Wdbgq?=
 =?us-ascii?Q?klvo7ZZ8ewBu1Fg3xY54hkZpXtycZnMX7FVSjnWELgue/u2mPra+Y+IsFQfq?=
 =?us-ascii?Q?N5R9C+oJh6za4UfF/7688M8/+EwgtyqUoFk8DHWs0oi0+B6ZVY+YKwftT3n1?=
 =?us-ascii?Q?99NS5FWODockaAZt431bdFiiFc4ADVM8l1OwawQ/Zc9jFQiOu7Ml3eJ9WLAh?=
 =?us-ascii?Q?Ru+FCvfibFxnyVsmKoCyrf9cXM8byHpQC2R7yArRF4i+zUSSOljiNe8n8B+n?=
 =?us-ascii?Q?5HdEHS4mel4a0aTRZdttQiv8GJ6sKRx9m73o7ReCOIG3eqY8mPuCuHjwT5R6?=
 =?us-ascii?Q?mX7CVGHpFGHFnGzq6L9nVVOOXD0eo8Kp2EwhEHUYIHWgI1kjXfqy9yqWiVxi?=
 =?us-ascii?Q?w+bhyqtxoVLhZq0mQsp7wU36KsuVCCSMyneJka2JNaOrtPJWaUd26RfRYns9?=
 =?us-ascii?Q?+zdcILZ26OZKJpHssZJX9OzNCyI6/gmA9Iw8B9GdpWApDzLbzQZOxpmxepQf?=
 =?us-ascii?Q?3IvFY5P0ctsVnIhPW8IOB+5TnYFq0Dbr06S617V1b0pOclSvCv619Oa/pPqJ?=
 =?us-ascii?Q?5WEr+WdQs4+D2itJ1sl6JhI8rI8uDL9sIkgGbiUW8ZqkSp/bzJaOyPjSGNuE?=
 =?us-ascii?Q?rItGanbthV0lZI+xPMQKDx7RXq7wg4MtY44FgOjjm3h3Aj8D+eZ7pffm+Un7?=
 =?us-ascii?Q?SvCzwMmqb5QdOAH28uMW6pYd/pr+oUD+Mvk72T17ornKKNciVYnxReinVMSy?=
 =?us-ascii?Q?CFtwf+xTO4EurzXdQCZu6pSFk1gPZIdLCqlQCGtnErnP0n2e8rID858gBEGK?=
 =?us-ascii?Q?7Jn0ZQfvAjRLFBkRJHyVdpbuHB06wORyFM72e6U9a0vtDwW0JZ/EgIXXIh7J?=
 =?us-ascii?Q?B7V2km9uaKMwHzxMgKOcS2V5NgnxAmTl6acivCqOP7Kmu3OCuZjts1JwHJje?=
 =?us-ascii?Q?IyAWcfKYA/q1puvvOblqF8TgZYQfETuYdwluRjIREjc54Kh5TzlPdtegWUJC?=
 =?us-ascii?Q?YVyvwLu/uutZtfY5aexnG+aqRcozxBDkhbLTWp+xbascnze+NfZaBKCclpH7?=
 =?us-ascii?Q?4XQBw1Flr7A7rooBH+5YC9bPsKf23vjXV8TYuTqVaUbgVAdfmkfJvdIH9aaZ?=
 =?us-ascii?Q?Ni+S/nIURkIo+FmshpHLNgKZhWpwEjW57AyItsxzywfRkaaYQ2uMiYvKou+f?=
 =?us-ascii?Q?N0ficZNjUR5o8lqXLC5QOG2MOPIUml4mx7yLQxWHBqqAifQ+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: px70pQSduXRwhmWJD5nffxpw7HkGufJ7TP4vIWMrU1hZgAd40L+XngRdARueCC3ffO0SkSQYvrqKD5CoLR7Oq4sIFWnezwdo81QxTe46SNElVmo+FR7a5mZ/RyovPYskiitmaCD6IdCUIaopJWJY3eFTy0MumMASGkXDj+n2DbpAJeIRYyXYqTHY/MZLvx8mSskmt0yEYG1dRUcqYRcP5euJ2HBsvbR/C8Oide7ZKeCPkHw5oXIbbrhHFVGq9jXpxx3orL946iMTcMC97xqoxfD9Oll7Oo18d0rwz4Al3wmRW1JGUj2rYY5+eNTkAwVGdBm6KWeJqjLOe8BBkYKZ0w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2994ec8b-dd65-4a88-1944-08df0a52414a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2026 07:00:50.1496
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eMvjKPxxG75raND/7k5+ojfbkzrAYfNXKcZM87yCWNoE3P4obBKtSxVHYYgLv7KDFMHBApSq0IWPeloYlFjiQQ==
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
ux.intel.com>; Cao, Chinh T <chinh.t.cao@intel.com>; Loktionov, Aleksandr <=
aleksandr.loktionov@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v5 08/12] ice: create ACL entr=
y
>
> From: Real Valiquette <real.valiquette@intel.com>
>
> Create an ACL entry for the mask match data and set the desired action.
> Generate and program the associated extraction sequence.
>
> Co-developed-by: Chinh Cao <chinh.t.cao@intel.com>
> Signed-off-by: Chinh Cao <chinh.t.cao@intel.com>
> Signed-off-by: Real Valiquette <real.valiquette@intel.com>
> Co-developed-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> Co-developed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Co-developed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
> v5:
> * Move ICE_ACL_INVALID_SCEN definition to ice_acl.h - will be used by
>   other files
> * Add ice_acl_set_act_drop() and ice_acl_set_act_fwd_queue() helpers -
>   will be useful later
> * ice_flow_add_entry(): add entry list head initialization. In this
>   patch it may be possible to have a NULL dereference when deleting
>   entry, because it may not have been added to the list. This is handled
>   in one of the following patches, but adding init won't hurt.
> v4:
> * Adjust to using struct ice_acl_hw_prof instead of struct
>   ice_fd_hw_prof. This gets rid of some redundant checks and an
>    extra-confusing block of code in ice_acl_add_rule_ethtool(). That
>    block was storing entry handle in a VSI array, but only for first
>    entry added on that VSI (in ACL this would always be PF), so only a
>    single entry per profile. This was also redundant, as entries are kept
>    in prof->entries, so these VSI arrays are never actually accessed
>    again in any ACL path. All this nonsense is a leftover from reusing
>    fdir structures for ACL, which need to track some ADQ-specific stuff.
> v3:
> * ice_acl_add_rule_ethtool(): add a check against illegal values of
>    hw_prof->cnt
> * ice_flow_acl_check_actions(): check counter action type with
>    ice_flow_acl_is_cntr_act(). Previously only ICE_FLOW_ACT_FWD_QUEUE was
>    being accepted in the first loop, leading to an error if other counter
>    types were used
> * ice_flow_acl_frmt_entry(): set err variable when alloc failed to
>    return correct status
> * ice_flow_acl_frmt_entry(): set range_buf =3D NULL if !range to avoid
>    double free in error path
> * ice_flow_acl_frmt_entry_range(): introduce a temporary variable
>    (offset_val) to copy data from buffer with offset. Reading it with
>    cast would lead to byte swap on big endian
> * ice_flow_acl_free_act_cntr(): flip condition in loop to reduce indent
> v2:
> * Fix invalid profile ID passed to ice_flow_add_entry() in
>   ice_acl_add_rule_ethtool()
> * Fix uninitialized cntrs.amount field in ice_aq_dealloc_acl_cntrs()
> * Make ice_flow_acl_is_prof_in_use() more readable and return bool
> * Add ice_flow_acl_is_cntr_act() helper
> * Remove prof_id initialization when it's immediately set by
>   ice_flow_get_hw_prof() anyway
> * Check if src overflows in ice_flow_acl_set_xtrct_seq_fld()
> * Adjust error codes in ice_flow_acl_check_actions() to more reasonable
>   ones
> * Add ICE_RX_PKT_DROP_DROP instead of using a magic number
> * Reverse condition to decrease indent level in ice_aq_alloc_acl_cntrs()
> * Get rid of useless variable in ice_acl_add_rule_ethtool()
> * Use plain alloc and kfree instead of devm_ for ice_ntuple_fltr in
>    ice_acl_add_rule_ethtool(), ice_flow_entry::entry and
>    ice_flow_entry::range_buf
> * Use plain kmemdup and kfree instead of devm_ for ice_flow_entry::acts
> * ice_flow_entry members are being deallocated on device unload via
>   ice_deinit_fdir -> ice_vsi_manage_fdir -> ice_fdir_rem_flow ->
>   ice_fdir_erase_flow_from_hw -> ice_flow_rem_entry ->
>   ice_flow_rem_entry_sync
> * Add missing entry->range_buf and entry->acts dealloc in
>   ice_flow_add_entry() unroll
> * Remove redundant checks from ice_flow_acl_frmt_entry() unroll
> ---
> drivers/net/ethernet/intel/ice/ice.h          |   3 +
> drivers/net/ethernet/intel/ice/ice_acl.h      |  27 +
> .../net/ethernet/intel/ice/ice_adminq_cmd.h   | 123 +++-
> .../net/ethernet/intel/ice/ice_flex_pipe.h    |   2 +
> drivers/net/ethernet/intel/ice/ice_flow.h     |   9 +-
> .../net/ethernet/intel/ice/ice_lan_tx_rx.h    |   3 +
> drivers/net/ethernet/intel/ice/ice_acl.c      | 183 +++++
> drivers/net/ethernet/intel/ice/ice_acl_main.c |  76 ++-
> .../ethernet/intel/ice/ice_ethtool_ntuple.c   |  37 +-
> .../net/ethernet/intel/ice/ice_flex_pipe.c    |   5 +-
> drivers/net/ethernet/intel/ice/ice_flow.c     | 640 +++++++++++++++++-
> drivers/net/ethernet/intel/ice/ice_main.c     |   2 +-
> drivers/net/ethernet/intel/ice/virt/fdir.c    |   4 +-
> 13 files changed, 1075 insertions(+), 39 deletions(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
