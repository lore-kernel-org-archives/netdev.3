Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4774813A86C;
	Wed, 17 Jun 2026 09:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781687997; cv=none; b=US1RV1mzHXKLWSJYfO7QZzn7GUTgLbUOgJNWf9MN1mrWBVQxuk+vSHoxDS4RKQSxPXWATnIGzHTOGbv8Yao6GrJdJnHcCM7eYVvp2JspOP5OgMemcZe0QSEv/sP/NE+Z/LtBt2Bmayqy0C8N8DEC/NsO5cUUO2AIpOuVjVX24R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781687997; c=relaxed/simple;
	bh=yPW0/gGgJInFWTDT1Labb4HnGILlEk/0Iq+1T/Whwo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d/r8QBBL/RIRCIGEM6nYOG2ovO6am7q2YNesr4t6GWKKZkQJXdEG490ru48VbBm9D3vgC07GvfiUkj74Qi4amfgVwHWL5eCNTIXWMDAZPIHNDTOCYUQ8a28AwZfcmt9J00yi0pV+PPdc9iluWFH46pRCmqcMVhTqO76Qi+b1Nvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=X7UdkVk7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="X7UdkVk7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KF3jViJ8RV1au3xZmPm/2f7q1mQz98SWnSozj/8FwZA=; b=X7UdkVk7H+72Dgl+jLszPNvht2
	oLlcCM+SRixL9VfBfVw3W5IKcY5hWWimyjRolYZ1YdIIsvTYMti/NVI8jAWIbVzaEiwwJWU+VbVo/
	Gf8I+0bsLbWYCGAzZq9m1H1MJI84Iolq5iMJ8aCgKoioNN9TF8kolu3BHW+Pdnds+aW4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wZmR1-0089gl-9Q; Wed, 17 Jun 2026 11:19:47 +0200
Date: Wed, 17 Jun 2026 11:19:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: mmyangfl@gmail.com, olteanv@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
	xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com,
	de.ge@motor-comm.com
Subject: Re: [RESEND PATCH v1] net: dsa: motorcomm: add yt92xx dsa driver
Message-ID: <ad636332-6678-48c0-a5a7-9c54b1ba720a@lunn.ch>
References: <20260615111235.3544282-1-kyle.switch@motor-comm.com>
 <3f7bf73b-c8dc-451d-981f-5e5343291960@lunn.ch>
 <adc1dc4b-1d9d-42e6-8983-f0a7c650a6cd@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adc1dc4b-1d9d-42e6-8983-f0a7c650a6cd@motor-comm.com>

> Thank you for your reminding, this patch will submitted  in a series 
> of small patches.
> This patch mainly contains three contents:
> 1. Underlying function interface for different motorcomm switch series in 
> the file driver/net/dsa/motorcomm/switch/.
> 2. Optimization existing yt921x dsa driver using common switch function apis.
> 3. New yt922x dsa driver.
> Can you accept break this up into lots of small patch according to this logic?
> if not, do you have any suggestion? thank you.

We need to see the patches, but keep them small, and add functionality
little by little. I had a very quick look at your first version, and i
see a lot you will need to change. So just post small bits of code,
learn from the review comments, and fixup all the rest of the code
before posting it.

One thing i need to point out. Linux has a long tradition of not
replacing existing code with a new implementation. You take the
existing code and step by step improve it. So i do not want to see a
patch which just removes the existing driver. I want to see patches
which add new functionality to the existing driver, doing refactors as
needed.

Please also remember:

MOTORCOMM YT921X ETHERNET SWITCH DRIVER
M:      David Yang <mmyangfl@gmail.com>
L:      netdev@vger.kernel.org
S:      Maintained
F:      Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml
F:      drivers/net/dsa/yt921x.*
F:      net/dsa/tag_yt921x.c

David is the Maintainer of this driver. Listen to what he says. In
time, when you have shown you can also can do the job of being a
Maintainer, your name will be added.

      Andrew
