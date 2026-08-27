Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA64F222599
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 03:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787800431; cv=pass; b=PkzM7DaZP5/RpU5M0ZUv/v6KQ0yi1JS7LuB3JA9iDPRiASyJtGgMM9iR+zsroJFOejGcv4kvS+ue995ThxhLAcfHWFATV9knYPFZGs8iODFMyy6JNv1Rh0OVDI1/GiFAJKw29ekVFo4Xk8oad/Ej2nAesk/VUDr9t/R9Qx0XnTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787800431; c=relaxed/simple;
	bh=nk+tBDb/jsp8s9rgLPpnoL3ufYi9ooa6bM08erhpxrc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HVBT/pFlcbjBPoiIWokzfypamo8uczeSnuCzkD8yOEqxUBBSRBc8uWHpTihSjcI+J+2btU4WGiezo36eoeESQMH2Y/L8/td3IJXfQcK3Re7nUUs/okn6tSBpnxNL3EKs81FMaxWf53NMpBY7Ouikv2YHY9uc1dKS8HbsxVijWIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ciZyjS93; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ciZyjS93"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-394f4397662so240660a91.1
        for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 20:13:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787800429; cv=none;
        d=google.com; s=arc-20260327;
        b=mGeTO0G6hANWOcEzdhSUO61rFycbT2BwQFiH4JC5HDHaLvL6XSw8yGvXhQPpdGgZeq
         F/G4CwmjiwxYNRozVxATnUk1VyVG5YtPTaXTeRpqslBazItprvVnq/4nlcXWrL/hjZ8k
         B8xypb6wfLW5SBYIBScUfLA38DJc/IiWQyFSRi9KFFtyq/Jrd8aJtTZC4w6vgLXfExb/
         3JTPC0rBnmh2CBjdlSiGL4HikqppMoRPHprSzjKYLGi6TSeSmJ4A3OEW6rHQgwHRldU7
         WQr9I/Ah0kgZXaxQpQBmyTrt9/2r23rypcn3Cx67TeVKezlZAr5AwyEHJ000k3zULEQF
         Kviw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jIFo/4wUUfQWH3xk8dCu9GeGPDvxh5WSyUAAPSe4Mv8=;
        fh=jzu+YqMROOKWZUcwcvpIT70Tansfi+5Aa0dPc9AOnpI=;
        b=A4dOK045gqKZJRty5/5ewmv4YsqQ6A49n+KDkirbCFJvFaHoK6qRX0um/vg1pxMUaa
         no3P4JZHPBIePWHc6W+RSRUd/aNJ4PszIc3Bhwk74UnahiuArtO9XcwnWlsbFdx3CXpo
         nKXD6NW+3V/tkdd65+yGlLWgOmK9UGAuCARdb9kDMOH1JbLpEtCcZZorXwX8vUGk1uxO
         TEIRk2n8rjP2fUONMkjG9WMbA0GcJQdFYpSCzJGv75NEXJAL1mhhlu19KQI3TjeHVaIS
         Vo9ADm18ykTyeewT3NwGfkbKM6KorvseHyVwwwrv0YgSUKQacF42j5GEZ03ur2bzrLxx
         OAsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787800429; x=1788405229; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jIFo/4wUUfQWH3xk8dCu9GeGPDvxh5WSyUAAPSe4Mv8=;
        b=ciZyjS931NY9LHOMM23HB3N/x+s6T0qcpbdxeJnVbYRvYa1GaYHtqcn1yEM5QfnHfF
         /KA/q1pBBcupeyKK2Z2/NgM+Ahbwfgb5IlqxtJ6Ct0avrJB0J4165hGyiDWS/F8Md7tf
         l96VhBoA69dgXiVqvYcVFm9x31RDfFDwPJrlVbVp86o1Ujsz7+QeR9mHmHhHwf0qfTdy
         MiQZNfbA4HE/Z2nfu3vuozBg5QB6EDySQa4+ZyfBZ2ALKS6YD3EAiMQnuk4jvMWkoatW
         tGqcySblkkmeW1NBO6vg5d9rrI08VpagCeYQbCKklZ5yJ8WPt37tQ8UNGLfT+4khnR/c
         L+NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787800429; x=1788405229;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jIFo/4wUUfQWH3xk8dCu9GeGPDvxh5WSyUAAPSe4Mv8=;
        b=B9HO4zEeHhK/VHMFClrQrpElNFmKJc6YB2j0VvIUz1eulcyv7nhFe7CjNnlC45E2dB
         R6pavtBRf1jPRzwKRuWOmTZ9roO8ZaTqYQaAOcn0mNehUivP7bRT/S0873dRmnqO5gQA
         lcXhhEBw3GUTSj6azj/CQ73KdkH0MeJeSP6yiGsBqrlFl0xYK/MGnmDv80CZuHBos3LA
         WRw4C2SaCjPuZtX/J6nHB5eLPqKy5p8o8USHoLvWbHAymCxyfZVmdxSZfH+OCb9kQcif
         LuKEXVbR65dTNPA/4JtMR0AI3ndw1xeYaKG6TKxf1ulp9+xXjfOsDO1J1z3tRTDTfO8Y
         4NRg==
X-Forwarded-Encrypted: i=1; AHgh+RqWfueZt/8/u3L2l/XhUzJtLwzk6WphelWcFoDUYe/DTMSdx07w3afdCMpaX8clFiJvAb+bKoY=@vger.kernel.org
X-Gm-Message-State: AFuF++nZD7BKWq7EvQf5TmWkbPezGoaTKYKBBqfKsWbirJ0ZW8hjtq17
	eCRGVYI/xCE5+n1cxN3Anlbjgkh47+RYi3NO08PftApoqSINQhmiilJALmq+/biZdEILeEKeHvJ
	37AUP7aSpxtXrQcSnADAcd3WQLPWTICo=
X-Gm-Gg: AR+sD13DAvpJTeOZ8jwfRGVC69eHh8puadxbSjOctjUbVuDGD8kYCmWCUbpe0+tUVA8
	c8YZNUYJHI40HxXOe5Ui2avFoYy41pP3NbnGCn3HhtnM4odeBwlRTT/zJBNrG4VlRYOX+LChAD8
	FX7TzdMcY4mMld7LAuI4mPQD9Z2rYin+Q1zpJ9SCnnBOwzSJUbu8fQaae+8k7+bwKThf1JkifBJ
	UjWfJ6gyQ2Y7Da9MqTDpD6S4tK1GmSQ2Jvbj85/RDjcdU6HMxJ4VtSwG+6SnepLxmiojsJJh9cN
	YQnXSQ0AazP99+RuiaMiSZd0GueYwdjjYKaqMUd9iRfANGhYBatPQT0q9mcZU8usnA4f7RhicKN
	l7M9cR8BCEYfv2tIowSXHuuvSbHO9W219+KM=
X-Received: by 2002:a05:6a21:15cf:b0:3c3:bbe6:95db with SMTP id
 adf61e73a8af0-3d0c3876d35mr5059007637.1.1787800428960; Wed, 26 Aug 2026
 20:13:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824021802.90369-1-q.h.hack.winter@gmail.com> <willemdebruijn.kernel.2ec10017f4836@gmail.com>
In-Reply-To: <willemdebruijn.kernel.2ec10017f4836@gmail.com>
From: Qihang <q.h.hack.winter@gmail.com>
Date: Thu, 27 Aug 2026 11:13:35 +0800
X-Gm-Features: AcwNN1XlEAN6Z71gF5B1m-Q6SGnH18H8zxtGCkTd4isFlpTv0XrZ8cKkv1LXuYg
Message-ID: <CAH78GvvF-mBij7exwgkthJC2puz1-1Ti=WkNr2PwFcKr_v5U4Q@mail.gmail.com>
Subject: Re: [PATCH net 1/2] bonding: reject frames with insufficient headroom
 in bond_header_create
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: jv@jvosburgh.net, jiri@resnulli.us, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, netdev@vger.kernel.org, stable@vger.kernel.org, 
	Hangbin Liu <hangbin.liu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Willem,

I'll resend this as v2 with a cover letter.

On scope: I grepped every header_ops->create.  Five devices delegate to a
lower device (bond, team, macvlan, ipvlan, 6lowpan), but only bond and
team re-select that lower device under RCU -- the rest bind it at netdev
creation.  So bond and team are the full scope.

Re Fixes: I used 950803f because it introduced bond_header_create (where
this check lives); before it the type-confusion BUG masked this race.
Happy to point at 1284cd3a2b74 instead if you prefer.

On the fix location, I'd rather get your read before writing more.  The
options I see:

  1. per-wrapper headroom reject in bond/team only -- small, safe,
     backport-friendly, but not generic (the next stacked device needs
     its own).

  2. central check in dev_hard_header on dev->hard_header_len -- one
     place, but I think it's unsafe for bond: bond_dev->hard_header_len
     only follows the first slave (bond_setup_by_slave),
     bond_change_active_slave flips curr_active_slave without touching
     it, and same-type slaves can have different hard_header_len (two GRE
     tunnels).  So it can under-reject.  Would need bond to maintain
     hard_header_len differently first.

  3. resolve the effective {dev, ops, hard_header_len} as one RCU triple
     via a generic callback, so the caller never cares which subordinate
     the master picks.  Truly generic and race-free, but it's a new ndo --
     net-next material, awkward for stable backport.

  4. make header_ops->create() take an explicit headroom contract and
     fail cleanly instead of pushing blind -- cleanest long-term, but
     touches every create() in the tree.  Too heavy for now.

My v1 is option 1 (per-wrapper).  Want one of these, a combination,
or something else entirely?

Thanks,
Qihang


On Wed, Aug 26, 2026 at 10:02=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Qihang wrote:
> > From: Qihang Tang <q.h.hack.winter@gmail.com>
>
> Thanks for working on this Qihang.
>
> Minor: a patch series should generally have a cover letter
>
> > AF_PACKET SOCK_DGRAM sends reserve skb headroom from a snapshot of
> > bond_dev->hard_header_len.  A concurrent bond type change can switch th=
e
> > active slave to one with a larger hard_header_len between that snapshot
> > and bond_header_create(), so the slave's create() pushes or writes past
> > skb->head.
>
> Are we certain that bond and team are the only devices that implement
> header_ops->create?
>
> > The hard_header_len snapshot series that fixed the SOCK_RAW send paths
> > deferred this SOCK_DGRAM race: dev->header_ops is the stable
> > bond_header_ops, so snapshotting header_ops in the caller does not help=
.
> >
> > Reject the frame if skb headroom is smaller than the active slave's
> > hard_header_len, before delegating under the existing rcu_read_lock.
> >
> > Fixes: 950803f72547 ("bonding: fix type confusion in bond_setup_by_slav=
e()")
>
> What's the rationale behind blaming this SHA1?
>
> > Cc: stable@vger.kernel.org
> > Cc: Willem de Bruijn <willemb@google.com>
> > Signed-off-by: Qihang Tang <q.h.hack.winter@gmail.com>
> > ---
> >  drivers/net/bonding/bond_main.c | 16 +++++++++++++++-
> >  1 file changed, 15 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond=
_main.c
> > index 522eab060f9e..9ec663610dfd 100644
> > --- a/drivers/net/bonding/bond_main.c
> > +++ b/drivers/net/bonding/bond_main.c
> > @@ -1524,10 +1524,24 @@ static int bond_header_create(struct sk_buff *s=
kb, struct net_device *bond_dev,
> >       slave =3D rcu_dereference(bond->curr_active_slave);
> >       if (slave) {
> >               slave_ops =3D READ_ONCE(slave->dev->header_ops);
> > -             if (slave_ops && slave_ops->create)
> > +             if (slave_ops && slave_ops->create) {
> > +                     unsigned int hlen =3D READ_ONCE(slave->dev->hard_=
header_len);
> > +
> > +                     /* Headroom was reserved from a snapshot of
> > +                      * bond_dev->hard_header_len that may predate thi=
s
> > +                      * slave (concurrent bond type change); reject if
> > +                      * insufficient for the slave's create(), which
> > +                      * pushes its own hlen.
> > +                      */
> > +                     if (skb_headroom(skb) < hlen) {
> > +                             ret =3D -EINVAL;
> > +                             goto unlock;
> > +                     }
> >                       ret =3D slave_ops->create(skb, slave->dev,
> >                                               type, daddr, saddr, len);
> > +             }
>
> Ideally we could fix this in dev_hard_header or PF_PACKET itself,
> rather than in each implementation that's in scope.
>
> But there seems no way around holding this rcu reference on the slave
> device while re-checking.
>
>
>
> >       }
> > +unlock:
> >       rcu_read_unlock();
> >       return ret;
> >  }
> > --
> > 2.50.1 (Apple Git-155)
> >
>
>
