Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8ADA4218B1;
	Fri, 10 Jul 2026 13:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783688788; cv=none; b=WE3amsMGJ3hkMUbVB11PEI+5jmvT5uW9/p5F2Qad5Sptqn8cgHlC0Phs1wzRfIsBA93H2kNv46GMFH26gGbzJoKSG77WM8pmeGj1FsKULD94K6lW0cpJ8DJnJ+YQPMq/p++IstzJmnHXx490fENnsXC3Ppy0rtRUUGLMD91OKj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783688788; c=relaxed/simple;
	bh=yPHmQGplbyhWPo88plDfUBgak+u9g9x5QCPg1XA/uWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OorJFL3cn8Zp+echUyrleiB3e4gp5mWtYPo8zBhVJtx5SyGxGGfMv+uWbovJmbwKTsc1YowLJtm/+sM8JxaG5fFsQ82im8hoqRxVomEeqJHAnHESOSeQmaW6Xy8scAOAYfn9Rr1tYOSyssWd148UjOLEO7qPttGhdRNvI73tHi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=it9g7SVJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="it9g7SVJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mV0lmoSxClm6EXoLgK6PCrBog1QXAV7JsOzWUeygPIA=; b=it9g7SVJOI11VI3pGKWrACyv5W
	Z5jSes55gmSxSpQSuJBecSsClB5wh9T+evcXldmduX/3I7uTqNeh0ffsl9Hb9VkM124RBNsgBdW2E
	R0a8RWSETiS4qEdKuidMFvHm/xcnqTUDvHpAegRuZFRqk9XczKAUSy6syZX92h7Uc1M8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wiAvn-00Bdvn-4J; Fri, 10 Jul 2026 15:06:15 +0200
Date: Fri, 10 Jul 2026 15:06:15 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Luke Howard <lukeh@padl.com>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Cedric Jehasse <cedric.jehasse@gmail.com>,
	Kieran Tyrrell <kieran@sienda.com>, Max Holtmann <mh@rme-audio.de>,
	Max Hunter <max@huntershome.org>,
	Christoph Mellauner <christoph.mellauner@joyned.at>,
	Simon Gapp <simon.gapp@gapp-audio.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 2/2] net: dsa: mv88e6xxx: flush the ATU when the
 hash algorithm changes
Message-ID: <b594d9e0-791b-4333-890b-169d6c071e0f@lunn.ch>
References: <20260710-mv88e6x41-fixes-v2-0-e23654c65aa0@padl.com>
 <20260710-mv88e6x41-fixes-v2-2-e23654c65aa0@padl.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-mv88e6x41-fixes-v2-2-e23654c65aa0@padl.com>

On Fri, Jul 10, 2026 at 09:29:33AM +1000, Luke Howard wrote:
> Changing the ATU hash algorithm invalidates existing entries: those
> loaded under the previous algorithm end up in different bins and read
> back corrupted.
> 
> Flush the ATU whenever the hash algorithm is changed through devlink
> and reload the default broadcast entries. Per-VLAN ATU entries and
> any static addresses are not replayed, so the hash must be selected
> before the FDB or MDB are configured.
> 
> Fixes: 23e8b470c778 ("net: dsa: mv88e6xxx: Add devlink param for ATU hash algorithm.")
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Luke Howard <lukeh@padl.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
