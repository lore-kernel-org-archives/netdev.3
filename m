Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECBA3644D1;
	Fri,  3 Apr 2026 15:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775229171; cv=none; b=f6dhu9NBrXDb4cwvQQ3+NOR2v7jZgX4q9C3+TbvOF5rG9oNUReN0W20h1uXfLg1wRTgX84Kwnjes5UDp2C7JZK1Afpz5YRPG4iZ17ezjstL81D+tM+DX4rS/WNJopICYa6MGj9dOc5lZkFJcMynmmTXtl3u0pqfhMiZmWcBbufM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775229171; c=relaxed/simple;
	bh=a+j1yHdSKgjQjouYqPa5ixNwsQf7jH1GlqZqCqbZWA0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PoB51vd5O0B7am9WlkbzF9Ls8hPDi+Ag82qQ2j/MpsV3hstgOmkHWYBkdOjYz/MqtXNk0Y4vdNT1ft6mRm3tPFY/EmnqmRIttmskfIbKSkmIqkndFCrjJwugBvJu5j2f1kaXm8Eie81+SrdViCXIp9RKM4B0jui0d2hqTKfQkTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W3G51svx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3G51svx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66B4BC4CEF7;
	Fri,  3 Apr 2026 15:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775229170;
	bh=a+j1yHdSKgjQjouYqPa5ixNwsQf7jH1GlqZqCqbZWA0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W3G51svxLp59XBd1Su09L6VLbKFhjjdliA8PKcE4JcJXxmvkMiDiVBUY+a1OhBX+N
	 qRgUAbkyuA+26czPCHCsi6PQSLe7YZiWgQJj1yJ7Jnwab2Y2GnX0zhS83CzxK1VKyI
	 kOKdsjYRFCQnrEuAE+TdYGJ6JU9LoFmlDEveanLO8r5GbEEQo+uHAWvlhMdOzR87qf
	 +pG0SKPLdhxvEhepajHsF97+6Q1UZK70ExZjWFTyDSLENxuzS2uLZe3h/1SpvwsdGb
	 1EICAw10Y4vK9XPx80d8PUQ1tADHEUugrjia010a9VUxO+8+M/hGxMVbtQfXd3JqTT
	 jGPDkC1vKvO7w==
Date: Fri, 3 Apr 2026 08:12:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dong Yibo <dong100@mucse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, danishanwar@ti.com, vadim.fedorenko@linux.dev,
 horms@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/4] net: rnpgbe: Add TX/RX and link status
 support
Message-ID: <20260403081249.50e25acd@kernel.org>
In-Reply-To: <20260403025713.527841-1-dong100@mucse.com>
References: <20260403025713.527841-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  3 Apr 2026 10:57:09 +0800 Dong Yibo wrote:
> This patch series adds the packet transmission, reception, and link status
> management features to the RNPGBE driver, building upon the previously
> introduced mailbox communication and basic driver infrastructure.

drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h:183:19-23: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)

nit: checkpatch complains about a few lines over 80 chars too
-- 
pw-bot: cr
