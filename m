Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94E1378D91
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 10:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771930469; cv=none; b=Fi5VqQsZL91DvZIsCHn5wf+Pptt7tX+HUnvn40SSjq5ZULvChaX+CrZFTaLiVhmEoENyINafSs3w2XQwyFYvcAQbahPN3eQRz4bRQpSexXPBjFBK7qx/NMitMj2icyS3QEQT7UtRpVHl/baBn8rIzTioJwKyzaCbT62yR+VMZSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771930469; c=relaxed/simple;
	bh=ggOBgUlgnDUGvS3o+o6A+b3bloz8IFdveaiD+S4suA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q02KUnc2qQdpQKgzU8v/JN9buAJ3u/7FvoRrsutYWO+YVG4zf0TtufIPrLcg/HKB79l+Ayr39fdPxw1sK8v8jZ8bD7cIuI/Z4NBAI1J9gQV+nlrtH9DwgCA6byeIUPi+qQgDAi2SHvCG3qGDCzqsAmg/C7V8b3hTTmixVatGdpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lIz5C4LV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lIz5C4LV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A84B4C2BC9E;
	Tue, 24 Feb 2026 10:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771930469;
	bh=ggOBgUlgnDUGvS3o+o6A+b3bloz8IFdveaiD+S4suA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lIz5C4LVG6BNNgk6ws3S/eQUBL+KXKSN8kpN8xXZL73ywHLs9OoL01SsusySx3Wf/
	 bj9+eBSkoKEyHXTq39bEXsrkCvUMXuTUjGGfiSf3U40MbLKl67U2/v093OalMwP672
	 Ss+DAHZ5szwYwv5SWYzAXJuRn3GR1FGsZSkUQOGQkVPX8eEZiq0kEYh8uCAO2TYqPR
	 5DNgcfM4ulvZcrzdFNamU8JhU1vHdtCqJdKO9lNGOs2jsqB47JbRoWhiNTj6s0LH3X
	 UMUk9rADd7IERus0RzDIo7jXqwRX3cZ6HJHk1tsggjK5axGnCqGmw99IRrTvJUTHRL
	 Urv9gpjHa8crw==
Date: Tue, 24 Feb 2026 10:54:25 +0000
From: Simon Horman <horms@kernel.org>
To: Maciek Machnikowski <maciek@machnikowski.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, richardcochran@gmail.com,
	milena.olech@intel.com, willemdebruijn.kernel@gmail.com,
	andrew@lunn.ch, vadim.fedorenko@linux.dev
Subject: Re: [PATCH v2 net-next 3/3] selftests:net: Implement ptp4l sync test
 using netdevsim
Message-ID: <aZ2DYSitNqQwkqCu@horms.kernel.org>
References: <20260222094110.127927-1-maciek@machnikowski.net>
 <20260222094110.127927-4-maciek@machnikowski.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260222094110.127927-4-maciek@machnikowski.net>

On Sun, Feb 22, 2026 at 10:41:10AM +0100, Maciek Machnikowski wrote:
> Add PTP synchronization test using ptp4l and netdevsim.
> 
> The test creates two netdevsim adapters, links them together
> and runs the ptp4l leader and ptp4l follower on two ends
> of the netdevsim link and waits for the follower to report the
> synchronized state (s2) in its output log.
> 
> This implementation runs the test runs over IPv4 link.
> 
> Signed-off-by: Maciek Machnikowski <maciek@machnikowski.net>
> ---
>  tools/testing/selftests/net/ptp.sh | 93 ++++++++++++++++++++++++++++++
>  1 file changed, 93 insertions(+)
>  create mode 100755 tools/testing/selftests/net/ptp.sh

Hi Maciek,

I'm wondering if you could consider running running shellcheck over this
and cleaning  things up a little.

I see SC2086 which I think can be trivially addressed.
And SC2329, which I think would be best ignored using #shellcheck disable=SC2329

Also, I think you need to add ptp.sh to tools/testing/selftests/net/Makefile

Thanks
