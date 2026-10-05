Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6845F35E92F;
	Mon,  5 Oct 2026 09:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791192022; cv=pass; b=KXowPbIc87blY124zybP2P0UFrhfNtFh+OifXGv4TyPzM8agwJY8VYRc7YeHnU+iaq7o/PhAWwj7tZEVa7yM+RiBzRNUhdXB4sC4ToMKls+DVSL6qVKNdMCJm1WNXS4S9tNKlN2aFx4ZU60DlY1Y6W3Dpuz+OnH6pY80M7p7fzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791192022; c=relaxed/simple;
	bh=KacnfO9SH16HHjeaj4ZH2d7XhnanGBJQYrbJX1V++2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=drGscx0Qf4Xj3ua/oI7bsOWx62yezq4MCiGxAjBYvzbVV2N/5NG/EuRvINBr8DH2PzZMlcB8g34M0nlKN657hcmvcrx4z6h+atj5fVCFIRjH/EVzxm3gnq+Asqjrc0NQDE3yH58TuHludRCWhJixcw1ipPYZ4DQoYrxzWOcaGQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=RTp6c+mD; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="RTp6c+mD"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id D062B2004BB;
	Mon, 05 Oct 2026 11:20:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791192009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ss4QylMNSQGoq0x72rybiuk3RGdfXtdv9vZi3Q1MtGM=;
	b=RTp6c+mDm5K8NUTtoiJelQdm5oE/jv7vwoS6AmYoLbyRgjcxIe+nyPe9BKmAhUAnHg3s6c
	9RJ1PWQmA0COABcn2R/sWhHs3BGeHDLXuRmtjOvUQqctKk3FeV9ExY1lr3nvZUsTJHy5Dg
	ApG8FlgiRSKrvpPu0FIM/iAVNlhbyMwl6v8NfZzqUN2fu5PHlGOL4PxM7fcd0HNX1TZjv1
	oesJekuutUxDVu+/b3egTOeE+CxNlqYV6qpMQ9Aa39XA5yOv+uqvLHVyLZpqLJl/i0VBUc
	TjO9oedKwXwVV9DcGKKaeETbMD2ENJqAJKBKFuXL5KuoJjIQkAUgPN9WqjhPHA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791192009; a=rsa-sha256;
	cv=none;
	b=Atyo+gTOLV4jC11a/YINUOSx84heiD5gcN1d1Wa4SMlJ2jfHvXblMWPcX5R0RPVk9//UB6
	PYqvrZWSV43/62F8vYLDZB4OCx+2tbzxqjyljsd2Rft3G908B+1y4MxuRA3kxUbVJLaRQZ
	X9DjxbPSZZHcOCpp3CQR6Zv1+FRYDi8gkwf5rU8kt7D6XOJXMQBsEs0iie5t0hRP6hA3rZ
	k32azvMKOd1FcUBARjCJTHt+5LdI5nfH8Df7eIOPL/56WZKDif+Ls4J6S0iHbsxtyI7tT7
	zptAYpAn/JTgPM237qyubuHCgmBOCZKF5uouM7dHND3gqpmFdPffwPMmhmjVKw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791192009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ss4QylMNSQGoq0x72rybiuk3RGdfXtdv9vZi3Q1MtGM=;
	b=EnjltG2TRkyS/Xp/RiwsrlhiobWfJkNK1jilhEarZ7JHiivtBS7A/EaJhIK9etjFuCPHHz
	DTDEUwy8L4UgGcMdfDUN/2isrAwx5wjFOaYTNo95v5eN5sTSZDe+w8nd3zhjMRZMiLrHdj
	B6TIjr7WYOahNsyewyyOX/DExMJLggZa7eX+GjMK/hX8ejO/EOqB4twTMub+WyDkogOVSe
	HSe0FtWCrUmZU9VXYcxrBxKin5yq43XeZLgoVlGPWZULpfJkF5GJ0FIhDZwjfPLpD/4NUI
	UiOj7WyxnM1RFdJz5HwADmQ8GbbLYKHRYV3RqqP+dzhP0d0R0jm6c8lE9EsvOg==
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1xDerh-004MRY-2M;
	Mon, 05 Oct 2026 11:20:09 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1xDerh-0000000FHBo-2WCm;
	Mon, 05 Oct 2026 11:20:09 +0200
Date: Mon, 5 Oct 2026 11:20:09 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Carlo Szelinsky <github@szelinsky.de>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Corey Leavitt <corey@leavitt.info>,
	Jonas Jelonek <jelonek.jonas@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>, netdev-bot+sashiko@kernel.org,
	devicetree@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v7 0/5] net: pse-pd: decouple controller lookup
 from MDIO probe
Message-ID: <asNryalTQyUVwu4T@pengutronix.de>
References: <20260927191850.1370515-1-github@szelinsky.de>
 <20261004143351.969544-1-github@szelinsky.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261004143351.969544-1-github@szelinsky.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain

Hey Carlo,

On Sun, Oct 04, 2026 at 04:33:51PM +0200, Carlo Szelinsky wrote:
> Hey guys,
> One process question first. I do run an LLM review before posting, as
> maintainer-netdev.rst asks. I ran the review prompts (masoncl) locally 
> against a frontier model and still got a different set of findings than
> the bot reported here. If there is a better way to run it so the two 
> line up, I would be glad to hear it - right now I cannot tell whether 
> I am missing setup or just reading different output.

In my experience, review prompts are not enough. The limitations are the
agent and actual model which are running it. I personally already run
own sashiko instance backed with gemini API (the same variant as the
public generic sashiko). Since running sashiko is expensive, i run
multi agent claude setup [1], to stress pre-review patches before sashiko
round.

Netdev is now running own sashiko-netdev, which is running a multimodel
sashiko, which is even more expensive and finds even more things.
Privately I can't afford this.

[1] https://claude.com/blog/building-multi-agent-systems-when-and-how-to-use-them


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
