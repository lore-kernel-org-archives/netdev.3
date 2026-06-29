Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1310B33A6E9
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 14:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782742412; cv=none; b=NE4Vc4MZ18KZxsCQRpy64SNHCV4WR+5wIGW00jAzizjR/o9X+dl5wTsmJ38r1QnrhwIpku1TDC0l+qQOBtMD2p9VVrutRQ5TuQyjsuNXV+KPPEP0x3l5iVDLjGwe267P/SGhzCMDUp6c0VwN7woDNK1va8QhxALsAE6hZqOD+bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782742412; c=relaxed/simple;
	bh=n2moP8sJR9BhHMurE5j8uV8hEciqqJxPDOsyZT57eT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=co8VR+9J7zpfCE1rQjkCE7GNmPgDj/Qu2aAI5zsFMw1RMTnBGJ/sGvPOGtO1epsrjWlnulg9wSqxHuav33lB2L9Cms+g7KCwprssP11hXd0FXfu684bdLdOgZbJR1InRYabQjBcMJekUQhW53TkVc/x/jFeajvmzlTeuYK1kc+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fe0zJ3MI; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fe0zJ3MI"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47231f1f8f3so2487236f8f.1
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 07:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782742407; x=1783347207; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xeFfaIaYuJ4MPfGng2mUHQKnK1lD+x40upFL0+GBvfo=;
        b=Fe0zJ3MIZdeG79AwrWUFe0XWL+XHBFIxSZYDhE+SSYicAyxUvDR7p9KtJAT3Iv3LKo
         mfeyHP7tMNJ1iuhhtq16POCERc6tF5KSPDqqWJc7gO5gqsNymfxa9XYjTq+m3IfkNmC0
         c4R+/kJRsyK7L4zdXGIN19DsdqSxHr2VtQUy+YjaPgauim7kuT6SKugvaQwiy4QNSzxD
         MkA23GUiOMNSv3Ef8NNvn2mVJAMti442+FAq9K1Owhc4MuRDcH/QMkUWCwDMHPufOygd
         BlRDrOCNAzBFuMQjgXJ5+HPOg8aWe323XQlD5fviatKe/2ANyYOyuDjn/nb4t7x1phH1
         2hFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782742407; x=1783347207;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xeFfaIaYuJ4MPfGng2mUHQKnK1lD+x40upFL0+GBvfo=;
        b=Tv5jzDiRUgbthhA5dwF9oSAwxywjDnT2ziG/tZvLjs8HSUpOQDtZQvB4TF9aNH8PbK
         XxrlpGFW0dv41qqnH12nkba6E2v4W8gAiv/hXLAcLAHXQf+cCkBx2gjF+KLxfv/reccL
         OWhmvQdoh7IFWPb2Y2sr1s2l0WLdueAijLj5QEO6evstsIVSoIQ9RF0l7+t3rtgiglM/
         Db+SjsIYlDOQsTRwRNZbTu53NSrTqn3yIdz/h29OCbZD2Gfk1029hqgm7p7dZfDhshrk
         ueUkhyEFOqpNs+xy4rTYu2U6icqC/NLpSa51qwfdEXrjmLLUmOQbrdx3n/jnZ5wvTU7K
         gnkA==
X-Forwarded-Encrypted: i=1; AFNElJ85mudmoudd+THYq8uCiQbrjKh8uCAar96vVpxcN7RXIEznQfIDvlc/tLLbA0ZRHqFg8gx6jFE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv1UdX0UtIFIc6y/HZBl9MVLcP2mH5cdSdAS+Brp83X+A/InVC
	1PGMsxYILu30ml7mYBbkGscCtvI3L5wYilKuFOtkucpX1EQNchbcGvst
X-Gm-Gg: AfdE7cmBk+DpnKaTsOTfEgC/fGTLpS0qFj4RnklZihtgCKT/pR5Uj6FIm7h3uwhX/K3
	O4WFsO+AM2nHCJyxOmypIxfOUVKZYcKUQGsNljE79QDFaGWzwPdToq3tSUZv/LlnkaUgCGgA+7p
	oBhBrog1GLSqmCIdWi/xqJ3SC2e46wqiWvl9KaYBGyFuJ1BeJJLITRiZe5yXAT9Rlp4I+MBjUsm
	Q6nRxC4IkqToQ17vbZzjrpvhXrQrtEH4q3dtj3veEclnX46sWsoqThRgwTQuozmAa/qIljv3eNz
	OIpSdeE6+zSr7Zysgunq91C3rVBdVQOItfnz5VgtmBupOR9LXrsNeH8pBlQACu4PAiruiW+deMg
	69g3mYtFPh1ruEZ2CztDV7BQ9zvPzTh8hMHqk94mM67qr+HsV3L1zNTq4RnGBmlBRo9QYldQG9F
	awSFiWRx5IMfAWpQhAz2pEQM3WiKlsiOAMoi6/a5W0cWOE24nU
X-Received: by 2002:a05:600c:a086:b0:492:6954:1036 with SMTP id 5b1f17b1804b1-49269541111mr229190765e9.14.1782742406763;
        Mon, 29 Jun 2026 07:13:26 -0700 (PDT)
Received: from eldamar.lan (c-82-192-247-196.customer.ggaweb.ch. [82.192.247.196])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47290ed4377sm16140004f8f.37.2026.06.29.07.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 07:13:25 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 026AFBE2DE0; Mon, 29 Jun 2026 16:13:24 +0200 (CEST)
Date: Mon, 29 Jun 2026 16:13:23 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Wongi Lee <qw3rtyp0@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jungwoo Lee <jwlee2217@gmail.com>
Subject: Re: Please apply 736b380e28d0 and eca856950f7c down to 6.1.y
Message-ID: <akJ9gzZrhXMUomcg@eldamar.lan>
References: <ajuR7rZYU943EG6p@DESKTOP-19IMU7U.localdomain>
 <2026062417-conceal-driving-0ebd@gregkh>
 <ajujm9+82N1g/HgF@DESKTOP-19IMU7U.localdomain>
 <2026062416-amulet-paradox-cf7c@gregkh>
 <ajum4HXbhgdRl6Vz@DESKTOP-19IMU7U.localdomain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajum4HXbhgdRl6Vz@DESKTOP-19IMU7U.localdomain>

Hi Greg,

On Wed, Jun 24, 2026 at 06:44:00PM +0900, Wongi Lee wrote:
> On Wed, Jun 24, 2026 at 11:37:29AM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Jun 24, 2026 at 06:30:03PM +0900, Wongi Lee wrote:
> > > On Wed, Jun 24, 2026 at 11:00:45AM +0200, Greg Kroah-Hartman wrote:
> > > > On Wed, Jun 24, 2026 at 05:14:38PM +0900, Wongi Lee wrote:
> > > > > Hi,
> > > > > 
> > > > > Could the following upstream commits be queued for the active stable
> > > > > trees?
> > > > > 
> > > > >   commit 736b380e28d0480c7bc3e022f1950f31fe53a7c5
> > > > >   ("ipv6: account for fraggap on the paged allocation path")
> > > > 
> > > > I do not see that commit id in Linus's tree, are you sure it is correct?
> > > > 
> > > > >   commit eca856950f7cb1a221e02b99d758409f2c5cec42
> > > > >   ("ipv4: account for fraggap on the paged allocation path")
> > > > 
> > > > Same here, no id of that one in Linus's tree that I can see.
> > > > 
> > > > thanks,
> > > > 
> > > > greg k-h
> > > 
> > > 
> > > Hi Greg,
> > > 
> > > First, sorry for confusing you.
> > > 
> > > The commit IDs are from netdev/net.git:
> > > 
> > >   736b380e28d0480c7bc3e022f1950f31fe53a7c5
> > >   https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=736b380e28d0
> > > 
> > >   eca856950f7cb1a221e02b99d758409f2c5cec42
> > >   https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=eca856950f7c
> > > 
> > > They were applied to netdev without Cc: stable@vger.kernel.org, so I
> > > wanted to flag them for stable handling but I send it too fast (before
> > > merge).
> > > 
> > > I will resend the request with the Linus tree commit ID.
> > 
> > They have to be in Linus's tree, before we can take them in a stable
> > release, right?
> > 
> > And why were they not originally tagged with the cc: stable?  That would
> > save you time in the future as it would all just happen automatically.
> > 
> > thanks,
> > 
> > greg k-h
> 
> Right, my fault.
> 
> Also I just forgot cc'ing stable when sending it. I'll apply it next time.

Small heads-up: Both commits are now in Linus' tree and included in
v7.2-rc1:

$ git describe --contains 736b380e28d0480c7bc3e022f1950f31fe53a7c5
v7.2-rc1~29^2~66^2
$ git describe --contains eca856950f7cb1a221e02b99d758409f2c5cec42
v7.2-rc1~29^2~66^2~1

Can you queue those as needed down to the 6.1.y stable series?

Thank you already,
Regards,
Salvatore
