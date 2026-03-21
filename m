Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8181E15E97;
	Sat, 21 Mar 2026 10:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774088371; cv=none; b=vGtkQhu1Tcr9q/xNajCeh8w8M1NfQvOsZ34IrvzA2wszfLBc4kgJspk1MvIakKjqKmqQg+PebcJnlI1Gh3ybdVUWbwnVvjGhu5w7a+92qI3lhr/+Q2yKLZo53+xYH51z7usyV1ILHZLCiApB+QEMzFNJmGnUSdK/VcE1XqNT2C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774088371; c=relaxed/simple;
	bh=iD9xikylZwtdXCM4YADJdCNPZRb5mmZ451xS3Yw7ovo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=phrehG/FoAG01kyQHM8N+MGYG7ZI1le68zgytnDmGfPpcABbql0YI1Se16Zsup+eUHV0rKaT72L9ZwjAcbhURn9XXZGJEuQ9UF42TyQV3nfmbc1MEm5QBBh6K8LnLvnHD3oX3Gds/U1sl58pI3eWBRe5T4LpWXw3KuPBWe0cHK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5YcbIZs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5YcbIZs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1753CC19421;
	Sat, 21 Mar 2026 10:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774088371;
	bh=iD9xikylZwtdXCM4YADJdCNPZRb5mmZ451xS3Yw7ovo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A5YcbIZsducdfLzfGWINWAWaeGHdkBH0q644fR0OypPcxW5xTrXVJftgiQyXSAJY+
	 WS8qnseQS9gY/rgkzNrJgvNYzzoFkCOsJen9TBIytJRmlqjbAg1HUNj/T87DA0dSU4
	 O6oO5P/+Yv/jgHTrWiLgbz5VGzRDse595oNRD8KmokLNXErBNEnj6OUXL7htGGN1oj
	 VkFuc1rFgzXGkc8EdttRbQHH4Al3x464Za77Q4uy/D4jqkpoVa63ioNa9v/YCZYslI
	 ZX9OIbCB16X2Q8K4p7s3lFADExWJrPcIjHg3+NjecFwZVuFFn85FD31z0w1lGTAwNu
	 K/UZLnX0YELrA==
Date: Sat, 21 Mar 2026 10:19:26 +0000
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
Message-ID: <20260321101926.GY74886@horms.kernel.org>
References: <20260320-qrtr-fix-confirm_rx-on-big-endian-v1-1-e1a337dc1a38@westermo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320-qrtr-fix-confirm_rx-on-big-endian-v1-1-e1a337dc1a38@westermo.com>

On Fri, Mar 20, 2026 at 02:28:52PM +0100, Alexander Wilhelm wrote:
> Convert confirm_rx to little endian when enqueueing by using cpu_to_le32(),
> as big endian systems otherwise interpret the value incorrectly.
> 
> When receiving, apply le32_to_cpu(). !! ensures the result becomes 0 or 1
> in native CPU endianness, so this conversion is not strictly required, but
> it is kept for consistency, clarity, and future safety.

Hi Alexander,

It seems to me that the conversion is required if the code
runs on a Big Endian host. What is your thinking on this?

> 
> Fixes: 5fdeb0d372ab ("net: qrtr: Implement outgoing flow control")
> Signed-off-by: Alexander Wilhelm <alexander.wilhelm@westermo.com>

...
