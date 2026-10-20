Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792491007;
	b=U7xS7j3fuWmfvtKTc3VVakM3x6E7ZyxWneOaII2eljabnVJaCH+8g1SXBpdHBf/Sz+YA
	 B9Onz6Mw/Xx1Sij/M9FUJcdfAJMSlbZ9O8zNet/jEYaRcepSAAAQ4r47ifqsgClNt1zHu
	 uGuzVpE07qKVBWfSLarIAaW9OV1LBEuqtSUPxSdCwesIsnPxnVzahdjjqZLy42Jc/XfSd
	 /NAMLADcA/+cM0c+YkTwvurMb2BWNuWFAbT1ipyby/SpfFlwpCeU4HjuF9SYHAgjQvp1B
	 kSI7OcrhuLrHJ+FVon7h/Htuv7658yOYb8d8f5ohlWJCfk+dsYleocr8hDj6oj7Bzag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792491007;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=gSKeR3uJsOc/jsn43qIo1ksdoOnSrNbPSsujhyqJUjo=;
	b=1NePV1d2zB5uBBrSM/ffl34AVFiuxyt0NWDbhe7LoCXzxv2Qald2QL6dAlpgFClSgtyy
	 G3KJXXIN3MHhdLTO6EsJbKDDSJYKjqzVgRXNznnK879rk3P2SvvaTNyFa7VPMeGwJKsIT
	 +xDuSZv12eG8boXOzLuPcP00exGSXddZSYmmw+v7I7gJEr4qQZRp/2YLUoQa6GcZ3tcwQ
	 syPzoLUs+kz/vk4fkHhtDzqwSDb7wzcNE/GiVscY9UeouCEfRR+g0EyM95I9L7aeBzq+M
	 0CWqm9bhuUfI6sSXZrMfKN15z2d82ZkEZnQDXwExAVgAL7YsDXriWb9Wm7lAX6BAJOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Iq8j85S8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB359606A31B;
	Tue, 20 Oct 2026 10:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Iq8j85S8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8009F1F000C4;
	Tue, 20 Oct 2026 10:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792491006;
	bh=gSKeR3uJsOc/jsn43qIo1ksdoOnSrNbPSsujhyqJUjo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Iq8j85S8Uoo3+3s0cIzKMU3cD97NVYIJu4VknZ8YSytxdvOcsOyjHqK5+DH0U6nJL
	 bL8gPw+q37uhp/t4ZzJvwMsChLStIw6JD81aPgvqVg8bhyvXpcFtWaIm0atLRzU/32
	 UXwK4cDfsRJRuYR6ELcISw2ENO9XHeeJV1ybo0iqCFhKXZxB/VvNT96Nh7efw8Yc9J
	 dcZ83uvYGoaJH8PMk261wX5bKWy0q5WHIePLqSQb9U4yfXNOSs9/hfFOMKJvveY3I2
	 8aDSukMVzUI1DZwKPMPObJNo5A203Xa3cWzo0WB7bqJkG4+nCvYAaq8H6yug5kGF5Z
	 w5XLw4o+m58Ng==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 774683808209;
	Tue, 20 Oct 2026 10:10:06 +0000 (UTC)
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
Subject: Re: [PATCH net v5] net: phy: qca83xx: read resolved QCA8337 link
 status
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179249100503.3632927.12173934815866310072.git-patchwork-notify@kernel.org>
Date: Tue, 20 Oct 2026 10:10:05 +0000
References: <20261013190339.51909-1-yongzhao.derek@gmail.com>
In-Reply-To: <20261013190339.51909-1-yongzhao.derek@gmail.com>
To: Yongzhao Chen <yongzhao.derek@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 13 Oct 2026 21:03:39 +0200 you wrote:
> After a QCA8337 SmartSpeed downshift, genphy_read_status() can report
> 1000 Mbit/s from the advertised modes when the PHY is running at
> 100 Mbit/s. On a Redmi AX5400 running downstream OpenWrt Linux 6.18.52,
> this caused qca8k to program the user-port MAC for 1000 Mbit/s and
> traffic failed. An earlier prototype that read the resolved speed
> from the PHY restored traffic.
> 
> [...]

Here is the summary with links:
  - [net,v5] net: phy: qca83xx: read resolved QCA8337 link status
    https://git.kernel.org/netdev/net/c/42a91cbfc7a3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


