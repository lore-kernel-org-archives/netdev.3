Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD82B2459DD;
	Mon,  9 Feb 2026 13:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770642653; cv=none; b=IFl2yxtfEyz4X2CETPdCnBzDY7zRDKkW5MzZ9DxMzwT7JlS0UYlPT0uPazxfETPee751an/OjBQF8/mp1++5EowHMHUj9MLgiaDK+yDdnlpR7it7wrVMYpGEtWbeH6vKgsT5VMQoIae1lMr0nfXCleSR0tpIeJtSx5wAKPRsbuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770642653; c=relaxed/simple;
	bh=kRBS3UxBzm6Gi5y7bzUG/UAZWpOiOJC7NrKiSC8t1kY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZmrZ1b8wwUPc6rpo7XCGV9l6m5MWzPAC2PJo4sD6KZObNXuxkr7Q90vGqMcB4Uys1Gtsi6eu7RwS+DLU7rehSObOp47B6gNN9cFhT0dHONI1I0u/gQlJt0BqK833ZG+ke6hVzQmTNnHVEtnm93Y7Ll845PnP2gT+ZLGYo4moL4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KAZbc7yS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KAZbc7yS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Hrdx+eRTgukOx5Ue/ufBHc7Q/GYZQTIBwxbGp3spE6g=; b=KAZbc7ySROFs2WY8SZgRjGF7a7
	Pv5wbGIapXWYQ1xz7ZsK20akuvYwlBpekP5/uuSgxbdxA7GPWL+qWSPYh3YzS8U27JkijdGIjs0z9
	cqHoyH0y30hwZVVmDINm9BKsgptU5wPibtZ8uzdcswcsxSrRnrKa58sUMe6k4G2AlNpA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vpR2E-006ira-2l; Mon, 09 Feb 2026 14:10:38 +0100
Date: Mon, 9 Feb 2026 14:10:38 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [bug report] net: ethtool: Introduce per-PHY DUMP operations
Message-ID: <8cd942c4-986b-4c20-bc12-f8fc17f626c3@lunn.ch>
References: <aYXu0esD_wSjGTZm@stanley.mountain>
 <c9c6378a-14a3-440a-80b7-f48cdb06623b@bootlin.com>
 <aYmID1BOGmwb2rUD@stanley.mountain>
 <e5f1688f-cb13-4d43-bf20-644cda6ab494@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5f1688f-cb13-4d43-bf20-644cda6ab494@bootlin.com>

> > ETHTOOL_MSG_USER_NONE, 
> > ETHTOOL_MSG_FEATURES_SET,
> > ETHTOOL_MSG_CABLE_TEST_ACT,
> > ETHTOOL_MSG_CABLE_TEST_TDR_ACT,
> > ETHTOOL_MSG_TUNNEL_INFO_GET,
> > ETHTOOL_MSG_MODULE_FW_FLASH_ACT,
> > ETHTOOL_MSG_RSS_CREATE_ACT,
> > ETHTOOL_MSG_RSS_DELETE_ACT,
> 
> While these commands don't have ethnl_request_ops handlers, they still
> have a genetlink handler, see the ethtool_genl_ops array [1]

At least for the *_ACT commands, they are not expected in the
userspace->kernel space direction. They should only be sent by the
kernel to user space, to indicate some action has been performed, or
happened. I don't know the netlink code too well, but i assume there
is something which will throw out such commands if sent to the kernel,
without even looking at the parameters?

	Andrew
