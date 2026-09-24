Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8BF472F65;
	Thu, 24 Sep 2026 12:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790253914; cv=none; b=NNcJHLjgolhACxpaia9gIvPLoUA2zFc+wL8/yAu6zzx2V559w+R3b1n4XFDBeRIhOFyG+mlUo0LsxfdKn/9U7tf7J8QHcN6pvYJayfBSJW69dgyz9mgCcDknix9EMojdSue0xTHBFd88V2DB3TqcHQjZ8VG2pr1jsc/h2oC9HJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790253914; c=relaxed/simple;
	bh=FDYWuG/LAlz2+g1l6gVN42jqalnZlN2fCGgQ42ad6Is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XXUrsVL/8EnNn35ZUdabR5gNKzBF6o+wKcgJ11fe/Q50OyupeGCzdU3ht1cPuv01VznnuV9PZc93zYhwKMRTgr3+bHooroT4Kxwjdt+3a7355xNOCiBjmubUxMwlBjgfFvTsqsmQF+XC3OjRrxl7MtI+7d6RIeAuNYrmvhvxDls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=BvJlLKYB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BvJlLKYB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=UhpawE8XyS0X4kY+R+dBl6PrI9tvX4W8POpNSnfgP8Q=; b=BvJlLKYB9EoVRwJSIwpg03+7Ud
	+1ChcIaee93ulP4MdyV2IhF+y3hkkwRaXohrasoTvFl5uD5WGNHmslZKs2w0qI4S5HgcEpZkXCaX/
	y5BCVmsf+Yg4wDWbcn18mKZRf6xwAGR/OFqZCy3FChZXHWt0T2dGLXQhfA+WxaeMixDE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x9iox-006zZy-UM; Thu, 24 Sep 2026 14:45:03 +0200
Date: Thu, 24 Sep 2026 14:45:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Hongmei Xu <hongmei.xu@oss.qualcomm.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: phy: aquantia: add get_features() for
 AQR113C
Message-ID: <cd172044-b256-427e-9843-c7daf4c33d50@lunn.ch>
References: <20260924-net-phy-aqr113c-fix-pma-capability-v2-1-29b06283b0f3@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924-net-phy-aqr113c-fix-pma-capability-v2-1-29b06283b0f3@oss.qualcomm.com>

On Thu, Sep 24, 2026 at 11:51:06AM +0800, Hongmei Xu wrote:
> AQR113c does not correctly report its supported PMA
> capabilities which includes speeds like 10G/5G/2.5G.
> Add get_features() to explicitly declare 10G/5G/2.5G/1G
> support instead of relying on PMA register reads.

Please slow down. You need to let discussions about previous versions
come to a conclusion.

    Andrew

---
pw-bot: cr
