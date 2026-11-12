Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794481537;
	b=jPn7mZxaVIKfFpOD78Nnsd9IjmRRHzXE0kBdY3c2AXgc4phOAM7CdDQCWV4nD9xa/6EK
	 Ei+B0TBBF6aiTjM9vHEjVE8d0NHVQ4/2QH8HcBoCwPAyT1PPQviMAKJUD+GYPTpSw5EkX
	 BIVs1P45k6TB7RpPxhPzSbVzz5YhoMssTWurEhH6+J1NksTg4SFvton1WBG2umbYw+2sa
	 z+wsWC60/NUf4ctXC/gk5PawHIZWP9SnEwUMNDTReBhYRxa8xSBAOgDMHEVBYKO60buwD
	 wl1eHOPfiBSUT1COdx1FDBl6nC6KKx8Q/+IrOPlpSCwLCav8dLXdUY8tDigXXRxQltQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794481537;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=kiMdH9XjYH5DacKijAUOdeBwfBR491robWI4VOLItTA=;
	b=p+thK1ZReFMWEa4iGnxiITlYFps8HRWCwtdfg5oLN6xs3YpkObN3l6c/OsEZxD/u8Y0q
	 LSRYiF//lGTUTjxeIyiMOcDxB/MUEcgELs/2xPMpf8clmbwWjAVG+xfjcobaOMLF1IRMJ
	 et2VcGWYDnxQSOfasdHsubvIYiB98zrZgHq/25PpPrLKXeZhpOC12qgtiu5Ns69lzXLVL
	 88MjGeMKkdlmWAfy1iz5MlQsprptWdblAq2Lag8AnmE86RO3WFb2So/KFesB5O5DWx77W
	 ZxfkL1SD25UoMCFXjhESVYmPldZ65k8gV9YLCF7fYPxDUVr+htM2WceBict8hQZ/fZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cvamh6QK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F105D606A31C;
	Thu, 12 Nov 2026 11:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cvamh6QK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0C791F00A05;
	Thu, 12 Nov 2026 11:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794481536;
	bh=kiMdH9XjYH5DacKijAUOdeBwfBR491robWI4VOLItTA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cvamh6QKd2uRSuQ1mKjyIBlqu2nTe4fNQxDt7l8FRBcCJRe0BVlvSXhFKGCicsWO1
	 YHayRHdX5U++7hIh3Zt71/8EpoxZ9Wj00AWMkWvsnoc/Byvh6i2RY4g+DaTHFrhGnu
	 DK7cxUl+rP3iWfI3zGnfjyOIwDXolTKnP3rpFJYCG/oEFv/Hasm8jTmrZJ7A3AuOFn
	 l5UPyuJ6yBy3tdiNlz0tTmo0sx12f4kfPV8FWRnYa5Jx+sfndeGRt+U4x1VLBx//b8
	 NQZHZoe9ljLnX5WVdL2XCMD4uHLzCscRm676uphanwZ1XLaFA81j6dfUTJWLlprVZv
	 FBBPigtADyHxg==
Date: Thu, 12 Nov 2026 12:05:33 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Asdlerto Korry <korryasdlerto@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
	Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
	David Heidelberg <david@ixit.cz>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, oe-linux-nfc@lists.linux.dev, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 3/4] nfc: s3fwrn5: i2c: Enable the pvdd supply
Message-ID: <20261112-little-camel-of-certainty-c95ede@quoll>
References: <20261111-m52xq-dts-v2-0-063289405882@gmail.com>
 <20261111-m52xq-dts-v2-3-063289405882@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261111-m52xq-dts-v2-3-063289405882@gmail.com>

On Wed, Nov 11, 2026 at 05:07:47PM +0200, Asdlerto Korry wrote:
> Get and enable the optional PVDD supply before the enable GPIO is
> driven. Boards that switch this supply from the SoC no longer have to
> mark the regulator always-on.
> 
> Signed-off-by: Asdlerto Korry <korryasdlerto@gmail.com>
> ---
>  drivers/nfc/s3fwrn5/i2c.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

