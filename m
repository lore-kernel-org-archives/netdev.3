Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azolkn19012021.outbound.protection.outlook.com [52.103.10.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78181233929;
	Thu, 17 Sep 2026 04:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.10.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789619398; cv=fail; b=r2TF5xBZEIPcLwzSVr62vRIFfs4+ufsLSp7kNq0BHBxq9QJStNPFf6ZkhdqIT50+AuoMOD3CjRKHx+JvkiraOCYj0D96mEvP5sBR5OySZYK7BmqS2v5fRUoR8ISUlPxoQXsUf7U5slEtjM/6CXALVtYDvq6QPHj27KH0VJIKnqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789619398; c=relaxed/simple;
	bh=JXQPAGOD6AMAhjvy7iuTLbouibKrMIi3CWcrR80DhXE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jlF8vWijhTLaZVB6m65M5DIzgaQFkPlteuHPjmdy/k1DXXrrxRzOISLGGxEl/XRt5+c0tibqFWNYC+FfB2Dhk6q2rjy2/Gy40f1UNXcqxO8ffhEfDX5PrTLDhblSW4UBtLR8PCNlZK9schHcbVEvH17dkbFnfb2DWp3ZOfytwHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=FLAlFSDv; arc=fail smtp.client-ip=52.103.10.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="FLAlFSDv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yzXhMIuvuUlul3GRcBvPQgsfUZR+O9CMUklGV3dB8AagFrHHLc8Zi0mYQ0LAGkSHc+gW82xFSFiPtPg7vgQ8UInmmXA2i2831VrQazTnNZ8FXtVKYoIurBJ6SFdhA1pnkm5rPsqeKaQ6eNtiGrVJCFHt1CeTF+V8wqsZM5tRgms9PzfhHEACinOgij0rT9MoA2rx//d82eIsGc+Fx6EseFmQYGt426o5qwbtj2FyK1ot0CgJuaYYhJd4SPTctRM9tGLg6dfK1D7CmIedFYMlzATdwwS+pcqFMQufyGPDCj4OQ/B1kaLX+kiQoCXEjEN2f5X3FbrRJFTSrMNJL+dbNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2hIQ+k3tis04/tdYe96d3e0pY5s+3NQq1EruS4RBLA=;
 b=tpgpri2ADDfBOviHoBHFVCpzcrG6fNP/ASU5w54f9G0j0PY4vg115pic8oKi8jTdfF9u4cXwyF66SiXRBIutActH+6StNPro9SVf5+GJVnlw4MjenH2ZZs5SamjgcQTV5byWuXJgvkq3UGaS+2hDM0kVUDQQd0zVnBRY1Yj7PLYvK095EYXBfyKcbtH1GqVfFWppHeYxxTW2d3mHEEyiwsdZ5FObgvX635D1LCfKgbIoPSl2NOphLPYsCl4TrLrprpBSuX7Vm0VU7Tqg07HQ3b46HVuZdgv2hgtjz+VCcT7GkZdlsGIhtA3QYm7f+Bxnhsy+vvd9P0moTzq13bfCrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2hIQ+k3tis04/tdYe96d3e0pY5s+3NQq1EruS4RBLA=;
 b=FLAlFSDv5EkdqM+DAb9cz6/krMQpsRS/MXySAScL30WcvBiO0TYgbHW9NKkYi23XGhe2eoy64tRPEMa7GVbAijY5wYNeCwZhtzz9hS20d4WLtMERWU7esLJMVVDM8A5oYEmEmA8TXNo7XVvDBzAv4q56MNtd6BoTlyQeZgzDS99M3UJno9GJqluUdnXyiVwWIR7aTryYtQQCnjnDhTDOT2nT/uDfwq+ymNwTFH99XDL2qcHPcOHJYijskThvRNPsA81rV+Ldvdk4HrLQu5OjDBRiUExqwxobUlSjjrqUp7YVxi9I33ZbK4+Z3qoCW6XlnDZSaQzW7NLLDpAt0VCktw==
Received: from SJ2PR11MB8401.namprd11.prod.outlook.com (2603:10b6:a03:539::19)
 by DSWPR11MB9692.namprd11.prod.outlook.com (2603:10b6:8:353::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Thu, 17 Sep
 2026 04:29:55 +0000
Received: from SJ2PR11MB8401.namprd11.prod.outlook.com
 ([fe80::ccc8:68f:2e82:ab65]) by SJ2PR11MB8401.namprd11.prod.outlook.com
 ([fe80::ccc8:68f:2e82:ab65%5]) with mapi id 15.21.0406.013; Thu, 17 Sep 2026
 04:29:55 +0000
Message-ID:
 <CH3PR11MB8413131D50175690DF9FDAB0E4B82@CH3PR11MB8413.namprd11.prod.outlook.com>
Date: Thu, 17 Sep 2026 14:29:44 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] net: stmmac: qcom-ethqos: advertise supported
 SerDes interfaces
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
Cc: netdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Choong Yong Liang <yong.liang.choong@linux.intel.com>,
 Bartosz Golaszewski <brgl@kernel.org>,
 Russell King <rmk+kernel@armlinux.org.uk>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <CH3PR11MB8413FCBA598F7FABC04ADCFEE4B92@CH3PR11MB8413.namprd11.prod.outlook.com>
 <CH3PR11MB841353E5708DDD7C5E2EA1D5E4B92@CH3PR11MB8413.namprd11.prod.outlook.com>
 <aqqI9wOnradk9d7K@oss.qualcomm.com>
 <97924d2f-45f9-44d5-b482-97fcbb70abdc@bootlin.com>
Content-Language: en-US
From: Thomas Karpiniec <tom.karpiniec@outlook.com>
In-Reply-To: <97924d2f-45f9-44d5-b482-97fcbb70abdc@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: MEWPR01CA0026.ausprd01.prod.outlook.com
 (2603:10c6:220:1e4::8) To CH3PR11MB8413.namprd11.prod.outlook.com
 (2603:10b6:610:170::8)
X-Microsoft-Original-Message-ID:
 <7ec598a3-fa4f-4d1d-bd8e-1f0754dbd75b@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8401:EE_|DSWPR11MB9692:EE_
X-MS-Office365-Filtering-Correlation-Id: f3ccc659-daa9-4fcd-4df0-08df14745103
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|25010399006|12121999013|23021999003|15080799012|4140399003|41001999006|51005399006|24021099003|8060799015|5072599009|6090799003|19110799012|2607281247196008|1602099012|10035399007|40105399003|4302099013|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z0M5R1hRc2d5YjNZNnFramwxcDhjYjc2b0MvTTVJTW96bUlQdnJWS3FIdGhZ?=
 =?utf-8?B?M0ZXS0FRUmNTZ2hiWitqbkRKaXJ0cmEzeVRuQ3VhQTJUNVpiajhNODJHUnNN?=
 =?utf-8?B?UEpYZXV5QTRvOWFmQ1d0dVhCcWZOaUxzWW55dlBGVTVwOUhCSWM1aHFuWVhK?=
 =?utf-8?B?aVhJSjVHVU1kSHhCSTRib21VT1ByZjkweWJyOFhuT3dNYjhtdnVQRGFZNVc5?=
 =?utf-8?B?VFAydExLZmwreWpsT1YyZFR2bDdsZWRHSk1xUlByWHRtd3VEKzh0aitTZ0JZ?=
 =?utf-8?B?dllmY1J2UEZXbElhNnp1T1NRQVRhSnlYU1p6TlpheUtCbTc5a3lHcGdSSEkr?=
 =?utf-8?B?KzJRODZmbDlSNWxqWEtVbEFMV0UzVG5yaEZiTGdCY2RheHBoc2J0QUIveE1H?=
 =?utf-8?B?UHhwUE95Mm9BTXFMU0hSOWthdEpVbHJyTVJPZkpSR1JBVFB3UytrcCtFMk5U?=
 =?utf-8?B?ZTNuMmZFK3lGaW1BZ0E4b014QWxOdjc5VFJXOGxhYU9rUkJsVHhURmptSGhi?=
 =?utf-8?B?U3Q2Q3VMcXIwbkwyMFZUYnhvQjQ1NU5wdW1HYlptOFh6dU5SOVFHOHhwKzZR?=
 =?utf-8?B?b2dBVG96VzY3dTNYUUxFUnRRM1BycEU3VzBPUzN0RlIrS295Z1dqOElkKzhq?=
 =?utf-8?B?R1pJZWZlYkVDZ2o2RDRrSTl3SEZ3dVpwVU1iMHozWkhSNjMwdUVVTVdJQ0Fl?=
 =?utf-8?B?dCtaOUFXNCt6c2o4VGVKTmRMTzFaWUtkR0xzR0psNFJqdTRqUS9tdlE5M3la?=
 =?utf-8?B?K0tuZ2tsSzNqMVR0TDhzQTJvYUpJSU5PT1lRSnVhYU9EQWs5VDJPNmpOY21k?=
 =?utf-8?B?Vmx6c0lyN29qeERLT243TlNRcDdaTWY3djVuWDdsVUdoQk5sM3RTTmpIMEhZ?=
 =?utf-8?B?M2ZUOFlVa0IwYk0yVENXZlR3dG9UVVBhTmRtUFFZekRRYit4ZVhlNG1IOHY0?=
 =?utf-8?B?YUNQeFBEaW5LMGwwN0N3aEVDckNWOUVNV1FwL2tFcDZmNnRBZ2xVQStycE5u?=
 =?utf-8?B?RTFqS3NoVlpub2JpTEJ5ZGNac1NhYTVyMEtOZ0ZHd3FqVE04MzMxc0wxQ3JM?=
 =?utf-8?B?OXBPL2JWLzgvbTNsUHZyMUdvVDB2WXRYcW9sR2hqVGVtZktOakVhV1BRTmYr?=
 =?utf-8?B?cml5c3Jma0k1QkdjZ0hHYzl4RUJPSHdIVkxBWWJENmhKVzdTU3ptMDVGMzZx?=
 =?utf-8?B?TDBxMm9rRHlEZlYxTlJDRTViZGV1UXJ1WGp6bzU2b0R4aEk1V05tcjFVMVFi?=
 =?utf-8?B?eW56dUIvMjFzSTVnbEYxZTkzNFJXRWNMdGJ6cXBKKyt1enpkV1U3N1JGRStq?=
 =?utf-8?B?ZlhmZ0ttWU9HNDVPcWF5VUhVVG5HYWFFbi9halZ4WFcyejFWL0FlSzBEVllo?=
 =?utf-8?B?NGRENlpJNkE5d2RjV1dlYVU2ZFVPM0F6eWQzc1FIcjNzQjVmb0ZvemxlZlZz?=
 =?utf-8?B?elVLQkp1VVoxZ3k2dVhVQUNBMjloNkVTVzNtY3lBPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cXkwcVg1NWpxUTNJcUpsd0RnckVkTWNHbTQxNU9EMFNYclIxYnA1Qk9BRUZ1?=
 =?utf-8?B?YWhldWJZUGRmVHNIMXY2TlhjVmhDTVljc3JKaUhxRk5oNWpEemxSTVJOQnNB?=
 =?utf-8?B?SkwwTXUrRGN6T2I3dStwUjNkd1Y4MVdVVUE0MzYyTVllUEFvZStxM1cwSjJ6?=
 =?utf-8?B?ZGZTRll0b3ZsekFkVXVsZUQzUDFZQkI1bXhndHp4WHVPVEJQRzNpQm5wNW0y?=
 =?utf-8?B?c1UwSUordi80TjR3Mm54WGNyQlZINk9qMkZpSGxRQVpJZytOT2UrK1BMaXhV?=
 =?utf-8?B?UHphWVIwWlh2YjNibEplQ0FCZHhZUEdRYXJNdy8rMU5wRFd3cDZxdkphYk5w?=
 =?utf-8?B?S2FFNkVmblRpS1FvVlBiRW9waXIyb2oreHkyQmxlenRlT1JYbHZ4aTc2UnZ2?=
 =?utf-8?B?RUpMK1E4cVJNRFhsendsSW54V0RrNE1WUHhLcm5IdVlqZGRjVlJzZ2lIVXdh?=
 =?utf-8?B?NG5oZDdReFJsRGlPalNQdXdaYkEyUmFQMmp4UmYrQmlKTm1NbjVRUjZPT2Ja?=
 =?utf-8?B?QlRvNmxGMGFCbG9MMEIybzh2ZmYwNTIyc2ZYQlVqK1ljM3ZtOVg2UENZUzFB?=
 =?utf-8?B?Y25Sdjgxa3hTUVNUaC9GZ1RnRWV5cUxvU0FzY0VsY0lqaUVQTy8vY2pPVUxy?=
 =?utf-8?B?cGh4UWJSK1RxbXB4d0NsWFNSNHBMd3FSR3hDVTFHL2xWOXB2L2lQOURJVkd0?=
 =?utf-8?B?YUtIMUNDS2tiSXFCZEx4T2dkY2tuZEErZmwvOGhsRHRVNi9NZ0JBdTdLWE5Y?=
 =?utf-8?B?UTA2SXFzNzlzOHltb0o3Z1owYjdCUUtaZStwTnQ4UVoxK3p6dS9zWDMvOUJE?=
 =?utf-8?B?b20yNnpMZG9RdWtQbGZEYWJuT1EyQ2c4S0JMa1pNZjkvL01qSEU3SGJXZXVp?=
 =?utf-8?B?Y3VkZ0xpQ0hZY1U1V21SaVozYkZNdHZ4cGNsSlR0ODRMSFFIMWJXTUI1MjBI?=
 =?utf-8?B?NjM1MDh3aUJqQjRkeUZoVVdGYWczM3RkbG4wUThCeVBRN3NNUndLb2J3MmhC?=
 =?utf-8?B?alF0Ni83SkhPUVNna21XZDdPYmVNeXNFVVEvT2lVQ1pSbGJjZm1iQ2dNcmJq?=
 =?utf-8?B?YS9aMm5UMFRGR3F4RDFTdUQxNzFsWXVkTVVMQUdmQUNURFNkckNZWVhzVkRK?=
 =?utf-8?B?bjk4RWdJWVRZL0IxRmRXZ2U3U2tpMFp5SERSaG5KYTg5SXdHb09Oa2hKL3k3?=
 =?utf-8?B?UWlJdGpjSTE1eVFtUExPeDNZVXVseU1SV3hGWjF2WTkvWG5Hc1pnclFwMFB1?=
 =?utf-8?B?TmF1L3E5UlhoNGtQUE1uV0haQUJpNE5uM0FraDBkQ0tCM1E0am52S3BMcUtj?=
 =?utf-8?B?WFIvUzhDNXZyWkF0MzQ5U28zYmlvYlZ1OGNQaUpYRGhlMmE2M0FwekNMNzlR?=
 =?utf-8?B?cHpWT2srdWF4bWE3bVJubW9lSmZWNVZ3T3FpWlJKckxMNVhUMVkvTmJISGRx?=
 =?utf-8?B?YU4xVStML3Vxcm8xcnU1OEZKWUFxSHpSQXBlaHdPYW5KbTA3UFNIM01uS2Mx?=
 =?utf-8?B?U2dBTjJ6ZmF2bEJBVEd2OHh4NVFic0FJcjhTeFRWcGduRlluL0lqNlZXQzAr?=
 =?utf-8?B?QmoxVHJJWklqcUMwVkZRWTZSK0RIU2hPbWFGTU9QUitBQU5xSjllWVJmL2E3?=
 =?utf-8?B?amV2QkVqZ0xVVlhHMzErYStjZ25ydUhCS1N5MGpjclhOQ25zNVRTMnJuRTJV?=
 =?utf-8?B?aGk2bXFnckxGTGdsMzJpaHFuVGNHcjRXTWozcXc5QVhWelVmMzJINDQycGcw?=
 =?utf-8?B?OTAzcUtqVmpJK3MzK2dQb2dxRk5UbTU2MVJaRjJSUTZ6bk42czhUdEdBMzQz?=
 =?utf-8?B?bTk3WWNMTEl5UlVFS3UvMVZXMDJSYjE3TjdsZ1U1bzJlWjBYWkMrYUlvTVg0?=
 =?utf-8?B?YVBlQ3E3UndaR2NKb0VOSG1nL0o5eEo4NWh6blBoSU5icHo2RkYyUU9OMWVU?=
 =?utf-8?Q?kK/jDX7VneSe4/rGkCDY3VrJ5o9B8Pwt?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3ccc659-daa9-4fcd-4df0-08df14745103
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8413.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 04:29:54.9052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9692

On 16/09/2026 10:58 pm, Maxime Chevallier wrote:
> On 9/16/26 14:17, Mohd Ayaan Anwar wrote:
>> On Wed, Sep 16, 2026 at 08:39:50PM +1000, Thomas Karpiniec wrote:
>>> +static void ethqos_get_interfaces_serdes(struct stmmac_priv *priv, void *bsp_priv,
>>> +					 unsigned long *interfaces)
>>> +{
>>> +	struct qcom_ethqos *ethqos = bsp_priv;
>>> +
>>> +	if (!ethqos->serdes_phy)
>>> +		return;
>>> +
>>> +	/* PHYs such as QCA8081 switch between SGMII and 2500BASE-X with
>>> +	 * the negotiated copper speed. mac_finish reconfigures the SerDes
>>> +	 * accordingly; let phylink validate all modes that path supports.
>>> +	 */
>>> +	if (!phy_validate(ethqos->serdes_phy, PHY_MODE_ETHERNET,
>>> +			  PHY_INTERFACE_MODE_SGMII, NULL))
>>> +		__set_bit(PHY_INTERFACE_MODE_SGMII, interfaces);
>>> +	if (!phy_validate(ethqos->serdes_phy, PHY_MODE_ETHERNET,
>>> +			  PHY_INTERFACE_MODE_2500BASEX, NULL))
>>> +		__set_bit(PHY_INTERFACE_MODE_2500BASEX, interfaces);
>>> +}
>>> +
>>
>> So, I had proposed this exact change a while back:
>> https://lore.kernel.org/netdev/aMgootkPQ%2FGcdiXX@oss.qualcomm.com/
>>
>> As Russell noted, this behaviour is due to the messed-up integrated
>> PCS support in STMMAC/QCOM-ETHQOS.
>>
>> I would defer to him for this if he's around.
> 
> Indeed, but we haven't heard from him in a while, let's see if we can
> figure this out.
> 
> Does this IP have an integrated PCS ? (i.e. dma_cap.pcs is set)
> you can check that in debugfs :
> 
> mount -t debugfs none /sys/kernel/debug
> cat /sys/kernel/debug/stmmaceth/eth0/dma_cap | grep PCS
> 
> if it's Y, then you have the integrated one.
> 
> Russell worked hard on that, it looks like a lot of the plumbing went
> through.
> 
> I think the right approach here is to have the PCS itself report the
> list of supported interfaces, instead of relying on the glue. looking
> at stmmac_pcs.c :
> 
> 220 int stmmac_integrated_pcs_init(struct stmmac_priv *priv,
> 221                                const struct stmmac_pcs_info *pcs_info)
> 222 {
> 223         struct stmmac_pcs *spcs;
> 224
> 225         spcs = devm_kzalloc(priv->device, sizeof(*spcs), GFP_KERNEL);
> 226         if (!spcs)
> 227                 return -ENOMEM;
> 
> [...]
>                                                               
> 246         /* Only allow 2500BASE-X if the SerDes has support. */
> 247         if (priv->plat->flags & STMMAC_FLAG_SERDES_SUPPORTS_2500M)
> 248                 __set_bit(PHY_INTERFACE_MODE_2500BASEX,
> 249                           spcs->pcs.supported_interfaces);
> 250
> 251         priv->integrated_pcs = spcs;
> 252
> 253         return 0;
> 254 }
> 
> Can you test settung the STMMAC_FLAG_SERDES_SUPPORTS_2500M flag in
> dwmac-qcom-ethqos ?

I can confirm that dma_cap.pcs = Y.

I tested setting STMMAC_FLAG_SERDES_SUPPORTS_2500M on hardware and 
unfortunately the flag alone doesn't solve the problem.

I think there are a couple of things missing. stmmac_phylink_setup 
doesn't use the integrated PCS bitmap to populate 
config->supported_interfaces, so SGMII is still not advertised to 
phylink as a usable host interface. Also stmmac_integrated_pcs_init is 
adding 1000BASE-X unconditionally, which wouldn't be appropriate here.

I did a proof-of-concept fixing those things and the end result looks a 
little messy: config->supported_interfaces could come from either 
get_interfaces _or_ the integrated PCS with unclear (to me) responsibility.

This POC did show that STMMAC_FLAG_SERDES_SUPPORTS_2500M enabled phylink 
to configure the integrated PCS for 2500BASE-X and a 2.5 Gbps link came 
up with no apparent issues.

Do you have any thoughts what the clean end-state should be?

Tom
