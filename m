Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593B448C8CB
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 13:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791378698; cv=none; b=hdSHoTjKOutNPf2GTelsC8J9IcRMATJ0Y9U97aWwVQbK+otCyXfiJcBPXXOnPmH32sfder+Puiu+aZ9clm5k6ZTCspyY1ac4+KXIWeCl1eGdyxcm1pmDKPUdpqo3KmuiEjqDPUONMjrQT+WNvQ+gAaRVaK/JhIi9uxN2pQDJxqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791378698; c=relaxed/simple;
	bh=Xxs0uB5If2Ut9262mUBW3bNyhQPBrDPWuruAgxJj4Zs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LkpBZS7AEmFEd87MYaAwPAqrU2AdLRqFtkpuePfZ00ufrnFh6sqSd24aLkB21kIkv0pPq23pcBiN6NRyhcOWmlwvc/O6xZw+tDCyjESuaz3hop+9246CKhIXxU6oWFFlHl3488iTozGeE/EcboOmxQBuoN6oqSLdSppiQszM0sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=CtnP0ibk; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="CtnP0ibk"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3a7d9d9b67bso1335394a91.2
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 06:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1791378690; x=1791983490; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YUz7LBXRnF42JnciC/ACJGoLpBiYqavZK7urtzI1OeY=;
        b=CtnP0ibk0zNcB4Q1qu1YOjeAUsmRCtRBkfKdAYRplqcps/Ir6f/FnUUPUrd5E15CCO
         RBdj6HZL6zqTizWd4Ll4jqN9vOBaW34lPjJP7nSLjclPtHXGqcLcD04DWioVvhvQW7LM
         soD+j+5LnWMlR4DDv3gqKYE1bJFIbCd88NBFot4bWD9ldoc6CdjDhw5xv64NIk2ayD8h
         V7MPFLKTjiafQLCoVNoMr9/4irGGGMaS8WNJR99cc6qAlFOCEhv07BrlS9M8GAhJYtKr
         japnKhwS8jeAZm0owbghiPSYnezyDv4z9j6VGNsWyLr22TSFwJTkab7UdFWN6OkSrJVI
         94tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791378690; x=1791983490;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=YUz7LBXRnF42JnciC/ACJGoLpBiYqavZK7urtzI1OeY=;
        b=qdohszA0WjLe54qeB2xTHd2juzUlMt5+JUA3gQa8FloUp4YaCvX7QwNtJW/v66jgka
         RZeyUoAoxAMgrFKY4FdjG3rJvqkcl2SuPxl22BIVcSZGRkjyqshztxVZaROioWVKh812
         zoQK+pb1J/oCEo3KkVLPcak8v9hS1pYUnCr8zIwAR8fHHGwOqYOjkp3HJg1Z9FOQuCnC
         D2fL7kq6Y+ADAhT/TuNX5vAF21Fx32f1ymS2K5tqq/XhdPZB3WyjqIFao9Epj9HtB/JW
         P4pF8LPlzpkgTyLlQRiNmhk0FSJtGDj9TYKzYM6JHAu0gIgeQADS7g4TWRElOJ4c3j/j
         6q6Q==
X-Forwarded-Encrypted: i=1; AKwUvBwq3EdgtD9sF353wDrG64Q6/L5ujTs6tLzuonL0l6l/YbJgBygJBmltIxoK2Se1+/+cw/lxUos=@vger.kernel.org
X-Gm-Message-State: AFq9FYInIceKoaAQUy20rJi9eIn6xBFBJdt7hkkb0VKdu0WQgF/BByza
	AgpLd7D1AWv5WH41V4eN2JfQNJCRIVND83/WzDHgiopgPeTz2oeyvrzyqnTt66CJi6c=
X-Gm-Gg: AYBFou3lvWKWpDcxtFG91s3mvpsPi5gjhsTJ1ZIbxX8JDyvqb3VaDoetBkE3a4ldwa0
	gNU/bUQKA3XNgsllG5zc0LQyq85UdmT5WZg3YIeUkCg+MMVVQbR1b+jilPrnnEkAw31eNbElinm
	BN/p69BMUADZAwNg2hfQYVJHYYXTCXXoI7oxzvMFxPPsUA0tjTuRjfxM+zK7c7Nent16brjp0CS
	DC52tnafLbs8Zkj0pqRUr98j8/TBLUCggBLtA3mDZmBKfWCxU6jKRAoZ4NcTL6ONbGVgIysTw+9
	7oRvvgZFMGR/TiO3A0tZn2vf7s1+uPWJENsFnSIccyq/OFuHHuJ2C+WbvkRglo6emOAGnKYPVCl
	RsLf/iNKvEgfdaIHnWcT2k8XdI8RrSxgWYVki7m8BHE5Nu0sayUOt13w7Y1wk9fvE6tFFI9M4ZS
	7MkHTCcfESFzGLluPfLZfQs7lmYBlvS7Yac739ixPogYe1DbORoKEbZUWMF5JCzr/fEGCEA3Nmx
	Q==
X-Received: by 2002:a17:90b:3908:b0:3a8:1a1a:7895 with SMTP id 98e67ed59e1d1-3a8a0b8b75dmr1575608a91.18.1791378690497;
        Wed, 07 Oct 2026 06:11:30 -0700 (PDT)
Received: from cloudflare.com ([104.28.174.224])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a8a4b1abbfsm1502137a91.4.2026.10.07.06.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 06:11:29 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>,  Martin
 KaFai Lau <martin.lau@linux.dev>,  Eduard Zingerman <eddyz87@gmail.com>,
  Kumar Kartikeya Dwivedi <memxor@gmail.com>,  Amery Hung
 <ameryhung@gmail.com>,  Yonghong Song <yonghong.song@linux.dev>,  John
 Fastabend <john.fastabend@gmail.com>,  Stanislav Fomichev
 <sdf@fomichev.me>,  Eric Dumazet <edumazet@kernel.org>,  Neal Cardwell
 <ncardwell@google.com>,  Willem de Bruijn <willemb@google.com>,  Tenzin
 Ukyab <ukyab@berkeley.edu>,  =?utf-8?Q?Cl=C3=A9ment_L=C3=A9ger?=
 <cleger@meta.com>,  Kuniyuki
 Iwashima <kuni1840@gmail.com>,  bpf@vger.kernel.org,
  netdev@vger.kernel.org
Subject: Re: [PATCH v4 bpf-next 00/10] bpf: Add bpf_tcp_ops hooks for TCP
 AutoLOWAT.
In-Reply-To: <20261006192601.1875100-1-kuniyu@google.com> (Kuniyuki Iwashima's
	message of "Tue, 6 Oct 2026 19:24:26 +0000")
References: <20261006192601.1875100-1-kuniyu@google.com>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Wed, 07 Oct 2026 15:11:23 +0200
Message-ID: <871pa1lkp0.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Oct 06, 2026 at 07:24 PM GMT, Kuniyuki Iwashima wrote:
> This series introduces two callbacks for bpf_tcp_ops:
>
>   .enqueue_rcvq(): invoked when TCP stack enqueues skb to
>                    sk->sk_receive_queue
>
>   .dequeue_rcvq(): invoked in tcp_cleanup_rbuf() after data
>                    is dequeued from sk->sk_receive_queue
>
> Those callbacks can be enabled on a per-socket basis by
> a new kfunc bpf_tcp_ops_set_flags():
>
>   bpf_tcp_ops_set_flags((struct tcp_sock *)sk,
>                         BPF_TCP_OPS_FLAG_RCVQ, 0);
>
> This allows the BPF prog to dynamically adjust sk->sk_rcvlowat,
> suppressing unnecessary EPOLLIN wakeups until sufficient data
> is available in the receive queue.
>
> This functionality, which we call "TCP AutoLOWAT", was originally
> developed in 2020 by Tenzin Ukyab with the help of Soheil Hassas
> Yeganeh, Arjun Roy, and Eric Dumazet.  It has served Google RPC
> workloads for more than 5 years.
>
> Combined with TCP RX zerocopy, this typically allows us to read an
> entire RPC frame with just a single wakeup and a single system call.

Nice! Just yesterday we saw at LPC that even with SK_SKB/SOCKMAP
overhead, you can observe an RPS gain from waking up once there is a
full L7 request to read out [1].

[1] slide 72, https://lpc.events/event/20/contributions/2428/attachments/2064/4781/Beeper.pdf

[...]
