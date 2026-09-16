Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FD94DB54D;
	Wed, 16 Sep 2026 22:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789598587; cv=none; b=cV4tFxZF4kr+OYevt0E+eZk8EdNYiqkETF2j/xuKznr5WF+v+EiBL2xkLPNHRL02kY/wxsrPxr9c/eL788zH0CvRJm2yf1IrHWwQlUkq78XhKxi2g+a9YdTjtoX51/b2IkepxJqtDqfgAHV69upIHzWczxyuToPkMMZh184fkfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789598587; c=relaxed/simple;
	bh=NQInzHZEL8fqzVLolGkccH5qLsNLm/CzstawCeEqC2c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R03sBe6A0KmPJJ88PEtZpOgcrv+hHbmJDrHDgBhQ9KuTJEfDjtNlKdY5dRKFN6JvbIZOLZADI8ebIaHY3LkIP3eUo+McdBIQ2cFjfTpSHnMyowyL+647p7li9dXxII7TSjwr0q/m2zgSfKHyIXuQqTwTyDCl+lCuxd86d1kPkAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxhGPYmp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxhGPYmp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F7A21F000FF;
	Wed, 16 Sep 2026 22:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789598567;
	bh=qZCfPuOF3CwE/OcmSc0yij3ogOH6Mv1/81bgWBcOgD4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jxhGPYmpEI6Ybl89DleIf/AGD87BtCa2yG/BB6ZI8UdTKXBT+cl3vPNGzJiYGzuis
	 1LHZ7jxzFOf2H21hQ+FthOtQVvvneSt+vFcDbrl0o5pncb9hiEv9m7P/B/6nknY97A
	 wom5hdAwG83Eogel9CQNNBgWA/UjPq6S4XYnfRppjapxO8U5vhn3GwD32xO2bs81kb
	 sH4OYjtPg2rmzPQiF4XW/xeFNJFFtKxUGxP3/ifEwL4zbiFLxv/+Ozwzh54VxaFTpP
	 gs7N/9ESZfSv48ZjWK6dJYKp1810hjjAcz5jf5N7QrpVDzJYzUaNTZeQlnPNfE/hk0
	 06+zoUjKx3L2w==
Date: Wed, 16 Sep 2026 15:42:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Anton Danilov <littlesmilingcloud@gmail.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, David Ahern
 <dsahern@kernel.org>, Simon Horman <horms@kernel.org>, Ido Schimmel
 <idosch@nvidia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 9/9] ip6_tunnel: add drop reasons to the
 transmit path
Message-ID: <20260916154246.290ac83e@kernel.org>
In-Reply-To: <20260916143717.1875082-10-littlesmilingcloud@gmail.com>
References: <20260916143717.1875082-1-littlesmilingcloud@gmail.com>
	<20260916143717.1875082-10-littlesmilingcloud@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Sep 2026 17:37:17 +0300 Anton Danilov wrote:
> -static inline int ip6gre_xmit_ipv6(struct sk_buff *skb, struct net_device *dev)
> +static inline int ip6gre_xmit_ipv6(struct sk_buff *skb, struct net_device *dev,
> +				   enum skb_drop_reason *reason)

Pls ask claude to look thru the functions you're modifying and see if
they can be changed to use the reason as the return code (using
SKB_NOT_DROPPED_YET as success), instead of using the output argument.
