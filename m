Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEF63F8711;
	Tue, 26 May 2026 12:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779797980; cv=none; b=kiiOTQr7bF0iM1XSuCRag8FSYTQ76d+nLUP6IM7wkTrCNG+UTMoTNgZcmvrPiBWhLNX37DWm93xu4kabWgPabmbgK9NjodLMRtP1gXqOf3Jauhn6ZHATwaQ6TMh/Vnum/KdL34YAHck6JArbdV5PcZD0PUdqxKZ5EEuzpwrDlRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779797980; c=relaxed/simple;
	bh=az1CT3ei7AGakJmcVHCnEPrNvq0CemFpBgIfSk3tROY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J+RacByx8FnZHHSMQdmQ4eP9Xmn5SsDJ/OXzI9aKqFHC8Xpzt1Uo7Y4PBDdlR+mMlZTzoj6Op7pQoIBCzbAD/MHFlJkliWqtQbQnJ0lzV6IZBXWX5XSEQMPe4MeWEHUfTYMY7/mv+dgjibETPz9g7x94zoGEJNpgvCMzRiYQKF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dn5Pa96Q; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dn5Pa96Q"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=okTz4Jqs0iAtd+B5XhfG494EbCiJgBGdq4nUN7G2S+I=; b=dn5Pa96QkToDcyKBiPGnMeVCds
	gwvTSBZ4Xgva0IBZMz0EPbieiOX6Y9qBvF5RlXlSHLnJgLwfUon2DDh4a+pzKeJOwBkx4w4FSDXdL
	ln3hubYmB+Jfchl2uL+jDPEWNA2BY/1NyeM17NFNgywpjrrSu45JRkwDicGHtFbKP0CE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wRqkp-004a4o-EN; Tue, 26 May 2026 14:19:27 +0200
Date: Tue, 26 May 2026 14:19:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: cedric.jehasse@luminex.be, Luke Howard <lukeh@padl.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/2] net: dsa: mv88e6xxx: add support for
 credit based shaper
Message-ID: <499bb8cc-190d-4845-8dda-ded4ca6b9bdb@lunn.ch>
References: <20260526-net-next-mv88e6xxx-cbs-v2-0-13eb49c29b83@luminex.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526-net-next-mv88e6xxx-cbs-v2-0-13eb49c29b83@luminex.be>

On Tue, May 26, 2026 at 01:41:13PM +0200, Cedric Jehasse via B4 Relay wrote:
> Several of the switch families in this driver have switches with AVB
> support. The switches with AVB support have support for Credit based
> shaping. This series adds support for the 6352, 6390 and 6393 families.

Both Luke and Marek showed interest in your patches. So it is a good
idea to add them to the Cc: list. Comments or Reviewed-by: from them
will help get your patches merged.

     Andrew
