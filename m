Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459F5397944;
	Sun,  4 Oct 2026 14:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791122541; cv=none; b=tT9XFu85oAe3Oo9sQuuITKIJpwgOAvLVLCH9G6/8xw/j1rrsq7hq7sxl0eWCpO1aN+GQn3+7PA6sOxB/IVhhjw+5SOOuOl5zDY4Q37cxzx7uSt71JH2h7qIqtjrZN1zm3/8qTfOebYo16HOxBwO9Hx/+fo+EHObzDrxXqpv/he8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791122541; c=relaxed/simple;
	bh=NCd7WKxp4kEGokTn6MRqfILIXz1WkJVMFd1/mOVBgvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uAZzAr6JOm2phv5CCLdOvUh4SYsh6iFhAusl05jAZ9IesbGxd+vrSTVOIt7fKY1PHU9XiaAp94y4zuTiBQI45o7SKsci6zFdo+lYQbSZ1oEycCQW6UGlStvWLnEoKhul5OIy/krLxQewxsIcYtU7K1SUMmbIWnPr84SPmTtLJQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jsJLoOnh; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jsJLoOnh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9krPyE+nzTcrlIqOOt26TStIvtj5wmE7mm8cI0Pgd0Y=; b=jsJLoOnh64ppg4+FmkbMDibK4J
	KdhyXoTriwReAHKd/vNNW+DaiAiSEJnBAhMFAzRye3fIacs4XU4sj39zN9GQr3UvzItYaj79Kt1hI
	CvM1n33Ogro7kTqzmrk58Ou8CJbgqZQL5bSdXIKdkG3lqHpY+PnJAbJEmdPv0UygyyZM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xDMn5-008sxv-Q1; Sun, 04 Oct 2026 16:02:11 +0200
Date: Sun, 4 Oct 2026 16:02:11 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/5] net: dsa: motorcomm: Split TC module
Message-ID: <91eb4829-8c6f-4817-a939-4a56903a3437@lunn.ch>
References: <20261001204851.2576101-1-mmyangfl@gmail.com>
 <20261001204851.2576101-3-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001204851.2576101-3-mmyangfl@gmail.com>

On Fri, Oct 02, 2026 at 04:48:45AM +0800, David Yang wrote:
> Move the traffic control code from chip.c into a separate tc.c, to
> reduce the length of chip.c.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
