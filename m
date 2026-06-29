Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3DB30EF64;
	Mon, 29 Jun 2026 23:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782774593; cv=none; b=kKqVi61s2AAZotQvaZaotlHFVhB3tpRLBARcK2JpWp07vsTPP/z9cdcCPtsZisg0FbEumka5b2xR9nJW76SjkdLtLfrOJvHcpiM//8sbwc1lh9IUNmdr+WdLpdUEfu24+y8u+nfVAZIyvlZMYRgz9SggV1NJkkmlhrFayo6b5SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782774593; c=relaxed/simple;
	bh=icGFh1SSUg2hh7zxcGrKPKfc/WxKw2d2Yt3zThyUmDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=elorua447T2enUi8/gAZTDDtwmhbhyZrV3jzfw/TvK9wQxUAIVKFqmTQFvcs4kyyIo9aBwe9O/CuHzqAiMqEo8cxcKGlRMFfHYh/U4RSXf01dp+dLv43CDjRltz4nxcLJecx7Q+kWvLMbxiMpf70raKv854voVQzMHe3Ll1eZNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eaLaybsb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eaLaybsb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4FD31F000E9;
	Mon, 29 Jun 2026 23:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782774592;
	bh=tRLfogdUNVUXKQ5fchqfagIJhzd1tLxjGIoy+FPAPxw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=eaLaybsbxWGU1iX1NeGmf+b6e6WNY9+QG7YXEeIQwvzSzHPbNiFjqMWwI5sVH5+/M
	 0FxO4WS4XPAwx3Hxr+FwvOk6EgUSLHH0ctbyE+EntZnYZQdyf/G8JkfpzWvAiIL1t3
	 L52GfgKDJUfbElenW4XaO6KcO+QWsC0vYIjETVkCWuxiPyExnVimj80UEn9goGsPna
	 HqivU5ppg6VDxv5G508y0bHWI9EtQ9TWLhJQh8/04Vn2fNLhFVSZ8ZDWQlm7JZcpdT
	 43pF8hJJWwUrWwv6h71Vp4VAdm/V+6FV9soxANKzCFKv8ogHbeGtOMvuYi6tXd55o9
	 1z26lL7zlLt2w==
Date: Mon, 29 Jun 2026 16:09:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: javen <javen_xu@realsil.com.cn>
Cc: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <horms@kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v9 0/7] r8169: add RSS support for RTL8127
Message-ID: <20260629160951.4422d10c@kernel.org>
In-Reply-To: <20260629071339.1605-1-javen_xu@realsil.com.cn>
References: <20260629071339.1605-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jun 2026 15:13:32 +0800 javen wrote:
> This patch series adds RSS (Receive Side Scaling) support for the r8169
> ethernet driver, specifically for RTL8127 (RTL_GIGA_MAC_VER_80).
> 
> RSS enables packet distribution across multiple receive queues, which can
> significantly improve network throughput on multi-core systems by allowing
> parallel processing of incoming packets.

On top of posting this too early you're also violating the limit of
outstanding patches. You must not have more than 15 outstanding patches.
_Especially_ when you struggle with the quality and need 10+ reposts :/
The reviewer bandwidth is very limited.
