Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344B7296BBC;
	Tue, 11 Aug 2026 13:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786454526; cv=none; b=lJUb0Knv/XuGxqobg4yHQ4+0w0nTkdFlVcDVIIFp7lLZ7iP9g19jeeMXZzK04ptrAEYHlYmapm8dPYLjd7rnJkf8m8il0At4yoE/yL4t66DOTtiQjRVTDnfUzLFedZzo/dxgusIqNx9U8w5QswErx3dlsRQDglx0pU4Nhzd8wK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786454526; c=relaxed/simple;
	bh=gFsm1EiEVbNDIczxED9CtcGN2F4EXWbX6B9h9m+IcW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BEvsyut+ufWbWnMKxVuiVZ7OoZUkPb/I5w793YJdBQ6fuQIdVwmDXnGXg1AxG/0jqmhJEUtY+mY/IpCHZNVvQE2hGjW+K5b0LfJihdJ3/9ZNgAn+Kkz7CRK301O1rvJEuq6v/9Esu8wFJ+8EPZ7sXoFU2lNk8LoZvgt2BOWhfIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=pBtJbztP; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="pBtJbztP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RZi27n+E6pMgfcdKg061LU6m9TLIqdpXQn7B+Os2F/A=; b=pBtJbztPOZIG22OjvvgqwbqmIf
	Zo7cLdsLtiiCY7h84ad+mgX+Tjti0jloLZoKadYXdEGxKDvr5BWJOubuQhlEBfER4DGJzy3uuoZpQ
	xyQMhfejzV5yE2INg/6b+q3ivShRoqqGPhR3vAl2caMICZGkPUGDZCn5EIl+HudXg+qk6RLCY8NtA
	+lYM4MoKoLWaNYsy8NuFcd7Kg5PSzbdLjs42nL+MjwNkBu+8oV38BVJzNZjgYKA6Rz+rvsbZhKNKc
	8akDjYAfX8CFdWc2l+Z1puGVSojyz6+2kN3uQyXlcKzoxfsVfLdDMbB8zbpDLQc6dqMrH7/jrOjn2
	heoptXBw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wtmQZ-003ahQ-0V;
	Tue, 11 Aug 2026 13:21:59 +0000
Date: Tue, 11 Aug 2026 06:21:55 -0700
From: Breno Leitao <leitao@debian.org>
To: Gustavo Luiz Duarte <gustavold@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 6/6] netconsole: move struct inet_addr into
 netconsole.c
Message-ID: <ansh45Or9S-xYxK6@gmail.com>
References: <20260810-netcons_ipv6-v2-0-3d4fc987a90f@gmail.com>
 <20260810-netcons_ipv6-v2-6-3d4fc987a90f@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810-netcons_ipv6-v2-6-3d4fc987a90f@gmail.com>
X-Debian-User: leitao

On Mon, Aug 10, 2026 at 05:47:30PM +0100, Gustavo Luiz Duarte wrote:
> The struct inet_addr lives in netpoll.h, but since commit a1116396476f
> ("netconsole: move local_ip/remote_ip/ipv6 to netconsole_target") the
> only user is netconsole. Move the definition into netconsole.c
> 
> Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
> Suggested-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Breno Leitao <leitao@debian.org>

Thanks for the patch!
