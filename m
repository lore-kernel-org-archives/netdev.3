Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48390352027;
	Tue, 29 Sep 2026 00:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790640021; cv=none; b=Z6wKNgeKdGTi6ORLQOrvEydHRf69xfbSMVvgucL3c/OhMHDrRx+VooUGYNqmBrRDWYz6/j7okmpC59jiI8xcFFllFZqk8WtTBM+Zg4G6ySfeSnkr2OzAGIAMexWMXeczofDJG2a7jzOj+vy9OyOIWEvOLnN4KrlJsBvQ6Z4n48c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790640021; c=relaxed/simple;
	bh=PFwaBBBPfoMpkuptS7RbPQwvS3l52IuuDZgn3oWyhB0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tfH5BNQcqQGeFXtb3E8wbj22NgBPr4Pwu6IbTVaUKoZKBLju4ISUJi3v6Ecpq23mtujjW4FRnvHj1SXVl8hAsQ42Cqm6wTis3/GQgTgTatQ7hnfpHegq3ldlR9Dq+Lydj2B6TXQNnH6ofmK1X2U9P4PxhCaykStd+8/S6uQgt5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MxxPhfzX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MxxPhfzX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 338611F000FF;
	Tue, 29 Sep 2026 00:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790640019;
	bh=PFwaBBBPfoMpkuptS7RbPQwvS3l52IuuDZgn3oWyhB0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MxxPhfzXkEzgCroYWGwtMGd5hmW8mBwViX43g4kO00UnJ2ozgT+0nGrS2wLOR7tpq
	 Wo6JcKu/ugwnRaHeAa9pAxISzy6ZMT3fWJcdqRquLfL0Rqma6XiDaGru/WGiszAzJT
	 4dLK3/OPDP81as6ULvI3pglbSJf207xDPcRzNVABNbWCR9yWvrojvli/OxefNALitS
	 B+xMXMaJ3P9xWoHBWo/xiLu+VW0q/agCgk+/jYspTKapZHr/wKmYGyQHcBgr4OjDWk
	 jkCvLlMk6B6AMyFSwmzJypKyiPjrYg6TwISnVRocvS/0mQr5UUvGmW1irycd/v3Xlj
	 5dNpfE4M6Wk+A==
Date: Mon, 28 Sep 2026 17:00:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Nicolai Buchwitz <nb@tipi-net.de>, Doug Berger
 <opendmb@gmail.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Zak Kemble
 <zakkemble@gmail.com>, Simon Horman <horms@kernel.org>, Ryo Takakura
 <ryotkkr98@gmail.com>, linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH net v2 01/10] net: systemport: Fix buffer overflow in
 bcm_sysport_get_stats()
Message-ID: <20260928170018.5284b925@kernel.org>
In-Reply-To: <20260922232440.598918-2-florian.fainelli@broadcom.com>
References: <20260922232440.598918-1-florian.fainelli@broadcom.com>
	<20260922232440.598918-2-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Sep 2026 16:24:31 -0700 Florian Fainelli wrote:
> When running on SYSTEMPORT Lite, certain statistics are unsupported and
> skipped during bcm_sysport_get_stats(). The variable 'j' tracks the
> compacted index into the destination data buffer, whereas 'i' iterates
> over all elements in bcm_sysport_gstrings_stats.

looks legit
