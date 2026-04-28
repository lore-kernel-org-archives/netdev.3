Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C4D450915;
	Tue, 28 Apr 2026 18:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777399908; cv=none; b=CYQGsUECTBTsF62saUg8N0UJ+q3LH8Dse8xMuxy3x+bjV5unds0hiKVRF830iGYy0yirjTXiMS/Wp64Yp8neEzZytmtjrYLy44PFbtwNIsaZJzqWOkgX1qha3OYtOChjpXY3PktW/+hHybWIAX+B/MTDx2lcGnTnDcaHK5Q1YmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777399908; c=relaxed/simple;
	bh=rpf9UYlcIuRl2od1r3mJoQ4Jq0BJBc3aqYpS37c8IRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IPGHHvdwu+8kGgAVCuv3hXX7DZ4XyHKAiDShOy6FCPOPjsS9Q8Gu8Yw1cPbtTXzOW8f9WHei8GAnpJJq2bE6gMjivGqlCI+UZfTOYr1WaYHZ2XpepG2AnqZgDYC9SkdsA/brdIt5MX/7UQcZ6GMtMkGWTBb36r2G1BcN0pOd1iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NCbiZXEB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NCbiZXEB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Iw9DEVFTVf3n5vvCjO7XaiE/hgoDHXcO/TXkzV3Ay5U=; b=NCbiZXEBTEFgiq7cq9mPFAMZcz
	0xZz1T9ew8Iw7ARvmksbyb5y2H2w5pTa2gAPx0nQ525blC8o7S4wDG7O4QgyTYUkpynhnLz/E176h
	Jc560Il2wo8H6zA/JJbf0oYX4OPWfelSd0i5UkZ6vFTt7ztYPUCdJiluGkBLMVP1eGc4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wHmuA-000O0f-FL; Tue, 28 Apr 2026 20:11:30 +0200
Date: Tue, 28 Apr 2026 20:11:30 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: mike.marciniszyn@gmail.com
Cc: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] net: eth: fbnic: Fix addr validation in pcs
 write
Message-ID: <caa57970-7377-4986-ab62-f3f5d4054625@lunn.ch>
References: <20260428172810.175077-1-mike.marciniszyn@gmail.com>
 <20260428172810.175077-2-mike.marciniszyn@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428172810.175077-2-mike.marciniszyn@gmail.com>

On Tue, Apr 28, 2026 at 01:28:07PM -0400, mike.marciniszyn@gmail.com wrote:
> From: "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>
> 
> This patch contains a fix for addr validation in fbnic_mdio_write_pcs().
> 
> Cc: stable@vger.kernel.org
> Fixes: d0ce9fd7eae0 ("fbnic: Add SW shim for MDIO interface to PMD and PCS")
> Signed-off-by: Mike Marciniszyn (Meta) <mike.marciniszyn@gmail.com>

Please don't mix fixed and going development work in one
patchset. They should be applied to different trees, etc.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

    Andrew

---
pw-bot: cr
