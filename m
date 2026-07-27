Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CC21A6839
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 12:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785155900; cv=none; b=psqThXVwzqJLZs0er4SiJ0vn+kIfiBeWq1YOjnFLHhRtDvdjuPomdjcWjV+dvbhTxsAVKzGKYMoQD6yZewi388TV+06LoY//K93+rKe0Abzr8p85dPThui4tCzTiKaLA1oMf2P7EinL84fvGGXMUrJu0DtNR65yTUsohBMulNvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785155900; c=relaxed/simple;
	bh=+xkt9NC/geoelIn0EZCujc3Lyl73T78aDl49KfgKhZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qIVaVMyAtX3T2YPWl7xFgq9xx/n5oolZSNmQorSaSvWEAAUIff0xb2DZR/Lw0D2UO5jTDOTLI9UpKg1oYKysxjp+HxzaEEwP95Y1i0Grtc4cWDGX9/tVgn6sDsxVa37NPizRuFtrMOVcxkW1+xz6BvApMAuOFhSsFqVcJeglx+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pqrs.dk; spf=pass smtp.mailfrom=pqrs.dk; dkim=pass (2048-bit key) header.d=pqrs.dk header.i=@pqrs.dk header.b=pMACFkvL; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pqrs.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pqrs.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pqrs.dk header.i=@pqrs.dk header.b="pMACFkvL"
Date: Mon, 27 Jul 2026 14:38:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqrs.dk; s=key1;
	t=1785155895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h7Hyns7gmEe0o2at1J1kixWFyWe+PA0g4xnYAct3WtE=;
	b=pMACFkvLIiOS5XQ5KkDlya86ZC8lnXtduP7w0pLhAX3doL4gM5Yo+HrjNk3cMS2ruQbbJA
	2oaBsJWW6mAPNRifmTcnboEnfhExiRzcGjAqmdJ0xJFA35XBBnUdUzfeqrkAtTaFwI6AkW
	UPjo+mp3ufBgZ91pGm0pym+wXIMAee2BdBiNzVoDs9BAoPTWuUoMaWOkYaSckn2GtmB/jv
	9m6x6eTINqjSB60Baa0AfTF5kTOJAfBgYyeGR9pGeRAqC+7WroPhvnp7T0ZGfvFIKntSqA
	PIdAlzHNI6O80+Z/GCVqf4fZYdrGfReuBq/8GIujeQaUoStJJPW7Wi3zVlbgrg==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin@pqrs.dk>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Linus Walleij <linusw@kernel.org>, 
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Michael Rasmussen <mir@bang-olufsen.dk>, 
	Florian Fainelli <f.fainelli@gmail.com>, Mieczyslaw Nalewaj <namiltd@yahoo.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 0/4] net: dsa: realtek: use devm_mutex_init
Message-ID: <amdQ_aD-zNTnsK-7@pqrs.dk>
References: <20260726-realtek_mutext-v2-0-5d62ba998791@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260726-realtek_mutext-v2-0-5d62ba998791@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Sun, Jul 26, 2026 at 10:56:07PM -0300, Luiz Angelo Daros de Luca wrote:
> This series fixes mutex teardown in the Realtek DSA drivers.
> 
> With CONFIG_DEBUG_MUTEXES enabled, mutex_destroy() must be called before
> the mutex is discarded. Using devm_mutex_init() lets the driver core
> handle that automatically.
> 
> The changes are split into individual commits based on the feature that
> introduced each lock to allow proper backports to stable trees.
> 
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>

For the whole series,

Reviewed-by: Alvin Šipraga <alvin.sipraga@analog.com>
