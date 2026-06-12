Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC6B395DAA;
	Fri, 12 Jun 2026 12:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781267105; cv=none; b=ebtmSI5Z0zOMh01u8LPtPzYZew1L6RlD9NXgMpJ4VFvmZMb5A9klYKLAuwe6bySUgw70fAftrC3h9jQXDk8YpqCrUmhtdbLt2tzJCEF5yfPFcz6LRcDG05QiVaSHWcoRspUJh/U0Aab+pzSU0LqChdw3Pv08oG4Vbk27gCB0nGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781267105; c=relaxed/simple;
	bh=8efJRhmrPygmrpPFw77bhT6JwWU62/INICk2jAhtO3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JzJlp4SD+nZNkldNUIdgrBuUASkEOB9kcESm2sNXIjXCAe6zIUjWG9QTTkDwzfbUnBlH4NDAS5CrVQc5MmgawY0A7lZCNvy/hSGPmX/8y5lTz27l7sNQrhFJj4eYQoSB+sZIRVN71DTtgIXGSFSbITFmcXC61E3qChZmbs2uEMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LeIUvZH3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LeIUvZH3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7B271F000E9;
	Fri, 12 Jun 2026 12:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781267104;
	bh=XyKeMQWx3qJwTBdaxlwr+ooF5i8jx3bmcjQwKrMhwiQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LeIUvZH3PIpohuB3LmYWMygUfc0OLrtkT13i5zT4gaGGH713+8TOGXFjnCqFceZwe
	 PbXzJYmk9jKDh1Xu9RNIDJC43Nc5u+eczm7K3gQOkAiU7FInTbJsbzzTr8SRR2Yjvn
	 AFK2DKqudWBGWNkWv2ojBr8iXqObYT4IYZpXbpMn8Z6CdOsocnsoSrGsEKjCqVXWTE
	 BDtLMDyHwYa6cbqYOp6qP6beZnByg8SAT53B58iSe9STKBWSKawGeVv3GA0mZkjLgQ
	 rcaZBIt4o/l5Wuw3UHFSmk/6s71fKNMQ7nT8jxKm+lnaZGYsh6OoTJY9B78Cc1x+DL
	 lzrfJi50RaaNQ==
Date: Fri, 12 Jun 2026 13:25:00 +0100
From: Simon Horman <horms@kernel.org>
To: Doruk Tan Ozturk <doruk@0sec.ai>
Cc: david@ixit.cz, oe-linux-nfc@lists.linux.dev,
	david.laight.linux@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4] nfc: llcp: bound SNL TLV parsing to the skb and
 add length checks
Message-ID: <20260612122500.GB671640@horms.kernel.org>
References: <20260609202543.42282-1-doruk@0sec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609202543.42282-1-doruk@0sec.ai>

On Tue, Jun 09, 2026 at 10:25:43PM +0200, Doruk Tan Ozturk wrote:
> nfc_llcp_recv_snl() walked the SNL TLV list using a u16 offset/length
> pair derived from skb->len, without bounding reads to the actual skb
> data. Three problems followed:
> 
>   - For a short frame (skb->len < LLCP_HEADER_SIZE), tlv_len underflowed.
>   - The per-TLV header (type, length) was read without checking that two
>     bytes remained.
>   - A declared TLV length could run past the end of the buffer, and an
>     SDREQ with length == 0 made "service_name_len = length - 1" underflow
>     (size_t), driving an out-of-bounds read in the following strncmp() /
>     nfc_llcp_sock_from_sn(). The SDRES case likewise read tlv[2]/tlv[3]
>     without a length check.
> 
> A nearby NFC device can reach this without authentication; LLCP link
> activation happens automatically after NFC-DEP.
> 
> Walk the TLV list by pointer, bounded by skb_tail_pointer() over the
> linear skb data, and validate each TLV declared length before use. Add
> explicit length checks for SDREQ (>= 1) and SDRES (exactly 2).
> 
> Found by 0sec automated security-research tooling (https://0sec.ai).
> 
> Fixes: 19cfe5843e86 ("NFC: Initial SNL support")
> Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>

Reviewed-by: Simon Horman <horms@kernel.org>


FTR: There is AI-generated review of this patch-set available on both
     https://sashiko.dev and https://netdev-ai.bots.linux.dev/sashiko/
     While I don't think that review should effect progress of this patch
     you may wish to consider it in the context of possible follow-up.
