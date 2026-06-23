Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9A53CF68B;
	Tue, 23 Jun 2026 08:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782204877; cv=none; b=JG+mGiGPBXzcvU42OkmQuQY2SuO8yQdatvOHrZy8G9dYvMFpTcVCuJBjK/35bBddAUV5ziMBq2rjjbunvwZwMRmKhP95t19xTqLEmfjvokyLt/Tfarpw3Wzfb1zlaGmV3zWlPtFPYtmJDYq1aXBchZ6iegNCibVyQpxpWcazcNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782204877; c=relaxed/simple;
	bh=kFAKRrQ3zICZT6MUaJ0rB0BJxQeNLxOKSVJw/6BG9rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qav12Rvs5yCyBqgqH4/vSZsPBw7nd8X9b14jD/bB9f7p5Vx1+D+OWduKaSODJc89keJ9V/XZozaVmL6kURtAH3y3jWfVEknqLVft0eqUCFX1B4uooQtenTiAo8lfHMP7sP3nlikeX16lV8gUf9cMjgn5Ad4ohZHKVIZg4MQLm/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lrewN8lb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lrewN8lb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D10291F000E9;
	Tue, 23 Jun 2026 08:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782204876;
	bh=kFAKRrQ3zICZT6MUaJ0rB0BJxQeNLxOKSVJw/6BG9rk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lrewN8lbokIftMCJeK+ZvnRGFJ20U/MqNF3LxCaR8QinbnwfFrClIhd6ZGMpTI9WE
	 Xwv+iRXM643l9cTcwErqrmkfNyP3tROFMUnaDVZ9FuSXNMDlAAZrRGKIO9FU85jJ/A
	 y4t44zO6I4OZivJ225Gb1iwrL0VAK51zcrhh4QY6DhNgPZhYkS6IgscIfywLT404Np
	 GgewrXkgBfm+U1TMNVfvOoUvWDpo9Wjf3+iZ/RBqdMn2wHwaedGEYlaAv5ljlgTgx8
	 zqRPaBECvF7GeWGvU9rZsuo8Q+2FdqOqVsSAOU3Nn+XsLKJ/+YZboleqCfRMAiKW17
	 qemKn4+53Flog==
Date: Tue, 23 Jun 2026 10:54:31 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Esteban Urrutia <esteuwu@proton.me>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Alex Elder <elder@kernel.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: net: qcom,ipa: Add SM8450 compatible
 string
Message-ID: <20260623-rustling-sincere-walrus-1359a2@quoll>
References: <20260622-sm8450-ipa-v1-0-532f0299f96e@proton.me>
 <20260622-sm8450-ipa-v1-2-532f0299f96e@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260622-sm8450-ipa-v1-2-532f0299f96e@proton.me>

On Mon, Jun 22, 2026 at 09:44:18PM -0400, Esteban Urrutia wrote:
> Declare compatible string in ipa binding for SM8450,
> which uses IPA v5.1.

Please wrap commit message according to Linux coding style / submission
process (neither too early nor over the limit):
https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597

Please organize the patch documenting the compatible (DT bindings)
before the patch using that compatible.
See also: https://elixir.bootlin.com/linux/v6.14-rc6/source/Documentation/devicetree/bindings/submitting-patches.rst#L46

With this fixed:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

