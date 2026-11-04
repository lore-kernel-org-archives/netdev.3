Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793797073;
	b=07nbt07FwlMrTr2UcTGSvWeMHU3rFLffLL5Iv5OKq5gk/ziiVzVi27gbbK5b1rynbH0l
	 Q116JIG9MhhEA58mfRk9vqg+4GSKNKEGFkTk03LlmjtUOElz7RqpSZXlcNdmSC/4lN6wT
	 BjuVr3DAgsMFpdQc7SyUoB/xYdCwzGs8Oqr/6zFnt6gJxDGKrb9MMZtQEPz96HkEA5aHD
	 S0NQwzdPeQ7egN/zkBZk+S5Yq+p2t4hgn8abSOVdCNPi7wKHtA9Gj03jCBczI3fXf9ueQ
	 ZlsSFaR6qBAPxApMNa0NbKdMTL0vvUON2NQVykusM8F4aECmYzXtjzlFoDrfCvCdM6w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793797073;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 Content-Type:Content-Disposition:In-Reply-To:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=hHIpzF0x8C9EFYv3dVzOuKSqCL9CNF9oFfViZxj4j1g=;
	b=wjHvrPp0Fyk/ezLHktvkd0XLhUpEnE5tFuITuneoi+Q/tb8fKgTOrU7fK2BJ8aEA2sJ9
	 qH9Lmo7frZnKS+7IlDC/T9lfyzakv0Do45IFw+J1S/mhEt4o+0h7hbe/bE7DWRXWZkzG2
	 UXqOpzWEzvXwLSX8ztPcBK62Ardd4ZRwiuNhX/M4fDiFj5+GDm/67jA8UMtIsURyji52e
	 n6cZr/ZviH1dv8voBj7t9JFqKR3JBYF5Mtq7atbMGvAgGCIcVFofl9/g8SCOz2EqKZBYE
	 fVteV2adOSjHi5+v3cXShHb50Uij5YinTmZ4ZVBPIMVMRimkrTLxyBIgANUt+Us7yfw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=YRaK2JeX;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=Au7PMGD3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3BB606D80E;
	Wed,  4 Nov 2026 12:57:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF3BB606D80E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=YRaK2JeX;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=Au7PMGD3
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4Bbefu3324899;
	Wed, 4 Nov 2026 07:57:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=DKIM; bh=hHIpzF0x8C9EFYv3dVzOuKSqCL9CN
	F9oFfViZxj4j1g=; b=YRaK2JeXAx0SgOBQu2T2XY3KLitM4+VLPs7Ky8hu5EYef
	RDUCKbNqgJyQO8iEj+Jy3NrezKvfdLw9Gg+ORvXnTvqUaeatEiwYQda0MNDuaylc
	+AJFCJi4QymROQ7CYQGGXxKaToN0pkZ2Y2eRt9qOTkSGZUkEH2pr1xUfSHLVo8y3
	X/K3Bi2ks+/uCjfU+PWQDkXfyx7RBaU2+FU/3rMsBiowHEzwP8I+QElktHICP5xC
	vnBPr2qx78Z6LqjyrRhzxNtPXxNQ34Eb2NbRhwHtQyRrOIuZi0hz93zca5xFJmBH
	8iH6ukzFmBJzkwVvapGAfP2FM+8oXWR0jGYoUjQmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=DKIM; bh=hHIpzF0x8C9EFYv3dVzOuKSqCL9CN
	F9oFfViZxj4j1g=; b=Au7PMGD33+oiCt7qARoiH+zY0vCNHit8wMxw+jxzdYnEP
	1p+uubKGgELhPc7TmC9CUFFJR0uLs8epFrBAT3zk5s2yqblrL9vEj0AI1tlmyYIu
	1KXs1qegWMgxwm7ZxUdGoNHG8lnnk225TpheObFL9Zzw+XshlgRwmYZg5v4hm5Kb
	qiIK3J/UmxTmntI6pFd74RA9K2a26OQygmvwKgz1gyeyZzw/+f8HUIN6XvWMAmPD
	Ts/0JsSmx4IH3zOxsZiwoB5AwKZzQmO9FhRW8k/34etKG3IwLX7TBZzjk5RSZWQV
	2YwN1EaYVRklnRouNOHxsSXW+YURtYD6pYGImoqhw==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010017.outbound.protection.outlook.com [52.101.201.17])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hqh166nxk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 07:57:30 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YgjpHf64hwdT1l8MOZ6bvmBcy5U96xpghWsOXi0/zPRME8NtKLHUcXNrPm+Ef5KltQ29I/4D9ldrXBNm8CdNiAehr8h7TwdSdArhEB9YW6KzIjdXS7pizUF8l/LfEqhMaCQ/+vJ7SIiIRnPRXxC2NaPJLiicuh/CAJu0Noy/C8JuKe6KD1r1/ekmyGdZwES6IjvzKkhSuBn/VXvY0//QWNrvKUs1NAPff9BXHgTK9QNFO9NjjsAxihZcM0ag489UTon3zXEJd66/u7aYc1UgFiWWvOmsC9vJLpMZ7ujUX1juZIXZh++OlNDMT5d6V7ImQWly0vxvUwjes2uTqkXBJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hHIpzF0x8C9EFYv3dVzOuKSqCL9CNF9oFfViZxj4j1g=;
 b=Od5hCE9jJNBXpWS9ePAyWDWI/51wiqZnT5xBKWKjOf/fy3Z0BHoDfCVEMPVujvcXcUlCDdxhg1aBYuQ4Y99Ibr7K/1stOR+Plh9z+EGcAcgBnhdC6qTqrzjJV3jq5XrZdnJrfrmmz0UbZZcR2gs+s9v1KiVU85oMbi2kdNYBkrGcmgusLTiZefob5HT6qiBI1mhQCO+9iibrrFohFFw9Fl+XRk4Zk1dKS614OKSvF17ehMnD3O4ZIoKlYcXHfS7UnEfeZzockLR1tp+mh64rZHCAe+yUV1WQKeZ0PLfPsM8auaB3kiaA4a4V3X7mgl7Qv8YW3qJFo/8VmZBzxwW0uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from DM4PR03MB5981.namprd03.prod.outlook.com (2603:10b6:5:388::24)
 by BL1PR03MB6199.namprd03.prod.outlook.com (2603:10b6:208:315::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 12:57:28 +0000
Received: from DM4PR03MB5981.namprd03.prod.outlook.com
 ([fe80::7af0:3071:4d42:63ed]) by DM4PR03MB5981.namprd03.prod.outlook.com
 ([fe80::7af0:3071:4d42:63ed%5]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 12:57:28 +0000
Date: Wed, 4 Nov 2026 13:57:24 +0100
From: Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin.sipraga@analog.com>
To: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Cc: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        linux@armlinux.org.uk, luizluca@gmail.com,
        maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v7 08/10] net: dsa: realtek: rtl8365mb: re-latch
 the family D SerDes
Message-ID: <ausrVrtHQHvac9bV@analog.com>
References: <3bf4dd70-9771-497b-8c27-e925e0ef81eb@yahoo.com>
 <3ecac0ea-830b-47a0-931a-67fea637f0c3@yahoo.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3ecac0ea-830b-47a0-931a-67fea637f0c3@yahoo.com>
X-ClientProxiedBy: CPAP307CA0012.DNKP307.PROD.OUTLOOK.COM
 (2603:10a6:380:3::11) To DM4PR03MB5981.namprd03.prod.outlook.com
 (2603:10b6:5:388::24)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB5981:EE_|BL1PR03MB6199:EE_
X-MS-Office365-Filtering-Correlation-Id: b6c7970e-ce2b-4ba6-de8e-08df3a732e20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|7416014|366016|22082099003|18002099003|10067099003|11063799006|4143699003|261009223027099003|261022105027099003|261026121527099003|261026140227099003|56012099006|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	UKHTMRZCekWXWOuk+XZxMYqKp9IeDnJVqtbwrw3ZjGsYZetKJ/PNuFuk5AfGUjfFJFqtiG88SpPqOmDLxs/mSo003KwWFEQAb+7hSRw0Xy9PJY0rVFjrlwZe3L4VpDcEMDUZN2eOk3mO/1uQMvbrGDUIVIJd538nLGSGzWYAshkPDWwfm1HWVakCPS9CEjJZzDWKWL6moe62TRl9+rWor1WSFmIqS4SAmVQGF50I8xkG6KUQu1btr4cZV8o36YBfsdvrDZ0iCrdJKIVxFzcDtmujkHXxjNIn51ziWm6GMD6pe+6GTEz1Md6tuWQcYJXnSogmZsdXBRacJbH+kt9l5TJbdMHaoDI9BvgA+zJ9j6MjZyuRYyS2cvxmlYx2Lp7rZ+Ys1AUPpw63hXRhX9YS7tUqLfgP2P22/8qXdLC85EtFicyoOFoxy3UbZhSaycEe6M7ehiVFllRiIzw4TPHsl8niCe8mT3kKITlrRUU83HozUlRuz0riQBkMjmVMOrnnYBHu0yAKgkUtPN5QdPa3ETa/N23dc5axGIDteaNlorObMhCdZauhtHOl1xHfcEJIGZSUwfhw9RQUm85ev+O9cTb4QRZiwchCWwWGYOj32jRiSGdwS++319kki5Z7o3fo+avWhae0GgMGX7/BBkknO5LxWCUb7Twi9fwdiPwerMQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB5981.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(7416014)(366016)(22082099003)(18002099003)(10067099003)(11063799006)(4143699003)(261009223027099003)(261022105027099003)(261026121527099003)(261026140227099003)(56012099006)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OEJYemFhVXZtOExpQURIcS9QeFI5TEU2djUxcDkvMzVzL0NIcFptb3VMbDhj?=
 =?utf-8?B?cWtkM0RhU0xBNmhQTEl3OGlOSjhSdzZxS1BQaTVwZXVBT3lBbzdWbkwxOU4w?=
 =?utf-8?B?NFZHVGwwQVA1SFY1UFQ2Vkd0UXUvdEhyczRWaDI2VHk4YjkrdmdWSU1WUTVp?=
 =?utf-8?B?cy9FMllCdHlkWUxBdkx4RXlEMi96WHAzd0JHTktoaXN6NndIN3RxNUp1alpL?=
 =?utf-8?B?M2pTcW1ZMCtLU3EwMVcraytTditJOXZCeUlFUC9pbkhQNVB2RG54a09VRll2?=
 =?utf-8?B?amtzU29DZ1BVZllkNURNdkdMOUF2Uy9Rdk1TRVBJcVJuOE1nRzZlellYeDBr?=
 =?utf-8?B?Rnc0ZEtPdlMwVEszY09LK3JycDRITEc3QUpmMzBFS0kzTVZzak82cDhEQzQ0?=
 =?utf-8?B?L0dxNjZxN2RRS2Q4LzJqRE5KTXpKU2RTVnRaakIwU3VTbWQ0SDR1SkM4NEFH?=
 =?utf-8?B?SUFrYTVXZmp1WUhHODIwSFB3SkhrTzZwV0VLQnJoNnc0cWlpMlFmZllCZUsw?=
 =?utf-8?B?aUZpRmtvUUEyYkJIRG9PTzIyOFMvMUw0TEh5R25nSnBZYk1kNjdkYUtUbldj?=
 =?utf-8?B?bGhKL1dkY0hoemJhQ0duQU1wYVFEanByb1RreW45aDhoZFhsaGhUREJtbXlq?=
 =?utf-8?B?YUw2VXpRZFlVL0crbUVqNTIzUU81ZitSNjBDWWwxRzJRRWtlQ3phNHV3bDJ2?=
 =?utf-8?B?TUE2VWcrWlFCS05EZW5jSTlEZXkzTXJUU0tZdkh4d2NRUTNBQWN2dUJoTGgx?=
 =?utf-8?B?MWdGbjNtbDBJRDhSZEdHMUxUc1dsdGJDZzRjTnMzM29vMklrd01lVzFqWW5U?=
 =?utf-8?B?Q29MRHdJdHlIQU9rdUZoc0RBR05mMkhaMVZLQys3VmxJT2pKTjN0bjg5MllN?=
 =?utf-8?B?REF6UWIvazhUQ0swNWs1am11MFZUcVZiVThqcUd5cGpkN1NadGh4ckk0aDk1?=
 =?utf-8?B?NUg2bzlKMGxDME1QbFloWW5ibGlNTG9CNWlreDVmdnAzYmxFZlVrZUVYaHVz?=
 =?utf-8?B?alJmQ0IrY3h3RlNkdFNCa1ZnbjVKRGJGZjhaNTZ4QVdWRjBRNUQ3ZWw4N25i?=
 =?utf-8?B?UFB5ei9ZNlZ3b0lCWWlXVmZWR2RrZEhOc3BkSzhpTEttVU1OcDVMeThrOXIz?=
 =?utf-8?B?RjVsNGZ3OGtMR05mSVY5elZlbVZWbWk2bHBkV2xwaHNteDdUelhVTDNZSGRE?=
 =?utf-8?B?R1dtYkZIMjJzVUFSaytwbjd4ZWVCSG1ZcUpTT0wyb2FacWtGVzd4VnkzK2hE?=
 =?utf-8?B?MkdQREJQRHNzTGRVNWNwb2ErYUpUNXM1TG5pS09velg1M0VxREdoWUR0ZEZk?=
 =?utf-8?B?Y3VaQ3Q0QjZ1R2tmL216Ri95MDFPMTBqZ2JXYTRSTkhCTEZoUUl4SUEwOEVT?=
 =?utf-8?B?dHlrdmdWeWV5cUtnSG9Pc3dXRlV6OXdYaENuNzQxYlBpOWF3NUptTlpBaUYw?=
 =?utf-8?B?cW1pc0JrWGtQNnFNd0dBT2VacGZrWmN5dmNtR1krWnV2MFFlYWplcHdobVZp?=
 =?utf-8?B?bEdMaHgzMUR6K1lFeVlGRGhhYXE4bzRwNUpZNU10VFZra3hkMFFXd2d3U0ly?=
 =?utf-8?B?Q1drZmZpSFBWT0loakxGQnNqWDhXcENRVnpMY0xpWjZ1VTVYZVd1bGJGd2Zw?=
 =?utf-8?B?Nm42QWZ3QWdiOTYyYWY0czVEeElNaTlmSGhhNy9JUEo4dlNRRy9kbkwzLzBG?=
 =?utf-8?B?TWdTN2Z4d0l4ZDlSenVnQVdJN2dyTkhaNlIxWVgwblAwdEV4UDRFMXpGWVFt?=
 =?utf-8?B?Rlo5cERQWVJBNmtSWVg5Tk9Pb3BuU2QvblFldkdoN0x4ckRrZGlIaU1FU3Qy?=
 =?utf-8?B?MFZOdmkyWnk2cDVEVzNnU2RqS3BlVzRqdmFLQXZWVWFubEpCeE5OVjJjeU1o?=
 =?utf-8?B?aTIrRkJndUZGYTdydnRCWm5HWlRwdXFndDFXWlYvakdYQTlsRjFQb0tUcnU4?=
 =?utf-8?B?TVpoaUpvUHYrc0Y1dmZVMHpXRkNZTFdmK09mMURoTmFnemxtRmgwcEI3WmQy?=
 =?utf-8?B?VGxFTzVMa0xMb0dWZk5lc2c2bk1ybytYQ0pXVDA5L2NEeTVKS3p2cWFTSERj?=
 =?utf-8?B?RDVtd3NSZUNiREhiOWo4R0NFUXhEZzljZU4rWHFrYm4xazR5WkRjd2hZKysv?=
 =?utf-8?B?Z2I4NHdWSHdiOEozbnJnZS91dEhzcklxNEsvS1FUWXVDakEzVEdPTHFyRFNM?=
 =?utf-8?B?cDJnQmdLYzZMS0ljUEtWYUpqZlZ6KzZFSWNXUEJXRU82alV5QnhwajdEZDg5?=
 =?utf-8?B?Q2srUVdrZktPY1JuWWY5RDZsZERaSFlPeDNFeXFZVmFyM0prVHNqTzNheEdF?=
 =?utf-8?B?elVnN2Z2c1FoaFNtRStPUnhNSUZ4Wk1mMVFSamdJOWtZMXNUY2dvdz09?=
X-Exchange-RoutingPolicyChecked:
	Tijq1dNtd+QgSZe5X1eSYebEOitWZ4NGNRzrrohsrsOOVKuN0SpKJcC5lgzhErm4fqjZw13Uq5b6PVyBqWLJbpvK/byODffiLGbS2MLWqesE1tF10ZIn1Y2cpRbTjAfwyWD9hhyyn15F+7niAcCS7OQRrAPu2hbdQ3nhZiHmTNkYZL83fwgfCBVDj7XEnKruUmAgfF5AEAnCuc5cY09Kjyunk/arM3PKmIOpxUcC0MBDOXFFQuZ/BRnWSc/eOC+bFybrorYYtutfZY2VnrgqirbUpUKFLpewzXQeSlAJzqvKnE2fLwpi2IrgyEqjXgn8XlxlYvccg70EmTO/pYXzXQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6c7970e-ce2b-4ba6-de8e-08df3a732e20
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB5981.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 12:57:28.4577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yqg4sNFD7eV7zJ3BI4ds0Ko2k4sXiIaTdUDc9/2YGEV9PSqFZYtGo/DJt0Tl3TuBk8YGEk3uG28KkvyGAuS8ydk2BrmdwnT+TXcYodPYwaI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR03MB6199
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA1MSBTYWx0ZWRfXwSYktxHST7C4
 psc1Be+TnFBqaBLcx3I31AJ/NeQEW+4XUl+sZuO6Qf7W2uYpXfnCyFBFLajjsiBDBmS38MgsCea
 XyohPSzEtUHVxeYeg1nRqPiNQdQppwC/4kO4ZiHs1ff3Twm9bd8f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA1MSBTYWx0ZWRfX2euwPkFcQVru
 fAZIQUqG6bjNJquPNb0P5QH78ba39UvxeRnDOQJTYuUyPkoGLLDtLEwQXvu6q2mKatx6L456U7y
 oB+xi6zOADupib/jmnLuufhUBWR1MXVXiiw5btN/yWxJ8d+UjrQI+4Nm9d4qcgs8myYFhs0eslY
 AVP3Lb2ly5E8k2I7JP4FE6ViNnEKBo1WkMuMz0+AnVYdmwj40nY3FyA5ebAxAcfery1ZVhHHln+
 fxQspLrKhqBH9/R19C8AMZPRIEq6ApYRVwxJE+b/vLR9v4UZ2afeOsX5PLy8lIIYVnGyBK98EFr
 0cMslmGm9uLJcE+M2w8y/EGOhj4rjs4FxqJrixffW8bV5vBfEtR+cHrJrnajjvlO2HoUsZYVsSj
 wng2oSEDT9gfa8ibrOvNYEIOOE3YQoqt7xv08Ef6oj+OL2XY0pEEOKqcksOc9S6RCxSVC5vHR2Z
 Ag9Fpg+kgi2ttFzzvtQ==
X-Proofpoint-ORIG-GUID: mvvw3T00Lo3g1MXOPQQTNj-3HoTXvnao
X-Proofpoint-GUID: mvvw3T00Lo3g1MXOPQQTNj-3HoTXvnao
X-Authority-Analysis: v=2.4 cv=QtHLTlyd c=1 sm=1 tr=0 ts=6aeb2bba cx=c_pps
 a=EaWthEyNNaJ7GkMLLYePaw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22
 a=zUeJSql6I5xa3lOTfRoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040051

On Mon, Nov 02, 2026 at 03:43:45PM +0100, Mieczyslaw Nalewaj wrote:
> The family D receiver latches on the DISABLE -> HSGMII edge in SDS_MISC
> rather than on the value, and it will not latch until the MAC at the
> other end of the trunk has brought its own half of the link up. If it
> does not latch, the trunk reports 2.5Gbps/Full on both sides but moves
> no frames: the CPU MAC transmits, the switch CPU port counts no octets,
> and there are no CRC, alignment or FIFO errors.

[...]

>  
>  #define pcs_to_rtl8365mb(_pcs) container_of((_pcs), struct rtl8365mb, pcs)
> @@ -1357,43 +1404,53 @@ static int rtl8365mb_ext_config_rgmii(struct realtek_priv *priv, int port,
>  static int rtl8365mb_sds_write(struct realtek_priv *priv, u8 index,
>  			       u16 addr, u16 data)
>  {
> +	struct rtl8365mb *mb = priv->chip_data;
>  	int ret;
>  
> +	mutex_lock(&mb->sds_lock);

OK, I don't think I can give a particularly good review of this patch
since I didn't follow the previous work for SerDes support... But at
least, can you use guard(mutex)() here? ;-) And elsewhere it might
apply.

> +
>  	ret = regmap_write(priv->map, RTL8365MB_SDS_INDACS_DATA_REG, data);
>  	if (ret)
> -		return ret;
> +		goto out_unlock;
>  
>  	ret = regmap_write(priv->map, RTL8365MB_SDS_INDACS_ADR_REG, addr);
>  	if (ret)
> -		return ret;
> +		goto out_unlock;
>  
>  	/* The SerDes indirect access engine completes the command within the
>  	 * register write transaction, so there is no need to wait or poll for
>  	 * completion before the next access, matching the vendor driver.
>  	 */
> -	return regmap_write(priv->map, RTL8365MB_SDS_INDACS_CMD_REG,
> -			    RTL8365MB_SDS_INDACS_CMD_RUN_MASK |
> -			    RTL8365MB_SDS_INDACS_CMD_WR_MASK |
> -			    FIELD_PREP(RTL8365MB_SDS_INDACS_CMD_INDEX_MASK,
> -				       index));
> +	ret = regmap_write(priv->map, RTL8365MB_SDS_INDACS_CMD_REG,
> +			   RTL8365MB_SDS_INDACS_CMD_RUN_MASK |
> +			   RTL8365MB_SDS_INDACS_CMD_WR_MASK |
> +			   FIELD_PREP(RTL8365MB_SDS_INDACS_CMD_INDEX_MASK,
> +				      index));
> +
> +out_unlock:
> +	mutex_unlock(&mb->sds_lock);
> +	return ret;
>  }
>  
>  static int rtl8365mb_sds_read(struct realtek_priv *priv, u8 index,
>  			      u16 addr, u16 *data)
>  {
> +	struct rtl8365mb *mb = priv->chip_data;
>  	u32 val;
>  	int ret;
>  
> +	mutex_lock(&mb->sds_lock);

Like here, etc.

Kind regards,
Alvin
