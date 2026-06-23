Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234C73C8705;
	Tue, 23 Jun 2026 08:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782201996; cv=none; b=OGiy9RLPG9B0EQZoZ2qVODu21i6XcT74b0exDEKqdtQ5dPYrTzKkaD0RPpIE/MJWBN5Dot5JQBnT8SuID2ujRixS3c//eZ6e+lv2WZmK+FeEK2hEo+STvDrANCfHjv53LVhwgBSQoVp9edMryWP+zydpfvpO8pWRc0DuOQ2jkTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782201996; c=relaxed/simple;
	bh=M2ufHH2/dRHg50Fl1au4I769pE7zBPdBt/sZuNe2aUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S/1aXwUsttj6YEItv4B+FUmXVwayuagU7wwJoqQUwCfiLnOcIb0d+14e88OhO8i6w7RQy/8154tz9uZp64bkAWyBSucu3qY72v1cVSCVUpKE59BGGOY+YAYWCnXftu6YIWMVcnDgT1TWUzdUvHN4S+XaavBbqbaVKCIOsHWTvXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wKStXU5Y; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wKStXU5Y"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=cH59EFRiOTJTVXBV0T3lxDOJxlmVpYuPyPnDHXmFSvQ=; b=wKStXU5YQaTfYlCR654yeoXeHL
	OkFr3aqdHGjt3ARMRBsNp629g3PW9Mrqv7hnJoxi7aWXvivSnZpwRe2bou+e9B0VlqFvqfT8mGwq1
	eWGP4z3T7twO7JC3N8JlUel/T5mq9cwJvBiMibdCIzgfTdFCuuFOKXhDgfubk1CqShxM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wbw96-008v4K-O9; Tue, 23 Jun 2026 10:06:12 +0200
Date: Tue, 23 Jun 2026 10:06:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: bcmgenet: report MDIO busy timeout
Message-ID: <a3264f30-fa52-4d45-9c54-7be606b587c9@lunn.ch>
References: <20260623061524.51411-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623061524.51411-1-pengpeng@iscas.ac.cn>

On Tue, Jun 23, 2026 at 02:15:24PM +0800, Pengpeng Hou wrote:
> bcmgenet_mii_wait() waits for the UNIMAC MDIO command busy bit to clear,
> but ignores wait_event_timeout() and always returns success.
> 
> Return -ETIMEDOUT when the busy bit remains set for the whole wait
> period so MDIO callers see the failed transaction instead of continuing
> as if the bus were idle.

MDIO is a very simple bus, basically a shift register, clocked at a
fixed rate, no possible protocol failure scenarios.

Have you actually seen this timeout occur? Or is this theoretical,
from code inspection?

We are getting lots and lots of theoretical issues reported and fixed,
while very few new developers are contributing new code, new
features. Please could you try to concentrate on things which actually
matter? Theoretical issues just waist Reviewer and Maintainer time.

Also, the merge window is open at the moment. You need to repost when
it closes:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
