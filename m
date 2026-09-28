Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DF6363082;
	Mon, 28 Sep 2026 01:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790559253; cv=none; b=kvwRvML6UgJy9Ait3UHi+AbqFm8OQEggFHumgwq68AKpch/o4KHLNRObAsHq0jwKRt9MjSBzGVkniQ2vilx2mOLT5hqMfd5IPQtKBHgLWDNFAQbMbPb8Ovb4b4uOmJZ0S6Pf16fvOz2qgv34I16loK43TywcUAdA4t9KLlHVTA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790559253; c=relaxed/simple;
	bh=Bcztscssb+S3DRuQZPjeL3UWf5CO6sQhLzjsL8LND/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UcPXCjIAVXqUkvSsN42svYXK69wOahFvQs/E9hGPyt5z1O7Ixd6Xw88UrmGNpL4wX1RexSLKHJ49upD9oMm7gCbLeZFrojGeAVqPkj+Z/WjMog8qlKXreWEvivIJUMt7vd6koU+UAdlL72EMj2nMnU3uXtgy/THWsyl6S56rfos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=5KU3ojg1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5KU3ojg1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=UUCjqNm9NvxEbmSa32Ot9O1zERH3prsSUL5wSts74p8=; b=5KU3ojg1xrAQS3G44xzF+mfaRz
	9+WsUAB5upBxnNDlOx9hw4kYrv0Y9iXmXjhjQBkMNmguLBGTT3YnNPSjNQVFpB53YorqZGtHUcRx3
	69NNesTeY+Q63/L9quajBJDdin6pOAeyURIZBbiNXVfbCexK1K9/5Pgzsj2M42+DvqNQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xB0Fe-007bdq-Mo; Mon, 28 Sep 2026 03:33:54 +0200
Date: Mon, 28 Sep 2026 03:33:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Dane Linssen <linssendane@gmail.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	Mathias Nyman <mathias.nyman@intel.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: r8152: RX stops until rebind after -EPROTO on the bulk-in
 endpoint
Message-ID: <eccf9c1b-b5dc-45ff-b3c7-859e3ef3c832@lunn.ch>
References: <CAM6_QD_PoTdwdM7DvzzgHRs-G5EvQu-c5oNGve=GuKV4wFYAvQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM6_QD_PoTdwdM7DvzzgHRs-G5EvQu-c5oNGve=GuKV4wFYAvQ@mail.gmail.com>

On Sun, Sep 27, 2026 at 11:55:25PM +0200, Dane Linssen wrote:
> Hi,
> 
> An RTL8156B on r8152 stops receiving and stays that way until the
> driver is unbound and rebound. TX keeps working and nothing is logged.

Is this new, after a kernel upgrade? If so, can you do i git bisect to
find the change which broke it?

	Andrew
