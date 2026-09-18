Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E134441616;
	Fri, 18 Sep 2026 06:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789712597; cv=fail; b=gCdaE3dsHWFJzbpr4KQSsr/tWaNsRvDS+LKlAJ9R725vU1E6QqHfDVZNa5359Mu0eUdVCiiTQxXmGvF28nef3iMzmE/HduVT3Elz1KFHWq7WaGPGsGXy5/HK/9G/KltDVEs8MTHV/z5SzE0BeQkBf+Rn+apXqSupQZb4EAu57Pw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789712597; c=relaxed/simple;
	bh=tk6vB/h4b7NlaMaAypEnxdo+Qhehz/A1cQ/FMNIPyqM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Go+Rhp6xWD0kpvXDKGuukX1rO3UuqqI95X880l76HYI5h+2zg16KXmiWMFHlL4yUaSMQeYTsxB55KAyhcw0UtepmAD8jYzLmiETkxULfbgeuiM04840DQVFoCRKxx8SlIrVySeBEcgXCIztAlbWJPPHZBwHiAU3pSFuyiwZ0Kkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=ZOqagrIK; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="ZOqagrIK"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68I5xYSc744830;
	Thu, 17 Sep 2026 23:23:07 -0700
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11023102.outbound.protection.outlook.com [40.93.201.102])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4grxxb87kf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 23:23:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J2nbHMCfpGpDbpHwgaA8SvU5eki1JE5r3mKRcO1DbyK2Bt56PuTaR9BK5BYpdXlnJ3TaJrpIoKrRRiVCb3Tr6dFwnEHGeA0m3wK0kFYcfn5GeugZLvB75ZrbuyaF1iWQ30xjIviDMUmGh5esWUlGpJJmUY/OJse4G1v4ssvFLxTktYKp/IrqJN3F2JPLj5vfaT53IcOfY58l5PsXonLsM0KU47vI1kbcL4+WAUUf4xuafpnN62yux/hWwi1A6CvkSoEMf891yGe0arOWkZ6fIyI/+jhlv0MVQiuBd/XnR01kDu/QAZMJoUipGU4cIOWYtCorTfvFJ4/RVboL4EVyfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CMbZ+V5cg1Kg3+RLuqxJ+b7Qp/u8yIQ5kzJDLlA55+A=;
 b=sMQVUNG+SAKo18KCMtZN3YTEeQJ2szLxFY7Jl7+IUPsSbRPWcXwixz/IjUc1mvSR5efIgEUxyvk8kyymEYUqq4rO1hx8nkFGRqyOdaLmLbtuiEyIU4Re05D5uNDXKFk7WTuapZoYeRxFkMjkJmfwUHlsS0lWwr4DIBQCrlr3FhB80onSyj0rizQkozdPrJkpkoQQ8u7cilNB0592m4TNKACaYl2dzCmcJ3flqcI/OxSvwKES8BcnHgt+j6BtxxmoCVomjzo69DqJ175GeFQb9Xzi4v4GRgpkDsf84BjbL5HqQ8D0fg5MvQWiZhMgtlVR0rAVKS1SGEJgXJQE40irVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMbZ+V5cg1Kg3+RLuqxJ+b7Qp/u8yIQ5kzJDLlA55+A=;
 b=ZOqagrIKN0EdLElU5YgOTm1+t9DA0s4ZDrMRzBnyaesjhbchZMcic5R4aOm3h9xRBXtwBbwWbq+CQj9czDyUcXDP9zwLfrEqwQA4kV9AqbYuNDMOM6J8diZUom6EV8U7IMgt+1BUvreGQ1/WuT/2RBHv0jQVQ9c4Po5zwbom4eQ=
Received: from DM4PR18MB4384.namprd18.prod.outlook.com (2603:10b6:5:39d::13)
 by LV1PR18MB988731.namprd18.prod.outlook.com (2603:10b6:408:3f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 06:23:02 +0000
Received: from DM4PR18MB4384.namprd18.prod.outlook.com
 ([fe80::99a5:6a38:56fa:cda3]) by DM4PR18MB4384.namprd18.prod.outlook.com
 ([fe80::99a5:6a38:56fa:cda3%4]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 06:23:01 +0000
From: Subrat Pandey <subratp@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "pabeni@redhat.com"
	<pabeni@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Ratheesh Kannoth <rkannoth@marvell.com>,
        Geethasowjanya Akula
	<gakula@marvell.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>
Subject: Re: [EXTERNAL] Re: [PATCH net v6 1/2] octeontx2-pf: Fix aura BPID
 assignment when CONFIG_DCB is enabled
Thread-Topic: [EXTERNAL] Re: [PATCH net v6 1/2] octeontx2-pf: Fix aura BPID
 assignment when CONFIG_DCB is enabled
Thread-Index: AQHdQO1sOzbTtZsqtU6liYn0QpDwp7bSD6kAgAHYr3s=
Date: Fri, 18 Sep 2026 06:23:01 +0000
Message-ID:
 <DM4PR18MB4384D0E5C98A52FF5DDBDF79AB872@DM4PR18MB4384.namprd18.prod.outlook.com>
References: <20260910062657.3712256-2-subratp@marvell.com>
 <20260917020340.2544315-1-kuba@kernel.org>
In-Reply-To: <20260917020340.2544315-1-kuba@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR18MB4384:EE_|LV1PR18MB988731:EE_
x-ms-office365-filtering-correlation-id: 502d0051-34c0-492d-0c65-08df154d4a73
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|56012099006|3023799007|4143699003|10067099003|11063799006|5023799004|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 b+cM0BGShh4qPeMeUjRcQCSwSSEUkWf5yZfXB+JXuPxpmvQ9rmagjCosBI7aulx/UvdB/iZnLkEoHOZKwpQhKTYLENuAnDo0X/Bq1r5IqGt8tG5eicN3Tri+paGJAZG94dujZRoKoECY4LTYfKicMj5WoBdJs78gO/H3Str/Q8pHVd51KZCRELUN1JgV+z7o1IMKpEb/DAmLtEF5n4YgBTlIvB21yFnW+GBCXWqhn5lJGrfvxhzaN+0BzKwhXzvFqQVkxv4XrPCI1DSLAVLY6e2qckKVVrjZ8y3+8hYbyXBnHZM1i2RpnvmSw1H7qg3YhEMa1Stm0DjfLPvZPcLQg8TG5SVUdnBbb79lcwqslxnlo6yZU1LjEtNxTNNn/C51q4Bd9UDNhs8JME8VOmGoOU/1rSJkVEp7P7yTnhMyDazrYQBH5PXZZNQFOdYWq3ADQ0R8zp891myU8eg80cjdE0/OHhTnDQaIDQU5E+QPSMZLEBIhZB/2YCQXIF5N2p8Iql4on/csE8gZO5gc/WNacLfGhThLhgsRMoIceUIsOVMubRezIxJniAc4hLr1hD9ZSCanljvmPEDKR41/aqo2dpk/PnUJmkhhvY9UxHg+vSflBchBiG13KK+vcCmvka5ljL3IIa6wlKKLiveVDsbzK4D+R4enNHsYMW41fu+R4ompbWMD2+ige7Mhi/PV0VHkm7QOQnlkFArEWHdKllBcL/uffxsafqiVvf8R07DR7rU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR18MB4384.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(56012099006)(3023799007)(4143699003)(10067099003)(11063799006)(5023799004)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?hAxHBVx9TVq+uabKliy+5v08xD+JkGyUfdVmC/qieY3MjEV0rNLADNP7xf?=
 =?iso-8859-1?Q?hMbQ3EDeOcyOQ/ge0o4NptyZ+Im9aY4EEG+55/iyjWlsvKmvdTQ7CEgAMp?=
 =?iso-8859-1?Q?8PTrONVCoIZctW7UW5ThaLJZ2UL1R1+bkUgDm1whnj2fxN1yT2QUmaZRf3?=
 =?iso-8859-1?Q?hNJzMIHuikqkLqOU4vA1PDtVBNgS4LoozqRB6JdqAU5jfga5Z8hHzGhZOd?=
 =?iso-8859-1?Q?MRGXlpZ80kcTQOl2BC0F9sLMzuhckq/87zUWFZ8gD882iYI51OEEw6I5Hp?=
 =?iso-8859-1?Q?9oPCZkyq26zTV24k6Qet1XLv1MHxpiXWhqoWFs7/cbR/iZZ9SaevE00qVs?=
 =?iso-8859-1?Q?G9NVDMcqJOnATZ/1YqUhqPHnyAg5d9kFqyg4jwqp6FwLuvE6kXSpTIUUJC?=
 =?iso-8859-1?Q?9RQUDV+dCsNvdGxpHAX14dMCAjSr3I1pmOZaEm7DKB6gCMYWrwbspeOSxl?=
 =?iso-8859-1?Q?IZ0sXB/b41YxtZn+ZMKlGcvYoZxGRO/y6UJRbrdN1zkDUtU1gHnxaqpzJR?=
 =?iso-8859-1?Q?wcx1KRn45FqKIHiXxyTUTqafJubOJCnisrtG02Y12u5LmPXwGNKvfdnbXR?=
 =?iso-8859-1?Q?S3mToCKjZl6phN38oonxdydS6Z3M0Ae3M2PB0Rl1foU6Vih7C0UInrjdWH?=
 =?iso-8859-1?Q?cImo288mKwvmhE6iiKRJ3Kh7WSHKXK58XQid3OxgG8juxAwQTJfz6ROyed?=
 =?iso-8859-1?Q?5GPWrop2Ynn/IA8KWUw/MFSjqTi8gz+1J5ZR0yBD1YaGlMhVQrAIbMSiUj?=
 =?iso-8859-1?Q?In4Ui2R6grV8eFY4M38avMoW4MSCGTMG3AOZe1iXe1ue5Gph/8SwqyCS8Q?=
 =?iso-8859-1?Q?jY8DGtHJ9oELF+T5OniAEE1fVo747c5YHgzJKnD6HksqnCmTpttlNIo1a4?=
 =?iso-8859-1?Q?kOvE0aqnVPSha5KLW6Kq7138BIh1PCnPyydsFHUA4PQDCq+bjiQQmEYd9H?=
 =?iso-8859-1?Q?+5Z1IGg7pdptHIrK+jzRxs929n1kt/CEtiN32MrSZ1n4Xashkqgrf6QKZZ?=
 =?iso-8859-1?Q?TOnPwEYmoWQgQ2RnbXFPDAWvVxU7RzKIU2FYvXcsLCdVuOnMEc2DYAY+zR?=
 =?iso-8859-1?Q?+L1bFNnlWuyBKZEp90bMgQvskrHIZWHIAeFiLcXQ98dVlRMpsEBqi+YFBa?=
 =?iso-8859-1?Q?21vMi7xmFfYfvZjZQP1N/yECNnYfLm2ZPDbKoue6XGLjCWhQ4xMr84ElHV?=
 =?iso-8859-1?Q?7A7cfGENrzitPnF0wLSPxCUf+HCgaGUMS04XqEWMmBxVrKgpOqwj2ecQtm?=
 =?iso-8859-1?Q?yst1+1fl99Vv53o4Oxdi/cBZPRnahnFTWjeMyad6AYgOGHdOu750IFiYMr?=
 =?iso-8859-1?Q?20euyFvgKKZgxgfVb7WJEXiQknFJ8z07U6Kccu91AELviRU4c+u7YB04Vl?=
 =?iso-8859-1?Q?cNGRjB/EpUEmXYe/13gpe3ajuDVvqKVZV6nyBgM46SWI7toHgKLJZne/Pk?=
 =?iso-8859-1?Q?SEmijB8kOyUNoLO7QHxF4QFef8zJNKQonUqNScH1nZnfIqSFPd2PP90BND?=
 =?iso-8859-1?Q?UKLuspsQukUIzQxrL4O6uliZj5dJjEvZv4rMuFVfTRS9M9/SIdCVQJvbzP?=
 =?iso-8859-1?Q?0MAlfj+H//5JbTWy3ISpAiZFhJ3stIzxpGfctD72NlhpUokuFIqEA4UkLg?=
 =?iso-8859-1?Q?ZzkVRzav86vjsTQYuIHHeO0xJhXYhDFwKkAc5Y/2890KmeGJOPRvLfJJUy?=
 =?iso-8859-1?Q?gyx0S1TjGP0UJufiuSGcelqtTesYntXHJPmUz1mxm/Awogb7hfWpFXC+JX?=
 =?iso-8859-1?Q?7m2whR4F4gk4HbmruY8EeKTya95Fh0MsEc+qkzyGSMJ069?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	0UZkzHS4f7dLGmmaZYvNjyJVXsnwG2XNw+tH6I5+jwgYV/DKKedhGTceRAiIrHamWy2PWEGhLs5umQnYBnhIuseB4V+EuSneN5/odgSWxnUxgf2TxokD8UO3HjLp/icOaIZJlDAdySOmAWxkoQnppdq6le19YP+i8uGP9oE5Lvfi5uCJcGIQUSLlCr+AW9zJs1hM4sFLm8O/peKtHHNJW2oGVi3TPGh8U0lCWBFk5yC0xn1JFuMYGSCeYND3tMh3yb0lG2EwaJb2uhgCOAOWVXoSK4PUk/ZmghjwL3Sv93DLSrCmG+SzKrS54DEXQwh0Mw+eUehPfiZN8DKlzI2nZw==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR18MB4384.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 502d0051-34c0-492d-0c65-08df154d4a73
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2026 06:23:01.4859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w9reLHppK/ZztkMiDlZKnOTQyUhBxCp8oweXTot1/vcjpFdfZQ7mbsoXgvos/rHxnmLetVFv6EXtSKcA1DeFkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR18MB988731
X-Proofpoint-GUID: _KAfVrAfPH5LZygWIePzAf2xNwpcdPJ0
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDA4MyBTYWx0ZWRfX2J7+ZrklyWAa
 CP0NaIooPltsazc+yg4qQnCVpNMUjUYRLK+gN3lbN5mqY0YqbvleSDG19MXPA+NSAe+IAZTPgLZ
 duYBJc1rKK/1GR67pzmXgoSZVOzZg/E=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDA4MyBTYWx0ZWRfX3Q4CV3ujqEaX
 33y5mCTUJsjUq65nTpsSoZDm3u9E38iBkReqVgH4HcZOmjBlCCJjiEXUhvJ54ojohAUr+45rIkW
 3Mxh0osDjLbBnqBjK4cWFWuiNroGM/aYKC8bMsKzp2lHJNvXLTvgh62MKVJrWh63YmNV7wzRphK
 pdYWpyNjnedUdZ0UfYmWja6TEpV+oRvuXC0+Q7MTA1/1WqUifNqR11RtpUye4jhQrPA6um58auZ
 0vF2fCHitqQcpy+ryKOJfTglBkvvjSYW29fBvzZz1Dzbh6fGMtQi8RSUoxAQNEHXYY23+w93Ym9
 23uMNC8ae4pWikCerqzKrg0JqfT3oKe9VTO/+JSofaPm5W3wtzayml+lZvBaojKF4m7/xnFB+iS
 woUks4xfFkuiasf6T7wojNPpQ1pzExQLFea8OZPuPxpwZAkDfowRLHyNeXWHZClnupBnQzmJCkA
 knRZGDOpkSeZ4d2T2Ig==
X-Authority-Analysis: v=2.4 cv=JfApPkKV c=1 sm=1 tr=0 ts=6aacd8cb cx=c_pps
 a=V5lscarYawUrr6zEozVj7A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=VdqzKS8jKosA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=KLb8SQ-2ampKDuaWgFYA:9
 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: _KAfVrAfPH5LZygWIePzAf2xNwpcdPJ0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_02,2026-09-16_02,2025-10-01_01

=0A=
> This is an AI-generated review of your patch. The human sending this=0A=
> email has considered the AI review valid, or at least plausible.=0A=
> ---=0A=
> octeontx2-pf: Fix aura BPID assignment when CONFIG_DCB is enabled=0A=
> =0A=
> This consolidates the per-file CONFIG_DCB ifdef blocks that pick the BPID=
=0A=
> index for CQ and aura contexts into a new otx2_get_bpid_idx() helper in=
=0A=
> otx2_common.h, and drops the equivalent cn20k_aura_bpid_idx().=0A=
> =0A=
> >     Previously, BPID assignment under CONFIG_DCB assumed=0A=
> >     `queue_to_pfc_map` was always initialized. For SDP VFs this leads t=
o=0A=
> >     invalid memory access as it was not initialized.=0A=
> >=0A=
> >     This patch adds a NULL check for `queue_to_pfc_map` before=0A=
> >     dereferencing it. Also, simplifies the logic by always assigning a=
=0A=
> >     default BPID first, then conditionally overriding it if CONFIG_DCB =
is=0A=
> >     enabled and the map exists.=0A=
> =0A=
> [Severity: High]=0A=
> Does the patch match this description?  I do not see a NULL check for=0A=
> queue_to_pfc_map anywhere in the diff, and no place where a default BPID =
is=0A=
> assigned first and then conditionally overridden.  The new helper appears=
 to=0A=
> dereference the map unconditionally when CONFIG_DCB=3Dy, which looks=0A=
> byte-for-byte equivalent to the ifdef blocks it replaces.=0A=
> =0A=
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b=
/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h=0A=
> > index eecee612b7b2c..2a63d22cbd8d0 100644=0A=
> > --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h=0A=
> > +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h=0A=
> > @@ -1029,6 +1029,14 @@ static inline int otx2_tc_flower_rule_cnt(struct=
 otx2_nic *pfvf)=0A=
> >       return pfvf->flow_cfg->nr_flows;=0A=
> >  }=0A=
> >=0A=
> > +static inline u8 otx2_get_bpid_idx(struct otx2_nic *pfvf, int qidx)=0A=
> > +{=0A=
> > +#ifdef CONFIG_DCB=0A=
> > +     return pfvf->queue_to_pfc_map[qidx];=0A=
> > +#endif=0A=
> > +     return 0;=0A=
> > +}=0A=
> > +=0A=
> =0A=
> [Severity: High]=0A=
> With CONFIG_DCB=3Dy, isn't the trailing return 0 dead code here, leaving=
=0A=
> pfvf->queue_to_pfc_map[qidx] as an unguarded dereference?=0A=
> =0A=
> queue_to_pfc_map is allocated only in otx2_dcbnl_set_ops():=0A=
> =0A=
> drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c:otx2_dcbnl_set_op=
s() {=0A=
>         pfvf->queue_to_pfc_map =3D devm_kzalloc(pfvf->dev, pfvf->hw.rx_qu=
eues,=0A=
>                                               GFP_KERNEL);=0A=
> }=0A=
> =0A=
> and since the Fixes: commit, otx2vf_probe() skips that call for SDP and L=
BK=0A=
> VFs:=0A=
> =0A=
> drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c:otx2vf_probe() {=0A=
> #ifdef CONFIG_DCB=0A=
>         /* Priority flow control is not supported for LBK and SDP vf(s) *=
/=0A=
>         if (!(is_otx2_lbkvf(vf->pdev) || is_otx2_sdp_rep(vf->pdev))) {=0A=
>                 err =3D otx2_dcbnl_set_ops(netdev);=0A=
> #endif=0A=
> }=0A=
> =0A=
> so for an SDP VF the pointer stays NULL for the lifetime of the device.=
=0A=
> =0A=
> Would something like this be what was intended?=0A=
> =0A=
>         static inline u8 otx2_get_bpid_idx(struct otx2_nic *pfvf, int qid=
x)=0A=
>         {=0A=
>         #ifdef CONFIG_DCB=0A=
>                 if (pfvf->queue_to_pfc_map)=0A=
>                         return pfvf->queue_to_pfc_map[qidx];=0A=
>         #endif=0A=
>                 return 0;=0A=
>         }=0A=
> =0A=
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b=
/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c=0A=
> > index 175992188c18a..0f3f405d9f1b7 100644=0A=
> > --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c=0A=
> > +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c=0A=
> =0A=
> [ ... ]=0A=
> =0A=
> > @@ -1132,11 +1133,8 @@ int otx2_cq_init(struct otx2_nic *pfvf, u16 qidx=
)=0A=
> >               if (!is_otx2_lbkvf(pfvf->pdev)) {=0A=
> >                       /* Enable receive CQ backpressure */=0A=
> >                       aq->cq.bp_ena =3D 1;=0A=
> > -#ifdef CONFIG_DCB=0A=
> > -                     aq->cq.bpid =3D pfvf->bpid[pfvf->queue_to_pfc_map=
[qidx]];=0A=
> > -#else=0A=
> > -                     aq->cq.bpid =3D pfvf->bpid[0];=0A=
> > -#endif=0A=
> > +                     bpid_idx =3D otx2_get_bpid_idx(pfvf, qidx);=0A=
> > +                     aq->cq.bpid =3D pfvf->bpid[bpid_idx];=0A=
> =0A=
> [Severity: High]=0A=
> Does this call site still oops on an SDP VF with CONFIG_DCB=3Dy?  The onl=
y=0A=
> guard here is !is_otx2_lbkvf(), which matches PCI_DEVID_OCTEONTX2_RVU_AFV=
F=0A=
> and PCI_DEVID_RVU_REP but not PCI_DEVID_OCTEONTX2_SDP_REP:=0A=
> =0A=
> drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h {=0A=
>         static inline bool is_otx2_lbkvf(struct pci_dev *pdev)=0A=
>         {=0A=
>                 return (pdev->device =3D=3D PCI_DEVID_OCTEONTX2_RVU_AFVF)=
 ||=0A=
>                         (pdev->device =3D=3D PCI_DEVID_RVU_REP);=0A=
>         }=0A=
> }=0A=
> =0A=
> so interface bring up on an SDP VF reaches otx2_get_bpid_idx() with a NUL=
L=0A=
> map:=0A=
> =0A=
> ndo_open -> otx2_init_hw_resources() -> otx2_cq_init() ->=0A=
> otx2_get_bpid_idx()=0A=
> =0A=
> The same holds for the other two converted sites, which carry identical=
=0A=
> guards:=0A=
> =0A=
> otx2_init_hw_resources() -> otx2_rq_aura_pool_init() ->=0A=
> otx2_aura_aq_init() -> otx2_get_bpid_idx()=0A=
> =0A=
> and cn20k_aura_aq_init() -> otx2_get_bpid_idx(), where the removed=0A=
> cn20k_aura_bpid_idx() had the same shape.=0A=
> =0A=
> Given the Fixes: tag will pull this into stable, could the helper be=0A=
> respun with the guard the changelog describes, so that SDP VFs fall back =
to=0A=
> pfvf->bpid[0]?=0A=
> =0A=
> [ ... ]=0A=
> --=0A=
> pw-bot: cr=0A=
=0A=
We will address all issues in the next version.=
