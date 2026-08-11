Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6C82DECA1;
	Tue, 11 Aug 2026 13:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786454197; cv=none; b=kpgshTMhCdkyeAGSKiQyyXhCzQ1sXJqehE+Ao7SbZTSBcFQhvhn6DI+Bea84mkXpLdeo8+aCk2xISHcKzj0QvXflEX7mXXKMAodOwvK0ocaluFltqBxbXpWXXmcmUnk3KhHw1Qxqe2Geb6ppW84unJFCpzt3aBogDQI2ld5pycY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786454197; c=relaxed/simple;
	bh=JNy2Hx/fepk3RqsnhMinkiiqUY0ke/+SDON8dH4JN9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jNadZ7F5wuwgn/VKjjqRFeGqEPqjG2q8FwGBQKQtNZTBmJDQu61pmr5VX14+tZQfP9tCOs2BAwMjFtjX1jXlhdWax221GHqkLt5ykqCQBG1nvgefystWGkEMqsUCS8BsOyb2RinTuZb4yDVZHThj08/yBqYsBHvKhNmiPieRrE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=fhh0wqM9; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="fhh0wqM9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IhDsGhdaL3ubLtCH1gN0eAwKGsMmTdmTqfCwPgpf8AA=; b=fhh0wqM9AAaODH00nmXIZn1LAX
	8dO853IbMzmRbth2RZj5yYHoJ4wWiL3szfYN3od3CYaYFGGqKVD4K4f4A1kq1YCiabKL2uzcSsplx
	+C+EarqjS6EGpBXxi4ChnUn9nw2eke+KCZF1g0Dn2+MrF9iLK7hwcALhw5jx7LgoW1VMHSq+OZIwM
	zTJx2Jx+60Y/YX8hZVx6HW7zsWJuvaFwiBtizWunNpjBKpT71xy1IsfyZzIrTffuFf6nBqIUa2dMQ
	5suIg1ovczvRfnG4JlTC9gFGCnkvENKlFqAC5YRoYfTY1iymZtxnBFKicb+vkSrmXCobF+qeO5TMT
	INkEDS4w==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wtmLF-003aV0-2g;
	Tue, 11 Aug 2026 13:16:30 +0000
Date: Tue, 11 Aug 2026 06:16:25 -0700
From: Breno Leitao <leitao@debian.org>
To: Gustavo Luiz Duarte <gustavold@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/6] netconsole: reject enabling a target
 with no remote IP address
Message-ID: <ansgn22UpFY46qIA@gmail.com>
References: <20260810-netcons_ipv6-v2-0-3d4fc987a90f@gmail.com>
 <20260810-netcons_ipv6-v2-3-3d4fc987a90f@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810-netcons_ipv6-v2-3-3d4fc987a90f@gmail.com>
X-Debian-User: leitao

On Mon, Aug 10, 2026 at 05:47:27PM +0100, Gustavo Luiz Duarte wrote:
> The command-line path already requires a remote address, but if a user
> creates a dynamic target and enables it without setting a remote
> address, we currently try sending netconsole traffic to "0.0.0.0".
> 
> Refuse to enable a target if the remote address is unset.
> 
> Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>

Reviewed-by: Breno Leitao <leitao@debian.org>
