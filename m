Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9183BE17B
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 07:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785137404; cv=none; b=uhTXloEDEdUc0tZ+Gj4/D89F+x+9INhuC7NCT16sLECKcXUy/v52RkUPXcC7rf/s2W8MBH8PcJrGsuP6QuxU1HTtu1GrVt0iZc6Q3IRoNSSRao+D4jSuUgKBBYTEeoGnl7YIYSwmUZHYz7fGJPgS1+h7yhCBAq7hCphiMh2dq2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785137404; c=relaxed/simple;
	bh=UhT6TdJcnYRuh90NzOCB7QtqcxQnUOtEQARAaHYvEeI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=afvdloQ50PgRSBYQ/NXTQPWULwGq+ulBWFMMGMOMuCAD9y4kLMtclRlZslNBaVU2+t0wvnpiRZL0fJN7RXGOT7nky2YcyaQFHXbh1j6BmvneBOWa/Tsj+m6Zp0jeX25uVlclKGmQ6lkJ3ClGr2zdYDXsenivQsUbWZUe0gMW78U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=f4BVn0Fe; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="f4BVn0Fe"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id CC478207B0;
	Mon, 27 Jul 2026 09:29:52 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tKBxNj8zWtP5; Mon, 27 Jul 2026 09:29:50 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id B3C17201E4;
	Mon, 27 Jul 2026 09:29:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com B3C17201E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1785137390;
	bh=HK0g0rNq9Pc/MMgZKsNtXwsxxw/yllhj/AUEjlDAVJE=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=f4BVn0FeXdHXVhvYQuXsfCaeh82lopYk3bFAULAhPJCUv0LpAnxhgqAsIk7rxdw8b
	 MK4rjTQwezuuDgSFV+9wEWdDV9G82noLOAnENFBT6O5J5y0vGqXGS9i8bRk76X+i4s
	 9JHhhkCZ4EmlokfSL7dHnEhAPJxnysisU8i0AKXWCGjcvzOmDTXQcYD4p33ZnjR0we
	 CfELoa6iUQITjCrOnZJhLSEzx1Vpbq7Lw0Vv6gTsk2gQYry52OjmFl+4gniJQMP3Ea
	 BTsy0PvDEtGx/a2z0NSCsbWNWJzlBd0ls0PslRiUcfRLil1VPx8KSBBynaLAiiHsP+
	 99GkXbz1yRDEQ==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 27 Jul
 2026 09:29:49 +0200
Received: (nullmailer pid 3823544 invoked by uid 1000);
	Mon, 27 Jul 2026 07:29:48 -0000
Date: Mon, 27 Jul 2026 09:29:48 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Ren Wei <enjou1224z@gmail.com>
CC: <netdev@vger.kernel.org>, <herbert@gondor.apana.org.au>,
	<davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<horms@kernel.org>, <eyal.birger@gmail.com>, <vega@nebusec.ai>,
	<xizh2024@lzu.edu.cn>
Subject: Re: [PATCH 1/1] xfrm: avoid lock inversion in nat keepalive work
Message-ID: <amcI7JjDyyxVVf0X@secunet.com>
References: <cover.1784645321.git.xizh2024@lzu.edu.cn>
 <b196f448f8f7e452e0f6d1d3d72ba57b5f25eba7.1784645321.git.xizh2024@lzu.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b196f448f8f7e452e0f6d1d3d72ba57b5f25eba7.1784645321.git.xizh2024@lzu.edu.cn>
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
 (10.32.0.171)

On Tue, Jul 21, 2026 at 11:25:42PM +0800, Ren Wei wrote:
> From: Zihan Xi <xizh2024@lzu.edu.cn>
> 
> nat_keepalive_work() walks the state table while xfrm_state_walk()
> holds net->xfrm.xfrm_state_lock. Its callback then acquires x->lock,
> which conflicts with the delete path taking the same locks in reverse
> order via xfrm_state_delete() and __xfrm_state_delete(). This creates
> an AB-BA deadlock that is reported by lockdep when a NAT keepalive
> worker races with SA deletion.
> 
> Fix this by splitting the keepalive walk into two phases. First,
> collect the candidate states while the walk holds xfrm_state_lock and
> take a reference on each state. Then, after the walk completes, process
> each collected state and acquire x->lock without nesting it under
> xfrm_state_lock.
> 
> Fixes: f531d13bdfe3 ("xfrm: support sending NAT keepalives in ESP in UDP states")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: Codex:gpt-5.4
> Signed-off-by: Zihan Xi <xizh2024@lzu.edu.cn>
> Signed-off-by: Ren Wei <enjou1224z@gmail.com>

Patch applied, thanks a lot!
