Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A592BE7DC
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 07:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770018991; cv=none; b=UWC1gt2+sB+eqd73+NoEyyiAmtmvy3mZrHjz0HZAxyRx9aoztxHnshJHBa/Z75zh7uMBk3cgwnS+Qc5lOQsMRSB+pnQzLcCcqcaeFxOqQ0Qv7+whvVDYe/l6z94Lhq5dT6XlUlrKjzVmeWn2EEbG59f0Xdb47XtbVf65QaE+BR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770018991; c=relaxed/simple;
	bh=nchdBZXNLi6jVZ7u6RO58+pyCkNf4bWSFjQWZd4W/AE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IShT1WbaXDZ++Fuf5xIT+Jc7T25yt2qhTQeG3OuviYQT62wOywx7K4rUqn5AxLLVtfFgg/+mtfrIzT6BK2fk7iO/3OLYlwSZ4fo22abqaf5Xs9+s2NASC/+ehQC4Mcs9E0OD88v4J59deymQuInIRF6nyh8dITbo5SD/OUlP8QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=vL463cxo; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="vL463cxo"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id EE5321A2B94;
	Mon,  2 Feb 2026 07:56:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BEFCE60767;
	Mon,  2 Feb 2026 07:56:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5D4A0119A8891;
	Mon,  2 Feb 2026 08:56:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770018985; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=DuCrnCOcQYVNXU3bhLaDSyIoMIusOApYWue7sfV4pqQ=;
	b=vL463cxobzZxL9deO4Lo4O3kEm2JHAVLHOdRANOXFPlwWhk5UExzmzWQdsJVplPlDcAhmB
	E8OHVuzNl1d5rA+/WtU/wePVxbCyzpRr1WIy/C69BsLsK6m0fR7T3CIYocHd0i9gX6ahnH
	81mK2bEtna8/bS3OzAxheqfFvAQcvhAKLxfl5l78agUHIcR+ZYodiDC9mFqEXuWh0hPHZq
	OeAUyrsaQUYFVuZDkuLM1PRbHbaX0dVgJSLP0yVZlqjwOVXg1QPMwe3J+hj4E2JhWKmmav
	E5NIHLQl98138RMFi+HaTdi0FLJiEtpREiBQZmfcOG1dqcTkX7VxiuYYQONq7Q==
Message-ID: <921c59ea-a3e5-439b-9a25-73374545a921@bootlin.com>
Date: Mon, 2 Feb 2026 08:56:17 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 00/11] net: phy_port: SFP modules
 representation and phy_port listing
To: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?Q?Nicol=C3=B2_Veronese?= <nicveronese@gmail.com>,
 Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
 Romain Gantois <romain.gantois@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>
References: <20260201151249.642015-1-maxime.chevallier@bootlin.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260201151249.642015-1-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 01/02/2026 16:12, Maxime Chevallier wrote:
> Hello everyone,
> 
> Here's V3 of the second phy_port series, this time bringing support for
> more phy_port use especially for SFP, as well as the begining of a
> ethnl uAPI.
> 

I saw there are some more AI reviews, I'll sift through these :)

Maxime

