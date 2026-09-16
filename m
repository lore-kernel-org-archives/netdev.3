Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0591543CE71
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 07:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789543986; cv=pass; b=XEX2Nu0FdOBHE5QSdwJrjCSWOUpzPq3qcOzsxv0k1V1HbHr8W7XFEIzdQ3fTkArN2vvp2rEpbm+2/biwJa1iErVDm+xKFOCJAOOWYHrLJEWaNxzEeae3ArsLMrFJnMVl986Ba7tn/VjdI4+qaD/YOJKR0vLd1zPC1OBD/LENhHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789543986; c=relaxed/simple;
	bh=mjR04Bkrj9erkkufpQlRwq76e4C529B6SDKCewiFrYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T9wqWbfdJGoNf13U/LZ4RZPjfHKgI1gd4kf/hvpbTsP7h9aLS3tydXWFakfy5uKUoDFwr8+ndwxpXejW77Bn1NOkm5JgA4bsjLm33EWUNVHwQeHfBbUh9v4oVC2Mdmk7pxsPi1uVibr9rhUkpvqe6/AiT9/76CM6iX+dOPICl+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=OJIYvXnP; arc=pass smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="OJIYvXnP"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc4c08393b0so531061a12.0
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 00:32:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789543970; cv=none;
        d=google.com; s=arc-20260327;
        b=dQiPEKiIlEiTN5ueK3GN/6WZy5UHl7VxbF5zBzyRdV0Qj7YsL9zdtutOTUa4IpvVvq
         OFjcD+27AAYoikpXGNuPa2iGW5EoOxyQjSauFZ2WEYXyaAYyNfvwX3KZvF6mQcQjxnxN
         Pa3+58rrloGK3jk8uAi5Vazqvnf9AKSZNmLtl4K29ZVPYRNZDtwSuelnqMCfm9UwkuoM
         AWTWOrUuvVesBp9mg9UvSFbKYEHbcrsknyCfADz4cD5C6/OKWfaoh28ZFlvo10iuL8yL
         7odo/b5Ia2TFw6Zz//zBnhY0bl7KJBbfytcK4dWBjKNPa2wWxylZFCofODS4RGzJ6pS7
         eq9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VZpiE0+zzAEvG+TqmxLhQovdw7arxClPfA9bmtpoXjE=;
        fh=1F4JlWiolUWgYxV5NY8tgwh+3ZIutFywicXuT4yuFlU=;
        b=Wz/J7ds14kNU2XLS8o30G5jEDHXKGn+GBx6fAY9QfKd7FSdZJXecEg/YKz07LMJ+0J
         WzIrF8Epy6QtfsmUIfAjHtrm/QT174uP6Fcjf4sVviTqETj0I1fiMM6le3nI68QkoalI
         Yi0jP32XgZt+zX/beUlLu1TmAJ6qRD8Ms8pN2YIjQJZIlQoYxw5TFMIcdwXLkEmHgP1z
         9uXOOqAc9Fe5FTW33C94Uf5vDyuZveKsIg4Abt7mYPHVpvMa/WD6XqLGWLD3Qsv/zEJI
         v/svzr4KzJYEui/CqDs3E85d7n7FrSttA99+17ysOJkTJCGIgTi0fchKefpwYYWN8wBM
         yTog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1789543970; x=1790148770; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VZpiE0+zzAEvG+TqmxLhQovdw7arxClPfA9bmtpoXjE=;
        b=OJIYvXnPpF9Lju1/Az7OlaneV7iSXbgSm69SplH0kBg8jdVCwjt9Vz8RRxe1U47DC7
         +wRTs5dhS46ut47RPGJs7xtA0yzzbb9pEIxWn/yqgyhu0L/Bz1I73RiPbe+GYD+F7T5Q
         wDxYxCfFZu5bsIL4Thd6eJSAlbydMPVcUsyLuQalJFDJRlddQmbHKf7UD/axONPtOe/w
         JRa+6v0F8kq5P4Ekx4JZmzYWB7xLD1moz161O0GW5F6PW+RW5UjMSJ5ufEYr/3Vj4m9G
         BhEPsCJxxCvZtiOUdAi+0N+u3EueqbUeDsq0n3bUKO20Ew/oZLyzfBO0lh2oRw3+NO3q
         i+bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789543970; x=1790148770;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VZpiE0+zzAEvG+TqmxLhQovdw7arxClPfA9bmtpoXjE=;
        b=BjDwqhWAKUX36HMRHhx/97uYxix+Ekrce/sqr2GnYFFmFkUSBiMl1+n1TyKLeLO8V0
         WSU3nlWKh6xRkAETZ2PULtKmA66kpI4qf8CTcg7+SShViu9cVZz7i87r/K6HDvWE5FkE
         z/k/caUTlYo58toAmX4WVGJeX0U4EzwOnGIMUwYwf4ZWoFg3cmHFuwzi9Q4S0ugV4dOE
         RYQjyXs3QXAyv4NshzaySb4GyXhV/fB3z6u9HX5AOs5faEjcZrzYwdFxZYkPogLra5o6
         FIUYoO43fAU7lm8Y4ra8jYWA3WPPt2d9GimBgxDXMxl7rGX+GyF+wQpV/32KQZQcqvVy
         Ny8g==
X-Forwarded-Encrypted: i=1; AKwUvBxuD334gQWuvSmLuPL0y66yy5bKUHaudrKvutM48FFUcYPOeyvnDJ5fkVefDIGJeK/LpcnYPLM=@vger.kernel.org
X-Gm-Message-State: AFuF++kuwfUG1333L9akWZ7OkwECLdnKzSuFFUcyO9hpzabTnC5F9BzY
	SBP0i8L/hHOJueexv33EhvTXOC+ukvnbr7Xjvq4HCoc3v1p/Nn30s63kdZ8vkK5xTsbWS6SwhMQ
	AElzf4HkK7DZHFohjUtx+Xu+4gXO8bOrxZ96s4eSG
X-Gm-Gg: AYBFou398in0BfYbmJOyVuYFurOHUC6cwK4FTohgKlxKzzUMFN0FeMaxy3jbCAHs+N3
	8zBte9Xm3PrxmrfFZ+EeGEIHbVCynNyQhYQW3Zk8qAokvgWdRav4nwVLb1/tFrYxDjjyMmf5kMM
	NynLrMsjtwhI0V+SOzhvq8JiLGoEMgN0btOk8R8GKJ18Oe6rfm0F41kbuJhnBreSQP0c5w/N7kr
	6wuy6JH5oHGpg2IqYwrT41GbCe+tk+xOU5WYFrppYCMBsXUm7D4MtfkPaNv+akzIhwIWHgh9ab1
	vXj1sEmWadAdnqJjzx93eh3Rjfxf2SQ5kA2J0+AoELPk4CEH6CcyHPPgwtOC5S4i+ouUqUSX7Vf
	EAMpVB9/amRmL4b7iZz2v/UqPWSGDhKlQovvKKaVQ8E/27g==
X-Received: by 2002:a17:90b:524d:b0:39d:eca2:5c81 with SMTP id
 98e67ed59e1d1-39e1e2dea05mr3829092a91.8.1789543969709; Wed, 16 Sep 2026
 00:32:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916041102.1914333-1-xmei5@asu.edu>
In-Reply-To: <20260916041102.1914333-1-xmei5@asu.edu>
From: Xiang Mei <xmei5@asu.edu>
Date: Wed, 16 Sep 2026 00:32:38 -0700
X-Gm-Features: AcwNN1Xljv2HCFLUQMDufNtEairMBCo-H1BK8G1-p5r5dXNC6bE7Jd1RDn7HVDo
Message-ID: <CAPpSM+SpeOa5uo5rffXejDa4g9VGphp1GvirJgUWze-O+cQyzA@mail.gmail.com>
Subject: Re: [PATCH net] bpf: lwt: clear stale IP control block after pushing
 an encap header
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, co+ff13a35f73bb7891@bugs.sh, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 9:11=E2=80=AFPM Xiang Mei <xmei5@asu.edu> wrote:
>
> bpf_lwt_push_ip_encap() prepends an encapsulation header and calls
> skb_reset_network_header(), but leaves the IP control block describing th=
e
> inner header. Its offsets are relative to the network header, so they now
> point into the encapsulated packet.
>
> On an ingress lwt-bpf encap route a forwarded packet carrying a Record
> Route option then reaches __ip_options_echo() with a stale opt->rr. It
> takes the option length from the packet and copies up to 255 bytes into t=
he
> fixed-size option storage on the __icmp_send() stack. ip_forward_options(=
)
> writes at a packet-controlled offset for the same reason.
>
> Clear the stale state once the outer header is in place, as the tunnel
> encapsulators do and as seg6_local.c was taught to do in commit
> f967455fb2a5 ("seg6: reset IP6CB after IPv6 decapsulation") and commit
> 44930446dde4 ("ipv6: seg6: clear IPv4 control block on IPIP
> decapsulation").
>
>   BUG: KASAN: stack-out-of-bounds in __ip_options_echo (net/ipv4/ip_optio=
ns.c:96)
>   Write of size 255 at addr ffff8880bee08930 by task exploit/150
>
>   Call Trace:
>    <IRQ>
>    __asan_memcpy (mm/kasan/shadow.c:106)
>    __ip_options_echo (net/ipv4/ip_options.c:96)
>    __icmp_send (net/ipv4/icmp.c:949)
>    ip_forward (./include/net/icmp.h:43 net/ipv4/ip_forward.c:176)
>    lwtunnel_input (net/core/lwtunnel.c:465)
>    ip_rcv (net/ipv4/ip_input.c:612)
>    __netif_receive_skb_one_core (net/core/dev.c:6264)
>    process_backlog (net/core/dev.c:6728)
>    __napi_poll (net/core/dev.c:7787)
>    net_rx_action (net/core/dev.c:8007)
>    handle_softirqs (kernel/softirq.c:645)
>    do_softirq.part.0 (kernel/softirq.c:546)
>    </IRQ>
>    __local_bh_enable_ip (kernel/softirq.c:473)
>    __dev_queue_xmit (net/core/dev.c:4961)
>    packet_sendmsg (net/packet/af_packet.c:3143)
>    __sys_sendto (net/socket.c:2281)
>    __x64_sys_sendto (net/socket.c:2288)
>    do_syscall_64 (arch/x86/entry/syscall_64.c:84)
>    entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
>
> Cc: stable@vger.kernel.org
> Fixes: 52f278774e79 ("bpf: implement BPF_LWT_ENCAP_IP mode in bpf_lwt_pus=
h_encap")
> Reported-by: <co+ff13a35f73bb7891@bugs.sh>
> Assisted-by: LLM
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> ---
>  net/core/lwt_bpf.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
> index da49364ec63d..17be476b5717 100644
> --- a/net/core/lwt_bpf.c
> +++ b/net/core/lwt_bpf.c
> @@ -649,6 +649,18 @@ int bpf_lwt_push_ip_encap(struct sk_buff *skb, void =
*hdr, u32 len, bool ingress)
>         if (ingress)
>                 skb_postpush_rcsum(skb, iph, len);
>         skb_reset_network_header(skb);
> +       if (ipv4) {
> +               memset(&(IPCB(skb)->opt), 0, sizeof(IPCB(skb)->opt));
> +       } else {
> +               bool l3slave =3D ipv6_l3mdev_skb(IP6CB(skb)->flags);
> +               int iif =3D IP6CB(skb)->iif;
> +
> +               memset(IP6CB(skb), 0, sizeof(*IP6CB(skb)));
> +               IP6CB(skb)->iif =3D iif;
> +               IP6CB(skb)->nhoff =3D offsetof(struct ipv6hdr, nexthdr);
> +               if (l3slave)
> +                       IP6CB(skb)->flags |=3D IP6SKB_L3SLAVE;
> +       }
>         if (is_udp_tunnel) {
>                 size_t iph_sz =3D ipv4 ? iph->ihl * 4 : sizeof(struct ipv=
6hdr);
>
> --
> 2.43.0
>

I just found Weiming post a patch solving same problem:

https://lore.kernel.org/bpf/20260915170147.3943392-2-bestswngs@gmail.com/

and that patch covers the cases I didn't consider so please ignore this pat=
ch.

Thanks,
Xiang
