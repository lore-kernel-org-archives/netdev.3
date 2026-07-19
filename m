Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB4122F767;
	Sun, 19 Jul 2026 12:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784464887; cv=fail; b=jiYYJaxibwL5Wo4y9XeWx3a88c79ueI1nHPYqxEJMADZUHY5p6zmBWrg5KyUiK3FIuOA4uQifB4O8RULIbkgN0wFLL39MwpF9B6YhDSscC3eFJquKJH59kLXvmnog3gTyYPw0GQt82AeINT39BduWoKy0zWrkJem5qYr3Cofg30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784464887; c=relaxed/simple;
	bh=eVpZ4KgWenCuonP23TeIMfSnWvPmku2I4pvIBh7UuW4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WNnJowCyLm7eTr/AHg9onkeG6tgEy6iQs784jVnIMeCysMKQsRlrVZeQ6dLpbZA2rP4Ym6QMGUOg+DLGqhlQNd/GTHZX6O9h41jKCmgscdN2gIDkMuC3U18c2pRXEsM3FcAbzoYtihb7tQddd68TTgmtIS5x+CwgQDIH3PUbx+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=fExGM/yo; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="fExGM/yo"
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66JCTi1s1824485;
	Sun, 19 Jul 2026 05:41:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=2DLE6Cnsx5z79dGawBkubdaa3Jy4zD3rO4QZr2V79CI=; b=
	fExGM/yowd8kCNHuLIMEAdO5ouSvIk8iJ5J23DC6iazhSwuN2BFwI9MXRNv5AqOL
	zYmMEjbYnXet9ZM74SbclIlDpasPmfW3Idv/+IUmfdAHi7hz9hJGcitPI0O6QMRS
	deA9ozvPMk0fNtoAEod8p5EjNY/5yHVd7IK6pDqmPMnQGJlXZxAzW2TAAj+bcms1
	utQgFiULcpcsmS/6w9CglZqI3GjeKV9nqz41GlBGArIDz53tfSZfDrw7PPZCb7hC
	ADmwX8D/i4UhgTWLuYblFffNWEUKAY2TPwJEuZxNzis6h5pnex3BdVsYeqaYaaU7
	H6hPORolhqFBPVC8JpNS4Q==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010023.outbound.protection.outlook.com [52.101.56.23])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4fg4rygy53-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 19 Jul 2026 05:41:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KY6pcNLBrdCeySo8gJlB7Jd4AoTzoYeFeFoBMawkbTumkpTVTioTQAv1R+Ui+RrDscGle8wiku2mjy9+kreqa5vWSfxkkYbevg8Q4yYlIWb+YoF8+KnBtjKRaosPXkpXrKz29E8sTeJdqbfk62zjYduMxFJcThwS5Or0y33Lz2iTTm+R+wTP9dT6vHkm8WxPohS3K7w6Z3VeNg6H6axuiS5P0txy+o8e6iq4hEq+TrC9TdpoveUrFi3vdZs4jrZ+UidAtyWNcz5Jj8l/oH4eSVnkBW45V9SBj6l9jsjYs6nM4ffHulCz4C+9DeH7gNEyaCpoqKQp5eqeb+5pdK41eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2DLE6Cnsx5z79dGawBkubdaa3Jy4zD3rO4QZr2V79CI=;
 b=R8n8RHAaLgKb5wegzvd1Y96vEb9LqQtqOVxMHY9P8cBd75K++cokskewmCZGXFQBX5zoIcxLH4xC6E9iJnDSfAw6jklQ0Pd7gzA4Jbe7uGfTWTBqSzu4WEP8z3/5m65+tldSiAtNwx/uzr7WlI6FlgcmlPnQSgPjgAXPX0rOhDP8xtgmheL9i8FBUCZNMVfLRqdevSZsBclhNh93B/BLM6fXhmLXWYpvdX3FvBc3PqQ1K67zeKOCrt6o+aRoCK4CwoQa1gIXLYg4f2HKqlQ3ItN8S1DuPIvsIZjXxA0xWxJPcCL0TVMlzZUwJ8iHRCwTQN6BneP5z3bv7wgxCQ4aNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH0PR11MB5332.namprd11.prod.outlook.com (2603:10b6:610:bf::17)
 by LV2PR11MB9540.namprd11.prod.outlook.com (2603:10b6:408:378::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.15; Sun, 19 Jul
 2026 12:40:57 +0000
Received: from CH0PR11MB5332.namprd11.prod.outlook.com
 ([fe80::8f86:8d08:45bf:ec13]) by CH0PR11MB5332.namprd11.prod.outlook.com
 ([fe80::8f86:8d08:45bf:ec13%6]) with mapi id 15.21.0223.015; Sun, 19 Jul 2026
 12:40:57 +0000
Message-ID: <91ea5c5c-5476-4420-b852-45c6677d6134@windriver.com>
Date: Sun, 19 Jul 2026 20:40:49 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: erspan: set lltx to avoid sch_direct_xmit
 deadlock
To: idosch@nvidia.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, dsahern@kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, horms@kernel.org, yun.zhou@windriver.com
References: <20260713151435.1815104-1-yun.zhou@windriver.com>
Content-Language: en-US
From: "Zhou, Yun" <yun.zhou@windriver.com>
In-Reply-To: <20260713151435.1815104-1-yun.zhou@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP301CA0089.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::11) To CH0PR11MB5332.namprd11.prod.outlook.com
 (2603:10b6:610:bf::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB5332:EE_|LV2PR11MB9540:EE_
X-MS-Office365-Filtering-Correlation-Id: a6fef447-d0eb-49f0-fac9-08dee592fae2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|3023799007|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Lh9Y/5WSpsri59tVuMB+UZMruzomxcXHxh4q9N6jvCm5T4/pIJOCTIFQpHYXfgoowI2bAbWf/ZYmksR7rdzi9wCHJ8m5eH6MBZLJHLf7+ZDjE+mGwLuELr/ZfCNm+l+sX2TY0dQEo3G39cYgEZFsGKmTpLvJGunTjFvP64JWSi8K1V3uYDAfSJDuMQYFFwM/qPVTVI97L4P7B33O/hZjZ1hkZEuyMwpT19+E9Sp5GZbk1vg2KIn2UWbFLqspgDNmfcKP3Whzibs8y+hzaQnWe3loLRviNPjPW9HTj81mm0b052PnFBMXoGN9r9W/iAB5U4bJtKqJ4FsYBdzliO1xyMjpXg8ZBU3SihvFlDPV+2p3y9A5F1OXzUqQCqGanlLkE9Xc1ws9oiM1HmEnRgXK+dXLl4lsr/2MQRUODJ2df3VBM7N+U2mxditnVGNA3JzPl3q6KHblF0xJ61pRCikInNztbrf/pTUAEpFtykVlbfme0q8s8eP2ODoc04mDryUHek4uTcefS62R6S4VPGPOhHgAEgjp1G2pCKep1EOV825PVEWtSTsiyszIbAtBHIX3sDzuqe+E5a58WmXbI12YImV5U90adTpniK+fX+B61QGOkH8i+3g3mlGiews+e2+a
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5332.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(3023799007)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VXZRNXlUYWlVRlFqaTJYdGtUMGRDYXFDVVBlU0RWVTVZNGNWZEJGU3RhT3Fk?=
 =?utf-8?B?ZUhwVGRGME9KUDdtTFNKSlpjZGJ1aGxWNStLQmhRZGJObHFSWWt6bEFHak9m?=
 =?utf-8?B?UFNZU05Rb3JvM0ttUGVlL1BYMTI3MGUrejBGM1pFUXh2U0l3aFJ2UWZUVzdX?=
 =?utf-8?B?eVl3UGNlU0E0TjlsUnV5RFlzdDYyeGdxb3gvRlZ4K3Y5cWE0Q2I2S0pwT3V3?=
 =?utf-8?B?SW85ajV0dXhaV25rYVY2dWk0enFKOWdhay9icEp2RUZ0MmI4NjRoemc4REVM?=
 =?utf-8?B?RG9jNWJsQ0o0UitncVRHVkxpYWttTzMzMGtzeGl6YWUxZ1BOWUVmWDZyMzV0?=
 =?utf-8?B?R0FleUUzZUJQWWVMTGs4YlZIdnI2OGVPZ0RldTdVclYwM0R4T0lyVzhUWTZD?=
 =?utf-8?B?Q0xScjNBd3BoVkVHV1JnSU9KRlpEVHMycTJ3NHVES3pzMVR2WTdiUU41Y1Rz?=
 =?utf-8?B?Ly8xWnB0alU0MGF6a1dyQXRrYjNFRnE3NkwybGdVeG1XdElLQUpreFNCcXJ4?=
 =?utf-8?B?R1lzMUNYRFBWT3UxVnBlQ0VHaE5DZXgyd3dkWmpvVTFVRlZVV25pYS96Wmh6?=
 =?utf-8?B?YkRGUkNkQk1uVEJoWW9SV3htL2RRbjUySk4wTkVaV29ON3VNTEdDeEZMa2Zv?=
 =?utf-8?B?ZEYwWHBvUlR6R2xibmRUM2lZMWRjTm0rUkVqbGlBUlRMaWZlTUgyM29Paks5?=
 =?utf-8?B?U28zR0dDNk9iSnQxZXFqTndSbS9yYml0QWovNWRKWWtWTzFFTnhTdk9qK2FJ?=
 =?utf-8?B?V3BQazRVeVhacjhwSy9UbHBLT0NzWVJMVmx4VXR5UDJ6U1VaRGNBY3RDMEVB?=
 =?utf-8?B?OFpCVnQ1amp6aDFWOC9tYjdNcHJVTFJpY2JBWHdTZ0phTnJBdGE2YzFwV0N0?=
 =?utf-8?B?VTdsY3FxM2x0dzJWTm5XMm1wcHpmNW8vUURGVzdiNmpqRFZjYlpFeWtFSGY4?=
 =?utf-8?B?MnE3SUl0cU9Xa2g1TE1zbXdGdmRqbWhhcXJZS0grUzhmMyt2R3R6cWVvdFZY?=
 =?utf-8?B?MTU2VzhSVXlOeGZWWDREWmh4V090cWpMU3ZTT3RPYWRtcDRocm1UWFRKMk1G?=
 =?utf-8?B?V1krM0VYd0NDOTlHblREdVJQSlk1KzJPMWFNc1NCTnpaRkU3VnBwcjFycEdj?=
 =?utf-8?B?Um9lTmhSb0FRcmNjN29rbVJqdklHQXRsTmZiZlg3bmdQWFNzbFpqMFJjZkU3?=
 =?utf-8?B?akIxOW5hTWQzQmluaWx2RmRQT2RvN0tLODJIMFNxZlJsODBMa1IzVnVBS1dj?=
 =?utf-8?B?UTNGZEJPZVNGd25qOFoxaXVDTnU2YmpCMkc5VWZsQi9DZlVwYklwbEJlcExn?=
 =?utf-8?B?MWdtV0hxRUI3T2d2aXFXWmJBQWtpbCt0ajY1R3NoSmlGYzVHRGVwQmxYQ2Vk?=
 =?utf-8?B?NzVKOWw4d2dPdEFDZ0FwY3dnVUVpVFpNazBxUjE4Z3hxUGVpbDhWZU5DVEdS?=
 =?utf-8?B?QlZZNmY3SnVsenY3TkZoK243YzhLUFdJREtDYlVDZFVEUDFRZjNqZ1pUTFl1?=
 =?utf-8?B?SmN4eEE2RTV1UHYzcTdHRnJUOVpDejE0OVMrTzJTbmtSVXh0ZHpIY3dTZ1Ux?=
 =?utf-8?B?bGFVRm9JbVh6YU5zV1E0UUdIVG5MczNTMTZtK0h0ZEZpNWJrdllDVGxXRkhu?=
 =?utf-8?B?Y3hjQ1lzczVvYTNQcmtPM09zbHBXUjlpVFZCU2daM25mWGhZNDhFeGVjUzRo?=
 =?utf-8?B?dXg0NVluZGZ2eGt3b2EvWVp3REJVSU0vd1NFd3A0Z0pnVmdrL2l2OXlYT3Fp?=
 =?utf-8?B?OUdJZW5Tdm9MYkRGZktCUkEyc2FxTTE2bXBvbVMyUkZ3RVI0Z0NOSWdURzJ1?=
 =?utf-8?B?eG9pRnl1OFBFS2tLSFBCaWdkbVFObUViOCtTS0ZZWXhvSlJiZnAvQi9NSUd5?=
 =?utf-8?B?a0FvRDFON2FtdWZHRWFFb0daSXU1M2ZDdUZvMllnRXFBTG1mVlNqNm9ZRXd3?=
 =?utf-8?B?ZTBDcHB0VHExSFhsV2hRSlZHeWROUGo5MXc3UDJLTUZ2WDNQcEF0dGk3VFZD?=
 =?utf-8?B?WUYxRU5kTTMwM1R5WFk2SFdPOWQ1K1NTOHRFTHZ0aXN5Yis1cGw0dkowUjRv?=
 =?utf-8?B?S3FuSXdWcThqdndNLzB4Z3MybGhQVThMamt1cGo2T2NnUVJacVBZcGNVU0dU?=
 =?utf-8?B?T0dKd04xd0FvS2d6bzl6TEhoTXMyTncyVUMzNU9CSHBvZUtGcEVwZGYxM2VU?=
 =?utf-8?B?YmtlRmtzbVRSNlpSTnpLU0JtSlM1Q1ZhS1BYMU1JaGpYdkNkVEhaWm41UkV1?=
 =?utf-8?B?bDNKSjRSMndqL1hCYzVhZ1JCSzE3dXgzaGw1VGhYbTN0Z1B3WHp5UXFVaUlv?=
 =?utf-8?B?ZnJkb094TlJWc3F4SjBiSzJWNFZ4WkxyZ0szWDhPVHI5SFF3M3prZz09?=
X-Exchange-RoutingPolicyChecked:
	GZdFhmQRTu88hyJoe+z/bp2V8EEal8IV+wen4ZPgTnHOvxLqVwVd9pKEX/mbIdkOek+qSF0+EyI9L8ShKwCOBF0nf4cYty505kPyRmxrDfxT6jliA1rw8CpHkRedUJO98RrfQIP9ffAVJtgx1Zg/1NAYOFDOtOwVfAHIAc50DTFnWj30rh1FiB1sLHUXQZrUHtz0feX1J4D+055lrFkLhegPR45eHQcm1FGaYcEyXatMkEXR3+5UEUGFOGbrIsOXQiUOMm0yldVzs2EY7nCZpsF/M/otuZvD5IlH4nMiHVCmBtCCAp5NMUKfEtA2MrglWGhwV9sUmFrJyoKCRFMolA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6fef447-d0eb-49f0-fac9-08dee592fae2
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5332.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2026 12:40:57.5162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2CWTga+l+TLPL4/LZx9Na99sS2OEpNQRJgMdVJT0i5G3ucKU0elvhsVpvnxwGl98gOukUxtjMP5lNwxZUEXXSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB9540
X-Proofpoint-GUID: udJMayfRopIxL9u9vICUWK8-H2b0Fry-
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE5MDEzOCBTYWx0ZWRfXx1F+X7m2i+AS
 BbSHMPxF90eIHXJihUPeqC06DTLFz9MC7EmVrldOCgjyDtwVjkJqU47kN0y1Hd4DQqotETM+fks
 AhEGpwvukQ9aBk+pNNpSMRsAB7gn43aLUB95WA+eq4DqsCitmULv
X-Proofpoint-ORIG-GUID: udJMayfRopIxL9u9vICUWK8-H2b0Fry-
X-Authority-Analysis: v=2.4 cv=CfQ4Irrl c=1 sm=1 tr=0 ts=6a5cc5dd cx=c_pps
 a=55pr0gqEmxT9FJl44qZDsQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22
 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=t7CeM3EgAAAA:8 a=OxmsxxJHNjWuO1D9JxYA:9
 a=QEXdDO2ut3YA:10 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE5MDEzOCBTYWx0ZWRfX1LzRRWMzhDpZ
 iJcSmEGaPMpvaqy9HwkgWG6rnc4DpYsF24twNOzxIuk+HOCcb5GqZq3fz174ex/iFXOjRSCO3Sp
 3/b90+Onq6uD5zOw1YQHbMoJJc3YDk2OBpvbQL5pJYc2wPTtLDBZUeeALkyF3UzXN67CQdwT8jC
 rF4UeQRUuo7majG32cEdzJ9x4MRGnksA4lHf4rc5SfdkuKV9Ee7cmYEBX9eSAmseBi1gM3fBeO3
 zJOw4/9j2C+lvD9wlif7a5rpBEI+0uyLpMjxrGUKUyrK8W5NdiPVLfUS/CzEYb8i/xtcqdb20eb
 9np6Gc8VlVBrxSRGUtQAnDWddtjS33AT2Ndu78rJ2c4Wz6WKJG6NHPaz6ZUxo8xL9tkY/pTySfQ
 n83QAenuD6+xjnAWw9H8cQWVxYW4Qotsj6N3N/hZPsNsZOxj6e9K+fS4O0G0UGCb3GTQZviJu9g
 bW2v0T5o0n6dz6tW/uw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_04,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 phishscore=0 clxscore=1015 malwarescore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607190138

Hi Ido,

Could you please help review this patch when you have a moment?

Thanks,
Yun

On 7/13/2026 11:14 PM, Yun Zhou wrote:
> erspan_xmit() re-enters the network stack via ip_tunnel_xmit(), causing
> nested acquisition of _xmit_lock on the underlay device while already
> holding the ERSPAN device's _xmit_lock. Both are ARPHRD_ETHER and share
> the same lockdep class, creating an ABBA deadlock:
> 
>    sch_direct_xmit [lock erspan] -> erspan_xmit -> ip_tunnel_xmit ->
>    ip_output -> __dev_queue_xmit -> sch_direct_xmit [lock underlay]
> 
> Set dev->lltx = true so HARD_TX_LOCK() skips the spinlock for ERSPAN.
> This is safe as erspan_xmit() has no shared mutable state: o_seqno is
> atomic, stats use atomic_long_inc, and dst_cache is per-CPU. GRETAP,
> the sibling device with identical xmit structure, already sets lltx.
> 
> Closes: https://syzkaller.appspot.com/bug?extid=9bda1b9fbb7fbdf9b62b
> Reported-by: syzbot+9bda1b9fbb7fbdf9b62b@syzkaller.appspotmail.com
> Fixes: 84e54fe0a5ea ("gre: introduce native tunnel support for ERSPAN")
> Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
> ---
> v2:
>    - change subject prefix to [PATCH net]
> 
>   net/ipv4/ip_gre.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
> index 3efdfb4ffa21..9fbff16cda1d 100644
> --- a/net/ipv4/ip_gre.c
> +++ b/net/ipv4/ip_gre.c
> @@ -1363,6 +1363,8 @@ static int erspan_tunnel_init(struct net_device *dev)
>   	dev->features		|= GRE_FEATURES;
>   	dev->hw_features	|= GRE_FEATURES;
>   	dev->priv_flags		|= IFF_LIVE_ADDR_CHANGE;
> +	/* Skip TX lock: xmit re-enters stack, risking ABBA with underlay */
> +	dev->lltx = true;
>   	netif_keep_dst(dev);
>   
>   	return ip_tunnel_init(dev);

