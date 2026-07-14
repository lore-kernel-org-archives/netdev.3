Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A301A423E8F;
	Tue, 14 Jul 2026 22:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784069075; cv=none; b=egvV0XMjTNn1AZqwcZ+18fyGtJ+xJnsbYRrUrL9Wm1CJN0WkiqCobQFqQtiFdQBxN77xoAnua7nP60YhRoZKPX+4hELFH4bfUDI+wBIJk3Fvl0wGKPfUrIsH1lcMM51usxvRbjgLTW1fVhkBnEMrVmn85fxnwWX8LWgbZPuTnCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784069075; c=relaxed/simple;
	bh=7sSNu+JVL5JbFf/nTSwy1UCi3y3uyNXH7XtkW2AQ6WY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LmITMnnAq1ZH0xDLDsNcx/yf0PyjOk+BLXIlWEnAO2qAAoovA88PWma0a+RL0lQRqDPeqDdQA+IYq51rM6PmfH9CnNFzxAY6u1WZ2L61GHO1y1qXqIE0GqEGqFFYGPvIYGrUB5aJETUMTSbHTG/3gPjkEoYkybJRE0L1X2PIuys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=kFoAi3hQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kFoAi3hQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=msQsONzw5o/yMkbC/i1/jrHLiW0z7BfiinQ4NyKa5wQ=; b=kFoAi3hQmzxNwiJL33pGWZ2uyg
	pFtj7bkHrUVDSbAy6SZNLBAU360iI1pPJXgduH9vKNpekFhlv+ohsyV5c5Yk+3wV+GyeQqhOFM8ta
	Y9ZuiCv7e5SZJ7JdaVGumtRPw/c0gubnK7LSznsvMotK7U9KSvuo9hjFyJHo//q5gryw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wjlrP-00CGLo-Fq; Wed, 15 Jul 2026 00:44:19 +0200
Date: Wed, 15 Jul 2026 00:44:19 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Coia Prant <coiaprant@gmail.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, robh@kernel.org,
	krzk+dt@kernel.org, heiko@sntech.de, netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org
Subject: Re: [RFC PATCH 06/10] net: pcs: xpcs: improve SGMII AN state
 handling for Rockchip RK3568
Message-ID: <464cbdf3-2e9e-43ea-b30a-75b3d1b8a188@lunn.ch>
References: <20260714191341.690906-1-coiaprant@gmail.com>
 <20260714191341.690906-7-coiaprant@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714191341.690906-7-coiaprant@gmail.com>

On Wed, Jul 15, 2026 at 03:08:34AM +0800, Coia Prant wrote:
> Commit 2a22b7ae2fa3 ("net: pcs: xpcs: adapt Wangxun NICs for SGMII mode")

You do not appear to Cc: the Wangxun NIC people. It would be good to
have there comments on this change.

> Fixes: 2a22b7ae2fa3 ("net: pcs: xpcs: adapt Wangxun NICs for SGMII mode")
> Signed-off-by: Coia Prant <coiaprant@gmail.com>

Please don't mix fixed and new code. Is this a real fix? Should it be
back ported to stable?

     Andrew
