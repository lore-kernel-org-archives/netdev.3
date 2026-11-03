Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793703595;
	b=DSUptdhLid5eZHzhJDpaldg1vcgGXp/+oC53ibgV+XPqN+0HeYpelWo+zpjOGOzZ/Xn3
	 YBDLlrC9M0Rch81nrbmyVmWrtRq27UAvZKEIrZeSR47xsx9noTy7yyj0OKETfd/8RZlvS
	 jkPk1+kVgxnoy036UCe2aEeq8XcPMTrB5CG4cTksy3vyP1a/eJRCEYqJ/WtVQuJ58WH84
	 KIeXORRE1WCmKXdQrqmrlyCv3G+8Ap3f8Eu8QNdW6WpukX9SI56fgbmUfpssO8D92ycJW
	 vAwGepyqR89ZR98dJ7UHduZlPfDXiJqZaBTo7ro4b0tm0JM+lTDw0c/3vRQQDtsA4jA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793703595;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=5pKcFRXYhUfRt/NFgpZQiyJq40B9sdnA84VTi8AATL4=;
	b=4hjaLud8AP/yvURV3/Pk7l9L0ClL4NPnoWKuBCYJV+goe2uA0KzNXFAf/cDyZXA8hCGd
	 gsvlJZ9aEaeto1+dRlYV2E04r2gAUMueZis8RnoZlKCe97Y80GBUo1BCbNzngpy5FSdWu
	 tFz6AZ0gLCfMgPtY0vT70AgwVNmatOn5PT2o4FS8rHH8KVChnBW/cXg0w7oDdvRjYHj3i
	 4jmv+0tAXmHyCoiR+vAA+mbUnwNX+RJJJRvPukye5pdsp2vYIFC1LzV9S2QkrX9FfEP/5
	 vPkKteC0Oaxljs+0YkC0srkcmYrUnhwfN+Df3n2yTAA24Bd9qA8aO8rG8jK62ab2TIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YRQ7geCx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E58C606A332;
	Tue,  3 Nov 2026 10:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YRQ7geCx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 456CD1F000C1;
	Tue,  3 Nov 2026 10:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793703595;
	bh=5pKcFRXYhUfRt/NFgpZQiyJq40B9sdnA84VTi8AATL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YRQ7geCx/qjrzWWDNYRgg6axSKgU5uvHghVLI81Zpn+1oDAhtH6BXWRZ37uqV4pi0
	 71M5+uhW+qULQlK6pZolWG9o7RpQFg1sPKE9fr8Og1B/p+UOrbEDiHnIvazdTiy62U
	 0IG3igKkHO0AJHcjPccEOkDbQR9AaS3Sj4E+4C7HMutrmM8WwyZ1Nr3lzaMupa6Wfm
	 +4riYs4vvmV7kdBlozp13+EuwLkb9x8ATTTbT0aiMCaYkzOBWE++TXkkV7tpqP6iFt
	 V+2TNl32cMMO2SSbtgLv8D+ahHTaPJ/67imKLF6+srU+qQyncAt6z8YnQYQIjF9yG8
	 6oZ2tGLfaCZwg==
Date: Tue, 3 Nov 2026 11:59:52 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Caleb James DeLisle <cjd@cjdns.fr>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, chester.a.unal@arinc9.com, daniel@makrotopia.org, 
	linux@armlinux.org.uk, arinc.unal@arinc9.com, Landen.Chao@mediatek.com, 
	dqfext@gmail.com, sean.wang@mediatek.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, naseefkm@gmail.com, b.larsson@gmx.com
Subject: Re: [PATCH v4 2/7] dt-bindings: net: dsa: mediatek,mt7530: describe
 'passthrough' hierarchy
Message-ID: <20261103-magic-ingenious-buzzard-8bfbc5@quoll>
References: <20261029184202.1859843-1-cjd@cjdns.fr>
 <20261029184202.1859843-3-cjd@cjdns.fr>
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
In-Reply-To: <20261029184202.1859843-3-cjd@cjdns.fr>

On Thu, Oct 29, 2026 at 06:41:57PM +0000, Caleb James DeLisle wrote:
> Due to hardware limitations, full switch hierarchies are not supported
> with DSA based on the mt7530 DSA tag, however it does support a simplified
> hierarchy in which one or more switches act as passthrough conduits with
> only one CPU port and one DSA port active. Document this capability.
> 
> Signed-off-by: Caleb James DeLisle <cjd@cjdns.fr>
> ---
>  .../devicetree/bindings/net/dsa/mediatek,mt7530.yaml         | 5 +++++
>  1 file changed, 5 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

