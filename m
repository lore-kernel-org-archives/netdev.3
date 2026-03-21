Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE6B2561A7
	for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 02:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774059019; cv=none; b=p5LlRtYN4RMnrT29YT5zyb0oQlnHm6HuqUr9i26a4HqiKt/NmcD0cR9V+m8w7CmQfdrAREOEIl+v1OzCTv+VEKCUd7de6U2hYrU0EaSQB0KI9mtL2SPTDN5bvnNAm07S6EX6vCXcy7DATIQKz21Sq/DIRiuxN5uLkFRgbOy3LBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774059019; c=relaxed/simple;
	bh=P1a69Opz2QEUXdUbziprfsdTi6le2vVUfkTYFxwnplE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=vFs0vn59znPdcJ5g/Il9oTLtQTzxR/s/WHcofbF2qCR6+3zS62gft9Zt0m5WwYrW0KR1+DZyJRePsFQTtcHJyWlpk54hgGze7COO3eTZDparKYFXh9GwzAlMyhsM1x3u9DisETl8p7U12ssTEAbVKlS6IhnWoCcmi9oqnYKH8jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=csmi0Y0k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="csmi0Y0k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F4111C4CEF7;
	Sat, 21 Mar 2026 02:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774059019;
	bh=P1a69Opz2QEUXdUbziprfsdTi6le2vVUfkTYFxwnplE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=csmi0Y0kTwwR5KzODVsMjn2n60aAsuVrVNOIpoDrDgDw6iGz3sROVvoYUmFsChD/x
	 ybMHkk7D7DMsOjnDVSlOOP1irtKIaRfmbkVhrNwq/71AJVBh+cxZs870N3XM5DfLtG
	 zJh1sKWBBXa/XQ/wacsovAu5al7AVU7lTNsbj1nZvh1CotngJJ1wSC+kJoxWUQtY2e
	 LQ0cu79+59fkD3ksP5NyBKcJCyxUz87+F0f1vtuMnaL9/h8W3Xi54D0AEhLxxZtEm5
	 rtGZ5kVLyMvOIL47KHjplVygN3X3B6isRSUpH1hPvecHNW/3Vem3kL5HaIA1zZ2yH3
	 r+TOQ3ty3pQJQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE383808200;
	Sat, 21 Mar 2026 02:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/2] rtnetlink: add missing attributes in
 if_nlmsg_size
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177405900904.2723214.12630168952954708160.git-patchwork-notify@kernel.org>
Date: Sat, 21 Mar 2026 02:10:09 +0000
References: <cover.1773919462.git.sd@queasysnail.net>
In-Reply-To: <cover.1773919462.git.sd@queasysnail.net>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 20 Mar 2026 00:02:51 +0100 you wrote:
> Once again we have some attributes added by rtnl_fill_ifinfo() that
> aren't counted in if_nlmsg_size().
> 
> v2: add missing nla_total_size in patch 1, spotted by Sergey Ryazanov
>     patch 2 unchanged, keep Jiri Pirko's Reviewed-by
> 
> Sabrina Dubroca (2):
>   rtnetlink: count IFLA_PARENT_DEV_{NAME,BUS_NAME} in if_nlmsg_size
>   rtnetlink: count IFLA_INFO_SLAVE_KIND in if_nlmsg_size
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] rtnetlink: count IFLA_PARENT_DEV_{NAME,BUS_NAME} in if_nlmsg_size
    https://git.kernel.org/netdev/net/c/52501989c762
  - [net,v2,2/2] rtnetlink: count IFLA_INFO_SLAVE_KIND in if_nlmsg_size
    https://git.kernel.org/netdev/net/c/ee00a12593ff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


