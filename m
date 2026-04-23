Received: from mail-4317.protonmail.ch (mail-4317.protonmail.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1911A23A6
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 08:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776933641; cv=none; b=UMzAguqg1DV/STIH4KC2ETYoC6MVNsQplHOR2ap+TET9frPBzuMKr4iIEv7I+v+6OEv3xbEBkq2ySU7neyfyFP2UodskVeAFR+xpfnLe2FPF04rR0/m/8cSrza91LQ1FLv5YxzHiANlRyP7l2aR1hQuJ8gjMEaDeOnp8K5U2cJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776933641; c=relaxed/simple;
	bh=F1zHL6A9kY1EbpiIa7b2qPRhPe4nM1+qtQYCVb08+rE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ca7zftmIbB/CPKZC91WdfYbN4UtjqH4SW52VkOGgPzMCZHx+H500RuYp5uCSaUlhAwVpvwbJk7K6Qo9+5ZbGDirTY5isXHYrq5DCb32JCRqt32EQBdEgvQFJL8mHBcdbXe2lvvi7kz01IUglwxKNCHnucXbhWpmW58ZHUqCxmJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leavitt.info; spf=pass smtp.mailfrom=leavitt.info; dkim=pass (2048-bit key) header.d=leavitt.info header.i=@leavitt.info header.b=sB1oYQCM; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leavitt.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leavitt.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leavitt.info header.i=@leavitt.info header.b="sB1oYQCM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leavitt.info;
	s=protonmail2; t=1776933635; x=1777192835;
	bh=fGdNDvIMSmYo0TLgMYF2iLQnDdqamGW0X3WpxsfTCX8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=sB1oYQCMMXu6wuNLvpmD39sBl2vz1BdB6I3KZdOhZwKjTexfURZ5T8lxbIeYrUuwD
	 SGcEnfcu5ixY2asKLqOaZl+sNO2S1lukvdztADeWyVBP7wTKKJLa9H0XzMQ/1SJla7
	 KImcFECLFyMb2rhPzU4a+M8edWaJmvz8/+f14K1zi1x1/+YVTyVhddGv1tK3dB269F
	 iCUaC2tgAzqbpxawFbaMTLAu10o/a49nybCklsYud73A0QWwoHDRJxHAUCi+iTnYmO
	 gdPPjR67gpIqSjFF++C1ib6fXW4lTMcNlH93pbnHBUv9SldCM0kiaFYH4lRqhBqGzB
	 e16CN5EXEP4tg==
Date: Thu, 23 Apr 2026 08:40:30 +0000
To: Oleksij Rempel <o.rempel@pengutronix.de>, Kory Maincent <kory.maincent@bootlin.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>
From: Corey Leavitt <corey@leavitt.info>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next 0/4] net: pse-pd: decouple controller lookup from MDIO probe
Message-ID: <177693362253.84762.6848519898058872632@leavitt.info>
In-Reply-To: <20260423-pse-notifier-decouple-v1-0-7d4856f686f6@leavitt.info>
References: <20260423-pse-notifier-decouple-v1-0-7d4856f686f6@leavitt.info>
Feedback-ID: 22087991:user:proton
X-Pm-Message-ID: 2857937825efa94d9a5fc03cd176f762008c1d6a
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Apologies for the noise -- this series was inadvertently sent twice. The
first send went out through an SMTP path that stripped the patatt
developer signature and re-encoded the bodies as quoted-printable.

Please disregard this thread and use the clean, signed copy as canonical:

  https://lore.kernel.org/netdev/20260423-pse-notifier-decouple-v1-0-86ed75=
0a9d62@leavitt.info/T/

Any v2 will land as a reply to that thread. Sorry for the extra inbox
traffic.

Thanks,
Corey

