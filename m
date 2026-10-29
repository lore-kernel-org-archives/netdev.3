Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793236100;
	b=qi19dXE0Xh8+E1rMGvp8Jb9prVhNBF8ERc8SfU/Nuf2ID/1vAcRifRbjsv9hQwizdoVL
	 xZaKhDbbHlH661r76fz9Pft6nxoe9zQWhHUq58e02DEhoXzjVVOdk+3fpOSyHeqCvCaLq
	 HZdjqPhvlFRfotuzvtC3VqRzfmvHy7r22zSX9YhZIr7FLuwJE6i08JXQsUy8IAZPqcFaQ
	 xN19u2fqAw9mMTmzE6FLry8nz6dfod0JY1Mou553Gf5gHqpKdaJ+Qd472fY5r+WcegNr7
	 wbRM+IDYV6FwJPSWmqbe4rWo6QJt5JZxEnmLSOocVuJR49CM/lEJkY2WmLTDBGiZuzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793236100;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=nhLVtTkIassfrANkFapLPbYMUKz/+bInbQXzVZxT2lw=;
	b=MC6fxMfUXenIsvBluucePnx3tSQrrkRlKBGW2XpF9HvdBqjD5HGS7SFHyQSYPjmFKcT2
	 a+YMESEaTZxnB4rwBSZNfvya2PBxxpcD3kAitJ+46hWjBV6Hnt2AtBhJgGzNqhHQdTEHp
	 99wxV0RYlRvdOKiJWZlVx/lIFapFxayhxstGMrQVnvCatXVs59y73NYzTiEN/u4CZ0ups
	 Y9LftrF6JUSyVw8R4ejawgW70XVTD1UNUwvtuVZv9ZpggAMtN4SYILya/si2Djo1cXPNX
	 QE0wBDsAuWm+n/W668f3+nsnzNfvWVfEqHlqA/GuCHbE6Tx4nw8tJdvUCqwJV9WozeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZHTrRZcB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10848606A31A
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 01:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZHTrRZcB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29BB01F01825;
	Thu, 29 Oct 2026 01:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793236099;
	bh=nhLVtTkIassfrANkFapLPbYMUKz/+bInbQXzVZxT2lw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZHTrRZcB25R0EPY0xjYrZjwkdR693GjvIQ+npm96KApzjuKy3BoMAVhR+vQFpEdgA
	 hv7RWnA8bux8KUanFS2mM8PaPXxx51sSHdQxHJmRU2L/4CYxFZo0eYsjeMwvKHvAZo
	 ZmyPCMbj9IqK9YFpdp1+Ames60dr/kGg/+ZwIBNM+L9UiqqBhCfz3DY0lYi/58QFi5
	 GqqFL6xCbEwuWEjkTlXf3PvVvz8jNj8uIcEb8L1rdYKpUJWSpovZSq0/N2d8feBJ/4
	 aJeidOTIkvWKI/BgzhqjDGcfCSGQeL5Uct1IIDFxs/SMd88bRFxmS7lI609tqUAQra
	 zDbHTFtb7w14Q==
Date: Wed, 28 Oct 2026 18:08:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: jacob.e.keller@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 pabeni@redhat.com, poros@redhat.com, netdev@vger.kernel.org,
 grzegorz.nitka@intel.com, aleksandr.loktionov@intel.com,
 alexander.nowlin@intel.com, anthony.l.nguyen@intel.com,
 maciej.machnikowski@intel.com, przemyslaw.korba@intel.com,
 sergey.temerkhanov@intel.com, arkadiusz.kubalewski@intel.com,
 richardcochran@gmail.com, horms@kernel.org
Subject: Re: [PATCH net 4/6] ice: E825: stop clearing
 PHY_REG_TX_OFFSET_READY
Message-ID: <20261028180818.72e882f8@kernel.org>
In-Reply-To: <179323521502.3134.1640101944514020934@kernel.org>
References: <20261027-reduction-v1-4-81237c67a361@intel.com>
	<179323521502.3134.1640101944514020934@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 29 Oct 2026 00:53:35 +0000 netdev-bot+sashiko@kernel.org wrote:
> - [High] ice_ptp_port_phy_restart()
>   (drivers/net/ethernet/intel/ice/ice_ptp.c) now returns from the=E2=80=A6

Looks like this is because of the patch droppage.
Let me take the first 3.
