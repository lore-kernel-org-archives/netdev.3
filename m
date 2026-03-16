Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9096030BB83;
	Mon, 16 Mar 2026 02:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773627842; cv=none; b=XlrMlX+HvMC6raK1U/W3I4WOVP8ZAvbMp93LCGxtKrRSRRvR9nD6QTFFEwVIYaPH0G/kA7RNzQPGoQ8GL20G7AZhDIJz3ZEsPYcyUIcp/mXW6Hj+BYKXNglIrOj8XRKVMnhSVfykJfj8YD7giD4V9uXBMmeswNUPtDHTtBTe1is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773627842; c=relaxed/simple;
	bh=sjky/WMSKWoZu6ymTAQU3dutImI0h0ZaU8LaKwTluU8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tBy8hd7Bod3HrsLftgUo0HcmTVHr2I9oiuM2ma0vAOt8jWHnc9s1agoY66gJu6T7tN1K9I/wFhjJSjvIAyWHB3A5qimjkPvyreLKIdMY39Tz5jVV5TQqFwXjUncHIt6f3oIZi7q8cBVpfO8u1LQh/0Mo0mzp0djiq+ZMtQUfSxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=EYdtOzK3; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="EYdtOzK3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1773627838;
	bh=sjky/WMSKWoZu6ymTAQU3dutImI0h0ZaU8LaKwTluU8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=EYdtOzK3Q+HJ/fGEWVWmx8Oh8kQYHUPfU8VLyOTHMp48lFZlm/XJMNIOaOxrWEFpt
	 9RXemVDltKg+BQkipZV0rjybhMCZyxtHkgAuqCg7PA5B1KHLjQFarlA3dJulCy3cO7
	 /SsYGosPty63R53wnHG3WrqrYaB/M/LPV0Zr5PANBwaKU65MtJkUy9Gze+Vjnt7Qwu
	 4vZG4qDJcwg6fDDqIEWy73namac5Zu2oLXyIPeo9qO47uecOl70sXgpWwC+EtJnvEX
	 mec0Yxn8bsSUEja2hz3EY6StLfpGVbltiwpOgGRJDHjPPLJWdRXYlOUGkPDCD6GFBB
	 bDmqDguH1CMIw==
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 6FEA960929;
	Mon, 16 Mar 2026 10:23:56 +0800 (AWST)
Message-ID: <81939fbe065bca0169b84198b9fefac5f188f4e0.camel@codeconstruct.com.au>
Subject: Re: [net-next v32 2/2] mctp pcc: Implement MCTP over PCC Transport
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Adam Young <admiyo@amperemail.onmicrosoft.com>, Adam Young
 <admiyo@os.amperecomputing.com>, Matt Johnston <matt@codeconstruct.com.au>,
  Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Sudeep Holla
	 <sudeep.holla@arm.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Huisong Li <lihuisong@huawei.com>
Date: Mon, 16 Mar 2026 10:23:56 +0800
In-Reply-To: <b2811dac-5bb0-4d9f-882d-a8b40e49a37d@amperemail.onmicrosoft.com>
References: <20260303213649.237851-1-admiyo@os.amperecomputing.com>
	 <20260303213649.237851-3-admiyo@os.amperecomputing.com>
	 <d0c4ad6f1a5b7ed4326e3b4a64dfe1f21042da3e.camel@codeconstruct.com.au>
	 <b2811dac-5bb0-4d9f-882d-a8b40e49a37d@amperemail.onmicrosoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2+deb12u1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Adam,

> I just realized that I am reporting the number of bytes sent including=
=20
> the pcc header.=C2=A0 I suspect that will mess up the byte accounting: th=
ese=20
> are being reported on MCTP links, and they have no way of knowing that=
=20
> they should be removing the PCC header length.=C2=A0 Should I be removing=
 the=20
> pcc Header length from the byte counts for packets-sent?

No, that's fine, keep it as-is. The TX/RXed headers are part of the data
sent/received over the transport so can be justifiably included in the
stats.

Cheers,


Jeremy
