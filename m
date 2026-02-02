Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900292BD022;
	Mon,  2 Feb 2026 21:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770068582; cv=none; b=PrKsgl0FNzcd9Qbk3HgBYOOZEkL7KvrYLuBCgHWYmzs2uzJUFFjGxnmj2cGCaTQDelr8BkUK9Bu5aDeUJxnU5bFgpPZdbGUHE3jxouinyBaiuf9dmvk7U7hBypcMUWi0F4lchk5PIIXlV5UL+LGHWta49RjBouSvrU124JnUrxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770068582; c=relaxed/simple;
	bh=EM+yB6h7ZLLXyFPlzm3Er2mFuOEk3fS2kyUl4jgJabs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XR5W/VYPi6VRJ824Gt5PxVrdYS3m9vIqYRPrZKsdUKZQjIKxycstEjjJkcK3ghWoCA5mxYOzAbSdmTFUXAAMorHa05bBPV4Gg8L233QrdM/6xQKvWoe8UrayxSoIZ4fCb48N7EY+mOVDgBIMSfr4gbpIXiwNTs5MIcbeT6SPmHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4kOt8Uz7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4kOt8Uz7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=X+rJcB2Y3qMDo56ip7zmJMMV7jKekUzDLMK8Xoy/uag=; b=4kOt8Uz7i0mzzy8jrwtiH1Kwzx
	uUOJtiRZNlPHGyAlZwIPCcxtxOolOVgw/aXNtkbbMovey+opbxKkDEjn6Kfqt/NOtpGxsjjnbdBSX
	8GTXNJiALuzNd0KGnzWhsiAqeqBkS3LfriJFK5UhOJxrBKQyTaka1VOmJ3c/PUbDVjTY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vn1gw-005sFZ-Kg; Mon, 02 Feb 2026 22:42:42 +0100
Date: Mon, 2 Feb 2026 22:42:42 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: Vivian Wang <wangruikang@iscas.ac.cn>, Yixun Lan <dlan@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	spacemit@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH v2 1/1] net: spacemit: display phy driver information
Message-ID: <35c9e98d-58f1-489b-a635-4755f518da96@lunn.ch>
References: <20260201100001.33102-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260201100001.33102-1-amadeus@jmu.edu.cn>

On Sun, Feb 01, 2026 at 06:00:01PM +0800, Chukun Pan wrote:
> Print the PHY driver used and interrupt status after connection.
> 
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
