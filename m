Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C88736C0B5;
	Tue, 10 Mar 2026 02:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773109216; cv=none; b=LAUoU20NpW6xfQcddiDeTtVoU/WMjTwLIpD9T1bx5wSBbyEkiLHxYqek/RmzIpVqLMRQRuARw98QBozr+SLCHCJ47+Kb7cl94x4lfcDBfAiKNR9HWe/HNyG7piKCPdapgdtjBQfk0akYHJEfdC7ATPfawLSPuwPxHjtTvdUCU1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773109216; c=relaxed/simple;
	bh=iNny7nXjxyCyVafYMxf+wvIGjXGtRtw3cCHxOMcw4rI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Hm/QYi0tVz2WXQpxpBzfDLyq5Pt+39zRNcdJBwz4Iw5ecuF+NreYywB2GAR1/nggr13zHOBuo16Mh6G9IpupaZO3h+70Ar22Gfv/DHJNZVY/J56XWl9CILw1SVOv/Y8GFiwjWgaeQxITEmiQ+yZ6QFDQ6rEECYCI9PUqOtgrvk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ib001/7N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ib001/7N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FB4DC19423;
	Tue, 10 Mar 2026 02:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773109216;
	bh=iNny7nXjxyCyVafYMxf+wvIGjXGtRtw3cCHxOMcw4rI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ib001/7N9dJQuK+rI4YdSYHEaZO6En7DvudW/xOGdt8J/nlGDLgF5EW3fDczwJJmx
	 4rg3fT90eJQZmiW7ndHqB3ukTkUjJ3SkXmKxRz+6icwLnbPADZAmxj7ssK3WEoQxDC
	 AF9KTP5PRhkuwMHv3B6Nk7Ja1GQMPxWM/rET1WKhAj5ofzIpSF3bmWis2fJJedo1ej
	 qiicgUP+v41iwahGQ4OKy5P+2l6ONw69zB07/IB8XajDIvoDahz/TBSLer8kI+9Rg6
	 UcVS/wcKTGIVlZslQwXK7i7HQbfRlb97JXaaa/e7liyaeiOkyMYzEo/Ri+iVXU9y1N
	 Yty4Gf3ksFeCA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE773808200;
	Tue, 10 Mar 2026 02:20:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] gve: add support for UDP GSO for DQO format
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177310921304.2028885.8390657941904839220.git-patchwork-notify@kernel.org>
Date: Tue, 10 Mar 2026 02:20:13 +0000
References: <20260306224816.3391551-1-hramamurthy@google.com>
In-Reply-To: <20260306224816.3391551-1-hramamurthy@google.com>
To: Harshitha Ramamurthy <hramamurthy@google.com>
Cc: netdev@vger.kernel.org, joshwash@google.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 willemb@google.com, nktgrg@google.com, jfraker@google.com,
 ziweixiao@google.com, maolson@google.com, pkaligineedi@google.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  6 Mar 2026 22:48:16 +0000 you wrote:
> From: Ankit Garg <nktgrg@google.com>
> 
> Enable support for UDP GSO when using DQO format. Advertise the feature
> flag during device initialization and enable offload by default.
> 
> Signed-off-by: Ankit Garg <nktgrg@google.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> 
> [...]

Here is the summary with links:
  - [net-next] gve: add support for UDP GSO for DQO format
    https://git.kernel.org/netdev/net-next/c/014c607f86ab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


