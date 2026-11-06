Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794003008;
	b=wJJJ+/yjKt57yFACrCzOL8sM9K2tKx8dwKUhzpoE4vqr7bRute+vAqnSsMKJ0Zqp2St9
	 mTmEGX+7vLPuR6Dyh0yDdPVKfI+WUCCIGaHWYdqz90oi+Y8iTLN9stja7ZteHYZYQYqqI
	 XAzwi6fyw27SaxPbeC7FhH1KZAIPO4Qi0RZFXeH4pTUqA+99nJqAPkh7HoQoznH0DUXRH
	 haoQR8i/bplWH6TyS9bgfT8AlxhmMFqJ8pgCKqmpjrfJfnrlB7XNjhgdP0WETY5l/yG99
	 bPURmfuKEOVYeaQYZB+rWMKHLLVCTqhnxkETXoa67s/kYkXQoRDhcB3+3Aj0oJya76g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794003008;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=A0IxIZ7KNidKyG0DlMEYje+e0uCxo2CsIGqyQc1x5R0=;
	b=lfHIiDRn6bl1T4p7Ay4T+CnsbYuULQjKeluynb6rItDEYooa+11OpjyRrWOPI0B2564d
	 bVc+aMMa7PdEBVMS03aQAy5rDgI+uT0vfkKvm9Z+zQVDwOGFcE49gBgeeM8krTX6mVJrd
	 ps3MOr9DEEK/HxPZzH5YOylfnCyXQoUBA9OFI09mT0oA1Psg7cZv3wNG0UwZmE/q32RVf
	 hlAGgil+4ldPXN1ZcZof3iCM43ll7l93ceCgjJ3GH80N+E+eT6YUIz/FifMIgb8GLdd39
	 NcTRaDKzBGlxKOQxF9zvEJNMdqg0+ZGFDcMke4PXXJ7OMJki3+n8g5x5Hj/B25dtWZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HhLTd+y9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79C0606A326;
	Fri,  6 Nov 2026 22:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HhLTd+y9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 698221F0089F;
	Fri,  6 Nov 2026 22:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794003007;
	bh=A0IxIZ7KNidKyG0DlMEYje+e0uCxo2CsIGqyQc1x5R0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HhLTd+y9JTzWARnWMjkNk1CQO5DlniPtnPu0R+wFOX991Ukn1h1UeJcrPmGMth/7s
	 QE4HCypaghnUqoTo+1R3MNz+Dpxjf7k20ecycng9T06z8HLd3CsWQ6Srxo8thomCIB
	 Dj58EzY0En4Jkdz+OnmQMisctbtpdS/rMDh06l4aMo2IfkzhHf/Lf8yXmRW0B3Kuph
	 AkX1Gi2JgopWe+xRILA+Q4fiqWUSpwxEi3XO1m4+Lx0uOJ9fXCDxKHSdtvWenI5Hq1
	 4V4J5c0eCt7F8Hc66b/b4PnbsCMJFGAbuDBUjN7AbceTYNrpE5GKMZ6lAxkhzn46tM
	 45EE0aF2VK4tQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5E35C3A549BC;
	Fri,  6 Nov 2026 22:10:07 +0000 (UTC)
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
Subject: Re: [PATCH net v5 0/4] netconsole: fix target enable race and
 configfs
 read locking
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179400300617.899981.1200767278484963659.git-patchwork-notify@kernel.org>
Date: Fri, 06 Nov 2026 22:10:06 +0000
References: <20261102-netcons-fixes-v5-0-bdada2f03563@gmail.com>
In-Reply-To: <20261102-netcons-fixes-v5-0-bdada2f03563@gmail.com>
To: Gustavo Luiz Duarte <gustavold@gmail.com>
Cc: leitao@debian.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 stephen@networkplumber.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 02 Nov 2026 19:54:48 +0000 you wrote:
> While looking into the sashiko report about local_ip_show() and
> remote_ip_show() missing proper locking [1], I noticed a couple other
> places that need locking:
> 
> Patch 1 fixes a null-ptr-deref when enabling a target races against a
> NETDEV_UNREGISTER event.
> 
> [...]

Here is the summary with links:
  - [net,v5,1/4] netconsole: finish enabling the target before releasing RTNL
    https://git.kernel.org/netdev/net-next/c/f94b9640bcf2
  - [net,v5,2/4] netconsole: read np.dev under target_list_lock in local_mac_show()
    https://git.kernel.org/netdev/net-next/c/3733db02b88e
  - [net,v5,3/4] netconsole: recheck device registration after waiting for carrier
    https://git.kernel.org/netdev/net-next/c/6891cd198752
  - [net,v5,4/4] netconsole: stop waiting for carrier once the device is unregistered
    https://git.kernel.org/netdev/net-next/c/a2b4d25e4ddf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


