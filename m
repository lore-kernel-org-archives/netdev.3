Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE66E2F549F;
	Tue, 30 Jun 2026 13:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782827313; cv=none; b=OO32DOhX0IrNTP1qzD5m7dmGc0nQ/zDnFZqGrxawikXgxiPhOM6ipsTgI5Wm+yH/Jv4nwSOuOmEOmMLnGmYsoPbFCuoXX+MYcIFXap7ve2RKUcP6YRgcbQS0oSl2Sp3Lxb3R/406Pjk7pBteodUWEhWKKFj4K9ClJCDBro+i1IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782827313; c=relaxed/simple;
	bh=TonebF7Ag32GOyOJMqqlwc8e8lXlquoAPTTINlV2joc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PbVRethvFU2CfHe37nB/lq94QgbQArrz8b494eojdCVhJZEK+px4k5/sf0WNhL0xLDR/iQANLIKcl+wM072RQK+FnmvKJlVUxs2iUwfpQeF1XkBdVUPOVcpYlUs/oJARckgjjl/hlBP+gkwybMKQKCTASBljaCA6Q+O5B2RIuiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=D0LTzYUY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="D0LTzYUY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/wA5uNWt6gB7JZ5iwu/IO6wZKMVB6pWC14dthf5YOGA=; b=D0LTzYUYJSQhbOHlkEmQgOV1Pr
	rFAitysvqjixjc/kDLrZXlv16PJ7VZwrjSPFeycp5i2syZJwkCsmeuPAknZFP/nK6T827x/e5WKsy
	GvD3efgA2XwrWhtWRz+kl63THBUOoX3TEJQbMDywpcoySg4Pdpv32s537s3LWSlQm+zg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1weYot-009z3M-FY; Tue, 30 Jun 2026 15:48:11 +0200
Date: Tue, 30 Jun 2026 15:48:11 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yousef Alhouseen <alhouseenyousef@gmail.com>
Cc: Petko Manolov <petkan@nucleusys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+9db6c624635564ad813c@syzkaller.appspotmail.com
Subject: Re: [PATCH net-next v4] net: usb: rtl8150: handle link status read
 failures
Message-ID: <355409c6-0b52-4dd5-9b0f-bdb72159ade4@lunn.ch>
References: <20260630101216.10365-1-alhouseenyousef@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630101216.10365-1-alhouseenyousef@gmail.com>

On Tue, Jun 30, 2026 at 12:12:16PM +0200, Yousef Alhouseen wrote:
> set_carrier() ignores the result of the USB control transfer and tests
> the stack variable supplied as its receive buffer. If the device rejects
> or aborts the request, that variable remains uninitialized and the driver
> chooses an arbitrary carrier state.
> 
> Leave the existing carrier state unchanged when the link status cannot be
> read. A transient USB error should not be treated as link loss.
> 
> Reported-by: syzbot+9db6c624635564ad813c@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=9db6c624635564ad813c
> Suggested-by: Petko Manolov <petkan@nucleusys.com>
> Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
