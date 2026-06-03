Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0941C3E51CC
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 05:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780466194; cv=pass; b=CZJi4jweqML5FVdL7fRuh2odxSTGadsP+hBKbWOFSfJcJbPAHATLuV9143C3mHCzmBfXIB4qFeI9pVP9FBpUg+c1u97bfNKLieKETIxqjo8kHaeFpsuajg2kWLik2C6colLEoN9G3u+xjc16qLuS9QAUlJ0/Dk93ZeMIo9Wug9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780466194; c=relaxed/simple;
	bh=edZNAe/m4jj0NczNWOtduZgweTZ8wVTCasnxrHvuUgc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dR8XZ9ir0PU9hp3GiBvD9YQBb7wGTOay1Cp/Huz9A59WLQCNlXthh7UO6NG84M9pMKuCp0pPEqaSZoxjwsPO3OYjwYwRRx61qqrJnuscbHpGdzG4J+Luvt8UN99aqBHif7quNxbXdCNH+XVD6hu245g3WDrDoO+Ch1QUzBDelS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DaMjVwot; arc=pass smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DaMjVwot"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-915906a4becso20340485a.2
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 22:56:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780466192; cv=none;
        d=google.com; s=arc-20240605;
        b=AuPaBJ8MZnM6ENM1zOs5i0JCpxd1XvqFvqRPLFwdRxBB3K1FD96r8MCipDYUSNCIEk
         U3MfhP68CMxgyE6RWnTMp3Lnm24RB2KIybLmdri5x+DtAKuUNQNO518wlntB/Ouu0De/
         ftN88+jP/nw5IS7SM/LsbPNeDjz/scdDgvz7Uv5JbxXhpZA46X7YVKBx66AX4g6ZwaM+
         Y8aHVcgXnNMMTYjrG34/lqoWAZwKLy+uVtDV0pRESn5/VCJZCGlxnd7KDmpD77ewt5Ui
         hzxQuEZz+TW8RYeGzu5xH0Glbk1hkH+8LgDxtwpHumZIhiuR5zjjQXgL5vaiRjr8LPm+
         I/SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z35/UICY2kBA6Yxsu0YmHo+AofQg6GySF5BiGaW8ffQ=;
        fh=KKNIre7G0FLlbJGB9OBrV+k2UBXbvMy+YJnOjhcOt/Y=;
        b=PlUgSFG4CoYVraVgNDA8UZ+MRDk2KTzc9/i7x1lTMa7teEF+zcMo38So1RfQw8m1xZ
         zmiT/M/fulN6YM1S9O8+6LMYwHK7Pjj2TRf5ooa79StAkdmLc0EpKDFhxjU2YgQD2TsP
         OfpDchsLx+/xN0mKXRS6eaCdEzuZ3X1EtRDN1AWONq3ob2DIIvN1TdlLGJkQIStPcR6/
         FQNdAE54sFW2qEmCVeEVTzdhBqUnSW+mK0T9moMXSANz0SMpYK3ZfSWRpKQalA5LQWqX
         FzmEgW5qvJKCz6rs4BIva/Cze/zD6qlYDWZzB7ESL792sBEOIUaOro/pxHiaG1OzZ67X
         S4lw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780466192; x=1781070992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z35/UICY2kBA6Yxsu0YmHo+AofQg6GySF5BiGaW8ffQ=;
        b=DaMjVwotQrn5EavXB+2zowI0wYrabENAGTxbBtRnBmuhpV8SEWU9YVit2F918dmea3
         GDAXNbQg6oAVjyIUkDZo7lhIaBPj80iVJX/1+hrp9iAKGonrsXKJpeI2so23GIcbUuGs
         EKGl4QpsTmYq8zL773JriroKh094yggRVdUI0iwPfNqA7jZp4XJcA/nLm9SpHpXGRciv
         5pKuVt1HqJ52/R44LY0eVJymEFo7bYUMQTnt7txbICHlR/tIfyZaQU9CoSMqEUIwWqC/
         Ia5LkBNMd7yYWpbARxigFMyyoeinaUMXHIfMYqwZIfGfuyNKZED8uOzE/cN6P0iD5san
         NZ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780466192; x=1781070992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z35/UICY2kBA6Yxsu0YmHo+AofQg6GySF5BiGaW8ffQ=;
        b=EA/VGup2B6sdDpp1OhIDcUpKfKc7Y5IurJSuauZNxhTR/cOWMKY0s0zGE8ooRg3g8r
         i04/rhbdKzo+HuNO1Na9wOwHYZRzUISzCzI0eqz4hTw15qBqMYUvi/+Bi84BUvSqLFpj
         LamSpmG8IfkgefW0d0LUfdh3K1QXkcNTY1W+9V8P9ky0CjnOlBXQQP3t1AEY+o1S0TnW
         OOGrUE3jQLj/E8sKiiFm62q0gnc/xLDi3YQcpX2tl2sO5y5pJ8Pujq8tmgqn4FswY4+u
         K36P6F9jQ8mApYPxm9rGL2vb1O1+WOac3dQ9HEu/BJsOaujNZHZ2HZkz4AShbN8dg3M+
         E7nA==
X-Forwarded-Encrypted: i=1; AFNElJ9d5w57V/FTJu2MLxv1A3OvXQaa29YvGsxdsJW9HLrpH4FsnlwbDOvKGSVVIWm7p3/4jLQsa/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YziZv7aauxnjLTt+UCZLqr7HyHiwWqqtyGidSBtna2vzxj86Xar
	x+dQ0dPk2KhWU7MVpqY1T2L3s3vHOw874mA3LLaRncKcH/Eio6MXySCcqyth80+uZiySbfpQV+1
	NdihGg/8NafVfZyFq1XCeiQ7hTEfRPcdxZnJoZefz
X-Gm-Gg: Acq92OFZqhbGGs7aJHVR3jTafIIgAIRtOW9W23ur4Io+JBuxsIFVIPeOPVCdr+3qRiY
	sgMP/vQJebyYl4tV/20T3V+2AcuqtzE9thPVZ2i4Xnd4HeWuCK7+rN2rWiE7JNXGUUqUs6Rnvx0
	KL5aRhzYnpDwqiQ/QA08SAOIhStn0+IX7KuHGCuhzXVUuJLSiw1/18wblL6K3SGsAEEkzuT9LbB
	Q/ZgE5rqkMiahj0MHQmS8QKsRI8fDTpPRqSj7XgsDv96FkIsA/qhOzctCS4swAU7zCv+3JBuEXZ
	BnVivVgvX3C6BF3KeDlTBCNqMMfc4glDmNTanVZFbVkRUWdR228x2l64d2LCT8wE8eaHwjvujQL
	oLmR4eoEqzQByKf00Y04JdWC7XuiN
X-Received: by 2002:a05:620a:2550:b0:915:7b5e:a4b8 with SMTP id
 af79cd13be357-9158a83f808mr350733585a.60.1780466191576; Tue, 02 Jun 2026
 22:56:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521131916.3627204-1-edumazet@google.com> <20260521131916.3627204-6-edumazet@google.com>
 <20260524124802.GE74116@shredder>
In-Reply-To: <20260524124802.GE74116@shredder>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 2 Jun 2026 22:56:20 -0700
X-Gm-Features: AVHnY4JRLBcNtnZNAdOT_EoAZbz20UroV_pfKEcKicsv1PbZtRNm4KC1GMlYtJ8
Message-ID: <CANn89iKyi-_HbsnowuuDk_+JHjZtOFw8qnYwhSKndDvyypn5-w@mail.gmail.com>
Subject: Re: [PATCH net-next 05/11] bridge: provide lockless access to p->path_cost
To: Ido Schimmel <idosch@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Nikolay Aleksandrov <razor@blackwall.org>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 24, 2026 at 5:48=E2=80=AFAM Ido Schimmel <idosch@nvidia.com> wr=
ote:
>
> On Thu, May 21, 2026 at 01:19:10PM +0000, Eric Dumazet wrote:
> > diff --git a/net/bridge/br_stp.c b/net/bridge/br_stp.c
> > index 024210f95468308066827ac2ae71f68f99fa77f5..1367cd3ac4dd6a587d4a647=
1184453a14af6879c 100644
> > --- a/net/bridge/br_stp.c
> > +++ b/net/bridge/br_stp.c
> > @@ -125,11 +125,12 @@ static int br_should_become_root_port(const struc=
t net_bridge_port *p,
> >       else if (t > 0)
> >               return 0;
> >
> > -     if (p->designated_cost + p->path_cost <
> > -         rp->designated_cost + rp->path_cost)
> > +     t =3D p->designated_cost + READ_ONCE(p->path_cost) -
> > +         (rp->designated_cost + READ_ONCE(rp->path_cost));
> > +
> > +     if (t < 0)
> >               return 1;
> > -     else if (p->designated_cost + p->path_cost >
> > -              rp->designated_cost + rp->path_cost)
> > +     else if (t > 0)
> >               return 0;
> >
> >       t =3D memcmp(&p->designated_bridge, &rp->designated_bridge, 8);
>
> Both Sashiko instances complain about integer overflow and I think they
> are correct.
>
> p->path_cost is [1, 64k] and p->designated_cost is unbounded. So, even
> before this change the check could overflow, but now it can overflow for
> a wider range of p->designated_cost values.
>
> In practice it's probably not a problem since 802.1Q recommends a range
> of 1-200M for port path cost, but I suggest to keep this change purely
> about the READ_ONCE() / WRITE_ONCE() annotations and avoid the
> unintended side effect.

Ack, will do this in V2.
