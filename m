Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793398650;
	b=0EsHnA2CiNBKCllmBUv957bNq8MjOeVmoZlMnmrV01RvK1MMlH0r8hD++Tl756J5VKzu
	 h01GiP3ToRk32gSUeWYRRt2ig33/ohIwnIIMOSDlXMZwa3e+N9hmmxaATjslF0hdkaows
	 NmaDWEXEY0Y3fV+Mby18sU4CLu/wh+ddaoOIV71V7aSicSjqLr3e/1S5bgXHtOTkyi+OS
	 QimZGk6I0Szk9TKEFux214gt4DeX22mPxXVY8pxcu4bWaDbYUMGuPixINE04kgqpJeRT9
	 eDDbCpc7qgRk2HHJCNDq6BZey1pnhoaZUkE9wFr3NqX6imUnI1ojv7ScXmFbUlqE9Qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793398650;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=+4fsGFxBPCzVOtcfgAZx0ssUY7TnrXdSGzVeP/5K2e8=;
	b=sg77DxkGC8iFkdfAnDLKCSvxebBLVEZRfd8npbDOThaWFCikg0JwghoE7ChiB+KOjGsd
	 6YaoTBKyd+Ryg/IF4gqIs8326wkqh0jjf9ZlvjUzLC6dly+DR7cxYiAzm/D4mLWbTC9vw
	 Qvmy+k+7mRcu5fCFTXcqzgBhW1g0jVP+t92l7wLljDTM4BCyY6B9CPEqA82rbtsjXo/Pz
	 n+Erp7H6/VHcK76+A81F7nYDOEJPZPMb6qBCcWC51MsD9cnUmqxeAFxChB1w/37XQVUTI
	 AFfFCiB9LwkOTNYjs5sKvHuueZbLj/Y/JAPqvIp+RrRbP6Tn764jovXPs/yxmFKU64A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bykgm7ur;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07315606A31A;
	Fri, 30 Oct 2026 22:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bykgm7ur
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40A7B1F000C1;
	Fri, 30 Oct 2026 22:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793398649;
	bh=+4fsGFxBPCzVOtcfgAZx0ssUY7TnrXdSGzVeP/5K2e8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bykgm7urZM9tgLZyhhJ50plTQMFKWJT9cOrQjyMHZ4cvfEo4PkhUMVuGyf39ToPFJ
	 VrqFWcy5g7rgQj9/i9PVNn0E86c7QSv6dQebP/jRytcEZ6W99YLz2Kagf2jx3Mtc+t
	 xGJK1TgLgVBK4Ta1HzGEdPIhVppsRbm5hzIJbkWM4PySUwzr6KabfVK77W6hujI6mP
	 uHFnzClU3pHLX1WWoWMMGItQjvfagEsKLlGgug2+pV7mdeDSjo/OdW75frHDprZ+7D
	 qZsbOF9Pn3slRqBOdIsrdkn6LNMBsZYTBAzZgEOvZ5u3M/2k+JoTlZtBSew2gqdsSJ
	 1r61pLk9bPRHQ==
Date: Fri, 30 Oct 2026 15:17:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Salah Ahmed <haddad2inc@gmail.com>
Cc: Christian Marangi <ansuelsmth@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: qca8k: expose cached per-port MIB
 counters via get_stats64
Message-ID: <20261030151728.51277907@kernel.org>
In-Reply-To: <20261030215831.17997-1-haddad2inc@gmail.com>
References: <20261030215831.17997-1-haddad2inc@gmail.com>
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

On Sat, 31 Oct 2026 00:58:31 +0300 Salah Ahmed wrote:
> DSA user port netdev statistics count only CPU-seen traffic, so bridge
> offloaded forwarding is invisible to /sys/class/net/<port>/statistics, to
> rtnetlink IFLA_STATS and to every kernel consumer of them

net-next is closed, please repost in a week.

And when you do please trim the slop form the commit msg.
