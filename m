Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407BE322C73
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 16:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787674099; cv=pass; b=Ito5a9bzas62P1bAc3s+iF4og0lCglAW3Xyt+0tVWz4etMJD0RUnQAdaz+CrW8SNB7zZ2XGF3Efp9HTncjD+LKKp0cSm/bx7Di51sLOzhbVDqcEuPk8Vab9FdFT3/bLfbrwYUH2YoZkz1Ox4QZE9wmi3llEjZGhiLyKXozrf89o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787674099; c=relaxed/simple;
	bh=dGqiAelMi3j+OBeMLnEKDn93G/jB0JDZpRAJXM72wUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VAdRF8jaYwOX+FGnHPfJju7JugQHM1cBbKIYrMKlrFoOhUt/zanhWg4YI6SPdh1TvANj2SP3sOn+cPKQnUievJvnZnFQnp5YMbaH9ZuPxuV2TY7viElhJvHOgMw6bDFdHne1HaNBrd8ikktKYKvMsxQ4qHYLT1iJ4WCXwTGuXdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=UFhY6V2Y; arc=pass smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="UFhY6V2Y"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8534d507f59so33254b3a.0
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 09:08:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787674096; cv=none;
        d=google.com; s=arc-20260327;
        b=f/mWgFW455LkqQ8xC46sxAq6d0BcNd4nqICWWyMuWaDB/IhhzAPUZGFUgnPW4VTjxq
         r/IbTqGfkyy82z1YeU99AH7km0IKzBS9X7lnDnq039QxdoZArFqjwP0LPg5o9fKzGppB
         eLa3YYBCDjnFhyKcBVCSCWhaxrznbKHod4KKiBaFK/vR5N0WIRODFXOc4kigjYhhM2aJ
         fiZeDTmFz+uuaCASHvs7SInyvIlxsq+iRrogilzAP1cacJeAeOB8VosXuCCOxjCN9Jwn
         XObrQKYsW9vzcCoVLxu9JdVUlNCqnloWfsNUWiFjL1/PWwfMuMiORA4ExBKnd5p9jmmA
         USMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2ZLowbj6pZcMppFHbOVdGIJyzEqMnEa6iqrdQcAQ/VY=;
        fh=4N5FssHd/Gfyz1e29NYp9PS4UyorIoqzPqGhCOG7doY=;
        b=RzvnVnJvRuTkRjE928OWqaOgh+/ONsADOPJaQnoygYY9Qd0BMp3iDcyqcH4lELMVNo
         xSDjyPy3tAsoaR1wuCYiBTfb2vibt4wl1yFya22HWJi/6CGyfbRoDhDgvrf9m5gq+6GP
         rlJ4JKPsua6+x4832WXXLzYwlWZ673/5SMp0Fo9yIAeovTV7Xl4FF//YLt5Rgg69bg+g
         ynn9TZ25Hpjo+GHkvRDq4w+vHEBYfmJrgOZFZcWd/RFpGwICr94D09LGgwELmEU37lgj
         CgRfEemL9MADYFFIjsGN0oXGB7xYPSVCNktJemyVgaLuNNiGyIDryfOOjU6TqbJms1TL
         MzKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787674096; x=1788278896; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2ZLowbj6pZcMppFHbOVdGIJyzEqMnEa6iqrdQcAQ/VY=;
        b=UFhY6V2YaSXTehNNJjFn4l41ePBoR8UlPOKHj5w3M4/MatP3KAXsNNLcE4pOvcexw+
         Lq+uvtutLQbsp5ReMkA+XgMaiqfLKS8y1hzemu7kvGkVlusLkbwQzSzlFKLktY3CIEMC
         SD8if/k1ClDUcb5ekJ2FiIZVfeX9KMP0zc2xw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787674096; x=1788278896;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2ZLowbj6pZcMppFHbOVdGIJyzEqMnEa6iqrdQcAQ/VY=;
        b=atmm/73x9fz1HTUDvokEfbNmtBjXBrEx9pZaz/xPFid9odb/1rMU0JlLMKQfchzfFG
         1R1PdavZVFeogyJbAK/FSIPfkRv/+Aic1u4tqvac/CifYqdiYaEPX8YK/9EjBNIsJ6/C
         wlw3n0kwO8pJoxCICeNv3MyLAxA6EHTa3oJ9UAtXXLLOWsk4szlvG/A4GoGPfCswYRxW
         cKrPU/eeiTxOycaGRwkZ81jbSQTOykwufIbZBwhRs+XuVnEzGA1ulmQDWaqg0awSyLG6
         unLkLIHs6obNwyDMV7gfkLHdXTWFZ8hunKMQmwuhpcZXkRGOUui8Co6Zv7/tRFg7mWhp
         l1eg==
X-Gm-Message-State: AFuF++k5Z4at7w+vfqxtcoaCaja4SBzIwoaYRzZPigInpC7FkUnM643O
	c27y1AZ0KRE+qqdky01mgpgayMxvMGqd09l6+yQxi0wdqKdQNZI5+l0lvQ23YjOKmDRQR/brPAZ
	Eu71hor5os+iIg0gIkQuJyZXrieVy+mVof9uCBBN5ZstCbH48iaqQUvH/
X-Gm-Gg: AR+sD11raBkmsalKEEuCoDjqP+3i0PheFSedFkfs5Q7hpNRbzd+3Af0Kp+H4CHimJ1I
	16Ji2HVtm1Pt9yVdgDM11vXlf+hVwzWKoouoQPvqN4aDT9YvmYCEwrCPYSjrtOIDquqaShLRsLu
	mJUjqfzSfKzh5fj/sUH8zCgWxFxibnY+48hBwX/zI4qR8rsnLoquM9obYiiPljPIY4v7TSWbGKu
	/+Hzz4YvdVL5T7IeLgWaXjV8CrEdgD2OoTUMpqeQGSnpbQYqa7KBzPYCLo1Le5iZmZN0wrIpl9p
	sZD+iq4Zrxb/i453R+y028QhML53xNdr3aXAenhxGrBuJEKe+MbK
X-Received: by 2002:a05:6a00:858f:b0:853:5152:a3e9 with SMTP id
 d2e1a72fcca58-8535152ac57mr1163052b3a.11.1787674095878; Tue, 25 Aug 2026
 09:08:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820095742.68511-1-jhs@mojatatu.com> <20260822134401.6545e4eb@kernel.org>
 <CAM0EoMnLnc2dtzRyaJs+V6Niq=39OQ=p-XC7M+FMTQ0ctSvmyw@mail.gmail.com>
 <20260822160234.7115ccdc@kernel.org> <CAM0EoMm0orPkSuMLrpGMNkUATjmBPCvqWmKMEPQoYuYAEvCAQg@mail.gmail.com>
In-Reply-To: <CAM0EoMm0orPkSuMLrpGMNkUATjmBPCvqWmKMEPQoYuYAEvCAQg@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 25 Aug 2026 12:08:02 -0400
X-Gm-Features: AcwNN1UfZeiVD0YzBqdqd_6Ugr5w6_aaDqOKIPnHzTlvPeR1fBSFdGBvHs3fFDo
Message-ID: <CAM0EoMk8fAACt11fe1pUsFeG9np3SdsV0YUNmEevLu=i=b+xKg@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net/sched: pfifo_fast: cap ring size and account
 to memcg
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, stable@vger.kernel.org, vega@nebusec.ai, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 8:37=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Sat, Aug 22, 2026 at 7:02=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Sat, 22 Aug 2026 18:14:49 -0400 Jamal Hadi Salim wrote:
> > > > On Thu, 20 Aug 2026 05:57:41 -0400 Jamal Hadi Salim wrote:
> > > > > +     if (qlen > 65535) {
> > > > > +             pr_warn_ratelimited("pfifo_fast: capping ring size =
%u to 65535 for dev %s\n",
> > > > > +                                 qlen, qdisc_dev(qdisc)->name);
> > > > > +             qlen =3D 65535;
> > > > > +     }
> > > >
> > > > Why not a hard cap?
> > >
> > > sorry, where to put the hard cap and what would it be?
> > > Or maybe you misspoke and intended to say "why put a hardcap"?
> > >
> > > Or maybe in this case probably safer to just reject the change if > h=
ard cap?
> >
> > The latter, I'm asking why not:
> >
> > if (qlen > 64k)
> >         return -EINVAL;
> >
> > To be clear I didn't dig into the code, just read the commit msg, so
> > maybe you have a reason. But the "normal behavior" for out of range
> > params should be to return an error rather than silently clamp() into
> > the allowed range?
>
> No real concreate reason other than the thought that it's a device
> param as opposed to a pfifo one.
>
> I am going to send a v2. Will switch to similar to what virtio does:
>
>   if (qlen > S16) {
>       //extack here
>       return -E2BIG;
>   }
>
> The followup as identified by sashikos is on tun/tap - i have a rough
> patch, untested but there are others ahead of that i need to send out
> first.

Although i have submitted v2 - i may have a small change of heart.
I was trying to document sashiko's famous "pre-existing issue" rant
for this bug so we can followup later; sashiko correctly pointed out
that tun, tap/macvtap have the same issue and i was going to do those
as followups.
Although i had this approach below as an option earlier - i didnt want
to go with it because the goal was to isolate the pfifo changes to
net/sched. The option was to make this change:

diff --git a/net/core/dev.c b/net/core/dev.c
index 38336858c168..ab6b44b67be2 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9985,6 +9985,9 @@ int netif_change_tx_queue_len(struct net_device
*dev, unsigned long new_len)
        if (new_len !=3D (unsigned int)new_len)
                return -ERANGE;

+       if (new_len > S16_MAX)
+               return -ERANGE;
+
        if (new_len !=3D orig_len) {
                WRITE_ONCE(dev->tx_queue_len, new_len);
                res =3D call_netdevice_notifiers(NETDEV_CHANGE_TX_QUEUE_LEN=
, dev);


This is a bit controversial with S16_MAX as the upper bound, although
no device i could find had anything that caps other than virtio (u16
max: 32768).
I have tested this with all 3 issues(pfifo, tun and tap) and it fixes all 3=
.

If this is acceptable as a fix i am going to withdraw v2
(I dont see much of a downside even for buffer bloat needy folks like
satellite links and given virtio there is precedence)

cheers,
jamal
