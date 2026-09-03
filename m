Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C269345740;
	Thu,  3 Sep 2026 22:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788473237; cv=none; b=u6bWt5zgpA+1fFuRE3G/z+9KWKIuEVCvlZkqiUJZCEcW6vurNxEy2dsZ28Qk1XwTuQW3QnUOiCsCjMcCUyRY6qK+UGnz//0/dgollHQIapy092oE0hqMcqhO6MvCEA1fkneFL1DwECdvjU+s9SCGf5r5S2Y1OjdzrKaVNawYpyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788473237; c=relaxed/simple;
	bh=DmLKfdQ80iHN05D9JX6y3kx+duT+i0FL+6svEIDdpLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/qCkbLCSbdoFndTRie9LWcsvqNmzGeTaX3L9XZOP/jYn9nIVa3XPL39aGob/1kJ25PtijT4EtodITTm3Mau4LgtWM2ur2ngJGeOTG+2QFVqW0yFl1oO597Q/s6+AQGJg++skSQBbSKvcANlPLCaSuODePhe7nDhVU8hDfLMq2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=aE4zSQpP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="aE4zSQpP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jmPdKwA5oBox13nOVPuYeBNSXW5SZTTwhPMA0q7U9Zw=; b=aE4zSQpP7srwC+sX23tPsnerwc
	hcQmjb9SQ9NYgiecdLxz9fKLTynt3+M94BU8XsbIUKRd5wFYwugiC4dZ8MgYFMtegJAm/yQ8dJnHE
	Qevt9Akx2rNhInCkeLTp7TIuiVtD+DCstnpBzcc1v6s9UBoJa5Dauv5TMSkMcrPs3aT8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x2FaI-002oOC-AQ; Fri, 04 Sep 2026 00:07:02 +0200
Date: Fri, 4 Sep 2026 00:07:02 +0200
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
Subject: Re: [PATCHv2 net] net: ll_temac: Return actual error from
 of_get_mac_address()
Message-ID: <d2ef669f-12f0-4fc7-9fbc-1142f9d62761@lunn.ch>
References: <20260902210238.283494-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902210238.283494-1-rosenp@gmail.com>

On Wed, Sep 02, 2026 at 02:02:38PM -0700, Rosen Penev wrote:
> When of_get_mac_address() fails, return the actual error code (rc)
> instead of the hardcoded -ENODEV. This preserves the original error
> information, which may be more specific (e.g., -EINVAL, -EPROBE_DEFER)
> and helps callers handle the failure appropriately.
> 
> Use dev_err_probe() to avoid printing an extra error message in case of
> -EPROBE_DEFER.
> 
> Fixes: 8425c41d1ef7 ("net: ll_temac: Extend support to non-device-tree platforms")
> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Does this bother anybody? Have you seen the extra error message?

Maybe net-next would be a better target.

      Andrew
