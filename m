Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039E8345CD0
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 02:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780540220; cv=none; b=H//rOsUQ20FPJKgrBc9QWtT89YAN7AzzFxaNxaFjxmTEYHbQxT/FasnyP9LWd2HV5reTrdaD2pYbd40pm7r9FhG37W48R/0xcd1SxvcR+NKw2JnfMPxQC6FPwkvxZ9xnzWsnOHgAOjr6yC6ZtAP39cG5i+PYdg5/x5PwxFEpBQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780540220; c=relaxed/simple;
	bh=CKikleqoW8Vet9cHPjqjvBNXC/7K+x7A3saUqqZOhL4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WBCkbYAvqDTJl88q6gdbsisgn9PkCSX3nTegUHs3KCoPUXcw+chEIutOluLBwKV6F1inyg+xP4P+AcCU5P3KajltZ+gCI+b+C1UtvxWol+L5ifHks+wKCYK+BggLw8Dx5u0nt/T3cF4e9pwFMWfIJYku+keBuioDXpOGkyneghk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DDwIwW28; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DDwIwW28"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACCD51F00899;
	Thu,  4 Jun 2026 02:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780540219;
	bh=CIe+n0BFPlKAxfLCH28hqZrseXQjs/w7HQSSg2n/XYo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=DDwIwW28LNC05f0PkAOI272ZmbTfpTjRICweF89L9GJxsKmCRhw2TuQZXhuasGTgD
	 vQNX0YJ4CV/ZdibZX2bEBUvGzEVJAoWYgwbLkDoqXJYhzpBgYRIVTK5ZT59NBb01h2
	 YuniartNMpagCxkyq5W9Wl6CrVxn/VtGcJzPwxz2BYPgIOVrQDIxjON8ael9Cs3JlO
	 +BoetjbSW1xFlUZNu9BvH2CpCrPOeLc5nzkcdQ21Xf2wxey7DCAbyqQdIU3b6QtlWM
	 JwXiXzyapLTF4YaUcHLlPKMe5l/Zr7SSbenXXb0vBPlFApJVRXXrFLGuLfN91imF/H
	 3TZFEg/bKRcaA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19A7439308E6;
	Thu,  4 Jun 2026 02:30:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ipv6: exthdrs: recompute network header pointer
 once
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178054022064.2211213.11260316431238664968.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jun 2026 02:30:20 +0000
References: <20260602213033.12244-1-justin.iurman@gmail.com>
In-Reply-To: <20260602213033.12244-1-justin.iurman@gmail.com>
To: Justin Iurman <justin.iurman@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 idosch@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  2 Jun 2026 23:30:33 +0200 you wrote:
> In ip6_parse_tlv(), recompute the network header pointer once regardless
> of the option processed (Hbh or Dest), as missing recomputation for
> specific options has caused issues in the past.
> 
> Signed-off-by: Justin Iurman <justin.iurman@gmail.com>
> ---
>  net/ipv6/exthdrs.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)

Here is the summary with links:
  - [net-next] ipv6: exthdrs: recompute network header pointer once
    https://git.kernel.org/netdev/net-next/c/ee5aee77bcba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


