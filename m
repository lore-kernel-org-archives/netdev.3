Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3433624B7;
	Fri, 13 Feb 2026 15:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770996419; cv=none; b=R/ezBGtOJ3sLXIpcVdHa5DNlQrveqWFr216Z2233iDw/RWbxDyQEbmIyjaARAnmIbFugIRzO1s5gjlQ+S8gy0F8v7ydLhuF1CD1X1lyGdjQ14OH+0PPbfYGexDifYA24BHMcEzQ1jXXPcv70S65BqNen19/jNHM5KmzHdcql3r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770996419; c=relaxed/simple;
	bh=TjKjfh4AHZJmJ5vSp/9BroQ96QAtgOr9pMqQU9yoiH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dn5Ut6djW15RH9+7BQzH+7L3GwCf+c9Tqjz5GtnNG2RYAW3tV9vTFm3ZMo8juzh9PGkUF5wHt9yFdRD/xcyXK29CitCPy1YJ9Daj/BFceleHoHdYnH01zzqdjFbReZq+5u3x/pVKWjTRHNN/Kj1EQi4GMGH/5so/GUAsH7DSONU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CEI1wUKG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CEI1wUKG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A36EC116C6;
	Fri, 13 Feb 2026 15:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770996419;
	bh=TjKjfh4AHZJmJ5vSp/9BroQ96QAtgOr9pMqQU9yoiH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CEI1wUKGJjK7Sl3xlVdZJj/Ctg/oXEKIWcZxXCY1nhdSwYQyolQ2ZAJe97ZfhSyge
	 Ntb8w5fI0zZovkQe2uiT8KnIetp/hhvSr35UZjp2ZQsT/TortYFgUGqwflkRMpU8ds
	 l7wSDxAy5BM62Qztfv8aHjlhg16+KLo/vS1BPi877V0PJg85G1JaJmdt8alGOFVjV+
	 xsA73BqfDstqxyHHhtNRfWN0NnrcHY/USi2xnlYlX8hhYeJTTpc12Nh6UkkRzHIk8T
	 KVX9nk6Z5FYqCdMfyzhsWcb4wck69oDsksS292ZX0ddm4jQY/4yGgwaNkUbfTJaWyQ
	 FCmX5P9G3THcg==
Date: Fri, 13 Feb 2026 15:26:54 +0000
From: Simon Horman <horms@kernel.org>
To: "zhengping.zhang" <aquapinn@qq.com>
Cc: lorenzo@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, upstream@airoha.com,
	zhengping.zhang@airoha.com
Subject: Re: [PATCH] net: airoha: fix typo in function name
Message-ID: <aY9Cvud7rSw_aWU1@horms.kernel.org>
References: <tencent_5F3DFF496EC95F5BC0D71C297D088B06F40A@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_5F3DFF496EC95F5BC0D71C297D088B06F40A@qq.com>

On Fri, Feb 13, 2026 at 02:57:25PM +0800, zhengping.zhang wrote:
> Corrected the typo in the function name from `airhoa_is_lan_gdm_port`
> to `airoha_is_lan_gdm_port`.
> This change ensures consistency in the API naming convention.
> 
> Signed-off-by: zhengping.zhang <aquapinn@qq.com>

Hi,

I agree that this change is both correct and complete.
So please feel free to add:

Reviewed-by: Simon Horman <horms@kernel.org>

This looks like net-next to me material as it isn't a bug fix.
And it's best to include the target tree in the subject, like this.

Subject: [PATCH net-next] ...

Unfortunately net-next is closed at this time.

---
## Form letter - net-next-closed

We have already submitted our pull request with net-next material for v7.0,
and therefore net-next is closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after Feb 23rd.

RFC patches sent for review only are obviously welcome at any time.
                                                                                See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
--
pw-bot: defer
