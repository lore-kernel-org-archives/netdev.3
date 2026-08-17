Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736583EA968;
	Mon, 17 Aug 2026 15:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786981102; cv=none; b=NZ0+wjE0wCNJEHme0/gp+qH3vyzWpZZtwDbSsr/DVqn+xmzoF63uZ7z+C77uHGxbQl28/ewvjP2SQS5Gdh2kmIKKDKvicPwJ1BGxbiz27l37M6ejZR1FNGd6XrW9G6qAZbu1M6rva+5VJnws5OjYH8fsTUP/LIi7p8P11uSLPtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786981102; c=relaxed/simple;
	bh=eeHrPJk9gy+K8yMel6HsWsQYL+cP05fbS0ciXBYC7hw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bjtyrF5pt48MGIoR7VJtqYjEVPmhkgj6WDFU8IbmPJpIGHsQBD+avge18O5/gb2ews8QZeeB2yU26zomOtUYADGJtkDKkmsftb3OnxgAQGPFiGiy3QWLmy5iA747UKe7a+ONGMO0kQ2+amjSKpCVz53zChKE1ylWc6YaZIPqIkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZvjcytQr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZvjcytQr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6664D1F000E9;
	Mon, 17 Aug 2026 15:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786981101;
	bh=xKXOCD9CuZCCFOTORHsxB/Y4xy2wPXe8BRMSxN/bXRg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZvjcytQro4FcohRmb7N6AK14yxjEkep/XoDVLoNLnoPY0rTz3/ej/NX2dU5EaOQS9
	 lWNnTpMnK7QCa12ivhA6fCXvPYeHe3hhr/ZwgtIK/JA5lhGCzu/GFzGVS7jPDHt41F
	 rSldX9QCcyshIOMubkTFvvIilwVY+Yz7v4tQ5jl+GfqyKjDr49jMH/5QoWa+MMoUvL
	 aYbYA0CtVghFN+b1UJh+he0Rk0JcUe8bgcJDX0nJ49Gpqys3jVSoI/nh4gBrzPrk41
	 4sIv9wtxaZiYUxw9DY423vOymteEHbxaKwvX7blDnvRLtHkHKIRAz8EZ5BI1uYh4Fa
	 25rgBGvslelWw==
Date: Mon, 17 Aug 2026 08:38:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Vladimir
 Oltean <olteanv@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 "Chester A. Unal" <chester.a.unal@arinc9.com>, Daniel Golle
 <daniel@makrotopia.org>, Heiner Kallweit <hkallweit1@gmail.com>, Russell
 King <linux@armlinux.org.uk>, Simon Horman <horms@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, mfd@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v20 00/10] net: dsa: Add Airoha AN8855 support
Message-ID: <20260817083819.67dff919@kernel.org>
In-Reply-To: <20260817082034.20326-1-ansuelsmth@gmail.com>
References: <20260817082034.20326-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Aug 2026 10:20:21 +0200 Christian Marangi wrote:
> This series add the initial support for the Airoha AN8855 Switch.

## Form letter - net-next-closed

The merge window for v7.3 has started, and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We will only consider applying net-next patches which were posted
before the announcement:

https://lore.kernel.org/20260816155953.072d73da@kernel.org

Fixes are obviously welcome at any time. net-next patches may be sent
for review and discussion only with an RFC tag.

Please repost when net-next reopens.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed
