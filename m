Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BFD4FDA48;
	Tue, 22 Sep 2026 07:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790061144; cv=none; b=ulbWSrZxXI2mXPykRwH/NLEJVWIL3y8IZfniT7pE/fX3JNNFUtoRnhO16wOs1jLPTWDFD/KeZXQYlMGcyQ16PI6ECEEnPCJtwErBAz9uGveodYCh9O80tAkfdRW5FKwzaGqpZEEuy/XAe2wha2l4b2QpL+1fcgaFD1+s3JAfP9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790061144; c=relaxed/simple;
	bh=J7bgjlWHfD35nAuXdrw5wqnQOzUKyrdR7uwwIxPzLRc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=nJczIGQpuzAKldqB8K6Wo+XmCowl9ayElC1+qX1/T5fXtLomDg3rA4I19kDp1fS2q8rxMWKbk0irfAINhAGGkPkBQGWQKuKPY9oESN35n05V+CMjqIGDN1Uu6YRTU0KUDb94d6LBwm3L13puiXBFA9j1dJBVD9WjuyrujKyBFww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=MKmd26Fr; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="MKmd26Fr"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C8F94A4A34;
	Tue, 22 Sep 2026 09:12:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1790061136; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=o2Dvl8LriDs9c3eda7doL8EwSK7ODoJenHR1YmSNe4A=;
	b=MKmd26FrzNVo/twqZl4H8Aut4kR3D4mhaxSq6q4l071V8gjU+2XGLDstzKgJY2/8w/SB+o
	4HaYGI5XRLjUcJAuEOCIx5PFh7jf36AV0ONjw+JbCLJzXwJomiVucMEMUAYQSp13Dv8VDF
	BX4EIKPsdM5i3ApPbVS70xbYVK2qAxArjnwarueTx+RQthGBjymYKH/NIjAS+KGFSf9on1
	YQgxVi53WihZPmUOgOsFJKYD3foa9EMCbW5X5rYRdh/Jgwg2QuCQS85sSsAFASfABsp4NP
	Z+pl3tg+OxzV/WslEiYjLSMPVSyaztQFg58VW9CQ5cwyha54qjC5HFGtddeC6g==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 22 Sep 2026 09:12:14 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev-bot+sashiko@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, richardcochran@gmail.com,
 kory.maincent@bootlin.com, vadim.fedorenko@linux.dev, jjc@jclark.com,
 florian.fainelli@broadcom.com, opendmb@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: don't require the hwtstamp NDOs when a PHY
 provides timestamping
In-Reply-To: <20260921163746.5d5d0070@kernel.org>
References: <20260918095540.34286-1-nb@tipi-net.de>
 <178998466913.2160803.80702009306181180@kernel.org>
 <8037c32ce6fef79a74ee56973bf185c2@tipi-net.de>
 <20260921163746.5d5d0070@kernel.org>
Message-ID: <3663f91fa60a78f8eeadb6983cf0d70f@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 22.9.2026 01:37, Jakub Kicinski wrote:
> On Mon, 21 Sep 2026 12:23:37 +0200 Nicolai Buchwitz wrote:

> [...]

>> No, IMHO not here. It would change change behaviour that never worked.
>> Thus I would suggest fixing this with a follow-up to net-next.
> 
> Not sure I agree that it's separate but whatever, I don't want the 
> ioctl
> fix to miss rc5.
> 
> I'd prefer the netlink fix to also target net, tho. Netlink
> functionality should match the IOCTL, targeting -next would put user
> space in an awkward position when deciding between the two.

Ack, see 
https://lore.kernel.org/netdev/20260922070813.1458713-1-nb@tipi-net.de/

Thanks
Nicolai
