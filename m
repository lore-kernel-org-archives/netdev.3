Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF4129E116;
	Mon, 19 Oct 2026 12:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792411689; cv=none; b=sjxiJhRdooh9zn2YVEJLMn0/gjumW82zRJMgk8dXimjn3mbUT7v8tQfqgW6pf2ahuduT+Jw3k1SpJt+LFFQPkFB3Jff7ncXapTwMfQnfUTnXusNTCqGcZgjakPvOesb6lmjCRZ7BlymNhe33jeRpwUaMJFDJfG9ALO3NAS8C68M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792411689; c=relaxed/simple;
	bh=w/hph4ER0YkrhJQPiR4aU48CqXYO8evQ2VX++Wqlenw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f4FFefioIJ7IMuVHiIgxu0co4QDr72Zchu9supq8Hxz0KZVy6BGvxEJELQuU43J8vHONzfYQM3f8hk7r3HLMwq2DSk7jDm0fNiIItbXPjXd3LxUv1G4JqCqTyX1kS0T+xeWjMUtxiCo8J4ntKuUv3DflGUQ9kRcndE7HJBMpKkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=mzwHE7VT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mzwHE7VT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MQhzuftN3IBNJW2MfPPSv2gfeHMpUPXUNgzYh3G684Q=; b=mzwHE7VTd+ddtNKbg/UUfniP4T
	88fAYX/aZvG6dpQl1K8utJvl6zNsfEmpBXX2zMVS3YpM6w0/o1hWMw4/yAth0mSlgc8zaq9tM+nDg
	Wi0nANbgVbIcLVkikpVRqRdag6B6FXRPx2ltA6WHv4KZxPjipkPYrFtqFWHkCgbppo7k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xIm9e-00BciC-VN; Mon, 19 Oct 2026 14:07:50 +0200
Date: Mon, 19 Oct 2026 14:07:50 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mmyangfl@gmail.com,
	horms@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
	xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com,
	wei.zhang@gl-inet.com, sijia.huang@gl-inet.com
Subject: Re: [PATCH net-next v15 5/5] net: dsa: motorcomm: Add support for
 Motorcomm YT922x
Message-ID: <549c71e6-fc23-4258-8673-24194b1d7687@lunn.ch>
References: <20261019110543.2999419-1-kyle.switch@motor-comm.com>
 <20261019110543.2999419-6-kyle.switch@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019110543.2999419-6-kyle.switch@motor-comm.com>

On Mon, Oct 19, 2026 at 07:05:43PM +0800, Kyle Switch wrote:
> Add support for Motorcomm YT922X, which is series of
> ethernet switches developed by Motorcomm Electronic
> Technology, includes YT9224 and YT9228.
> 
> This patch only adds support for the YT9224 variant.
> YT9228 is not supported yet.
> 
> This patch adds basic support for a working DSA switch,
> includes .port_setup, .setup, .phylink_get_caps,
> .get_tag_protocol.
> 
> Signed-off-by: Kyle Switch <kyle.switch@motor-comm.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
