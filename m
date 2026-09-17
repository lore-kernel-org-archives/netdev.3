Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C94F58FD1D;
	Thu, 17 Sep 2026 14:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789654926; cv=none; b=e4sg/gtnDobBXI0zP0sWMpbeNehyOIH6/ZCHyYoNYMEXQh553KoVZH4pReO+UzqTsjWB9cFfPeBldiwI3MKH+tdYLrMMENMCiFW5Kw8aN3sWWg0WMTY7Bb83bbbH6bAyoepdkz1OQBs28rblyTsKeMwz6hvWITaxATiKwQgXrxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789654926; c=relaxed/simple;
	bh=ip1flpcRIjMldJWNOit5YtRQaHkCJwO5mD9/2P4s+HY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=s98rA5vS7mOY1Zsbfm9Z6Kctix84Hb5SXMaRWItmOkfBZ2ymRQh/seK6Ea4JhhQ3tKLb1jfBP5XvIEYyN5CezO+p5Kv3Pck0yVQovRUFXzEm+WtteTC6Lp+GMlsLeZVScY4rM745WlpxnrcdruD9YNTpfJMsfzrbQTiajDrfElQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=luOLLHi8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="luOLLHi8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03DDD1F000FF;
	Thu, 17 Sep 2026 14:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789654925;
	bh=Q+kB1vPD/x4kkH8oa2bN4dsg1HODvpdInHMMuRK6EA4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=luOLLHi8PurtGd4Kz5EWPBP9DpEEYaUdmt2vpFRYr5KYYx37dVvdkUh0xfyB7RxuC
	 +vrfA4ZC1nkkUsypPhGk/94CT63MQYp2GTk8IZSTMjAHREbxHKIMzJdYox9PPA0+nh
	 WjakmP0oHn2Rle1DedIZbEP+WTZTD2A7SktdYjqpDZuI73f3g/dx/P+Bj4A2ymcERp
	 OWwxVq0blM9Nul2lrfynRCwGMlDbj5BdjqigwT4tzPTKpsSUN4KTAmW1Z7vHw+1IrO
	 bzF8LBEtQ+fk9VE9TsmmBA/V0aIF0r6OjZmsNuawkGQus429crnhtiCCdoRCthwoBc
	 Z511TiEXj9mXw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A91381196A;
	Thu, 17 Sep 2026 14:20:59 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] netlink: specs: fix duplicate if/then keys in
 netlink-raw schema
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178965485830.3670790.9144403134041634623.git-patchwork-notify@kernel.org>
Date: Thu, 17 Sep 2026 14:20:58 +0000
References: <20260914-ynl-robustness-v2-1-c6125003b21e@gmail.com>
In-Reply-To: <20260914-ynl-robustness-v2-1-c6125003b21e@gmail.com>
To: Taylor Bates <tmbates12@gmail.com>
Cc: donald.hunter@gmail.com, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us,
 sdf@fomichev.me, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 14 Sep 2026 21:53:15 -0400 you wrote:
> Currently netlink-raw.yaml contains two if keys and two then keys in a
> single mapping that enforces a "len" for "pad" members and a "len" or
> "struct" for binary members.
> 
> During validation PyYAML resolves duplicate keys last-wins, so only the
> binary rule survives. Pad has not been validated since commit
> bf08f32c8ced ("tools/net/ynl: Add support for nested structs") added
> the second if/then pair in January 2024.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] netlink: specs: fix duplicate if/then keys in netlink-raw schema
    https://git.kernel.org/netdev/net-next/c/5ccdfb2c3203

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


