Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00CD3D9525;
	Mon, 31 Aug 2026 23:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788219007; cv=none; b=U/9KfeLRJPiRiKwOFXACImR9WBmUBgCmkD5qnUOhMKlZe2NTx6L47LK/OPRfAMe2rw60ZBYrZmcxYmc13pWfEHyjXN5JQ1Xyj+hrg6e6baoVXFgFjNk2bSBwswrAOepZqy9m3maxtfSb0TD6Ut5N05RQBFb0dFz4Y9AXglc02Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788219007; c=relaxed/simple;
	bh=jxxCvrSLQQr05q4oRclLSpfnOYatmqTW/N9Pz8x1ngE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uBqk1gKWAYnmVkPWzeawpDF1ZQ0P20Uf8e9FLCgtnne8N1PCIz9wCNVOTG47w4UT19sYz5J740dNH+cWjX464Rqo4C0xI6g/IA1w2QN3Uv10hN+LD4qUCY5icaJTpXQYCp32jsE0tLsftdSC5VU9DIezGKh8eju4YgErR/vOzK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=pBvJ34xk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pBvJ34xk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=C93C3lQf4DBk5lTWftWVU5xs8UQLhprIYIJMjarUuBY=; b=pBvJ34xkLQg7DAds2Apbm4ZmBX
	Rjs71jj/s/zJD+drhZOqT3WeBxm67ixMhyUNhs3ADdMA001gtDGUG165I8dZATtVyrKNYvykCvDWB
	i56p+dHIAE1HX6tQV7OHGQCUOp4r65knWtHxMm0WC33zoGCquBjPUubwuKnsRxgF4BAM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x1BRu-002GqA-45; Tue, 01 Sep 2026 01:29:58 +0200
Date: Tue, 1 Sep 2026 01:29:58 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v11 1/5] net: dsa: yt921x: Check lock status
 with lockdep_assert_held_once()
Message-ID: <3493dbee-ee11-4a1d-9eaf-3919a97a6197@lunn.ch>
References: <20260831044818.4103477-1-mmyangfl@gmail.com>
 <20260831044818.4103477-2-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831044818.4103477-2-mmyangfl@gmail.com>

On Mon, Aug 31, 2026 at 12:38:54PM +0800, David Yang wrote:
> mutex_is_locked() was used to check the lock status. While it should not
> be triggered unless a bug is introduced, it does not warn on lock being
> held by another thread. Fix it with lockdep helpers.
> 
> Fixes: 186623f4aa72 ("net: dsa: yt921x: Add support for Motorcomm YT921x")
> Signed-off-by: David Yang <mmyangfl@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
