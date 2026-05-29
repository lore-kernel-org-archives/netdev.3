Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052622DA749;
	Fri, 29 May 2026 22:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780093503; cv=none; b=UXcbpy0N0xu1evu9+/w0WjwU0d6tENAmclptDKudh7rOw2KpSa1lebytFLVsbbzUUsNrK+3yQxmJjHAM0SotYfLGRvs2gw5n0slrn7spIIv7ZUZeTSC7IAsxnnWfm9S2SjbKXGyQeXDENEiyxu+Hpwr8WNwU6CL+ho5Ne+OQbEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780093503; c=relaxed/simple;
	bh=hJftosZ54ulWFMAdONtBLnLPasSga21LYaUWgYPkFRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lV/XCrQdGqu+Hvx/uDjH4Qu9FZN+NHPlW6wzi9/Ok2NuBTg+TRvwjtM5lqEfljz/pivtWoTsO1sm/63JzoNOmnm/nWTNKTihvubuyI9C45qm1DuerN88j8S1/hbfmIehNRIc57QKyQRojpiQfi5DtYo3EJTqME9bV4JCfynmyR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NmMiuk3l; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NmMiuk3l"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MEafzqHfuBpJRgLEZJuEPTcFJ/MeCB9xfdZ+TG/FVNQ=; b=NmMiuk3ldUumBN3CpyvQGn4uRt
	nUvhh4KXxLrqrB3CCaBe8A+ZFa+kxlb96iAaO9WmwyiSsBQcC+40X1loas8hBSrnXmiFTn9pR1453
	PGN8OpLv3YC9So/rX+jZ+fMYsKbrCGcFJrZzG7daeiYrcEJLI8uz1KRtR8HeZxXhHvGI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wT5dL-005B6k-Dd; Sat, 30 May 2026 00:24:51 +0200
Date: Sat, 30 May 2026 00:24:51 +0200
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
Subject: Re: [PATCH net-next v3 05/14] net: ethernet: oa_tc6: Move OA TC6 MMS
 definitions to header file
Message-ID: <d7619281-7957-4110-bcb2-e6bc9e77b451@lunn.ch>
References: <CY8PR02MB9249C29E61887561D50B243D83162@CY8PR02MB9249.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR02MB9249C29E61887561D50B243D83162@CY8PR02MB9249.namprd02.prod.outlook.com>

On Fri, May 29, 2026 at 06:39:52PM +0000, Selvamani Rajagopal wrote:
> To prepare for other files to share the constant definitions for
> clause 45 registers memory map selectors, moving to header file.
> The values are from table 6 in OPEN Alliance specification.

Please don't move them in one patch, and then move them again in the
next.

	Andrew
