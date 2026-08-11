Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAAE401A16;
	Tue, 11 Aug 2026 21:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786483705; cv=none; b=D4rupU8ohDoF+fZyGOLrZ78NikkX8GAO/FprqfBG9cAeiBFmpxW3/cywMHC+MQKRg1n9WJDlIlXCP6pDHJ4juZxNRVHuJH5gg009jwqGu4CsTCXSR9gY36oF3Fl0zQAYejNIZkBitHxDn3De/tmR/eldno4LRmXO5TXeM6aVhC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786483705; c=relaxed/simple;
	bh=esbc202jWGrefT9VepBHVOm+YFOKCqc62WTJZlyV0y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UWb9E2VTl+V0hL5wZvlVVdakfs2NBjhykO205sjk+0KDxeN3srTzQF9sKMdShHPMC89oJn5UoDpntawP+KFDizuCSI85gkZfUGxABH2xU5aZIvfGRQpEjZx/C6vZ41JwdqaXpkzq3lf/sl8l9KL2NctAHFZNJ3BG6m6m/BrBo8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=yTj+1O1v; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="yTj+1O1v"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5l6cjSY0jq+fSvOspRrG9pyRBk8UGINLxVjf3K8kRXQ=; b=yTj+1O1voCctq26qaY1MeDsMcX
	2vlYzHRMycA6jvztuF834Qp0YVsiGEXlfrDubCrfRyObMquEPeptezsje5UaHBePmpNSJmd8mj64J
	vg5ymWRx+qJ8sNOVpYCd7STQH2Nx60IB9pyru6/G4C2F801wmVJZQmqRFhKEYRuty8Pg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wtu13-00H9M4-K6; Tue, 11 Aug 2026 23:28:09 +0200
Date: Tue, 11 Aug 2026 23:28:09 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Hongyan Xu <getshell@seu.edu.cn>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn
Subject: Re: [PATCH net-next v3 RESEND] net: phy: nxp-tja11xx: cancel
 registration work on remove
Message-ID: <312f0dbf-5004-47f8-917b-9cf9d21df38f@lunn.ch>
References: <20260729155322.319-1-getshell@seu.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729155322.319-1-getshell@seu.edu.cn>

On Wed, Jul 29, 2026 at 11:53:22PM +0800, Hongyan Xu wrote:
> tja1102_p0_probe() schedules work to register the second port. That work
> uses the Port 0 private data and phydev. The private data is
> devm-allocated, but the driver does not wait for the pending work on
> remove.
> 
> Store the Port 0 private data in phydev->priv and add a remove callback.
> The callback cancels the registration work before devres teardown frees
> the state.
> 
> This issue was found by a static analysis tool.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
