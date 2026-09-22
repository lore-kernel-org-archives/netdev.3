Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EE64A43E8;
	Tue, 22 Sep 2026 19:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790105818; cv=none; b=YKCgpVIlXNCskZhHqOEVyrg+tOKR/xv78HXWLr2WY6D1fd8Lq88qCOVmczeEBOgCKak3cm2sgdoOi+ThMAbUmjVPomDV3mVFcu8f0dM1hwSbYcAILO6Ok1OjKOaheDfuJINZdxB+MCUzd1Mtx5hKLDUXMugA8NOfecf+IDz2LKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790105818; c=relaxed/simple;
	bh=u5eC7QbN/0KMiGIfAnewygJ7wjNim+8UKid5Q38XPEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n+BUJy1u8oJ8akLiOJ2rluAgrsdD1eJwXmFDODCch+sun23p9NG37iozagrc2qcgDiMycUxdGEZeXx2l7asq224cyrQp75kcf1//5Yu3qbK8IWmPMCGg98oJqR+SgXH8U9Qls9KMmbDdV4M4u7BLpBu+kMRUxgrPpnR3O8+TqNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j0jidb+h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j0jidb+h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89EFA1F000FF;
	Tue, 22 Sep 2026 19:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790105817;
	bh=V7bXpo0vHaFtFPd8JgONxBJ9/QU6tAtzQGrWC4wYhTY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=j0jidb+hLKwwmTBn7BvFTYJ5vD19Z9z959/j/gHZvTijOnIkb3dAx8gtFOcJFQERg
	 DF6vUuZD2q4dXkyzsrYJ0od9pAH8NbmhBDH9xFlaIQpcu8KoZsVfjTVWIYeHyukeff
	 XSYa0ZG8Omtmf07lQX71gAUZXhD1qyTDw+ST2b+5jeYYcduQr7w4diBq3Wm7iFouvQ
	 3T/3CPYGDHx1F2G9lfUIf2zszouQiAWRsmIeGMQUCKr4av08UDQc/P1A5X6keF2o96
	 Q5i+JSDpclnnimbsNh0IhyCYgMceiWXYTJc98prV0bm8DWQRvINmBv3ayiqcgyH6eW
	 GSmDKfjgComlw==
Date: Tue, 22 Sep 2026 20:36:53 +0100
From: Simon Horman <horms@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: benquike@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: slip: fix out-of-bounds access on short CSLIP
 packets
Message-ID: <20260922193653.GH13925@horms.kernel.org>
References: <20260919223432.3882500-1-benquike@gmail.com>
 <178994445036.2160803.93100448666025209@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <178994445036.2160803.93100448666025209@kernel.org>

On Sun, Sep 20, 2026 at 10:47:30PM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 (1) · Low: 2 (1)
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] Commit message describes work that the patch does not do, and
>   names the wrong bug class.
> - [Low] The new reserve literal 120 in sl_bump()
>   (drivers/net/slip/slip.c:338) is undocumented and unlinked to the code…
> - [Low] The Fixes tag is wrong.

The concerns above seem legitimate.

> 
> Pre-existing issues:
> - [Medium] The rx_over_errors early return in sl_bump()
>   (drivers/net/slip/slip.c:338-341) discards a compressed frame without…
> - [Low] Claimed TOCTOU race between the reserve check in sl_bump() and
>   sl_realloc_bufs() swapping/shrinking sl->rbuff and sl->buffsize.

I'm less convinced that the above are in-scope for this patch.

-- 
pw-bot: changes-requested
