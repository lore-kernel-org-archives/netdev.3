Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98BB25B0B6;
	Fri, 18 Sep 2026 00:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789690275; cv=none; b=iAdVQvP1p4c+t1ljfQkNTd8Z0to0tyOW4tmYesqRQKW1UfkyRC3ZUHuQlo4MB9DIZd/+qDSqxQylkp2H7w/N8oWqk/id1lV1H6F0UXNrFQak/6yzLNvys3dPB1a5th62EXBMr3kHLSMzPDubu3oxeVQTGP9Fop8tNnLzV6LRtJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789690275; c=relaxed/simple;
	bh=v4alhD8JbNPOTZqEh3EYRowAzcAr2o6IQ6QQC/iISYw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Of8G4T/f+l4Q5dx8Mh9/Epci/sU0dCnZPLl5l7CDBARCRmHzxbuaNGyc635wrkUswYUAU+9ibvw1nqhIGVe2+ldU+SR0qN9JkxO7T1Mq/7EjwLu/LSjgpCM59hQph8K+dCLyN+OawPN+BFA/BrMLWAtZ2+nsnhbz645jBqkiL0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+t0q79B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+t0q79B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7124C1F00893;
	Fri, 18 Sep 2026 00:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789690273;
	bh=aL3/urrrSHWm+dFAubRby0+Nofe6hzEHZq0YfSTyfXk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=i+t0q79BukwlW222H5njMlKLlteeyzrzj3gHumlSKC2LcCu2bm8q6u8UQnGc+8tB3
	 V4733vbC7Esf7PrLUAh9hnVZARpy5c6HJ8nIAtCqRTA/Q1ET/O7TBZB3kHvU9YdBoy
	 VChcW/JjZvcyabE+/J7DiNE2ufQOWuWlSsgu0IuPRy89XLqNRbQDkf4c1fv9UHtUO2
	 BFHpXdSeUJQX+3xsySb0KfgpiSE8wyiWn53mpOvbOO1cQWLoa3ELP2vFzqgofn2vAS
	 YtlHHpKevbAj7rj9RNuecL2p+BFyySgpEyobkTUgX54g06RuR1qrZDTNi7Rv7bQo8l
	 +qWV8PKBjD5/Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19C1B380820D;
	Fri, 18 Sep 2026 00:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5] net: pcs: rzn1-miic: Fix config array
 initialization
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178969020663.191233.11908163427391514070.git-patchwork-notify@kernel.org>
Date: Fri, 18 Sep 2026 00:10:06 +0000
References: 
 <20260915-rzn1-miic-fix-array-v5-1-b7173fd5b97d@reliablecontrols.com>
In-Reply-To: 
 <20260915-rzn1-miic-fix-array-v5-1-b7173fd5b97d@reliablecontrols.com>
To: Kyle Hendry <khendry@reliablecontrols.com>
Cc: clement.leger@bootlin.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
 linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, geert+renesas@glider.be

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 15 Sep 2026 10:39:20 -0700 you wrote:
> From: Kyle Hendry <khendry@reliablecontrols.com>
> 
> Fix memset parameters to initialize the entire DT value array
> 
> Fixes: f39e968dc168a7bd ("net: pcs: rzn1-miic: Move configuration data to SoC-specific struct")
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Kyle Hendry <khendry@reliablecontrols.com>
> 
> [...]

Here is the summary with links:
  - [net,v5] net: pcs: rzn1-miic: Fix config array initialization
    https://git.kernel.org/netdev/net/c/daf677c2c644

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


