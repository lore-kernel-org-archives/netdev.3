Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E220B1A6811;
	Tue,  2 Jun 2026 12:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780401645; cv=none; b=B/IVzrr15zU+kJbKeVCRa7KRXOnodAFFs4j/E6gDsjW6J4RwrIOxjSgPC0m3CmooT7BcVhWHoRHtrN+dGXByDTrDFZxRnVB0j1MTGBetN67oc6nR6msWC0bNoZ34cWSnh/OM0qXBe9phz9Yhr5NhSDY+LeBlPldxtmxGl4kOMAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780401645; c=relaxed/simple;
	bh=dp/+iTiMz/pYNi6L4RRQ99sAGDeVwl5l1xsDeVbOQTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MmFrRBehqvP4C5njURVBqTQAvz4ozvz2+DUcpFQEktZM3lrwhkP2JEH7HQep2uRgUV6wZxu3KjYCDMPSXxCMF98CrgKXYOkxjtR+Q8NozPfBmiW5oWLYeOEnCKv6qdEn+JXsS8vBXdumsK8Ik7AUJZU8cop+J42jDT7Z3jv3lSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=EYoNokPl; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="EYoNokPl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=bn3LblJfFEjiEa9uJvceLp7cBlrJ+F3kSsh0sE2DqjY=; b=EYoNokPlfnajWTjb4XeaAngiZb
	jIsVOnLIDiPkCiNavnXKcEDl9lI3Lz40Xh8mtufqQr5TyrdMj+1FbdBxdnxeVZ2msD0WjbfaG1+zh
	F/Fq0fFLfEGaGqCa+FjI3ZTMNDKrbmNViMTzZlrYPJABkhQrWQf9JQHkfr85ny8gtCTY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wUNnF-005gEI-SG; Tue, 02 Jun 2026 14:00:25 +0200
Date: Tue, 2 Jun 2026 14:00:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Cc: Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	"parthiban.veerasooran@microchip.com" <parthiban.veerasooran@microchip.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 08/14] net: ethernet: oa_tc6: Remove FCS size
 in RX frame
Message-ID: <93ae38dd-344a-4f65-945c-babebef4fbea@lunn.ch>
References: <CY8PR02MB9249644F900471DB8417134683162@CY8PR02MB9249.namprd02.prod.outlook.com>
 <cf87ad90-6ba4-4132-a1eb-beedd796c168@lunn.ch>
 <CY8PR02MB92495E274D4194CF06B1048783122@CY8PR02MB9249.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR02MB92495E274D4194CF06B1048783122@CY8PR02MB9249.namprd02.prod.outlook.com>

On Tue, Jun 02, 2026 at 02:40:13AM +0000, Selvamani Rajagopal wrote:
> > 
> > On Fri, May 29, 2026 at 06:41:00PM +0000, Selvamani Rajagopal wrote:
> > > When MAC-PHY appends FCS to the incoming frame, FCS,
> > > it is removed from the frame before passing it to the stack.
> > 
> > What is missing from this commit message is an answer to the question
> > "Why?". Does the stack do something wrong if there is a FCS at the end
> > of the frame?
> 
> That was a little mystery to me as well when our SQA alerted me with the issue.
> When I tested, ping worked fine without any issue even with the frames with FCS appended. 
> But strangely ptp4l utility failed with invalid data size. Once we removed FCS, it worked fine.
> 
> Will add this reason in the commit message.

Please take a look at NETIF_F_RXFCS.

       Andrew
