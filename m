Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EF83AE703
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 18:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776970253; cv=none; b=l2EN+dvRI0XUojcGIRXbsF37A8Fi9Pc9h0iE4i3DVVVOKdxHOEMQRlDKpav4oWWtukKrp/Wl33qnIIIRhRzqxUQXNNCW7cR6H6aZSMf4g+pGLT+O+5el6y+X38JlDSWTieYnjpdzM1c6sEx/nk3dGBcPxExKBNQj7Qa3k21jXJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776970253; c=relaxed/simple;
	bh=IKHyFQj5r9x8NU1A2gz1eIUB/vsoWTrN8qKNygHBc4k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NCc0wbH9vlCEIQn5Sbks0GWMLggLmnfBK7F/PfkUyMVq60wbXYIWPnGO0t83QgIk9T45KTmrCDkgPgkon8PBbmtprz+v3vh+SeV0ILql3DNY99Iu08Ny/dMMZMP/pryxj0eXvD3irWzgef7y3R4ndUU52apRZhUuM/VMNDQBjao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UIynQ9ti; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UIynQ9ti"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE3BAC2BCB6;
	Thu, 23 Apr 2026 18:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776970253;
	bh=IKHyFQj5r9x8NU1A2gz1eIUB/vsoWTrN8qKNygHBc4k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UIynQ9tiiBoGNefCb/mFVBTPVAGx9nEQ3SbLWARDCN5WuwIixXijGJEn2hYZ61/4c
	 Ya3ZjEB6z4L0Xwqclpn7gkF5etfCY+5ofCIskW2WxgupKOa2IpI1H1vwJ+4OLBycTn
	 ANHyA/kVzf/ZIa0PedxH6iVMK38EwbGgoa8m8AmMR8gnfwnY73iuD97FsYobaQtq2m
	 eybApdqSM3hFYChPr9utNq4ZdGf1Wx858Qpw92djD3JRGBdmV3Z1uNfFGQl8RHj12p
	 2gXiQCq6YYwifAvp00vqYH6NfQgfbAGc6ccsnelPu6t7+c686/OkAaKFe24MQ8/UPt
	 KdayOzmq2zurw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FCAF3809A90;
	Thu, 23 Apr 2026 18:50:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] ipv4: icmp: validate reply type before using
 icmp_pointers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177697021480.714464.15959651050466333528.git-patchwork-notify@kernel.org>
Date: Thu, 23 Apr 2026 18:50:14 +0000
References: 
 <0dace90c01a5978e829ca741ef684dbd7304ce62.1776628519.git.caoruide123@gmail.com>
In-Reply-To: 
 <0dace90c01a5978e829ca741ef684dbd7304ce62.1776628519.git.caoruide123@gmail.com>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: netdev@vger.kernel.org, edumazet@google.com, davem@davemloft.net,
 dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 andreas.a.roeseler@gmail.com, yuantan098@gmail.com, yifanwucs@gmail.com,
 tomapufckgml@gmail.com, bird@lzu.edu.cn, caoruide123@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 21 Apr 2026 12:16:31 +0800 you wrote:
> From: Ruide Cao <caoruide123@gmail.com>
> 
> Extended echo replies use ICMP_EXT_ECHOREPLY as the outbound reply type.
> That value is outside the range covered by icmp_pointers[], which only
> describes the traditional ICMP types up to NR_ICMP_TYPES.
> 
> Avoid consulting icmp_pointers[] for reply types outside that range, and
> use array_index_nospec() for the remaining in-range lookup. Normal ICMP
> replies keep their existing behavior unchanged.
> 
> [...]

Here is the summary with links:
  - [net,v2] ipv4: icmp: validate reply type before using icmp_pointers
    https://git.kernel.org/netdev/net/c/67bf002a2d73

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


