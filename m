Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazolkn19010020.outbound.protection.outlook.com [52.103.20.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18EA3B2D18;
	Thu, 16 Jul 2026 16:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784218489; cv=fail; b=slsWt+Vh0+8jSiqaUXXfIt8uv/b1y7xN9fyHAu5FmvoBMjgpPYJGSR75u60GRtHQvjxhEWZj+edRKJZ5qHtra2HAwnu/r4OoJVZ4ve4lIJom9TvkBYutb29NZlK5bteZOmmSI7WApfUJmGo4uLD0NE6KtiOhzr5zgxOrb7v6n/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784218489; c=relaxed/simple;
	bh=ozMI+sIxXYjBS9WcXiZ1zrY3VGFFrImgwadTx0wI+B8=;
	h=From:Date:Message-ID:Subject:To:Cc:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GRHrp8b0FgfAkWpOnBXFpVuFe/FDQk3YxKiUBJSOhE27jMOmwPfgw1nOjW1pSqDoOwL6d+AZH7euvi/WxlBgS3kZpj8lItwJEt97TVNy7GGZvX6QT1B2xWbHK4dOd0ntWcTLVjaUpl60qLmc4/YW3Xerk7VB1eT10IWjkyZtb+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=tRLjr6R+; arc=fail smtp.client-ip=52.103.20.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="tRLjr6R+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tvlyzwqx4fPz54rZTNHqysHbcY7k7Olamk3wm/yYGs0RBAYUDvpieaZgzjAiNFcPxBZXOKMvbS3xe2pJiC82lCxLPY3A8LfRl8K+Hzu3CuD6fb3en/PIPyFPLx9L8CpYf9ez0uajpzix4o/RCuL/qJGCU5gZtlu4GM07+uJm/vPnmb0yC4oPyGmzHdLQ7JFL2Jslq63doREjJTvdD3AlB2FCkI8kIKN5C4Odfq9Q7RVTepVKQ1d58gAQXdyAJ6QEvN1P45op2KzLCazmCXT9EdG1W8dLcQrIvZarFs8v3Ji7d+EOqnMUiUDgK/VcE4YIFnZloFhc0CCVj5EZSolIBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ozMI+sIxXYjBS9WcXiZ1zrY3VGFFrImgwadTx0wI+B8=;
 b=E4jrgBB5xtFQbUWl1sQGG1h6pitOLHu/z/Uf8I1Fr1jwlqWnssasvipD7br+9h8MCQLON3yAs0z4F1MCbw2yL9irg4Lne/qrYI94//MJTd1J7dAJy0LkO7uY2L/0TZDUNXeI/t2Bv+ZTMo2RqKzY7kcX2iF/njdNg/o37oZQ4YcBCz45BUC52WDIQ/xiKGmHZhcGQQJoMEKrVw9zHxFR903hxUq9JwP8Ix3YM2tam0CwzHUiJJVYoQzZKuxhslw/eI7HaJCDo+94ZIVnXBbHIUqeJZ2/UxPLcoQVl9H0w8TqiBtDA9pqRas0D/kme49XxAaHOlJnkxBkd/xoPNszdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ozMI+sIxXYjBS9WcXiZ1zrY3VGFFrImgwadTx0wI+B8=;
 b=tRLjr6R+DQbaemax1uE/wL8uUIYvVzlWjhEh1eLlmPNYw7v9cd5XUDCjLPy4zP3XLYpu57tMXupraUIJ+qaHgo8WebXbxRAaRRuc1I96AuDOesyuRBJm5gy8G5b+C3JzKw2mtn82V0ZW7p8fN4sN3ZQzMC/6WjWGr9Z0Bjz+SJnbNdzZNs4tbBkjk9dW9QOdVqopl+ZLP2MaXgTv2sHvZpRMxekULJsBA4DCYPZOtDVOFVtMCqEpkiPr/Irz3v2a3dKLK/vFQbo0ZCWmvU1PwRgAiIdKkHrFuWMeKJmKhYShq08HRYRT9Oxkf9/UOC/Ocnlu5DqMbTAkA7dEs2LfIw==
Received: from MN0PR19MB6091.namprd19.prod.outlook.com (2603:10b6:208:382::21)
 by DM6PR19MB3963.namprd19.prod.outlook.com (2603:10b6:5:24a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 16:14:36 +0000
Received: from MN0PR19MB6091.namprd19.prod.outlook.com
 ([fe80::af9a:4cc3:facf:9374]) by MN0PR19MB6091.namprd19.prod.outlook.com
 ([fe80::af9a:4cc3:facf:9374%5]) with mapi id 15.21.0223.011; Thu, 16 Jul 2026
 16:14:36 +0000
From: Liu Changjie <liucj1228@outlook.com>
Date: Fri, 17 Jul 2026 00:14:17 +0800
Message-ID:
 <MN0PR19MB609111152E1C759EC7F13DC6ACC72@MN0PR19MB6091.namprd19.prod.outlook.com>
Subject: Re: [PATCH net-next 0/2] net: phy: Add Maxio MAE0621A support
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>,
    Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>,
    netdev@vger.kernel.org,
    Russell King <linux@armlinux.org.uk>,
    Rob Herring <robh@kernel.org>,
    Krzysztof Kozlowski <krzk+dt@kernel.org>,
    Conor Dooley <conor+dt@kernel.org>,
    devicetree@vger.kernel.org,
    linux-kernel@vger.kernel.org
In-Reply-To: <c03931fb-019d-42d7-99aa-f2d97fb97660@lunn.ch>
References: <MN0PR19MB6091CD5A84D2DA5DACF434DAACF92@MN0PR19MB6091.namprd19.prod.outlook.com>
    <c03931fb-019d-42d7-99aa-f2d97fb97660@lunn.ch>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGAP274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::14)
 To MN0PR19MB6091.namprd19.prod.outlook.com (2603:10b6:208:382::21)
X-Microsoft-Original-Message-ID:
 <977c4d69893b42ebb99b46755c5c12ee.1784218457892324.tspi3m-maxio-10-100-reply@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR19MB6091:EE_|DM6PR19MB3963:EE_
X-MS-Office365-Filtering-Correlation-Id: 72899b0a-d974-469b-0af0-08dee3555449
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|51005399006|5072599009|24021099003|37011999003|23021999003|25010399006|15080799012|6090799003|8060799015|19110799012|3412199025|440099028|26104999009|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bWZGYUlHQ3RHeHZvdVpDUHhMTGs0dWVHKytTQnY3dE1jTlRxUlZRUXVEenZ2?=
 =?utf-8?B?Wk1rajdzR05kWHhkempUclcybFhuSXlSeDUxeDRVeHE1ZTA2V3A1Z1kyN2lN?=
 =?utf-8?B?WWdieGkxcmdvTkU0Wm1hTVJmbm9XMUswbnozZFp5WkhoaldWME1MOUIxcGRZ?=
 =?utf-8?B?amVhTUFMb0FKeEpVNDUxaTNWSmFHODBycWFWTW1GakRHeTNSSFJrM0pveHhS?=
 =?utf-8?B?Yi85cWVLQlhpZHlBaEs5ZVB3U3ZlMHR6azFHQSs0ZElJTmJyS2h5QldacTdh?=
 =?utf-8?B?MGZrRWZZYnk1cDQ5U3JaYTJsYUluMUtCQTBVRUh5RWJJRnNIU0Z4Qm0yYlEx?=
 =?utf-8?B?ekVLdkJMQ0VnelZZSFNKKzBmR2pqQmRqUktNc01TQTNYOFZGd0lTRXE1T3Q5?=
 =?utf-8?B?WC9iRFJQK0VacGlpUmlxSUY4MXpkNHpXNzN4aml0NWZOVDVVanZrZ3BqWnRo?=
 =?utf-8?B?ODg5SG1qT0daQy9Ea0h4d2w4cVRzc1JLYlA3NHJUSVhOVmFheHNpZE01d3lj?=
 =?utf-8?B?b1g5b0JDODNCSDNpMEh2L2E2MVBzc2ZlK0tuZHZVRHFJbkt0dklibkQxakRS?=
 =?utf-8?B?Z0NJZE9Fa29JM1JwN0NQRUFCdUxGbjdlblhMdjJ0NVBoMTJuS0ZGTExqMkwy?=
 =?utf-8?B?UFpObWE3bGNiNGxvVFYvVXRPdkpldVlmN1VyTlIvRGFxMDFTZDBzY2JUKzIr?=
 =?utf-8?B?KzNUSzFaK21iVHRtWE5kUHMvenc4VlFNcDg1NlRtTTRkVjliMG9KMUJBMmdn?=
 =?utf-8?B?RUkxT1ZHcitzYmZDOVBKaVdaTFplRDViMlZDSzBkaDVOeEdXU1ZjNzZycGRL?=
 =?utf-8?B?dyszNmRnZ0ZTdVg0UzRCZE1LeTdiVXRrampZdjlwMU1IdjVVOHIwSVU2dzgw?=
 =?utf-8?B?Q1AzWmNxTjUzQUxWYWR5a2UyNmRxemdSblJlem85U055c1pxNHRlbjdXNTh0?=
 =?utf-8?B?NmJqK0hxSVpvclVrUnlESjRDM0ZNcWZidmdVQ3d4OTFscHRkMlpJMUJyRVV2?=
 =?utf-8?B?TzVTU0VNbklsTTZtbG43aHUyRExTSlNDR0g2dXduZ09INDFOT0tyZ2dxUjlM?=
 =?utf-8?B?c1J1dHpGejUxYTlzU2F2S1d5Z0FTcHlodFNIK2NZbmZ6Z0FzakQ5aHBwYVE2?=
 =?utf-8?B?Nm01SUxobUJXV1VXWEdZUEpBSzdKNTdnelVtNkJRRi80Q2l2SGEvUUlya21J?=
 =?utf-8?B?U29MQWx0NG5OQko5eWZKZ0pnLyt6emszY05va0w0cmtVeFljME15K2ZwajZr?=
 =?utf-8?B?TmFpYXpwNSsra1MvUFVja0p3UElZUzhzeXNMR1l4SS8wN0dabmZGUHVRRkhz?=
 =?utf-8?Q?RQMkgCm+SNNI9GeTw/CjIh8TM4VbK2Ya/J?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b09JaFQyd0RVazhVMG5sbmVEZ3NvRm02S0d6bTVONFFmK0w1YVN3b2I2NWg3?=
 =?utf-8?B?S0JsUVFOKzV2bVM5OWM3ODhLczE2Z3ZOc0hrVjhycHN2WGlyd2Y3SDVWaVVI?=
 =?utf-8?B?WWFEcVVjQnkvNHhaaFkvSFgzOGVuN3BJT1R3MVFwd2ZsZlNIN2RFVGZPN2s2?=
 =?utf-8?B?WlhVZFp0MkNuNCsrSFVtSnI3bzh5NVlTeUlWckdVR2k0N29UUlVEUFF1b2pY?=
 =?utf-8?B?Y3lJNkZKaHpLdmdvTlJzZjVZQjRmM3IvWnJJVlZQOEtGTEg2aVJOYjcyZk45?=
 =?utf-8?B?WWN4dDRYMEUyZTJaNDJadDRGd2g3WnI3T0loMFpmZmJ3bFl4cXFGb2VQR0Zp?=
 =?utf-8?B?MzNGL2l2WkNDQStaYk9EeVh6YXYreHNZZm5ObXdrOEpXc2hoUDZXemZvNnlK?=
 =?utf-8?B?YzRHbXlPS0piQlFMWGR4dmI1RGpjNFhNZElLM2UveDl6R3RRSVFMQXhab3Ex?=
 =?utf-8?B?QnZWRG1kSnA5cVFVRWxGQUxUQi9PUXRNTis0Mmdxbk96bGJkMVRqdFNXcy9W?=
 =?utf-8?B?MHdzUTNuaXUyeVFMZlBxSS9ad0Q3bUdYbEhIblR1T05ZWEx4LzhMSi9EclMr?=
 =?utf-8?B?NjgveDdVSUloR2pxN2ovc2pWQ1QyS2tiNm1qYkJiY3YyY2dQb2w3Vk9RWGtu?=
 =?utf-8?B?Y1Z0TDRvYW1CVkZoVkxCOG9zTkxSTTVEM1BpOW1waDUzMm9vQ0c4NFhOM2NB?=
 =?utf-8?B?ODN4eVh3Y2tPVU1GSXJvL1JBSy82YTBJcWkwcStjZG5LejEzY0JtT0RqNVcx?=
 =?utf-8?B?WUxib2lpSHZQblV3YUkvUmlUb3pBUUxaUWIyaWUyUjNnL3FoUTRqWmY1YlhW?=
 =?utf-8?B?VDg1WjYwYmgzRGhXeVdyMUYwTXNxbzFzMVpWRGNMQ015b3ZBNS90TzFqZUdx?=
 =?utf-8?B?NFdTS0dudDhGZ1N2RnR6Yll5dit6cS9uRWd1RndWcEk2NlJGaG5xV2ZkTVNO?=
 =?utf-8?B?YVFsRzQ2UDhlQkFXVGxkam02dHFuWHlGQTlqN1VKRFNIV3JIOFJnYzVOZi9M?=
 =?utf-8?B?ZVhSSS83Y3V6eUNGWXhLMTBGWDY0ZnlFZEZLekVOYk9PcndZQVBOUkVEaXJi?=
 =?utf-8?B?aG1STkpGZzVSLytQbGFHMUE2eFUyUUZ4ZmFvbFlvbjNvYitBS2RLU3E3UUlz?=
 =?utf-8?B?RlpUOW13Z3NsdVFIU3ZlaDM3a2VtZThlRkpEcUczcCtpUlk0TG50RlFqblR2?=
 =?utf-8?B?VVZOdVplK0F0KzZucXgvS2l1WnEvT2pObGpUclZrVy9RTGpLZlQ5S0N4STJ5?=
 =?utf-8?B?RFZGNDlhSFN5US95bkdGYmxNMjhhNFNXMXdVNzBmcy9VVlVGUnhEU1oyNE5G?=
 =?utf-8?B?MFUyUDlkdm1MTlliNEQ5VDU1b0VTMEc1MUY2TlNvSlFnQ2Q5UEFucHlzLytI?=
 =?utf-8?B?U1d3cEpENEdIMlBtZXpkanYxUFJzMnVna242bkE1bDV1TmZmTkVnamk1dHM3?=
 =?utf-8?B?c25UTWFpNkpnQ1hZeUVpZ29uMG9wT3lvOUx5dGlZTEc2c0lKeVVXMlRVNjFr?=
 =?utf-8?B?RzAvRm9xWkN6RklNRGNEZDVTeXVLV1M0YUQ1NmQ1Wm91MHRWMW1tbHZzazFM?=
 =?utf-8?B?Q01Vb01iQmxHdWNiQ2cxVSs0alhQRHh6cGZvMXhTUU93UEozbjV5eHFMeEZI?=
 =?utf-8?B?ckdzZm1VQW5tWWtVaU9zd0M2ZkdFcThoZzdtVTdwdW1wVzVvbHNXbXNObFVH?=
 =?utf-8?B?Q04vdlYreURlSFVOV3hzVWNMMTJ4QUxMM3FCMnFGRUQ3SjdRQkI4MEZWWWFC?=
 =?utf-8?B?SWkveHpSUDJoSElrR21odXB2VjNGWURXMDl2Y0NvaVlQSjJ0R29ROUdpZk9N?=
 =?utf-8?B?ZjlINjhMZ2ZRcStycXRGWkNqRWhMM0VNUG9TZVhHcm1Mc2lIT0N6MFZYYmM5?=
 =?utf-8?B?VGdSSERaZnRvZk9GdjVBTCtFOGozRnFhN3VFdEdsWnlobUE9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72899b0a-d974-469b-0af0-08dee3555449
X-MS-Exchange-CrossTenant-AuthSource: MN0PR19MB6091.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 16:14:36.3496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB3963

Hi Andrew,

> What happens when 100Mbps or 10Mbps is negotiated? Has that been
> tested?

Thanks for asking. I had only exercised 1 Gbit/s before sending this
series.

I have now repeated the test with autonegotiation enabled on both ends,
restricting the link partner advertisement to one full-duplex mode at a
time.

With 100BASE-TX/Full advertised, the RK3576 reported 100Mbps/Full. iperf3
receiver throughput was 94.1 Mbit/s board-to-host and 93.7 Mbit/s
host-to-board, with zero retransmissions.

With 10BASE-T/Full advertised, it reported 10Mbps/Full. Receiver throughput
was 9.38 Mbit/s board-to-host and 9.37 Mbit/s host-to-board, again with zero
retransmissions.

For completeness, with autonegotiation disabled on the link partner and
100 or 10 Mbps forced, the PHY fell back via parallel detection to half
duplex and the link came up, as expected. I excluded throughput results from
those runs because the forced-full link partner caused a duplex mismatch.

After restoring normal advertisement, it renegotiated at 1Gbps/Full and
reached 941 Mbit/s board-to-host and 935 Mbit/s host-to-board, with zero
retransmissions.

So both 100 Mbps and 10 Mbps negotiation and data paths work with the
125 MHz CLKOUT setting.

Best regards,
Liu Changjie
