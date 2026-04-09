Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CD03DA5A4;
	Thu,  9 Apr 2026 16:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775751171; cv=none; b=oJlEqs9QWEL6sBLBPJdoGR6BT0oqs3pi7+Y6On5JU+ZOrsZ9u8vpig0XMX1FJAQhKt6Df1aaOIPUrisGNgNzd1cbZyAGIGBd4BBuSj+gCPESVlyEPy+/1Yh8WmJFaK4YpqkTUtjt4VD1XsdaQ0uZap1jQicDnAOQ9roIWOtUh6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775751171; c=relaxed/simple;
	bh=oLbn1eubxVcwwIg1iMpcgI2cC2W9CzLbVWxCwczvJTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WpkIltUTh94PQVnKyoQ9Ay4eBVivJRzijs45wy1EQXCjqMDlHvWF7K3bevnbz2o9bhEmPY906+TYtYiyuiDP6SJzfvQTGiRH9qJpUu2/ynt+R1TcHSQRJTcEsfpzCU0sDNxkJihKdlfYozQN7lUZ5KnN5a4h+eiGdgJjlvj3XNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=5sJv+Jfb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5sJv+Jfb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=bSjQIcszTluN96NaAQUeMOqPqzSGvcDca/Pdltz/Yas=; b=5sJv+JfbkBYd0BeAP5SWKbS5oC
	IwNAM+ed0CiCUBbcGnYGtH3QYQCC+2+4IQXgPyp/gwvK8VV5KgTuCD+ft1qnKBI9aDaKKRDEVGjjA
	Sr6hRbdukfaHUFPHzl89NJWunUVURfdhScgMNzujYHxmzXxqkdYrKJv7lqQM+5uahyIU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wArzg-00FSQ5-1R; Thu, 09 Apr 2026 18:12:36 +0200
Date: Thu, 9 Apr 2026 18:12:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Hangbin Liu <liuhangbin@gmail.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/5] ethtool: strset: check nla_len overflow
Message-ID: <bb2e7087-aa36-4556-8778-b65d11354779@lunn.ch>
References: <20260408-b4-ynl_ethtool-v2-0-7623a5e8f70b@gmail.com>
 <20260408-b4-ynl_ethtool-v2-5-7623a5e8f70b@gmail.com>
 <adaFjwkOrPoBgzoc@devvm17672.vll0.facebook.com>
 <20260408173943.2c239ae8@kernel.org>
 <adfG99Pb-4QewoQ7@devvm17672.vll0.facebook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adfG99Pb-4QewoQ7@devvm17672.vll0.facebook.com>

> I guess... Should we update ethtool.yaml doc to tell the users to prefer
> ioctl over netlink for strset-get and mention this new EMSGSIZE?

No. The ioctl is deprecated. It can still be used for drivers which
need it, but netlink is the preferred method.

     Andrew
