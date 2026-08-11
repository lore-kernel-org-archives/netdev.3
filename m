Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C3D2F8EA3;
	Tue, 11 Aug 2026 13:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786454423; cv=none; b=R/iOW1x7i1gz5Lp8boXdmhO6FeA57HQZ7kp0McNpzNFWt0+F3SkH+VVlEEptEMa41IvfTPi9KhfUkc8jDO8///D3QGjSZkdkGtjVPQIzxzhOKdla3WjBpLkWJW+b3PVg6mEAf59zXSXA0iLlLWlU1G9M9KoLHN4pHeoGUaMcUwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786454423; c=relaxed/simple;
	bh=ppjE8g6BU9yNBbS9Snly8mVLM4yT85pcMixd/7d3/cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UT0D0x7pm8kYlGLxfQiWRSMujVs7ReOQJblfq2mH66My0QTSPrNn/3/jGkTh8d2d4IHR+Aiv6uz0K3QFOM8OzTox6s3KxdTrbDMDKARl4eLwnGmCtgVEml6Si1hOMTGeC7wrn/Da5dwG4h0k1hCTactSrYBFgF0gfM+3sU5d/ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=SYy5ZMYi; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="SYy5ZMYi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8hofmMrKiO0JgQt903vqZFbWP8ReQZApFrA3vkcYy5o=; b=SYy5ZMYiCa/f4nq9nGHBmlU9fk
	u2Nr4e05CyJnbI5U1BqzWRiZucKgqhxXXJQIFDSOTTERU0btxhu2ShdXCk8ouxDjLe3g/3uTuz8YD
	Sr0kLAXhM5J5ioSqLRw2i40viJkT+L6C7rOB5VQExrXWuN75JYClD4Z87+uizdrkAwwpvoQ5SklvI
	Euc1YfPNB4kSsJv3kTCOLK8VnJp8uEB0Hvevuvgbu6oRSJ3dBx6rcodK2H0Aq2oCFGZyJntJBxmYM
	CtEY2SuO+HdgDkXBqMmfI4ELaPhHjKpBp4wNLsa6wbyFYsfj3DyO5dfCQw9mTPafEZmuf6lTYlE50
	LlOWP9KA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wtmOt-003agI-0a;
	Tue, 11 Aug 2026 13:20:15 +0000
Date: Tue, 11 Aug 2026 06:20:10 -0700
From: Breno Leitao <leitao@debian.org>
To: Gustavo Luiz Duarte <gustavold@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 4/6] netconsole: reject a target mixing IPv4
 and IPv6 addresses
Message-ID: <anshcVXKS8QqBdfM@gmail.com>
References: <20260810-netcons_ipv6-v2-0-3d4fc987a90f@gmail.com>
 <20260810-netcons_ipv6-v2-4-3d4fc987a90f@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810-netcons_ipv6-v2-4-3d4fc987a90f@gmail.com>
X-Debian-User: leitao

On Mon, Aug 10, 2026 at 05:47:28PM +0100, Gustavo Luiz Duarte wrote:
> The local_ip and remote_ip configfs attributes are written independently
> and nothing stops a user from mixing ipv4 and ipv6. This leads to an
> ipv4 address being zero-extended into an ipv6 header or an ipv6 address
> being truncated to its first 4 bytes for an ipv4 header.
> 
> The command-line parser already refuses such a mismatch. This adds a
> similar check when a dynamic target is being enabled.
> 
> Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>

Reviewed-by: Breno Leitao <leitao@debian.org>
