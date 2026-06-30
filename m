Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B7D320CD1;
	Tue, 30 Jun 2026 22:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782857457; cv=none; b=UUBoFnSuV2MNxF+RIPa4g4BD21pduaNZkJoPSStCWQal+Lo3BYO68Gu93SwtjsHSQfDW3eIf1uDPtBRJDzkkYt5NhhxffCbzr/1ja3Q5LljfXQKHUUCJuXRn8ZLImb408hnjg4jqHQOFgj44JkLAO1Qvqwn36f5559ht4STLsFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782857457; c=relaxed/simple;
	bh=fnspQWBmSRnNj07Xy4CaTJ4TqkCMtse+qFGhOV9+ajU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLW0pw9+A3GVNV7ag/53FRmPr0TVtXuAxfRC5rEdnmpXFppUp3hrDkQte2ae55VKB8ycB8tT/hHs9kR7+WDXKHMVMMhTsNqGYPnC38XctnaY9b6CWH19YWZmMoLZ/phqxfYp3/I3E7W82cxUO3D0cKtmpUOPV+HZnlUedsIZv1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zm+/ITDl; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zm+/ITDl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=VQ1WAdTjz3Ww9nXUFoKq2lTEwxbcgJUEo9TVqDh7GhE=; b=zm+/ITDlxtP/PMzP2nGltZCDgB
	hBl/Q7LW+mxqxPRNfNXccL2YNWJrfBRNzGB+3cajP9iRxHiILb2vZX00k4nyBZ68H7qGSmIndwjW/
	DGmUy9SdKi6b6pvQQQae14r5J1A24QCOFr1xtybYE78oZ519K6TtlEz8XXD+rZah5i0Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wegfJ-00A3FA-RA; Wed, 01 Jul 2026 00:10:49 +0200
Date: Wed, 1 Jul 2026 00:10:49 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/4] net: dsa: motorcomm: Move to subdirectory
Message-ID: <5092b703-e826-4644-b1a3-8d1dee4b6f6a@lunn.ch>
References: <20260629183137.541341-1-mmyangfl@gmail.com>
 <20260629183137.541341-2-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629183137.541341-2-mmyangfl@gmail.com>

On Tue, Jun 30, 2026 at 02:31:32AM +0800, David Yang wrote:
> yt921x is already the longest single-file DSA driver, so it's time to
> split it into parts.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
