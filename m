Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7C6EEBB;
	Fri, 27 Mar 2026 05:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774588069; cv=none; b=I234lhCfxCoGOuAh/6x1kZDTaOr7Y2b8R2An+pZ2wFAiyEd3fQ8efoEWxnSiHAAo8nyCe1fIcvT56XikIk0VAofXYhqK5QOW6nDHT6cZATIBk4fjFTU6H168bewQi5jy51VgPB36ySg7+xafaphHioFrZR2+OfDDlFTO95glXXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774588069; c=relaxed/simple;
	bh=foyfzrQ1xblJ+uKERe5imDS8DSIRt3u5tExHq8ZHtuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+8pBw8t7FKuBNO3E+jkaHa3px2xZ/OZR/HV/gyn0ksjBvPH4F77ZdpP4KTEQv/jcQpeBGEwThGr5UvEkgMJ5xtePGIBlmDhAWdX+2d73sU/iSnfWPv8KGCZhj07IMtKyqB8cAIVmiK/qGD1Co+88abn+mDR+h0txqZqI9mWwA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZxhoOU5G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZxhoOU5G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B001C19423;
	Fri, 27 Mar 2026 05:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774588068;
	bh=foyfzrQ1xblJ+uKERe5imDS8DSIRt3u5tExHq8ZHtuc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZxhoOU5Gn9wujdx8qZ18UHU/0v+DMRePW3ZbybKA9tjR4flnT0BHDJsSj1NWL6rQr
	 8crQacM65bL9SxH9w5pIKW+jbo9jxgZ59n/LKPyAt4JPbAY+CIw4zNzzDFPYMWsGLG
	 /Ze2bu0dm2PpNNdat28mBV1SpMtY6gVAtZonYiZ5KwNZhT2gXbdMeSHa94zn0RsUhR
	 eNRj7DD3kt4bloOfluHvyNlOi03PZY6jIgeB8+QJZZY+4jrURiRWOdHKGXY58W/iIj
	 a4GgGZWviXWE1OX/FnoJuJi5b/wWrvUQJKAa0pQZji01uu/dVjzqAEniQIIJS6LrQM
	 Aa5Vr9rUTfjcA==
Date: Fri, 27 Mar 2026 10:37:36 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Alexander Wilhelm <alexander.wilhelm@westermo.com>
Cc: Simon Horman <horms@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: qrtr: fix endian handling of confirm_rx field
Message-ID: <hcxmfaai3qekgvh2vihnx7qdprungsrpmeu6vzz6mmxywjzifh@tzmmcx7olpxt>
References: <20260324-b4-qrtr-fix-confirm_rx-on-big-endian-v2-1-674fb3f4865b@westermo.com>
 <jwqcbxfhnzbxn3iwvoe3shtfttio2pjsah3pkwknzqvjx4xfp5@nmfkkgrjxkhk>
 <20260325180737.GM111839@horms.kernel.org>
 <acTV86xU6piDih4B@FUE-ALEWI-WINX>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <acTV86xU6piDih4B@FUE-ALEWI-WINX>

On Thu, Mar 26, 2026 at 07:45:07AM +0100, Alexander Wilhelm wrote:
> On Wed, Mar 25, 2026 at 06:07:37PM +0000, Simon Horman wrote:
> > On Tue, Mar 24, 2026 at 01:28:32PM +0530, Manivannan Sadhasivam wrote:
> > > On Tue, Mar 24, 2026 at 08:50:33AM +0100, Alexander Wilhelm wrote:
> > > > Convert confirm_rx to little endian when enqueueing and convert it back on
> > > > receive. This fixes control flow on big endian hosts, little endian is
> > > > unaffected.
> > > > 
> > > > On transmit, store confirm_rx as __le32 using cpu_to_le32(). On receive,
> > > > apply le32_to_cpu() before using the value. !! ensures the value is 0 or 1
> > > > in native endianness, so the conversion isn’t strictly required here, but
> > > > it is kept for consistency and clarity.
> > > > 
> > > > Fixes: 5fdeb0d372ab ("net: qrtr: Implement outgoing flow control")
> > > > Signed-off-by: Alexander Wilhelm <alexander.wilhelm@westermo.com>
> > > 
> > > Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> > 
> > Sorry if this contradicts my review of v1.
> > 
> > But as this isn't strictly necessary let's target net-next
> > and drop the Fixes tag.
> 
> Sure, I will rebase onto the latest `net-next` repository and send out `v3`,
> without a "Fixes" tag.
> 

FWIW: Adding Fixes tag doesn't mean that the patch should be queued for -rcS.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
