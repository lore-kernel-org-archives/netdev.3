Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCAF3F8257;
	Mon, 14 Sep 2026 08:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789374659; cv=none; b=JsnhKfsKifP+ez5S3ER7PuVf9MbTn7zLDFxf3u4z1/5Vo1GVgqnXjAhbB5Eu7abMwDAHmx8m8EVvg9niTT1xAx2gshHwmKsD7XszTmHwncF5JjA8Ep2LBXegbjOZlZXkHK/lcDNIY9EWov9sieM00Ee++DmVo4b+tzmaLZd2lOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789374659; c=relaxed/simple;
	bh=jPWIkYLvL3CPASC+m6PbmIW37aCIkbWkYoBLvhavZ3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VbtuCvRRwHJ1sMQzJo6xqvuwrjeflmTbZgDt2FF6DvNFUR5kul6xIODt9n+LL6BfoXentK9eDSkBaNXEGfgdNbnMUjv0EJdB6VaLQ++cvaIOwj64nSPdL+ZA2B7du174SWj3IXV8yaCTvz3GiXktqQ93Z3lSaqzMTET2Vj+RqQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W8r+8lXZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W8r+8lXZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06F6B1F000FF;
	Mon, 14 Sep 2026 08:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789374658;
	bh=6ibHar/AX28bkkoClufcFVZ+t/sQVv+pp5sGp/+SErU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=W8r+8lXZZ3xW2+zjal8D15frgt1TGkG41Fbtl3qTID46a1iLFLhqKDkmNVWBsfUiw
	 sonR5wJYEuRP0w3yqxMC8rXRegkBNZtfGtOye+wiDq4WOnjwt+7Tkk1YF1k9CUtDTa
	 QXQocPQu9fM21N9hQoL7AhImwPR1W1dqoB8WmOt5IYAAGe7d4C9IIsL4gQdHAX2S6X
	 3ICn2kHqKC/Mm4BTxv4bCsL3zSsdW2+3danOj6WcpiijviXhSTij9Yr5oGfN3afJ2O
	 9Dg/d4om250OTEuG83m2s+5YYs+5OXQORqpaxXhToGrVy2tNjOjNyCP61T6MjTO6uT
	 iy4uwSzOxyjsQ==
Date: Mon, 14 Sep 2026 09:30:53 +0100
From: Simon Horman <horms@kernel.org>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux@armlinux.org.uk, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, ae878000@gmail.com
Subject: Re: [PATCH net] net: txgbe: free the fixed-rate clock on cleanup
Message-ID: <20260914083053.GM48209@horms.kernel.org>
References: <20260911155318.88857-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911155318.88857-1-mhun512@gmail.com>

On Fri, Sep 11, 2026 at 11:53:18AM -0400, Myeonghun Pak wrote:
> The fixed-rate clock is registered with clk_register_fixed_rate(), but
> its error and removal paths use clk_unregister(). That unregisters the
> clock without freeing the fixed-rate provider allocation.
> 
> Use clk_unregister_fixed_rate() on lookup creation failure, later PHY
> initialization failure and removal to release the provider allocation as
> well. Keep the existing clock registration and lookup cleanup ordering.
> 
> This issue was identified during our ongoing static-analysis research while
> reviewing kernel code.
> 
> Fixes: b63f20485e43 ("net: txgbe: Register fixed rate clock")
> Assisted-by: OpenAI:GPT-5.6
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>

