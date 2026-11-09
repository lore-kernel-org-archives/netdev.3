Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794246610;
	b=dlNVp1SQwXi5v1mSo26T4YqzPJOgmaSLv4WUJPEpktZVzS7WJ7Ju2W2xkTEXcNNs52T3
	 D2+Fpbud1W9iO6Uy5w3jtST2KD7vm8xu7AAGC/OdxExND82eJw1rRWwV/DplOuV//qCZn
	 JHjRutiJLkpyWhLl8J/M1NHrHDWqtKOcpMoHR5cIss5Sx2xVjNZT6pUMX7tESqCqK5qN8
	 87CgiqssslB445PnxramCxwivVyesfSDRStX85lilZ6RB+/gpnk2xwxx5OcSRXs1/WBbi
	 XuFh7ArUU8t9Bp+jcbwzSUSToFxpe9cHNZAUT6+eS+/fkYW1PNAWvO21OKPKZKuEATg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794246610;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=c3imtM1pjHxOPhVDojpdZOzaRP31i9BPx97saE9mOwc=;
	b=1FzaBsyQ7iSeauZUWq6Bl8ZHMaDDSrvuVUYgEhp/OUSSeogqU6WIHOK3f3M8CL254i88
	 eqSYriM0X8jlT6ju1VnSfK90OkwuFZVjiGGFIj767EgO614m/HUCQU3Ebax4RFBIJOjVG
	 jmFXknZuraQdM+k+GMJylDFwCLV7Rlmqh0NYgLfYuRFI9Kg674jMIqkfVd9Mqf0pZRk+l
	 Ai6J8z1a57eCP8/8dkHqQzCAgjedYfeFzEvRLMCtRw+at2KbFGSwux5N1LA3A7UbvZ0YH
	 BfkQTmB+PAy5Q+bX0613Iind8PursBwqNOtX0W7u4ttOQAHDa+jTwNtb8Kup02ajP8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EEZENXvT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AA4606A31C
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 17:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EEZENXvT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E35BD1F008A1;
	Mon,  9 Nov 2026 17:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794246609;
	bh=c3imtM1pjHxOPhVDojpdZOzaRP31i9BPx97saE9mOwc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=EEZENXvTSyKF8JZSbh8xBVBlHY8wLX7jxTs0T/l7q1viId3OVCgBnQuAHou/ekG2k
	 mih+XwEZih1Jfj/Kl/anxAsy1zzutSP//A9uB4tlXHn+3H/1eMbPFiaKINWA9SbmNc
	 bLTGN6jLdb9CgvTu+bSXwhC/M42RZzZ3D9P5Gp52FQQaL2RSXFb52h/5nsq3vx0yP2
	 QL3uYR2mGmyildnj3jOHPw3ldsAgTDhYxcVBQre3l4xT2wjwMLk5dyPka3W9qUDJ98
	 lrfK0eUifuiEgkUZh5+PzJS4y4WzqYPJZcJDcxP/1jxlNwmEEUuy+stGcu8j+gPaPw
	 HC2/j/ZmnC5XQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D84C03805CD6;
	Mon,  9 Nov 2026 17:50:09 +0000 (UTC)
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
Subject: Re: [PATCH iproute2 v2] libnetlink: zero padding in rta_addattr_l()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179424660867.3393623.8324863272464754349.git-patchwork-notify@kernel.org>
Date: Mon, 09 Nov 2026 17:50:08 +0000
References: <20261109164116.2637408-1-dave.seddon.ca@gmail.com>
In-Reply-To: <20261109164116.2637408-1-dave.seddon.ca@gmail.com>
To: Dave Seddon <dave.seddon.ca@gmail.com>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org, dsahern@kernel.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Mon,  9 Nov 2026 08:41:16 -0800 you wrote:
> rta_addattr_l() copies alen bytes but advances the parent by
> RTA_ALIGN(len), so the 1-3 padding bytes are never written. This affects
> every caller that passes an unaligned length. Nests built in stack
> buffers (lwtunnel encap, RTA_MULTIPATH, RTA_METRICS) then send those
> bytes to the kernel. For example, in
> 
>   ip nexthop add id 53 encap mpls 101 ttl 10 via 192.0.2.1 dev d0
> 
> [...]

Here is the summary with links:
  - [iproute2,v2] libnetlink: zero padding in rta_addattr_l()
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=c5b76cbbfefd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


