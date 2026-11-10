Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794321395;
	b=vNTndBgCpwq/BFEO+tZJNMnFz2zySIkUzUZEAh47yM+9NmIxIGQLIRcYV2Asb9UPc4M+
	 Jy5tnLTwAZhlIPXPxfJY4mEDIHWT0otqs2+lZ9I42W3CiSnOX1zoG4JinH+5JqMb19ClN
	 cCXHtaxNfeYSpgZ02AYYbgTO/IG1lTDhDO1NJT16QEotRYtkUT+q7sPUk6kSmpZI6jZMp
	 Bh3BuToq3aMOuJVufe8Q78dSGDZ0QEIeJJwXD2EChKx/Rw91cCZqxdUHfGyEwE7htjiS3
	 BhRGbzq2iSTECrbmnlVBsx45VXeUJET/LFZnl4wBVn1dk/tRHSRJGm5LVpnFo7Zx8gA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794321395;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=oEHOu7Uiw00HdqEly/gqNHY0gfh2SsyPf6lrcfakVD4=;
	b=hhQUiA0cI99QvX/6gjBCl7qFYZojt2WJzLLpiMgNjvGXp6B7qDq3OCXpZfszt4wJwZwX
	 pUXTkPdqDhPPL0/jeo/Adu2irHiG4mjHo1oXpglZ4LyIQm/8HVJ7g60Mi3+qqr/L/ptRM
	 Ur7mUAkUvViBbrZ2z0I0PrltYfWJ6cAHY+8uSSPFIEipXpn5E7Ftv7DHCNK+dX2PqnUXZ
	 +E5WomAV1HLakMAJpxgOigNV7QMMrql0c0AkLK+7xXtXe1zfv07hoyXcy8bGmfSigL8ti
	 abnmSg3SUqo3KXnFFwlo3FSRDAErz14KCIzueRhlPZer+yuBsHcw3g7lHcaLAcov1Wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=rrv5jKyC;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5E8606A31C;
	Tue, 10 Nov 2026 14:36:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F5E8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=rrv5jKyC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=oEHOu7Uiw00HdqEly/gqNHY0gfh2SsyPf6lrcfakVD4=; b=rrv5jKyCH+FkL0BClHQEwfqS8H
	C/DbaWhUDX+x71dULa7QnpdokGoEjRaUKgzUHZZI0wuHRxZ0FQObHv0X5BKDUIyejQBMnjphha8eP
	0+kPjynmZWQCg/E0r0OZo0NxePr7gxlygWegKwygPNjIhkRRDfUUOMiJUZxL7VWGjyjw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xQmxS-00FVJG-Ro; Tue, 10 Nov 2026 15:36:22 +0100
Date: Tue, 10 Nov 2026 15:36:22 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: netdev-bot+sashiko@kernel.org
Cc: kuangkai@kylinos.cn, netdev@vger.kernel.org, olteanv@gmail.com,
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: dsa: user: document the write memory
 barrier on LAG conduit migration
Message-ID: <5e7d676a-9c02-409b-9312-57bae6c0be63@lunn.ch>
References: <20261109120607.344544-3-kuangkai@kylinos.cn>
 <179431548491.994134.1097968032701195124@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179431548491.994134.1097968032701195124@kernel.org>

> [Severity: Medium]
> Can the wmb() in this position give the ordering the new comment
> describes?

Please consider which is better: No comment, or a wrong comment.

If you are adding comments, you need to be 100% sure they are correct.
wmb() and the like are not simple. Do you really understand what is
going on here? If you do, please respond to the LLM indicating how it
is wrong.

   Andrew
