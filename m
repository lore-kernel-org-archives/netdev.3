Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A1B3F7A9F
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 03:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785812423; cv=none; b=t5lfxtHpDPCra5dvjjXhrPWbJDiqpFFCdnLyBN8K2kEBY4OS+rUL/AfAhXdp0AfX2yx8oBjKPcmhnsxKwEN1X+x7EYzjJhIzGnoO0eF2i+9rBSafBdSHzBswknrNNxIi8YtyKAsvnKov1RsR5WFYyn3ZzfoV1Kp/cMN/iJhsjRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785812423; c=relaxed/simple;
	bh=7xwY5e3ceAHIdHg7A7hO/PcMU9Hg/myUoi7UnZY5q6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nH5be9XsvPLS1Niw41XEpgMrGnBPz2PHfqCUpo1gR12LJ/y7QCZNsy8zPqwh4WBYafEHvvMYzl9cq1H0splzap/gm3m0nml5D07a4xldP0LYE+LVgjWflD98ga/bIrCCPc7bXDLXZkzdFNHxqaKOXIZhlBHobVAbIEDsoJDLxAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ZcibJYl1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZcibJYl1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3qD0R7jk+rGqW1h53ipYapH2SCIu5TcBXdSWDThDwm0=; b=ZcibJYl1ZeJDinvDlHPUa/FGwx
	vRB3AUwWqFiG1IvmgXHrY4M6czYWI1D2cLi2G3M1OgpQv7ph8CbFmwDe4+gR/irKnbZ4gNwWYYm9q
	O1BhNW/1hlwGNlXfDCOEXmrTSpF1z74RuON8afYqIk/1DqCzwMM/fE5KbPKve+vN5aTQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wr5O7-00Fttp-2v; Tue, 04 Aug 2026 05:00:19 +0200
Date: Tue, 4 Aug 2026 05:00:19 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Martin Vandebosch <mv@dataunlimited.de>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: Reproducible TX stall with Aquantia AQC113 using Linux atlantic
 driver
Message-ID: <7ae5546b-1925-47a4-bd50-fc357a579d8e@lunn.ch>
References: <d5088aa97b4047dd86b381d6ee41cf0f@dataunlimited.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5088aa97b4047dd86b381d6ee41cf0f@dataunlimited.de>

On Mon, Aug 03, 2026 at 08:07:22PM +0000, Martin Vandebosch wrote:
> Hello,
>  
> I would like to report a reproducible network issue involving an Aquantia
> AQC113 controller using the Linux atlantic driver.

./scripts/get_maintainer.pl drivers/net/ethernet/aquantia/atlantic/
Sukhdeep Singh <sukhdeeps@marvell.com> (maintainer:AQUANTIA ETHERNET DRIVER (atlantic))

Not everybody reads all emails to netdev. Cc:ing the driver maintainer
is a good idea.

   Andrew
