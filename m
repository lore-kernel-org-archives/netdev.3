Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A6E3B1BD
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 14:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787065067; cv=none; b=ewbX4PXYtz1cTEWNKUb76r8H6Shudke5wAN1xfvyfBlr2AqzhZkOe7G5z4BmB4g4yYZIAmoEWyeMWIadTLdn5DhKpluph+S0hZb2PzNZSP4XNF/ZaadqrcoWoMkSKM9k3yjtTELexe6bwlLU60QBPhZij+puS5ivHzwM8sb28zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787065067; c=relaxed/simple;
	bh=uY3rFsyz5ZYdIErBIaijCvXqLjLcebXEzx+044EhWZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ULC0IN5uEHeo9uyDalrJjJwDTh0m8YpjJlz9YXFGeXQLsUvhutg6dGqT8MFMBxadEkdnUnSEr52x5Cib7G1D0ibAFvk8zbYdctA7qzp+y0wN4MzKlBXZPWRWhmfbrvbH7f9b+MidPI3bTeSOOmzOQjTn5MPG36G0aU6ARwYF4nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Cr3JIMOd; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Cr3JIMOd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=5Z6bwL1PxQ3izXSOS6Vsahi2TqLTaxXTcr+7j4SA0u4=; b=Cr
	3JIMOdTL91a2OkQwXfCPJPXHeNxxrpMiVo9Sg09luJSA+5rKpYsp3ej0ZGhz0v0xzAzyoIKAIDqP7
	f1r0cXomAwo6pla85ZL34xDRPd6vMBsmBxQXhjw96IipdA5/WiCgcTkY5EuYZIR5GMBymIRvP6Hjd
	a3F95FcFBpCs40M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wwLG0-000U61-R9; Tue, 18 Aug 2026 16:57:40 +0200
Date: Tue, 18 Aug 2026 16:57:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Pedro de Oliveira Amarante <pedrod@rivianvw.tech>
Cc: netdev@vger.kernel.org, joabreu@synopsys.com,
	alexandre.torgue@foss.st.com,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: aRFS support for stmmac , any existing work or interest?
Message-ID: <9cb3528d-3ac7-4de1-b1bb-a6c58494aeec@lunn.ch>
References: <CAOWL=BDr96rcThv7zPY5PhOsgNXDJmLPQL5LWjJXgdwQGX8kkg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOWL=BDr96rcThv7zPY5PhOsgNXDJmLPQL5LWjJXgdwQGX8kkg@mail.gmail.com>

On Mon, Aug 17, 2026 at 07:13:14PM -0700, Pedro de Oliveira Amarante wrote:
> Hi,
> 
> Is there any existing work or interest in adding accelerated RFS to
> the stmmac driver?
> 
> Today stmmac only reaches the Flexible Receive Parser (FRP) through
> tc-flower/tc-u32, and that path is accept/drop only.
> 
> The hardware seems to supports it, as I've confirmed on a dwmac-4.20a
> part (frpsel=1) that setting the FRP entry's dma_ch_no steers a
> matched flow to the chosen channel; the driver just leaves it at 0.
> 
> - Is anyone already working on this, or has it been attempted before?
> (I couldn't find prior postings , apologies if I missed a thread.)
> - Would this be of interest / have a realistic path to merging upstream?
> 
> Happy to do the work and send an RFC if there's interest.

The architecture of the stmmac driver is not great. Please take a good
look at the driver before you start making changes, we don't want to
make it worse. It might be you need to perform some cleanup before you
can add new features etc.

However, RFCs are welcome.

> CONFIDENTIALITY NOTE: This electronic message (including any attachments) 
> may contain information that is privileged, confidential, and proprietary. 
> If you are not the intended recipient, you are hereby notified that any 
> disclosure, copying, distribution, or use of the information contained 
> herein (including any reliance thereon) is strictly prohibited. If you 
> received this electronic message in error, please immediately reply to the 
> sender that you have received this communication and destroy the material 
> in its entirety, whether in electronic or hard copy format. Although Rivian 
> and VW Group Technology, LLC has taken reasonable precautions to ensure no 
> viruses are present in this email, Rivian and VW Group Technology, LLC 
> accepts no responsibility for any loss or damage arising from the use of 
> this email or attachments.

If you want to go further, this has to disappear. You just emailed a
public mailing list, which is publicly archived, forever. No way to
destroy it etc.

	Andrew

