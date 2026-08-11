Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012054.outbound.protection.outlook.com [40.93.195.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DDC37BE81;
	Tue, 11 Aug 2026 07:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786433103; cv=fail; b=n7DDEjRVM90aD3VK0mxKCy2ljt6yKmtHFWtmkMC7r91LgqcHaWL/ijuxKphUne6Pl7rz52VxvX5GgH0UY/4A3OQu7t18Y6Ogh6htoCBKWTJfHJ4e6yA7bmbZouV/GmkdrjM8yKf+eS4qRgKHNZssr0FntsqeUpT1ljf0XzNy1Oc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786433103; c=relaxed/simple;
	bh=n+a3URPvu00iONLgqKocEiaRkpGCH3f51VG2u0Nf7tk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N3Z9DpxONFbnYhaBbJF4/+oOUFCpLGAvova/90TZLsvKP2nLP1kBuWzoSi6IXpUQ9mN34nrotd+NyDaFUkr5hJG1qRVSjdYUBk/5w78Sp8ZW3X2xRPCVvC+szmU8RMz7wQpggxguxWriyCOFuz2lFtkwMbcL7/pupMcEgoHZmng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=upqwcqXE; arc=fail smtp.client-ip=40.93.195.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="upqwcqXE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uh63Y1KVEw6oVvK5ZboqTYG7wGdetDkffmeJPNNWTWctohKR5+92BWgn8n2dsL0fR6zyRzmrWQrx+Zy50xnkAwR8w+SeLwc9HGR+CkdV5tiiMWK9iMp5RNShd8Ncfl+QLZUE9bABI2hmcyqkI9OdN3dvhdKmNVZLRL2Le7pX3mnVLnzbCANcwrpEHLP/rijh5TQH65JGpHkwn0g94iNWavZv+P3ymonBgKiLW2lvo9692IxZHYPsceOPKXozfI+Ql3nJ2P/9RI63mJXQXpCiuUpp7whzR+fhslOrnnOZX0o6iwxFnZPAAKWlEXX7ABGYmFEeTYVKN3W+mfPY43+Y6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rwbAC4CF7ZobBtusS1oGfvZOcg/RBE2ZgtF0+HaSPHg=;
 b=F3ewZU3XqFxWK0ERKBSEfbysUCH2h3Y2BepB3Tls2PD1bx+yppgVexmJ20x+PaxmUEW5ZpKp30T9ZQJaI9hWJ5m2PAD/mNqAlvfRTIu+bykuCUFtLWPw428Mud57YesXwgaEYZKPGvLDoTpiMCSAGzjSTlXGVvfpzAQUdVL5IYyOaFwo1WM8sj8qpzZhmMpRcrePAUe3RPDIqACVe6hvL3sbTXbiaIb5SWkQdL/vrgnNzn/rZQIFW4oTBXZTXK9vsSqutF70rvSiTdzZuJb7glQOkfWbI30DltD02FU3AIdboAj4sj/6pH80iS0bFWRK3p8MfB35QAbt/1KpyVTqhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rwbAC4CF7ZobBtusS1oGfvZOcg/RBE2ZgtF0+HaSPHg=;
 b=upqwcqXEWvr0gLNsvMTExaPR/F2Pnx7kT5Q0Ri0ihSsaK00Wmjn5VnJXn8ZwRxnMhXRRj0upyP17FV1tqa/lS8+5dN7JjXVRST7OPrZLHNdaXj+MOSUBW1UAjJzVIt+5w34/LWfC0GpMygCpL1rrdI80T/0C3aSuCVAw0t4M3P18WRFLpmYUCfEUUHkbCPzagN9J75r8oCuFc+b367LlBMP70Z7PU0GpZNgr7fjkvEDxzh3KCXKKxVZKUn/onPdLP2c4HFIAtgbcTsU69XQ3YfYmSGD/vzgYR3DL+0oG2jyh9Lrz+EwEF+iI6K0uRMw3ok4rHDO99Wl0wYvh0ytLpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 by MN0PR12MB6080.namprd12.prod.outlook.com (2603:10b6:208:3c8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 07:24:59 +0000
Received: from CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7]) by CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7%6]) with mapi id 15.21.0315.008; Tue, 11 Aug 2026
 07:24:58 +0000
Message-ID: <dab8a7cc-f202-4975-93a7-7e80a386e214@nvidia.com>
Date: Tue, 11 Aug 2026 09:24:53 +0200
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next] net: devmem: add netdev_has_dmabuf_binding()
 helper
To: bobbyeshleman <bobbyeshleman@devvm29614.prn0.facebook.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 tariqt@nvidia.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260810175446.3945358-2-dtatulea@nvidia.com>
 <anpN3vJUig93aSB8@devvm29614.prn0.facebook.com>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <anpN3vJUig93aSB8@devvm29614.prn0.facebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0139.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::19) To CH3PR12MB8728.namprd12.prod.outlook.com
 (2603:10b6:610:171::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8728:EE_|MN0PR12MB6080:EE_
X-MS-Office365-Filtering-Correlation-Id: be352d26-2706-45f3-9abc-08def779a649
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|18002099003|22082099003|11063799006|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	QF35+SRMuUe7fpInUh4YhcFwsGQsA3moEUg23ky++alKrYiC07Sr0kKN5WhVBjGQsMO3N7Y6xVY2GwkEjT7YFh1QG65cTx5J/V+lXOtieG6vTz9mgD8RKp9QLB4tdvBs03lWY23kXdSERF96LEGiaoPqFTXI6nxePEQQPUMqHXZJ69SH6AGDbiJ99cLuUoS99CuPL2bVcgFxoxNGUQWV6lApJiMHEOyPvk5PFOBRjgmA1IleZCO5yKNJOmJd+SFWNserwpIXrDDu3A5BU5YFNtPQsgqWZmdirxDrbV1/qhEzR+RBpdzbC6/Giamdu9UbVn+r2TadDBHbdGsoE3pLoBeZ7Bl8XPqJalaWaqr9lWPI/7ivwHPRhcB9UY70jF1Oo+WM+hhG9EoCBIcDctl8yq3Lfg+AATmWgUw85zvePNCybrDnLm8rBDfx9Wkq8PVSoqt06ulcFBl49WYd50iTfBN6ED92OL9fWIZq3ZnQNWE9mYwICsI3TrIim1UiKh0akwC/RlyHbPFpxQSEGSNwjFAHvk1OMc4oQJd0cUGIcsg+Wyj0oJmcuumQ7Ojow3k++ExzDYIJE5WbCaRoHMmJgUx8GKhZpSLxjbTYRG7KEqjuE8wVt0wkpFEjJhXRvWkOjGYQi12u6dm5AdiCK5P0/fvZpniobjQOLAzFycae4KY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8728.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M3RKMzNzdEN5dVJ4N1V6SjZTa3dzQjVVSFpvVTlwc2lxNWovZlpWWmNTWXV3?=
 =?utf-8?B?N3MwVHppSXZtb1I0Zm1tL1FnL1lTclNndWRDZ3U3TlFzYm1UOTlkanExTUJX?=
 =?utf-8?B?ckJITmpWa0Z2OGpuOWJDZWszQXVqZ3FVNm9FbkZHOHVCWXo1Ylp4SW9TVURH?=
 =?utf-8?B?RWlSWHZlMTZRc1FNNE9NQkxFQXVXdDdwRWpSVDBKOXlITmZpZVFLMWRteDR3?=
 =?utf-8?B?QjVUTW5NNWFkRlA1dGNUT05CWFU0bnY1a01CbGREY2VmbDFIbm5meGd6MElj?=
 =?utf-8?B?bWNDZUF5bGJSM05JaS9kd0xBMXhjRkVuaitCK25rVnpyeFZrbzBwNHVHWmRu?=
 =?utf-8?B?UWlyRW90WjhuS0c1TlBOd05aMjZrbnFpS3k5NEdnd1VoL2kzdEJ6TUJCNDgw?=
 =?utf-8?B?VGc5b2ZDMGpnRWZIKzAwLzArZGh1bldZYnVHL2NWbGZFZm5NQWNBQWh5SldM?=
 =?utf-8?B?M1RpcGNpWVhUWjNEL0xZbjhHMS9EcmZzbmJCMlhlSVJjOGxsdjBYd05lb2xx?=
 =?utf-8?B?ZS9Pa0VTS21pbEViZHAycEpKMER4K1lNN3Vzb2l0MGw2dnNMK1ZkbWxZYVVL?=
 =?utf-8?B?MHRoZTNKemJ0VnlyUXlKbVJ5cUFscTlUNzhsQnVhQzBnbzRJR054UzhTVDR4?=
 =?utf-8?B?YUJrbFAvVUpLTS9QdERxZ3RHNmlzZEc2ZkNVS2FnWTN5d1JyQmR0bU81YUds?=
 =?utf-8?B?WFoxYjF5bnFBb1d6SHp5cDlDNWg4YnFpMitIQkxSTUsrYkt0dEphVWYybTZq?=
 =?utf-8?B?Ym1OQWFtbTlxai85M3o3TFF6aWprUDBSSHUvZDU0b2l5V2JMWHQwbTFsY2Rt?=
 =?utf-8?B?azJQZmFNZW5VWHFRbW9nZnRJcWU0a0RwOFkrcWprSk1uV0VBZ3NZSCtyM3J4?=
 =?utf-8?B?emRKczVnMTdIbjdmOFExZ0FMSCt1R3hPcTJWM1YxT3lKaEFpK0tMbFMyV1Ns?=
 =?utf-8?B?b2pzaDA0UkRZYnFXOFU1STJ0YjBIOXBMYW9Zb3U0dmNrNDZjOUwyRjJDOE1R?=
 =?utf-8?B?VDkyWG9RemV5bUdERDRLWUR0T05JQzlDanJPZGs1Umd4V3lvM3JtS0ZqUUxM?=
 =?utf-8?B?WWRJNkVNRFhLM2JIa3MwVnFHUkhNRlRzdHkwb25mVDVtNVNud0JJWkM4R1dL?=
 =?utf-8?B?VDA3aUNTWmZXdXo2KzU5Sko5ZmJLVit2WFhMdE05em50ZUUwZDRnVU90WEdw?=
 =?utf-8?B?UllTMUxyYjZXMjc2QzVTOUlKTEhmK3dMMlFOSFR6Q29ucFRHc3dSdHpBM2s1?=
 =?utf-8?B?c2ZacUg5THZYUGNSQmIvZElKM2k1UUp5bHpQamkyOVdLdFR5RVhiek1KZkov?=
 =?utf-8?B?V0dnTlE4QnZsM1JnaDUxR1VUR2MwU0I3WlVyZnpEbXgzdDI5QzdKbjJkajE3?=
 =?utf-8?B?QnVPYzA5Mm5lOVJOM3dUMkpmTW4ramNtdENreVpDNzlISEJobzlIZUE1Vm95?=
 =?utf-8?B?VXFFVitab0sycWlUaTRLbFpRVlRCUlNYVGFub3lBY3RrUnBoS3AzWmlYcWZG?=
 =?utf-8?B?MGpQQzJsK0pxSTNmRWxpYTJJTjJDWG5lQXRsR0NxL0prdUw3L0VYbzFDbFV6?=
 =?utf-8?B?dDVDclZraWtqd2JRK0QrMjh5TmdkQW9DdzRtaWFJdi9SUEdsRWgrR1JuN3ov?=
 =?utf-8?B?Uzk0UGFEZ3p1TS9vMGZvZzZXaUlxckxlWFhzNjhmN2xlNjZMZytwUzNNY2xG?=
 =?utf-8?B?cjEvWG5wK2tNUEhvMVkvcFFlT2NZdDdSeUdRZzNLaGtoV0pUSG8xSnY4RVBG?=
 =?utf-8?B?d2NQcVBwb0ZPcTlxSm44ZUZpQUNGMVNkcGh2TUhqQmFneEVzZ1VxOVdORUNw?=
 =?utf-8?B?YThFUC93aDVMek5hUzd1VXdLaHhncmN5TDdmeWxWTHBPbFRjb1BJTFc4T3RV?=
 =?utf-8?B?T3pBbzhUeHIya0NVQW83KzYwSzgxbE45cFBadm9JSXRyODMvTWxVa3cwR2dG?=
 =?utf-8?B?OVhucmREQTd5RTlqc0I4VEpJNityeGlKZEJoRWtMbUdLM1l3WVM3d3ZWWFhR?=
 =?utf-8?B?L3hJSDdiWFhHeFl5NU0xbmVHL05PMEhaNDZXd2VBMGE1blpaV2hzb1lnbGVB?=
 =?utf-8?B?YVRORUNmMThrZk00ZVRlc1BuQUtlNXA3Qm15Q24vZzNlOW8wbUd5Sk1TMGRC?=
 =?utf-8?B?R3ZPZDM1c0lDMm9IKys3d080OXRiVGw4VWlLaWhVb0VHSG5aMG44UU9NQlor?=
 =?utf-8?B?Vyt6ZFdRN2VWanhHOUN6Tzh1YjlSTFB3NDJyVjFRTkxUWkVBRmdkNUhJOEhl?=
 =?utf-8?B?M1RDV1NGa3pLejF2YkgzMGxOdGZDWTVuWnBGRFVNVEloVTlqY0JmTHd1TVo0?=
 =?utf-8?B?dWNlbXZiREhVREN2b2Y4bW9EY1h2NmNxajVRZ1FXYUFaa1czZDBRZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be352d26-2706-45f3-9abc-08def779a649
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8728.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 07:24:58.8595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qpu52W0N9lblpCKA7y1tdBUFZib+2C953R7USMJRdN44Tesa65gk6mGT4lj4kymPkSOahnsNVx+8n61gQBa/Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6080



On 11.08.26 00:17, bobbyeshleman wrote:
> On Mon, Aug 10, 2026 at 08:54:45PM +0300, Dragos Tatulea wrote:> [...]
>> +bool netdev_has_dmabuf_binding(struct net_device *dev, struct device *dma_dev)
>> +{
>> +	struct net_devmem_dmabuf_binding *binding;
>> +	unsigned long id;
>> +	bool found = false;
>> +
>> +	rcu_read_lock();
>> +	xa_for_each(&net_devmem_dmabuf_bindings, id, binding) {
>> +		if (READ_ONCE(binding->dev) == dev &&
>> +		    (!dma_dev || binding->attachment->dev == dma_dev)) {
>> +			found = true;
>> +			break;
>> +		}
>> +	}
>> +	rcu_read_unlock();
>> +
>> +	return found;
>> +}
>> +EXPORT_SYMBOL_GPL(netdev_has_dmabuf_binding);
>> +
>>  void net_devmem_get_net_iov(struct net_iov *niov)
>>  {
>>  	net_devmem_dmabuf_binding_get(net_devmem_iov_binding(niov));
>> -- 
>> 2.54.0
>>
> 
> I think netdev_has_dmabuf_binding() can return false even when there
> exists one or more in-flight skbs (e.g., in sk_write_queue) backed by
> the txq binding (won't technically be inactive until the final reference
> is dropped and the binding is freed)? If so, can this still detect when
> it is safe to swap the underlying dma dev?
> 
Oh, good point! I didn't realize that the binding is refcounted and can
outlive its xarray slot.

Thanks,
Dragos
