Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5D9305057
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 16:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783700182; cv=pass; b=i1CUcCRn9aLI4z1WqCWUUUXiwvCTM0Erask4j5T8cwijXhkd5HOOHrchWeTfIjn+O4HrTJnyZC57548whLFAVFGL9Qc+lcebwIgPoLXevbpDWRBIA8tiLaETXuMDVdPbC2hjjYGDbAvsXZsyiwjQ20Mc/VXVLu4xqubdlWjeKWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783700182; c=relaxed/simple;
	bh=5js74AdKbars7Usj3g8I2n7xXgF9uimxpPdoO3FtMBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mZGSb2Kk4IGvohihf0tSkEtBe1QkIuX6i9AD0r/7mwIXjjYE/ZNuoWVbxgr547FN2GMSpHC6aXzS9HKoulcISwhdyPwmdj2pkxLr8wyiT+iVKYGv4z3EobLPcfO/cG/vW6oK/8T38HKPv3+2avLxCGfBFPxYj7ciZLwOz7BVA/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AR9E+vt4; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AR9E+vt4"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6986287534eso2082249a12.3
        for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 09:16:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783700172; cv=none;
        d=google.com; s=arc-20260327;
        b=PDw+SYnRXsk0WY9ZcmFav6wA+6WGaEvyVDTdom9jeY5A0/1+GFAGpZ4O7anvdFNd0J
         rDWXfY7ieSyhPDwo4e2/FA26GuXKKN/SeVjSgGvsZqDcPiKyxjE/CcYbXKFNZKAkwhqn
         qQTGF0G/70Avl8QliYXlHaCRmsev1eouRDsm72layesmkehPzOypHKB/H4hfASW0wbt5
         xN+jjc42jBx5K1DOhPkcprDD4Rxr0UDez/1BXimvnqq65fyenEiHNaXIGHX/QcoqgN5T
         miFH/F+ILkEgfID+7OZjxT3G3gZCPb2NoZS058shd57rxQ2qq9TnsLkI2qki3FQu+foE
         bAvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zs+xWp8GQzONfB7g/lvCrSCFK6d4aoPZdC89WFaIMtg=;
        fh=X7boB6e+0BA2V55bLY0DCuh/r2q2nsMah1D7pPbK/bo=;
        b=YLIP20W/oNYTFhUGDXYmM7kA/95VQEudpI1POT6qrTCZg6+vsJES8h0OGKCX0OkLQ1
         oIojkjIv2v1/sGgNOtQPILUteCPFsrqn5ukwUYyaUkIgzkxrW3IoJtbRsBeTFJNeBdLI
         M8xPorojughf+sPAOkRZzlqgRHI7T/9VDbQE9XGrxf/hwnd8y/i4enb9WXfo0yQCko4q
         c7uAkejol3TGCJf4iKpNj92hlfggJWBqirc/Tao6YKmH8jq1kNcrQQOcJvyD7DHeh9aV
         RsCV3Wga3PzGni2HHKGIBmcehro95/8RSCVV31MnX2eonbRGaVqhbINCmo3GJ2rhpcNU
         bHCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783700172; x=1784304972; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zs+xWp8GQzONfB7g/lvCrSCFK6d4aoPZdC89WFaIMtg=;
        b=AR9E+vt4zrvxewVg3LCBZIEeODVkNnEWzi+8wAlAj1CWsUzrx9JFvWepon1xWz5ldW
         YOgJ9mPPFJqzx/+wYeDJX6Ky0afmgmmyOXzuje/H2y+owyhuvRIGUcGHjPScE4gIVE74
         973ocP2vhG60LRJ1s9QaCxNeoM9RefB8BYJZH25iIxgLELNQ66RjO3BfuEHYbKmF7UKQ
         rqJXvXucjKFpwqoCtyqH8U7i+dgR7hFYhxzb5Mp9Gio6lrIxW/H481eBW2UkaOtBxoCj
         24rnvku3PtGzeNbSXutgRj/fu1wvtgGtBN6b7ZGO8wTNzzJ5BaJzr1gwHUYUDTkZYShX
         Dskg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783700172; x=1784304972;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zs+xWp8GQzONfB7g/lvCrSCFK6d4aoPZdC89WFaIMtg=;
        b=YefGJw/ubRuYGzpg+tby7NVtkk2BpQZLO4oreFZdynjrXDXM46XcuWXP9lDm6gJWqT
         exjYSWgVz4kPHZ2SNB2ao1b0EHYvif+aDkOG2iVNJd72qZAGUKgdzFd8/PAFZa1OaNbJ
         bGCbtlMMFJ3VirMtP1NyF4eZE1+2EzysYRsvAaw+dEgqZeTvWDoHpc9PD6IeUBOzYV3k
         jWKRufN1GFZrtPuwVjNjgrYL8Q24i0d/kpkgitAfz60GF9TBBi3VOHxc+aW0yLa8W5Xw
         go9IwT5P0arPzGj3mVPxActRP1GR+skvOsIHYIHmJ0PJ+TwxTN62DXsf5OqtL7i6Mvp2
         /M/A==
X-Forwarded-Encrypted: i=1; AHgh+RpCOJpRNnbHgTHyUFXcbyvsBI++YMdHk8aqYSZ4d2LCtDruUux4OlGNAElegMwi0cvbXbnKmVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRBWSMtS+r4x5Nx35nkq1XfzgeZJu+gXw0qq5z71/egactUMwe
	0gKdW9mgCAfkewis3stLk4ibaIkGTKizlr/8D1Q452qIOC5OLRKtXMFKd8IrKPWfp7aDs7chb6w
	hVJW8V6NC12+7htclZgTzphcWjC8vPwOaw7wJ+mKd
X-Gm-Gg: AfdE7ck1WfSnuITaxp+xxRS8IQI3UiPNGzYE5GXpj3VEvnfPVxwLhGFYl2JZVPvI08Q
	p/t8sjr3fbMNWvQeRGBKvpEl0ZHIw9YKEelQsAngn/7hny8/mqbZYldhXu/v1vUldIeykj5TlOG
	DhuDyBrMeAEG68UzsWRfmKgLzdCFMoudRNbYvbfYsNdL+e7xUU8v9r1k2n3UZQYFHmBtEsv4q3W
	GS6UfuD3lrKHvbSZVqWYvMVay570XftShgLswQNl4oZn016xAyAwQPHGPRlsInPLDBmZ56U0y5Y
	mfs553xGk698JwIo5TLXK0XzdX6IqIi8+8jmWcJmkM+aQl1AOpMyZtQMGI/mKiNLn2HJ/6bnMbm
	aZVGQMuS/mYL0HbRRV5WQQOHx7HoZ4A0bib58P4r1Zg==
X-Received: by 2002:a05:6402:11cd:b0:698:9b27:9823 with SMTP id
 4fb4d7f45d1cf-69c5ef8ce7emr6866a12.4.1783700171591; Fri, 10 Jul 2026 09:16:11
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703001009.1572444-1-kuniyu@google.com> <20260703001009.1572444-14-kuniyu@google.com>
 <71f1aba1-78b6-4e7b-8dc9-092b50402e07@redhat.com>
In-Reply-To: <71f1aba1-78b6-4e7b-8dc9-092b50402e07@redhat.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 10 Jul 2026 09:15:57 -0700
X-Gm-Features: AUfX_mwZbKln41V8ekfkZywAs1LMi_b0VHMqblJyUNXNXmLV8kMMSoXrxuBUrwc
Message-ID: <CAAVpQUDwa4cqLf9RJg2o25oN+xKyP+gv+asW4aK7LMNgpE3o2A@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 13/14] ipvlan: Protect ipvl_port.ipvlans with mutex.
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2026 at 4:08=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 7/3/26 2:09 AM, Kuniyuki Iwashima wrote:
> > @@ -800,9 +831,15 @@ static int ipvlan_device_event(struct notifier_blo=
ck *unused,
> >               if (dev->reg_state !=3D NETREG_UNREGISTERING)
> >                       break;
> >
> > -             list_for_each_entry_safe(ipvlan, next, &port->ipvlans, pn=
ode)
> > -                     ipvlan->dev->rtnl_link_ops->dellink(ipvlan->dev,
> > -                                                         &lst_kill);
> > +             list_for_each_entry_safe(ipvlan, next, &port->ipvlans, pn=
ode) {
> > +#if IS_ENABLED(CONFIG_IPVTAP)
> > +                     if (ipvlan->dev->rtnl_link_ops !=3D &ipvlan_link_=
ops)
> > +                             __ipvtap_dellink_ptr(ipvlan->dev, &lst_ki=
ll);
> > +                     else
> > +#endif
> > +                             __ipvlan_link_delete(ipvlan->dev, &lst_ki=
ll);
>
> I'm not sure if it's worthy a repost, but what about adding a
> link_delete_unlocked() cb to `struct ipvl_dev *`? IMHO should make this
> code more straight forward.

Since port is allocated in ndo_init(), ipvtap needs to wrap it
and overwrite port->ops everytime for one time (or at ->newlink),
but I don't have strong opinion here.

It would be nicer if I could follow up since this series gets 5-days
penalty on Suie due to too many Sashiko false-positive, get_net(),
and a build warning due to xchg() for veth, and we will likely lose
context next week :)
