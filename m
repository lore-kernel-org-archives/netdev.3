Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C62422579E;
	Thu, 27 Aug 2026 01:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787794778; cv=none; b=tek5lDHP/JCQ2TlHyead4T3+yyPEoU8OtQjyGy2A3Cj0VIl2GOmG4KtH4xDosZwnUqb3dleB4q6P/LI4DU7FQxuBzeQysmzavpNRbHZJOQ8vQT/Sle7utw6+CxqX4zRE95T1N+RpKTCIUPAX+EXdpjAt2dzGqS2Iw+tpIs9k+bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787794778; c=relaxed/simple;
	bh=1gIY/lJObKgnbgN4ICHnUK5ZAlyu5Z8aw0GjEmPnKXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mwb3Z0743IeFtUHw1W4qyZfrbludYQcEYHr3EQDSVgNNFtkXQAf+mcgY66m3uqLarvhNTXLknnRtUZ/8chFYt3ljYE1G3ZdH8Zl7J5voW/j94wBTsNFtyCIPBoYIp7IqiKp6aVLU2XRcYtIbm84BGobqlqnWyad0jm/ob3Th6uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Ad6sPjaG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Ad6sPjaG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Ou+uZZvM10YocibGfvW+Y0EZIVXwfNylKTXt7B6QMwo=; b=Ad6sPjaGO7Hg6oF/G5TltzpdSJ
	iX6Li/VJDUhXX2HjPkvLrmJA4U7H7hJ/OaX+VIp+ipdt0CL6IAuU1yB2RMwUfYu4KlRh/qvZF6NUm
	gsxpK8y+uaq37hz+2/D5zz4bzmuE2pwIPQ6neKhBdCHiJcf1TUtpbNNUc5GlYdyFrvj0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wzP5C-001ahP-Gm; Thu, 27 Aug 2026 03:39:10 +0200
Date: Thu, 27 Aug 2026 03:39:10 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Michal Simek <michal.simek@amd.com>,
	Esben Haabendal <esben@geanix.com>,
	"moderated list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: ll_temac: Return actual error from
 of_get_mac_address()
Message-ID: <1f602a6f-fc89-485f-9df5-aa6da3e756a8@lunn.ch>
References: <20260827012439.162651-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827012439.162651-1-rosenp@gmail.com>

On Wed, Aug 26, 2026 at 06:24:39PM -0700, Rosen Penev wrote:
> When of_get_mac_address() fails, return the actual error code (rc)
> instead of the hardcoded -ENODEV. This preserves the original error
> information, which may be more specific (e.g., -EINVAL, -EPROBE_DEFER)
> and helps callers handle the failure appropriately.
> 
> Fixes: 8425c41d1ef7 ("net: ll_temac: Extend support to non-device-tree platforms")
> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
