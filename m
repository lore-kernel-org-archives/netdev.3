Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C85328CF6F;
	Tue, 21 Jul 2026 13:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784640461; cv=none; b=WNVPa/obZYW3kjxwRStnuEXYabkDISST4AkLH2cI2Lw7B5mvGLMuYRRr1QnnE3lMb0RhWkKodlZUl1QT2RP6/gevJVELDsl9V3hHvy1EfTn7nfyE9XQgea0dcsBuXyoxS9SpvtuxSkolCy6+qyxTRePH/KGsWH/5VkQkC986cY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784640461; c=relaxed/simple;
	bh=o+m+j7OfD9GtGz131xFv3iAXEoiTrnCmM0xOl9s0FEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K3zrbbZLy0g/EXB87c+LEysoykjQC8wOkRg7s1qMr/iAo2iGrdun+P7AxTKcnrxMffeLIkA2kdse6DNlXu0IYuuGyHsEFmr3pCRqmuMgGsvmhIegn0NPjjdAHM8hoxqYv9t4glARlhMqg07UIr2i3lX6lmj+jOC7WAz655cZ0o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bso/0MVl; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bso/0MVl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0vayxH9hJHp40zibUJV2MKtJ7hghiLqL+BwIbPIWnO0=; b=bso/0MVlAiYyVyo1ZUiVSzxNR/
	JGdb7hgkR7DhU28Z5UTKJOSIfyfzwxmTWmtYcKbucF/y12UQpFHSGGICM+41cSBj4oHjSbmRQftwS
	r+R1aK27aNUhjtEQT80RXOe9TStzuOy8t/qRhiic2iBsTQA44cVkNpN5yHRA7oEwwkj8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wmAVL-00DRbo-Ga; Tue, 21 Jul 2026 15:27:27 +0200
Date: Tue, 21 Jul 2026 15:27:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: Frank.Sae@motor-comm.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
	xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com,
	jie.han@motor-comm.com
Subject: Re: [PATCH net-next v5] net: phy: Add driver for Motorcomm Quad
 2.5GbE phy
Message-ID: <038431aa-5aaa-4c9c-87dc-bb0c0a1ed847@lunn.ch>
References: <20260721114810.660718-1-kyle.switch@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721114810.660718-1-kyle.switch@motor-comm.com>

> +#define YT8824_UTP_TEMPLATE_MODE_CTRL		(0x84)
> +#define YT8824_UTP_TEMPLATE_MODE_MASK		GENMASK(15, 13)
> +#define YT8824_UTP_TEMPLATE_TEST_MODE1		BIT(13)

Is this MultiGBASE-T test mode register (Register 1.132)?

The test mode control is not a single bit, but three bits. So you
should not be using BIT(13).

Since this is a standard part of C45, please add a helper to phy-c45.c

Another thing i want to take a look at is the locking. It is pretty
ugly having to use so many __ functions, and not being able to use the
helpers. I want to see if we can avoid this.

    Andrew

---
pw-bot: cr
