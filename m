Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BEA3DAADC;
	Fri, 18 Sep 2026 09:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789724622; cv=none; b=grfThOPq0SV4tEh/7TsbMxYYrjptAB4dmQ1zhT0uoiXrCU0a6uGLngAAvJ3RGrTi5VZcC+Nd6/yj85Th9B2ancBdYN+GsbCzjjlgZ3vjd3yYEvsSsbtiiJPZHH9XWe4E2j2WTYO3bba9KGC4ir4OeGq1vcFpVLLvcSXwQdXKGh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789724622; c=relaxed/simple;
	bh=v7Zt4qF7nhzJUvnSlf8u8Gqvg322CumB8FCO8R5KLkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zoqp7hhEaJjd9zEyV4H1eDP3CcZTt0G1JhIWX5VBu2KUjuBPO6MnHU/1aH6c9pqDa5naIn7DAKfWQNWIZ+LdjrnbZfGno6ntByo5DqRu9kL+ZZqWzqqEYN1on3TUGiLVfkNsQZbdSJTMiYgoJCZOySfS6ND9FoqWPOOL9dNp2MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ts6FDe6T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ts6FDe6T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E93F1F000FF;
	Fri, 18 Sep 2026 09:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789724620;
	bh=EKrCf1g7KGrMpkojRzdEMSveTBOgo7O0cRg/h5XTzGQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ts6FDe6TZjTlgHeQwoWtxFcaxWxIQbhihN8m/4UNScqOKiH/G2tGZxK5DvBla1bhZ
	 l5YMnSFtgkBE42zuqGAZ5KTEnvIy9VGi2Z3o2rmZJ8W9ts2F5csGhR2VFJoNXI41m6
	 HR0CgzqxmxIiMiTkopBlgp7CePEoRUFHfGYZQubijfDTk/DudCnRaitBLQjuo2DEzJ
	 8bEm9XHH1+3CdIB9FxQA1LIeIztE2QUl1421Mx6AQua/0hzC3NtgeqxnDhV8fXTOFP
	 7CXo3ADHgbNuu2VeUr7zWivTxw6qR0Bu1D7eg2jKfaG3ztJcy+zOPcHJ/EZac8n6yk
	 LkW8yP7RxdsRw==
Date: Fri, 18 Sep 2026 11:43:36 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Alessandro Zini <alessandro.zini@siemens.com>
Cc: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: microchip,lan8650: add
 reset-gpios property
Message-ID: <20260918-incredible-benevolent-horse-5efaeb@quoll>
References: <20260916075349.21822-1-alessandro.zini@siemens.com>
 <20260916075349.21822-2-alessandro.zini@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260916075349.21822-2-alessandro.zini@siemens.com>

On Wed, Sep 16, 2026 at 09:53:48AM +0200, Alessandro Zini wrote:
> Add optional reset-gpios property to describe the connection to the
> hardware RESET_N pin of the LAN8650/1 MAC-PHY.
> 
> Signed-off-by: Alessandro Zini <alessandro.zini@siemens.com>
> ---
> Changes in v2:
> - None
> 
>  Documentation/devicetree/bindings/net/microchip,lan8650.yaml | 5 +++++
>  1 file changed, 5 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

