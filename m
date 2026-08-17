Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77BC3F3276
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 20:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787000392; cv=pass; b=ZitQ7h6mXTR1oShpEglrOwztJIO1tuyzJPYnjg84/KRmEuZtk5JbxZSGpGV8W2PMFRgM5i+pDHdhE/GEXPDKZGazvQGvAS3hHT2W8H+nWHyCuURsRM8ErH5Y0hk2nj9ErtO+g0Hg75Aa/Mx0Wzanp7Mddrokzn5utjx8HgYT/ZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787000392; c=relaxed/simple;
	bh=GGsPWRK9FRWecXnz96hzeq1dlR1HRflM9Zj+Rwf39JU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rInukKbWHLqx7or77lAHTr+mv9xY3599wqkNtRpl7aRI2cpIJ8zxcbpYad7nj1MzOfcTq2KwKz6HEiICeDbNK990yTcO80lSNPToi3qQqFRID2OlAWBxqEaw9bxHTthFUVD8OVkNq9eOmRyaySJyLiKNYyw+q9o9qcag3Lk4y4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E+qpRyP+; arc=pass smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+qpRyP+"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cb5b8572b70so4623135a12.2
        for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 13:59:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787000391; cv=none;
        d=google.com; s=arc-20260327;
        b=hLdeePw/rW/KX7Qqi0qWKcgxQRXNEcsxMorijeAkx7V26rvmPxk6T0hfxIPk+ghIw6
         7F2HISaseDeAiHj1174ksU51ael2wgf3On9TA6oHOTps/30QUfH13ALvrD0Bvvamhqd0
         2miYxUV72liJMOU44Z+EoCB5sM8Nv06K8oGjmgrilCXu6r8z/9J/79tOB3gUGeOSmhFA
         y+4Q2YA0bjfZN45B836qIslL6Z7GfLEa61xHrKc5nsK1q1pDLw4hqFs32MrxW4ilAxCG
         zAU96xi4r2m2hNgO+yRzsG5k5C7c1JXbXmWkI/ktsX8bcXbQ7un2Bd7REYEOtsmcNzss
         7ClA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8mMkXFKPm9YtmcJaO4UnEV5UZT7iWIfb0O/4F18eXG4=;
        fh=oySJ0IZBV/kvd0lNdMFNXegDGm/hICdyXgAccWYt2Mc=;
        b=EtRaUWynM5T/ZxyBBXJFnc8M3ir2y076BgT6PqXRtrul60bUCr78RpOhij+E8OLRXo
         mygM8OARWv57k9kcN0TbTMMXw5O8se0k6S5w3pthCRDnz6g2Hv+xky0wskk5rF7osBuK
         NzmH6HnAiy9zIpIr2t94nRT/pHON6gwZ7NZJG/A8LxgVPhIgHCGfcSbXJ6AnkNSxyIet
         L+fpfWEPYvC9eHGymR763lpAPWAug+tTHoQEfemf8EEY1xnnpJaSHogqNU5ES3lCRCBA
         ArEkgrH1UccMYYcPC76i82T+KvIzOjJCMsRNqG8GlXusqus4HBwUvqFVtz4+5y51uYwp
         FsZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787000391; x=1787605191; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8mMkXFKPm9YtmcJaO4UnEV5UZT7iWIfb0O/4F18eXG4=;
        b=E+qpRyP+2EBGpQapcEgizSUkjvCo+3l7Cg0pH8lgyyr7XgwLCXrlUM8ksusep0sk3q
         NTDZ/RuR2NZFXJGbG8xvqCJxXc9FyvJS9mMyHWOEVS33JHwwPbYCJ2zHsGm2cko6YOq5
         PQvRUFQhlnnOSqLrwOjRm9eB+8U1/WiBsz+ExVc4ORPkteqy9luXc3NcR2yBmYAsz38R
         3/5njOWfT4AkiW9X5VxjEX4KUNo4v4jElEEP1drukVX9WTPjgIqmj9ERkmQsfIq4B7OE
         JBn7MpB9Vtmn6eceyFR+1fH3i3y8mIIsYau4EM+8h6BwMEN4SLlNqHoygY7YT1snhDr0
         HXnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787000391; x=1787605191;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8mMkXFKPm9YtmcJaO4UnEV5UZT7iWIfb0O/4F18eXG4=;
        b=g8jR/SpQ6Q3HIFAL7sZtoovcsUfIgSVVCaeGWJDap+zVy08PJnFX4Rgko78uJwBBO0
         M1IGXaKs2ctfDIzM6iGyIDvfuAfpyNNXWhFto8VX6ttoO/BW3N0GS7b0inC1hpzxwflI
         zGUWZugIUsbcIcJCBixNjO70DHEfjwst1lahojIJN3dx6/UrAcRZvBbrrsE8ZqDEdFu+
         5PvK0q5EvGDq0FU0TMUl8iSUJYpvVrv3/Tdte3lS4c2qlrJovAOcASnv7YzN/t8pn/k9
         DA7Y1VVEw2x7zlD7QIn35zBsERLaBzIXMsoUdMLwTOp6S9fl1dD1QctSPzI9EsJVQ0j+
         He3A==
X-Forwarded-Encrypted: i=1; AHgh+RrHTTiJz0gE9m49zAJ7ZM0z/Mj9271kjCzhycuUI1cSG6aZxrhlUvTl4qfNPvCgiJsQsOKYTpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHdo4660CFEZUiD/00f4P0Ml+HDFuSnTYjphnBb/MSZDpwTjQW
	f7ZVnJYX7FxGSkfwtR/AyeXZc/BCrz83JprIkEtRjEPKdpKYYykA3rrd1XmzKDUQpOoASGE23W4
	eP+SRYkHg1kSXXL01BiDBas8PsCpCPD8=
X-Gm-Gg: AR+sD10NW2UxuzvYfBGCvlwI5AAdFdHNFh1em/POqcZhmYPP+07FeAHy4LOWkz7yDdy
	cyf+MA46a6JQWDg1FsSB9nm1vq4bCGCCkVULzLsGNcCCjaLxRI/dKePZi+wA8toUW2V2HLo3uMQ
	2eKJSrGmeF/UErqy4caD/DwvgxPH0tcHSV6OOzUhH5QmQtWiKoiUsjpbX44PZ1cFTn8/0BpJVP1
	DDYez5O39mVPQPZtqqjFPWH+Jm4693xlvc6bp1aZm+ieVlsFxdNs3aMRybGJbckhCNhbEbsaZI7
	wCC1lMJWgfxUTUEQ87z8aVGB5uA8HGofj+gziG7KXh4u8UXi7KIqgQAN7G7OiQD1/lgb/w2zeWL
	+wDqiJ4kKQnAyZNl+ZfPW4mqac6baNdkpJbln7BHrdvs=
X-Received: by 2002:a05:6a00:12d1:b0:845:40d1:87fa with SMTP id
 d2e1a72fcca58-851b882e7admr2836763b3a.25.1787000390987; Mon, 17 Aug 2026
 13:59:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <an-oGfEatacPTSX-@v4bel> <CADvbK_e60CFEVUVo25Tkcw_p4y16o8vZCf0N=hH+bUoEqpu6Qg@mail.gmail.com>
In-Reply-To: <CADvbK_e60CFEVUVo25Tkcw_p4y16o8vZCf0N=hH+bUoEqpu6Qg@mail.gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 17 Aug 2026 16:59:39 -0400
X-Gm-Features: AcwNN1VOnIN_7JXsuyS_viaYzaB2zKZsu4VQVWQVlF-17_QueSTRw30EbptT5bY
Message-ID: <CADvbK_c4V6cWiS=fTfCeS602bazwXy0mYCXnF6=eYH08PaRznQ@mail.gmail.com>
Subject: Re: [PATCH net] sctp: drop a backlogged chunk if its transport was removed
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: marcelo.leitner@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026 at 1:48=E2=80=AFPM Xin Long <lucien.xin@gmail.com> wro=
te:
>
> On Fri, Aug 14, 2026 at 7:43=E2=80=AFPM Hyunwoo Kim <imv4bel@gmail.com> w=
rote:
> >
> > sctp_rcv() resolves the transport once per packet and leaves it in
> > chunk->transport. If the socket is owned by userspace the packet goes t=
o
> > the socket backlog, and sctp_add_backlog() takes a reference on that
> > transport.
> >
> > An authenticated ASCONF DEL-IP in an earlier backlogged packet can remo=
ve
> > it. sctp_assoc_rm_peer() takes the transport out of the association and
> > calls sctp_transport_free(), which tags it dead and drops the reference
> > the association held. The backlogged packet still holds a reference, so
> > the transport stays around.
> >
> > The DATA chunk in that packet puts the removed transport back into
> > asoc->peer.last_data_from. Once the packet is done that reference goes
> > away and the transport is freed by RCU, so the next delayed SACK carrie=
s
> > the pointer into the SACK chunk and sctp_outq_select_transport() reads =
the
> > freed transport's state.
> >
> > Drop the chunk in sctp_backlog_rcv(), next to the existing rcvr->dead
> > check. The peer retransmits it. Guarding the last_data_from assignment =
is
> > not enough, sctp_assoc_rm_peer() clears more than that one pointer and
> > letting the packet run fills them in again. sctp_wait_for_sndbuf() alre=
ady
> > uses the dead flag this way on the send side.
> >
> > Fixes: df132eff4638 ("sctp: clear the transport of some out_chunk_list =
chunks in sctp_assoc_rm_peer")
Please also double check the 'Fixes' tag, commit df132eff4638 doesn't
seem to cause the issue.

Thanks.

> > Cc: stable@vger.kernel.org
> > Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> > ---
> >  net/sctp/input.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/sctp/input.c b/net/sctp/input.c
> > index 864741fae4187e..83b8361d149251 100644
> > --- a/net/sctp/input.c
> > +++ b/net/sctp/input.c
> > @@ -285,9 +285,10 @@ int sctp_backlog_rcv(struct sock *sk, struct sk_bu=
ff *skb)
> >
> >         /* If the rcvr is dead then the association or endpoint
> >          * has been deleted and we can safely drop the chunk
> > -        * and refs that we are holding.
> > +        * and refs that we are holding.  Same if the transport
> > +        * we looked up has been removed in the meantime.
> >          */
> > -       if (rcvr->dead) {
> > +       if (rcvr->dead || (t && t->dead)) {
> >                 sctp_chunk_free(chunk);
> >                 goto done;
> >         }
> > --
> > 2.43.0
> >
> Can you try to move the check to sctp_inq_push() to also cover the
> case Sashik reported?
>
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/an-oGfEatacPTSX-%40v4=
bel
>
> Thanks.
