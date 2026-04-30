Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7D51FBC8E
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 17:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777569328; cv=none; b=IOr71Sq/87INB8v5Mq9F/ZqBsuA7zMjAtrqr4RKlg4+KaXkoI+Pc18Qw4nDf+iloedikvUa5VnzWYj2iYF241V9ebwUvPTCNmH1lmxKkL9FH9KlS/tVKYWdPmQbOLJpqZU04xwYjW03s3bTkmdmJO7KuzcosAU/1qqbB2D4nbDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777569328; c=relaxed/simple;
	bh=mb1Rt9GJDM6MFUJmF+OZpJrprjSJxcsE/PCQCUOVtbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JHL2p62PII5/K2Me/sRcFKII6Z17eWUl51+19EwlAJNVHBnOPxzOKE4YHdhpqjhRHCZYfX5cRjn1lajkwhcl0JlNGKshbLliLgF3dNolBGkBbQr7PfHEbGO/dJ1VcfH8PwGZEhRUcG31NZSYK00Xt++xyF3DmqzjEBNv6f3sD4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pphg7XQ5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pphg7XQ5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4518C2BCB3;
	Thu, 30 Apr 2026 17:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777569328;
	bh=mb1Rt9GJDM6MFUJmF+OZpJrprjSJxcsE/PCQCUOVtbE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pphg7XQ5aPXiMO1eyuQwlUOcgAgyKmjXmzMKSp0Gaio2wl6nqC5yLnCPPxhUGuKcu
	 fmOBvwwGdrFmg2zzViZYai0Jtmvh5+tJc7J5z1tAJUN7s5eL1yXPlXqRYpGszbIVaD
	 rv+cahNw/Dai1BBvFe0ddFDT/gNOQjHpjXs3YRskAX2pUBDlBXpCrtnWojOB4OPGDM
	 BrjIUh0mAj/sHcaXfluEGPfHAeABim6Vr4lE2Si4AACz+3fYM63EeylBhgKt8wDY4+
	 TMmiNvpY+GhZNg1UQ52kL5YKnl9BOk0yqd7/OTt97BxByr7WGUTcpTSceBhXjRlF0Y
	 DZk4AJQOMh91A==
Date: Thu, 30 Apr 2026 18:15:24 +0100
From: Simon Horman <horms@kernel.org>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: Matt Johnston <matt@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH net 0/2] net: mctp: test: minor kunit test fixes
Message-ID: <20260430171524.GE900403@horms.kernel.org>
References: <20260429-dev-mctp-test-fixes-v1-0-1127b7425809@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429-dev-mctp-test-fixes-v1-0-1127b7425809@codeconstruct.com.au>

On Wed, Apr 29, 2026 at 04:21:40PM +0800, Jeremy Kerr wrote:
> This series provides two fixes in the MCTP kunit tests - one exposed by
> ktr, and one found while debugging the former on different VM configs.
> 
> Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
> ---
> Jeremy Kerr (2):
>       net: mctp: test: use a zeroed struct sockaddr_mctp
>       net: mctp: test: Use dev_direct_xmit for TX to our test device
> 
>  net/mctp/test/route-test.c | 2 +-
>  net/mctp/test/utils.c      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

For the series:

Reviewed-by: Simon Horman <horms@kernel.org>

