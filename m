Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F0D48986C;
	Fri, 31 Jul 2026 01:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785460229; cv=none; b=Kx5j5vciHVpXuE+fs8o2n1qozY/lX/p+m1LnbRAUgJaXQDd71QzX92macxVb3Tdt4+/dVeiVLzv0QGn5wSnHan/KOjyeSbNqSYW2rdGihmvp4JqdYfvaMX3AYd3he7QSFh+aL170taQieDxd9fIsvVa3juLMd3IVSaRqjNVdc/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785460229; c=relaxed/simple;
	bh=LYEnLgoEWxlA5WhI0qzv+Ewlf2gwhJwtbcSPUiMpexY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CgRrxkmKUpezh+LyZ5Prp0DLWDCm2O7uB49FqGxOn+ZxyRYeoIAaynaLp40TEzyXClf2QOu+PBdckzUpkETV5t5lFoKpyf0peCYgt7IbqmpN5u4xUKLOcvr8LUm62J4Zpmda3/rDvDYNgym0Fp0OM297WvKSHUEa0r5oCzaCcug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EW0DybYT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EW0DybYT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 579941F000E9;
	Fri, 31 Jul 2026 01:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785460227;
	bh=ryZkJzv+oPiqpys8luF54dVvEDhJeA69sd6+yHuqlzU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=EW0DybYTL9CgviHX5FLsl5Gv1Fg/ErlRClqCcUPLWJT9ZjRVqGmE7ymslBcigvFVF
	 O17EA7/f+Toy6UViLYeDnQnYxHiFTTMCBQPX1Tgn3kCqNzmUkc+zx8peQk3jzi0+aG
	 ukoADpsWjKbrqpQljwq89L9/iUdKz2GUpUXgUYO1+gWs2Z9Ztrg0Th+5QzFmgCY3zF
	 mUOftm1tFOPazFQjNWn3vrj1bEJuM/HiFrYYQfhC+ebaFXkW7lalXFbj0irPnPBMjv
	 o4/8JkS9QT9AMuSsTnu+ixahvnGbJeJFSIO/hV4+x87oEtLMWwKzPteVvOtUuO+5Z2
	 MKIgEGKdZlwVA==
Date: Thu, 30 Jul 2026 18:10:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "illusion.wang" <illusion.wang@nebula-matrix.com>
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 corbet@lwn.net, horms@kernel.org, linux-doc@vger.kernel.org,
 pabeni@redhat.com, vadim.fedorenko@linux.dev, lukas.bulwahn@redhat.com,
 edumazet@google.com, enelsonmoore@gmail.com, skhan@linuxfoundation.org,
 hkallweit1@gmail.com, linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v22 net-next 01/12] net/nebula-matrix: add minimum nbl
 build framework
Message-ID: <20260730181026.614aea2d@kernel.org>
In-Reply-To: <20260723040110.91410-2-illusion.wang@nebula-matrix.com>
References: <20260723040110.91410-1-illusion.wang@nebula-matrix.com>
	<20260723040110.91410-2-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Jul 2026 12:00:53 +0800 illusion.wang wrote:
> +config NET_VENDOR_NEBULA_MATRIX
> +	bool "Nebula-matrix devices"
> +	default y
> +	help
> +	  If you have a network (Ethernet) card belonging to this class, say Y.
> +	  Note that the answer to this question doesn't directly affect the
> +	  kernel: saying N will just cause the configurator to skip all
> +	  the questions about Nebula-matrix cards. If you say Y, you will be asked
> +	  for your specific card in the following questions.
> +
> +if NET_VENDOR_NEBULA_MATRIX
> +
> +config NBL
> +	tristate "Nebula-matrix Ethernet Controller m18110/m18000 support"
> +	depends on PCI && (64BIT || COMPILE_TEST) && !CPU_BIG_ENDIAN
> +	help
> +	  This driver supports Nebula-matrix Ethernet Controller m18110/m18000
> +	  Family of devices.  For more information about this product, go to
> +	  the product description with smart NIC:
> +
> +	  <http://www.nebula-matrix.com>

Let's skip the "For more information.. " and the link the sentence
below pointing to Documentation is enough. 

> +	  More specific information on configuring the driver is in
> +	  <file:Documentation/networking/device_drivers/ethernet/nebula-matrix/nbl.rst>.
> +
> +	  To compile this driver as a module, choose M here. The module
> +	  will be called nbl.

> +enum {
> +	NBL_CAP_HAS_CTRL_BIT,
> +	NBL_CAP_HAS_NET_BIT,
> +};

This enum is unused in the patch.
Please don't add unused code, it makes the submission hard to review.

