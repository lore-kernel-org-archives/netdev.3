Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675C933F597;
	Fri, 17 Apr 2026 16:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776441883; cv=none; b=gKHzN1b/p/hybVqGXLqAwgEaJH/nhOeXWWxNpqC3iMDzMI3Yz/6RjlSpeb8851hX62fWwEHwkV1T+1LVbi8MVUEmPt1SXZhBkg4D+WqTCSDcEfs29SxmzqzqgLM8kyQqSMBHS+d0gnxtqpmAyUZa79CsiPgZeLksqY6YPA8jGus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776441883; c=relaxed/simple;
	bh=eoOHNTLXUuxqHa7GYHnN9Zwr2758O72sKIxIKArJBIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hk9KudJqc8qXn4tH6Dr1jckXSOXUev695v0JEGEPcLXs4tgFtMNPLYlkhwD+eNI1d3SlXiDqo6T+1CmGhPwZ6gXX3uWbbL2+jFp/gMozpZz6BAl0Vmiort9Kir5gYVOXAKfE4qZPsEU5RKvnImhp48QZdQFvnRKXbLR8ziNL39Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KtX3uirh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KtX3uirh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D91C19425;
	Fri, 17 Apr 2026 16:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776441883;
	bh=eoOHNTLXUuxqHa7GYHnN9Zwr2758O72sKIxIKArJBIM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KtX3uirhW9fpWjIycPD5JAaW3aJgAtxCrbsRGXTVJv7w2dV4GuQJ7uydCiHkg9AC8
	 2CNIoTSBvAHY7u2bpZDQZZBO686KN+wno/YKCHatdDGKQzD+r/ZSfPYVMmG/7Sh3n4
	 AYUxKJv9gxE8WyldqefJutDHoR87ZUsekuSHQBOVEvyDG2I1vRSztw63X44UnfAjEm
	 dTFn7eGvhmjbRovJ5dP3cM8AWhnI8Pws2hs7KveK4dUj6jDrUhJ/+/Wx8AIJIJX8jQ
	 OcvjgBXaCccNBi99Ql+NhxSOzhZxDpaImW63pVnSBY6GXLjIQK1b0ejv1TLVMM/VbY
	 KZW2wkvWj+ySA==
Date: Fri, 17 Apr 2026 17:04:38 +0100
From: Simon Horman <horms@kernel.org>
To: =?utf-8?B?TGVrw6sgSGFww6dpdQ==?= <snowwlake@icloud.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	=?utf-8?B?TGVrw6sgSGFww6dpdQ==?= <framemain@outlook.com>
Subject: Re: [PATCH net v3 2/4] nfc: llcp: fix TLV parsing in parse_gb_tlv
 and parse_connection_tlv
Message-ID: <20260417160438.GH31784@horms.kernel.org>
References: <20260414233534.55973-3-snowwlake@icloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260414233534.55973-3-snowwlake@icloud.com>

On Wed, Apr 15, 2026 at 01:35:31AM +0200, Lekë Hapçiu wrote:
> From: Lekë Hapçiu <framemain@outlook.com>
> 
> nfc_llcp_parse_gb_tlv() and nfc_llcp_parse_connection_tlv() walk TLV
> arrays whose length and content come from a peer-supplied frame.  The
> parsing loop has three weaknesses:
> 
>  1. `offset` is declared u8 while `tlv_array_len` is u16.  In
>     parse_connection_tlv() the TLV array can reach ~2173 bytes (MIUX
>     up to 0x7FF), so 128 zero-length TLVs wrap `offset` back to 0 and
>     the loop never terminates while `tlv` advances past the buffer.
> 
>  2. The guard `offset < tlv_array_len` only proves one byte is
>     available, but the body reads tlv[0] (type) and tlv[1] (length).
>     When one byte remains, tlv[1] is out of bounds.
> 
>  3. `length` is read from peer data and used to advance `tlv` without
>     being checked against the remaining array space.  A crafted length
>     walks `tlv` past the buffer; the next iteration reads tlv[0]/tlv[1]
>     from adjacent memory.
> 
> The llcp_tlv8() and llcp_tlv16() accessors additionally read tlv[2]
> and tlv[2..3]; a zero-length TLV makes those reads out of bounds.
> 
> Fix: promote `offset` to u16; add two per-iteration guards, one for
> the TLV header and one for the TLV value; require length >= 1 for all
> TLVs before the type dispatch and length >= 2 for the llcp_tlv16()
> accessors (MIUX, WKS).  Return -EINVAL on malformed input.
> 
> Reached on ATR_RES (parse_gb_tlv) and on CONNECT/CC PDUs before a
> connection is established (parse_connection_tlv).  Both are
> triggerable from any NFC peer within ~4 cm, without authentication.

As per my comment on patch 1/4, I don't understand the relationship
between the last sentence above and this patch.

> 
> Reported-by: Simon Horman <horms@kernel.org>
> Fixes: d646960f7986 ("NFC: Add LLCP sockets")

I think the hash but not the subject is correct in the fixes line.
IOW, I think this should be:

Fixes: d646960f7986 ("NFC: Initial LLCP support")

> Cc: stable@vger.kernel.org
> Signed-off-by: Lekë Hapçiu <framemain@outlook.com>

Otherwise, looks good to me.


While looking over this I noticed that nfc_llcp_connect_sn() seems
to have the same kind of problem. You may wish to address that as
a follow-up.

...
