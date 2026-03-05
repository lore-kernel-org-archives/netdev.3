Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE71A3B5319;
	Thu,  5 Mar 2026 15:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772723064; cv=none; b=LTshbsh5ew6Z6vvYiXGSZV6ocBNZXuprXhjBGJu3W3kZ2WwfopJdWzIJRDj8gnwhW7YitFJeB1R/2RfRoqc7XCVROc/AMoiIGb4F2A8yGmv9Oh9Bdz4QLA/airFru4xJzKvssXnvu7+KF9cqD4XLB61L8JmaLrMUACxAOcIpdN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772723064; c=relaxed/simple;
	bh=1OVnh6CzPYUJxdpqTC2AXVSTmiQssLsyZMXeAG6UPUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LkcyU3tq6rih1p01R0JWLaFBKJJiO1U8BMtRn+k63w2L3k8oFDj8kWWOVBqow9fxLra3cxxpANY4ctOilRC4wLRPD+nmVUPbXiyEAzwksaNxcX3YdmruWP8jB+Zqsr1A7Juh3P0lKMRNRfL8mMEdgOEhufa0vY23iLFgzWtxr38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=CFXXtaTx; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CFXXtaTx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=fdheodiH8/yJzsJGMG0+ZHgayFkz52bxcYCH/aBcXzM=; b=CFXXtaTxBNRNSp89ZBfZwKbA/L
	61IsIsKfIMbpYFFe30LiCR3rsrhOfFjV8xW8eISWODCl021ZCuslv0PezdPzb63eu+ZszVPfRfHSV
	ZUlqYoUNXwKg8crT5sK86L5ULKUeFydNCYTMiY+VeLubtkZ6/DoXjWVxYZeFtFKjbh+A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vyAFK-00AKmn-Ng; Thu, 05 Mar 2026 16:04:14 +0100
Date: Thu, 5 Mar 2026 16:04:14 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?=C1lvaro_Fern=E1ndez?= Rojas <noltari@gmail.com>
Cc: linux@armlinux.org.uk, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	mnhagan88@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: sfp: improve Huawei MA5671a fixup
Message-ID: <a628cf95-a0b5-447b-a514-96b2232d599b@lunn.ch>
References: <20260305125235.51286-1-noltari@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305125235.51286-1-noltari@gmail.com>

> +static void sfp_fixup_huawei(struct sfp *sfp)

Please avoid using a vendor name. It is unlikely just this vendor
produces an SFP broken like this, other vendors will break their SFPs
in the same way. And then we will want to reuse this helper.

So maybe sfp_fixup_ignore_tx_fault_and_loss()?

   Andrew
