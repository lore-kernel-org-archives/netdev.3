Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149F63C061C
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 16:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786464417; cv=pass; b=kuc2qbMt2KmWTSpk+NW5Ay5nYmH7TXaMecrwXAstz4xZqNQ7QTTnBR0a6L2JFqd10t+lk7fkrHryBlwUach986+nLX9ZyoQk61mLUKGBXHYztvCDB9Q8kzv8ttzBzy86u/L8QrRnAMqbpiOrMxgYyHZ8ktcp6d5yHjQjg54iLOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786464417; c=relaxed/simple;
	bh=EpZfoLYbJcIPSxl/oTc6thafxuEwE0MFlEgXgQgfH4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qCmGQZewT8lk57aP4f1MWy6NtR0JkE/Ce1wOhMb6oADNOn4fbDPT3s1gV8CS8tgmZwpUKHQUQzsFiT+yxWi1C6UBdA+w/ecmGebsLw8KT4J6s61VDwHUqkoQ8DWkHb19t3IM5yobiTFMNtNTYkjDaQWqNm0aOfZ65Yftt5xeWCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KKW4m1Z2; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KKW4m1Z2"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-69fab5a852cso4243474a12.0
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 09:06:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786464414; cv=none;
        d=google.com; s=arc-20260327;
        b=rJCQVV22scLy7F9MArgUYwuUhp+UGrvhMJ6UgK/RUg9zFHJE7lTOXqRiE37BIz64L9
         p4902OjeqTBZkRgcHaaANw2uGHzDyApNgx4Lqyvhk2V1/IkSF9nDGCHLkfF4QeyYZgn4
         7xZTgrf5yl3WcCfv8Nlzwt6Nwg6PeQyd7loM7g/4naEau7JU6OSjeNaHZexdpH6MkPxJ
         D4gmNzKbMe1/8DLpvPZbeONXgxxWpc8/d0q38LoLi9TURBOlqCcQNc8FQlHeSiLn9miq
         8BdHX1Zm/PN0INNgV6pvdy8h7mhshJlGh0Tdap1wVPw9BNWXnCwCg2LtivRc6+AfrE6F
         DtUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NxBXsvZDfR8x8hVJHrORxprKXoQusJH8uCvAZ74aEb4=;
        fh=IxCkeNmpUVjZ06S6NUPN4iw0hd3LZoSHeXJBRFOxuzQ=;
        b=jObZvhCFFIIngJkxpbB7Tevfef9nh1W+rJQqKA5Ayf57V30jAAOa8bl/LqvQMGoDpa
         hx2eQWj0TwV/nukEsMb24koSGOLiGqJZsuUST+/yLZD3BggMJtkXzhIVjt/9q+nOZHMf
         oqdzBea8dvHISJuSWUUaSCpfpr60TlOVfhhjfJ1Y/4zUNCZUMGTIcRkSV/A9JV7YZAtt
         FiIifDIphI3uzJ5AVGs4oEWU6BxMTGX7T6qN8rnuX2rqqPcdjaPCx/Rg9M3/Ep0i6fWB
         K87q4CA/O47N7OK7Q++1ipPmJSf6bfFaz6kkWSRALugPm0ldOuEpJ9LE41cE2E5OB4DO
         tl0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786464414; x=1787069214; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NxBXsvZDfR8x8hVJHrORxprKXoQusJH8uCvAZ74aEb4=;
        b=KKW4m1Z2go0uAS0iaWWYqtWv3xh4Y04VR7uISR6f/RcZJSbTO6chGpXwvEbQAhcFf+
         YM1rZFU6x3U937e1Q7hPfFxNU1Nhb3KeRYToJLFh6MRrgAPu6o8KQNbUTBrcJ9RqC1B9
         qNdgzpwq9G2vlB71NM6KA0ecWxOAYd8rC5IK1CAxXKq8fRJHQGYMeOUH47AH0Ck0F6rn
         n4BVtnTewDwMwFEBamhHgOqjbtHykH3CPUvwXig+6u/F5bDr3pnbV5FMTh8Y3xWI3swX
         +Ox5d7b5a0Khu7oZMgWnXWClc2MwVQZzdk+PMZ83BleW8UwpymO5uNF3dJP7pNeser2e
         Li2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786464414; x=1787069214;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NxBXsvZDfR8x8hVJHrORxprKXoQusJH8uCvAZ74aEb4=;
        b=H0O3h5qOoM4TJPl/0vXwdS0n1nhUq0qoMYqXC0BMAGoIKFQrzwp0M/PU2yCtSTw93b
         giS/knztkaSyAkJpQ7jQI6eLEw26l9slWflQg2yocgSA8aTUrDdlRFnsxLkYP3lgYUul
         IkDEKUMO/ajZurDjzk2xGjMB8oMxiwRK9sIEh8VkUIoQ953sAY3IKaS0z1Lq0fIxHX3c
         p/SLQ0dItmy5mLregv6y0e9gZZ6MUEMIgeitm9EIRHBNr1doS9G9uqJQn/57r8xGmeEm
         joBc19tA2ew3sColnUhNTUxh6LhoesFDi4chDulKwsWkO2G7XYuRvG9gPoof3q/mh52r
         loXA==
X-Forwarded-Encrypted: i=1; AHgh+RpiZ/5jCfweicEsnomElclTufHnYTnVVAfk1eVP3X5tbch6RTDU8m84LsYurR5EMOagkoR52HU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyivZ/OSr135ZteD+fqplThYn/kpAI/LXLaVSfgCfPotiDnqaZ8
	FNnX5Sxht2B0g4/7yIYyawz5wtRM0oDfDiJQqnffrx0wiagXks+efBtbJvDcDroPgfCMzwdQj54
	3fNM9W9ueNrxBzJqMrwkFvDkaYLVokDoBKqwaVrl8
X-Gm-Gg: AR+sD120t6FZVufTcMaWH9EBUei048ihXgM7tOKCVI8URf+9mUZ17TO44L7XFBXFnBv
	au4FgGo5j1i5MRvrTJKtXdt+/AAY2ffLJlGNK7Fdgferu0sSkNzw96XrkUL3ZmJ83vYrpAqYvjG
	mzj4EHcq1HbeNlfYZOChpRrHoEkjOZFz3tQgY2BTtfJGSEfvDLq4QMsrR/2kffofH+SmIBN5pba
	KGAO4elVsvOZc494BhFYLobORY6sNdH6I3TISRMaZE0airFkAxvoQm54FbdpqqiTso2qKpHhu9J
	OKP+OLfR1UPBdL1zouwBIX6tQQVLE877dyCeag5XoToO965EgXeUEi54vgOaKu+hRg4r2QLkuK5
	zyWpMQX4wdahFzahXiEg1TknV4qwiStwDNS38YA8Cw/cgXbAFqm2pYc5mSUb3iKK7d2P8wCgEO7
	QOV0M/OfJFI/sv8iL8Zn3xj3+UzjTEuKWlrDI=
X-Received: by 2002:a17:906:9fcd:b0:c1c:332b:74a1 with SMTP id
 a640c23a62f3a-c20e61fc956mr224405766b.28.1786464413459; Tue, 11 Aug 2026
 09:06:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811022448.116235-1-kuniyu@google.com> <20260811022448.116235-7-kuniyu@google.com>
 <c90385b9-28f6-49ea-b4cf-9eb90604af10@kernel.org>
In-Reply-To: <c90385b9-28f6-49ea-b4cf-9eb90604af10@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 11 Aug 2026 09:06:39 -0700
X-Gm-Features: AUfX_mw45djgaea9_LsyXh8uOiUuplSqLBi1MNNRvjC3gN8gcUiDvnup1aRDzAQ
Message-ID: <CAAVpQUD3R-Vi6CQYS5MRtE13u5LgxZ1JNnn3MDkT78VE5zWTzQ@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 06/15] neighbour: Store arp_tbl and nd_tbl in net->neigh_tables[].
To: David Ahern <dsahern@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 8:19=E2=80=AFAM David Ahern <dsahern@kernel.org> wr=
ote:
>
> On 8/10/26 8:23 PM, Kuniyuki Iwashima wrote:
> > diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
> > index d409f606aec0..bad17d5aeafc 100644
> > --- a/net/ipv4/arp.c
> > +++ b/net/ipv4/arp.c
> > @@ -1495,15 +1495,34 @@ static const struct seq_operations arp_seq_ops =
=3D {
> >
> >  static int __net_init e(struct net *net)
> >  {
> > +     int err;
> > +
> > +     err =3D neigh_table_register(net, &arp_tbl, NEIGH_ARP_TABLE);
> > +     if (err)
> > +             goto err;
> > +
> > +#ifdef CONFIG_PROC_FS
> >       if (!proc_create_net("arp", 0444, net->proc_net, &arp_seq_ops,
> > -                     sizeof(struct neigh_seq_state)))
>
> proc_create_net already handles CONFIG_PROC_FS. It is not clear to me
> why you need to add the check here and below.

Actually it does not handle the case well because the =3Dn case returns
NULL and setup_net() fails to initialise init_net and dies.

Most callers have the same issue (e.g. NFS can boot w/ =3Dn but triggers
oops immediately) and it can be followed up if needed, but I didn't want
them as the prereq series.


>
> > -             return -ENOMEM;
> > +                          sizeof(struct neigh_seq_state))) {
> > +             err =3D -ENOMEM;
> > +             goto err_proc_create;
> > +     }
> > +#endif
> > +
> >       return 0;
> > +
> > +#ifdef CONFIG_PROC_FS
> > +err_proc_create:
> > +     neigh_table_unregister(net, NEIGH_ARP_TABLE);
> > +#endif
> > +err:
> > +     return err;
> >  }
> >
> >  static void __net_exit arp_net_exit(struct net *net)
> >  {
> >       remove_proc_entry("arp", net->proc_net);
> > +     neigh_table_unregister(net, NEIGH_ARP_TABLE);
> >  }
> >
> >  static struct pernet_operations arp_net_ops =3D {
>
