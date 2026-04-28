Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D247633BBB1;
	Tue, 28 Apr 2026 16:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777394749; cv=none; b=iXF5R5HG7eeijVNXUvhyh1zGtIn7qsGbqVGMGji9GDHyGu+GMR/8N9SZMApYzRQgf+DxlATrf4BrvuwKSPUh+FkfLo7EuAYr+RIuL9z9WELRyOciHQdeDLk2vlDpIZboI4WPRt+UvW2dlBid93tecmoBnKEFPr16pz64ZKfY924=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777394749; c=relaxed/simple;
	bh=44UzHHp3Vg6kLMVVpxMVtoUkOpmBtpHyCKbwCaI8IsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jFDPpsjZB3z3SzZd6i3tm8duguW8KWF7zNfGxOUFec2s6nZIsgSTUA28K+YKKz7o2ifqAmlvUg4CQsDMLcFyLbBN45EMj8tlEKNBJxqTM5eL5iUXYCUGPoB0FhFpqvfA8wsluoaku3PynbbOna3B9r+Pxh+vYSZpzF5aXu43Gyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RfMOU6cX; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RfMOU6cX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hZtkJkwAYBJj/dqcDVYkgzF9zSMWomEH526AyV+zG04=; b=RfMOU6cXjNAnIu3PbmEWC3pa5F
	imfiBALyYzUGur5fW+7sDl0L2eWPuiPey1o1owZIR3Xk6i1euB7pWhlHoSXn0flqybX7NPhpqgUP0
	dohBO/ES1nVu3jTUPtiuiiLsW8wvBcEzpi4RSclCaDL9j+K1OctaDr4i7sEbdCbi2OH4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wHlZ0-000NKU-TT; Tue, 28 Apr 2026 18:45:34 +0200
Date: Tue, 28 Apr 2026 18:45:34 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-usb@vger.kernel.org, Yehezkel Bernat <YehezkelShB@gmail.com>,
	Lukas Wunner <lukas@wunner.de>,
	Andreas Noever <andreas.noever@gmail.com>,
	Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH 9/9] thunderbolt: Add support for USB4STREAM
Message-ID: <e38bb396-748f-435d-9d17-5e7799edcc64@lunn.ch>
References: <20260428072209.3084930-1-mika.westerberg@linux.intel.com>
 <20260428072209.3084930-10-mika.westerberg@linux.intel.com>
 <ef5411f4-0e4c-4ac1-8ae0-0d557fc0ebd2@lunn.ch>
 <20260428151311.GU557136@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428151311.GU557136@black.igk.intel.com>

> > Is this mutually exclusive to networking, on a device?
> 
> No - they can co-exist.

Do they have there own rings? So that ethtool -C on the netdev will
not conflict with your configfs setting of the interrupt coalescing
for the stream?

	Andrew
