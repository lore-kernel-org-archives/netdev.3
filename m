Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2001A23A4;
	Mon, 25 May 2026 18:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779734160; cv=none; b=LEiR1sGM4TsPbh3ZdhVylE8opdmmxyOufZKHpJfypkCiMZoWFbQidIhw+H/rdeHEdtvwJdSnBt7NJpDQ9/pRFP3nbP75cc9b50+05aPKJIpzInKM0jH2LV5Wp3wEkCcwgccvN5Hgwba0X4Lkn7g+HIbPVKSyV4vuIl2EJy2QS00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779734160; c=relaxed/simple;
	bh=eBwH9rWmf+4lIJnmfdCexfouZbIfdjMVSlP679q6Y10=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y64ZfCWS+RTcBtVae0gL2qPNlQxRFchZNXCpSPnIO3vPbj5K3pyXZ6vNGDTCr2PItkbjaO/jy70hJ0ZdYhThhwiEjSRzCNfY4mrciM1GIEDxhlBxCT4/s8uDsFoeKCKzZOWfeSr3pguoWZ4+cXqx/rAQha4tq+nQ8QRgqR7W04w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kSFwvaOQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kSFwvaOQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D01A61F000E9;
	Mon, 25 May 2026 18:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779734159;
	bh=NdUEHvy6IiK6HI8x+dd8eQZG9wUjSih5j8Or/mbnlpI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kSFwvaOQEC6jH8m+ukkHJjItrWnK5Dfm5FJ+c3mO24nBNfxYTCTNOdjRbFKH9z5XY
	 I3VQWd0MurUBb82eWUeRuZusFJcPlm4x7zFEUUwc12PhU/8/LYroc+U7+KKH+THQKt
	 kqM5MPAi+UdGGaDbg23Gf7eaZKFhhL8Yi2fXKFavTa+EQ/sZAtepgWvJYtII0wlNan
	 K9o/bfgyvM+byJBNpuKngLYHLSekLtDji5mpg6tV8Fqa568hpU7C/WS3kOTzEaFZTJ
	 7MOGkTjUgeM7ozY4rXjYg+IkvFD0Gkbj7Nr46pF9GvYNz3wRqCmvPhy89lA5bFHmFJ
	 ArcwjuzrFLJlg==
Date: Mon, 25 May 2026 11:35:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Russell
 King <linux@armlinux.org.uk>, Mohsin Bashir <hmohsin@meta.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Bobby Eshleman
 <bobbyeshleman@meta.com>
Subject: Re: [PATCH net] eth: fbnic: move aui and fec from fbnic_net to
 fbnic_dev
Message-ID: <20260525113558.0b6a461b@kernel.org>
In-Reply-To: <20260521-fbnic-aui-change-v1-1-fc0c46e8e682@meta.com>
References: <20260521-fbnic-aui-change-v1-1-fc0c46e8e682@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 May 2026 09:51:33 -0700 Bobby Eshleman wrote:
> Subject: [PATCH net] eth: fbnic: move aui and fec from fbnic_net to fbnic_dev

reportedly does not apply, please rebase & repost
-- 
pw-bot: cr
