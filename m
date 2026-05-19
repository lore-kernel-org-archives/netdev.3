Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8420C3A7F7E;
	Tue, 19 May 2026 23:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779235009; cv=none; b=ryGsQODesjASxPYMtj+rYHitrMWuHNCEntdbMbJKtgD23DJiEYCPhsdJY/lEbutT3DD+Km7FWjlUhHjA+1+0M6+04WoONWxP6OPMUCyawJ2k09A/zs2yfqyHj+AjFV6AruxnlF6UWsQ3bTaNKAIgWcL7i4cQe97BaQ315IFkf0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779235009; c=relaxed/simple;
	bh=vdFQP87CxmaqQBGjYYUQzavFHxP3v9QLU+hTIDisHFo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qfmx72rTudFVJbHfiY5mfXxxmR/PMG5700FeV1ok+zMXoUyRSrRo1UUuCmX3PqFn1YDQPd1WBdoHeRQCg6Iaom5myjmlvvuETxISnsv0WPVr0fj97Sn6uK5KdYaG8BCwe/W2IdxZg7n7ZlT1lsR5IE2lI4ijaM5SYlF1/rjnquA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=INtNDhNN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="INtNDhNN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 458CC1F000E9;
	Tue, 19 May 2026 23:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779235008;
	bh=yYWbA7j46aueWZEJm8bnihGWxOjtMrOMmpHf9Fu5Y7A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=INtNDhNNwgCAkz3ew87JMcdeZl6c+E1ryD+QFvS0NJQGxosUfkWGVZgyOiriYretc
	 Y0AyKreTS1Ey0kji8T8wdYsuU1aUND9pI4BtwVhxE5Nh7XIscCq+4ICKXho4j0dn6K
	 BZRkQoQRub0KZUMvFEB+Th0vMXgmiX5RNvtHPaFb/zOd5MgQPRHL907oVn5Zt3n7bL
	 3X/A72M3Ub7C/EqQ86i6FtCOZWj2MYTwGJoJlXmr+LbG1dG3cqIabGsEchb1dno/Im
	 bc0JnXGz1TW8HIipXfAy0B8T7OPqSfeb9cmLFLoRm6u0kFDttm3AD79iki7P2H8GKU
	 RtO/BLJ2FDRXA==
Date: Tue, 19 May 2026 16:56:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Luka Gejak <luka.gejak@linux.dev>
Cc: MD Danish Anwar <danishanwar@ti.com>, Felix Maurer <fmaurer@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Roger Quadros <rogerq@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Meghana Malladi <m-malladi@ti.com>, Jacob Keller
 <jacob.e.keller@intel.com>, David Carlier <devnexen@gmail.com>, Vadim
 Fedorenko <vadim.fedorenko@linux.dev>, Kevin Hao <haokexin@gmail.com>,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH net-next v2 2/2] net: ti: icssg: Add HSR and LRE PA
 statistics
Message-ID: <20260519165646.09b0783f@kernel.org>
In-Reply-To: <E30AAC96-01D2-4A23-B562-126087DEB7FA@linux.dev>
References: <20260514075605.850674-1-danishanwar@ti.com>
	<20260514075605.850674-3-danishanwar@ti.com>
	<20260518184506.694c584e@kernel.org>
	<E30AAC96-01D2-4A23-B562-126087DEB7FA@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 May 2026 07:55:55 +0200 Luka Gejak wrote:
> On May 19, 2026 3:45:06 AM GMT+02:00, Jakub Kicinski <kuba@kernel.org> wrote:
> >On Thu, 14 May 2026 13:26:05 +0530 MD Danish Anwar wrote:  
> >> Add new firmware PA statistics counters for HSR and LRE to the ethtool
> >> statistics exposed by the ICSSG driver.
> >> 
> >> New statistics added:
> >>  - FW_HSR_FWD_CHECK_FAIL_DROP: Packets dropped on the HSR forwarding path
> >>  - FW_HSR_HE_CHECK_FAIL_DROP: Packets dropped on the HSR host egress path
> >>  - FW_HSR_SKIP_HOST_DUP_DISCARD_FRAMES: Frames with duplicate discard
> >>    skipped
> >>  - FW_LRE_CNT_UNIQUE/DUPLICATE/MULTIPLE_RX: LRE duplicate detection
> >>    counters
> >>  - FW_LRE_CNT_RX/TX: LRE per-port frame counters
> >>  - FW_LRE_CNT_OWN_RX: Own HSR tagged frames received
> >>  - FW_LRE_CNT_ERRWRONGLAN: Frames with wrong LAN identifier (PRP)
> >> 
> >> Document the new HSR/LRE statistics in icssg_prueth.rst.  
> >
> >To an untrained eye these stats look like stuff that could 
> >be standardized across drivers. 
> >
> >Luka, Felix, others on CC, do you think we should expose these
> >from HSR over netlink as "standard" offload stats different drivers 
> >can plug into or not worth it?  
> 
> I think there is a case for standardizing part of this, but I would 
> not standardize the whole set as-is.
> 
> The LRE counters look generic enough to me, especially:
>  - unique rx
>  - duplicate rx
>  - multiple rx
>  - rx / tx
>  - own rx
>  - wrong LAN, PRP only
> 
> Those are protocol/LRE concepts rather than TI firmware details, so
> exposing them from the HSR/PRP layer sounds useful. I would expect 
> both the software implementation and offloaded implementations to be 
> able to provide at least some of them, with unsupported counters 
> omitted or reported as not available.
> I would not put the firmware check/drop counters in the same standard
> bucket, though:
>  - FW_HSR_FWD_CHECK_FAIL_DROP
>  - FW_HSR_HE_CHECK_FAIL_DROP
>  - FW_HSR_SKIP_HOST_DUP_DISCARD_FRAMES

Thanks for the breakdown!

> Those sound more like implementation/debug counters for the ICSSG
> firmware pipeline. They are still useful in ethtool driver stats, but 
> I would be hesitant to bake their exact semantics into HSR UAPI.
> So my preference would be:
>  1. Keep driver-private ethtool stats for the full firmware counter set.
>  2. Add a small HSR/PRP standard stats set separately, limited to
>     well-defined LRE counters.
>  3. Make the HSR layer expose them, with offload drivers plugging in via
>     an optional callback or offload stats op.
>  4. Define the counters carefully, including whether they are per-HSR
>     device or per-port A/B, and what PRP-only counters mean for HSR.
> 
> I do not think this patch should blindly become the UAPI definition, 

Not at all, the unique / multiple stats gave me pause. We should
only put in the standard API what can be easily and unambiguously
defined given the protocol spec.

> but I do think it points at a useful follow-up. If we want to avoid 
> adding driver-private names first and then standardizing different 
> names later, then it may be worth asking Danish to split the 
> protocol-level LRE counters out and route those through a common HSR 
> stats interface.

As a general policy we ask for standard stats to be added first and
ethtool to only contain what didn't fit in the standard ones.
There are some technical reasons but it's mostly a mindset thing.
