Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792546598;
	b=MydLmn2pIF+kYQ0t5dh9JQpywm3+xCmK+l0u2mtRJWGM2w5ov1xi7qArV585qdrlw8g0
	 LZPm/y3b09XZuFBtoVb4jHVJFaZoL3bQPcpjj/n7DgoGhavaIphtYneP7S03QSj8LxcaQ
	 KCuZsg+qqyStA6CqcgLx0HPdA9szlG8po6pC3vQnmQZjEAnc9VvsmU0S+hO1wnrO5jjUB
	 Dj5R23RvRDvR9F7MaYpQCOm972vBcBFYk2UpK/vcjgl0/JksO8kfHHyhp69BK9l3Bd63D
	 KnQqAdqBc0GrXs6yUYLeRv573ZMaf7i/JZw/fihu+JgusWqCe4OGe4v5x7VCypirJUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792546598;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=9DWXQQtxd/YTIhHjVZl8evK/hoMf2JH2xzvEAV82hQ0=;
	b=gGLTxbwJUXR3fKAy3olJ1XpugGzysxF+br2Ur3CP8CVLwyaE3uwhUVNOPsVlstPPzfWM
	 uqrqq4tVCd6ojeryUeo5Z+6FXnNxqIAlL3D0ua5qf3M4EUgdVjAri9RKYdAg1uYMA7jaG
	 Kc4ceTOH0vmzTZQMNdt4HJlmQZMk6WI5NSsKVmLG6HqG2rL3ZDaNA1qNIHk5fLAiIzcEA
	 noJdsepgwgA4ADnZCLyp2hHxQ5iO0F2S8ZLinx6h9cEL3LOlcA2Q+9VfLdmmoveP8FiVd
	 0SnKrueqipGQax4MLe1Vji4eJMY9PUchv0yZ8wQ5ulZecN7a146D/3x/xF3JMQHkKBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WylmPhEm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F511606A319;
	Wed, 21 Oct 2026 01:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WylmPhEm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EFA91F000C9;
	Wed, 21 Oct 2026 01:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792546597;
	bh=9DWXQQtxd/YTIhHjVZl8evK/hoMf2JH2xzvEAV82hQ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WylmPhEm8Qw82UTPE2SDMvY93pvffU1ZuWG1/LmcqE+HCLtGjvWjsD7pgCrCW9hdN
	 3W8wa/0LJ6O51jeTwmTAp4YK01yixY/s/dM2KGKNjoTEAqsVMAVa/cENxo4ava8dvt
	 6vODoYEunR3cUvtTIVUCKariZS2Kih7zXcxK1tbjw7EeOwN7HTSZG7UW+r/Sdb7GRm
	 o1oJ76BdWIbPSgNvrKZr1W1U8q3gBxttr5yocArlsnsRM3Q053ufEEF5A83KH7cEsq
	 9NTZfHW4yhU7MluJ/MY9LKFxbo+od/7L4BEIVx40udolZLx3GZ2J3n4ltxyltwmZ7b
	 rgODnPEWfPs2Q==
Date: Tue, 20 Oct 2026 18:36:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, Frank.Sae@motor-comm.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
 jianmin.wang@motor-comm.com
Subject: Re: [PATCH net-next v27 0/3] net: phy: Add driver for Motorcomm
 Quad 2.5GbE phy
Message-ID: <20261020183636.77f631f5@kernel.org>
In-Reply-To: <20261020021929.3028490-1-kyle.switch@motor-comm.com>
References: <20261020021929.3028490-1-kyle.switch@motor-comm.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Oct 2026 10:19:26 +0800 Kyle Switch wrote:
> This patchset mainly implements the phy8824 driver. The phy8824 is
> an Ethernet PHY that provides one 10G SerDes output to four 2.5G ports.
> The driver mainly covers two application scenarios:
>  1. external PHY8824
>  2. PHY8824 embedded in a switch.
> The patchset mainly consists of three parts:
>  1. the DTS for the phy8824
>  2. a generic template testmode configuration api.
>  3. the phy8824 functional functions.

## Form letter - net-next-closed

The merge window for Linux v7.4 has begun, and the net-next
tree is now closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens. There is some uncertainty
about how long this merge window will last, so please check
https://netdev.bots.linux.dev/net-next.html
before reposting. net-next _may_ reopen on Nov 2nd.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed

