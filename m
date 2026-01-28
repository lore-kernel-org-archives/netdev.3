Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235E8228CA9;
	Wed, 28 Jan 2026 22:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769637660; cv=none; b=jl7ozk2MU+ixZdsmtP7xzVXqh5F51jOhBi7nmS1ZblLG2IsvthnQNXZK4Ui3CFthE/uOl7IQJRIAke+Fvff6y9a/5gs8DsH41cnSCJkzlYyhieyLCwU2DKeu4JsoQLvj9TachHoXejMHXX/5mSZS55eYNW9VwFQqCoTEBYGyyJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769637660; c=relaxed/simple;
	bh=Pr9W0TJTxQfkteJORcfkfTT3Vc43LHiOIR8QlDKL4hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VRpitrqZpfl/HwnsQI5dxOGiKcjovk2+TUAbUFzqB4O/OjAbx2N+2Wjo7+pThZqeaNL9WK/LHRF3Ypl3QoS4clrBXKwg1id058kZdCCe6rS+VCO0Pa05SGRj/2o0cNx1fiaKG7TcUz4FqZDYgend3oPuahK7VWl2NS8/RXSa+fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=QkKP87rQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QkKP87rQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=kL5xR/IwwRggd+tjtkDqeU/lLMEuwjvUemYV4fI7oXs=; b=Qk
	KP87rQ5pEIGipEENjVa7jpd7nimjSv10d81KWctU1peddGibgGy0hDFtj+JQ96J1yhjQdkuXHBfc8
	+ktcvBVsd/jddvpo23l8DZXZ1ju7ECMdsxbUVmtkhvAkqQnX9hnYvR9bY/HPuSiGXvOgl/3G6dj65
	wJAGA0NlL/N8/J4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vlDal-005HgV-JZ; Wed, 28 Jan 2026 23:00:51 +0100
Date: Wed, 28 Jan 2026 23:00:51 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: =?utf-8?Q?=C5=81ukasz?= Majewski <lukasz.majewski@mailbox.org>
Cc: Jakub Kicinski <kuba@kernel.org>, festevam@gmail.com,
	linux-arm-kernel@lists.infradead.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, horms@kernel.org, shawnguo@kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org, wahrenst@gmx.net,
	pabeni@redhat.com, davem@davemloft.net, netdev@vger.kernel.org,
	richardcochran@gmail.com, edumazet@google.com,
	andrew+netdev@lunn.ch, robh@kernel.org, krzk+dt@kernel.org
Subject: Re: [net-next,v20,2/7] net: mtip: The L2 switch driver for imx287
Message-ID: <ed0e1af1-0210-4461-8939-3e4e35d74dae@lunn.ch>
References: <20260126103400.1683125-3-lukasz.majewski@mailbox.org>
 <20260128022549.4151341-1-kuba@kernel.org>
 <20260128224125.246bcf41@wsk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260128224125.246bcf41@wsk>

On Wed, Jan 28, 2026 at 10:41:25PM +0100, Łukasz Majewski wrote:
> Hi Jakub,
> 
> > This is an AI-generated review
> 
> AI is going to take the "Maintainer's" job :D

We had a bit of a discussion about this.

Our observations so far is that AI finds different sorts of issues,
which human reviewer often don't spot. It also does get things wrong,
so we spend some time sanity checking its reports. So overall, it
might actually increase the workload, but also increase the quality of
the code which gets committed.

	Andrew
