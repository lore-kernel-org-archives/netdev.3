Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020108.outbound.protection.outlook.com [52.101.69.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD103E40E6;
	Sun, 18 Oct 2026 16:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792342483; cv=fail; b=MI9Svh7llyCmpcmZauf4oNT0pCsBt1HevFccqZ1ipSpedLf2ki33fUCfIljIRcSWCVY1vUkXtDe78UJ74lgtz7WcOus+Wb2xd4j5UtcLbalzNpnAe26NE/voCRC2tnpCh/musz2kJLUH1EmmaWuHJUpOddn8ddqMtEKaFrjRh6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792342483; c=relaxed/simple;
	bh=KhFvBjGpI+0I0fKUmwGtaSXVn6Qb0dXe/0eFkhWsLX0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=O3P+zq+9jFrzbD7499KzmdfpekOzKq03SHLWriqfk8HFycfc0fgc6WwN95B3VTPReariXBsKL+oenbmwKsgrkTMhht3KhGT6kjnQvaQfeIm7TpJnN5fcvc/ZfN3V807jiWQ18B87BtJgwwibW+anQTcHw/UvTH7NKona7gIeGtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=duqapKmJ; arc=fail smtp.client-ip=52.101.69.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="duqapKmJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q9Yj6pXOjys8SmiFEAcqvGf0m0UpvpqYPhp0UCuSX0jIW4H+Ocom3yH9Jkz/zsW2xUSKLOdswimZomSEOJxEpFeBTQJq4vwmhyahruZuKxa21YdY1kd68Fj8mE5QzctWWQrLl7PtfaKug4xNbm4eNoKmZfO2pCgppMUoae6l69QiJwj40HZGuo4LP3ns83JLF3WHy21xqaB/vIcUCmDEkNDXG+vYoNwhJgsVI+fRYc0eTtQs1SoWIZmuYQGq+L95Em6CJEaW10XR7lzOWor2PEmwC3ioZAxnSHRUxsc+kDor7UeAONqBz+9JDHll4Mv2rxZk6MSyXJBrKIz5DVWCTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KhFvBjGpI+0I0fKUmwGtaSXVn6Qb0dXe/0eFkhWsLX0=;
 b=jK+q8XKy/whajCLOKMk2fJnSSgEasMtqlpwYReHHFvK8now90RSMpMh+wf9iaiUWILN6CGFqDbddj9pOoExyzAme5g207G93n/aeL7gEgoNjjJFAwAx8rQ2cnlTtoATt7gZYB5DVGVtu5pykGB0/7SIdN4CHf2NFpxMow3XNqqlqiyg445hoHEPwoVHnQjFYfGUmgohWIUZOrzdTRL7Xvarel5w8ehP3a0wJF5myUq9CUHaP6JWZdMXhcacCy/a4BL2ARlRE6VspEJalLKJQkm2i6yLperYjRwXqHnqnOdATsf2y9MflM8owxOxSViPpv/JorRm71UWVfcarwgiAfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KhFvBjGpI+0I0fKUmwGtaSXVn6Qb0dXe/0eFkhWsLX0=;
 b=duqapKmJZKKwgIl+vS35PY+76PbyN1F+NZZ6b+b5htFeJ0leXKhYJXvAo7/H2nw3KSAOQyT3fx4lyF3UQO6u+VhpM5gwX9FHuTxHNHG1B1HkwJ5Zb2+q3Hh0Vd3Q2keINQRPZeKYsfr6SmoULn/V2HbEiIxgCOUqOuefMh9hdbHgPrGrZNlZ5ePY4rl5Ry6b4zhORkz4aR+uKA/F8IOKxeGzV65XTmGmihdGNz2vTbotS8uW776NSecEcNEQVtrL7uayifDUKOhwqZCkw++axjiqOSprqjz3yD363yQFfjMaTplKw89FzsTx/+NRuH3d67HNV6cMn43tpqUXgkJc0Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DBBPR08MB5929.eurprd08.prod.outlook.com (2603:10a6:10:208::8)
 by GVXPR08MB10810.eurprd08.prod.outlook.com (2603:10a6:150:150::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Sun, 18 Oct
 2026 16:54:36 +0000
Received: from DBBPR08MB5929.eurprd08.prod.outlook.com
 ([fe80::8c14:5279:76ab:8d35]) by DBBPR08MB5929.eurprd08.prod.outlook.com
 ([fe80::8c14:5279:76ab:8d35%3]) with mapi id 15.21.0546.012; Sun, 18 Oct 2026
 16:54:35 +0000
Message-ID: <dc9eda55-2688-40f7-9b0a-7dfa0e5cbf3d@virtuozzo.com>
Date: Sun, 18 Oct 2026 19:54:30 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] udp: let rx-udp-gro-forwarding aggregate under
 encapsulation
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>,
 Alexander Lobakin <alobakin@pm.me>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20261008163817.2983484-1-eva.kurchatova@virtuozzo.com>
 <willemdebruijn.kernel.2f0d78527930f@gmail.com>
Content-Language: en-US
From: "Eva Kurchatova (Virtuozzo)" <eva.kurchatova@virtuozzo.com>
In-Reply-To: <willemdebruijn.kernel.2f0d78527930f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0037.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::17) To DBBPR08MB5929.eurprd08.prod.outlook.com
 (2603:10a6:10:208::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR08MB5929:EE_|GVXPR08MB10810:EE_
X-MS-Office365-Filtering-Correlation-Id: 3be10899-a718-418f-88f3-08df2d387d59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|18002099003|22082099003|10067099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	HMRlpAdwC8kcYS/t3K8Vv1KuwYjGGOj7dV37Rbj6QdMegTSyHMsqcIxclA1ZoRJK7o3uAm2inG74MdYm6DwkbFFiaeVbeK/lAzNqgbbXcNe69iGMs8rnz8GwHa13u87xndahwbQoT6FKM87z5Exu2UJyNg21qCqkd/H4rT0ljihEt7X/h25CFYWjoAesY9BHpjeYGhEnN7TxsSVC1xWKB+JUzMo8wRvHmLO6+jNO8JgR+mW1RRjbw+h2Tghe26es/yvAwY2cHU35dSQyFmNkHZhU/iDUbYzrgUmhwGbLBplbFygSOTU3u8srefpgjI8p2rMQkN2FFUAsSd/n9+w981U3Ca6qSjjf+KfirM+wie/XkWdWp/97wnZeXnzit1ZdLJUlDcApBDKuBfwt7VQLkaSJ568O8X74nKPqt1K55NIRR7BFH9o8KEc9R5xdZDYUBqW5Io2p1ODUNMxfYcAr47OCcuaszC5U1a31W0t91I9BLiYdlf6b1vH6DsEpQ/SXZRvnUjLQBvhUlbhixsb6qGRBx9BL7rFvZ7YXaq6tpOLNJmJQny2trJ5fRIMgZ8cRzUR8xnVAPla7Kx4hIeckz8h4hGRWSi65mhKiI13KZn8aRMBXmlLJaJwOFMJTEJA5KhGy8p3adK9qBjDkRw5ubPbEGK1a2F9dlPPOTvW4UiQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB5929.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(18002099003)(22082099003)(10067099003)(4143699003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2dHNU5FT2Vva0Iyd0w2S0QzN1VLeGJSMjh6SlpoOC9GNWwrbmQya2FIaVlM?=
 =?utf-8?B?ZGpXQUVBa3hXM0VuS3JsbkVxYnJzTE1acFZpNi9jRndzVUZsMFhWbXhNR3la?=
 =?utf-8?B?TjJoaUI1bW5xR3g2c3BvKzVMWkMvWUg0dmlmZVQ4SGV0b2pZMHUzOXdNcTBs?=
 =?utf-8?B?RnQwdlZnL2FIdXowTXBtWTFJS0NkRUl0UFhxcDFwSEJJYy82eS9zQXUyYkFl?=
 =?utf-8?B?bVMzckxVWmFFSTNZTjBybnhNUDF5d3VGMzV4dE1RZ2JzaUgrNmo2SVZnYXgw?=
 =?utf-8?B?US9PVnM2SnVQdlVFMmNWTklJVEprQUQvMjhNUWZJVWRuTjNqeWU3cEd4czJv?=
 =?utf-8?B?ZnBUNU9YRnF0YkJod09RQnBmdHpCZkV0ZzJ6Q243TGFCV3lJRFJTLzFuTnJH?=
 =?utf-8?B?T1JHdUdMcisxdWYvYTRVQ2czdDVvRlBHalpBc2hDRUFXQUVXOE1jVnJiVXV3?=
 =?utf-8?B?akswdjU0N1JWT1JjSjlZVGtUUDM4VkROYkxHYS9HM1Npa2IxTlIzV1BLc0da?=
 =?utf-8?B?L3FyMjgzVWQ2RnRNRktJYnBSaGd1R3dLOFdtMktiNEY2YklNT1BqenRUMHNj?=
 =?utf-8?B?UWRxTFNIbzFMUkFldVV3TUpsQmdGWUVmMmVoOXRBYlJLQ3pqNEVKMnY0ckpw?=
 =?utf-8?B?Q0Zia0hCeGNsYzlqYUs2d0FkL3cyYzdYcFlFbjBPVDk5T1RXdHRHanRIckRN?=
 =?utf-8?B?dCtwYk93K3ZRR2k3TTVNeTJsRjFhUU1jbFViRHhxRjBZcFJoeWdUSUFHZEo5?=
 =?utf-8?B?eU4xcW9JdWsweHNJbVlVVmhqeXVNTnByUjIzQVFlSnJ0MU9BYVBWdnRPNk5D?=
 =?utf-8?B?bm5aYWZwNStUZWJ3VjJPT25neUp1NXRXWFMvcVZvY0ZMcGNKQzVjazFiTlBN?=
 =?utf-8?B?T1cxNEh5d2VoME5nMUVmWU9kb2F3UHBGZitNblNHdlloUHIxR2Fuei9JK2ls?=
 =?utf-8?B?eVZPQ1dqcTVDMStYOTAyWC82NXJQZ2xxRVo5MVBQcktFaXNjRS9QZ0pSUk84?=
 =?utf-8?B?dW9tV2M0dUliVjQzSHpDc3lhdEZzcEk5a1ZYcTdsbE9RVkhDMU1TcmhxTDFO?=
 =?utf-8?B?a0MyRmJoa2FkVVNQcGpjY0FNOUgrQkFjaFMyMU9RQTZzSkw3Q1RpeHAveGpJ?=
 =?utf-8?B?a09LRXB4UjNRU3lNeU5LazZGUnBHQWFzdEhpZFl2RlZhYnFlQThCLzlWQ296?=
 =?utf-8?B?Nmg4cndKRHhjZUdKZVpncSt6UzI5b1Y3YlRzdHJNbEZwa0dENS8raUZaWXlh?=
 =?utf-8?B?dHZseXZ3TlhLd2ladkNqVUtOemhNWnF6OVpQaVRYVTlyQVRRTXNCazVYZXhE?=
 =?utf-8?B?VGFvQndldll2VjFwQUdUQ3hzMHlSdnRwOGptb1JGUWtSWlJ5VG5GMU5hSWJ1?=
 =?utf-8?B?ZzNzN25Ic3JpTjF1bXlIbnJ5dnRpaDVOUVI3R0ZmQWVxSkFtVk1NbjJsTkx5?=
 =?utf-8?B?bjFVUmdWeGxmL0FlLzhQa1FPVHRVMTl5ZTZISHp0dy9PaHRDWENUc3l0QUFU?=
 =?utf-8?B?Vi9rQlh3cHp4M3BIZmV5bFlOdG1LRk42ZzI2eTc5OFN1ci9EN2RIMHYzNS9l?=
 =?utf-8?B?bDIybTJOamNOK2E3Y1J3TzhpaHVjcnpYMTJiWlN6UEJKTGNuMFY2Y284Slc4?=
 =?utf-8?B?aE9LbXlYNGFNcTF5TTRxM25XSVBlZUZEUG9iZzVzcy94RkswaTFOZVh6R09K?=
 =?utf-8?B?WXhZTGRjdXdiWklibFAwVHd5Wk5Ub2xGMnRMLy9ObGxKejk0Tkk4UklldW4y?=
 =?utf-8?B?STlIa2oyTjVzR3VabVBaWXV1ZXI2djhiMnNSSkpjYk95ZjkvWHlaWXFDSERi?=
 =?utf-8?B?NHFwK0FoSnVUTXp3TDFhR28xSWVlV0hCeC9rZG5pdE5YbG1qYVVyaW55OU5P?=
 =?utf-8?B?VzlCUG9jenVMby83UzJldW45YTVMckR3NUkzcVBKbzBnTlhMM2l6TW8xd3g5?=
 =?utf-8?B?bHV3S015ZXF0MUtzcVFaZ0FsRS90UEk0djhNZGF6cEpGOUc1NG1SdFc1cU1m?=
 =?utf-8?B?aDd1WmxteEJLNjNrYTRyaXpqdWtQdVlJdE9qM09KU3hISnExMXpLT1F0Vkps?=
 =?utf-8?B?L2oxOFlHMXJyYWhreXI0T0JOQk41b3dUZ2ZiVGRLV3JFYXUzN2RTK2dwZ0w5?=
 =?utf-8?B?TkpVYnlNekhUNzBwUExPSUs0YytyZVhCM2xTNXlBSG9sK01kU3A2Q09RRUcx?=
 =?utf-8?B?dU9SQTYzTlU1Y1diaEpkLzdoZDYxUGZNa1Q2M1MxaTN0TVZCVy9OSHlhaDR1?=
 =?utf-8?B?SVhaVml4ZlRvcXF1clJlODhmRzRxWmpDcXBRakZSazRCWkFwRldDRXdXeHJy?=
 =?utf-8?B?MEh4RzEvemhMVEdNYlROR202ejJXTzl1cGVOUUpxQ09ZUnRPYmhENEY1YmRQ?=
 =?utf-8?Q?bCVzR0rJH6y26+9g=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3be10899-a718-418f-88f3-08df2d387d59
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB5929.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2026 16:54:35.6057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tx3hYxQg7L3EeWfqf9PamALFTnjBcuKRJrIX0rXQjHbN1QNFb9NYS+az4UufichktexMf9Lyvism+FHJbB3quXLOO0v1Xguc/5mE1AJAH1E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10810


On Wed, 15 Oct 2026 02:56, Willem de Bruijn wrote:
 > Uses encapsulation in the same network namespace as where the test
 > runs? If different namespaces, the socket lookup should fail and
 > thus the behavior be the same as on a host without a tunnel.

Different one: the vxlan sat in the init namespace, the test in the
ns it creates. The static key is global, though, so the tunnel turns
the lookup on everywhere, and the lookup then runs in the test's
receiving namespace, where it finds the test's own receiver: a plain
socket bound to any address, without UDP_GRO. That is why the check
goes from 1 to 10 the moment a tunnel exists anywhere on the host.

