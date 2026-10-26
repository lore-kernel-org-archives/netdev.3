Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792980176;
	b=I9e/bbbyy5FV0NlszrQQUiNB44g7/w6uGYbOkQEc0UX/Kytd+c2DpXecRI5DK60YPfTX
	 m2P2d2Y4nGOqkoc75OTr4qzo+35xboox/wiRKDIc4nlo9QZbrzhRJ1ipkGUIvb5MlsXre
	 rM9XjfSqzQ8Bj+g0aKhEgNxrO8WBKHebv4ruFZQgMVk3Q3p1G9U5WLRez7iZtX6rsOS96
	 Xb89vCt9+TPnDo5afgQmBd+mnGcU7T0IGZdr9VlzUmvdAqeWbgFwKmcYSlNaJ0GppPnSJ
	 XkHkeLzOxavcFGbxeS95m0Ac24fD8L2odJCKm6SrNTF4/QzwBcpc0JjLy+84xwcHFqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792980176;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=If3HWL0JukjflKpqf96xpA2ykeHffj+qfMocs+Us2t8=;
	b=LgC+/kg30BoK0DmaBmRkrLE2y72+6X1eFOd8qlwwmUDIioLOSmHAPiVE4LSBx9s7Azwx
	 7bfAJQVMfgV8FsBoToLqmqfTj5exwLxt2uATZhretR63GumPFTvFcxWOUVIRhTmUDsXaU
	 4zbxwxLu9ZARuHcZhpma7yUcuh4+Rtrx/fyluhbyzyT6H37QV4XNsBGbC06ax9odAiO0L
	 LVKgo3sLuMI7AG0QxvXgB25+0A0pu1cCm/d9sv+/ncqUz6BOHh5fyn9EHKaYL7nhbF6lD
	 uWiwjWzKhSZUwwIQMMNJH4UljJvJknz6p20P2enC5plIaN7gY9i8lhhE0Mne5hjW0Sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=33Z96V7u;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC23606A31A;
	Mon, 26 Oct 2026 02:02:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCC23606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=33Z96V7u
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=If3HWL0JukjflKpqf96xpA2ykeHffj+qfMocs+Us2t8=; b=33Z96V7uKHmJYA4kqMyKvxyWRr
	SY+8c0tjqz9TIfZcZAkLR+RYcIVqayY7li8Ikr5RGProVdbChN4oCS6ntcopLFVec4vA+OJrwyI0i
	y8l2KMsyuvOwaFOxT01JiT3vt+5Jsx2f1F3qJamwxvBy0A8GPlaCwFEXSk8ETBXGyKpw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xLA2s-00Cjim-Ru; Mon, 26 Oct 2026 03:02:42 +0100
Date: Mon, 26 Oct 2026 03:02:42 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Selby Mashiki <mashikiselby@gmail.com>
Cc: Sunil Goutham <sgoutham@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: thunderx: fix fwnode_handle leak in
 bgx_init_of_phy()
Message-ID: <bf64600f-81fa-416d-8d2d-9149e5b62a43@lunn.ch>
References: <20261025203159.455100-1-mashikiselby@gmail.com>
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
In-Reply-To: <20261025203159.455100-1-mashikiselby@gmail.com>

On Sun, Oct 25, 2026 at 10:31:59PM +0200, Selby Mashiki wrote:
> In bgx_init_of_phy(), device_for_each_child_node(&bgx->pdev->dev, fwn)
> breaks out of the loop without calling fwnode_handle_put(fwn) if
> to_of_node(fwn) returns NULL.
> 
> Switch the loop to device_for_each_child_node_scoped() and remove the
> manual of_node_put(node) calls so the child fwnode_handle reference is
> automatically released on all loop exit paths.
> 
> Fixes: 9d28f9491258 ("net: thunder_bgx: add a missing of_node_put")
> Signed-off-by: Selby Mashiki <mashikiselby@gmail.com>

Does a leaked OF node bother anybody? I would say no, so please post
this to net-next.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

	Andrew
