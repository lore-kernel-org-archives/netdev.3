Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794337990;
	b=FF8GuZHxwFd3nGtgHHxqL4NQjsDnxVF+K/2mnvcglLNE1cfGyPRY/fI5IF2r22cK2qiZ
	 ccBOI5jnqzilAMU6nvunMasrmKM8ite+hAmxlrUbXR1orpf8OKqmn74c8adRKr/eRJZzM
	 45XBG/j+sHXa7imGzygg5OquhnwL4gDXjuZaU8o3Ck86maZ1DOeWuDh4ZFUiFpoGjx1/t
	 SxBaekpKybyHONDxl2g6IG7bb4enRHRNieLJp9ClEOB32NOt0MXdbkk8dH5t2KoOYttxA
	 XZ0AtUnaoS7bp9Rhy8tNnRIWDta7Gm+X1I1qsx6tR4orbAPbONsVpRnusLtnfL+AM/Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794337990;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=PPN74zPjILSGxCCS7SxXfoIlLPHZ7cwWQduhoo8Th80=;
	b=4xcia8mYIQ0qG2JM5LeTeu/dtzmk+8B8/fwkP4kPUhRFMEs72EJzZQTU0Clz0peUPxa2
	 JmxhBW54KXymXMrb767J596SyWGq5HfHBpqXwVud8WHzKZPzaAI3wm88KodBAkVrk8bik
	 SnpjQUxICHFJb5WOUnALq4r0J8bqcAFLjMwo/zMVZgUtk1mGgPHokxWRQtCqfiwvurYpx
	 FAxKUooie43Tswhuo7UQPSUu14dYm/xQ5HnOu6FtXQUf/DrSltmT/ZGyYRRlgXHFL9EaV
	 lYQpEpu0FEOIMxtdHElqyShLjVz6IB9FnNd7k7JwLJLYV2m3Si58RvHfOwpXMPQRreQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=IQpavx3W;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662D3606A320
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 19:13:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 662D3606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=IQpavx3W
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-15ea896ddc8so3844138c88.0
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 11:13:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794337989; cv=none;
        d=google.com; s=arc-20260327;
        b=XATgs4Ehna9XThrIlT0Ngv9Dx62tZyJqU61cAYspqoX+U5hJin1NKDkCkubLh/aLds
         bhtiYHTtmoLhpXZvdTXEBi22mzUxr6+ieseKrKnwUbhGR9KxUIk2m8TJYsVU5/VnJiSo
         UxEtEDBwhlz0YYWLVZTfoPgQMHD9VigtCVLZuAyz64p/1AWnB6BTS4bx+hNIJfpBU3ym
         e6Jsy+c6fIlOF6GYjVHb1fk9d0rFET8Px7XA22CS1o4rxlta/ZKoEBTfoHGoLSjdvyOh
         YEW1nG8pR5KCJrY7jgq/10jt/im+dS2teFePF0smIaLN9pyBg8AVB8vSe6I8G0hYvOqq
         Hv0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PPN74zPjILSGxCCS7SxXfoIlLPHZ7cwWQduhoo8Th80=;
        fh=5dcv0N8dMQwN7ksls3f/VHNN5CsREU0xRxb+5+Nu3tU=;
        b=VKjsCrlPaBP6klbF2GVOvP/WOgCt2eVJudrLarOfohyvmz9WGlAX4d6IiD6WAityqg
         n0byB6DYe/MA7sORPRr6BgcNAs+Q7/tQg4gvvnx2OL5nFmV+o598SZ6/WtUb6lS6XJsb
         V69sv+jU25OGsk6rNqYZp+S8mwl2pV4pD3+FIYH2S8fVhgi46iz1A9maTI75vtmJqa/n
         6mCPknc2d/gtHmT97exvIc6AXgDLB6StYZTkZlWC4PydMoykOcjaUv6kLcB91XPh83He
         0JadqHXBC4/rk5m5jZ4DBN+bde1sXBRgtERxZDyLqcPUR5rYyqsu3kMEg9PJuus06Ibw
         zRtw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794337989; x=1794942789; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PPN74zPjILSGxCCS7SxXfoIlLPHZ7cwWQduhoo8Th80=;
        b=IQpavx3WtB1frl+XrjSgPqwXlFYHBqTHI5qEDrl8A/qyax/KQ413JdkhX8jMH6IfT4
         spxR6wEOBX7eiwA4BfPMRL7ubHemEAK9ZQTBfq/WiTCoxJLuEJdZizoY5R92Wawt1p59
         jGIaO0ITTKN3nkBYvXe1MkpBiF9oA5vCeX8qTGZ2lsimzdRbbMoaWzmkwqGEGbUQeQqn
         bSnJxCBYsJZn2nNgk1D+ckxaeKwEJOGCnh2/NcwmQZ+AWih1k88stHL3tBXraxoC0GB1
         f2a3cb/X75+i/isn0Wb+VFajYZ4XMlOZJmu7od3c1KSv00tJEBrMxNx+BxVnXOOAgAC6
         xu4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794337989; x=1794942789;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PPN74zPjILSGxCCS7SxXfoIlLPHZ7cwWQduhoo8Th80=;
        b=bHgH0jX0lMAWnz3GPUhUUsFytnUSzStssvPxXj3498ugXw1pCotbzeRToDPRgXWdzB
         aXoQPwGBJfSSwxIfFhY3wxGBTrscod6QkpAhtZyg/OW0CQZjUHnqrfUaUPtx/K5sWuD2
         jVcfX8i/zdsJcxuQqtfvZdRRy3Up7XujJqa1EanFAPJDAM16jZwtdoprzeE9kfN+Gp59
         LwC7uk2R8gOOkx4Ynn9i+hEJyRYSCAfgpxm2OW0474OyQJy/9AqXdQ7JYCJdALthmAJQ
         PRLZ2L0u+XUJ1osT8JRhpsekYCktA2s4XrQs4lMlSKsh57MF5dS2Wz1KzK+zwHJLJC+c
         70bA==
X-Forwarded-Encrypted: i=1; AL+hErGmG/x8NiBLiTOUjnnlBcqe3nSe8ljd2TMtAjP1dwengX3sl+z0dvmpwNHJRXhx/7yu26p6ZgU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+6RRuGvQUf0zxD1ISy8s9f4oKGGaTR6fpxEbn+DFnkoHJBvLTg
	GO3+LNgPkcnw2ZbyrB7MSN9sGHWMPHISKE84EL0OkGVHRlCBN6aX1od7Psb76Mm3VRqmvUuNI/g
	9ZhL6Jh7E3es597c5DwJUQD31zTgPa4yWoKMsRXYG
X-Gm-Gg: AYBFou0glVWwC8GxY+EkuGMKnDVhfVCITtYcz1QbM4iP271IEayglWnCRtZj4IpNUv3
	MLiKg+g5O82UgbprsYxWf1ETsxGFCv/ob9dcFYfPWTv2kfGjYgSO06uvlUlO4h9eZPNe3QALF3e
	eEBGLKVK8P3jFJM3B4Decur3mYvFZmK9XGzcs3bbVzMIwMEI9vRZOxXbkB1gMtGst2dMsUiYrGo
	Jmc1+hUmNeceZ3VMZcmHamVqc+F8rpJwCk0CxVustmU6XYMIGl7McnUvpg5aXKhqo1L6rBseC+l
	SMw+XlT41RADNCWYZmd+PaOSTh1y1mIAwaqHyXfKKxJtzqbLXSGlECqd8AZIeUiWbuYc0r/XS2C
	l9g0YOW+g1i2X39/YUeLAmL8127X+eEPVMsD5ImU5jsB18d5ZWMi4iBHZzlucYu6F/7MzLy18Oz
	lVNlqj+MwX+R2bE2nN/TItEeQIvtkmPnjU1OUbjQbxez6z8T8O/zZ30sDA6Z0RYwjOi/1+qDmrF
	izvjyY=
X-Received: by 2002:a05:701b:4554:20b0:1b2:490b:6fdd with SMTP id
 a92af1059eb24-1b3b6025d60mr4753015c88.24.1794337987292; Tue, 10 Nov 2026
 11:13:07 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261107235720.3129212-1-kuniyu@google.com> <20261107235720.3129212-2-kuniyu@google.com>
 <8362f907-4e8e-4514-bff6-f0bf8fd22f57@kernel.org>
In-Reply-To: <8362f907-4e8e-4514-bff6-f0bf8fd22f57@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 10 Nov 2026 11:12:54 -0800
X-Gm-Features: AclHuK8hHWrMUQ4RzO-7riZzbKnrtfCtmxW-I90j8tuK1vPNNHgQOuOjbQZxh-0
Message-ID: <CAAVpQUDSecbKNPnw7FT=jtSq5Py-bXKyLv=OxVStdOt0uGQb7w@mail.gmail.com>
Subject: Re: [PATCH v1 net 1/3] tcp: Clear DEFER_CONNECT before tcp_connect()
 and in tcp_abort().
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Yuchung Cheng <ycheng@google.com>, Wei Wang <weiwan@google.com>, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 10:46=E2=80=AFAM Matthieu Baerts <matttbe@kernel.or=
g> wrote:
>
> Hi Kuniyuki,
>
> On 08/11/2026 00:56, Kuniyuki Iwashima wrote:
> > When TFO is enabled, tcp_v[46]_connect() sets sk->sk_state to
> > TCP_SYN_SENT and puts the socket into ehash without calling
> > tcp_connect().
> >
> > Then, tcp_fastopen_defer_connect() sets DEFER_CONNECT, and
> > the first write()/sendmsg() will call tcp_connect() and send
> > SYN with data if possible.
> >
> > If tcp_abort() kills a socket before the first write()/sendmsg(),
> > the unhashed socket can still call it and send SYN in TCP_CLOSE.
> >
> > Also, DEFER_CONNECT is cleared after __inet_stream_connect().
> >
> > So, blocking write()/sendmsg() can release lock_sock() in
> > inet_wait_for_connect() while DEFER_CONNECT is set, and
> > tcp_poll() could set EPOLLOUT even after SYN is sent.
> >
> > Let's clear DEFER_CONNECT in tcp_abort() and right before
> > tcp_connect() in tcp_sendmsg_fastopen().
>
> Thank you for the fix!
>
> It looks like we can still have the race with MPTCP:
>
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261107235720.312921=
2-1-kuniyu%40google.com
>
> But that's not blocking this series here, so for the MPTCP part:
>
> Acked-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Thanks Matt !

>
>
> Just to avoid a deadlock, are you planning to fix the issue on MPTCP
> side as well? If not, I can look at that later on when I can.

I would appreciate it if you could look into it.

>
> (Perhaps by checking if the msk and ssk's DEFER_CONNECT flag is no
> longer aligned in mptcp_sendmsg_fastopen(), under the ssk lock? If not,
> clear the msk one, report the error, release the lock and return? BTW,
> it looks like we also forgot to clear the DEFER_CONNECT flag in
> mptcp_disconnect() as well...)

Sounds good.

Thanks !
