Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67656155322;
	Tue,  3 Feb 2026 01:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770081380; cv=none; b=ayJH04X/YlS2CZC0/S+Sv4zN+83HvR/WkDbwPuNkfWlKEdmF1E2xtS/0ExihYvnY85ZS93sgrsbG5niJb2okYI030KwXO3waYOVfUzn2zx28g+A3YltD9gvU23hWOL9QGL/MSbGDHDS530lrm/ACDtw4ml9a9Q3giCh5OybdswU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770081380; c=relaxed/simple;
	bh=b5FnBtRSQaxS9+SaReP0mpmkQR350oaH8JzRY2sa0eI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KDPF/P3Pvg62/hCmS29uQwL4vvmJokws5YJk/8Y3+1vSAiesU62CCqAvJLrMQONo4Y8dBjynAkuWtEdmS9rpNy1qtsGrFphLAnDE6S+bZUJeqlnwyjrGr19xiWNHQILUNKgZjd1kpe9IDLs5jR5N5bdPve89h9r13BCohjGsxJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5BGmGmw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5BGmGmw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98B12C116C6;
	Tue,  3 Feb 2026 01:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770081380;
	bh=b5FnBtRSQaxS9+SaReP0mpmkQR350oaH8JzRY2sa0eI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n5BGmGmw75qpsvLrqpIR7xXzZ5HMPqyB8JFuPipsw9nOjzKXnRVdoxDoawKGYXQBq
	 rmHQqszW1z5JG92VODHNh6FSU5w8ZfNq/xn9Dh0xDM34ltciCJHmP39vFSSWFE8sRk
	 P0+FzfaLIS4zDFu3gpD2qgDjaa3HpG7jdiRr+r1b2eeLw/CBxuJvtEsopQCrIleMFI
	 jBwM6W+qb9VzmIfmxBfOzX/favaNcsoS78jDPmclKvGfpsFJE1IEgeJCvR2cVjKJ62
	 P7YFoOBS4iIMKLpv+70aRoR+/50EMlSDfAE/RYl0kENrmsfu7r4GYkhUvLPm/eF5hD
	 NeNwKEWzX6jRQ==
Date: Mon, 2 Feb 2026 17:16:18 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Oleksij
 Rempel <o.rempel@pengutronix.de>, "Russell King (Oracle)"
 <rmk+kernel@armlinux.org.uk>, Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH net-next] net: usb: sr9700: remove unused CRC32
 dependency
Message-ID: <20260202171618.5d11f957@kernel.org>
In-Reply-To: <20260130115945.49875-1-enelsonmoore@gmail.com>
References: <20260130115945.49875-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 Jan 2026 03:59:37 -0800 Ethan Nelson-Moore wrote:
> The previous patch to remove code for the nonexistent multicast filter
> removed all code that relies on CRC32, but overlooked the Kconfig
> dependency. Remove it.

This one
https://lore.kernel.org/all/20260130055123.19269-1-enelsonmoore@gmail.com/
?

Please post a v3 instead of these kind of fixups.
If you notice an issue you should reply to v2 saying that there needs
to be a v3.
