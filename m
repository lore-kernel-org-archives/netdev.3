Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34802352C3F
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 19:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790538431; cv=none; b=iNiE3h5cKwtxnkIKmq7foE5I/nBJy0qMEnxzEUSwCBT7UyxyL7CAan+dsLe69y4wmjsxHV13fQPS70pYlf8OQy7tf6MKgvHEovvlxkzNWBtlP8TIiPNMqWTT7+uokryPFeV9vphTVx+g3E8qk4HfyJOLOdCwzCTacQhanp0C10Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790538431; c=relaxed/simple;
	bh=JZyZaY8L0qDWdgkL/XIv4rfr1fFAtgMzndD1hsWL4r8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OArn0J7SGj77zVDg1TIcI2yTjQGLBkUYkeyFAqbo0BjUPPC5spv1zci2k5XfrOkWGugg1ft4TVoxoq9fIvznrBLFsJOUAg8XvSLXjY6g1eookSvmiP+k1eqqGZSiFeYJAtaCIfhJTf8aqBhKZtW5J7nk534JeNCN35ZcTfWY1ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=WRnLot42; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="WRnLot42"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ZV/65/lm6txMSvfwOzqDRArVAIYdzLFkpEL+cuAhogc=; b=WRnLot42y8TUVGAENs7vZOzPAp
	DjqzkozfFvITazlb2aWK9cT77dxF9zSkiyIa7S9HNrGuvg9Ov4tcdSyy+NJNXrRVlK4x7XQSH0mcD
	uCqS1NfE82vWlW3NVEsMOXlAIRCNglqxZYD5vsPaXWUuEloBar7seDVtC5UCrc5cI+MI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xAuq2-007YhG-O0; Sun, 27 Sep 2026 21:47:06 +0200
Date: Sun, 27 Sep 2026 21:47:06 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Gaoyang Wei <yhyxwgy@gmail.com>
Cc: netdev@vger.kernel.org, pbs05 <xuziyougm@gmail.com>,
	Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [RFC] net: towards a generic PON framework
Message-ID: <3d5e9f9f-09e0-41a2-aa3a-e3bcfcecbef3@lunn.ch>
References: <20260926174601.1675-1-yhyxwgy@gmail.com>
 <b0d1908c-a6f6-4c28-bb4f-b00644acacfc@lunn.ch>
 <92d9c8a9-ef43-45ce-a599-2c00d0a2fa61@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92d9c8a9-ef43-45ce-a599-2c00d0a2fa61@gmail.com>

On Mon, Sep 28, 2026 at 01:22:13AM +0800, Gaoyang Wei wrote:
> Hi Andrew,
> 
> Thanks, the hostapd/wpa_supplicant analogy is useful.
> 
> > But having a dedicated net_device seems wrong to me. However what
> > you mentioned made me think of hostapd and wpa_supplicant. Can that
> > sort of model be used? It does not require an additional interface
> > by the side of the wifi interface.
> 
> Yes, I think that is worth considering.
> 
> One reason I initially found a packet net_device attractive was that
> OMCI itself is a packet-oriented protocol, and an ARPHRD_NONE device
> would give userspace a natural AF_PACKET interface without pretending
> that OMCI is Ethernet.

As i said, i know very little about PON, so i will likely ask lots of
dumb questions...

With hostapd/wpa_supplicant, the PDUs it needs to exchange between the
Wireless client and the access point have normal 802.11 headers.

Do raw OMCI PDUs not have headers? How can you tell apart a OMCI PDU
from a user data PDU?

Is there a PON header before the OMCI and data PDUs? Tools like pcap &
wireshark do allow for protocol specific headers, so you can have
802.3 headers, or 802.11 headers. You can even have fake headers, like
wifi RSS, and more accurate time stamps from the hardware, etc.

      Andrew
