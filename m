Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA6735B636;
	Thu, 30 Jul 2026 01:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785376515; cv=none; b=jikSIf4aSRDhLvt8qK8u144IywsTdgAK3hdSCHHMxZY4Fuw/UK/ZpKG/m3Q/fFhIFUKVN1djlc9uG2R0NwQfihavc/rU5cqKTtnvp7EqslF9zo98Nl6SPRLGNwJGNl+m+JH0XnaZplsKu3/zP3ZEov17KydFX/hf0DQToODLOwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785376515; c=relaxed/simple;
	bh=RyL1S241I1xbwzhgWmEuC0C/zFe0G3j9ov1MUawjNec=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=er5vmLUCILeWQK15UlqY2n/T63VwsQoIzghoiiJERe1P/3AyOvc+dbw7/Gjgv7sHutN0pmVa25Ut634z6jEddYX8e1YqE4fPpkorutIl2UaoPe/IKkUQ7ZtuHGmonHIAetsZFO2FaftmBUK3ETkZpgYOlE7BjE4h+wuEoiUUuyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LOzd660v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LOzd660v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D76411F000E9;
	Thu, 30 Jul 2026 01:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785376514;
	bh=emPhhmwnKKZ4Y76u66rvP8YGIkqLeJ3gQ2wEmqMqayc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LOzd660v00kjaWeBI/kugYfnoL15Bq85jzyk4Umy14TjT0UnX8wsTXcFiQO8TOyea
	 briufyej9NW8/sGQAfT+gFgCC9sJV3J20lNU8wjoumg098AmZzrptn8szu+7BmsAXu
	 FxTAU+NUpPoLt/RZ9CqNBIxFlnY6bUwxbGbpYrPLkAt6acudglPtFqdvbVZn9oXLmJ
	 7sKz+Gq8TtZwfekGhS8ER/AOZFvVsdubPzigaIqXUOxX3uugk2XgwFIbU41MByWwKE
	 aXRtCW/6JNghayVaeJIQJqj5GyGuT+VNtfzUsnVBWBcwv3erSU/pEorhszyZo6QwjX
	 P4p9Yh1FPckkg==
Date: Wed, 29 Jul 2026 18:55:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Artem Lytkin <iprintercanon@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, jacob.e.keller@intel.com,
 chrisw@sous-sol.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] rtnetlink: truncate IFLA_VFINFO_LIST instead of
 overflowing its length
Message-ID: <20260729185513.52564971@kernel.org>
In-Reply-To: <20260725132236.88318-1-iprintercanon@gmail.com>
References: <20260725132236.88318-1-iprintercanon@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 25 Jul 2026 16:22:36 +0300 Artem Lytkin wrote:
> rtnl_fill_vf() closes the IFLA_VFINFO_LIST nest with nla_nest_end(),
> which stores the accumulated length into nla_len. That field is a u16,
> so a nest larger than 65535 bytes is written truncated modulo 65536.
> 
> The skb is sized by if_nlmsg_size(), which adds rtnl_vfinfo_size() for
> every VF, so the buffer really is large enough for the whole list and
> none of the nla_put() calls in rtnl_fill_vfinfo() fails. The overflow is
> therefore silent. Userspace then walks the message with RTA_NEXT(),
> which advances by the stored length, so parsing resumes inside VF
> payload and the top-level attributes that follow the nest are read out
> of VF data. Those are IFLA_VF_PORTS, IFLA_XDP, IFLA_LINKINFO,
> IFLA_PERM_ADDRESS and IFLA_PROP_LIST. iproute2 prints "!!!Deficit", and
> strictly validating parsers reject the message outright.
> 
> rtnl_fill_vfinfo() emits 296 bytes per VF on a 64-bit kernel with
> efficient unaligned access, so the nest wraps at 222 VFs; without
> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS it is 328 bytes and 200 VFs, and
> with ndo_get_vf_guid 336 bytes and 196 VFs. ice supports up to 256 VFs
> per PF (ICE_MAX_SRIOV_VFS), so this is reachable on shipping hardware.
> Requests that set RTEXT_FILTER_SKIP_STATS need 335 VFs, which the 256-VF
> limit puts out of reach, so plain "ip link show" is fine today while
> "ip -s link show" is not.

We should cap the output at known values and document them as the max
the interface supports. "The number depends on attr set and random
things like CPU alignment requirements" sounds like a terrible uAPI
contract.

Perhaps 128 with stats and 256 without?

> On CONFIG_DEBUG_NET kernels nla_nest_end() now also splats via
> DEBUG_NET_WARN_ON_ONCE(), added along with nla_nest_end_safe() in commit
> 1346586a9ac9 ("netlink: add a nla_nest_end_safe() helper").
> 
> Using nla_nest_end_safe() here would not help: a nest that does not fit
> in a u16 will not fit in a retried skb either, so returning -EMSGSIZE
> would turn "ip link show" on such a device into a hard failure. Bound
> the nest in the writer instead, as suggested when this was last
> discussed: drop the VF that would push it past U16_MAX and end the list
> there. Userspace sees IFLA_NUM_VF unchanged and a shorter
> IFLA_VFINFO_LIST, and everything after the nest stays parsable. An empty
> nest is already emitted for a PF with no VFs, so a list shorter than
> IFLA_NUM_VF is not a new encoding.
> 
> The other large nests in rtnl_fill_ifinfo() were audited and cannot
> overflow: IFLA_AF_SPEC is bounded by a handful of address families at
> about a kilobyte each, and IFLA_VF_PORTS would need more than 560 VFs.
> 
> Fixes: c02db8c6290b ("rtnetlink: make SR-IOV VF interface symmetric")

Not a fix - this is along standing limitation of the interface.
-- 
pw-bot: cr
