Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF7F368D47;
	Tue, 22 Sep 2026 01:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790040218; cv=none; b=u42Zi3XFtSpUuvXhULY1LKdb5JT7gP9zkQgaa+53n0qM0LYKPG7peRqvykxpHXAv1S6I6BwJ13Gk/Is3iek88gf0kKkCcZEp5iYpoLcTYkLA7QTdOoM2Z3vwiKmyX+EIZWXl8/YOwi15TN7wEXsGgMAXskJ3sE7JBqIkD0Zcono=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790040218; c=relaxed/simple;
	bh=5BuBZZnK32r8ACboo/WQLjtGC4RMRIxwkfQhR2RTwZ4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pvIMk/bd76nZgszmSiEi+PS8G/ghBybJUMK6QFZJ0ENcx0MYW9JKu83dXe7+o3nBLq51s1UwBGxcThwTOr8srilC19C5SYEowX0BDNNICz/cE691k/+ANbuWLf+IECXZ37NTwSw2x33mHqmXTTPK1iIGMVK9GgLXkqC0LN2VLwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=St91aZH0; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="St91aZH0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1790040207;
	bh=5BuBZZnK32r8ACboo/WQLjtGC4RMRIxwkfQhR2RTwZ4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=St91aZH0l7sHl/hP2szhVQYa+WtEiW58YnWbDwsCnqp4OWBW8RbsgdImRUUYZlcAr
	 yq7q4O0XJ6p3NOBxXBC6p9h3K1DYhVeV/cMhWEYpA5vMH9Pyd1gvKwHvqGuaukFK1+
	 6qBuk6zC7mRpfWDhpf4WHQ28sNQnRCq1I/hXqEBTgQLbfn58Xa3WWTRz6/ntcunsGh
	 0BYxnncZLeNNawRXWaKiK7DuxKY0N+n32HGPH9Wb/n3p/3JKdEz7uM1GAtvTkk5lhj
	 t0jmy3x+CzgIapVlugCHMsHzvdB4yWY+xcYTJakR40Uc2r15JfWwjSyXSiqbtu2dVk
	 JWV+sWcIzwnrA==
Received: from [192.168.72.161] (210-10-213-150.per.static-ipl.aapt.com.au [210.10.213.150])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id C71106BA1E;
	Tue, 22 Sep 2026 09:23:26 +0800 (AWST)
Message-ID: <e272f7d7556a59671db7e4c5503eb69efc27759c.camel@codeconstruct.com.au>
Subject: Re: [PATCH net-next] net: mctp: add MCTP_OPT_ROUTE_SRCADDR
 getsockopt
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Faizan Ali <faizana@nvidia.com>, Matt Johnston
 <matt@codeconstruct.com.au>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Jakub Kicinski	
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet	
 <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, Simon
 Horman	 <horms@kernel.org>
Date: Tue, 22 Sep 2026 09:23:26 +0800
In-Reply-To: <20260921035118.1649687-1-faizana@nvidia.com>
References: <20260921035118.1649687-1-faizana@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Faizan,

> Add a new socket option MCTP_OPT_ROUTE_SRCADDR that allows applications
> to query which local EID the kernel would use as the source address
> when sending to a given destination EID.
>=20
> Applications such as PLDM need to advertise a local EID as the event
> receiver address to remote endpoints. Previously this required a manual
> multi-step lookup via the mctp tool (route show + addr show).
> The kernel routing table is the authoritative
> source for this mapping, so expose it directly via a socket option.

As I had asked earlier, can you elaborate on why this is needed over
choosing any local address? Is there a routing topology where this
would not work?

I'm not against the idea, we just need a fairly solidy justification
for adding user ABI that cannot be changed in future.

Cheers,


Jeremy
