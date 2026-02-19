Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E431862A;
	Thu, 19 Feb 2026 00:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771459970; cv=none; b=ubIUyA6jdej5803mFrMskVYpojDALqtYHxkjSKvjDdFyr1MIc04EbQn4W7hoahXmvI21YMmN9ygCprRtucwP+vPzgR0sEHpah9Kb8sL08zv0O/PAxGWQCjDjoGYRB/OMosg5Mae7ICaVpF1GC0iNkwMFUCuIZafQSNryFCwysyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771459970; c=relaxed/simple;
	bh=o8etze+y3hMNq8PDJ9/sdrv4OaE6MDSU0wyIKkz2Blk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qyoJF9WzVhHDC33wXcP2DkvyvkLC3r3NMenepLv5gaGg1NvpgsqNXP9H6mj5bSGFmVc6xRRddPOQ3Ugd5w0gqGTe/w020YTc0zSqRzQ5zSF7sk5MUdpUYBuTklH3B6NlgwkoCMlNWcC9sfBOAzxBch1VGSq8CcoSE1ydNe1eCHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VjHrZs6r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VjHrZs6r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C30C116D0;
	Thu, 19 Feb 2026 00:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771459970;
	bh=o8etze+y3hMNq8PDJ9/sdrv4OaE6MDSU0wyIKkz2Blk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VjHrZs6rfU5U1NRha30heUrhaAgM5PNqRswWPpxU9kqnh1c8enIyc/eI4MvSsJWW+
	 agltxEj3hGoh5wpDYIh5uCiEG7t1PygWMHM+aD8uQmRWZVsJhRPwK+8h/okKv5Z/ZQ
	 kxhqCjvdx+uFKiblyj7ThZzesXUeoMLG6SWaShfck4XTXBbyfqmrk+xhUpLOWiWMT1
	 S7Mgzx5ZZM0CXmAkkzdvPzLU9zQPo7SdB60d01IgXE5/PkrGpl0tOlyB7pOo3PaNgp
	 /N8iElV8uAsXqNxhP9yrnphjjw1V4aEeJh65m0cBGWLII6FODreoQ2NZHaQqdT5fbm
	 yPOCrp40x0mQw==
Date: Wed, 18 Feb 2026 16:12:48 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Satish Kharat <satishkh@cisco.com>
Cc: Leon Romanovsky <leon@kernel.org>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: drop enic maintainer entry for benve
Message-ID: <20260218161248.1cfbb278@kernel.org>
In-Reply-To: <20260218182610.1138802-1-satishkh@cisco.com>
References: <20260215074139.GA12989@unreal>
	<20260218182610.1138802-1-satishkh@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Feb 2026 10:26:10 -0800 Satish Kharat wrote:
> Christian Benvenuti is no longer involved in the development of the enic driver.
> The <benve@cisco.com> email address is no longer valid. I will send a separate
> patch to update the usnic component.

Please send a combined one. Why would we need a commit per line of
changed MAINTAINERS file.
