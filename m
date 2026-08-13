Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29396353EDF;
	Thu, 13 Aug 2026 09:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786614366; cv=none; b=jUxSj/LLksLu5QBoFPt+BOFSyFWgBKoyLvU196eFj8Zgcsfhu86Mw6hMnW9BP5x/OivZIziFvHDLiAklfGjJf0qPm3JQSXfQY6Cm3RTZ+Od0mMajkdNk5wy7UGU51lG4pp01OJvDjosLLcBEwFfcMnITi2k7r6v4memq78tucT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786614366; c=relaxed/simple;
	bh=Asfy3W2nPVPE/oIyIRQzD/mHd4wbc6vZc1m4e7AHJNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a6Au2GEC6dIHDzfvyKngRw9JYfFxZJ7UV7+DIM/V4+nXvl2ellW2fs7c7oIMNMNcB5ZvQau8W3nZrDUYFla+wDJbnwOE3W8ixPTokltwDThgSCqREZrBo5B4k8YY0N38sgD82jUbLd8erNUdXJfDxaZbw3hGGljMaHVxO6+ZhyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQPX9WgT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQPX9WgT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46FE31F000E9;
	Thu, 13 Aug 2026 09:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786614364;
	bh=94KZngccI045nRvys8eezH1GfpKKPqRGcEOkvAjloio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AQPX9WgTX8qT4ToT5/172hs/Po43jnfpkRyqxQbRZDb4Do8q3HsgxL6HO0sTu5E5T
	 eziVZEKMVigN1uUUOPw2P4ud+DGOSERL1VhuCt7KmBl+CGVqocT30XHfFpWE+LmVFY
	 n0sm5Ari+ndCOY0sxai6PCIew26BzIyl5YPb4/riSDgaIAQaFkGm0QVTg1+0SmG+rc
	 qZpNkNhHToA2sLnceRNRx+/OV2TrOoFuDqMctJbHkGdd4ufS3Dc5UINSYHa5UTZbjP
	 BF8veJDnnJP0nWHjCC2BnbRO9IVBarF6kQkg1FagKpWxyQwYoSxKvidNTXN0PBDoND
	 hz3w8nsRB2fzA==
Date: Thu, 13 Aug 2026 11:45:54 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Alexander Stein <alexander.stein@ew.tq-group.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Oleksij Rempel <o.rempel@pengutronix.de>, 
	Matthias Kaehlcke <mka@chromium.org>, Fabio Estevam <festevam@gmail.com>, linux-usb@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 1/8] dt-bindings: usb: ti,usb8041: document the TUSB8040A
 hub
Message-ID: <20260813-olive-kingfisher-of-greatness-f24ddf@quoll>
References: <20260810-msm8974-onboard-usb-v1-0-08a805768328@oss.qualcomm.com>
 <20260810-msm8974-onboard-usb-v1-1-08a805768328@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260810-msm8974-onboard-usb-v1-1-08a805768328@oss.qualcomm.com>

On Mon, Aug 10, 2026 at 03:42:32AM +0300, Dmitry Baryshkov wrote:
> The TI TUSB8040A four-port USB 3.0 hub is not documented, so onboard
> device nodes for it cannot be validated.
> 
> Document it next to its TUSB8041 sibling: the same reset-gpios/peer-hub
> properties apply. Besides the datasheet default 0451:8040 / 0451:8042
> IDs, also document 0451:8041 / 0451:8043: the configuration EEPROM can
> override the product IDs, and e.g. the APQ8074 Dragonboard programs
> these values, as seen when booting the vendor image.
> 
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/usb/ti,usb8041.yaml | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

