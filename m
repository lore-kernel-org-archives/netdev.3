Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011002.outbound.protection.outlook.com [52.101.65.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACEA49A3D7
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 09:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789982928; cv=fail; b=rUEdrZ3anvGe0y3wauFjvqGPe1qQm3Yc3Ngpl+RDLpzkkgNxlG/f69/1nCZB5rVcXbO0M7YM8gXoJwWRjIduikjON1IiqHGc5qS1naz+yoZmJppiIQuFbl0CtYf15uVa/sIJNxixbLzSCEYeCoHmqekKXLAkzweegiv13R8IQ8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789982928; c=relaxed/simple;
	bh=uryIDchf5orsXo7fOySDY86trn4/fXjQMrY5pXwrLCM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sGnDaiqkxktKUeeS0axerZZjD0ITqAt6/oLk0LQv/lffYtoTykmX6Ga8jB+AZwJzUCfH35SFG6Huj7j+j8S72hguC9LkdmiqG/WJ+gteiMerZVtHjQueQhCStPUiBkg2isOytiOfrkRw3e6Kq8MgyCr4kB2DCmoznpxnfJzH6Lc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=sPHoUE+q; arc=fail smtp.client-ip=52.101.65.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="sPHoUE+q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QTK8bqafCBLc0C0yiHVa5i4KQJGgKMWu/b04lsQbDJ26zScZMSgxMzRoRYajT4rW1js6fzRHjXlT7ViEEzMW/9CLPYXQy2gAi7WCkhP2aAD1PGG82K5a05i8l12wKurIOBAj294s3MPBMoxnvhnnjfuBaMpKQ89gyj3beCS8z9xylkFQfOlcUukR0lQkzop1FspC0PBtK0Mi+vhGCdpYYOc+ONeUI8fmjUi7zW/hDNpTrjBdkZ6C8qC3TkionbDQ2XAVPYSdvZDYMa7eoUw3S1ANqDLM08oI7gFURWO8U+ABpEvs0dKE2uCPW0H7cyCM4SdMiS3xcXej4L3DPgYbgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zLd5hPRcfb/E4GiSkOhMPn5Inpb8BbqTq/OSgK0dIGY=;
 b=EMH9eRwS0ithv4F+fjogxHXCjsj6XDJDjI/UF5GTUWT8LticPytZIHe93KJrd9ljQRCaGdSxmODYyA9e2T4Hw7se/MvVnfNFXWaMsqqB0zsA9tqgx3iOI+RyxTqOBKidnbaphwCTe6Sj7RQfx948cvPUNi7m+ZFiIPh1TNcKMAKY/FNq+U5NO4TpEIFFD4Zl4z++VmsgcEOeNQEndDefIB3JDK61x8E46uiQluuyOQdQxYi2WDuKFgab1dSFGdhRW+4YmXwlIixPqlz+Z69x+P+l9siTPRitdxpR1HqWrZNzn7cZOr5CCbbYsNJkirgZV3m4vmjEPvx/UlY0Mj/tKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zLd5hPRcfb/E4GiSkOhMPn5Inpb8BbqTq/OSgK0dIGY=;
 b=sPHoUE+qIajYggeTEYUN3DYjIwrAV2x7Q1omzJXjLVWPshlAExut34LzA8k9fJBBfAHeaXfNCUPFbyEZ2XxsFeHhw0MFKbP/5NMb7t7e9pmVtjiSNVG0IVP8Oks7PeC6E7kb5IkPHwRLDH9Qcrr6SlnpBHvAdy4ovGGTZewts1BzgplAUNYZcxdrsTUwEqCpjqFyL6cXpYI2QjT5mHM4ZnSFqBfqf1b4He975WxWquskwhS8bdBuPrm1R9TeGYFxF8GFeQdfYxRTbNDEFhRzReZXqoAjduVGel/jkIAri8iQP2+IaFGx97hNPsMojYdWN7Rz2VxYfsvQJ3rzjOhDlA==
Received: from DU4P189MB3750.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:617::19)
 by AS4P189MB2136.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:51b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 09:28:40 +0000
Received: from DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
 ([fe80::d422:dd3a:7c1e:f4f3]) by DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
 ([fe80::d422:dd3a:7c1e:f4f3%3]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 09:28:40 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: "xiaoshoukui@gmail.com" <xiaoshoukui@gmail.com>
CC: "edumazet@google.com" <edumazet@google.com>, "jmaloy@redhat.com"
	<jmaloy@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"w@1wt.eu" <w@1wt.eu>, "xiaoshoukui@ruijie.com.cn"
	<xiaoshoukui@ruijie.com.cn>
Subject: RE: [PATCH net] tipc: fix memory leaks in bundle and fragment paths
Thread-Topic: [PATCH net] tipc: fix memory leaks in bundle and fragment paths
Thread-Index: AQHdRaM/5s16wXYOHEyHInlRwNizWbbSEy6QgAZZhwCAAE9NoA==
Date: Mon, 21 Sep 2026 09:28:40 +0000
Message-ID:
 <DU4P189MB37506A937448D1ED977C7BFCC6842@DU4P189MB3750.EURP189.PROD.OUTLOOK.COM>
References:
 <GV4P189MB37321B67712A8B2906F2DC2DC6B82@GV4P189MB3732.EURP189.PROD.OUTLOOK.COM>
 <20260921034758.806257-1-xiaoshoukui@gmail.com>
In-Reply-To: <20260921034758.806257-1-xiaoshoukui@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU4P189MB3750:EE_|AS4P189MB2136:EE_
x-ms-office365-filtering-correlation-id: 82a3d0bc-e12a-4457-71d1-08df17c2b91e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|3023799007|56012099006|10067099003|4143699003|38070700021|5023799004|11063799006|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info:
 B5v7UiLOH9kEb+Lqr88YAI5L1ynvPxgjeJMRizZXjg/HOuxp2CTQ4j8MkQUjSSQf1YY8PcxibLxnnvvQDtxaJYi/76eBHG5A2ua8CYM1TzG6MUeNUOS341L3wrqJ4xFSzJMRwN/Ksn692/KmPoZKut3YOJ/DILfK+aEB5TrCN/fKfGlELrsxEaniGPlQW0MGvcohU2r+CcgHQekczl1gSo3uorN6YIouasdflyvuemX0lipI+DU3RNGPeZABZDeacfgK32MvXiHPf7ElmjJ6mH+ZWzaGCJrrcnNSYqfejpCLfPSdSCL/gyd+SwYNH9STpaYSwRL8mO+3D7xO6IwLgpjKZt6WxqO+xqK/8bQbjUuugnjvNRjOpAVJs75930H7MTGsJh5TKPODdBrapx1xaCUZEZw7Yz66B1xK6L3cn9X5UzTnnHwt+znVhPbzw4xEHFTZ9iGuv4LF48Ot+14q7t6ID9+wADFA8/JI0gfSPyiewp3nJTlwLQd+JiX4CjJrJ0RD5WpEVyW/Js0AYScAXOLzp2E60Si+bXtmuHUwCU/7WEOHW/ZEIs7KhMjaGLC++Czt0LOILB42C+DzfWJ8C0HpNtejJNmGyj6bbsc8SgBal8m1ey9O5lNopbvjNBWDNP27K079c2BgszzwD9QNUzHoEO4LiYDobeHdnCOw3Qg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU4P189MB3750.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(3023799007)(56012099006)(10067099003)(4143699003)(38070700021)(5023799004)(11063799006)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?vYXFy0yYZUhNGrACjtz4Tk7+P60MOQKDwDXRNwX8jnBOHTDGwjmmZLZtjrSE?=
 =?us-ascii?Q?cqC++ACvQjQXYd6kh3R5TRvBBgLilaPP6J8mi6xMH8WtPBKMggw64v8oS5S/?=
 =?us-ascii?Q?2g39DhZSRrYIqwEcQLKd00djH6SC9z7R8EMrlpT7jKgQ+KYXKgACB1D1r8I9?=
 =?us-ascii?Q?e30LA6vczxFWaYRcfQhZSBtWJ0ucGqm4s8wntLAmOFhRvvWcU7N03Tds3RJk?=
 =?us-ascii?Q?dZwhaUX+qJTpzCciXrV0BSm2XfyI4f+XTsawYolgcMN1pt0oM9nraHMsI0RJ?=
 =?us-ascii?Q?L6oGp2h61ncYCTMWPrS5DZHkQDhgXIPgBJQAkXJiHnVCav59D63n5gXd0cCh?=
 =?us-ascii?Q?iVW3M905kWWfRSFje3MEzielcy2y47GGBZdjgLgFHQfKl3VnEP5abUo9LXhg?=
 =?us-ascii?Q?6EBeilQIxTK1xoPaiIsPa9tFLGfDjYVfPr1GbzRm5HtN2EF2yRZbePQIpKAO?=
 =?us-ascii?Q?KC20X25wK4FxDGzgELsgC8W6eskGPeFCYMNSoAJmFvRfKjZ7ABjjLmg7JtNu?=
 =?us-ascii?Q?u8c726tlgm7dVsM/xlVS+2rE0aUfPHGl1F7PmMTHPeQLc3cY2j4bIskNpL9C?=
 =?us-ascii?Q?KQ97w0gZlGXGFZN9//Jy0n2nl23BlGD7xlbSrQZJGgpj6YlNrCQsCCLZbhT5?=
 =?us-ascii?Q?IhJGN9GZiPxqyeRBRALsLM4UAwEML4t1L1uS10had/qkxrz5bwhusJD4rQ3V?=
 =?us-ascii?Q?7pmzXhKTuUKv9HjdZzyIA27znQmesbAGVifTFg4e8PPFpr1gbOhodKqp6evF?=
 =?us-ascii?Q?TnZBL1wESPivngC0f0XHS4v9vI2DudhpaXAQyuqah1ISoGapugOb4dUi+ffe?=
 =?us-ascii?Q?Lx2+zazk2b9hPjabFTOgsGmFBCLsZRP05y4JJ5sEiJ20WCYpGvsf9cqRMgZu?=
 =?us-ascii?Q?GMpoAkCx3mhH0XcBmmMSfTU1Tfe7jnF3vPQXeux3jZ8TK+OISV9n3514xCRv?=
 =?us-ascii?Q?skkckoLVSFH9cANASHaTGRMNEOgR8YV8EB1mKBcPwKBX9vPWdinkhiTKQhQ9?=
 =?us-ascii?Q?x+VGC+K4fm5lgNm1IUKpxDacXUpg8cQsPrifjRT6/Hc3uMyg9XYRm1ikvCQY?=
 =?us-ascii?Q?osTMx4TMfR78glyEEpvxW7YWeF0VMRNyxpqYE62abQNB9Kd2cRpQFv9dM7ro?=
 =?us-ascii?Q?6XDJ3vGSJJxMF4pfyqfaBztiLvUbGgKv0kH3lgSfZVoJb8znnfXNdohp0FIy?=
 =?us-ascii?Q?Ba5q59VUOxueARi0BCx7evl8Gku4pXgibvtx8aLPkKMCKa0KZRSUtcv99vXS?=
 =?us-ascii?Q?W7d35vqVx3T/zQNds+gs7gV+e/bwN6LFjdmVat98AXfK77D0ggnBX68haP7w?=
 =?us-ascii?Q?DQ8zN0jT9seIGzXpjE+c64kEcNK5mMVaxLUYM4TUUgnuO+I5ahuOb1ywUqRZ?=
 =?us-ascii?Q?ZVnTTmNWzV4Z5aeIqiYD3yc/iOu566RBon8wHXd/EYB5NbcZPpjyDVPSJsor?=
 =?us-ascii?Q?fBsdu/T9YT301syzUvKcplH1TR/5kSZL3GoNLKEcnoOmD7ewwp1IuVu6pRU1?=
 =?us-ascii?Q?l7cIeBvHM8VvMi81ybGWD2waTermixOHHHFv0Y1KlftkMAilwkII6/uaPiuo?=
 =?us-ascii?Q?FnUEFoGjOljk+ZQTDDPmEp+2fu5FzJzQc6LyIbPGBl/GI/n+Dr9FUKPqR1dW?=
 =?us-ascii?Q?qpatzFdbKZjDyXCvGk7gtZrAdfR4IphW1MQc4f2gx6AzgafNAKNyCNLYJStf?=
 =?us-ascii?Q?7i5ALLANqUds5wldHUA2ai0c8Bzak3emD/pNBGPVcu7DTYGe51MvWpiBll2w?=
 =?us-ascii?Q?nm+XlJUAxw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 82a3d0bc-e12a-4457-71d1-08df17c2b91e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2026 09:28:40.6531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GyAdvOgaDv+/mqgx6CxE8ZYJZUqjVehr/5AVx7+N5ShswDtoSn5LHsJ1Wa4hu3GTF/UEzZe6H+RRTaXBJkHv+fnIRF7vsWsbFKbHCosiFVI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P189MB2136

>Subject: Re: [PATCH net] tipc: fix memory leaks in bundle and fragment pat=
hs
>
>Hi Tung,
>
>Thanks for the review and feedback.
>
>On Thu, Sep 17, 2026 at 03:51:16AM +0000, Tung Quang Nguyen wrote:
>> This cannot occur because the sending side already does sanity check
>> to make sure that no invalid protocol type exists in bundled and
>> fragmented messages.
>> This only occurs when you create fake TIPC messages or tampering with
>> existing messages. This is an invalid use case because TIPC is being
>> used in an insecure environment. In such environment, IPSec or TIPC
>> encryption must be used as mentioned here
>> https://datatracker.ietf.org/doc/html/draft-maloy-tipc-01.txt#section-
>> 6
>
>I agree that the normal transmit path performs checks that prevent the
>relevant internal protocol users from being bundled. In particular,
>tipc_msg_try_bundle() rejects MSG_FRAGMENTER, TUNNEL_PROTOCOL, and
>BCAST_PROTOCOL.
>
>However, I think this is separate from the receive-side skb ownership issu=
e
>addressed by this patch. The patch does not assume that these message type=
s
>are normally generated by the transmit path. It handles the case where an =
skb
>has reached tipc_data_input() and that function explicitly reports that it=
 did
>not consume the skb.

This patch tries to address an unreal use case. I am waiting for your real =
reproducer and explanation on how data part of bundling and fragmented mess=
ages can contain invalid types/users.
Of course, tipc_data_input() drops invalid types/users as designed.

>
>The relevant point here is that an skb that is not consumed by
>tipc_data_input() must still have a defined owner and cleanup path.
>
>> This check is redundant because bundled messages do not contain
>> message types that can make tipc_data_input() return false. The only
>> exception is tampering with TIPC messages.
>> If that is the case, a fake valid message type can be inserted into
>> the bundle message and tipc_data_input() returns true but user
>> applications are broken by corrupt messages.
>
>I agree that a tampered message can be changed to a valid user type.
>In that case, tipc_data_input() returns true and the message is queued for
>further receive processing.
>
>However, that case does not exercise the check added by this patch.
>The added kfree_skb_reason() is only executed when tipc_data_input()
>returns false.

The check is redundant because tipc_data_input() never returns false after =
calling tipc_msg_extract() or tipc_buf_append().

>
>The two cases therefore have different ownership behavior:
>
>valid user type
>    -> tipc_data_input() returns true
>    -> skb is queued to inputq
>    -> receive processing continues
>

This is correct but there is more valid use case:
-> tipc_data_input() returns false
-> skb is passed to tipc_link_input()
->  tipc_data_input() returns true
-> skb is queued to inputq

>unhandled protocol user
>    -> tipc_data_input() returns false
>    -> skb is not queued or consumed by tipc_data_input()

This is not correct. If tipc_data_input() returns false, the skb will be dr=
opped.

>
>For the latter case, the bundle path currently ignores the return value:
>
>while (tipc_msg_extract(skb, &iskb, &pos))
>    tipc_data_input(l, iskb, &tmpq);
>
>tipc_msg_extract() has already allocated and validated iskb before returni=
ng it.
>For the protocol users listed above, tipc_data_input() then returns false
>without consuming the skb. Since the caller ignores that return value, the
>extracted skb has no subsequent cleanup path.

This is not correct as explained above.

>
>The proposed check only closes this ownership gap; it does not attempt to
>solve message-integrity or anti-tampering problems.
>
>> >+				kfree_skb_reason(iskb,
>> >SKB_DROP_REASON_UNHANDLED_PROTO);
>>
>> Compiling warnings:
>> https://netdev-ctrl.bots.linux.dev/logview.html?f=3D/logs/build/1166117/
>> 14820384/checkpatch/stdout
>
>Thanks for pointing this out. I will fix the checkpatch formatting issue i=
n v2.
>
>> This check is redundant because fragmented messages do not contain
>> message types that can make tipc_data_input() return false. The only
>> exception is tampering with TIPC messages.
>> If that is the case:
>> - dropping the invalid fragmented message will cause the reassembled
>message
>>   corrupt (For example: sending a 65KB message but dropping/truncating
>1500
>>   bytes). As a result, user applications receive corrupt messages.
>> - a fake fragmented message can ben sent and tipc_data_input() returns t=
rue
>>   but user applications are broken by corrupt messages.
>
>Regarding the fragment path, I believe the proposed change does not drop a=
n
>individual fragment during reassembly.
>
>tipc_buf_append() is documented to return 1 only when reassembly is
>complete. For the first and intermediate fragments it returns 0. When the =
last
>fragment is received, it validates the reassembled message, assigns the
>complete reassembled skb to *buf, clears the reassembly state, and returns=
 1.
>
>Therefore, the relevant sequence is:
>
>  first fragment
>      |
>  intermediate fragments
>      |
>  last fragment
>      |
>  complete reassembly
>      |
>  tipc_msg_validate()
>      |
>  tipc_data_input()
>
>The added kfree_skb_reason() is reached only after this complete reassembl=
y
>step:
>
>  if (tipc_buf_append(reasm_skb, &skb)) {
>      l->stats.recv_fragmented++;
>      if (!tipc_data_input(l, skb, inputq))
>          kfree_skb_reason(skb,
>                           SKB_DROP_REASON_UNHANDLED_PROTO);
>  }
>
>At that point, skb refers to the complete reassembled message, not to an
>individual 1500-byte fragment.
>
>If tipc_data_input() returns true, the reassembled skb is queued to inputq=
 as
>before. If it returns false, the complete reassembled skb is not consumed =
by
>tipc_data_input(). Without an explicit cleanup at this point, the reassemb=
led
>skb and its associated fragment data become unreachable.
>
>Thus, the proposed change does not truncate a 65KB message by dropping one
>1500-byte fragment. It only releases the complete reassembled skb when the
>receive-side dispatcher reports that it did not consume it.

You are right. I misread tipc_buf_append().

>
>I agree that a forged valid user type is a separate message-integrity issu=
e. This
>patch is not intended to provide authentication or protection against mess=
age
>tampering; its purpose is limited to ensuring that skbs rejected by
>tipc_data_input() are properly released.

tipc_data_input() releases invalid skbs as expected.
Note that we do not want to add check for unreal cases because it causes pe=
rformance regression.
I tested your patch and it showed regression as below:

Setup: disable NAGLE to generate bundling messages. Two netperf threads wit=
h different message sizes are executed at the same time.

[BEFORE PATCH]:
node1 ~ # taskset -c 0 netperf -n 2 -f m -c -C -H 100.100.100.2 -t TIPC_STR=
EAM -l 60 -- -O THROUGHPUT -m 64
TIPC STREAM TEST to <1.0.561:547203127>
Throughput=20
521.49

node1 ~ # taskset -c 1 netperf -n 2 -f m -c -C -H 100.100.100.2 -t TIPC_STR=
EAM -l 60 -- -O THROUGHPUT -m 65536
TIPC STREAM TEST to <1.0.561:309928041>
Throughput=20
9342.63   =20

[AFTER PATCH]:
node1 ~ # taskset -c 0 netperf -n 2 -f m -c -C -H 100.100.100.2 -t TIPC_STR=
EAM -l 60 -- -O THROUGHPUT -m 64
TIPC STREAM TEST to <1.0.561:1589461199>
Throughput=20
440.38     =20

node1 ~ # taskset -c 1 netperf -n 2 -f m -c -C -H 100.100.100.2 -t TIPC_STR=
EAM -l 60 -- -O THROUGHPUT -m 65536
TIPC STREAM TEST to <1.0.561:2903145288>
Throughput=20
8417.67



