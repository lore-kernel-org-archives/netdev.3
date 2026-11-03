Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793694826;
	b=nhQ6ep3d47FM01hbKvoF0Y3O3Xp1UMMaxpMoegT9HojNqY6EjQ0+Kg4sCbgrlh+feAzs
	 UQYZxKkWOOhK5LgBidjakgmJBLX5meVJZIUOrtMgcsDedZUfTguXm2rbNJPBoE8gzQ5sR
	 tUb5PjpAj7t0puV/A0txHvVqMvO2pFULcjzMRuYs3tzDhyOmkERR7SGUofN+dEBryzCot
	 lwOO/w+qyadzhNuzlu1mObm4iWIn5vsq5MAD02HTFKjyC+DWLoKy4Z5QizTkpw7A/Yhar
	 3IPFwIzM8oxjwKJQCJlJTOkWiC5gAD6WJG2jfQgNpL5pBSIhXbv7EIovCDN73vbNHaA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793694826;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=HwF4S5bxm2j9EzIyz1SC/J8IudB+3qt9yXUwER1aUJM=;
	b=lgdA6pFN33VtuKqB4b/rLdT9e1HVdfIFRTq8gry7in05vGci9letzhZZIrfMcFgYDj1K
	 01R5qJ0YsLsUJ7eW0J24ltdxyHI5OXRWPFy5dqxmGf9QKAwq/AOtAilz1jC1htcJJLwLe
	 PFH0Eabq777Vo1Y80DCD0hQ9PNjyD3yvLUAjXMTeFP31ufNqt5ZjUcNSuPtlsjGAm5VxL
	 W4IlVAHy7AwGlWDEdL6u5d4j7B8PNnnBMK0I3k5wv1M56/m7d1aChhT3VdBbIemXTcpNd
	 79zDJPvdhPWld9Txe9pGmCGtsS/FkrbjuqofNat5Oy5CgCY0dx5E3hmpfNxvjyQ2H3Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VpKRh5iM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438366076B93
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 08:33:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 438366076B93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VpKRh5iM
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3adac5c10e3so2409923a91.0
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 00:33:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793694826; cv=none;
        d=google.com; s=arc-20260327;
        b=Wn9pXwzb8LfIuO+XmQ5Y2URnZ9gTstYk6obR/nW8hQspXQ9RtwDGCH0GtkYkboJDDo
         TQJwPMDsQvujGikGdbOyxg+OD1nJ79llujKtT3fMasf19M9xE9Bq/5sNeaIQnYEH9RrI
         v+8OBQRPkI1S/+WTWl6S6GahCBptLg+EqMY9N+mkBTRiME3icAU12lroWLlbSJi98X3G
         IK+t+lBf5pBuWjqj615oippJbH8wmUYZknpCJ3o65rQX9SDN91T6SMxxyvUCPhXzSMqZ
         Y8UOqPY9JFqxTtK/Gf2WV2FKT8slW5vYRWfGSNRu6wAkngi7CX3FYHMZ8KH0+3MLgw5s
         SBgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HwF4S5bxm2j9EzIyz1SC/J8IudB+3qt9yXUwER1aUJM=;
        fh=JFmbBCmB9bbifCEdc7ddvrre74CimJI6kyJnoYuR+0o=;
        b=s4tsOWIyZW6m+bjA+3ovXAHxS+Ii4MpqYAkKaPTBF7DKY+1VS479tKXkwyo8jI5Fgo
         5fkrjx6jYCwuigueEWJUOlnwEeJ/HmWuL4TJRCOj0CYci4vDzaeQ4yx9RSArY3Qtss+j
         eP1vXVtqkT/IFvvkIytYYHUQbTu7gery4UMyjiPkG/biuH9923KNdfkLVhZviKOeZcJj
         e0VN1DxZ0L7s/YTwC49jceFvmUbHxyGowrAV/DsWFBf3f9EoArf2FZZb/Z7HFBQuQMJ4
         WugBgVCo9rpFWpEfDTL7lPvmCgO/S4Y7YXIJ1Elr6upJSurtFJgOX41VKYlObACZ9NQU
         K8CQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793694826; x=1794299626; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HwF4S5bxm2j9EzIyz1SC/J8IudB+3qt9yXUwER1aUJM=;
        b=VpKRh5iMMk/uDrxhCUU+vgVGN8WWGzbo1owdw++3mPZSar70R5Xp3muHRKWC4ssocD
         IsNAJjccanDWxOjWHzQVA31b8YG1buwVNtZnkM4Voz2Ng4zrcFn5pQcZ2WaW0Pucq8wu
         mfqEBP+8X+Abmtx2BhkgfuVox5Reino5rFZUC6QDOR+GwjRRarjUxEFv5HPN7vCbFRWl
         AoGh4tc7INzidBgkx6NDuEB4l1Lo5bUQczEhKFdGeGn+0wDZsOgG+6ujrNPxXdQlfQgW
         7CkruBMfViCHcqnqyQvMKV4BNUg/MOuTHYmUZCdVWu3HU/Wl+juFJ4AAxMATWj7OIDb+
         CsWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793694826; x=1794299626;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HwF4S5bxm2j9EzIyz1SC/J8IudB+3qt9yXUwER1aUJM=;
        b=2SMesjxwjt6Mey6U9IJSswKbHDyZrLQ4yPPTbGFdlnRPr892kB1T6jSKW9fMQ5t+Qe
         2m0F1lGwsePmksz3MBzzI+4fyn8r874lMeGlgvMHyKnadibNjj2izF+8wQmyVTuYetIn
         S1rHsKzR139WU0DMwrEV3Y0Ixxhpt3iwxbUx1aG+qyXE7aYoyHuVbop7tJ1Pqj8TT/Mx
         jW+d9LN9UdBVjOkPT18Uq7ZQjSfI1CaW+MQBKlK0MK/GHpemy5JTmsTz76sLUlUAPZPA
         nT1JX4STGc8RXDnKeAHoCS2UedXnke2jLJQVwWqVKUtYMpLsfoOs1cT3pop7QNookD2P
         yn/g==
X-Forwarded-Encrypted: i=1; AKwUvBxN7UxgsHdjYAn7YMXHXfDf/1yJBdk8VGb2dPsLGeEU326Z5R4/Z5gDgQKJrQkVs0JhSgGu39A=@vger.kernel.org
X-Gm-Message-State: APuU4Z+F5SNmfRJM5mDu4V5oCHsOqlM0nPL4Y5yUEgZyksJr/Loxt012
	X1pMUOGsHxoG/kAu/I04Say4+ht006baCRR5H/LoXdznSu40RQqII4ZoIZvP3KhLkdoIP2IiUTu
	I04mCjWUomrObFrHlAXWb2NqqfJfS77m3EqYgJqkP
X-Gm-Gg: AYBFou2M17t6nD/N9XjJszqllLBNhESfse3OdZQpJf8Uw2Vpe/NgWd9FDKEmDu7isQW
	RZ8tAS8k9wDEWivziCUlLnIE8nx7+TJsVh0JyVWRib3XiEaierohGtsmk5FkrG1NhEv/dskZRW/
	RDXnsS5UuzKsVxx+Y+JLi4Nhd0/USRezBW/YQ0dCzdKQWjKGu8BWMF93Zxo8KveJioSTZasUDBm
	eX/eJUJgrjCalN/UYuED6x6F1vrP3kUU9Hw6SjA01Rnei9BWc6PHMbO4UEf3Dz1DIar0/Z4DwTG
	hrwjKC2OjrCbNynz1TesDXhcEqdtytvUq3UMKqxVKU3cXLv0CYZFkuX3W3uFg2+ogitrUmziczt
	tf5XFL2XuZQpOyVONTL/JPLAf4848bS339EjR
X-Received: by 2002:a17:90a:e7cd:b0:3a0:8050:2ec9 with SMTP id
 98e67ed59e1d1-3ae897ccf9dmr9830837a91.16.1793694825021; Tue, 03 Nov 2026
 00:33:45 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029211634.2232784-5-hramamurthy@google.com> <179365432386.3131.15374369453099115031@kernel.org>
In-Reply-To: <179365432386.3131.15374369453099115031@kernel.org>
From: Pin-yen Lin <treapking@google.com>
Date: Tue, 3 Nov 2026 00:33:34 -0800
X-Gm-Features: AclHuK8zM-JZ_3yaCoKIW6N5v6Mma-fZLHgYVCQdxl4X3qkS-7jYnU2RPPScwO8
Message-ID: <CAHwYsip2mYupJp3a7JhWCHX9e7U7hHGmqrAGSxzRDBuN_RJJ+Q@mail.gmail.com>
Subject: Re: [PATCH net v4 4/4] gve: Fix link flap after ethtool ops
To: netdev-bot+sashiko@kernel.org
Cc: hramamurthy@google.com, netdev@vger.kernel.org, joshwash@google.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, jordanrhee@google.com, willemb@google.com, 
	przemyslaw.kitszel@intel.com, nktgrg@google.com, maolson@google.com, 
	jacob.e.keller@intel.com, pkaligineedi@google.com, yangchun@google.com, 
	patricion@google.com, awogbemila@google.com, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 1:18=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wrot=
e:
>
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in ca=
se
> you want to address the nit picks below when you respin.
>
> Low priority / nit picks for your consideration:
>
> - [Low] The patch removes `queue_work(priv->gve_wq, &priv->service_task)`
>   from the end of gve_queues_start()=E2=80=A6
>
> --
>
> gve: Fix link flap after ethtool ops
>
> This patch changes gve_queues_start() to update the carrier state
> synchronously through gve_turnup_and_check_status(), instead of queueing
> the service task to do it. It also takes netdev_lock() around the link
> status update in gve_service_task(), so that update is serialized with
> the synchronous path.
>
> > diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/e=
thernet/google/gve/gve_main.c
> > index b5e2f39a903c5..bc7d7c41948c3 100644
> > --- a/drivers/net/ethernet/google/gve/gve_main.c
> > +++ b/drivers/net/ethernet/google/gve/gve_main.c
>
> [ ... ]
>
> > @@ -1494,8 +1526,7 @@ static int gve_queues_start(struct gve_priv *priv=
,
> >                         round_jiffies(jiffies +
> >                               msecs_to_jiffies(priv->stats_report_timer=
_period)));
> >
> > -     gve_turnup(priv);
> > -     queue_work(priv->gve_wq, &priv->service_task);
> > +     gve_turnup_and_check_status(priv);
> >       priv->interface_up_cnt++;
> >       return 0;
>
> [Severity: Low]
> Commit 3b7cc73628ff added this queue_work() for the link status update,
> and the new synchronous check handles that. Does removing it also drop
> the service task run that used to follow every reset recovery?
>
> gve_reset() clears the reset flag first and then disables the service
> task:
>
> gve_reset() {
>     ...
>         gve_clear_do_reset(priv);
>         gve_set_reset_in_progress(priv);
>
>         if (was_up) {
>                 gve_turndown(priv);
>                 ...
>         }
>
>         disable_work(&priv->service_task);
>         ...
>         enable_work(&priv->service_task);
>         err =3D gve_recover(priv, was_up && !skip_queue_setup);
>     ...
> }
>
> gve_schedule_reset() could run after gve_clear_do_reset() but before
> disable_work(). One way is gve_tx_timeout() from dev_watchdog racing
> with gve_turndown(). Another is an RX NAPI error path just before
> napi_disable:
>
> gve_schedule_reset() {
>         gve_set_do_reset(priv);
>         queue_work(priv->gve_wq, &priv->service_task);
> }
>
> In that case, disable_work() cancels the queued work, or queue_work()
> is rejected while the work is disabled. enable_work() does not queue it
> again.
>
> Before this patch, gve_recover()->gve_open()->gve_queues_start() ended
> with queue_work(), so a leftover GVE_PRIV_FLAGS_DO_RESET was handled
> right after recovery.
>
> After this patch, the service task is not queued again until some
> unrelated event, such as a later gve_mgmnt_intr(). When it does run,
> gve_service_task()->gve_handle_reset() would perform a full gve_reset()
> because of the stale flag. That reset could happen long after, and
> unrelated to, the event that set the flag.
>
> gve_suspend() and gve_resume() seem to have the same gap. They call
> disable_work_sync() in gve_suspend() and enable_work() before
> gve_recover() in gve_resume().
>
> The other parts of this look fine. A missed device REPORT_STATS request
> only skips a stats_report_trigger_cnt increment, because
> gve_stats_report_schedule() sets do_report_stats on every timer period.
> A device RESET request raised inside the disable window is covered by
> the reset that is already running.
>
> Could gve_reset() and gve_resume() queue the service task again after
> recovery, or re-check gve_get_do_reset() once the work is re-enabled?

Yes, this is indeed a regression introduced by this patch. When the
reset/suspend races with the Rx NAPI polling error path, the reset
will be delayed until the next service task is queued.

We will add an additional queue_work() after the
gve_turnup_and_check_status() in gve_queues_start().
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261029211634.2232784-1-hramamurthy%40google.com

Regards,
Pin-yen
