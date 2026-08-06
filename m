Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1567237998B;
	Thu,  6 Aug 2026 00:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785976852; cv=none; b=YzR1t7IChaDrLTHwLLddM2VVymXls1rbbtDxohTl0oi0tmRiwrqCp8TDcJBVFmtCBgcofQ4+t3LnSa1kx2pnwTWFgak4nw8O3VMej0hboiMDIU5BpKJLwRNnjQtdYLc/iNarW7NwBj8Kyh2z2wGUgKV3dYgFVaLpsOpVF4hybvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785976852; c=relaxed/simple;
	bh=epIlwySHSMFovlJDLcq4SRWgCtGs8SkJqhu3Y+DQN9s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=R8Mo8mndhWq/d2iBYRwIjMhpnsGdNiJ47Zu0ORxRn130xXFFiJl3AZkYWx3qSM/AsHWdtxty6z71fvuuoPcYe4I2LHn6oeoB76E5H15zLGHrhCrKQb9vSuaZyru0cwxignB6zQGRv/zuWvjntpAO7KF16+gSn82cEuC+QTenjGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKtbExGI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKtbExGI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E53C91F00A3A;
	Thu,  6 Aug 2026 00:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785976850;
	bh=AcdbAc7v5Q8RXoUlb2EzbGO1I62hGbLniigedcE43hw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jKtbExGI8HFIJBEs5VHicEMsByAXDu5z8wVWiLULaWp3pdBOBxWCjE+5RsxJ5kNZ6
	 cGsUHSlsI5pI9gUX/CKVZhjg9ecjGdA3Ggcys+HGqXFYd9K6ZdWUuHUYV7OVnXJ7OO
	 wk50YP8GQC264L4aRFFWVX1ZtUSV6inWAfLfTmCtoOPlNSo5YptVKbGR4puDhsfhht
	 neTm3H44F9Tx22ZQLkRlgDKndb8oGzd413Ifq+8OLmGdBgiIfbi4Lq8KPzYdR4Wy4t
	 hDRDgh0YPXFMcmbiF4EXZf5UmqzZGYqluQyWjvetIZ7y7MLEUCpPTK0QmqYvev8F34
	 Sp4FP3Maw0xAg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A03392FFD8;
	Thu,  6 Aug 2026 00:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: prestera: validate firmware header length
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178597681039.580024.12661606336457263473.git-patchwork-notify@kernel.org>
Date: Thu, 06 Aug 2026 00:40:10 +0000
References: <20260731141500.1-prestera-v2-pengpeng@iscas.ac.cn>
In-Reply-To: <20260731141500.1-prestera-v2-pengpeng@iscas.ac.cn>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: enachman@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 31 Jul 2026 22:19:06 +0800 you wrote:
> prestera_fw_hdr_parse() reads the firmware header before checking
> that the firmware image contains that header.
> 
> Reject images shorter than struct prestera_fw_header before decoding the
> magic and version fields.
> 
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> 
> [...]

Here is the summary with links:
  - [net,v2] net: prestera: validate firmware header length
    https://git.kernel.org/netdev/net/c/8ae344eb540a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


