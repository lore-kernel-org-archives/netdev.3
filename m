Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEDD46EC61
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 02:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791857666; cv=none; b=IkyU1qPxs8dTT1d2DY+RDXwJTaJ8NcxNSLSljHfKqwSrIkiwATD0YYdw3E9BCMzc4ldpd7kVeS5w9tUEPlymAkOPIj0vgJAiJoC9TagF0Hy9dfe+0OLpHJtTcfeplt8izOi41bGSnEJ+g28zV6HmA4GOkx6snZCGPfQR4dFnGOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791857666; c=relaxed/simple;
	bh=P9p0Y7rwwDGaoa844nq6szM9NNrpUbm3kQNmBtLkcBY=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=n3awlbvxRyJqBIrh+KCmBSdSE/Rgp/jI9MZzJMNUVxeU+geHYT45Ln3a9sxTDLn7MWMX7TUICvEt6OFs9IDg2+6soDMR/5hOtY66zEDWHeIZpSqJHGp5xHX2cmWAZSMuGdRfEXjrqoHwmgqGVYIVVGMeDEGcF/QWwVTdEdPG4KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:tivesync8t1791857621t29780804
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [115.198.217.6])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 17936028579200060869
To: <netdev-bot+sinfo@kernel.org>
Cc: <netdev@vger.kernel.org>,
	"'Mengyuan Lou'" <mengyuanlou@net-swift.com>,
	"'Andrew Lunn'" <andrew+netdev@lunn.ch>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@kernel.org>,
	"'Jakub Kicinski'" <kuba@kernel.org>,
	"'Paolo Abeni'" <pabeni@redhat.com>,
	"'Russell King'" <linux@armlinux.org.uk>,
	"'Jacob Keller'" <jacob.e.keller@intel.com>,
	"'Kees Cook'" <kees@kernel.org>,
	"'Chenguang Zhao'" <zhaochenguang@kylinos.cn>,
	"'Aleksandr Loktionov'" <aleksandr.loktionov@intel.com>,
	=?utf-8?Q?'Uwe_Kleine-K=C3=B6nig_=28The_Capable_H?=
	=?utf-8?Q?ub=29'?= <u.kleine-koenig@baylibre.com>,
	"'Russell King \(Oracle\)'" <rmk+kernel@armlinux.org.uk>,
	"'Maciej Fijalkowski'" <maciej.fijalkowski@intel.com>,
	"'Simon Horman'" <horms@kernel.org>
References: <20261013020626.5548-1-jiawenwu@trustnetic.com> <20261013020626.5548-2-jiawenwu@trustnetic.com> <179185736117.2527009.17237483632731841289@kernel.org>
In-Reply-To: <179185736117.2527009.17237483632731841289@kernel.org>
Subject: RE: [PATCH v3 1/3] net: libwx: keep NGBE OCP cards MAC enabled
Date: Tue, 13 Oct 2026 10:13:40 +0800
Message-ID: <00ba01dd5ab8$76a833c0$63f89b40$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIrARiyAOkyvcPRvF9csrGryG8GwgG+skdYApN5Ri+2PNx7UA==
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: tivesync:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MWDF7YTQXx3W5BPyOQEtgUnfDcSACUR3bxz8kVrcEar2v+f+ioViukeI
	aNpxXqs1h4R4lAGznAoVxIWj4euEvSf0StuUUVVssNlAiR/44WkJL14DPQTJAnZchUtepbY
	V/yjue3dB6Fxxn3fR164BgKVwK7b4vceHJSwXpULsaoRDb5wjmq0RBWlAw3Arp/OHD9H3vB
	kg8EoQ5j2U1A4R5UbAzklxBqgb8dlpOJSUrOfq+hTPh/Cm3qyKsFXezytAwXUoo5jXiVX5p
	SD4EFjwbSd7Xmh3nLj/m72N7UaazQ6F9DKsBdMNSQYhFPaG6N9ywH0E75pj9qcYtiaqPNZU
	JO78jKIgxozQn2I+ExUhrgY/o7u5nobnZt52pCF45v0tgVwYJM6IJsol8Yk4UpJW1YCg68w
	1c7dvo9HGbUUGFjCesijaZ2NbmxpEpojVCyeR1AvKvQbQHsvvSFZCvqI+b7l7IpercRFxyt
	HJ6zi+G4eCyTSiWynxD/0n/ZK65IrBEwyM1m/anf0y5ojSayXqW4n5bAmT7APtW/phoUgmX
	fnIei5pifM0Ao3BRjCybbuhhl80Rkq2LELdpQZKlyWkO2FZXo+boACYTLppi8/hhfAwB3xa
	V9Kd3urTpqarP5gkBgqzQ6/8XoB49J8lfdp1CAuImWI0GDpmr1xWK2w4rIEok1uJ993YzCg
	ANgh1a4q/7p1h9jYzownN8sEMh3DzmX0gHVkSXw3y0PrylSCmpNAMfz457IpVkMIvO3wL2H
	HJCqvVVdg1fghHqze+RtJ/LNkxmMcZEuDinpop7+9SzytBP49vhZ3igGToh5idrwbbnCcd2
	R7p0ZppZxgwrFHPvjHBiyLRKlZ2Wa2885iEXTrGBG92cHtrHKuHqdqw8T9o1mTqEW6b+eQC
	fxZCKxf8ZTDDcaRHQ79Crk0Yw//Rzv+NXXOHAs9FPzn3ECynPDWsFyHm1KQfmYXp5ejKJQp
	EfPCxyzAFcYepbcqHsxr2RB4H+8wo1Yw0rHGvmcu06IEN5R7164rIgJW2SvhagdddbCxE7h
	TaU4I+TC38GFHUb8K+wU4cmbKFZj/D42duVVkVbrmXRlPWyK2+UDdK41k3sO7gBKeqbDnFr
	74PmG0pgzr//67NHEDRA3kSLZGg0GtBNY7dsm+YZxSxfo6uSJBtyqR/02YpS1tRqCzzBUUN
	qLc1jrQ7vvoI1JZeIf/DwEKAJ5Izus2KbemA
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

On Tue, Oct 13, 2026 10:09 AM, netdev-bot+sinfo@kernel.org wrote:
> Hi!
> 
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
> 
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
> 
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
> 
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

Sorry this patch was accidentally sent in the V3 series, it should be dropped.
I've changed its status to superseded in patchwork.


