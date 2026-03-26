Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B0E1A3029
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 07:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774510735; cv=none; b=KpQ8Vn07b92MPt+VFrfbPDoeQxk597AT6VpZBJodMlOcJmBNtwBsDoeC3Ud0XTQp17z83dHBwludF00M6OY1B/YD0Vd/ev32h80wj1uQPSsheHh9/onJkmS9Orm+1PTkp3isvLyF0FYQbvmrTSuuqEmsA+nVob9v1uu56YanXHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774510735; c=relaxed/simple;
	bh=R3wbXgK2r8UzgrCyD7t5lRhw2OhPhOtemTvhLLUTItg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aNdRqxEjv153D7nv755J0qnZ1scouIBKqQshrgoz3W7DvbwIsf2yg5Pv+5TsPv/jN8JTyU6CoIqOsW1x7EwIqv69/cO7wE4SSAx8w4rT/Uy/5/iGlyJ1WLAXEqTAsR1jxmFjoPkd1zxTK4otjDwNlBCa2IvqkUnJTbOoRpHhAOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dx1mxg19; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dx1mxg19"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id D4C324E42801;
	Thu, 26 Mar 2026 07:38:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9A30B5FDEB;
	Thu, 26 Mar 2026 07:38:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1730D1045120B;
	Thu, 26 Mar 2026 08:38:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774510729; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=jj3IUh9R4W8+zkoV9vgo47YT8g/4LpTWBqx1PXl+Xuo=;
	b=dx1mxg19tKD42CdR/2YaBJLf7Dr7Fe8A7WsqqtMLBf/vZtK80OAm5Pyjs0aChk3h0Gt1Z7
	SojNhPAdTawdHI+A61XZO8Sf7qSYBxkK+KtMSJJuFjlhzaU7pIciS+fYgpACK7+0S5gK4e
	ZHR0SvQMyICsJ/DVLsjG6QD7JFk1RNLfe2wXVaW500om5NxSsKvJY3BDUROV4g6nFyMZji
	s3tPdWPC4wmX59nJEVTGfXi5AjVssF/xG+WhagOb1GqIwHxbmOI/LmaAmvoNtZcOZB4exq
	5/FNmmAGBUJlp2oyDhgvelvms6ybZx2Mjv1goCN484gu3+BwlnWLEyNudaD9PA==
Message-ID: <2f496443-ea0a-425d-9c83-fb9c33a106fa@bootlin.com>
Date: Thu, 26 Mar 2026 08:38:45 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: phylink: use phylink_expects_phy() in
 phylink_fwnode_phy_connect()
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
References: <E1w4zHg-0000000DmC4-2oyb@rmk-PC.armlinux.org.uk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <E1w4zHg-0000000DmC4-2oyb@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 24/03/2026 11:46, Russell King (Oracle) wrote:
> The tests in phylink_expects_phy() and phylink_fwnode_phy_connect() are
> identical (by intention). Use phylink_expects_phy() to decide whether
> to ignore a call to phylink_fwnode_phy_connect().
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime


