Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A6154726
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 22:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775255423; cv=none; b=KyUDX1lY3uudfZ33i2kKiE33GjL5Jt5DvPqKtFkIo7HSyyAvnghhmOAif57rWwswPXmzr/paDHQPcsnWuQ+kzC3UdYhKnLY8CEl0Vhx2LyyhlVCz83xQcQkS+zWXALeJBVyyiMtzL5N5fw6wiw64V8eKSMFt1dk53fIdJYG4tgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775255423; c=relaxed/simple;
	bh=4ocyzM2QbvMA5wea/DeYrpjP0PRr/fapOJhLkGZkgXA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Tn2G1MJlr/2HWSjLuuR0Wm4euzDSMIlV08ONA8/+6L+a6YtuFk2E50NQDgL5/2HN/w9xaWsicGyNlnMIvyi7n1GAoHpxG1GhTfm8HibCY7vOw3/hbtB36HoWUUP8GddfHAB8JyF/ileSuEcSCat7tzQg8cyyJC3cQTbyJzRqhtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eb/cKjvn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eb/cKjvn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A32FC4CEF7;
	Fri,  3 Apr 2026 22:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775255423;
	bh=4ocyzM2QbvMA5wea/DeYrpjP0PRr/fapOJhLkGZkgXA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Eb/cKjvnAzE6TkBFmpe1xoq6/5NIe8VK2rFq7UVs0eDuwo+hJuobh4KI9hPIX8xP4
	 pTtfnjXcV2k9HGaSrCSA1cGhyofY7CL5vmhyTqBDaRPrlylL5LwgmfiS48xZpKyqwV
	 iyxdQbjLpO8lRKRrEJnC6MaKX+IsKECWzRELRXQXH/38GBC6MhcbBNJk5wNGnemj+Q
	 0Yax3VSY5Biz7mP9JHpygFPr5qWB5ynFhpKooww3IC9L2epqi1tRv3DOqMsVM5ykCn
	 7eGyH7Io/Bn/mcIu1YR98WbRb9z6A1ZYgkCdo4iUXGm8t6//9rcuC31T/Jq45OB5wV
	 3DEE5LHImcS1Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02E0F3809A14;
	Fri,  3 Apr 2026 22:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5] rtnetlink: add missing netlink_ns_capable() check for
 peer
 netns
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177525540479.1474180.4557160126196950232.git-patchwork-notify@kernel.org>
Date: Fri, 03 Apr 2026 22:30:04 +0000
References: <20260402181432.4126920-1-nickgarlis@gmail.com>
In-Reply-To: <20260402181432.4126920-1-nickgarlis@gmail.com>
To: Nikolaos Gkarlis <nickgarlis@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, kuniyu@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  2 Apr 2026 20:14:32 +0200 you wrote:
> rtnl_newlink() lacks a CAP_NET_ADMIN capability check on the peer
> network namespace when creating paired devices (veth, vxcan,
> netkit). This allows an unprivileged user with a user namespace
> to create interfaces in arbitrary network namespaces, including
> init_net.
> 
> Add a netlink_ns_capable() check for CAP_NET_ADMIN in the peer
> namespace before allowing device creation to proceed.
> 
> [...]

Here is the summary with links:
  - [v5] rtnetlink: add missing netlink_ns_capable() check for peer netns
    https://git.kernel.org/netdev/net/c/7b735ef81286

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


