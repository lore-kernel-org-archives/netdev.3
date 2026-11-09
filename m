Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794224663;
	b=WS4GSlie2ZANNb4BAAsaZxLO0MPkA6NaOGzUxrPPuJnD+UqrJAPtB+UJgpBmdiy03K/V
	 d0kbKk7E0O/h6qhHh3MFi58wWUqlZWDxriqwIJY6O7BHa+XfeZ0WGTBdhB3l6BWo8xU4E
	 boGibyHhudvK3HRS3aKIXJkr385Y8goXitZpiJKSle/t2gd5oqmwyuLuO4kizwuFcbhcc
	 +nj+dqy4v2MwnLJJc1opKlMG1+fQGv3rlEfdrcrBPCbdhEhIE9aXe1yy1986DaDm2lkhN
	 XcATKo4t7goeeroXBlfWAI5zEMZ4zvYqkj/RFB8SCpRiMFVscd99Vpuht3aZ51yEPmA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794224663;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=Tudkjez28RMXxzBWfLg4pArawZDNqT2bA2wVkoHQwkA=;
	b=f+3HNqWR3u2rcj0rgT4xwzOdw2IjjDg4+hEWuWB93+hy5Ny5GoIozg891Uqgx0rHZd/Q
	 KJ/8vsmT3sw7Qu7aoMwAwIx5kM+zJMzIdLsedu6sceCmhujCjX9U3qUgfPTTVa8iacVHX
	 STbfYRSpgPtrxZv1eDnxmLNiz4KHBR9q2+QWquPi1pUsQ8+JX+IjrrdcAn+hnXa00bc0d
	 gohQwFqelTyo5WMFC0kCGEcToQGkGTHKBynocd6ozHnP90il0b8y50Dh+0zt0TInlUL0/
	 2LwIP/S3xsdiWkIDzYBvSYiFBKvomLN3wIPPbJ8o946uvqWkVzhLIyGdK7pMxxjNfJA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=ZQe0wgkh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.46
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A77606A31C
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 11:44:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2A77606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=ZQe0wgkh
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-67c0bd676eeso627351d50.3
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 03:44:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794224661; cv=none;
        d=google.com; s=arc-20260327;
        b=CvXhlPQxAPePleSAudd4hDGtGlhNBvc4tlxXwEUrUbkwdvs/JHKHq/QfyUNuGujrta
         21+7ZIdaUJk56lIh+4h877wpAT7aMBJ3Z6PmbKUYEwS3HQnMw/OopasUo0DiacVQmEZj
         OaNctct+SEx/BrIqSwcVw6yCtqviylBcZVwo1R6C9GS7sN8/hd0qCkIRCLOFXNl5Zg7x
         Thb819EiP0PsnfXSuRrjtLofTzAJwZAhWaRPhCi+C75AqPbu1lBzOkgpAHBblUb/0aPZ
         LQGaKPG+fckAUn9CQ9YiyWLgC8Ul3fGc7+etf1JTczhDg4Qi/f+yLGAGrE2+kQTZMd68
         JnNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Tudkjez28RMXxzBWfLg4pArawZDNqT2bA2wVkoHQwkA=;
        fh=8RmJ1TkJL7iN+NvlkjYMunY5KmL2jMvo7FSORUvpFYc=;
        b=clTdmJ7aSQLAJUQ6biIq+JOKzxsgeHg63LQE7MvXZozrXfuV3vkvQJjyv06ompgsIW
         xEbAMpXgmW9FRGk4Q+On743EQsSwioYIAjhlCX0BYz+9BeglrW0FFJ1/aSZR0QDzmel/
         fSSBdX02Rlp5SJ5GQUR500MxkqrX/J92CKrHKVvhjjTQ6+Jr93E93KGsXzCeU3aMJ/07
         Hnywoq54xzEpqJEkYfAxFhLRwTb7v+qHEUp5BgFKU+MoXTKg3th3xk4GS+4fKRv6HKQ7
         3uq+dWXIX+ZYx1RyAt27oRw22o4CUgA/EhvZJElXu2Tcrl6w144fNQCeaNnPhkh9pf7P
         bBWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1794224661; x=1794829461; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Tudkjez28RMXxzBWfLg4pArawZDNqT2bA2wVkoHQwkA=;
        b=ZQe0wgkh8TKbL38Yd857vJAYjnRpvdOqiSILvwF9KMhtnugEymoI3Pq2wBpyH3gY6w
         4ymdkZXFMAxEql/8BappkuDkki9YnXxESGCXp0UrSmvwDvEAZ3dyalYLR1JYy3uGEFOa
         B+x811mT/wl5RrnDencOUkObB42bB9GoyCAvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794224661; x=1794829461;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tudkjez28RMXxzBWfLg4pArawZDNqT2bA2wVkoHQwkA=;
        b=FwzuG3gZEkrxJHMPGouCsvUbjXuGI3wonmYqK92622FvbApi/Q8EX9wXHPjrI/xPcC
         6WJ7rQaM/CVcGWNCQyodVIasfJUEICE1WRKS/uGQRVvCmcGC/WySq8O3cJ3r7mqrG51c
         /XVDSEWy4pLvVRubKO+Cigt36FFitMd6gggXxdIH5qiKm4Pm/bxDe9vck8y40Vb1xPLq
         aUXyCA7dcc2GOIiHjcsP0t1KjBEbXmFP7uLzwgUL8GSeSgLEE0d1ZzA7fwmWAtd1LE5j
         vAh/4YYdehvaBI9gcm9rNHtWugrnovB9W8eN/ZjvNjuSGTXm9ZpkGpUQa+dLOPnVwYe9
         KFWQ==
X-Gm-Message-State: APuU4Z+eEckykgJEgYHNXHfuURP6VVyb7V1rCKKlUmF5U7vUbBK6ufe7
	srNqgLgOpNqLdDaijlo4LI2DkwusropWS/Q6j/mb25aDHMXzM1C07UaHJ9qivJ43dJmpr1kZRln
	9kvyGIoC4p+fVDmZKaYYOFf2aNhphHCOMqZLnkc8i
X-Gm-Gg: AYBFou1MXHqtmc3Vc1qTZxowmC5lN9MVWP/Sq0txUyCz2GJTUhXWzdgmgLbzE1exqTr
	h0eWp72WGirPQ6vjrLaTY6BeIaqP9TsFOMUknYceWuF8qR/q8v7356UziTAa7YGPIQ+P2esXtzU
	3DMoEXBcNdYtZYiS43G5f+rcts4hcbqUh/tMpAlGdmDWCEvCSUKzVHQx6vu22GtrxTIPXd8xb6C
	F6M+JlmzV7zvAubN90uTR/UtpOuwgbCpXwUxRXAU7SYr+wu+zNOL7WJZtOj0ax1ofCGkF1Femxs
	2AfyQ+TjZwu/IyLYH5Up/tUWNYplCt/PPe3qM1WajFtKa8+XSirEyr73Og3QLdyDJ+4/oHLoU36
	6ZsbAoqzQ05bWG4O8TZjtyv0HP5wqyLqLlCPzqk45OB7VQuap5QMcHYkPg5u85eISzjQVNft8jQ
	11XsoWZBCDhUv4rFI=
X-Received: by 2002:a05:690e:191c:b0:67c:295d:5836 with SMTP id
 956f58d0204a3-67c3d96bfd4mr2294772d50.17.1794224660803; Mon, 09 Nov 2026
 03:44:20 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <QDISC-6HS9.v3.r0.20261103062649-2@mojatatu.com> <179406458348.994134.6942745655171316289@kernel.org>
In-Reply-To: <179406458348.994134.6942745655171316289@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 9 Nov 2026 06:44:09 -0500
X-Gm-Features: AclHuK8mvVB_TGgtxN6qXQS6xYcYAMbCidFBmEaOpBy02Kh9E4kbueKy3al45cY
Message-ID: <CAM0EoMnprPstSvZEj+FKtK_kM6JB-jkrhYRwSd_mmN3WAMFQFQ@mail.gmail.com>
Subject: Re: [PATCH net v3 2/2] net/sched: sch_teql: keep skb->dev consistent
 on the arp-queue path
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, victor@mojatatu.com, jiri@resnulli.us, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, stable@vger.kernel.org, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 7, 2026 at 10:16=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 1
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] The new gate in neigh_update_process_arp_queue()
>   (net/core/neighbour.c), `if (!n1->dev->header_ops) skb->dev =3D=E2=80=
=A6
> - [Low] The comment added in neigh_update_process_arp_queue()
>   (net/core/neighbour.c), '/* headerless outputs (teql, shaper) transmit=
=E2=80=A6
>

I think i missed responding to this one. Sashiko-nipa responses are
very erratic. For some threads (not mine) a review shows up 2-3 days
later. For mine the average time seems to be 7 days and sometimes a vN
review appears a few days later after a vN+1.

Summary: I will not be spinning anything for this series since there
are no new code change requirements. I have addressed the
neigh_update_process_arp_queue() issue as a separate (producer) issue
in the past; it's a separate net-next focusing on producers. The
comment (Low) i would have rectified if there was something meaningful
to make me respin.

cheers,
jamal

> --
>
> net/sched: sch_teql: keep skb->dev consistent on the arp-queue path
>
> The commit sets skb->dev to the teql slave before teql_resolve(). This
> means an skb parked on the slave's arp_queue no longer points at a master
> that teql_exit() can free on module unload. It also changes
> neigh_update_process_arp_queue() to set skb->dev to the top-level
> neighbour's device when that device has no header_ops, so the skb goes
> back through teql_master_xmit().
>
> Link: https://lore.kernel.org/netdev/20260824115928.4099988-1-victor@moja=
tatu.com/
> Link: https://lore.kernel.org/netdev/20261026160747.283702-1-horms@kernel=
.org/
> Link: https://lore.kernel.org/netdev/20261031165925.780930-1-horms@kernel=
.org/
> Link: https://lore.kernel.org/netdev/179363700308.3131.117781795382902514=
34@kernel.org/
>
> > diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> > index d6e9c7c59a892..541cf699abae4 100644
> > --- a/net/core/neighbour.c
> > +++ b/net/core/neighbour.c
> > @@ -1339,6 +1339,9 @@ static void neigh_update_process_arp_queue(struct=
 neighbour *neigh)
> >                       if (n2)
> >                               n1 =3D n2;
> >               }
> > +             /* headerless outputs (teql, shaper) transmit on skb->dev=
 */
>
> [Severity: Low]
> This isn't a bug, but the shaper driver is no longer in the tree. There
> is no entry for it in drivers/net/Makefile, and the older comment block
> just above also names it.
>
> Would it be clearer to name in-tree devices this gate is meant for, such
> as teql and eql?
>
> > +             if (!n1->dev->header_ops)
> > +                     skb->dev =3D n1->dev;
> > +             READ_ONCE(n1->output)(n1, skb);
>
> [Severity: Medium]
> This gate is in generic neighbour code, and it doesn't check whether
> sch_teql parked the skb. n1 comes from the skb's retained dst via
> dst_neigh_lookup_skb().
>
> Can it fire for any skb parked on an arp_queue whose original route uses
> a device with NULL header_ops? Examples include ppp, geneve in L3 mode,
> vxlan when header_ops is NULL, rmnet, qmi_wwan, mhi_net, ipa, iosm,
> mhi_wwan_mbim, eql and teql.
>
> Two producers park skbs on another device's neighbour while keeping the
> original dst.
>
> The first is nft_fwd_neigh_eval(), which nft_fwd_validate() allows on
> NF_NETDEV_EGRESS:
>
>         ip_decrease_ttl(iph);
>         ...
>         skb->dev =3D dev;
>         skb_clear_tstamp(skb);
>
>         nf_dev_xmit_recursion_inc();
>         neigh_xmit(neigh_table, dev, addr, skb);
>
> The second is bpf_redirect_neigh() with an explicit nexthop.
> __bpf_redirect_neigh_v4() replaces the dst only when nh =3D=3D NULL:
>
>         if (!nh) {
>         ...
>                 skb_dst_drop(skb);
>                 skb_dst_set(skb, &rt->dst);
>         }
>
> bpf_out_neigh_v4() then sets skb->dev to the target and calls
> neigh_output() with the old dst still attached.
>
> When the target device X's neighbour resolves, the drain takes this path
> (Y is the original route device):
>
> neigh_update_process_arp_queue()
>   dst_neigh_lookup_skb()  -> Y's neighbour (Y has no header_ops)
>   skb->dev =3D Y
>   neigh_direct_output()
>     dev_queue_xmit() on Y
>
> Does this run Y's egress hooks a second time? In __dev_queue_xmit(),
> nf_hook_egress() runs before nf_skip_egress(skb, true) is set, so the
> nft egress chain runs again. sch_handle_egress() and tc BPF also run
> again.
>
> For nft fwd, this would decrement TTL/hop_limit twice. A packet that
> reaches Y's egress with TTL 2 would then be dropped.
>
> Counters, quotas and limits would also be applied twice. A tc BPF program
> that encapsulates could encapsulate twice. If the second pass gives a
> different verdict, the packet would leave through Y and not through the
> device it was forwarded to.
>
> Before this patch these skbs went out X without a link header, which was
> also wrong. Running Y's egress hooks a second time is new, though.
>
> The commit message acknowledges this:
>
>   "Those forwards supply their own device and nexthop and do not consult
>   the retained dst, so dropping it at those two sites is where that is
>   fixed; that is a separate change to the producers, not part of this
>   series."
>
> The patch is tagged Cc: stable. Would stable trees get the new behaviour
> without the producer-side fix?
>
> Should the dst drop in nft_fwd_neigh_eval() and in the bpf_redirect_neigh=
()
> explicit nexthop path go in the same series as this change?
>
> >               if (n2)
> >                       neigh_release(n2);
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/QDISC-6HS9.v3.r0.20261103062649%40mojatatu.com
