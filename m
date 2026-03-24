Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F284363097
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 11:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774351827; cv=none; b=fgXfCo0whJpdH7PYDXWlYQM9dMP3WVpSdEScyF7E27+IG+WyjEyI3mQBXD7C1vLM5Dg8sD1TgFfj/YRuHJ4azxo95huQJS6G1g2IviWeYm2xmC+cblpVjkQN3vPNyNeVrmAJdmTWJGIsFXKC5WccLZFVKUmlDDIfCpZrAug52mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774351827; c=relaxed/simple;
	bh=ACHRu09XIYxTt0zZYe2MJ/mWwqJKU/RLKTwYfjozmYQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MCZLb/1u+hJkh1sE+v5V1U25lzBCpGN/kLgC4UB+X5zYhcCzKtITGQIaLERkBtx/gbneCI8tB4zKNvOr+mUZYc7gGNz6QCrSMFkMlY7egXZhLgbvrRYivgmUrbwTTpUUoIM2ij3+PjROedvB3bkDkHN3IisAE7MsYtTY4n0cJ6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sub/QWq9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sub/QWq9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD77FC2BCB1;
	Tue, 24 Mar 2026 11:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774351826;
	bh=ACHRu09XIYxTt0zZYe2MJ/mWwqJKU/RLKTwYfjozmYQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Sub/QWq98WrFtQfyM4SLLQypjahpUE0G3D2Lmu9UWp4GJtxEafRYdHdSaiFoDAjWr
	 o86Jfi3dx3MfvWCmwEMboUF9BRJJ8nb1eq7V95nVCgXW4i+zyoiQ6mNtE2qlCfULqs
	 4jmn+oemFpLaBJAjS9pHbjm7P3MtwCG06jtz7ioFb2QQA984kGB3h8O97V9TuvO151
	 dC9DH7CV5A1wW7DHlMq+/7o7qdjKxFe2yJJUagP+D3Q8FLb9yz6Z4B/dKHZlSBRuXU
	 GDT25G0m8zcM2q7bdzbbIRwiP3DI1LH1b+A/JcwbJB4NUc12JGx7wpjaNqduxJBggI
	 yc3LGs1pSxhHg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02DF43808200;
	Tue, 24 Mar 2026 11:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: ti: icssg-prueth: fix use-after-free of CPPI
 descriptor
 in RX path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177435181453.632762.9983445279705514953.git-patchwork-notify@kernel.org>
Date: Tue, 24 Mar 2026 11:30:14 +0000
References: <20260320174439.41080-1-devnexen@gmail.com>
In-Reply-To: <20260320174439.41080-1-devnexen@gmail.com>
To: David CARLIER <devnexen@gmail.com>
Cc: danishanwar@ti.com, rogerq@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, horms@kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 20 Mar 2026 17:44:39 +0000 you wrote:
> cppi5_hdesc_get_psdata() returns a pointer into the CPPI descriptor.
> In both emac_rx_packet() and emac_rx_packet_zc(), the descriptor is
> freed via k3_cppi_desc_pool_free() before the psdata pointer is used
> by emac_rx_timestamp(), which dereferences psdata[0] and psdata[1].
> This constitutes a use-after-free on every received packet that goes
> through the timestamp path.
> 
> [...]

Here is the summary with links:
  - net: ti: icssg-prueth: fix use-after-free of CPPI descriptor in RX path
    https://git.kernel.org/netdev/net/c/eb8c426c9803

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


