Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793683809;
	b=GnBJFjGR6OwzM04EbB4RFGH9sIIBACRPIIIPJrpJnb3s9GRbYuYUjFS2gPM5/kUcSUjr
	 4iX4HMD7JHWs8+h7AXXM0f2uPlpmI461uXX8VOraVSOicShgeMNP0e/swVBhLPxsgUhSo
	 i6p2kuJU4GUlnIA80QXUYaxPgEBIgKFPr1hh30yuOeRYzFpY3nrWW0NskoYfYZRBruPx1
	 FTiIGYdftYnXv2fyM0O/A/lRfN78DKiZNDDwGwSmSV5E0IOL9aQ8pOQXLwBJZkNk/+ZCI
	 YOcE2OS8rzyrKZaqyqxJQzUlcoyO1UuwQIcItzjiLqidSG6Nq181w1S9e1QvS/bcCmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793683809;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=UfcfWDapD1eN1wGqKknnJPLrQVp/4XjcdHnVO04qcqw=;
	b=EJMeYj5zH66N5/VkKg7qdF1a9T8ZyAV5NL4CivFRBjB8b8OAejJRe+9IwWIGatKFQODR
	 Y9Ga0tknzE6qip96RbYoMS90Q2pXNSweaEP+LiDw/QsqDZaxD6P/hUzJKqTrJ9P59ozMn
	 uhFubTKI9YXv5tn43iqSzjeRwTelukJAnfsHIMTWYkCySo0/Mh5GQSzG8JyYPQRPX2Hoz
	 aOH4TVxxG9jMcd9dda8lI9INtGxGslfBqF0g7tCvAZrvzG9z/73BPvDSRxrx4tn1Gwn1T
	 e5eg2gJret1S52x1cu7CJyXzBYUr0r25iOXDtKynRS1WuxUh4lxUg5mUtWdSzfwIM6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NYg9ND0r;
	arc=none smtp.remote-ip=209.85.210.198
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919DC606A333
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 05:30:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 919DC606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NYg9ND0r
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-89fb6a45c48so3078626b3a.1
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 21:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793683809; x=1794288609; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UfcfWDapD1eN1wGqKknnJPLrQVp/4XjcdHnVO04qcqw=;
        b=NYg9ND0rl6ZVUxd59X/M8JLqm2JZfoIYNgR1YP5jub2+BFtBLeQ6XsXn365c4VONP2
         H+A7iCzlCy34ecM7sWmkKX4CSlv1q7BWbKmykJVVpdv820G3ICM2QOeyzNOY8+O3CE5e
         DQ+yMogBox/+L3KwUSPWxA+8MN1cRLV4q5o608j9isVxzd50uLOBM7UfTq0Ye+OIuxU3
         KFtw68WwivnN/Wy08dWnqskChfVLU/uQmhuiR04knfq0kNLrYAaMxg6h2pYF7e26XK3e
         Bt1/Fg8TaIWyajMiBondOsiZi9OpQw5aaLWOmDklwFSswSlWUnwHA7brg9sziDRAaLTI
         5Jhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793683809; x=1794288609;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UfcfWDapD1eN1wGqKknnJPLrQVp/4XjcdHnVO04qcqw=;
        b=xXMEmYaZqeDppPZtr+/ZZ3/R4CtMNKWYXOVe9QxrASA+AmOb8frixUyj/zsVE7uQVc
         iy2Qk6Yp/E1ADj29+BtL36gRI4iRm17N32taaXI4M6E2Jl0HNyazd/wgfQ0hKOZlT29Z
         Wk2G5pZnzcZVQKtvowM9BBJGSacgGmlhEI8m8wgmZJj1efR908MgO3TX3JBQKLaTQSUa
         ds1oRNzmQ38PDS2uBJBJQkIxdG4nG8JbO7e5LfRZyt23duez9hA5S1vNnhjf7q+JPEPL
         EdUfunVsRaUjijE02zQwjR5JyrWgmD7m7pbHnSzpfZDwJ1CqDe+G5dA9e0Qcm76o/ob1
         pQAQ==
X-Gm-Message-State: APuU4Z+auODZQCGDGvok9FhnPD1pC5G3CBPluhAxpo9KGa96+AWTuObE
	xtzKSNDuMehPdw0f0sSgeSVLmXNplYYupNln+NFKCcfvh/MYiQHn+vIE7c4WtEEAFpHnVEWIDR5
	WdAGAhA==
X-Received: from pfba5.prod.google.com ([2002:a05:6a00:ac05:b0:899:3459:82f2])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:e85:b0:886:3a6c:a9da
 with SMTP id d2e1a72fcca58-8a9beb6139dmr9360293b3a.26.1793683808642; Mon, 02
 Nov 2026 21:30:08 -0800 (PST)
Date: Tue, 3 Nov 2026 05:30:08 +0000
In-Reply-To: <20261101061331.286404-6-jiayuan.chen@linux.dev>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261101061331.286404-1-jiayuan.chen@linux.dev> <20261101061331.286404-6-jiayuan.chen@linux.dev>
Message-ID: <aulxWKGoq0ed__Rr@google.com>
Subject: Re: [PATCH net v3 5/5] net: restrict message_cost and message_burst
 to non-negative values
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, 
	Joel Granados <joel.granados@kernel.org>, Fernando Fernandez Mancera <fmancera@suse.de>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, Thomas Gleixner <tglx@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Maoyi Xie <maoyi.xie@ntu.edu.sg>, Zhan Xusheng <zhanxusheng1024@gmail.com>, 
	Oleg Nesterov <oleg@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>, Yung Chih Su <yuuchihsu@gmail.com>, 
	Wyatt Feng <bronzed_45_vested@icloud.com>, 
	Hannes Frederic Sowa <hannes@stressinduktion.org>, Flavio Leitner <fbl@redhat.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Petr Mladek <pmladek@suse.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Sun, 01 Nov 2026 14:12:03 +0800, Jiayuan Chen wrote:
> net.core.message_cost and net.core.message_burst feed the interval and
> burst of net_ratelimit_state, but neither rejects negative values:
> message_burst uses plain proc_dointvec, and message_cost uses
> proc_dointvec_jiffies, which happily stores -1 second as -HZ jiffies.
> 
> Since commit a940d145cc38 ("ratelimit: Warn if ->interval or ->burst are
> negative"), ___ratelimit() splats on such values, so the next
> net_ratelimit() caller warns, e.g. a martian source log:
> 
>   Negative interval (-250) or burst (10): Uninitialized ratelimit_state structure?
>   WARNING: lib/ratelimit.c:43 at ___ratelimit+0x56e/0x960, CPU#1: ping/3218
>   RIP: 0010:___ratelimit+0x578/0x960
>   Call Trace:
>    <IRQ>
>    net_ratelimit+0x1c/0x30
>    ip_handle_martian_source+0x1bb/0x340
>    ip_route_input_slow+0x1057/0x3650
>    ip_route_input_noref+0x104/0x260
>    arp_process+0x109b/0x2510
>    arp_rcv+0x381/0x460
>    __netif_receive_skb_one_core+0x173/0x1c0
>    __netif_receive_skb+0x21/0x150
>    process_backlog+0x37e/0x1200
>    __napi_poll.constprop.0+0xa5/0x5e0
>    net_rx_action+0x4c0/0xf70
>    handle_softirqs+0x204/0x9b0
>    __do_softirq+0x10/0x18
>    do_softirq.part.0+0x49/0xd0
>    </IRQ>
> 
> Negative values never meant anything here: 0 already expresses both
> "no limit" (interval) and "suppress everything" (burst).
> 
> Reject them at write time. message_burst can simply use
> proc_dointvec_minmax with extra1 = 0. proc_dointvec_jiffies has no
> minmax variant, so add proc_dointvec_jiffies_minmax(), mirroring
> proc_dointvec_ms_jiffies_minmax(), and use it for message_cost with
> extra1 = 0. Note that like the ms variant, extra1/extra2 are compared
> against the converted jiffies value.
> 
> Fixes: a940d145cc38 ("ratelimit: Warn if ->interval or ->burst are negative")
> Cc: stable@vger.kernel.org
> Suggested-by: Joel Granados <joel.granados@kernel.org>
> Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
