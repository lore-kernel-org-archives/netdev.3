Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411C64052A1
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 09:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786526530; cv=none; b=L4FbSrT9Orp91URYTiqbYsad8aUVB8relYZVJBGZHrf113z+ipEbHUVW6QVvXlw5mYYmFyoffdqIvfJwgSHXI7S2DlTIR8rozVKZJaWWIGs+k5LtocWtw6BCKER8Iab4wLraYQAyoapvl+zOArWiu5pD24Q8pmrOAVh9FyC6yM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786526530; c=relaxed/simple;
	bh=u/j7lOinK5cSS1WYkeYpBZ9uCTsskMNH0NAE2fhQE2o=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J9J3bYqAuywIv+ciE0mIHcqy37aXXYggQaTxeVkivhfKZBXQS/+Vkcf3b7RJIFhynLKN+Qhvoai692DQv72uqQjxY/pm7cnqyUMADckUHkI35jj/0JUfuljbcW4cid5O1PIsGarXBEtbNAxty644B1pJ/MgQQhVZjIEt51z8m7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HK14FQ0p; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HK14FQ0p"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4957eefd361so5187135e9.1
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 02:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786526527; x=1787131327; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:subject:cc:to:from:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=99ZRp8GGXEz732+HjUTBizNYKi5BfYbbcdnZB1/nF7Q=;
        b=HK14FQ0p/K2MgJ3XEC9EkDCSwyWnvIRmS4t2DubAEF7BW58J2uRt+3wdThK12v8BoV
         ohK55/gcHPuvk2zKrVpcwi8ELMZQwPi473VZtMl/ZjsK/lIAnpQVWTuHcjb5QSCKxXgk
         JoAgRC38rI/nlwr/3E2dFMZbR0gdxjOjJsf+/jm8P0jlR85BSCFVwsRwRAtGy1ZpC5Wn
         zkM7HmKYqAf6RpbEM2zJtm9X0Ktnx3yJxbhLzvLOK7yYbhonExRo8EjpCQkjaUrpiRlQ
         H7xg3nHW3tCbFkN+uE7vfW/i3n82iguhUkMHSUIis/yP4TY6dmm6JgYeQU7NARHOnrQI
         bXWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786526527; x=1787131327;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:subject:cc:to:from:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=99ZRp8GGXEz732+HjUTBizNYKi5BfYbbcdnZB1/nF7Q=;
        b=EhqAtJU1ZgxLkOnE+rAZNn8HbWI2l+ZZrK5fMOgwkyj1gBIlo04jlHhuvRHAzwxeCv
         +83nZif69ZDq0Ena5oguRfdSzmKJaFh8FAljMYYANScH90/kxk+IFK/j1xdcXPelmSBu
         aSkoaCxlKfucmOjgTPyPf5E4uVGiLn4bIUyAltHnriliW+Bt3oDXBItuuPq6MSXJ7W8a
         s3LJ4iHAM91+Tcz9TYn5eKg5uJPnxGr1EDnzEHqm2IcWfz14LoIFMTeomwrYyd4WEzD8
         N7M2J9CgCT/GICpT/wSsCdVkBjlihR5yupc1Ic0agBHPgp7B5i7ZuNeHOCV6L0DvLPPT
         CItg==
X-Forwarded-Encrypted: i=1; AHgh+RoR5pGc3ujsbZtlQgVX8cnB8rtxkqtY2Z0dvErU1BrOdYK3ehseOgRKQ7boe7XvLPTAAj8DFrY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy99N4oSG21p4bTtfP8/FnbL/JWla78dLMu+m8YT5/f//zqxo+e
	BrULWuChtky7vDxRAOLzUPLqaGTfwpJylcRPEIXbO54aBibHj3AslGOr
X-Gm-Gg: AR+sD12RqyQH19Eg+wsmCJkjv/Ov6J2SXGb9tidHZi0zdWy2dQ/iyKM/knoVN3U8r6j
	0Im5CiHoHuoZV6X5lTeSRL+r4vjFfXqxrupI65OUS+od+bpnTSPYRHSKwppBzMB0UqMzeq6KP4u
	l2TBcNMNNCNBwUONVgydq+ZkG0xfCW2ku4iIcNoaWtsMxswNLfeZkvetcmco1egDmwBU5PUWQ7o
	9y4W6/UCQrOz2FbRGzd7dk0L8PpawkTLggoGgTIBBoc3teOcNlFOnRGl3wfhVY+3p+Tb9WSKSG0
	ING6yHMAb6KsjKOoJCH60cZ7GZRHBKii50VspoHokYqEn3qgsASTjm5T526L17cZcYGs76Uzc+6
	HcbJrdPwod2bv0L8F15aI2Rp2pHOFO0qVC1F+RkhTaTKvCsUnrZpLRe/q+jQKCgGYl46/ReXBpr
	bjmrKQHo/UE9iEQBOQE2BLcNneLKktLgidf05B4HRKqNVUfnZ+s7tff71kPrMQuci1vB+C+gUOF
	4nrDiBBuqEaeBZXQcnczanITZDgCeY=
X-Received: by 2002:a05:600c:4585:b0:498:8e6:d464 with SMTP id 5b1f17b1804b1-4997c15bc25mr36076835e9.14.1786526527288;
        Wed, 12 Aug 2026 02:22:07 -0700 (PDT)
Received: from Ansuel-XPS. (host-87-20-3-207.retail.telecomitalia.it. [87.20.3.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997b33e038sm32231495e9.4.2026.08.12.02.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 02:22:06 -0700 (PDT)
Message-ID: <6a7c3b3e.e9cff95d.4a93a.554d@mx.google.com>
X-Google-Original-Message-ID: <anw7Og8rtVQ_hQtT@Ansuel-XPS.>
Date: Wed, 12 Aug 2026 11:22:02 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: dsa: qca8k: Disable mgmt Ethernet for qca8327
References: <20260810061612.23745-1-kernel@kempniu.pl>
 <6a79d7fa.ebbd881c.2cd61f.2e0d@mx.google.com>
 <anw5dJ0EqBJtAqRU@larwa.hq.kempniu.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <anw5dJ0EqBJtAqRU@larwa.hq.kempniu.pl>

On Wed, Aug 12, 2026 at 11:14:28AM +0200, Michał Kępień wrote:
> > > I came across this while migrating an AR9344-based router with a QCA8327
> > > rev. 4 switch to a DSA-aware driver.  This glitch is a pain in the neck
> > > to troubleshoot any further as it occurs randomly, anywhere between a
> > > minute to an hour after the switch is set up; traffic load exerted on
> > > the switch does not seem to matter as the problem can be triggered on a
> > > virtually idle device.  Previously working links are reported as going
> > > down (one by one, not all at once), even though port LEDs still blink;
> > > no traffic is forwarded; reloading qca8k does not alleviate the problem,
> > > only power cycling seems to help.  Nothing like this happens when only
> > > MDIO is used.  However, qca8k currently only uses MDIO as a fallback.  I
> > > figured that simpler is better and that mgmt Ethernet should simply be
> > > disabled for the qca8327, but I would be happy to work on some
> > > configurable solution if that would be preferable.
> > >
> > 
> > This is a long standing issue and it seems to me disabling mgmt is just a
> > big workaround to a real problem.
> 
> Understood.  Is it a long-standing issue for the QCA mgmt Ethernet code
> in general or for a specific subset of switches (or devices)?
>

specific subset of switches. On ipq806x the 8337 is mounted and mgmt works
correctly without issue.

One thing I notice on a different vendor (Airoha) is that sometimes using
these indirect way to access the Switch register might introduce
interesting HW bug.

One bug that was there was that when PBUS was used to access single port
PHY register (instead of direct MDIO) the link up/down was broken. My
theory was that the Switch chip had some latch logic that was only
triggered with MDIO. Using PBUS didn't trigger such thing.

Could be that the QCA 8327 switch also have some kind of HW bug where specific
register needs to go with MDIO or some refresh/latch logic are not
correctly triggered.

An idea might be to limit the mgmt to vlan and fdb and see if the problem
is still there. (after all those are the path where mgmt would benefit due
to the multiple register access required)
 
> > Long time ago it was reported that there seems to be a problem with the
> > mdio master register for external and internall access and how mgmt was
> > actually sending mdio command... just done by the switch. Could the 2 issue
> > related?
> 
> This thread?
> 
> https://lore.kernel.org/netdev/20250425151309.30493-1-kabel@kernel.org/
> 
> If so, that was for QCA8337, on a board where the external MDIO bus has
> an extra PHY attached, so it did not look like a match for my case.  Of
> course, it _might_ be related to the issue I'm running into, it just did
> not seem to be at first glance.
> 
> > One idea might be to verify that stuff gets actually written... as Andrew
> > said to verify if some packets doesn't get lost or just ignored.
> 
> Ack.
> 
> > Also as Andrew said I would still save this for the MIB part as the 2 thing
> > should be unrelated.
> 
> Got it, I'll play around with it and see what I can find out, thanks.
> 
> -- 
> Best regards,
> Michał Kępień

-- 
	Ansuel
