Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDAF44331E;
	Tue, 11 Aug 2026 13:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786454100; cv=none; b=fdhnbNt62f3lIdr48cWOpiZIHRejALyQKBR8ozoOZo1540t9WBkm+X/mbvu/ne9KPa2WMgJdx9FUlrsmCHxo04r54+UOu3rGuYO6FfW9OZQ/mXnVcHbxwS3HuhoY71U2cCd2Bx2OT3YW/RVlEOShbi6FleVGjQ0wqMV/yKfN9m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786454100; c=relaxed/simple;
	bh=S7FRhNitoEtV4TO/HFHinokjgrtn8fyv2bqew1kFrmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sf1Nt9T06mguhWbIdMa0To5VbicNqpZ41MYfVy9/NaSj42R6M0JrGpTtbnKVgjUW6a6QF7qJHR364kY9LcCmv3uYi+32qBeBcUdCe617GCM/fb9BuUWy/3zS2+Oiee1eTLdx1wxuy64kaM0w0fnAVkmB020jLQF8Im+3YZ/oq6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=H/DYzcJ6; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="H/DYzcJ6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JWbpkoLGAkUzuTBUwUUawFS+dlA9P0+DrUN4qtnP/Sk=; b=H/DYzcJ6NbH+HF5/tdxFsSjpuP
	kolrTY0zwfNfGCrhhoy9BqPzHucxEd+NXdbQ3+4C0llWT3TYrtWLSy4UjHYgsZoVIkOYL/sanURto
	vOSGvQvikA05sa+klTWZHlU2ez+LSeuLcjBJ6f1AwEOsugQ2Vp4jSfo+vXomB2N6vgQB0HMXdwfnK
	Mi3OofVmk2LUF+QwETIpxqV3TWNjHf+4L5BQsZ2MvGZIMfn6LvRndyvPna+OZvoCcAmF17k858Qua
	gTW3I6XcR56SnZ7UroWPz5LQklfoDujZHtg3fpMD5kxplKd1MpZc7K4+Z3xXaNVitiZ4zGEKv2Vqh
	xp365rIw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wtmJg-003aU4-2K;
	Tue, 11 Aug 2026 13:14:52 +0000
Date: Tue, 11 Aug 2026 06:14:48 -0700
From: Breno Leitao <leitao@debian.org>
To: Gustavo Luiz Duarte <gustavold@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/6] netconsole: use the address family
 instead of the ipv6 flag
Message-ID: <ansfpqRSBvmMJEJi@gmail.com>
References: <20260810-netcons_ipv6-v2-0-3d4fc987a90f@gmail.com>
 <20260810-netcons_ipv6-v2-2-3d4fc987a90f@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810-netcons_ipv6-v2-2-3d4fc987a90f@gmail.com>
X-Debian-User: leitao

On Mon, Aug 10, 2026 at 05:47:26PM +0100, Gustavo Luiz Duarte wrote:
> Now that we have the address family in inet_addr, use that and remove
> nt->ipv6.
> 
> We no longer need netcons_local_ip_unset() to check that all bytes are
> zeroes, as that is now denoted by (family == AF_UNSPEC).
> 
> Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>

Reviewed-by: Breno Leitao <leitao@debian.org>

> - * Test whether the caller left nt->local_ip unset, so that
> - * netcons_netpoll_setup() should auto-populate it from the egress device.

This will change the behaviour when a user setting an explict 0.0.0.0 IP
would not have auto-populate (which only happens with family ==
AF_UNSPEC).

At the same time, I don't think this is a big deal, but, I think it is
worth getting this documented.

Please add an additional patch that would make it clear that, if the
user passes an IP (even 0.0.0.0, it will be used, and auto-populate is
only used when no IP is passed)
