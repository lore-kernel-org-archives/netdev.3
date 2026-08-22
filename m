Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CC81C5799
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 18:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787423763; cv=none; b=hXKIYX56VrcWYaqKZpsdW0JJJt8mH+bY1M3pm+8vhp3sH6NOxyHl3gkcDyPH4jNLSYdn4BMBv34SFg/LK9VMUqT2ZtTAUV/eVQkou4EexKJBqs6d4KgSv6wrGjXN2O47+a2w6tF25TttracLx6j+mFanilvFdrPmxym9PL2NmzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787423763; c=relaxed/simple;
	bh=TLLbF6WP09mYyRoovdyOa51a1cXyE4ifU6zXuKsJbMk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=NmUqBDiGZzfHkduhVqdfB/mIfqpTH2S/6nb+62iihMXlAaW5hyfhxiQWaeG12IFLAO4pkvYX26weN96j5WA6m+B64TzFZx5+HCMPcEiOQj9bvqKWtgasFyJXGYtFk6f3HbVR/WSoD78poGKGbB31f/dWNBaJBBEej5k8vUdcMBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rj9w6Cbp; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rj9w6Cbp"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-81f3b227a4aso34259767b3.1
        for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 11:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787423761; x=1788028561; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bS934iqIK+7uhKpQQcJWZHEutHeE7gGmDIz5JB+TEno=;
        b=rj9w6CbpMydItyn1lIS9BqnlbZSsTrjFen0zG1H/gc8RtOWpJ6pG7wRj0C6H1DFADA
         5tFnTE2iV6jIMXkBjJ+QYrPMmD9JM2QaNKcNwAeIemAtXrYW91t8VRuwcxuzqvBKnhxO
         aZZYzSFu936p3sfjt7CnzeT8Q1exfCCw5ZAmIXIwjYBmeHAT+RoNsdQFF1VZ5BNdGSiD
         YhM4WTsPdUmDoysYojj9JjMnNvmfKlMiNWb7C1cIsNt9tHIR74QOWmlvJW8Zjfnh6i+r
         WakzO/O5BgN6br6c0xwoxcmBwUT3nyVrAYMRGIaW5y6L+OuLqTr0KgdtBKRQUl5MkOky
         Zl5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787423761; x=1788028561;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bS934iqIK+7uhKpQQcJWZHEutHeE7gGmDIz5JB+TEno=;
        b=iV7RypbHmGyMjShLVvf1hDWgajR1AVrmTmqElB5JYf3cT+THnaSIWalXBuBZar/PD1
         ZI2Gx2yGekdnvv6GsNstQ2m7SpZNH36ZeiEznDorsPrFyX/bzn/kPbN02xL6jt01cTx+
         42Ilr5+Wi0H8yK+kOOzn7MQ7knhuQtEcDqktRXTQ16wsQCfGSl4vwHozRx/nBFelBDdO
         DGbjoTDS7Yp28iBMHK8UyFh1n+Qmj97uUhSkh2XufTi/bzS7GSg3yKkN1eFcFmtZArY4
         sN0DnitQ2Wsk/YmXhxLQ09RovihyO6Nr8e+YEl30e5QA5GkaCJAlCb+lI2SREFB0ldyL
         rbxg==
X-Forwarded-Encrypted: i=1; AHgh+Roa9bgylAq71zkNcj5PJjkQHOMxLrSMeYRZss3fZDHQg+lbrSuERopIWuDe6Y4HDgQPdrtmeiA=@vger.kernel.org
X-Gm-Message-State: AFuF++l/Xu3kr5ka++hr1qzGEFq8vsRnTvsg+OjGejXLAhCgvqgJKnsK
	wXQsvFHrl1OLVYtdpr0TRpdJj691gV3w/+qQgn9mCMZxAlzgA/REHJ0v
X-Gm-Gg: AR+sD13XOwjJV4A+wIcRTusBmXcV2uDz6nusX4koSj0wWdqOcX4s7s572L0v6fXAg2j
	Bg77WFQZ22JsZ428i6evhV1USbG4pQrFSxOcj8klsVYEIY1Ajix62gp8rub+I8J+D5pUC4PQVM1
	syKpaQlKhq+CkausmsqOqfoqY4Rs5nv/xx5ZwZPiDATh/WwrW6XVOZ6XURvwZZ5mopLwA6vyERB
	F+T7A3pPSYEFXuO8YQRkg6dDcYUuo2rrJA7xKTGX+BXBDMfsEkIzxErk7DPs6fN6OZ1luhQxGVg
	PwtHrNtpFbvxmg79pmkVmyuxDe8RFhpuH2/kS/74lHnorRY12DGnTSinbK6hiThcfRsDsWRYsYY
	FuVHuyKRA7XZh87VxR/mvEqVFSqnUAywSrbqrxmC2JUg8BeEVExqXlyU66OGyAiJnEiufGF+Yq0
	D6tgWm/CEHSU/+hF0bGM3nEFZQmz7ypo/b8fZ2gQmga8GoHtpC/SMjyzR5LbEDPPlTLbrgZwfMN
	k/GT7MpHrza5bpwfcSbQNlZRDEoG6OuCHseIslybg==
X-Received: by 2002:a05:690c:a9e:b0:845:ddf4:a3a7 with SMTP id 00721157ae682-849f2456e27mr68174927b3.16.1787423761062;
        Sat, 22 Aug 2026 11:36:01 -0700 (PDT)
Received: from gmail.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-84caacaf1e9sm13253657b3.23.2026.08.22.11.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 11:35:59 -0700 (PDT)
Date: Sat, 22 Aug 2026 14:35:59 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Alice Mikityanska <alice.kernel@fastmail.im>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 David Ahern <dsahern@kernel.org>, 
 Ido Schimmel <idosch@nvidia.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, 
 Hannes Frederic Sowa <hannes@stressinduktion.org>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 netdev@vger.kernel.org, 
 Alice Mikityanska <alice@isovalent.com>, 
 syzbot+ce13c07d96d04716eaa2@syzkaller.appspotmail.com
Message-ID: <willemdebruijn.kernel.d16fc5b418dd@gmail.com>
In-Reply-To: <20260822115717.1161782-2-alice.kernel@fastmail.im>
References: <20260822115717.1161782-1-alice.kernel@fastmail.im>
 <20260822115717.1161782-2-alice.kernel@fastmail.im>
Subject: Re: [PATCH net v3 1/4] net: ipv4: Fix UDP length overflow with PMTU
 discover and big MTU
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Alice Mikityanska wrote:
> From: Alice Mikityanska <alice@isovalent.com>
> 
> This commit bounds cork->base.fragsize to IP_MAX_MTU to avoid a
> possible overflow of UDP length that triggers a WARN in
> udp_set_len_short when setsockopt IP_MTU_DISCOVER is set to
> IP_PMTUDISC_PROBE, and a large packet is sent over a netdev with an
> unusually large MTU.
> 
> Steps to reproduce:
> 
> 1. Set device MTU bigger than IP_MAX_MTU + 20. cork->base.fragsize will
>    be set to that MTU in ip_setup_cork.
> 2. Set IP_MTU_DISCOVER to IP_PMTUDISC_PROBE. It lets maxnonfragsize be
>    set to device MTU (cork->fragsize) in __ip_append_data, rather than
>    to IP_MAX_MTU.
> 3. Send 65528 bytes of payload (+8 bytes of UDP header, +20 bytes of
>    IPv4 header). Device MTU allows it (it's only one byte bigger than
>    IP_MAX_MTU + IPv4 header, and the device MTU is bigger than that).
> 4. The UDP length in the built packet is 65536, which overflows the
>    16-bit length field and triggers the WARN in udp_set_len_short.
> 
> Note: IP_PMTUDISC_DO with IPv4 is safe, because ip_dst_mtu_maybe_forward
> always clamps at IP_MAX_MTU, unlike ip6_dst_mtu_maybe_forward.
> 
> The Fixes tag points at the first commit where I could reproduce the
> overflow with IPv4 and IP_PMTUDISC_PROBE.
> 
> Fixes: daba287b299e ("ipv4: fix DO and PROBE pmtu mode regarding local fragmentation with UFO/CORK")
> Reported-by: syzbot+ce13c07d96d04716eaa2@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/6a6a966c.86abc875.e5c3d.0054.GAE@google.com/
> Signed-off-by: Alice Mikityanska <alice@isovalent.com>
> Assisted-by: Claude:claude-sonnet-4.6
> Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
