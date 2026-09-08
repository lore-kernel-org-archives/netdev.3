Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D16557C729
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 16:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788886543; cv=pass; b=oJlN7b7FlTnvJsojgwqJLWJvsupHFoDpeh3bamZoeEKBvCmwEKfi+BJbH8ra/ICOvhYnlj5FkH1PK6a5OM4uCif1XEWOMByUDk9HSc3oYIFyFR/KaCjs+ArEpDI0z1zN1car59O0uNO1i+f8RIViHSnOGA/LNzVA4s3ip5wCkUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788886543; c=relaxed/simple;
	bh=wqfbKZYO9T6s7SK5bHBj3gImP672/Xrc97fe6qPVVic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P7HTEh2ZpawKw+1pkb490yTLuGsa54oRdiABsVixpqaognoGa/dXX65u2A1T6X881CUIQdcNB9XXkOtNRqKloP7MBgl/DdVCGz2ntVsu3oYNZ4ZqTzfKy6WzLx5e4s6xTQxCAnoaldSoFWA01fYXS63ccZplxlB5WijFCAvUdcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V01kEifl; arc=pass smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V01kEifl"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc1c8d4a959so3260147a12.3
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 09:55:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788886542; cv=none;
        d=google.com; s=arc-20260327;
        b=LQU47NmCxLrFyv+TuY8nJO41LA6Smt+yG3OCG3HDwvcgN0VTi7ZUt3EX1CEJYVbDIK
         4s9OFHaSjvhyJXJdPp85JAorsoglIJ5BXPGEO6iV7URPoPGuQ02Xsld+KCPe6yMee7d5
         XH9rhV5WrVGM3uextyWMRPr3vGMJe5agLJhUpnmjSRxx6bQxi+gzh86IIQcqnMLzwTIC
         0yrEyKbWij/8uzAbqWOLwA6MEYMCN5UU/PbBtZECZ9Bc2uZ0SKZoqS1LeoI3nQlW2awM
         xrat325nfv96fV3O8QriMOgcaa3tzhUhswjunTCI9IMkBSe76mCpAzUO1LMNsg7hqLnK
         Gp0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4X/heUJyU+AbJij09DYXBKeBkh36gMwincsy8BAmf6E=;
        fh=F72ir7+YtdsDFJWNhSsrZIyndSoEe9NfWwT3WwmxHiM=;
        b=hxdD25IdgwTJk7Flr8zN9pgdTE1yacEzP9eTOU079b34ROrhOJ06WKv3Vyr48VTi9T
         1eOx//4SQq3i7EGtfa3i1UkgUUZV7LoKWCu3EIMWC9Hwbf3LeK5ELs7NyikS9YPWrGC8
         9HKhOMxI/tPPPuw6pBkTf39Y+KNouQ3Vux0b+rJVEaHo+G+s2lKJlX3fu7LQGeknfBSR
         Q3+BOjAui8VT3QUWazn3LduIsXHGbuBc0mGUOXXWToAnqzigKLbMejcy+B/CJdUAmzor
         OBu3zn4ENapQwCoiwMyIBSHntw7lGlk4wamKMUkum6JdS8wOLhxfOSiJbmoEYRkmP3F6
         xYYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788886542; x=1789491342; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4X/heUJyU+AbJij09DYXBKeBkh36gMwincsy8BAmf6E=;
        b=V01kEiflG9oEN/H+CQPqSSunv+sowUG3HNrok+4YJMwhLwr5SsOibbKtdEIRTBpZeM
         OfDkfXS0YBRmNKqXFE2fzhNBV4hiDCsevCJxxHE1onHeVGMteZWqNVtSOOn/lwD+lo7H
         9Ut8LSqOm7Kd0sgs1e3rE1sJT839rw+Aj2ZmKUOrK8f4V/4m/F+R2kDQk45SOWV8gRmC
         8kw0jGbyaSgl8XKptnpgF2LhZWrW7JhOl9z64eRwz05J1f89jXDB7lHiimdmMMNq+qkt
         zNfc/OQT5MKuTgGP6LOAduOBvyc8+TaD8s1xpDX97vJWa16HQZAmRVOeOmNlhBh/2bn7
         gFow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788886542; x=1789491342;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4X/heUJyU+AbJij09DYXBKeBkh36gMwincsy8BAmf6E=;
        b=BEVqjI0WWwtTdjqE750rvpAZC59zkQi9P+BEL/olePFQJjm3ruqUeGBmNnea/aOUcQ
         sDxx/rjrVqYliqCKsKMRBoba5Aye4vKdn54cJIJ9WCke8Vy0SG2Ibz6/jmZHM8bLnHts
         ozwZsdgE/6EN9uyLw8nIPolJ+XBmeFJjZ8H4EtG8QjDLIOxILxm3ucm3SbYLcJ7O6eoC
         eS7uEl7jD1SfYptC6ScuTjE/Iag8CssW/7Qd4JJQagudAU8U6eO2ZU9fMzTDr6MPtkmg
         SvkLlZaS0VKqf7KI6JqQTb+947D9y15N1W3lARWfBVRyj3e9Y9u//hAtmy9L1OHed4X0
         Fd9g==
X-Forwarded-Encrypted: i=1; AKwUvBxNCYHo/hTl9hExneIkScfNjluwjjb9WdSJ5Q2Zsaxs0w5j8/dE7HPUx1DzOQsC+0YKTnFUTLo=@vger.kernel.org
X-Gm-Message-State: AFuF++kJ4YnO/43Mk2FDlIpeET/WzOMfa1ic/vrRk/H6w9a2u+jaXTzq
	eZrSjpzW2t4sFkT3QhzBYurpPxjCjTIhEhJd4XbEgje5tY1jnxQdG5riCx39TKnL1MqUCS5C0Rc
	HMUj8SEqSLTtO2HI3ZWwD8O7yHGQCH/w=
X-Gm-Gg: AYBFou28pvaYxt4Kw6DkZZs+S7G/jkY2qyy1fjJTHJK4IGCkb65emWYtJNzLB5EHw7X
	k+jucXhFaHsywAxr1yDopGRmLUWwJoKj7qTaxegnVGCWExSyCrJ1RRA1toqKOJswT7VwhhSpDp4
	QFKPbTGKy2LDo6/g8NW1QP+4U0zEgdjA9kSHt+gAXSuVuTS2CNTFYbqPox4NwKsQI/3CKqpknpw
	5FlVxxMFBq9UYjwp7D7RqIgJhceBcUj32nN41hlRsNdRCF/9+7ykYEDPZNzRqCrPhfJO0sn+Jtw
	B1aG6hUQKk3L39jKjHgF0eekcdiWd00bKr9K1G4Z8+jr20Uv2FWhCW9O94nOwbVH3yyEJ4K1X52
	28xqQ
X-Received: by 2002:a05:6a21:6110:b0:3d1:39e9:b269 with SMTP id
 adf61e73a8af0-3da39b5cfc5mr49040879637.4.1788886541658; Tue, 08 Sep 2026
 09:55:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260905194725.284347-1-adrianox@gmail.com> <CABBYNZ+_KZXEz2210xPShKy=baN2Xrd4T7YijdCn9y3h-t5V8A@mail.gmail.com>
In-Reply-To: <CABBYNZ+_KZXEz2210xPShKy=baN2Xrd4T7YijdCn9y3h-t5V8A@mail.gmail.com>
From: =?UTF-8?Q?Adriano_C=C3=B3rdova?= <adrianox@gmail.com>
Date: Tue, 8 Sep 2026 13:55:28 -0300
X-Gm-Features: AcwNN1XaC2U3kdCp8dxKL8VeVUqbrduVW0Lqh5YW6C9HLUaKhl91MEg9ANX2ioI
Message-ID: <CAMGU2hWQYMihNkc=JeH3b4G4y0a5Q+HhsvTEpy939EJYW=8g+Q@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: bnep: linearize skb before sending
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

Right, thanks, I will send a v2.

Adriano

El mar, 8 sept 2026 a las 12:50, Luiz Augusto von Dentz
(<luiz.dentz@gmail.com>) escribi=C3=B3:
>
> Hi Adriano,
>
> On Sat, Sep 5, 2026 at 3:48=E2=80=AFPM Adriano Cordova <adrianox@gmail.co=
m> wrote:
> >
> > kernel_sendmsg expects contiguous data. Check the skb is linear
> > before building its kvec. Should be already linearized by the
> > stack, so this is defensive, but drops the dead block and the
> > FIXME.
> >
> > Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> > ---
> >  net/bluetooth/bnep/core.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
> > index 5a6a49885ab6..497eb1d2d6ee 100644
> > --- a/net/bluetooth/bnep/core.c
> > +++ b/net/bluetooth/bnep/core.c
> > @@ -457,13 +457,15 @@ static int bnep_tx_frame(struct bnep_session *s, =
struct sk_buff *skb)
> >         }
> >
> >  send:
> > +       if (skb_linearize(skb)) {
> > +               kfree_skb(skb);
> > +               return -ENOMEM;
> > +       }
>
> Looks like we should be linearizing earlier:
>
> https://sashiko.dev/#/patchset/20260905194725.284347-1-adrianox%40gmail.c=
om
>
> >         iv[il++] =3D (struct kvec) { skb->data, skb->len };
> >         len +=3D skb->len;
> >
> > -       /* FIXME: linearize skb */
> > -       {
> > -               len =3D kernel_sendmsg(sock, &s->msg, iv, il, len);
> > -       }
> > +       len =3D kernel_sendmsg(sock, &s->msg, iv, il, len);
> >         kfree_skb(skb);
> >
> >         if (len > 0) {
> > --
> > 2.51.0
> >
>
>
> --
> Luiz Augusto von Dentz
