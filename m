Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793056809;
	b=dgWbXFXIGsKlLk+zgcCZB6Hm9g1MUf9/O20JBrCFEHL2kiN1XcHWH8zvO64++qgyYeo0
	 7DzGUQd0aKbecI1JN+5+HGiSGfA8/e2Ychov5qtupTyUpILXcB0EfLGrHS6AZqcYQ3RWq
	 AV+y16eHJ5J5AvSX4y90+3Vng7pVJN345MPnUE9YRAzHyWfQmeuVx5jhjXi4w8k/DtXTR
	 o/HyNNCYr/2jEKfmv7gNupMtHl++zvxhNTcvJwqI+M9WFBBr7uewtGrKkDJaGLV1trUXs
	 OBPmPpoKhfW4nU//OSUw7PNc7R8Il3jJ0fx6Q0ggmiqR64gvV4t1Zag1ak7/x7414IQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793056809;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=DcJrrkGlpe/1ePRnU9+2recCbP2BuwO9gOSF2VkPVyM=;
	b=XMiAJeOPE0FVclXrlKji0pRNqYJmzB/c7WobXe4HOfNUSTIQT4PfgUExdzfTlA+Gb4Pp
	 o2W6eEXF9Y2NV+GHK8QGAovcWTH+JWbtY0VaLJzyozmrbZkoaVWQ7qEV0lr+k9ts/NqVF
	 e9mX+5MfUeW5ynxqvscWC9RSm97ftAkyoCPWrH5qOMdSxqgxIkAG5kDFreU7ZjlVMAw3z
	 Ywus+dNQ2FbIp6sDfdVwjRNGZSzhoLSQrO9AwnZ6+hokBGq4cRmhWuA8XHPf12Nd1gNH+
	 NTZflp/NLWpCGlLy4JtBrHTlumef9h/SGrrWz6609Ps/xizyRYGORBETovabJxzS+Sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X2yr45Ip;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD753606A31B;
	Mon, 26 Oct 2026 23:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X2yr45Ip
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E95E1F01825;
	Mon, 26 Oct 2026 23:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793056808;
	bh=DcJrrkGlpe/1ePRnU9+2recCbP2BuwO9gOSF2VkPVyM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=X2yr45IpGAqn23OzTwPQdMrH0BkKlt8+GilcEmpPh3JqsUS5TTpDADjnci9N7PvYS
	 RYh24qY6L9pDIchF+XHK05eM1zGQhw3J/DmJvIesacsrx4K7bFUGzB3Gz00bRwi1Yv
	 CFYykc/y1MqDdAQ2DpRZeJ+xn1lfOkBuE9hprKtLs+xEp/hvcxj3ZXVAVMgGbDct39
	 YSIUuoOihU+k5++yTVwv/yeejRsXOiJXNuq9F6QltryOAMXW8rOR2VTN8hUo84VxGn
	 eb/8DIYzO+yMh8APvnTPu3s7+uXDQxul3a/D3EJ0Y8u3YR5Ufpd1adxB9w9E56PInH
	 z4M9bXTeUuXBQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 444563AA80F0;
	Mon, 26 Oct 2026 23:20:08 +0000 (UTC)
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
Subject: Re: [PATCH net v2 0/2] net: usb: pegasus: fix receive length handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179305680682.3450824.8798469906798497439.git-patchwork-notify@kernel.org>
Date: Mon, 26 Oct 2026 23:20:06 +0000
References: <20261021020310.34045-1-law.wei.jie@gt.tech.gov.sg>
In-Reply-To: <20261021020310.34045-1-law.wei.jie@gt.tech.gov.sg>
To: Wei Jie Law <law.wei.jie@gt.tech.gov.sg>
Cc: petkan@nucleusys.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, 98lawweijie@gmail.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 21 Oct 2026 10:03:08 +0800 you wrote:
> Two fixes for read_bulk_callback(), both reachable by a USB device that
> identifies itself as a Pegasus II adapter.
> 
> Patch 1 fixes an out-of-bounds write: on the 0x8513, every frame that
> is dropped because of an oversized length field advances the receive
> buffer by two bytes, until the host controller writes past the end of
> the skb data area.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] net: usb: pegasus: do not advance rx_skb->data on dropped frames
    https://git.kernel.org/netdev/net/c/bfa09dccf98c
  - [net,v2,2/2] net: usb: pegasus: check rx pkt_len against the received length
    https://git.kernel.org/netdev/net/c/efee699f6de0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


