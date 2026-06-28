Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FC13B52EF;
	Sun, 28 Jun 2026 20:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782677709; cv=none; b=K0/sefeIB2ZU3pCAtLgjo7PMmdiaCdBfk6YungC3Gd3IgJOmUJ6At6s/K3xWGNs88X0pqHypFvjuSWOZ0ayCa3VgwUjNqEQHOMjfcMa4q6tAR0CHS0OAG+9J4HmQXgiziCkwtBWVufyCtUw+rMGpZT+T7rrMIKsYGaTKdY7a0XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782677709; c=relaxed/simple;
	bh=cJfm057tqHIFt78HMXnD6ULZrlwea0zk279xkwsY4uY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bzn3u23KF+eVAuXXSXuvKqNH7wwszFyZDX1nKoYihcvxuH4sskNbzegPZATLg+41A6I0yx6VZcJ7t5Njn3H+h9eb6ZntPcxfE4g7571A3gND85ucS9AA6K94LBhnAB2rpwslK7T6bM9FGGZVm25SAWhTgK46LFbiS+tS4L1ZScA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1zmYmYSS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1zmYmYSS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=93cNbwIyQUD3lbjk14PcWay9gegKO41oR3z08L7WD0k=; b=1zmYmYSSOqHAfgSCe8dYeoG/Hm
	HcRjQuAW6gwQCDiy8BvL2AZmof1+sJ9G5S01ICsPOxRANpjS0WMln6h/7/x1EecPS9Vd0mXNjbdqx
	tDgeMG7V65wqMtnr+R+5VHHTuSJAjwy2I/QPi0MpHN/TJ2W7l3dAi9jo+ZDpXtkrHw1E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wdvu1-009dyq-Pf; Sun, 28 Jun 2026 22:14:53 +0200
Date: Sun, 28 Jun 2026 22:14:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Lucas Poupeau <lucasp.linux@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, kuniyu@google.com,
	sdf@fomichev.me, brauner@kernel.org, krikku@gmail.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: sysfs: cleanup coding style
Message-ID: <83dfe4d4-167e-4073-ba05-6ffa299177ee@lunn.ch>
References: <20260628185824.231250-1-lucasp.linux@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260628185824.231250-1-lucasp.linux@gmail.com>

On Sun, Jun 28, 2026 at 08:58:24PM +0200, Lucas Poupeau wrote:
> Replace DEVICE_ATTR() with DEVICE_ATTR_RW() where applicable to
> follow kernel coding style conventions. Add blank lines between
> function definitions and macro invocations. Fold multi-line
> attribute initializations onto single lines where it improves
> readability without exceeding the line length limit.

When you have a list like this, it means you should have a patch
series, one patch per item on the list.

Please also take a read of

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

    Andrew

---
pw-bot: cr
