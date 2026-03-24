Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F945340282
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 19:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774379185; cv=none; b=DQe6o5guA4O53nAXDkr6JrJenkhcuWWLsLXVsxSPZsmJbBgXdkvVo+g5fO+hpsgNkUs6kdJL6Ppl5N/Vq/aLRGLiem62U17whhSfU4DjqO9OXpCUwo3bHjGPfrCqRNUTv5RoAe1s3j1ZqjwtjMCQTomTR9TXMZgS01u2+OBEeeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774379185; c=relaxed/simple;
	bh=SvzlX1uuzmY7Mp9BmMubxQRH2ngFBpBlaBMBmLIepjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aRhGi1cYsGZbaZskgYn+NjEtjsHZFt6km0AZmLm06nQqP+RQB1iyofD6Ix6py1Jlkdkf25OTWi43qhIc7xvPqtxgYXgy7Lez9eQhMwtKDgghj5je7LWl1UNGwsMdwtpD2gxWIU4rKCp2wgqtdgThcyY/++0jQZXRMlzUYHpESRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uZ2/m73F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uZ2/m73F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F404C2BCB1;
	Tue, 24 Mar 2026 19:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774379185;
	bh=SvzlX1uuzmY7Mp9BmMubxQRH2ngFBpBlaBMBmLIepjg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uZ2/m73FMmCmshrmqNIi4AoGcmkmnGrXYXYcXI6Awj3uN2jzlvsh2Yvn0BDUxPOuX
	 Is6jGpQ8FyIpbYBKu6PI6tt1n2QDaw91q6j7fGcAkDYzQ+z//ctZb59N1i8lweZfA0
	 gRb7bMd/BPC0zXBXhQ46j9wr8VkVpigsov/T74N7MOivQwPSnW2ltOtIFhZiWZYv1I
	 uM2V0mHWdDnoq6/riDQF8bIJBFLBsANsWteRc+BA65Vx/GtxsUVb38JODoNMdA6BBr
	 3tiHlcqGxtWlIv2S2hnHieHCkbzzhNCbYs+59uSnVe+LmimmfnNszK/AdCMfZvnJsP
	 Jfn2CcxVC8qdQ==
Message-ID: <154d612f-2621-488c-9c9e-984062345ea9@kernel.org>
Date: Tue, 24 Mar 2026 13:06:23 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] vrf: Remove unnecessary NULL check
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, petrm@nvidia.com,
 lirongqing@baidu.com
References: <20260324155521.525292-1-idosch@nvidia.com>
 <20260324155521.525292-2-idosch@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260324155521.525292-2-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/24/26 9:55 AM, Ido Schimmel wrote:
> The VRF driver always allocates an IPv4 dst entry for a VRF device and
> prevents the device from being registered if the allocation fails.
> 
> Therefore, there is no need to check if the entry exists when tearing
> down a VRF device. Remove the check.
> 
> Note that the same is not true for the IPv6 dst entry. Its creation can
> be skipped if IPv6 is administratively disabled (i.e.,
> 'ipv6.disable=1').
> 
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  drivers/net/vrf.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


