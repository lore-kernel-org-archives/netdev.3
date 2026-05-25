Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1DD1CFBA
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 18:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779735291; cv=none; b=EugAdbU7BeqGD+Nk61etwG4cjGbCli1UvcM1yqUJOcA6XcXj9qq159gmBcxQYFX9i7qrDs2GLmujq3wSIieL5FfZnsv+wOwcd3kd/oMIltgH8sPHpw1UpATyIOI90PiIHy5GCB/zReru9Fx+Pxe+MK+2DDTzqcxUl2AmUTfKYJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779735291; c=relaxed/simple;
	bh=qympUoKCf4LY88i1j6GeJZoqBt5OSOf9WF5fk6eD6DM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=usn3vIzkX/e8q7Q4aQxrfnS/8iHTHQOaBsgOGz5kmIl5FckIOIweA9QGzpZuObDVbfTfwLwbJ2xalk76eGi3YKY1vP6t56Tpl9/blYYJxC7X82vraRuEUUg4lx+pkTCg88+yuuXe2GKEiIVNZ49cFkY2iFsFqPTw9xXBFIdNVNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YwsSWIY+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YwsSWIY+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF471F000E9;
	Mon, 25 May 2026 18:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779735290;
	bh=Un2oLbMrJHdtxudviEDA4FalCRzHh/t7BsxGNhEFHz8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YwsSWIY+gwexelodHIDErA6VKCT3q8al52tID9xL944ez/tYvRFGqjpfas09tNVJ7
	 /0AUP20beXi8sTL9D8hHLHdXy2iRqjIjHvHRib1liVraVP3vsq8/wORAGkimyonZxb
	 +H8mLwLyftP75F1RyK1HENLqspL5Wa9wIeQ9sCygeV8D/6stCaHLW+7tGB/GXNbPGz
	 5OO1lTGqf+xXO2e5/KurRTXkfjlpsjBAXvTgLJYa+bs5UzrvYyXDaG1094iWj9aBmY
	 vPn4VCHcO5wm1ML3I09QQjJwGxAKKZxUu9OrqRKxqbkbl0aaUzjFKG12s5CwVbVveX
	 OqVYvohfA01Og==
Date: Mon, 25 May 2026 11:54:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, "David S . Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Willem de Bruijn <willemb@google.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, Damiano Melotti
 <melotti@google.com>
Subject: Re: [PATCH net] tunnels: do not assume transport header in
 iptunnel_pmtud_check_icmp()
Message-ID: <20260525115449.4e0895ba@kernel.org>
In-Reply-To: <CANn89i+h3d=SoK4S3iUFvQ8fb=iBbBTX+yoM-Ey6ya+BnsAJTA@mail.gmail.com>
References: <20260522115512.1519110-1-edumazet@google.com>
	<CAAVpQUA=kJ-Ne0zDniRehpebv51MuBnvKcAL5DpT2ofk8Ad12A@mail.gmail.com>
	<20260525112011.38a93f49@kernel.org>
	<CANn89i+h3d=SoK4S3iUFvQ8fb=iBbBTX+yoM-Ey6ya+BnsAJTA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 May 2026 11:41:59 -0700 Eric Dumazet wrote:
> > Are we okay with what sashiko is reporting?
> > If it's legit it may be better to fix in one series  
> 
> Maybe, but iptunnel_pmtud_check_icmpv6() is also calling
> pskb_may_pull(), and always had.
> 
> Perhaps it is time for CONFIG_DEBUG_NET kernels to always reallocate
> skb->head at every pskb_may_pull() call, just to expose these bugs.

Ack, but callers may ensure pulling just the ip header is already safe
at this point vs pulling an extra L4 hdr.

> I fear that a series will never be complete, sashiko will keep finding issues.
> 
> I can try a V2, but will probably give up soon.

Thanks, let's try v2. If it turns into a rabbit hole we can just apply
v1, LMK.
