Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D162772D;
	Tue, 23 Jun 2026 11:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782214275; cv=none; b=EtdNBgxzgmxw5lyxLGFtrncp4riU5eplKHOoNlGFShVIS2yAml0oQoTqUsLNj1V+dPDuFB5IPvwEbDxdcSIaq6FMUeE5Wg6AlvN1KNL8OMt/iOuZimFVOzCUBNeDK8hon4Tr6ri1Imqc5ePhPPl/+i1OOLzUcRXqoK9cPyN8jVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782214275; c=relaxed/simple;
	bh=t5H9v8cD0y/MfleB3n3sLnNyUk5bff/XIkZuRBby9so=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=isejBVvFWMW/JtoP+EWm283Wt/XmLo10PqpG+j4cTf7FuhUvGXcM5qi1tdxWU3QedG+WDgvdNqYuU9Z/3lLd+GVdRgObt0pMF1y10OvTe2+SudpMQtpeUOhKtxzRR3jDFEhj9n2w4arWbq+2nCelSXJCPnWQ5GscfvSS7z42WG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=sNCcrIBu; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="sNCcrIBu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Rhf4msS0hzIBbTWZHTAeZwPWp7w9ELrd/AqQGfDE12M=; b=sNCcrIBunJWAlTB7MBzdwhvaZc
	mbtM1snQPrSemYkoFiVkDtC1f3e0We6VF1YnGWRo0/LTrqaR3htmdIU7gkonAQwYn/CFFAuz7hAyp
	nTxURC45C+9rzjQNS6IcBed/KyhjX768rfWx33kdk33hiqasPZKVnYAdHs+yXsoVbHOI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wbzLN-008wh1-5E; Tue, 23 Jun 2026 13:31:05 +0200
Date: Tue, 23 Jun 2026 13:31:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jie Luo <jie.luo@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lei Wei <quic_leiwei@quicinc.com>,
	Suruchi Agarwal <quic_suruchia@quicinc.com>,
	Pavithra R <quic_pavir@quicinc.com>, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: ethernet: qualcomm: ppe: Demote from supported
 and fix maintainer addresses
Message-ID: <7095f7ba-bacb-4d03-89cf-ed43882d8213@lunn.ch>
References: <20260623073307.36483-2-krzysztof.kozlowski@oss.qualcomm.com>
 <0247dfba-1c14-4fea-aab3-5489a36f35f6@lunn.ch>
 <8b0560ae-af5c-4d54-be02-d186be1d799c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b0560ae-af5c-4d54-be02-d186be1d799c@oss.qualcomm.com>

On Tue, Jun 23, 2026 at 05:42:34PM +0800, Jie Luo wrote:
> 
> 
> On 6/23/2026 4:10 PM, Andrew Lunn wrote:
> >> Driver is not supported - in terms of how netdev understands supported
> >> commitment - if maintainer does not care to receive the patches for its
> >> code, so demote it to "maintained" to reflect true status.
> > 
> > Maybe "Orphan" would be better, if the listed Maintainer is not doing
> > any Maintainer work?
> > 
> > 	   Andrew	   
> 
> Hello Andrew, Krzysztof,
> I will continue to maintain the listed drivers, so their status can
> remain Supported.

Please understand that being a Maintainer requires that you respond to
patches and questions about this driver, give Reviewed-by:, ask for
patches to be changed etc. If you don't respond, ideally with 2 to 3
days, the driver will be set to Orphaned.

If you want to maintain the Supported status, we can help you set up
the needed CI system, and get it registered so it reports the results.

    Andrew
