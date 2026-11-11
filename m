Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794358214;
	b=39XQItAJ/ka/ZnAyCyIMp23FZPWeiRYjsZb/3BIm1qnutVkUCNdWrYx30Xwlgpz2+HaI
	 +AWZ54Q7gWnPQ4YNjEKUs3roile7B127uoLECs9r3gN0EuBFbO3Zi8V8lt9P7cQwIFSFe
	 rfSWOoPUOYovSki+sEdiZ92lJg1r6NECJC4Re2MBItFEsZhSAg0B1WeNWMC+mnvw9EO38
	 of6aVxUTafCJ9bWZOtHdvM2uIs7Okm2XUNtJ53RYJhfqlSRVXozU4ajL3XlOuQAR2UuHA
	 GkMKrl4sYoz07pgsIazou9BJPsdENou8G/sGQCsAM5nDgpDOo6zp3RHWpXmfEiZ69sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794358214;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=TXETTPPRVF+HNiL1JDfhK3+Odg9X5L0s6YqExft/M58=;
	b=c9RifpvegEshkiqlfdzfZ8A5r5rUe1Rcis+ashOf/NZQjSJh/qBitt4Q3H7ciO1XFFLs
	 4Dn6TWSeOtxZiFxD7men/5oNtWHPx3VB1IWZgQ4nvGCQ0dMYABS+cOjpQpLr+R3xShgIt
	 dsghUM6Lqa18boaDQV82/5+utJ6RbDdZzdBcuP33nNNztr28rUq/85tO3iRup5U4c1ptK
	 Tpai8+tw62D/falFDVMy3n1Y8m2Q01vyX93YP8JiWALFm3deTZYHDXDXS/xNfkZLG8EgV
	 Ky2y4k7SrjsAaGEsbZl1A+/6iQezb4q8pxqgH/uoqFVCmUedY3MowjJQcDTodiSbayA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="aLsL/HDI";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5618C606A33E;
	Wed, 11 Nov 2026 00:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aLsL/HDI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C3141F0093C;
	Wed, 11 Nov 2026 00:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794358214;
	bh=TXETTPPRVF+HNiL1JDfhK3+Odg9X5L0s6YqExft/M58=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=aLsL/HDIZvha5C4UASbyS/8/oVMaiH7y+qfKFJsCXtFfgjRBqu3k2mhnpw7CSVusn
	 DTLKMNvUdumkNdWSdIPTi19z3ZAdWJn8gnmMxSSzO+4tuHGlP6VnlMU92IQYtu8Wz4
	 o5PRmVcXER7KBkqzTmNj8ZMUgxv5RXbL6NFLEhj8IWyg3FaMA5gBMU6F4QhTFHkgpo
	 du8WqP2QFNMfCCzPxMFSFja8O3s/U4IsCxTJ0xLjd9I2KvTdZKWCEy0maVEaYMhcw2
	 AxESCG0UX5+WvHOh1Ms2i8fjr2djtyyLYDiu3SZ+XUG7dnTZfdUuVumad1sLn+jJwP
	 wjZY5as0LwZrg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 2108E39E8A55;
	Wed, 11 Nov 2026 00:50:14 +0000 (UTC)
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
Subject: Re: [PATCH net-next] dt-bindings: net: add Realtek RTL8125 PCIe
 Ethernet
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179435821267.142717.8246984206000823163.git-patchwork-notify@kernel.org>
Date: Wed, 11 Nov 2026 00:50:12 +0000
References: 
 <20261109-dt-bindings-net-realtek-rtl8125-v1-1-cff4b8a8be66@pardini.net>
In-Reply-To: 
 <20261109-dt-bindings-net-realtek-rtl8125-v1-1-cff4b8a8be66@pardini.net>
To: Ricardo Pardini <ricardo@pardini.net>
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de,
 sebastian.reichel@collabora.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 09 Nov 2026 02:53:47 +0100 you wrote:
> From: Ricardo Pardini <ricardo@pardini.net>
> 
> Add a binding for fixed/soldered Realtek RTL8125 PCIe Ethernet
> controller. As a PCIe device, its "pci10ec,8125" compatible is the
> Open Firmware spelling auto-derived from its PCI-SIG vendor/device IDs
> and is already covered by the generic dtschema pci-device.yaml. The
> compatible itself therefore needs no binding to be valid.
> 
> [...]

Here is the summary with links:
  - [net-next] dt-bindings: net: add Realtek RTL8125 PCIe Ethernet
    https://git.kernel.org/netdev/net-next/c/711c458f6f34

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


