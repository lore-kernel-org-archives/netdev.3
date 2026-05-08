Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CBA3A1A54
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 12:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778242049; cv=none; b=QZR2Xug27xdtMxiF+dQyqJ32U3azMJbOqW+QNBBbdmjzb3mDlTQsFPQvebtJ6T15Ft/Oppo22Rtccimrtd6cP4WNh9eRSPw5tkoPsdXH1iHGF3lzn524ADWLQhZ/8DRLa4XJCaywCQJ616LQoUU22fg4z0u72hZ91GKp2wf2zeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778242049; c=relaxed/simple;
	bh=QbDTVF2ImXMDl2jgCVZV89KZ7SBcRmn9NE8pN7GIF7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gi2bg7+e7J7Bltw63QD2huUcmsFBind3OkQ/y5eVstMk+dKUZHkFFHTs5teM1/YoNFlefvxsL3qw8HjsU2n/LqgJ39eRW2V7Jz6MpasD6SBZFaiF6pCEmcy85AAoNaaxUD7apyD/CTbpfmCfn14+zemCwRvN224etRFa9KOnAm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=iyPcTCBv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="iyPcTCBv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8zKC6bgCNQ22N5CFjyOJGIo+pSm6Ry0GOh6h1WUxHF4=; b=iyPcTCBvpkw+uSGyG3dNh174BJ
	pocFtQ3A/q4eOQSeqRmqCxg78qnY3uh55h70tU9Cy4MrIlS/x9FiI1EHVFj77Qm0fG5PjSqcrB3iJ
	gOez8KbmRnpskikzAHEECCi7hDVDZ6cFCJGfWMTS42Qr1kQ9klspJKjiQjnE0kqztq+I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wLJyy-001xgE-6u; Fri, 08 May 2026 14:07:04 +0200
Date: Fri, 8 May 2026 14:07:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Tao Cui <cuitao@kylinos.cn>
Cc: leitao@debian.org, vadim.fedorenko@linux.dev, davem@davemloft.net,
	edumazet@google.com, horms@kernel.org, kuba@kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net v2] net: ethtool: fix missing closing paren in
 rings_reply_size()
Message-ID: <1c5f2275-17f0-4a80-97db-61af3129e6b4@lunn.ch>
References: <af2tj9AkacSUfsp9@gmail.com>
 <20260508100435.186819-1-cuitao@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508100435.186819-1-cuitao@kylinos.cn>

On Fri, May 08, 2026 at 06:04:35PM +0800, Tao Cui wrote:
> sizeof(u32) on the _RINGS_CQE_SIZE line is missing its closing
> parenthesis, causing nla_total_size() to absorb the subsequent
> _TX_PUSH and _RX_PUSH entries. The resulting size estimate
> happens to be numerically identical due to NLA alignment, but
> the nesting is wrong and misleading.
> 
> Fixes: 4dc84c06a343 ("net: ethtool: extend ringparam set/get APIs for tx_push")
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> Reviewed-by: Breno Leitao <leitao@debian.org>
> ---
> v2:
> - Added Fixes: tag as suggested by Breno Leitao.
> - Added Reviewed-by tags from Vadim Fedorenko and Breno Leitao.

Please always start a new thread for a new version of a
patch. Otherwise the CI/CD system just thinks it is a comment to an
existing patch.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

	Andrew
