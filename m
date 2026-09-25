Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E295731F985;
	Fri, 25 Sep 2026 21:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790371598; cv=none; b=j+En0+2n903JeqjPqpg4EimfTnV2Q9QilBec2rBjl0db71OY5ZW+KQY5KNDGLSbpFfy5cfhVTJ5WAvKCk10fpoyKgZh4zrvNw2NnZ2t9GzZIl9q0bwimt2nkyCXdLS97Jh9eE6s8oJ1jA4Yt9q7jEImzQx1/huhXhBB7lZJMuPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790371598; c=relaxed/simple;
	bh=JX4wHbQ+gBdmVVj6OhbGKQaGDG0oKRixudHkG6CAGqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I9I1Pl4Rm/xy41STIX37BXNTgId52S185+0dX3xgR+WOAU7HNMMmXThYcb3tNXOhesiyk25Jx7UQAUDf8F1vfY1MlQREEnG/q6O3TJ14s1t7Nk7WLfOXW8mublCC3NnuuxRedJCjCaH5oLMtnapdSx7zXAtsFCvyERPSp9mcpuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GDW475Tn; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GDW475Tn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kUgRvzjH5Nng/0oeQsMG6q0pTnAxIznTLyHMuTPk6to=; b=GDW475TnEWdErC95CCYwHan5s8
	S87cUJOT/welLbBUF0SJ8UUFjqrSI/0cPJIinM8PSodpahXOKbyJouN703WSfrW24IF2aVWPFJ7LQ
	N6g2vaw4aXJZboV9sYgUGvKlJClYb8S5k+oSqh0GyUXPDJpJTI8ymOp//GBiYmBD9dSg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xADQw-007Ice-ME; Fri, 25 Sep 2026 23:26:18 +0200
Date: Fri, 25 Sep 2026 23:26:18 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yongzhao Chen <yongzhao.derek@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, Ziyang Huang <hzyitc@outlook.com>
Subject: Re: [RFC PATCH net-next v3 4/5] net: dsa: qca8k: flag QCA8337
 internal CPU PHYs for SmartSpeed
Message-ID: <69b36e16-eece-4739-9208-96bd8e60943f@lunn.ch>
References: <20260923215858.1653-1-yongzhao.derek@gmail.com>
 <20260923215858.1653-5-yongzhao.derek@gmail.com>
 <09d669ff-7aad-4414-880a-21c2e7bf2cd7@lunn.ch>
 <20260924234814.1734-1-yongzhao.derek@gmail.com>
 <d2797713-9b92-43c8-a26e-bf3bc9817ad8@lunn.ch>
 <20260925210153.8717-1-yongzhao.derek@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925210153.8717-1-yongzhao.derek@gmail.com>

> Disabling downshift for all qca83xx PHYs would also remove it from the
> user ports, where I have not seen it misbehave. The CPU link has no
> cable, only a fixed on-board connection

How are the two ports coupled?

Are there magnetics? Capacitor coupling?

Anything like what Micrel suggests? 

https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ApplicationNotes/ApplicationNotes/ANLAN120-UNG.pdf

    Andrew
