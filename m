Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CE03955EB
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 19:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791056256; cv=pass; b=kMTTzLGhrP6ObBuu+Bogo4Wz2MSu8NWf3axJVb9svVpAIWW+httoKGlGYpq9/akqL88NHUJZF61Yx3LjnmWEgLh2BRtLa/fxUsFeh8sX6WVEUtysqcCDFl0VsVHDN8b6PgB9Mg792ymgzgFcdOhFth2L91/hQPlECfmoC/lCTkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791056256; c=relaxed/simple;
	bh=RQdISwCIeTHJRNNRYXKnQccif86ZtXCpqBErB1KRL7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZHgKy7Bl/4KLbtiKFtw8cEYIT+c46R4SV82En8vgr361LBl2GQvmAG348iZPCucM8fJT8P0Pqo1slifAgI32fAfAtcU5OSJ0UuFFzRCD2r13lz+5YA0l4m9+4RiHVETFqfzciI82kE7MQAoJy9TLt0ZG1eqbcKJY8SiNLC/Y1B8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p2qBkOJb; arc=pass smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p2qBkOJb"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c2a837b0c2bso11414366b.3
        for <netdev@vger.kernel.org>; Sat, 03 Oct 2026 12:37:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791056252; cv=none;
        d=google.com; s=arc-20260327;
        b=r+zpMKX9qWf5Gq6MEKcKR+eDxdwmeLStfD0wqUFuNn7iWo3fyTxpruewWn3W1xVe1N
         e7tvRtqzNdx6cVxNJ/Pq7sMv9PoASbGiVqcIvfY5RW6qHQAZWqAhO+Xx/9FoTZLlDd8a
         xDCHUid4Y9Z21dB+bZQ+VPnBvEAChqiUzc9O5ccKD1EQsnQf6kQKtFxzjHu7CkgtSv0+
         XkTmGbBmCwqjTAGqkAWuL+nzTUpuCvkalOBamDazXIXEvgeBZWfkG50w9SMH3HP9X6M6
         ccGsFKqxJgviQZ4gEKjrycHlPh7dI9nCd7jGssMKZ2ItpjWIXlLKFg8gx3c7BAqk51v3
         SgoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+1sgNjTuEhjk9Api27Ek7GbjZW7LaWBth9pDAUxc4Wk=;
        fh=2Pu4KWRueU0DyFSqMYhBHwkL+kdoIOZzbPeJiEu1/4I=;
        b=Xn2eynTH7zRwZN/JFsYJ6qMGGKShas53tNbJ2rx/CFE6dzts2vop9VNF0+rpH4aazL
         WlqAUt9SecCmMTsDaciueKM/RfLaozd5HANh/e6OpQMUJbcRuzsa4n8lKthBLYZClbHj
         JgRoU3fydHeNsETbQlMuNHRX7Z3Fs8BJWu6qT2u5IhRmS4bTJz8Hj1EcJOv6NMenOWkv
         fwayTRwcQxAmqL0hcTND4grTDeWtyyJKzCmT8by3W0UKEmaFS8GBaRpgT7gZqeuqTHv7
         u3p/U2nXVs6PYGyX3jVP8EntcQOSTND7oofA/XPCt9HP7d5sHmQWWUlh6ZtM6LitNOMx
         IVeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791056252; x=1791661052; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+1sgNjTuEhjk9Api27Ek7GbjZW7LaWBth9pDAUxc4Wk=;
        b=p2qBkOJbe0JoIVZCajmcrQTxkDnY+IOH3/Tk7u4MNIVFwtr+MwYQD/b8Wiq+6L1Z5D
         XH8mXaO7g+fmFom3HdXa+rO/y6TynLCKTZZpNl6SscUG+2P0WMrwx5aRc3kjGm6PfhRd
         1Rr8zmBaUPRzZe1ZoIUjLsdfPRDUU8P5zuF9k9YDE+0VfkHUzJduxWdNTQ6ThddUKhmO
         2M7odiGaEisdf693nRTuGLEe1H63qaLVrTKKCXqkbNhho+sqeZzA8Euk8bvc1Bq1rnMp
         omDjAxvICJx04pmTcLSMIRTpsmpop8GR/dN9vInYBmrSD2ufRbKFagmEqiFPTI5+Rh+f
         Ylcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791056252; x=1791661052;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+1sgNjTuEhjk9Api27Ek7GbjZW7LaWBth9pDAUxc4Wk=;
        b=VZ5fxH2NrZzRAEXELagkkwCBO5NWCZlsUmykU8bvsMycN1LNpolX4CPvBWW1u9ilyJ
         iJgHfUJSS/F6aUC1y+P17H0iCDXgEV0OQM4Ii7dos/925MqrZfzq+/qyyuetXYOdSsV9
         HTjGyGngB5OxWsdITufr/8fc9cdrMy/HXMIznuSjNHE3+s5WvJLZlXNePbzRcy3s9iPs
         nKp5VIkxADQHUBKJOxK+FUXKKtec1CcpMOug7tRwSLeSUc5zPZ3Y6BNtuXmUt5b+87ut
         1klYRn5KNeTnnLSat2loMTJEhrySxP2tT0bO1RtPFbFRpKxnC+u51rCR7rf5C8Iwf+kD
         Z21Q==
X-Forwarded-Encrypted: i=1; AKwUvBym31Kh3qbTLrXzfABCc8xJ02T+ooblzqzFRremrtO0KvvqAfIk9N0IlAJyGyxM01PxyyQsbU0=@vger.kernel.org
X-Gm-Message-State: AFq9FYK8JBDU8WixloPcnRhkXY5reFIESV6Vrkfc/dqDsbc2F9RsDJI+
	o2tIKBh7ZsKgSILIF/uv/aiiDptnN1n7Z+y3lLfTH1ze8JLCfHEHwbBFSw3zA6L7h0eiXmCNXGP
	h0JOR1JXdiNlJEjOzk3pVwhvEY0HpilA=
X-Gm-Gg: AYBFou2neJtiv39ZDEz2lSL88jGOFawjY4EZMywfHbB9p5BmRx8Yzblvsxz1PqSUbBI
	uEHFLYXj7PRTBZVx16Sf3GDBxrLipcwwijHIrIyLOXxbx4T2Ua6Vef5VSPbhRNFWcvIahK0LfHl
	/PH58NqkVryAVIlAfPVlFV6DY2SpmCVDuDjKaH2y3B79CM5XEqUXlZC40n9tf/AFax2ewEiQTdq
	VBu/PybFKmyepjC8NTFbBjWn8uzCaQuW/OiW1hIdK4EJXnRSs/9jNAJSlXDthv+8UWghHhjBIde
	1qF2+CH9fPf1Sp72+Qb3/4PGtLBEFErKHoxi9LMutV7ElPCwkn6B3Td4pTHUVDWaEDHzW6n3jqc
	is3cGGL6I6kgLozzn3u6X2g==
X-Received: by 2002:a05:6402:1ed0:b0:6aa:a040:cc0b with SMTP id
 4fb4d7f45d1cf-6af9e26f8demr6033264a12.1.1791056251842; Sat, 03 Oct 2026
 12:37:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260927063607.3691520-1-nicoyip.dev@gmail.com> <179072873236.434549.5842458403458661428@kernel.org>
In-Reply-To: <179072873236.434549.5842458403458661428@kernel.org>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Sun, 4 Oct 2026 03:37:18 +0800
X-Gm-Features: AclHuK9p6aQ_J43EOVKpodci3vxNOzsM7jVie2jHyLl0wZCCleShlxslsIU4Ncg
Message-ID: <CAAo+4rVATDapayqSFFjRaNxFod=bnUGk66opVVUgdwVBr48FNg@mail.gmail.com>
Subject: Re: [PATCH net] net/smc: Serialize early link group cleanup with termination
To: netdev-bot+sashiko@kernel.org
Cc: alibuda@linux.alibaba.com, dust.li@linux.alibaba.com, 
	sidraya@linux.ibm.com, mjambigi@linux.ibm.com, tonylu@linux.alibaba.com, 
	guwen@linux.alibaba.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, ubraun@linux.ibm.com, 
	kgraul@linux.ibm.com, linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 8:38=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 1 =C2=B7 Low: 0 (1)
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] The patch covers only one of the two callers of
>   smc_lgr_cleanup_early().
> - [Medium] Early cleanup can free the link group while a
>   smc_lgr_free_work() callback that has already started is still using=E2=
=80=A6
>
> Pre-existing issues:
> - [Low] In __smc_lgr_terminate() (net/smc/smc_core.c:1573-1574), the
>   comment says "cancel free_work sync, will terminate when lgr->freeing=
=E2=80=A6
>
> --
>
> net/smc: Serialize early link group cleanup with termination
>
> This commit makes smc_lgr_cleanup_early() check and claim lgr->freeing
> under lgr_lock before it calls __smc_lgr_terminate(). This stops early
> cleanup from racing with the other teardown paths. It also makes
> smc_conn_abort() hold a temporary link group reference across
> smc_conn_free() and early cleanup.
>
> > diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> > index e9f93b3ab435b..97b0a0b510664 100644
> > --- a/net/smc/af_smc.c
> > +++ b/net/smc/af_smc.c
> > @@ -1011,12 +1011,16 @@ static void smc_conn_abort(struct smc_sock *smc=
, int local_first)
> >       struct smc_link_group *lgr =3D conn->lgr;
> >       bool lgr_valid =3D false;
> >
> > -     if (smc_conn_lgr_valid(conn))
> > +     if (local_first && smc_conn_lgr_valid(conn)) {
> >               lgr_valid =3D true;
> > +             smc_lgr_hold(lgr);
> > +     }
>
> [Severity: High]
> This adds a reference for the smc_conn_abort() caller, because the new
> lgr->freeing check needs the link group to still be allocated. Does the
> other caller of smc_lgr_cleanup_early() need the same protection?
>
> net/smc/smc_core.c:smc_conn_create() {
>     ...
>                 write_lock_bh(&lgr->conns_lock);
>                 rc =3D smc_lgr_register_conn(conn, true);
>                 write_unlock_bh(&lgr->conns_lock);
>                 if (rc) {
>                         smc_lgr_cleanup_early(lgr);
>                         goto out;
>                 }
>         }
>         smc_lgr_hold(conn->lgr); /* lgr_put in smc_conn_free() */
>     ...
> }
>
> The hold is only taken after registration succeeds. On the failure path,
> smc_lgr_cleanup_early() runs without a reference of its own.
>
> For SMC-R first contact, smc_lgr_register_conn() fails through
> smcr_lgr_conn_assign_link() only when the new link is no longer
> SMC_LNK_ACTIVATING. As far as I can tell, that happens only when
> __smcr_link_clear() resets the link inside a teardown's smc_lgr_free(). T=
hat
> teardown drops the link's lgr reference and then the initial one. For
> example:
>
> smc_smcr_terminate_all(NULL)   /* reboot notifier via smc_lgrs_shutdown()=
 */
>     list_splice_init(&smc_lgr_list.list, &lgr_free_list);
>     lgr->freeing =3D 1;
>     __smc_lgr_terminate(lgr, false)
>         smc_lgr_free()
>             smcr_link_clear()->__smcr_link_clear()  /* link UNUSED, lgr p=
ut */
>             smc_lgr_put(lgr); /* theoretically last lgr_put */
>                 __smc_lgr_free()->kfree(lgr)
>
> The connecting thread (connect() or the smc_hs_wq listen worker) then see=
s
> registration fail and calls smc_lgr_cleanup_early() on the freed lgr. The=
re,
> smc_lgr_list_head() reads lgr->is_smcd and the new check reads
> lgr->freeing.
>
> The commit message says:
>
>     The extra reference keeps the group alive until early cleanup has
>     checked teardown ownership.
>
> The smc_conn_create() caller has the same lifetime requirement. Is a
> use-after-free from early cleanup racing with termination still reachable
> through that path? The window is narrow. It looks like it needs a teardow=
n
> such as a reboot to run during an SMC-R first-contact handshake.
>
> >
> >       smc_conn_free(conn);
> > -     if (local_first && lgr_valid)
> > +     if (lgr_valid) {
> >               smc_lgr_cleanup_early(lgr);
> > +             smc_lgr_put(lgr);
> > +     }
> >  }
> >
> >  /* check if there is a rdma device available for this connection. */
> > diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
> > index 9974149659c2f..b166a379753c7 100644
> > --- a/net/smc/smc_core.c
> > +++ b/net/smc/smc_core.c
> > @@ -688,6 +688,11 @@ void smc_lgr_cleanup_early(struct smc_link_group *=
lgr)
> >
> >       smc_lgr_list_head(lgr, &lgr_lock);
> >       spin_lock_bh(lgr_lock);
> > +     if (lgr->freeing) {
> > +             spin_unlock_bh(lgr_lock);
> > +             return;
> > +     }
> > +     lgr->freeing =3D 1;
>
> [Severity: Medium]
> Can early cleanup free the link group while a smc_lgr_free_work() callbac=
k
> that has already started is still using it?
>
> After freeing is claimed here, __smc_lgr_terminate() only does a
> non-synchronous cancel:
>
> net/smc/smc_core.c:__smc_lgr_terminate() {
>     ...
>         /* cancel free_work sync, will terminate when lgr->freeing is set=
 */
>         cancel_delayed_work(&lgr->free_work);
>         lgr->terminating =3D 1;
>     ...
> }
>
> free_work is queued on system_percpu_wq, not lgr->tx_wq. So
> destroy_workqueue(lgr->tx_wq) in smc_lgr_free() does not flush it. The
> callback also holds no lgr reference.
>
> Suppose the callback has started but has not yet reached the freeing chec=
k:
>
> net/smc/smc_core.c:smc_lgr_free_work() {
>     ...
>         smc_lgr_list_head(lgr, &lgr_lock);
>         spin_lock_bh(lgr_lock);
>         if (lgr->freeing) {
>     ...
> }
>
> Teardown can then run to completion. smc_lgr_free() drops the initial
> reference, and the new smc_lgr_put() in smc_conn_abort() drops the last
> one. __smc_lgr_free() then frees the lgr and its embedded free_work, and
> the callback goes on to dereference freed memory.
>
> The commit message says:
>
>     This also prevents early cleanup from racing with the delayed free
>     worker
>
> It looks like the freeing flag only prevents a second teardown while the
> object is still allocated. It does not keep the lgr alive for a worker th=
at
> lost the race. Is the commit message accurate here?
>
> To trigger this, the SMC_LGR_FREE_DELAY_* timer has to expire during the
> creator's abort. That looks like it needs an unusual stall or a jiffies
> jump.
>
> [Severity: Low]
> This isn't a bug introduced by this patch, but the comment in
> __smc_lgr_terminate() quoted above says "cancel free_work sync". The code
> calls cancel_delayed_work(), which does not wait for a callback that is
> already running.
>
> What protects a pending smc_lgr_free_work() is its own re-check of
> lgr->freeing under lgr_lock, not a synchronous cancel. Early cleanup now
> reaches this code after claiming freeing. Could the comment be updated to
> match the code?
>
> >       /* do not use this link group for new connections */
> >       if (!list_empty(&lgr->list))
> >               list_del_init(&lgr->list);
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20260927063607.3691520-1-nicoyip.dev%40gmail.com

The issues (incomplete fix and comment consistency) identified are
addressed in v2
https://lore.kernel.org/netdev/179105277608.1402591.16173087244761956438@ke=
rnel.org/T/#t

Best regards,
Chengfeng
