Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C191A681B;
	Thu,  9 Jul 2026 03:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783566774; cv=none; b=Xfcjm2N8eNvDKYZzrpux/3oncPxucCl/PR4aj/X+AiPgaiMRZvkQljJambQtgrqEeJ0PUIsI9cZ3ah/iOpeXtv6siUdNgH676mnFv4gvhdb8SQQLqbqpUo9mOnem33leFsDuX2rTdKkZWyI8od8APUwvMOPE+BMpqKHWvUCjV1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783566774; c=relaxed/simple;
	bh=Py1ascRdEQCaAhvnW0cwmGQqqd9p0/llQq263Fch4Cs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jr7I9wjc5WOY/Ub0e/VkycycqgMg9a6FSIvE7DpOt3dGYlOT3TlkwR5e+K5JIdtufmBTX5da4vVeqkCes8tF7tnwIS9uJhoqvT2XdUK8TjlhoPR3rYnum9w/i+N5MiXD/bnujmM2rkFnbwxQBIc5ObPj0gpfIsO7r+/c9qQyiAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=DTd+yNxI; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="DTd+yNxI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1783566771;
	bh=Py1ascRdEQCaAhvnW0cwmGQqqd9p0/llQq263Fch4Cs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=DTd+yNxIx+wW37HF0K6xYv/L/RO4C53gp2auksXCFiYATZ4+HoMrIlG1Hk7isJMrc
	 jRx2FtzhhOpl92Me3UmW+VJgfJC/3lZ1QSjqYewo9vRLBqzQpsVr8juc/stgPCqzlC
	 ihnbWwv3ygBi4ZVuNF8Erw+pJ4VLZ0XnaKWvI4cZcJ7GKtRwfqJ1FaZwMVUc/TTbq2
	 MWkoqwb4Cs5tjDDx4z2+GhZKMIpUfXCF+cQmCDtjbQHr1iVnmVjDJdSCNb0D17gWxf
	 Hqd4tphCP0N4vXsJh97UEbpEUEcKwoPrzPY1fWnYXz+W25bKVQD3crlJv7AdD36q3Z
	 fwKZT9JAWgwmg==
Received: from [192.168.72.161] (210-10-213-150.per.static-ipl.aapt.com.au [210.10.213.150])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 888F866358;
	Thu,  9 Jul 2026 11:12:49 +0800 (AWST)
Message-ID: <aa92796bc2dce8098c5e8174b163f1949a748c58.camel@codeconstruct.com.au>
Subject: Re: [PATCH net-next v3 04/12] net: mctp: usb: Improve IN endpoint
 status handling
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Oliver Neukum <oneukum@suse.com>, Matt Johnston
 <matt@codeconstruct.com.au>,  Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org
Date: Thu, 09 Jul 2026 11:12:49 +0800
In-Reply-To: <2a0bacab-951a-48b2-8263-bad3088a29b7@suse.com>
References: 
	<20260708-dev-mctp-usb-1-1-v3-0-9e710155cdbf@codeconstruct.com.au>
	 <20260708-dev-mctp-usb-1-1-v3-4-9e710155cdbf@codeconstruct.com.au>
	 <2a0bacab-951a-48b2-8263-bad3088a29b7@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2+deb12u1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Oliver,
Thanks for taking a look.



> What allows the assumption that mctp_usb_open() does not race
> with error handling? What happens if the device is still stalled?

When ndo_open is called, we know that the delayed rx work (which
performs the usb_clear_halt) has been quiesced, so aren't racing with
the actual recovery.

The device may still be stalled; that should be okay though, as we'll
detect that through the subsequent IN urb submission, which will re-set
->clear halt and schedule the rx work to do the clear.

Unless I have missed a case there?

Cheers,


Jeremy

