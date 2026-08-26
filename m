Received: from mail-108-mta168.mxroute.com (mail-108-mta168.mxroute.com [136.175.108.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653CB399007
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 18:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787769175; cv=none; b=raKnHrZEQPmqZ3EXaDpJ9EjMRF7DOyZT4F1oE+i2UbvL3yt9+gDIFAMngSH+7DE2Us+cU+eK8R1yX21UCtD+d8tr4iqgOeWlr9pCgeBlwVP5bPVv6rhc4c0QeoPj3neD+a/kvLef8FZy2B0kc6sNNeacXI5WSVD91eP5e6XioKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787769175; c=relaxed/simple;
	bh=MDzOo0vJhpPf3JYPDUSu0FsN1VRM4ZboiTN726K+WIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JNFfStNg/hxoIjlDbwaY/YRwuH49C5YwNHLJ02BjPUAoQAt9Gy/vjf3f6q3whh1gM67V5w66NpSdvtuDSwGY8i/Hs+dCLLJMw6IayI9B8daD+AeO39Z67lBCdpLNNQcuiPSqFo4wPRgzE6bJHMNIf1/Yai7iGWvIRJwh+xRGIi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wii.dev; spf=pass smtp.mailfrom=wii.dev; dkim=pass (2048-bit key) header.d=wii.dev header.i=@wii.dev header.b=xAgaOhMm; arc=none smtp.client-ip=136.175.108.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wii.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wii.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wii.dev header.i=@wii.dev header.b="xAgaOhMm"
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta168.mxroute.com (ZoneMTA) with ESMTPSA id 1a03f53b7fe0001089.008
 for <netdev@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Wed, 26 Aug 2026 18:27:26 +0000
X-Zone-Loop: 0284b4761ecbd84d94273a58fe1bd608be0c11833def
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wii.dev;
	s=x; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc
	:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=mOrWrsVxNY4DeKzF4oVpyrcTmPtW8ML65wACYvxEaYo=; b=xAgaOhMmwZ7SlDvKpdqUk5kn/U
	Er7LKw8sIjIMgSadrb7joPJ4ln5IQ8QZmy947SskB70pIIYIwYMQCCLQqiLNLdkf6Uh9WPjZ8t0sQ
	E06hVcdBsdQHMpt0h4eoNqqF9h+69Cs/tWEgwBBY0NhYbJgZNqtdL5igkd49KMVySG0RpMw+xdThS
	mLOnwBm5aCVNSxhX1ZeC632sRj+BYCRDdXZVBUKGgdgtsiBELODKTNWqW167zSfD+Rssz/dgbj2vd
	JGpOFTGnDqVaeWm6+fCXqSbDznusZwlf6W0ltLx3NysG1ik1w24g4w6DlF2YL53ZYvf78CKhbsjvg
	MCMyredQ==;
Date: Wed, 26 Aug 2026 18:27:04 +0000
From: Richard Patel <ripatel@wii.dev>
To: Andrew Lunn <andrew@lunn.ch>
Cc: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Steve Douthit <stephend@silicom-usa.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ixgbe: fix MDIO bus leak when rejecting SFP module
Message-ID: <ao8v+E27nWRW7g7V@wii.dev>
References: <20260826042945.2344686-1-ripatel@wii.dev>
 <87e4aa92-4687-4fbf-b632-9493932c349f@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87e4aa92-4687-4fbf-b632-9493932c349f@lunn.ch>
X-Authenticated-Id: ripatel@wii.dev

On Wed, Aug 26, 2026 at 02:23:25PM +0200, Andrew Lunn wrote:
> On Wed, Aug 26, 2026 at 04:29:45AM +0000, Richard Patel wrote:
> > This code path failed to unregister an MDIO bus owned by that
> > netdev, so when unregister_netdev() tries to tear it down
> > (via device_del() -> devres_release_all() -> mdiobus_free()),
> > it trips over the leaked registration.
> 
> Maybe look at using devm_mdiobus_register()?

oh nice. Will submit a V2 tomorrow with that instead, thanks.

	Richard
