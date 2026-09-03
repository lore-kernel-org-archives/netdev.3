Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0430542DA3D
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 11:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788433941; cv=none; b=sN2kjkVfl3ymfNbKr+a5UHBlAxXe336fkE/aKziZDP2qkhYe6Ntwl5wOV0IP2gDYYq8vdZD1uTfNRAVm6v2p+cYTO6MNgQJuBSBtyFSd4wmSVLOaWKkmhJ3SJ8QYRvzLfJ6O0HMI2S/zH0Jwcm3+Peq4RcF7vLvUXS8BLmf8I38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788433941; c=relaxed/simple;
	bh=Pac/wMgs45bpgTKNoxpbW2bjir3PW/Jl0bVjbJuqX0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bak8FKkgO+zbF0dEW0A/bgS+yolbOuYCTHqiAOcihO8cr6X6HO9wdBabBn9E7kDg6/BLGkvgwm6da+AkamdUfw7t34GGDGJcR0xCipjlG++glHXm0HqfCngM2a41RjrnJZK4Ohi5eIdw5mYxLKZWfL4Mk3srTmjkZ5uqgysekaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bfJ0QuJE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bfJ0QuJE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F7641F000E9;
	Thu,  3 Sep 2026 11:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788433939;
	bh=KlBeecTn7vpGQ9ASP6oYD7UZJkpNW1Vd6wM8g7PxlLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bfJ0QuJE3euHnflVrSHYz3OSPSVsSmW8KXYYhBXbHT9PLE0LYtWu6l7/H3jNalAI1
	 Lz1AQtBAsCyNA7HPPXosa8opoAup78NHhaCyCLm4Yz6/M33iJWqJ1VJVlcKNDB4dkV
	 IOAF97ODByamar7ky4bPntDvtaFxD4Nm/dk5Nds4uMSznAaoa8Lvau7fnPa5DH2pUl
	 uDeJe2im9x8dY6Z0OAgZ/xXtDDmomyzzwcnpu0B/D7Ge6q/oQx8QU/ixbl5pvMTEE0
	 0xcIOf0xPW/yPieL4uNYMw/7PacGoXx4jj+wj0Q7qwuR0pWmXQiBnm3a9hbibNcJAx
	 0DVQUCYRCmctg==
Date: Thu, 3 Sep 2026 12:12:16 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH iwl-net v2] ice: fix bound parser hash offset before
 reading packet data
Message-ID: <20260903111216.GM396647@horms.kernel.org>
References: <20260824132248.3396788-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824132248.3396788-1-aleksandr.loktionov@intel.com>

On Mon, Aug 24, 2026 at 03:22:48PM +0200, Aleksandr Loktionov wrote:
> ice_rt_ho_set() uses the HO register as the starting offset of an
> ICE_GPR_HV_SIZE-byte memcpy() out of rt->pkt_buf. Potentially HO can
> be advanced by user-controlled data reachable through
> ice_parse_raw_rss_pattern() -> ice_parser_run() ->
> ice_parser_rt_execute() -> ice_rt_gpr_set() -> ice_rt_ho_set(), i.e. a
> VF-supplied raw RSS pattern (virt/rss.c), with no bound against the
> size of pkt_buf.
> 
> Clamp HO to the last offset from which ICE_GPR_HV_SIZE bytes can still
> be read out of pkt_buf, deriving the limit from sizeof(rt->pkt_buf)
> so it stays correct if the packet buffer layout changes.
> 
> ice_parser_rt_pktbuf_set() stores the caller's raw pkt_len in
> rt->pkt_len, even though it only ever copies min(ICE_PARSER_MAX_PKT_LEN,
> pkt_len) bytes into rt->pkt_buf. Both ice_parse_raw_rss_pattern() and
> ice_vc_fdir_parse_raw() pass a VF-supplied pkt_len of up to
> VIRTCHNL_MAX_SIZE_RAW_PACKET (1024), i.e. larger than
> ICE_PARSER_MAX_PKT_LEN (504). With HO now capped at 504, the
> "HO >= pkt_len" loop exit in ice_parser_rt_execute() would never be
> reached for such an oversized pkt_len. Store the already-clamped
> length instead, so rt->pkt_len always matches what was actually copied
> into rt->pkt_buf and the loop-exit check remains a valid bound
> regardless of the caller-supplied pkt_len.
> 
> Fixes: 9a4c07aaa0f5 ("ice: add parser execution main loop")
> Cc: stable@vger.kernel.org
> Cc: horms@kernel.org
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
> v1 -> v2:
> - also clamp rt->pkt_len in ice_parser_rt_pktbuf_set() to the same
>   ICE_PARSER_MAX_PKT_LEN bound already used for the rt->pkt_buf copy,
>   so the "HO >= pkt_len" loop-exit in ice_parser_rt_execute() can't be
>   bypassed by an oversized pkt_len from the raw RSS/FDIR VF paths
>   (reported in review)
> - dropped Przemek's Reviewed-by since the patch changed

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>

