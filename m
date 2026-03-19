Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5582BEC57;
	Thu, 19 Mar 2026 17:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773940367; cv=none; b=otg8vx4o9EG7V87Emcx7BfKI8GlZ2uYSTEmj68YsLw49+1kCukDGzb1OFl5Tu7dK2RnuvjMP9PdmHiBWI7hS96k/TR5b5HIq3ikC2QNc9z5tugDdAKknKrflnLwKUfeh6XcQMcHKHZ9EZtV87T6uyPXTO6jKFFhdKEDRYDHEYdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773940367; c=relaxed/simple;
	bh=te5NL4bTBTMx9UuqKV9IgTjSqHM5mjjF2s+85P5tezU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iRn2rZIMmA4rv/owHryMfuYIoFkfeaG9tWkQCC+3oCU/lt7o7s1huAqw6TiHXt6+AB1aQU3PXx0u8g1zAnViXhYNVpus6+Owbm+s4UOcBjdDe+gwxabkT92mH+o37AL93gHL+xA51Yc6RLOlwu97C8oLtBlqAj2RO1cFUk0QHVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=P9ohocIZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="P9ohocIZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=PWgDPxKGzXwvztG+k1eLj41i9UnHTszaaItUXcqxK/w=; b=P9ohocIZy+UtMRodamDlRTFu3B
	BxaBCz9DE6Iw93ihprajIZt7m3+mTnZx3TsHiV6YlCXOYq3F8MI4kFNMttGQ/O9r10nrzGU6Xd17T
	2sCy7Yv0nxoTnWY8dMYu+JasIySq1XZylhX0GQHH0AFfA+FJD6XVc6WHpetSEB2P6kBc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w3GvK-00CQEm-PU; Thu, 19 Mar 2026 18:12:42 +0100
Date: Thu, 19 Mar 2026 18:12:42 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Qingfang Deng <dqfext@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Breno Leitao <leitao@debian.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH net-next] net: add netdev_from_priv() helper
Message-ID: <88ba2f94-0b50-4c1a-8670-e0eb4c421fd4@lunn.ch>
References: <20260319022608.323969-1-dqfext@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319022608.323969-1-dqfext@gmail.com>

On Thu, Mar 19, 2026 at 10:26:08AM +0800, Qingfang Deng wrote:
> Add a helper to get netdev from private data pointer, so drivers won't
> have to store redundant netdev in priv.

You always need to include a user when adding a new API.

    Andrew

---
pw-bot: cr
