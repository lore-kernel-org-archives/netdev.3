Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB3F3BB11A
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 23:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791328663; cv=pass; b=fyeHCj5DV3vdqZU3KgoX2/E9XxILU4xNGG1/KL5yElZz6JmRs0ZhXDrFIabKH0mezgyCMBjM1UVAqH3XvsSqAFhXj6U+qebZvKJGeYgderwDB9I1h0P1cLk6cGRo+ANrfm6vmUhPERxz7yyqPLZW/u+bGA4pkfxdq4x7iY/WuxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791328663; c=relaxed/simple;
	bh=aO34Wg+EhZ2MBBOCazylrMjmoEMFQZsqrQuOcpOxfGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C7w5dDK4JGcwyA0kri0BWXrPf7XIRbsicG5+cWwTU2uSJiY/Lfz/6+K+76flBU/l84JzBqZEBEsvxs3zXPH7KjJ8+fTMkeeS3OjHAtEwTaTbyHoKaU3A91tc4tE75c0hmvlXOJvEFoFm4N0Xg3SP3EBAkJC6ACMxjoRIDbtx8xY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sUxA90SC; arc=pass smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sUxA90SC"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-97ca72f2cd9so640301241.2
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 16:17:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791328652; cv=none;
        d=google.com; s=arc-20260327;
        b=ou45fPPYXHTWRDqZI1tsh2aEPavywwv0mSZJ2KkxNySxxHwFH8U94A38AbFjpObgWg
         q2DCG7ByqI73pI02vrIJPJMI9g1uoe39gewVSa7uI+6wN6N/53fg15wiCe3u+g6qSGPk
         rq7Yo+o8+XsqgXzBhAeayhC0L5xDdA0onTa1Kc7dKz0cP9hXlo6E7hYXRsgJ+aEz9X06
         9V1dOIinLXvrZvD2K37cwdMSy78qLLNtYBik/2T87Tg0rDIGcs2UnFsbkWwHfBaWFQQH
         53r4Ill6TD2BHgP/mXvpfM4KIBnRP9kynsSAVgRlIB1M7jw5xhEF5uej8+9PCb9BVDKh
         UhVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aO34Wg+EhZ2MBBOCazylrMjmoEMFQZsqrQuOcpOxfGo=;
        fh=A3pfC0oxcP7cOYh4LTqMCjVVo8QBXkjBYuMWWUQdt+Y=;
        b=gKQ8Wo9uzIsICmhMP2Lmq6KPra0jIz8NOUn6Wk2xIwaY2tJZndtsj8PYhq9/319y1u
         9gkFYtu3o+0H3lfU7LJmlrh5nI2Pg9+V70uBeqfYszR7Lid8961RZIUlfR76205dYUxq
         +oG9X2+yAiT0nNgJA26841qxxQTOn418Tb0cc4W4FQ2rhKUVLST2VzVuiBd3F806o+N3
         XbsJpcVkG3bu+yFQfLOHCHZxd1d992S23cGk7BUi43E130KsCsoBOVKLbgUwGkswnHCK
         HzvP+yNGSHSZfVaU1srCTs8AScgcUWZ/7pKYenXrE4n0Am6UcRsMNRbJ23juFi1oSccw
         JoYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791328652; x=1791933452; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aO34Wg+EhZ2MBBOCazylrMjmoEMFQZsqrQuOcpOxfGo=;
        b=sUxA90SCMoClTosV4Pw5lirOdqazlu5pk5m7lBv/xwcpgYVh2dFz0uRczs4yLgWCzH
         ss10IAXPA6+etAnvj06Mf2vdguWyUE9um5An7PWWb5aQSCzu7r0clIAdgsvUHVc9ntvN
         08/xaG8wgNwPZiVv3Osf0F5jf6fLvHmJQYxzX1RECSdQXaetDsstxLDmy10f2oWgj7no
         rxikn/J6bm5W/plKndWDyvSuNf+vmP7i6TrP0vNZn5m/VxANNHhN+/UccA0rjMFWHePs
         CYx9qDjGqaxObixU9DNuNtfZ1zfVLTcmJEv0Hx/5gcIi4olNDwZ8npfff3ancPVYEAmk
         vhVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791328652; x=1791933452;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aO34Wg+EhZ2MBBOCazylrMjmoEMFQZsqrQuOcpOxfGo=;
        b=BmrRt+SdCSXFREkfab3uuWh9/bsQZL6EekuSkrkwAq+pfUJzMU4ZTc0NA7Y3+fqWXc
         APxv242NQIeYi2DZuIj7iLpfJISIo4dN4AEPpJA08+FgzbHFKIMzeOt1TWc/XFosIVr2
         ytMQcUab0HFdp/J8PS1v91snj0VZ/lnQq0v9pnjkfTz3woSooC9R8+ENLk4+1dOlRP+N
         AF8fzPTdmIfbNNey1ZKezzoyFFWjXNGwOL+epaFJ39XUtHkOGZTdM46V8hI8Widzey7F
         q6IlUgLK0aR3JZfsuI50EbuNnz5NTHgqWfjwPEAXHtUUYXbPxd372yWNZrOhAkHSbf2Y
         WF9A==
X-Forwarded-Encrypted: i=1; AKwUvByIg2VIIQo77jsxwrp7VutmMA84lyyl6p74/27pM7hbO8SnpCeB3XeZRHfPN8+qmHH5BoW0h60=@vger.kernel.org
X-Gm-Message-State: AFq9FYIk+EdEFKfYwF3mjrD5TBre+IXmSz1dTHUS93zwhmYQkiYGsmLy
	Xkc1gjrKQGmzat8fFyH9g/4mAQV0CS350XrlLMlPSpxuuli7S7LzhWC+PmEbiRvbfFFqQCc3IPM
	3OKM3prGN1zch6kl7z3UC09nb9PUZfMY=
X-Gm-Gg: AYBFou0fKqUYutz4v0tpiXk4fIqhbfxav3E4VpwJk0xwmY9n4dSTewx6Z6AqypHtI8L
	KwsXtTdm8kdJJhtrw5GEgplQ/zBGQ4JdV92KO9CDHoTdPh2gmWIOe1UZkwYjXt/kznPERds3gt/
	tb6ZZb0iASq53WsPAPyGZIN4ZYtjxzn8+6duAOI+iiAen9Te+ejz24zHHwgmPpklqWbuijU8KsS
	ikKZ6mhnA+iOyJ2SqH8Mkjhpoyp+QzhIDnAPbWo1J0jST5vNHzorq25SNMnmdqEJSiiB11qKZe9
	K2KJmE0YFcz//QqZdxBD1N7aAUD7iSQ3KH51Z3iIFYkPMt9Q6UjkEAvStZZqNSYoVKA2ZlzRV9p
	FyjJkQBVI9zgWuySyuWLuxA6NaKOeg8udaDVR4Z/bR+DORhnaHSOA6mcr5ol8RyNtxFgzFweoYJ
	e/jWTMzMlaX3HIJxyDYWpZQvWXHjyJ9xUxaz54aH8ib4M62k+LTs7Pnle4
X-Received: by 2002:a05:6102:2924:b0:7ad:3ad3:997a with SMTP id
 ada2fe7eead31-7ca36e443a7mr124714137.5.1791328651645; Tue, 06 Oct 2026
 16:17:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006-stmmac-irq-unwind-v2-1-194591c87460@gmail.com>
 <179127056620.2231598.8882282421523696709@kernel.org> <CADvTj4orth=RYtb78ND1rdiYh2yb6d+TjZt5ohK_-+1mnVpqfQ@mail.gmail.com>
 <20261006155214.63c5cb5b@kernel.org>
In-Reply-To: <20261006155214.63c5cb5b@kernel.org>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 6 Oct 2026 17:17:20 -0600
X-Gm-Features: AclHuK95whFkQF1vfwc0DrtRzHj7zemriMM1hLHVnrlFjQ1KlVVaQcu7yNMv7bU
Message-ID: <CADvTj4obBNgR4w3BW4-gCU-=LUxesQdTRN=EdWTcx7VznFi4kA@mail.gmail.com>
Subject: Re: [PATCH net v2] net: stmmac: unwind the WoL IRQ after a safety IRQ
 request failure
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev-bot+sinfo@kernel.org, netdev@vger.kernel.org, 
	Paolo Abeni <pabeni@redhat.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Serge Semin <fancer.lancer@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Nicolai Buchwitz <nb@tipi-net.de>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2026 at 4:52=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Tue, 6 Oct 2026 01:14:52 -0600 James Hilliard wrote:
> > > Please do not repost the series just to address the above. Instead,
> > > reply to this email with the missing information, so that reviewers
> > > can take it into account. If the series needs another revision for
> > > other reasons, please include the information in the commit messages
> > > then.
>
> Please make sure you read this paragraph, to the end.

How much detail should I be including? I had previously been told to try
and keep commit message more terse[0] and this info didn't seem particularl=
y
useful.

Should I put this info below the --- separator so it doesn't end up in the
final commit or something like that?

[0] https://lore.kernel.org/all/CAD++jL=3D6Ov5BPK1naX6orzMsrJPm_g6SkdRaU6Ji=
+okXMFaZdQ@mail.gmail.com/
