Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D801433E74;
	Thu,  2 Jul 2026 20:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783024992; cv=none; b=k7C118m1TequN+N30F5dh4MeBJTCqROoM4PLuw0FiI7vmBszN5eG7ZYvFA5+dqERpMs75rl3uS4ewVW+htnw96Y1Ykx2CDqR5s8m6n4wyk48uVtMR8EF8tG7816xmqHOP0nJvJBfLUVTggf9e9ywSrs74aBs+3iki9w2uh0dCPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783024992; c=relaxed/simple;
	bh=2z9E1TaermI6oB6YCmVVw6+0GKLKmoenV71vgTpEZPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h0UzkbYQIcpWOjUiwBGh6YpwMM1Ba1CTTUlqDxTGp0QHcT9PxU1hJXmtWmeN0+7QfO+yxfnCckRCsExpCkUVa/ck5CALurBlRpoNQK0lgM6DTaLhDG5WB5SPUC0aVs39t4Cb3lzLS6NkHWHTj3C3ZzBJphnrlGRQA7lK9yIe7dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KIn0SrjD; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KIn0SrjD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0XnzerovzKYsbDQGBTbWNWVrTwreF16VtzdO22UwIsE=; b=KIn0SrjDx9KCuzPPsEBmJiGrzy
	QZp6u/nKSNBTK3WhDzpm3MIsg48inh3lIL8JnMfTp5Q6qoBAdYHR2JDdY6kwtPbFwrPHpt5onCT/U
	0utU269xOOYV+QTHoE4n/oeOpFEjhw5xh2QOyWKjnDZquWiwxN+a/sMLJh2yOx7ZbHG4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wfOFV-00AR77-1n; Thu, 02 Jul 2026 22:43:05 +0200
Date: Thu, 2 Jul 2026 22:43:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2 net-next] net: dsa: qca8k: fall back to ethernet-ports
 node name for LEDs
Message-ID: <c34ea180-dd91-4ed7-a3fc-49dd66381a40@lunn.ch>
References: <20260630015137.1591152-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630015137.1591152-1-rosenp@gmail.com>

On Mon, Jun 29, 2026 at 06:51:37PM -0700, Rosen Penev wrote:
> The device tree binding allows both "ports" and "ethernet-ports" as
> the container node name.  Try "ethernet-ports" when "ports" is absent
> so that newer DTBs with the preferred name work.
> 
> This matches the handling already present in qca8k-8xxx.c
> 
> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
