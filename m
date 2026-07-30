Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A2440926C
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 13:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785419607; cv=fail; b=OGjsw92/69hbqEHlhKQbXzwtLyCyhyQCf0b/p6jXq3a8WMckBwqAbfhod7KO+klNpNnWgRuSVDSVeyCU2R3VZ3g9xjrpiKVpL/k4iEn5p9XK68HvKJQ218ks5bHBO0zUCTBUfaeB30FvgzJUYDcypAJHLL3oMuVLlHYiztPEnRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785419607; c=relaxed/simple;
	bh=l3AEGDkBcGsFgYbF+3Xuem0msW566/IZPzH2MNS3COk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FfFdkK2YAyeL8dBeesmOgtUZTgaAp8Si6PaoJpXk7e0Jb/wqonGC+TeG2X47KliWozRhZH6q7t+NRzPrQTF468E95o3HYBVddbU4Gm4v2mP1hmvvLn6pBo5AC7uypftsL0mnaB+hElFlnydO5MQUWVuV16sMRgOuo6DCQXzT1nU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KMqJQdbs; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KMqJQdbs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785419606; x=1816955606;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=l3AEGDkBcGsFgYbF+3Xuem0msW566/IZPzH2MNS3COk=;
  b=KMqJQdbsRr6FjVricGlq3y/UADV3SeEwmjQ6HPs47nB7C6zvLjuWq2LV
   bMNn0he4qw/NXdUiYXBxUs0bSUZkvOgyRa8kPEeaqTT6GC8J3jyZLpO8e
   d2GBtC3z3LLHbDfsEQrnkXF83tEhxTFXTQUB2uxHnpYylQzEqrYEJrL/X
   44RCYY3dxRoibO+/QoUV6ziLqyqz2CANYVvpkz96VfiHLGBqN3vaJgMK2
   /FrD0q+a0P0zwfljJM3tbwlEax4Lxa0ALD2L2FLe6sEyR2hln6H8MYes3
   yCn7LX+LGNRcTQHHLi64jTSRh3WbB99KbmjHgflGcNzu+rYa9I2DDl5O0
   g==;
X-CSE-ConnectionGUID: A8D8GSv1SieGaNpXC6RYjw==
X-CSE-MsgGUID: fgakUJaiQVOEHlHVah3aQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="73573796"
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; 
   d="scan'208";a="73573796"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 06:53:25 -0700
X-CSE-ConnectionGUID: UXnv1OX6T4qBTYCFPNvAYg==
X-CSE-MsgGUID: CIAsAacYSJKc6r1f5/EVAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; 
   d="scan'208";a="260918562"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 06:53:25 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 06:53:24 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 30 Jul 2026 06:53:24 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.36) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 06:53:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ToVrLmiSSiJ/X2RlWAZ7HJTCPfP30WioCrsIo5bRb5RNBbrDGBwOCCqv8mUssnnqsAer+ca5dUu9kaZ61ymeT21rGyQ5vC5swUSIZmgaNX7ZIreTUjCTI5brw03Q/kL/GrHGRgUzlIWhTQGT+ZGI/ATBrNVmtVN2Z/HQuv9DN9wvWFv/l1P8cYbojnJHpX4sbhXtKS09is1ScvahXNh8/TtLVBzyeSlNUI26hmwbiH7xqL/bbg1RLy71Urwj1qEldNoxB2seT6PT50o46hOyMKSPZl3B8I4410f4+q6vaLtqn7sOZPpsucp9hMSRiHSIK7Vhmkutd6daVhV8L79dTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=piapyf02rnLWggoMNDNCeLD61qsDd9RIL3Bm7Dehv0w=;
 b=YlMpkGYaFNWs34SUMRB+nJKBdS7kPEEP0kXkDh4iTxIXO2XjGBHWzgjeyEyKNwvasE1+JXKKsd6U0d15eOU6HER5A/tt8WcvoLDd6VXeO2ALA55Og9HTwGoEbZfejpypxPmLyTYDjsSD9APKKrGqg0lT77AQXIIEDN2/PrgKYQ1Hk71/DTGXrHuwFxtoMjY5DlUUjdbc3caTAqfC7kFRHrGE1nDxjksdA0unuIlCALg68erYBnsJwROKPtt6mt9MLWx1fVIOXKPQYSS6RNEZ/eP8fpa7Mej7YWjF87WNYNYJiCNcQz5xr2EoGFV797RX6EEe3b+q+Q4S14+61y5+NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by CY5PR11MB6440.namprd11.prod.outlook.com (2603:10b6:930:33::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 13:53:21 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 13:53:21 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Hay, Joshua A" <joshua.a.hay@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net] idpf: account for VLAN header
 when parsing RSC packet header
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net] idpf: account for VLAN header
 when parsing RSC packet header
Thread-Index: AQHdHhtqcs2GhZ/rW0y/RrY8xGYecraGGUqg
Date: Thu, 30 Jul 2026 13:53:21 +0000
Message-ID: <IA3PR11MB89867614C1641C49AAF96AE9E5C92@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260727230848.1557452-1-joshua.a.hay@intel.com>
In-Reply-To: <20260727230848.1557452-1-joshua.a.hay@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|CY5PR11MB6440:EE_
x-ms-office365-filtering-correlation-id: bca9ea1c-a8cc-46a0-e725-08deee41eabe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|38070700021|10067099003|56012099006|11063799006|22082099003|18002099003|3023799007;
x-microsoft-antispam-message-info: 5yQ0lIAH59RHfi3aMmW43e97dt3IvHPGSluMbEnANSDxRzD7sVbnD6mpacAHv72Ie7EPn1ORspoPFGDbAdyrrzOCIpxBdwQ13GWNNLCeyg1upjVlHFQncEX+nXCrI/mUDt49XsC9o4e8tIOXCj+uzYpORxZiY78DZV3a2hh2D8NMTs0eQKydsSe1WW2CzfzOAgeCU+aOwMTHE3OW6QSNc2s0zkfFvpfCgJqNVv7zC5Rc3JKEhBE4ai/wQrP0BAsbkdDIkFpCPJH+f5RlwGmFAL+u8NB9CzZ7yB0/BhQyYsr2a8n5QDRiFs6EatJ6yzDORR+OWaSbRmOszrf2pnhE0id3gKsflSUc+ojgD5S9i9X+cfy979+N78cuY4EYLVJZaml9UJZzgnZlW00V9sAKc2H9DdJ9cpCM3KvE4sz/naPhqm7RWTXExk6MdO97r2ZWZC9jpLpuHRgGfHLeA9n3Fhxw82QCp9HxJGO1zLrSTxCWEeabMFig0P69kNoY3VW/KMO7sfEggGz9EobAWlApS9GbNjgtQW8ZwRGEw8DlMayrA+vng5VpkyvQ91DX9xLeGbZosfxudyj2kBeWshXGJ7pxXjOtKQoiu+jQIalfe6kcB1TUi+UoSq9NeHIB9oeNljAiBGsYyE3TVl5Cn7mlmfm7/FevrTfn8sBBI0nVekV48fBpCEFD+LzpZz6yxOnZcVups1Zn7S+AU9TojwBpng==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rLNtlHtQ8zYV/PNB6Ba8cFr6RBbKtqz0YdvRtHE5AN2vyydYmfC9kIvD/68D?=
 =?us-ascii?Q?12gEQ1lomUzj4zv0r5dhpP4eHvq62x6UBeikhtbyQn62HezpvWPymrDxS4O/?=
 =?us-ascii?Q?LXZmRjvJwvtYlKz64/i6FO1zGlsT9KUY+ZHpERHLe+jBvNM3rdwZZItl8fVF?=
 =?us-ascii?Q?W6y606h4QTWq7hGCTcdWGupzpvamX4K21YhGM5/Ho/bpnxsVVzFnLRUXM76o?=
 =?us-ascii?Q?SPjlQ0osmHrsST4iYCKa8eYRvfENwhxKDOZTW/YY4H/9umw3r+0HWtE/EBSV?=
 =?us-ascii?Q?1wbRQa0OiaqwqRP0vngJytoQbFqwBove6U8ev/8d9P7WUYnwj1+DUSc+MLYm?=
 =?us-ascii?Q?9a0QZADqDMs1VoAc7CNUeRGzH0hUo4iQBLdWJ68mW7pVMr5pCkVp7gjiK0CR?=
 =?us-ascii?Q?bTIGQ1zV61BFDCa9ijf/EqkWVx8CgCeZL4wdDSRfwfaQpmIy1e4fP/EIhZ5h?=
 =?us-ascii?Q?xhlea7Q2Yf3bWTRZIfUqOMZYYFiPmQOuM0Qfiyka9ES44hBpkWOdmsH7/mGl?=
 =?us-ascii?Q?c0z4AzPIsdMhrwIr7VLIMns0HHZ5xfcKhsFmutv7/Mi5qdg4hY3Bad3vlwDy?=
 =?us-ascii?Q?Yd8B8kAMBX0Ia+Traa2A4aPdygG4RVe/m7eukuw/s5kraec4f0oYaXTNaIl1?=
 =?us-ascii?Q?DUMmKK3f0xmmgFscTr6jX8N3mGLfre0ekQW0GBgSwMq7KhdH5W/BB8LtEzRC?=
 =?us-ascii?Q?EmnJTf18RyWWUcPvjZXX4b2MUUw1n8NGUZhu+TXYaW5jXkUKxLA+eF/AnLqE?=
 =?us-ascii?Q?XLjfWF+iN4BKfIrOYTeRP10npkxqpiNRmIBzY1omGmbhwSDKRnF1mvhGthni?=
 =?us-ascii?Q?y+0FgfAOL3bYBINPB2SjdawRJP0acxtR9F7tHoBFA0aaRp8SCvCCjGip3ksu?=
 =?us-ascii?Q?lkKa1B1+gESB1s05RGpEGsUHmRiz8GgHGRjE3iSJnTZ2DEOuWub4mVvpn/za?=
 =?us-ascii?Q?POExbsF8nuMy4DK5elbDhKVzYKCxuu+UOjK6wgiQBQI0//ABnXl0jxqSN6+j?=
 =?us-ascii?Q?g7wOjfqvKmW3lmkjGABy8Vmc8FEfcXu1zJGGwn/6JFF54FH6d0iQK5fuxFG/?=
 =?us-ascii?Q?Ibcsnfs42RVzQld2FOtv13kiYvqXjOvHwPlUTQTDoZ+dJKG4dqlfeB4y9aRh?=
 =?us-ascii?Q?KVN1VpGi0FRTw4LKI7awJSB69yHTAFS/DJh1LqSTVF308xIrVRmNvy0bbexa?=
 =?us-ascii?Q?w2rI0KOuRQhepwhre2R1ixeppLXYUYFoE++lh/UXWWdaSUefjlqdwxM+sv9V?=
 =?us-ascii?Q?AzO6oy7mH/w8s6OWWKrOq0EPvMjhyTRyD94Tg3b9gXZCyK7C99kjIYov/6VD?=
 =?us-ascii?Q?/7skh2IAd/yxd2ZUGqwUqHPC6nHZmnVDNZygHmLBCVsAxNXXyl3zOFpjytU4?=
 =?us-ascii?Q?EvlWbic8RpwN0J0qDkBLIxUBg1AtbQExYhtyZiTFDg3OiLziEh/9vht+a9Sb?=
 =?us-ascii?Q?zfQhxvcLCpdpdAGk83PSeu89dSKNyEwSOeA/x/M0w0RXQtznl8clmOW6HLSY?=
 =?us-ascii?Q?e03f2DM5NQZ19iekB14QAh43rJLEIMo9lqsNkKFA4RBN3+wrT5lfUttxyHue?=
 =?us-ascii?Q?65oSiVHWi623tpyL8iRDiJz2ys0/7Wun+9n3qLBdBNXGk9KxdYIw5vIq12OL?=
 =?us-ascii?Q?R+JdgFdXubrIKgg0SkJeQnD2asaDQv0dj4OATuWAtctnqNJyiiVk+wuFQQsp?=
 =?us-ascii?Q?lhAWKyWEl4bNfrYNPr/TZOObRh2/xLdCVTZa153EqLsODSwuVtNsLSbQgaiu?=
 =?us-ascii?Q?hzegSOPiU/uuSa/J6/j/mwDKkn2Iu7M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: QIC0WBcjesirmK19GUy6eOTHfV6xNgCZ51xOugxXzhBS6fOIcZtid6yBR4cwxLs+ngiZARSg8atvc4kGi3otMmpWGvrzVQ3rKPXYjVqmk6hpbDrmyF22Okhp90cZAybUwkUZx/63SR++WtAiVZ1LVktAzGBqUcShrYnY2IimhdlwmH/lrIy+889ONsDhqoiv5VWRBTyX8XTDopFXFXFHYz5sKAFOyGA8/nXD53qrciWWVJD6XpWUCLAMf0Xk/eb2om99zfYUhbOvWE/TGB6da50JhcoJ9oWpHh4fAwCo3CLh7yXiMojLEbRLN1lt6fhhu5u6w3ZGIpUTftPzFeBTTw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bca9ea1c-a8cc-46a0-e725-08deee41eabe
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2026 13:53:21.1486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zpR4dMoOF08pSAn9A45LtKY7A/cuNBM8HDYko34g2XC5JzmDp/Xo2dOSrRYxCp8UG97lNAS+K/NcZYCnXxklRkBjoZyR8hLMsl3+4HDD1W8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6440
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Joshua Hay
> Sent: Tuesday, July 28, 2026 1:09 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH iwl-net] idpf: account for VLAN
> header when parsing RSC packet header
>=20
> While parsing the header of a Receive Side Coalesced (RSC) packet,
> check if a VLAN tag is present and adjust the header parsing
> accordingly.
> Otherwise, Rx TCP traffic is completely broken for any VLAN interface
> whose underlying interface has RSC (rx-gro-hw) enabled.
>=20
> We only need to worry about one VLAN header since Rx packets with
> multiple VLAN headers are not candidates for RSC.
>=20
> Fixes: 3a8845af66edb ("idpf: add RX splitq napi poll support")
> Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
> Reviewed-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>  drivers/net/ethernet/intel/idpf/idpf_txrx.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> index c724d429a7aa..70553f64f770 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> @@ -3299,6 +3299,7 @@ static int idpf_rx_rsc(struct idpf_rx_queue
> *rxq, struct sk_buff *skb,
>  		       struct libeth_rx_pt decoded)
>  {
>  	u16 rsc_segments, rsc_seg_len;
> +	u16 l3_start =3D 0;
>  	bool ipv4, ipv6;
>  	int len;
>=20
> @@ -3321,7 +3322,10 @@ static int idpf_rx_rsc(struct idpf_rx_queue
> *rxq, struct sk_buff *skb,
>  	NAPI_GRO_CB(skb)->count =3D rsc_segments;
>  	skb_shinfo(skb)->gso_size =3D rsc_seg_len;
>=20
> -	skb_reset_network_header(skb);
> +	if (unlikely(eth_type_vlan(skb->protocol)))
> +		l3_start =3D VLAN_HLEN;
> +
> +	skb_set_network_header(skb, l3_start);
>=20
>  	if (ipv4) {
>  		struct iphdr *ipv4h =3D ip_hdr(skb);
> @@ -3329,7 +3333,7 @@ static int idpf_rx_rsc(struct idpf_rx_queue
> *rxq, struct sk_buff *skb,
>  		skb_shinfo(skb)->gso_type =3D SKB_GSO_TCPV4;
>=20
>  		/* Reset and set transport header offset in skb */
> -		skb_set_transport_header(skb, sizeof(struct iphdr));
> +		skb_set_transport_header(skb, l3_start + sizeof(struct
> iphdr));
>  		len =3D skb->len - skb_transport_offset(skb);
>=20
>  		/* Compute the TCP pseudo header checksum*/ @@ -3339,7
> +3343,7 @@ static int idpf_rx_rsc(struct idpf_rx_queue *rxq, struct
> sk_buff *skb,
>  		struct ipv6hdr *ipv6h =3D ipv6_hdr(skb);
>=20
>  		skb_shinfo(skb)->gso_type =3D SKB_GSO_TCPV6;
> -		skb_set_transport_header(skb, sizeof(struct ipv6hdr));
> +		skb_set_transport_header(skb, l3_start + sizeof(struct
> ipv6hdr));
>  		len =3D skb->len - skb_transport_offset(skb);
>  		tcp_hdr(skb)->check =3D
>  			~tcp_v6_check(len, &ipv6h->saddr, &ipv6h->daddr,
> 0);
> --
> 2.39.2

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
