Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41484E4314;
	Thu, 17 Sep 2026 12:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789646839; cv=none; b=a1Jup0vwIzFsYr4z/J7cdC3/Tk6pNJ/0pvUopPjK7KnXPDzsFXDNDCnJTc1N5NgVI/pG8N2jbQi6YzOrq/g3BeJUd7Ne4hkUqz9oN/xPaD348HS/BKBqhep5E7zl3wYXO/mRGTVU6qHe5NLB2b600FG3hHSM0DWgGv5+zNXJbr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789646839; c=relaxed/simple;
	bh=+N/xA6uppH+jcnCFHQTy2mmbhw5VGAyrd3eBpNbthIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TEelBngQEtwOGZBFMygwKuwD2RMyPxkYb+vpYaugiiDw8GVoiMBmQI4v3WeqOGM+84R8q0xDSu/Ll3VG9h1LYC+zGkF7BjhFGCtiY858nZ6cBRV/GWWIBMVRXeC2G6oWUY5RLA1etlQhY7DvpaegNS0I5XxgnqkvCyzFEMJKE1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Cje0W705; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Cje0W705"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=DH0OYKtGSUlylYcDmv61Bdop+K5RL/tkGG+cpn5RDUI=; b=Cje0W705n30oEkgLv9O91hfRxU
	Kvx1U1ZvIjcrwycRguaBZUmBDmo7+T8hsSLepWkInQtsvMl95IJ+Z58Ieh6xHfdJD87nSH5dSsNQB
	WjlDxnFHTQbaY0Gqw3ZX4ypNQFZgqj1uVXYeYJLmLxFawhBfhIkSAhc8idYt+S2l0OoM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x7At7-005fOp-91; Thu, 17 Sep 2026 14:06:49 +0200
Date: Thu, 17 Sep 2026 14:06:49 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yoshihisa Yamamoto <yoshihisa.yamamoto.xn@renesas.com>
Cc: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2] net: pcs: rzn1-miic: Reset PRCMD state before
 unprotect sequence
Message-ID: <f896b55f-ca21-4885-a2f3-5807184cf959@lunn.ch>
References: <TYCPR01MB748139F059DF2459B9813416A4B92@TYCPR01MB7481.jpnprd01.prod.outlook.com>
 <TYCPR01MB748157ECB6B92D8E3FFD433BA4B82@TYCPR01MB7481.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYCPR01MB748157ECB6B92D8E3FFD433BA4B82@TYCPR01MB7481.jpnprd01.prod.outlook.com>

On Thu, Sep 17, 2026 at 02:49:29AM +0000, Yoshihisa Yamamoto wrote:
> On RZ/T2H MIIC, writing 0x0000 to PRCMD resets the command state
> machine to the IDLE state.
> 
> Reset PRCMD before issuing the unprotect sequence so that it always
> starts from a known state, regardless of any previous PRCMD activity.
> 
> Signed-off-by: Yoshihisa Yamamoto <yoshihisa.yamamoto.xn@renesas.com>

Please start a new thread for each version of the patchset. The CI
system does not always see the patches when linked to an old version.

       Andrew
