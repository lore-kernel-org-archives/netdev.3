Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE33B23D7C2;
	Wed,  2 Sep 2026 00:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788308419; cv=none; b=bWUzItgj+EvLBNDd7bv7t62mgYgXakjuU9CVcANqOiNxqy9yt08hkkrI9+/ryMNTXMj0bg3IdL0hP18uLjxEkX8TWCCeioEPFthqDH5Rqm1tiLtAsoGWBuYMy5ocUWVLkfjqqSN2QKWKPRt4iVOErZNBNS8OvAcogFZQW7m24TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788308419; c=relaxed/simple;
	bh=3L8y/oVTEi3V1VcOB35Q9yLjb226MynSQD0cFQqtkdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oUS1yoZK/RGZBLCK40+qUEpm7wpj/u1eaU51uFwMetyt+sj7YfJPgjOSOvErUdnuGhcDmRk966iMOJ3q89GYbaQar9Qwkkz0DD0JZAKNo2J5PAsGRxdMr/+gAkISNhtM+QktF4g9rAV5yI+4p1MuTXCMOOCr7d0E8IwPFEf3OaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2mQrjeM2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2mQrjeM2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=uDADk6U2GdukEw99rZhRDaR0m2q36XsHGsDAmbDAqtA=; b=2mQrjeM24eb7pd84QIk+CpakS3
	GknZUUgxNpDicWa4JG0e4x+eyRwqKwm5mz1jTQM6Wt9tOkONqdFDvUspYXxytLeXM7dSQbfM4jEF2
	fS6IBLYOq9c6hQ5jB3/d9OomcCNKFxR5Ev5JXx0MDrY0c+HZMxD7RIWxxs8P4gYami74=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x1Yi5-002Rg7-3I; Wed, 02 Sep 2026 02:20:13 +0200
Date: Wed, 2 Sep 2026 02:20:13 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Miguel Garcia <miguelgarciaroman8@gmail.com>
Cc: netdev@vger.kernel.org, jacob.e.keller@intel.com,
	syzbot+372a7d84708b07f64d9b@syzkaller.appspotmail.com,
	linux-kernel@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org
Subject: Re: [PATCH net v3] devlink: use direct firmware requests for flash
 updates
Message-ID: <46ae913f-39e8-4041-b15a-8e7363cd2fd4@lunn.ch>
References: <20260830111700.1799255-1-miguelgarciaroman8@gmail.com>
 <20260901123819.2035064-1-miguelgarciaroman8@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901123819.2035064-1-miguelgarciaroman8@gmail.com>

On Tue, Sep 01, 2026 at 02:38:19PM +0200, Miguel Garcia wrote:
> request_firmware() may enter the sysfs fallback and call
> try_to_freeze(). Devlink invokes it while holding the instance lock,
> causing syzbot to report:

Please always start a new thread for a new patch. The CI system does
not always pick up the new version and test it otherwise.


    Andrew

---
pw-bot: cr
