Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194F5360ED0;
	Tue, 18 Aug 2026 15:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787065248; cv=none; b=s113Ll3Ilh/8WgdKoHV4UvBovop74I6iFFh6D0F0N24fcsk2w0Pd74WXIoFQIfTabVKNiQNcOJHFmOTkd9QEY1npEkOV0UVbiPTkjBs/q99LnhBW7IR8ExpQF28jTcHQjFPef1qX/yiDXZrFKz4NXD+xEue8i2BEVP8YA7EhjCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787065248; c=relaxed/simple;
	bh=6mEfNdo0N0VKZlbFSJVChvEM9TulcJXh0+ftAG1SmF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=csTvxZaKm7WGOiqVAFk92NeExjyLivpBrrAC/o6tnenzFVlfGhOP7U7DQLCm+g9ghdFPtLofxdwW6CReJjqlvqatxc7GzV15R1bd/Xp5P9j8C8IR/omBGDbL5TtCyp4JnzBJZv5zFn8EX2AOnnULdLmB9ZyFgj3JUQHX++jGdmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=R5vXSeRV; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="R5vXSeRV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kwUJRSJYudCZXoQC0vfxh3yxU7KlA02sKNq0UU/tIm0=; b=R5vXSeRVNZUA15K++edvreE9ey
	lr/XILa3Za8GiZBT9uqUCfMzBfhf8aNH/bGbr4JDTOpZeym6vMZXUeYwto4niUyrYMWqnsXGpW9JU
	l/fvf1p86FmBF0iZuPI9cuXlqN0vaCQFzinaT1Z/OFRGJwfJDv32a4laO8bGZhDnh6/4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wwLIj-000U84-Ax; Tue, 18 Aug 2026 17:00:29 +0200
Date: Tue, 18 Aug 2026 17:00:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jiawen Liu <1298662399@qq.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH] net: renesas: rswitch-main: fix runtime PM cleanup
Message-ID: <a402f04d-a919-4bde-b15e-b02c06ae1ebd@lunn.ch>
References: <tencent_2EBD0396FF7A54CAD61F16E942D2E8FA3A0A@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_2EBD0396FF7A54CAD61F16E942D2E8FA3A0A@qq.com>

On Tue, Aug 18, 2026 at 04:41:35PM +0400, Jiawen Liu wrote:
> From: jiawen <1298662399@qq.com>
> 
> Update renesas_eth_sw_probe() for the confirmed driver lifecycle defect.
> 
> Keep the change limited to the concrete operation shown in the final
> patch.
> 
> Signed-off-by: jiawen <1298662399@qq.com>
> ---
> diff --git a/drivers/net/ethernet/renesas/rswitch_main.c b/drivers/net/ethernet/renesas/rswitch_main.c
> --- a/drivers/net/ethernet/renesas/rswitch_main.c
> +++ b/drivers/net/ethernet/renesas/rswitch_main.c
> @@ -2123,6 +2123,8 @@
>  	{ /* Sentinel */ }
>  };
>  
> +static void rswitch_deinit(struct rswitch_private *priv);
> +

Please don't add forward references. Add a patch which first moves
this function earlier. Then fix the issue.

    Andrew

---
pw-bot: cr
