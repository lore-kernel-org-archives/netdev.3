Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15312E175F;
	Wed, 25 Feb 2026 19:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772048150; cv=none; b=Mv1oujsHmgZwOZekqLrJEndiYj9FKRMM/lZxpNHP2I45FyGksGk7OVOzmATUU9d9xzY2YNfhWBW9lRsVZY6/tcPmXh2PuWI1eskji6x1WUDv5qJJIgYkKcqPyHW5+Mj3Ouzkg3eoid89l8lwCLJfUi+ajNuvuH+JRZLhKgCHl4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772048150; c=relaxed/simple;
	bh=LCcCGykLEqUy1dDs5e+ctne0AhEZqRPJSzXFbWQkanE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVlVBolWM0KXz9Ufm0XRWzQ0GJrlpmv7Pt7WfYFrGhFylaFvA/p+Um3LgMZ6l4YEbXQY+SND6udXn8C/D5DGQwTBh0JJT+7zg5k4iuSuXiIAsFf+Rr0JQtZ2t2zQMQuVwCWcfBAqJx1RYaRSFXBWjhbYhqzyTwtZcW5PvhcZ7wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DuUm8457; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DuUm8457"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89BE2C116D0;
	Wed, 25 Feb 2026 19:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772048149;
	bh=LCcCGykLEqUy1dDs5e+ctne0AhEZqRPJSzXFbWQkanE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DuUm8457BOfpyG2LF6Aawb2CnIyALtsyAAnPzQ6jyysWIOCEZuVVbN6gZRvd8ywmZ
	 SzdQ654EnIeoke7oBprsGnsOnJZG2OPZfs3zTBaWVXvDU7JbhiOuR/H/kqMdbuIAeq
	 EvDFGjc/OlaBxGldm7MJy1NU3GNJ2ct4NhEMmt9VH5eaJHj8gQHVKLDmMSDz9yZTFj
	 OCBw/WYQGBwPF34HcYWhKY02bWGUsbKSH02AO21SFnixMkxKz8ACdfyaBn6R5s3cOt
	 KE7dRgT9Ac9aQtvDKS4e47hYMQvUXtND9LHMlmF8pDKStiEQb3UvBkyolKAl9hUmIK
	 4Tqszr8GKHdmA==
Date: Wed, 25 Feb 2026 19:35:45 +0000
From: Simon Horman <horms@kernel.org>
To: Abhilekh Deka <abhindeka@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	nnac123@linux.ibm.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
	linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net/ibmveth: fix comment typos in imbveth.c
Message-ID: <aZ9PEaog5ZMr7LqW@horms.kernel.org>
References: <20260224153101.16935-1-abhindeka@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224153101.16935-1-abhindeka@gmail.com>

On Tue, Feb 24, 2026 at 09:01:01PM +0530, Abhilekh Deka wrote:
> Correct spelling mistakes in comments:
> - Fix misspelling of gro_receive
> - Fix misspelling of Partition
> 
> Signed-off-by: Abhilekh Deka <abhindeka@gmail.com>

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>

