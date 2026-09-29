Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1331839A7FE;
	Tue, 29 Sep 2026 10:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790676627; cv=none; b=eHlfAn/Tn5+Kyw359N312JzHR60c3gtMmMU4vjiq8oiNr6OiFt5kIYzOYZkJFrrGsJsZsTDiHj/Xq5VKUg42USIZxrE8JWJ7JVZ0Dx7IpQ3teDstKS+y9zIsltyUMzbMq7+sHWteouRqFKZq0MOT/830MuBAw2hWGc83MO1TRmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790676627; c=relaxed/simple;
	bh=ZET5wZTZ5eAPgxFsBwE990H6jmj/ROHY7L5F/LDVfXc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BkNKL4U/VYDmHvDq08vhHmTg/X3FSDOfKVUkQncOy1DwvofQs64v0IO7+lALMSBeCS0zonK73KG/8/VQ9tbI4lrM23Bd/bdNaaz22JgJ60xwGwFANTNliGn3LtVkRkk7VQSPbfTxx6U4iy5pUldwnqcnrmkIm4Z2+oi3mZtbfH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f3jrqucb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f3jrqucb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 460C71F00898;
	Tue, 29 Sep 2026 10:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790676613;
	bh=yYKeJDNt+0Ve3roWaN8ID3iKky4Fn66nhezUtOWQHSg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=f3jrqucbJe1iRoQ8C+oLoSvvi7Ww1tKcmiJYDtMaZsBIJoJEddI/8q8okTNZYSH2K
	 U4g2x7+MGojvwrAaMfyEzz2+cEN+CxSEydhBF+N5HmBThGtr1sV4nvW61zEOaUqvNq
	 T0PhmG4Qtnadm/tFzxy/NpEoQ3Drdn+0JUhIWYqc7egNSZfW/2XDJnPueKdVrXAsPe
	 CB8HKABDFhB2us/1aTN9LLJs8tme5bdLL7A9v8KmkKD/dZakOTsTyIuI8k5INzVA9S
	 WYodghH65EUdEDCsCiTYW1jbzfbBLWtINetW8tjD4JQTCdmPMGTTT7ZWEIbQQC8pEV
	 uuLA/3Uy8eIeQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A597392639F;
	Tue, 29 Sep 2026 10:10:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v6 0/1] net: gso: limit recursive IP-in-IP
 segmentation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179067661177.399852.14443829829984221646.git-patchwork-notify@kernel.org>
Date: Tue, 29 Sep 2026 10:10:11 +0000
References: <20260924051521.32568-1-zihanx@nebusec.ai>
In-Reply-To: <20260924051521.32568-1-zihanx@nebusec.ai>
To: zihan xi <zihanx@nebusec.ai>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 dsahern@kernel.org, idosch@nvidia.com, kuniyu@google.com, willemb@google.com,
 kees@kernel.org, richardbgobert@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 24 Sep 2026 05:15:20 +0000 you wrote:
> Hi Linux kernel maintainers,
> 
> This reroll uses IP_TUNNEL_RECURSION_LIMIT directly for the shared
> IPv4/IPv6 GSO recursion check and adds the requested Closes tag.
> 
> The v5 cover letter has the bug details, PoC, and validation evidence:
> https://lore.kernel.org/all/cover.1790157745.git.zihanx@nebusec.ai/
> 
> [...]

Here is the summary with links:
  - [net,v6,1/1] net: gso: limit recursive IP-in-IP segmentation
    https://git.kernel.org/netdev/net/c/006c8b834aed

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


