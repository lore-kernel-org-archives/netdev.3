Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEEC4071CC;
	Sat,  6 Jun 2026 09:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780739881; cv=none; b=mO/XfY2eh8UlLAyZA5TMt+VTw6Ni+412EP+5FNvkNXsW/YC3eu5wSgzPmtVbYdlfx/yqOiHi/q8iiZuzHwWJSzP5eLRdpCflstE6qysKQLPQG9wTbvoDrkdezz97H7sIByzM6ZixV4wnT/WtN7oN2ulf7u8jpbwxWNnpFdGTfWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780739881; c=relaxed/simple;
	bh=GkEEHZG7UFE4IDnPNUkoyP3RG+RSB2/eLnISscrClcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lv/Z8+tMoCBBBikCAeHySOZXebjbxEksnpQjczIq77E0vnzH8uc4OaK8tSWDWA2qA8+O/x2DffHg4uA7fkUJFdpzzovcSNouBQxv8tkdmXnd4a5B9qzGE4dw4FMJZEWfPLowrfwjF+fbixh9c14n6YSO/5K6KmQf0RTE0ZzodBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=EIRmoHmZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="EIRmoHmZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=k5Uh+Pk1kAd0luTTEDcclpK1hZ9Xdsd2R0whOWNw8Ck=; b=EIRmoHmZuIFR8FSLi/iUGqes3f
	VvBH4TQAluatWJxtHQsc77+/W7zey9Su1Nr3RYt4Zf8zQ1AnJf52N2Bc27lfEvo4QFE5tkpVlvhDa
	MZoU6tMEpHIZRkY0aBs5v9k0jMSUAsBnK6fIdLvektNSOqE/lbeOePu+ZweNTCZubeOQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wVnmh-006MFO-1n; Sat, 06 Jun 2026 11:57:43 +0200
Date: Sat, 6 Jun 2026 11:57:43 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: javen <javen_xu@realsil.com.cn>
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v1 1/6] r8169: add current_speed in private
 struct
Message-ID: <81385ca8-7055-4ef8-8280-be2e389d918c@lunn.ch>
References: <20260605103906.1445-1-javen_xu@realsil.com.cn>
 <20260605103906.1445-2-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605103906.1445-2-javen_xu@realsil.com.cn>

On Fri, Jun 05, 2026 at 06:39:00PM +0800, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> This patch adds current_speed in private strcut in order to decouple

struct.

> from phydev in the following patch supporting for phylink.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index ec4fc21fa21f..fdc8c84dd112 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -750,6 +750,7 @@ struct rtl8169_private {
>  	u32 irq_mask;
>  	int irq;
>  	struct clk *clk;
> +	int current_speed;

Maybe just speed? The code would then be more consistent?


    Andrew

---
pw-bot: cr
