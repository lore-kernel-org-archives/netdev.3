Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CFB3803DA
	for <netdev@vger.kernel.org>; Sat, 27 Jun 2026 22:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782600644; cv=none; b=NohFXfCqJRK0udM+OWG2ArpHvOAJHuMj/w5fhJX2p7WBEznduFF5vYIkSa3vXwsItwlQts0dc/D667TvducFr4MvEji28AiDqhI7gENBcuVUzEgzM4eYHSJ8BiYwxVa0001qJQFWpp7eFTllr7KbGbsl3CgGLtx6jNFEOha4r9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782600644; c=relaxed/simple;
	bh=2CJnhDF9DD1OgzYpwvPSGcKGsVVRzTn5Hb0KmOffXSQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=p1gAQulFg1UFLWsFYleorjWiAFb89qix6se3L2wK/zgUP9ml4VDqt81+dYLhviD3j1EA3DYl62wGb9NAfNdaqez2q+p1VRcSJlKIlACQRdg/XHH+7hHmPfdn6QJl75t90dCSCGX6/V8xvqYcDps6s8e/3uN/gHFod90tI+BQGh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eVPcJfk8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eVPcJfk8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB37B1F00A3A;
	Sat, 27 Jun 2026 22:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782600642;
	bh=g9TElVIDnPv7Li0JYvlHdeEO7dqICIvNnU7GJ8movX8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=eVPcJfk8sX98XZjC423SbE8k/VuJLJNuaJeplymAEs1R11Vb8UeIMFEbUGDzFN2nc
	 +RIyww1Bx0B5oAdAzS4dvwe+WTTb2CyrgzciOggWDAJJ5o6/AOurLprCZGyMnPKQ5P
	 thT2OGkG8dkHRmSNe8wvjGKxndHDXX0f6zDr/g/AcbaGVxnzCPpplLsM/KjojtiklZ
	 tjgiQMwf1a1sWGkU4ZCbG4+oTFCz3pCIcjyfmP7t/Ygr46SgGyJuXZONywcJ3lbjPX
	 xqQET2qYgiHUTX0jKr2cAitB+/O9n2QylQHaAIOKtjTK4IIYG/LTWle4a7jWEP5cyy
	 ruGIZGLcSdbdQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0E4A3938452;
	Sat, 27 Jun 2026 22:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5] net: dsa: Fix skb ownership in taggers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178260062830.1451849.3573078989535411096.git-patchwork-notify@kernel.org>
Date: Sat, 27 Jun 2026 22:50:28 +0000
References: <20260625-dsa-fix-free-skb-v5-1-b5931e4cbdb0@kernel.org>
In-Reply-To: <20260625-dsa-fix-free-skb-v5-1-b5931e4cbdb0@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 florian.fainelli@broadcom.com, jonas.gorski@gmail.com, hauke@hauke-m.de,
 kurt@linutronix.de, woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
 chester.a.unal@arinc9.com, daniel@makrotopia.org, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, wei.fang@nxp.com,
 xiaoning.wang@nxp.com, clement.leger@bootlin.com,
 george.mccollister@gmail.com, mmyangfl@gmail.com, netdev@vger.kernel.org,
 sashiko-bot@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 25 Jun 2026 09:47:01 +0200 you wrote:
> The tag_8021q.c tagger calls vlan_insert_tag() in dsa_8021q_xmit().
> vlan_insert_tag() will consume the skb with kfree_skb() on failure
> and return NULL.
> 
> When NULL is returned as error code to ->xmit() in dsa_user_xmit()
> it will free the same skb again leading to a double-free.
> 
> [...]

Here is the summary with links:
  - [net,v5] net: dsa: Fix skb ownership in taggers
    https://git.kernel.org/netdev/net/c/d4be5f6f9094

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


