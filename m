Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2808B3A3E87;
	Fri, 11 Sep 2026 15:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789140624; cv=none; b=aKcT65/WcCPHpazzi2hdwo35muBhNHmgcYvvZ2p3Y0yZ5D4Gyj3gmcVqDc5eevjwr22quVQeZgjeC4UQ/FXwoZQlr42MgC4botuMWGnG/Bj93KejWzG2PhEG7nIveyl654Wy+Yukh74DqwMXtRxX/j6onwrci3MDRiiEDn/qAsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789140624; c=relaxed/simple;
	bh=MR2aQAPwlvYEd9+x9MPOoBprAhhES4kA9cnLmBi7tEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bD2l+GhmTik81nMZElVxer8Lm4Iep+5NA64XXdfaKopSehQPgfCb4H/dU0K/unMzAgfMv83fltkm50IZ/CJnlprQZC/EGQWNSGtnYLl1oRgEyZqE0Y4ggfe/omYKZYJ0efBGIMh8396plvYbi3IC8auN1Q4ABnBW0CvQF2VOK9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net; spf=pass smtp.mailfrom=marmottus.net; dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b=EjORVyIr; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marmottus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b="EjORVyIr"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6AF343EF95;
	Fri, 11 Sep 2026 15:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marmottus.net;
	s=gm1; t=1789140617; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=MR2aQAPwlvYEd9+x9MPOoBprAhhES4kA9cnLmBi7tEQ=;
	b=EjORVyIr/Z1bDfgqn0r3A3gGxN4/Bs0Pqd+15a8oW1qXKREEw/48USwKt4lchytSCHs8Jv
	P7dXDrg8y63/00eDqB++UfmGzVJaas+Wf76So/Xi1MY7OZ0U+amT/bNb6WnP3ZzfUc48GE
	dOklCCcv8pnAlkKqxM1aPfzNE5sWWCtgiEn2b3L0UCIRTHsXIH/IzHlRNa0NPeDaUxJ+pT
	riue5MvmDU0UhmwuCU4v4KnSLzgwTMF3R5Xtv1YwYshinZr4+Ewh0ktb4cAi9c60oRNIEe
	JIGOLjHu+nFEYN1s6pjYvHOT93Wp8a+uUMUQqo57dsULbA15uzt8WsxFipBsXg==
Date: Fri, 11 Sep 2026 17:30:13 +0200
From: Arthur Crepin Leblond <arthur@marmottus.net>
To: netdev-bot+sashiko@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, arnd@arndb.de,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, krzysztof.kozlowski@oss.qualcomm.com
Subject: Re: [PATCH net-next v7 1/3] dt-bindings: net: wiznet,w5100: convert
 to DT schema
Message-ID: <20260911153013.GA9585@marmottus.net>
Reply-To: arthur@marmottus.net
References: <20260904-wiznet-link-gpio-v7-1-69f01b70c96f@marmottus.net>
 <178895753846.219967.8860843467900146377@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <178895753846.219967.8860843467900146377@kernel.org>
X-GND-Sasl: arthur@marmottus.net
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: dmFkZTGPDiB5gVxwKSgCPMbxXbzTaM0DHFYUSzST+l3ye13PeZ+FAw1NcnWq0ZnPXG+0HzplhqDbaIGrnOpETveo2gJkvjILqXzbqXNXW0kAfVW+V90CQUnVBaIgy1+PdPwVb9dRtRrBhPQi3yH3lRGNUb2PXtyhxmOC0t8Ls9PoK1koDoGXb16PG+Qb0tG5kkIJfMNOltY33eVAOkmxR1XsJAesl+V7U62gPnMaOei8DzV8NH4paLl/kvXVXcwkVdyys/dwnPCGaEU1o88d4hfadKtO+UJ66RlABeqiVyICZUCP8n72jjVgn9iiI2pc2vxiTrkPS7iwU+AdxDKwYHaPgdInkkzRyhvv7jLKZJgKnHIoFOwzYpfXN/oCsGG2/LeLOrQkJCSSjxD0hOJrb2X340kxaCGpNSzJ0saVVvChgDbowL/o2W3WQciKemqOPwuvcx/v1ghm3pg8Esie8W4fzrnrvOKpAaJRwN90kZhrOfusop/HxL1g9H+3DAHlK8VQoEWmoryKwaDMdP2jlNSpK/Od73g6orNYGdmpTpjt37r0L4mtw6/jcvuh2mqhJ4E3wDBhoN1gmG9TEU2wdqnn8/cgnq8hvTQ/azWiSOG/BJPHHvlL55LlYX2sssxwKPJTaXH/INCnAeczSbr3iuBXjg4+d38SSOOM8jTWUZGrURcQwA

On Wed, Sep 09, 2026 at 12:38:58PM +0000, netdev-bot+sashiko@kernel.org wrote:
>Would it make sense to either describe/constrain the type as level-low in
>the schema, or have the driver pass IRQF_TRIGGER_NONE and honour the DT
>type?

I'll change the falling edge to low.

>Would an allOf/if:properties:compatible:contains: block per part be
>better here, or a description explaining why 80 MHz is safe for all
>three?

I would maybe rephrase the description then but a allOf sounds
overkill, w5500 and w5200 seem to support theoretically up to 80 MHz
but going that high will probably cause some signal distortion. I
would consider this a user mistake to use an unstable frequency.

Arthur
