Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F59C2D3EEB
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 13:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787059100; cv=none; b=L9mxkFHqgbUdoHd+oMeEKI1ZlBvE/gAGh4lldVFPnJxXjh78vAIbOHWynLWUaUZ5e2ssxbPGrDdQBTLlp0vxWssPFKgNCkyclXCdKdMDxg+VHFE/cmilS8gJqplg+Z0m5V4+G9SNxhQxdHSQzAcqqT38jY1hgNjCZa6MQTpwobE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787059100; c=relaxed/simple;
	bh=CF1mZqMaZMqYn0qXlWTLeGROWbC6u3H4657H0AarfLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dgVvb6/VDyOVNE/ru22kRxreua6I4dseO5wV+mTnrtsqNClyX69zKHZtWwSRYO01KVQqbycWf8URITTeBY4TyoMdnx/F4qhMHeCufo6hFfVAJmsMt0vre/piAVFP2QUahNfJ2UR/Br8bjZKTrZa9aNfbbc8Ani4nopi6zNmZ9oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=qq1eXQUE; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="qq1eXQUE"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id A12554E412AC;
	Tue, 18 Aug 2026 13:18:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6CFE360355;
	Tue, 18 Aug 2026 13:18:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0E5B711C70533;
	Tue, 18 Aug 2026 15:18:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787059090; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=Q1iitrFjvdi42Or4d3ywCF0+ZJg8zV+6fPYVVcS8aGY=;
	b=qq1eXQUEKC52qBr3qFHvzMNEQEGztnsyKRL/CzpSS/KxAYODNFKYf2ID2hKYwSr8lREiSR
	9/Iss+Le00ekXqcU4BPu6s/3TqUOsci5+69bctvN8u+Nw4N8/R1fTy2o9lpGfYFMG8Rrgk
	OCPrCfaf2XnDTo0JS7IOtoXbQd5AX9s2o3ZW/rm618HdernRokywcTuuCeHwqIbyafWcNp
	9v96FKAD+WH7mZD7+DRyHUuM97lGCaF+8bevthetrP2PfFZkZKdn4MiCzMoTFOGT7650/r
	LAPZuSXjuE/ePWRx6p9+wdzfyVj8YohckwK7ylRJRMUl9jzTG/ff6jW7pQ0Ghw==
Message-ID: <48761981-fd4d-4cd6-b4e3-cb575bb34349@bootlin.com>
Date: Tue, 18 Aug 2026 15:18:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH net v3 3/3] net: pse-pd: unregister from the controller
 list before freeing PI data
To: Carlo Szelinsky <github@szelinsky.de>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jonas Jelonek <jelonek.jonas@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260813200653.980170-1-github@szelinsky.de>
 <20260813200653.980170-4-github@szelinsky.de>
From: Kory Maincent <kory.maincent@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260813200653.980170-4-github@szelinsky.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3



On 8/13/26 22:06, Carlo Szelinsky wrote:
> pse_controller_unregister() frees the PI array with pse_release_pis()
> while the controller is still linked on pse_controller_list, and only
> removes it from the list afterwards. A concurrent consumer probe running
> of_pse_control_get() walks that list under pse_list_mutex and calls
> of_pse_match_pi(), which dereferences pcdev->pi[i].np. If the walk lands
> on a controller that is being torn down, it reads the freed (with the
> previous patch, NULLed) PI array.
> 
> Move the list_del() ahead of pse_release_pis(). Both the lookup and the
> removal serialise on pse_list_mutex, so once the controller is unlinked
> no new lookup can reach it, and any lookup already in progress holds the
> mutex and has matched against a live pi before the free can run. No NULL
> checks are needed on the lookup path.
> 
> Fixes: 9be9567a7c59 ("net: pse-pd: Add support for PSE PIs")
> Signed-off-by: Carlo Szelinsky <github@szelinsky.de>

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

