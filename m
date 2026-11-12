Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794478335;
	b=vn2EztQNMIuCl0zerIQfNgydwx93nuvs8vVv8/qbhjhMNwAHOsNSjxGpuZ5V0VqxOlBJ
	 d+YJ654xUNgkaHvIPfC9bzi1I05yNc8yneOzJnE7iYfwpwLxBbPeKi0k8A+Qcj/WTY94Q
	 JF58H1mcB1X239JIrgnYdLZG4SWfYKInZYQ5wsWpwEaarXU3Z51zaFnVLrPbMnR1jm96l
	 uR74ordHqDwFh7xQeHYFRGDk7Y2Aj7+2+Q18Wf0o3Duvovk8ScT97BQRNJPs9byJIAJ78
	 XBi1GpkFf9nTRxmudFiGS3PFgBMbXLjTNfs7mFnhXxrOVIz99L3Ly7CzKLq3PxhZDCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794478335;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=m6vUZ3LR0Bl/r5MeX/A4FbQJiyioDH18V2IC79hgfy0=;
	b=QAhdks7ajiEOO78NAf9HnNAtsjfylgg/YIqE9eJV5kg628kgFbab9btdw3wIeo5oEjw9
	 tGjBa/xMdwXc48EhwwuiuyERk1TSwaWRUIg2RgQ6bH2I2KqNRTTVnqIoc6UWyKVxTova2
	 zGlUrnyzqpsj++06xas0ubIKsLQuSOy8bi69Q0PnRUUgig0JMnyTzUsUIAFyViFEY/Bga
	 u9WAKpeEZDeVZBh9x/QHZtUYyHqQYBWjBdwagevEhp9Zd6ntLtxXIWM4QzCA7DUMhvrNk
	 K7QgCRcQOyqMq3eS5od5DJtPu9VfJSXQftQEHKvQHOuEGNxD4alwAvyuUyUd5SsJK/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="blh/yOuJ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 254CB606A337;
	Thu, 12 Nov 2026 10:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=blh/yOuJ
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 1BC8E1F00A05;
	Thu, 12 Nov 2026 10:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794478335;
	bh=m6vUZ3LR0Bl/r5MeX/A4FbQJiyioDH18V2IC79hgfy0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=blh/yOuJpn/OjkRt/062TkdjYc3SCnLweis40rnFbiSAh8WIt5dI8Vnr+GMbVMXf3
	 qs7/kjJWcx6GPKbXJlXfrCXDfA87LEp0HrrhthbY+o3P77jKRkzZsEWCpo6STNpZ+H
	 eMlK7zwt59UbK/QMW8Ug/zjh8U/uMiYiHRckEUExUJI5Hnok6vINBYRopm2JTQ8aNH
	 Z0fpeTMB/uwTffFrp6HC+bxWB9Ihle+6TP6vaKwpCwbkzN9/xIdhZx4wiWBtI5uKOs
	 6eTaDbdPmHGA8OhkdEPp3qN5+Loipi2EvhKkWJQpr1kZ90Ov6nVYhEmbvjhcTlaSoh
	 gGBZ/nORmaVoA==
Date: Thu, 12 Nov 2026 11:12:11 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Xia Yan <yanxia@cmss.chinamobile.com>
Cc: netdev@vger.kernel.org, Felix Fietkau <nbd@nbd.name>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Yanqing Wang <ot_yanqing.wang@mediatek.com>, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, yana06070@163.com
Subject: Re: [PATCH net-next v2] net: ethernet: mtk-star-emac: fix
 device_node leak in mtk_star_probe()
Message-ID: <u6jz3rgrlwhlbhqwgi26lsa2knkwgjws6scbb6e3dq6bkjmudi@hiulukf72wrr>
References: <1794455490000.585551.2561101329908158128@cmss.chinamobile.com>
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
In-Reply-To: <1794455490000.585551.2561101329908158128@cmss.chinamobile.com>

On Thu, Nov 12, 2026 at 11:51:30AM +0800, Xia Yan wrote:
> mtk_star_probe() gets the PHY node from the "phy-handle" property
> with of_parse_phandle(). The helper takes a reference on the node it
> returns. The node is used by of_phy_connect() each time the netdevice
> is opened.
> 
> That reference is never dropped. Every error return after the lookup
> leaks it. Unbind leaks it as well: the driver is devm-only and has no
> remove callback.
> 
> Release it with a devm action, registered right after the lookup.
> The error paths and the unbind path then drop the node through the
> devm cleanup.
> 
> Found during a code review of the OF node handling in ethernet drivers.
> 
> Fixes: 8c7bd5a454ff ("net: ethernet: mtk-star-emac: new driver")
> Signed-off-by: Xia Yan <yanxia@cmss.chinamobile.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com> 
