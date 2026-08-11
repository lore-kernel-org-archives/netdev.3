Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483F8443A9D;
	Tue, 11 Aug 2026 13:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786453924; cv=none; b=ILkkzqpGfQvy5D8tLYlXGDmM+rHasjiqclqjD6uoDJw/Su+j8XNXHhfuSGBrG4Zi7gG1g4Vbj2AwwP3iYfWjJwt50Y+K5HAK10G8PzFLrqryZVJyupdexvNMTHvAG7+JeKoBkY/EyEuha7jtEGQKhS475q4c4XBx9Itw+svuybY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786453924; c=relaxed/simple;
	bh=RjZZ2yCni2PMSeTIf5TeX6diZAMIl7qfOCDGmZsVn+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kEQSZYzo0edi5V6PLx36PMqIYLSHrQkkSkDD2mJf/2iwU3K1L9H5TlKmEVyH2oyNDYYhP77cK1ZfQv2VFabv/a0Ko5yfz7NVDLORxi9X7sWL5ug6cEFGbiQBBmfbdIhNartr8UPGizWCcAIpsGAsyORUZw5Vg89+3prifIRKYAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=EK1NqaTw; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="EK1NqaTw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=psQpiW8vFmThWD8MlC5BR+ZqAcAhux0yCCpapRRC7Rw=; b=EK1NqaTwBWMehnj6/lHnLcG5UW
	akc9d+fifvlXtvyLQKDSDKkrBhE54t9NfPyEt+iaGeV0o7g+TgFqbVncCq8FOc8pQHczPfAo51hov
	vQQIr5w7c/+trVokfDbjkoDnhiGTcN9slqR0gmuri1TQFTbzneEPAEi27KmO8J87+dZG/qXtZJm8s
	t3bVEzwqJQFjOuHPSXtP6d+KmMY1d07JJoCrEZFoGr+x3CkIiZSdN1kJ05G2BzZLMlqY9lNOBzvU9
	I8+2sqBiXfE/91hyD+m0cvTDgpp1EJIzb4pf6kVhpnlbsKzf7W6xMy5XI4CTzE6DIAby3KM6T7jcn
	aarrmq1g==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wtmGo-003aLI-33;
	Tue, 11 Aug 2026 13:11:55 +0000
Date: Tue, 11 Aug 2026 06:11:50 -0700
From: Breno Leitao <leitao@debian.org>
To: Gustavo Luiz Duarte <gustavold@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/6] netconsole: add an address family to
 struct inet_addr
Message-ID: <ansfiT014RsCOJNZ@gmail.com>
References: <20260810-netcons_ipv6-v2-0-3d4fc987a90f@gmail.com>
 <20260810-netcons_ipv6-v2-1-3d4fc987a90f@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810-netcons_ipv6-v2-1-3d4fc987a90f@gmail.com>
X-Debian-User: leitao

On Mon, Aug 10, 2026 at 05:47:25PM +0100, Gustavo Luiz Duarte wrote:
> netconsole_target stores a single 'bool ipv6' to denote the target's
> address family. This makes it hard to detect conditions like "no address
> set" or ipv4/ipv6 mixup between local_ip and remote_ip.
> 
> Add a 'family' field to inet_addr so each address stores its own address
> family: AF_UNSPEC while unset, else AF_INET or AF_INET6.
> 
> Nothing reads the new field yet. The next patch switches the users over
> and removes the bool. No functional change.
> 
> Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>

Reviewed-by: Breno Leitao <leitao@debian.org>
