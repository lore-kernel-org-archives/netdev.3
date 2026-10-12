Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC652361DA7
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 23:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791849183; cv=pass; b=RUDp0tTbCwE+2VY5yef3pQXxAabOj93Gz5oYFd/cXmj47KpY4pLYtgKSfCd4QI9Qiv/ba47n1UFC+mw7WmosQv/e4nf5fEivucV9c+FnBi/qvXV704FsRs9LYVcNLVQPMDuBxvMA6Yp+wTx6g05LS+eEuPusUv8cCz59J19X6i0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791849183; c=relaxed/simple;
	bh=luQOKTSz4OF/H0xSObc8tOzedkb1dvzfqEyO1NHqM6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A+cNIaleQInK7YHqNxX3aajoqq4V82L6/ss+r6tu1PhsWxJLxnv74A81jMubGBwbljEyRe0QGuwJJ2P2Of6Jkmsg1DgeN69SA7yVtP1sX3eGR1AU6AHAtW7cW4WRbRFp0OHaAoQI8HwWlGhyM9TR3xvS9ze2etm8ymc1Lk099rE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nuro.ai; spf=pass smtp.mailfrom=nuro.ai; dkim=pass (2048-bit key) header.d=nuro.ai header.i=@nuro.ai header.b=dgdiSD0g; arc=pass smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nuro.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuro.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuro.ai header.i=@nuro.ai header.b="dgdiSD0g"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-35834f72d94so4189081eec.0
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 16:53:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791849181; cv=none;
        d=google.com; s=arc-20260327;
        b=RtkNMPtgTyB9p78aErmtTFT5GyCDgv5LR9hS8VVbOT7x9QwskjzWcYZliV19kiBGLb
         SqUXPjJ7051+/WqTQoy/qXnlzVRb+mTHnnS9/gUFv2Iw/1YklNHxi6TJNKMGItZuPLSi
         Afy1ykI4r9bCzlbNgbDVIdadymm0AC8YGKid4P6L30puzbf/v7EU09EdScVpGVU/b95d
         Bg/2N0ehkqdkllZERfRaItLCwnQipFi5z7eeBa3sYxrqTaMNdwATyNyLkOkDmRctO6+t
         xHn/pjO06Sm+hpZE1q4qhQXIBWYBtZFLI3e/goTgmiYAXP8QpLkD19CDHz81GAWi2Pfw
         pgJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ovZiNJC/Y+4dwZomOEpDxjKAXYGbJWrwmtb8TaD7amg=;
        fh=J1aAaIKQ4tuTA4v9yNeceEMhdaac3ZN/6Tm04LusH7I=;
        b=L1uGkY6v0YrvmevkvdGOlIwdd7VQWk9STgCpL2n8HG/rxyfk+WCjNzWFsBF4QQHpvd
         DZ9qcdEilOsODBIr7sVmR6KpW9VmbWGIrg42yMgnmBPDkYWyxlhXpikwBR8Fo3i1EUWS
         8eO4CCuMF8SYJORlgCcYtgAOi/vO0BT5tgE9hNWhyg7i2HJ0eD9V7EkAkp11DE9+Mfmi
         ocvCx0t8Kmlu4gyIeadk2fLubARfee5/0j4G/kahBXyNPU2ECQXm0rbY1LvDRvcrQHS2
         CvpqL0N5jcgFWbRn4NvaQ0x1jV9cE1/rhbAfnw/j0Z99z0odP1x95tBByXDBSeks0ANQ
         G6WA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nuro.ai; s=google; t=1791849181; x=1792453981; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ovZiNJC/Y+4dwZomOEpDxjKAXYGbJWrwmtb8TaD7amg=;
        b=dgdiSD0gcwXB5ZiajRkA9dsGLzIi3gWEpDp4dEN6rOn1XwJSPSQIreo4iEBTr5mJEm
         8xkmM/lcOwF1Z4Qn0XlisjONDaS+erHrUHM7EZzLsr+2PEp4v/j4sWRSwGpNsYVMlVsC
         R1+JplA/s3WJFIyiSlhzGez5r6q1M+Lqx/dJbz1YNFtkfGlgWLAQL+lCEsUhyi2RXup/
         WU2tko13UxkXPjC2cX9NWR1RjkQNl2HAjtthmqUoYdE1dGD/+QhMxYr/mO5ZUuF4xYL4
         Ffv34c1/Oonqs0dad2+bH+bx/YZnNWohTlk0GaRe7kUiB+8xUozvNPvthVPmdwnIzBVP
         tsvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791849181; x=1792453981;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ovZiNJC/Y+4dwZomOEpDxjKAXYGbJWrwmtb8TaD7amg=;
        b=TWbon1q2iw71t/Pdkyh8oFqRtmgQ6m3ibjwQM8n3S/QTKpU2mZ9GTHr5HPQ0gnTSvn
         tfBNJ0hjIjCBDNAeLklt0bg6VQ52BXdpLmwVklfbQ9TauBCH5ThcXgEY5ZwwkGnW0RXb
         GKLbOgDCWonAUAoqETP67ZBmeBUI915z4ufxjCmenUCena87x/mju9GummpXTnuHbgfv
         4WhJPw7pD6/NoMxRhdHe61OLPGmf0sqLjyMPgUC+uSpCRhnd57QRs4VbJf2zjFbSa8gD
         wF+8AgzIuZ4TaodXWAv3hWhJ4ayi5nGRNgwaoqGAOyCJWOvH65zxcOuW2VofQVB2V6+k
         fElA==
X-Gm-Message-State: AFq9FYKf9u1VF9nBjmgxxIEPvH12sdkguUgfcZ2y2w/BApZJKzPZLn3H
	Mkt0ZL7rSWxD6vh3xncBEULs4DntBV5QWlZXe5qj7KV84ySzjRck6WCGZkmOolXmmMVaea3Fn2e
	+WTYmg3lz2EwIogkNAiIsAXuabaXtUc5PkHkSPsYZUA==
X-Gm-Gg: AYBFou3xl2JIYl9xhdWSCgyO6msD9EtNANMGpvrNephrGL8D6eOdoameT4mVCpukDZ6
	QMBLrK/qd/77iNzpEv+IT2GrQm/8Vj/LgvSpqKQd2LsrIaJj3Dhh2COxhSLnSY0dMo1WhZtprY2
	x5RZap9MZCnFZITIJCBba420p2X6LJD5r7b7iApGn4ammEpTIJ7KSulhIbBjhymfO2k0Q1U7MS9
	fGVU+U+L7iPU5yR/AcFbsLyyVafhS5JEA9tXd+7XlR93Ct4D9c444oZAYk7M6NJjVgXys0sY/3q
	UyeLClrsggfwNUAqbu1LNfikdVPDKu8+/f2bCPDsMGZjpLvWj2qBzTc=
X-Received: by 2002:a05:7300:2c01:b0:35c:1567:7966 with SMTP id
 5a478bee46e88-35c15677c5dmr1792809eec.27.1791849180900; Mon, 12 Oct 2026
 16:53:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008220256.1844072-1-jkain@nuro.ai> <179184768524.434549.10991307098335983416@kernel.org>
In-Reply-To: <179184768524.434549.10991307098335983416@kernel.org>
From: Joseph Kain <jkain@nuro.ai>
Date: Mon, 12 Oct 2026 16:52:49 -0700
X-Gm-Features: AclHuK8ZnjML-asNI4vPGyHzlcAfxhgMbd2pbBpBd-oWVB0gwQBPJx9by3vW56M
Message-ID: <CA+Y90PjY2ysL5xGwn42pUszZ5Sbd37JmbeN7AREp-HwJ6p3BNg@mail.gmail.com>
Subject: Re: [PATCH net v2] net: do not let defer_count outlive an empty defer_list
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, edumazet@kernel.org, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, bigeasy@linutronix.de, 
	clrkwllms@kernel.org, rostedt@goodmis.org, linux-rt-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 4:28=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 =C2=B7 Low: 0 (1)
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] The patch only partly fixes a stranded defer_count.
>
> Pre-existing issues:
> - [Low] The skb_defer_max documentation and the sysctl range do not match
>   how the counter works.
>
> --
>
> net: do not let defer_count outlive an empty defer_list
>
> This patch changes __skb_defer_free_flush() so that it drains the
> defer_list before it clears defer_count. It also clears defer_count on th=
e
> empty-list path. The goal is to stop a stale counter from turning off
> deferred skb freeing for a (cpu, node) pair until reboot.
>
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index e76762e29360e..e847e243a692e 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -6938,10 +6938,13 @@ static void __skb_defer_free_flush(struct skb_d=
efer_node *sdn, int budget)
> >       struct llist_node *free_list;
> >       struct sk_buff *skb, *next;
> >
> > -     if (llist_empty(&sdn->defer_list))
> > +     if (llist_empty(&sdn->defer_list)) {
> > +             if (unlikely(atomic_long_read(&sdn->defer_count)))
> > +                     atomic_long_set(&sdn->defer_count, 0);
> >               return;
>
> [Severity: High]
> Does this recovery path ever run on a CPU whose counter is stranded?
>
> The counter is only cleared when the owner CPU calls
> __skb_defer_free_flush() itself. skb_defer_free_flush() only walks the
> this_cpu_ptr() sdns. It is called from net_rx_action(),
> napi_threaded_poll_loop() and busy-poll.
>
> The producer side in skb_attempt_defer_free() is unchanged:
>
> net/core/skbuff.c:skb_attempt_defer_free() {
>     ...
>         defer_count =3D atomic_long_inc_return(&sdn->defer_count);
>
>         if (defer_count >=3D defer_max)
>                 goto nodefer;
>     ...
>         /* Send an IPI every time queue reaches half capacity. */
>         kick =3D (defer_count - 1) =3D=3D (defer_max >> 1);
>     ...
>         if (unlikely(kick))
>                 kick_defer_list_purge(cpu);
> }
>
> The reject path keeps the increment and never reaches
> kick_defer_list_purge(). Once the counter is at or above defer_max, no
> producer schedules a flush on the owner CPU.
>
> Some CPUs only get NET_RX softirq through these kicks. One example is an
> application CPU that sends TCP or UDP while NIC IRQs are pinned to
> housekeeping CPUs and RPS/RFS is off. napi_consume_skb() frees its TX
> skbs in a remote TX-completion NAPI. That path calls
> skb_attempt_defer_free() because skb->alloc_cpu !=3D smp_processor_id().
>
> On such a CPU, wouldn't the reproducer from the commit message still
> strand the counter with this patch applied?
>
>   sysctl -w net.core.skb_defer_max=3D1
>   sysctl -w net.core.skb_defer_max=3D128
>
> The list is empty and the counter is large. Nothing calls
> __skb_defer_free_flush() on that CPU, so the new clear never runs. When
> the limit changes, proc_do_skb_defer_max() neither resets the counters
> nor schedules a flush.
>
> The same applies if the limit is lowered below the current count before
> the half-capacity kick fires, for example from 128 to 32 with the counter
> at 40. The queued skbs would then stay on a kick-only CPU's list
> indefinitely.
>
> The commit message says:
>
>   "Clear the counter on the empty-list path as well, so no count can
>   outlive an empty list and an already-stranded counter recovers."
>
> Does that hold when the owner CPU never runs net_rx_action() on its own?
> The cross-CPU TCP RX test would not show this case, because there the
> alloc_cpu is the NAPI CPU.
>
> Could the producer side change as well? One option is not to leave the
> increment in place on reject, either by undoing it or by checking before
> incrementing. Another is to make sure the owner CPU gets one kick when
> the limit is reached.
>
> > -     atomic_long_set(&sdn->defer_count, 0);
> > +     }
> >       free_list =3D llist_del_all(&sdn->defer_list);
> > +     atomic_long_set(&sdn->defer_count, 0);
>
> [Severity: Low]
> This is a pre-existing issue, but the skb_defer_max documentation and the
> sysctl range don't match how the counter works.
>
> Documentation/admin-guide/sysctl/net.rst says:
>
>   Max size (in skbs) of the per-cpu list of skbs being freed
>   by the cpu which allocated them.
>
> skb_attempt_defer_free() increments before it checks
> defer_count >=3D defer_max, so at most defer_max - 1 skbs are queued. The
> list is also per (cpu, node), not per cpu. The doc also doesn't say that =
0
> turns deferral off, which proc_do_skb_defer_max() handles through
> skb_defer_disable_key.
>
> The ctl_table entry has .extra1 =3D SYSCTL_ZERO and no .extra2, so 1 and =
2
> are accepted. With those values, this half-capacity kick never fires:
>
>         kick =3D (defer_count - 1) =3D=3D (defer_max >> 1);
>
> With 1, nothing is queued and the counter keeps growing. With 2, one skb
> is queued and waits until the owner CPU runs NET_RX on its own.
>
> One part of this is new with this patch. A producer that lands between
> llist_del_all() and atomic_long_set() now leaves its skb queued but not
> counted. The list can therefore briefly grow past defer_max - 1. The
> commit message covers this ("bounded by the producers in flight").
>
> Could a short comment here say that this is intentional? The similar
> qdisc path in __dev_xmit_skb() has one:
>
>         /* There is a small race because we clear defer_count not atomica=
lly
>          * with the prior llist_del_all(). This means defer_list could gr=
ow
>          * over qdisc_max_burst.
>          */
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261008220256.1844072-1-jkain%40nuro.ai

Thank you, this is good feedback.  I will address this tomorrow in a v3 by
undoing the increment on the reject path instead and removing the
empty-list clear from v2 as it will become redundant.

--
Joseph Kain
