Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E40223183C
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 00:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784680370; cv=pass; b=Waw8RiIoVcjZkWqdGhyIyzrKoIHOixvslIo3fqhWLaDH2P3j278djIVKSC25EM8N1yfMXQK4B1QpNwsr9qtuLkQB9y2ZHrbKbE9HpzjzTDH29hppLjYBQLhF3JY+dr0dqs8hAQ3cY7h6JoirxIOD/5dMMvLSOa6g4hYhC5azkBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784680370; c=relaxed/simple;
	bh=xj6AJTCRVisGLyGI2Dqui1UxE4C4Hn6yJ1tGOWs/rz8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G51/eXZItJCqfnTbuj8MlqNcjqLFqGsybanNUH2TKRX4Gkb2SLgLB4rm+S1aW+Q0r9anmE3dm5xH/uD1PfLfuWGibfveFsUdy3tWmlov6ue6DRDfSiE/BmE3CjE7g+Eamx3nws7P5jPFSoku6peT68fqDFsxUEygBa6LBsDApwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=HVecAvVg; arc=pass smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="HVecAvVg"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84864086bfeso12670000b3a.1
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 17:32:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784680369; cv=none;
        d=google.com; s=arc-20260327;
        b=owhV2xF+9fYwKAfr9c/Lja0Uq9GHc7tWZ2+S3Pkx6ENJyCVBz+QR7vpUHX/UjZgWnz
         fuEZrIJHRrb/SVVxp36xFtj+y2H6e35mhjBfpZLsDdkuH69wv6SrIcv581FaZR70kuRn
         BIV2lBkxyutoj8FaNxPK2HtvMc/oZRMMUQ+ZgJkqdvL+jEcG/rdZ3VO4MUFrz2GNcvOg
         qaq5IMBOOEWN8vHnYYAzEeNGxi4oZVZJ7k0yw38IqtG4pefQnsY4/r1aVJLRBM8wa6Es
         YfLixvNFODhVqsyUoIJjpohWsze/365Q9IfNayv8+He0ab3YAmXNKD+NEQjPAqvG5ivA
         l3Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CjHUP4M+ePKMXAG6KJT5FeCRTglKP3jyZi9oz643nXs=;
        fh=6Tk8DpkvkGELfavGRK3NarWcW3Te2seU5MDYqAByhvc=;
        b=YIg9Dxr1fKaaFOTPAI8/1p9/nmkpCf/uAt+oOgRd+BrelSn5UrPoihELT7cC2Mq4Nx
         52wap2zYZia3iAs+BHUYKyUtp4w46g2XzhAxsl1z8uz/BLn6FuswJ+oHVaAzsRplkYwD
         LjUAtHZn5r6FQsenwyfyImW8KzA4rgCrbEFyE2szbBoJZxQCl8N68RJSidlttNLrdkma
         66hnNlAn9vDhJiT7qgPBq/0d6f7c9969FCDkF0MuT4bSvhJoAPMDx4hYD6DwYEfr1KVn
         ie+5zfiPZ9lq/Xih2EyXUjU7sgx8oFMJuYCb/oAs5vz23Ikut237ezdvAZHSQhDhnl+m
         ldlg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1784680369; x=1785285169; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CjHUP4M+ePKMXAG6KJT5FeCRTglKP3jyZi9oz643nXs=;
        b=HVecAvVgE9s+3VEi8NTcFlytsmN5emyo17XFlayCikq7NzVJ4vk0sNJC+WLzJqxdhS
         15RjDJMvE6fOhvRVrNwsTiCQKiAy1AuAJi8y4g0JpdMbK16tqFVzkmetj2YaOMM2vtKe
         Udm+xP7/MQl7x+kB1r0IQL3nRZlhmyn4uRhFgFcOZKkADbp299MH/Hjj1zScOWRosY9w
         UwC9lN9X71d6Ou6UlJg1mRjf/vQCAGK2Bcv69YTSLT5+dLCviWiiXSdT8VuIiDCWWmmu
         7aXuSglednaacCEqUmhWZcSQjUfHg8aQEbpMdKNLLumLpKgaiLxxVCDlUCbnFmun1dDL
         eHuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784680369; x=1785285169;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CjHUP4M+ePKMXAG6KJT5FeCRTglKP3jyZi9oz643nXs=;
        b=tF3y2u+i+kRmG9NUuL0Co9lNCa6BfI5v+rvejEGdZohqH8FSihQyVNZutpYAscSzjO
         FNND35ZMgdGe0xiC3hIV/ahlUTfR5Xyj7JFcE/+RXXdebNbwY+6BjdzVd9I8pM85VIMN
         5LOWtDk94eIW0fxcknDs/LFzwJ3LyTEhKXrqP4V0XkFb7W5Ui1VuO6D7xK0EYy/92lQI
         qfYnW9sunwK70ZeTz/M15Mw4afhALW5JNrohXoEQNkDZdL46Sn0NFlV3e9hInar2oRxn
         z7TpYd0dgmsZIdc664jJzurwNaeYBkXDVvf3/hB2TZWcRR35KIT13Ua0Q9gaeR1agfYH
         pw0A==
X-Forwarded-Encrypted: i=1; AHgh+RqBdmLAEFDjXef+oiZsnXwZ402341wiFkLJ/keKQxLCsIVupZsSGaHPebloWBPhvLd++/c5uSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAkaB+lQMN+paccg1ruWebE28kiTG/I+VaxOfBIl6asaVAZlZm
	awXHusDCe/JaNx8SsC2MkTJESSkORPK654MPlGoNqSXldFXdkH0UO/F0ezQ2CJSpUUlQxUE9OuT
	RyNHoyUBEWDBW/Mhy7DSN0HqPf8U7mwCHNLH9i8VN
X-Gm-Gg: AR+sD12cba3eeSVjMNWM/3OqMtJyr+oYWNxj3+rq0yyMaQ2KttP1kB1AZAV7jb7WUR3
	BSPor4/vgo6UQnXmd1AN9bvHNoOHCH4o/dP4SV04nBJyqiB9nBSqNA4uIjdrsBPk+PquwIP2IhP
	5JIZvIvZDz9DIVQ1SOvDrATzXcnTBhhmoj4xIUee6JHjEaAxxIbcG4QR9hg+Zq13HXnvDihd5XP
	mdT/hWxz6QjlVk3+JwlHn0za3IT7afcb6mmcMz/n5QJa+4I2DTiOY3ZIZjvhUtKZPrXYtuTzyr9
	Ln6Ma53QiUHsmOeIJQ==
X-Received: by 2002:a05:6a00:3e06:b0:848:60a3:bdc2 with SMTP id
 d2e1a72fcca58-84c294bbf89mr18920959b3a.60.1784680369019; Tue, 21 Jul 2026
 17:32:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721232805.2451198-1-xmei5@asu.edu> <CANn89iJkaPSMay3o6ibejpZh0p7MzKOjDps=6wVpSeAaCRRL=w@mail.gmail.com>
In-Reply-To: <CANn89iJkaPSMay3o6ibejpZh0p7MzKOjDps=6wVpSeAaCRRL=w@mail.gmail.com>
From: Xiang Mei <xmei5@asu.edu>
Date: Tue, 21 Jul 2026 17:32:38 -0700
X-Gm-Features: AUfX_mxS0NxSCJZsXt07Y9ItxykSRg2OPcqtiU19WVQm-XkyAkn_R1_7GAhzyAs
Message-ID: <CAPpSM+Rho_6skd+CmEnFnqjFYDf62ttDpeQkAB+6f9+=eaY2tQ@mail.gmail.com>
Subject: Re: [PATCH net] amt: linearize skb in amt_rcv() to fix use-after-free
 of cached headers
To: Eric Dumazet <edumazet@google.com>
Cc: Taehee Yoo <ap420073@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	AutonomousCodeSecurity@microsoft.com, tgopinath@linux.microsoft.com, 
	kys@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 5:10=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Wed, Jul 22, 2026 at 1:28=E2=80=AFAM Xiang Mei (Microsoft) <xmei5@asu.=
edu> wrote:
> >
> > The AMT message handlers cache pointers into the skb linear area (grec,
> > iph, ip6h, eth) and keep using them across ip_mc_may_pull() /
> > pskb_may_pull(). On a non-linear skb (e.g. a reassembled fragmented AMT
> > membership update) such a pull can reallocate skb->head via
> > pskb_expand_head(), leaving those pointers dangling into freed memory.
> >
> > Linearize the skb on entry to amt_rcv() so no later pull reallocates th=
e
> > head. This is a no-op for the common linear skb, and covers all handler=
s
> > at once. Drop the packet if linearization fails.
> >
> >   BUG: KASAN: slab-use-after-free in amt_igmpv3_report_handler (drivers=
/net/amt.c:2023)
> >   Read of size 4 at addr ffff888013fdd71c by task exploit
> >   Call Trace:
> >    <IRQ>
> >    amt_igmpv3_report_handler (drivers/net/amt.c:2023)
> >    amt_update_handler (drivers/net/amt.c:2503)
> >    amt_rcv (drivers/net/amt.c:2846)
> >    udp_queue_rcv_one_skb (net/ipv4/udp.c:2389)
> >    udp_unicast_rcv_skb (net/ipv4/udp.c:2580)
> >    ip_protocol_deliver_rcu (net/ipv4/ip_input.c:207)
> >    ip_local_deliver_finish (net/ipv4/ip_input.c:242)
> >    ip_local_deliver (net/ipv4/ip_input.c:262)
> >    ip_rcv (net/ipv4/ip_input.c:612)
> >    __netif_receive_skb_one_core (net/core/dev.c:6212)
> >
> > Fixes: cbc21dc1cfe9 ("amt: add data plane of amt interface")
> > Reported-by: AutonomousCodeSecurity@microsoft.com
> > Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
> > ---
> >  drivers/net/amt.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/net/amt.c b/drivers/net/amt.c
> > index 951dd10e192b..2bce99d45d2c 100644
> > --- a/drivers/net/amt.c
> > +++ b/drivers/net/amt.c
> > @@ -2785,6 +2785,10 @@ static int amt_rcv(struct sock *sk, struct sk_bu=
ff *skb)
> >         }
> >
> >         skb->dev =3D amt->dev;
> > +       if (skb_linearize(skb)) {
> > +               err =3D true;
> > +               goto drop;
> > +       }
> >         iph =3D ip_hdr(skb);
> >         type =3D amt_parse_type(skb);
> >         if (type =3D=3D -1) {
> > --
> > 2.43.0
> >
>
> You are essentially killing the performance and usability of this module.
>
> pw-bot: cr

Thanks for your review. I focus too much on a small and elegant patch,
ignoring the functionality, Lol.
I'll revise after understanding the performance concerns.

Xiang
