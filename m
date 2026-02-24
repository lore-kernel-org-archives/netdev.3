Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1167E3EBF08;
	Tue, 24 Feb 2026 00:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771892730; cv=none; b=If06dJD45ZEsVCJL691nl+63po3ZOqt5QKT+st8mqgd9pe28pQZWwXz123tsTWAgsOpkEa8FxCCCWW+w5E0nD2lhho/1++/HfbvqE7PMML4TLDHoWs2kIfaoi7WVNE9UXiKeyDnlEkcTS78KohxNQMlNjLHPoHtVu95Ml+3Ff7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771892730; c=relaxed/simple;
	bh=7Hn1LL/P0+aqiVoYtGkNW5sN75m37hbO8D97TAL8QZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N1NZ02OkTitceYcf/1bfNEcw16Vo1YDIM/CEtNiX7z9wOj+vdnq/bnw4D4dAGyL8389UZf1YK17SGc2e4Mbu3XZYAcs1RlsNpYkINoysyVsH+LsjBcy0vFC+bwcO6FA8WA9XksevbyKyxL1gjAx/IuWWI8tqd+8gwF6fExn7Pnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2tQOFWaH; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2tQOFWaH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9wNbfljbdrFJ4n2mZFkerLZ8iaTZAp5bP82EU+2TLyg=; b=2tQOFWaHgdJXv3mVmyFe//Zsgf
	OrGcmZyuuWjtmVmZFttTohmxtToez41TqAz7m0rpqWhIxDTW6kzPlTBvqOnEmO3JcaQZ8FzHj742Z
	jje/868dk3eAHYAWpw9r6naV2UJCRvi6D3N8PDWkZ8WSdmMnpxjKs+5P6vRwAGa4n0+k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vugEk-008Wyl-A0; Tue, 24 Feb 2026 01:25:14 +0100
Date: Tue, 24 Feb 2026 01:25:14 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Artem Lytkin <iprintercanon@gmail.com>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Trevor Gross <tmgross@umich.edu>,
	Russell King <linux@armlinux.org.uk>,
	Miguel Ojeda <ojeda@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] staging: most: dim2: replace IS_ERR_OR_NULL with
 IS_ERR for devm_clk_get
Message-ID: <796e602c-12c3-4288-8ed2-b41bfd64b2d1@lunn.ch>
References: <20260223220504.2102-1-iprintercanon@gmail.com>
 <20260223220504.2102-3-iprintercanon@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223220504.2102-3-iprintercanon@gmail.com>

On Mon, Feb 23, 2026 at 10:05:01PM +0000, Artem Lytkin wrote:
> devm_clk_get() never returns NULL, so IS_ERR_OR_NULL() checks are
> unnecessary. Replace them with IS_ERR() for both the "mlb" and
> "pll8_mlb" clock lookups in fsl_mx6_enable().

Looks like you have some other patches mixed in here.


    Andrew

---
pw-bot: cr
