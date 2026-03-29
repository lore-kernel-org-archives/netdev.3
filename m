Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112541F7916
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 18:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774807885; cv=none; b=ZhCBKP5nsiNNEC5vuGY6dIH5t8ERS0fJVwURQBEcEVVpBwcuXKkHGVq1AgLWVtXw2yz9DoF1RqZFdneAYBFQkoAVnYyW4P7/FRG1g7OIVOuFXDsGXaq2Ht2grabvbYhbwae34q7ZEgHmEHbosQP5lkR4tgFKSeA8DOnApxHXBlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774807885; c=relaxed/simple;
	bh=LafMpKW3NSnJa5FfLZmmzqltgjxT9kZoM/+zl6NnOfY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e5cqCC1xroCCBUDS2TDB7KKemFTTSem6KrhVyti7HjXUvAJlaJc84YNUC7LFg9fm4YFHoyYEGCKpu2A4uHbWVgag+Ang2pnp0TsrLZu5ScHG//naUSjJ/GKvhhVENAR7dTBUKsc6WaYovX/op3thtHb1LaqsE43LpFI4lk60Rfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQbJ0d7m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQbJ0d7m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C467C116C6;
	Sun, 29 Mar 2026 18:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774807884;
	bh=LafMpKW3NSnJa5FfLZmmzqltgjxT9kZoM/+zl6NnOfY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LQbJ0d7m1/4MbRj5Gfe3XxX/23mxGIieJS6s4DaYHm+Hy+HdfBeqs77lESjTdVKM1
	 kLcU88DlmdETb6SoRTQ4+OyHSjoapDFHBEge2uuxUKb1o3xXGf6p1GuFmMOaKQtLO9
	 xXOXSvM6pn71TueIDWkAkVDJpL2US9YS3eRalTUuzwedoDvXsz75Le3501eDcZXjzK
	 RWe0z6zORWeLKVgYFCiWkSZLsOIkdj3A5ZtgTZAmTb7y2dMRisBDtNZSJDJ5IVrwrh
	 jKT0plrGbQ3ctfzbGza+89J2IVfsQdVX5AUR+x+XjZMtw9ZMLDajWVUTrIyWTZTYjk
	 wqVk4LEnc1eJg==
Date: Sun, 29 Mar 2026 11:11:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org, Ong Boon
 Leong <boon.leong.ong@intel.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 00/10] net: stmmac: TSO fixes/cleanups
Message-ID: <20260329111123.740bada9@kernel.org>
In-Reply-To: <achJ1dfeT6Q8rBuX@shell.armlinux.org.uk>
References: <achJ1dfeT6Q8rBuX@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 28 Mar 2026 21:36:21 +0000 Russell King (Oracle) wrote:
> Hot off the press from reading various sources of dwmac information,
> this series attempts to fix the buggy hacks that were previously
> merged, and clean up the code handling this.

We have a limit of 15 outstanding patches per tree.
Please follow the community guidelines.

While I have you - you have a significantly negative "reviewer score".
You post much more than you review. Which should earn you extra 24h
of delay in our system. I've been trying to ignore that and prioritize
applying your patches but it'd be great if you could review a bit more.
