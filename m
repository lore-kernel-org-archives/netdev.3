Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81AD2D2381;
	Mon, 27 Apr 2026 14:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777300476; cv=none; b=MpDk5pB6r/YsnrxRzf7/1msy69KvrfBTjVNf/8IsKfTiumKczKZWln5/7XmkoeU8FpfpWGAJfBrH7Rz8ZaAW/y3Jb4Jluwz+C2+iGB9FAsvyf+kfrHlL5BCLyp9O9GlKPoMAAY/y8zoKg2FNYDX1iQN2bVr9VMl6iWX5HZoNlG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777300476; c=relaxed/simple;
	bh=s6ejNYCbQUv1Hk+z8O4MRcyBpQn8kQYVQr+hrb02CMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TBIWqo1OZI0z/lyPhmk/+u5JXyrNBudJAlpIs6I7oceXFnTujs4Eccq5pvHq10+eNUTjgRTmN74inhoN/kfZOBTRBT4NGDCkfTyOsYVK9/kE6RhqUu9N3qHG/AObNCVkNxzqL8469o3JNdn/VP7Xhe11E1r8JaJFb3LR+1M3wUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lf/lexo1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lf/lexo1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7H/RVlrWUtSyHg3S9RnjkHqxWWdo3Bo1omK0WCDbjbM=; b=lf/lexo1rhwmt3JkG+tGVhrQ3C
	ehSFfsVf/h/Z/NVuL+aX9435itt1RE0IDp8HWZX4ig7cW+PqhCApE+j4JY/ATEaUpVZgt3U6Jcp0+
	sBXqKc7G65rgPeSL9PHShTt9lIZlcsVp/r5sLLMUUJxHMW+h6zhAFlvnCclMAj3bmLNw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wHN2W-000B0Z-K1; Mon, 27 Apr 2026 16:34:24 +0200
Date: Mon, 27 Apr 2026 16:34:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Javen <javen_xu@realsil.com.cn>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	"nic_swsd@realtek.com" <nic_swsd@realtek.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC Patch net-next v1 1/9] r8169: add some register definitions
Message-ID: <25ac5d27-dea6-4dcc-90d3-748549e17bb9@lunn.ch>
References: <20260420021957.1756-1-javen_xu@realsil.com.cn>
 <20260420021957.1756-2-javen_xu@realsil.com.cn>
 <59c06e34-2782-438e-bfd7-a8d475f34f95@gmail.com>
 <bff9db3261a54995aee448e6115f5e29@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bff9db3261a54995aee448e6115f5e29@realsil.com.cn>

> >> +#define RTL8127_RSS_KEY_SIZE 40
> The name here is directly ported from vendor driver, which may carry some confusing.

Part of the task of taking vendor code is re-writing it to make it
understandable. That often means using better names, names which fit
with the Mainline driver. It also means making use of Mainline helpers
like BIT(). So it really is often a case of re-write vendor code, not
drop in vendor code. Use it as documentation, not code.

> V4 actually refers to the type of rx descriptor, not the version of
> RSS IP block. Since RTL8127 exclusively uses this V4 descriptor
> format (and not the older v2/v3 formats), V4 is indeed
> unnecessary. 8125B is from older chips that share the same
> descriptor format, which is also unnecessary.

Maybe also consider taking a step back and looking at the overall
structure of the driver. Would it make sense to have functions which
handle only v1 descriptors, only v2 descriptors, only v3 descriptors
and only v4 descriptors? Would that make the overall code easier to
understand? So you might need to start with refactoring the existing
code, and then add in your new code.

	Andrew
