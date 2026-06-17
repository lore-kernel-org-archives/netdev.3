Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7975341ADD;
	Wed, 17 Jun 2026 09:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781689253; cv=none; b=ZEmPkz2uKZ/F0nfnV+Onl8eEn2+lKwLZ4la9kwKQByfiOKDrbhm8F/39xj/xLSyUxAZub6awirrlqiOmRiviQi7kegb6SMmPAAscTSPS5ni02WukAfNjqwyb3s9hoxaVuQ7+c1Tb9iPTdk+xcdXb21H4Gvv4ybwaDUBPqX5XUAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781689253; c=relaxed/simple;
	bh=BrLyaznhfBjqbipr+HA1xByYVVfCZaxy+sgwvgvj+3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U3r8p4jtmCN6a3hEJtUMO95pBR8v8pcWx6cnDzr//LxKG0nwUGQLPSe8lq0xQNKH4RO/3kUOI4fGwZzIJwBs2n4ZRLqJPSalhsPget4VXyOJznS4S3wkUcDt/LtkKYYfyAS07uQrexlmLWJMA0BcjbHrtg3WlzkmpB9KWxzY7bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=QBwwVDB8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QBwwVDB8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=iLSNsBozXV/wBJ/xaMv2VelDGFtJMFzZlYbbHb7KVC0=; b=QBwwVDB8d2zeT7I6V/u9S2PrnM
	usjoIDgyd3YaGy+sCwNW5MILEzgaOEM6WnjlfT+zf2zwUBZnYmQ80Ers3bMx4kasxLF3vgGleYUXv
	aLb8Npsxbd4rBeE8e4wl6OS37DGC3tt4ZkfeE6XDUK1Rsk3QyZCnF7+l94xjtfEGpcSk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wZmlG-0089rg-2M; Wed, 17 Jun 2026 11:40:42 +0200
Date: Wed, 17 Jun 2026 11:40:42 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Dong Yibo <dong100@mucse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	yaojun@mucse.com
Subject: Re: [PATCH net] net: rnpgbe: fix mailbox endianness handling
Message-ID: <bf5366c5-88ae-418c-9c5d-b2249a7f43fc@lunn.ch>
References: <20260617083531.251119-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617083531.251119-1-dong100@mucse.com>

On Wed, Jun 17, 2026 at 04:35:31PM +0800, Dong Yibo wrote:
> Mailbox data is exchanged through 32-bit MMIO accesses but the
> mailbox payload is defined using little-endian FW structures with
> __le16 and __le32 fields.

Given you are using __le16 and __le32, why did sparse not find these
issues? It would be good to understand this, because if sparse missed
this, what else has sparse missed which is also broken?

	Andrew
