Received: from mta0.migadu.com (out-90.mta0.migadu.com [91.218.175.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED94175A7F
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 07:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789628829; cv=none; b=oDhyVI9JkoeGN954YAF3j8615GhjKJFUTwPoWb3PxfVeB0cPEKn2Fp8UameSrJNwE1gfF8QuCyFkEXfy0QmvQwXMi66VyFj71dKTp0znet0I0SB+sFswaRYLbTPI83VF2tZhPtDj+JPOahjYM9BIlQ+UE5FX+8U+Z4YTZBCPnrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789628829; c=relaxed/simple;
	bh=dKN2BOj8ckTbnmNRwjRJVyt2q7SHqLuYzWP+M8RH07M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JSva2+g4xe8xGiaxy6ahst9aIgmmhASUfCOE1MHX6RtO5ECp6wyFvAgGp3/2m0BvAix4NWBOarVp0JaRW3+67iFNHEevZCti5cuFoSbuY9bHkEs05LxprdLWRhWmIVzvQ8JxCVh0f53UyrPATfWd0bOwXT4eTU8nh8nb7yjWAjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lG4LtXHT; arc=none smtp.client-ip=91.218.175.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lG4LtXHT"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=dKN2BOj8ckTbnmNRwjRJVyt2q7SHqLuYzWP+M8RH07M=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789628824; v=1; x=1790233624;
 b=lG4LtXHTRzLitPvMRaxzmBoJZk6tUtNdipq55uhZn9mSeuJKkXuup368k7dYfzW4vDK8E7p6
 tC9Zjfz2xmRk1OUT7Nroi7wQvuBfMqNdqclt01v62wBW0nzExn3JrGyH6nzmVLiW5Imp3Keq8IS
 2nBQcPqATG7Pn0wQ+oD0lfr4=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 652112a0f8d0066e;
	Thu, 17 Sep 2026 07:06:54 +0000
X-Mizu-Trace-ID: 652112a0f8d0066e
X-Migadu-Flow: FLOW_OUT
Date: Thu, 17 Sep 2026 15:06:46 +0800
From: Chenguang Zhao <chenguang.zhao@linux.dev>
To: Andrew Lunn <andrew@lunn.ch>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, Chenguang Zhao <zhaochenguang@kylinos.cn>,
	syzbot+694b49f41098a5df4fd7@syzkaller.appspotmail.com
Subject: Re: [PATCH net] net: phy: allow phy_detach() before netdev
 registration
Message-ID: <20260917070559.GA85254@pc>
References: <20260916021505.238990-1-chenguang.zhao@linux.dev>
 <d523dec3-7075-47d9-8ac2-6b3c9d6cec3d@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d523dec3-7075-47d9-8ac2-6b3c9d6cec3d@lunn.ch>

On Wed, Sep 16, 2026 at 02:12:27PM +0200, Andrew Lunn wrote:
> On Wed, Sep 16, 2026 at 10:15:05AM +0800, Chenguang Zhao wrote:
> > From: Chenguang Zhao <zhaochenguang@kylinos.cn>
> > 
> > phylink_connect_phy() may be called from probe without RTNL while the
> > net_device is still NETREG_UNINITIALIZED. If PHY bring-up fails,
> > phy_detach() uses rtnl_dereference(dev->hwprov) and lockdep reports
> > suspicious RCU usage.
> 
> What do you mean by PHY bring-up?
> 
>      Andrew
Hi Andrew

PHY bring-up refers to phylink_bringup_phy(). The call chain is as follows:

usbnet_probe
  -> ax88772_bind
       -> ax88772_init_phy
            -> phylink_connect_phy
                 -> phylink_attach_phy / phy_attach_direct   // suceess 
                 -> phylink_bringup_phy                      // fail 
                 -> phy_detach                               // No RTNL
                      -> rtnl_dereference(dev->hwprov)       // lockdep warning

Because RTNL is not held when phy_detach() is called, rtnl_dereference() triggers a lockdep warning.

Thanks
Chenguang
