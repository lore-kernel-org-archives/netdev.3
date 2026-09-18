Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19013085.outbound.protection.outlook.com [52.103.14.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB34352029;
	Fri, 18 Sep 2026 04:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789706174; cv=fail; b=kc40AIOYEC7VI1BIpBE8F3M+EFxKpg2pt88Y3lp/9XmOtblN8gZlCcDivFCLr0L7iMzpOJtw6YLbiW7tjZ9l0oPGDQeg93ElFZJtPPPfHriYjXSJCsc0GrccZO9BfVTCQfn7KDniuExD2Dy6Na8EKE1Fauj1qzP3BJApwJ+EFas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789706174; c=relaxed/simple;
	bh=y4qinhAFZP8DsS2sPtZdpyZzbgXym2tYt9BhgDDRfjk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mjGmSTxdoLVQCD8hJ1hYOrQFH2JZ85OqL/8eqcyrMEhxptAC/RV8HcFGYKs3XvcHyK3xp3xwvhg/6eG+nZgdVrjhAaiofCxWOhPpqhNnQvWSLolcwGEK9Y4ly0qr0dgqYx9aG2AordxVWynPXCZ0pBhxWL3kHcIR40kODPm8WfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=O71kp82O; arc=fail smtp.client-ip=52.103.14.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="O71kp82O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LYa+I82oMxS4dxzqFtDPicaOrK6LOCnlQsVN084GqPWzzx/5ulPAMYpBGPowyY+IJ9XHV6J+SLUr8mRQCzj3JqkZCLDe8ZHhcOoVryMAjJWpi3Siyom/knSlBMDtxfiE1a5yK+zSWfROo7k1RJXV3meF99ra6wOxOuMNsDaUwiSxYwoNnn4/pcctPP9GFmww1Sl+cyaVjscObjiEW/wgpXSQ1lQO1TbZnK+XXNzCEGL/cCOyI1uH9WlRPntxErfeGQDD7vh3bwbKM2UcHlLbc7NdMWpgNh38fG6P1MAkw4BcINMH1tKrHb7NwYbp9GPyJvC/ruP+OdzMymYV2cbzHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tBsrzgwR1NDFDygnfJIs5xW5Y0vQnA0fL2XU+IjqjMs=;
 b=XQDjBl+tsrSqKVIg4R6N4+VfqjDaCd6nAjD9BE6H5lpKeMEN+sW1LWBEQZD7y8iwtmH7i83+J3DlvhzU1uo8WGBBpIJijcZE5rIhViUKN4/VTJcATyEnWFuN1LeSLMpqOrBkl8M4nnyHM4Uop93I1pn6RjMD1YWEllCm8K2uBJ1CgzZftAUVKK7oDYvDbA3A+dsyJMgyzE9QIO1ByozLhuBucOgv9rBP1OyBmLlp0ziXLMRnjbnE9awwtRK1L0GPltawO3TdSipVKHBMlZepp8NGqbVcpCropEI0MKpkwVGCQvLHDhO6oGvw7XB/MZQLnXZZA/6vnRO26i9XL4VynA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tBsrzgwR1NDFDygnfJIs5xW5Y0vQnA0fL2XU+IjqjMs=;
 b=O71kp82OLGuORsmOn2EFIRrhgmTRGyO30LqQziABnRaXA5yAzKtorjzik8GUTBV8v7Be+pyMZxLn2uqhCvo8HULWuIWgl4KZQdJcS9bzcZ/Ip6PFJzRC1GSDbnvQG7rsSWx61VMUZcUw2jp1Bs/ArDWDr1XWbeK+jX3yp3CdxyeTLcXhDG9pnihs6srvA7YCiu7jyBDiS/RXOQOE35/xF5kVUov1USHgnbbRsTtEZYUzjr6ZzQnn6rqLVtqout7NeR+sdNv6DAM/VY4Z0xJ87swwTH1UEArIFNGGiKFYr4Zx51aUMgQ+mllyWLYR/WcWOq41ySYxth3nqQboWY1qjA==
Received: from SJ2PR11MB8401.namprd11.prod.outlook.com (2603:10b6:a03:539::19)
 by CY5PR11MB6115.namprd11.prod.outlook.com (2603:10b6:930:2c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Fri, 18 Sep
 2026 04:36:10 +0000
Received: from SJ2PR11MB8401.namprd11.prod.outlook.com
 ([fe80::ccc8:68f:2e82:ab65]) by SJ2PR11MB8401.namprd11.prod.outlook.com
 ([fe80::ccc8:68f:2e82:ab65%5]) with mapi id 15.21.0406.014; Fri, 18 Sep 2026
 04:36:10 +0000
Message-ID:
 <SJ2PR11MB840156009D655CB83CD04EF8E4872@SJ2PR11MB8401.namprd11.prod.outlook.com>
Date: Fri, 18 Sep 2026 14:36:04 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] net: stmmac: qcom-ethqos: advertise supported
 SerDes interfaces
To: Coia Prant <coiaprant@gmail.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
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
 <CH3PR11MB8413131D50175690DF9FDAB0E4B82@CH3PR11MB8413.namprd11.prod.outlook.com>
 <3bdf2ecc-9dd1-428c-8841-36b1f19916e7@bootlin.com>
 <CALj3r0gXP0+bwsPVtuw=9RRQ6gpmuHzGc5PzF_a3XXXTTZYcqQ@mail.gmail.com>
Content-Language: en-US
From: Thomas Karpiniec <tom.karpiniec@outlook.com>
In-Reply-To: <CALj3r0gXP0+bwsPVtuw=9RRQ6gpmuHzGc5PzF_a3XXXTTZYcqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MEWP282CA0043.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:1dc::12) To SJ2PR11MB8401.namprd11.prod.outlook.com
 (2603:10b6:a03:539::19)
X-Microsoft-Original-Message-ID:
 <91ad1699-b92a-4d49-94d6-fc165f5821a2@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8401:EE_|CY5PR11MB6115:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d9acc3b-dd3d-4e99-630f-08df153e5c7a
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|6090799003|37011999003|25010399006|12121999013|8060799015|19110799012|23021999003|24021099003|15080799012|51005399006|3412199025|440099028|40105399003|2607281247196008;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SElmRWJITGRCc2RtZ3U0NStsQXQ1NWowZDhDVmlZWEFxTkg0cVNCZjBMMXBP?=
 =?utf-8?B?bXRIUGVUTHVmL1QrS3FLMjlIRW41UTlpNGNQMDhSdnk3RWRLNTVlYmNZb1BT?=
 =?utf-8?B?bWM5S1VrUWN1VEJrd3Y1aXJNN2J6c3Z4OC9oMnp3cUhTTEFjaFlXc0daQzNE?=
 =?utf-8?B?bXVHWVZhRGFLS2dHVS8vaVZqdGhtZ01BYzBXL29tMXBjMkNQNWNFVVgvZVNN?=
 =?utf-8?B?YXgwcEpnMzhRbUlRNWlGZEVqS3NpQW9zcitLaGM1OVlJUlNHc3ZxNndBUlRa?=
 =?utf-8?B?YzRMQlFrZjBxN3RjekExVTk4dm4xOElDMHVNVytFYW85ZkRhU3NyRmVKSkRr?=
 =?utf-8?B?b3lvWTl0K3NQTHFsalNvT2RoaXJFVGNuVlhLeGRwekpXclhtWTJPWE1MSWtw?=
 =?utf-8?B?anJEcFdQMStUbWZhRG9IYXdIOHFGcWVERUJjWFZUUUlma01WbGxza2V3b3JY?=
 =?utf-8?B?ZTkvcHo1cUk0eXNIbUZKRjgzQ0tNd2U3ZGtOeXN5NFVpTE5NTFpSRndaQzB0?=
 =?utf-8?B?WERiRFRUbUVwT2lSejd1RWh4MFNaVFNDNXhsUGN0dkZyb1I1UVg0VlA2eXNG?=
 =?utf-8?B?UW9ncE5BMExzWWlobExlUFFETmd0U3NaWTBiN2c1R2RtUDBtNEpHL2JTRlZE?=
 =?utf-8?B?S2ZybTV5T0w1dVdPcEpjZndYaEtzRWNGSmpqQWdnTEZFZHB6Mi92ZmJoTTE1?=
 =?utf-8?B?Q3NtYUYyRnJDeEJSQWtxY0xWSHpwZWxHNTZBTThZaG5QcmRXK2FzKy9VenFK?=
 =?utf-8?B?SnlLc2xFZkpLU1NRdEZMbWUrK1NHZUt6ZVVaYXp3elpEV3pwMHkxeWM4bXd2?=
 =?utf-8?B?cjhGSmU2RWV3SlY4dXY4UFlFV3lBbzhUTSt6a2MvVmpDSVJ1ZFh2YzNRYlFU?=
 =?utf-8?B?L1BBMGR1Q1ZPclQ1Mmg2aVJvQ1FmQ0E1YTRSZTkxQTdLY3ZlSldzWkpTNkhv?=
 =?utf-8?B?ZFB6bFZCNnhZdTIxNXhCdFRucWFOT01pekt1ZHVPakw5clBhMTdHc0gwa2R2?=
 =?utf-8?B?MlBqSTA3NDdoNEkzYmhWdEFESlAzNFBNSkg3Y3FFUHdJcUdLdGlUTGRyN3VQ?=
 =?utf-8?B?cXIya2ZVbXczRzB1T2Q4eFlFbVZJeDkvekliVGh1RnVJbzJDSnI3bDZRMUlh?=
 =?utf-8?B?eTJ1eWthTWxQSW1pMDdXZUJtZ3A2T3dUS3I0Q2ZCem05YWh5M205UE5iZFBs?=
 =?utf-8?B?TlZJckRkS1JBOVA1ZWhtRVVWZ3BKZEZsbXZXUUszMW1CV0xvbEUyeEgrYmg4?=
 =?utf-8?B?MjlOSlNtZ3pZRG1LcWxKYk1VeXFZdWFQVjFXY29NWk04R3dHMDZSYTVBRmw4?=
 =?utf-8?B?d2l0d21wQjFJbEI4UXJpQ1Q2RE1VRnk0N3JGeEk3YkVkUzBDR3dLTlgwcW5p?=
 =?utf-8?B?YTk5VnlYVndTZ0E9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ajZLTEx1YnBHMm9kWDFHR1BHV2tBR21lTGtZWXc1WS93K3IrZWxtcWxHeXF2?=
 =?utf-8?B?aGNLNEJPRjc5QUtEZGh1VzBxYXNZYTV6amJGTHlJcHd6TXIvTUhlSFc3VXJm?=
 =?utf-8?B?WUZ5WEtEMkVvYXZQLytFOVNUMjNzS3pBYWY2NDNIU0dmNWo3eVBCUCtmUmxD?=
 =?utf-8?B?SkhxYmpvSDZiL0JOY2Rzdm1neGVPR0RrZ2xHVG9pckg4Rk1CbzFLMmI0MzZE?=
 =?utf-8?B?Vy8xeC9PbDYyS0haOG9hdnZhS0pXWHE3enMwWm9jQnBENHR2c2Z5V0VNMXpW?=
 =?utf-8?B?Q2FuWExZNjV4K0FMN2pRM05YZWxjeFVYY2dzZHlCeVQvM3dMSG02WjlERVZG?=
 =?utf-8?B?cUxSRWk0eXVqTjJoQzdsdzE4UXBLZHN4R2J6UElQOHhkMUpKS08yRUhoTHNs?=
 =?utf-8?B?UWZrbDhuMlFUVlhaaE16ZWxmcTVobU5Gd01yMXBsc3Rhd0VTd0wxTERvaDNj?=
 =?utf-8?B?NnhBdVpYNCtEcnZ1cmU0bjRKdTNMUGhxcVNiOFZ4eUVEcHNRUGtDTnR0bHp4?=
 =?utf-8?B?dGNtTm9mZEQ1Tmdrc0pwT3o4Wit1SytLb0lpM3ZLQVArZXhxSXdoZE80SVRY?=
 =?utf-8?B?d1Qzc3JyMWRsalc4VVR0QkRudUFkSW02Mk5HZ081UjcxQzdORHlZdjVHRjVN?=
 =?utf-8?B?cTFMTTl1Q01VdTByL2pTTSt4MHRxbEduUy95MHBVTDl3b3lUUlpVMGJKZ014?=
 =?utf-8?B?TFBaWGZ5Z0pkUFhuNXN5N1o3c3p5b0VQTHVBVnA4M2Z6ZWg1dzIxTk4za2hR?=
 =?utf-8?B?cU05SytXTWVGeHlrTjB2RlAwWnpMUHVDZ2NqUUtOMEdjZXFzbjdtcFFBR2xO?=
 =?utf-8?B?by8vUTBuTEEwTUNuSE1EdXVpaDJJMXlqc25TUmFua1JOV3ZKOHFKZVgzN2s2?=
 =?utf-8?B?Qmw0anJrY1pCQ1JYYnpSSml2UDJvNUdRT2dPeWNaUjcxWXh6ajN4TU8rYnVE?=
 =?utf-8?B?MUFJSjRJUmlva1F2MzlSWGpjNFdydlNkRnZabGZsT3BaSGE4TkpEWTVnS25K?=
 =?utf-8?B?WHVqZGh3dGV2OUdzRWdoaEhhQUgxMVI3Zk9HZ2VMUVphd1NSdldQdGxIaEk4?=
 =?utf-8?B?dkJYbU9tSDdaQXp4TXBFUkdrLzBJT0MrUUdTVVBsMG1Ddjc5YXlWd3ZFR2h5?=
 =?utf-8?B?SFNFZ3ZNRTBsT2dtRGlmUDYzcmdjMGlaS0NwNlY3a3BWeWx3eUZzRkJ0emIr?=
 =?utf-8?B?QVFQNld0RHpSamFOa3JkazJRSHBWcXNKakNwNmVUT1NPanB0RHZtZXlZdS95?=
 =?utf-8?B?SUhpY3dzUVNMbDVSRXgrTzkwWHdhaUtORjN5OXZLd3lodTNaZ0wrYlZmT3dD?=
 =?utf-8?B?eW5sV3dtckI4cnN2bTA4TURJOC83M0pJYWZKWURwQTlEUXZBci9zcHpsZ1hm?=
 =?utf-8?B?dGNwT1A1VDQranN2VEJCU085Rk4veFZiZkdxcyt1T1lEZ2NFY29USEtJRUVa?=
 =?utf-8?B?dDhmRzhsZ1l2QXdmUjRxWlMwc01QWWdYNVBOYkZUbHhnMzlWMWJoK01lM1pN?=
 =?utf-8?B?UHRHNGYreUZiaEZiWGN6TGN5ZkFDWUNKUDBVQnZVU1IyS2JPVWYxR0duRWpF?=
 =?utf-8?B?NWtHNnFMNVB1R2dDeldEd0F6dmtxR0V6bWRidEwwRFdqSFpIeDEwa1UxYStS?=
 =?utf-8?B?UVhqbzBGbUJIS2xZcVA0TWIvQ09nMU1vTWxjbVJnVzJHTkdjWWF6elIwZEsy?=
 =?utf-8?B?dmlYK01uQXZDZGd6aXJlUGJsSEhiMHZIOHBqK21ZRllQMkJDQjdTMEwzWXkw?=
 =?utf-8?B?am4zSFlVTWRhMHdndlVqWG5vUThhQVdhaWFXSE1JTUhhc1MvUmN5em5MNk5m?=
 =?utf-8?B?NmMzS1R1d3NWZUhEUVBpT1RoRFN6MlNLVkxwUi82eVdDUVIvK2NxSlMweVdw?=
 =?utf-8?B?aTlyM3dEb0hRQy9yV2tJeHhMVmZUQjBYaWFDRXhPRmhSbTU2MnNQeEIxc2JP?=
 =?utf-8?Q?Nd0MLhmzEo/xND0UcZNBfpcOK04DzhJm?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d9acc3b-dd3d-4e99-630f-08df153e5c7a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8401.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 04:36:09.8259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6115

On 17/09/2026 6:21 pm, Coia Prant wrote:
> Maxime Chevallier <maxime.chevallier@bootlin.com> 于2026年9月17日周四 13:36写道：
>> On 9/17/26 06:29, Thomas Karpiniec wrote:
>>> I tested setting STMMAC_FLAG_SERDES_SUPPORTS_2500M on hardware and unfortunately the flag alone doesn't solve the problem.
>>
>> Yeah, but it's still the right first move. Russell planned to do that as well

>>> I think there are a couple of things missing. stmmac_phylink_setup doesn't use the integrated PCS bitmap to populate config->supported_interfaces, so SGMII is still not advertised to phylink as a usable host interface. Also stmmac_integrated_pcs_init is adding 1000BASE-X unconditionally, which wouldn't be appropriate here.
>>
>> Ok so, the missing bit seems to be that priv->integrated_pcs isn't taken
>> into account in stmmac_phylink_setup(). This needs to be added then :)
>>
>> Looks like there's also the inband support that needs addressing

> On the qcom issue: the missing bit seems to be that
> stmmac_phylink_setup() only looks at priv->hw->xpcs and
> priv->hw->phylink_pcs, not priv->integrated_pcs. Extending the existing
> OR to cover the integrated PCS would let qcom-ethqos work without a
> new get_interfaces() callback.
Thanks all for the feedback! Including the integrated PCS in 
stmmac_phylink_setup makes sense and I've now confirmed that this works 
end-to-end on my QCA8081 board.

I've prepared a v2 that replaces the get_interfaces change with two 
commits: one to set STMMAC_FLAG_SERDES_SUPPORTS_2500M in qcom-ethqos, 
and one to include the integrated PCS in config->supported_interfaces

I reviewed the work that Russell was doing and I see the problem. Both 
the integrated PCS and the ethqos code are configuring in-band 
negotiation. On SGMII this occurs twice - both turn it on - and on 
2500BASE-X the PCS briefly turns it on before ethqos turns it off. On my 
board, it finishes in the correct state.

I have tested cold boot connected at both 1 Gbps and 2.5 Gbps, and 
transitions in both directions. However, this is a slow transition where 
I am physically unplugging the cable.

I attached kprobes to dwmac_integrated_pcs_config and 
ethqos_fix_mac_speed_sgmii, which are the generic and Qualcomm functions 
leading to ANE configuration. We see this on 1 -> 2.5 Gbps:

464.233469 integrated_pcs_config interface=2500BASE-X neg_mode=OUTBAND
464.234778 fix_speed interface=2500BASE-X speed=2500

2.5 Gbps -> 1 Gbps:

279.018122 integrated_pcs_config interface=SGMII neg_mode=OUTBAND
279.019708 fix_speed interface=SGMII speed=1000

During the cable swaps, Linux briefly reasserted carrier at the previous 
speed before the link went down again and came up at the new speed. The 
log contained several PCS Link Down/Up and ANE-complete interrupts. I'm 
not seeing any evidence of churn or link instability once connected.

Russell's wider change is compelling but affects a much wider range of 
hardware. I believe this targeted fix can work separately.

I'll post the updated version shortly. Thanks for your time.

Tom

