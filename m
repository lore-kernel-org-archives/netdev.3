Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.196
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794243148;
	b=SJxtaH/iYdxDjTrXuaXbQ+WTStgC2fzysnzyd/bjf+jUwEMPPIDb2J1OtlPOfa54/A2p
	 qqf9EfI6KsheLiwS/unrCORiVoBdNl9mKkspd/ng/SEC3SQT20nsKYqcLR4h6Y89xz5w3
	 HebJrWQkEWNU+s7EPcnYfUhUrjG/xmn857ne3AvgSrTR40eIfYADdHdZObMLIR9GsfkNs
	 98HHMxVzJXmOCSqnOKSVeYHlVZe7IfRRaAKV12omeCfllyfLKb6u5VTVwBd4HKcevQdx0
	 DOQc8G7sJL0BSKGi3S3/UHV5DKRjB3Qr4IoG6X5iSByMU8vGx1DvclyAuTLjOzEnhsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794243148;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=fuHZtQtU9lROZ/O4yKt27hj3wfZGAKcA/Fa5UWAqKTQ=;
	b=P6x+IEKpx8dgaxFByB2QdxrBhpwp1feNm1R4xeuT/KNUfDUk8bMQrhI1K46bUg6xgPWb
	 REHFbx/hLCdaG07bQ0RUrpQyhX2cWyhAUyEPj0yhoxr88glMQa39nxLCxHZA+f2GnbPbw
	 phB5QKnucauJe5S0cjVy4R2dos5zxEBnoojKI4+vWfBJz9yx5sU5RKKgSgq/Bvb3uULBi
	 gi8p+CYjHXPNbTqaMT1+CGrJnhNY0nu7/YS732jBlxVQEbAwmNGlTLM8ZKzF5jYSbVZ+p
	 RvNa/f/NsQyaNFVkn30EH11sBgdSsHya3TjTwCNyfe6RRKrDwIM6RMJkEWcRkDOay5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oYQ+80sk;
	arc=none smtp.remote-ip=74.125.82.196
Received: from mail-dy1-f196.google.com (mail-dy1-f196.google.com [74.125.82.196])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1A0606A33A
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 16:52:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E1A0606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oYQ+80sk
Received: by mail-dy1-f196.google.com with SMTP id 5a478bee46e88-36fb88ea38cso1376794eec.1
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 08:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794243147; x=1794847947; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fuHZtQtU9lROZ/O4yKt27hj3wfZGAKcA/Fa5UWAqKTQ=;
        b=oYQ+80skzcfQpY3fF1yZKzX+O37yAjXKx6eHf4T1UfvLj18R4WOQzZZtSEbKuJjtuW
         3x+YNG3bHeC9Ye4jsFbYOvFW0WfPhTICaT9ykexDNTsgY33laAkCJV6fxDzsXzflc/Wt
         TkxL/ya0bxd3lRyCxPMOTqUkoBapk1ozZqnxDD0RbCdBEhw1NOAx9quaXcndZ6RJPZTp
         2zMF+P7mE7s3cGnTOPKFDC1cHoobSDLqIrsHAjjLx2e+WVjKXoUtd7SjrpRna0wAzrzY
         Ssck9TzkQp08fH5Z6eBNXLJjZIJyWtb1t4HD1xziSAiwap8738EdkG7tB8sDXO0FfQKD
         hOWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794243147; x=1794847947;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fuHZtQtU9lROZ/O4yKt27hj3wfZGAKcA/Fa5UWAqKTQ=;
        b=uNHq+Q95ebaO6ql+6NiBCTd8xZlmz/ZBOoi4ElTMFIB5x4OxW1qL6KaDGUFJ1QdzdW
         sPbV99mu/xYo1S60xPpTjY2ZhqumJzUKOsco+XrePADjE+skicN/Q/D2UcpjxvjO5p2E
         DjUl7QaK1BavlllqS2pNV5bNuVLcL+5e31S396TMOj/tcSw7wZokO8cairQY+0i84LVa
         QhuDYkaYHpzqnlOfmazJLiHEuuQq/r6PNTgHKSA2M6qPgx+012zz3TNQbTRC2h82+nhd
         Tu4Kigxfn9Fh/dcnkNirHdVlvmPf28HfUVoYGpqnsW/+EgE9s+eb875vZidpplFThZuU
         JrvQ==
X-Gm-Message-State: APuU4Z83qv7+/0b5/1w+gAYQZ8gspnpURaIHiqFbXdzEnZ9OqCqD5CxI
	sPtlhcYP0J4Za1CxJniBAbh9sk3/R/v/fWVQ/FlikxIYcKGtn2h73pOU
X-Gm-Gg: AYBFou32xH2GV8hmMjdjvPDuctmKOCsPn1Rb1GZkE99O/P76Snzc/3yiyVUHTjatgZn
	vvXinAmNNVScbJdmOYTxbNYjGoJ11XsB7YG0/rgbvVPq9u6szLsb3dOrjVkaT4jScOGuGooJ7ES
	ZqYGprdq0+m8KCSwDlTmiyD/tGBCQEFUHViqTt8fHlYBPKz3AVAgfX4G6Wt2RKMcqIjWUnUz9of
	sx28iLfhwyH3Ak/dMce0M5rBMU+IIZ4taWIwYtYeor9qUglrPSe0stWT+sVKn6ostXJ7vfZYnUP
	E0Hf0K4HfDxph1FM7NPIS5kFMLpc9T+hJmCqYcigtDAS5ddazEHiqWf5fEsqqBUrOz1+AvSjypw
	md+054zspo+M6PCJKBVpWdpLnVOnkV6+ZtcBkJDa8xEpHTiDJAhfL4ds2WSuCY6pzV75LkUNms/
	aRx+1LAM8Cs0EzBTl3g/U0SR63S/nrBMzuvyzkPYZKLw/OgxqlzMZd8WRBLKi4q8CX5NpTZ4+0m
	BrjAqVkKt08rruL38v1vf3Umvut0rWovBLYOBqtnAzT3bq7OpNk9+sv19V/KPt/WLLAa7VK/Sv5
	ZXeoPgWoD7272b1FuJgEgQ==
X-Received: by 2002:a05:693c:65c3:b0:36c:a2cb:6ad0 with SMTP id 5a478bee46e88-3750903a112mr62054eec.8.1794243147013;
        Mon, 09 Nov 2026 08:52:27 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:6d::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372667d78ebsm14764519eec.27.2026.11.09.08.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 08:52:26 -0800 (PST)
Date: Mon, 9 Nov 2026 08:52:20 -0800
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, magnus.karlsson@intel.com, 
	stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com, tushar.vyavahare@intel.com, 
	kerneljasonxing@gmail.com, bjorn@kernel.org
Subject: Re: [PATCH net-next 0/4] selftests: move the AF_XDP test suite from
 bpf to net
Message-ID: <avH47_V-WbLm35cN@devvm16445.scu0.facebook.com>
References: <20261105134117.977655-1-maciej.fijalkowski@intel.com>
 <auzqcm1YLsTvUU7S@devvm16445.scu0.facebook.com>
 <avHAGLwtyucllh/M@boxer>
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
Content-Disposition: inline
In-Reply-To: <avHAGLwtyucllh/M@boxer>

On 11/09, Maciej Fijalkowski wrote:
> On Thu, Nov 05, 2026 at 12:43:36PM -0800, Stanislav Fomichev wrote:
> > On 11/05, Maciej Fijalkowski wrote:
> > > Hi,
> > > 
> > > As the maintainers asked, this series is the first step of moving the
> > > AF_XDP selftests from selftests/bpf to selftests/net: the code moves and
> > > builds from its new location, without changing what the tests do. The
> > > rework [0] posted as "selftests: net: migrate AF_XDP test suite over to
> > > net" (v4) will follow on top of this move.
> > > 
> > > Patch 1 drops the test_progs wrapper of the AF_XDP tests, patch 2 adds a
> > > generic BPF skeleton rule to net/bpf.mk, patch 3 moves xskxceiver, its
> > > library and test_xsk.sh to selftests/net, and patch 4 (new, not covered
> > > at [0]) moves xdp_hw_metadata, which is built from the same library.
> > > 
> > > The xdp_metadata test stays in test_progs: it covers BPF core
> > > behaviour, and moving it would mean rewriting it for the kselftest
> > > harness. It keeps using xsk.c from net/lib/xsk.
> > > 
> > > xskxceiver and xdp_hw_metadata are the first users of bpftool at build
> > > time in selftests/net. NIPA has bpftool, but 0-day and KernelCI build
> > > net without it, so both tools are skipped with a warning when bpftool
> > > is missing or does not run.
> > > 
> > > test_xsk.sh is installed but not run by run_tests, so NIPA does not pick
> > > it up: it runs every case, including flaky ones, and some cases leak
> > > page_pool pages after skb_pp_cow_data() in generic XDP mode on
> > > veth-based runs. Until a later step makes the suite fit for NIPA, no CI
> > > runs the AF_XDP tests. test_xsk.sh is being removed by [0] but it is
> > > kept here as there is no other feasible way to run the test suite (if
> > > needed) until we come up with an upstreamable Python runner.
> > > 
> > > Thanks,
> > > Maciej
> > > 
> > > [0]: https://lore.kernel.org/bpf/20261016174338.787135-1-maciej.fijalkowski@intel.com/
> > > 
> > > Maciej Fijalkowski (4):
> > >   selftests/bpf: drop the test_progs AF_XDP wrapper
> > >   selftests: net: add a generic rule for BPF skeletons
> > >   selftests: xsk: move the AF_XDP test suite to selftests/net
> > >   selftests: net: move xdp_hw_metadata from selftests/bpf
> > 
> > Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> 
> Thanks for acking! However for some reason clashiko missed this set, can
> someone remind me what could be the case here?
> 
> I also see in SUIE that check_selftest failed - is it mandatory to repost
> in this case?

```
Bad format: tools/testing/selftests/net/Makefile
```

Not super descriptive :-(

Maybe check on your side if this is complaining about something legit?

https://github.com/linux-netdev/nipa/blob/main/tests/patch/check_selftest/validate_makefile_format.py
