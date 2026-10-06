Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE393222590;
	Tue,  6 Oct 2026 00:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791245851; cv=none; b=XnaprG3rxYGzvZTJOTPb7QKkdKCDrf1nvLq0AiWA8Y0lqtKitW1iJ/IhLEEf361ovm9HSthuwx8PEh8caMH9gsEJTPVZlte2JDtEXtSflxSaYtWp9/yYNaxfr+2MTeAgPMD7W7a5zEX+3SKBLdnS0tArloWWPS+mBFPcirATH0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791245851; c=relaxed/simple;
	bh=YfCBZy11AmPwUFv0kkCLdOCxb/nqYvkYuTvhz43gse0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YOANwTIqGtzbCSEOl9nxmnkaV6yD3mnuZCjZ3qnf9zn3GHNmZ312JYgGOMVj6rU6MO5ofYI3IPbKIjSDcAh4e8q8syOCDFnyW3WK0NihdZFIUBiYC2cSpgw1qCc6QyUbhTeo5fAv7st/RiX7P+QxjEJ4ZqMBeTmvXEHgpVVhTc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OijQB2Oa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OijQB2Oa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48E531F000FF;
	Tue,  6 Oct 2026 00:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791245850;
	bh=BAbymLWMnqGRppzlXX6fySkA0seOXWrhFUdz4wkHaKM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OijQB2OazLm2xZM2rsZ7K2I+t7rYtXl0lnLHiUiSx/g/N1Rdx2BHryu5VlewYZFSw
	 6IvDb1dRUd+m1mChQi4Z2YfQbgBAvSneDuccQcCNdH2Odo+FUZbq9ImrPRLPOwzp2s
	 EnZ6dhCJ67hP79dAS8cs/axaZvxcHaMjl4HFJ+iDgfJi0tpRDbSXukZOTnaRutXAYg
	 IhdYGgj1jmBNo9kfY7uy82JSEv7G/dpl4FohwFeOV0P6kC8ADGogPH9NiMUvuFiS/d
	 HzM7P3dDh39QxqAsaaRUWgdb7wg8Fh+gyGMB8C3ebupO6+uBw8Jh9hTX/gPNo2rGk/
	 IEcAllnyIYmWg==
Date: Mon, 5 Oct 2026 17:17:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 0/2] ipv6: fix address publication races with
 addrconf_ifdown
Message-ID: <20261005171729.65fda9d6@kernel.org>
In-Reply-To: <20261005165706.6ca89a76@kernel.org>
References: <20261004183639.3773498-1-4ncienth@gmail.com>
	<20261005165706.6ca89a76@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 5 Oct 2026 16:57:06 -0700 Jakub Kicinski wrote:
> On Mon,  5 Oct 2026 03:36:37 +0900 Daehyeon Ko wrote:
> > The first patch serializes address publication with device teardown by
> > taking idev->lock before the address hash lock, as suggested by Ido. It
> > rechecks both dead and disable_ipv6 before publishing.  
> 
> Please slow down. We don't want to see more than 10 outstanding patches
> from random "LLM people" in the review queue. Please look at your
> outstanding patches here:
> https://patchwork.kernel.org/project/netdevbpf/list/?submitter=223024

Herm, you seem to also have a tendency to make minor adjustments
to the subject. Please try to avoid that unless really necessary.
It breaks the quite naive version tracking kernel.org infra does
for us.
