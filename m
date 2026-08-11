Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FAA38B7DC;
	Tue, 11 Aug 2026 07:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786434245; cv=none; b=nf8E9PbPMOR3DDP39o/lRTgpq0+25ldur/hB56y+lg89MNgt6wAYIui/i/S1AtUQui4meOwOKS9y3hwNMAbOCUS6p+bUAKSFDF/nXKFLhr4ZzgaEkGh/TROzFJCuUCwJw1wRn7gAFbgf0Emb8hhYuUfYSHKXu2ZwGFBGvDzwyAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786434245; c=relaxed/simple;
	bh=i3UxgmIn/FWHG0glZnPUbs/e86+lCjx39yvZ6fhS4MM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dgm7Sy4qWuEoAq7i79/HVzTfF16l05vos/jp5CHmzd3ivMzZ/n/F5YfIz/CacPzLLB0ApACUbKWYjnStmmfns0p+wduN0GbYvj/hYPIscwEYXwKgDowIFa5EWgntMwrp1FNhbJC07UUoHMaW7BcMp4SOeSnAWSd0SLmWVcV9mlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kniZxzZO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kniZxzZO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AE7A1F000E9;
	Tue, 11 Aug 2026 07:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786434244;
	bh=S9yQIDCmC2m0UOSi0aNLRFJwvF9ciswmzmGXGaqkJp8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kniZxzZOYCPw+NmrglEzRBvYZjy11qAtz2ysTGInTA1IQ7q+EqcysL/U+n2gFgJS7
	 3f2kHWDN6WC4/7h0E8O0qo3e0cJPBm5DTCucw+S1IWCZkwQM12VKyePlprjMDLOLTt
	 jBfWU70bXYJ7K7XS5+5ZcgUQ4+MwnneMkXjl8ZFrULqCwD0b+AND1VR41Y7xS9ahyj
	 eupK+KzzN2u2GFOl5DpwIyyGtx+IMSvxmfc3Fx4NqX0+kHypP+/Ib2XBGk+1Upf9Av
	 Qge0lsZFkB1dDGASExH9KhySuxdnZKWwFR4SyoE7sdvrpCqRXdoaH+eIccIQ74s3fY
	 zhl8X+QhuMrSw==
Date: Tue, 11 Aug 2026 09:43:59 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
Cc: David Heidelberg <david@ixit.cz>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Bjorn Andersson <andersson@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Conor Dooley <conor.dooley@microchip.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Luca Weiss <luca.weiss@fairphone.com>, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, oe-linux-nfc@lists.linux.dev
Subject: Re: [PATCH v4 1/6] nfc: s3fwrn5: drop of_match_ptr() from the I2C
 driver
Message-ID: <20260811-uber-hyena-of-acceptance-da8d5c@quoll>
References: <20260807021001.239389-1-jorijnvdgraaf@catcrafts.net>
 <20260807021001.239389-2-jorijnvdgraaf@catcrafts.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260807021001.239389-2-jorijnvdgraaf@catcrafts.net>

On Fri, Aug 07, 2026 at 04:09:56AM +0200, Jorijn van der Graaf wrote:
> Since commit 9739e07fdb29 ("nfc: Drop __maybe_unused from of_device_id
> tables") the OF match table relies on its MODULE_DEVICE_TABLE()
> reference to count as used, while of_match_ptr() still discards the
> .of_match_table reference on !CONFIG_OF builds. Drop of_match_ptr() so
> every configuration uses the same code; the S3NRN4V support added later
> in this series carries its variant selector in this table's match data.
> 
> Assisted-by: Claude:claude-fable-5
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
> ---
>  drivers/nfc/s3fwrn5/i2c.c | 2 +-

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

