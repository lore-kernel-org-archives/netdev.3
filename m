Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2B8391E41;
	Sat, 21 Mar 2026 15:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774106942; cv=none; b=MzqTadXWrdWZ8aoHNuOH23sQLq/Vvt6nB1I0lH6Ck0XJqet0DLkfMa2qj9J8HGQqGPfCqiEL65s1eqUywoHumXW/yFtMkIHuClig/yy7Bh3XXdOBoWymkrmGwcChfpWeOpLWPnOhb+0+pdUFBS5cxOW5SN0fMpnCFgXbu9jUK10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774106942; c=relaxed/simple;
	bh=4CMZtdrUkeHipUTfXOQB1nOArw6Y9HSJFvn3EVDhXyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pipUhBVfWpx12RhCvGrKOSAlypWVb3HOG1oIQ9sgtM9GMEhLpXX47WxmHRMeqmhVP75mB7toT/sEmJRkM3EJIefgvyf7My2FvNd26i8a2aN+3Qx18trDIt7B7CH5JlZKjejd0H/SuITthww4gRfHoI35CFWtXz9Q8XET40teOmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NXQjXmSw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NXQjXmSw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6AP4cI1zcL0d79rvKwxclRXlEkH2NVlrTTHSANQpKdw=; b=NXQjXmSwx/TN8qJjeUwyuQbicK
	m1Xnpl7EDZuRnQXY+ktfgXE4ykTpvgSi/MMCxvYwz5A/prZjWHF2RMG3RzaJ4C6E/YRRSbkm4co5U
	llb+laF/WPbbZTUtXndQnpvW+eoWcQ01/fBx8pH12Sdu5mSRppR8NjgJyMs0FPX1M87I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w3yFw-00CizW-4p; Sat, 21 Mar 2026 16:28:52 +0100
Date: Sat, 21 Mar 2026 16:28:52 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Liang Xu <lxu@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	Jose Maria Verdu Munoz <jverdu@maxlinear.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next 2/2] net: dsa: mxl862xx: use RST_DATA to skip
 writing zero words
Message-ID: <279eca3d-e067-4d0c-ad2d-9c989d7801ea@lunn.ch>
References: <cover.1774070039.git.daniel@makrotopia.org>
 <d27d646eb7a4cc50585821bb2b2c9ab7f6b1a75d.1774070039.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d27d646eb7a4cc50585821bb2b2c9ab7f6b1a75d.1774070039.git.daniel@makrotopia.org>

On Sat, Mar 21, 2026 at 05:20:14AM +0000, Daniel Golle wrote:
> Issue the firmware's RST_DATA command before writing data payloads that
> contain many zero words. RST_DATA zeroes both the firmware's internal
> buffer and the MMD data registers in a single command, allowing the
> driver to skip individual MDIO writes for zero-valued words. This
> reduces bus traffic for the common case where API structs have many
> unused or default-zero fields.
> 
> The optimization is applied when at least 5 zero words are found in the
> payload, roughly the break-even point against the cost of the extra
> RST_DATA command round-trip.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
