Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D978119995E;
	Sun,  5 Apr 2026 08:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775376185; cv=none; b=l3VUylRqlixmJhVIMOTqsgyk2FDtSfXJSYkKR1+bUqlPHsi11nAyVAxlK4z6Zo5VIg/S6Y9jgTB61MtjCyAJoodEo1WK2EtUy7y+1bP7OKjWu8zggEqFljxlyr6RMqUIIjnMPKSBIuFhqZhFpb95gJNiT2JDvAZiMKNpAnUwTa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775376185; c=relaxed/simple;
	bh=l4A+ajEBMJfUsrXMtC4Rbv1/k6Te5/BMi3JNGNRMSDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Scplq+LWYLj2M9GZJlm9b3aXDPnCIfI6BUqaVVwMquSrCd2geCH5gCa1PrH1cQ1lQUFEMOgBOjP6eJyxRp31znfpQB6Dsg5IwWDFD7c124Wnsltod/g/HEN/JBaU88kVcirbHAWSwKKsRALQEQwhgovNvi9OMjrh/e2rmDzhvCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BS6UmvmX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BS6UmvmX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6BBCC116C6;
	Sun,  5 Apr 2026 08:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775376185;
	bh=l4A+ajEBMJfUsrXMtC4Rbv1/k6Te5/BMi3JNGNRMSDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BS6UmvmXSMzXXR/QuPThU8sqGrUBQ2oGoFaNRJiwbLageWF94DJ03ow/rQmeLNvdj
	 NPsunQFekr6OemAZ8sb+WvTyWd3n8Q8m3krHl/GKQqaR/U40t2UpVwtCBY8ntfELhs
	 wlZVIOyLBY/rO7kPtGpdJfnyLUxbq6UyS6dLZdmp0FoJ+LnaCNMtRN0kIs7UbtzmWT
	 8rEYZOVoqsrv0oELmREWJbCfFLo5cFH5HHqQCnwfDp1JMu+0eg9Ef9SV4oNdyoMW7l
	 IH8JP2wFDNYjgWHxoCDD3zE6D+r6e6jflA1w+waF6kaWfzvves2Nenva9OGHeNFXbR
	 wHgxN26VjgWfg==
Date: Sun, 5 Apr 2026 10:03:03 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Alex Elder <elder@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Alexander Koskovich <akoskovich@pm.me>, ~postmarketos/upstreaming@lists.sr.ht, 
	phone-devel@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/6] dt-bindings: net: qcom,ipa: add Milos compatible
Message-ID: <20260405-roaring-hasty-trogon-dbffb5@quoll>
References: <20260403-milos-ipa-v1-0-01e9e4e03d3e@fairphone.com>
 <20260403-milos-ipa-v1-3-01e9e4e03d3e@fairphone.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260403-milos-ipa-v1-3-01e9e4e03d3e@fairphone.com>

On Fri, Apr 03, 2026 at 06:43:49PM +0200, Luca Weiss wrote:
> Add support for the Milos SoC, which uses IPA v5.2.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  Documentation/devicetree/bindings/net/qcom,ipa.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

