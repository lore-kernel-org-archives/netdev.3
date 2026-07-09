Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DCE426698;
	Thu,  9 Jul 2026 13:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783605006; cv=none; b=lJMApWkFu8afVNLtJNc6S55m36I4iRWGeEZXXiGF9BBqNb/6bOmXk9RZ8BRJVxJCeuFhSBzR475clvh2BOAXj4luRxNotAYW1JBlYTgEKSm2IbJXS2uIPo85I8pG6IGL3UsbZ8LEJLmRFThxhYMCkvCv+iLDwFJ0vLzkhW521zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783605006; c=relaxed/simple;
	bh=WUQQCHxlqXbSzNDHU0i/BFDAsBRWW83Snmqtn1EizTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mh4CH0xzjNEFNijk5Lo/bjRJVyUXjNPZ8C1x/wXoXC3snTPyGEYQMxfFMpw3MAXgZyJabJKdjjC1Nyakph6pPnWwbcae8yhnH/uH0BVXlNS1kk08uiYEOCVbhO6VMmGIIKORNHU09MikZ7JJwAIZqVN28IyWLre8jLpfuwjnaO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=S4Q23EPH; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="S4Q23EPH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=gYZu55CoPdGPpVSCMWMnNdXmIAkhmxWSMsJyWl0qiqw=; b=S4Q23EPH8/v4LbG/mXkEXNQ5OQ
	ctbuOuzyiVjlMi7SBQaT+3o8HxEU7i8VpvC5yBcZ3TkzpsNXqazZ1wfotHKGY++KRzNIXwCpMv+1J
	IHyAX1dP0bVoH9c7aHvGb+fz9iL4NGATGXAQotNlUdvk7uaIYKStmDw00e/03ZPfywEU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1whp8W-00BVDR-Bo; Thu, 09 Jul 2026 15:49:56 +0200
Date: Thu, 9 Jul 2026 15:49:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oliver Neukum <oneukum@suse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	manuelebner@mailbox.org
Subject: Re: [PATCHv2 net-next 3/7] net: usb: use cdc_state in struct usbnet
Message-ID: <545c2c92-3359-4bae-a31e-faf0c2a764be@lunn.ch>
References: <20260709120116.1423033-1-oneukum@suse.com>
 <20260709120116.1423033-3-oneukum@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709120116.1423033-3-oneukum@suse.com>

On Thu, Jul 09, 2026 at 02:01:12PM +0200, Oliver Neukum wrote:
> Remove private copies as now a central state can be used.
> 
> Signed-off-by: Oliver Neukum <oneukum@suse.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
