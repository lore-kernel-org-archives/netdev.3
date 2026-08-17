Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EF139B4A1
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 08:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786954611; cv=pass; b=mQfbRqCMUy6s24BsJp6I61LZOy97jfouOM0pZgI5ewm/njLN7XayrGkp1kDaGNdKxLeh0IzR7zNHEb+zIqUROp3t9tSxfX8AcfvpViasTt43IoYp3eeZHGxDqkTMviLD6Gwy362cjcTSybjZ06JgHR5lzxbUCkZSOy7ewNWoyyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786954611; c=relaxed/simple;
	bh=Tdu4bqJ08ov38Zf33EoGyUCmbztfiig+a2av8PkuDaY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fl9bVRQly6rrxXzBRLwuBnt20e92aBPCsQ/zgOroNjCPfrDQsaapqDXcUkPpE20rozEeK7fwNCGiy00UNZ4avWL2VFShpMVGfzWhj9Cf6nryRzVcJ8c2dnld/QB7d3ShjT1IlJrr6VdtfNgfBRu1Gs7WPQSwZnixzHujbdcx8kU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iiTd9nOU; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iiTd9nOU"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-529a1ee0e62so21879061cf.2
        for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 01:16:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786954608; cv=none;
        d=google.com; s=arc-20260327;
        b=Hjy3jxY8V42p8iMLhg2eAJmZzClE7c9uD8hJpCaoiBGQSYIWYhEa7goe2VKmhmsMfc
         atFG1ac+ue4A/bPs0qhAXy+9yy3ULFhoJjqHFa2oDs+O7oeHJVIaeM27Cg7fsj1E1irk
         abRaHvwi77VojAOpJyUJW+97ybZrmPcuCruQQFP9vAyqNmcI/g867NOow4ApUY0LRVT8
         qKP8Ii6gITKUH8w6v0Ngn8TRnDl7HrAsVlrkCVpfadQy/5T6kwzJU3UqagTdzpUB4kfV
         0N3XZiQS4flFLTlhLYS6wz9wYeBOAOaNGK6z5TLWwrssFnxQfCooT6dvdhi5H8GkfwHq
         cnXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wKizjhAikhCb9V41ASNqAIpXy0cGhvhtspoPIe6aKcI=;
        fh=K9Ka5s///Qt4oCLsQS82U9ThLztSU8suEoLguFVirhM=;
        b=C4+atwFP6DC+B1mfGdBfVUtaaYNxr9ivJ1DqGrEukl6JkQVDTkrIto7oBEtCYGE87O
         HH3VJoeZRZwttu2Sonn686l+q5zX4dNF2gPNhLF4zHmicvENrHCX5dajf4S+2Y7anexK
         +aUIHPryG0EH3w/RQ0BQ/5h/hvB2YTU/B90x0CC8iYxYCCMrlbobwY1F1/50pxe378Ht
         nmHJjP2XncteglrCz4LtOFTLZ0P3J4mgtdQrghu1kpRsSCOlclapKiuuC+4AJ/ESqzyE
         PJnaEg6EgwidLnLQ2fM58dJwOc0QEOfL1KeDlwQ72+pUf9BqMpnJaFj2VTaAHvDn9Z2b
         WkIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786954608; x=1787559408; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wKizjhAikhCb9V41ASNqAIpXy0cGhvhtspoPIe6aKcI=;
        b=iiTd9nOUgKO8/t2DmJr29Co49D3xy36x3BHH57D6VtB3Q9C02Ibq1vooISIBerbMKj
         34p9P/jov7PuHGXvCtLje7zmVDhz0pr2VHAHmLkeY+RIPqHkgVKniZW/fSca5Lbn4LAH
         JQPLaDRn0knlwpDxynNar51Fc0mmBVA1TF6gvvKr90x+0U6QomDaGbK3tmbBIc6hsA8e
         /srdF+D7EFMtP+NzxJlzYHKLBCp0ZaUtjDDBgqqiJXoM3FbD1uiwaYQNkK+hNOT1Xmon
         bHibz41Lg7N7rPKcu807KAgapxEXl2JJnURvxMJuimlgQXw/EJnrOEmVBEXsXyBrdRMA
         sgMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786954608; x=1787559408;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wKizjhAikhCb9V41ASNqAIpXy0cGhvhtspoPIe6aKcI=;
        b=HEiv5kw8StvOUCZAC0NHi13nggScdK1JJY1CcaeteUrO+F2LmUXmzr0MmAdZ6vFdeA
         1tdJKm4GtIUR6+YZa3ld8ZomyY66Drvwu0RlL8rK9Ev87Ayoby3nUrcVoYYPhM3UvO0w
         NEqc2Djh+ruN+5+fOJv+6/i5UY3nKcQBKxATQFiVsdh/1q3xCCaeOItsTPlso5H0+cw0
         1FkrtxXSAv8C1nQWYAQtaTSg/AZlwNvjk1NFMT+lS0LQ58Hq0kSLYR8V2ZrjwgFwloEH
         ZCGVuu9tHMIHzZwrhdPEMxbNJjCA30suUAOrCFtcp4J4/RntGmDRBuysb5XA5h7E8AuM
         ywpQ==
X-Forwarded-Encrypted: i=1; AHgh+Rojz9rfVO2x21fvHK8+SXT8DoJJRENURnAc9EL5YBpCMpzfZDzfxo/KMyjp9TcJuh6w2ftAXBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy9ailuipCq7BkvsEF3My6ZjWxiA4js3FyLbcSN2jOEo1J3qOq
	MIuKbXuq92lRtDeiRegOmJQ2m1zfMO0IEtUOvPAiKHPts5IU7RbFO0VJtmK8uLuhrKKOoYornAT
	mJg3Y/yD+xjtt2MwvXAzFmM+wTnCpRQ7Dcs5lTPu7
X-Gm-Gg: AR+sD13IVPf/lbSuJUSMMRPtpiZ8nuOHMq78ARlWgKdzL0D38Wb4Eb/OlLlu1b7XZWf
	jJqD7b/r3ijyesLDUzHxFeYHmcPiJ/2x+EcabwUJgXMhn5XpPoEYOXPx/Ob6JGROqJgvJpJD8Tt
	bfXhQqi1uiU1KPPP/3r1OYFRx1A2fbuX8Am3p3BQ1hYr6Yvldyg/5XZ6OQwsN9PpyFc9hzht20V
	u/5WXRJx4Cl1VVQ4AK4u1XeD43Uj5Vm/2FQCgzzNuB+djOBj9O1+59BAL8R/tM2hwJKdxMPzslw
	4jzR4ru7QCHNUwB6lL6Pg6zVLXVwpF0HdNQJqk466I8oT6vl64uxcM3kKTs4APXJpNhpj2u2iOb
	VA1emvACy1fNdLUtqmaA9g6jioPpmNJ/FfX4Iwh9RbP0JqJfA22FbWHZ/Rbgm6ldgTH/hX7wB7I
	e4Qt0A+96PJyeUWrg=
X-Received: by 2002:a05:622a:428b:b0:51c:1c73:5943 with SMTP id
 d75a77b69052e-52d854c545fmr252207561cf.23.1786954607535; Mon, 17 Aug 2026
 01:16:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807171533.1904697-1-edumazet@google.com>
In-Reply-To: <20260807171533.1904697-1-edumazet@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 17 Aug 2026 10:16:35 +0200
X-Gm-Features: AcwNN1UBrRJ2ksMrlb5Cx2AUg0-Vv8JcrRBu_1xZsEy15LdBXR_6tbPGW2IeeWI
Message-ID: <CANn89iJDW7P5cagO3EZk7xKZ-yn=BBsyOszvbi48O5OkD3tLXA@mail.gmail.com>
Subject: Re: [PATCH net] xfrm: add missing rcu_read_lock(), skb_dst_force()
 and dev_hold() for xfrm_trans_reinject()
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot <syzkaller@googlegroups.com>, 
	Steffen Klassert <steffen.klassert@secunet.com>, Liu Jian <liujian56@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 7:15=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> syzbot reported a suspicious RCU usage warning in ip6_pkt_drop():
>
>   WARNING: suspicious RCU usage in ip6_pkt_drop
>   include/net/addrconf.h:389 suspicious rcu_dereference_check() usage!
>
>   Call Trace:
>    __in6_dev_get_safely include/net/addrconf.h:389 [inline]
>    ip6_pkt_drop+0x596/0x610 net/ipv6/route.c:4620
>    ip6_pkt_discard+0x1c/0x30 net/ipv6/route.c:4651
>    xfrm_trans_reinject+0x324/0x630 net/xfrm/xfrm_input.c:806
>    process_one_work kernel/workqueue.c:3322 [inline]
>    process_scheduled_works+0xa8e/0x14e0 kernel/workqueue.c:3405
>    worker_thread+0xa47/0xfb0 kernel/workqueue.c:3486
>
> When commit 4f4920669d21 ("xfrm: Reinject transport-mode packets through
> workqueue") converted xfrm_trans_reinject from a tasklet to a workqueue,
> the reinjection loop ceased running in softirq context. Workqueue workers
> run in process context where local_bh_disable() does not enter an RCU
> read-side critical section under CONFIG_PREEMPT_RCU.
>
> Because finish callbacks (such as ip6_rcv_finish) expect to run under an
> RCU read lock (performing route lookups, l3mdev lookups, and accessing
> RCU-protected data structures), invoking them in workqueue context withou=
t
> rcu_read_lock() triggers RCU lockdep warnings.
>
> Furthermore, packets queued to the workqueue via xfrm_trans_queue_net()
> may carry non-refcounted (noref) dst entries (e.g. from ip_route_input_no=
ref).
> Additionally, on netdevice unregistration, dst_dev_put() replaces dst->de=
v
> with blackhole_netdev, so dst entries do not keep skb->dev alive while
> queued in the workqueue.
>
> Fix these issues by:
> 1. Calling skb_dst_force(skb) in xfrm_trans_queue_net() while still in th=
e
>    caller's RCU section to ensure dst is reference-counted before queuing=
.
> 2. Holding a reference on skb->dev via dev_hold()/dev_put() across workqu=
eue
>    deferral so skb->dev remains valid during finish() callback processing=
.
> 3. Acquiring rcu_read_lock() around the finish callback invocation loop i=
n
>    xfrm_trans_reinject().
>
> Fixes: 4f4920669d21 ("xfrm: Reinject transport-mode packets through workq=
ueue")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Steffen Klassert <steffen.klassert@secunet.com>
> Cc: Liu Jian <liujian56@huawei.com>
> ---
>  net/xfrm/xfrm_input.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
> index eecab337bd0a794588b192598851bd77427c8392..8f6109eada7eaaf1c70aa2da6=
10523b42d75b50c 100644
> --- a/net/xfrm/xfrm_input.c
> +++ b/net/xfrm/xfrm_input.c
> @@ -800,12 +800,17 @@ static void xfrm_trans_reinject(struct work_struct =
*work)
>         spin_unlock_bh(&trans->queue_lock);
>
>         local_bh_disable();
> +       rcu_read_lock();
>         while ((skb =3D __skb_dequeue(&queue))) {
>                 struct net *net =3D XFRM_TRANS_SKB_CB(skb)->net;
> +               struct net_device *dev =3D skb->dev;
>
>                 XFRM_TRANS_SKB_CB(skb)->finish(net, NULL, skb);
> +               if (dev)
> +                       dev_put(dev);
>                 put_net(net);
>         }
> +       rcu_read_unlock();
>         local_bh_enable();
>  }
>
> @@ -821,12 +826,18 @@ int xfrm_trans_queue_net(struct net *net, struct sk=
_buff *skb,
>         if (skb_queue_len(&trans->queue) >=3D READ_ONCE(net_hotdata.max_b=
acklog))
>                 return -ENOBUFS;
>
> +       if (skb_dst(skb) && !skb_dst_force(skb))
> +               return -EHOSTUNREACH;
> +
>         BUILD_BUG_ON(sizeof(struct xfrm_trans_cb) > sizeof(skb->cb));
>
>         hold_net =3D maybe_get_net(net);
>         if (!hold_net)
>                 return -ENODEV;
>
> +       if (skb->dev)
> +               dev_hold(skb->dev);
> +
>         XFRM_TRANS_SKB_CB(skb)->finish =3D finish;
>         XFRM_TRANS_SKB_CB(skb)->net =3D hold_net;
>         spin_lock_bh(&trans->queue_lock);
> --
> 2.55.0.654.g21b8a5bc05-goog
>

Gentle ping, thanks !
