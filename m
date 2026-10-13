Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C123D34BB;
	Tue, 13 Oct 2026 09:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791883082; cv=none; b=EIs31/pzKcpmLImkZAj1xApm5pBu0OFGzaVZbi8K3V/ixRNTqyp1V0iXiCRmqCNBRQqJTBdzVOE6dCfa1h9NuSwHRfikte9BNacuLu8Kp7G251hKoIOujEhk9i7LIi8IcNj8MtPkQepLnorsQTk4CPFBc+Tn2e7qFP2MzIu2IRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791883082; c=relaxed/simple;
	bh=fyiBIYufyxIi6uzpiUG2QI9MCRYC48F9PmNixrginhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jq3Doqg3v9KQiMZAiH71U7IvJpGosT98wxC7z7Gcm4FB9JuzYxvGMf61qOHmS4XUnxkbeKw/RWgaGfUKemv/Grkl/wNHI2gDyS3qmaIWHpJWA7aPtPoyG6H1eCoOsqyD87vSSDEg7cjD6F8FTjt5TX2jK3KoMCla+p3l9cDQ0zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=CgKxtx9C; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="CgKxtx9C"
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 564CEE83923;
	Tue, 13 Oct 2026 11:09:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1791882576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9K0x8EVXp6dfLdQLW5fnQazXsB8eueO8FRPfzur9aNQ=;
	b=CgKxtx9Cjze85ZEaaZ/YL6WsPwa16tUT091w/hcONgdM4To10kuo3E3zOGAoht7eo6vNXa
	QzKIlEqM8N5q8cJFhbubjS8WFCsFKlS3KmL/sZvi7f71T9QzwX4F+mqEexK62b8oiVUEvk
	QM19wGVszk0GoMgXatYeE3fKlNBAVoucC+IV9sDc+0CzPjvNwRJ0GqLPja+8EFrWRQ7xGU
	y3hFvJDpT5JQlbdqPnL71yMTksgoC9dcQP9fIoLWq87BN6tnlQJK4IpHPEuw/j79EwmYWP
	5aLTPxMCcXPwcfHm0iOCZ22x1xuBYCO67TPeuXu/zNslObvSU28eH7PcSsdIwA==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id Wh2ZjR5lJGPj; Tue, 13 Oct 2026 11:09:36 +0200 (CEST)
Received: from p14sgen5.lan (86-103-67-208.ip.tng.de [86.103.67.208])
	by szelinsky.de (Postfix) with ESMTPSA;
	Tue, 13 Oct 2026 11:09:35 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>
Cc: Corey Leavitt <corey@leavitt.info>,
	Jonas Jelonek <jelonek.jonas@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	netdev-bot+sashiko@kernel.org,
	sashiko-bot@kernel.org,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v8 0/7] net: pse-pd: decouple controller lookup from MDIO probe
Date: Tue, 13 Oct 2026 11:09:33 +0200
Message-ID: <20261013090933.3552546-1-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <e70bea49-c18a-4d47-9cf5-fd7b8e7675cc@bootlin.com>
References: <e70bea49-c18a-4d47-9cf5-fd7b8e7675cc@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/13/26 10:39, Kory Maincent wrote:
> On 10/13/26 09:40, Paolo Abeni wrote:
>> @Carlo: you should always reply to the AI review, even to point out
>> previous discussion on the same point. And you should try to be more
>> concise (even in the cover latter, should a repost be needed).
>
> Indeed, the cover letter should be more concise. It's hard to read like 
> that.

Hi Köry, hi Paolo,

Thanks for the feedback. I will reply to the AI review points and make
the cover letter shorter.

I am already working on v9, because some of the AI findings are real.
So if you don't mind, you may want to wait for v9 before reviewing.

Thanks,
Carlo
