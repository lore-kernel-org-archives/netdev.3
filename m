Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D962772E
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 18:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782497899; cv=none; b=tH5bMgyXyKEnD4C8xotTFAZV7AYNj6U6GA/4VWo8DnDbD5EJ5qoBATwzFPwH9nXKKz462P5hZgMIDamkyCWmMdxTi2jDSL8F2U/IktcuYmCNVB0jLzYmtbKusYy6lbRuqgdHuTaF9HzhB2xFfwgB8yy1f3zJ9T2tMFlu2NZXkxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782497899; c=relaxed/simple;
	bh=FxwqHRluM6ZE9kF2sB6no4lDU7A6Eqiprz6NM3tmKUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tSOk0T1DkI7eclQRbjtCAGiDdsREDF9nz9VroteYKKp1UwXraKt1NfDoYXc9tLaHB5iOItWmhWJi9UlY2qJTc2X8bdNiHUHt3M1EU3b3IZMESggjN22L7yuvyTZ2ioC5+9R2/OGjCbFFPSIBW8AT1w8q3gmtkCMknloaCYo/TJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=PxmMesAM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PxmMesAM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=veKtw8omJazukn8Z63YfMTJpEsdl/6xkNOX0nRzml+I=; b=PxmMesAMFoHPRQXe6IMYt3oHqH
	QTQ4joJsRhiLmcASOVGPEX+ngE1MM3pPvka2cU7a+K8RtHdPuK+i103HDNESM0Y81mNTP2qC7bcJl
	CAf78C4xIt5775DvFGvBolvh9JcRlY89esav98VcoDJUVyVY9yU7ImzQpBV7lXfPGcFQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wdB83-009P8k-Gq; Fri, 26 Jun 2026 20:18:15 +0200
Date: Fri, 26 Jun 2026 20:18:15 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "D H, Siddaraju" <siddaraju.dh@intel.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Das, Shubham" <shubham.das@intel.com>,
	"Chintalapalle, Balaji" <balaji.chintalapalle@intel.com>,
	"Srinivasan, Vijay" <vijay.srinivasan@intel.com>
Subject: Re: the confusing 10000base_CR. Shouldn't it be 10000_SFI_DA?
Message-ID: <2baa5a77-3305-4ed9-b56d-ba27cecc1911@lunn.ch>
References: <MW4PR11MB6912A234CAAAFD25EAC7C8909AEB2@MW4PR11MB6912.namprd11.prod.outlook.com>
 <2994edfc-0894-49c9-abac-6daea5e12075@lunn.ch>
 <MW4PR11MB6912BE7FEDE5C509B6C5D5DF9AEB2@MW4PR11MB6912.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW4PR11MB6912BE7FEDE5C509B6C5D5DF9AEB2@MW4PR11MB6912.namprd11.prod.outlook.com>

On Fri, Jun 26, 2026 at 06:12:15PM +0000, D H, Siddaraju wrote:
> Sorry Andrew, carry-forwarded IEEE's PMD naming convention of separating media "-CR" :D. Will stick to Ethtool :).
> I was referring to "ETHTOOL_LINK_MODE_10000baseCR_FULL_Full_BIT" and its associated documentations Andrew.

Please don't top post. And set your mail client to wrap to around 75
characters. All standard netiquette things.

It is a good idea to be specific when asking questions. Asking about
something which does not exist in the kernel just makes it a guessing
game.

As Maxime pointed out, this is uAPI, so cannot be changed.

	Andrew
