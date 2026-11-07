Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794062467;
	b=fzbeSJzeCIiTZ24fjT5NJ17OIp5tkTrtHvWhiGKra0+p+wUAM4943IKCK//buUCSYuOy
	 VItIJQkDzsjvCmih4Vn5+Ai7DQwg+Lk/RimSS/5j0IylNE6JkGPNrQlKZll4vvxEQ/oFU
	 OxlNK3ZQ98kLzbEJ3hIkTKu2VNpHVjuROxvTNemft7NxMi5R5chlEN1GZfMD9zdCeclF8
	 6P7p68LfVKlUXm5rLD/8/AJHy2spBOZcpBqlQBcxY6zN9hZKdFN8s8sDfohXhWPd1vNhY
	 eetZz2x+Horer92f2pn1d9fqY2whtB6vLq2jPMmZpGoyJDzy76WCsoXumUDHBeRTcFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794062467;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=mAXBJnrefFBIzpyi+/xIAamlnKbGOaz7xXuvjQoOG20=;
	b=g2+gsvN+FRGOI7cLyBKbSahgYxWxDUDtJvM5ROq37W/e3Nmr048jACS9NxAZWCSmEaw1
	 kl5d5pHQq3nj8f0nSW0+PbNwJCn7hOFeKmxYhAePqsUrWBF96ysrYPAHtCXf1RlFIeY1e
	 DiEmFkxfsV2906wv+UUrWcYXBIGqJWDtNpceu9RFSgwBH5F9VaeM1qVqwGNpAKjldWWW3
	 VA5qJaz7AK2AUEapUZ0VqOFowkW4smHaTCt2rKRY4WJkzvuV2AuqCbuHWhWSKu5hcA76X
	 nfZXv4V+kHgYOSXzUl87lZ2um2BjeWLZ09HRtuHgj1jzdcMfdDFPbby/CzI7c/42C7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=niaecTAq;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D8F606A65A;
	Sat,  7 Nov 2026 14:41:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08D8F606A65A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=niaecTAq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mAXBJnrefFBIzpyi+/xIAamlnKbGOaz7xXuvjQoOG20=; b=niaecTAqavwtL7dI0lyUOAqyEa
	E58LYVcaKACZDTdDNLvCDFX3YlqOIU6vX9zKMiB4BtXy4nKBNcAbltCwU4/PVmekWfZ+wCRBLRZRv
	zH4e8VyCRBkPd4bEUo4vHUR/nRdIEYheiTNYbWVOpTvkeFhxvE3tDs55MrSjP/5M/k0w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xPhb3-00Ey67-7L; Sat, 07 Nov 2026 15:40:45 +0100
Date: Sat, 7 Nov 2026 15:40:45 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phy: micrel: Fix potential shared PHC
 use-after-free
Message-ID: <71089325-dfab-45f7-9ebd-1feb65013863@lunn.ch>
References: <20261107-0d0c29e10a-net-micrel-lan8814-1@mail.sdu.edu.cn>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261107-0d0c29e10a-net-micrel-lan8814-1@mail.sdu.edu.cn>

On Sat, Nov 07, 2026 at 02:54:37PM +0800, Guangshuo Li wrote:
> The shared PHC outlives the first PHY's managed pin array and is not
> unregistered before the package data is freed. Subsequent PHC operations
> can therefore access released storage.
> 
> Keep the pins at package scope and select a remaining PHY for register
> access when a member leaves. Unregister the clock before releasing its
> storage on the last member's exit. Pair each member's registration with
> cleanup that also runs on probe failure, and serialize clock access with
> member removal.

You fix looks overly complicated. Ugly.

Try looking at it from a different direction.

.probe() and .remove() should be opposites of each other. What happens
if you do that?

    Andrew

---
pw-bot: cr
