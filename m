Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FAF2248A5
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 00:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791161480; cv=pass; b=px50ohKX0AFLPEj7Kus9V6yuRGItC3cUVUWfrU/KQwFZBMSnecWzBlzNGi8FAllOYF1KU54BGFA0cqGDV7ZcLV741Hq1V6EscmmAAn18sc16XOlWEt5Fl5P3krhTEGFyXBrwenN1h5YqTETj8NZNZleT3xisU7a68KGANG3tEew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791161480; c=relaxed/simple;
	bh=al7ZHuocxRdOqtzJdhsg6QORl2P2JeEePJX8HxUAQbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XbZ/r2vgniUXjh425IFU0ydzbv0b80YmVmU5x6xfb+lfEk3pS16k64qE7IlxILfGHAfSp5YmLbJDBC27WITKQICdvpTjgY5+FrS2CAy73UkaM4qlHesZt4fEf5jXpTryT1vPksJckDwTIG7CUu8s5XSJrymcPWSlIkK/0WWLeV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PLAvS5pU; arc=pass smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PLAvS5pU"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-15354aa70e8so2585780c88.1
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 17:51:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791161478; cv=none;
        d=google.com; s=arc-20260327;
        b=eVMIk/ktf8igLw+Q7CKnVK8EVjJkf1tYq/9cAwBOH4IcdYMGW/fcCKJ6OP6SFb++c6
         ePhQnR2fAHjfy956/Or5AL/UMFGGKXLLQIlfuRh6Y5KQor04eJU/OM1Z94mk6sDrifBu
         xE3ojkIXjKAyOcyT7f2BuReScl3KOnB3Ux2bFNmYz7Jfk1hvDm/JSBy2Fvdqq4faPaHm
         fyol4KZ9K2j0NoccmZsAaSfpMmllgduNK9O0k1Ei+O0v5HOg+vq5t0tM70NW5KyXBZ4J
         QiBWRfMVQVjUh3IkbKN37m7ODlCEaVcRddF0ZOoi+whDAnfvJklSo5fiy2Z5xAHDnAIG
         /bsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RMHvbNRpAhPxfoH/Gr8Og40d44z3lI8rV/0oErD6Kn8=;
        fh=eQd+w0Pw5tDCIQ9J3DNI4e7l1SJNkGwJTMytXvpY3rY=;
        b=daEYye9yocIGYCrDlQcW+jWtas1DZxIk2R+Hvfsc2hw/P8LAhizBFw1KfdCpylSuKa
         0Al6F8uOz4UccSWWZYRrhttM4uu+NRRnw3uvvt7ak33kN9Khuu+tL1Ec+FiQELLfj9lA
         ZmEYuwe5ha5cJNkIx5ad/Irr1jjCzbaBTrKgaXlpTSR7sm4/SPUOC/UitGe23Ep9+9RD
         y3oKJTO/joa15vvrHgvaIzRO3kKxRz2RgIB+1eauAGJm2FjEa6P8UKMaDThxWyZv6D7U
         4+SNATm8P53DjKbNXlMmUkYYQINiZ3EXH2opRtjhuIt0YJic5fI98s4CWGV2/nonN6Qv
         EiFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791161478; x=1791766278; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RMHvbNRpAhPxfoH/Gr8Og40d44z3lI8rV/0oErD6Kn8=;
        b=PLAvS5pU5dE9meCuiVLOVwMiR98WdxIqcCcjZ6FxgqtUAB7tRt1o4Sa9gahBq5FsOZ
         sToIap3X4GqWPCE5L8IzJWuGG2weT46hgx/8yF4osYofFZAQMN8SKp+t3riFHCLJI36i
         F3PjGHqw6bSL6zpXhR9axsfgQne0+qaTAKcZwfOG3wvWAqDF8MPHzzA7zTFCbPQct2XG
         4byFUI66WpfWUiTtDT8/KQpqZACBX+sukLLskNP0V73gPEWZkPp/NHVZsTv3Rcwrr8Vt
         qHMcZkM+xOiGWXWWR/ZYl3ccVdiyjO3qJhnz5gLV0UFWQuZfv0N4wRssuK2oyXY7PYLP
         Ya7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791161478; x=1791766278;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RMHvbNRpAhPxfoH/Gr8Og40d44z3lI8rV/0oErD6Kn8=;
        b=AaNg4MZXYZ8sAnTGHAhJn/XbhdWNaXWWDYc922OOs+eVlotjzy5USKLH7g8NPM2WQ0
         VkJDl0vVmVlLOMhe9aTIK0hQI63t+KiGkkfILzTZfZS5QDqGXhZn9PilItDiHC3hJJ6F
         Ztt9pAfP62ntmsWfRtu4yDkGL7KwRNiYpu01vOXttVas93W31tE4CoYlkXdyMCp416pw
         mOBFoPUXHhDG8rIgbscRJ6r9Pq7zcNlDeIMpZ1yzFVn6A+IkTu1Xi2hWA+02pZ2lkFvk
         AEaaOtt9qHI9OkvkAfRbg1/FKJsHl6/YhNpsIN+LKpeatpfMR1/vW4P00xgl67qtdqZg
         VvoA==
X-Forwarded-Encrypted: i=1; AKwUvBw1wsQJVpX5CD0A/9/4v84Qa8mkzM+Qn0fx53rpWae1V+HUi5JVcJllV/4Z7F4k6ugMeCCzwAQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lfDRgKJ3rwqoE8FHS2F85Hysi1tqOu+f7zZlyC0QKd1eBLElJW
	rt674mHGFuUB08pA0S2L/FSwYxE70mqx3R4tPDyX/q7GT0opWzufXa3fZpKZmdcRYZpIOcKtmLS
	hiP2WwTV79xu1G3d+ePUWQ1Nvr2xk7EuIqZJWsmY/
X-Gm-Gg: AYBFou06Qw0JTktdh/HspOdz3qW3CqCRLFQV/YgunEKIvt2K2p24tXEx8MWDAXypqKy
	7kWcTTH6dJjK+5t1BHchRSYf/qcHsFABfY4sIEhOZpKOo5HSp2Ai69AsnYTjztc3C5x1o5u71qu
	ThE2iPusYSqzrTQAeiSkgN8JdwRCdwRkBKi61Qh9jeLla/mPD2624KpV3oVpru8QqfSJwSV7X9b
	jlhS4LsbdHdXCdZnkigIW89ndDZZslFOoOmUKH87vTmP3OfvCxy7B2sjiv/V9Ew4vuihePzvxay
	5LwADe5lDRk2ZkrFXfLjU+C6l7jdaHxsE+26W4oXDUVSbihc8/OCQRxEBWUm22t2SXw0Bcl6+XZ
	ZSCMQsu8n4+FKi+f60FYZxH7xOyJUthsXt+MQFybrIng4JRmnMUE0+6FmTiaIc0fZ1+2s2DOn+a
	pOLLmxwcBb3jUYBFBqbeCh+ZYx
X-Received: by 2002:a05:7022:b051:10b0:14e:d0ba:7590 with SMTP id
 a92af1059eb24-151c32ddbfdmr7827647c88.15.1791161477058; Sun, 04 Oct 2026
 17:51:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001204752.2572265-6-kuniyu@google.com> <179115494261.434549.1774667236869169411@kernel.org>
In-Reply-To: <179115494261.434549.1774667236869169411@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sun, 4 Oct 2026 17:51:05 -0700
X-Gm-Features: AclHuK8oQgamOKbMamm_KOuFA7EhpPxBfmawxld11BA_xaVJETPnD7p0U99e8cE
Message-ID: <CAAVpQUBNLiqTiA=e1sAj09uyNd_36giqGgMQrB0OBqhbJUtzyQ@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 5/6] ipv4: Batch rt_flush_dev() in netdev_run_todo().
To: netdev-bot+sashiko@kernel.org
Cc: dsahern@kernel.org, idosch@nvidia.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, carges@cloudflare.com, kuni1840@gmail.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 4, 2026 at 4:02=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wrot=
e:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] Missing RCU grace period between the device-pointer swap in
>   rt_flush_dev(NULL) and freeing the net_device.

Same with IPv6 comment.



>
> --
>
> ipv4: Batch rt_flush_dev() in netdev_run_todo().
>
> This patch takes the IPv4 uncached route flush out of the per-device
> unregister path. netdev_run_todo() now calls rt_flush_dev(NULL) once per
> batch, without RTNL. With a NULL dev, rt_flush_dev() moves every uncached
> route whose device has reached NETREG_UNREGISTERED over to
> blackhole_netdev.
>
> Closes: https://lore.kernel.org/netdev/20260917-hash-bucket-route-lists-v=
3-0-30493a37b6eb@cloudflare.com/
>
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index 0f87fd8c68923..4658e4e16d9dd 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
>
> [ ... ]
>
> > @@ -11871,6 +11872,9 @@ void netdev_run_todo(void)
> >               linkwatch_sync_dev(dev);
> >       }
> >
> > +     if (!list_empty(&list))
> > +             rt_flush_dev(NULL);
> > +
>
> [Severity: High]
>
> Is there still an RCU grace period between the rt->dst.dev swap and
> freeing the old net_device?
>
> Before this patch, fib_netdev_event()->rt_flush_dev(dev) did the swap
> during NETDEV_UNREGISTER. That was before the second synchronize_net() in
> unregister_netdevice_many_notify(), and before the rcu_barrier() at the
> top of netdev_run_todo(). So any RCU reader that had already loaded the
> old rt->dst.dev was done before the device could be freed.
>
> With this patch, the swap and the reference drop both happen after those
> calls:
>
> net/ipv4/route.c:rt_flush_dev() {
>     ...
>         rcu_assign_pointer(rt->dst.dev_rcu, blackhole_netdev);
>         netdev_ref_replace(rt_dev, blackhole_netdev,
>                            &rt->dst.dev_tracker, GFP_ATOMIC);
>     ...
> }
>
> If that drops the last extra reference, netdev_wait_allrefs_any() returns
> from its first check, before any rcu_barrier() or msleep():
>
>         list_for_each_entry(dev, list, todo_list)
>                 if (netdev_refcnt_read(dev) =3D=3D 1)
>                         return dev;
>
> netdev_run_todo() then goes straight on to priv_destructor, free_netdev()
> and kobject_put(). Some drivers instead call free_netdev() right after
> unregister_netdev() returns. Either way, netdev_release() frees the
> device without waiting:
>
>         /* no need to wait for rcu grace period:
>          * device is dead and about to be freed.
>          */
>         kfree(rcu_access_pointer(dev->ifalias));
>         kvfree(dev);
>
> The only synchronize_net() left on this path is in netdev_napi_exit(). It
> runs only when dev->napi_list is not empty, so most virtual devices skip
> it.
>
> Meanwhile, a sender whose socket has an uncached IPv4 route to this devic=
e
> in sk_dst_cache can be in sk_dst_check()->ipv4_dst_check()->rt_is_expired=
():
>
>         rcu_read_lock();
>         res =3D rth->rt_genid !=3D rt_genid_ipv4(dev_net_rcu(rth->dst.dev=
));
>         rcu_read_unlock();
>
> rt_flush_dev() does not mark the dst obsolete, so this check still runs.
> If the reader loads the old rth->dst.dev and is then preempted (under
> PREEMPT_RCU) or delayed while unregistration finishes, can it read
> dev->nd_net from freed memory? Other readers that use dst_dev_rcu() rely
> on RCU to keep the device alive in the same way.
>
> Deleting the device needs only CAP_NET_ADMIN in a user namespace's netns
> (for example "ip link del"), so an unprivileged user with userns can
> reach this path.
>
> The later patch "ipv6: Batch rt6_uncached_list_flush_dev() in
> netdev_run_todo()" seems to follow the same pattern for IPv6. At the end
> of the series, netdev_run_todo() still calls rt_flush_dev(NULL) and
> rt6_uncached_list_flush_dev(NULL) and goes directly into the free loop.
>
> Would a synchronize_net() after the flush calls in netdev_run_todo() be
> needed here, or is there something else that guarantees a grace period
> before the device is freed?
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261001204752.2572265-1-kuniyu%40google.com
