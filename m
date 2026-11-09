Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794267029;
	b=aFx7/aAl+SKOIBqrnUMmRIw3RdXIJwQfQHLBflwO65nNd1y9Ox9uTnSu9/B5Lmye4YX+
	 0qHb3GmYi1plEG0a/lshHhTtoGr8xOSPvK+nZFfNnuFHxrMcufS482AMAZYAeNMk8qA5i
	 QHQ2VluLKr5EngLyyQaZ5JZwXQTZcaPOGYth77jkH5sR24uq56J07Oz8kq+Niz/VFCgA6
	 oHTERAgk9f+t7VEh9nsXaGQ7RBjWRgtgAlPrP3A019tE6z4TyC7HIiBMZk1fXR/IUxvGq
	 gtWw3HA4se7AoJdFLPl+ap64ugCp8g+Oo0HzHsEo68rt/OnySWnkLN/qmcNhK4NPsPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794267029;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=utZOYS4SAXgB2EwrXvT+V1JUlvBmdbFEIh/ePk2lfvc=;
	b=tjziwB/0NlzaAnNUS0reha6cK6pLZPLActGujvnpzVpTXnI4Fhpk6rCJ1clnZWmIVkB6
	 rl8eSxIMtxNCDTRUZ4qPekhyZ7ULAgNAuPiyS+suJoceUnVKDArFww4MHNocYzukqR+kW
	 Mqx/l58NvXc+vHmTwC41Bg7zbe2YMGGcsHBNhJylzqMSGWPB9djc66kyUfkl3LiPfPGQa
	 /dhwgY1yJMN5pRaikSGUT5PEnNZs2Vd+QiruMmfCNSGNxQZYhafibBXFPzeEmoOtJSOJA
	 84FAF63sRRdUvOv9xblmCgJr6vPz5C8NjTYgagyvqoRRhKFZwd7qZA8YhBPQrxGTNog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CBXJQvMB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3C760A260F;
	Mon,  9 Nov 2026 23:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CBXJQvMB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 669221F0089F;
	Mon,  9 Nov 2026 23:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794267028;
	bh=utZOYS4SAXgB2EwrXvT+V1JUlvBmdbFEIh/ePk2lfvc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=CBXJQvMBIvIZEOyxF5qOe9JcpCYk0gLQ6ZDI0AYWoHb0+F7XX9sr7rjM7TrKmKz4l
	 JbDvlGg/LGAehpRfaQrL4FhL25tQRhvl+CrcSWqSxm8CBxdSsewWNq+kuj/C2YoW1M
	 rbJhs2GTR4Djl6JmdaD7ukd/zvjRNKBnM4KSyS1Jx7dY6Nmuvk4H08bddnd09ZZoqu
	 wfK42/4CkEVK2FnQLSpWmQm5567EExpkm7cZY2wCAyEf4PVmFrSEHupSkUJkxw/H3G
	 eOA38Xv73rpefDtm4lciLjT1rBs4WUoVAueoWBev3BbofJRRDj6mwpuBbDtggGTMqn
	 edSs5LsopPEKQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5E118391AFA5;
	Mon,  9 Nov 2026 23:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] dt-bindings: net: Convert
 snps,dwc-qos-ethernet
 to DT schema
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179426702692.3543549.11224444718065652161.git-patchwork-notify@kernel.org>
Date: Mon, 09 Nov 2026 23:30:26 +0000
References: <20261103220402.471214-2-robh@kernel.org>
In-Reply-To: <20261103220402.471214-2-robh@kernel.org>
To: Rob Herring (Arm) <robh@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, krzk+dt@kernel.org, conor+dt@kernel.org,
 richardcochran@gmail.com, treding@nvidia.com, jonathanh@nvidia.com,
 alexandre.torgue@foss.st.com, peppe.cavallaro@st.com, joabreu@synopsys.com,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  3 Nov 2026 16:04:01 -0600 you wrote:
> Convert the "snps,dwc-qos-ethernet-4.10" binding to DT schema format.
> The binding uses several common snps,dwmac properties, so move them to
> the snps,dwmac-common.yaml schema.
> 
> Drop support for standalone "snps,dwc-qos-ethernet-4.10" compatible
> and "axis,artpec6-eqos" as there are no users. Also drop the
> "snps,dwc-qos-ethernet-mdio" as it is also unused. Add the interconnects
> and iommus properties. Replaced the example with one from Tegra186.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] dt-bindings: net: Convert snps,dwc-qos-ethernet to DT schema
    https://git.kernel.org/netdev/net-next/c/47d30748de0b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


