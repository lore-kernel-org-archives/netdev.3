Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BCD18FC80
	for <netdev@vger.kernel.org>; Sun,  7 Jun 2026 07:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780815737; cv=none; b=OJ6TCNZZ47GWWTSkWWxVbb8MDR/lTedXVKBQ33piqjUj2MhvOG2i9cJHM484z7RLFuEpqhBYIFXOzqCt55eABxjwXoZdvyw7ZoB+bPH3d4uSKn3DoVEmpFaxt+53QQ8Sb/b01o4x9UAQP4xUSFbCwfPjvuHPmjbUo3MqAm9udSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780815737; c=relaxed/simple;
	bh=HXcVk+J/jC94lJ4r/0go5TopyLFmG8Dt8FnFs9J7yDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IXKV1XUYXCTbJega1L06NR2sSKODyKfvrVFRXdstnuFLhx93yVFpkDRxK8fC7ZbbRiu5urUrEdrDp+TycG81WH3Qk+I2Uy4c4rIApZUFwOsOEE7tBGyJcfziqqgloipjWaUmcWH4z4X/ooeFuOWHyQjXkUSRp9LKf+uc0DZJXqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=aoGvoJc4; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="aoGvoJc4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=OzshWX62bv6H2iTVYR0A3I8MxYDmhGZ4N9sOLl3B9Ac=; b=aoGvoJc4XZP196V/2MZ3KhxMzS
	JSYyi7HgNSKyO8+Z+wopCzzeGHfMlcZYOt25fkEQM8FH7H+tTc5clwpcQOMxIWdcL+v0NPA1VTuPj
	X/ytJutlxNC3DmgMZpzB6woHMpsKYMfopdE9a8idK+d9WFUGchAWxQ4lJlL1+kZBK61I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wW7WN-006RO9-B5; Sun, 07 Jun 2026 09:02:11 +0200
Date: Sun, 7 Jun 2026 09:02:11 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Potnuri Bharat Teja <bharat@chelsio.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch
Subject: Re: [PATCH net-next v1 01/10] cxgb4: Add T7 register definitions and
 core structures
Message-ID: <e45bc138-f551-496f-9d86-74a48ccdf90a@lunn.ch>
References: <20260607035220.528439-1-bharat@chelsio.com>
 <20260607035220.528439-2-bharat@chelsio.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260607035220.528439-2-bharat@chelsio.com>

> +/**
> + * t4_os_lock_init - initialize spinlock
> + * @lock: the spinlock
> + */
> +static inline void t4_os_lock_init(spinlock_t *lock)
> +{
> +	spin_lock_init(lock);
> +}

What is the point of this wrapper function. It does nothing.

     Andrew
