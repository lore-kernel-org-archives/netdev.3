Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7972540801E
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 18:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792003189; cv=pass; b=pGhOYLpiEzcTDkOEfrOWoQJfjxrVwdNu/HSSvrNn8Tp6FIBGSDh9Y/Qauwr2LDjNP94sZ08mzDTP6i+ax/SsovEGX8EUz8TE/o8f3xnrmqyg+MVBHAsBjXpFegL61tz6eMQUWwyOdOVf0Givju8ZjDCmlt02jkODHmgFwCRzSVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792003189; c=relaxed/simple;
	bh=Hi3oLimrk06HY77N752dV/sqU29cIiskVgmmFoM1BrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cms1+mZkSelgJH59ku36OKo/MTleb/sJ9srBvtuPp8GJUtw3OMiwqdjesAXwFvfEP+vi/UTBpZgNyk46QhSOPQT9aPkcWkf5k9eb6Zo9HygQvBHh+qhF7+hSd6QY9YnmfpWCyBtokNhF2fsuJ0XFrBf0YYMoHC4XfDJxqAJkg+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LlGT/VHy; arc=pass smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LlGT/VHy"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-459bd8ea98aso202420fac.0
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 11:39:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792003186; cv=none;
        d=google.com; s=arc-20260327;
        b=A2QbEn4JXCEASoZhfHgM4JEcrzzD1ALwtUZg4lg0ysYJics6y+IX4/zt5+qxVg2fOs
         Px5CVlSTD626enOmYNI2pewbhZ/0RMKDoXIUrvPAtrWxB2j7EkkfGArF9znbgi9sxQR4
         h6dxMDT69gLSebHpU2j9EUqy7TrFxj0OXmBOlouesaTJandVbfnoVCABRtitOpi/AhPQ
         6b0brTiy+nPbfjg0lHbykGBuMxCW8CDHZUaLfBDeSLaBjmgtdNGJSmwvUMzEzzhSWSZ8
         t1aCfrDwseJlXOHBZ/xcpMBR2e3z603vBm8Q/pjcUtG69VraW8SyVA5ocQQL41af5Y01
         5Mmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nfJLxdiTo6vJhA+TJkzuS9wIdOWg1+Cfb8ilaZ5iWJU=;
        fh=8YJ07cQTBLau2/4lS5UYzV5xQvU7Dtd3S1KGISy3ozc=;
        b=gln3q4ttV9irLLmTfC+62t8QqGmyjb+uY7Rpo+6sL+U5SIh1+WX/+aD9PegODaPd92
         nktrAwf2feQSvbE0sIIXCrIWiFngB44bv+z95njkj/TuEtNQYwFWf7fSeERlIQjb8GhZ
         yXO/BGrH87QrBF6t6kQWFI47alA62R4FTIV05afR0nfyAVW/y8K0gSp4oJJBbv+kZpOX
         LwyBMDKu37cqImgJWJ00o7hqB9TG75j83mJC9sCxqDsADeljeTqJdbuzhEEa8k8t9Y/f
         YcoAfzgTpor0i1nrkm1YRT6qHzBzc6oM6/L1kcHqcW0XbOA4QTvMDhPEN+QPewTS4UyI
         /F+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792003186; x=1792607986; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nfJLxdiTo6vJhA+TJkzuS9wIdOWg1+Cfb8ilaZ5iWJU=;
        b=LlGT/VHyAgrN/IdTQ6Ev9lBxxjVLPU7IvPw+3n8w/2oSZdb4C4GhiwCyYdc05MHGCW
         DIGRLng1bIT0K8ka2XlxR1z46Ab/bu8D3U3/nuCUNIDNA95ZU7v+coVJye3gTrtA8AD9
         Uv1G/uJm79zKmnNd0k+TGg471AH+FOZmqyOBlcAcOMzvU7crgj6Tnc3u5+AcPHBp9fTM
         TylteBLo+YMZlD7WH0+71IMu8/mABZyGEYwCAKeccW2uD0Vn6seyXJ7YTZnDcQivMpkG
         98BbtWtL1eFgGwe/hcSHdFOIZf1k211IhdoNQDpDKdHxO90/TK6Q5MP3YjSNwwEC1VMy
         blLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792003186; x=1792607986;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nfJLxdiTo6vJhA+TJkzuS9wIdOWg1+Cfb8ilaZ5iWJU=;
        b=g0YHJtJdbTzo8/7H6bYhdRbIhZI/mZ8b0yqPPRbh+7I/Vomi5hsouT8VQiK74TAh3+
         MzALiGz6YxUwtf/r1aj4BuquZV1L4fAGkxttEBZClY1Np5MBvNaXQ5Qne5gTwXNs1S52
         t4KdT+yaKFCS5TUBCEp7k3rtqzYk/Bj6yRCpqMexz/y6o2cOs+qr9ArjjCtdvxHXCJF6
         QnLOPImmEvNKNDEd6vRImk8h2meS3ExlFkWyg6VUTQT6oSPKskyMV89+i9Q2Qbky6Dh+
         swvYqo8JLOULNd3ZRBDnDtyEur6RgiSHqDwTlw61L+tX06JpNKkq8ktBBkAohDqzT8cu
         Xc9A==
X-Forwarded-Encrypted: i=1; AKwUvBxf9xQZ6EzyKLn2DYLggsE6UzUWItLXBYGcRjN62Y/Bk6bsep5Erc6Q+LLliZPW27DPYJBJK1M=@vger.kernel.org
X-Gm-Message-State: AFq9FYK7MWuOcFENE37SGBZTmLPifZp2vF787GeQMZupPz/QiolSG50y
	NTBiSN3x2Pv8/69Oc10cjMF7bb2Fw/KounZ2q45eFpDGQsMyc72LFM1+H/dFnBIFUDcMH9+BFG/
	O2ORvS1q3OuOqHbBGyLwujFnw6x6pbgs=
X-Gm-Gg: AYBFou0VecN4DsrTOiV7mrOwaaiQC4VFMG1TwiCsUuNnvSn8QrLmVItfAlMNNZBZ1gb
	85lz9W2LLsKZMGgtkRcRDTnZHKUSekPKxULk18aUnfUFxaJROvg7SNFq+zoIm5N4p8Bh7N7A58g
	hMvVoSM/Uq4qgydWACcE53momAzn4/IGuAGI0uE9PBO8twOyat6Pd0MCiMoNJcixkpsRNRF/eKL
	6xAawYcY+rH0POV6OIDBQQI+U36wuPAnhNhp0mqMvyHWwWCY6kG3L72KEyswdzgMJ8hhShvirKY
	RXQXix8eHfg2ocVkCrEC/BbMPjIgBjroahda55S7z4b05P18Tb0IckiLRUPOydJ691wB0Ss=
X-Received: by 2002:a05:6808:50a8:b0:4e8:9e40:a0dc with SMTP id
 5614622812f47-50c41108624mr24831152b6e.1.1792003186157; Wed, 14 Oct 2026
 11:39:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012-netcons-fixes-next-v2-1-ac8ec4c62edb@gmail.com> <179191204261.434549.8984165771561140450@kernel.org>
In-Reply-To: <179191204261.434549.8984165771561140450@kernel.org>
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Wed, 14 Oct 2026 19:39:35 +0100
X-Gm-Features: AclHuK9H5B8TXm5v5mDMBoKGdofCkC_RwhygYwsXkWt2btKwSIv0kBCAj4jxGFY
Message-ID: <CAGSyskXLys0G5MzhnRjGzLBFcsGfWUwJbBSxOezL+1UpPqc2NA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/2] netconsole: avoid printing partially
 updated target attributes
To: netdev-bot+sashiko@kernel.org
Cc: leitao@debian.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 6:20=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 2 =C2=B7 Medium: 0 =C2=B7 Low: 1
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] In drivers/net/netconsole.c, local_mac_show() still takes no
>   lock.
> - [High] dev_name_show() still races with netconsole_netdev_event()
>   writing np.dev_name, even though the commit message says this race is=
=E2=80=A6
> - [Low] The commit fixes a user-visible race: configfs *_show() callbacks
>   can return torn values while a store or the netdev notifier updates=E2=
=80=A6
>
> --
>
> netconsole: avoid printing partially updated target attributes
>
> This patch makes the netconsole configfs *_show() callbacks take
> dynamic_netconsole_mutex, so they no longer return values that a
> concurrent store has only partly updated. dev_name_show() also takes
> target_list_lock to serialize against the NETDEV_CHANGENAME update in
> netconsole_netdev_event().
>
> > Reported-by: Sashiko <netdev-bot+sashiko@kernel.org>
> > Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260814-ne=
tcons_ipv6-v3-7-bc0915e8c75f@gmail.com
> > Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928-ne=
tcons-fixes-v1-0-bb5ffe5e698a%40gmail.com
> > Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
>
> [Severity: Low]
> Should this have a Fixes: tag?
>
> The unlocked readers in dev_name_show(), remote_mac_show() and
> local_mac_show() date back to commit 0bcc1816188e ("[NET] netconsole:
> Support dynamic reconfiguration using configfs").
>
> The family/address tearing in local_ip_show() and remote_ip_show() comes
> from the more recent inet_addr/family rework (commits 46b3f9e7e761,
> 56ddc8d48e75 and f6e96d72f64a).
>
> > diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> > index 267254f046de9..953a1da071862 100644
> > --- a/drivers/net/netconsole.c
> > +++ b/drivers/net/netconsole.c
> > @@ -859,7 +859,20 @@ static ssize_t release_show(struct config_item *it=
em, char *buf)
> >
> >  static ssize_t dev_name_show(struct config_item *item, char *buf)
> >  {
> > -     return sysfs_emit(buf, "%s\n", to_target(item)->np.dev_name);
> > +     struct netconsole_target *nt =3D to_target(item);
> > +     unsigned long flags;
> > +     int ret;
> > +
> > +     dynamic_netconsole_mutex_lock();
> > +     /* Hold target_list_lock to prevent racing against
> > +      * netconsole_netdev_event() changing np.dev_name.
> > +      */
> > +     spin_lock_irqsave(&target_list_lock, flags);
> > +     ret =3D sysfs_emit(buf, "%s\n", nt->np.dev_name);
> > +     spin_unlock_irqrestore(&target_list_lock, flags);
>
> [Severity: High]
> Does target_list_lock cover every place where netconsole_netdev_event()
> changes np.dev_name?
>
> It covers the NETDEV_CHANGENAME strscpy(). For NETDEV_UNREGISTER,
> NETDEV_RELEASE and NETDEV_JOIN, though, the notifier drops
> target_list_lock before it cleans up the target:
>
> netconsole_netdev_event()
>     spin_unlock_irqrestore(&target_list_lock, flags);
>     mutex_unlock(&target_cleanup_list_lock);
>     ...
>     netconsole_process_cleanups_core()
>         mutex_lock(&target_cleanup_list_lock);
>         netcons_release_dev(nt)
>             do_netpoll_cleanup(&nt->np);
>             if (bound_by_mac(nt))
>                 memset(&nt->np.dev_name, 0, IFNAMSIZ);
>         spin_lock_irqsave(&target_list_lock, flags);
>         list_move(&nt->list, &target_list);
>
> The memset in netcons_release_dev() runs with only RTNL and
> target_cleanup_list_lock held. Neither dynamic_netconsole_mutex nor
> target_list_lock is held, so the new dev_name_show() has no lock in
> common with this writer.
>
> MAC-bound targets do show up in configfs. A netconsole=3D cmdline target
> bound by MAC is exposed through populate_configfs_item(), and
> netpoll_setup() fills np.dev_name from ndev->name.
>
> For such a target, can the sysfs_emit() here still copy a partly zeroed
> name?

This might happen, though quite unlikely and it has limited impact:
printing a truncated device name.
The fix would be taking target_list_lock around the memset in
netcons_release_dev().
I'm not convinced it is worth it, but happy to spin another revision
if someone thinks otherwise.

>
> Two options that look possible: take target_cleanup_list_lock in
> dev_name_show(), following the dynamic_netconsole_mutex ->
> target_cleanup_list_lock -> target_list_lock order that
> drop_netconsole_target() already uses. Or do the memset in
> netcons_release_dev() under target_list_lock.
>
> > +     dynamic_netconsole_mutex_unlock();
> > +
> > +     return ret;
> >  }
> >
>
> [ ... ]
>
> > @@ -906,7 +933,14 @@ static ssize_t local_mac_show(struct config_item *=
item, char *buf)
> >
> >  static ssize_t remote_mac_show(struct config_item *item, char *buf)
> >  {
> > -     return sysfs_emit(buf, "%pM\n", to_target(item)->remote_mac);
> > +     struct netconsole_target *nt =3D to_target(item);
> > +     int ret;
> > +
> > +     dynamic_netconsole_mutex_lock();
> > +     ret =3D sysfs_emit(buf, "%pM\n", nt->remote_mac);
> > +     dynamic_netconsole_mutex_unlock();
> > +
> > +     return ret;
> >  }
>
> [Severity: High]
> This patch leaves local_mac_show(), just above this hunk, without any
> locking:
>
> static ssize_t local_mac_show(struct config_item *item, char *buf)
> {
>         struct net_device *dev =3D to_target(item)->np.dev;
>         static const u8 bcast[ETH_ALEN] =3D { 0xff, 0xff, 0xff, 0xff, 0xf=
f, 0xff };
>
>         return sysfs_emit(buf, "%pM\n", dev ? dev->dev_addr : bcast);
> }
>
> It loads np.dev with no lock, no RCU read section and no netdev
> reference, then dereferences dev->dev_addr.
>
> enabled_store() sets and clears np.dev through netcons_netpoll_setup()
> and netconsole_process_cleanups(). process_resume_target() sets and
> clears it too. Both run under dynamic_netconsole_mutex.
>
> The notifier also clears np.dev, without that mutex:
>
> netconsole_netdev_event()
>     netconsole_process_cleanups_core()
>         netcons_release_dev()
>             do_netpoll_cleanup()
>                 netdev_put(np->dev, &np->dev_tracker);
>                 np->dev =3D NULL;
>
> If netconsole holds the last reference on a device that is being
> unregistered, netdev_run_todo() can free the net_device after this put.
>
> Can a reader that already loaded dev then read dev->dev_addr from freed
> memory?

This is being addressed in
https://lore.kernel.org/all/20261012-netcons-fixes-v3-2-1aac85ed7665@gmail.=
com/
