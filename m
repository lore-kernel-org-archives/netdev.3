Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFFC2441B8
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 13:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780406079; cv=none; b=L0EDDernY2KBjNwqkaAR3j8whgPNKMOFFceixhi4Ji1muHDPUF0i+vJxx9O2+X3AfB6llbWoyAGRrbjDfqLJZyLDiyXyOf9oOs3gUXFsxiwFtXYMNAUTyvFTo1POJkOQSX2nKhHuLgJVn/I6eMzOQGuJ3VIwF/P0wCwdbuKNJg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780406079; c=relaxed/simple;
	bh=MFApm68By4k0Kr44EXAgoLdlNMPDX44vW3plH4MrTxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cG1mvngmooXmgR1Ad1iyJ3c+2u47TcVuuvP1XWZEIiPcF/2ZoM9utQWuVcS3kHNRYa0MrRVW8zpbwAnmYg3dM24QB0nPA1X0NmrvpZU+WEgBcjwogOD/YLHeR7kkGagPPM83d2APrm5jcct0KKirQfOZZcEmZkgjBJkIm0P1+Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=x3YCFDDD; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="x3YCFDDD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=VKs59dNKmRvI1Hmlk25t2+mwRctoV974/4uKPiMDGpI=; b=x3YCFDDDvzUX7leJXsQbsXQu01
	+SYZMHNXF+RhyJufNzuClcmU4NV9fTIwZGmiuH2qRO+pcdpsQF1Rv5gBr733KIMYPHiUxV11ACFcd
	uBxamZ1vmtYDeuw73frUJV2epqWv2QKKpU9ZU0A6e4U57GyXpp8APM7HaGPxouao0MD4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wUOwz-005gxN-74; Tue, 02 Jun 2026 15:14:33 +0200
Date: Tue, 2 Jun 2026 15:14:33 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net] net: txgbe: fix module identification
Message-ID: <9945fe19-815b-4e27-8446-c21cdfaa16d9@lunn.ch>
References: <F3DA1ECDCE0A1E9E+20260602025443.332456-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F3DA1ECDCE0A1E9E+20260602025443.332456-1-jiawenwu@trustnetic.com>

On Tue, Jun 02, 2026 at 10:54:43AM +0800, Jiawen Wu wrote:
> For AML devices, there are some issues where the wrong module
> indentified then configure PHY failed.
> 
> The module info buffers should be initialized to 0 before the firmware
> returns information. And DECLARE_PHY_INTERFACE_MASK() does not guarantee
> zeroed contents, so explicitly clear the temporary interface masks before
> setting supported interfaces.
> 
> Rework txgbe_identify_module() to validate module identifiers through
> explicit type checks instead of relying on transceiver_type heuristics.
> When using the SFP module, transceiver_type could be a random value,
> because it was read from an invalid register.

This seems like multiple fixes. Please break the patch up.

The current DECLARE_PHY_INTERFACE_MASK() is not great. It is mostly
used by phylink in structures which get allocated and zeroed. But here
you have it as a stack variable. Maybe we want a new variant which
includes = {} ?

    Andrew

---
pw-bot: cr
