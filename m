Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADED48EBF7;
	Mon, 12 Oct 2026 14:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791815769; cv=none; b=UpKjL1DJgA9cQFL2TMvxJ48xSUOOOrSaPkQTxxQnvrDGUYON1isf5PZQDKrbNkIz+PPnhJxf3WwPhFCOXJWsxNBxeVxL3wv5pVu7lixE0lP1F5/O+x3sVPiXNhRSv8yx7FfTegKkkc2Sl7ko6P87mEO/wugTCAnBXAxRqCFetKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791815769; c=relaxed/simple;
	bh=ruAB98NV4MtKZb7ATPssY5Pyex7av3lefwqTbyxb1dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qG8BWUSmAqvDxLHVoW8DjpstGUDq3n9WtatUr2Ay2A+9UUDzbFPvTz1xkx1f5Zmdg59JrONcczQV/9w8+xJ4FVdulY6dzDJtOTgOub97CN4Vr8wFZo8Delq/fO6BX48FQn1+bLhdOEiIeMoNCRxD5rZmfS8uNJMOrsFgVhUyT/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=SaNRFaRd; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SaNRFaRd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=krFACiaW3QUm8OgBNfKBi5AprBUH06s+4jeaJgDuJho=; b=SaNRFaRdunTEj4UKEw+1hKjwTo
	8MWTmSZJhrOC7IZYFF1AMp4LNX9y+JB99m216dBI4RlC68LpM4RTIxP82ssbYh0MxCfvmltV/L5lq
	dXrr3KajSRmwLfS1e7OOaGqTBMX87A1XMmNt2hmqKyWZx0MqVz+lrTnfZWHDs3jcl9ug=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xGH81-00ALAe-6f; Mon, 12 Oct 2026 16:35:49 +0200
Date: Mon, 12 Oct 2026 16:35:49 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mmyangfl@gmail.com,
	horms@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
	xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com,
	wei.zhang@gl-inet.com, sijia.huang@gl-inet.com
Subject: Re: [PATCH net-next v13 3/5] net: dsa: motorcomm: use fixed-width
 GENMASK_U*() helpers
Message-ID: <44b1b1d3-06eb-4a95-9b24-71a2d25db977@lunn.ch>
References: <20261011025043.1859940-1-kyle.switch@motor-comm.com>
 <20261011025043.1859940-4-kyle.switch@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261011025043.1859940-4-kyle.switch@motor-comm.com>

On Sun, Oct 11, 2026 at 10:50:41AM +0800, Kyle Switch wrote:
> Some masks assigned to u16 and u32 fields are defined with
> GENMASK(),which is an unsigned long constant and wider than
> the field type on 64-bit builds. Convert the affected
> internal_mask entries in chip.c and the YT921X_MBUS_CTRL_*
> masks used by mdio_bus.c to fixed-width helpers.
> 
> This is a type cleanup only, with no functional change.  Other
> GENMASK() uses in the driver are intentionally left untouched.
> 
> Signed-off-by: Kyle Switch <kyle.switch@motor-comm.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
