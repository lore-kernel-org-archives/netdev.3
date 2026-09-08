Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22ED625B08F;
	Tue,  8 Sep 2026 01:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788829274; cv=none; b=XobVkyb5t/pU1Yh7MX9JgmfK789yNAkSfy3GtD26WzzV/2FS1VVw1RL5lRvVdpYBkl6PeOKm1vmS3POnNFa8J1QKDWUFtYP9r1StOMQ/SU/x+/7D/Hjkj7AaAdCUFP/3ffG3O5v/EmaC7yPoZD9Ndb7J9DFfvMaCQZBhA1pvNCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788829274; c=relaxed/simple;
	bh=5Od9tV8xrjRKRoAHO/+k/r3fO0vtNKgYVv4+INYpv/g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JQrX1b5YDi0DdbsPkMYa1aGzRygfrsQaczD8VwU1110d0VnACs/pyxyHAMXXvikBRUTBXnqF5AmE9cVfBs3vTzc1BJ6LPoqw0IhRr5i48GW0wS8jxQ2KduMDb6fXMq9tZw+dhIow3y2Sq3xj41OTvW/d1OGIX9xabYScTwOCtFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCOty56R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCOty56R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7A3B1F00A3A;
	Tue,  8 Sep 2026 01:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788829272;
	bh=mgFGv+p5VCSYasC4Sw/icwQ7E6i0JtLQ/AfOj2+o5n0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kCOty56RqyXBLivJgd3Adu4OiEi81Lvm3V/8Qhpcrzh+TJqFJHuwd14h8NYAdqxGE
	 qjRiVCnxQS+Cpkv8BeHR5nWlDrVL+uEz3s+sSZl8rhIkQfrG0lXxbn/uyY9xO3C7dZ
	 7K8C+wC8XTh9KVaIUoCrwIfXkdYk24CLdaITPK+sfdn41/sN/snNopn7OyColcqlK8
	 9P5FkQRnwMzr7w6c82QotYAJgvnEHA5MtJw300/QJhdZ19KBiIzNFukJ29WpdPyNoP
	 KQ06qLaM0ch7qYlyshKIY5CwaqspEovvA1QUPOXB795lUJVJoUgBgTuqA52gNfIYHZ
	 UtPvrSZT8SkMA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A1539E8A5D;
	Tue,  8 Sep 2026 01:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] mdio-mux: fix typo "framwork" in comment
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178882921138.3227186.56921221399363588.git-patchwork-notify@kernel.org>
Date: Tue, 08 Sep 2026 01:00:11 +0000
References: <20260904104107.12832-2-hemanth.selam@gmail.com>
In-Reply-To: <20260904104107.12832-2-hemanth.selam@gmail.com>
To: Hemanth Selam <hemanth.selam@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  4 Sep 2026 16:11:04 +0530 you wrote:
> Correct "framwork" to "framework", reported by scripts/checkpatch.pl using
> the misspelling list in scripts/spelling.txt.  Only touches comments, no
> code changes.
> 
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
> 
> [...]

Here is the summary with links:
  - [1/2] mdio-mux: fix typo "framwork" in comment
    https://git.kernel.org/netdev/net-next/c/32ca12fbcf6b
  - [2/2] mii: fix typo "asymetric" in comment
    https://git.kernel.org/netdev/net-next/c/4e2554eab15a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


