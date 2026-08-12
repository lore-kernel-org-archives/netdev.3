Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC84486341
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 16:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786552068; cv=none; b=OZG1ClEtIdm/sTRSHpmLUjjCA6L9pgkT0wGMHsbBvaxIZ2gzLx639UkcdoAgrx8nMJ4pqkTg7HSCpC1rBYNDGeiLGWjJSmJchLeMBL+mr7Invu5h3eT22wG3G0juSDYf5zKKiXCU512PfmJ2QytSDYAyuZ0fRXvQ7i9zJ/8um88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786552068; c=relaxed/simple;
	bh=eWiym/QKom/222F98edwFNxFNxTbkd9+F3LCGViqdX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dD7xwEYNCyYKES01rtnUeWW4ag7DE9Q9R18R7Hn2wOR4fxz4cZA8G02d5UnL4H6qP5E3zXJDgRufRG+6c6QHxApOxiRupnE5I/ijG8xT2pJsvvbPgPXoKBpQsAmpEgpPYvV4YlpRx1pK+2RGfUuglPMfKAgo7/Xqt1z5gCQTavg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=yjADucU2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="yjADucU2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=uPkT5EYz5TsD9jTs8oCw49jzUb4HVVG0il0CcKmah9w=; b=yjADucU2c6BiM0zVPcBEY8LBZu
	4vxWzKzCf2lQCd8qKlzw+ectudNvcmtZw02Bb2bg/CAUfEuk7AejbglX/iDScx6ifbGkAtDXRI0pL
	w9m/tEk1WQTt40wwiCzv5weRljCk4YJmNEbxnJszWATnUdVEXT6wX1LV/RO/+tZv+CJA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wuBnq-00HIpm-JS; Wed, 12 Aug 2026 18:27:42 +0200
Date: Wed, 12 Aug 2026 18:27:42 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	vadim.fedorenko@linux.dev
Subject: Re: [PATCH net-next] ethtool: tsconfig: reject zero-valued tx_type
 and rx_filter bitsets
Message-ID: <a44d3a88-a322-4640-b920-8b78200d22e7@lunn.ch>
References: <20260812162230.1837788-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812162230.1837788-1-kuba@kernel.org>

On Wed, Aug 12, 2026 at 09:22:30AM -0700, Jakub Kicinski wrote:
> The ffs()/fls() guard in ethnl_set_tsconfig() was meant to enforce
> that the user selects exactly one tx_type (and one rx_filter)
> at a time (off / none are explicit types with non-zero values).
> However, both ffs(0) and fls(0) return 0, so the guard passes
> a zero-valued bitset through.
> 
> The subsequent ffs(req_tx_type) - 1 would produce -1, if user selected
> no bit. net_hwtstamp_validate() catches the invalid -1 downstream,
> but returns a generic error (-ERANGE) without telling the user
> what went wrong. Return -EINVAL + extack instead.
> 
> Replace the ffs()/fls() comparison with a hweight32() == 1 check.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
