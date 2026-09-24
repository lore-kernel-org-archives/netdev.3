Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F383737CD2C
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 12:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790254562; cv=none; b=oPEEDNYqwTtEr2hlCXsR/YoZfaFHEk2Arqrw/KgNLqD5ikv+GUaLK6fNp8y+uw+0u89ZL9vGcw99JmD5xVJQrLqkzt0zMW0/CCBdgDvnzMexIJYyXWkZxphlDP94JHDttVXSvT6kx9jA/vJNlj4QzUquaI2CmcUSq+fjLOUqjp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790254562; c=relaxed/simple;
	bh=f4IL8ktIID3HRkyS5P9IxAaspWHx9Fiz9cZVNH4Dx6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GU+EYwHohlxyuRNB1Y258XAM4k7r/wXBU6FmOErbyVTlIGcsONeUErFThUUNqVujxTuetAqiUS8DC1lqKsC/c3kVNJbYl+COsPB1fSxNE0Im/bY7/FzzzMPcA73hs2OWY/xyqPTVnOSgdmlOB+3KLPTs8nhfqE2VyM5iRebigXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ioPLwIS/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ioPLwIS/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 306981F00898;
	Thu, 24 Sep 2026 12:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790254560;
	bh=6HrSyFKugGP4vj4AL7ort5Z45m1Jcuf42KNiplphNLA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ioPLwIS/wYaeNUQ+rd6cF2SnDkZx+IrSv/awzYo2V6P0vNdEvPAVLyR4uL4vJNhnE
	 ibJZDEnu+hK0Ny2ydYIUjrYUqi0/zVdk1xRuvB+/2qBp5WZWcLnb79CBqe0Vf8TGeA
	 4vMabhMGjBBIRpmZQuD4GNo2jPgGGd8T68az4pzwNNuGW2iH2PoaEDzy1oyflCoiCi
	 T7ackH9WNFXxrz/1pG7DS9xc5nrwb3g+ac5dLYUH0eON+tA5nPyLPVZGW1N9IozIE4
	 HFDs+OJIAC6TUXm58be6u2fg2l3f3ydA25KK9JitRFQFQHf+3V7QPHZwaxGLap1OEN
	 a5LMVN4RhaBgA==
Date: Thu, 24 Sep 2026 13:55:57 +0100
From: Simon Horman <horms@kernel.org>
To: Potnuri Bharat Teja <bharat@chelsio.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch
Subject: Re: [PATCH net-next v2 00/11] cxgb4: Add T7 adapter support
Message-ID: <20260924125557.GE13925@horms.kernel.org>
References: <20260921233041.61093-1-bharat@chelsio.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921233041.61093-1-bharat@chelsio.com>

On Mon, Sep 21, 2026 at 07:30:30PM -0400, Potnuri Bharat Teja wrote:
> This series adds support for Chelsio T7 adapters to the cxgb4 driver.
> 
> The series extends the driver core to recognize and initialize T7
> devices, adds support for T7-specific hardware resources and firmware
> interfaces, updates PCI initialization and resource management, and
> enables adapter operation through the existing networking stack.
> 
> In addition, the series updates several auxiliary components to support
> the T7 architecture, including PTP, ethtool, filter management, CUDBG,
> and debugfs. Support is also added for T7 multicore debugging and
> diagnostic infrastructure.

Hi Potnuri,

Unfortunately this patch-set does not apply to net-next.
Which means that our CI did not run.

Please rebase against current net-next and repost labeled
as either [net-next v3 ...] or [net-next v2 REPOST ...].

Thanks!
