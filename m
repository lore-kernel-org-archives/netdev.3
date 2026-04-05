Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C2133F5A5;
	Sun,  5 Apr 2026 07:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775375104; cv=none; b=QX8dXS64cu7j6d6JKtUY59b1Z9FunQ+aisxh6Idkahrerri/bhJj4Bv1xrLte97vVR7GMxgrwsKoppIvgb4SzvK9d+FxnASoAr27k7iASGRKcvolLBLWxLW9QNeq/UVH3aHyMK1KZw8oBfzo3Kyd/IMbOJ4PvfpbK2bVNgKc/5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775375104; c=relaxed/simple;
	bh=r1fCiZ94zTgwIFtJSHcZSyEfTls2k6yuQHeYxk3E+s0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J6QS6xnOE96wa09WnmYAyzgQuDN49WE71txorbZxiSeSVpdHxPRtO/FENwoZhe2btQWpRA+8FF8kRBoyCI7Xh6UjzvjTZN3cOUwZJCuayUKrQRbrVpMoRvN7MKYC74t/8Ih5OQyrS6WS3bwKSxo+rsLuY9IU+6R5Wlcy1BWvN2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ig/JnhBa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ig/JnhBa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F05FEC116C6;
	Sun,  5 Apr 2026 07:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775375104;
	bh=r1fCiZ94zTgwIFtJSHcZSyEfTls2k6yuQHeYxk3E+s0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ig/JnhBazT7qhC8JGijMu1xBMp729RhpnCMzkiC8ZBnmeeYExsFJn3eKv7qDk6hj5
	 swU4dM0epf/LA7dimuwfmJg0DT6YOg/IwavDL+XYRx+QZyOWYFr5yTZZPgq/A0Mbkv
	 W+icGTMA+crslWd+fU1bQ7UL0KMHIfLrgOsRlQPBjyGH5XshrqgmKKCo1MeRuFYDwq
	 FrrnTBj/I1uUIRHNjOT/hiJyLA3w2C605SKxGEcVmOOjw1+KztPZl8bCG2PHkZXJVo
	 QzTpUSuJN0A2CHYf6faKuMmpIPTgWkGfFElq/Tee4y8L9kq0JK1BrOwOWYLGa7JTnz
	 VPRnLYi2npghQ==
Date: Sun, 5 Apr 2026 09:45:02 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Taniya Das <taniya.das@oss.qualcomm.com>, Taniya Das <quic_tdas@quicinc.com>, 
	Richard Cochran <richardcochran@gmail.com>, Shawn Guo <shengchao.guo@oss.qualcomm.com>, 
	Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 2/7] dt-bindings: clock: qcom-rpmhcc: Add support for
 Nord SoCs
Message-ID: <20260405-subtle-anaconda-of-atheism-3c21ef@quoll>
References: <20260403-nord-clks-v1-0-018af14979fd@oss.qualcomm.com>
 <20260403-nord-clks-v1-2-018af14979fd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260403-nord-clks-v1-2-018af14979fd@oss.qualcomm.com>

On Fri, Apr 03, 2026 at 04:10:50PM +0200, Bartosz Golaszewski wrote:
> From: Taniya Das <taniya.das@oss.qualcomm.com>
> 
> Add bindings and update documentation compatible for RPMh clock
> controller on Nord SoC.
> 
> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

