Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335743B9D97
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 23:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786405901; cv=none; b=e5Sd0p1q3Dus3P6EpeEYQtbjIM8pOduJe+bLpdLfFQvj5BBIjK+8/DcT+l3D67i5SzPG5IzKZBwxbRL6JTOe1YB9obRsvqJfFyAIlu7JYd5p9PO1w0NSyCYtH0h02mgFE3kaq8xC4GMFZ/3Xqi5pUt4KPEKi9OaLVB1MTkg6inA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786405901; c=relaxed/simple;
	bh=Rs12tqQ6ibMc1aUO2DC20onPNc+HOGSS/y9mgvCEl+k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tAUAg091xUqMEmAYYkboLz9Zs44p2kIZ5teMJVhOAGJbST4Uq7a9+IFtWkPAnH+c/+fYM/g4x7K6SnYla7gDIO3OwRp0brdbaTWMhR1N9LDytDVr5SFoPTgVLk8sxXXRfz2J8adHpXV9ZQdH8j5OheRCQ2nIWAzbClhhi6TIMl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oFFnzEGR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oFFnzEGR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 190C21F000E9;
	Mon, 10 Aug 2026 23:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786405900;
	bh=iJPG2nyeehd+FvTFn18FcDPwT+qREgZP8/FMrN0IqpU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=oFFnzEGR/W0EzzcLSMwO+M3hpFqpPKj1BQZa9h6Kq529UTfrYOqjUJbL9SMML/9q7
	 VNhF9bIIohoXUdMmbYCOpSgbseI9WycEevloB6NxxctzfhTWcLmuVdLrZAw+yefZ1q
	 uz58S95hWuvSV/yWNz7MPcG29F+/xYCmbZogNu07l2bWdG+Vhg7rD3ZluJsldw7MXJ
	 xBjp5prObZHdkLuaY6aD1vHu7wnH7osQdgmRgG3t7dWyFlDDrITrczGIz4aw4jdLjw
	 RgbvWq+SlZokJ33zl2cp9G7/fXFyMmCLf/6OTCEQ3RaRcE3lRaFNdLGjG1U8i7nRHA
	 mIcwUMLgL1XwA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0995392626C;
	Mon, 10 Aug 2026 23:50:57 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] netdev: check for nla_put_u32() failures
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178640585636.257874.12469697387477130082.git-patchwork-notify@kernel.org>
Date: Mon, 10 Aug 2026 23:50:56 +0000
References: <20260809000609.327659-1-kuba@kernel.org>
In-Reply-To: <20260809000609.327659-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 daniel@iogearbox.net, bobbyeshleman@gmail.com, joe@dama.to,
 razor@blackwall.org, sdf@fomichev.me, dw@davidwei.uk

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  8 Aug 2026 17:06:09 -0700 you wrote:
> Make sure we check if nla_put_u32(id) was successful after creating
> objects. This is theoretical today, the skbs are large enough to
> always fit the ID.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2:
>  - don't handle, just WARN
> v1: https://lore.kernel.org/20260609190804.1137085-2-kuba@kernel.org
> 
> [...]

Here is the summary with links:
  - [net-next] netdev: check for nla_put_u32() failures
    https://git.kernel.org/netdev/net-next/c/ae2998ab62e4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


