Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339B44E9C2B
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 12:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789734474; cv=none; b=r/CF3oZE75BmWWirDd5ZNhr9r7DDZAP4zOFw1DRnC890/g5mj3nmLH87WyhVc9bPfl+EaBX/IVMa9u8JH5pxt1I6Jo83/NMtomyBKTsE5gASoHyw2LWjEVgjdQ86bXfesCsCkdZMSScUhBJ/MXobCQSGszoD43cvCqXgcZLyfQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789734474; c=relaxed/simple;
	bh=rPmI3FNZkhe+GHeaM7hnQAaJHP2GLzCXFHO62JGnIJc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EWNDxWwqG6AiZj8gO/zvyMEAcuz/bd0ZPtvp2Pf9mcYlwjN8zuPzBa6mLISoW9r3R+3U4h0EE1OE5lmh4UCRciAvf6cnWxpr7mIF2iBzU68HoCX3dQvuLlY49r+D+9GmMXViFRgfQNOyPQ4XJOtwHRwRXpBL4R/yo5O+R23Vkr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KYiqXQ4A; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYiqXQ4A"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-48434392b02so489437f8f.3
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 05:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789734469; x=1790339269; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gvjMDdsg/k5nMEjyepG3LV70ieB2SKZbmKFwt4EpOis=;
        b=KYiqXQ4A1EqCwD9JcPNF7k4Zs/0c2rp7vnnqEnV8aEPoUdzBDVDRXN7UeU4tEZ4rbb
         7t7xcIL1LJChf4R+0NP5RN77iJTNhRRG0seXsD1RzqUEh/9StjhVcA2mmJ+kEVpvg6mL
         TXG9YbaOBReuZBTwOkf7r5aYM/6FsGmoVtQi7BxvoGxtojk4jP0NUlMOrGzO9lx+6egI
         y1rfx0TofXqLMF2s51YJGxcvXOGfGcxoaO33mXXgmj38UU4sI65gCJNvIB3gJvIfM9e3
         lg2tzfJceXp3bjupqlvwlPKEy23K2smUZ1NVW6RvzQH1xBCWiLNXj77rK3Vr/7hhcLIA
         CtwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789734469; x=1790339269;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gvjMDdsg/k5nMEjyepG3LV70ieB2SKZbmKFwt4EpOis=;
        b=e5kLZNkXJWxxmbakw839RE8P98/EbdB31F54zesqEs2JgpoqzYMTiXyNMKhMGobsn/
         JQAbiProwmQzh/q6Rj3TPeroAd9MBRIcbvaYj4aITB5iwlNzvyZpPxDmsCgFHG02LmYy
         ph+lJ8PtKzFNi2wNFgg+NCGt2pI8uBhWyZdOi0X0/Okbyw0BPzQoXNDvLnD33vkl6jRy
         OvwDmnTfWdA86su4buKmSsXTjo5bd3wknD5FqUvWQ09sPpDw19qjw8usmY6M/mto3A5f
         tY03uoVz256ohn29XknlQuZuEP6OZFd6i+G14uoN7eGdwMh2UIip20oeMwysp4GdxiGY
         nmgA==
X-Forwarded-Encrypted: i=1; AKwUvByKVhDTLIwXwObmLlWcZJ1lz18gT6vz5ZHAT9nqh0TgCxlejezVyCcH4oGHFAnh4sNPQewtI5U=@vger.kernel.org
X-Gm-Message-State: AFuF++mNh/WDtWZ0rSSj9zK4wZ97sE6SqKaf/BebPcvSfMzaSkIS+PPI
	4yS94T2htjdoioIxlQ8QTkF8bOl7rFBfHNGU4TgEXb2/r3V5do6EVhxBllLvkzOA
X-Gm-Gg: AYBFou1TPnI0sedqz8FdVixxQQTVdKFQqDtF8T4bLAEcWsLSGZlCYamQJ0iwKaTNoeA
	8dhliB7RVThQ5y2E8F1xQAjqYmv2+ZVqPhWbmo6JApLXN0igcJPJXQIWk9gDdwhfNrH3ChqOwj2
	4fYT9P5ZIQsp0GnxU+F1Ww14hJHXCEZODIfS1F15lhwr4NwKYIiAo9JIIZ69gW6R/4cXS3+njSo
	nulBfnj5esV6uD9w0AqbnnCIhoUrkdqgfmvZkYX/9m9jd4JFuJV2L6CiLMX/0y9Z8hXAMDJK2dA
	RcfNDLqRbidayim3HWOYQdV/brTCJQEyM2NHhoaU8OLGieUnhCQe9GjPSKiFEPT7rWXNS0UW8S9
	eY98O7t2TZBvcVoYUk3Y/7pyGBtz6wBHLCJAp0AD+Xlvckiii3Htdgy/72viVaPbfqzmZFiOkBc
	88C7LqiIdGkIym1G5EiCI268vFuG6NgMbtVhFGjiNSj+EM/tDEvDpvLlvJSiLusObwJERar/PrB
	6ZrYGmix3VFvoQ96ICj5JUYExGeO8UlR6wh5fzBMAXWm9k=
X-Received: by 2002:a05:6000:990:b0:485:ad55:208d with SMTP id ffacd0b85a97d-4871e263f69mr7176550f8f.18.1789734469024;
        Fri, 18 Sep 2026 05:27:49 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4871feb5636sm4043259f8f.5.2026.09.18.05.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 05:27:48 -0700 (PDT)
Date: Fri, 18 Sep 2026 13:27:47 +0100
From: David Laight <david.laight.linux@gmail.com>
To: quanyeyang <quanyeyang@proton.me>
Cc: Quanye Yang via B4 Relay <devnull+quanyeyang.proton.me@kernel.org>, Eric
 Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, "Matthieu Baerts
 (NGI0)" <matttbe@kernel.org>, Geliang Tang <geliang@kernel.org>, Mat
 Martineau <martineau@kernel.org>, Jiayuan Chen <jiayuan.chen@linux.dev>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 1/2] tcp: annotate lockless access to
 sk->sk_err
Message-ID: <20260918132747.6ac8beeb@pumpkin>
In-Reply-To: <zEvCcu9s6PbTRajtbCvCik2zCOJsXozLWWvYsLfl6AV4IJLyXmS63i5nuaCmqk_5DsRajMO3IjRtFpOSpmRY55ByjpBJ8NmtwDk-kSpr9bM=@proton.me>
References: <20260917-mptcp-sk-err-net-v4-0-1f04f52f2561@proton.me>
	<20260917-mptcp-sk-err-net-v4-1-1f04f52f2561@proton.me>
	<20260918105142.3dc675eb@pumpkin>
	<zEvCcu9s6PbTRajtbCvCik2zCOJsXozLWWvYsLfl6AV4IJLyXmS63i5nuaCmqk_5DsRajMO3IjRtFpOSpmRY55ByjpBJ8NmtwDk-kSpr9bM=@proton.me>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Sep 2026 10:33:04 +0000
quanyeyang <quanyeyang@proton.me> wrote:

> On Friday, September 18th, 2026 at AM 2:51, David Laight <david.laight.linux@gmail.com> wrote:
> 
> > Don't they need annotating with data_race() ?  
> 
> I think READ_ONCE() is the intended marker here.

If the race is with locked accesses I think you need both.

David

> 
> These loads are part of the I/O control flow (stop send/recv/splice),
> not diagnostic or heuristic reads. data_race() would silence KCSAN
> but would not restrict compiler optimizations, so the load could still
> be torn, fused or reissued. READ_ONCE() is a single-copy atomic load
> and pairs with the existing WRITE_ONCE()/xchg() updates of sk_err,
> same as tcp_poll() after e13ec3da05d1.
> 
> sock_error() uses data_race() only on the fast-path "is it zero?"
> check, which is then validated by xchg(). That pattern does not
> apply to these peeks.
> 
> Quanye
> 

