Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213353C07A;
	Sat, 21 Mar 2026 01:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774057216; cv=none; b=A4Ecl+e8xlSqCY6u3lwbWRCHH8qKdJMOAsSBsPwATwH2ufsiz3rW3B/PX+y/e8qQWALKTilBDqPa79cFBjyiwMBdOAJPSeyFOaaPvpSFczR4BUYqwXHjGEyCAlE3uh9HASq/MfP8BlmsIHuznffVgsyVm3921UTZw6ckeOgIe2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774057216; c=relaxed/simple;
	bh=ewLoup8QV1e6EtVHrX6BPU6g4YtluWG056Fcho1RAJ8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=R7lW1UvNAmVpysvRp/5dypmuzSHwn41NKfcRCYe8F2GnleGkFnDKs/qkl6o1GDJUa+afUTjVVv3Ia8EDrgqZrz/xRw62eU8C4avn/vK3K5qaXORMtBsDuDpJMPNum0nNQh9HcN3RPGP/9chhQXrYjASOnIn46lTKzqwktj0vzyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rs6Dzs2t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rs6Dzs2t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B75C3C4CEF7;
	Sat, 21 Mar 2026 01:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774057215;
	bh=ewLoup8QV1e6EtVHrX6BPU6g4YtluWG056Fcho1RAJ8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Rs6Dzs2tEd+bXSOztpR0/QiMlWVOWhToCAz2FqL02xO7Lt/a+KQvMEDsn36tBiUcS
	 0WrLleyyK9ud8yyzUFgbtItqiODdE5HALYWGy2TjIy/C6TKFDMp9ySs03LMTx2BnVY
	 4wSGV0+ChgC0XrN0SYFPPcMUGvhI0xKK7Xok09qqyZ7S6lWOj+VyBKqo4eUGaUDA1Z
	 3D8cGlCZh2fZ+VWVM1AN2ThpBQn3g/c0/KMo4gsYR1NPKO4kztseV3BcgH1I+kBeS3
	 6m8O2kN+Q98ZK+zJ8Ku0xBkNL5UUkbw8RiOGjDylkhHRDYAgdj/Leu8sh/uwuMo1kN
	 6EcROuIQ8nGdQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02CC63808200;
	Sat, 21 Mar 2026 01:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] openvswitch: validate MPLS set/set_masked payload
 length
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177405720582.2718727.10927931850502604118.git-patchwork-notify@kernel.org>
Date: Sat, 21 Mar 2026 01:40:05 +0000
References: <20260319080228.3423307-1-n05ec@lzu.edu.cn>
In-Reply-To: <20260319080228.3423307-1-n05ec@lzu.edu.cn>
To: Yang Yang <n05ec@lzu.edu.cn>
Cc: aconole@redhat.com, echaudro@redhat.com, i.maximets@ovn.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, pshelar@ovn.org, martin.varghese@nokia.com,
 netdev@vger.kernel.org, dev@openvswitch.org, linux-kernel@vger.kernel.org,
 yifanwucs@gmail.com, tomapufckgml@gmail.com, tanyuan98@outlook.com,
 bird@lzu.edu.cn

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 19 Mar 2026 08:02:27 +0000 you wrote:
> validate_set() accepted OVS_KEY_ATTR_MPLS as variable-sized payload for
> SET/SET_MASKED actions. In action handling, OVS expects fixed-size
> MPLS key data (struct ovs_key_mpls).
> 
> Use the already normalized key_len (masked case included) and reject
> non-matching MPLS action key sizes.
> 
> [...]

Here is the summary with links:
  - [net] openvswitch: validate MPLS set/set_masked payload length
    https://git.kernel.org/netdev/net/c/546b68ac8935

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


