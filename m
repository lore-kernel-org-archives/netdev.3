Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E060834404E;
	Fri, 10 Jul 2026 17:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783703097; cv=none; b=Sj9ZwegXC8HD2mn4D1UkgYoRnrNtZg58nNs3qoqxB0/1ya9ofqkqcW1geVdVfXjyyF6WnJRjvRzJWJLhi9FQV81ifzod+1DAHpJOsBoYozJSFYzlZ5ZCG4jkQQOlwm5UNkQia8NTHvHBnphR/b2gmB1OulaHl7+wITfB9jCFcTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783703097; c=relaxed/simple;
	bh=DX+s07zp7xmaJlG9wwY9hbtgh1B4auOwg/DjalGTcWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CBsE9/wWuVmiMEj6QMLMilvmgztvfStB5DMW7G0ccDgPTu/TzS1zhTQFxMQjvU0v/KDQtSuRcCXNng1FUxfZRy+qdBbBWLAObEA3Uysb+lpoJeqjzYkpbEUtVQKoSuSnffAMKskbgRXRjBUmZK6rVkz05RggplYJ2/ukXrRNhjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=XjAGBKEx; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XjAGBKEx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=BhQ4l2+cyVz4qYYRQyEBluzLAA23BL1k/prf+814iEE=; b=XjAGBKExUwbsVqwG/f5+OGLGmH
	bQXANm3QV571r9HJmwRZsJI5e/cGP/ZBgmJgkxLJbz+Loe3NmwIbI3UOHody6LRdRLnC+rkTiJFLL
	ed7stZT8qmPyZP+YyFpTtZOA7dwS9Jqy95dR/O050PPp2wEelZb1f3jhZzNrWGV2tv5g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wiEeT-00Bfpf-9k; Fri, 10 Jul 2026 19:04:37 +0200
Date: Fri, 10 Jul 2026 19:04:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ahmed Naseef <naseefkm@gmail.com>
Cc: netdev@vger.kernel.org,
	=?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	"David S. Miller" <davem@davemloft.net>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Conor Dooley <conor+dt@kernel.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Landen Chao <Landen.Chao@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Sean Wang <sean.wang@mediatek.com>,
	Vladimir Oltean <olteanv@gmail.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next 2/2] net: dsa: mt7530: add EN7528 support
Message-ID: <60bd1e79-3914-4814-976c-b8aa2b006a36@lunn.ch>
References: <cover.1783680864.git.naseefkm@gmail.com>
 <1865eaedef97e593ba608764c7390209cae85b30.1783680864.git.naseefkm@gmail.com>
 <f968d3fe-83dc-4b82-972b-0d4d477a1a52@lunn.ch>
 <alEktKWsrriHdR40@DESKTOP-TIT0J8O.localdomain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alEktKWsrriHdR40@DESKTOP-TIT0J8O.localdomain>

> My plan for v2 is to not advertise lpi_capabilities for the EN7528, so
> mac_supports_eee stays false by design and phylink disables EEE on
> these PHYs via phy_disable_eee() and refuses to enable it from
> userspace. Does that sound like the right approach to you, or would
> you prefer it handled differently?

That sounds like the correct thing to do.

     Andrew
