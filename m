Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B38350C2B8
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 14:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789569692; cv=none; b=f8IVQl/F9eRRXmB4P/CA9gQEsQ4fvAQYXOnCpu8apQtDB3N4cF/E00ApaMdwacgO5ua3VQhsQGjMWu4yrNkDuF1VDG203XNo8psvswKcjEOV0DELbdYMi6srywzCXlBHK/caVd1+mwnCfRus4uUnak80+x/sFvE50yeSQkqndrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789569692; c=relaxed/simple;
	bh=mjqfdTowP5r3irrt1LbGxpiTstxT+W8ZjVF4sU+bepk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hc8TcVMmDuWKlyxQrZrSblOXgllt1rVr4z8e+E/BwwuDrdpULQ000Xhz6ZLPQ9SAaGcAGWK1mGw4iEv32xbfxXEd4RNUQ57V0QyvCyOWbHCSoYmbfaVjm2bNx0FJnGxZT/wHEjf5A8M59fSvLAfKqsRX6IVYVjkPBEjGT6ES4lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WKXghM7y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WKXghM7y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E33FD1F000FF;
	Wed, 16 Sep 2026 14:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789569689;
	bh=82sCX0TvTRzwmUtFpBAYs8yegtSun3AYeBn0vabgQE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WKXghM7yA4vICpye4shwC3xDWVWYBes52zArD8yKuEWlIbNMB+oUPA5/BkUotObvW
	 61qnzLhyMbG8jt5NiBK62i/Efwfg1yQFhjfDXZ9445IapfoJGWeqlj0LnkYgvI/ECo
	 +cyx5E6RaoWLqB6+vcIpaH9Z5ehWthv9iloNPFBzDSUJEfLWmk52q4Vfkhz4TvPE3+
	 Okg9P+sk2MI/rCLnrmq5BXLpWa35YOHecY2zeQNLGL+6Polx+qJ0dLDMh42aXzhDJV
	 JcQ7UACePlkuIiOv7eUIDK6EGBHuuIqUVI9uMeKqiukiJDW3CENOt1klARIAyhtl6Y
	 8dvqDb01ZeBMw==
Date: Wed, 16 Sep 2026 15:41:24 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next 1/4] ixgbe: lower IXGBE_ITR_ADAPTIVE_MAX_USECS
 to prevent RX starvation
Message-ID: <20260916144124.GM51261@horms.kernel.org>
References: <20260915125538.3975870-1-aleksandr.loktionov@intel.com>
 <20260915125538.3975870-2-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915125538.3975870-2-aleksandr.loktionov@intel.com>

On Tue, Sep 15, 2026 at 02:55:35PM +0200, Aleksandr Loktionov wrote:
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> At the current maximum of 126 us the minimum bulk-mode interrupt rate
> is ~7936 interrupts/s.  Under sustained full-line-rate bulk RX traffic
> this is low enough that descriptor ring starvation can occur before the
> next interrupt fires.
> 
> Lower IXGBE_ITR_ADAPTIVE_MAX_USECS from 126 to 84 us.  This raises the
> minimum rate to ~11905 interrupts/s (~12K ints/s), providing enough
> headroom to drain the ring before it wraps.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

