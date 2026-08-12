Received: from sender-op-o19.zoho.eu (sender-op-o19.zoho.eu [136.143.169.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F90320A00
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 09:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786526096; cv=pass; b=ZijW72kuOiyL+aFR8QGJzNmyh3SvswTE0ZcqGfyV0iobVIfjaqk8t9Tc+1ZXViuy2WLUJoNC6xiZhszQrzxfX89d6zptlcseML+Owoir5lIbmEnGp3RQNULGnfssTmNOP25mFiQc7X2NkqdC+sJ9GOrh9w6uD/FBHxgo9rA2cjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786526096; c=relaxed/simple;
	bh=mkIpjpgvlKjAyaTP1h2u4NrgYY5I5j56f8N6CoqZac4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RtdiXa3CYsKjHjQFALM4Gt0Eno7HiMFchhx3RMjOAjwRnNFkPb3h7IF2Mixl8khHGhBQD9ULO8kqb/sf4HbwUjqpL9xgQvq4gNGqEkWtYvVFSOQOHv92zpLO6hUn+CujC6isbfmxXlDLnOEzvAOd41URrvdZ1tAj4Cw9cxmNXL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kempniu.pl; spf=pass smtp.mailfrom=kempniu.pl; dkim=pass (1024-bit key) header.d=kempniu.pl header.i=kernel@kempniu.pl header.b=EUfBqACc; arc=pass smtp.client-ip=136.143.169.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kempniu.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kempniu.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kempniu.pl header.i=kernel@kempniu.pl header.b="EUfBqACc"
ARC-Seal: i=1; a=rsa-sha256; t=1786526070; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=HrGBxVOAi0LFaaVoC0/RloX5znU49bWOZAjlWsUzpuwCLLDro/RUf4yVI5cshiZv0ovYQIGEGOxMXR3rwS5OdBkqzx/Li02c1XaAlyVbbMNd3a+kbVOvkGZbU6VDnor4z4J3ZM+719kKsfhG8Vw+b0yBSBAtDyLKtfBTmdXlu64=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1786526070; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=wfnAKLpouQnydNE4ViqffFeGkwazkUQQXhBWuh7gaQI=; 
	b=Ahjz1AOXeGGGtiay2tiTCglmvGY3AAJEUsSzJmhFICopTNcqHoaRskBoFUc8uz88RMLAZtrcauWMG8EVX0x9V4jDeNpTUI0D76GMZRBWq7mXjYEBlyPgxiql2nozfFUCCG7MRtJoo7dzu0F/tfdXk0pzfrARdWvqywoXW5LILkE=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=kempniu.pl;
	spf=pass  smtp.mailfrom=kernel@kempniu.pl;
	dmarc=pass header.from=<kernel@kempniu.pl>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786526070;
	s=zmail; d=kempniu.pl; i=kernel@kempniu.pl;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
	bh=wfnAKLpouQnydNE4ViqffFeGkwazkUQQXhBWuh7gaQI=;
	b=EUfBqACcih7xzyhNM+garmjk/Z5+5Eq0B/x4mlLeJDr7eihxo2AFL4RsHxinAVpP
	MzCO5kTbzdrhTFx7StzDpBrckRKxeh/UJJ6//7u6qZ/1Ef+kbn3Q5a54p3jTAmka2qo
	Km86OLq4qHp5kXwjjuNjezpmOm5kIWUjbzoXtCCg=
Received: by mx.zoho.eu with SMTPS id 1786526069423918.8227640785118;
	Wed, 12 Aug 2026 11:14:29 +0200 (CEST)
Date: Wed, 12 Aug 2026 11:14:28 +0200
From: =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: dsa: qca8k: Disable mgmt Ethernet for qca8327
Message-ID: <anw5dJ0EqBJtAqRU@larwa.hq.kempniu.pl>
References: <20260810061612.23745-1-kernel@kempniu.pl>
 <6a79d7fa.ebbd881c.2cd61f.2e0d@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6a79d7fa.ebbd881c.2cd61f.2e0d@mx.google.com>
X-ZM-MESSAGEID: 1786525529505015800
X-ZohoMail-Sender: =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?=
X-ZM-MESSAGEID: 1786525929063015800
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.11.1.5.2/286.510.57
X-ZohoMailClient: External

> > I came across this while migrating an AR9344-based router with a QCA8327
> > rev. 4 switch to a DSA-aware driver.  This glitch is a pain in the neck
> > to troubleshoot any further as it occurs randomly, anywhere between a
> > minute to an hour after the switch is set up; traffic load exerted on
> > the switch does not seem to matter as the problem can be triggered on a
> > virtually idle device.  Previously working links are reported as going
> > down (one by one, not all at once), even though port LEDs still blink;
> > no traffic is forwarded; reloading qca8k does not alleviate the problem,
> > only power cycling seems to help.  Nothing like this happens when only
> > MDIO is used.  However, qca8k currently only uses MDIO as a fallback.  I
> > figured that simpler is better and that mgmt Ethernet should simply be
> > disabled for the qca8327, but I would be happy to work on some
> > configurable solution if that would be preferable.
> >
> 
> This is a long standing issue and it seems to me disabling mgmt is just a
> big workaround to a real problem.

Understood.  Is it a long-standing issue for the QCA mgmt Ethernet code
in general or for a specific subset of switches (or devices)?

> Long time ago it was reported that there seems to be a problem with the
> mdio master register for external and internall access and how mgmt was
> actually sending mdio command... just done by the switch. Could the 2 issue
> related?

This thread?

https://lore.kernel.org/netdev/20250425151309.30493-1-kabel@kernel.org/

If so, that was for QCA8337, on a board where the external MDIO bus has
an extra PHY attached, so it did not look like a match for my case.  Of
course, it _might_ be related to the issue I'm running into, it just did
not seem to be at first glance.

> One idea might be to verify that stuff gets actually written... as Andrew
> said to verify if some packets doesn't get lost or just ignored.

Ack.

> Also as Andrew said I would still save this for the MIB part as the 2 thing
> should be unrelated.

Got it, I'll play around with it and see what I can find out, thanks.

-- 
Best regards,
Michał Kępień
