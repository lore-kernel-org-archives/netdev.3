Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2E94071E9
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 23:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790983437; cv=pass; b=XN0R4disheGkwmuCPEtBp7vZ5LjLq7qGm7cfDQ3+e3F9OkEZHRPGcQA78DAwf1XuUP4epa9wNVd+Ymoq6pueqkWvgy+Zi7Dvc91rTVcFYiXfDYQMIWQRVO1k4wLuYouZnKLWEpK2t/lcfeUvhId95xHNg98mTAnZV9P1Et8gGOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790983437; c=relaxed/simple;
	bh=RRu9tqdBY3AuiE+QNEPO/+zvxhldBrdnI2YOZOTmnGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nBmPsrjgwzVxtPMQ8SHzcw/HF2Ue5utsPOolm84qXFhPVP0fgSoxLuikMw9JYOBJFI9J6wJLTvOdUipfLHfk4oEk0ABNuqUPLS05rAA+J6c/eMdkYqNTqKyyunf/OIi2AHN/ZBzbMsLDBhpC+WS+MycUDDgMrcOsPDqdTzJw/0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vmbQC762; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vmbQC762"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2e2e4ef20beso22085ad.0
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 16:23:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790983434; cv=none;
        d=google.com; s=arc-20260327;
        b=D2v0FDoqIxUh39ZrlYMJ0UEhz+YajkN0uFgiojSHIGxrDqvOlwOw4AVHdQOwUtX1No
         QrBtYQwV754a17NqDml9FDvKOj07hXjdw4TuHRcFQ+m+YiLSwvdRoF/1kmsZSJMMRCNm
         N2OMQepdaVWnbROb8mruhuAiKLCW3QaxDnvcDrg12Z9+ySzBFFeuFtOwUkS1ny+hjimI
         73VFsxFaCwDsKEM/2iTLN/mpDKRBJwjsNDBAz5O4oUQjB9Y/f3aBp4DqRL779xvYBOhE
         2qS9TkdFOiBjiBwr/TCYfrDCt6jHEXOq6XNO7h1yh0UNUegCNgh43FajW2Hq/YhAEcpM
         fYAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yRPB82VFJ90lfQ7njnr7XC8e8HLChtcDRi7BTmzq/ag=;
        fh=tbZNW/+yd/aYY4xXSCzHlSvxAezAtCerzA4AUpUnXZw=;
        b=N2852prRpaMF/rl0XiocZFs1XruEyzRmsPYiGNW+TalIiM0/2vG5bGdgwGVdZiDV4e
         Sv0aLpQtkDEE25rbvGqcnaUUO3aic/M6SYpCXVCaGh0wCbaWlUf2AP2HUkz4DcFUVjZw
         cTsxONwcnO8egc1W6LZxMpDY3whHZdHpgCNxjfRqB8rdirxC/7n64zWkOCbRSKO+lr0N
         i6YcnNlU74K51Dx6vSGJ+gJGG1+igETWnEDdNVf0r4ucm/G9Jg7cUGkoodzBVm62QpWK
         Dx/CMECBBVzDhwx3FRtoftEu7Q4fcFZLu1GKezLY30ICDcwF3XenojqspgIg6+SZY7E/
         bhDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790983434; x=1791588234; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yRPB82VFJ90lfQ7njnr7XC8e8HLChtcDRi7BTmzq/ag=;
        b=vmbQC762YIx+c+b9Jcnd2ztRovdm6zNGjHZ6GeiASMwD7pmAJ3ugMenjclUjOA3dLb
         rJ2IdzxHW+vqGiiN30lJyeK3aZ/OmBpQJuqJRei45nG6YI2iQe4O8m8zln4qQiY1PCaZ
         X/KboT6nAaJ90wI442SPH86gBBG9WrhYcUuD2dtXmINFla2bQP+mcQsXgwX5GkYQZghF
         nBjbDfMZBYywTv/ogVf9WAy99T2cSG7LfWQRkzCwSfgVAGYTLDGRpwNN9YAZ3YL6NKPe
         w+srLCT9yHBfyP9dGe2aRGF27nmApJAUCigXBZDjq6EuBvxttRjC3krG41YGyn5E6WE5
         8GjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790983434; x=1791588234;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yRPB82VFJ90lfQ7njnr7XC8e8HLChtcDRi7BTmzq/ag=;
        b=wY+68XECpicEOTz7+OKCHPx12xsbGxFSlxkd/9sgVlhkjW1os8kvxWAHL/E3FKpmeO
         87CwDWpiG0kt5aWIyEhmvyRYt6i8zzoH8F052oSfcOLE9oXa6W9dfjXf6q2rmkSuvZ9h
         mlF0GEcHTrSyGj+FAT/WKseATo+kveOzMZYOAS/PiZz7Cdvg3v0tfuaUpTrCtMwl+1CX
         bQrGB9aBWzmLNqtP1NAYd51cnhJrKZwkgFO6lASOk85dEGIUxOLPA+ASzLZm1WbbMr8u
         2IFpIiDo0WfUHAcDSar9GbYW7S9gWuvNaSptSsLFykOHp/qycGoG/4YWSlWBAV+J7DvR
         hW8Q==
X-Gm-Message-State: AFq9FYLLIhXa62Fsydbapar18cxeGvveWywarbjK6xXumUX56t40zbHo
	Rhfj7HtqQUZjQnZlVQWsfvo7ldY8cN2FjtAFYtwxtbAQo37rO54cKKtwo4pNvqdeyDgvRLvig/A
	+QoxIR59iDtV1muxdXnPBRc/eKsS/uW4iL8qPJgB6
X-Gm-Gg: AYBFou0HF2P3wHNZqOm2B5rSkZwrnG/PG6jWhRPufElYezhhxNC9DytkT19MleJEUtj
	v9JyoGVnIrs6ajS49ZnsCtYLTAUY0TUlbPa8XBGGVLbQKhJ7TGcRSVxmRyhyckqENqB4I4JMs/K
	N+bdWU54s4njRanP7b/vXJVPb3tkTmHo9wnVHR0+b//jOJbTutz6pg8XCugtKb7YPrFR4SNfK/r
	NLqjO0q4R8J2EsV0cdHOchrCPbQJg7T6BCmtjUWUO7OpbSIyABka18Ay1H3bVZN85t/afmTooaJ
	CN2gs9gYKzFqCQ0eq73PfyNePWZ63M/rXhzrLuK3CMLE9sKrFwVL5I9FcTmeBThFgEkTwsgTRXE
	KGP8+RpFWgfzpC+BH+iwNu39xI9xgZmFiGBxKOKxxcMyNvowmebxEoQ==
X-Received: by 2002:a17:903:3c2b:b0:2c9:d89f:fd98 with SMTP id
 d9443c01a7336-2e530c1b194mr2089565ad.1.1790983433055; Fri, 02 Oct 2026
 16:23:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930190428.1130007-6-hramamurthy@google.com> <179093559163.434549.8853251921845038273@kernel.org>
In-Reply-To: <179093559163.434549.8853251921845038273@kernel.org>
From: Harshitha Ramamurthy <hramamurthy@google.com>
Date: Fri, 2 Oct 2026 16:23:41 -0700
X-Gm-Features: AclHuK97xos_v4EowLQemIo8YleA2mrgDLsr55DFbDKD09wvx5nu-a-y-m1obAo
Message-ID: <CAEAWyHdJiwb_SEgmUw0TMn-kh6SNzrg3Xwr9wac=E8DpXr-hCA@mail.gmail.com>
Subject: Re: [PATCH net-next v9 05/12] gve: refactor gve_init_priv for reset path
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, joshwash@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, jordanrhee@google.com, 
	willemb@google.com, nktgrg@google.com, maolson@google.com, thostet@google.com, 
	jacob.e.keller@intel.com, debarghyak@google.com, kees@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	przemyslaw.kitszel@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 2, 2026 at 3:06=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wrot=
e:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 (1) =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] The commit message says "These changes are only code movement,
>   no functional change".
>
> Pre-existing issues:
> - [Medium] This problem wasn't introduced by this patch, but a hard reset
>   leaks the AdminQ dma_pool and its buffer.
>
> --
>
> gve: refactor gve_init_priv for reset path
>
> This patch splits gve_init_priv() so that gve_probe() now does the AdminQ
> setup (the new gve_adminq_init()) and the device property negotiation
> (gve_adminq_get_device_properties()). Device setup moves into a new
> gve_setup_device() helper. gve_reset_recovery() now calls
> gve_adminq_init(), gve_adminq_verify_driver_compatibility() and
> gve_setup_device() directly, instead of gve_init_priv(priv, true).
>
> > diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/e=
thernet/google/gve/gve_main.c
> > index addfd8dc1a1a2..2fe280cf7e680 100644
> > --- a/drivers/net/ethernet/google/gve/gve_main.c
> > +++ b/drivers/net/ethernet/google/gve/gve_main.c
>
> [ ... ]
>
> > @@ -2566,15 +2541,32 @@ static int gve_reset_recovery(struct gve_priv *=
priv, bool was_up)
> >  {
> >       int err;
> >
> > -     err =3D gve_init_priv(priv, true);
> > -     if (err)
> > +     err =3D gve_adminq_init(priv);
>
> [Severity: Medium]
> This isn't a bug introduced by this patch, but does a hard reset leak the
> AdminQ dma_pool and its buffer here?
>
> A hard reset is gve_reset(priv, false), or gve_reset() after gve_close()
> fails. Either way it goes through:
>
> gve_reset_and_teardown()
>   gve_trigger_reset()
>     gve_adminq_release()
>       gve_clear_admin_queue_ok(priv);
>   gve_teardown_priv_resources()
>     gve_adminq_free()
>
> gve_adminq_free() then returns early, because ADMIN_QUEUE_OK is already
> clear:
>
> void gve_adminq_free(struct gve_priv *priv)
> {
>         if (!gve_get_admin_queue_ok(priv))
>                 return;
>         gve_adminq_release(priv);
>         dma_pool_free(priv->adminq_pool, priv->adminq, priv->adminq_bus_a=
ddr);
>         dma_pool_destroy(priv->adminq_pool);
>         ...
> }
>
> So dma_pool_free() and dma_pool_destroy() never run. Then
> gve_adminq_init() here calls gve_adminq_alloc(), which puts new
> allocations in priv->adminq_pool and priv->adminq. The old pool and
> buffer are lost.
>
> The same thing seems to happen when gve_teardown_device_resources() calls
> gve_trigger_reset() after a failed AdminQ command.
>
> The baseline gve_init_priv(priv, true) path leaked in the same way. The
> later "gve: simplify reset logic" patch in this series appears to fix it.

Like the AI notes, this issue is pre-exisiting and most of the reset
related issues are fixed in the following patch =E2=80=9C"gve: simplify res=
et
logic"  in the same series.

> That patch makes gve_adminq_release() static and calls it only from
> gve_adminq_free(). It also stops gve_adminq_release() from clearing
> ADMIN_QUEUE_OK and removes gve_trigger_reset().
>
> > +     if (err) {
> > +             dev_err(&priv->pdev->dev,
> > +                     "Failed to alloc admin queue: err=3D%d\n", err);
> >               goto err;
> > +     }
> > +
>
> [ ... ]
>
> >       if (was_up) {
> >               err =3D gve_open(priv->dev);
> >               if (err)
> > -                     goto err;
> > +                     return err;
>
> [Severity: Medium]
> The commit message says:
>
>   These changes are only code movement, no functional change.
>
> Is that accurate? The patch seems to change behaviour in a few places.
>
> First, gve_adminq_init() writes the version string before it allocates
> the AdminQ:
>
>         gve_adminq_write_version(&reg_bar->driver_version);
>         return gve_adminq_alloc(priv);
>
> gve_reset_recovery() now calls this helper. That means the driver version
> string is written to the BAR0 driver_version register on every reset,
> resume and recovery. Before this patch, gve_write_version() ran only once=
,
> from gve_probe(). gve_recover() still does this at the end of the series.
>
> Second, the order of device accesses in gve_probe() changes. The version
> write now comes after the max_tx_queues/max_rx_queues ioread32be() reads
> and after alloc_etherdev_mqs(). AdminQ registration,
> VERIFY_DRIVER_COMPATIBILITY and DESCRIBE_DEVICE now run before ctrl_ops i=
s
> set, before map_db_bar() and before alloc_ordered_workqueue().

Both these two changes listed here prepare the driver for the addition
of the new control plane - the version write is now done as part of
Adminq init specifically since this won=E2=80=99t be needed in the mailbox
mode.

And in mailbox mode,  the control plane has to be setup and the device
properties negotiation has to happen before we try to allocate the
net_device. Since the max TX/RX queues that the device supports comes
from this negotiation.
>
> Third, when gve_open() fails here, the old goto err path logged "Reset
> failed! !!! DISABLING ALL QUEUES !!!" and called gve_turndown(). Now the
> function just returns. Neither gve_reset() nor gve_resume() logs the
> error, so a failed re-open after reset or resume leaves nothing in the lo=
g.

Hmm, actually the only visible effect here is the dropping of the log
line which will be back in the next patch. gve_turndown() does nothing
at this point, because NAPI is already disabled and carrier is already
off. The following patch rewrites this path anyway.

>
> The only place this is mentioned is the v3 changelog below the ---
> line, and that text is dropped when the patch is applied. The changelog
> says "don't free device resources if gve_open() fails in the reset path".
> The baseline err label did not free device resources either, though.
>
> The later "gve: simplify reset logic" patch adds a "Failed to start
> queues ... DISABLING ALL QUEUES" message in gve_recover(). At this commit=
,
> though, the message is missing.
>
> Could the commit message describe these changes, instead of calling the
> patch only code movement?

I can call out these changes in the commit message and bring the log
line back if there is a need for another respin. These issues on their
own don=E2=80=99t merit a respin IMO.

>
> >       }
> >       return 0;
>
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20260930190428.1130007-1-hramamurthy%40google.com
