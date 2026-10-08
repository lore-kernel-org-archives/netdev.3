Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E944C3B0AD3
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 16:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791478060; cv=none; b=GU1wQiB4qKNWdCXQshBTvsnEGTCvCBgO851NW+CAMPY5tKFZEJ+fQz9u1szOl3tUQ7ldDy9iuo79D1BHWBbTopiWy1SeTsODZo55BcVojIRSgEqxwVK09sUL2z5d/0Ps0CQ18WcbGIFzYpv5kPxS/zChPkl54rb+iXtX/Ej2oSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791478060; c=relaxed/simple;
	bh=/qhWlmE27BABPGY06UBdtsWTeyecBiJUfII/sr9F4UM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kq9BV52Jn6ZDnQtpIIRImL+K5/R19PNYxwq+xeBU33Zmp+eNVfTA915I1sfRvb1+42eD3PJ5+3f3CpGCnAY5Z+skuSNRKxxhDUT/UJuSiz3JBUvE4YrXocRz/EnyrJG/whiSYegqJeyABYwHkn9BdKTxh5xglkffRZF4+5j4NQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oQ+oNeho; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQ+oNeho"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CAD41F00898;
	Thu,  8 Oct 2026 16:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791478056;
	bh=CVMMo/1QCvPziTsi6rK1XAcF4mZm4Qc/4nXVsZo4GiM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oQ+oNeho3a/os54lSJOsyoNv6Pb4wu01+C7D6017KEWE9SUSf7Oqe/Jg+jOV/S4P1
	 2f6xwAnhmFn4RRA1RqF+0xh8HiKr8K/ozrdkn91IQ0FL9xGZrKt83JzctznNFjNCZ5
	 K4L6eaxLvjAw6EeHbJ2gr7vIdTpb9Z0Cp9YJZrrM9is1yIoapv9iZjztvtsTA8rdAC
	 V2pAreCB5pqTIY/Q23WZ6/nEzm/8bdrXF+WkSahdS02kWHErNWmpxl/gMyC1pzYXTj
	 EGoHSsqfFNLmK7ZW5cw0ZWYDNpFM19SeQx9UT5711e8WmN9qJRhck1oSEPn5610cMu
	 S2hWlekN9QNAQ==
Date: Thu, 8 Oct 2026 09:47:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yago <yago@yago.blog>
Cc: Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, Andrew
 Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@kernel.org>, Martino Dell'Ambrogio <tillo@tillo.ch>
Subject: Re: [PATCH net] net: sfp: ignore soft LOS on FS XGS-SFP-ONT-MACI
Message-ID: <20261008094735.583b5248@kernel.org>
In-Reply-To: <20261004114408.754312-1-yago@yago.blog>
References: <20261004114408.754312-1-yago@yago.blog>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  4 Oct 2026 11:44:08 +0000 Yago wrote:
> Signed-off-by: Yago <yago@yago.blog>

Your legal(ish) name is required to contribute to the kernel.
-- 
pw-bot: cr
