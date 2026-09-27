Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazolkn19013077.outbound.protection.outlook.com [52.103.43.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7886822576E;
	Sun, 27 Sep 2026 08:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790496339; cv=fail; b=OpqbWxW6nO++n08QE39xfDSX3EfKURDl8OeZ94/Jke2ModaIPG6OaF1wnsv/IeRfGfa77VQF1LKBHir9bw36DXy2O3PLairMrQijY39lR0yhuZkVsQ+t/nLXEZb0uiMRJ8DGr0jpvcq+hcAPpdOQgD7EwYJJDu04ef46V8Pt+q8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790496339; c=relaxed/simple;
	bh=XXGP7avdZ6n7eArqerYlgYqYmKPQIvRZWaWdLfS9Swo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Xf4aq6PpYL96/xYCkPlgYUN8AWMTxV6FFZnLQe9Agtx6FfmVGB+5V9RhTGJVEk/wXvJGYWXBVeDD7qUX2yULK1SfvAcXU/svsnDJBOIXJ/bBT/16yNdAdOk/IFEhBTzbkqJ2e4+QURepoTF/zY24ZzzYlIYAXXmOu4LcMUQ6cEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=VA85qRCE; arc=fail smtp.client-ip=52.103.43.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="VA85qRCE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SbkEgvuL+pHyxoyuoVCjdAebDgU0TCn+1MK0o6/Mdk8C/mxm2j4NgqouTP8BihXVU/VtY4z63YWMCXBVzGtDrEruSF/5HYkvyRtObI5gJEH/RwTNwbGrD6876Tv2+kDnORz6aeZEZmorGS4IOMNW1PXYdE234zydrKCu+2D2IsMz4IOvZgWUT5HxEx76hNJhmO0Rkih/QdwTqbgLBYttTIj61f+aOKPLq8BXmjtSHFpEDo1agU0uzfIE0dixKIprHoM3yV9aGhUCSv8laMGBJryFESlo4CV317HOt6wGotl1VRlPE0irCZQlEFL9M55e09inz6iMo8Efz0C2t6vyYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ziCznKSqZsG+i3O69rAj5iAI6IkbrM5XWOtxUn7yYL0=;
 b=ocL6OHHfDU/7KTB+zl7O3TZLtoCmfiNmafaAsVoxNUpMPLoDQB4D8GAZ5MXZ6avcL2US86pkHMlh3xXCssUg8o0IDN/dhK4cp0URd7aYj4CxZsoKPH24r1pyYVbYxItne24WyTiuNS0vwfHaruXJ09cs9AA0NOruQHzK3b6yVPZyD5fkp7WsTqcrj2cVy3n8IRKWlG8OeBQHZTjItGUSfeaUegSBROZ1CbXTtZyuURKWvTy+DjAAUgJ0ifMWPX14j7iUCCr/gQgQihz+UYjw1yTd7YyItT8qupHhWm5SFH3ibNvSY3q/xFtjaK1XEUKaSsqdAFNSvbnqP4YbusbOhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ziCznKSqZsG+i3O69rAj5iAI6IkbrM5XWOtxUn7yYL0=;
 b=VA85qRCE5OGbpliTIEdULMK2lLYtfIJt56GIS6EWpCqNTNA4vN79IaudZSWuvDBcac3zR2xND4G/Yp7rFyK+4erdsR6Wj4S7IvuAlpvUZDzBnqzOcqmCxd3B7yOPfFauPcpaqU5YFPKM29BAgiFSzUOSySnP8bLCQod9dYNZJ8VkEHKhGfdyB+JlSpBMsYSVgPMhuHHY223IYsFU1+5ir/crO5GcruMqci0tGWC7xeHp9v0xaOclGMYXZ0DNBy5YNSs3nFeoSyDXJigl6vbb6KJHPiiJG/Q3fdYxQ4jw0B1tbCQmA0XX6M/14OF2eIxUNWbvoSPSPGPmhX8I+KWD0Q==
Received: from SEYPR01MB5882.apcprd01.prod.exchangelabs.com
 (2603:1096:101:1e1::9) by KUZPR01MB7787.apcprd01.prod.exchangelabs.com
 (2603:1096:d10:2e::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Sun, 27 Sep
 2026 08:05:33 +0000
Received: from SEYPR01MB5882.apcprd01.prod.exchangelabs.com
 ([fe80::36dc:66d8:26a6:5612]) by SEYPR01MB5882.apcprd01.prod.exchangelabs.com
 ([fe80::36dc:66d8:26a6:5612%5]) with mapi id 15.21.0451.014; Sun, 27 Sep 2026
 08:05:33 +0000
Message-ID:
 <SEYPR01MB58827E0D18ACC93AF98A4109C98E2@SEYPR01MB5882.apcprd01.prod.exchangelabs.com>
Date: Sun, 27 Sep 2026 16:05:26 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v3 4/5] net: dsa: qca8k: flag QCA8337
 internal CPU PHYs for SmartSpeed
To: Yongzhao Chen <yongzhao.derek@gmail.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <20260923215858.1653-1-yongzhao.derek@gmail.com>
 <20260923215858.1653-5-yongzhao.derek@gmail.com>
From: Ziyang Huang <hzyitc@outlook.com>
In-Reply-To: <20260923215858.1653-5-yongzhao.derek@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0026.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::20) To SEYPR01MB5882.apcprd01.prod.exchangelabs.com
 (2603:1096:101:1e1::9)
X-Microsoft-Original-Message-ID:
 <f633d189-6179-44b2-90e5-fbbbf0750831@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR01MB5882:EE_|KUZPR01MB7787:EE_
X-MS-Office365-Filtering-Correlation-Id: 3290ec4a-2d5f-4433-d35e-08df1c6e1abb
X-MS-Exchange-SLBlob-MailProps:
	7J/vb0KDx3j4EGtrWC76yZtYjXYOkK33Ddjza6KtZw/4oa8VCHCM4DCLwsWYiod9U3mD4GxN2gRXBFOgySK30LSE7jwbDPTC6EjIfTMKJ7z+svx/kMF3b/izeqv5wC5mpIm/YMSgdjBdt6ELAqmdrGGkPRwUlKeEZIL6G9l/3V2BLn9RxQw28S2cFR77Zlprgp7hl4lBzwlz7H1yE+QSrXyHJlGzyUdRSDhBE4z2uk3ug/tIkJUUNz81mJ1hVkRl49OPkyDDzu21Bz5SK/jN2BrdSm2L1KyWdgrVcDGmgiCLwJsIZGLBndcaNcKqjLrqQ9d4G2vXZcgDDhho8GQxAEsiQX9S1g1FU+tx0RBAeKfw7GoAstnd/G+VIxhkeyJGzt5pP57v+ciSUq71lBRGmsHwxMaowo3aemxNo09iB4wSPxy9CWtNDQX1rTjUlP/vpTEXbHCkDnJl7uy4Lmunh19i0DawX7hIlaJZhVz4BHhiV9J2Uh6SIkN62H5Iy465gll5Fa9MOcZjrKwwguTTIc7cghZxJhVoeG3uz2383jOcReL+y9LBcXBm2FJ+aAwPKCmw8BsEnEEXsMhmZDxg8XOgShlgKbHj/k6tE8Nj70JlBT5GJwjc+2KrbaJ/HZBP1iviohrjoIFhc/ZuBg/gdS6hvGWBoYIM6JnAelV0HGW3LzLi5ttl/Jzk8a/4gciwlvdVhfN0ovEgQfrz19huE4wW82r7Bqy6D96vQgVfAcFLBDTkZXc1vDgfXk/NC5lsUVymH3FgekSjjYC8sfRLWRJGJtbLPuF+PFkS6SvQJ64=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|4140399003|6090799003|25010399006|12121999013|19110799012|8060799015|39105399006|5072599009|22121099003|24021099003|23021999003|15080799012|3412199025|26104999009|440099028|40105399003|2607281247196008;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?LzFLSFJ3VUtDSVNqcVl6TktuY0NUaXB1MmRTNjlsMUppV1hTbkQzTThJRk9B?=
 =?utf-8?B?R05rVFYxbEV5bElXNy83MHJWemV3bDBSZTA3QnhKeTBuQXlRUkU1VjlSUkx4?=
 =?utf-8?B?aVFHS05uTGlSM3haMlRVdGtla0hER2w3aVFQTGJSNVExeGxLOTRUelVXT2Y5?=
 =?utf-8?B?QXNuWE1vWkF0bTZ6M05Tc1pqUjB2QXVYY1lreU1oNjJYM1prN1JXTGN0UEpW?=
 =?utf-8?B?UW5kNzFFMU0zZHU0WDArNVBUcXdsZGlpY0JKbWxmZUdKcEU4OVY5R0UvbTBt?=
 =?utf-8?B?NmRUYll1ZmZRRW5HMmNlTXVsWWZIb280NEVvcTJES1d3K1FqZWRSbkFadGRM?=
 =?utf-8?B?Ui93bllURm8wd2k4MzRLV2I1aUZzTjdrSldDdFJ5bDJhYUxwSjFkRkIwYll5?=
 =?utf-8?B?OEh2a1ltUVQvSTlieXZ6aXpUendLTGQ3NlFxMG9jWk14emlodjBKSEtGVHNx?=
 =?utf-8?B?Q244WFFYUmh1WG5MKzlCczBVNldta3hWcm9QZERhdHBROTlIUnFDRzY2bzVP?=
 =?utf-8?B?L0RTSi9nSUp4aWNmRTZ1Wm11QmhLbWZrQ1VaYU02SzlWTURVb3NTNWJwSVN4?=
 =?utf-8?B?cTFFZnk1QzhScmRTTmVqZE5oc0o4b2wxdE5SLzlWaUUrdXVvaWthcEdEcGM5?=
 =?utf-8?B?dlB6cWw1NVl3ZlRDWmhWZEk4aE9ob1VUMElLZzNJK3NtdTBrQ0VuUlFGaXIz?=
 =?utf-8?B?REVlMnhMRmNVdlE2Sk5rUjE2dWNCZFpYQ1FhYnQraytocit5UnFlL0NsUlBT?=
 =?utf-8?B?bzFEcFY0Z0hXNkZXTFNXYlp1aG9qMzZNQnNETmdITERoMlBhMndtWXV4S1RV?=
 =?utf-8?B?V1ZsMjlodkVJa1ZabDhBYTdCWko1aUFuOUszakJ5VWlZelNJdnZ1UWU5Sld0?=
 =?utf-8?B?V1VHRTlPREV1dzMzbW1rTlNYRE1WVlp5MWpOWC9PSnlGb3RLODFOcnNCM1JU?=
 =?utf-8?B?cWF1LzcyeXV0YTQxZ3VXZDRlMlRzQm45TEdraHhUVG9wUUZ6MnFvL1JIdXhG?=
 =?utf-8?B?aTc2YXdjbGd2SXlXTkNOd3lSbzUya2M5K1VvTlUxTXl6bDNyeVUvZGhEWjdB?=
 =?utf-8?B?QzE0RHNoRHEyNGJoeWZ0Ty9PSEpsRHp2Tk9CQ3U1b3BwN1ZMZjY5cmU0RFp1?=
 =?utf-8?B?c1NUTjNGU1hTVkZvdzcvaWhTKzZqSjdUK2hRSmtDZ3Jad3p6enBQOXRURG9E?=
 =?utf-8?B?YmhSQmwzSVZxaHNjTEVBZVk0bUJwWCtUNVkvZGxwTjZrWFJEbHppcGUrMUY1?=
 =?utf-8?B?ckFhSXpYQXZ4di9zWTcxaEVsdjlKSGRIakwxSWVzMXlabi81ZlBnUkZRUVRL?=
 =?utf-8?B?M0UvMWlvVHVDTjhNVk5hdG5pYW5KR1paMjZuNCtrK0dNKzQvZ1c3ZzhmZWFP?=
 =?utf-8?B?UUdseGtEam1XR2c9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OU1IUkJPbE1DYytBa1lUNG9MN0p1Ymw0czVhU2pIQm1JRTdMSW9SbzZVNGlI?=
 =?utf-8?B?QUxEcjZFSDJqZmZpR3VEZzZ0OG1DK3haelhOcHl1QkRZeHZPdHBXNmV1RzBl?=
 =?utf-8?B?eE04TENGd0pPeS9HdHlQc3lRNTNuN3E2cDlXWXhPQXI2dXN2ZG1vUlhmbDZQ?=
 =?utf-8?B?TzgwdFRaVXIzTW9keW45dlNkMjRaQW8zL0pXTUxxd1c0OG1GZHc0VThrdjZH?=
 =?utf-8?B?amRPMW9aamFobGNXaXR3QmZ0T3FvVXBMK0h3TG5aZi9kTlJoSkw4V2Uvby90?=
 =?utf-8?B?SE9Rdm9LRUU2elE2NVlSOXBhWng5REtRN213L1hwMEFIMHFiWVhFemNiRGNo?=
 =?utf-8?B?NFlJNWZOTFhSMG5sZEJ4Yjl2bWY5MG9kKzRjclpVdUlKa2J0emViWlhKeHU0?=
 =?utf-8?B?OHZidVJPQng2QVJYSTh0L3J1empTNTJXREJ6RjhBVGxhMFpyUm9DaldBRlFR?=
 =?utf-8?B?ekoycVhmRXMzWVhpeU9OVTFlVUJXdGs5eFFhZ2k3OGN1M3NVdHgzRUxKYjEv?=
 =?utf-8?B?ZHR4TXk3M2JvSjVLU2lyTEdsaWtUWUIrV01MQjBkb0pybEQ1R01hSE1GbnRN?=
 =?utf-8?B?dk8xV1g0NVA4TzlkTkhDbTZLQjBrR1VaZS9WZHoveExFVjVjeWVZZDNVa2tw?=
 =?utf-8?B?bEZSOHg3Q1ZIYzZOdDd2aTJDZnR2ZWxsWEpmSExLbWdQTEJ6cGpkU2RKL2lB?=
 =?utf-8?B?OWlSamN3RnZiRTRPZk9ZNGdLV1UrVVBZR3RoVGlIU3J2WHR1cGFQU2RlUVZE?=
 =?utf-8?B?MDM2S3hGZEVvTGtVSGEzQ1E2K2xYaWZjUkJxYnV6YlMxMEJaQlNoNVpsNDBX?=
 =?utf-8?B?d2JXRHdmQlJjNU5hemtaTkVka2lTVWdrNGZzLytUSStvSHFJS3QvanIxNDlP?=
 =?utf-8?B?eHpDRXZwMDhaeGtsbVNUNGQ1U1c3SUMzQ3AxMDFEa2U0RzhMNk1JUWhsOVBD?=
 =?utf-8?B?N3htL1hMUzA4U1JBeW5sQWxrQUJDNlNFNVN0NlZPMjdMK0d3QUFNYU1vcEZy?=
 =?utf-8?B?YUlLLzFNcEFmVWpCU0tsVjVPSWRsb2tNUWNwNXpFTFVVdkVGWm05djNtQ0Rh?=
 =?utf-8?B?MXJFRzk3alNncXI1UnZvbjVyL2RMU1NzM0VqSEl0Z1hJOWY3bUVKSnZMYlRR?=
 =?utf-8?B?RGFJZldpaHE1YzRUMTVEQlhYa3BBZjRYTVpXQ2J1a2pCMnBEU1JETHdWMEJx?=
 =?utf-8?B?cG5UUS84OTNSclN4cUsva1pmbW5BQ3ZFWTZCYnJSZWh5MFgwR3piYW1FTEVi?=
 =?utf-8?B?ZHRQUXRWd0ZNQU8rVi92ZDRBRC9iTExFZjYwMTJJSytVVkN5VjZUbG1BYWxj?=
 =?utf-8?B?RHF1Z3g4akJGVEpYKzFmQ2pRZGlsL0ZWSThxTTU5Zjdjc0MxSVFpMi8rVnNu?=
 =?utf-8?B?ZURHMlQxWjBtSC9UWGlCSm9mT1RyZkR0eWxXZkRObDRwY0FrYUxEa0JmaEpq?=
 =?utf-8?B?b20yRGo3ZnI0Z3dLSGxqa2lzNVZXWlFHL2N5bjNSV29CRHl4OFJDTXkxQUs3?=
 =?utf-8?B?VGxmYnVrL2ZLZWxoZVlJZTUzSVZuNVlBMk1udHYvSGZQSEdCYmFTUHFPbCtC?=
 =?utf-8?B?SnpnYjk0cUxiNmE0K3JWNE5Nd1ZzN0Z1aTJmQzI3TThoeDJCUjZqU0ZhWklq?=
 =?utf-8?B?U2pZdXlYVjRpL08vakdUc0ZhQzVrUzlmcEg2djBXRktkYUdCaHArM2d3UXI1?=
 =?utf-8?B?ZGYrRk0reDFndVFsSmprdkt3bmRIcDhmZkpHd1FQeXBTU0RCNFdDaWJWWkNL?=
 =?utf-8?B?SmNLZmU3bGVOdG15ckJFdW5YSFN5OUNDcnVRNXkrYnVXSlZiL1dQZmtHM1pF?=
 =?utf-8?B?Y3hERWtpZWZOSHNrYTJlT2tDaWxMcm80M0U2NU1PTFpYKzI3VHNVQUFNb1lV?=
 =?utf-8?B?VDlVeFJRaWgvOUV0ZkR2MTUxOVo0ZTFFUXJPYll4dUJiVVJuaDRlTUtsSmcv?=
 =?utf-8?Q?SWdPfJ+/7Yoim7/7Ry8jv8MJfhFcUq7n?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3290ec4a-2d5f-4433-d35e-08df1c6e1abb
X-MS-Exchange-CrossTenant-AuthSource: SEYPR01MB5882.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2026 08:05:33.3986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR01MB7787


在 2026/9/24 5:58, Yongzhao Chen 写道:
> In a diagnostic boot on one RA74, PHY4 initially advertised 1000BASE-T
> full duplex, but a later read showed that advertisement cleared.
> Clearing SmartSpeed before the initial reset preserved the 1 Gb/s link
> on that board. This observation does not establish the root cause of the
> advertisement loss or prove that a delayed conduit PHY caused it.

Have you correct the DAC settings of the IPQ5018 PHY ?

Most of the IPQ5018 devices which use PHY-to-PHY CPU link require to 
adjust it.

But some don't need. What's more, maybe some need different values.

NOTE: Setting a large value may damage the SoC. Please check the vendor 
dts.

