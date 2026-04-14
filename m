Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB862D5940
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 00:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776124838; cv=none; b=B1lT0VP63CLxky0QsAFpO4/xRGU/MrKdjaDiPSGJZ4+UyVbsH0BgjiZUk7IHnNWtwsp5Dc9LeYIoy7Jm1WJRe8iC5nEBRJJnZMq6SuOu4EKME3yH/uMF9pdne54OHBjtWvychrGYnZoX2S/1HbaCN0mG2lD/xQOW5ima4S/NJRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776124838; c=relaxed/simple;
	bh=uUXgRgZxekROlhnbfJX/9FLXh2pbw88Xdl9zxwLhSsY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=U42O96k+15Ri+7pcey9Oq9f8lT9rEOHYis5yAFROm8MvzpU+zL/vs9rVXi3TZYwRUTwNyJ1kpHwwgCCiC9z/9zArhxFEt3M6ZBu+r/Dlgnvu+dtZeeVq3pHN+MPtLCRm60D68n0ZQ/l94AWL50Ln/bc9xDEpYOtD/J4RUokLJfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DLa77Cep; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DLa77Cep"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E7C2C2BCAF;
	Tue, 14 Apr 2026 00:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776124838;
	bh=uUXgRgZxekROlhnbfJX/9FLXh2pbw88Xdl9zxwLhSsY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DLa77CepKtp8eyhPqkxd1dmQZdPm/oF9MOyJ5N1D0f8deK+YUf+SJJkxsXWQikyDs
	 YWzcQfUQ1KxRT9qarQ0Z5sOt+XelZx0O6hLDg1PqQST4TNBfhzstT8Q2M7Zyui1UTa
	 T9pgL7VYAiBH+/Ei5kY48aDNid2R5GjJTaPDXHrRQYEiEQFY21uc87WHZFqaLx/NLc
	 miWNTNp1Dmw/TPuY+DOdr/Bk9UVl05GVTLX4hNjLvgIYBSY7ylFcwGgLJSrFOGapAN
	 B9GsSUMDCyrbl+0Wv4THFUEri5HZdj6c9/tr+cSAbNrvj+n+Iy1Duqvk5BNziOprYs
	 fnKgayXDOqydA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CEC83809A0B;
	Tue, 14 Apr 2026 00:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] net: airoha: Preliminary series to support
 multiple net_devices connected to the same GDM port
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177612480929.606407.7600477899196250547.git-patchwork-notify@kernel.org>
Date: Tue, 14 Apr 2026 00:00:09 +0000
References: 
 <20260412-airoha-multi-serdes-preliminary-patch-v1-0-08d5b670ca8f@kernel.org>
In-Reply-To: 
 <20260412-airoha-multi-serdes-preliminary-patch-v1-0-08d5b670ca8f@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
 xuegang.lu@airoha.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 12 Apr 2026 19:13:11 +0200 you wrote:
> EN7581 or AN7583 SoCs support connecting multiple external SerDes (e.g.
> Ethernet or USB SerDes) to GDM3 or GDM4 ports via a hw arbiter that
> manages the traffic in a TDM manner.
> This series introduces some preliminary changes necessary to introduce
> support for multiple net_devices connected to the same Frame Engine (FE)
> GDM port (GDM3 or GDM4).
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] net: airoha: Rely on net_device pointer in airoha_dev_setup_tc_block signature
    https://git.kernel.org/netdev/net-next/c/360d745a5319
  - [net-next,2/3] net: airoha: Rely on net_device pointer in HTB callbacks
    https://git.kernel.org/netdev/net-next/c/8baf4bf72ef9
  - [net-next,3/3] net: airoha: Rely on net_device pointer in ETS callbacks
    https://git.kernel.org/netdev/net-next/c/ae32f80018f0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


