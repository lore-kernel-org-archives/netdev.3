Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361593B14A7
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 19:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790020689; cv=pass; b=ZBKJpOeyF/eExTBnpzsEkFKDgI1F6vit2bMpRFBzIqTsgmlYQDhdZ4DXtBbDQp4w44xbnLil/z0UVLseIRjT0S1WPzl8PgCa71xWEx8stNZS7EbMxlp3ycYfJnz3IHd7togFdZus04kVGXHeiIzyaXx4KNWUKth8pIKhrjpv6/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790020689; c=relaxed/simple;
	bh=aVIY0fcdB+TxzKraWgL56vzwXD30AFT+2P7KJPTHESQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XJ0z84rNEb0O7El/3jyXJRHwebYGuORBr8w2t4OKC1mbF8/vviL4sOQ+UK1WkpRQiHVgRgq/XOw4Qpzc46XEfdsQdiNv8Ly83ExGxFjd1pALzdBm/w1cRXg3xsuwEGRfulWdo0wXGCe/0H6dUUVH4aFaJC2+wU05AsXF4WZKuHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=W+Rm/4q2; arc=pass smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="W+Rm/4q2"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469b35611so2249374b3a.0
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 12:58:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790020685; cv=none;
        d=google.com; s=arc-20260327;
        b=c2PVdPi+j0Y1Mr5ZzGEr21j7cKF2Q/QXB3JU0u1m+tfLfG7rwNkZ0s0kdFYtRxtmXy
         w1fNXu48Ea3rKB8uRO6FEOi39jH/XAUXPsFByba0M3E+PwQSgpGQp/BPBTCqWMbB4ivy
         vX7tIPMi8d+8LWi+BmwYIMdycI55QgtfP6yd/88tEKYKix/YinIrTyRFZnsiXYnofi+i
         Y2ovVAGXbGiuXzullKZHN+gq83ZsOyeB+Hzy9HmRk04WX4WKhRs1+jFtCsPJfdGXCI9p
         ViAP36dWhUvUJPz+HWEFJVRxuLi+Ep5RvegvX1kIchL0t/YEY45c17lLWelVCcx6uHBI
         FMhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ir8YjhAZ4HBKfv4xjXY9QLHR7YUA9HcIqSwoU+P+HV0=;
        fh=tDbrLGbqPvwgsqhMqSHf8/Hhg24ZkP67/eddtzwcejI=;
        b=lL9ADFi1kLAOGHw6GkM2+rmUlcMcyD6z3lqaoYrYCtJPjRVYSQMllWv5GbihdlpFjs
         x5xkSDKxw+IrjvfZhlUbOhIgGQZP4xQTTHpx8rHb1ZRwJvKE6epy7x8uMju0AZKFrNY0
         ZYTlrvHUASWB2bX4+GkbuEtuqvEu3taVM0U1+AfRmFQj4gSoxF080fYYp7utFoDLd20T
         9S4c8915dABm1kAj+uzFvLe3ApRMssObL/jcqK/Mf3SRh15xr4fplolkHkexGy6MAWI6
         XSBqc7pMQn/Oax1OwmtDu6StyJUUcLnAa0WmWVl7PuZXaJWu02laLQXSx8GMDbsEpai8
         fs0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1790020685; x=1790625485; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ir8YjhAZ4HBKfv4xjXY9QLHR7YUA9HcIqSwoU+P+HV0=;
        b=W+Rm/4q2w64AQOlMdLST0LcN7wx+3eVZKaD2KVeA8dvyUcVr/UJvYi107uV0lFgkZT
         QFtImlvuWqvEXGxXB/B+SbUlOwc59wzphjpTJuAn8uYCzvKkLIWI5AdltnWOkqIVUXxS
         vu8rzMWMqpmlftNmbI+fnYSRyGhEb3nPupvIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790020685; x=1790625485;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ir8YjhAZ4HBKfv4xjXY9QLHR7YUA9HcIqSwoU+P+HV0=;
        b=zC1+ya/ktTKwrAx/om7dYqQN+iEUl/Zbhg1W0gdtJs2JdlkvvN2n2kwbJW8TDn8Uhm
         RFrrUesLg6QSp8D8ToLSd27ZQlNqCjUBbPeo/N0jf5c8NdgEZotzcyJwBTwqW7Q22nh+
         Y+TU6RVN2esJUnCbT0Kaboorychk7AbDIEI3ydYVeNTUdHrloIz0hScmijTomYQ4qD3T
         PiI8Swu0JNmn3LDaIit+Occb62YkBmYgxhUG3lDBST13iTsQX96NFrXqqdezZX8Ucse9
         iR5LQX37TlPruNAP3CvOXTm1tJ6RgmuvWI5Jo7SXlMiVaga/0o7eC9SBVxJQjozvcJrV
         R3UA==
X-Gm-Message-State: AFuF++kp59ek4JrhDm/J55FsmcISztlcGm9bcA5/JlZgqrOi65u3Ljms
	KBpnxhJ1KOHqrW9PhP+jKfFMe+ED+fCzWHv5EZksRvZJLzmEF6vab2a4ZtjeO0LPBOf+GiYJvEx
	9fE+tHbj6U8lJrk9VjDEA3jB7JEdGNHWbPQYJTk4I
X-Gm-Gg: AYBFou1BzPbMoRxFdE9k/soesk4v0jC3y2bflPqrDdYQPbqze8O7Y6NHWCpTVLQh/8j
	xu66tfaiuJu3o6NBX9Wf9IsHZAhePL0PDuWyuI14pr0KdkOyKVUOvpxDpuDmpXlpPVnofi1rMiZ
	/us6r6plzyZ7NDYzN3yM+g3ZmhKZy0MHqaOrDK+d46qYDokjm/OqnSaNkP0StxcRRMSmVL4oCgy
	1myIWPtZeBXf51154Owylf3vwO+LaeMAdTn/yri4UOciHkUVJtvyqeW+glLBohtbfm4FRdOinpS
	cYg0vHeW2syrS83z5XZaj2qiFX31QsKInqg5s1jB619iPJC+rT3Aox8Fu1wNFGYDLdPX2jj0zCJ
	bIEmtvaqWe7+B+P7oBKkSe6OiMSE1oWGtdTfd7w==
X-Received: by 2002:a05:6a00:c206:b0:877:ec64:dcfb with SMTP id
 d2e1a72fcca58-877ec64e61fmr7175019b3a.16.1790020684726; Mon, 21 Sep 2026
 12:58:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-9R8V.v1.20260921065103@mojatatu.com> <CANn89iLwYx8nCVf0pCEk_MmEiyC6kQaMwCQT9WkQVeeNzNQHqQ@mail.gmail.com>
In-Reply-To: <CANn89iLwYx8nCVf0pCEk_MmEiyC6kQaMwCQT9WkQVeeNzNQHqQ@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 21 Sep 2026 15:57:52 -0400
X-Gm-Features: AcwNN1U0TtrJlJtmcnLvTjC10KotZWlmoXxQK3RjKM6r8C0XrxC13TtwOf5HRGU
Message-ID: <CAM0EoMmzdRYFRvjvTEQM7QsdPRqiVmHg1pHVCObdMTjAKmZP5A@mail.gmail.com>
Subject: Re: [PATCH net] net: cap skb->queue_mapping when the tx queue is picked
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, 
	Vinicius Costa Gomes <vinicius.gomes@intel.com>, Simon Horman <horms@kernel.org>, 
	Victor Nogueira <victor@mojatatu.com>, Tonghao Zhang <xiangxia.m.yue@gmail.com>, 
	Zero Day Initiative <zdi-disclosures@trendmicro.com>, hybris <hybris@mojatatu.ai>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 10:42=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Mon, Sep 21, 2026 at 4:02=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:
> >
> > skbedit can set skb->queue_mapping and __dev_queue_xmit() honors it
> > through the skip_txqueue flag; netdev_tx_queue_mapping() clamps the
> > index it uses to select the netdev_queue but leaves the out-of-range
> > value in skb->queue_mapping.
> >
> > Every later consumer of skb_get_queue_mapping()/skb_get_tx_queue() on
> > that path then reads past the device's queues. Taprio's child array
> > q->qdiscs[] is sized to the device's queue count, so taprio_enqueue()
> > indexes past its allocation; qdisc_restart() likewise dereferences
> > dev->_tx[queue_mapping].
> >
> > A local user in a network namespace can redirect a packet from a device
> > with more TX queues to one with fewer (mirred action) after setting a
> > mapping valid only on the larger device. That reaches these reads and,
> > under KASAN, faults with "slab-out-of-bounds in taprio_enqueue".
> >
> > Store the clamped value back into skb->queue_mapping, as
> > netdev_core_pick_tx() already does for the mapping it picks, so the
> > whole egress path observes an in-range queue index.
> >
> > I have looked at other alternative places to put this "fix", none
> > appealing: an out-of-range queue_mapping is read by every consumer
> > on the xmit path, not just by taprio. For example, upon testing
> > an approach that only bounds-checked taprio_enqueue() I observed
> > the fault relocated to sch_direct_xmit()/qdisc_restart() instead
> > (because dev->_tx[queue_mapping] is still indexed with the raw value).
> > Another approach was to cap it in skbedit;  cannot work: the
> > redirect target, whose queue count bounds the mapping, is not known
> > when the action runs, and act_mirred sets skb->dev afterwards.
> > So the decision is to cap the value where it is first trusted and
> > result is it fixes all downstream readers at once.
> >
> > Conditions to recreate the bug: with CONFIG_NET_SCH_TAPRIO=3Dy,
> > CONFIG_NET_ACT_SKBEDIT=3Dy, CONFIG_NET_ACT_MIRRED=3Dy and KASAN enabled=
,
> > create a 3-queue dummy qa and a 2-queue dummy qb, put a taprio root on
> > qb, then on qa's clsact add matchall with "action skbedit queue_mapping
> > 2 pipe action mirred egress redirect dev qb" and send one packet out
> > qa. Mapping 2 is valid for qa but past qb's two-entry taprio child
> > array.
> >
> > Reproduction: reproducer ran on a KASAN build with panic_on_warn=3D1:
> > the unfixed control faults with "BUG: KASAN: slab-out-of-bounds in
> > taprio_enqueue", a read 0 bytes past a 16-byte taprio_init allocation,
> > and panics.
>
> I do not think this reproducer works. mirred egress redirect re-enters
> __dev_queue_xmit() for qb, which does netdev_xmit_skip_txqueue(false)
> before sch_handle_egress(). qb has no egress filter here, so
> netdev_tx_queue_mapping() is not called for qb at all, and
> netdev_core_pick_tx() rewrites skb->queue_mapping in range before
> taprio_enqueue() runs.
>

The repro from zdi works (and produced the kasan) - but i think you
caught a bad description on how to reproduce.
It reads like it is two devices but it is infact 3:

  qa (3 queues) - clsact egress matchall:
          action skbedit queue_mapping 2 pipe
           action mirred egress redirect dev qb
  qb (2 queues, taprio root) - clsact egress matchall:
       action mirred egress mirror dev qc
  qc (1 queue) - clsact egress matchall:
       action skbedit queue_mapping 0 pipe

The KASAN trace shows exactly that stack (tcf_mirred_act ->
tcf_skbedit_act on qc, then taprio_enqueue on the outer qb xmit).

At a minimum, the commit log needs fixing to describe as above:

> I suspect the real issue is that the per-cpu flag is cleared *before*
> sch_handle_egress(), so a nested dev_queue_xmit() (mirred mirror, or a
> drop after skbedit) can set it and have the *outer* __dev_queue_xmit()
> consume it, for an skb that never went through skbedit.

That could be the root cause or part of it....

> For a forwarded
> packet, skb->queue_mapping is then still skb_record_rx_queue()'s
> rx_queue + 1 from the ingress NIC. That reaches taprio with a garbage
> index, and clamping it only hides the fact that an innocent packet got
> pinned to a random TX queue.
>
> If that is confirmed, I would rather consume the flag where it is read:
>
>     skip_txq =3D netdev_xmit_txqueue_skipped();
>     netdev_xmit_skip_txqueue(false);
>
> right after sch_handle_egress(), dropping the pre-clear. Same number of
> stores, and the request can no longer escape the xmit that set it.
>

I believe your suggestion would fix the poc repro but opens other issues.

How about: save it, clear it before sch_handle_egress(), and restore
it on every exit? Something like:

        skip_txq =3D netdev_xmit_txqueue_skipped();
        netdev_xmit_skip_txqueue(false);
        ...
        skb =3D sch_handle_egress(skb, &rc, dev);
        if (!skb) {
                netdev_xmit_skip_txqueue(skip_txq);
                goto out;
        }
        ...
        if (netdev_xmit_txqueue_skipped())
                txq =3D netdev_tx_queue_mapping(dev, skb);
        netdev_xmit_skip_txqueue(skip_txq);


> Also, taprio_enqueue() is the only qdisc indexing a num_tx_queues sized
> array with skb->queue_mapping. A bounds check there is free and worth
> having regardless.

Likely missing something: how will taprio code be hit if we cover the
egress direction hole above?

cheers,
jamal
