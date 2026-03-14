Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C15335898
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 16:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773506665; cv=none; b=Y1BoWAiOtP95cUFip5zhfpRu23hQPxPEjcD9KeVxv/N7gmzkqWQ0jM8y11q2czXfySKa9HvaqHHbSiItICA8112R8WYORK3EFCIq/Q+vWRb9Jo6WH9V+PVfVdCLErylMGvLzFNDhyvC2sXRaGY1zupgSNktf7VNeNKqx1xJJkNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773506665; c=relaxed/simple;
	bh=1AoH8p7scZskefPdSpTpd3T6tdQlotazxTP2An3TiE8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EY/QiQdO19BNCggmiJSZVFc7VgXMqj8hdKPeDX9dW7GPxp5UTLb4zw9D5/JIXgLG5R7w4XhQEEO/d7LwlRZKAGTkhaz6DO0+0KgyAD7PzX4izwbCt7M5vEKhT2PvdKLgj1FhNYPSQxIsqwQqAdkt1G27Y3B9WwLgnUilwpuOp2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kv0lBT0n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kv0lBT0n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 621D1C116C6;
	Sat, 14 Mar 2026 16:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773506664;
	bh=1AoH8p7scZskefPdSpTpd3T6tdQlotazxTP2An3TiE8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kv0lBT0nC8OWGRbH/dIwtr7ftpPdLhzdSulMbcy8vaJ9JuWNKBGhFuXwp8RSajf+/
	 v0TIz376XDEql39GPYvARZOjp6vv2RPWfy0IZ/LQ/awhKcAg/EVNfnW5ViMux/2MXh
	 meQl7oOzOZgH2Oob1yfX5qcR4QfcDHTvq7YiKLGqA1TWRuJbzcUpgKhXVmxxlEkGIo
	 5xjmCf7g7KzYm1EvR01yyTFEZKWPubEmSCODX3KS9lDAq2M5WZ+gJQvStZ8uWRF9Zn
	 E+LVaLQIpTALG6wMGQN3dJU1x5BPO7Z5ajw313TXWR09LpjJMZyxUneYkJt98fY8jV
	 GA/lxEOwk81CQ==
Date: Sat, 14 Mar 2026 09:44:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org, Paolo
 Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: stmmac: avoid passing pci_dev
Message-ID: <20260314094423.6a908938@kernel.org>
In-Reply-To: <E1w0evI-0000000CzY7-1fyo@rmk-PC.armlinux.org.uk>
References: <E1w0evI-0000000CzY7-1fyo@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Mar 2026 12:13:52 +0000 Russell King (Oracle) wrote:
> To avoid unexpectedly exposing the device name through ethtool where
> it wasn't provided before, add a flag priv->plat->provide_bus_info
> to enable this, which only dwmac-intel needs to set.

Seems fine, but maybe as a separate patch we can expose it for all
devices? Is there anything special about platform devices here?
