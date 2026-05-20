Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EC136F43F
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 08:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779264704; cv=none; b=afVpsOIM1otr6Hx3lHUhMKke3WXLrxWaOgKb2MuzrCbXNPdVE2Gzz2ts8tGmMP53c3p21jBInZJzlshlYNGkWwk4imdCRjR1Nej1bw13yLM4y09EMBQR8Xsi8WfLi0Y2mynjSmzm/qOREiZLe+tvwGW8U73tqlrw5B8pzYsoOk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779264704; c=relaxed/simple;
	bh=Fdxm3Vn1AOFhUkYyB44/D2Qh3Bnq7xCWi1/UeH17wX4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oKtNlCpF38YyPZYbX2qmBQF0Rb4Yakt9bSdPQko+ReXDOuFVkp9Br2mCjEiSIQp2gxZ45jYAC0v0j/sIVloge/TGIhOsEtPVU37XF1Px8dWpaGBw/x+q7bSxS5MfxFGLhR0bYh7D/ShC0xt6mOxLuoCMNjlbh8Fu5BN9zKaZd/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KKgYZ1gv; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KKgYZ1gv"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id A49EE4E42CFD;
	Wed, 20 May 2026 08:11:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 70E466070E;
	Wed, 20 May 2026 08:11:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E2F4B107E9D89;
	Wed, 20 May 2026 10:11:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779264699; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=DdZv3J2pCE/mvIb6zkVmZxOxqGg0ys9/r9v2yQA8PjE=;
	b=KKgYZ1gvW6m4Xlq+HRrCKY9ejhnura8Ve//r/VOSTko+5kMC61kLF98xFjwu3TxpRt2LpU
	vzTHB0WTQHDPml6chbEAsSrxP13i0vUZN+QAeUAwM125kIEBMmTCS2Kb+6TShkQwDFsElC
	k5TqlwLHLDbDH+Gmyf3AKHa07k5bHviOFe8L4PlhiMGeKV3V+ledm0jR8QBIQSUiBGuYnd
	dmWa1eFiHWaL5P88xV92AhcebXzeS5B3TV7qxGTDyEG6qGPh1x9vDkkTw+zPQ6ZyM+mXkI
	Q+2uTaTuBfVyvtG406wl9McJF6wJsa0WcqrKv14cDTiECULWwxQWwIdbZ8gHIg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
Cc: Alexander Aring <alex.aring@gmail.com>,  Stefan Schmidt
 <stefan@datenfreihafen.org>,  Simon Horman <horms@kernel.org>,  Andrew
 Lunn <andrew+netdev@lunn.ch>,  "David S . Miller" <davem@davemloft.net>,
  Eric Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,
  Paolo Abeni <pabeni@redhat.com>,  linux-wpan@vger.kernel.org,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,
  stable@vger.kernel.org,  Shitalkumar Gandhi
 <shitalkumar.gandhi@cambiumnetworks.com>
Subject: Re: [PATCH wpan v2] ieee802154: ca8210: fix pointer truncation in
 kfifo on 64-bit
In-Reply-To: <20260520050707.38055-1-shitalkumar.gandhi@cambiumnetworks.com>
	(Shitalkumar Gandhi's message of "Wed, 20 May 2026 10:37:07 +0530")
References: <20260520050707.38055-1-shitalkumar.gandhi@cambiumnetworks.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Wed, 20 May 2026 10:11:32 +0200
Message-ID: <878q9esdor.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi,

> @@ -2540,8 +2540,10 @@ static ssize_t ca8210_test_int_user_read(
>  			!kfifo_is_empty(&priv->test.up_fifo)
>  		);
>  	}
> +	unsigned int copied;

Why is this declaration in the middle of the code? It should be at the
top,no?

Thanks,
Miqu=C3=A8l
