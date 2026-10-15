Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2C450EBFE;
	Thu, 15 Oct 2026 09:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792058356; cv=none; b=RKxHAKDkELCK9ZeUcaZfvcH+CDcI6PdJObHqbo6HdH/HyU9MQ602OOjfKe2FGhNmqEtY6v42tjjVK5caRnz6mbwumNi9SPBMwPCs1VIBRpmfjaRUcDHwZbuPhwsbY17DnY0ytON22mkEEnXsPDBYA7Tgx9OBete/72w5TyySuVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792058356; c=relaxed/simple;
	bh=NVOia/N7LIk8muVKWJmeQ6PHy+eo+cQ9zaVjQs9I690=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTGjzG/tU8bP2celyKl12TbnCHbnhzL5tNABedSRkOSai2vmoWBtGWLgNw8yZD/7FPvITNwpGduz2JGkG7tN333UsRakY5U/c9uJiNcoFClCL2mbryqywhkvsofsGVqODgTel7LRogYEzJPNxOeM8WXKXIbf7Pb8y1p2ImzcQW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=ukyERuE4; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="ukyERuE4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uAHo67pn/12jxJum+3WSXwcW7pfgqgyfx97rw9oiqW8=; b=ukyERuE4dLZMVahRFReNWVx0gi
	qEQqcN+leoQIn50ENP2cPXNGKIMmgNnDAA/vG+i/dkWamyUm9HRf5duku3Vz1FQrVVuQpqJM9bhsz
	/V58VQLOrBLx91zm5gddj6smw9rnOKVlZQ8xC3q62Z+WGNMYnbhIwXFXxcsAA1R6MuDfIiWI5z3fI
	kyum1w1dD9HMe5T436aYRj3qzYiQHczQEgLonJX0zIdFih3YIl4rV9HB0ZvgjxxSyz8QxmcQrYB5y
	L9Wt0lfzO+eMsp+g9ABkEOwPPuPj0K+XgSYrjMKxoYosAvfb4hRr0FTcOjT4xdN5hZfyEb8GTtwhC
	4V4rTIvQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xHIEt-0056yl-1s;
	Thu, 15 Oct 2026 09:59:08 +0000
Date: Thu, 15 Oct 2026 02:59:03 -0700
From: Breno Leitao <leitao@debian.org>
To: Gustavo Luiz Duarte <gustavold@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sashiko <netdev-bot+sashiko@kernel.org>
Subject: Re: [PATCH net-next v2 1/2] netconsole: avoid printing partially
 updated target attributes
Message-ID: <atCj2rOpqy83s5bC@gmail.com>
References: <20261012-netcons-fixes-next-v2-0-ac8ec4c62edb@gmail.com>
 <20261012-netcons-fixes-next-v2-1-ac8ec4c62edb@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012-netcons-fixes-next-v2-1-ac8ec4c62edb@gmail.com>
X-Debian-User: leitao

On Mon, Oct 12, 2026 at 06:03:43PM +0100, Gustavo Luiz Duarte wrote:
> The configfs store callbacks all serialize on dynamic_netconsole_mutex
> but not on the read side, so reading an attribute while it is being
> written returns a partially updated value.
> 
> Hold dynamic_netconsole_mutex on *_show() callbacks to avoid racing with
> writers.
> 
> The dev_name_show() callback can also race with
> netconsole_netdev_event() writing to np.dev_name due to
> NETDEV_CHANGENAME. So it needs to hold target_list_lock in addition to
> dynamic_netconsole_mutex.
> 
> Reported-by: Sashiko <netdev-bot+sashiko@kernel.org>
> Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260814-netcons_ipv6-v3-7-bc0915e8c75f@gmail.com
> Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928-netcons-fixes-v1-0-bb5ffe5e698a%40gmail.com
> Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>

Reviewed-by: Breno Leitao <leitao@debian.org>
