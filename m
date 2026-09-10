Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CE63E5585;
	Thu, 10 Sep 2026 09:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789032718; cv=none; b=owixN3HiGxSL4p4nU23FNvhzZ0cKqIwWQ0oyWpWS6XvRvBFkNQG91JFTHNxIXEnokAd6qI2ownUuY6eW1+HMqtJ2GqSs/lbRBeQErjHh903XFaPU42dYNaUfQdMY5Q2AB8jG7/65xmgvCDxm/7fdlem/ifs1FVh+jMVtDWJe530=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789032718; c=relaxed/simple;
	bh=YcOwuNm+jiJRIHyb9IPNwT3CxsI/lcSCV40qGKvSocc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RlVlMaNh9UnFQ//G30NwEZLK7PkkO771YoMqkH5QlfNDeszoKRhk2143XvCQHIhZD4raSRClrD+AM/IQlad0vvDisGN12VSvQhlRucN4p+aUBFn2938qcTp31rxxSiWI2PmzftiZiCOlFueybNmQk/oTD/6+mixEDDke/T1r/4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERwGEOxH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERwGEOxH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DDBD1F00898;
	Thu, 10 Sep 2026 09:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789032716;
	bh=PZxkW5GeT9xy9ss0aS1FMlsgqN+mLBhYVrrO86lDB4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ERwGEOxHWiQGog/UdC/VYZzMN6BoUvUitPcnl+yPgoF5Glx2rodYkMW5cTiu3fkYw
	 vO6Ge1WwpskL+y+6CstiE1tS45B7Ito2Jo6ITsYQ9t79pBJBluz+VGr6EJWyx7dgRR
	 Mdf/aiw2UFXtuO9LfnrRKSXhBCwOhzg2O+yTlhDxVlJQK0k7fA7WOM01RvKoXr1q34
	 PcH0Gjuzy5Z40u7attUQni/H6e0QL3wPHncFcYpqwQQS6t6TFj0q4hXg/X7HHCfrKj
	 +Hj/TP+9urLqSzEJ1ci8XY7lyKLYZfw28Jttl99Tb6U3EALPy1B0kERtWa7czFsCUF
	 jI3zfdrCIaVQQ==
Date: Thu, 10 Sep 2026 10:31:51 +0100
From: Simon Horman <horms@kernel.org>
To: Li Youhong <dayou5941@163.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	wens@kernel.org, jernej.skrabec@gmail.com, samuel@sholland.org,
	linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Li Youhong <liyouhong@kylinos.cn>
Subject: Re: [PATCH] net: sun4i-emac: fix missing of_node_put() for phy_node
Message-ID: <20260910093151.GO40544@horms.kernel.org>
References: <20260904080758.2432748-1-dayou5941@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904080758.2432748-1-dayou5941@163.com>

On Fri, Sep 04, 2026 at 04:07:58PM +0800, Li Youhong wrote:
> From: Li Youhong <liyouhong@kylinos.cn>
> 
> of_parse_phandle() returns a node pointer with an elevated refcount.
> Add the missing of_node_put() on the probe error path after
> register_netdev() fails and in emac_remove().
> 
> Fixes: 492205050d77 ("net: Add EMAC ethernet driver found on Allwinner A10 SoC's")
> Signed-off-by: Li Youhong <liyouhong@kylinos.cn>

Reviewed-by: Simon Horman <horms@kernel.org>

