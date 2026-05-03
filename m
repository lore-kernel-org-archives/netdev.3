Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7623618A6CF;
	Sun,  3 May 2026 14:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777818247; cv=none; b=tk2CDsEf7ifGQ9PYSsGsFUvQ438WGrqkHfu9u7owtoqOFNS+REOgmnu2I16Fj9c+Br/Uyyzvg2FVxfg2+JsS75sLPjKW8YVgeseEcUwW304t5SyCnLskHE8RLJoo9QISDxNZEW1pSyuu6F4PDHlTWago7mJhdg5Pf207oWAoGyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777818247; c=relaxed/simple;
	bh=X6fzaFtyBszx6Ih+NRfWdgtZitELeSKhz+NE9X7qZkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NbkIn+FfDJGyZWz65CzldOVGrvAl2wuTJ4MZvKXxE01RkfUIwBWq1wB6Vs9iH8HfRM8Wbtqnfsoh4XI2AfR+lAZYa/tVpfqscPuXDhG134+eAsEx6QcrsnSGgM0PVkyXkMSIbdMNjDVCch89g2ig09ePWDL7pgVDEjBW7UIBM4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HT4X7DPf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HT4X7DPf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74BD8C2BCB4;
	Sun,  3 May 2026 14:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777818247;
	bh=X6fzaFtyBszx6Ih+NRfWdgtZitELeSKhz+NE9X7qZkM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HT4X7DPf26Mytqx0A4PkxgeNOWMJNxbTc+qS6Wlqd71Ckus60wmAY3k0xVg6tuW+v
	 oBmC0NokIrG+UJHZSHJLKB18tgF+WyrwEyFusgA4XRM6vzmNjQdIreqqz6HzaeNU6X
	 KzhPNqKKa18j4+3PtKQ1RE7BPSxaYENId5Efu7w9ElYSDKzCCU/JNpN8aFDKELVXBu
	 6YL42pAEAS/wgbZrQX69lDAlw0ZwTwPTXDmYrFxHO2hsljVgDBEpMx1XD7yjg0Nr4H
	 RLdJTwrpXxuyty9rZiP6X/JO7yPnN4EeaQ0HNEf1V7+Td3g55rBktlqyoC/pcF9KUS
	 H+EIp5SAhNdaQ==
Date: Sun, 3 May 2026 16:24:04 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Imran Shaik <imran.shaik@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Ajit Pandey <ajit.pandey@oss.qualcomm.com>, 
	Taniya Das <taniya.das@oss.qualcomm.com>, Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: clock: qcom,rpmcc: Add Qualcomm Shikra
 SoC RPMCC
Message-ID: <20260503-weightless-strict-rattlesnake-5f66cf@quoll>
References: <20260429-shikra-gcc-rpmcc-clks-v1-0-c3cd77558b7a@oss.qualcomm.com>
 <20260429-shikra-gcc-rpmcc-clks-v1-1-c3cd77558b7a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260429-shikra-gcc-rpmcc-clks-v1-1-c3cd77558b7a@oss.qualcomm.com>

On Wed, Apr 29, 2026 at 04:21:49PM +0530, Imran Shaik wrote:
> Add bindings documentation for RPM clock controller on Qualcomm Shikra SoC.
> 
> Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

