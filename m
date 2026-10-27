Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793059645;
	b=wHE3khpm7kbK1LBNu8kNovQPGnjaxK3+IKnz9fH+0RJDOd+9nAghfkQ80y8c5nLEnnAR
	 gQLTIGOxP9X98aenkrGD250AArpVX4BATMmy1V7LNK7ojsskVJcjKQgLJAZ6Ys/8yMdiZ
	 bbE5XrTIeuLh3BMn8tnNPa5NPCWAAdgI7J0KiVrTbxybbQGewK2K1iakl7aKPwgsINJXk
	 Dy7wtvtRIO7UGi8BvXDx6F+cqO5v6NvsODkRhC9mEfhg7nAdL4WlQNHmX0+beqnStSWy8
	 Ba0CWqtF2G8/vrZZWOWfZT27Dafizcrm6gRzDNdXft0f8j6t5wDuvbvNhBp8/ADPdNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793059645;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=STw7ttmyMfYQ57hNycIgofafN4euvCy7hTw4Wf5urN4=;
	b=nJ358Aul+aPos+ToZpQsQznNikbFI3/4zpwj4vipa7IAPu5mI/AyurCpqMW7Re/TssDQ
	 jbze25RUA/6SQ7drHSVkM8WPX6y+op/7TcOtoc6RaSMyUkKOusky8Ewjo3HFy7Psqxg2c
	 rLGgeZg8BVWAjggytTy0yP0esu5qmwkXodYGteCbaOqb5JzRRDIziZPYYx+U+Q2G/MArp
	 kK/yuyeCw6i6smBx+W3+wxyLXVPP85uRwpGE55yO8/PhuXbivNLljYgmlGZPG8F8cs1F+
	 rmjYyW9jOkIHs2Lmt9y8c2ooCtAZdTrTWnDgnY6EqqH3tr9Vq9H9/Hasgy9Eku4xDtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JdDu1VTz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3283606A31A
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 00:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JdDu1VTz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2278D1F01825;
	Tue, 27 Oct 2026 00:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793059644;
	bh=STw7ttmyMfYQ57hNycIgofafN4euvCy7hTw4Wf5urN4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JdDu1VTz15xazOuL4vAiYSyyquNkR3WqLkDNjGeNqnYSWXL6szazAuBtKrWoBSEkU
	 ixJYESTS/SsTp12NXsfWTUuOHX4ngmm5tX9ACloEQNPxlI+9CsXJwsxUafEtcNcZok
	 Ri2LHj8TuiwktuZNWSISD8YIMvDIDbRF3C3Dt1PedPRx08/ZLiivyCrSjEISsy+iss
	 8/W6H50skh/YVPWTRLc3YotD0kba42/VRK6yFy2yUQYqofFMvvib3DveSRmRZO1unh
	 ZWTluRxei5brtl6GpUG9fIEeaO0dNhZ8YaCSdoLOAegiJbs91f3ErmmJTjn8wriv9T
	 fHVPKFVRuNPJw==
Date: Mon, 26 Oct 2026 17:07:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Minxi Hou <houminxi@gmail.com>
Cc: netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>, "David
 S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v4 0/2] netlink: specs: fill in the missing ovs
 operations
Message-ID: <20261026170723.612619ce@kernel.org>
In-Reply-To: <20261025103409.3519874-1-houminxi@gmail.com>
References: <20261025103409.3519874-1-houminxi@gmail.com>
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

On Sun, 25 Oct 2026 06:34:07 -0400 Minxi Hou wrote:
> The ovs specs describe get and new but not the set and del commands the
> kernel has registered since the families were added. This series adds
> them and names the attributes each handler reads. Nothing here changes
> the kernel.

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
