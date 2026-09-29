Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB2B233722;
	Tue, 29 Sep 2026 00:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790640541; cv=none; b=ArKvtSSIiFKSPw+zEcsCZswSnFVZObAo+NaQCfTc96OaGnNlue1bUSXdFOL3pBIn53fd68z3Rg/qomk+naKGy0ZzKzGDI887T2TuxS+gUU5MCkwKIAK5q++gY4bNweRyMY4w2JbFG1vSg7qXHSzkyHrj0aYvFeIo983SPmKXaA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790640541; c=relaxed/simple;
	bh=N/t7V+CyYFzGbigEWV+QtMUvKX9Fdy4EVU2uQ6+oipU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S6JR1L+22Dx+3R8BLeiW1lvl5jS8el4rdLcwkU8BZyva3nz2+wrtGUHtwm6mnz241xb7a1deCAeu96TUYbQ7DnmHdHM0nlXAQPzCbg8VdNf9z4hx1WTwxJ0i4M1WrgccL/M4bHCjjfOzE0O4W+eb98CMwwtyHLi4nkCLBiCzpnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTqdjXfj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTqdjXfj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E4D71F000FF;
	Tue, 29 Sep 2026 00:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790640539;
	bh=uwY8xZ0mTXjs2W04kvJnCd5innU5VsqqxcxbDedfPiU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kTqdjXfjFtL9/ZFhLKgr3jGpTn2ifkiExg/YZOP+F22K4whvDF7b+/wBH4eonL8a5
	 ctS6Jtt3LjlmnOLX7TNZHQeXQDPLWuTIT8svFViJKR2ijTab3hUMEPphI9J9pnuVmH
	 LZ/Lb4xswm+Bl0WLEnu0u7hGqd+yFdnqGudSQKcCkEpUkc1Oul1Tm4wy6XKIg5KoGL
	 WZSfCqyUkemeJqaGHbC9db6NMFqMhVCQ4tSaJ0BMZRbOkj/VquAv5jP0M0M2ijQfMy
	 Lj55zH19CV9FBAcUouWhL86x9B2KhRBxr4jZgNj43wMMbaGibQ/sthmlHH6oDc5NDY
	 3XSEc/lC5jmzQ==
Date: Mon, 28 Sep 2026 17:08:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Doug Berger <opendmb@gmail.com>, Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Zak Kemble
 <zakkemble@gmail.com>, Simon Horman <horms@kernel.org>, Ryo Takakura
 <ryotkkr98@gmail.com>, linux-kernel@vger.kernel.org (open list), Nicolai
 Buchwitz <nb@tipi-net.de>
Subject: Re: [PATCH net v2 00/10] net: systemport: Collection of fixes
Message-ID: <20260928170858.5ee4ca9f@kernel.org>
In-Reply-To: <20260922232440.598918-1-florian.fainelli@broadcom.com>
References: <20260922232440.598918-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Sep 2026 16:24:30 -0700 Florian Fainelli wrote:
> - dropped patch 4 and target it at net-next
> - dropped patch 11 which needs more thinking as to what is the
>   appropriate DMA teardown sequence wrt. topctrl_flush
> - addressed Nicolai's feedback
> - added Nicolai's Reviewed-by tags where provided

Ima pick some stuff from here out for net and some for net-next,
rest I lack clarity or AI asked about something that _seems_ like
it will need an answer.
