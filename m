Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792422229;
	b=BefcF3YFToHlpXm9HwRSHSztydCWyzEIIYwPk6x+8xopH82iB88DDrFwuuQckLP/7hNU
	 PvBifM03HhR5IvkbSLcTGQKF36vJ1tn7qIV1BCFkPYktgKBtsiSJ9+ZVpv8tJtvhbu1Qo
	 /54B4DaEIZzOfrKFZG9K0cld+K+wlDXBviV77SOCmNCWveUy04KRPlkPUFQbH8y6+XoHp
	 WJ80JgFL05fURLJAxEr9dh/p3myhTDpu1NaDMdtWIIxVCDqoo8P/8DEV48qnRW4CD5Ct2
	 i4xSHwRpfvdT7T/0wqWPjkW9LPMeTh1Hqd9kOLA2gLTTSriDSwMb5A9wJhHKbhufG4A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792422229;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=5QTDlON/KbcJhL3/P1XHXLsZg4JTmgtOWrzjy+XctCQ=;
	b=vQrEDM45MsIjABtCEIkQwKIdAfxwuveZ0djUKC9gk44gerw7CAjZ07rHV41T+3rXZqxw
	 RAYigv9BLx2MptI6o6aRXdmBv02gkVRtFSBiSwau2ggiffCNTGCLdi/z5wne+8qx6/gSg
	 75ac7AnC7jtxnggZaJ9G28sdaDLzn5j/f9I/Brv1xTuoqTLtpTVAM3X52f/w8/W+31GRX
	 uoMOaBgqHNXI/DOEFCjAXyyHrS8OGrw7IbMC+5LKjmyIpJYlMYKjeghAOJxdPfQRK/8b5
	 R2jvVbX7MfHcyCyIIDW99NrA/WlqfR9kDidtQtHopg1YbsPc61lTgIQbulIrU3AZoqg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lfLxaypf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.178
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1551607DC66
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 15:03:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1551607DC66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lfLxaypf
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8ab43af5e97so21874807b3.1
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 08:03:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792422228; cv=none;
        d=google.com; s=arc-20260327;
        b=PowzBN3RX+0XMNsJOFZd8i18KC8AljFD14Lr040SP20Ih96AFnoyXI6Yp8IJrCRv2X
         zBCpyvOTWTCOgz/ZOl0bgkwGFsfZ8RjtMzRwyjKkrVetHWa8WfaTa/+hC1GT6+RuydNr
         mHN/TKGgp9UViz4XN/gYS/89xEPFJ/w4xtxs8MnMTktDqFWpdh6TPvWYTkX3FSUvRCV5
         Ljo9DetNxto8bLfPrIbKNEmoGu27KJl7ahZZNPF7Clrylzd0IvcG+8einMprXyAaGtIn
         VJV6d+jYRe0yVeV0vgSgcGBm4j6EQ2OyORmPJFBhwgXeO3E5G0ZfwMHlqprXrM/0YcmD
         snIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5QTDlON/KbcJhL3/P1XHXLsZg4JTmgtOWrzjy+XctCQ=;
        fh=s3lTEjQr16JyoxjdHzuuib6n3e0eyt9hxlKpR5U54lM=;
        b=DT8AZtypPmewn815g6cQdH9NNRO5VYQ4aSesgKV7v9YRafdE500FNBNzU6iYr6VTxV
         xbVMezY8bz7CmMfraMxtlLDysG0ybWQ4DbgtPiYzWPu0PD35QxdkclQ+Y33y9jrImSXS
         sJ7jphZqcYqH0QR8lxP6YDtQMVGbEaAg20El1GaCRqgKRg7elZgS8nLPzNtUYv9ZKkCY
         IW5IPeQal3jnNqaGoNRYtzuVI0XfWlRqEUMmUzGsUb7wPRndcJ8WdbQ3LEptSF97qZz0
         Fl4PzAwUPyyZ9BJM6s+kyKENWdqVkY/ATYi5sJPiOIIKcRG4iUMLCk6gWl4vpn0WH1df
         7fag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792422228; x=1793027028; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5QTDlON/KbcJhL3/P1XHXLsZg4JTmgtOWrzjy+XctCQ=;
        b=lfLxaypfn5eTo3Pwy5z2Wo4EQ45+jftWf8KJ/H7Tjsed4+okOibCAUfO+2r1xNGqdN
         q7SYAYbW6h9ZxdtVu1TkoWJxAWZw/cH4Px642yvRfb1RVKtCTGI11Ss9XtMvbe1JSL2k
         g1DJXupIXb4JanvOFNN6DT2cEA4ttK4thLI9/QwracZJUdq7ar/5gOVi4GN/k0Cufs9y
         /Agug1TKmWro2+bufkfw38VQPwCnp4Uft5MhztP6cYDo6OhG5rfmRdBJSbaqfev9qoUa
         O+9iOXiMMGzFbj4SZgB45HWjtw0Qgn3uM4vmJJSPrHAK+5FYhbFU4L597wUfTXInelcE
         7kVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792422228; x=1793027028;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5QTDlON/KbcJhL3/P1XHXLsZg4JTmgtOWrzjy+XctCQ=;
        b=TqealGod/N9UO71zkwPZbBHCVXf8hPWG/YsJ5EZU4cWmF8peOUT09sNZqmCPdpSNBD
         fO/58FH1gugWlrIve8i64PeYUkJu4bbMUFsSVtC6BDUE8y4CjTY0jxsb3foCWm8bhBQg
         LgT3OTirM37ACvsBFB0v7VaqadFEK649eqTxwsUVVmQuWsYd7I0UGXLZOqPCpt4tZlKh
         GIToHYP535cWGm9wbYPgihDe6pXWSNj5ALCfWoU3pm/S5+yyIBYIMMb1fpr1tLJFMVim
         ndHeGLduehVom6Mz6PNtl4yQp3wcrxNntUh/KWbx+PtoWYJtZnQUzEVogrL6NIh6Ew2/
         JXWw==
X-Forwarded-Encrypted: i=1; AKwUvByJbgVJbQuKYxnA1FEYiAcpsJpnTaL/0BFQ2/6JwT1HiiAS8+y6JxW/JUQnvwtk4wAF23REsqY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ25TPyRjrT7y7LgCZrlq2EnSOSRZf+5gfNw7VcRfMiSdVBg9kR
	gha2t4qcOuDL6HLScl2dwCiKrtbli1lXosgBaAwCq8KAO0GpEKsjLhVxxk/8b0LbikUORn+9u5o
	o/xfP7OyT7QHeQKptgVrm+gVn0Cr98Gs=
X-Gm-Gg: AYBFou3dzjWcdgIpNOW38r9pG38jv+nWxT+1pOvVz2SDgxH7pFeNaykGaGb1xWiKj02
	k9lche0e/pZM4ewdLYPjKX/EGDg+SW1nLkl+vlp7dhoHHD7TlyiOTBvEOfAlQCl2FIzUDhgynXV
	2f9indAc1AHOgZMPK2iC48r83WAYxBCiC+cPVICtmFNEI16DqxBpnFD8VVNZxwNomD6JUQ3g5UJ
	AGc3q0rq0i3ySvx7LbqP9EPonkZzrlP85zFrFPCV2O6K6ksklxSYe9zlMd0O6fM5Brtwh09RtPb
	s7AT00oVAJKnxAG8v4l+NGiY7tBOHufIm9g8VoYDrXeE6vNSA2hGlXOBBJcnX+ovrlzRmFPCrZB
	F3LaDrS/Cz0UKxQ==
X-Received: by 2002:a05:690c:dd5:b0:8b0:ce9f:29a5 with SMTP id
 00721157ae682-8b0f2134c02mr22560477b3.18.1792422227751; Mon, 19 Oct 2026
 08:03:47 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261018203215.77371-1-andrebrait@gmail.com> <atYbzARmBOVuRTdW@luna.proxmox.com>
In-Reply-To: <atYbzARmBOVuRTdW@luna.proxmox.com>
From: =?UTF-8?B?QW5kcsOpIEJyYWl0?= <andrebrait@gmail.com>
Date: Mon, 19 Oct 2026 17:03:10 +0200
X-Gm-Features: AclHuK-nY0XZAuJA3DmN1wCDwTD2SwIY60IsaVP3Mg8yQeVWH5_YcsZSKoFnKPI
Message-ID: <CALhGy9=s7FDzCPUWiEc-XFJUrRjkr13Lmq-_ZXWXaCm9cm6p7A@mail.gmail.com>
Subject: Re: [PATCH iwl-net] e1000e: segment TSO packets whose headers cross a
 4 KB boundary
To: Gabriel Goller <g.goller@proxmox.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

**The previous email was sent as HTML by mistake**
**Sending again as text. My apologies for the noise.**

Hi Gabriel,

Yes, I checked the ordering and this leaves a gap in the check.
Software VLAN insertion moves skb->data back by VLAN_HLEN, which
can create a header crossing when the original data started near
the beginning of a 4 KB boundary. skb_cow_head() can also relocate
the buffer.

There are other later layout changes inside e1000e too: the payload-pull
workaround in e1000_xmit_frame() and skb_cow_head() in e1000_tso().
I need to account for those before relying on the checked address.

The posted testing covers the original untagged reproducer, not
these cases. I=E2=80=99ll address this in v2 and test the affected paths.

I think V2 can make the final decision inside e1000_xmit_frame():

 1. Complete VLAN insertion, payload pulling and any head copy-on-write.
 2. Check the final buffer address and header length.
 3. Use hardware TSO if safe; otherwise explicitly segment in software.

The check must precede TSO header rewriting and descriptor programming.
AFAICT software fallback also needs correct ring-space and queue handling,
not just clearing feature bits.

I will have Claude try to reproduce this on the same Proxmox hosts
with the v1 fix already applied, to isolate crashes to later packet growth.

Andr=C3=A9 Brait

Andr=C3=A9 Brait


On Mon, Oct 19, 2026 at 3:36=E2=80=AFPM Gabriel Goller <g.goller@proxmox.co=
m> wrote:
>
> Hi Andre,
>
> On 18.10.2026 22:32, Andre Brait wrote:
> > [snip]
> > diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/e=
thernet/intel/e1000e/netdev.c
> > index 834a5b888..6f95ed19a 100644
> > --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> > +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> > @@ -11,6 +11,7 @@
> >  #include <linux/pagemap.h>
> >  #include <linux/delay.h>
> >  #include <linux/netdevice.h>
> > +#include <linux/sizes.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/tcp.h>
> >  #include <linux/ipv6.h>
> > @@ -7359,6 +7360,34 @@ static int e1000_set_features(struct net_device =
*netdev,
> >       return 1;
> >  }
> >
> > +/**
> > + * e1000_features_check - validate offloads for a packet about to be s=
ent
> > + * @skb: packet to check
> > + * @netdev: network interface device structure
> > + * @features: offload features usable for this packet
> > + *
> > + * The transmit DMA can stop for good when a TSO packet's protocol hea=
ders
> > + * cross a 4 KB boundary in the buffer holding them: the descriptor is=
 never
> > + * written back, the driver reports "Detected Hardware Unit Hang", and=
 only a
> > + * reset brings the queue back. Seen on I219-LM/-V (PCH) with forwarde=
d
> > + * guest traffic, which arrives as linear GSO skbs that can start anyw=
here in a
> > + * page. Let the stack segment those few packets in software instead.
> > + *
> > + * Returns: the features to use for @skb.
> > + */
> > +static netdev_features_t e1000_features_check(struct sk_buff *skb,
> > +                                           struct net_device *netdev,
> > +                                           netdev_features_t features)
> > +{
> > +     if (skb_is_gso(skb) &&
> > +         (skb_shinfo(skb)->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6))=
 &&
> > +         (offset_in_page(skb->data) & (SZ_4K - 1)) +
> > +         skb_tcp_all_headers(skb) > SZ_4K)
>
> Hmm, doesn't validate_xmit_skb call validate_xmit_vlan after the
> ndo_features_check, which means that the vlan header can be pushed into t=
he
> packet? Meaning the packet can grow after this check.
>
> > +             features &=3D ~NETIF_F_GSO_MASK;
> > +
> > +     return features;
> > +}
> > +
> >  static const struct net_device_ops e1000e_netdev_ops =3D {
> >       .ndo_open               =3D e1000e_open,
> >       .ndo_stop               =3D e1000e_close,
> > @@ -7378,7 +7407,7 @@ static const struct net_device_ops e1000e_netdev_=
ops =3D {
> >  #endif
> >       .ndo_set_features       =3D e1000_set_features,
> >       .ndo_fix_features       =3D e1000_fix_features,
> > -     .ndo_features_check     =3D passthru_features_check,
> > +     .ndo_features_check     =3D e1000_features_check,
> >       .ndo_hwtstamp_get       =3D e1000e_hwtstamp_get,
> >       .ndo_hwtstamp_set       =3D e1000e_hwtstamp_set,
> >  };
> > --
> > 2.56.0
>
> Gabriel
>
