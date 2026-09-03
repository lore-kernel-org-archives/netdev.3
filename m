Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92D64C6EF7;
	Thu,  3 Sep 2026 15:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788447715; cv=none; b=RGz3uOZYYMNs4hK/FeAztpgJ4gTaO3slsXcs8Bn1PnpRwy1U8Ry4Z8RLTvhULbvCvUz1Xkqgloq7U04SZM6OBggSuWcldpOfhv+i+/+1tEM6GnGbLGT2U5Vb5ZT9FcD/Lcks8OUQtDuVBO0tQDctrhBAY2LW364855In/pQkD7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788447715; c=relaxed/simple;
	bh=2NVT4qyXE5p5GM7ZLzH+N20qJe00ze1dLenXe0c36RQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PcpdCpm4BVEUOuxJhvXcuLs680/2ZeDUpqnr55xY7mZalqPbArCZ1fPj0jmbLPi4Fl26q1OGXIsWzITLzNRKZ+Czsk1BEtcP71aRxcw7a/yGkHjiLkLB6K0c9YjsK4DFs//+VhzJ1d090BfAFGKzrcIXxFC6JqzeNmKrbVIy0+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=D8C+H49A; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="D8C+H49A"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=TuzHIr4ah3Mg504+OTodqlP++wRHIVjvOvHwm2TCv2U=; b=D8C+H49ApZp5Fn2+a/IVT6TBqX
	WYGOlelngDDzYEFaM0uzJbf+hAxtv01J18KQjJrKaybaERm47SbfAYb4QWJoySD2BD+U/v+0d7tlo
	Yl3wXRubb7ROPpn0CUqHFRiSjQdRLWKFCVjV6DYhxNwAlsfhrwH4nRcS+5vFSyNR0lqo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x28wg-002kIp-Ue; Thu, 03 Sep 2026 17:01:42 +0200
Date: Thu, 3 Sep 2026 17:01:42 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] net: dsa: motorcomm: Split MIB module
Message-ID: <f4e2e465-8472-4dcd-8e34-f3002864abbc@lunn.ch>
References: <20260903143514.532023-1-mmyangfl@gmail.com>
 <20260903143514.532023-2-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903143514.532023-2-mmyangfl@gmail.com>

On Thu, Sep 03, 2026 at 10:35:06PM +0800, David Yang wrote:
> yt922x is going to use a different MIB scheme, split it to reduce the
> length of chip.c.
>  
>  		pp->index = i;
> -		INIT_DELAYED_WORK(&pp->mib_read, yt921x_poll_mib);
> +		INIT_DELAYED_WORK(&pp->mib_read, yt921x_mib_poll);

This suggests the change is not purely moving code around, but also a
rename? I then ask myself, do i need to review the code in detail?

Please try to make patches which move code only move code. Then add
patches which do renames.

    Andrew

---
pw-bot: cr
