Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E733D9535;
	Thu, 20 Aug 2026 21:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787259766; cv=none; b=Fc099q9ZkZvp14fOU3RxPwFpyd578a/7chHPgfOK++qacnNeuyniiiGzYysu/viRPrdp/8sY14ZcWU0JD0ZuczinU2UGQLLDM0xzVyEiRME8pj/4rp9KK8IaAx/AE3b7ikgh2NtNHXRYaAcYWVvn7zhWn64ucnKbg59h+4W+TEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787259766; c=relaxed/simple;
	bh=hAEOokNojh3lhJqgZ65G/2OyKzGruLJoWhh1Lmm4550=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UvCnTArzz9faPrCItieV+W1+iiGZ6DZ1WGJ/1fmEsmtVdJIWSTFf1ckNNpwVz8+mahRhRXUHhG+wAcoM+vcC1qNlSaZYhlA4vRQfI5b5dnbe4gyhlSbAvQanwG2CFGaYRPxd+As/q8ENEdIa238oUf/14CD/n18jshrJDc/a7As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=es6UCJRL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="es6UCJRL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=EvwSXRxb9J8E1d/2epUBUSc8FSlEoFftTDkK/JBgJcc=; b=es6UCJRLDTAY1chKmX9GHIaQQo
	+DLoTvMoIHeGBQQoGDG55Mo7ki1zuRY/fI69Ctk24CD8qC1w2EsVwDOciwfoc+D2GX4NjilPrUoBj
	SlnuHQ9aud8/JsyAgyPiRHudxs5FVylkKV8VokYyo+Kp94yxsOI9bdvOi5QJksJc/ySU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wx9uA-000qSi-1m; Thu, 20 Aug 2026 23:02:30 +0200
Date: Thu, 20 Aug 2026 23:02:30 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vladislav Karmanov <vladislav.karmanov.dev@gmail.com>
Cc: netdev@vger.kernel.org, chester.a.unal@arinc9.com,
	daniel@makrotopia.org, dqfext@gmail.com, sean.wang@mediatek.com,
	olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, yangshiji66@outlook.com
Subject: Re: [PATCH net v2] net: dsa: mt7530: do not advertise EEE on
 MT7621/MT7530 switch
Message-ID: <108396dc-0067-4b1c-b270-9d42e2b9a96e@lunn.ch>
References: <20260820202844.1821687-1-vladislav.karmanov.dev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260820202844.1821687-1-vladislav.karmanov.dev@gmail.com>

> The MT7530 internal GE PHY advertises EEE by hardware default. The
> eee-broken-100tx / eee-broken-1000t device-tree properties

These properties are not needed. We know the PHY is broken, there is
no need to describe it is brokenin DT. The PHY driver should just
disable EEE. End of story.

     Andrew
