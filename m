Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BFB248880;
	Wed, 10 Jun 2026 01:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781053220; cv=none; b=Kq42YipKGumsjDjXHgE+XWzEQihaL7zuttDyP+xbEZiMXcgQKoNw+xDxwWooaoghsM6KiXKnLz4NRV1iS13x6cfAGvwrwaOi/0KpzK3NguEnK4MYvmZ4QN6h3Fw6711Akxf26hakyVyYIOZ2R5yEF3v3RvtHvoCQsgkpaf3BNJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781053220; c=relaxed/simple;
	bh=wLwt2G8jW7yg7dZCQpEhpZmCUYIjn6d9ID/HQZuuBNM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=B1l1glEYkyCkWUWYytgdAW9Eu0hRo3Ic9jIahLijTiuJZiWSlijLqjFBj4hyOffm18d+zuaU4aUiAAmUtzkQeLQrQ50gZ6HJbnCQUemLXNKQfaPINENqX/X9aiXKl+aTUnkHCL7rHlD0F2qoQZu5mfOl3HX4YNuFNOB9DdRN/wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QhkPajNU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QhkPajNU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33E811F00893;
	Wed, 10 Jun 2026 01:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781053219;
	bh=rDxKiM+w3SmdOsTJtOMtmUeQ/ErFwtyByc3Qblso3tU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=QhkPajNUym4UFYH6hLfqRVXqYK3GTX5rtsFH5Dt/g2Ep+tsq7E9kAOAxfCVqP2Ond
	 WHo0+Pk96OhgVXPbi2+OAu47mLF/w4vaYqtyxRRAAZqmnIpsXQb42ZNbzrxdbfsIQP
	 KmE5sut+BbsTCo/WIke5jgNrnkjthtVVNvfiYAygaubF7Y3VY6TeZoLLUTAT2wJQEC
	 mYmnZzojNBxRC9UOWMiopuA7oYpe2Y8YLjlN409byhdbsevvL22hv2UbMNPfx8UaDN
	 z2IEa+2hngxHDQDHwk5CEsolISYw85fyJrt4bYVagxpWkX+pyEeoWmIDKxFAnqjlCq
	 yQAUc3PyEjkbQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93B5E3930A12;
	Wed, 10 Jun 2026 01:00:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH next-next v2] net: dsa: qca8k: Add support for force mode
 for fixed link topology
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178105321713.2773882.746838782482338822.git-patchwork-notify@kernel.org>
Date: Wed, 10 Jun 2026 01:00:17 +0000
References: <20260605-qca8337-force-mode-v2-1-d9a6b6545bfa@outlook.com>
In-Reply-To: <20260605-qca8337-force-mode-v2-1-d9a6b6545bfa@outlook.com>
To: George Moussalem <george.moussalem@outlook.com>
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 05 Jun 2026 12:11:29 +0400 you wrote:
> From: George Moussalem <george.moussalem@outlook.com>
> 
> A fixed link topology is commonly used to connect this switch (on port
> 0 or 6) to a SoC's MAC over SGMII. When inband negotiation is not used,
> the switch needs to be configured to operate in force mode. As such,
> enable support for force mode.
> 
> [...]

Here is the summary with links:
  - [next-next,v2] net: dsa: qca8k: Add support for force mode for fixed link topology
    https://git.kernel.org/netdev/net-next/c/e0a77b1ed900

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


