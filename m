Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5E6274FE8;
	Mon, 23 Mar 2026 15:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774279979; cv=none; b=lGK5tt1XHbPgpjqngTOTMRI414IM1ndPWmtytS0+7kQfoeFCKdwCtVDVi9Cx9Umu/ydNGMPc5ozQm1Q/i+G2uyfA+Bu8TzO/noNhSJnGAfAKBbPT0YiNfW5cUEhAKlfV/PdV1lsaBnX8O3vaOVnjgX4hDhKtFfsGOYBLA+m7x/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774279979; c=relaxed/simple;
	bh=BhJNsSNxfDVBLV0zI54hKmZm4+Esc4e2YJ+SpT9RI5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fi1SsQlhPsCgZdqqkKCpqospXp3IgM1VvlmmYgWuJbiBMKkgOfEdRfhGVEXuTQUsAoM6EM3YqYiHIjrEa9tY50WlpDma6NuL5y+5hN88SjFG8PcWXDgWbJDucYSplNkutsZDrxXciSUlhpbd2NY+QY4+SZ2KOtq3POiAlBtvdrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tW/1wg/S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tW/1wg/S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2219BC4CEF7;
	Mon, 23 Mar 2026 15:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774279979;
	bh=BhJNsSNxfDVBLV0zI54hKmZm4+Esc4e2YJ+SpT9RI5Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tW/1wg/SHw7eup63o0KCTC1RZF2dUWHPrBjidDb4uxNH2/x68d4j5prCpHynSCGZS
	 jf8jeVF7QGcYomMSfnHnjOCRQcoIsj9dsPeZIUNDHDshQtF39m03s0HIoV38ujnHnh
	 uaMi7cdcD1fT5oaLzGOSsHNFUdR92D+iG2UxG1S6W5s/bP/s6HNQ3mXvtVuWPnPzon
	 CpH4Ka2VDdi7WuXEevooeIG0WBP2/y+e7SyUu8xIt/CcLQokeSKyKNV80BQtiUY2yv
	 OyXspwun2hnzLqAmkkt2kfcbgtcfA2fquJZbCCC+Fy7L7TnTHItbFMhKwu5mFfhmtP
	 JsXvTb4TpZ88Q==
Date: Mon, 23 Mar 2026 15:32:54 +0000
From: Simon Horman <horms@kernel.org>
To: Alexander Wilhelm <alexander.wilhelm@westermo.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: qrtr: fix handling of confirm_rx field
Message-ID: <20260323153254.GB112574@horms.kernel.org>
References: <20260320-qrtr-fix-confirm_rx-on-big-endian-v1-1-e1a337dc1a38@westermo.com>
 <20260321101926.GY74886@horms.kernel.org>
 <acDi3JiSjbr4whVK@FUE-ALEWI-WINX>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acDi3JiSjbr4whVK@FUE-ALEWI-WINX>

On Mon, Mar 23, 2026 at 07:51:08AM +0100, Alexander Wilhelm wrote:
> On Sat, Mar 21, 2026 at 10:19:26AM +0000, Simon Horman wrote:
> > On Fri, Mar 20, 2026 at 02:28:52PM +0100, Alexander Wilhelm wrote:
> > > Convert confirm_rx to little endian when enqueueing by using cpu_to_le32(),
> > > as big endian systems otherwise interpret the value incorrectly.
> > > 
> > > When receiving, apply le32_to_cpu(). !! ensures the result becomes 0 or 1
> > > in native CPU endianness, so this conversion is not strictly required, but
> > > it is kept for consistency, clarity, and future safety.
> > 
> > Hi Alexander,
> > 
> > It seems to me that the conversion is required if the code
> > runs on a Big Endian host. What is your thinking on this?
> 
> Hi Simon,
> 
> Yes, that is correct. The patch fixes the control flow on Big Endian platforms
> only. It has no impact on Little Endian systems.

Thanks Alexander,

Please send a v2 with the commit message updated accordingly.

As this is a fix, please base the patch on the net tree.
And target that tree like this:

Subject: [PATCH v2 net] net: qrtr: fix handling of confirm_rx field

Or perhaps, making the subject slightly more descriptive:

Subject: [PATCH v2 net] net: qrtr: fix endian handling of confirm_rx field

-- 
pw-bot: changes-requested
