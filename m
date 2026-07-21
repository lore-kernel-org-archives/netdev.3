Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF98446AF3B;
	Tue, 21 Jul 2026 12:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784636034; cv=none; b=kkNInfzK+kcgCgz00BtCH79YUYJatAgyb/idDsNOJnylkDRM9jSYbd3bqWsKZhvMAXv8w9fKN2oFqjMQ8pua84awxhzakD2hoAwYGd6reuYIHrJrt8fPMCOOTI/drsy2ZfyCyK1SnTQyfT3r6O7YmSMNbDdcnlHHCvx2TgHx1Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784636034; c=relaxed/simple;
	bh=qWy5XKAam/tjdvp8WYRRj8pUzIM6bQfnMv26CGYktYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cuHuReFQbKyVJP7wSgNs18bkUXKQTzuUIHGGPiBCMLuOMDUu9f9+M53hpDDhdlx+2PtN+4+ZR07g5/1GQpIyFgpTmfabU99Qlr2aE19gl4MKk2tsyx+yA5VvKWbmyjPCbmkHUHLinuLXXXCZQiJ931ehBw13mMQIfwuVkhe8VhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KNOrEGKt; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KNOrEGKt"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 1CB341A1135;
	Tue, 21 Jul 2026 12:13:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DBFF860368;
	Tue, 21 Jul 2026 12:13:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9EBB711BD03C7;
	Tue, 21 Jul 2026 14:13:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784636030; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=14fin0YJ6SbUZMWvdG1D118Ew6eotDwzI0Tc0US4E9Q=;
	b=KNOrEGKtxLIsxrLlPvS1FYZxFOUJo0JD4Rm0f6TKarf5otCJzqTg0rkTgkw4qA4htQ74e5
	mgp5B5leS/5DXS5vNpPJzs9HDsqJKhDFuxdeaTs54ny+f+f5jXE6xCnup3WGB2ok24W9wH
	Z281zliEgQPKjJahSp6yleLjMjUS3ZfJSb912htQUgrURiZYOr7Q/yc0jshujlBSYFyeBy
	H63BhN86EzTR9vhUShamL/uszBoQCA/wql29baaRhj2mJD17rhDxoqQMIldKSvuWJ2vBfy
	W+Tkdyxu0YKT/lLuYadc4zhXVk6WSJTig8T/yu1Blew/npJH2HH31hP7S/ybwg==
Message-ID: <8d81d5fd-7c22-4ada-83a2-b4c7ab1711e9@bootlin.com>
Date: Tue, 21 Jul 2026 14:13:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 09/12] net: phylink: add .pcs_link_down PCS OP
To: Christian Marangi <ansuelsmth@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Saravana Kannan <saravanak@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20260717065448.1498335-1-ansuelsmth@gmail.com>
 <20260717065448.1498335-10-ansuelsmth@gmail.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260717065448.1498335-10-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 7/17/26 08:54, Christian Marangi wrote:
> Permit for PCS driver to define specific operation to tear down the link
> between the MAC and the PCS.
> 
> This might be needed for some PCS that reset counter or require special
> reset to correctly work if the link needs to be restored later.
> 
> On phylink_link_down() call, the additional phylink_pcs_link_down() will
> be called after .mac_link_down to tear down the link.
> 
> PCS driver will need to define .pcs_link_down to make use of this.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

[...]

>  
> +/**
> + * pcs_link_up() - tear down link between MAC and PCS
      ^^^^^^^^^^^
should be pcs_link_down() :)

With this fixed,

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime
