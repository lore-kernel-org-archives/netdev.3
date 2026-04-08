Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963B5372684;
	Wed,  8 Apr 2026 07:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775632020; cv=none; b=QLKnH1ftWzLosqNOIi8Yq9SSnybWnL4ixIfct/AN2AvIaPTWU3SMzlRYOXFx87b73MEKr0e1Lo3csaKdrsWIezD1lf2Jw9cAK89ZhSFny1WAhermGz9oZ23gH5VKGTREQ8/KRsnzCOWVJVZ1nsd+ZzALoqKJm0AnxheMqGVLZeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775632020; c=relaxed/simple;
	bh=VAqtM596fTkblqBx3Tz9ML/ae1nqwvaQNrNp6yDtM8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bVIoNZssO+oJNOje0sFHjpDKjhEcizJLgzw5j/sX9dFigtH4oqGx74YSGyGrwqjYZQxATOQRWAIgUJE6TxjiwdSzvWTpCXieg4XVL1cy0bnrGy6s12pehMQ568nuL8T6Ro1ybz8pL5Ah9scyRRO9kf1K5lloDSnnjrLHTNLWYJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f7WioZIT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f7WioZIT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 593A0C19424;
	Wed,  8 Apr 2026 07:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775632020;
	bh=VAqtM596fTkblqBx3Tz9ML/ae1nqwvaQNrNp6yDtM8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f7WioZITLb7TUZbaCmvNgfZSxzDFscADhCwHweiyBI0mPDleF+9+FkGbAzTd0+ofx
	 0+8wBQvAqIDQaMiWAgnaHBz9uq7NBPBbCXloOBIeMILNX3UQc63pe4dYt2v40c7caX
	 gk7JYjJuubcWlaxnz5o6FMNS2bWRaeA5qgGPjedDbJy+n5JcsUqtqAyx/Aoy8IckCk
	 xi7iqEFGH1z7mCpkYS7NXtcv2SKVe8+463vgmf25N44cd18QWCqkkkiHZtx01popOi
	 0oNvwcywv0QZP1TLrqa85k30ofyobzeFQE4VUyMwHBTSsqTxqBdywv9sCafepZDzf9
	 /Hb0h7ngh2czQ==
Date: Wed, 8 Apr 2026 09:06:57 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Nora Schiffer <nora.schiffer@ew.tq-group.com>
Cc: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Tero Kristo <kristo@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux@ew.tq-group.com
Subject: Re: [PATCH v4 2/5] dt-bindings: phy: ti: phy-gmii-sel: Add
 ti,j722s-phy-gmii-sel compatible
Message-ID: <20260408-umber-boa-of-expression-09a29c@quoll>
References: <cover.1775559102.git.nora.schiffer@ew.tq-group.com>
 <b67c8b0bc9cc918667e9329d79f617d033d025d5.1775559102.git.nora.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b67c8b0bc9cc918667e9329d79f617d033d025d5.1775559102.git.nora.schiffer@ew.tq-group.com>

On Tue, Apr 07, 2026 at 01:42:34PM +0200, Nora Schiffer wrote:
> The J722S gmii-sel is mostly identical to the AM64's, but additionally
> supports SGMII. The AM64 compatible ti,am654-phy-gmii-sel is used as a
> fallback.
> 
> Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
> ---
>  .../bindings/phy/ti,phy-gmii-sel.yaml         | 23 +++++++++++--------
>  1 file changed, 14 insertions(+), 9 deletions(-)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

