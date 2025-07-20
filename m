Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3AC1F1905;
	Sun, 20 Jul 2025 14:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753022057; cv=none; b=IAL7E8YH3K13nH0RFBvkiGS18S2mzsSKzwvGiTUOkj5x0Nc+Uimrk1EWF89OcCOrSeEU0XuvGQZNBJprP40L0yeq7r9/C67QL0MPzGpYjcgB0X6i0flA+KB7qvB8z2I4aUlipBxcgwnOOleY0SJPYfEnpF2Jc3wjOFSMkGX+u5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753022057; c=relaxed/simple;
	bh=233+4YFYU5Z87c51IPyrDVdldtXMXBDkU9EDcJFNeGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VF+HYPnKEFAhCEXc2s/FiCfeEO1S8xb7Ur8xT6VlW3NSZ3Ef1KNBUIlnIJ3aXGFYqWYtDiK60yDiRpdLDQfdz02/b4M+gKPJNQUspR2pLcWIYsTph113PSNtcfW9n3xDhB5ROxcSkPySvi7C983hKMyLqlgvkcZ5fVcTK4lewGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OGoYsNWP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OGoYsNWP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 112EEC4CEE7;
	Sun, 20 Jul 2025 14:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753022056;
	bh=233+4YFYU5Z87c51IPyrDVdldtXMXBDkU9EDcJFNeGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OGoYsNWPqHg1lx/A35D4JYuyEcCdOdd/TtZbOIMxAgAxOZfGSbhvsqnWcP3dCP4wQ
	 wY6Oi3ebiklbnO9YzzC84j9ZgNjEOyVbwDCAQOHcrKQfrjhMN5hH47H16viYfoOERW
	 egIYHusySI0p0swwt4zpkqpE9Whu0KJ1aFitnSp11BIvfDS/L6fr6ERkgPam5O6qQ5
	 hnzL+S7k+L0PI78LXVCbX5H+ksYqfOGJ1v12V2iy/YPE0sXGVyySyRSIgJai+7ovOC
	 W0bGwV/uZwLAPDctM+/lEQuwtXuhVotscSB7sFs49C0tNIZJzgpzS3dR0jOGja4VrB
	 PxQeucF8i6Fjg==
Date: Sun, 20 Jul 2025 15:34:12 +0100
From: Simon Horman <horms@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] ip6_gre: Factor out common ip6gre tunnel match
 into helper
Message-ID: <20250720143412.GW2459@horms.kernel.org>
References: <20250719081551.963670-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250719081551.963670-1-yuehaibing@huawei.com>

On Sat, Jul 19, 2025 at 04:15:51PM +0800, Yue Haibing wrote:
> Extract common ip6gre tunnel match from ip6gre_tunnel_lookup() into new
> helper function ip6gre_tunnel_match() to reduces code duplication.
> 
> No functional change intended.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>

