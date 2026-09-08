Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3B7563FD7;
	Tue,  8 Sep 2026 16:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788884408; cv=none; b=rYygGOHEo/vzjoSP2qKPIC0dwIVmYC47TlIwKpSoC/4YedDNcicfzx61whxINmfNmLalU+KJ1MNQRy7F6QMzYeIe/D98yJbjjRIEIWlHhVNFZfpC4JQY35M+NX9t7QIxfFt3Sc9AmJ9/thYQMBsyouIqKNCUPX60pH6Vgs1oqCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788884408; c=relaxed/simple;
	bh=NzqUywipRON5jjS/TeIYxCs0yurRWEVfVVuUSrREwNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V42sJMmlevhvwjtptPfyG0ftXgTC9FCV0p9DLKEKKo5iY6VEf8mrXwDrDXMsKv4bE8/nu/YgsdJWRKpIjeM6FWK3Tk7DBzinXzylB+w7Fkr82CzFQEw78333ey6x8jp/WldCeSSnXltgeKL/lDo1/ewNZHgGWO+EUqvAf8ZLaCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8o5eBWr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8o5eBWr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A2B81F00A3A;
	Tue,  8 Sep 2026 16:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788884407;
	bh=g0gh8GMK2mvWOMy9Zr29Xi4znqfwf867zSmYAK3XBVQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Z8o5eBWrAiMvDeeFj9QaV+Z2tmsmS95HOEmp8gol0BZgbRbMy4oSfWkzH/nVJteWV
	 GhwVyFMFd012ITR9Jmhp2OnarfGCORL3VjiKXVzDfdZ0lJgogQqE3Fr/RfvpulZaTT
	 4idDhBlQFvv4GikgufAmgCb4H5JOzp8FBgwd4D2bb6/7BU9A2/fvFF1p11St06NQPC
	 Os7eJqlDNq8B9OVoU0glkxuNlII8d/SRMXYG6oUbelYW327H8KapmGssEl/tNIDeZ2
	 nUpU/cRQFsnBtlxpdWv16NMJkOoi2wQF2T74bR7O3eV4GQcDxQKmE5dOK/cNItLjay
	 NN4ZCdFIRO1gw==
Date: Tue, 8 Sep 2026 17:20:03 +0100
From: Simon Horman <horms@kernel.org>
To: =?utf-8?B?w5ZtZXI=?= Mete Kaya <omermetekaya0@gmail.com>
Cc: netdev@vger.kernel.org, david@ixit.cz, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	oe-linux-nfc@lists.linux.dev, linux-kernel@vger.kernel.org,
	syzbot+1e3df0852e82c21ca418@syzkaller.appspotmail.com
Subject: Re: [PATCH net v3] nfc: llcp: fix slab-out-of-bounds reads when
 logging service names
Message-ID: <20260908162003.GC40544@horms.kernel.org>
References: <20260905225211.596366-1-omermetekaya0@gmail.com>
 <20260906003917.627282-1-omermetekaya0@gmail.com>
 <20260908154152.GA40544@horms.kernel.org>
 <e6cfe188-c4ce-4919-bb16-9c26175e111b@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e6cfe188-c4ce-4919-bb16-9c26175e111b@gmail.com>

On Tue, Sep 08, 2026 at 07:12:38PM +0300, Ömer Mete Kaya wrote:
> 
> 
> On 9/8/26 18:41, Simon Horman wrote:
> > On Sun, Sep 06, 2026 at 03:38:08AM +0300, Ömer Mete Kaya wrote:
> >> nfc_llcp_wks_sap() and nfc_llcp_build_sdreq_tlv() pass non-null-
> >> terminated strings to pr_debug() using the %s format specifier.
> >> The buffers are allocated via kmemdup() or come from netlink
> >> attributes and are not guaranteed to be null-terminated, causing
> >> __dynamic_pr_debug() to read beyond the allocated region:
> >>
> >>   KASAN: slab-out-of-bounds Read in __dynamic_pr_debug
> >>
> >> Fix both call sites by using %.*s with the explicit length to limit
> >> the output to the actual length of the string.
> >>
> > 
> > As a patch for net, this needs a Fixes tag here
> > (no blank line between it and other tags).
> 
> Sorry, I know that but I wasnt sure whether to add it since the bug
> has been there since the function was introduced. I will add it in v4.

Understood. FTR, yes, a Fixes tag is needed in such cases.
The idea is to guide backporting of the patch to all versions
that are effected.

> >> @@ -135,7 +135,7 @@ struct nfc_llcp_sdp_tlv *nfc_llcp_build_sdreq_tlv(u8 tid, const char *uri,
> >>  {
> >>  	struct nfc_llcp_sdp_tlv *sdreq;
> >>  
> >> -	pr_debug("uri: %s, len: %zu\n", uri, uri_len);
> >> +	pr_debug("uri: %.*s, len: %zu\n", (int)uri_len, uri);
> > 
> > This does not compile because the trailing uri_len argument is now missing.
> 
> Sorry, I normally test-build before sending but this
> one slipped through.

Stuff happens :)
