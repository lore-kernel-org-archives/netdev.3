Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A168454CF5A;
	Tue,  8 Sep 2026 13:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788875738; cv=none; b=XD210k4V3a+UQdWtmxTJTfGL9vSTeeVOBxn+sOgKfHWIs4qkuUYg71lF4WKsdmyfkeW0pA0BX65qVhC7GhEeDFCewu7WpX1AHggsgjZy5GT14/6SQj7//iyqDHeRciASpRvNwEVU+ha3FnXztM1ftHKM99uqWXZhQFmLJOr9c9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788875738; c=relaxed/simple;
	bh=gRCn3+YDyLRrz1q17xa+w8RvUKk71+uNLnSqxsscRvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vj5fOCOS6c8PugMrSPwsB96vHHuvE8W4YwbLFpsVfYoCLc44fXvLNSBzvwN43eSz/jTPavD5zC/MkPsoNYFJdITtEfXz7AAhucAcclqtwD6pLdA15gWsOLa1dzIKbhEQ0Cr8q9E+yQSiWJq6T/n1RAyv1qo2OxNsthOafYh/01w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=D3rUuibF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="D3rUuibF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=e8c+U2YARm2oC1guPl0swGVCIkIvkFhElMlfvGpbdAw=; b=D3
	rUuibFuYcn0Rqs2FOYiJVKY1soksmz9W2uaWWbwMS0NiNtvMqd23cAMdZS1WnV9EHwkwyw5LQUD6t
	o7Z68boAfNqJvcaVqio1Rhnv9Tqi12bTCX6a4ZaeO6EW84Owvq5Ue/JdRcrQU2nzPGPefCGgmjNTL
	ROyKOmgEvbSehEM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x3wHr-003uFS-AG; Tue, 08 Sep 2026 15:54:59 +0200
Date: Tue, 8 Sep 2026 15:54:59 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Potin Lai <potin.lai.pt@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Oliver Neukum <oliver@neukum.org>,
	Samuel Mendoza-Jonas <sam@mendozajonas.com>,
	Paul Fertser <fercerpav@gmail.com>, Simon Horman <horms@kernel.org>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Cosmo Chou <cosmo.chou@quantatw.com>,
	Mike Hsieh <Mike_Hsieh@quantatw.com>,
	Mik Lin <Mik.Lin@quantatw.com>, Potin Lai <potin.lai@quantatw.com>,
	Adrian Ambrozewicz <aambrozewicz@nvidia.com>
Subject: Re: [PATCH 1/2] net: usb: cdc_ether: add NCSI passthrough support
Message-ID: <8414bb12-1b9a-4d41-b9a5-20b60d5f9ce2@lunn.ch>
References: <20260907-ncsi-over-usb-v1-0-6b74d2f1196c@gmail.com>
 <20260907-ncsi-over-usb-v1-1-6b74d2f1196c@gmail.com>
 <08083379-6eb9-441e-a656-0066c9006dd7@lunn.ch>
 <CAGfYmwUTsqgDQCP1q=XxCyW=R+a61urg_Jnnw_3-oJfw_BU38Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGfYmwUTsqgDQCP1q=XxCyW=R+a61urg_Jnnw_3-oJfw_BU38Q@mail.gmail.com>

On Tue, Sep 08, 2026 at 08:45:36PM +0800, Potin Lai wrote:
> On Tue, Sep 8, 2026 at 2:17 AM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > > +/* NCSI operates at 100 Mbps */
> > > +#define NCSI_SPEED_BPS               (100 * 1000000)
> >
> > Why 100Mbps? RGMII is often used, running at 1G.
> >
> 
> Since the original NC-SI specification was designed based on the
> RMII protocol, simply set the speed to 100 Mbps as the default
> for this virtual USB link.

How is this used? You could look at the USB link and return 1.5Mbps,
12Mbps, 480MBps, 5Gbps, 10Gbps, ...

	Andrew
