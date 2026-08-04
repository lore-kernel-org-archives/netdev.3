Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3A532AAA8;
	Tue,  4 Aug 2026 01:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785807785; cv=none; b=mXmZ12a3lRoQUiBylhrw77m1ckJ+RtWMIm+ntujhVyOAcBrbxFVhc1c3umI3pvEXEw1tDgocODKyXGC2R+55sOscOY0ORoewSNNS4nEtc+MAGHf7l4Que8RYdoHHveN/12sO0VGf4rGtl+PAsBYme/CF7BUAks7zZLDUSiAfFvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785807785; c=relaxed/simple;
	bh=VlXdWwTV7LCto4gFFImF5QEKubLeu6fzgcfbalIuMoA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LXr6o/j4ntCf3rKKi0JyvJ3SnN6o6BxMgcW9eB//SyJZcvy/0nuEnZPPlV6VL2HmiTOrF0WOZkPmiP2w9c44fnRm0Lw19FMZdxmuhKCHpELSzaQ9Mc3a4BgAcvcgE+68ngzeSK59GKE7gk/20QLmqebiC9BpTDpKbrC3WEjqBdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mdryV+b/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdryV+b/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F37C71F000E9;
	Tue,  4 Aug 2026 01:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785807783;
	bh=DO7JjvLw7hnkPqHoC7TvmXBtgyEkXrMt3vhNNd4UZtY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mdryV+b/4inJrTTpR2WeVz0bsmaWlx281cGQ0MCds5qWkNGX5eOVQgHP/8RbmndM3
	 PGxjtuNDhhSsWwAIwQQoODjVPTSqAZFihsbykGp0kD6J+E/CaUMicMiNdaKDdwlf7g
	 j+z7oFzDEo5lCiNo86k+rz2clboOl2hN8KnUYxbMyCE97ZBERLwEF+bP5x+5ZuSg9N
	 /yACL6gAFE1Jo7Xn2bMFOr8xKHDHfBnD7ThURiy/0bnETMvl6dCFGZwt3d0i5Fyn7F
	 AQ35qxRxDCFsklqEXtLCw482xM4hQYw33Ex+eKlWvKpjUum2n8NNKRm2+9jsxTGDIV
	 Zlky0p/NN5oEw==
Date: Mon, 3 Aug 2026 18:43:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: "Chester A. Unal" <chester.a.unal@arinc9.com>, Andrew Lunn
 <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Alexander Couzens <lynxis@fe80.eu>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Russell King
 <rmk+kernel@armlinux.org.uk>, Landen Chao <Landen.Chao@mediatek.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Sean Wang
 <sean.wang@mediatek.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net 0/4] net: dsa: mt7530: fix remaining swallowed MDIO
 access errors
Message-ID: <20260803184302.0df91301@kernel.org>
In-Reply-To: <cover.1785427248.git.daniel@makrotopia.org>
References: <cover.1785427248.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Jul 2026 17:03:00 +0100 Daniel Golle wrote:
> v1 of "net: dsa: mt7530: fix swallowed MDIO read errors" [1] was
> applied to net just before v2 [2] went out. This series carries
> everything from v2 which was not already applied with v1 and still
> qualifies as a fix: the two standalone patches v2 had grown following
> the Sashiko AI reviewers' findings on v1, and, as patches of their
> own, the companion fixes v2 added inside the already applied patches:
> the unchecked bus->read() in core_rmw() and the unchecked PHY_IAC
> command writes in the MT7531 indirect PHY access functions.
> 
> The remaining non-fix changes from v2, dropping a redundant read-back
> and improving the poll failure messages, will follow via net-next.

Let me ask explicitly this time -- are you planing to address any of
the Clashiko nit picks and send a v2? :)

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/c41c256a5b4695bec24abc6baa4f990fca88f834.1785427248.git.daniel@makrotopia.org
