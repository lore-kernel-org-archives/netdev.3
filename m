Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5D15625E4
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 17:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792000235; cv=none; b=a0+so7yWGQ1uq23LTgXUicQ1YdakZVv45NeoZCZzn+iAPsr9WeykUV4Afpeyop3AASaLQEUkWb4jIQTv2VP6AA9/BScSa5Kia1YubrZ36GTQOcWmyq8dNoaiUWGbNt54ZA9TPX6BW93OXQLui6LZnMBoSYenUJE0esdGjaQh/6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792000235; c=relaxed/simple;
	bh=jOEgE+7hZGq23m4Kwf1DaF7fI9X9TN6cpMzxIR01eQE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Iun7Hvu7Juiwru4wR27M0jJy/SL/qWsTlxgm/j2nGs+HDRrWC82+XNCJh228L7kJuu929NH/vWOYm3ePQHD6kb+rvGiCLnM3BQFkaA9rusbquUzgeLwnvzIZc6nfju1jKiF+j4LrnKuSUzLXBoM/Pxj9tnfebeetspb1eggGSYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=eGvlljxA; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="eGvlljxA"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c33bb2f3e6cso235031866b.0
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 10:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1792000232; x=1792605032; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jOEgE+7hZGq23m4Kwf1DaF7fI9X9TN6cpMzxIR01eQE=;
        b=eGvlljxAyFsJkM1yxRou1aGc6sVKrsM+psjmnP4Z0n5WCC1ieMv0P6pEyD0lLX+twW
         NAWpZXKS4EtH0YCfb2uut4i2lErx2jbrUAh9rouXB6NyAFtrtJ5HZ5pL9+OlOVk9kwFA
         bbvJrljiaN0fnMP2ykP3ePPE0NjIGgsBgZz/oGLXW5IPZwq21O13LhJPGx1kRnmBWxWh
         ZKbE1ZdKVQy1XCCiuxAbDGO8e7sQ+7CD7tTHCw4jQudumJA1dKlr+9DiaX1nfO/iCd/h
         qnQD9Yx62xaqegCvQ7tZnuhbsTha4wl8QVKV2lb9FtS82hGTDYqVqTSt76TrVwn+ueiw
         153g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792000232; x=1792605032;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=jOEgE+7hZGq23m4Kwf1DaF7fI9X9TN6cpMzxIR01eQE=;
        b=fhcc96d/M/C8QQFmQ3YFJLthArXug5PDtorq3aa2VWyAMLS3VAirRT6xuExJdpxcfh
         nU6152p1yB7QgpLhJbI+VxaiIQ67rEaJ+UwhHfIJr3fkkO0k5UXkSu3gaYUR90quNM6L
         Q+JgfC0EpCmj46tqCnD8YJuuOHKsP90TyNwVQNOfqldH/KmVA0Dl4ha7WUYKiNC5Wrsj
         S5S+KA8g1XnNfxzFX82Vlwi8V+NSUGLfsO/5Pje3w7aexnOLIdI+LIF8MIFl0wOkGbxq
         yGbBGtfhr9veYvxJqU+fBREMR3QY+ZQfelt8vJRNCmMX6Ys29FtRsXkTT9ej/ny3Y5/5
         Bj2w==
X-Gm-Message-State: AFq9FYLjTXd3UNOrpIxtu5mjocZo7cTVwOoTsWrK5D0wCGv/aRrizsT4
	oHJ4HRyJHVoGuftnw+Z0oV1iLcYO2P4TLeh7/sUPl8kPfUkF6jaBfFFtWyoOTXLEfuQ=
X-Gm-Gg: AYBFou33ZQMeDEh6Vus+CFCT8Pa9DIzO0P6TqX6T1Ll/VFzDoJDGNgIskFHvzSl3w+D
	JA53ZdZuNdBbb/YE0tU5SQjqdI19SKQTuKp2r81KreBF6IZk11+1NJgtvXgvq7H3SjjjeueNGRj
	D1rr3cLsypjBsdepiwmB4gqPsn0VmAgkWotEvHWxwSlILHDmOf6EbEQBt78/8M10cqVdatY0pNE
	euCdDexqxL9vigd61qkewYnBaEXA/QZ8Zf0baVr+YSlEKqFKNqLoSnsAA/TscTUgZWoi9kiqbZM
	EpVJj7zEQOS+s/B7yHMu80JID7qs9lnG0GZh79q4oBToVAF7pbWbWG/n+qVAVDx86oEFXBCLOeM
	i/ivcz8Jd/JLaCu01v5uJsyUm3FeduL3oLoRMQxxZZOaqmxrlVXoB59ktsDykY9IhZMUVMubcYb
	V/4ZeswiMaPDQvmYkYBjdzfRp2cxQSrxCPZe6gSxaDLI+r1vFYlrJi2nM6wk/z
X-Received: by 2002:a17:906:f59f:b0:c2e:4b90:3c56 with SMTP id a640c23a62f3a-c31a9fcf0c2mr1509659066b.13.1792000231355;
        Wed, 14 Oct 2026 10:50:31 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac6:5067:2dc::49:1e5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c3eda433582sm10353666b.64.2026.10.14.10.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 10:50:30 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Willem Ferguson <wferguson@cloudflare.com>
Cc: netdev@vger.kernel.org,  davem@davemloft.net,  edumazet@kernel.org,
  kuba@kernel.org,  pabeni@redhat.com,  ncardwell@google.com,
  bpf@vger.kernel.org,  ast@kernel.org,  daniel@iogearbox.net,
  andrii@kernel.org,  eddyz87@gmail.com,  memxor@gmail.com,
  linux-doc@vger.kernel.org,  corbet@lwn.net,
  linux-kselftest@vger.kernel.org,  shuah@kernel.org,
  linux-kernel@vger.kernel.org,  kernel-team@cloudflare.com
Subject: Re: [RFC PATCH net-next 2/4] tcp: add BPF_SOCK_OPS_TCP_TS_ID_CB to
 assign a TSval identifier
In-Reply-To: <20261013103906.2660384-3-wferguson@cloudflare.com> (Willem
	Ferguson's message of "Tue, 13 Oct 2026 10:39:04 +0000")
References: <20261013103906.2660384-1-wferguson@cloudflare.com>
	<20261013103906.2660384-3-wferguson@cloudflare.com>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Wed, 14 Oct 2026 19:50:29 +0200
Message-ID: <877bjk893u.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Oct 13, 2026 at 10:39 AM GMT, Willem Ferguson wrote:
> Let a sock_ops program pick the identifier that the previous patch
> encodes in the low bits of TSval, for passively opened connections.
>
> The width is set per network namespace by the new tcp_ts_id_bits sysctl
> (0 to 8, default 0). A listener opts in by setting
> BPF_SOCK_OPS_TCP_TS_ID_CB_FLAG, typically from BPF_SOCK_OPS_TCP_LISTEN_CB.
> tcp_conn_request() then runs BPF_SOCK_OPS_TCP_TS_ID_CB once the request
> socket exists and before the SYN-ACK is built, so the SYN-ACK already
> carries the identifier. The program sees the request socket, the SYN
> (bpf_load_hdr_opt() works on it) and the available width in args[1]. A
> reply that fits in that width is stored with the width in the request
> socket and is inherited by the child, including Fast Open children; any
> other reply leaves the connection unencoded.
>
> The callback is not run for SYN cookies, which have nowhere to keep the
> identifier, or when the peer did not negotiate timestamps. It is skipped
> for connections using microsecond timestamps and while the sysctl is 0.
> The width is captured per connection, so changing the sysctl does not
> affect existing connections.
>
> New /proc/net/netstat counters report how often an identifier was
> assigned, declined by the program or skipped. TCPTSIdEchoMismatch counts
> third ACKs whose TSecr no longer carries the identifier, which shows the
> echo was rewritten in flight.
>
> BPF_SOCK_OPS_ALL_CB_FLAGS grows from 0x7f to 0xff. The tcpbpf selftest
> used 0x80 as an example of an unsupported flag, so move it to 0x100.
>
> Encoding makes the timestamp clock appear 2^bits times faster to the
> peer. That shrinks the real-time span of the peer's PAWS window, and
> peers that keep ts_recent for the RFC 7323 24 days stall connections
> idle for longer than 24.8/2^bits days. ip-sysctl.rst documents both,
> along with the lack of TCP_REPAIR support.
>
> Signed-off-by: Willem Ferguson <wferguson@cloudflare.com>
> ---

I think SOCK_OPS are considered legacy.
We probably want bpf_tcp_ops struct_ops.
See [1] for an example.

[1] https://lore.kernel.org/all/20261006192601.1875100-11-kuniyu@google.com/
