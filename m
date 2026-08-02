Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5EE25B09C
	for <netdev@vger.kernel.org>; Sun,  2 Aug 2026 14:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785682177; cv=none; b=AYcKMWaY4s0oU3KPtcnDid7MDVIcsWx+9lt5TkXls//uWrakzt3IkoPKsaMBo5i0Y6s2FbwMmIsqDHuxAzCIVzeusL5iIm+vce7ICt4kwauM4Nqh8qqiQVRtH1EL8lrGWl8Hf4+L5HMstlt4z3TZ457RBg+mQ8D87acbo735mB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785682177; c=relaxed/simple;
	bh=1GBYwzfBy8Vxfvm1oZEvcR0jKJCGBUTse20wloDcbvQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Zh6nxNweWzLlCEXaRUP1ptYYNJJ4fmm5ftv/QTn8XPAdw/UI8rlxGfmSkoFNt4Cml2DgYN8aMWGhVG8gXKPkTg+cjyvhvsixYV9nMb7KXdie9POVsXCn8N1KbbSAgNanQA3eLD3X45bMnVteOjlUzu7zyd6MeGmYatNMPkQMP2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=slzgsG9F; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="slzgsG9F"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-668296d0ff3so3532120d50.0
        for <netdev@vger.kernel.org>; Sun, 02 Aug 2026 07:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785682175; x=1786286975; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=V4GM4/GqfAVb5cTf5RBA3BdX6aTeMVRI9zYqDVX3UjI=;
        b=slzgsG9FeCuTIe43xHAVACcf8d3K1z/h7vbSHZTQYdd7SKvnZSP9jnVJvxlrF/3mWz
         Mf5C52PaFT55bIHryvJ538XPt9BIrnX/NQ3WQHPn7MB6aYHnaAMH1Mk3gsz5NEeBUz8l
         qxw992E2Mgaf0Eg1IMZ5eDa7enq2be/KWEQ7adTjHBIdu5XMkgF6xiT5KHrewv8CCgdy
         SsTel7KMSRUbR9wvUOcF/TvwMoqwPLm5dD59+gi8XBkuPYnKxE8NqBstfYnDsD6KZDmq
         itc8LJ1NvY5+YeU1+p2V1j+WdvzKquCqyr05yz3XglE+qsUflwVd9/dW+nJMTN9ekAIA
         gO9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785682175; x=1786286975;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V4GM4/GqfAVb5cTf5RBA3BdX6aTeMVRI9zYqDVX3UjI=;
        b=jNqAEeFJJtfUAv8Nc0h66ZK/YZw1QJpvSw/fBQN3rNlfZPxh3xTMKuh0wPRnjfU6Lc
         5Pm+JigkcRc76xcpA3/OKH0DJM511xuDIc0KW+mwz9I+ogp9gUv1LbSXfts6B6JyMnpa
         qheczWMLLqVWSPFWCNHRPL1OCPqxXzSHqNm+orQs5PI8XAKEAh7e7C5TrqEZzL16Bvlk
         8pC6bVAgaV6GFvSr25m5EXjxTyokCQUlCZBvJp0QLUctGu4irFvZPOrQF5TRqp2mgbDv
         tb64Jbj5pnTOK9KLNrCce60k15dVWq/A6ddaAVgaak4iqwwtKt1bBBHW53yhu0MuVGQb
         MQGw==
X-Forwarded-Encrypted: i=1; AHgh+RqnPlEmRMqCyeegDmNpPoTwmE9D21tffpzhoBkxd4g2ROR+96hJq69Pz7GCgbPT1d9vlkyhuDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YykbicbIHKiH3S9IJvQq7YoLTpH0bh/UWexh0aZMYFl2Tu+6ywR
	xWa8IuF7K6iUbO+faRrHPjbusv8vNWSLbURo0Ta/RWnwav4F0je0UfPj
X-Gm-Gg: AR+sD10HMjFbbdXt1J1nD61Jaq05IK2yUSzARwsI6nDl9jEFBf5DLalE1QjwfIFdGlJ
	CHBHF+GGxWsgVHgpOZSWSANe5LndToyxEk8Fh+VHAg2QenTnqJjljl2479/PFm4kNqW2E6ayhbD
	meITTT5WQXyTtMmhOBmuwT5/+tWz6OVXMJ4Q0KaTZJECUb17e+Bgrop8ahejD1twePOgJfuPmmJ
	oqM7yUrHwHmIDUMhKVZzFTh6J8fL8Vue2PN03blnVyr1VXNa9jYjBdCCRV4XrRoRJHyhUnGVwQ8
	7rvOB6g4ETQdcs72Acl4ZWxvUCxNpfMOtD4qfIWB2LFujYHqUhCExu8vp9pLGvyJBfCyi5egD4s
	4nBQmtsxgjUrR74rEuQbYJDiZ/zWm9Eo1J5m4QGLvGIsjyELnJzVwoyzRzkaYzianZjg6VE4RUL
	IgbxzwTlPjrvdaKmUyMu9JsuDUWxNWoaSxtIX5eN7lzfxlwTgMkqaZ/phCKfVR3EwulmSTeCipp
	99XOlCqqieZi5AAsrwH3J1DvUTp+8Jqd/pZjy5RRQ4U7x8=
X-Received: by 2002:a05:690c:278a:b0:80b:9f4e:a73 with SMTP id 00721157ae682-81fd4ad19b2mr102865707b3.13.1785682174909;
        Sun, 02 Aug 2026 07:49:34 -0700 (PDT)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fccf2e4dcsm41166607b3.1.2026.08.02.07.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 07:49:34 -0700 (PDT)
Date: Sun, 02 Aug 2026 10:49:34 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Zihan Xi <zihanx@nebusec.ai>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 steffen.klassert@secunet.com, 
 herbert@gondor.apana.org.au, 
 kerneljasonxing@gmail.com, 
 kuniyu@google.com, 
 bjorn@kernel.org, 
 bigeasy@linutronix.de, 
 jiayuan.chen@linux.dev, 
 gustavoars@kernel.org, 
 jlayton@kernel.org, 
 runyu.xiao@seu.edu.cn, 
 kees@kernel.org, 
 willemb@google.com, 
 lirongqing@baidu.com, 
 vega@nebusec.ai, 
 zihanx@nebusec.ai
Message-ID: <willemdebruijn.kernel.65e6c22f2aa7@gmail.com>
In-Reply-To: <98097df6369ec684ede15b3658bfe7acd0cd5daf.1785529351.git.zihanx@nebusec.ai>
References: <cover.1785529351.git.zihanx@nebusec.ai>
 <98097df6369ec684ede15b3658bfe7acd0cd5daf.1785529351.git.zihanx@nebusec.ai>
Subject: Re: [PATCH net v2 1/1] net: skbuff: reject skb header offset updates
 that truncate
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Zihan Xi wrote:
> raw_send_hdrinc() and rawv6_send_hdrinc() reserve LL headroom before
> storing skb header offsets in 16-bit fields. If the reserved headroom
> grows past the representable range, skb_reset_network_header() truncates
> the stored offset and the hdrincl path later copies the user header to
> the wrong location.
> 
> On IPv4 this can also happen after the user header is copied, because the
> transport header is advanced by iphlen. The value U16_MAX itself is not a
> valid transport header offset either, because it is used as the unset
> sentinel.
> 
> The initial raw route is not the only place that matters. LOCAL_OUT can
> reroute the skb, XFRM can add dst->header_len, and LWT or other output
> paths can grow the skb head later. More generally, positive calls into
> skb_headers_offset_update() can wrap these 16-bit offsets, while later
> paths that recompute transport_header from network_header can still
> overflow it or turn it into the U16_MAX sentinel.
> 
> Reject hdrincl sends when the initial reserved LL headroom cannot fit in
> the skb header offset fields, and reject later positive skb header offset
> updates or transport-header recomputations before they would overflow the
> stored 16-bit values.
> 
> Fixes: 1a37e412a022 ("net: Use 16bits for *_headers fields of struct skbuff")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: Codex:gpt-5.4
> Signed-off-by: Zihan Xi <zihanx@nebusec.ai>

This is an enormous amount of code change, including in the hot path,
for a rare edge case.

Can we instead address this at the source at control time. E.g., fail
GRETAP (or similar) stacking if it exceeds a safe headroom?

The patch also seems to combine multiple paths. It mentions raw (and
those changes are fairly small), but then also adds checks to XFRM.
That should likely be a separate patch. If needed at all. As said,
hopefully we can catch this by restricting the bad configurations,
rather than by testing each packet over such a configuration.
