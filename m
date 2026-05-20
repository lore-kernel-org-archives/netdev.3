Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4962839FCC7
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 23:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779321251; cv=pass; b=E+mJF8MhEEmeMvpphwx/+xDdsCLQfmyBbuUOUSQFBELgxMczsr7cNR6D0PIWEwXfMAMGyS1S6DpMWgOwmqLbaNrcFl6YomPzRuJ65SnNn67BzTS5QZDrFDuDqH0dOHgYBiP/gsqDqHRLDIvWoU359CP2i97RrBK/XEA8YRdL1iw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779321251; c=relaxed/simple;
	bh=CSysq9SiVahqSP5MZ3etWW2Hzf9hnYf/hgEdCbyySWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TFHSa0acXnMHCJBq+KZSaMLXO36mPMs9n0X9xkqbqJYjJVW9i0ukLL5NHBQBP4qH5jkcLvIu4h0yAbx5YJVAHpmM0RsCJk8tSQAxbTWTOjItWQk+D3leEy5RbKtmarUtqhb6sYnh7CzzpP1soGeOTzxDEizuhG3Rv6Mg1BLq0a4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lcW6bTcD; arc=pass smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lcW6bTcD"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-38e97e73234so49475151fa.1
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 16:54:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779321246; cv=none;
        d=google.com; s=arc-20240605;
        b=NfApjoi52Q+wMxJdtujltmF6LxFY4taVM87g/3DonfK1/VLfYT8xJim2Ksd/+ErAJt
         us/crsejQXYAKet4g3nWaSdo3+mEgSUeaRYdCGIvou39gEQSELlE/7L8NycEzAfO8D63
         BHhPw37slENjX4hhYgq+yaBg/gjV0eFnF4JLDp0civjpk+tDmMkLUQmpapBq6opbJ+kA
         PaZK2hVHnDKCfv0WmsxEgCdTTnIaWvu8SGjZp5DdMVs5uV3GFCqCJULhLksW7BgssB7r
         ZVx9LBX/NH1zb7uwdK3yls/KWM4oZpsPFPgqZLVKxeEp/0rbp7s4tcYuU9zVO7FaTIx+
         zGpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qVdteeUJUkJY8GpXMSwIKhxn3fHzJU6mCTRL8j03HL8=;
        fh=90R5V96qZ4y22zt4xXmqfxYE4KnofMzcD7OEmjxSItE=;
        b=dP5uvJsrpH+wJ7VjP1yc+TI8B3IaFSfjJ0SMsC/dsHnPpU3omRdmqmd9kFG3BrBtCb
         WCRY1HZFZi8AR6V7tZ9ndoldjs18pbT5ZASY6MVQwrNh/qm8xXawinr+oYssB/3zmoGA
         ltFORtV+NXmSdxb+ASptCKRrp4AjJhQ7RdTuco77wbiG55msqQy1sIyaeSBqJUQiscms
         FwgiqUHB+vF8pn9Fa/F+Mz9KlMAWLUWs6fKOuw2lUsAPBvHDnhSWkEnk4IoPkMwPB3RN
         i4hvfVITbZJrVzN1OnjUmkZCSZY9MLfrKMd5poWg9DpcUHOIhS9jTv2FZCyfhcdM3/tw
         SpJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779321246; x=1779926046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qVdteeUJUkJY8GpXMSwIKhxn3fHzJU6mCTRL8j03HL8=;
        b=lcW6bTcDSzoGk7PGD7LNGBKdUzFGFU0XhdJtu9W/JfS0Zo4++rxCnKhVtL8B4KDvgG
         n/jWAGh29r115hQEbO7jmtykpExGK9TOQts7EYwaBK1350ro/hnLla0Mzy/DNs7zBzOe
         kdsdgYC7xuaH5SbPTf8BOwkx3tiB8njaT5Vkgpk317eosmtCWua+8jrZHWNoXGC7U+/W
         L/oxR85qpuVnV+h4R2/yEb9fPjWxtmKtXRQlzhPwCFBIapCB4GkC8aj+WK2TlW531Zkq
         4gXaOpiydaKTWRndsfMOqzkWFdf5kiHCWY8vcHr+LcI9urI7jE7GBQhd65bk1lOpPSAz
         o3+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779321246; x=1779926046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qVdteeUJUkJY8GpXMSwIKhxn3fHzJU6mCTRL8j03HL8=;
        b=X1xS35zdWgUp5ZLNWhvua55KPIz+kwGNhvD1kdZgbQpVPsOcWqGGZytqCb0nrxf1EN
         taVYvxV/BVCHjELJpHiS4O2Y4QfUoBJDZYbo6lRGhsJq9KIwzjmZkiTIlZx1bnqU8hmW
         +DDNrb+r1Y3lxZvws5QpLZXwoNzAxt8tp25e+hrKQQJG8qs34yWjtsEp3olQWq/IVWtm
         03z4bnPapJJqEQ1Z8Lf8xf4HlTqFQSOQu9adnte/g28d/T3RNL+ovQaKm0u+4cHU+R/v
         D4ia8JZS+C/dV9u9OM5orzkWSLzg8BJMS7fMDOLjo/wMhfN8HnXtQJq5WXUVsKuxP34A
         pNig==
X-Forwarded-Encrypted: i=1; AFNElJ/IqXN/xKaXh50xgcImj4dgBAm9XuzKcCHGIqQOqUlPYFqZwW0qhT7kM0ocp2HouU6LoB4w1yE=@vger.kernel.org
X-Gm-Message-State: AOJu0YylizGyN38MbaB1EdK/h/QfGmR4To0Pr4hQ7gVF8mC2KMIQoZzN
	vx0j2dS2bVsEnywiD2E6STJUOo7DbNr5q6JRxlI+tIh6JpJA610YxbS629wmFAEjbVUoVyVPPvs
	zLYKEzMzV+qWQMRFFkUT+kVeIS+Kp7IU=
X-Gm-Gg: Acq92OErJPAVtEcweA3NLLkKpzvjryXXd5qjYfp27Ask68rkUBWrJtnkFr0Q1ae6H6D
	HznxI1ZoizZ+YuQtv9TMEO5x4XEkpzGQRHGje4r5P+rbgTQGmCAvJ+Pr2UWA2BJcHw6u+rZ4hT5
	72A6YxMXKstHnmmbeoq0mA7xSCWUxo50QWo+OiBAN/w5oukaC2vVLeONVU3dgEX0fz6iMl1LFlF
	9alW6F1FmCs5LQ3VIMhGc1W54vS1l3Hd0AJYkid3jMggixxqMgfZjuipEjwCZLpjma3L4Tk7p9F
	wEctMUyVHgkZwECFPBuUJ2dnwmOAi/q6XXKBxpnfha0Cs+vJPg==
X-Received: by 2002:a05:6512:38c5:b0:5a8:ed8f:2c03 with SMTP id
 2adb3069b0e04-5aa2ba8fde0mr117133e87.35.1779321245286; Wed, 20 May 2026
 16:54:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520004244.55663-1-kerneljasonxing@gmail.com>
 <20260520004244.55663-4-kerneljasonxing@gmail.com> <ag3c9/EF4h7DLQu3@boxer>
In-Reply-To: <ag3c9/EF4h7DLQu3@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 21 May 2026 07:53:27 +0800
X-Gm-Features: AVHnY4Ji5TGpZw3bmLWIgcUrQKDvsjJZOSQkRmCKyyZgCvkmwdIO6i-y-EnmcD4
Message-ID: <CAL+tcoAvbEZ7U2oXBWwLAKeuC==gAHi=GXLZcrEPxbb4mQ9sfA@mail.gmail.com>
Subject: Re: [PATCH net v4 3/5] xsk: drain continuation descs after overflow
 in xsk_build_skb()
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	horms@kernel.org, andrew+netdev@lunn.ch, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 12:10=E2=80=AFAM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Wed, May 20, 2026 at 08:42:42AM +0800, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > When a multi-buffer packet exceeds MAX_SKB_FRAGS and triggers -EOVERFLO=
W,
> > only the current descriptor is released from the TX ring. The remaining
> > continuation descriptors of the same packet stay in the ring. Since
> > xs->skb is set to NULL after the drop, the TX loop picks up these
> > leftover frags and misinterprets each one as the beginning of a new
> > packet, corrupting the packet stream.
> >
> > Fix this by adding a drain_cont flag to xdp_sock. When overflow occurs
> > and the dropped descriptor has XDP_PKT_CONTD set, the flag is raised,
> > so we have a chance to examine and handle the potential remaining descs
> > of this big overflow'ed skb.
> >
> > When the last fragment (without XDP_PKT_CONTD) is processed, the flag
> > is cleared and the loop continues to process subsequent descriptors
> > with the remaining budget. This behavior follows how previous xmit path
> > treats overflow packets.
> >
> > Closes: https://lore.kernel.org/all/20260425041726.85FB3C2BCB2@smtp.ker=
nel.org/
> > Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx pa=
th")
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  include/net/xdp_sock.h |  1 +
> >  net/xdp/xsk.c          | 19 +++++++++++++++++++
> >  2 files changed, 20 insertions(+)
> >
> > diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> > index ebac60a3d8a1..8b51876efbed 100644
> > --- a/include/net/xdp_sock.h
> > +++ b/include/net/xdp_sock.h
> > @@ -80,6 +80,7 @@ struct xdp_sock {
> >        * call of __xsk_generic_xmit().
> >        */
> >       struct sk_buff *skb;
> > +     bool drain_cont;
> >
> >       struct list_head map_list;
> >       /* Protects map_list */
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index 0a6203c42576..f4add7be8c93 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -1062,11 +1062,30 @@ static int __xsk_generic_xmit(struct sock *sk)
> >                       goto out;
> >               }
> >
> > +             if (unlikely(xs->drain_cont)) {
>
> Hi Jason,
>
> could we get away from introducing dedicated boolean to xdp_sock for
> handling this rare case?

I've tried several ways, but they didn't work. Please see the short
conversation with Stan:
https://lore.kernel.org/all/CAL+tcoA6Cu3P-y2wYjJ_R9cSeRkW2tswY1LveqH=3Duxd2=
McuR-w@mail.gmail.com/

That means we always rely on a flag (that is either static or like
this patch) to recognize how we treat this abnormal descs.

>
> > +                     unsigned long flags;
> > +                     u32 idx;
> > +
> > +                     spin_lock_irqsave(&xs->pool->cq_prod_lock, flags)=
;
> > +                     idx =3D xskq_get_prod(xs->pool->cq);
> > +                     xskq_prod_write_addr(xs->pool->cq, idx, desc.addr=
);
> > +                     xskq_prod_submit_n(xs->pool->cq, 1);
> > +                     spin_unlock_irqrestore(&xs->pool->cq_prod_lock, f=
lags);
>
> It feels a bit off to do this cleanup one-by-one.

Actually no, it adheres to the basic send logic in copy mode.

>
> I wonder if it could be covered by xsk_drop_skb() where you would walk th=
e
> tx ring and store addrs at xsk_addrs and then use xsk_cq_submit_addr_lock=
ed() ?
>
> OTOH, in theory the amount of frags after we hit the overflow case could
> be well over MAX_SKB_FRAGS again so xsk_addrs wouldn't be able to cover
> them.

Right, this is why we now put the logic into the xmit path just like
other kinds of descriptors. We need to check and send it under a
series of protections like the check of cq pressure and budget. I
don't think it's an exception to escape the check logic. The whole
process should be fast as there is no need to build skb and send it to
the driver as long as this case is recognized.

Thanks,
Jason

>
> > +
> > +                     xs->tx->invalid_descs++;
> > +                     xskq_cons_release(xs->tx);
> > +                     if (!xp_mb_desc(&desc))
> > +                             xs->drain_cont =3D false;
> > +                     continue;
> > +             }
> > +
> >               skb =3D xsk_build_skb(xs, &desc);
> >               if (IS_ERR(skb)) {
> >                       err =3D PTR_ERR(skb);
> >                       if (err !=3D -EOVERFLOW)
> >                               goto out;
> > +                     if (xp_mb_desc(&desc))
> > +                             xs->drain_cont =3D true;
> >                       err =3D 0;
> >                       continue;
> >               }
> > --
> > 2.43.7
> >
