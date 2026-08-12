Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F2D2F6931
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 03:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786506235; cv=pass; b=SbyvqPBWTp3rNKjIwJYuxhEaBd05sVdsi6q4Jg4UhgxSD5Jh+q+XNacBwtmevHk45F03Ow+BA5kQlcnDlSLKSQLyaSrHHwMU15Z+tn3CI0hMPY2yYPS8Q16F8MVld50Xm2/TAjutHtOFXglOWe1sWVpoGeUzmkwLTeZ7lTQBvj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786506235; c=relaxed/simple;
	bh=pKCoUqXcqNnQpgLpohDhm835pld3atpbmVji0q/VYyg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LDy334yktcHoe3u4+fTBiNXIkZl+oPx8EHHZLbgTYlAJPoV2ZfptD2ENVXFRZZoJosLu2SVXxnQsrBdc3CE73Ww3ExlmRjwvJ0f7a+vbKfIkSTHmVLkXJlm+8oeCXqqdiHAQ1W9zoQwZ6VV2LATARCvDvOGuDGXK6IxM/RZIeQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t8OpM7Ro; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t8OpM7Ro"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cacf197759so11476405ad.2
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 20:43:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786506234; cv=none;
        d=google.com; s=arc-20260327;
        b=JrlJkAwEJi65liBtp7W4KuC4MdOGupfLHW8ivKAhZFiYqexy7hKPoCZzKpMO4rTFhG
         9bj98VZIDlhHU8yHTValjfKO03AdCEc29feZH3/z7Y1EKKKwDmyauSbwQt1kWlVG4oP3
         3pUGzU16ycqveAnYCY5VZ0rSzeLQ3wnC6cR0zzfRbdhr0oBDcN+65wZs8Zj8/sinCTW4
         wOAAFRDBAcRquR6NMM6DW8AuZeN15MPZxGh1f1b1Ou9Wu54TMtgVdxVhuCEpXhWz7Hwv
         ZGCMoS4byQ7AlYdcyD33IJcV4BFs/BRzCN3AB77MOXjt2Jkb7chYpkJxED6FfXw9x+7e
         JCQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JqqV/YviY1MRxkHffT0r9+GTqkdQOUM7n2lGLpU+CaI=;
        fh=lUXdPQ9ik80j+BlRY5V+OxoPlhcJUYyCKlDIkXb4rYs=;
        b=BWlonYuHHc95yhSUraiKS0eecZLFOEFhs2vTjOvlNLbKHlX/SzvIfTeMKd9Bg8YYVI
         u7fSxWWKqScMf/PF6dzGrli5yXTD+BbVmJURAH0KTnJoloVZbXZ/z8mOieJICNYmb/Et
         pxV+DhgdmjqoOSfdR11qbqyl/UuqUdhJeb6a7kdTmTXYGMSVBZjuQrfVTcehUALg+t0I
         P0PX6MCOiB3HWQkyhdF2fpKf1b/rLKmrV2CJzzI/81x/QnbjxBymVcgeH8WHwCExKm+F
         6pf6CESTmfHwDI6Ipxhni8iayAiNkziQ1aAl+wL1b0UOBN3L9tZqnELTdnMaihu9tv9P
         To3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786506234; x=1787111034; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JqqV/YviY1MRxkHffT0r9+GTqkdQOUM7n2lGLpU+CaI=;
        b=t8OpM7Ro5evr/WUdH/NoZFEiUK+ZBQVNFYKWmqMdXC+pl52lNthagYgbzty1WcomIK
         1WO8cEa7QprlEjtf4k6De0dOHDs5EhAfPgM4QVvRlSC9lzXz862HokhDzqW4kBf/Njry
         kSETBCDhAOwOHy6b7MW4N09qbx144Ec9EdU7qZS5W//aWmhgzWlf8pbd8MqnXB7hBbTK
         alSMFPjLA0qge+otKZEBDeXdZN9UR9ZvqkUF/dbtRjxfpKHI/naVioEzfAUz+1A3g9V1
         SWhqcJ3w3jYsA1ceOksY03JlgRcmiPHxbiH0J3CnGqyCgmhOOcGdr55a5cQAD+00OGl6
         pGmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786506234; x=1787111034;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JqqV/YviY1MRxkHffT0r9+GTqkdQOUM7n2lGLpU+CaI=;
        b=XJ1j6OB8O9G3la9IpztGDOHZtIi4T7j7e51g3nZ0JKB7lN+dFco04bRB8GTWdShhxs
         t+wTt1EBaNEU8Dt1AJyPPrUxC5LSFvhMuOU0QFd/ozYM5mLr6Kn3EfNM6IypZQfhBfKD
         HJtG1KKEVtTgwmf5/lLjCjBBh3BZ0nVm3/dw+Gt+8j8t138mPPT1Mq8uf0ChNm7ZqVoX
         jFopXHIkQBbltkSER+ie+cAG/0sXiT3CeAyQnzFQzCqPlO5f4mjBZb0AbQXKlHKoKQ/f
         v3a4Sb4uUT6lRzrGZG/m9ZTCsBX4MZMwqAa9gdsC+Yiqr4zdaSM/mVVhiebpoKP9RRJo
         f1tQ==
X-Forwarded-Encrypted: i=1; AHgh+RoSzUfxeV8TWSYMHxOXQxT4VziV7on2xdn/E35otZaP36WJeq+pv4Gby0qxvALjhCF12Pw01fk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOGH5Sp8EbJItm7LLzi10a1Xdwli7bNmc0zeNbpi9jd0j0pWl5
	FW8QvwYC1SifPUgjpGy30cckHcWNFW1qXEZtI3ieuZ7uIBQUlS65rfNm91YIlXGyF4wVHiOdDQp
	EZJLaLrsqXpYpyqPxqydZUEcLmnhoXVQgl4hAN8T8
X-Gm-Gg: AR+sD10wox7EkuYpUeJYp4cEQyAHvwleJBNWTwdeZgvi+A0X+RntZFu61YqaAALTzQQ
	zSnEpGyFV4vaGEwul4xvhaoVuSDbeLmYt51vg8j4kTfas5s//hM44ndlCLPgjQQBCtasnOD9jH1
	SBypygqH18G0ssij0gabo/fPfGFZieIT/ilV22yd/K/3cUCYBOAWdSYG6kzAgPr3pD25bmK6iNQ
	OJEsXnqz+GmcyZv4FgHevT6nbWCBd5LSsFJU2hIyIfJ1AH0aHzJ1kC0Wr915tHk0oDGOLJw/Z7I
	52wKpD0vmKA4Z+Jzq6QWMF1EpIxKzypbH8CbWwhP3XMrBuiso272n0b7KuYo1HtqO4PehviFkUX
	eXxkFZp4UaLoevx/DASSiVZtF5PC7SBWhwvqPDWYshJx8wjGJtGgq1f827vY=
X-Received: by 2002:a05:6a20:918c:b0:3cc:1e7c:222b with SMTP id
 adf61e73a8af0-3cc3f701e2dmr1508628637.24.1786506233219; Tue, 11 Aug 2026
 20:43:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811022448.116235-1-kuniyu@google.com> <20260811022448.116235-6-kuniyu@google.com>
 <27ec0a14-67a7-49e8-9e4f-944f46c6d94d@kernel.org>
In-Reply-To: <27ec0a14-67a7-49e8-9e4f-944f46c6d94d@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 11 Aug 2026 20:43:36 -0700
X-Gm-Features: AUfX_mxZjnE0MaJUk9oA9gK9ny6OjZgete3MJGdKfmBAAnKAfrl6lUS7kCMx6j4
Message-ID: <CAAVpQUBjifJXnRfBMbRRM-X+MdFXV_ZWF1zm19GypBbinDGCjA@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 05/15] neighbour: Remove __rcu from neigh_tables[].
To: David Ahern <dsahern@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 7:42=E2=80=AFAM David Ahern <dsahern@kernel.org> wr=
ote:
>
> On 8/10/26 8:23 PM, Kuniyuki Iwashima wrote:
> > diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> > index 6fda0052027b..caa52bf64a2d 100644
> > --- a/net/core/neighbour.c
> > +++ b/net/core/neighbour.c
> > @@ -3162,7 +3157,7 @@ int neigh_xmit(int index, struct net_device *dev,
> >               struct neighbour *neigh;
> >
> >               rcu_read_lock();
>
> rcu_read_lock can be moved down after this check.

I'll keep it as patch 7 adds dev_net_rcu() here.

>
>
> > -             tbl =3D rcu_dereference(neigh_tables[index]);
> > +             tbl =3D neigh_tables[index];
> >               if (!tbl) {
> >                       rcu_read_unlock();
> >                       goto out_kfree_skb;
>
> Reviewed-by: David Ahern <dsahern@kernel.org>
>

Thanks !
