Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33040309EE6;
	Sun,  4 Oct 2026 14:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791122564; cv=none; b=KJ/OvBGx57oUuziAY9sYhSO8N/51sHq9+F/AasCl9m/M7OvVLVSAALNs0fAtGgefWsZGzDpWkZw5xqqDicHGWmFVcbTKXWUJPXG2N7mIZAhB29vhJDSSnBdegQafSo7coRa67JNH7RvUaDKI9iDYoUBhNp31vpdx8c7e6+C9VoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791122564; c=relaxed/simple;
	bh=uYG9mEU9YWpkW1X9Ixi06VRKBEh+Cityx2Hzi595/Yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eg/wL5Y6EB5+NpK21yV408rNjJXx/pPIzoCbIuZFrabe8/KlcU8qZFcljXQaXuMi62aQDSa8vLy5mwcmOM70DikLDcY/z7yEL2DLL9kecnpewaNBoSLHe8oU9zTD7f8zJVbeSPMqT+NTsnu6QBzVPa5ym/55tSu2+n+bcaA1SKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=x9azlG08; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="x9azlG08"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/SDSPyhE6mO//U3qp1w3fAfWLfMuXJZCzXVtpqArSEE=; b=x9azlG086DaqCjddnFzHGHiTtF
	fKjEb5gNghY647RIQKoCC5K9US/fIZbSyPrZgTHTsIBWUThDVtDtSwhsJppxJ2ip2v+O5RAlXSBJ0
	WmenOr+ovPEtdy56NdeRIKHONtgiV1e10CTXFsb84n7CcvAzxuT6QtdkP8+rc9ou+AKU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xDMnT-008szQ-TC; Sun, 04 Oct 2026 16:02:35 +0200
Date: Sun, 4 Oct 2026 16:02:35 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/5] net: dsa: motorcomm: Use NSEC_PER_SEC
Message-ID: <2e4bb01d-64b6-4a55-b585-13f1723e94f1@lunn.ch>
References: <20261001204851.2576101-1-mmyangfl@gmail.com>
 <20261001204851.2576101-4-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001204851.2576101-4-mmyangfl@gmail.com>

On Fri, Oct 02, 2026 at 04:48:46AM +0800, David Yang wrote:
> Get rid of magic numbers.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
