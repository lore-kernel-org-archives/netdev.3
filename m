Received: from mail-oo2-f0.google.com (mail-oo2-f0.google.com [74.125.231.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FCC19005E
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 04:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791692254; cv=pass; b=mnSdbAqyd2/2wbh4u17C6xyysv8kEOOdFs8X4puzZI0g43qKeQmS5fI3Lrfk1xV7ipU9roo4GMkhzAWnFGjbLDQ+5F+QIQ6GmqqJzOvHG/CZN85EKGg4UbZU5W1wLKFhzjBzAcwbFTFEWoV6xblq3et9VpicUHMZ7uCNaWGlz+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791692254; c=relaxed/simple;
	bh=EojC/6mtzUWJ7avmaSpCmXay/upr0JmdGGgyCBDDGzY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OcR5ccfrTV/m//SbjkVgJcbCzg1/gpUX4c0clnGDZdHw9gTO9mTOGWNQ+biRy4iyBdrwPyBmZ4Z4A1/OUS3wd/QdfGKU2T3wh9jaZjUDdfsuJh9yKZ0DL8wTDCae1rey0dY+bzfM49dPVjHte3PGo+ew1/0n4WkGP8nGztUjWiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=acqmmXTL; arc=pass smtp.client-ip=74.125.231.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="acqmmXTL"
Received: by mail-oo2-f0.google.com with SMTP id 46e09a7af769-824040a3379so398698a34.0
        for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 21:17:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791692251; cv=none;
        d=google.com; s=arc-20260327;
        b=m4DBXoI22tgVeDRoyovO5XZ19TTCbfY9MtkHe9ChN80/LEzXRA4jLgdoLME3S+F6PA
         bsmWd4a1YpGM0kDMMdmgaTdK/a8ypJuaWVGbPq48ZInuwkiP8G+MYPWywXUBT7DdSmbv
         PhZeD2iC2GOXVc4Odpkdt0zpqLxEfVuzJVqb/Ov7K7mhJ3rOdl5eXezopQJUP/vZf/NO
         /dykoMxv1jQSqz3RJ8fXAdsB0yIljKEcQ285nQRDgskNeEXRmmVi2SjB/ag1DRJeZmva
         RHTTAVHzMw0Xzs6b99TrfSaJ0Z1lJUNxKN1xw7I4M7r2v5tM58wToXACJabnb3+RR09K
         wmFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ze3tU5ClgmV//hWYQFqIt/MG2FODlVRCQlPbo8m5k9w=;
        fh=OOfZzHJZc7VF8olnIjmbnpxcBUpfWvHiME6ZW7a0zvQ=;
        b=hOqIxPXIjeJXZ54n88tNjliwtaPh+noqAebNWfNRJ0v5LUu3CHjoZKgbJmOfDqxWLX
         Np4ZHYNIu9+m1YTOmpZLAA9Vk4Spg0RvNPPy/jmMNXKL6sXIiDgtlsanTecn9GCFXkJ0
         iLmxHMBBFOLl+4+5K6E9sG1+5e//MTapynxpua5VsYek3WIgJp9E8xdrpCfGLxzWlU8t
         XCUJyR+b3tIoQsa3tpaU63O3D8CsSLFhUOPAq0XnKudX/FJvrzaCZ33b2rj7dULO6H0X
         /e8La4429Nf6KNbYW9oY+IqlB0cht5wEpZrfj9ESkM0PQYgZQJJ09IqEzfdz6MH5sFSK
         Fxcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791692251; x=1792297051; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ze3tU5ClgmV//hWYQFqIt/MG2FODlVRCQlPbo8m5k9w=;
        b=acqmmXTLH3/JqLul4xg0YhnqrVxyfR3hxgvuPybOeTz/MIUiN972T+nMdl+nhNsiiZ
         gvAHayn/EDi5xIoaRVVuIcMNda+TXC9UMymbknO+5KlK9Dg1n4Ix7EZeb+OrwClrjnw5
         ELkGj3gVIPRiJv4h5eChhfSbpOiKnT7Ei1l/5/ovHXZzXdLecQXJXuyZGXUpVvoYC/XW
         pAQ6j4JkRHG8A3QXwEp6L2TmagY8cMV/d2cHFeUL1QfLJgVBDPipiPrd1orkQKiBKQDL
         8A8wAHFnu0Qz0C8xMnWMCA2UyPG3KIwR3ikjXCmS/+BpPCLddzYu0/wA0BirwanIMDQ6
         V9gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791692251; x=1792297051;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ze3tU5ClgmV//hWYQFqIt/MG2FODlVRCQlPbo8m5k9w=;
        b=hhR2iQtzHje9kCxVIsIXCdfd1EzP7oCMliJOb0u//mMbIOqTZ4bsZjtZil5E4AWTAE
         LTBrLX4Di2Run8PkwPPkcjni8JIOWKuoEhnXZw+zhZiZFuwoaPCSqUM0o7lfWhJXEVZl
         CVZ68a+N0d+xYy9eVY7LViYPzQ/79IkCfvjgYvIOfPeBmPdRnxzIa36/fFcVa3z3jFMU
         rR/p8t0L9YedsnSc4Wq1EEDnccH4vTivd17+lYDBX5fKcnJDcYH+lSodrZA5KVrMRu22
         mTgQrxD6YssaXu0XfJ27k1k6gREFH+0+efngRh29PkrBkPPKoioViPeHPspydZHV/gqN
         x2Zg==
X-Gm-Message-State: AFq9FYKh1k4CsifMOwqPeqk35Q2fChd8nRLHt3VReB0sEdB2/kQFt7BK
	qEkeN64YPFbG5bRkTlf4LWcWJYnkpI6PKh+oUMYK0iOnFRNGoZ6eqXW+jJuXXqJWDmOvk7c+7QB
	Lr8Y7t6zWp7LMI531kLZtP/ayOmzORnA=
X-Gm-Gg: AYBFou3IVD0vyfnX65k1P3ilL13t+Xran2XBiiB1CZLanLuzIYoiBf33S1yNgqxvRBe
	eUVFohBALq8jK56izfkTNz7WAjVHaZQx1cmdwFjHLNERiboCaZ4RkzzGwouBtgptjr6Z/PbV8R7
	cRHcKfnch3iaj46Pql8Wq46hMuTLzdncoI6MRWmkcdcbZwAedd90iDLKoj026iadaQEl54D9NXA
	HgrcSVUkx39PkAlLHXSUim325PCtaOngOccaDfHBgbMve8FlM1ktkCBtRLJNLix3DvJgpy+d0D1
	ZWHqA5UIMVsk2iQ3apNuLqMZAUvnQ9zjFR2bXGdc6WKPf6I8HjzJHcMkIHZKxBpwCB/SG0RVVbG
	pdlb1X0VVTqND2eNPlbrMKGM=
X-Received: by 2002:a05:6808:1908:b0:4b9:a88b:8884 with SMTP id
 5614622812f47-50c50f2e1f2mr6409320b6e.26.1791692250833; Sat, 10 Oct 2026
 21:17:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005041525.49111-1-xinsheng.zhu.ny@gmail.com> <179134657946.434549.14071341559835135672@kernel.org>
In-Reply-To: <179134657946.434549.14071341559835135672@kernel.org>
From: Xinsheng Zhu <xinsheng.zhu.ny@gmail.com>
Date: Sun, 11 Oct 2026 00:17:18 -0400
X-Gm-Features: AclHuK8R4vcLcP0LXZ-tOoywSVJ8FWjq2V0QOjKOAR5xzmbA-pdI0ZnoHItcWRs
Message-ID: <CAFGKm+zjOtU8WGpcqqb6_XnFd3vmPw2RszPig9PJzbq3Uqh_Lw@mail.gmail.com>
Subject: Re: [PATCH net] net: usb: cdc_ncm: reject short GET_NTB_PARAMETERS responses
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, oliver@neukum.org, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the review.

> Should this branch return a negative errno for short reads? For example:
>
>         return err < 0 ? err : -EIO;

Yes. I changed the condition without adjusting the return value and
overlooked the zero-length case.

When usbnet_read_cmd() returns 0, the new branch returns 0 before the
remaining initialization has run. cdc_ncm_bind_common() then treats that
as success. This is a regression introduced by v1.

I will fix this in v2 by preserving negative errors and returning -EIO
for short responses, including zero-length responses:

        if (err !=3D sizeof(ctx->ncm_parm)) {
                dev_err(&dev->intf->dev, "failed GET_NTB_PARAMETERS\n");
                return err < 0 ? err : -EIO; /* GET_NTB_PARAMETERS is
required */
        }

> Is it intended that these responses now cause a probe failure for
> cdc_ncm, cdc_mbim and huawei_cdc_ncm, which all share this bind path?

Rejecting incomplete GET_NTB_PARAMETERS responses here was the intent,
to avoid continuing initialization with parameters that the device did
not provide.

> Should it carry a Fixes: tag?

Yes. I will add the missing tag in v2:

Fixes: 36c35416a94f ("cdc_ncm: fix endianness problem.")

Thanks,
Xinsheng

pw-bot: cr

On Wed, Oct 7, 2026 at 12:16=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 =C2=B7 Low: 2
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] In cdc_ncm_init() (drivers/net/usb/cdc_ncm.c:527-529), the new
>   check `if (err !=3D sizeof(ctx->ncm_parm)) { dev_err(...); return err;=
=E2=80=A6
> - [Low] The patch makes any GET_NTB_PARAMETERS response shorter than 28
>   bytes fatal to bind (cdc_ncm_bind_common() -> error2 -> -ENODEV).
> - [Low] The commit message describes a defect: cdc_ncm_init() only
>   checked `err < 0`, so initialization continued with an incomplete=E2=80=
=A6
>
> --
>
> net: usb: cdc_ncm: reject short GET_NTB_PARAMETERS responses
>
> This patch changes the GET_NTB_PARAMETERS check in cdc_ncm_init() from
> err < 0 to an exact-length comparison against sizeof(ctx->ncm_parm). The
> goal is to reject short responses instead of continuing initialization
> with zero-filled NTB parameters.
>
> > Require the return value to equal sizeof(ctx->ncm_parm), consistent wit=
h
> > the existing exact-length check for GET_MAX_DATAGRAM_SIZE in
> > cdc_ncm_set_dgram_size().
> >
> > Signed-off-by: Xinsheng Zhu <xinsheng.zhu.ny@gmail.com>
>
> [Severity: Low]
> This isn't a bug, but this fixes the unchecked response length in
> cdc_ncm_init(). Should it carry a Fixes: tag pointing at the commit that
> added the err < 0 check, so stable backporters can follow it?
>
> > diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c
> > index 35db38cb3e4a2..66f40f0d9c273 100644
> > --- a/drivers/net/usb/cdc_ncm.c
> > +++ b/drivers/net/usb/cdc_ncm.c
> > @@ -524,7 +524,7 @@ static int cdc_ncm_init(struct usbnet *dev)
> >                             |USB_RECIP_INTERFACE,
> >                             0, iface_no, &ctx->ncm_parm,
> >                             sizeof(ctx->ncm_parm));
> > -     if (err < 0) {
> > +     if (err !=3D sizeof(ctx->ncm_parm)) {
>
> [Severity: Low]
> With this check, any response shorter than sizeof(ctx->ncm_parm) now make=
s
> bind fail. There is no fallback, and the wLength the device reports is no=
t
> used.
>
> Before this patch, short responses were accepted. The zero-filled fields
> were then sanitized by cdc_ncm_fix_modulus(), by
> cdc_ncm_check_rx_max()/cdc_ncm_check_tx_max(), and by the
> tx_max_datagrams =3D=3D 0 default.
>
> The commit message calls this "consistent with the existing exact-length
> check for GET_MAX_DATAGRAM_SIZE in cdc_ncm_set_dgram_size()". That check
> is not fatal, though:
>
>         if (err !=3D sizeof(max_datagram_size)) {
>                 dev_dbg(&dev->intf->dev, "GET_MAX_DATAGRAM_SIZE failed\n"=
);
>                 goto out;
>         }
>
> No device that sends a short response has been identified. That makes
> this a compatibility question, not confirmed breakage. Is it intended tha=
t
> these responses now cause a probe failure for cdc_ncm, cdc_mbim and
> huawei_cdc_ncm, which all share this bind path?
>
> >               dev_err(&dev->intf->dev, "failed GET_NTB_PARAMETERS\n");
> >               return err; /* GET_NTB_PARAMETERS is required */
>                         ^^^
>
> [Severity: High]
> What happens when the device ends the GET_NTB_PARAMETERS data stage with
> a zero-length packet? usbnet_read_cmd() then returns 0. Does this branch
> log "failed GET_NTB_PARAMETERS" and still return 0, which the caller read=
s
> as success?
>
> __usbnet_read_cmd() passes the usb_control_msg() length through unchanged=
:
>
> drivers/net/usb/usbnet.c:__usbnet_read_cmd() {
>     ...
>         err =3D usb_control_msg(dev->udev, usb_rcvctrlpipe(dev->udev, 0),
>                               cmd, reqtype, value, index, buf, size,
>                               USB_CTRL_GET_TIMEOUT);
>         if (err > 0 && err <=3D size) {
>     ...
>         return err;
> }
>
> cdc_ncm_bind_common() only treats a non-zero return as a failure:
>
>         if (cdc_ncm_init(dev))
>                 goto error2;
>
> So bind would continue, but the rest of cdc_ncm_init() never runs.
> SET_CRC_MODE and SET_NTB_FORMAT are never sent. ctx->is_ndp16,
> ctx->tx_max_datagrams, ctx->max_ndp_size and ctx->timer_interval all keep
> their zero values from the kzalloc.
>
> With ctx->tx_max_datagrams =3D=3D 0, this loop in cdc_ncm_fill_tx_frame()
> never runs:
>
>         for (n =3D ctx->tx_curr_frame_num; n < ctx->tx_max_datagrams; n++=
) {
>
> Each incoming skb then goes to the "free up any dangling skb" block, gets
> freed and is counted in tx_dropped.
>
> On the RX side, is_ndp16 is 0, so cdc_ncm_rx_fixup() calls
> cdc_ncm_rx_verify_nth32(). The device was never sent SET_NTB_FORMAT, so i=
t
> is still using its default NTB16 format.
>
> With CDC_NCM_FLAG_NDP_TO_END set, kzalloc(ctx->max_ndp_size) with a size
> of 0 returns ZERO_SIZE_PTR. That passes the NULL check in
> cdc_ncm_bind_common(), so the problem is not caught there either.
>
> Before this patch, a zero-length response went through the full
> initialization with sanitized defaults. Isn't this a regression for the
> zero-length case? Short reads of 1 to 27 bytes do fail bind, but only
> because the positive byte count is non-zero.
>
> Should this branch return a negative errno for short reads? For example:
>
>         return err < 0 ? err : -EIO;
>
> >       }
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261005041525.49111-1-xinsheng.zhu.ny%40gmail.com
