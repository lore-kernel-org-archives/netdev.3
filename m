Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417AA3F4DC0
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 14:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782484348; cv=none; b=Ou3WoA9T9wnNkqGnHmxm/FY4L4DXCMMbwvoKxlazA/uf+8yfCV8C1hJYNE5dLBrmY2KHtHM7hLg9llUrSt/m5O7FjhLmojjFmqMzXdyyImZZo+TIKgcDlW0xmBVFRMt0ZfyC4BOWazRS0QDzIxx1mzqp5Ycqh6OcnUkIXQLE/3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782484348; c=relaxed/simple;
	bh=F36sVb0uhsA8Dj2h4dZa+5KdjUe9/H+qIrfW3tfRADU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qUiYhqN3tIga5bDF2WDoTwH7dHgN8A77OQjhs2Nt0til3Q8ifKU9fNnDeD9J0bElqFE+sTenC3Sf9o3rPxYWhr46lWR1Cm8vZQSSnnF1tysJyGT+MEPlMAVZ8B1BFyOxg2Q66RznivmavbBQTKBORmfa4M5BnKr6xakY+/R2kuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=pPlLYSEl; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pPlLYSEl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8+f4g3FkcW5AlmqHvS55wx6YptrRYjtILQ7u1414NTY=; b=pPlLYSElIWd1XzNpqKshRUdsoM
	jwIPBoE9+5T2zIFyic2EHXUkS3pwZ29xPaWpMNe0PmNY/qW9X1146lCFc5I2ZA89hW1tmp5ppveaK
	36C1Rqsbav92YKp3sbHmTy0DqtODrQtNs0GmMipP94oyLhGrA4/ZXyLUrxcLhrmUF10s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wd7bT-009NdS-FN; Fri, 26 Jun 2026 16:32:23 +0200
Date: Fri, 26 Jun 2026 16:32:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "D H, Siddaraju" <siddaraju.dh@intel.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Das, Shubham" <shubham.das@intel.com>,
	"Chintalapalle, Balaji" <balaji.chintalapalle@intel.com>,
	"Srinivasan, Vijay" <vijay.srinivasan@intel.com>
Subject: Re: the confusing 10000base_CR. Shouldn't it be 10000_SFI_DA?
Message-ID: <2994edfc-0894-49c9-abac-6daea5e12075@lunn.ch>
References: <MW4PR11MB6912A234CAAAFD25EAC7C8909AEB2@MW4PR11MB6912.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW4PR11MB6912A234CAAAFD25EAC7C8909AEB2@MW4PR11MB6912.namprd11.prod.outlook.com>

On Fri, Jun 26, 2026 at 02:15:27PM +0000, D H, Siddaraju wrote:
> Hi Linux Ethernet Team,
> 
> We explored Ethtool's "10000base_CR" PMD PHY type
> and we think it might be just a wrong name.

~/linux$ grep -r 10000Base_CR
~/linux$ 

~/ethtool$ grep -r 10000Base_CR
~/ethtool$ 

What exactly do you mean by 10000Base_CR?

     Andrew
