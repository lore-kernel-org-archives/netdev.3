Received: from mail-ej2-f42.google.com (mail-ej2-f42.google.com [74.125.228.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDAE2C21FD
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 01:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789953569; cv=pass; b=k6vhW7XRtEySHw/9TJvXSw29MUseojAqR7Th5qnYJynllIJO43TWDOMP0l94W84+jMEKCX7qm6fnK8IKvy9q3LtKZ/fFcO8IIBGv2XhD12g7IghlPKqsQbPJg2LtpsP9eW5zKiFLWfGop32MPQE+z2X6DkUdQXCYrkfgYwuXngg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789953569; c=relaxed/simple;
	bh=524Exas1fPv38RjrxCqkSKJKlK7ycvZRRydZy2op5Qo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NEGYRM6HTHUciEZLC9zaVBHgKJK70A3UgXeMKGZvLH6NMEeQ7E25XpTQwHtcRVuK3c9joBBp67888bSpwRswLC5q6JSAvpvoRTwLpnKa4FBN23P3rxmasiBmeI7dQ+iZ3r1Heg+xMZp29kKXfHzwgj7x6eN5LIalQ4yrowtjmaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QIvRRLK+; arc=pass smtp.client-ip=74.125.228.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QIvRRLK+"
Received: by mail-ej2-f42.google.com with SMTP id a640c23a62f3a-c254f6c7a56so280536466b.1
        for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 18:19:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789953565; cv=none;
        d=google.com; s=arc-20260327;
        b=tAN1M1/o6icdYmnsM0mCi4ic2ctzl9OkNoRl6tk7i5TbGPWUZ7aHvSqka7BVDtaw5y
         DLxfjPJT52xakbpO3hMzX/xKrJ3GKeHZ95gD8XdwP3NGLTnMjamfs8ZVNM1jq9vswP2B
         YbLCha3QbOw2mog+udRen/fJkl+I7A6TXWvNV8LYh+g4NbpC1tTH2oq2oNkQoM+X4+J0
         kexv3TfZU3TaySZfJmhKxG0Er65s7x7m7JMbUcnmRqyoA7u8JwspIkLTdYH5tnE0Zy5Q
         Pe5N6Scb1qQYtYY4ZnkbBEbbAgvpjElPFicH6J1EkldjRPR9M3IgNSumDzQ9Nvpp97wB
         DlWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hfhh+c5YY12EVXNVBu8sm0eRIhxIeh4aWLnX4aXKNYo=;
        fh=+61pGqE+vLwvl44I1SEuZR2Zfm4hflqElWNG82DO/es=;
        b=ApohiQ7f4rwkOs4Qmld1/gs7YE5jiZoaMh9iGo50q52+alq46NyF4aAmUeRNhcmZ/t
         lXO+ZG9T0tJe2l6zNyXxQWHcwrrnaBNaHJ2YLNX1Bv1BrXuq+/33W0kDWLdy+b7h3Cii
         eK1YdT4xHy2EDtLJXvQw/FQmaKuLKeo3lKVhP2fesoZy/Hor1356djBi8v5vgeNaXLz0
         ENpqCJcKVmklaqi+G0fKR+PJUSutZ5xZioQkzjxQX8ppheDx8E5rdAe71cShbIyvbvoh
         x47FKL5b74TRKnDqNITYtBERrEA/h2BS27JL8mc2ymHZvrwXiLOZ6OgjVm1RognTcZU1
         9L1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789953565; x=1790558365; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hfhh+c5YY12EVXNVBu8sm0eRIhxIeh4aWLnX4aXKNYo=;
        b=QIvRRLK+krY8dmixuKYy9NGi7X84FB9k0JcS8q64IUdvdMpDGXPnOh961kiG9EGpdl
         WEiTMgPtC+osI/S7LOe8GrrCHMbZWNRyuoHAKCVIoLKWmrl+BugTcqiT7ry769oKYf/r
         Xvsc2J1KVkjrsUprJAk0esKLyZkM3BmeM9uTUV2p3mRGPiSfNoUOt9ZZJyQeLlR3kNTv
         3cQDIdYa0oEAeiTQl10yBQC37x/uiDSAA/vlRO32Hw0hMyHxYQ0R2ED3dMPC3TP+2raL
         9k1oOvKSKlTg/frOK5HqK/mhwGk8OxQU2g+OoYrV4g5LSOIJaebj93PhjUjzKShwHRId
         PXSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789953565; x=1790558365;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hfhh+c5YY12EVXNVBu8sm0eRIhxIeh4aWLnX4aXKNYo=;
        b=R0DkJ76S95q4HsCNiR7u7i3IFTZXOnNgrj8y/pAo8a7WL0hWGh4v1QpK5Vu/gN+5w/
         S0qaUncfUzUNqbzhSKVybxAuzoyxNmWb1PkgC9Oar7uM5sCUzIBQAqxpXsO3xds7ZcCl
         yT6og3zYnQ1OAB9Yr1tUE027QMSGqluu6z+tR1sjDiA/z94mrjCHd+ALo1yYb3VqSGcn
         1gbFygsM3FOhN8M+JdA5YC8fkXVuGGgqY5NCY9W8CbU2zyb7VLiV1ZxT3cGAYf4+OCU6
         ynqlept6+eYFEhK1nORKmTUM2he13T6xWGjUcRtEU9lDMFpwJ+eRKfdOVKGS52VJRpko
         XCuw==
X-Gm-Message-State: AFuF++nAmO4oP/3CrCX986kkIEzsq9uc3vyGinc2rY27iyWvTX+qVuk2
	F6EFcQJh6THQymBMNkqRjvRojBULbUVgbcN3Tla2BJRLFRYpkbsYhGS2V21Ke/u03aTmHl+dXmS
	W852BRh8YsW83avVYYDWQlezozBSia68oVA==
X-Gm-Gg: AYBFou3VcRFuWQCUtAX1auP+QwdWHUWI00lkh1Vea1jRqWQIcW9IhcKd/00s8ADPK1G
	bdOLlKHk5OUwy0x52qHDonIxL58uEjjX6xoKwIZo9yCXfcbuEZM88/5EbbDc0GHST5Sn3GqoV0x
	iQ5A7pEHdYb53x4dec5wdclCuUsiAxvN0WML92JZCnIbhUXT40ThFGlm/C3ilU/5H6/lAOCjhPd
	QiIOeEF7hqgAIV/7Xc9l76AjwPpGhx9yo6I6TAXFLLhjpOtNh27ZctiXejsk70NsS7wCOLfWo4V
	Ih8ld4I5JFKTeeahLI5VJ3kdKndfRSr5oDbj+j8Vrlkyeb5dWhXi9NRVxrtNukcN4Hyh0H1mQgd
	UZOSreUkKWiXX3+8MVrsMq2Wv4ZH7EpBVOFCXTvU/cA+6il7LdgnANNJU1ErR1xdZY93JN/uJHU
	JY3Cwuo6CczrbR4pjvmkMgBWhkyjMxsOURdm1L1hShwuivoogTyIsdnQ9icUC2FXPVyA==
X-Received: by 2002:a17:907:d0a:b0:c28:ec7c:27ae with SMTP id
 a640c23a62f3a-c2a15aecddfmr767261666b.25.1789953564969; Sun, 20 Sep 2026
 18:19:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916223228.271815-1-rosenp@gmail.com> <178994444750.2160803.15737331291670911275@kernel.org>
In-Reply-To: <178994444750.2160803.15737331291670911275@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Sun, 20 Sep 2026 18:19:13 -0700
X-Gm-Features: AcwNN1V5USA9DUgZKgQR3NMPwqVnFQM1hGdEh4oEzz3Sj6DomwRh8WV62bkhbYI
Message-ID: <CAKxU2N-1Xm5oHSriNWnmaYW9XM8nNV==6dq=kwSja=x1v6Zu2Q@mail.gmail.com>
Subject: Re: [PATCHv2 net-next] net: fec_mpc52xx: remove dead resource size check
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 20, 2026 at 3:47=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] drivers/net/ethernet/freescale/fec_mpc52xx.c: the patch
>   deletes the only runtime validation of the firmware-supplied register=
=E2=80=A6
>
> --
>
> net: fec_mpc52xx: remove dead resource size check
>
> This removes the minimum size test on the FEC register resource in
> mpc52xx_fec_probe(), on the grounds that every in-tree device tree
> describes the FEC node as a 0x400 byte region and the stale error message
> referenced a file deleted in 2008.
>
> > diff --git a/drivers/net/ethernet/freescale/fec_mpc52xx.c b/drivers/net=
/ethernet/freescale/fec_mpc52xx.c
> > index 5188551add0b7..14ad03d75598c 100644
> > --- a/drivers/net/ethernet/freescale/fec_mpc52xx.c
> > +++ b/drivers/net/ethernet/freescale/fec_mpc52xx.c
> > @@ -834,13 +834,6 @@ static int mpc52xx_fec_probe(struct platform_devic=
e *op)
> >               pr_err("Error while parsing device node resource\n");
> >               goto err_netdev;
> >       }
> > -     if (resource_size(&mem) < sizeof(struct mpc52xx_fec)) {
> > -             pr_err("invalid resource size (%lx < %x), check mpc52xx_d=
evices.c\n",
> > -                    (unsigned long)resource_size(&mem),
> > -                    sizeof(struct mpc52xx_fec));
> > -             rv =3D -EINVAL;
> > -             goto err_netdev;
> > -     }
> >
> >       if (!request_mem_region(mem.start, sizeof(struct mpc52xx_fec),
> >                               DRIVER_NAME)) {
>
> [Severity: Medium]
> Is the "can never be true" reasoning in the changelog accurate?
>
> The changelog says:
>
>   "but every in-tree device tree describes the FEC node as a 0x400 byte
>    region, which is exactly the size of the struct, so the condition can
>    never be true."
>
> The in-tree DTs (charon.dts, lite5200.dts, mpc5200b.dtsi, tqm5200.dts) do
> all use reg =3D <0x3000 0x400>, but the device tree is firmware-supplied,=
 so
> the blob is not restricted to the in-tree copies. Bootloader-generated DT=
Bs,
> out-of-tree board files and overlays can supply a shorter reg.
>
> Does anything else reject a short reg? of_address_to_resource() only chec=
ks
> representability and add-overflow:
>
> drivers/of/address.c:__of_address_resource_bounds() {
>         if (overflows_type(start, r->start))
>                 return -EOVERFLOW;
>
>         r->start =3D start;
>
>         if (!size)
>                 r->end =3D wrapping_sub(typeof(r->end), r->start, 1);
>         else if (size && check_add_overflow(r->start, size - 1, &r->end))
>                 return -EOVERFLOW;
> }
>
> So reg =3D <0x3000 0x100> translates fine and reaches the code below.
>
> Also, Documentation/devicetree/bindings/powerpc/fsl/mpc5200.txt does not
> state a length requirement for the fec node's reg, so with the check gone
> the 0x400 assumption is neither validated in code nor documented in the
> binding.
>
> [Severity: Medium]
> After this hunk, does mpc52xx_fec_probe() consult resource_size(&mem) at
> all? Both the reservation and the mapping use the hard-coded struct size:
>
>         if (!request_mem_region(mem.start, sizeof(struct mpc52xx_fec),
>                                 DRIVER_NAME)) {
>         ...
>         priv->fec =3D ioremap(mem.start, sizeof(struct mpc52xx_fec));
>
> __request_region() validates against the global resource tree, not agains=
t
> mem.end, so a short reg is silently over-claimed rather than rejected. Th=
e
> declared length then has no effect on the driver at all.
>
> For a truncated reg, probe now proceeds and touches registers past the
> described window during hardware setup:
>
> drivers/net/ethernet/freescale/fec_mpc52xx.c:mpc52xx_fec_hw_init() {
>         ...
>         out_be32(&fec->rfifo_alarm, 0x0000030c);
>         out_be32(&fec->tfifo_alarm, 0x00000100);
>         ...
> }
>
> drivers/net/ethernet/freescale/fec_mpc52xx.c:mpc52xx_fec_reset_stats() {
>         ...
>         memset_io(&fec->rmon_t_drop, 0,
>                    offsetof(struct mpc52xx_fec, reserved10) -
>                    offsetof(struct mpc52xx_fec, rmon_t_drop));
>         ...
> }
>
> Previously the same input returned -EINVAL with a diagnostic. If the
> over-claimed range overlaps a neighbouring reservation, the failure now
> surfaces as -EBUSY from request_mem_region() instead.
>
> Would it make sense to either honour resource_size(&mem) here (for exampl=
e
> via devm_platform_ioremap_resource() or of_iomap()), or keep the minimum
> size check and just fix the message? The stale mpc52xx_devices.c referenc=
e
> and the %x versus size_t format mismatch look like the only genuinely dea=
d
> parts of the removed block.
It is close to impossible to get anything similar to this merged.
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20260916223228.271815-1-rosenp%40gmail.com
