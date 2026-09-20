Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2AB3264D9;
	Sun, 20 Sep 2026 14:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789915344; cv=none; b=W1LhaK6k23qYdtaMrH7GmQQdOMM/GVE7Wz9+MQ1+q1/Sf+aVF8i8t0p4364mxVHwueT12M817SUSYPnZHF0QZRMuCO5z5F9BVik0ZsKzEwov1Vqcg05wIJsNOdjRassjIlTf2ldoUN2Sb5W6Fxkg7TcqaPMeH8k29uu6NGDHpxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789915344; c=relaxed/simple;
	bh=nqI2Eac1z1rkD+guwWwVAG0wkHx+OfNjNp7Lc6ASkh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZTXAEte81eesoUXLX5tRt1h6vpkpD2AeKyeW2wvdg/BJl1RBzLwh2Ww8XijKNPGoKVmx3JOCadLbZDD2pIT47NDdeio+7DLdtk/MTtHd84uMWAfE951LPzmZAhSQPdFvYIo7cFI2S293uwN7fyvbYN5xzyTViowyw8OTgc9UH+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=N9YixaiU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="N9YixaiU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9yzwkDXHhJ/92kjXS5gW7uF7Qx32+rVm/NrK/8EfbA0=; b=N9YixaiU9pNiblXk30I3arcjd2
	60rvlWAkeNQ6KRvP50g285FR1tv8Yc5B4yHFjQZJluAMZtjJXF4VSfsZn+CO7FyBPk3kXEfJsrZsI
	ZWHobE1qXvKIqQTxZuodJLj36NzBxEj3GUdaUoFGvY1lB9hdJNZVjV+kWlENOg221kbs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x8Ijp-006ALv-Tn; Sun, 20 Sep 2026 16:41:53 +0200
Date: Sun, 20 Sep 2026 16:41:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yongzhao Chen <yongzhao.derek@gmail.com>
Cc: netdev@vger.kernel.org, olteanv@gmail.com,
	florian.fainelli@broadcom.com, jonas.gorski@gmail.com,
	woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
	skhan@linuxfoundation.org, rdunlap@infradead.org,
	linux@armlinux.org.uk, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next] net: dsa: pass PHY flags when connecting shared
 ports
Message-ID: <59975387-5539-47e7-bcca-4a5ed0a84bad@lunn.ch>
References: <20260919085406.1395-1-yongzhao.derek@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260919085406.1395-1-yongzhao.derek@gmail.com>

> The use case comes from qca8k PHY-to-PHY CPU-port support carried by
> OpenWrt. That support is absent from this net-next baseline. The downstream
> PHY driver needs the switch revision and a flag for a QCA8337 CPU-link
> SmartSpeed quirk.

If the PHY driver is not in mainline, there is no need for this patch.

You need to post both this patch and the PHY driver in the same
series, so the new feature has a user.

    Andrew

---
pw-bot: cr

