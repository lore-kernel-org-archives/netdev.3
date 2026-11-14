Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794616810;
	b=gWDxwu0uOxyUkN0uWxQxnRDyz3hntHvHhlNEabgX999t8blDCVvwqeAySmhphbEAn5/E
	 R06IkrlJ+lhYeIXFXhYBh11jT9e1Rg9HN5ZlNY64Ou9yoemcMUc/rs2LlXMnz443iR8oV
	 7bDkj0kenfCFWjxEoD3s57jQOx4fWtQym7HEvceZABJo5a37Ycwhr/HWq+MxO8I6RLBQc
	 vCagTj+u9I/R5OALdjKi/KiQUEQ2cge0MPCPGqpFwAYX+kQUQZXk0B6w0IpApCIKUMZSz
	 fO8V9hFg7hgSP+w8o5OLaT9EowJCWA896Agan7cHe/XAGrKZ+3ZaIfe2u2Z1B6vbLTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794616810;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=HlpN+6N4wdz+X9YKdUIv7dUef/LnUlg+4JxFAzxEzCo=;
	b=CEudSFZbA/kfJ8K67YGygTIaxyTDaHTDGU6NIZosNSMwiu73zq+mT6ngMFzhSfnKqz6W
	 mGujfEYtcSOpE3q/6X/U47hokuJl2l9R1q3dmWVQ54a5JVYMjpBVwEBMY2yj8A95MIIyx
	 CBrdpKtfaf0bK0EyT2TAJiaCiqaUMgm9W+qalnymvb/ihZRkZzA5LMQKNNtM7yt4wiUyT
	 uRtdYGjxdyo3VRdiFyxWRlrVH6XQms3hl4+oXYswhHoGv389WkM/o1cajXRFozr+r23cb
	 u7D8PtSuL5lCmxXObk9DyRTY9CLZq60zxLl2SJY7KLBSYEE6XzFFv0I8DFvQdI0BDlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yaul+esp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5476F606A336;
	Sat, 14 Nov 2026 00:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yaul+esp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE26C1F000C4;
	Sat, 14 Nov 2026 00:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794616809;
	bh=HlpN+6N4wdz+X9YKdUIv7dUef/LnUlg+4JxFAzxEzCo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Yaul+espwDc1EwlcYxOdjs9e1WIh9eoTYWSlfPxQqCr3CrvsKNelto/8tiU6TNtyu
	 vceW37JRAl9rXKFNhGn8BbSj7zo3i+hQBD/tzmM2fMuvQcP49m2flnNOXVmn8YcVjc
	 OGLjtpkNSCULAg/inqFaAuGxmUH2kWSqi2gqL5EkGYqr9yNt23BUQ9xVoS4Xvo89Cz
	 /CqxdQ96GEGToP/TbtO4ec+MPJFymqIcFNkPGIeZiVzlsvK9REOyTRsZ+Ayi7kR+w7
	 y4THZFwvZfEdqoT8ZoLJ2lkr8db590GyNrqA+Bcu6FIV1uRzQ3KsBP/3W33andPvhs
	 Mu81NZHddAlhw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B455C380821F;
	Sat, 14 Nov 2026 00:40:09 +0000 (UTC)
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
Subject: Re: [PATCH net-next v5 0/2] net: usb: lan78xx: do not use
 uninitialized
 data after short reads
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179461680827.1918448.12775877038726661990.git-patchwork-notify@kernel.org>
Date: Sat, 14 Nov 2026 00:40:08 +0000
References: <20261111013454.34542-1-law.wei.jie@gt.tech.gov.sg>
In-Reply-To: <20261111013454.34542-1-law.wei.jie@gt.tech.gov.sg>
To: Wei Jie Law <law.wei.jie@gt.tech.gov.sg>
Cc: Thangaraj.S@microchip.com, UNGLinuxDriver@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, woojung.huh@microchip.com,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, 98lawweijie@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Nov 2026 09:34:52 +0800 you wrote:
> lan78xx_read_reg() and lan78xx_read_stats() accept a control transfer
> that returns fewer bytes than requested and then use the uninitialized
> rest of their kmalloc()ed buffers. A device that sends short replies can
> get stale heap contents used as the MAC address of the interface, and makes
> ethtool -S report them to unprivileged users, including kernel text and
> direct map pointers.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/2] net: usb: lan78xx: do not update statistics after a failed read
    https://git.kernel.org/netdev/net-next/c/faf25c2bc6af
  - [net-next,v5,2/2] net: usb: lan78xx: reject short register and statistics transfers
    https://git.kernel.org/netdev/net-next/c/ecb8113b5b32

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


