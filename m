Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F129878C9C;
	Sun,  2 Aug 2026 21:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785707150; cv=none; b=T1PHHm12u6oQzhhWq3YJiCP3B9I8i7MjVXRVPHGo1bTdcz7WaEybj96mgJkYALQt32DUPeFF5D4/I9k4u4B1r5Rzu4wS3vqyZUbAyIC2tCC4YoSDgXqIR53QurEo+bJnmYzHaFWBPNoacGo3O8vw05FzMtjsZfV10RVULOzyfv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785707150; c=relaxed/simple;
	bh=msiTY31LZ9Tyzga1+WaIkrOz9mUMlkWNsMrO9KF4oBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nazurLIJxf8aXPvGozXmYxos7RsP0ton/w1j0OsPsLBLv1HJSR3ui2h3jq8a1Enmn0Rw7fJ8Xep3uH8EUaCLZKh4CUvsrHYQV13mx0zwZOcsGP8Y7aXyO2z1jNICY7kQ5luJdR5EV1bfqXoxYRkfgNfXwoRajhxX+mb/IEJM9Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=k888MbBf; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="k888MbBf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+rUZMkXL0ohuKWktFmLiUcek7f2HOxZraYJsoE11C6c=; b=k888MbBfgzy7At1py5iO4etQrm
	1SSQqLBKp5bV82RClYGL3+eLf37fiOl9eeYeeZ0ckxU2Vd0MjUjtoDap3vzV2RFJzRrHgf4hxhf7U
	pXbrmJ7WRlmDnzUKgnRFjDJw01J0xWh0cZK8UH5xDUBI1TMdkfogl1+pq27vO0fZAhcs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wqe05-00FcNO-TE; Sun, 02 Aug 2026 23:45:41 +0200
Date: Sun, 2 Aug 2026 23:45:41 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jianhui Xu <neuromoments@gmail.com>
Subject: Re: [PATCH net-next v5 11/13] ax88179_178a: Update driver name and
 information
Message-ID: <cdf1aba0-6bac-41e9-bbb7-271727684249@lunn.ch>
References: <20260802-ax88179a-v5-0-dcb9fea4acd4@birger-koblitz.de>
 <20260802-ax88179a-v5-11-dcb9fea4acd4@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260802-ax88179a-v5-11-dcb9fea4acd4@birger-koblitz.de>

On Sun, Aug 02, 2026 at 06:32:09PM +0200, Birger Koblitz wrote:
> Add additionally supported devices to Kconfig description, add
> further requirements such as PHYLINK.
> 
> Update driver name in usb_driver and update MODULE_DESCRIPTION
> to include the additionally supported chips.
> 
> Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
