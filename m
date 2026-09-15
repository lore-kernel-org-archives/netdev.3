Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazolkn19013081.outbound.protection.outlook.com [52.103.35.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6A637C0FD;
	Tue, 15 Sep 2026 20:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.35.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789502451; cv=fail; b=Ki1LC6Lu1KIctyUovZyzzRAdtUzIJyXbipbB/QnRCtqsReR+8gg7S0thdLzj2QA0lyjKgPjEuaKJ/zpoFoU4m8CCQ8IhoRLDOkA68GxSM0B4oOy4HHUUOBLVmJjLSi3ke+iTmKrc2AM+3YtmsEy/Mdg8CsriIjP+wX6bg43s7ns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789502451; c=relaxed/simple;
	bh=tIdRY2ud2nL8k4HB6XsVSO3VcLXpsziqDNWchZkRvBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E6HEE3tGzR/DDdtceCJT1bqXCj2HXns+y8ZU6Ozsm77w1jjxmGHTdndt4zzjz3vklhhsbX+ElNcui3wKBLhuUeEW5xbcpHBPISYcVuF9p0+aDIg2G5sfB/FeBONovuc1xO5/KR+mArB5n6jAbK6cOnyinT+qEj6AgtWvuetyqbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk; spf=pass smtp.mailfrom=hotmail.co.uk; dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b=dQcakFNd; arc=fail smtp.client-ip=52.103.35.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b="dQcakFNd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kD7U/wY4OjsJitsJXo4SJcT3INsEL84Ex+XhkJcoX9XY12OeFxLzC6LllW89/qGfxaL0nzgOGMH/aHPETg3CD86woKffvu7X+g+dGN8uxOYdH6nEGC1BauVJ+q0geQMmfXNsdWePPfSe4Qe8n80Pm/wN+5GtOtC8QELpPXvMOYMB0Z9NLXhx+4Ys7wC21btVS80JYtCUiF7JLy4PBQ7pEniQtAA9Td+ZHQQ4IIYfkEWtCIvfzWC0sPWLjS8SHjCZbXe8bfOLBTiNr7uzIiWZHjiOwIcz1UIFpbQ9UqMAc2evwBfnqwDKXe9/68sxp9Sn1vu5pv7WJ+Dlbm+mXt3Umg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AEI7mZYvFzPlGnKyocewi7ZGxtJlFLmi0nc9uC1npDk=;
 b=Orc2JuxpC4pdDkNACVo0/nd3a+jP4Oh+TX4zCmq6cuo6B4cea37OJX1A722QI42tM30ItujUPWtL7RiCRpDlEyeEpwd3ZDS4Fjavte15jbNK0uvTgQdTUEd/U+IjQG7kaC3RXMdR8GKwL9H+yNM8mo8rYaP+DnJWxdSWEVJ4jPQmGO5ALJhlDQfLTGorB2uGBqYhQCG5nDvgSFVdXOEKuI4xW4AJwDM0WTXqqAz8Nrys2xWPrq9Tfwzqj0tZ8XyLnC3oXyVAguSo7R/JvZ5Uv0EHnjxDDRUdv9slq9YLUqKIaUNFaxc4TGTVYcr74twmfIigiN+3mLdnRgGteEqMuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.CO.UK;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AEI7mZYvFzPlGnKyocewi7ZGxtJlFLmi0nc9uC1npDk=;
 b=dQcakFNdUa50z1ieOJwf2wsLCmg0maPn/xAM/Z/lI30177PPf3hkPHDBjtOR7T+pFp0cv28nOha27w0F2BBxQ0r0H3ClVUiLtPKT19vP8v1ERFyjLlF5X2J6cwf4P+EdOWCaJAdnT5AcqwMLn1fG0ssSCm1B01UhueKCLxo4GqtmMFScmNoNwHNZ0ddlsoYswt5vSZNo5x4UFb80qZFy4nEU17r6MgYzXBCEAkR14/GiVaQRO7vDTDLxn2ISBO12lFuVtjGU4p3U+2Kz3SRrpDvpeGozhF8NqlPJcVdNvuYaaJYM+LBHr3jcvjoLda6C2j7OVr1PbzV1ExjooSYZ4A==
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:344::22)
 by VI6PPFD881969EE.EURP251.PROD.OUTLOOK.COM (2603:10a6:808:1::168) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.13; Tue, 15 Sep
 2026 20:00:47 +0000
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352]) by AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352%3]) with mapi id 15.21.0428.008; Tue, 15 Sep 2026
 20:00:47 +0000
From: Aamir Ahmed <elb12345@hotmail.co.uk>
To: David Heidelberg <david@ixit.cz>
Cc: Aamir Ahmed <elb12345@hotmail.co.uk>,
	linux-nfc@lists.linux.dev,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfc: llcp: validate PDU size in nfc_llcp_recv_dm() and nfc_llcp_recv_hdlc()
Date: Tue, 15 Sep 2026 21:00:43 +0100
Message-ID:
 <AS8P251MB0001E064CE83252EED1B5D87C8BA2@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0.windows.1
In-Reply-To: <AS8P251MB0001E8602F36054CDD8979A2C8B32@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
References: <AS8P251MB0001E8602F36054CDD8979A2C8B32@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO3P123CA0018.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::23) To AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:344::22)
X-Microsoft-Original-Message-ID:
 <20260915200043.12442-1-elb12345@hotmail.co.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P251MB0001:EE_|VI6PPFD881969EE:EE_
X-MS-Office365-Filtering-Correlation-Id: b1081354-eb69-4d4d-c5bc-08df13640874
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|15080799012|25031999004|12121999013|25010399006|37011999003|55001999006|24021099003|51005399006|8060799015|6090799003|5072599009|19110799012|40105399003|2607281247196008|1602099012|10035399007|4302099013|440099028|3412199025|26104999009|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cmVkTU1pMkdjL3ZoaS9VUkROdURsUkZhS0lEZlBDOHJyS0VMRW5mZjFNdGMw?=
 =?utf-8?B?d2hmVUVoUkVLZmlVT0xEYkJpSVpBV2xHemM3enM5dXhEN0cweForTXR4UXhX?=
 =?utf-8?B?ODB3NWVmaURtV2hxNWdwajhyWlJDZFVqUEJmZko3Q2VISk5vSVgyakZnb2to?=
 =?utf-8?B?Q3JWY1JleEw4aU9UaDhGT2tZRGd3TlljQWk0RG5EemlQS0NvWEVYbkVMQjhC?=
 =?utf-8?B?clFPN1ozMXJlWDlpcHJaelgya083UEVKL1RlQjNWQ2ZEdUJjSUZhODZ0VkZr?=
 =?utf-8?B?amt5UUF3TVA0ZzQwZWRoZGtLQ2RBUTducWhQbFV1cEpDa1puMEFMWWlTUkVy?=
 =?utf-8?B?VFFyVkRPcnhuQ2Z1NVBxVlRLeVR5a29EMTB2STR6NDk5OVN5U09md2hwQ3ZR?=
 =?utf-8?B?MytYYWlkTW1Ga1ZQM2ZQb0lIZ1JXOVNMUXdCUWNjTGpxK0t5dDg3WXI2enFJ?=
 =?utf-8?B?L2JvMUZTZE14UU9ZQlBnOTVhVVFTYUlHMnBWbUVEOVFyWERNa0VlODl1S3dV?=
 =?utf-8?B?MGdVZmNRd0hMUGFlNkZwVG4vcHNHejFJR3JpbWlUTWU1MWhHQWtzYUM2MGRj?=
 =?utf-8?B?R1hnb3g4Q29yYjZOUWFjNjFxdWd0bGkxUVp6MDdzcWp4Z3dSTFZDTCtpUEF2?=
 =?utf-8?B?QnY3NkFNV2YvVjAzUTZOdGhyTjg3VFJSLzBhd0ZieXVZNi9HckdzM0ovQTlx?=
 =?utf-8?B?MzdaVXRkZy9xUWFrR1E5eGpJRVpRMkRQVGlQbXRvOW0zdzV2Wlh1QWhXOGsw?=
 =?utf-8?B?SmUxL1pnNWdKcmZ6bng3ZnlDbk96T1NBT05qN09HSDk4Ny9oNEQ0ajRuSWU1?=
 =?utf-8?B?dWU0WmZvejZoVW0vUFZ2QVcxaFpZRXZESGxOK0NUTzUrWGNweml0bk1GSUJR?=
 =?utf-8?B?bUtVeU5BTXZ6OWI0KzdGWlE0djZvaXR3a0NISlJPeEw1Q3djRWpwT2J2b3Rz?=
 =?utf-8?B?S1J2ZHhpaGJENXlEcGRYTG56UFNSUUtSMm0rRllYUWlCM25DRVNPaGsvWXZX?=
 =?utf-8?B?dkxiTC94RE5PVlBtTzllMXlBQkh5QUZzMVZibWU0VVI5TnB1dVNLZHdLdWs0?=
 =?utf-8?B?RHYxbFRNL1QxcUFGcGRoL0tGN0d4QUw4MzFzWFhRYnhIMWFKZjNmSjQwQzFo?=
 =?utf-8?B?d0I3Ukd4Rk5teTdieU5BR1JZZmQvQmQ2bkRCdDZnZ2hUM2FDSlQwRFJ3Yjht?=
 =?utf-8?B?bnA5TmRESEdaY0J3UTMySzJxcG5wcWhXU0tFL2FzYmxXMXkra1VxMGZSbFJY?=
 =?utf-8?B?Zm5jd3FoN0x3MzZaV3lLWFYvWE5TWEUyYlNwNmR3STJHTVNoOGlWNncwb3Bs?=
 =?utf-8?B?c3J3UXJCajFNWnNVV1lBb21TdWdydlUxNU9WUVVvWDZzbEtFMm1vdGVOMUl1?=
 =?utf-8?B?VVNZdTI5aUJIeVd4Q0lndDNHTlRSaDV0QzVYalQ5UTVQRUFyZC9iYW5WekRX?=
 =?utf-8?B?eHlhT3pscW9JSUMvSjFCaTlGZVBSREpFajRlTzZnTUcrVnN5ZGVuQmFqb0FL?=
 =?utf-8?B?dVVIRktoRDZlK05UMlExSnUxd0xWRm5pVUdXb3NUaWhuM3VIV3AwM3pZcmo5?=
 =?utf-8?B?Ym9HYjMrekhwcmNRVTBpZ3dJRUZiV3JHWkduMHFZT1RqejFaNVNBT1BVa3l0?=
 =?utf-8?B?bDdmYUxlb1lZSzBUbFVIb016bERpakE9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YWxJZzVac1VYRXEvNWc5UFNnUGVvVDdOQ2N5cDE5ajM3T3hrQS9FU2xyTnYw?=
 =?utf-8?B?ZFRzSFM5Z0ZSQ1QybnQwS1VjU3JwR1FLcURvdUFyQkFDYk0vZGhDMFhrK25y?=
 =?utf-8?B?Ylk0bHJmOTB1SFdzTjN5bkFSTDY1U2FiaGtMeUlRZXFkb3lZMFZXVHMxQU1k?=
 =?utf-8?B?b0N1dVkvMXRPUCt0NEx6dFlMV083dkNERzZDQTA4TnJZVjdyMkU4ejNlMmFR?=
 =?utf-8?B?ZEM1TURxeko4cWZraXpYWWtDcktIMExrdjZ2b1JJRW9UeWs0OFl2V291S2VQ?=
 =?utf-8?B?Z1k0Sm0weEw5WGF0Z3NwTTVZUndDd1VKSXpiQ2x1eW9Sd2x5NzF6VnRWSmor?=
 =?utf-8?B?NTlmMlVYQTlhZGE5TW1vbGhaUXVRS1JIdEgzT0I0Rk9xOG5iRlJWMzlBQSsw?=
 =?utf-8?B?NVI2bkxhVmxRcFNlR0VJMzhZVEdPRERDUjlabjBGUjkvdTExNVpSQlptdWVk?=
 =?utf-8?B?eG5hZDFTZlZqbi9iUGhKRXlCSHMvNHNoeWw5c0hlcFRIemVHQjkwcWVNVnRq?=
 =?utf-8?B?c3ZXbXRHeUNOZEdnMjQ1cFBCcytoNEVGa1lqY1RKbnUxdDZCZDdrTHM5SjVS?=
 =?utf-8?B?OWNjZjMrVFRNSTlEZ1IzL0ZRYkVvSjYyZFZJa0MwV2o4ZmZIbWNZeHhHd1Rt?=
 =?utf-8?B?NG1ZN1VwM1Q0V1Z0TlFaNXdmTmhGVWJ4QWsyRzFLTmZ3S1VRRzBkOTlYMWJz?=
 =?utf-8?B?WlJSSVRKSWxndXZ3SmRVUXNndDhIQUVrS0Z2bGtxWEk5QmdVdmF5QVJYVnRs?=
 =?utf-8?B?QS84N05hOWRPMGE3S1Zzeml6U1czRE0zM2ZBVklrVE9vbytsTDNZb2xjVUxl?=
 =?utf-8?B?MnliNk9OdGtPTmduVVU3SWdSQ1k4QUdvOUZ1czJjZERsbS9qNENxV0YyRmk0?=
 =?utf-8?B?WldFN0krSWp0TXdZSUFaNWVXOVowNjBWSWFZZ0drRmtuSWtwNjFGMEZVd1po?=
 =?utf-8?B?aEFneWJVcGpybTBrYU5xRHlZYWV5djIyRWtDNStXWTc0M2U0ZDNPTjA1TDRS?=
 =?utf-8?B?Z0RZbkdNejNKcWFackJSWnFCTUZZSGp0dHRiSWdQWkVuQ1EvR1N2cDJkOE9X?=
 =?utf-8?B?QkpBbzJKWDNadEQ3SlJTZWp2NkVKdmw2QUJnUkE0bEdONnFGdnMxNTBud1VZ?=
 =?utf-8?B?WGNyekU4bTNrYTVPMlpGRC9kVzJZRm1hVGhQQ0ZGaDJPYTVBd2VVUFJSM05p?=
 =?utf-8?B?aE82MVdKSlNVVk84b2plZVJwNU1jQzI5cnpwZ1FTNFQ4SWhiRksyYlBtcDRS?=
 =?utf-8?B?TTBocXNxMUhNSG1GMEJDalRHei9vb05JaEdxMG5Zb00ySFNvbnNtSTZTN0I3?=
 =?utf-8?B?c09kamZ3ZFk1dkkvOCt4aVdMN2xad0Z4MlQ1SkFzbGdtM3FYK09TaEI5UFRO?=
 =?utf-8?B?KzV5NjNkTC80QTVTZ2Npd2NDZ0JiKzR2MFE1OXM5RmlTSFFWRjloZ2N6VGdj?=
 =?utf-8?B?K2x4Sit4VUFtS0JhVytNQlFNK09LRm1Xb1JBaFdrZkpIMjFjRjBwRXNIVHla?=
 =?utf-8?B?VVBkMzdwOC8vNE5uMUE4YVBhdCtuZ0lJaWpwR0dUM3V1ZnEvbStjRmZUQ0dq?=
 =?utf-8?B?a01ReVpQcStOVk9ubEJ1QTJNeUhhT0dHdzR4MFhqUGx2NDJzeWFQNWpnSGd6?=
 =?utf-8?B?RFB0bXpIWjF0R1h2ZmFPUWVQaUg3a3U4U0JId293MjhIakJ5dEFBcURZZ1RH?=
 =?utf-8?B?cUk5TlJhSXJEZlZ0aE1mWVNEcUIvMDh3dzEyMTRPYmswbGprREQxb3JZKzJQ?=
 =?utf-8?B?QXZ6M0NqSDlUd2NuUFRGaEZjcnZxcm5qb2NvSWR5S28zZ3M5NTdFNm5STndU?=
 =?utf-8?B?eTlYMFg0UnZSSlpKaUt3d3QvemY3TVcyWmVoQnRvcHhqaUNhdFU3WENBa2dH?=
 =?utf-8?B?SkRrR2d6MkI5QVdBUFhqOVVpZVpmWG82cmVoMmpYWnh4eE5DL3BsNWRneUdH?=
 =?utf-8?Q?5qF3oLoUy0/4EkZP+VhTqd3i3/frSVHX?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b1081354-eb69-4d4d-c5bc-08df13640874
X-MS-Exchange-CrossTenant-AuthSource: AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 20:00:47.3092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI6PPFD881969EE

This version is superseded by v2:

  https://lore.kernel.org/netdev/AS8P251MB0001789BBF04B72745C7D96BC8BA2@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM/

v2 narrows the fix to nfc_llcp_recv_hdlc() and drops the
nfc_llcp_recv_dm() hunk, which duplicates Lekë Hapçiu's pending patch:

  https://lore.kernel.org/netdev/20260729011547.19191-2-snowwlake@icloud.com/

It also addresses the Sashiko review: it no longer replies with
DM(NOCONN) on a truncated frame, which could close the peer's side of
an established connection, and it uses pskb_may_pull() so the check
also covers non-linear skbs.

Please disregard this version.

Kind Regards
Aamir A.
