Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794192864;
	b=q9GppLDzIRwf6oih955xRPsPL9TswWoRV5crNlwFcD8mkLnxLzp34cL/ITHnS/F0Mwgc
	 sOe2yzr8pRCsALKOCy+SdR94+2P+AGNsvXBqkKPe1K6pUdyUGvsvg4mcaTZsyYirzSn35
	 OZHSfbD/zpW5zQ9Ti25mGILsXwGJAvKk0Qjn/0ByLLOdTWsLTnvdvHFwShBaAEVMBY/gv
	 jChpcSrBoHEG2b6aCEEFm8PDdx8JS7OXBVDMX1ujloGzI14EHCNjyMScg3mAVnMxc5+By
	 8I/AaNwmp+MZHEnH7W9X9I0jY+JBADTV0jgszoODismCRCQfBvKOfwkrDu9mlOu6rHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794192864;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=YFiFvM32hOcR5Y90zApzECJ7RVHYz69VRXl9qwib/qo=;
	b=EpUrpDC6I3fWgDNgEBLenHlG6itNnQz2lJIdx7VHFgBvglZildsBSbJd7QMRhgdw/PaK
	 GUMCZTVTLG9AFssdWDM89aEzhxJE3aAxmdGvKIbQGpBJFiiXM7HbiTIlHGy01rhQkOF9N
	 bY/12uOUGpOQcB4dmHDhoUtTL+k6No0CQeGFvHxcSdVUHAquIlDc+xZBEEUNYbMT3ma3m
	 5nqOt18mNTugfnpRhJ72/LPMv88OTcJgzPheTAlcQGzLnFla5bDwOgb8JlWF5rgllgRHS
	 1L9+EQ7/fxakdpkQmyNrypO27bvN01ulueMdr9DtXPAlgO/Qw+/k9TyNIotnGhQqLtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=gMh86AzT;
	arc=none smtp.remote-ip=209.85.210.174
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D648606A31C
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 02:54:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D648606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=gMh86AzT
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8a052aff9e9so294931b3a.0
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 18:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794192863; x=1794797663; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YFiFvM32hOcR5Y90zApzECJ7RVHYz69VRXl9qwib/qo=;
        b=gMh86AzTUxJsjktaXCiWQhVjfcIZq34kh9cg7PRORFrBK0/f4OWqfeQY/Uthvvb8VT
         oBsyotvQS4Ukkt+mTLCQ6ff25GUR5oBWKvQiiBkdC3LFG4OFr3cVarUvOCbAaEwLPAPq
         0ZbTUdxo1TGIkkxsQBScdYjYciBWP4RO5PHn2prt12a05D/IblRxUYIQyGk+wwCQNSho
         LPJLVOOCd9MaTqpMo8ahQ+oMIyDXtXvjSu+OPb6KOAu0t881srQ4iDhUwlTWm8J2SaFR
         3qSfznAvoW1XdDRKITQIgs154Q5WLnI+FGmFSoxkmEJm/UOpr3VqMwq3a317gDaXlQST
         4nWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794192863; x=1794797663;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YFiFvM32hOcR5Y90zApzECJ7RVHYz69VRXl9qwib/qo=;
        b=Asr2mAJvKH2oOMHeid49W7sO8H5gZoCYi+rr9vQ62tk/lHSg/uCmbE9vfjhNY2uMHI
         zpuzGVoSl3Y8a5W+xr7tfJ6sX1OkTTYnaRwhnS2peKT9+4g3WYPfgFbL/5v7/NItt6IM
         XMmlGggYTzfRGJLG2MHaVGIc8+Oomv0rYpewEisxOwQetLYS+cDHARxkeyd91WPeL/JA
         Cld3AHwwsU39pa4MTZaSj/ZkavdIVdDYuk9LkzgdVFng4HSD/WXV2AX+rzFI/DLaYgym
         mwmAr77EnuCsQ44byQ4H960NWDz+pcks0dys0X1NS1FXeFDTMM+XInmJ+VuU/H6Ny4yu
         Nycg==
X-Gm-Message-State: APuU4Z8It7DHRuv42iqRSWk/qYkb+1mUgeKsIEZR1wwsVz4F930jhjnR
	P0kCxEuP4LVfG+AJc0QQ8bbNbZvP0thnJL3eOFOiQFpVDZRF2wrDsiEmoW6s05XQez4=
X-Gm-Gg: AYBFou1BflCtRB9JS/u4F3+gRO4/EIFqFCZiG86vhNa1VYhC7x4UDWRDRVxf8UsZQvU
	jttle5t7zmhamyDCvJvXRZPXH2H1YkWJkgHZUUcylDUdJTLFuMev+Vptda8MFdJAX5tWnVi2Lwe
	D5dLU5fEiwjHpmrjGIvn1CqKMNjbTVlALvWA5Z+4uYTXWoPRCUBJnRqj0rZOOQx4QcyUJkmmTYm
	wn09Rhn6fvv08uEM6nq11JKzDwHbjAB/DmfGpCd1OU4op80AbBdh+fSCHYbEWS0M6JE2w5kdSco
	XVTzUQY61itrrKxe0zkthwwokcUHN88rc9TKJCI2oT2HMbXWX28sWgbsFM91oDj+ANFFBvjBfpD
	wqVmPTWXQpyklrUFcy/WodhPw81ROg/hpkAUFi6rFncm6XVOQaVuYvPGI+aEg/BkQhQBUYTYD8o
	XVhmA3GApuALAaeu0pr5vSbQphWRSJ9X5UxgWgbaWGMiHySjpTpH7K68NAeJifvSfeN0IuWLWw3
	Q4Az3ov5u1a1/Hj38KrE4674MuTl3rM2YCSBJJktip2h1PuN35REQ35kWtMvhAIdA3DAYvwxKSq
	ecLNo44j2341gXIK0AQF8vRw+VlGc2l9GItUSm7ot32np9DYJLePSMPz7wzVde3FJRG/SOkY
X-Received: by 2002:a05:6a00:3289:b0:8a0:58c3:8ceb with SMTP id d2e1a72fcca58-8b67026524dmr2442507b3a.45.1794192862733;
        Sun, 08 Nov 2026 18:54:22 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b649b0d50fsm883376b3a.40.2026.11.08.18.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 18:54:22 -0800 (PST)
Date: Sun, 8 Nov 2026 18:54:20 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Fang Jiabao <kaquoin@163.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2] ip route: check return value of addraw_l()
 when adding encap
Message-ID: <20261108185420.1d3dba55@phoenix.local>
In-Reply-To: <20261102090535.226168-1-kaquoin@163.com>
References: <20261102090535.226168-1-kaquoin@163.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  2 Nov 2026 17:05:34 +0800
Fang Jiabao <kaquoin@163.com> wrote:

> iproute_modify() ignores the return value of addraw_l() when it adds
> the encap attribute. If the attribute does not fit into the request,
> for example a seg6 encap with 60 segments, addraw_l() prints
> "addraw_l ERROR: message exceeded bound of 1024" and returns -1, but
> ip sends the request without the encap attribute and exits with
> status 0. A route without encap is then installed silently.
> 
> Return an error instead of sending the incomplete request.
> 
> Fixes: 1e5293056a02 ("lwtunnel: Add encapsulation support to ip route")
> Assisted-by: Claude:claude-sonnet-5-5
> Signed-off-by: Fang Jiabao <kaquoin@163.com>
> ---
> Tested on current main (e4cd9f1d, "json_writer: fix pretty printing of
> arrays"), in a network namespace with a dummy device:
> 
>   ip -6 route add fc00:ff::60/128 encap seg6 mode encap segs <60 SIDs> dev d0
> 
> Before: "addraw_l ERROR: message exceeded bound of 1024", exit status 0,
> and a route without encap was installed.
> After: same message, exit status 1, no route installed.
> With 59 segments the route is still added with encap, exit status 0.
> 
> With 63 or more segments the failure happens earlier, in the encap
> parsing, with a different error. That is not addressed here. The same
> addraw_l() pattern exists in ip/ipnexthop.c and is not changed here.
> 
>  ip/iproute.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

I agree with AI review here:

The bug is real and worth fixing - thanks. I reproduced the
error-then-send behavior: with 60 segments the unpatched ip prints the
addraw_l error and still hands the request to the kernel (the reply
proves the send). Exit 0 follows from the ignored return value, matching
your test. Silently installing a route without the requested encap is
the worst possible outcome here.

But please fix the cause rather than the symptom.

> -			if (rta->rta_len > RTA_LENGTH(0))
> -				addraw_l(&req.n, 1024
> -					 , RTA_DATA(rta), RTA_PAYLOAD(rta));
> +			if (rta->rta_len > RTA_LENGTH(0) &&
> +			    addraw_l(&req.n, 1024, RTA_DATA(rta),
> +				     RTA_PAYLOAD(rta)) < 0)
> +				return -1;

The request buffer is 4096 bytes:

	struct {
		struct nlmsghdr	n;
		struct rtmsg		r;
		char			buf[4096];
	} req = { ... };

so the hardcoded 1024 is simply wrong - it is a leftover that bears no
relation to the actual buffer. Every other attribute in this function
passes sizeof(req); this call site is the only one using a magic number.

That matters because the 60-segment case you hit is not actually too
big for the message. It only exceeds the bogus 1024 limit. Using the
correct bound:

			if (rta->rta_len > RTA_LENGTH(0) &&
			    addraw_l(&req.n, sizeof(req), RTA_DATA(rta),
				     RTA_PAYLOAD(rta)) < 0)
				return -1;

I tested this and the 60-segment route is accepted and passed to the
kernel instead of being rejected. Segment counts up to 62 work; at 63
the 1024-byte rta buffer in iproute_modify becomes the limiting factor
and it fails there with a clear error - which is the earlier failure you
noted.

So your patch makes a working command fail loudly, while fixing the
bound makes it work. Keep the return-value check - it is correct and
still needed for genuinely oversized attributes - but combine it with
sizeof(req).

> The same addraw_l() pattern exists in ip/ipnexthop.c and is not
> changed here.

Please fix it in the same series; it is the identical bug with the
identical 1024, and leaving one copy behind just means someone
rediscovers it later. Two small patches are fine.

Otherwise the patch is well formed - builds clean, the Fixes tag
resolves correctly, and the commit message states the problem and the
reproducer clearly. Please respin.
