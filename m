Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817161;
	b=kEYyBp0VUqxuUJPU7Riu4dWiSUMstBHOr6O3wciSqjj/2jepEXTJCpEqyyrvT65CU7Jh
	 OZ2JhlA8OsFrK0eBTSM+MA6kBFqTaiBntWhkZ9w8oe8z+ZjqiaKWZLFWrkR7+V4lYzUyG
	 LbMd2gJhc3x+m7Uf/1B3LiWfUPbuUEamUakAzFgt7bKCi9FI7L9h97FhwKUZQO4Q8aJ5F
	 EJHGzuMwfB6YepkTyAGiavHEbdohp3ozU8QS4CoxMMczBayluTmALikeb9sNCIZx9bW6k
	 d2r3dC8czmHa1AXddQ77GYGaE/HeX9q/tSOpr2D+7j1d1zcZjPxMrJCpRXg7Z3KumCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817161;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=bgGvwwQ0hp1A5Cajh6ZjxfCDvcyK9tWxZx+AIP+8L3A=;
	b=LUBXRQQwDyO2M8s/TagMJclZev2LaeyrBhQ3RnDDgpaYDQF5NqvndnLWt2kSWRLf9IfN
	 x4nzmhfAj56/tAYn6tlZJpBTZzDBiMJStn6Mvp+YsLqO9sdTDnGwT++Ehru2LJ//7xnSt
	 ywhtTJdmJLH1IsKIz0gCLoDHLGNw+8L0/E4h9SGBOj44tKzWjmQl0Qt+2FtKbfAAFrC83
	 HqCLYeI/MzMnDdq6Pk3BxAO1wZTajA1mNHhzwqjkZgONKpRE2Cts8wU8kb/6Su8SIxJAN
	 T7xbWXUZrjMu+qeKo1NNPAFXDhDvTrK1AJhLiSRuF7z7d2521LmiyH7ano05dHpE+MA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WnhNglyv;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF37606A328
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 18:32:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7EF37606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WnhNglyv
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3ae6b4c669fso1388323a91.0
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 10:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793817161; x=1794421961; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bgGvwwQ0hp1A5Cajh6ZjxfCDvcyK9tWxZx+AIP+8L3A=;
        b=WnhNglyvCBh7ZPhaI+5vGqQkRigBp6TtgG0deUYHZNLf5FfinhmiZlHNByAGYNI4SL
         iSmUomw8vSyjos/KvmTEAGXcIjs5ntqRuFyyj+SDPaP1aolY1XC5rpnAwltboXplmF+H
         npO6z20tFVzn719f2b9XBNGstbEQRzUzgPW46+Dsks0ffp36oCT9dlXJBTg/OBdPsrVi
         GNYZxZ3TbMimbcRV0fLQ8t6EMIgUb0I6KT4dp0PaW8ZUcUSIu2Wb+fcGOlDFOAa4NmGE
         /sOsDZA4Gw4LOrkEAAF/eXmFi8HbwyV59xDcNGJrES/3JiZfwhay4EOl/OoArRih0CKd
         3NWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817161; x=1794421961;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bgGvwwQ0hp1A5Cajh6ZjxfCDvcyK9tWxZx+AIP+8L3A=;
        b=CBvg9TDQ5swS818wf1+E0sN9dLNCa5MkatiBCIhmeOtXfOg+iD6aFGCRakK6yp4Pcd
         Z1w/w7Fzw3B6gPZS3HvNnt33tqD/iRhpOsjQUzKdey1foZKx8VLL1X4w324FCKRZNrdx
         XdQzY3/hbdxFGGM01F2jXhFhV7C5lygfsG9dH8yxc7dcSO2l5qX6Qh6SKqtWS5BoO9eA
         6Uqe+ywZbrFcNvSHKwnD4MXxnEFspSAhHkIb6DhDVci0NbuNQceA6kG6KF+yH0meIS1q
         Xy4qIarmuiE7j8lTKGQw1WhFt//Rs9kSiqvGeZFPoAenJ3V3NR6QP9AhDItNxeMfl+Oh
         J5Ig==
X-Forwarded-Encrypted: i=1; AKwUvBxom5bU56zCHOPks9EbPfeW4hXLqu1sI1sB0mL6urcbd5Tc6+jGr5lpjKsX9rhc8ZMjoVgVtcw=@vger.kernel.org
X-Gm-Message-State: APuU4Z80VgYNpBS8eOXLyb5K/7gn1qGrJyhYvCEmbUilInB8fZTu2iFb
	bwTL/3sV97vTl3oiT0/JzXy6jfN2hEomXfidhCBzw16L1vxRRxiZMWGY
X-Gm-Gg: AYBFou1xJeHX1bYq1XAmSlS4g8OWCwuSJ65jn1n8yR03F/1XY1sfzY9j/VuVUbX9Coj
	ox0lBBY5h3Mx4ZL5XBhT6x5EZ0RqA0pPB6NquxBk1JF1cohGt72CcJB3abT09FnK5wTWWJ9BKAP
	mOMA1/5Pe9LT+s4GVmve9WW6uxksUWm+tBRw7x2GwKmMTQH9KgcrrXpnWHh/rFhN0gcro92Tk6E
	CZ6+Imc3/42kWHrXVmRpqNwAJeFx0KjekgSKtnbeOEl1NjO8R4+0vnAgWd7bzD9IZkqTC4S5qw3
	mrwOLZJBEzv+tKgk8GQuS7H9Yb8eQWu8VUUalDDNSj9kv/Bk86XKu0J1Ja+tXzNobeYgt2reVHw
	rAtSnTv6GdNGy7LxP3DIs7GR391cp/ZSOG5DgYf7bNr4Sl+2mcY4Q3lcsy0Rmq1MBESgRoNJV7p
	5fR6CQDSeqODZ6186bvnY2/dUmXr5Lm7jr4n8ga0GWkMZMz+e0mEGIBKj/Ks4VQ5t3TFOAwHoaU
	ZSgnJKdpuPi3cObazp9UP1PryyA29gdRlo0M9D8xIz5MZq5Wn8iRUlG+Q78WaS6s3nv73/0hMT1
	5gOj5prVecBZ6mjeztmyIHQ7ZIk5Z8iZQ6sSPjIZqtLAVC06Qhywghz56OqjxtTnYNKAm7Dj6Bm
	zlMXdTEVY8jZNnR88H4NOaczyTWTNWLCt9w==
X-Received: by 2002:a17:90b:554c:b0:3b0:a1c6:95ae with SMTP id 98e67ed59e1d1-3b0afc77a41mr178745a91.31.1793817160656;
        Wed, 04 Nov 2026 10:32:40 -0800 (PST)
Received: from localhost ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b313c143sm154357a91.2.2026.11.04.10.32.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 10:32:39 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Nov 2026 18:32:39 +0000
Message-Id: <DMMN42GPUESV.YUIKSBF4E297@gmail.com>
Cc: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <daniel@iogearbox.net>,
 <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <john.fastabend@gmail.com>, <jakub@cloudflare.com>,
 <jiayuan.chen@linux.dev>, <davem@davemloft.net>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <horms@kernel.org>, <kuniyu@google.com>,
 <willemb@google.com>, <matttbe@kernel.org>, <mptcp@lists.linux.dev>,
 <mason@kernel.org>, <josef@toxicpanda.com>
Subject: Re: [PATCH bpf v2 08/15] net: Leave sk_stream_wait_memory() once
 the socket is dead
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Eric Dumazet" <edumazet@kernel.org>
In-Reply-To: <CAL4Wiiq+QX8quVBjEZK5qipki6Yt7vx4=tt2L4o+FwO9zD-5=g@mail.gmail.com>
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com> <20261102072112.4160195-9-alexei.starovoitov@gmail.com> <CAL4Wiiq+QX8quVBjEZK5qipki6Yt7vx4=tt2L4o+FwO9zD-5=g@mail.gmail.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, Nov 03, 2026 at 09:23 PM Eric Dumazet <edumazet@kernel.org> wrote:
> "A signal or SO_SNDTIMEO of the target ends it" does not look enough to
> me. tcp_sendmsg_locked() takes the timeout from sock_sndtimeo() of the
> target, a socket the sender does not own and cannot configure. With the
> default MAX_SCHEDULE_TIMEOUT, a blocking sendmsg() on the sender's own
> socket never returns, and the sender's sock_hold() pins the dead target
> until then.

Right. It's not enough.

> Since this patch makes SOCK_DEAD a reason to leave, one wakeup before
> sock_orphan(), while the socket is still owned by the closer, should be
> enough. The sender can only get the socket lock back after
> sock_orphan(), so it sees SOCK_DEAD. Nothing walks the wait queue after
> sock_orphan(), so skipping remove_wait_queue() stays safe.
>
> Something like this (untested). sk_wq can be NULL here for MPTCP
> subflows, hence skwq_has_sleeper():
>
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ void __tcp_close(struct sock *sk, long timeout)
>  adjudge_to_death:
>   state = sk->sk_state;
>   sock_hold(sk);
> + /* A sockmap egress redirect can sleep in sk_stream_wait_memory()
> + * without a reference on our file. Let it see SOCK_DEAD.
> + */
> + rcu_read_lock();
> + wq = rcu_dereference(sk->sk_wq);
> + if (skwq_has_sleeper(wq))
> + wake_up_interruptible_all(&wq->wait);
> + rcu_read_unlock();
>   sock_orphan(sk);
>
> This can be a follow-up and does not need to block the series.

Makes sense to me. Thx
It depends on the SOCK_DEAD test, so it goes on top of this series.
Will send it as a follow-up.
