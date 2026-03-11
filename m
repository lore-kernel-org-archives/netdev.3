Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CC11DDC28
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 15:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773241364; cv=none; b=jaLKi6l9Qv38/cqLbWgDlDBc8Ej67SCnRjqZQesVf+Tsn4rTt3YSToSQG3gk61zoPVfWIGwYzCCfaUHjTUPoByAtgJvWDAtXxl7XOsSKkxVgKgUxAvRFb166LOcaQC1+inCHvMYR98b5zas7Xdb3aYmfHUZn0IoTgpzBHvVwS0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773241364; c=relaxed/simple;
	bh=CLbYQe6+NrAMbeSARL38qDa6D17goOmlb9LYaTpFSFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VyhxTo/BB2ZV68QN8+iEkI/KbI8G/h6aqulqzFijPJ3xchxclJvX7IgIBKCYOhNbBe8OKN2QW0seaq4gu0ZvgbCWfP2jlDBA4PiuaGBi050ApiX6NHNfC0RxqX0K5YmNrqEEndcxtXNgX0ahRfDKp0PyNUgbPeFSkLFgoZB3qUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=pLpX491d; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pLpX491d"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=Qz1na5q5eqGMIp658btg+Q2Uq1yh32E6rIZIzFp7SXk=; b=pL
	pX491d+1I3V4b7RmLdEbrvpSA3ovW9OWXNeDY1xzJsuNmcvaltcvnmBmzq3avO2xmJktjSAwn3B/M
	+5NZTssv2i2IXqC815uK6E8LD23iLXWTfYct9I3wWezfB61v8ZXMjMaZszatGv9BJ+zfwBgApZ5is
	P3SXj672IFgKHtg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w0L55-00BCII-GI; Wed, 11 Mar 2026 16:02:39 +0100
Date: Wed, 11 Mar 2026 16:02:39 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: realtek: Fix LED group port bit for
 non-zero LED group
Message-ID: <2783b548-864c-4af0-82e2-e5e0a8fa6bc8@lunn.ch>
References: <20260311111237.29002-1-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260311111237.29002-1-kabel@kernel.org>

On Wed, Mar 11, 2026 at 12:12:37PM +0100, Marek Behún wrote:
> The rtl8366rb_led_group_port_mask() function always returns LED port
> bit in LED group 0; the switch statement returns the same thing in all
> non-default cases.
> 
> This means that the driver does not currently support configuring LEDs
> in non-zero LED groups.
> 
> Fix this.
> 
> Fixes: 32d617005475a71e ("net: dsa: realtek: add LED drivers for rtl8366rb")
> Signed-off-by: Marek Behún <kabel@kernel.org>
> ---
> I was just looking at the driver code ouf of curiosity and saw this.
> 
> I don't have corresponing hardware nor documentation.
> 
> But it seems to be a copy-paste mistake from early driver development that
> was not fixed later, maybe because the original developer had only a board
> with port LEDs in LED group 0...

Patch looks sensible.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
