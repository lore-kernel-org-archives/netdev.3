Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794147670;
	b=bH3NstSz/o39NHf60aGNKox7x7GPLLYh/+Ax8kPT/8dNPrp7jUZ33XqOEJdO5HY6STX4
	 fVPBkS3jqvD4fO6bPST3mhD5r84qo+/COT0XLOdkmJ3p06lObNxLVg7R4o7jyszHU/O2+
	 Epc631yZUyBBvLoHOXfQZp0KlyHjRBtUqIupPZD37BgIS8l1LwRqyMUTPslZ2k7K798Ko
	 akzhLC6Am1iVNC6k53JtbVh3AZt+Kf5RPboYItUI1/Dur0dJOFuzxcCDmXVeBCwImS0e2
	 bzs5BDdcJcBzn+c0j4Qprri/ppswe116EN4y/rc3XiNqbxihFh/hy9nxbFYR0E61Klw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794147670;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=kQtf2YGeartcwb3E5bs7hWbnN6qZi5AsGs3oh/sS15M=;
	b=ODMIJczeo160WIlzQWBi7u3lPZ0wXuvjzGYauTYRdpv5L7hOe/9Ttgl0f6/PXn5JhUR3
	 oc7vTbAFS6I/9TvMdxXYnEnsQirLcagjnw3pJmKCueoJMaBXTrz+oIZYrs4AFqr/nYZBo
	 ZDxK4GzvhN7q8GA54TZHyo6yUV11GRPfOnnV/LaIFDl2tDVm1mzVGXuUCKxi7IcUKVrEy
	 2qRRZgoN3jAtd7RHOyTM3o9yksUoN/4ockFuzqlg4VZuhfiKH4Q6gFMiDR+Dy8GggYFPl
	 oRD2P+UYZYbPNfbNmrQKNkoWoiOwaiJGcODq0qJ0+ZY+6+CTCR4pyM4SEhjlb9BNKxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="bXjH0l/D";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFA0606A31C;
	Sun,  8 Nov 2026 14:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=bXjH0l/D
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD191F0089F;
	Sun,  8 Nov 2026 14:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1794147669;
	bh=kQtf2YGeartcwb3E5bs7hWbnN6qZi5AsGs3oh/sS15M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bXjH0l/DRRa0mduKHwWjZwmw9uFcEyQzx+MFRVVe8sDNtDoXlWfbN7GL4R/VGETnF
	 /w0UYUadX/uchHJamEVmQL5gl52L+OpUKt7saublI3UEtknGe6TQwmC/JVJZwfY8Sw
	 Zbyh9mf3d+gGYnj7EL+jTl8rlbuwITy1Bp+ODT6E=
Date: Sun, 8 Nov 2026 09:21:08 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: David Miller <davem@davemloft.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	driver-core@lists.linux.dev
Subject: Re: [PATCH net-next 2/2] net sysfs: simplify creating empty wireless
 directory
Message-ID: <2026110812-angles-guru-473b@gregkh>
References: <0a0a7987-abb2-49c8-bc16-3938233ae9c5@gmail.com>
 <675f4353-125e-4168-a617-c0d1fb519045@gmail.com>
 <2026110816-crate-tightly-8560@gregkh>
 <d85b02e5-d9ab-4535-ab82-9b8184fbd1a8@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d85b02e5-d9ab-4535-ab82-9b8184fbd1a8@gmail.com>

On Sun, Nov 08, 2026 at 03:12:04PM +0100, Heiner Kallweit wrote:
> On 08.11.2026 15:06, Greg Kroah-Hartman wrote:
> > On Sun, Nov 08, 2026 at 02:46:03PM +0100, Heiner Kallweit wrote:
> >> Now that an empty directory can be created with attrs being NULL,
> >> make use of this new functionality and remove the dummy attribute list.
> >>
> >> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> >> ---
> >>  net/core/net-sysfs.c | 5 -----
> >>  1 file changed, 5 deletions(-)
> >>
> >> diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
> >> index 5c0402389c6..f58b59e1126 100644
> >> --- a/net/core/net-sysfs.c
> >> +++ b/net/core/net-sysfs.c
> >> @@ -910,13 +910,8 @@ static const struct attribute_group netstat_group = {
> >>  	.attrs  = netstat_attrs,
> >>  };
> >>  
> >> -static struct attribute *wireless_attrs[] = {
> >> -	NULL
> >> -};
> >> -
> >>  static const struct attribute_group wireless_group = {
> >>  	.name = "wireless",
> >> -	.attrs = wireless_attrs,
> > 
> > Why does this want to create an empty directory?  Surely you aren't
> > adding attributes later to it, right?  If so, that's not ok either...
> > 
> 
> For compatibility reasons. See 38c1a01cf10c ("wireless: add back sysfs directory")

How long do we have to keep that?  That was a very long time ago, 2012,
why not just remove it entirely now?  And if the sysfs core hasn't
needed this since then, why give other people the opportunity to abuse
it this way as well?  That doesn't feel like a good idea to me.

thanks,

greg k-h
