Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469B52AD32;
	Thu, 20 Aug 2026 21:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787259622; cv=none; b=mSZ94ak0iFNGMqXuOMZjHbT8V+UDKe67BPVno3NovzJ3qOzWnxjsLjNob26iXAlg0SCnw8ldyPg2voWPyYQz1PCXROyymx96fqTkW6JRwN/xC4VLMqzLa15TKM1SCtIZaHkLaDhbJQ5A5ur8krNpzGR7rf/+WIQQvcE9/6xfMOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787259622; c=relaxed/simple;
	bh=Mjk6LVCMJ06VSs53Qpq+HJjD0kyakqz2jS+BaN2A3ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IRTrflPo+Wcg5uO1gXR1G25336no7HPJGDM2juozxR0853RiUghd3C6K/R9g+f+5w+8h4cdE2NdaYsua98LE7W8VYq5TkP9TefKvpcn0bb1NSWu9ZbyvnbL9YOBgoBi4sAlJp0yVR4jS1+mzEc9p9sNl8QkYy5Z5e8XX9f9/5mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=K450eMW5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="K450eMW5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=IraYJR8xbyQeqc2R0ipywXHXerqP8H5Ms/wpHOhoDYU=; b=K450eMW5Pz52gDGMsb/Dq5ATbU
	e3VdOZgwKzuYnDt6TdrFGkKnybpIWfrq1COX50af9dTOBRodnsKWnfj3zHa6SyDLIhfy7ROf6dq9Y
	baHJuFy9/V/zo36oIpATAhUx7BEhq0YAfUpKn7lUTGXlZxcWhEK4GuRqt4ECcM6g6R9s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wx9rg-000qQb-V0; Thu, 20 Aug 2026 22:59:56 +0200
Date: Thu, 20 Aug 2026 22:59:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vladislav Karmanov <vladislav.karmanov.dev@gmail.com>
Cc: Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
	chester.a.unal@arinc9.com, dqfext@gmail.com, sean.wang@mediatek.com,
	olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, yangshiji66@outlook.com
Subject: Re: [PATCH net] net: dsa: mt7530: do not advertise EEE on MT7621
 switch
Message-ID: <b6c8df34-417e-488f-8aa2-98c0c62f6642@lunn.ch>
References: <20260818182829.1580811-1-vladislav.karmanov.dev@gmail.com>
 <aoSnqurLLgdVT_Eu@makrotopia.org>
 <CADDoYm63JMq=5CyNvqkTo65BgS927iURKMmhvhD=B-ytqq3Ygg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADDoYm63JMq=5CyNvqkTo65BgS927iURKMmhvhD=B-ytqq3Ygg@mail.gmail.com>

On Thu, Aug 20, 2026 at 11:18:23PM +0300, Vladislav Karmanov wrote:
> Hi Andrew, Hi Daniel,
> 
> Thanks for the review.
> 
> > Do we know what is broken here? MAC or PHY? If it is the PHY which is
> > broken, it would be better to put the workaround into the PHY driver.
> 
> It is the PHY that is broken -- the MT7530 internal GE PHY (PHY ID
> 0x03a29412, driven by mediatek-ge). Landen Chao (MediaTek, 2021) puts the
> root cause there: "EEE of the 10-year-old MT7530 internal gephy has many
> IOT problems, so it is recommended to disable its EEE."
> 
> That would point to the PHY driver as the natural home, but I think the
> DSA side is actually the right place,

There are a couple of parts to disabling EEE.

In this case, you need to disable advertise early. So the PHY probe()
would be the correct place to do this.

You also needs to let phylib know that EEE is broken. So the PHY
driver should be calling phy_disable_eee(). That will prevent the user
from turning EEE back on again.

Since it is the PHY which is broken, this will cover all usage of the
PHY, be it integrated in a switch, or standalone.

     Andrew
