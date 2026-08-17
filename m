Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B8E3B42C0
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 07:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786953000; cv=none; b=nSSO8jp1yn4/FH7qQskRs1YQH+Go5a/fmPKmcczss1UDQQUY0b+DzURgSIp1m9PlBuet7OMvYrUL11Nil9eepMMWAue7gavli+YEUKF1jJxzLOuVAdXW5TJIj6HZPCgVfzF/rFhqy0+BAAY75J1KodGzdSPBc70UHih2XeURsfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786953000; c=relaxed/simple;
	bh=gGC3lYKq2mWHPR/8RuzYVDwgm2Cu9q6LphuLySSOPzY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c4L4yJFsNFvdxxvjv1KmxpJONgrK4oN8mOw8l3V7K1qz0iPQ37drbTMRmtza0EPcLQz8tIPuKcRgr2oBz+qu8D8O2L0CwE2yYDsA7SZD+EOY/o3HkEwVtE1o0Z60xL/GcGs9vqJgL8b8qgeXN04QCF6DgNV/cB/0G0uCc01UhOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=Z/qiFwuE; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="Z/qiFwuE"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id E75D720610;
	Mon, 17 Aug 2026 09:49:54 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6KNB2OuAWoep; Mon, 17 Aug 2026 09:49:54 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 101BC20606;
	Mon, 17 Aug 2026 09:49:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 101BC20606
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1786952994;
	bh=rIgy2Iz2/YuwN30qwUEMAvctngbYOapkhdGM2M/egUI=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=Z/qiFwuEM2jYE18h+KI+cKRJr9zVWxvl+CBQjUyul4MfPjbH8PpLQEn2avPT7aoOn
	 6m6cx8jPMlESYFqmTb21ciaE6X8nOCXcvZmyXtuEJtZkYFrB8dv9ZuC5SjCMsyrDBs
	 pPZx3qEoq9ix881t7aA8nkTKrLQncQ8U8KCjHWZoEGQnkXn0cYBXhbdoyTV0m86yjd
	 NDX3VZ5HxQdDqvaM/OVStqaTGaZiIM7DACv9XlbIzpelTOCVQku1/qRl8BC21BTji3
	 IXo93gaPUL5mHl2gWqtgHSTil6vnakpxYz6OXM0GAYu7SMlSnIwIZQ9VKxYlyFvxup
	 39RzdINaPTg4w==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 17 Aug
 2026 09:49:53 +0200
Received: (nullmailer pid 2417133 invoked by uid 1000);
	Mon, 17 Aug 2026 07:49:52 -0000
Date: Mon, 17 Aug 2026 09:49:52 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Zihan Xi <zihanx@nebusec.ai>
CC: <netdev@vger.kernel.org>, <herbert@gondor.apana.org.au>,
	<davem@davemloft.net>, <eyal.birger@gmail.com>, <vega@nebusec.ai>
Subject: Re: [PATCH net v2 1/1] xfrm: avoid lock inversion in nat keepalive
 work
Message-ID: <aoK9ILxoOLvOoTQ5@secunet.com>
References: <cover.1785861392.git.zihanx@nebusec.ai>
 <fa79c742acdfc25678e6807d4cad766edaaf1d59.1785861392.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <fa79c742acdfc25678e6807d4cad766edaaf1d59.1785861392.git.zihanx@nebusec.ai>
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
 (10.32.0.171)

On Wed, Aug 05, 2026 at 04:51:25AM +0000, Zihan Xi wrote:
> nat_keepalive_work() walks the state table while xfrm_state_walk()
> holds net->xfrm.xfrm_state_lock. Its callback then acquires x->lock,
> which conflicts with the delete path taking the same locks in reverse
> order via xfrm_state_delete() and __xfrm_state_delete(). This creates
> an AB-BA deadlock that is reported by lockdep when a NAT keepalive
> worker races with SA deletion.
> 
> Fix this by splitting keepalive handling into two phases without
> reversing the lock ordering. Walk the state table only to collect a
> bounded batch of candidate states while holding xfrm_state_lock and
> taking references on them. Then, after the walk drops xfrm_state_lock,
> process each referenced state and take x->lock in phase two.
> 
> Use a small fixed-size batch and the xfrm_state_walk() cursor to resume
> the scan when the batch fills up. This avoids per-state GFP_ATOMIC
> allocations, avoids aborting a full round on -ENOMEM, and keeps
> nat_keepalive_send() in BH-disabled context by wrapping the phase-two
> drain with local_bh_disable()/local_bh_enable().
> 
> Fixes: f531d13bdfe3 ("xfrm: support sending NAT keepalives in ESP in UDP states")
> Cc: stable@vger.kernel.org
> Cc: Eyal Birger <eyal.birger@gmail.com>
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: Codex:gpt-5.4
> Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
> ---
> changes in v2:
>   - reroll on top of net cf6f8b29befb so the patch applies after the
>     nat_keepalive_send() default-case change
>   - replace the unbounded GFP_ATOMIC state list with a bounded batch
>   - keep phase-two processing in BH-disabled context with
>     local_bh_disable()/local_bh_enable()
>   - clarify the validation permission model and reproducer scope in
>     the cover letter
>   - refresh the cover letter with cf6f8b29 incremental build and PoC
>     validation results
>   - rerun decode_stacktrace.sh on an LF-normalized crash log and
>     document the decoder truncation in the cover letter
>   - add source locations for the key lockdep offsets from the same
>     unfixed vmlinux
>   - add Eyal Birger to Cc for the v2 reroll
>   - v1 Link: https://lore.kernel.org/all/cover.1784645321.git.xizh2024@lzu.edu.cn/
> 
>  net/xfrm/xfrm_nat_keepalive.c | 51 +++++++++++++++++++++++++++++------
>  1 file changed, 43 insertions(+), 8 deletions(-)

Can you please send this as fix for your original v1 patch
on top of the ipsec tree? That way I don't need to revert
your original v1 patch.
