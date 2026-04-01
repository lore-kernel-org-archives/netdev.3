Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DFD37CD54;
	Wed,  1 Apr 2026 07:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775028349; cv=none; b=j28or8g64iQmCneL++ZTw3y3JYXD5jQvF+WjX/hT3tSGLOpVglcKWt2lY4x0dlwEB+jlonQXUpZEVkVHG3jNsZQVJ7uuuxcMOrzu6eg0MHCVbw6LJJn5OuETqG+Eg1FR611IBHjuTa/ht12u/YTLDPvf/+ahgExmfIiFw7MCA1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775028349; c=relaxed/simple;
	bh=3zpV4BmFHhX7sLoaP0MfQY1ZCq6/MCT3Rf1kvJHa25g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dY9D2AZrmiXR27u3iepsnJhFBna52yl3dvJ4kqcO50v/5ZzqL1RWORtSOuqg3RcBqbko5I6wHUwaZtkCGpQwJXvYblm92IJBdJrpfZifqcTg+TOZxejI5LYZl7CrVIzk0wuiNzn35GnUWI+ji84KCVzuWvRXqHrDrj/MN2TvdCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVeNUhp7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVeNUhp7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2688C19423;
	Wed,  1 Apr 2026 07:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775028349;
	bh=3zpV4BmFHhX7sLoaP0MfQY1ZCq6/MCT3Rf1kvJHa25g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EVeNUhp7ZEZMJv+VgpvFPW1uiPseHFuFg5g692BserrG/QehxMcC9zIlzTT2V6nwE
	 hMphmHkiapqUnRyOl835AuUyGaNUQB53uEgZoUoCqyEsT/r9XGvcCRwTnVbjOJJpT2
	 cm+SzaKGIiwql+64XsN4odwWmZD+h6K6sLUy6np61GANT66eqiP5b0PuVKwQVgp1sN
	 8sZyKtONPV8F8MlImxvtcBelKS5/6KHK4kRXbsqrYUjmtUEySmn3akNKzW9Ga2Gxs0
	 EVliWEMx9EAS1kLPuB72kG3pVP9lmZpwTxMJyndQJ78uy6eHBSu3uwlDittJYz5jP1
	 ZdRhw64X08+fA==
Date: Wed, 1 Apr 2026 09:25:46 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Umang Chheda <umang.chheda@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: qcom: Add monaco-evk-ac support
Message-ID: <20260401-sassy-nonchalant-jaguarundi-abe4ee@quoll>
References: <20260401-monaco-evk-ac-sku-v2-0-27b5f702cfba@oss.qualcomm.com>
 <20260401-monaco-evk-ac-sku-v2-1-27b5f702cfba@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260401-monaco-evk-ac-sku-v2-1-27b5f702cfba@oss.qualcomm.com>

On Wed, Apr 01, 2026 at 12:14:42AM +0530, Umang Chheda wrote:
> Introduce bindings for the monaco-evk-ac IoT board, which is
> based on the monaco-ac (QCS8300-AC) SoC variant.
> 
> Signed-off-by: Umang Chheda <umang.chheda@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

