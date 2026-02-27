Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E922F1FCA;
	Fri, 27 Feb 2026 03:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772163038; cv=none; b=pBmRZoRpKco3kz7m/34G83FT/zxtACudY9y7LmaAl+NnTroGro6iBcT+7bxCGBZwuxFOsh985QNU7+fKru9dr15tqDC8CHejR82gB4yg2wjKZDDCyeDZNxG4DQ6PpmtM6XLIw3DKgqzyWwDjo2ZmvD51YxpWzs2Ho/O6MDZQsb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772163038; c=relaxed/simple;
	bh=uI3j6DRmBkXWULFnXqlQf+BiSX/P55PHnGunZeBTc+s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R4fjEcmJZF0bSrxPCeFWTWpWwMwmGewXK1+yLxkocREUyfABy2tf/yZgD73Q+yGdzVTyrCIRKTmwA7Gh8apti2A71rqpoykJW5Td+Bp323pJBAZYoBrfJXarka543QPu7IXlLGG3DRb2NYi1PsqGVB6JPDUP/WG/HNQPKYZhoP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BW6DautK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BW6DautK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AECAC116C6;
	Fri, 27 Feb 2026 03:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772163037;
	bh=uI3j6DRmBkXWULFnXqlQf+BiSX/P55PHnGunZeBTc+s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BW6DautKTGhv0C64x2ff1vFvE0EadOhiHa0SZz+Io+yBuUEFqypxT9r+s1XuUDuDU
	 T3VKYFABAFmlHntUmABb+NaLcrSAmKYys9wZ//LNjNy+bSwww1F5HxV4KZL1CDProa
	 ctNQzZh+pbeIItHyrszQJ2IFNXGiQvk6Ch6ZqckFPAh+AncfI+iOVB1wLQInlrCYVi
	 VVPWvAi3/Rz9ye5feE+rbz64Zn5L69lRHa2HHvRqosHlTk+/er4wOlF4y9YZGydxHc
	 xQsGU8wcNfDiqF0l9/o+1JiJ9IF5K79SLSTgLood3ZDpqK1ZEErHQgVvMHxlN0RSdI
	 83qZAsL7k0xaw==
Date: Thu, 26 Feb 2026 19:30:36 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: tomasz.unger@yahoo.pl
Cc: horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nfc: pn544: i2c: Replace strcpy() with strscpy()
Message-ID: <20260226193036.39b93497@kernel.org>
In-Reply-To: <20260225172715.75756-1-tomasz.unger@yahoo.pl>
References: <20260225172715.75756-1-tomasz.unger.ref@yahoo.pl>
	<20260225172715.75756-1-tomasz.unger@yahoo.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Feb 2026 18:27:15 +0100 tomasz.unger@yahoo.pl wrote:
> This is a bug fix, not a cleanup.

Could you include an example path thru which a firmware_name longer
than the array can reach the driver? On a quick look the input comes
via netlink which sets the max length appropriately.
