Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793231939;
	b=SmbS3N8X3UYwd+SjygTyrcL49vBd5qX1/8JjTiDq8PGeXOZSAQNChyl5giT3QegPj1fy
	 AnBiWUwYMqCMFRYObnxcSPp+QWkrFfjJZ5uOe3901g23X5/D+sco+dmlA0KGrCmi7S5Ny
	 7+yxFJPlmSFRs39pWW1nWljVAVElKZxa+8QP7ZuQEVtnoAE1zzphd/q8ocQbMAkjZK2hy
	 xdmvn/NsMhA0j33cohVdPQ5emH+vLrBQg5JPGMO6qfi1bTRw+RaSw4gGClSIn8PfwM9Iy
	 ckZNsimetW1HWjxik5v7VlEVUxbIvykdCEap1kQvlavB+7KLQNu+GdgTdZYf8oh29gQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793231939;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=bkIauolFUP99goQic+ZO6OZzr0A9X9K2N+ri9gvCkgM=;
	b=YTNCrzjTsrjz3pJz6UkeFqJzg2ePD6T6NuZQpqr1DJXziWOg9lG86gdZeup5sdw7bQln
	 F2y8gW+IdMl43vJYQVTPQTE6lwRRiwtg4PA4jDxAuoglO2yzmxgqIJ8RX4431D0CDNXYx
	 /ZsdMloFQ/BYfXk6DCEXfA3Esdq2tRjhI3ZCx5wTw4GBJnoQaCGhhGML9egIzmjKdAq5z
	 Zf098Ij6uEshSma0F7eooTSuvD8BMqEwGiBkmqmVVsxRhCuW1nvjNIGe/dYnZokrugrWz
	 UFy3aoxfvYz0t57wzXfDlTuU3XociHWuInR9X3Zz5k/4i+DoV+Pnr/cZjvztgQV7jaA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=p2ziaZ2z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A47606A31C
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 23:58:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97A47606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=p2ziaZ2z
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1846bc43c28so1862228c88.0
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 16:58:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793231938; cv=none;
        d=google.com; s=arc-20260327;
        b=Y/DBYdGDxyC8ktuz5U8Sel/qftsYY78rTCMXwFrwVm5gPIRr4p4G6sU0OhfBNC+4iP
         S3a5lb/62iit4OtIAnvmlcxJ34oT1gEDMwtY5/JYLsBy1zZVkGRwzjHY2Y9Q0MJqxOr4
         KXCY0BsKmGPL4sBFvd9pXxLoEpCVo9HxvpEJhULDXp0PTFCspQyblSWkHYTkMwLYE8C7
         udzLIqr/5y2ONr/T/cQJYpKPb+/qpew5w5EUeG5gc9d6EN2/Q+IMaAjsMrXadxlAHzS2
         Smq/Zp3+YD1e7PBttgdMEwG9viL4UPR8731E0WavM2XpnwPw5ATMONTGQ7WLkAGholtb
         Ej2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bkIauolFUP99goQic+ZO6OZzr0A9X9K2N+ri9gvCkgM=;
        fh=l3vP5wnsErBOAkg7AUzd8HKFAP3E5ZYHta75iND1Fcs=;
        b=gUO1ZiF3Qw8yeCLNFFUhGvSPP3Zx1+zxluZHKSq7jneNfO7ldYehZheeeYTPYSla16
         Wz78U/0unVW4rzsGUaBm/it6NMGOZtvZGXAE9aSWRQTOfNscklC5el3jBl8B50yrGKIR
         SQ25KRu3MB1eDX++UFxsJ2+ZNIZ3rPSysBx/KAx6GVUL6RBXeTTi8z+tpq91QHZB4uiI
         V+QGgiSshkypVzdWp4RN8pVzfWLfiM6CcEfzaKQUudOH0xXpHRM5ywvj51DJCJe+IYzU
         lKgEpJBXffNirT0+uMYr0Zb178UC02/LpIb5GPLvJA42MbA1yjMpEwDTlADDBvh1kYhu
         2knQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793231938; x=1793836738; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bkIauolFUP99goQic+ZO6OZzr0A9X9K2N+ri9gvCkgM=;
        b=p2ziaZ2zEj0tj51mo212n8y58ZhNJzQfl1SKvwtMXV1nveewE+zgf/2ouW2pTE72AE
         gDZRv0gWRgAG6IYa1/VulzGbUgzBwNgeqTop9deeLfCowuVESEj0j8ejqfpo5EXKg76q
         nkbP10H1WOarIQrmMvsTrvt4EyG7qe6KaWxl74tidv2sfzzDe6UBveK3Q8u9Qixoingv
         yqHqRjzTnMm9sAcAygv8pjAIkpwxyXuPn5aAeDE8duZK70B9Hf5k1pq7eKUm8KLAl+WH
         UlbJmjt1UZjH7yI3HyZzvF05GOoJZ2C5m/CUQLMyNFdn+3CMbjYKvMyC9NGSAezcKecC
         ZMdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793231938; x=1793836738;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bkIauolFUP99goQic+ZO6OZzr0A9X9K2N+ri9gvCkgM=;
        b=jUbRxod6nMcLkzENwskuBUDAAQGzAYzyta5vwINwFO7BOQhKpMBIWgcYDEiDkRGzBE
         8TcrtMqRMwzwyXbefDQN8+pzI8G3pfVecQjBu7T6pBTibbPT0mYsstM93XXGQ7Xf/5PM
         shE+3J2n5MeAwK3FhAz7XiNxYJkD7FBffbEue+xbBmpDJgo/ffJl6E7+49Zxr8ffm5ti
         DzNTQWUqU+x1Wl6MjpX0xjLSKtIWiaOmT9oGYz4FUDLIBfoCBZFj63vPMQpfMP12OkV+
         6PRdTaDBi+hi9mH03V/H0ifAFrjXgrKmSyIHK3jOHNCuVh7pqqEhraWTqEXcUuw6tOuT
         AADQ==
X-Gm-Message-State: AFq9FYI1O5w05P6GQ/TqAAO6SytehVtqeYxHsuBxsuJIiNDzEksPEvYh
	a+sP9K/BFD6sgTe1Jx8vSZLKDj9Ptf4nV0b27qXlgBXJOmf2CwC/AM8KtSx4jn1+wDMNn1c8YCV
	aFAcNmvdmI64YLyDX68BIw6wNp8zZx1LU7f/L6iVH
X-Gm-Gg: AYBFou32qaeF7WtPylUx0OMFnCuYs1zaos7pUkZXZ/hdB/J0oKCDT45xmf7pLSFVeRa
	/0XyEXC5z2GGZUx57xfEiiM7N7Bvm0MDA+BDFfdh3i0Shankf+dItcgeghxuveGOfDrIgVe7C8F
	dqOWBIfnGJCtQif0MjKmdDUYiemxp+5EnOHJuc7Xnf0HKeNI2D2JkU70PbVr1Hk/OiY7j8RcJZ7
	PcANudJ94DW6bdhvG/ThYt+NL+x6nNxZ2GjFGiOeRU9mR+sJPFormvhMJNAjeA367RYnw9IMX0N
	YHN0yrYFkjj36LVQdBwnIsC4mFeTxI3cJlykaBCs8KHbyMDi+A/EdBFulXwLiVCAlUQEyfgRJbx
	OC2HexEL05uMGH1TD4e0DS6lTj/LDvx4CpB8Kf0Ewjbx3wIZHeOOWwgrIGsKCrutdjYqnBGtxZq
	xVDt75ebW6H49t2XZgQtNp4jgG5aHw6iEAQLie/GR+wkiUkZSxz4zlPOWRfGbYe6tGjdaTUk7DL
	kK6IlJbfg==
X-Received: by 2002:a05:701b:2515:b0:151:94a6:6f5f with SMTP id
 a92af1059eb24-1a6cd3a138fmr4261057c88.10.1793231936824; Wed, 28 Oct 2026
 16:58:56 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027104701.296240-1-jiayuan.chen@linux.dev> <20261027104701.296240-2-jiayuan.chen@linux.dev>
In-Reply-To: <20261027104701.296240-2-jiayuan.chen@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 28 Oct 2026 16:58:45 -0700
X-Gm-Features: AclHuK8KBdIT6N-DIpoNdJxwSjtvtUNtTI2wH9Yl2XvO51fbaw005XBERgZQ6aU
Message-ID: <CAAVpQUCBBaVmaZUv+D+a4anSbGSR_pKukYVXvRJRzSGVnjb2kw@mail.gmail.com>
Subject: Re: [PATCH net v2 1/5] ipv6: restrict gc_elasticity to 31
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, 
	Fernando Fernandez Mancera <fmancera@suse.de>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	Joel Granados <joel.granados@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Willem de Bruijn <willemb@google.com>, 
	Maoyi Xie <maoyi.xie@ntu.edu.sg>, Jiri Wiesner <jwiesner@suse.de>, 
	Gerd Rausch <gerd.rausch@oracle.com>, Zhan Xusheng <zhanxusheng1024@gmail.com>, 
	Oleg Nesterov <oleg@redhat.com>, Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>, 
	Yung Chih Su <yuuchihsu@gmail.com>, Wyatt Feng <bronzed_45_vested@icloud.com>, 
	Hannes Frederic Sowa <hannes@stressinduktion.org>, Flavio Leitner <fbl@redhat.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Petr Mladek <pmladek@suse.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 3:48=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
> Every counted IPv6 dst allocation runs ip6_dst_gc() once the number of
> live dst goes over gc_thresh (1024 by default). ip6_dst_gc() decays
> ip6_rt_gc_expire by gc_elasticity: the smaller gc_elasticity is, the
> smaller ip6_rt_gc_expire gets, i.e. the more aggressive the gc.
>
> ip6_dst_gc() reads ip6_rt_gc_expire into a u32, but gc_elasticity has no
> bounds at all, so writing >=3D 32 shifts a 32-bit value by >=3D 32 bits, =
and
> a negative value gives a negative shift count. Both are UB:
>
>         val =3D atomic_read(&net->ipv6.ip6_rt_gc_expire);
>         atomic_set(&net->ipv6.ip6_rt_gc_expire, val - (val >> rt_elastici=
ty));
>
>   UBSAN: shift-out-of-bounds in net/ipv6/route.c:3369:53
>   shift exponent 32 is too large for 32-bit type 'unsigned int'
>   CPU: 2 UID: 0 PID: 615 Comm: ping6 Not tainted 7.3.0-rc7+ #364 PREEMPT
>   Call Trace:
>    <IRQ>
>    dump_stack_lvl+0xc1/0xf0
>    dump_stack+0x10/0x20
>    __ubsan_handle_shift_out_of_bounds+0x1d1/0x390
>    ip6_dst_gc.cold+0x15/0x1a
>    dst_alloc+0x4e0/0x620
>    ip6_rt_cache_alloc+0x189/0x7e0
>    __ip6_rt_update_pmtu+0x68e/0x1160
>    ip6_update_pmtu+0x30c/0x3a0
>    icmpv6_err+0x1fa/0x330
>    icmpv6_notify+0x303/0x770
>    icmpv6_rcv+0xc12/0x1670
>    ip6_protocol_deliver_rcu+0xb4a/0x1520
>    ip6_input_finish+0x19c/0x400
>    ip6_input+0xd4/0x240
>    ipv6_rcv+0x1fd/0x330
>    __netif_receive_skb_one_core+0x118/0x1c0
>    __netif_receive_skb+0x21/0x150
>    process_backlog+0x37e/0x1200
>    __napi_poll.constprop.0+0xa5/0x5e0
>    net_rx_action+0x4c0/0xf70
>    handle_softirqs+0x204/0x9b0
>    __do_softirq+0x10/0x18
>
> Make it a u8 and reject writes outside 0..31 with proc_dou8vec_minmax().
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
> v2: switched to u8 and proc_dou8vec_minmax(), as suggested by Kuniyuki
> Iwashima.
> ---
>  include/net/netns/ipv6.h | 2 +-
>  net/ipv6/route.c         | 7 +++++--
>  2 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/include/net/netns/ipv6.h b/include/net/netns/ipv6.h
> index ffda15318be59..aefce37c04a4f 100644
> --- a/include/net/netns/ipv6.h
> +++ b/include/net/netns/ipv6.h
> @@ -25,11 +25,11 @@ struct netns_sysctl_ipv6 {
>         int ip6_rt_gc_min_interval;
>         int ip6_rt_gc_timeout;
>         int ip6_rt_gc_interval;
> -       int ip6_rt_gc_elasticity;
>         int ip6_rt_mtu_expires;
>         int ip6_rt_min_advmss;
>         u32 multipath_hash_fields;
>         u8 multipath_hash_policy;
> +       u8 ip6_rt_gc_elasticity;
>
>         __cacheline_group_begin(sysctl_ipv6_flowlabel);
>         u8 flowlabel_consistency;
> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index 94e5ef1c4f83e..abc8b811cd423 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -6579,6 +6579,8 @@ static int ipv6_sysctl_rtcache_flush(const struct c=
tl_table *ctl, int write,
>         return 0;
>  }
>
> +static int ip6_rt_gc_elasticity_max =3D 31;

as you need v3, s/int/u8/


> +
>  static const struct ctl_table ipv6_route_table_template[] =3D {
>         {
>                 .procname       =3D       "max_size",
> @@ -6625,9 +6627,10 @@ static const struct ctl_table ipv6_route_table_tem=
plate[] =3D {
>         {
>                 .procname       =3D       "gc_elasticity",
>                 .data           =3D       &init_net.ipv6.sysctl.ip6_rt_gc=
_elasticity,
> -               .maxlen         =3D       sizeof(int),
> +               .maxlen         =3D       sizeof(u8),
>                 .mode           =3D       0644,
> -               .proc_handler   =3D       proc_dointvec,
> +               .proc_handler   =3D       proc_dou8vec_minmax,
> +               .extra2         =3D       &ip6_rt_gc_elasticity_max,
>         },
>         {
>                 .procname       =3D       "mtu_expires",
> --
> 2.43.0
>
