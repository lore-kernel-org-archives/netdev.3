Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7E4231835;
	Mon, 20 Apr 2026 20:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776716330; cv=none; b=KaTsPQURFwSrsHJxnuLhoJ8+8Z4Z4svwZWlpxnnMoxWbuqctZSpdgv36FvBY2cIQKQWZo71Xq6RPZ/pVqlEvUVLuBfo+4Fr0Iaa8sVHJ1/Y05WR5q9fXDtr/oLaElq6rlHmJmsGwj3aUIGbQwZMFJ/J8+/RAPh2fa29h2wN+vWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776716330; c=relaxed/simple;
	bh=BMF0ehQn0cXbXF9lZDx290yo2BuuZJgGwTFBQI2McNs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hf+X4P4xITKk/qAktS8lpOFmNygjBQTcBufFuoiJbc4ElvPZPLLa9hvKFTIqR0hgCoKZiYFleD+hmP2B4fuOpdAS4Hm6Umy7bsWYxcpWBO4ZqDgaFIczcMrPOIyKII+1Z7vrFXwt4n4fQk3DJc9wl3ouF2jGm1DpnQ8II9kkPU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fm/ulP0M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fm/ulP0M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B8BC19425;
	Mon, 20 Apr 2026 20:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776716329;
	bh=BMF0ehQn0cXbXF9lZDx290yo2BuuZJgGwTFBQI2McNs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fm/ulP0MHmGZOgh6qHknr7+HQSaZq7tgU9iJtng1VtkngGyT3co4B1sqgu3Mg4vzN
	 AEL3kCzF5LdoDrflynN2hX8+Zk030A49VFXUlupgD8CRzwTNaYtV+L1TQ8KPNJzMUz
	 JSPv8/HLkqbdmO2JZnbk5b8hPuKSGdUKwG/B4ezNHcODqse8bpUNmykHdWUN0gRK1j
	 XKssicEce4uhKjzAM+7mCc/S113OoHVkuy/T3+uAW4d3esOXSn0aagAVSjvxUALt+h
	 7Nv2+znIucA8jBZjT22IUwa+3OMk3pMFYWDm7CJ1cP8NhOzwF+9hjvK2ht+yfqWpbq
	 nGFj2YG3BG2SQ==
Date: Mon, 20 Apr 2026 13:18:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Qais Yousef <qyousef@layalina.io>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Vincent Guittot <vincent.guittot@linaro.org>, John Stultz
 <jstultz@google.com>, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] connector/Kconfig: Enable CONFIG_CONNECTOR by default
Message-ID: <20260420131847.75248693@kernel.org>
In-Reply-To: <20260419214217.108901-1-qyousef@layalina.io>
References: <20260419214217.108901-1-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 19 Apr 2026 22:42:17 +0100 Qais Yousef wrote:
> To make new tools that depend on it like schedqos [1] more reliable, it
> is important to ensure users can find it by default on all system.

If scheduler maintainers think this is appropriate they should take
this patch via their tree (please). connector falls under networking 
for historical reasons (it's Netlink based) but we lack the context
necessary to apply a "default y" patch of this nature.

default y should be used if the symbol is necessary for most Linux
users across use cases and architectures. It's not obvious to me
that that is the case here. The commit message links to a tool 
which is less than a week old?
