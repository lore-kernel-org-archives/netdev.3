Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A454A49BD;
	Mon, 31 Aug 2026 17:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788196471; cv=none; b=BDiPGVXg65U3gNO/1Qk+ZxxOzKfc+/J9cmHG+1uAzxUkDKDHjdi34JG82d94aEUfBNmmbk4Gp0EtYrfzG3AMKKG2wccqvG83W0vobuMZfyXGLzE6Y88wP1w6o58VfjfM+3j27+I3yRzg0K7Hvh+Ytrf3TUeGqKV+7+nZc4SdRWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788196471; c=relaxed/simple;
	bh=EuYrqhbgzITCE3SQYpdNNeE4L189G9BPhKcSZqVreLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ki7eZV4Ef3LV5HxzNCCMmN8fjSzUdeK/dgYwYPTb0gnHEuFa2G+yuEW8gTi6mDKVIZcoIVp/KmRv1DAFSIV4IRS8oDGvpbD265+Dbzv9WKA6LapDJ4zO442AOGKZ4VPoXKvihmkwN7ysVnLqqG4DC6Cus8LkdIQ6X7hjGYDZ/Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ITG0MN6j; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ITG0MN6j"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Mg93C/BLYgHh/n0G+OklhbEZ69gCR/bdEIeH7kWAQMQ=; b=ITG0MN6jXzAjEeH42+oh9s8CZ0
	fqpgRXe8s30hgWWZ2a6Fu05Z1F6PqiA1mP6iNK3XCjSlCpUXy8Wmi4ncnza3+G/jVDeW+qiUeuK9q
	Xfp1OHPYdvwjJ+SmyOe6bph7E/LSnxpklT04hIkB/Tgqe3PAgEXRC1czEdPAmFLj1l+o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x15aG-002EHW-IU; Mon, 31 Aug 2026 19:14:12 +0200
Date: Mon, 31 Aug 2026 19:14:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <linux@armlinux.org.uk>, linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC 3/9] net: stmmac: qcom-ethqos: fix RGMII_ID mode to
 use DLL bypass
Message-ID: <74541d4c-5090-454f-96ad-f6c5baa21b93@lunn.ch>
References: <20260612-shikra_ethernet-v1-0-f0f4a1d19929@oss.qualcomm.com>
 <20260612-shikra_ethernet-v1-3-f0f4a1d19929@oss.qualcomm.com>
 <42355330-c22a-4fce-98ab-dc22b321ff16@lunn.ch>
 <ai93X/cNWHtEQsDt@oss.qualcomm.com>
 <82705420-771d-41bf-a4d9-ed94dff86ff0@lunn.ch>
 <ajF6q5eKz92ddqVl@oss.qualcomm.com>
 <apU8Yx08/PJiS9Xw@oss.qualcomm.com>
 <b36109c3-00e5-434e-a9b7-46049b0bff40@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b36109c3-00e5-434e-a9b7-46049b0bff40@bootlin.com>

> > With this in mind, I was thinking of breaking up this patch series into
> > separate ones to solve one problem at a time:
> > 
> >  1. Introduce support for "rgmii-id" using PHY-side delays rather than
> >  MAC-provided delays. Also, issue a warning if any other phy-mode is
> >  being used.
> > 
> >  2. Fix the DTS of the existing boards to use "rgmii-id".
> > 
> >  3. Once the DTS is fixed, remove the now-unused code handling non
> >  RGMII-ID cases. This should also allow us to remove the whole
> >  ethqos_emac_por code since it wouldn't be needed for RGMII-ID.
> 
> I'm wondering if we should add some temporary very loud warning for
> boards that use "rgmii" before changing this, or even just keep the
> actual "rgmii" behaviour which inserts the delays, as there seems to
> be lots of such users...

We cannot break in tree users, and backwards compatibility with old
mainline DT blobs is required. So for those, we need 'rgmii' to
continue to work as is.

So steps 1 and 2 are correct. But we cannot do 3. 

We can however issue a warning when 'rgmii' is used, advising users to
upgrade to a newer DT blob.

	Andrew
