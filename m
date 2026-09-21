Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DA747C0E2;
	Mon, 21 Sep 2026 16:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790007817; cv=none; b=R81Zm4OPcwauXh17ocI1IupjMzbn8YLsnhcW9CNfMTJwE/FoKn/t84HvGDO/pKJ3VMtm2ZsBJFwtL4wsTU5/N32vwSLz8NO7FT7JtIid0rawVyCNq2XSPA+ZyrvTH6YtDNnQVcTR07JxjSlRiGGHdGp7DP6OroOo+YhKm3UYyFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790007817; c=relaxed/simple;
	bh=2ivhCcmur4IgDuPDQMA/C+gJoN2Z4KV9B489tgEVTcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sX1gkS0TsSWQsigLJiuFZ6gHQJGBeRVXbSx3WCF1hgrsWD0Gq9NXrSuFsWps4QyEwd35aUwarHpv4AXaNxCDjSm9Cn/upj780wEZIda6OzZL54I1P4Fuo2kSNU2744WMKx58Ko6wir14JCpc0PiTrKffEkBPXz08e73V6XnXbRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=io1ieZp+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="io1ieZp+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C4221F000FF;
	Mon, 21 Sep 2026 16:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790007812;
	bh=3cyhZCtU1wrXzMa699AjFSIZqoX5HSYgq+ryd2wlPeg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=io1ieZp+me+gj4vc5hLBsV3pJ72ya0RvN9LAcqSOQj9R7QTrD9E71C/MqSsxP2Q28
	 Qr3LiOCdDY7sDOkbSLQ9LdNhZSFX74Bh7yL7deI2QpIBC4NdOKJ/HU7LkQJy8JjDuB
	 +ek399dMJXVNyGWHa+5mRXmRIAr5H6RnlBFK8BUF+pg/0IsR3yA9O+9IF+fZr0XjU3
	 uptBy50Ts51XATYAMN845XwoChEKETD8MiquFdslMAQIMCWMZpE5pHXPIj9dbSN8UI
	 X1JZX4m8wgPBziNC1KrgLzeCnTE9KB3eoQAPfWFpH6wN6+erw1snVJ2g9G1xYJSSdd
	 ZquHz9hJnjq8w==
Date: Mon, 21 Sep 2026 17:23:28 +0100
From: Simon Horman <horms@kernel.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
	linux-afs@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH] rxrpc: use assign_bit() where applicable
Message-ID: <20260921162328.GX13925@horms.kernel.org>
References: <20260920022753.3145871-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260920022753.3145871-1-peng.fan@oss.nxp.com>

On Sun, Sep 20, 2026 at 10:27:52AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Convert open-coded if/else with set_bit/clear_bit the assign_bit API.
> 
> Done with Coccinelle semantic patch:
>     // set_bit -> clear_bit => assign_bit
> 
>     @@
>     expression cond, bit, addr;
>     @@
> 
>     -if (cond)
>     -        set_bit(bit, addr);
>     -else
>     -        clear_bit(bit, addr);
>     +assign_bit(bit, addr, cond);
> 
>     @@
>     expression cond, bit, addr;
>     @@
> 
>     -if (cond)
>     -        clear_bit(bit, addr);
>     -else
>     -        set_bit(bit, addr);
>     +assign_bit(bit, addr, !cond);
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Simon Horman <horms@kernel.org>

