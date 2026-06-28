Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AE57261A;
	Sun, 28 Jun 2026 20:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782677835; cv=none; b=VwgexujJXbZ/+47rLgWiEGqt3SWxYIB0saPjoTK7Sn3a5ZjlI4+eoaI0I+hxoVdVP2Fn3xJbqOH7Li/ocgjWVkv0Vd246GZiRWHr6nGpW9V0QHgX3A2qtZmqJ40GByM32cLpQsWANBHy7HFjuM0HQquSuF9nOPLktdoQIsEyOLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782677835; c=relaxed/simple;
	bh=Tyrojh+Ry5SrKrM4Hs0/AbwiTJiH0hRsB1H4ojTBA6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oVoGSJTlElPRXXg+jIAk6QNDgx/4dMqYN8F42+nE8hFhs44dKzmlFOtl8v2736MI2Hc+mh/HfiZFAyq3c/hqYHGtw/GEKces3GEnqJ1ATwPmgOgIhPr0X3g/bOToRCp+hheTCUjhLu/1L9Vq4Mtdyxi9xyJVIEZhL6+bau0lfgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3tTAyZPe; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3tTAyZPe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=tYNzotMCRfgXnZa1hVuLqb3Rqllfsw647eNsTBuJtCQ=; b=3t
	TAyZPeET1DN7DhGUIw4G30L5pR6EkEoXMEhpfO43p0Y7xyIv7esFMU569zwW59dEYgb36Hm5vb8Ab
	z44eNOUM9UmKmlDeVv399sYKwG8i7qHUbFZQShoTvsX+cTGmAVVg/e5ERIa6ZTqRwVGrdC+P1FRcb
	sN6lvFOg+ZG6mo8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wdvw6-009e0n-Fc; Sun, 28 Jun 2026 22:17:02 +0200
Date: Sun, 28 Jun 2026 22:17:02 +0200
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
Subject: Re: [PATCH net-next v3] net: usb: rtl8150: handle link status read
 failures
Message-ID: <bbc962f3-8cce-4bdc-98d5-fee2e3e0f414@lunn.ch>
References: <20260628165033.17842-1-alhouseenyousef@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260628165033.17842-1-alhouseenyousef@gmail.com>

On Sun, Jun 28, 2026 at 06:50:33PM +0200, Yousef Alhouseen wrote:
> set_carrier() ignores the result of the USB control transfer and tests
> the stack variable supplied as its receive buffer. If the device rejects
> or aborts the request, that variable remains uninitialized and the driver
> chooses an arbitrary carrier state.
> 
> Leave the existing carrier state unchanged when the link status cannot be
> read. A transient USB error should not be treated as link loss.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

If it is for net-next it does not need a Fixes tag.

Please also note that:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

say:

* don’t repost your patches within one 24h period

It is a good idea the read that whole document.

	Andrew
