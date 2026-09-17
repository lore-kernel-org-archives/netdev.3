Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB364381E95;
	Thu, 17 Sep 2026 02:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789610619; cv=none; b=nWLpUWB3FHGtlivMuSXVtiJffFTphAovenq9u89EEoaH81dgznGdBRzYaJEeMsrwZzvPu8Y8Bxbbn2Emq5LKy8audRzXyZ8a8ET1WGc/HLHyhGbMnGQRacGFhVwWnsjHel9yu01GchLmg+5WBfnExlblrp2Vm5R3K/K6SsvMtWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789610619; c=relaxed/simple;
	bh=enWAOudfzXD8gjSzSTZoVJI3Y0wcSZdzpIZYlvg1oLY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=idf57L8J/OkAicfqe3nYq+cmP6llfNANGJj49vB27mIeU7ACdgRCRHFSrV1tJy4YM4A9plUD//nMf6xtinmPQJIR1zai49q9jL9aoxewwcu25mxJJi0Zj7hsvnV/0iyI1AFadMYeM1PjD698sRxnjxlGXXfsZw0Ks3dAEb31q5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZTN/Zat; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZTN/Zat"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CACD1F00893;
	Thu, 17 Sep 2026 02:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789610617;
	bh=vhXpPKM6RKinXGV1u0BDzpb9tv924NcbS9GLdFnncKs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gZTN/ZattszFI+QIlTOg2byqzLdKg4twg2Gn2BpFCnJcI3A4a2MZn67RaftqfwHs7
	 ulc+dnvN27mfVsZ6EhzOmcLwYwObc6eDHVt1zLVfUuYFfzdIulHexeXukQVzfJKqUZ
	 qKLYzkWcXiuVRhnCo/uPIAuMTRd+eWQkdubSdM2PdSs4iOp5Vgy26ScBaOICUhkgPc
	 DH5paOxYEeotL1SQ03VLolTn/3EXqF7EwlFBIFKPGHnUgau8dsnzPRGXbd4kI4hWgl
	 HTE2TXdk9QIIHsZTosLAzLvJ8UJuR9AjQgw68bLs+gtO4pR5E4v2j+Ic7OL1lLLkYi
	 wuuPrS/B+FJfw==
Date: Wed, 16 Sep 2026 19:03:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Subrat Pandey <subratp@marvell.com>
Cc: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>,
 <andrew+netdev@lunn.ch>, <sbhatta@marvell.com>, <rkannoth@marvell.com>,
 <gakula@marvell.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH net v6 0/2] octeontx2: Misc fixes for RVU drivers
Message-ID: <20260916190336.1115e38d@kernel.org>
In-Reply-To: <20260910062657.3712256-1-subratp@marvell.com>
References: <20260910062657.3712256-1-subratp@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Sep 2026 11:56:55 +0530 Subrat Pandey wrote:
> Changes in v6:
>  - None. Rebased onto latest net tree.

Could you please add the links to the previous posting in the lore
archive going forward? Eg
https://lore.kernel.org/all/20260910062657.3712256-1-subratp@marvell.com/
for this posting? (just starting from this posting, you don't have to
dig out the full history)

It's useful for checking if AI comments have already been replied to,
if not the review itself.
