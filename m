Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6631F31E846;
	Thu,  7 May 2026 15:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778168484; cv=none; b=IEimu0uJ/0gJbD1tXC+svetcSw7v9tsklQXdsGcMRWEkaNry4nRhQcQXOgQ7HAGE4/Tfi5WvGDe83Iwwkc6L4jql7ld+46fQhL29HPC0DxsWn5kHdDtsXnikrJBGHuJvY5DqCtXW1/RHKSNtp+nTie28BiPKlm/ifLDHcnOZ1Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778168484; c=relaxed/simple;
	bh=zeQbU2EFNu7YKS+F/os+rENcPRDMTeAnTD5kmnxzeHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ks4Q2rSKiK6Dkf4256AsU/fwOlzhymCDaIe/pRu8kuzGdgEx+uVUHjI6yOyg92k6f9bZJqGfPqb4wEem9xLKFDpAwx7g7HbJRcBcWOGz/XkAS3TgM/97Ecps37OB0YfM0MdTJouzU256LBtmjIWMNOGcd+ehAsksFjAd/sK6C04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=et/iSjAf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="et/iSjAf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAEACC2BCB2;
	Thu,  7 May 2026 15:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778168484;
	bh=zeQbU2EFNu7YKS+F/os+rENcPRDMTeAnTD5kmnxzeHo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=et/iSjAf9YdFaNPo62Wj8zHq/wYFlGRKrcF7Be2bJKnAk2tT8NDkZpr0FqGAVt9Ix
	 z+B4bZVf2kqYVPbtT0j7hXBrvfHdZzZVAgIAmNqvjTes8AF5cIdWkix11q5bp/3Ro+
	 DIoQ7DIC738q0Vn92/y+4jC2sRAWVr+VhyVq8HZ0N/CaRssGP8MAjI55zfGhdPcpG4
	 XQC6b82d8zX64TNZzD1JuiN+DUT/gtbZFsSMBYStrjHXaTdWZy9uqAuMPx6vVMAC3s
	 atwhOt3InD/r407qt6T+71n7sQ4wnv8Cay/h5d1qrpr2FIF0w778gP86MCrnTEJRWA
	 /Hbs8kuMNW3ZA==
Date: Thu, 7 May 2026 10:41:21 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: net: lan966x: Accept standard ethernet
 prefixes
Message-ID: <177816848057.1797986.18240361881148751528.robh@kernel.org>
References: <20260507-lan966-binding-v1-1-e99293d2a4ec@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507-lan966-binding-v1-1-e99293d2a4ec@kernel.org>


On Thu, 07 May 2026 11:26:01 +0200, Linus Walleij wrote:
> The dsa.yaml and ethernet-switch.yaml bindings recommend
> prefixing ethernet switches and ports with "ethernet-" so
> make the LAN966x do the same.
> 
> Reported-by: Herve Codina <herve.codina@bootlin.com>
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
>  .../devicetree/bindings/net/microchip,lan966x-switch.yaml      | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

