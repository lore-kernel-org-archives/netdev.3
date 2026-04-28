Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1E63E51F9;
	Tue, 28 Apr 2026 13:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777381437; cv=none; b=jZeYHe2Nz0u7pLk0pgM4WkKS/Jaoek7ij1BUCG8ed+lCnipq/jKp0glbyOIxS7ZQD4bvv4IykoOimj5T7ftmTOqgRRv1ClPzVFgdJulR++RMedrJ/IzhjOwBOJSsB4IGBIrGFjk1hsf0dhlit3jAnELDHH5AIe3EP8b8De+7n6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777381437; c=relaxed/simple;
	bh=xZbP5qcEMJ/KrG9R1lnVooWrMadkmUd4Nrp/Za6BggA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZgHHXWitEr/G37FKyCkWPzc0+a/RgLEiKkVQCmMb5bbdMl1062goReN2yiP6i3OcdFlgdXqPbrp9WEaMT6mJC7SOFVhfqGbbZUlFqISXfM9xE5JhfsUBdgSOXzVsFvjMXnvo9Y6AqLWMH3MyKeEEN1d+QNJmmpoPhBm27C3qkUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=5xqdZvhA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5xqdZvhA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LoZmBGb/wpi4U8bvGQZ6PW1zMxptFxMPpGFyLLh+QA4=; b=5xqdZvhADpst2KhHPL4DyPhtXp
	xMaBcuXPH+bu6WvC/3E52OTGQi1elEMUzvH+1s1OXeI/YJPGB5ijEpKjycXA/xRBvklKfTe8JtvT/
	uz1OUuziruCQuk0gQeldAYTk4Bb8GvVasxlS4Zarjf3+k4WfLZqx8UDOQy0HE+XcTNPg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wHi6T-000Krv-C8; Tue, 28 Apr 2026 15:03:53 +0200
Date: Tue, 28 Apr 2026 15:03:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Denis Benato <benato.denis96@gmail.com>,
	Ingo Molnar <mingo@kernel.org>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH] net: fealnx: make driver work on architectures without
 I/O ports
Message-ID: <17af8886-7be9-411a-8067-feb59eae2c7d@lunn.ch>
References: <20260428021145.40930-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428021145.40930-1-enelsonmoore@gmail.com>

On Mon, Apr 27, 2026 at 07:11:36PM -0700, Ethan Nelson-Moore wrote:
> Devices supported by the fealnx driver support both MMIO and PIO access
> (they have a PCI BAR for each). However, the driver always tries to use
> the PIO BAR on architectures other than Alpha. This makes the driver
> not work on architectures without I/O port mapping support. The comment
> explaining why this was done explains that some x86 systems have issues
> with MMIO. To enable the driver on all architectures while preventing
> potential regressions, change the driver to only use PIO on x86.
> 
> Issue discovered by manual inspection.

Does that mean it is untested? Probably broken?

> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

Given that nobody has cared about this for the last 20 years, why
change it now?

Please stop making changes to old drivers, unless you have the
hardware in your hands and you have a real problem with it. If those
conditions are not met, you are just wasting peoples time.

If you want to do something useful, please spend some time reviewing
other peoples patches. Or get some real hardware in your hands and add
new features to its driver.

    Andrew

---
pw-bot: cr
