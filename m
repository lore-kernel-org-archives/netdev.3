Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758963B7B98;
	Sun,  3 May 2026 14:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777818285; cv=none; b=gEp8v0nrOEwrIZG2cVoBezoQprQt+HRbWpoFY4/BkSVwoQl0xa/TBnNkT6+Uz/3n+G9PS4m8wMAKW1bam/OfEkWtUCQNhphbcmJxH/W3CRF+zgv2g1J9e68nUqRt0S5EmtcU/7hFMriBO/ti4daByGvmMJWvxxib8Uq/yfeXAyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777818285; c=relaxed/simple;
	bh=9nPh5kF8zGB/VEWWRaAcsTWdrXI0R2fhmr1VXxVUk+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UPctwsoQ1XK/4V0GKXplbuh7OPUyS0v7W+8DZfI9sM1ZbulW0UUIZyVacOdesGGVMP2IGVqxgUOJh78wsW8SEssx7Ml2D/ez2vB2SS4+rIgL1HoNJVt6Zd8CW5hFzY94iiCAyBiPUWlqSFNKvSHG7DFw4f53fDGbCChNA972o2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5HbDCJ1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5HbDCJ1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A22EC2BCB4;
	Sun,  3 May 2026 14:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777818285;
	bh=9nPh5kF8zGB/VEWWRaAcsTWdrXI0R2fhmr1VXxVUk+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q5HbDCJ19mPrLkSNEFpf4vGqIv1OJ3gECmIzM4fZkDVrbanWdpb9TK/an33jRv/xK
	 0ouVbS0HeGM9iTm87g/6u5QDm+MqUhQSDnNOCBleJCimqMBlnay0YntSInk0rFx/ks
	 mGTjHeYopVklpaz/diGRN+6ZZMjXNCvCl355Ch73imj/2aDXonKOeTQADsR/1hMAzu
	 R30ymFI9cTGBgqiwTdcsRqluhXRJ7FJfKUfbCfACoBBcYVH91bOdfz9Sa2WJzLtCmE
	 qM0ST3lVazbfaqf/0xFQp7ZjW0c8jXtLZHVjHtFfYuOzJlTSqJ40i7LbQ5Smq2uhJ8
	 SXIE/0PYl7Wsg==
Date: Sun, 3 May 2026 16:24:42 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Imran Shaik <imran.shaik@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Ajit Pandey <ajit.pandey@oss.qualcomm.com>, 
	Taniya Das <taniya.das@oss.qualcomm.com>, Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 2/5] dt-bindings: clock: qcom: Add Qualcomm Shikra SoC
 Global Clock Controller
Message-ID: <20260503-enigmatic-thankful-jerboa-020faa@quoll>
References: <20260429-shikra-gcc-rpmcc-clks-v1-0-c3cd77558b7a@oss.qualcomm.com>
 <20260429-shikra-gcc-rpmcc-clks-v1-2-c3cd77558b7a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260429-shikra-gcc-rpmcc-clks-v1-2-c3cd77558b7a@oss.qualcomm.com>

On Wed, Apr 29, 2026 at 04:21:50PM +0530, Imran Shaik wrote:
> Add device tree bindings for the global clock controller on Qualcomm
> Shikra SoC.
> 
> Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/clock/qcom,shikra-gcc.yaml |  63 +++++
>  include/dt-bindings/clock/qcom,shikra-gcc.h        | 259 +++++++++++++++++++++
>  2 files changed, 322 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

