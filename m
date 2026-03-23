Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D3A29BDBB
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 22:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774306091; cv=none; b=usXw7VxccbPCMOrqPCfKsNPu1/TJJ6tVpp4AJbzeZKszJEL9ABgM8CV/0AxKj6eDQMTSJxCl/9eIHHOuS6W7+9kSoIlW4xGrqS3/FDstWz1SxlQt9Y0MVuxiEmLRz+n4GYoWAcW0bXVxAbIME38/IQ2C2DbmPHXUAypi5rV/o/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774306091; c=relaxed/simple;
	bh=RLO6AJNyX9XJAF0DBbn/Uhcvy5YavrF7k5CQc+hxjUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fFHzxlIo5eF+41ocbRgkb8r8ilWoXsoTPZGyxg9u/lVTTEVNkMqnxhPEIIw/rcWggvTdH6BTrQpYtQMcw4LcVrEZk/5JrN22WKnmhRaS9LO6NYaNdo2zGWy/i0SNeqFgFkd43wR6XYu3FOWd2EgS1YWZMpTAY5bSbUseVUSfCBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=vBqhYo/+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vN9zCqiM; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="vBqhYo/+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vN9zCqiM"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 5991FEC01AD;
	Mon, 23 Mar 2026 18:48:07 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 23 Mar 2026 18:48:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1774306087; x=
	1774392487; bh=2yCnX6k580YaFLlM7722Ft5nCmkBkVP/WzIu2z0gYWs=; b=v
	BqhYo/+0aQgvb3d+U9Ofn/o1NMRn5qcOEZpF9FN2UmlYRrei1O7aQwaXEo+GQY1y
	IQmPOPb7BmZnVt4YScDKALH9J1GrDp2hELauWtjvUr56SPBcDa3878KE3JZTEjUG
	4anvnrAVybe095RlJtsul6NDFn4FHx0kxmLY0tHSltMT0nil/pSn24bQpwzQuCo4
	N9bvjNmSU/3HiyOybtAbyja87LWNbx9o0uBqDzObGdPYCB+ZuaWIbir4IIuX5LTz
	AhN3cTjab6nZa1eGJYqpUeOYe2w2Pov474QouxBtFBn8DdrzIcVglsw7kMQ/fW+v
	gCRZ7SNhZSNIEWKkxau0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774306087; x=1774392487; bh=2yCnX6k580YaFLlM7722Ft5nCmkBkVP/WzI
	u2z0gYWs=; b=vN9zCqiMGxRmr0WXy7NjhkwfMAdJ7fQsuH6UCyBhKCgfUKJyGTs
	v0SDGcgWQzFXmLyDk02Tevl2ZhB5eV0ozZNVldgTnukrNEZKRTlAwp63lZ3ZVr73
	291pPx7pkgixkoAOPKF72rTYsoiw5VvC7ctYAauktvhIxloaDjqLcW8pJZS6ftle
	INAMDJWmjPWI1H1lsSZS2s1J0AbUvmq/smmhxQWKQbEj6DR24YmBXeIp85yXwlV1
	R/hD+jcu2G38UgD7krVX/2mgbq1LYv8MVFWmIfmeOhpUaDH1QZGVsdstcQ6kUOSP
	fxXg5D3Rt0ctr/PmNYnrsQCDDpVwVaelT6w==
X-ME-Sender: <xms:J8PBabn_Fsd-yQHRnAJU9X1KoCcndmXU6Fss97H0Ge_Va4rkBv_zkA>
    <xme:J8PBafiFxiluk2RbvqtYmuVaD5d2Bqwaj1nak0ib9RWf15cItyX7DBeqJWVPTI-2K
    _i_84uNfexpHETT5Ek5ljyXWG2_CAmqrOF_hh_nQHdY6FOW_hF9_qY>
X-ME-Received: <xmr:J8PBaf2uOP4S7o4rjoaquD-lElHVeSRz7Q2K1IyH1e9jHVlWgbY_HnfwXQYO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudelleehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeejpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegtvghlsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehjohhhnhdrfhgrshhtrggsvghnugesghhmrghilhdrtghomhdprhgtphhtthho
    pehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvrhhnvghlqdhtlhhsqdhhrghnughs
    hhgrkhgvsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheptghhuhgtkhdrlh
    gvvhgvrhesohhrrggtlhgvrdgtohhmpdhrtghpthhtohephhgrrhgvsehsuhhsvgdruggv
X-ME-Proxy: <xmx:J8PBaYIv4zQDRQvK7BhyOZdY_fRQF0J4rfeYfAt5RKPcGZhrKXm6OA>
    <xmx:J8PBafxhHJ1Oin78Xh52CfMUBBiimBCaQi1akr-MrWFrGV0LiQ_khA>
    <xmx:J8PBaWUb188BmZjoS75Fsf5ZAAPpna8br6buHBXptgNRncnNtKDgmg>
    <xmx:J8PBafgl3CvCOmkqRWLhuNuOBZtwRlOydmLF2uTJkbCOhYa1Z2NlCA>
    <xmx:J8PBaev7Sb85V-FVyHd8nvVrR8B9sVuTDyKDfUG8wDXentAEiR5qzVzR>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Mar 2026 18:48:06 -0400 (EDT)
Date: Mon, 23 Mar 2026 23:48:04 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Chuck Lever <cel@kernel.org>
Cc: john.fastabend@gmail.com, Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH PATCH net-next v4 8/8] tls: Enable batch async decryption
 in read_sock
Message-ID: <acHDJNNqZlFIm84n@krikkit>
References: <20260317-tls-read-sock-v4-0-ab1086ec600f@oracle.com>
 <20260317-tls-read-sock-v4-8-ab1086ec600f@oracle.com>
 <0cf288bb-6ab1-4f2b-8a7f-727b3e1fe0d2@app.fastmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0cf288bb-6ab1-4f2b-8a7f-727b3e1fe0d2@app.fastmail.com>

2026-03-23, 17:28:27 -0400, Chuck Lever wrote:
> 
> On Tue, Mar 17, 2026, at 11:04 AM, Chuck Lever wrote:
> > From: Chuck Lever <chuck.lever@oracle.com>
> >
> > tls_sw_read_sock() decrypts one TLS record at a time, blocking until
> > each AEAD operation completes before proceeding. Hardware async
> > crypto engines depend on pipelining multiple operations to achieve
> > full throughput, and the one-at-a-time model prevents that. Kernel
> > consumers such as NVMe-TCP and NFSD (when using TLS) are therefore
> > unable to benefit from hardware offload.
> >
> > When ctx->async_capable is true, the submit phase now loops up to
> > TLS_READ_SOCK_BATCH (16) records.
> 
> It appears that async_capable is always false for TLSv1.3. Since
> TLSv1.3 is a hard requirement for both NVMe/TCP and RPC-with-TLS,
> patch 8/8 is moot for us. For the moment, I'm going to drop this
> one from the series.

Then 7/8 is also not useful, and the series boils down to a few small
improvements (tls_decrypt_async_drain, spurious wakeups, checking the
backlog), which are not limited to read_sock. [nothing wrong with
that, it's just a different focus from what you started with]

> Once Alistair's KeyUpdate work is merged, we can revisit.

Are you planning to add support for async crypto with TLS1.3?

-- 
Sabrina
