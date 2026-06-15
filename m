Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376CF33262A
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 11:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781522693; cv=none; b=Y2HO8z2a/jBQtlagmDU7zonOOHRtTdQw/aAGssykk6yLfw0yM6oqpMQxJZisbpwn5V3f3D0cz0ELX8sVFa6nX/pqH3pn+Sr5SlUqJoxq1ZdzaJ5i6WZtopoY442t+h0bsTyw5pLAzUXkZVbBIikuVLu3bwbMWnFmQQyl7K3Zkqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781522693; c=relaxed/simple;
	bh=/LsWDg8Z4r4/aZq1N5Rgf98imEnctVngbdNq714rESo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tCn1QY8GxDXaVz5rCCr/xA20hQVDQWYvmjg5yA82bM8cxkDYyLadaTdkKB8ZmcpoCgrn4SjKAR2w63brUtWSzEDIPrE4iyPUJE/RvZL0WWJvY1/NW2OyY46gs87I+cDvgFFZQWm9tONXZzebslJm6JjlmTlN7tBI9CaKbGBjiIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=QtP4DHFH; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QtP4DHFH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Xnl02vDl8tHcP3eFvIi31Hf07qNa+r6eqOGMBuYfG0A=; b=QtP4DHFHIbs4gmDgs1H51B2vKL
	E7J96FoWMUJ4a+J8DPaffJbc0eceCkXYgPus0GbAvu+hXyIQyn9qMDvYPcn1ISsHCGBZc2tMxavDO
	HS619o7RXsYp1ogwysOzg6tzOIT2NZFT+XT5lpgnRCZiDi/bJutuaGLO/og6aN+izI3s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wZ5Qi-007mxk-Jz; Mon, 15 Jun 2026 13:24:36 +0200
Date: Mon, 15 Jun 2026 13:24:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rongguang Wei <clementwei90@163.com>
Cc: przemyslaw.kitszel@intel.com, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	Rongguang Wei <weirongguang@kylinos.cn>
Subject: Re: [PATCH net-next v1] e1000: Initialize phy_data to avoid
 unexpected values
Message-ID: <df2fe788-34b4-42da-9f46-274abf5eb9ff@lunn.ch>
References: <20260612080331.120096-1-clementwei90@163.com>
 <1578c474-ffbf-46f7-b906-49da4ea48142@lunn.ch>
 <6a4bb07e-dbfb-4017-b0c3-b01ef2fc5432@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a4bb07e-dbfb-4017-b0c3-b01ef2fc5432@163.com>

> > Isn't a cable length of 0 also unexpected?
> > 
> > How does this patch actually make the situation better?
> > 
> Uninitialized variables may be initialized to 0 by the system, explicit initialization
> is performed to avoid accidents. 

That is still not an explanation why 0 is better.

Maybe you want to change this from a void function to something which
can return an error code?

But also consider the history of this driver. When did anybody do any
serious development work on it? Does it makes sense to do work on it?
I assume you have the hardware and can test the changes you are
making.

	Andrew
