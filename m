Received: from sender-op-o15.zoho.eu (sender-op-o15.zoho.eu [136.143.169.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C247B4F3903;
	Fri,  9 Oct 2026 18:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791570900; cv=pass; b=C6XJOJ8NDDFmdlT1XE4z3+oHsA5BBPbesmxWbU13cp1RJMDiApCCq2lLcjy040SOUugG5TJIMu0+JRC8EN5NsmVUuUO40wY7kaVjcIDUv3HxcHH66P0CHowIT8z3H+awqNgop3HsndMBKpdGCXOnta/ccdT0OW9+BhBecnwpYNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791570900; c=relaxed/simple;
	bh=WlvvH7aLnKMNlCSRgQjoYBIeJresBfFKmPCesFrfVRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IoLSiEkQ3tNUX63CReQYeLPzBTP/8htDPMip1cG/+R47cjVlHE6gzXlwg09mJ9ugRGFctT5XoQ4WgILw+8FmeIE30L3KUNgnZBkFx0AJPHradrND5iNdN6lXAruIhB9rZyeKM7MS4lv+qL4FHNef/wnNfO2mqw09xVLhS6cRAfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv; spf=pass smtp.mailfrom=iav.lv; dkim=pass (1024-bit key) header.d=iav.lv header.i=iav@iav.lv header.b=UbYg8fym; arc=pass smtp.client-ip=136.143.169.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iav.lv
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iav.lv header.i=iav@iav.lv header.b="UbYg8fym"
ARC-Seal: i=1; a=rsa-sha256; t=1791570856; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=KBRo7/xC1wGJdhiP33q8Cz89Vb2WCnfyDhf8/LgiTKnkgxrs/qqPaLfcEvvvfiabHoLnj7vNfFUQAdw2Bjw6UK4TYh0r9Oo3awf2ZVH6R8kvLMPzf9AUp9vVfwpdDzGrlWH4Z447MyXsnKb8ZvwTCtnmMjnJx7xXpvSzFNNwnkw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1791570856; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=WlvvH7aLnKMNlCSRgQjoYBIeJresBfFKmPCesFrfVRE=; 
	b=SOjOBeILFY/QbfJRlF4mXT86+BQRZbQyMyd3vV4G+8p8ggT+3WHxunwzF6VPVxLAOAs3ttoV6LAzwRNcb2SZmSwZB8LIBABTLlywd2nq0h2huYXulVP4nSw2/tVBrOhOqTRCNhMrxYrYKrTcjoumcI0VI/0sS5S6v3ypqTzOm9A=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iav.lv;
	spf=pass  smtp.mailfrom=iav@iav.lv;
	dmarc=pass header.from=<iav@iav.lv>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791570856;
	s=zoho; d=iav.lv; i=iav@iav.lv;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=WlvvH7aLnKMNlCSRgQjoYBIeJresBfFKmPCesFrfVRE=;
	b=UbYg8fymFWEe9r7Wge15uZxMG3lucl+S54vRBLRZ56M+zuNboVZ2kcahy7iEvTuM
	X9LHIGjDmFAzf3bpJ0diIGXhmNADiy0vFGkY1RL9V796rsw531LtcBCbBkgpv8fWPCj
	CEqTa4GgpDodPJLWeS0AHRaj4MJrE7ZTR5trvIso=
Received: by smtp.zoho.eu with SMTPS id 1791570853170490.41588682163206;
	Fri, 9 Oct 2026 20:34:13 +0200 (CEST)
From: Igor Velkov <iav@iav.lv>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Igor Velkov <iav@iav.lv>
Subject: Re: [PATCH net v3] net: stmmac: mask the MAC interrupt while resume
 resets the MAC
Date: Fri, 09 Oct 2026 21:33:39 +0300
Message-ID: <179157081922.1752198.10387132413683817189@iav.lv>
In-Reply-To: <20261009090252.cqrmpdn4bpxsbfqr@DEN-DL-M70577.microsemi.net>
References: <20261007031438.3179966-1-iav@iav.lv>
 <20261009090252.cqrmpdn4bpxsbfqr@DEN-DL-M70577.microsemi.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, Oct 09, 2026 at 11:02:52AM +0200, Daniel Machon wrote:
> The fix seems OK, but it could have implications on other drivers, for an issue
> that is dwmac1000 specific. Did you consider a fix that would only touch
> dwmac1000?

Not before you asked; I have tried it now. Reading RGSMIIIS in
dwmac1000_irq_status(), the read that 2e2c878a3141 removed, stops the
storm as well. Worst case, the resume thread and the MAC interrupt on
one CPU, Wake-on-LAN resume: without a fix a soft lockup in 3 of 3
resumes on Helios64 and 2 of 2 on ODROID-HC4; with the read 0 in 10 on
each, irq_rgmii_n going up by one per resume. I'll send a v4 that
touches dwmac1000 only.

Igor
