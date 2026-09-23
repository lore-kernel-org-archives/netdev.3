Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF7B3112BD;
	Wed, 23 Sep 2026 02:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790129880; cv=none; b=pXnPQwYEjpNo5xxsDMk/jJjzXE239aO8u4vrqdZKdoE2MwB2GTN73hYAqjzFz2u5t63iyrt32AmsKVUO62LStZR6QVKFglCEXeKHiLrw8sHggMQVMNZxprR3AEYhnxfaxIfHFD9u0wV+JUiHVsgvufKJxyXOOyecWktA5hmGBHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790129880; c=relaxed/simple;
	bh=0Zt3v3NQRNcHtA3hm0KuOL/lsIXryv+QefWbysKnw0E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tvNi3VYM69FHgpBw9smFAfo0H9A0PIDGeuu4RNN5B6YCXmNH6tMxSLtFem+y2ZFZg26yrZC1qereugsPCmV+53uzdSM4wMQWBIp34Sg89yyRHcEPFM9+IFut06PhCisoqsZh/6ve7XFoS6C2FSmVekejIA7japtN2IabHHmO8ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n3LkZo0N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n3LkZo0N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBA991F000FF;
	Wed, 23 Sep 2026 02:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790129879;
	bh=xfghmcIazzNv+3k9/mq2kvL7Hc7x+3J369UsPLCYc6o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=n3LkZo0NI7Oht1VGLYECVSR95ONoTSv/9T9ypWYwO6Uypn/cjianMl+7utFKTXFAv
	 JdxrHiIM9FrMgeIAoPguIH0gyo4e72jMq0VghBR8inkEsIkdxZLpi18yvs4JTxL2Hp
	 oAfjmANneH9uTiBFWBHpiWu50JNDF+1w4iU1uLvXDUB94jbo3eH9NUOe161Z+a3jwO
	 nn+QGvF90dn3T7wsP/K/TFUV5XTfjFf81r1bFAHtmcEjzWzIVp5o3H/ycNghbl/H2s
	 tAqW43gymhSGLEEPcQtaqw4VUzPuG3cVw8SahVneGGbrWyr66iFlW/ICqpax3Ov0jI
	 vSSZu+7Z6yxCQ==
Date: Tue, 22 Sep 2026 19:17:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Coia Prant <coiaprant@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Sebastian Reichel
 <sebastian.reichel@collabora.com>, netdev@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: ethernet: stmmac: dwmac-rk: fix bulk clock
 leak when the PHY clock fails
Message-ID: <20260922191758.2730da7a@kernel.org>
In-Reply-To: <20260919174223.2356964-1-coiaprant@gmail.com>
References: <20260919174223.2356964-1-coiaprant@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 20 Sep 2026 01:42:23 +0800 Coia Prant wrote:
>  			if (ret)
> +				clk_bulk_disable_unprepare(bsp_priv->num_clks,
> +							   bsp_priv->clks);
>  				return ret;
> +			}

Missing a bracket, EBUILD. I almost appreciate seeing a human error like
this these days :)
-- 
pw-bot: cr
