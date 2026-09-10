Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B22B48C406;
	Thu, 10 Sep 2026 15:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789055469; cv=none; b=uQuSxF2IDesgYOZgVf3DjeSGvt6COIdDlZIcv4psStxRLi68RoNwUMxZbfvH4Pdlp2UsuOr0LHONCF7khXKUFgNhnvHUKaLuzgH50HxOSXi0yRy9zZ0Bagu/gzAcLD2q9sLBFIu65bW4tLlGyHqPY5rNNm4mb3OfqPzKInX/EXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789055469; c=relaxed/simple;
	bh=2WOxcQxAy9FYpbVNgG4S8upkEIp+n+fGU5tSeGhbFiM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kaIgBGle3Nz/8atNcNn3j2KH8JiPe0up/JlL22hPNHTztgcvCXo+S06wg0ixzSAlO5RZS8KEcgOvad2z1yJQqIZKUk22yqFmGsORJDCCPkQqQ/S2DMc4e8hCdUzfrOjHW3uJQHcDOuokDsfYl8GHDb1RFyqqS5OZFLU6nUlGpKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xv+3KXKE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xv+3KXKE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E981F00893;
	Thu, 10 Sep 2026 15:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789055468;
	bh=gal8uHDUSBagG2oK1CJQ6A2SNIJiE1C3DHmPTfDnJkk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Xv+3KXKEVpc3i34jTxnwcHzqTKBDSSJBtgp9G9gO9FaL5fMW1CBwBEx5Z4qTs7v5j
	 ddI39SIgHhgOhbPE/KPFmICNy0Fv/BQlDeSflJUv+aljZe+6GwxkRrjmYoMlio7sny
	 8T1BLkgHr/qGlVR90u6gwf9f2ZG0hfGxLuhghZBWYkeRbe0wgcdqK8koVS711h9XCz
	 WmXF2NRcBm8P8yRBhSXL3hH3zLrXXdhD0RYZngnATHu9in7mPOstA6yckXDyr0VAHO
	 QqMXG6IzX/vYoQEn4ffjIRzXLjxbuwvcGgfkmgeFMI5Y6CKsXOQoEg7jHxPO+Nxq2x
	 F3Uy4X9ni3yxg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D08BC380CFFA;
	Thu, 10 Sep 2026 15:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: hsr: enable promiscuous mode on interlink port
 with
 fwd offload
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178905540563.1510486.7136914895055165645.git-patchwork-notify@kernel.org>
Date: Thu, 10 Sep 2026 15:50:05 +0000
References: <20260908090856.2876114-1-danishanwar@ti.com>
In-Reply-To: <20260908090856.2876114-1-danishanwar@ti.com>
To: Md Danish Anwar <danishanwar@ti.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, fmaurer@redhat.com, fmancera@suse.de,
 liuhangbin@gmail.com, kees@kernel.org, xiaoliang.yang_1@nxp.com,
 lukma@denx.de, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 8 Sep 2026 14:38:56 +0530 you wrote:
> hsr_portdev_setup() skips promiscuous mode on non-master ports when
> hsr->fwd_offloaded is set. fwd_offloaded is derived only from the ring
> slaves' NETIF_F_HW_HSR_FWD bit, so this also skips it for the interlink
> port, which never gets forwarding offload. Without promiscuous mode,
> the interlink NIC drops unicast frames addressed to hsr_dev's MAC
> (e.g. SAN traffic to the RedBox), breaking RedBox whenever the ring is
> HW-offloaded.
> 
> [...]

Here is the summary with links:
  - [net] net: hsr: enable promiscuous mode on interlink port with fwd offload
    https://git.kernel.org/netdev/net/c/a2dc179481d1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


