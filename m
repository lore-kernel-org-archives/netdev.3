Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7292732AABA;
	Mon, 17 Aug 2026 08:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786955590; cv=none; b=kYtb/oLupqJa8oz101mduqinSnrMqWIb6gkiAlC9RoT6sPNVKQEOL3NJw/APPUDUia21lOhR8cgqFg5lAfIPZn415X0dsQhsX1XIqMxck5LH+UDG6l7mZE0egv7/hF33YCz+hof3/MFCdTFFSYhQ86Q6zHkgJgcZkGulAj0+MFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786955590; c=relaxed/simple;
	bh=I7FZf37jBGeHkHtIo8wliYrhutck0dZq9aTGX6Gtf0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jr86K82mSTFU5C4OEGA2s2sJkGRUm0LNCr+730UGAy+2Pp14A4B+3GzH5TsEYgr/mE2CIPtrzSz1/7NExUqTsw6YfCSUZhA94N3KhOgVa+LPfEAzJ2kzeGcLwXubycNddcuV2/VmWZZzYqVV8+WymZHqWuM/gnVex3gep6Ivcjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=kITUFup/; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="kITUFup/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=axpIj2NM5kg4OjjcgeHpteDzEE3Y9bWGjvH/o1purSw=; b=kITUFup/SbOt8H9AooW3c7orNt
	hBWDnAjq91ClTdT0YZKxlME4gVdWnjMJ0Cj0UBsdl3BV9DJc2bNtprtcpHYiEwQVW+Re1z4DvF94X
	OvZZx/4chvRmRxyBWfxGHNj0RUdEbrqi7bMg++rrR+OEJS1tQKmXAIf4e09rw2+noeX9DUDZVpoLD
	d6qN4ug2my4L0rlY3IVp0HBi/NHqCbG2AAakxxFUf/WJtdQtLDe8v4jFncyqKCpQIWeiG0UXh2lmm
	gj92eEOvg5MgXWFslWdy1W5EJOBAeSrC5/6G1Ub3aL5Np+Hwc/NM7K5V+ddQG+v9XvsvgZWcjDy05
	lNzqrdpQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wvslz-00865N-2M;
	Mon, 17 Aug 2026 08:32:47 +0000
Date: Mon, 17 Aug 2026 01:32:42 -0700
From: Breno Leitao <leitao@debian.org>
To: Gustavo Luiz Duarte <gustavold@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v3 7/7] docs: netconsole: document local_ip
 auto-selection
Message-ID: <aoLHH6AMEWKFYHfh@gmail.com>
References: <20260814-netcons_ipv6-v3-0-bc0915e8c75f@gmail.com>
 <20260814-netcons_ipv6-v3-7-bc0915e8c75f@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814-netcons_ipv6-v3-7-bc0915e8c75f@gmail.com>
X-Debian-User: leitao

On Fri, Aug 14, 2026 at 08:28:58PM +0100, Gustavo Luiz Duarte wrote:
> An unset local_ip is auto-populated from the egress interface at enable
> time, but any value the user writes, including 0.0.0.0, is used as-is.
> This deviates from the behavior prior to "netconsole: use the address
> family instead of the ipv6 flag", which interpreted 0.0.0.0 as unset.
> 
> Document this so the distinction between "unset" and "set to 0.0.0.0" is
> clear.
> 
> Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>

Reviewed-by: Breno Leitao <leitao@debian.org>
