Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8CB1CAA6C
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 00:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777509669; cv=none; b=mu4JA6DsWk0zqKrt6zxvhBY6xKIfvXHfQiqAuOEA0uvwqHvuhJmdID+tYlCJ9lWJgSaEVJ55Qdu19NEOuVcfzw8Wi60Oq1VYj08FQe0K8BWmo2QXAEfHezG96mFu/HNVSmYBHml6TjhrcmhU2qt/Y6LkHP94gKMQlk14dIE2GzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777509669; c=relaxed/simple;
	bh=kWkvWtTJHP2Nt5qTurlLLvwhX2JPl2B6rN+svSuzHnk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=si5Vp7fVzKshJcw1sX99YnACdars7i1Ad6Jq2HgM4UKon3I9HIdkRMUfbC4K5Nb2TF0eofodDyVMySqR2sBSJ2dZv8uFPAqWM4e1E/vm5Tjveu1OWlqQ0X1dj3ioHnpUbkg6MyoaZbIVsPypYc9Ll79e75NMHVHky7mLzTqpUDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SX+b7G0w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SX+b7G0w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C91F4C19425;
	Thu, 30 Apr 2026 00:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777509668;
	bh=kWkvWtTJHP2Nt5qTurlLLvwhX2JPl2B6rN+svSuzHnk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SX+b7G0w0zfE02aLJt/H5TFZGKBj7iuWPgUW0orQbpTAgm2SjsxGwveKz/Td9DcIP
	 TC52vnZiGGlP4q71h0nL7P78POsHXMzI/IOnmYkMxb5BbKMQDRuIeKOpnP0glo0i76
	 qGVD0RHxoJqijSg70MMrpwbvQMUqAer42yMi+KnDYQT590NbVBeBu5G6awOSC961Hr
	 bHm5JO30e66I6FA7PzDXyykcW+RRAGVQ1YTqiUw4axaeaz2TNssGHb2BvnddnTGdkQ
	 itGCcMkhU/f0uK4G6wmQeYT8zXcUYBOB2XMVd/R221/gU+moyN2SbDHZs5J6lOi0TI
	 ffoUREqBgImzQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FF2D3809A2A;
	Thu, 30 Apr 2026 00:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] net: psp: add more validation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177750962379.2238701.18398023769194569989.git-patchwork-notify@kernel.org>
Date: Thu, 30 Apr 2026 00:40:23 +0000
References: <20260428205352.1247325-1-kuba@kernel.org>
In-Reply-To: <20260428205352.1247325-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 willemdebruijn.kernel@gmail.com, daniel.zahka@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 28 Apr 2026 13:53:49 -0700 you wrote:
> Address some AI code-scan issues with the PSP code.
> I don't think any of these are real bugs, but they may
> become bugs in the future. The two real bugs discovered
> were posted separately for net. AI reports 3 more which
> seem plain wrong (rx SPI "leak" on error etc.).
> 
> Jakub Kicinski (3):
>   psp: validate protocol before mutating skb in psp_dev_encapsulate()
>   psp: add a comment about a psp_dev add netlink notification
>   psp: validate IPv4 header fields in psp_dev_rcv()
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] psp: validate protocol before mutating skb in psp_dev_encapsulate()
    https://git.kernel.org/netdev/net-next/c/28e71cb51cdf
  - [net-next,2/3] psp: add a comment about a psp_dev add netlink notification
    https://git.kernel.org/netdev/net-next/c/5637fcb11c91
  - [net-next,3/3] psp: validate IPv4 header fields in psp_dev_rcv()
    https://git.kernel.org/netdev/net-next/c/c2b22277ad89

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


