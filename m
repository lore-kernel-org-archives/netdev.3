Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792543906;
	b=1QQ68Jg0IMczglYdmqb8xg6lXgWYKW61cEZDm/8BNIawpx7/nDIVhWHpLYh5plfLyt6m
	 etOf44Wg830uGhCE1r+rGYfZtWyv5QUVe5A2nvBt5CsKUO+yPs1gBL3VBCYNOImu4kUfg
	 lTvDx9WkSOq4Aw2mQmoPjgEI4IbtQ8tCc79W3euk2B2qq++59xRL8WWN9VJhTfrQkqowx
	 +ckG7KJz55YQIpKeakNqJMq9OhCCeD2Q/Nw9dr2nkze1ZEjV0eEnoNbUYSCeaqhc+NSRz
	 yOWcSMahX4WWKWnAFedNBTAoF5JqeMjnBZa5/qtZy6Q3UoAzuEIckRP94BD6tpjO23A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792543906;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=yI3pSgUsR/VjQR0kAX8qRQynnGywSH7av7OgfPY1uXk=;
	b=jXdkh2vp3NQZckz4jZLUcH7/xfrRl6W6JjckUwDSE1fjOVe+wpmiy0xD+XGY/NT+A3hN
	 yetWPrFAdch1IjgRA/QHZ/QQiuvsuYVJtel5EvNDEi8vZhyfMxNR5csGpKLb5+EXX4CGn
	 uBZ/y9CWe3X45ufvyLL8u5eKEq7wvbnrmPDVc6VDNO9AaqNPx1gboVQrATPwZbmunHAzH
	 NBEyy7WEX1kEk8FIaS60bc+nm2xiAqr4Z8mkONHZ3lNhwh/fkgVyOF2bdenGV4BAHJhbc
	 GMdEPMeQKfXU/jIqtrJS8DncSvI3VIkboxHlrn3PZhkwivkoh2vLmDJpd9xaHcv3CIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=sJ21Mir+;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B9A606A31A;
	Wed, 21 Oct 2026 00:51:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06B9A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=sJ21Mir+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=yI3pSgUsR/VjQR0kAX8qRQynnGywSH7av7OgfPY1uXk=; b=sJ
	21Mir+ZhjSe0THW+iMT9DJjZvNlann5MaeYbi3uF7MELjEHQF8mN6cRKhYb2RAg3QSOG+NIK1tZLM
	Zl8tXQy8xUw3Eym64BgCslvAPM8nVvau0vbLpKIIBSztX54Qknl82cZ0IwEQ9jUqhzlTATmOpSpo0
	70f3BYWm8XiJy4A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xJKYM-00Bwt9-6k; Wed, 21 Oct 2026 02:51:38 +0200
Date: Wed, 21 Oct 2026 02:51:38 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev-bot+sinfo@kernel.org, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Christian Lamparter <chunkeey@googlemail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: emac: release DT PHY resources on teardown
Message-ID: <f4ef98dd-0621-4560-9267-5b8120f9bd20@lunn.ch>
References: <20261020223002.1749284-1-rosenp@gmail.com>
 <179253561146.3290.7437858872851210199@kernel.org>
 <CAKxU2N9cQjHtoKBLkoOjFQzbz9xzmMQ_UxvXB7g6yvVxK_YKwg@mail.gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKxU2N9cQjHtoKBLkoOjFQzbz9xzmMQ_UxvXB7g6yvVxK_YKwg@mail.gmail.com>

On Tue, Oct 20, 2026 at 03:37:57PM -0700, Rosen Penev wrote:
> On Tue, Oct 20, 2026 at 3:33 PM <netdev-bot+sinfo@kernel.org> wrote:
> >
> > Hi!
> >
> > This is an automated message. This series looks like a fix, but its
> > commit messages seem to be missing some information:
> >
> >  - How the issue was discovered, e.g. hit in production, hit during
> >    development, syzbot report, manual code inspection, LLM or static
> >    analysis tool scan.
> LLM

Ideally, you should learn from these emails, and put it into the
commit message.

       Andrew
