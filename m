Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792543841;
	b=UwPFVkhNyYbotPQ+UXGb/PcTYLvdDWVa9fBrxs0UFpxIb0+zxUCsOsijmKC3hcHF3ggO
	 +20Ha3CYNkK8/CuUWZmLKMJrAY/LmsZYNUvLrUrit3LtKDMXON5RtOc+38SREtyyvIlA4
	 ay5VdOcm8rD9lIwKo2wi0HrxA3maWiojwjQhCRkLcQydVND2No8Xte0w22VqDrQDUkmIs
	 5rz4k39bBengROm7BiooFaky3PnMXsR9D/GTVS8S/Br1KAOLJJlCDCh+aJkESrGAQ33B6
	 EL5YaDJnnmtpaBSzGn2TWg2r8hDprhIiwsqORCuzOpQNTGWZIj1Q4P8SoGtwZsm0QBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792543841;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=7NakYNL871cRTQpV2KiS4MwXIGfg/GoB9+Fx09KFnvo=;
	b=gaNTaYJVIJvFF6JBJikL+D3119CU8ka94mdMahDpO+52Y8Gqg9GYVDAd1W/ZuIAJoPUn
	 EvKysz0gM8KXEJ8f/vQbLQ+VnMPe5T+MUOSsEizn2WCxFTNA9CunLQPrVsxpFChWDfQw5
	 s7bL+U7FHpvTzC8V1pROHwRurK8Qoo8u6ED6lE7mfeUPAGnmFprlC1rdVbafhEQ9WoOEh
	 9JdGrAWsjehEv6SidhRv2Cqtu7jwEQVXWAh6u8O/bmwyCAZSaNzQESUemCiX//P0pXOe+
	 SYfotWIoEdGcMm/D1NaSU1si3nLtLic3KOOoZAmU8f7wNPxh2NmYRjk+iMltLtpGk1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=br3oF4LS;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC16606A31D;
	Wed, 21 Oct 2026 00:50:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DC16606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=br3oF4LS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7NakYNL871cRTQpV2KiS4MwXIGfg/GoB9+Fx09KFnvo=; b=br3oF4LSH+w9t5Z4Es9N1Z3o5q
	XOkoZmbw7CLG8L275XdUmjMA3XNYI5hU69TCCVp4NaArIBQTTxznbTiuYOzYWXVTmDYsmfnrVwWTu
	osaUxGet2maR7WClZXcGLKkHS3qPo11M0nRt6qr/PyLYtWPqcF4SNkRz9w6sASaVqwrk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xJKXD-00BwsC-9z; Wed, 21 Oct 2026 02:50:27 +0200
Date: Wed, 21 Oct 2026 02:50:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: emac: guard PHY bitmap teardown
Message-ID: <678ea0b4-ba3a-499d-aa5e-217330590663@lunn.ch>
References: <20261020222723.1746201-1-rosenp@gmail.com>
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
In-Reply-To: <20261020222723.1746201-1-rosenp@gmail.com>

On Tue, Oct 20, 2026 at 03:27:23PM -0700, Rosen Penev wrote:
> PHY-less and fixed-link configurations retain a negative PHY address.
> Avoid shifting by that value while removing the device, and serialize the
> bitmap update with PHY discovery.
> 
> Fixes: d6f144830bdf ("ibm/emac: fix improper cleanup when device is removed to allow re-bind")
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

This is actually two different fixes.

Please split this into two patches, one adding the mutex lock/unlock,
and the second looking for -1.

Since this is a LLM found issues, not one which actually bothers
anybody, please submit to net-next, without the Fixes tag.

	Andrew
