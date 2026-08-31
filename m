Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5D7449ED6;
	Mon, 31 Aug 2026 14:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788186130; cv=none; b=sbUGxBg9YoljWkTRph9MNejVzu7cba8M4kzgiOjzyF7bKxYD7pjbKHSwPpLAHoozuMENZZN1OWptf16WXaWDDvaNZVI1ywR63UQC69t9QTcAzznWwxJFKfZGtWl0Q+YLtnwfUpTC1+Hdw17d+JHjwg841JHfvvSsc2JeOW4GQfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788186130; c=relaxed/simple;
	bh=tXGq8JMhxpBPrlNFl54ZrihpYKeb9m033nNmbHbzD9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z3KcuaeSxMJSXTa8heUfGrdxHqeISVS/pJpm+rc8OJeq9jOuEoti+YRKh2tN2Nqob4ffgKXxAdl15XvLEh9w+ftqY8r5CT7RktDiGvc7FHhZSW6MiMYGwP1c524D5BRG0JtzsXLWiuvIcRFi1yzmXXjgbbFbV6uMZckSexxnzZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=PKWGopum; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PKWGopum"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=83SKAEBeaGFMRisqoTdRA8CQOEJpXaFCGLaBIwgScvg=; b=PKWGopumWjVYa3rQpNAW0elFc1
	icCjjstTfb9GkujMhLFsvdz5Bm5NRt6bNqbv6rBSOOlt2rrj4nQDk+zr94luBfxzojyC65ioa0M+h
	Z6JN+0AtSI8RhX63kYeIFyoWAWhGep6X2ZEjMRyMW4bE9nPlq/JoL3TEyCd7Dt7YWzL0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x12tc-002CBk-Al; Mon, 31 Aug 2026 16:22:00 +0200
Date: Mon, 31 Aug 2026 16:22:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jianhui Xu <neuromoments@gmail.com>
Subject: Re: [PATCH net-next v8 04/15] ax88179_178a: Split driver into
 library and device specific code
Message-ID: <f1431e3c-edd6-4bc4-be6a-b636f4a127ea@lunn.ch>
References: <20260831-ax88179a-v8-0-de905f2ee426@birger-koblitz.de>
 <20260831-ax88179a-v8-4-de905f2ee426@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831-ax88179a-v8-4-de905f2ee426@birger-koblitz.de>

On Mon, Aug 31, 2026 at 11:58:53AM +0200, Birger Koblitz wrote:
> Split the ax88179_178a module code into code common to the
> AX88179/178a/179a and 279 family of controllers and device
> specific code for the currently supported devices based
> on the AX88179 and AX88178a.
> 
> Rename the module to ax88179 to reflect the broader scope of
> controllers supported by the module.
> 
> Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
