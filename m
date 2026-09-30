Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756A93BE659;
	Wed, 30 Sep 2026 10:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790762813; cv=none; b=GEFxFCkKMnHZcxoAjB960cJIxyr33RwmJvEp17W7wium4WM6L8nVnApVAG7r2xFqbChYFGy9O+Mb1575vNnc+mJcDGqEM9iSBF3JGIIAI8+FS17P2JQoyOafKmY2XPmV8aSgw+TUWmCEnd+gyU/VsW9Ay1HWF64q03SV7jl0hVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790762813; c=relaxed/simple;
	bh=ubAvfkCp5vsdwUjCVnZQk0oMqZ99KBbjxOYN5RzNHz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bdHeM9y6ktU3w9JyNic3OqDKRMad1WubJuxOaI48kX/fjuvutDyL8NGr5J+BLLAA6PW1JUvrAyd4BF8uHxUv1uZJLAh+OxSS8ocPjWpt0IXXWtPOYZdsa0VGri3zoQG7Q3t6HMaZov4LsG7CNnPfqjKwD4Aqe8xkav8VE0BivTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WfJ/AmNx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WfJ/AmNx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6F771F000FF;
	Wed, 30 Sep 2026 10:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790762812;
	bh=Q9yiKYavryXT+brJQyEy24mXi4JWCHIusIicf28HZnE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WfJ/AmNxHbH3gx7b57FwObyYPWoGBd/CHHeB1e0Oun037vUW75D/Pc3kUrV44bqX1
	 NsA82hecWQSdk8FkiS87UgBmOBrjES7EFAEG8Re4d3G9H1vS9ScnXBnndb09bkq8dr
	 AoHBUun3DucjgsbpBBmiWGY1TmDjcpjF/8u6IglR+g9O7jjPbHhPqFz3omUSM3xsub
	 yfgDgcvlI7M370/zdFArEUb1wgMBN9tiAXjSRh198fYyWb9BPpU5EzXr/fhoOgtryk
	 SdghhvyApBY7mWcMDIcxIFUp2NbjaQutFkGVQugusvCUqE3bjuXWfs6AS6BH2jnkH3
	 qSuiHvIXTmRLw==
Date: Wed, 30 Sep 2026 12:06:48 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Po-Yu Chuang <ratbert@faraday-tech.com>, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: net: ftgmac100: Add AST2700 compatible
Message-ID: <20260930-rare-sarcastic-angelfish-21cfeb@quoll>
References: <20260927-support_ast2700-v1-0-9f03f29d2c82@aspeedtech.com>
 <20260927-support_ast2700-v1-1-9f03f29d2c82@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260927-support_ast2700-v1-1-9f03f29d2c82@aspeedtech.com>

On Sun, Sep 27, 2026 at 03:16:20PM +0800, Jacky Chou wrote:
> Add AST2700 to the FTGMAC100 compatible list and document that its
> RMII RCLK gate matches the earlier Aspeed SoCs. Allow the reset line for
> AST2700 as it follows the same reset requirements as AST2600.
> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> ---
>  Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

