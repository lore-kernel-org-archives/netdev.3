Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6821A1EB3E;
	Sun, 26 Jan 2025 16:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737909217; cv=none; b=qMQDvtc2/PEjNxoNbgWcQgITgcTu3pUIuc6sMMmg/6A2wfLX6Ojmr8hi1BSlkLE9E+hW3RjZBMqz25hLb8TIdmxLNWIimyLQmHnFGERhUtGj/Ry6KRGkOUH/NtXXKIIc31Aw3ySVZL37RBHdhya/DeWU5Q807iPN+7qC2Oe3EP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737909217; c=relaxed/simple;
	bh=E/kjeAaH+uR0Cn+oiAtRx9KVLJ55wKcf6CrmFXMN+a8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A7fKIX1EVnxXBFL1l6Nev4AN9+E53PrGQ4ACuFUKLaV9vof0j6r1qA7Cl56A5AHBLkgldLjXC8CQzBvMjS1SVd6zYGnoAJ1lygAIofMjAcoQYf8bmB4PRcMes/Xe8CsMz9r6Yvsm00FqschkKEBBfKtTOEsIQV3gNhfk5UD0YnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rYHQlxH1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rYHQlxH1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kbedA//e6UwF+vhXZcC1JPwXFmuFy8J+z3JCyc/ZyP8=; b=rYHQlxH1vYT87pn57Vg/lhjg9P
	gWofde/1QMv80yRQEwPD096dpaZA1CUlDdIVsoW2A2G04zwlLBy1QvkDmlZnHIYPtjfEigMcqsk7j
	1Cn3Tj4Uo1tRs8mZZzmappMmVxID4o/B1q3zP3+CP6FNhMESTnPrFVfAbyZbiW1ciSLc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tc5Za-008HC2-Ku; Sun, 26 Jan 2025 17:33:22 +0100
Date: Sun, 26 Jan 2025 17:33:22 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Max Schulze <max.schulze@online.de>, netdev@vger.kernel.org,
	linux-usb@vger.kernel.org, andrew+netdev@lunn.ch,
	s.kreiensen@lyconsys.com, dhollis@davehollis.com
Subject: Re: [PATCH v2] net: usb: asix: add FiberGecko DeviceID
Message-ID: <584a635b-d3a8-4900-a134-3f57ddc0b01c@lunn.ch>
References: <20250126114203.12940-1-max.schulze@online.de>
 <20250126121227.14781-1-max.schulze@online.de>
 <2025012646-unleaded-laboring-d81a@gregkh>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025012646-unleaded-laboring-d81a@gregkh>

> For obvious reasons I can't take patches without any changelog messages,
> but maybe other subsystems have more relaxed rules :(

Same for netdev, we like to see a commit message.

If the intention is this is to be merged via netdev, please read:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

Also not that netdev is closed at the moment due to the emerge window.

    Andrew

---
pw-bot: cr
