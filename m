Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A647279907;
	Tue, 27 Jan 2026 19:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769540551; cv=none; b=uhQunfyaFzK7gdvkXi3SQ6eb/Iq8hsrT6HM/hlB1V4ENz+G64DN92xN48motUAFtXXVhzVN0moV29PbAM1JFnMQSOsi0+SQvNeKnQ6NmzYpK23n5WtJAPFprBuYR1tfzqkJmlBSA/iJ+DBFJJfOkNkfw42jIVHHOwcS1VZr1P1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769540551; c=relaxed/simple;
	bh=nDDKui+nmLwsef08FXAeCc3zLpeUXKvscJ0Wvnvl/U4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MX5/qTKarzCMT6XbIzsv5PsTs0PgNTs2GV3Tsu2y0iDQ9UmR2yNkRAcNbQAv1o1umqHf5MdtkB9O+VTBgeGALeeCQJY5oZQ/8rptiwUmrYamnJSPnRjPdINMumi3VLKRpF4yWn+vaEgqdI4CMGKCfvVHZlgi5SoeMd9smFqmse4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vkoKS-000000002Qf-1CML;
	Tue, 27 Jan 2026 19:02:20 +0000
Date: Tue, 27 Jan 2026 19:02:15 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Paolo Abeni <pabeni@redhat.com>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next v8 4/4] net: dsa: add basic initial driver for
 MxL862xx switches
Message-ID: <aXkLt2ON-XdO4kvK@makrotopia.org>
References: <cover.1769053079.git.daniel@makrotopia.org>
 <18c6a24eef8617abb5073569fee162f1aa1c06ea.1769053079.git.daniel@makrotopia.org>
 <c2e191c4-dec4-4e42-b108-353778d9bd18@redhat.com>
 <aXinOE7KIFIm5dUK@makrotopia.org>
 <5e7c2f9c-bf49-4564-91b3-a639ef1c97d8@lunn.ch>
 <aXjQKoXBIAkV06XE@makrotopia.org>
 <8f267321-25fc-447f-8ff3-5d5b2d844d30@lunn.ch>
 <aXjirjOsc5IJFHfH@makrotopia.org>
 <60e9939b-dae6-41d0-8008-3c38a4dd4030@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60e9939b-dae6-41d0-8008-3c38a4dd4030@lunn.ch>

On Tue, Jan 27, 2026 at 07:28:26PM +0100, Andrew Lunn wrote:
> > Some of the error values are useful, it *is* good to know whether eg. a
> > bridge cannot be allocated because (for what ever reason) of resource
> > exhaustion (-ENOMEM) or because of otherwise invalid settings (-EINVAL).
> 
> We need to be careful with these. POSIX defines ENOMEM and EINVAL, but
> not their value. So you should add ZEPHYR_ENOMEM and ZEPHYR_EINVAL,
> just to make the name spaces clear.

I'd rather just not interpret the error numbers returned by the firmware
and just catch all negative numbers and return -EIO, like you suggested when
we discussed the RFC series.

See also https://patchwork.kernel.org/comment/26697045/
