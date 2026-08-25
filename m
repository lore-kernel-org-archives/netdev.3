Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965793A4F3B;
	Tue, 25 Aug 2026 05:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787636687; cv=fail; b=rcAnoTqHDCQ+zgKcIPhk5D4vUZJtPGQcK7LI9Mgbp2rOrdMS5MF1fTdGwXE+kyhqg7qMwE+LquXo+3CnynKdXMc1penTb8wVPofEGYGYqP1KcJTvnrPvwsZ2enLa6E4DOts4oaQiJa7EbpqOHk21ZkiKub+a4FjZIXUTQ3E8b9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787636687; c=relaxed/simple;
	bh=qfbfzXPVSUYoJucVqYQXAEgnt6KrVnJ7fA6mY59qMeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sYcfCD+K/TxJGGzett17b4i1MHrPP/c+DIZ2af8Kou4v1YPaUGhDqrZGO+keoP4/ApSCrPUSAD3GhdJkXVkBRNqvPpCO24c3j5UfY8RqzB3tMl96Mz5YF1U+SX+a9qEJiOhU5hpX8dkQj50elf6vRM77qrR1cRkfih41WMC7TKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=WXaWNsIQ; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=tjCC9ADL; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WXaWNsIQ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="tjCC9ADL"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1787636685; x=1819172685;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=qfbfzXPVSUYoJucVqYQXAEgnt6KrVnJ7fA6mY59qMeo=;
  b=WXaWNsIQlrCdim5W0/sPAgu7h5/YeX8kzCMTk01yJK6X33eL8oOYQ2h6
   iZuwkreGltGGi320l2Hhr8gi/tvrFIY1svnyYqQ2LebJ/AJe3RxX2o5Cz
   R8d49RetEY5ifo23fiovretfG6hRQxTddae45p4jrCsne/4/mlicG1p4D
   wlr0BtB3CTO36k43AxlqCdBPunIjhGsYcQg0RxUb03TwjjyzhwvMeegfJ
   +B779kqx6DcjnBwBXutJX0UC3awNVbwSrR73aP1vww2Smsw/kAG/yrfye
   TtS1lTlzeu/+K+1CrVvW8OoDv0QS8rXuwPbUWoSXYkBo1HdQ9ripulrBz
   w==;
X-CSE-ConnectionGUID: TCPdsIeSSpK5DhL9R/3Aag==
X-CSE-MsgGUID: nUtnhJyhRdCDt7Spg1juUA==
X-IronPort-AV: E=Sophos;i="6.25,242,1779120000"; 
   d="scan'208";a="153247321"
Received: from mail-southcentralusazon11012018.outbound.protection.outlook.com (HELO SN4PR2101CU001.outbound.protection.outlook.com) ([40.93.195.18])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Aug 2026 13:44:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wscQoj0M+bLjOTuE+/Kp/R5HpyXO2//g7yzbHcz/F6cvB5HYU439zilLnJPqJpcQXWCdU9S5HwpbzK9ZUwm8LB9kjbkn0SCo3eKU7YrwYDRNsVdZmpsjnCEP5Gfp2r9Co1kOYKxH8+q9MS5kleogbRvpEcdtjaqZAQYG6Fw96mRS3hzFdf2seqDnQixeknfWK61hok8emqHyJIu7Dg7fe3ZNhbc1QUK06j0k0iIv2qhyCJ3+KDe3Vm4SSAbF8TiIDyCWjdwT7tCmgF6x8Lh8QYTywcCea9Yq6T4jaK/eHvRc7bPk5mXnQ5dGvKuhME1mT1Rkt8QPJ5BkhQx4zazzlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+uv2QuDQVkUrs+kcIDHpS8/xBFUjxhyzELPQqjXxESQ=;
 b=VZAPRprlXjxEDhZXDtBqQ3jz9D9H1u+6wFtRe6O7/hzMmrquBGYyqRbrW5NMn5cn1qtdL5VFW4NsrjMjI2bZtff9QUWw8Ww7vqBbg+aDDSwnK1l7PHtxK0E25o6OuPei03O1Erl+K7p3esy6apbE7zaS3u9GRFpeIEAfn9khxnx3xeETjOVZ4jFhIgEE9AFqt1koQ0F4DIeRAXGEf6xFmPokknJItqNKShgmeyL+xSoKlRR1h379mfhZuECc/1FTCVL8KtAngd43zcjpSr9gYFIa3xbk/O2oq/K+qj52S6OjbcISnDaG78RcLj8ZFrlg/mPaf5RAp7erRquok0+nTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+uv2QuDQVkUrs+kcIDHpS8/xBFUjxhyzELPQqjXxESQ=;
 b=tjCC9ADLu2Aa2Fl2eTeTWdymeGrjw1NBNfdTM27Izw0vO+DK7mh5FbUK5tIzSjnbK6lYV/q0m0cxCd6SRRYH05g0UUFZnD4nX1iV5jB6KyQ1LyrAGejnLObPPQ4izVdfIong2OwEI08P0Cu2MS5WvGDclkKS6H0VImH7CX90Ico=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by SAWPR04MB993584.namprd04.prod.outlook.com
 (2603:10b6:806:561::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 05:44:41 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%4]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 05:44:41 +0000
Date: Tue, 25 Aug 2026 14:44:35 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Eric Dumazet <edumazet@google.com>
Cc: syzbot <syzbot+2d770620059281e225a4@syzkaller.appspotmail.com>, 
	Nilay Shroff <nilay@linux.ibm.com>, Keith Busch <kbusch@kernel.org>, boqun@kernel.org, 
	hdanton@sina.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	peterz@infradead.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] WARNING: locking bug in tcp_tsq_handler
Message-ID: <ao0mwtt8ePAINFni@shinhome>
References: <20260825002924.1439-1-hdanton@sina.com>
 <6a8ce8d5.dbb3a75c.7844.0018.GAE@google.com>
 <CANn89i+wnTLC==UnXCpjsS4YxvEfhe5oK0N7fttbqr1zKyqdug@mail.gmail.com>
 <CANn89iJ01nSttn66xfaM+AOa4U-nvw=pSeqKxzvU64426-ZJrw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iJ01nSttn66xfaM+AOa4U-nvw=pSeqKxzvU64426-ZJrw@mail.gmail.com>
X-ClientProxiedBy: TY4P286CA0097.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:369::12) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|SAWPR04MB993584:EE_
X-MS-Office365-Filtering-Correlation-Id: 7862dcbe-6e42-4c02-bfb8-08df026bf53d
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|7416014|23010399003|18002099003|22082099003|11063799006|5023799004|56012099006|3023799007|6133799003|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	6sk3hNg/wl+lkVYh8NDqiACH0i7GYRSKoG8mjNtgzPoxJbQJqTQ7LPAhMLZ5EN8ks3VtJF+53nIXFJZRqtS80ssV1fUHENJRMqylIN9TqR/b3OLcYCkrTndXWQUV6PKZ/rYnarw7dz91D1tJ5NVIkLXdLIwXgdEGsSoi/cwPrBQJgMhTNmI2GP/wibHnuE5BuLX8j0WnM1a1GhGdDh2xeSwzvN5wYcvlUVB8lhfmayr33kj0Eqm2JOMq90Sc0qe/GKbw6G2zaLSCY4QLIP4yO2RRvVSgnCwb0wvf+i9m079j5pUpONVcXo4a/gT1g662ijEq/IvxGAabi9gMBCwGYrSq8UTlAtn4Zvw+hCG6c5/p6gtFV2Em8DNk5vG8tOCZanlNEEB6mo9Z2o0HkjfhUouQ2JjX6/x66O9QURuuUXz4yVO/9hFQklAcVJokbYWOdP+FmWr1x4DAx6q4ckVJBCWtQ4JYiL7y55fp21g/1igoNt5akW1Ex/7BKMkXivGfHaWdIzpQwcqR+7RXAfeb5ygSRvS2QnvDHDkWQTf0UOsnnHwiPyWP82OJoaM00YPb8r+jnsdrdWRpT/y0o6Uc2OlViJAvENYQQicvntV8APl34wDyDK1pzMiNBj+9GEu4w3VuOwzHCBajS6cROPW8iUs9vbMiL77b07cigoxI4hc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(7416014)(23010399003)(18002099003)(22082099003)(11063799006)(5023799004)(56012099006)(3023799007)(6133799003)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eEtrMFNHMEhHaXNJdXN3dGE3OUdhY0gwb015cFB2dUV1T2sxR0laQ1R0RmpN?=
 =?utf-8?B?enkraUdZUXJhY3NER1Zsbm9sK1kra1Z2RnhxZSs2dXdYSkpZVG41UnFmamNS?=
 =?utf-8?B?L0VZL1JCMWhzaERMZCtBY0dGMC9zVlQ1S2ViM3VMd0tINFU4a1ZRTThickJi?=
 =?utf-8?B?SUFPaDdTT1hvMTFpWm1EWExDWXdFMTZ6dERCMHhTM0c4N2lHT21qTHp3aXE2?=
 =?utf-8?B?OFVrSWlYQzcrY2tMbitWL3FPUU1PbUF1NTd0amJLZ29QQzV5d2hxbE84UkZw?=
 =?utf-8?B?Y283RXViTE9tNEFCZlRCNERjeDZPbDQrbWg2SmF5VzVuYXAwNVFPQlBydVlO?=
 =?utf-8?B?bCtUVWYvcFBCblRVR2tvSlNXdVpqOWF4NEFZSml1aTdHOFk5U3dtbFZ3TWhC?=
 =?utf-8?B?V2JtVFJnYlAwaGN6ZjZSVmV5V3JOL1FJK01Qc1pTVVEzL0ExeThJNHlXamZv?=
 =?utf-8?B?ZCtaNlphaVdtQkRDVkVNZUZTdW44bS8xZ2Y4ZHdYdWo5WC9MNHpxL21NeEUz?=
 =?utf-8?B?bUdkZC9RVDlZbkkyTWlQT0NRTFVZenlrZUgrT1pXM3A1Rk84eWpQaTA1TFFu?=
 =?utf-8?B?d2txSVdPZnVGTmNsSm9UcmRuYjBqMGg0SGdJVWpZVWoreSszSkRVWUkra2to?=
 =?utf-8?B?ZnQ1dG9ZRStzdEQ1bTVwVHdhOHZheWlSTFNoQjh3UEJlOVpYY3NWZ1dRTHEz?=
 =?utf-8?B?dUV6TW1yQ3RucVRlZmJNc1VGQys4YnNxa2FaeEZiU052aEtwZHJtQVZWWmVm?=
 =?utf-8?B?MDRQVjB0ZDFETEhVRkhXU3FMbDQvREorYklncGZ1VCtNdHV6endFQ1BmRUNK?=
 =?utf-8?B?Y2tzdHVCWlR3MTNFdzdiZUdkYmsyYmQ3aE9OUkRKRkNlL24rZjVBUWxrLzNC?=
 =?utf-8?B?bnBqOG1vVExGM2VlOER5VE1CTTBEcHg1SlJPT2VrMmR4MnJjaS82anpOUGFB?=
 =?utf-8?B?aHlzN0tqQTRGS1lZYW96U20xbjNKM080bm5ZeGdXbk9rOFpRMVh1UXN2Ym5n?=
 =?utf-8?B?L0VzKzJLSy9ZZFh4YkM1NU9wbHhBWDlJejU1RCtNaktNUzNMc3UyL0VJU2c1?=
 =?utf-8?B?RmFQK1J3RFRFN2wyNmgwTHJONEJadEVYZ2hDUHBRRzl4UWtlcVpBS21McDRE?=
 =?utf-8?B?L0xOVWNXNTZmZXVwVjI1YzdnTDg5aDBYSWVJQllkdlV5ekFpOUk1WGVwbGhh?=
 =?utf-8?B?Z1VyMTRhVGJ1bExpMERGNkV3VHFEL0VaSjN6QUJlR09WSUlMcnB6ZUtRTWZZ?=
 =?utf-8?B?VUduSFBXZjkxWmVFZ1R2cTJOcGZ5S2g3T0NPUk9ZbysvY0lIYmRKMW5oNFZt?=
 =?utf-8?B?blFnOURZVWhpSVVIckd3QU1EelRhR090MEF5TEJNQUtvZjhlRzdPeHMvb3pO?=
 =?utf-8?B?NktlMEtTY2QwNGVPeURNUXRNaUdtMElVTzV3VkxBRzBqM29FS2NNZ3BHMnZL?=
 =?utf-8?B?T3BvRlN0ck5Fa0hXVDM0NzFCaUVNb2d3dTlsR3lOOXpKVmkvSmF2ZkVRemJB?=
 =?utf-8?B?ZWtidHBZZmlMYm03ZTNldDZ4MFNGWGlwNHdkMHV6a3ZQZEg2VHNxNGxMSUVZ?=
 =?utf-8?B?N1pBTFVlYWtlYlpBSXMxTlptbEQ0aTBzWUJ0dk9laFljZGJ3VXRndDFKbmpa?=
 =?utf-8?B?VU9mU0k3WTAzL2ljMHNtUDVxWFZYNVFEL0hzQ2pqNC94TUdVaDQ5VENSZ00w?=
 =?utf-8?B?S3R2d1lhYnhQRU44N3dIalNTV0hvSnQ5QXk2VG54eFRyQ1cydjl3MDA3YnhB?=
 =?utf-8?B?WEt5NjI0SmdrVTl1VE9tMnFkWFd0NTJSWDR1NmltbWpCaEMvclRCd3A2QzdX?=
 =?utf-8?B?Y1hFYmxWT1BsQU5GK1RrampCZ25xKzlMVVdZY3Iya21qVWx4a09zUGI2N2VB?=
 =?utf-8?B?eXcxTGJVWUNlTjY4U3IvNWlMT3lnTXR0TitFMk5xVTZQTHhoNzkyczZkdWFD?=
 =?utf-8?B?SmJBaHJQK1BWUGk4bms0SWZwdWJmK2laeU4vU2I0b1JPUFRiSzBkK0MxeUt1?=
 =?utf-8?B?cTE3QXluTGdYdlA0MjA4ZExXM1J0OGhvYmlHZkc5K0trcit4WGVhOHNJZTNs?=
 =?utf-8?B?OG5LZ3Y5RC9KeTdJZEdIVS9UajFDS1VhdllQaHlwZzJPWmV4NEtYMEYva1J0?=
 =?utf-8?B?OEY2VXFUMGxDTzNiN1BnNjJaZ3hxRzVJWTFuN0RxZFRyQkpBemwyT3cxZUJI?=
 =?utf-8?B?dXpuQXd3RDMwVHltQWtjZDdKdG1ERmsrNHpSWEFudHFYRWN4Vm5FVS9ldmcy?=
 =?utf-8?B?UVVIRFFPOWpWcjlkdFVvWGhSeHE2VGdxaURrcXAxbGlDOVVkMGk2eUJDcHpG?=
 =?utf-8?B?MmYzeUkwL09SV2p5dHlhdVlZWDd4QnVIRWxlUC9adUxDbGltN21jUW9LZXlm?=
 =?utf-8?Q?Q8esrakvFM+7xrrA=3D?=
X-Exchange-RoutingPolicyChecked:
	NiYqvQhgyztghVYqi+/BDkbhnGmYPvg82BQb7VW//OdEBM9vJzpduiZC4IVC4CYcq/In1h45L4vIJN1IRiXabGyI5L7+CncdmkV4PUAkfwszFOQCNqEu+1QtJcgCrnC5sX2+qMQzCgOjlwnLw+94JK940LWvkyyjFCEQ0M41AMqS990WM8BRmUKIAbxvAAjDMn3aE892Pkm4n/TOWD/3EtytenYOnWddrPAZaUhha9c2X/C1xt+cTNbfHTq1Oe+qPbSNnQkz/bW6wn1JyHjbLLUda/vI5b+aSe+6UBfEdbc9S2bjG4K44+QcCKqSYTXo7nLX0qu0K39yzIMFVBNJew==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/AmXDUFW/d37bt+pqxifl7gTYg//E54HkBx0ofPnvfVvhL5yGMWScuWmdgjcZ4i4KcQZYyyGov1g4Ki02f+IgjcfDjOLugLEoA0x6ctoYCERV6ZJ+IKNaDYPRXJpX5rxQgqxZh0hvfYd8hDfAJtUI9IWJ82s+Wu9XUykZgcEuNrn+2/aeCheTfUqJCPJwiQ6OqnMwK/m7c9nr0BgQxxkXc08OmjSOV7kqL+MTZ8cYpNprh4SpNCZjPd4C4z7d9Qx4DDkhlwVRXERt1h072/kEascXtpKFoXGkLYaVVzPDSouanAi1ldQb/1BcYLNjQzuf45RTysntCVMskohWtKFtfyyyZ7EBF6Wpam/7C0M8yx2Si2/uXnj4I22Sr62CDMLJkzeSITUJgfhXZtb9Q7sZw/Z8Yi1rUzi2Sl2ccTsCGJiLU3k3o1U8wYYolNc3OVs5eoaONseSuTiGzusdjOHNcdfJoxSsN5bE7xaoHJm7eZoYUgDUF7Gc+cLWpiZFSXEdI1WM0eitiaUdkw+YgtjHYEWA0/bUzpFL3GGI3jZI84szJfIaS64iPlR5GxVTPHWTY2cR1RFfmZAQWDG9DOU5Nh2Ns8SzdxRBCwQ70GzRgFSAAEc6ohUHalxvv9Q9TdD
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7862dcbe-6e42-4c02-bfb8-08df026bf53d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 05:44:41.0077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W3Q4xu0XMB1SOrqVEm3f2UzEy/tCv2Wp3gltcG9XxjT5ga5VnzufGHJ0b3QWWZatt8fMHnzWQw4c2nhMGmxVuVV5JZbkEzAiMqj5V9EYhYI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR04MB993584

On Aug 25, 2026 / 03:50, Eric Dumazet wrote:
> On Tue, Aug 25, 2026 at 3:27 AM Eric Dumazet <edumazet@google.com> wrote:
> >
> > On Tue, Aug 25, 2026 at 2:59 AM syzbot
> > <syzbot+2d770620059281e225a4@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> > > WARNING in tcp_tsq_handler
> > >
> > > ------------[ cut here ]------------
> > > !lockdep_sock_is_held(sk) && debug_locks
> > > WARNING: ./include/net/sock.h:1799 at sock_owned_by_me include/net/sock.h:1799 [inline], CPU#1: kworker/1:0/24
> > > WARNING: ./include/net/sock.h:1799 at sock_owned_by_user include/net/sock.h:1812 [inline], CPU#1: kworker/1:0/24
> > > WARNING: ./include/net/sock.h:1799 at tcp_tsq_handler+0x1a6/0x200 net/ipv4/tcp_output.c:1292, CPU#1: kworker/1:0/24
> >
> > Note this is a different warning.
> >
> > This one might have been added in nvme-tcp in commit
> >
> > commit 19bdb70c77d3b24239a453291299b64040bdba86
> > Author: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > Date:   Thu Jun 4 11:32:08 2026 +0900
> >
> >     nvme-tcp: lockdep: use dynamic lockdep keys per socket instance
> >
> > The authors assumed that __fput_sync(queue->sock->file) in
> > nvme_tcp_free_queue() synchronously destroys the socket, so they
> > unregistered the keys immediately:
> >
> > __fput_sync(queue->sock->file);
> > queue->sock = NULL;
> > ...
> > #ifdef CONFIG_DEBUG_LOCK_ALLOC
> > lockdep_unregister_key(&queue->nvme_tcp_sk_key);
> > lockdep_unregister_key(&queue->nvme_tcp_slock_key);
> > #endif
> >
> > However, a TCP socket's lifetime is asynchronous:
> > in-flight skbs (e.g. buffered in a qdisc or device ring) hold
> > references on sk->sk_wmem_alloc.
> >
> > When those packets are freed later, tcp_wfree() puts sk on TSQ and
> > tcp_tsq_handler(sk)
> > acquires bh_lock_sock(sk) on a socket whose lockdep key has already
> > been unregistered and zapped.
> >
> > All other kernel storage/networking clients (sunrpc, nbd, cifs,
> > iscsi_tcp, rxe, siw) use static lockdep keys without issue.
> >
> 
> I think 19bdb70c77d3 should be reverted.

Just reverting the commit will reintroduce the other lockdep WARN that the
commit addressed. I hope to have another fix to avoid the WARN.

> 
> We can change TCP to use sk_gfp_mask(sk, GFP_ATOMIC) instead of
> gfp_any() in tcp_disconnect()
> 
> This ensures tcp_disconnect() respects sk->sk_allocation = GFP_ATOMIC
> and never acquires fs_reclaim under sk_lock.
> 
> WDYT?

Thanks for the idea. I did a quick trial with the idea.

Step 1:
  I reverted the commit 19bdb70c77d3 from v7.2 kernel, and confirmed that
  the blktests test case nvme/005 for tcp transport recreates the lockdep
  WARN that includes fs_reclaim in its lock chain.

Step 2:
  I created a patch to replace gfp_any() in tcp_disconnect() with GFP_ATOMIC
  [1]. I applied this patch to the v7.2 based kernel that I used in the step 1.
  I ran the test case nvme/005 on this kernel, and observed it still fails
  with the lockdep WARN: fs_reclaim was still included in the lock chain.

    I think this is expected, since fs_reclaim dependency comes from CPU hotplug
    bring-up context.

Based on this observation, I'm afraid that using GFP_ATOMIC in tcp_disconnect()
won't work, unfortunately.

Another approach I can think of is to use sk->sk_destruct hook to unregister
keys, so that the unregistraion happens after the all in-flight skbs complete.
I will try this approach.



[1] fix trial patch

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 455441f1b694..861ce399eee3 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3376,14 +3376,14 @@ int tcp_disconnect(struct sock *sk, int flags)
 	} else if (unlikely(tp->repair)) {
 		WRITE_ONCE(sk->sk_err, ECONNABORTED);
 	} else if (tcp_need_reset(old_state)) {
-		tcp_send_active_reset(sk, gfp_any(), SK_RST_REASON_TCP_STATE);
+		tcp_send_active_reset(sk, GFP_ATOMIC, SK_RST_REASON_TCP_STATE);
 		WRITE_ONCE(sk->sk_err, ECONNRESET);
 	} else if (tp->snd_nxt != tp->write_seq &&
 		   (1 << old_state) & (TCPF_CLOSING | TCPF_LAST_ACK)) {
 		/* The last check adjusts for discrepancy of Linux wrt. RFC
 		 * states
 		 */
-		tcp_send_active_reset(sk, gfp_any(),
+		tcp_send_active_reset(sk, GFP_ATOMIC,
 				      SK_RST_REASON_TCP_DISCONNECT_WITH_DATA);
 		WRITE_ONCE(sk->sk_err, ECONNRESET);
 	} else if (old_state == TCP_SYN_SENT)


[2] Lockdep WARN observed at the step 2

[   86.005477] [    T995] run blktests nvme/005 at 2026-08-25 13:52:07
[   86.164051] [   T1069] loop0: detected capacity change from 0 to 2097152
[   86.204542] [   T1073] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[   86.274053] [   T1079] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[   86.483498] [    T104] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[   86.493643] [   T1089] nvme nvme5: creating 4 I/O queues.
[   86.503743] [   T1089] nvme nvme5: mapped 4/0/0 default/read/poll queues.
[   86.510474] [   T1089] nvme nvme5: new ctrl: NQN "blktests-subsystem-1", addr 127.0.0.1:4420, hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[   87.138148] [    T103] nvmet: Created nvm controller 2 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[   87.145904] [     T83] nvme nvme5: creating 4 I/O queues.
[   87.167642] [     T83] nvme nvme5: mapped 4/0/0 default/read/poll queues.
[   87.274245] [   T1137] nvme nvme5: Removing ctrl: NQN "blktests-subsystem-1"

[   87.291121] [   T1137] ======================================================
[   87.292008] [   T1137] WARNING: possible circular locking dependency detected
[   87.292880] [   T1137] 7.2.0+ #669 Not tainted
[   87.293454] [   T1137] ------------------------------------------------------
[   87.294356] [   T1137] nvme/1137 is trying to acquire lock:
[   87.295070] [   T1137] ffff88812e989518 (set->srcu){.+.+}-{0:0}, at: __synchronize_srcu+0xc1/0x2f0
[   87.296192] [   T1137] 
                          but task is already holding lock:
[   87.297124] [   T1137] ffff88813bebaac8 (&q->elevator_lock){+.+.}-{4:4}, at: elevator_change+0x197/0x500
[   87.298299] [   T1137] 
                          which lock already depends on the new lock.

[   87.299570] [   T1137] 
                          the existing dependency chain (in reverse order) is:
[   87.300685] [   T1137] 
                          -> #5 (&q->elevator_lock){+.+.}-{4:4}:
[   87.301657] [   T1137]        __mutex_lock+0x1ae/0x2500
[   87.302338] [   T1137]        elevator_change+0x197/0x500
[   87.303047] [   T1137]        elv_iosched_store+0x38f/0x430
[   87.303719] [   T1137]        queue_attr_store+0x25f/0x3e0
[   87.304377] [   T1137]        kernfs_fop_write_iter+0x3d6/0x5e0
[   87.305121] [   T1137]        vfs_write+0x4b3/0xf40
[   87.305747] [   T1137]        ksys_write+0x112/0x250
[   87.306821] [   T1137]        do_syscall_64+0xdf/0x790
[   87.307851] [   T1137]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   87.309110] [   T1137] 
                          -> #4 (&q->q_usage_counter(io)){++++}-{0:0}:
[   87.310932] [   T1137]        blk_alloc_queue+0x605/0x7a0
[   87.312034] [   T1137]        blk_mq_alloc_queue+0x168/0x270
[   87.313138] [   T1137]        scsi_alloc_sdev+0x8df/0xd10
[   87.314229] [   T1137]        scsi_probe_and_add_lun+0x5bd/0xbf0
[   87.315381] [   T1137]        __scsi_add_device+0x233/0x280
[   87.316480] [   T1137]        ata_scsi_scan_host+0x137/0x3a0
[   87.317560] [   T1137]        async_run_entry_fn+0x93/0x550
[   87.318616] [   T1137]        process_one_work+0x8b2/0x15e0
[   87.319657] [   T1137]        worker_thread+0x5fd/0xfe0
[   87.320653] [   T1137]        kthread+0x367/0x460
[   87.321592] [   T1137]        ret_from_fork+0x655/0x9d0
[   87.322577] [   T1137]        ret_from_fork_asm+0x1a/0x30
[   87.323571] [   T1137] 
                          -> #3 (fs_reclaim){+.+.}-{0:0}:
[   87.325134] [   T1137]        fs_reclaim_acquire+0xd5/0x120
[   87.326174] [   T1137]        __kmalloc_cache_node_noprof+0x67/0x6f0
[   87.327258] [   T1137]        create_worker+0x117/0x790
[   87.328234] [   T1137]        workqueue_prepare_cpu+0x93/0xf0
[   87.329219] [   T1137]        cpuhp_invoke_callback+0x2c5/0x11f0
[   87.330236] [   T1137]        __cpuhp_invoke_callback_range+0xb6/0x1e0
[   87.331303] [   T1137]        _cpu_up+0x2eb/0x6d0
[   87.332204] [   T1137]        cpu_up+0x111/0x190
[   87.333062] [   T1137]        cpuhp_bringup_mask+0xd3/0x110
[   87.334049] [   T1137]        bringup_nonboot_cpus+0x139/0x170
[   87.335075] [   T1137]        smp_init+0x27/0xe0
[   87.335914] [   T1137]        kernel_init_freeable+0x442/0x710
[   87.336905] [   T1137]        kernel_init+0x18/0x150
[   87.337769] [   T1137]        ret_from_fork+0x655/0x9d0
[   87.338655] [   T1137]        ret_from_fork_asm+0x1a/0x30
[   87.339554] [   T1137] 
                          -> #2 (cpu_hotplug_lock){++++}-{0:0}:
[   87.340978] [   T1137]        cpus_read_lock+0x3c/0xe0
[   87.341886] [   T1137]        static_key_disable+0x12/0x30
[   87.342790] [   T1137]        __inet_hash_connect+0xf7f/0x1a60
[   87.343727] [   T1137]        tcp_v4_connect+0xcb7/0x1970
[   87.344619] [   T1137]        __inet_stream_connect+0x399/0xfb0
[   87.345570] [   T1137]        inet_stream_connect+0x55/0xb0
[   87.346474] [   T1137]        kernel_connect+0x103/0x170
[   87.347385] [   T1137]        nvme_tcp_alloc_queue+0xa48/0x1ba0 [nvme_tcp]
[   87.348457] [   T1137]        nvme_tcp_alloc_admin_queue+0xff/0x440 [nvme_tcp]
[   87.349569] [   T1137]        nvme_tcp_setup_ctrl+0xad/0x8a0 [nvme_tcp]
[   87.350603] [   T1137]        nvme_tcp_create_ctrl+0x874/0xc20 [nvme_tcp]
[   87.351646] [   T1137]        nvmf_dev_write+0x40b/0x830 [nvme_fabrics]
[   87.352660] [   T1137]        vfs_write+0x1cc/0xf40
[   87.353468] [   T1137]        ksys_write+0x112/0x250
[   87.354310] [   T1137]        do_syscall_64+0xdf/0x790
[   87.355175] [   T1137]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   87.356196] [   T1137] 
                          -> #1 (sk_lock-AF_INET-NVME){+.+.}-{0:0}:
[   87.357635] [   T1137]        lock_sock_nested+0x32/0xf0
[   87.358491] [   T1137]        tcp_sendmsg+0x1c/0x50
[   87.359322] [   T1137]        sock_sendmsg+0x31c/0x3f0
[   87.360180] [   T1137]        nvme_tcp_try_send_cmd_pdu+0x60e/0xcc0 [nvme_tcp]
[   87.361282] [   T1137]        nvme_tcp_try_send+0x1ef/0xa60 [nvme_tcp]
[   87.362299] [   T1137]        nvme_tcp_queue_rq+0xfa3/0x19e0 [nvme_tcp]
[   87.363334] [   T1137]        blk_mq_dispatch_rq_list+0x3e0/0x2400
[   87.364316] [   T1137]        __blk_mq_sched_dispatch_requests+0x20a/0x15d0
[   87.365378] [   T1137]        blk_mq_sched_dispatch_requests+0xa7/0x140
[   87.366411] [   T1137]        blk_mq_run_work_fn+0x135/0x2e0
[   87.367331] [   T1137]        process_one_work+0x8b2/0x15e0
[   87.368243] [   T1137]        worker_thread+0x5fd/0xfe0
[   87.369107] [   T1137]        kthread+0x367/0x460
[   87.369924] [   T1137]        ret_from_fork+0x655/0x9d0
[   87.370776] [   T1137]        ret_from_fork_asm+0x1a/0x30
[   87.371645] [   T1137] 
                          -> #0 (set->srcu){.+.+}-{0:0}:
[   87.372966] [   T1137]        __lock_acquire+0xe20/0x2440
[   87.373847] [   T1137]        lock_sync+0xbf/0x120
[   87.374646] [   T1137]        __synchronize_srcu+0xe1/0x2f0
[   87.375530] [   T1137]        elevator_switch+0x2bd/0x670
[   87.376421] [   T1137]        elevator_change+0x2e7/0x500
[   87.377311] [   T1137]        elevator_set_none+0xaa/0xf0
[   87.378203] [   T1137]        blk_unregister_queue+0x15e/0x2e0
[   87.379139] [   T1137]        __del_gendisk+0x28b/0xaa0
[   87.380009] [   T1137]        del_gendisk+0x11a/0x1c0
[   87.380844] [   T1137]        nvme_ns_remove+0x331/0x9e0 [nvme_core]
[   87.381851] [   T1137]        nvme_remove_namespaces+0x289/0x3f0 [nvme_core]
[   87.382970] [   T1137]        nvme_do_delete_ctrl+0xf6/0x160 [nvme_core]
[   87.384028] [   T1137]        nvme_delete_ctrl_sync.cold+0x8/0xd [nvme_core]
[   87.385124] [   T1137]        nvme_sysfs_delete+0xb7/0xe0 [nvme_core]
[   87.386153] [   T1137]        kernfs_fop_write_iter+0x3d6/0x5e0
[   87.387104] [   T1137]        vfs_write+0x4b3/0xf40
[   87.387935] [   T1137]        ksys_write+0x112/0x250
[   87.388756] [   T1137]        do_syscall_64+0xdf/0x790
[   87.389596] [   T1137]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   87.390592] [   T1137] 
                          other info that might help us debug this:

[   87.392533] [   T1137] Chain exists of:
                            set->srcu --> &q->q_usage_counter(io) --> &q->elevator_lock

[   87.394872] [   T1137]  Possible unsafe locking scenario:

[   87.396268] [   T1137]        CPU0                    CPU1
[   87.397169] [   T1137]        ----                    ----
[   87.398062] [   T1137]   lock(&q->elevator_lock);
[   87.398873] [   T1137]                                lock(&q->q_usage_counter(io));
[   87.400042] [   T1137]                                lock(&q->elevator_lock);
[   87.401144] [   T1137]   sync(set->srcu);
[   87.401864] [   T1137] 
                           *** DEADLOCK ***

[   87.403562] [   T1137] 5 locks held by nvme/1137:
[   87.404365] [   T1137]  #0: ffff8881134a0450 (sb_writers#4){.+.+}-{0:0}, at: ksys_write+0x112/0x250
[   87.405677] [   T1137]  #1: ffff888137b45080 (&of->mutex#2){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x257/0x5e0
[   87.407118] [   T1137]  #2: ffff8881475f82d8 (kn->active#141){++++}-{0:0}, at: sysfs_remove_file_self+0x61/0xb0
[   87.408549] [   T1137]  #3: ffff88812d8641c8 (&set->update_nr_hwq_lock){++++}-{4:4}, at: del_gendisk+0x112/0x1c0
[   87.410012] [   T1137]  #4: ffff88813bebaac8 (&q->elevator_lock){+.+.}-{4:4}, at: elevator_change+0x197/0x500
[   87.411425] [   T1137] 
                          stack backtrace:
[   87.412674] [   T1137] CPU: 3 UID: 0 PID: 1137 Comm: nvme Not tainted 7.2.0+ #669 PREEMPT(full) 
[   87.412679] [   T1137] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-10.fc44 06/10/2025
[   87.412684] [   T1137] Call Trace:
[   87.412689] [   T1137]  <TASK>
[   87.412691] [   T1137]  dump_stack_lvl+0x6a/0x90
[   87.412697] [   T1137]  print_circular_bug.cold+0x189/0x1eb
[   87.412704] [   T1137]  check_noncircular+0x173/0x1a0
[   87.412708] [   T1137]  __lock_acquire+0xe20/0x2440
[   87.412712] [   T1137]  lock_sync+0xbf/0x120
[   87.412714] [   T1137]  ? __synchronize_srcu+0xc1/0x2f0
[   87.412717] [   T1137]  ? __synchronize_srcu+0xc1/0x2f0
[   87.412720] [   T1137]  __synchronize_srcu+0xe1/0x2f0
[   87.412723] [   T1137]  ? __pfx___synchronize_srcu+0x10/0x10
[   87.412727] [   T1137]  ? ktime_get_mono_fast_ns+0x1f5/0x6a0
[   87.412733] [   T1137]  ? _raw_spin_unlock_irqrestore+0x35/0x60
[   87.412737] [   T1137]  elevator_switch+0x2bd/0x670
[   87.412740] [   T1137]  ? elevator_change+0x197/0x500
[   87.412742] [   T1137]  elevator_change+0x2e7/0x500
[   87.412744] [   T1137]  ? kernfs_put.part.0+0x2ca/0x7d0
[   87.412747] [   T1137]  elevator_set_none+0xaa/0xf0
[   87.412749] [   T1137]  ? __pfx_elevator_set_none+0x10/0x10
[   87.412751] [   T1137]  ? kernfs_put.part.0+0x2f3/0x7d0
[   87.412754] [   T1137]  ? kobject_put+0x62/0x530
[   87.412759] [   T1137]  blk_unregister_queue+0x15e/0x2e0
[   87.412762] [   T1137]  __del_gendisk+0x28b/0xaa0
[   87.412765] [   T1137]  ? down_read+0xbd/0x530
[   87.412767] [   T1137]  ? down_read+0x148/0x530
[   87.412770] [   T1137]  ? __pfx___del_gendisk+0x10/0x10
[   87.412771] [   T1137]  ? __pfx_down_read+0x10/0x10
[   87.412774] [   T1137]  ? up_write+0x24c/0x760
[   87.412776] [   T1137]  ? up_write+0x2f8/0x760
[   87.412779] [   T1137]  del_gendisk+0x11a/0x1c0
[   87.412782] [   T1137]  nvme_ns_remove+0x331/0x9e0 [nvme_core]
[   87.412802] [   T1137]  ? _raw_spin_unlock_irqrestore+0x35/0x60
[   87.412805] [   T1137]  nvme_remove_namespaces+0x289/0x3f0 [nvme_core]
[   87.412824] [   T1137]  ? __pfx_nvme_remove_namespaces+0x10/0x10 [nvme_core]
[   87.412843] [   T1137]  nvme_do_delete_ctrl+0xf6/0x160 [nvme_core]
[   87.412863] [   T1137]  nvme_delete_ctrl_sync.cold+0x8/0xd [nvme_core]
[   87.412882] [   T1137]  nvme_sysfs_delete+0xb7/0xe0 [nvme_core]
[   87.412901] [   T1137]  ? __pfx_sysfs_kf_write+0x10/0x10
[   87.412903] [   T1137]  kernfs_fop_write_iter+0x3d6/0x5e0
[   87.412907] [   T1137]  ? __pfx_kernfs_fop_write_iter+0x10/0x10
[   87.412909] [   T1137]  vfs_write+0x4b3/0xf40
[   87.412913] [   T1137]  ? __pfx_vfs_write+0x10/0x10
[   87.412915] [   T1137]  ? __x64_sys_openat+0x10a/0x210
[   87.412917] [   T1137]  ? __pfx___x64_sys_openat+0x10/0x10
[   87.412920] [   T1137]  ? do_syscall_64+0x1ec/0x790
[   87.412923] [   T1137]  ? trace_hardirqs_on_prepare+0x139/0x180
[   87.412931] [   T1137]  ? lockdep_hardirqs_on+0x8c/0x130
[   87.412933] [   T1137]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   87.412935] [   T1137]  ? do_syscall_64+0x20a/0x790
[   87.412939] [   T1137]  ksys_write+0x112/0x250
[   87.412941] [   T1137]  ? __pfx_ksys_write+0x10/0x10
[   87.412945] [   T1137]  do_syscall_64+0xdf/0x790
[   87.412949] [   T1137]  ? fput_close_sync+0xda/0x1b0
[   87.412953] [   T1137]  ? __pfx_fput_close_sync+0x10/0x10
[   87.412955] [   T1137]  ? do_raw_spin_unlock+0x55/0x230
[   87.412958] [   T1137]  ? rcu_is_watching+0x11/0xb0
[   87.412967] [   T1137]  ? do_syscall_64+0x1ec/0x790
[   87.412969] [   T1137]  ? trace_hardirqs_on_prepare+0x139/0x180
[   87.412971] [   T1137]  ? lockdep_hardirqs_on+0x8c/0x130
[   87.412973] [   T1137]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   87.412975] [   T1137]  ? do_syscall_64+0x20a/0x790
[   87.412977] [   T1137]  ? __pfx_ksys_read+0x10/0x10
[   87.412979] [   T1137]  ? do_sys_openat2+0xff/0x170
[   87.412981] [   T1137]  ? __pfx_fput_close_sync+0x10/0x10
[   87.412983] [   T1137]  ? rcu_is_watching+0x11/0xb0
[   87.412986] [   T1137]  ? do_syscall_64+0x1ec/0x790
[   87.412988] [   T1137]  ? trace_hardirqs_on_prepare+0x139/0x180
[   87.412990] [   T1137]  ? lockdep_hardirqs_on+0x8c/0x130
[   87.412992] [   T1137]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   87.412994] [   T1137]  ? do_syscall_64+0x20a/0x790
[   87.412996] [   T1137]  ? rcu_is_watching+0x11/0xb0
[   87.412999] [   T1137]  ? __x64_sys_openat+0x10a/0x210
[   87.413002] [   T1137]  ? __pfx___x64_sys_openat+0x10/0x10
[   87.413004] [   T1137]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   87.413006] [   T1137]  ? rcu_is_watching+0x11/0xb0
[   87.413009] [   T1137]  ? do_syscall_64+0x1ec/0x790
[   87.413011] [   T1137]  ? trace_hardirqs_on_prepare+0x139/0x180
[   87.413013] [   T1137]  ? lockdep_hardirqs_on+0x8c/0x130
[   87.413015] [   T1137]  ? do_syscall_64+0x20a/0x790
[   87.413017] [   T1137]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   87.413019] [   T1137]  ? rcu_is_watching+0x11/0xb0
[   87.413022] [   T1137]  ? trace_hardirqs_on+0x14/0x190
[   87.413023] [   T1137]  ? preempt_count_add+0x7f/0x190
[   87.413028] [   T1137]  ? do_syscall_64+0x5d/0x790
[   87.413030] [   T1137]  ? do_syscall_64+0x8d/0x790
[   87.413032] [   T1137]  ? irqentry_exit+0xfc/0x810
[   87.413035] [   T1137]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   87.413037] [   T1137] RIP: 0033:0x7fa87169008e
[   87.413040] [   T1137] Code: 4d 89 d8 e8 94 bd 00 00 4c 8b 5d f8 41 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 10 0f 05 <c9> c3 83 e2 39 83 fa 08 75 e7 e8 03 ff ff ff 0f 1f 00 f3 0f 1e fa
[   87.413042] [   T1137] RSP: 002b:00007ffee438c910 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
[   87.413049] [   T1137] RAX: ffffffffffffffda RBX: 00007fa871865006 RCX: 00007fa87169008e
[   87.413051] [   T1137] RDX: 0000000000000001 RSI: 00007fa871865006 RDI: 0000000000000003
[   87.413053] [   T1137] RBP: 00007ffee438c920 R08: 0000000000000000 R09: 0000000000000000
[   87.413054] [   T1137] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000010ade770
[   87.413055] [   T1137] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000010adef80
[   87.413059] [   T1137]  </TASK>

