Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793271007;
	b=3dyUey80gBLgaHfehixjNFEQAfF8lOsT+OvH5jeQX1UlyyNVhenXQAP31WNcXOcIVuqf
	 KHcPn4A4wNFMf73s0fiF4I+pbEU5h8M7y7TE7fpaJ7Iph5NfbpdJD23mGT0JVzlPn8pQ/
	 H9ceSVOzwSAAn44K2Zz9VJl0XyL8+VSMibB525Y/fzKp4gh7qRCD4FRf5JHbIYh1CW5FY
	 uCuZZtf/WWLQxQTx+Endzg8tZhCknhIjwrWqYKyezRfTugfbNkrr3lGtKoAdxZwvzfJTD
	 Tsw7FXxUf6JV7KXOLF1nOu3Npg87wWeCu3ELtbBvv2IOrZEr4L+l38EI1MGhc+DAUHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793271007;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=dRiUP4dE0KJjXYFGrMT2LaOMSMPl7w6XmE2D21wrQNs=;
	b=VQ1dd2Esa/CWTEVKaljHB3U9lzpLbEtHUZgVv2VPy7OW+0CDWSFoM/5Z7HH+E7/t9jxA
	 oAOrsCxAU+xj5duYaIRFesRIKau/f/E/O3ofZmFj+M70q1T2IcDEsyKCY9Zym8iqqjx5i
	 C3unHb66c73ZEFBQPhcRIBPPOU8hZtsk1AV8EvLQepOiUl1+Q5BIThukvmvNQY8VLzejm
	 xt3EuEVFkXqnyT8H/Vda11bPNCqeTiTkPhSJkEBld2bUg2GOy85mOf0xVJpj8AuzuHEYM
	 ys66l9yvyUmEnMYzJufaxM/P452qoVvFqpfBXHq0XZiAiOmc42065cLaCIngjBkzW2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NfaEbC2b;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DBC606A31D;
	Thu, 29 Oct 2026 10:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NfaEbC2b
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A6071F01825;
	Thu, 29 Oct 2026 10:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793271006;
	bh=dRiUP4dE0KJjXYFGrMT2LaOMSMPl7w6XmE2D21wrQNs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=NfaEbC2bLUaoTPDGiJVBS+cRjA/vTpJlEBlTFaNQw0jbI6GX1w5pq90w92jTmZpQt
	 G46vzPSWcrNpZCzyYLoq6XRMWjKBl1sQw3hEDeA0LDZRy47gxCT6i5YH0Iu6OHDsnY
	 bCjIQp8Umk1FAf5VeZNzivnKYv1GYp4ZWvn08Ek1pc/xocRoeGQ/22q42wyOJbegbB
	 0dhGg95YTFRDYHcgZOCZwHoruC/9Cw5NvcLzIeI+w69gy0wKBIQehaE2MjQgMyE7bN
	 z8ztvPscvW7IRfzEVtu/Cua8jsyybpMSlHP5kTQSer3ZCbRraLZHKuFEHFWAsSIR6Q
	 oGy/KmZCNmyIg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 815153ABD290;
	Thu, 29 Oct 2026 10:50:06 +0000 (UTC)
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
Subject: Re: [PATCH net 0/2] octeontx2-pf: fix ipsec transmit error paths
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179327100532.1753346.16642826109370857631.git-patchwork-notify@kernel.org>
Date: Thu, 29 Oct 2026 10:50:05 +0000
References: 
 <20261027-nb-otx2-ipsec-tx-fixes-net-v1-0-2114c4f10c36@tipi-net.de>
In-Reply-To: 
 <20261027-nb-otx2-ipsec-tx-fixes-net-v1-0-2114c4f10c36@tipi-net.de>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: sgoutham@marvell.com, gakula@marvell.com, rkannoth@marvell.com,
 sbhatta@marvell.com, bbhushan2@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 27 Oct 2026 20:54:05 +0100 you wrote:
> Two pre-existing bugs in the ipsec transmit error paths, flagged by the
> clashiko review of my earlier ipsec fix for this driver [1].
> 
> Both look like edge cases to me, but at least the path in patch 1 (an SA
> removed during rekey or teardown while packets are still queued) looks
> plausible to me. But don't take my word for it, I'm not an octeontx2 user.
> 
> [...]

Here is the summary with links:
  - [net,1/2] octeontx2-pf: fix skb use-after-free on ipsec transmit drop
    https://git.kernel.org/netdev/net/c/14d01ff1a495
  - [net,2/2] octeontx2-pf: pass the skb to otx2_dma_unmap_skb_frags()
    https://git.kernel.org/netdev/net/c/92cb8653970e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


