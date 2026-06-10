Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734AA282F2A;
	Wed, 10 Jun 2026 08:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781081019; cv=none; b=g7H36zcGH7FKxLB0702fHBKVk1109GyTqAcrAw03gfYuMT8uqeJaeTj7Ldud9AG74TW12clsDeKmJ0dmPNorJs3j+q4seyJXVMOoqyEm0vfB2ug+QfCsNaRqGRjncw1biy2fQAwE/BgDGo3788WNN6VnJZxmlAzWuDWw0NaW2IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781081019; c=relaxed/simple;
	bh=qm7Qgy6L8rsnm7WlC1/GCzxrBEqRt0IVZmohh9F1DUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oDATzVQt4bzbNsUria2SbGTQD7jXWhUpPlsM/ccgfyy8OelIvBMNgRWvmlMe4qarS0KQQCsakA4rKbB8mxnTMGyvqru6tnUtg5WxxEXLl5VZ/5pUpHs+fjEijbDwsrIoYlryrXDKG1RtCbBRnOl+HJgT3moZCmezJ32eGy9ud3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=oufPKAbJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="oufPKAbJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jXIaEE+UUEtt+5iKH+FbKURjMTIVOGgJjDprTGfFmNc=; b=oufPKAbJv/9xyv7ZP9pjWVtY30
	sxIe6D40uk74Au1zodpLZjpYmr01RpKcvdIrmuUudsVZKrUq8uZfthkFIqCYJY1n12g2KmscrRbgf
	joKHRaY8rJ4ICjBjsC8rCpInBw63+yqpvTgfG+03hl+nkw1weVNGBx+zYmUE3na/Wez0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wXEX0-006wyg-Od; Wed, 10 Jun 2026 10:43:26 +0200
Date: Wed, 10 Jun 2026 10:43:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Johan Alvarado <contact@c127.dev>
Cc: netdev@vger.kernel.org, linusw@kernel.org, alsi@bang-olufsen.dk,
	olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/2] net: dsa: realtek: rtl8365mb: add
 SGMII/HSGMII support for RTL8367S
Message-ID: <4d6e9d64-2a01-49be-ae2d-e4455ef63761@lunn.ch>
References: <0100019eb0b1822e-ffc5626c-1b9f-4c8a-8a1a-759a9e665f4f-000000@email.amazonses.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0100019eb0b1822e-ffc5626c-1b9f-4c8a-8a1a-759a9e665f4f-000000@email.amazonses.com>

> v2: no code changes. Resending the entire series because the SMTP
> provider used for v1 corrupted the mails and patch 1/2 never reached
> the list, leaving an incomplete series. Apologies for the noise.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

Please wait 24 hours between patchset versions.

       Andrew
