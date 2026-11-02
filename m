Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793590953;
	b=M1cvOxlrssamuPzs0K20jQCIhaPiWiCCftGDTZe5V6d4gzTKoLircS5mfdtGwtGlPDl6
	 BHha5Yxn0LppJqv2FmPD2dAjh8cJ0F2EXWqDrpm4Ti8+njAo/qqaAmUeA99PoPgxtW61j
	 XpIwpTcT0S+GleZViwt1fPFXPatfQjmUljYnBLq8tWJwyMe9/joc+C1k3CEcJwwhsRfm8
	 WelWSgAnsQzfPj+NR9+ezi2xXW1CCrKvKivJvh1H0muki/EVp1YIuk7P7uv35ZuEhF7fn
	 uCEVFOQE2lxqfmVQhJDOE9wh5v3kZeD3VACQmvPZFXoc4q4Vr2VtZ46cJGRZAelOUhg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793590953;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Type:Content-Transfer-Encoding:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=7i8b+2EQzkJH1ka9ciQTabx74kGJ1hFRehEwXOZkLFQ=;
	b=AAf85dq+EUhNGSy5tiiUAJutHiIkxWOKmliAmHkgOCPMej5AhDR8fOLMM2YahANj/Teg
	 zgdiaKGcOOeAxXSfAp2chQpT73snL4Wfv/OcPU/nVcPC+mE2pD8vsCvr7G3EhmSxvxHTJ
	 JtTACelJZptnYQx4Ox2Qis5PcC7sqc+S7mYapVg7ZB10nrY5D03obpKMEMFFR5FrxCUe7
	 f3ri0u911zbEpCj4R9dJCfcq8+qTEv8PVSyR6+ZNtqROu7TezCK/Jjx9r8A8VH7Baifu6
	 njoDCPOXqjTQnf7ShzmENITozGWYjNOTx3b4AVvJUE39JweVu+MuvqjUkKDnAZPZLiA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=est.tech;
	spf=pass smtp.mailfrom=est.tech;
	dkim=pass header.d=est.tech header.i=@est.tech header.a=rsa-sha256 header.s=selector1 header.b=Rt5URI1f;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.41
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013041.outbound.protection.outlook.com [40.107.162.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D29F606A324
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 03:42:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D29F606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=est.tech header.i=@est.tech header.a=rsa-sha256 header.s=selector1 header.b=Rt5URI1f
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hROS5lEP+5Uyk9a3Yemx1AyGhaNeb9XOzIBfBJjBFe9UmLtVUr7k3XGR8TARoKnRuvIZgoQrKi35vV7ebdZwVzPlm1pwlkD2ebTTDVLU4uVXfi3m8moboChDhF23Ag8BivmWlg9/04AjvOZBP5XR7c6Fvx8luE7hC9D/bTkXKO4IRgH2ifmh50+wtXN1ivQ4JzklvirkIK+HNE+Bw/yFyhh5qRIJ1EIgeZrMNHSuC/yjJPUKk8iffX11mCX96wKHCxUHquFCHE0IbX6WXLCsQLhCn5iuDwRbzdqMfRWJwLITZzQDD3NDF2vxkrn0iyk2yWlfytYCeoiXzDEw5+Gzyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7i8b+2EQzkJH1ka9ciQTabx74kGJ1hFRehEwXOZkLFQ=;
 b=oP4jKogflyAm/aLXOBVae5cFrWrNMp2BYqltQ+g/SpsVNyIRplWwnyhw8YXmTjAi6o4yXXW7byliRfknZ660qo4aStNqrp1BiEORzJqg6u1mEM+fDuhoKivk9MfgsR5lS5gaSqiMzstJrVMETs4c2XVWn9jO0Y/nhkSzeDbNMdsg5t1+92+xnTBPiwVRiaOFeM8fxd016K2MVaaM5aW8upBwlx4akoKpGvMhKO30Mduu2cDU1fCbQEB5qOsjlw1CgyxlrjjzRXeNk0J7CrCl2wr+oxNgqhIPj1qAySIcMWLYljpIiibOQgo+da9CsG3WXoOwhdNQHhzGQVKuRxjJGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7i8b+2EQzkJH1ka9ciQTabx74kGJ1hFRehEwXOZkLFQ=;
 b=Rt5URI1fEplf4m7aCXoG96hrSQ2SjNWu3xfZnaBZdP4YBwoBe81FxBoA00Xeg8oq0COKUczlUUOZF6Eq4B9h7A47PeNQqLrw1OUXDOnf9oxHwU6fyV+wvnlIiv5r46KbZkNz029zY+CHVHnSayFVXywA1byzL3FuGoKAcXhG3BVCG0elsmnb0VkTTlzNyFmyzP5Ss+LlDTJ8+wifeg5/Z5MWek0GvG0izLolTk69qDd6vLNnDKn/3k9xbKm/3oxvT4IJSoAMhjA3f2UQUK1rGQxOBpDPvC2pXkQjHUIQsXdBfR2i2jdSs4qCP6r/PPyFrjs8QVsaeOMVEQBrnXthVQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from AM7P189MB1137.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:17e::23)
 by AS2P189MB2399.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:579::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 03:42:28 +0000
Received: from AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
 ([fe80::86f0:8ce1:a437:b2d5]) by AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
 ([fe80::86f0:8ce1:a437:b2d5%3]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 03:42:28 +0000
From: Tung Nguyen <tung.quang.nguyen@est.tech>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@kernel.org,
	pabeni@redhat.com,
	jmaloy@redhat.com,
	horms@kernel.org,
	tipc-discussion@lists.sourceforge.net,
	Tung Nguyen <tung.quang.nguyen@est.tech>
Subject: [PATCH net v2 0/6] tipc: fix deadlock and NUll pointer dereference in tipc_named_node_up()
Date: Mon,  2 Nov 2026 10:40:26 +0700
Message-ID: <20261102034207.10639-1-tung.quang.nguyen@est.tech>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0213.apcprd04.prod.outlook.com
 (2603:1096:4:187::11) To AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:17e::23)
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
X-MS-TrafficTypeDiagnostic: AM7P189MB1137:EE_|AS2P189MB2399:EE_
X-MS-Office365-Filtering-Correlation-Id: 078f7bf9-91f0-476f-73ed-08df3893513b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|10070799003|11063799006|56012099006|261009223027099003|261028144727099003|261021121427099003|261021123027099003|261026121527099003|261026140227099003|261022075727099003|261022105027099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	E4Zk1H2CeVDxjNpVNTMBI0rprJ4aoEP6tPqq02CYblLklhFfzfKNcA8q9EyhnYE/fJ2ucqC1/Wyxc8Jzlq3miol5QpABm+HjeZuJZvQGX8i5adp5N/o4VGS/9hEquaeRn63kx3QVwCjIUwrEklrulZNi8STu1/TR//u9sUCfOP49tDmu8+AI/OvWq5nDYTqTA6fmUjU+3ryyEQjAkZPpCl1sxakgj107X/xkoMOGmapGR/lgOaCNXYBLG84S4n7AhuHPF4x2EmyQxVGJs2bL7lbBawIEw2TqB/z/n4uBrsJ+TTE8w6UfPqw87xd388NyHoqj+T/fZhsJaPBck1efAGZ3dNXd7J3VDjg+8i5MXglhGj2de0jGSgB+jfCSvr4zUynL8F0REYmgZ6kkj4hDfzcqeoxBgFzUGT84TOvyEBnsIjBmnzN0hd9SRLQPI10dZjtiQRc8FKt4uC+O9wcD1thbpYT763NIf027R4PCAgEL15YkTjjG+dwgtjIarD/dryK/ESGVQO0JM8MRVfJoeFLQx/PCzQMu87dgJxTEjCAOTRQYkBme5xiTY+4FXJtwEG2olZQJPEuAfb1TkwLMnDvspRaMtS0Tivupslj+/yEBcQ88t4Nz0cTn8zRKgMZNGrJbrszzk6ZlEPDFrcKaa4EQ8+97jGBK+QR2TRct9+M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7P189MB1137.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10070799003)(11063799006)(56012099006)(261009223027099003)(261028144727099003)(261021121427099003)(261021123027099003)(261026121527099003)(261026140227099003)(261022075727099003)(261022105027099003)(10067099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a1U0cjFGSUdOYkRIZm1xVWljSjRGdzlUWmNUMmYzNEkwWm8rRFFzczUxU0VH?=
 =?utf-8?B?d2h6REZXK0dOa0tQUy8vc0RqT3V2dm84MUlSYzk2UkNYdVc4NS9jTTM0c2Jp?=
 =?utf-8?B?eXRQVUhNeUhleDVyZS9Ld1Y4amtMNmg3bUhpY0d3c3FkNGtDWmVCd1dRODF6?=
 =?utf-8?B?UHh5VG1BRGNPS3lOL29ZbnZpQ3grM2tRVk5PVjZaRGxrZlJCMU9EMWR0RG1K?=
 =?utf-8?B?MnVTQ2g1K2NUQXdnTUpGWWVxUUg3RDlCc1JXb25SREgxck0wRms0TXRaRkRu?=
 =?utf-8?B?SFRzSWc0WkpEN0pSQUdHaWlBZ3ErYTRhcXRVL1VoS05Od0p4NnhZSHFjZkF4?=
 =?utf-8?B?dk9sMER6dmRsNVBmV0JZY21wWHBUTnVkSXRhUUdUM3pTOUc1Nkt2V3YzNlU5?=
 =?utf-8?B?Qm5wK0dtcU9RcUlDS2VmeHlYRUxNWmg1YVFGNEtkbGhvYS8yMUZHQXdTNEJl?=
 =?utf-8?B?Nk5ldWpoa3hsUFdYQXJTN2lFRlNzZ2l2Mml6YUUwaGFoT0UrZ2NSV3VFRUkr?=
 =?utf-8?B?U29Mb0ovdW1NemdhNERKcDViZ2h4bzhMZ2UxQ3JZVkRzRHZMQVBSL2M0Ylc3?=
 =?utf-8?B?dXpYSzIwSktKU1IwTzJZTU1kVXpPaGJWeFVFazlPWVRsZjNNMzljbjZhSHUv?=
 =?utf-8?B?UTBRZWhnYnR6dGltMGN2TkxNVlFpdS9nY1B0Q1VnYkNpWjhvUWwxdi9KeGgv?=
 =?utf-8?B?aWk2QkdNS0hUam1mbzM2UXAvSGEybVA2TDByRnJ0SFo3cWNFN3ZiNjZ1NFZs?=
 =?utf-8?B?VUZvSWI5dnlYWDRJWjNEMGpGYzZvRnVwbDhJem9DL0FBUHVqeGpkcGFZcHBC?=
 =?utf-8?B?SEkrODZHZTRXeGxxVGs0OEJzSUtqaUlZcVBxbXVINzNyM2dsdlJ0ZTBMRVIr?=
 =?utf-8?B?YUFxZUdJcHJ1UnB0cExiN3ZXclh1UkJPRkJndkswOElybll5UTc5TlNZVEJG?=
 =?utf-8?B?RDRNNFY2K1BqUHBPMUJRS3FHRkc1a0J5cG5IS3FmLzM5a2c3Z2RQaG9BVit2?=
 =?utf-8?B?T2NhdWhDWXNXQllxWGRQU2pLSGRwZktQR2FKeFMwNUE0WXVKTTZVN1VWV3hy?=
 =?utf-8?B?cW5yZDNaL1dDbUtDODJKOWJaZXcrRG0xejQ0RXlibEh1cG5BZ0dxSC8xdlRx?=
 =?utf-8?B?VG5JdTkxT0JDNDZ0VU9TWnkzVnIyUER5TktKTFd6ZVhKUm1CbUpCNW1hM1pw?=
 =?utf-8?B?a1NiVUJmYnNsSjBuVnpBRTZMYlJ2T0cxY3QzQzEvMVBJb1hzWHB3M0UzNVJ0?=
 =?utf-8?B?UWtXaVpOV3J1dWpORU9hUndpQjVLT1IwMmFaSE1IdUtia0xVMTFhMm91VTRH?=
 =?utf-8?B?NGpmS2hXcUtvYUxtYVJ3bVM4emVMTUd5NUJ3TU1tOG9idm5oM2FEOW1UdEty?=
 =?utf-8?B?SjhDM3BydlJkcmFSaUZNT2d1R0hyZ01KUElwSjBMNTBsQjdRTEJFYkpzWS85?=
 =?utf-8?B?NjhYVG00QkovTkgramdOVldhd0dBTEpEN1hiaU1ZcGZ4MkJFNExNMlVoenFV?=
 =?utf-8?B?b3Q1clpzM1VmWFVwOXNtK2NjRmR4Vkc0R05wNmMycWJLMFJ6YmEyUDREKzhU?=
 =?utf-8?B?VDcvRFhYODF3VytMRWlvelZtM2h0RWVyVzJxTFUycFdQY0tZR0pORmxZN2tR?=
 =?utf-8?B?OGQ1UXlocFRTZFZvNTQwMEE1bVR6ays1NVdTNHhicDdXMWlxMXh3NHVTNHR0?=
 =?utf-8?B?WTVqQ0w1MWFQaXl4SmhkU2RLT2V5MG0rbDBZTFpPM2lVV0JRU05KajNZZUtH?=
 =?utf-8?B?TGw3dW05SGNWa28vSEVMb1RzY0tKWXV0OG9KS2I2RlVFMVk1Wjk2K3g1WDdv?=
 =?utf-8?B?bVZDOC9TMzVKUFNmNS82bVNrcnI2dTFBOUEwZE8rZjF4dzhpeE5YVk9NSFZS?=
 =?utf-8?B?UXcrdDdlTmZxK2xSei9McDZ6U2lKMnRSekh1bisrMWJTaGt1bmNielZJejdx?=
 =?utf-8?B?TTlLb0I1NmEzOVkzOHhCNHl3NDIxOG1lWnZjTE1oby9VZGVHVDM1WkZ4V1pL?=
 =?utf-8?B?RHJzL2pLdXcvT2xwVGtFckhCbHlwNVV5TzcycnlhaU5CbmxVdDREbXlzcVBi?=
 =?utf-8?B?TmZxb1Y4QS9IZkZMN1J0Yy9ud0xoRHJIa3dTdjdyb1pPNGJ3UFpibUlKaWM2?=
 =?utf-8?B?VEo1RVdkb3puNTBKcXhqZ0huSFd5TG9tSy9tekdESzB5ZDlGUjJNMFhvODR6?=
 =?utf-8?B?TDNhYWpuVSsvMGJCVHFjQWRicm1oSlpjUC95S3pZYXBlaGRBZjAyVlVmMmRm?=
 =?utf-8?B?ZjNQSkZiS01hVlJNUExZVHhqenZReDJ0eS84bFVxUThqUW94RTllNFk3NFps?=
 =?utf-8?B?ckU3VkdNOUhVc0RtVWtKOTcrTWdkaFdldnI0N2lrRDFWNFpXbDlyT0F1WjNO?=
 =?utf-8?Q?DZkpHHMDRdOk83o9y7KYet5GBJYLjwpuujck8yFB9gOTw?=
X-MS-Exchange-AntiSpam-MessageData-1: SZQkTXaEgXpzcJTKJL6OcZLTwc324qSBwgI=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 078f7bf9-91f0-476f-73ed-08df3893513b
X-MS-Exchange-CrossTenant-AuthSource: AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 03:42:28.5268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6S4dqoWM8Y/SB6gUr7r+N0yp2JVlSFbf4Kf8xg+W8y3G3lxSm0XEvPRsuLGDeZTDCwELLSCfcSDauM+XIfvPXypHKshV3joB0aRxlUEJU/U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2P189MB2399

Patch 1 fixes a memory leak in tipc_node_xmit().

Patch 2 fixes a dangling link in the cluster_scope list during network
namespace teardown.

Patch 3 fixes incorrect initialization of the replicast node counter.

Patch 4 fixes a missing link-up event when memory allocation fails.

Patch 5 fixes a self-deadlock when inspecting tipc_named_node_up().

Patch 6 fixes a NULL pointer dereference caused by a race between the
tipc_net_finalize work and tipc_named_node_up(). This issue was
also reported by syzbot.

Changes in v2:
- Add patches 1–4 to fix pre-existing issues discovered while reviewing
  patch 6.
- Patch 5: Correct the bearer id that needs to be reset.
- Patch 6: Set node->dist_bulk to true when the node comes up, and
  remove an unnecessary publication insertion in tipc_update_nametbl().

Tung Nguyen (6):
  tipc: fix memory leak in tipc_node_xmit()
  tipc: fix dangling link in cluster_scope list in tipc_service_delete()
  tipc: fix incorrect initialization of replicast node counter
  tipc: fix missing link-up event on memory allocation failure
  tipc: fix self-deadlock in tipc_named_node_up
  tipc: fix NULL pointer dereference in named_distribute()

 net/tipc/core.c       |   1 +
 net/tipc/core.h       |   2 +
 net/tipc/name_distr.c | 124 +++++++++++++++++++++----
 net/tipc/name_distr.h |   4 +-
 net/tipc/name_table.c | 133 +++++++++++++++++++++++----
 net/tipc/name_table.h |  11 ++-
 net/tipc/net.c        |  19 +++-
 net/tipc/node.c       | 208 +++++++++++++++++++++++++++++++++---------
 net/tipc/node.h       |   3 +
 net/tipc/socket.c     |   2 +-
 10 files changed, 421 insertions(+), 86 deletions(-)

-- 
2.53.0

