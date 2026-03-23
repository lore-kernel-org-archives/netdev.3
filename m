Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB79E38B148
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 10:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774261365; cv=none; b=ZxMaA0sPUDYHnNgf6fdFkunDXCLNigeDS/0XA7Sc/zRC9rx49mv7a22ApZ27glBqHmAyy9Yemmy/FL7jNeLg3+K7gl/oKacux0A8F3OtJAYsQ35+Emn7gfDdIgrYLbjXqbDna8iTM+PARV+6Hk9TGPWVecomQqShCLhk49yW8Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774261365; c=relaxed/simple;
	bh=la5DGGPJzyR6jojzIDY4joVy0vmlZ+YmTxOupVc3dsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n5rkDJmXSJ7HmIH8H8V7LpRfawMJ01+d+SAUq0g8I056WXW7MvsYVeVqO378bDQv/p5LdeYToD13aI/5lwm8OcYhoDtRpVYyVFeChPjXNpW0BtpenV0z1+KOs5XsXlMKywV2WfYEcOYi0oBAwl27CS9r+fdZllufC3YF9LVxSSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=h/yNidx0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T+1TZS4w; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="h/yNidx0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T+1TZS4w"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0E25914001A4;
	Mon, 23 Mar 2026 06:22:42 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 23 Mar 2026 06:22:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1774261362; x=
	1774347762; bh=i6YocFU04QKVw1yIX/HjHbhtSR1sKIOxx9lUma1rqNU=; b=h
	/yNidx0Jh0EKRJOY4uvNo0DDtavHt5BnDTNcvyc29/+5L3nDl4NsLEXD88oLBH30
	8/xiouJrDgtGsJldqKTyUfW/WFMoMNXEostLtgyz7/FyoNlTOd6dWuwJBrsl9wo8
	ZiQZaxLWY03FV6hsbSE598XfUsT/Hd7cwaHFq77CvJ3Oi6lznvaBLwc7MN/XROlM
	0RvjuO+4uLyczGtHc5SYkTz3V7MK/ulfVO0vye8HpRQxEWN1938kGdLtDQll6cu8
	0iCiUikHy8EKEEhb/E36hIjeThA4vDuRJehQcY79ikPYngcLz8L9Nh2opIsd7JYY
	bQAQifbKahBAw1jNf+jIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774261362; x=1774347762; bh=i6YocFU04QKVw1yIX/HjHbhtSR1sKIOxx9l
	Uma1rqNU=; b=T+1TZS4w1EZqBz7StnXTOOj2BM6siRU2nG2IjNZxxXyZgcKzUPc
	mOF7DXJB3o8K5XgRj4SSqjBSS/+17l3yuhkHBwrmbbgKK9OVIZdG14Xnb6ZgWF50
	ijUVyKUiP5ooNZlYGwKjALwbhKXnCQSsfMnOj3icvB2hw6jeICpUqWwkEwN9n3Iv
	Dx6fR7c+IthotNbdwZ5YoPYf9/vw4SnJvCRQ+HON0g32mtP54e3ndl8ImHTykS9y
	KN0F7aYQvGCEulNYBoXslIyxqrd0bgPfE9DM3HgDshqZFduHA6LDcrDd1Z/0xBBV
	6g0VhHRkvfXzugugfJK8PzzLYg1Zq3dM5+w==
X-ME-Sender: <xms:cRTBab0ZH4ADpmjskLOQ71C64qp2IdEDGTg0LliGJiTHjntXuU1W5A>
    <xme:cRTBad6XTmZAOlF5P1f-cCP58FvVf4jtg-5IffjBeLHDN7pNA7jnXXDMtKXE-uknw
    a0RVI-0ljZ59ErD4DuiH1Aniupwh19xMG8K5PqKuPf7zFSMLQ0N1w>
X-ME-Received: <xmr:cRTBaU993QKhohsxwl5sZ679Wh5iaS-dPYYsYSf_ur5csx-t7jy7jHogGUC_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudekgeeiucetufdoteggodetrf
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
X-ME-Proxy: <xmx:cRTBaUWwkbEWZVJFaZWojayBIDz4AfUtX2NmXej8WJxHs17hSzgKkA>
    <xmx:cRTBaXoGa2MljxC6b6Xff6EPRZaDg-9xjJjJVWmJc565X5EnmjJGRQ>
    <xmx:cRTBaekbaNT-FlLr8k1TJ1eDrNNsu1fZBK46rfftZWndgykJC0pcRw>
    <xmx:cRTBaf1VHDdbdkJNXGRhDdzLfnMZDXuvUBakwDWgYHASnlIVdeeNzw>
    <xmx:chTBaYifhWvPKl7NuOhss9eT5jw-fR-aKDt0KaWMhMrbS4L_lWdnqJCw>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Mar 2026 06:22:41 -0400 (EDT)
Date: Mon, 23 Mar 2026 11:22:39 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Chuck Lever <cel@kernel.org>
Cc: john.fastabend@gmail.com, kuba@kernel.org, netdev@vger.kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH PATCH net-next v4 2/8] tls: Abort the connection on
 decrypt failure
Message-ID: <acEUb-oGmTBJKa9H@krikkit>
References: <20260317-tls-read-sock-v4-0-ab1086ec600f@oracle.com>
 <20260317-tls-read-sock-v4-2-ab1086ec600f@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260317-tls-read-sock-v4-2-ab1086ec600f@oracle.com>

2026-03-17, 11:04:15 -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> recvmsg, read_sock, and splice_read each open-code a
> tls_err_abort() call after tls_rx_one_record() fails.
> Move the abort into tls_rx_one_record() so each receive
> path shares a single decrypt-and-abort sequence.
> 
> Suggested-by: Sabrina Dubroca <sd@queasysnail.net>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  net/tls/tls_sw.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

This introduces a minor change in the unexpected case
tls_check_pending_rekey() fails (because we won't call tls_err_abort
anymore in this case), but I think that's ok.

-- 
Sabrina
