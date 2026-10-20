Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792525219;
	b=Lj+cnPd609pll5migWWu6FbmMMRva7v3NbdCO8i3RAn+s3yuI4CAOOVzUueFWB3VwQ8Y
	 2PX4jUzbAPPk4tNYOwv5xmCszlTqlDYWjs+yluK/2npHMDy7g9MxzfU7veAUdZhTDlZac
	 cgA/YY3qaSjMHLRVindIFws6hmj3qsGgmy8NAZTR9tJkEC7OnAlmecB+1h5JQ0MQAg21Q
	 whkpVpWlRCXUH7IewdTNdxarlgAdbcBdrf4qDdvVTIhMFVymgmuOsNJ0gTcFIypQv672C
	 vzsgtJr3cc3E2gOdrdkbmfL5rfiJyIYUvsO2aX2uV4x7B2r+YVAFxeK2ME68UW8T06Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792525219;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=g1B74R+zLZHlA9HxniMCCtlrK9GjZbxo0yBtw/MgAzg=;
	b=GPleaFZtPsRbcayqMDpfMNutBSUzQoVvy470GISbo8l2wDvruFkTx3CyGYWDBiSbBNso
	 MxSfnyjFcZ03FyrTC97SRNjBClZvCEare082O024hYDrci6PC5xZd9PSoRqQ+pa+NdbiK
	 bra9n7Sajp/0mCnzxvxVeSJMrDlFtpNQM97fKlMQgQ5L6hg0AHkx7c+OJ7BBOCDVs6H0A
	 QNscbRnHgt5TYPI6NCsOkCSRqOPr6qagOODkBZP++6v5vompLMkhrZAN48PIY0ZV/KWJ7
	 r8g/EI8VKcv2WEm873LuNgdrYuE6HOZkykY4bfUcb4VT7b2w3G3mRlIzeeH3E7L0kPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QI+zog0Z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5158606A320;
	Tue, 20 Oct 2026 19:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QI+zog0Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82A491F000CA;
	Tue, 20 Oct 2026 19:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792525218;
	bh=g1B74R+zLZHlA9HxniMCCtlrK9GjZbxo0yBtw/MgAzg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=QI+zog0ZCoioej/m1jLEW0rDaQVhIX3x/sLBnJfdSO1ySif9tJ3zs2ew0AMX7mRz1
	 TGOMxXPMLbUZLgzgrOm4cW/P0g1CxE5Bhm7fxhuUguAv5G20rOhG74RBBbbxZUVJ0H
	 Ka3E88pQBIgniDNqG/KlajwPvepGhdMNgcQvAVhAOnWG6GtXgTRsfLcVI6+HyFdQkj
	 lkXS72ohuOimGr8WEb2C4cE97NhG2qk/bNkTcV7BbIEx8gQbTYubsXsySWAl8JBkWj
	 XSJpghjPXErk1sw01uCMrqc/ZRQamMuLA9JcGtedSD4B9ejYl+3rwa2p99PUz7RYNi
	 kmwP8g2Y998Aw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 773D13809A09;
	Tue, 20 Oct 2026 19:40:18 +0000 (UTC)
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
Subject: Re: [PATCH net] net: qede: initialize extack in
 qede_flow_spec_to_rule()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179252521702.176933.4914190610931500796.git-patchwork-notify@kernel.org>
Date: Tue, 20 Oct 2026 19:40:17 +0000
References: <20261013105451.201211-1-avirdi@redhat.com>
In-Reply-To: <20261013105451.201211-1-avirdi@redhat.com>
To: Anirudh Virdi <avirdi@redhat.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, kees@kernel.org,
 horms@kernel.org, ast@fiberby.net, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 13 Oct 2026 16:24:51 +0530 you wrote:
> qede_flow_spec_to_rule() declares a netlink_ext_ack on the stack
> without initializing it. qede_parse_flow_attr() and
> qede_flow_spec_validate() only set extack._msg on error paths via
> NL_SET_ERR_MSG_MOD(), so on a successful parse the err_out block
> reads an uninitialized pointer. If that garbage happens to be
> non-NULL, DP_NOTICE("%s", extack._msg) dereferences it inside
> vsnprintf, causing a page fault and kernel panic.
> 
> [...]

Here is the summary with links:
  - [net] net: qede: initialize extack in qede_flow_spec_to_rule()
    https://git.kernel.org/netdev/net/c/106e562966a0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


