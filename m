Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792756666;
	b=rtF3UF9zp5olNqaFIRELMD1Qgo6fqo3rGjBr582EmSCw6HX8ok/EXOP5FzjD4jjTfi7B
	 7HC+wQCygzZHSLvAm0Rce21NzHqd3ZkWsNvcUYCwzrenk99/gObd0KrlSAKgR5c1wmwwH
	 yFxMJfzuKgKPC3sB+QywqHHD2mKEkBNs5ZXDoVAQBSXiseNywaN04LOqF845ncEJNsTEY
	 pqCAEQDbLj8TFYIjwgX8tnu2a0xXa/eDWrpEadEYsTEkAkJOZpyuS9wnEOTuLmlJtHRbs
	 C/dY6ztg0lIbYmEVxlJ/gkIN/wO+ZkdSsjk6rhdX2gRNO+9Ca58qpkokLVWR1hQxiQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792756666;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=G4ewQLUXqh6UoQ5uJbT6hYexcqObJQ6Phji4QpcyzL8=;
	b=LS8ILKjDoennb2gf+GOFEapGYCZHTy8TH8xItY4XIEocRhtImdvwQOtIA3dqK2IolbWY
	 xt4adfjj15tSdMdPBfK10UDAnIvEFFz0h+Ig0nj+Sjgo3TA143W6Nc1Nwz6OKEtfije7/
	 pBVgp9035NT9EPRIa+YKqquArKfToD+rEaCBMdLRwzABMuqzjY1UnmMaNrSGQvsbnlKsh
	 Z3gCNTPBo9KxjG7YueD2Kxrw9GZ0L7cYTRAPLjWaTqIKUkbkwry5RCS8hJtM4BxUks5Gb
	 7lRmrnYehw14qfh46/pXYrDcmacdR0lEtelX4etEEf3uT0oiuCoCtR/lRG0ArdvBUKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WaLp0bpR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFB7606A31D;
	Fri, 23 Oct 2026 11:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WaLp0bpR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 914361F01825;
	Fri, 23 Oct 2026 11:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792756666;
	bh=G4ewQLUXqh6UoQ5uJbT6hYexcqObJQ6Phji4QpcyzL8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WaLp0bpRfAVN6OXKomOYDcg/G6wVG7rd3noWw8X64V8rYzUwa6hoVCzGNNB9XS85X
	 laSZCZ8R1n/wbzm5Ltq1xVauCa1zOStiS9c72lEuJPyL1vE/e2BlDWoLYses9Qh87m
	 1kzJECu/VlpFsH/R2xz4BGFByrGICyvT6KqPOCrdEPRLLoK4x2+ClMH3mgBEWBIv6x
	 TUSXYFfE/Fl0c2fDs0jY2ja7LNrrJS68QwA2GEY0ybbW6IiaG3hrt6ZO1KtFUV6V2W
	 guIOw/oYIoWXPHPDki/kWCeGI+d8V8Xptqj9kf4tySPYSycrBbtGoM4SjGMWFGZGi+
	 JcnNyfgmGO6Yg==
Date: Fri, 23 Oct 2026 13:57:42 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
Cc: Stephan Gerhold <stephan@gerhold.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Loic Poulain <loic.poulain@oss.qualcomm.com>, Sergey Ryazanov <ryazanov.s.a@gmail.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Eric Dumazet <edumazet@kernel.org>, 
	linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
Subject: Re: [PATCH net-next v3 1/2] dt-bindings: net: qcom,bam-dmux: Add
 memory-region and qcom,vmid properties
Message-ID: <20261023-rational-fuzzy-chital-7ff1c0@quoll>
References: <20261021-qcom-bam-dmux-vmid-ext-v3-0-cedd1f681102@oss.qualcomm.com>
 <20261021-qcom-bam-dmux-vmid-ext-v3-1-cedd1f681102@oss.qualcomm.com>
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
In-Reply-To: <20261021-qcom-bam-dmux-vmid-ext-v3-1-cedd1f681102@oss.qualcomm.com>

On Wed, Oct 21, 2026 at 12:09:43PM +0530, Vishnu Santhosh wrote:
> Some Qualcomm SoCs, such as Shikra, run the modem in a separate security
> domain with restricted access to system memory. BAM-DMUX DMA mappings
> must therefore be constrained to a designated region that can be shared
> with the modem.
> 
> Add an optional memory-region property to reference a restricted DMA
> pool used for BAM-DMUX mappings, and a qcom,vmid property to identify the
> remote execution environment that is granted access to the pool through
> SCM.
> 
> Require memory-region whenever qcom,vmid is specified.
> 
> Add the qcom,shikra-bam-dmux compatible, with qcom,bam-dmux as fallback,
> and require both properties for it.
> 
> Co-developed-by: Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
> Signed-off-by: Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
> Signed-off-by: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/net/qcom,bam-dmux.yaml     | 36 +++++++++++++++++++++-
>  1 file changed, 35 insertions(+), 1 deletion(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

