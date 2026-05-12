Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFD31A3164;
	Tue, 12 May 2026 11:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778585234; cv=none; b=JvjOXPi49fEkm2Nhi9OgqV88ulcDVNOHxFCykRuOXBYefRNAmIO5U272A0pcMr5hjk0ph4Tf0ySsXllVW3ZRlZdHIK/3tRDamr7Nzk6C5Ry6Zqm9uCeXCLiCOUjHKqcmxkjCyhFaDcq+IkqR1LI8FVdcmzrBPkCT8F/uSl3oHEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778585234; c=relaxed/simple;
	bh=jePavObmjyERWQk0agzV8yguh2X/KLVCwD51cAY0e+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PR/VJYjj2gwtHpY27cVqjIwwcxVwRDUS3I5SCHR/cwPnX/mvR2aVgG6Nx44WUmypNN58iluN+59OS9G6FaSEgsmYPNFJAvGu5FlwSYArPr7FcneHZU/ZRXHDhGOKzZ42PMT3yphuF43v2aq5ReBZWUgo8RRNg3cw+qoXcSt7Ygs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BUoTsNeV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BUoTsNeV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A27AC2BCB0;
	Tue, 12 May 2026 11:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778585233;
	bh=jePavObmjyERWQk0agzV8yguh2X/KLVCwD51cAY0e+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BUoTsNeV822CGWByQK5NHU2Xtd/9q85DYU3WsLAI4uyQzT7+/1pN1NM3DUzpy59CZ
	 h6l/nVXxfF4xdHd66+ieK9BFID7wxvagaJrzh/d9aHgo6dKwAMBo0nKngakOncoSJ2
	 WG647eYU5oK5o1QJ2vGJG6qz+ZDJIuK0dXkbTRSaM3uLdHJnaSlm/tmvEVciYWkFxr
	 j89j4FHEkCgQ845NO7mLPIjh4y5rMj2DJWT+loGkbU9QUmqerLDZdcSYdsxniHmpDp
	 GTpEFd3PeF0EGzcyfQXSx8XSOT5Ar9z8/stu3NSfaiwmVv+ptDM3arQhWA43zB4W92
	 DoK2iLtMv1Eyw==
Date: Tue, 12 May 2026 12:27:08 +0100
From: Simon Horman <horms@kernel.org>
To: sukhdeeps@marvell.com
Cc: netdev@vger.kernel.org, irusskikh@marvell.com, epomozov@marvell.com,
	richardcochran@gmail.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, vadim.fedorenko@linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/9] net: atlantic: add PTP support for
 AQC113 (Antigua)
Message-ID: <20260512112708.GL27589@horms.kernel.org>
References: <20260506135706.2834-1-sukhdeeps@marvell.com>
 <20260508120156.3060-1-sukhdeeps@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508120156.3060-1-sukhdeeps@marvell.com>

On Fri, May 08, 2026 at 05:31:47PM +0530, sukhdeeps@marvell.com wrote:
> From: Sukhdeep Singh <sukhdeeps@marvell.com>
> 
> This series adds IEEE 1588 PTP support for the AQC113 (Antigua) network
> controller. AQC113 is the successor to the existing AQC107 (Atlantic)
> chip already supported by the atlantic driver.

...

Hi Sukhdeep,

There are AI-generated reviews of this patchset available on
https://netdev-ai.bots.linux.dev and https://sashiko.dev
with some overlap between them.

I would appreciate it if you could look over these and address issues that
are either introduced by or effect the functionality of this patch-set.  I
suggest leaving other pre-existing issues as follow-up so as not to expand
the scope of this patch-set.
