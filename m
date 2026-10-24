Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792867855;
	b=j+ayOkTUXsS1F+sxRG4/lxwhLeR2brTqpz4lT0A+icGb7csgKfm7kt9XMm8VcV7FWyiQ
	 UJ+zndQbF6SRq/yGbLBKCO7pL2p29kwPO+x2+HaehhJ+J93/QlVfr87fK6DiuA2ve5rYx
	 hbx5qlyzOtIxQpqv+00TI5/3TT35obG8zU8XqZik1iKPn5hNEr4BLKab1ECJC4FGlQ4W5
	 /s2b/JpePa5NSBRBIzMANGT7eA3RHFSrotOsA9AktPrPgActTY8PAYcGTY4LaWtOcVjOx
	 Ed7J9gAZbE7HonjHv8xKUNK2Wb58eJQ4YkJJpS7EFqtbgpQGERe6xRowE/X9eEvBhhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792867855;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=3iSWWVA9NsF4haq5BCOiFupfpXVVvto7OGNd0s+IFK0=;
	b=Brm1muKRMSk3d8/ixjHfncQxdOAlGRqqTb2Nfu41okzauYOHVsGGfcw5zg6alEnNhh6O
	 027MB+sQtULqlKqD69rzSra6SgXGcgpGqyU2gzO9bFEJ6O+OuJCgowoPR+bqAtNN2o/vz
	 6BtccCjGP4FKnhzqa4H3eoNyb/rajmW7oJ/bNCiRnyogfPgzZqOwwvkrFv6lUn+ohA8Mk
	 6F6vXj2gZjFpWiDmWHB/RZA4TaWSXn4HUdUOvbB0NzRY01CNCSbwLP05ut5j4Az3D+mGl
	 TAZgycPRmaj7KSAlj4NzNFwd+DopKKi9vGJssHLulDkhHaYDL8VfRY69nE92cGIdAtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=protonmail.com;
	spf=pass smtp.mailfrom=protonmail.com;
	dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b="oq/FqRcH";
	arc=none smtp.remote-ip=79.135.106.99
Received: from mail-10699.protonmail.ch (mail-10699.protonmail.ch [79.135.106.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF45606A31A
	for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 18:50:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDF45606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=oq/FqRcH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1792867852; x=1793127052;
	bh=3iSWWVA9NsF4haq5BCOiFupfpXVVvto7OGNd0s+IFK0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=oq/FqRcHrL1F/JI01PBsiSG7T++w/rWJ/rbLGmK6IMvH3kkkJ8NSo1CwAkpkRAdhh
	 jmSSU5v/uEOJgcbGjqFKYjjUzBmImLaUkZu4gpMybGmsuGO08BdldkRQ3kN1Ed67vn
	 xzlcKrkK0HPdK39JGNK9Wds44m4ISL1UYx7pdnUxtNtEWQmALDtBgIb1jfaeiuF0T0
	 3axOBZewH5aKGnvNRG7B/GMG/WGKTjnJWAKj5TgLNRtnbMU5QuzBgzsJH4mOc8igJA
	 YPoSW43pB5CM0wwVNpmh5QgyaV4NHtxtdM2DeKE4FX3WxdgGDLfU4yJhCGq5rIVyOD
	 SWqluPn7eKr/g==
Date: Sat, 24 Oct 2026 18:50:46 +0000
To: stephen@networkplumber.org
From: Hadrien Patte <hadrien.patte@protonmail.com>
Cc: dsahern@kernel.org, hadrien.patte@protonmail.com, netdev@vger.kernel.org
Subject: Re: [PATCH iproute2-next] json_writer: fix pretty printing of arrays
Message-ID: <20261024183341.34161-1-hadrien.patte@protonmail.com>
In-Reply-To: <20261023181302.2a06fe99@stephen-xps.local>
References: <20261022211002.31098-1-hadrien.patte@protonmail.com> <20261023181302.2a06fe99@stephen-xps.local>
Feedback-ID: 2516487:user:proton
X-Pm-Message-ID: 5b31b400848a26c7366ef4a0c81ce1c1298892c3
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, 23 Oct 2026 18:13:02 -0700
Stephen Hemminger <stephen@networkplumber.org> wrote:

> Putting all the array elements on oneline is easier to read and more comp=
act.
> What does python do?

My current patch actually contains two separate changes:

1. A fix for arrays of objects. Scalar arrays render fine on a single
   line, but when the elements are objects, which contain newlines, the
   brackets and separators end up glued to them and the indentation
   levels of opening and closing brackets are off:

   # ip -j -p addr show dev lo
   [ {
           "ifindex": 1,
           "ifname": "lo",
           "flags": [ "LOOPBACK","UP","LOWER_UP" ],
           ...
           "addr_info": [ {
                   "family": "inet",
                   "local": "127.0.0.1",
                   ...
               },{
                   "family": "inet6",
                   "local": "::1",
                   ...
               } ]
       } ]

2. Putting each element of scalar arrays on its own line. This is a
   style change rather than a fix, though it is consistent with common
   JSON pretty-printers such as jq or python's json.dumps.

I'm happy to send a v2 that only keeps the first part, leaving scalar
arrays in their current single-line form if you prefer.

Thanks,
Hadrien

