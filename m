Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.96.220.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792475062;
	b=s3AEMuiMTdV9XcMX2mMH34k0m50MqSNyqQG1RGrhFR+YI4NNAph2VSkrN12a+uwYwPXh
	 gI8MDTK5iD+2wQXBX3EnevcS5j32OrjCXrIlpQATzZIYNNHJapY/4u7mWW8A3Fn0ba75s
	 oyAQn6AAtEsXFkmqIIcvvPAPbk9v/leruVgWBaWSSvrw7izzVY+wm0Oy+JV15COM5bDF0
	 DfWP2ucykZI6eb9bGG69wAnGBP5FoqvTd6EERZyK/bcX4rzwIXr2J4+mbfr2OyyqhRZcO
	 DhwxWD3P17h9fXLeXdaArjGQfarTHU6+D7np1ls40/70ftfjEwBbW9OzPyuFj5l15yA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792475062;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:Received:DKIM-Filter:
	 DKIM-Signature:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy;
	bh=SHP+ZuI0NbQryrK1GfspQZp3EZ/0jC5OKBRZ00AmRe4=;
	b=eLE45N+8dcEqJ+5rA7lByZI4TvHnVD7B1Huf4zLP4JMq+wRtmMEjWj6LQ6ysqRe2BN/N
	 c02LOSV0p0GwQ2g7pV9dBv764ZnQtR0h9Cvnlya5dxGd2SGxkeRLMBt98sZrRv+Pnh7ar
	 8PfYwk7RZX3JVSh6jnOSVw57IMol6nZYHqKXpj99flqAe8oYRXtw6FLoS7NUh+mhSfx/J
	 v/yyP2jk5+rY7uNrZRp7DGUWWQbcDA2DiQMCl8yE/gIA0m6pdkdC1C+nFiCu+jBLfjSWJ
	 40QAfw6Y1ns9wrNauUK6mnKSgF/9wmZsN4NZjcujem4bPMDddZtqBc8PrJhW49jzWpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=secunet.com;
	spf=pass smtp.mailfrom=secunet.com;
	dkim=pass header.d=secunet.com header.i=@secunet.com header.a=rsa-sha256 header.s=202301 header.b=Bf71C4Si;
	arc=none smtp.remote-ip=62.96.220.36
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E74606A319;
	Tue, 20 Oct 2026 05:44:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55E74606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=secunet.com header.i=@secunet.com header.a=rsa-sha256 header.s=202301 header.b=Bf71C4Si
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 34F88207D8;
	Tue, 20 Oct 2026 07:44:18 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4xHASxzx2J8G; Tue, 20 Oct 2026 07:44:16 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id C173D207D1;
	Tue, 20 Oct 2026 07:44:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com C173D207D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1792475056;
	bh=SHP+ZuI0NbQryrK1GfspQZp3EZ/0jC5OKBRZ00AmRe4=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=Bf71C4Si4GxTzbyRFtPWYQnCDAxNZIuWup4b5Cl8J6QTemD6eRKQKEF7TZpKSoGOG
	 ObpQeH8Hdcswi74qFLN1pcReQUYX9FJ0c+Z5SZPIWsDu6T3eVCXLdJlPydlw7CAEiv
	 /8O4JzKy0I4KdgNKtfm+V2rXc0BM6kA49P/QgxUCmE+1qXZN0g6pXlwUrZ6gNBdbiC
	 LAREP9Sk1iFswRqAZExktnziJb9e8Wy/uoJCBOq1W4hGZjImf4T9gAcPXG6CytJnwB
	 k6CRFptHT5Xsl6BsRt5Xgdr2elBRxRwQXJdhyzHJzuCqTajSFWWbr5wZHc3pX97DgD
	 yPrZEsWaq9nzw==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 20 Oct
 2026 07:44:15 +0200
Received: (nullmailer pid 2880014 invoked by uid 1000);
	Tue, 20 Oct 2026 05:44:14 -0000
Date: Tue, 20 Oct 2026 07:44:14 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Antony Antony <antony.antony@secunet.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, David Ahern <dsahern@kernel.org>, Jamal Hadi Salim
	<hadi@cyberus.ca>, Shuah Khan <shuah@kernel.org>, Sabrina Dubroca
	<sd@queasysnail.net>, <netdev@vger.kernel.org>, Yan Yan
	<evitayan@google.com>, Tobias Brunner <tobias@strongswan.org>, Florian
 Westphal <fw@strlen.de>, <linux-doc@vger.kernel.org>,
	<stable+noautosel@kernel.org>, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH ipsec v5 0/9] xfrm: state: exact mark/mask match for
 control-plane SA lookups
Message-ID: <atb_rttOpKrO3MRP@secunet.com>
References: <migrate-state-fixes-v5-0-d9d3d794553d@secunet.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <migrate-state-fixes-v5-0-d9d3d794553d@secunet.com>
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)

On Wed, Oct 07, 2026 at 11:34:13AM +0200, Antony Antony wrote:
> While looking into a XFRM_MSG_MIGRATE_STATE issue reported by Sashiko,
> we found the underlying problem generalizes: xfrm allows multiple SAs
> to coexist for the same (SPI, daddr, proto) differing only in mark,
> and every netlink method that resolves "which SA" - xfrm get_sa(),
> del_sa(), update, get_ae, new_ae, expire, migrate - uses the same
> wildcard mark match the data path needs. A broader-mask SA can
> silently shadow a more specific one:
> 
>   # ip xfrm state add ... spi 0x1000 mark 1 mask 1 (SA_target)
>   # ip xfrm state add ... spi 0x1000 mark 0 mask 0
>     (SA_decoy, catch-all, added after -> bucket head)
>   # ip xfrm state delete dst ... proto esp spi 0x1000 mark 1 mask 1
>     -> deletes SA_decoy; SA_target survives, untouched
> 
> xfrm policy had the same bug, fixed in commit 4f47e8ab6ab7
> ("xfrm: policy: match with both mark and mask on user interfaces").
> 
> Netlink state lookups using spi use an exact mark/mask match except
> for UPDSA; the wildcard match stays for the data path and state_add only.
> This series applies that fix across every affected method,
> not just XFRM_MSG_MIGRATE_STATE.
> 
> Also reject marks with value bits outside the mask (state ADD,
> ALLOCSPI, policy ADD, MIGRATE_STATE new mark). These are
> misconfigurations anyway, since the extra bits can never match, and
> break exact match added here.
> 
> This series does not touch PF_KEY, which no longer receives
> non-critical fixes.
> 
> state_lookup_byaddr is out of scope. This is only fixing spi based
> lookups.
> 
> ---
> v4->v5: policy: drop the redundant mark sanitize in xfrm_policy_insert()
>       - tweak commit messages
> 
> - Link to v4: https://patch.msgid.link/migrate-state-fixes-v4-0-d5054459fc78@secunet.com
> v3->v4: add 3 patches to reject mark value bits outside the mask for state and policy
> 
> - Link to v3: https://patch.msgid.link/migrate-state-fixes-v3-6-836125bb53dd@secunet.com
> 
> v2->v3: mark match use only values and no mask in exact lookup
> 
> - Link to v2: https://lore.kernel.org/all/migrate-state-fixes-v2-0-c3e2767f0d96@secunet.com/
> v1->v2: few more wildcard mark check reported by sashiko and Yan
>       - keep wildcard match in xfrm_state_update() (UPDSA)
> 
> - Link to v1: https://patch.msgid.link/migrate-state-fixes-v0-8-a69e8637ba3b@secunet.com
> ---
> 
> ---
> Antony Antony (9):
>       xfrm: state: reject mark with bits outside its mask on add
>       xfrm: state: reject mark with bits outside its mask on ALLOCSPI
>       xfrm: policy: reject mark with bits outside its mask on add
>       xfrm: state: exact mark/mask match for SPI-keyed control-plane SA lookups
>       xfrm: fix use-after-free of migrated state in xfrm_do_migrate_state()
>       xfrm: fix hw offload state leak on xfrm_do_migrate_state() error path
>       xfrm: include mark in MIGRATE_STATE SA collision check
>       xfrm: pass extack through to xfrm_init_replay() from xfrm_init_state()
>       docs: xfrm: include mark in XFRM_MSG_MIGRATE_STATE EEXIST tuple
> 
>  .../networking/xfrm/xfrm_migrate_state.rst         |  25 +++--
>  include/net/xfrm.h                                 |   7 ++
>  net/xfrm/xfrm_policy.c                             |   3 -
>  net/xfrm/xfrm_state.c                              | 101 +++++++++++++++++----
>  net/xfrm/xfrm_user.c                               |  81 ++++++++++++-----
>  5 files changed, 166 insertions(+), 51 deletions(-)

Series applied, thanks a lot Antony!
