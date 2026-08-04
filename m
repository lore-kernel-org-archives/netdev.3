Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38A9393DC7;
	Tue,  4 Aug 2026 14:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785854498; cv=none; b=RUJ0ijYaocAlk09mRhvLSTBPYVJu7LhCXxneuqFGvLjf3c3u9C0hV7wIfEejToMAhopwPxnoWHtIuBkxYMpPHdZH/edEDVMZ1r+zxK/+5f9uhH3d6E6vK2pUeUDdVPwCRpxtvRX7MtuQX6OZ5WVaOmftoluCnIECDM8UlRw62GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785854498; c=relaxed/simple;
	bh=inRu6Fbs7qThKSOM6o9E9Nl5mQBWDBycP7w/R/gVngs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DiIhGX7RLhTpmxEH7nzJMnGwqMZl0erhy4uB9KmyCVRKh2cqiQ+D3FRKSU/sYlQSI9KPK34vKCg8K7KTmn5rAR+tO/yFGB+0o2uMtkbrL2I2TXS1kNKqZ2k6QFcAUWzdeOteAaA8R4Fjq4p8bSYvxlnMxOHV5QwZXjQxktRGdnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1ZUeJZTS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1ZUeJZTS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=N+1oknWBbbON9BY5ecDuc0sEWzNlET//gb3rEdeh9dE=; b=1Z
	UeJZTSG3izFxwlrJtuzKhrETd1JhkCo9tlUOiiqsjNqoV7GW5lSKFvO8PQhsCz7F+weHtmsSmKtqR
	0iGNg+f+vpsYoDEWJTyV+4/bw1/3+QNq//KtLiGtLCep1CguoUmst3OHrPOuJ5CqXP8nhAHBg72if
	jDHbB/Khw3tZEzU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wrGKa-00G0IZ-MM; Tue, 04 Aug 2026 16:41:24 +0200
Date: Tue, 4 Aug 2026 16:41:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Artem Shimko <a.shimko.dev@gmail.com>
Cc: netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v5 0/3] Add DAPU Telecom DAP8211R(I) Gigabit
 Ethernet PHY driver
Message-ID: <5ce27e97-bb4a-4f17-a445-16331af0a6f5@lunn.ch>
References: <20260803101734.270821-1-a.shimko.dev@gmail.com>
 <94fb1a6e-71d6-42ae-b221-cc03a820d2e0@lunn.ch>
 <CAOPX746ZFCE1XwXJ1H0gEaBvdvq-4GAiPTKkT-3XvZi0n_f73A@mail.gmail.com>
 <2ccd6223-dd40-406b-8869-021881755f72@lunn.ch>
 <CAOPX745w-Hfq1k+H0qLWQjsjY-5bb_9N9sw5LBJ0QM-n4j+D+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOPX745w-Hfq1k+H0qLWQjsjY-5bb_9N9sw5LBJ0QM-n4j+D+g@mail.gmail.com>

On Tue, Aug 04, 2026 at 05:08:49PM +0300, Artem Shimko wrote:
> Hi Andrew,
> 
> On Tue, Aug 4, 2026 at 4:32 PM Andrew Lunn <andrew@lunn.ch> wrote:
> > That is a very odd setup, half the 2ns delay the RGMII standard asks
> > for? Do you have an explanation for this?
> I think this is a poor example, as the delay is due to clock inversion
> due to a mismatch in the PCB parameters.

Ah!

Another things to explain with a comment...

	Andrew
