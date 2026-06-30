Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB482F8EB8;
	Tue, 30 Jun 2026 22:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782857584; cv=none; b=TtzgR+3I/4tC7oArEpdAgoFOqu5DDR1fINnFjqgsxri65RRcBqnt92z2Wrv1KpiRjZeCL4YB3jZH8ani4fjr3ry5ogq8icn2D/s2t+ENjn9j2mH0Cz3SyHY0BE0JnNp2+3VOio2fGV1j2ufkWlB5WZV0nV+tAAwAJZWNH6MUHIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782857584; c=relaxed/simple;
	bh=pVaNPAiZHcCsuAZrxZrAghRmSJ3WNIhmwoyfEq/qn7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XjnVmRKJ4qRCtam9gasOZpx3qIzisLEYI+VGv3/73WbfLv94/hc604T6bwTO5KihjWSBVOxMy9xBIKnTjNjb8VvRhJhslflTKo/RVBlpc1mGrus4J/Jj+l2r3oIsCj+VRlRMmiWJpSX0F3P+G/uMg4VZif9BqjAsh1WA2UZx5W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=X6dix34P; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="X6dix34P"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vFxOls3IFq32IXUZ+EhLPVbUF4zVGpElzFwfmaeUM+c=; b=X6dix34Pp6FjsDY/tP9+r31HoY
	sM9F42D5qx3wEOuXD812lgYZU7eU6EtbXJt22YRybGZBcp6b3hWRyq9c3H0GTcVynxw6P6GNi6+RQ
	7wdEo+jf5otkSxi2UPga/hyuyjC+uhzBPfCqFVUFobA1oo/6Dq5JzOql5+ol0UQVMdFw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1weghM-00A3Gx-V7; Wed, 01 Jul 2026 00:12:56 +0200
Date: Wed, 1 Jul 2026 00:12:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/4] net: dsa: motorcomm: Dynamically
 allocate port structures
Message-ID: <83ec8bc4-5c6e-4b44-ae38-93229433daaf@lunn.ch>
References: <20260629183137.541341-1-mmyangfl@gmail.com>
 <20260629183137.541341-4-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629183137.541341-4-mmyangfl@gmail.com>

On Tue, Jun 30, 2026 at 02:31:34AM +0800, David Yang wrote:
> With support for LED introduced later, struct yt921x_priv will be 17k
> which is not very good for a single kmalloc(). Convert the ports array
> to a array of pointers to stop bloating the priv struct.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
