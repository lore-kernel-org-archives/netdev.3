Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A2D41E6A9;
	Mon, 10 Aug 2026 23:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786404080; cv=none; b=clKiy6fxvfAxK3JBQM5q5aGzxghs6Mg8NkWP3AdXCQpOEhaN/luyqUA/OG9HS5hzG8CYuoK9pQ2GHvx/u8BQyfD4tv6cRA9ACNF4YkLBbFb6M7gXo5zWTsCyd7RIAqmv3dNemzPM5HgvvomhTZvslj6jHV7nCNtjDl/6vr+EniM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786404080; c=relaxed/simple;
	bh=1anBIWu8FRcqIwvDMJR4q0k+fNt5LT1kS++gJHbxcAE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=a6Euzl0LbQYzbhGwH5+d3WYUvnPc8ujeQ1s1c0dhMt9MK2NdrNOWkvVlNqtpCcfGyL3970HJn89UExzpeZtVwqgZSgBLhEaPoWn1E5tI1+W6sfDslJCzepmKQMjwYKxfzoke0gK3IUe4+WJat4zirvqoAjX7a5rO7RuNLQ2XFQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ouiEZWvi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ouiEZWvi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FB011F000E9;
	Mon, 10 Aug 2026 23:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786404069;
	bh=n5u/hcd9jMKH/Ai8euvfLn8xlo63Dkylm2IE7YYMnKk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ouiEZWvimrBIbSXdm7vXfGiMSO7G8r5BjCkMbyXIb0ndzYoAGlYklMp/tsdNqLl/W
	 7avrN6t9elKkHe544svY+xpLK76JE20BEGQnQMPMK36mG1BlabDzPg1p3GVNNGWMCS
	 L9sw2KyNM7SctYUae8wrVBoW14W5ZpQTJhbkrDTWBnOwi/yhBHNdDeuCaEJkZPQolt
	 wb6ntY8ZqVjcTx9cIteZed8qEVRQMoqOFYyTR8Do4D5u/tnE5xjNHsPIpVzHg3FcaJ
	 0t8UK0NPrvSkxiRRXzVGa5tWy7xjw2xY2/QzYeNlDvfH+KskIcju2VCQDZQmwA7eV8
	 RGzBskpYZQX7g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569CA392626C;
	Mon, 10 Aug 2026 23:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] bonding: fix wrong extack attribute in ARP validate
 netlink error path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178640402588.250217.14266028482174112217.git-patchwork-notify@kernel.org>
Date: Mon, 10 Aug 2026 23:20:25 +0000
References: <20260806-bond_arp_validate-v1-1-3ae005657ef9@kylinos.cn>
In-Reply-To: <20260806-bond_arp_validate-v1-1-3ae005657ef9@kylinos.cn>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: jv@jvosburgh.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 jon.toppins+linux@gmail.com, jay.vosburgh@canonical.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, liuhangbin@kylinos.cn

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 06 Aug 2026 11:29:28 +0800 you wrote:
> From: Hangbin Liu <liuhangbin@kylinos.cn>
> 
> The attribute of netlink error message should be IFLA_BOND_ARP_VALIDATE
> when ARP validation setting fails.
> 
> Fixes: 2bff369b2354 ("bonding: netlink error message support for options")
> Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
> 
> [...]

Here is the summary with links:
  - [net] bonding: fix wrong extack attribute in ARP validate netlink error path
    https://git.kernel.org/netdev/net-next/c/fd23a7c97317

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


