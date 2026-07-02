Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD95394498;
	Thu,  2 Jul 2026 18:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783016442; cv=none; b=ajBPkAVf/tZYvXWcGNVVuiTzi5A5Jz7+fFGLlraCzwBdN+Nh3HxXdj9YTZGMuw6YFsjjQQB0bZuW+oHIOhjBBbNaQcArpcPHDzfZ4gxokRVUirySwtKR4mNm0dUBOg5AWoFJItAIFdfooL3gVtIWRxwSdNmLuqwdVgrhkeo/SQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783016442; c=relaxed/simple;
	bh=91jc66yMeek53KPFh6DGIhBOa0ELu2KmG93LYgjexCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jA88NWHeh8XOLik9yAWnx6AbjoW9iMpoJmCu50oMXHl1INDBrQT+YsR41Z4q2/c5QRtz/sWcqFzokm8p1rfKKQ4y9yFzi5GUUzgQT6hwWPj4RfFYBBed3aoVvSseQIhUPblIIgnIkivFR0DTkm3Jmg5RcTx+X2cm9rzvv1jNuZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=QiXYEmg4; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QiXYEmg4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+rc1xoFCVIUImmkJDdnce5cImNd0dBvklLwA/wqnt64=; b=QiXYEmg4vp5/sSVyYaI63rBIjr
	E3CiyYgwp/A/CAepwBzXr51dnGKl6GJvHNWW8cQOiI5FvneftG8pGRcJezelYT7xhfqv8kwQJB0zL
	O2TUSjhBD2smKFCHTz1kq8vUCgR0xK3XVZ0d3TPlkacUkHX/fXedjWrVaEHL7DZN7/5s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wfM1a-00APvN-GX; Thu, 02 Jul 2026 20:20:34 +0200
Date: Thu, 2 Jul 2026 20:20:34 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oliver Neukum <oneukum@suse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, shaoxul@foxmail.com,
	netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] net: usb: move updating filter and status
 from cdc to usbnet
Message-ID: <c88d827e-f365-4a58-badc-051a9379e64c@lunn.ch>
References: <20260702143142.890654-1-oneukum@suse.com>
 <20260702143142.890654-2-oneukum@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702143142.890654-2-oneukum@suse.com>

On Thu, Jul 02, 2026 at 04:25:30PM +0200, Oliver Neukum wrote:
> These helpers are used by multiple drivers and do not depend
> on the rest of cdc. Leavin them in a cdc driver means that

leaving.

> more drivers are loaded just for infrastructure, not hardware
> support.

Can there also be changes to Kconfig removing the dependency on
cdc_ether for some drivers? They now only depend on usbnet?

	  Andrew
