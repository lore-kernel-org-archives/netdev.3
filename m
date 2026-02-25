Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFEC1D5ABA;
	Wed, 25 Feb 2026 01:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771982292; cv=none; b=fH/IreIObx6PzMgvEphrLPgWZFkFLxm/BWKUUZ60nKO2fTvaffo/WOL/0jdM31+IzuiO+l0TzAnriDtY0l+2ByyZxZRIN1MbDLzjvINBVN9AnLoNROBhNq9Z7GWmsJFQNUKiYCRkYZa4GgHveQGEHXKZbzoQssjQIsYZobLwiXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771982292; c=relaxed/simple;
	bh=CfeoXobfFIGaHcNgFaB3YnG0bdcXJOBenrhLSAUabIs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AUxTtM93mJE/4tzajeVCkL25Tr8Yy0Li2QZqOADUJ4xtX8ZTd6geoSWsyVjZrimlImOYGO0f/R1Ii7UfomIGU0VSqqDCzFBh01/olGoaD00/sTvITII30xa2auFcNglwXt5CNj1gb5s6QCG3hAqU9wW6UbBFuFGNo0vngjAyPmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qP0WEVdq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qP0WEVdq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA11CC116D0;
	Wed, 25 Feb 2026 01:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771982292;
	bh=CfeoXobfFIGaHcNgFaB3YnG0bdcXJOBenrhLSAUabIs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qP0WEVdqalZYkYKwQhI/LCBGaqhkVW1TaNFQa2ub2Asqe+YqUpmhd+jrQNLGJLZCE
	 ymrMbFQ7f0ZTRzN5ySkH8e7e06fyRChDZVvUXlToSb274aZm7j+EgWofNzMCJqVf5c
	 Iw8GHpsSYozIRCp6oAO09y+h9lGfICi6KT4xJAXsv8ALQUGyFQyj8sV/xRVUXEcGse
	 wH3mWIWeSYZMhS7Dg8HNJY7Qe45xl1oYylPB1etxo3ZRr1spn2RguwbZYWfBloXWuE
	 lp2Kx8aF1UW3HNjOZnvVzEFS8JHlUU8NQNQ11lxndNuhZpas9r0+jlReyR8HN/9OTf
	 uX8vD3mYyuPOw==
Date: Tue, 24 Feb 2026 17:18:11 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Gabriel Goller <g.goller@proxmox.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] docs: net: document neigh gc_stale_time
 sysctl
Message-ID: <20260224171811.642708aa@kernel.org>
In-Reply-To: <20260223101257.47563-1-g.goller@proxmox.com>
References: <20260223101257.47563-1-g.goller@proxmox.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Feb 2026 11:12:54 +0100 Gabriel Goller wrote:
>  * removed documentation for gc_interval, as that sysctl is not used
>    anymore and doesn't do anything.

Thanks! FWIW we can probably also document gc_interval, since it exists
(in a separate patch). Just make sure the doc says it's unused /
deprecated and since when if it was ever used?
