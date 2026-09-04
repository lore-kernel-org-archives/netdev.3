Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FF033D6F0;
	Fri,  4 Sep 2026 13:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788529705; cv=none; b=W6/OPMRtCtRnX3wfZhcQc/uA+ekk8Mxf17SZcQJd/P1jzcqUPQoMHYrfHZcTMC3ig/IjKYaS8CYsQYvMHLazXGPtbUCln3ZteDB7gxZhffUYUvacS6DqC7gf6alMXUnAdUK/5J4cHsujl7Ax29dcHRyI1g+hGO3THfZZaHAfUkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788529705; c=relaxed/simple;
	bh=osKVx/6dMiMJ6D3FU7IMm+eCkcghzvJVsxDtVc9UTDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F20VCE6oUymrNmTkgwVRqdPvM8amqCRAQoNuliyKYvffSuF5U/2BhIb49Gans+IkebFD06+ApEDYpk+NG0AeM0DoleFagkTvJwdbBtKeCFfbCJbpca3Z0ryfpPccpZeXWLMy7h8ersCZlnV8lvKig7itz4PUwQ/C7xgLw/EJrtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Z4Un9PMk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Z4Un9PMk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=HvNENXl0HfEc1Tm9aQ75WJHBU0Bow+jKalwkB1XfcKA=; b=Z4Un9PMkA9HuRsHAQGu5QfFQn+
	iZRQhFhsJ8wyZfvN+Lgzxu3/lfdwhyH6jB5Foui5OtdUd/KookPfYWqsFi6LVVKTfRKevVpcLP7qe
	3EIj4ViXLMQeUWNbjFq52fVnVv85z84TesFQ4oGcimR3+Xd/H9SLs3IjVU9CutimdimU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x2UH9-002zhZ-Bd; Fri, 04 Sep 2026 15:48:15 +0200
Date: Fri, 4 Sep 2026 15:48:15 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mmyangfl@gmail.com,
	horms@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
	xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com,
	wei.zhang@gl-inet.com, sijia.huang@gl-inet.com
Subject: Re: [PATCH net-next v5 3/6] net: dsa: motorcomm: relocate MIB
 polling initialization to dsa_setup()
Message-ID: <69b0cc5b-0b67-4eec-89e3-b4c788febdbb@lunn.ch>
References: <20260904095416.1692962-1-kyle.switch@motor-comm.com>
 <20260904095416.1692962-3-kyle.switch@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904095416.1692962-3-kyle.switch@motor-comm.com>

On Fri, Sep 04, 2026 at 05:54:13PM +0800, Kyle Switch wrote:
> Move MIB polling start from probe() to dsa_setup()

Actually, having thread the following patches...

For every start, there is generally a stop.

You move start from probe() to dsa_setup().

Should you not move stop from remove() to dsa_teardown()?
You want to keep the driver symmetrical.

	Andrew
