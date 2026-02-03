Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2B039E6D2
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 13:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770126757; cv=none; b=Sd71vq2WQm6tdpp9MrEh6+x9aKB6iuwvYypYhDbuDcxRhbe8mQ3OdLV/+HKtwAug/uuKwfNY+9Jeep7e7kIRb8rg6VRLBZa+Ee2CUgvAyL8wJlbvM5RP+NwurSzaUdsu1D30C3JRzls9v7kgCJwNRI0/qIOU/FBS1ojM/JsE2UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770126757; c=relaxed/simple;
	bh=m5M45ARWxrml/jFkvtYqWe0m/wdMjIRJDryXQGHAxRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z8IUsvye8047qgv/CecHzJIXGUGBMQy6jYOXXn6w2mO8Iuw1ZNm8sEQAQzFI9tjI9Asv89zupDfIBMfstY2ckhGnZ15u0J2nQhjMvjs2KPUrWQskecJto6Ao+/wvYrD8cwvk+zW2/yauJvOJv18YX/yiCUiXsWF2JdkXHsZu/bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=T6ZjqsJE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="T6ZjqsJE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=fOxcEzcB/5lYfxQnShwIXyaIojatj38FsOZvl9f4AJk=; b=T6ZjqsJEiI4SQzyQUv3Lr1jCj6
	CUyAqsmzk2Jv5Y68Q7dVgRL1hB0QTtds2QcCYpi8vYlGqz4vtW8kjgVh2OoVSQE2PkJltlz5aQRFz
	NeadJj7S1leMX+Oo3zSFAmbUmGojYbEKzX4ul1w6sdy/7Rjyl/LIvJMoml1Rm12gwTjE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vnGpS-005x6u-L5; Tue, 03 Feb 2026 14:52:30 +0100
Date: Tue, 3 Feb 2026 14:52:30 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: Re: [PATCH net-next v1 1/7] net: ngbe: move the WOL functions to
 libwx
Message-ID: <c58edf64-c61e-4ea1-ae4f-8d5c15003019@lunn.ch>
References: <20260203075759.5852-1-jiawenwu@trustnetic.com>
 <20260203075759.5852-2-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203075759.5852-2-jiawenwu@trustnetic.com>

> -	ncsi_mask = wx->subsystem_device_id & NGBE_NCSI_MASK;
> -	wol_mask = wx->subsystem_device_id & NGBE_WOL_MASK;
> +	ncsi_mask = wx->subsystem_device_id & WX_NCSI_MASK;
> +	wol_mask = wx->subsystem_device_id & WX_WOL_MASK;

The ncsi_mask change seems like it should not be here. This patch is
about WoL.
     

    Andrew

---
pw-bot: cr

