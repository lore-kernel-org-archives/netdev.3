Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A661FECCD
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 09:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736933413; cv=none; b=r4DU2gWHv99Y+vzX46sv5T0q4ISARp4em4W2spgM/OJIP6nXaxEI9fkvGxmXQ4n9swE2CT/ZdMQhcQNeoZCBpXkKlmSeqMJ06+wZLJUaYDSk8txcNxTFab8injVrDLy73lnbL8KvcX/OZpvVBWGrc6mTi4KA10IWy1QUHxUWdfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736933413; c=relaxed/simple;
	bh=twzrNx93SRRUGKGzxi7PEomiqzymrzJ8vhi/NySryQ4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=U2ST9N44M2Se+2VeojrQbkCB4C08qL9FfQafAnaedfbS6kgPtiCeFlqccBkYBTYGWPquPRJxm3eer74bNIUnSbd1EhDTycPGbYbjzxLKX0EFaNECr5tLImaTmyFE2ekfFkrOGTeWMYuO52IO3Jr6DHPS1sMOWQbv3jzCABjte5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gcxKP9gN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gcxKP9gN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4800C4AF62;
	Wed, 15 Jan 2025 09:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736933412;
	bh=twzrNx93SRRUGKGzxi7PEomiqzymrzJ8vhi/NySryQ4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gcxKP9gNQoof9NxzodGYvVmU5Hry6fO47iyGhYS6OjHXAlmM54smt+ah/ETLIYK6s
	 9lmYig80aqUdyArAQirxiKzf6h9LkshDpFOxC5kkxzzn2N0iaCxTsANXFBjHlCQ1aA
	 zT0BRhtse0T+gZgi/vEgra0dD5nvURC7I5qdNUcn0H4YQr2ODqpCDaIbSw/6o0ngNb
	 0zfByNWAPE0BxE9xUWG4C6I/IP5EsQo8Wv8xImgNV9t/qu0h770YvFM9K91TJM/6k0
	 mH3bN3rZQJTKTcBuZHqEceKm/Gg2Jn0N7WiGmxSVY6cAtU8wXMettWdFBol3ZVgZly
	 Hu4N/FF/BqNxQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AFECC380AA5F;
	Wed, 15 Jan 2025 09:30:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: net: Adapt ethtool mq tests to fix in qdisc
 graft
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173693343553.643594.5825676788697761376.git-patchwork-notify@kernel.org>
Date: Wed, 15 Jan 2025 09:30:35 +0000
References: <20250111211515.2783472-1-victor@mojatatu.com>
In-Reply-To: <20250111211515.2783472-1-victor@mojatatu.com>
To: Victor Nogueira <victor@mojatatu.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, jhs@mojatatu.com,
 kernel@mojatatu.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat, 11 Jan 2025 18:15:15 -0300 you wrote:
> Because of patch[1] the graft behaviour changed
> 
> So the command:
> 
> tcq replace parent 100:1 handle 204:
> 
> Is no longer valid and will not delete 100:4 added by command:
> 
> [...]

Here is the summary with links:
  - [net] selftests: net: Adapt ethtool mq tests to fix in qdisc graft
    https://git.kernel.org/netdev/net/c/0a5b8fff01bd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


