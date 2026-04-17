Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F3E12B94;
	Fri, 17 Apr 2026 11:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776426689; cv=none; b=g/2P6wO0zrSRubwwgTgrTqyziUJddpL5GIHaaX3SxUjvNu6N4o1HnRyOv4Dj5fH1pAFpBSqYo8O/BaFHB5ATCgkA6GGMg9WG4pHKU6vbTasZG6Puh/m/RQEWARJBBlrIYB/R44+ZZeZk61ZoDDuF2T94FKw+1ECZOr29+7pY0O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776426689; c=relaxed/simple;
	bh=rAXyLT5RLfyphcv1d83h3XEBAAHlPAV0dBZp35OPm0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=duLBSuOXHDRv0Sc5DlG0e/d5TAYgRs9tDOHLWcHrgQuBFCqyfNJkOrwc+GOUTFcLswRkzUr7pjdEuCdxkANBkTuqt/NxHwDHYYl4+fepdW9C1/iLYm+TsFtH7+oszO48yiho6hiIQ8E3+LSlGPQUTi7dkC+ZgF2FDpm1vQ23ocE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GWWhQdIW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GWWhQdIW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D92BCC19425;
	Fri, 17 Apr 2026 11:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776426688;
	bh=rAXyLT5RLfyphcv1d83h3XEBAAHlPAV0dBZp35OPm0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GWWhQdIWdYicGc8rjEfFApwQQ+vyljQ7WmK9K7RlPn9NGJURPJ1tCWClR1V7WaZ6U
	 owzPnxJCDENKSUiyrTS1zBbuELUUCKMVQQmlB114vq85MFkzdOHJ5QeVuJWCXShi9g
	 iDNg3Uy+B4ptYuzKAeIwn/V4v7UMxODwIl2GHDAQbevpBVa3WumJREEh8XVuKjEUel
	 d5NhrPviXJrtSgqBxxVWLWg5T0ZVkKcdNXJWZyYwapcyLcjhYxUwOIwEZ369YTKOZX
	 U5elaBkIoufQN7a/nGJY+QqERUq2fj3Lqgf4YGrdBNgftZax8/3UCrP1ckDYq7rQ/3
	 vWUHcLTk8YJ7Q==
Date: Fri, 17 Apr 2026 12:51:22 +0100
From: Simon Horman <horms@kernel.org>
To: Kohei Enju <kohei@enjuk.jp>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
	kohei.enju@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH iwl-net v2] igc: fix potential skb leak in
 igc_fpe_xmit_smd_frame()
Message-ID: <20260417115122.GA31784@horms.kernel.org>
References: <20260415025226.114115-1-kohei@enjuk.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415025226.114115-1-kohei@enjuk.jp>

On Wed, Apr 15, 2026 at 02:52:18AM +0000, Kohei Enju wrote:
> When igc_fpe_init_tx_descriptor() fails, no one takes care of an
> allocated skb, leaking it. [1]
> Use dev_kfree_skb_any() on failure.
> 
> Tested on an I226 adapter with the following command, while injecting
> faults in igc_fpe_init_tx_descriptor() to trigger the error path.
>  # ethtool --set-mm $DEV verify-enabled on tx-enabled on pmac-enabled on
> 
> [1]
> unreferenced object 0xffff888113c6cdc0 (size 224):
> ...
>   backtrace (crc be3d3fda):
>     kmem_cache_alloc_node_noprof+0x3b1/0x410
>     __alloc_skb+0xde/0x830
>     igc_fpe_xmit_smd_frame.isra.0+0xad/0x1b0
>     igc_fpe_send_mpacket+0x37/0x90
>     ethtool_mmsv_verify_timer+0x15e/0x300
> 
> Cc: stable@vger.kernel.org
> Fixes: 5422570c0010 ("igc: add support for frame preemption verification")
> Signed-off-by: Kohei Enju <kohei@enjuk.jp>
> ---
> Changes:
>   v2:
>     - change to idiomatic style with goto (Simon)
>     - add Cc to stable (Alex)
>     - add reprodunction steps (Alex)
>   v1: https://lore.kernel.org/all/20260329145122.126040-1-kohei@enjuk.jp/

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>

Sashiko has comments about a potential existing bug in the same code path.
I'd appreciate it if, as a follow-up, you could look over that.

Thanks!
