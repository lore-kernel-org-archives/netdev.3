Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794437411;
	b=mXyz/94SAtOk74aC7qU0CuJ/Rz/FtdZ2i79/vHoj3CdttkelwCnsEiotpQnAl8C+EyIE
	 YTIKuwEkzBmwSKrStp7QVnt0CQl/pCfYF6tejTtwJSbtwiRp2F7BclcOnOIHdd0IBD2CG
	 LpUrmhYUAmFT+3Xk7GRLkxmRpD2Rfjtn/w/XPp21Fgs6EOqgGIl3c/nLkHgx9hLFEKUXA
	 JAjzkRcMwn4PyecwOAC7svCSeLQ1qUPFMcXRxs0fKf/Ee+o7fW7tkv50tI1lYGux1hxc2
	 pmZWcqtdunztocjEmqjGvugknAPVM2JRSZl9Xi+U6EkAO7q/XdtSqk10+aaeW/oVomg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794437411;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=4+l3fyHv0HoDI8JNr6LcIUAqarbQcok0CzDtdaUdRTI=;
	b=2dmQSa5rwlcGwuNRZfiLbIWwqNwEiHI/7gKmJqKifqZrP5EEyK6rrnrHenlr/LwLNPR9
	 3mA/720w2tfx7MERFhh9pW/YNKRAhY6svT6tXsqD+6gqxgHJlHa6+8Pw50YNqe4+BbiJz
	 xfh7DAd9wk3xpXOSLCST/vmH60KaRjnYYNv41Y1nybE4a2HXpOSl6qm4ymD5J+R1wrsDx
	 VsD/gpXle/y33Dj6qaNu8PUa/AeIEJkSRmlOsG0kwQ/Dv+zgwdYxSfzqKjkGVShu8s4Nw
	 C5ZdqvyBWyC+IzYuu0BPrAFdYlGSDveSsYVyBrwCwotjKaZxRCM/+qtJpQn91V5pE9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g+0KCXNh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F371E606A324;
	Wed, 11 Nov 2026 22:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g+0KCXNh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A43281F00A05;
	Wed, 11 Nov 2026 22:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794437410;
	bh=4+l3fyHv0HoDI8JNr6LcIUAqarbQcok0CzDtdaUdRTI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=g+0KCXNhh9FLc6NiUPenqcH2VV1ITtkFIL88ZYlEPbS+ksbbzkE1B2TzpvSS+2ZlX
	 ObiBJjQBEaWOwCXvL4CUbenuUnGZDWPEP2ZD9FN+OTT5BsfOlPgakcRfZYgMx/w/cE
	 5dQk5qgdet6z8zth3XAZ5zLg5sqwz0hvIS9RYtY8W7TLPYZCwgVNfi2VzdznVZFiSM
	 RvCOJN+or+EIDNuQo3qB5TiAn6lC5souJI6PF2fJXmXD5M3LeQ/F55YRirqYn1zr8L
	 66fwgZXeBsOuuVhktQSDIhkTllHDYhmhngAejZqqZki4dJ4mkM5q/zwZO/RbH5l+77
	 TE/h9N8OxZMdQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9B1DC391AFC6;
	Wed, 11 Nov 2026 22:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] wireless-2026-11-11
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179443740943.1688116.1228666992876735767.git-patchwork-notify@kernel.org>
Date: Wed, 11 Nov 2026 22:50:09 +0000
References: <20261111133442.225455-8-johannes@sipsolutions.net>
In-Reply-To: <20261111133442.225455-8-johannes@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Nov 2026 14:32:01 +0100 you wrote:
> Hi,
> 
> Here's a set of fixes for the current cycle. Nothing really
> seems hugely relevant.
> 
> Unfortunately we're going to have wireless-next conflicts with
> this, so there may be some emails about conflicts moving from
> wireless-next vs. wireless to vs. net. I'll provide a merge
> resolution with the wireless-next pull request since it'll only
> be relvant when pulling net back into net-next after that.
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] wireless-2026-11-11
    https://git.kernel.org/netdev/net/c/831e33ad02ff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


