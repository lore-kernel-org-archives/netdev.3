Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C5140DFD7;
	Sat, 28 Mar 2026 22:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774736780; cv=none; b=CtrRJRgoZeUN4oY4i0PaxG5VwN+OFqEQ1GfwAg9Y9btdLeUT/QXKt9XMHycxZA97ywrFCjNpaQoX48VcOt6SZpfELoVRUv7j+Nl/qSjr+Tf1xgZq9Sj5K9mbY2upSQtDb6pePCZxFqVCvIuNumiBWRy89vpMNUqYoLWwpBvppHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774736780; c=relaxed/simple;
	bh=l1jfZwxErHlq0nx+juM7HdB/j7fz8nLUmbZBi1417vA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qZd1+DrSixo6jb/+TpM4/lPnluy0SMSV6mdSrRvqXPvxmHwZdnJBEmwTPZOHGis72MajHgFHu2g89HB8JAgA6YlNqds859UmJfuI+P3p8UTtu9F2DbvLhvWs9G+x4/SlWT9Dz4OODe2EhVKI1hBfjajUo9s4IAryNRhHIChcZsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=IrbqNRvG; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="IrbqNRvG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ksn/ONXvwjFSl7uoWMydoUCTQ2n21ymYZkV8pvqF/8A=; b=IrbqNRvGeY9gFvxXGYjzBeb65D
	oyV0CIkcphy8AMq9OdHok9Wx2jkD+i8SPTdK44SuUZj++7tuLMzSf/8u/IibGJNzOskprqmp0TiCW
	UiiYtbkj4Yk+2XkiibEtMIdc++DkTFZXZ4stjxKKTZTkcOER3QXkWghjq5eH0f6Jae/UFPtSUPgj+
	AbHdISz6jIVhlHDqKlsJ9SJBWs2h3uelqwy3YjN9dO4s0EYnn0jzKoPGXXT//ZPr6js1sr2/0I+Fv
	hPqkENCp+Y8NJ4vDaCl64J2Zv9URbJvXvkQlc5yp82CpA9kCS/QlIVPkreSVOTuGXN2kHo1mCvwKB
	YuaeBQVA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:32806)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w6c6a-000000007W4-46Aa;
	Sat, 28 Mar 2026 22:26:09 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w6c6X-0000000012S-1fvd;
	Sat, 28 Mar 2026 22:26:05 +0000
Date: Sat, 28 Mar 2026 22:26:05 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: =?utf-8?B?6LCi6Ie06YKmIChYSUUgWmhpYmFuZyk=?= <Yeking@red54.com>
Cc: linux-rockchip@lists.infradead.org, Heiko Stuebner <heiko@sntech.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: stmmac: dwmac-rk: Fix typo in comment
Message-ID: <achVffNlW_VPZu5W@shell.armlinux.org.uk>
References: <tencent_833D2AD6577F21CF38ED1C3FE8814EB4B308@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_833D2AD6577F21CF38ED1C3FE8814EB4B308@qq.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Mar 28, 2026 at 01:43:31PM +0000, 谢致邦 (XIE Zhibang) wrote:
> Correct the typo "rk3520" to "rk3528" in comment.
> 
> Signed-off-by: 谢致邦 (XIE Zhibang) <Yeking@Red54.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
