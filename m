Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DB235957
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 00:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789689722; cv=none; b=Q00iAkapoRjizzt1C4gDoa7XOnGRjHvg7CbA2ibSwez6knZ9SlMSEFu51R82K9V5pvvvbAxo3ptQIUhYEyWcIJ0XDe/zu+VK6lHCul38XaBHQWG49vsk/b6RTrKdb1DT7NBfbrYg8lJUVhdeVapO5aeCkpNwO3d8Nh2jsizXzq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789689722; c=relaxed/simple;
	bh=8T7yeEx04/8Fi09pA0Awyww29Tdyqlk9Iwyompw8jS8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V4H8gJGTEDyjeOQu3fTPEaIEr0GPPcsSvdXiuE8jRIVwhpqQL8gf8XiCEpbC3/fPWSd9dwC7nje+DpSLYAXfU0UQHOl8cpYI+Q19Q8kOrB2R6Ktf+jnRJHCSkrmnHaXyi+klxUnKyTk0TL22bVouxx32YyCbo8UUyPuHVXNFWHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=wAL/GcKZ; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="wAL/GcKZ"
Received: by mail-pj2-f42.google.com with SMTP id 98e67ed59e1d1-396ccda24afso126784a91.3
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 17:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789689720; x=1790294520; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KXfpUZcMtqwQ5vtiF9ulOiLpdJZgm44gtrD8mXvTA5U=;
        b=wAL/GcKZ9A5XlGukoLeRflw+H3WmoqHF7pj6KFxBCvyxE6sOB/UC/2Fd961kr0jyeA
         MP/M7rgSlRIobeNnst0ie7840H3DNzNudJxaffUj8IPAjfPBqQaChh6KHEGReSAVS2EG
         5dDXlrHfan7sSdpf8JWJDb3XNArBehvleoum5oRR8idR8AwNBwutMI1MKtncAw4Igaow
         fyqHZaPgjg5tXWeJIa12nnHt4xt3pLZPkNtgChBFIBDYz2kKpme/NsqjZyu8KM5vTapU
         yMHagP0lJmtJsl50CasdY3t8XBO5nywf+hfJY2/pDV4pRwloVwOGcO8icN5vGnElG+kM
         KWuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789689720; x=1790294520;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KXfpUZcMtqwQ5vtiF9ulOiLpdJZgm44gtrD8mXvTA5U=;
        b=0BjW05ACrJJvkoQ3MVU8dm1D/W51Pe5gWC0lTdUTC/+N8L11ogjN2sHV09y/Z4Sc1K
         AMETEjfyI25ty+K7+5LU0+HL8/Tdf7s+v2NxGO8yORvyid4JxvEFV9FyJsvC7/lIqwMZ
         FSMpBvgs6E22I6zoZaA4JDlEhMKUPKrKPvnRu3ymta5nxHZshnAs7YCDIa31982bqtVJ
         vri9EMT/0sNxZB3kVTix56Is8bvOx3PBKJOxjjs4tlYbdXbdsBqYYp+X00r/47jTmVtG
         B0yC7k+Vt/3izs0UGTQwVNRYnX6wYiGgzTiF6XnCH37XvBqbrJ5Eaj+cFWO7H3vyflkj
         5fPQ==
X-Forwarded-Encrypted: i=1; AKwUvBxRJaPkn5LrejpwSgHsSTV2aJU2QfzIQnDBwYa1ESefUvt+2UvpThFpc0tyQ/aZLpSabK1uNSo=@vger.kernel.org
X-Gm-Message-State: AFuF++l/DUFPPyw6qjPBd7zFhneeGfga+nPd/bzNvrLoz/0CVNOR5y5j
	APLmUP6e4Ax0K1SlUyzvbszl68j5s1DIPi/2xkEBVa5NtDl6nP1vbE1ADj85PK52U9v5ZPJvnh0
	3DVplGiA=
X-Gm-Gg: AYBFou37dvioq9rpQ29x8kiq2CeyzgKiPtWfZHONVLcwphyTMMk/M8T65AsIMoZBpIB
	1vMlA33T0f6Shzh9NvuPSMP/urp7m/chuLRWUAuhfr8eZsZKsZzLcXQZ4VARyE9fZFNJiHh4C9l
	cD5GuMjDddXcq5aFMISNHAFFH1M9xEZsV9cSQ6YOPYEcIvsno+2oFhCTZfumLK/LRBEE9CtzMR4
	VAZUGb+vXNk6Cw4exB7vSm+lRKYZIC1XdyhOdxaD4Bp5VTuYzQWqMx2pqxvF80HO7Vl0YGRDiKG
	Dy1qXtQ5+fyK2psccFqX7tv29+1A006XMnNdYwkbVIsqb8FH2eEy0EaYdugv4bCNGI0OyAuMz76
	Tazjs9e1PHA4HlIYnVbcV0CxqTy9Ze2AOoCtP+xqtZ6o+nWmPpwQ4fQ5VPOniTke0DWs+lZ/NNm
	hFgcw3QwU62dvl3qt95I4Ts+klq8jMgPJcELP1A803/a+YTlu/jHJvZ2BgObT07kM+EyNK+DD7m
	YyJJsfsBsEgjKON0hVyd5FvQU8MwpK0BZGvB4aK
X-Received: by 2002:a17:90b:4a03:b0:36d:9e0b:3801 with SMTP id 98e67ed59e1d1-39e54d38c48mr2351408a91.8.1789689719936;
        Thu, 17 Sep 2026 17:01:59 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e50a4bc22sm1808978a91.17.2026.09.17.17.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 17:01:59 -0700 (PDT)
Date: Thu, 17 Sep 2026 17:01:54 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, Andrea Mayer
 <andrea.mayer@uniroma2.it>, Andrea Mayer <andrea@common-net.org>
Subject: Re: [PATCH RFC iproute2-next v3 2/2] seg6: add support for the
 End.MAP behavior under seg6mobile encap
Message-ID: <20260917170154.2c8f50cf@phoenix.local>
In-Reply-To: <20260917-seg6-mobile-end-map-v3-2-7fd02b8b0577@gmail.com>
References: <20260917-seg6-mobile-end-map-v3-0-7fd02b8b0577@gmail.com>
	<20260917-seg6-mobile-end-map-v3-2-7fd02b8b0577@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Sep 2026 06:39:01 +0900
Yuya Kusakabe <yuya.kusakabe@gmail.com> wrote:

> Wire up a new "seg6mobile" lightweight tunnel encap type that mirrors
> the kernel's LWTUNNEL_ENCAP_SEG6_MOBILE namespace, and add parse and
> print support for the first RFC 9433 behavior it carries: End.MAP.
> 
> End.MAP swaps the IPv6 destination address with the configured mapped SID
> and forwards the packet via the IPv6 FIB without consuming the SRH:
> 
>     ip -6 route add 2001:db8:f::/64 \
>         encap seg6mobile action End.MAP mapped_sid 2001:db8:2::e \
>         dev <dev>
> 
> Help text and the ip-route(8) man page get the corresponding ENCAPTYPE
> and SEG6MOBILE entries.
> 
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Yuya Kusakabe <yuya.kusakabe@gmail.com>
> ---

The AI review for this is:

On Thu, 17 Sep 2026 06:39:01 +0900, Yuya Kusakabe wrote:
> Subject: [PATCH RFC iproute2-next v3 2/2] seg6: add support for the
>  End.MAP behavior under seg6mobile encap

Reviewed the full v3 series (1/2 uapi + 2/2 implementation). Applied
cleanly on fce739fa, builds with no new warnings, and I exercised the
parse and print paths directly.

Overall this is in good shape. The code follows the seg6local patterns
closely: strcmp() rather than matches(), duparg2() for duplicates,
print_XXX() helpers throughout, paired open/close_json_object(), errors
to stderr. I have no functional objections; the comments below are a
documentation inconsistency and two suggestions.

Test results, for the record:

  # ip -6 route add ... encap seg6mobile action End.MAP \
        mapped_sid 2001:db8:2::e count dev lo

produces a well-formed message -- SEG6_MOBILE_ACTION=1,
SEG6_MOBILE_MAPPED_SID=2001:db8:2::e, nested SEG6_MOBILE_COUNTERS with
three zeroed u64s, RTA_ENCAP_TYPE=11. Argument consumption is correct
in every ordering I tried, including "count" as the final token and
with no trailing "dev".

Feeding a synthetic reply through lwt_print_encap() gives:

  text: encap seg6mobile action End.MAP mapped_sid 2001:db8:2::e \
        packets 1234 bytes 567890 errors 7

  json: {"encap":{"encap_type":"seg6mobile","action":"End.MAP",
         "mapped_sid":"2001:db8:2::e",
         "stats64":{"packets":1234,"bytes":567890,"errors":7}}}

Both correct, and the JSON parses.


1. usage() and the man page disagree on whether mapped_sid is optional

> +		"SEG6MOBILE := action MOBILE_ACTION mapped_sid ADDR [ count ]\n"
> +		"MOBILE_ACTION := { End.MAP }\n"

The usage string makes "mapped_sid ADDR" mandatory, but the man page
synopsis makes it optional:

> +.IR ENCAP_SEG6MOBILE " := "
> +.B seg6mobile
> +.BR action
> +.IR SEG6_MOBILE_ACTION " [ "
> +.IR SEG6_MOBILE_PARAM " ] [ "
> +.BR count " ] "

and the parser enforces neither -- "action End.MAP" with no mapped_sid
is accepted and sent to the kernel.

Please make the three agree. Since End.MAP is meaningless without a
mapped SID, I would keep the usage string as-is and follow seg6local's
convention in the man page, which spells the parameter as part of the
action description rather than as an optional token.

2. Consider rejecting End.MAP without mapped_sid in userspace

> +	if (!action) {
> +		fprintf(stderr, "Missing action type\n");
> +		exit(-1);
> +	}

This catches a missing action but not a missing mapped_sid, so the
kernel has to reject it. seg6local has the same gap, so this is not a
regression and I will not insist -- but End.MAP has exactly one
required parameter, which makes the check cheap and the diagnostic much
better than whatever errno comes back:

	if (action == SEG6_MOBILE_ACTION_END_MAP && !mapped_sid_ok) {
		fprintf(stderr, "Missing mapped_sid for End.MAP\n");
		exit(-1);
	}

3. Series depends on an unmerged kernel RFC

Patch 1/2 adds LWTUNNEL_ENCAP_SEG6_MOBILE and seg6_mobile.h ahead of
the kernel side, which is still an RFC. That is fine for an RFC posting
and the cover letter is upfront about it, but for the non-RFC repost:
iproute2-next takes uapi header syncs from accepted kernel commits, so
this cannot be applied until the kernel patches land in net-next.
Please cite the upstream commit id in 1/2's changelog when you repost.

One note on 1/2 while I am here: the value of LWTUNNEL_ENCAP_SEG6_MOBILE
is fixed by where it lands in the kernel's enum. If the kernel series
gains another encap type before it is merged, the header needs a
re-sync rather than a hand-edit.

Nothing else. The uapi definitions line up with what the code assumes --
SEG6_MOBILE_ACTION_UNSPEC is 0, so the "if (!action)" validity test
works; the counters carry a CNT_PAD for 64-bit alignment as seg6local
does.

Thanks,
Stephen
