Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25A531E82B
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 06:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784617068; cv=none; b=twj1kBCnWrFpf2TaJwHIZnmBxAp40udUKxrjtMa7j0/kbLMs+y0LBhTl4C3+Rj/yQOaXyYpWasXiDDa7UFqp6hhLtzkZGSX+gZyTEX17ZYYBJ3A7/W0dmDUPu7XJsIQ7l2d8CdZ4jHFDGHXLodErQ4dqOObEpKgi0C1utVDg1bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784617068; c=relaxed/simple;
	bh=viALtA2lxvzs6wGL4Gzs3clwkivH7qO9mq8ONviKc1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ramRRBDLsYbh0CVizLFvpSadJK4gtjx7mH1r3kraC8U6yIISFyUpp/vIsY90UUPYO8uY8CXcnnpKO65cks/Pzbq9gocmpWsOypdNajZl9brqSNXhKvszvb9ldoIikQN5RLt920kbGbPPiRWs+i4KgSZjz2XZ/c+/MZ5XsgLHj2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=w4IDyHQM; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="w4IDyHQM"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id EED921A10EB;
	Tue, 21 Jul 2026 06:57:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B766F60368;
	Tue, 21 Jul 2026 06:57:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 43E8C11BD065D;
	Tue, 21 Jul 2026 08:57:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784617062; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=Q/R+FLvhfwOxiJZvR4cGfTwzWyMNNlybnEBgYGmIS+c=;
	b=w4IDyHQMrQ1pI7rVXZHmf1VhUO6snsOVbX4GGl9ruHnvT1ebd4yNjdh+5zugAOiV/4iANg
	RDsQfVq/CR8gYEeaAqkfPghwQEgPv8Z2k8NT8KLDiUvbQ924UQEAXvo+IUqbkdrk+TExFp
	rJK0+vFTNdIHqOWWfE1O+ro4UsKf2bcLnlcaELF352Oa99r1aUGBpM8JYbrsLRktL860h2
	GOTzi8EsHRDQ5FB8HMvj49scQ0kI3E7GKGOz1j0pfLROndiTlN36h/0TuqhqEQ7s1tXf7U
	uuUcmJzVVtsF5slUbNM3D4Gx32/CYyJCq8l+25Xnnxv/Hup35KMtmEu9dz5P3w==
Message-ID: <eac87286-4db2-4cc6-931e-f7bb241fc84d@bootlin.com>
Date: Tue, 21 Jul 2026 08:57:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 5/5] net: phy: realtek: add support for
 RTL8261D
To: javen <javen_xu@realsil.com.cn>, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, freddy_gu@realsil.com.cn, nb@tipi-net.de
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 daniel@makrotopia.org, vladimir.oltean@nxp.com
References: <20260721022410.1391-1-javen_xu@realsil.com.cn>
 <20260721022410.1391-6-javen_xu@realsil.com.cn>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260721022410.1391-6-javen_xu@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 7/21/26 04:24, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> RTL8261D is also 10g phy. It's sub_phy_id is 0x81. And it does not need
> any firmware.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

