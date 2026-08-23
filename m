Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB20E31E858
	for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 15:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787497879; cv=pass; b=kyu/BbtQvw9uNvL/FCdEq5KUFVwUWoLZRG9K5XxYFKvfc/RY7fTJv7SAv9EBXmE+CHZCmgha02PSq+p1dZLBPZp7zCHPPIm9/1Jm/8iNta6cCaNJ6xyvTbQdoRJsbtBSp2jwaVq3teCjxrJuJsZtdbDJiRH7rPXfdR00QuxR01I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787497879; c=relaxed/simple;
	bh=xIkR7zg5lhtFvWgzMHNup3lKSqq6a/c/k1dJRgDfsLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qBpInlq+eAU12kPskdR9DPFLZN4MegM3tGm5QmStpaSvw0aIdPwNv29Aa20Y5HrmlkaViGH2WAScbg137SrDE5E95zFyeTUY9XDMJ8Tf1pmoGNVOpFezdubgf9ccWxzrIc/9jPLbra3xxeb466+2M8Bj70FwGdIHoI+BLRcxy2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OAiHS/nS; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OAiHS/nS"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-526f963372aso18569081cf.1
        for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 08:11:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787497877; cv=none;
        d=google.com; s=arc-20260327;
        b=kLOJuseHxTruBD3+RRH7Uw+vGBMtPDALu/z2CEUptnLWs1XscD1MHvHKcX8BwJzamD
         Q4m7QCjLUS08lQfIrSnAxw/Tc6Nawgzg5iGRO5e1UjACCV7A6L0jYyxhgO7eTOkzD1eE
         AUrhXWgNIy6rT2WUyudkpGYnMZ/ZbpuJG4uqIQ6hJaXtPv6Qk2sUHLTQFMN6pLGF90bh
         gCRjKdhgWs1lpbOSxL1r9DdN0akamI6EaT/ORzyzPwE9g9Pmo8Nxpw41XuttFzSpn+tk
         dS7idyxoFa/5ZsLmYb0n5lurH9WsU5ncPO/fv7IO80BzBcJYfGYbNUG8Eu5FuhrwcC4t
         soXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xIkR7zg5lhtFvWgzMHNup3lKSqq6a/c/k1dJRgDfsLc=;
        fh=WYeCS5IGOFL6tFMdoIPPrr5zqVlBSTlREkYd+1FPD/Q=;
        b=kvt85FqBpz+ubEYrTmP9CtzcnZs7xzwpmDXsYdZHjXKc4pqEVa4qcTC4sa8QUgfh12
         iDjrkfgP1e5TcKxqSLQ2iJU9hBldXJ4Kz/eFjA2VszcX/n2NptcaR8rhLMMVQg+SxDeL
         LAHUlFOSGW8uDUWCDJoqfvyyOhsZfBUYzHHOp8DfBocLVUAxEwqIHdvGamspCPuETsPu
         S9mBtDjYKFTM8dDuwvjRu+1Iv1RE9uj95yrqHQgnmWQEPhMvY+7lG7F7l4b1oTH/eisF
         +r53cVdf8v1PMp4cBEpiuWtsOE3GRQ+XwtlIXwdV9FEiNvHjvRrEdLRF5WNeZL93lfOo
         0VIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787497877; x=1788102677; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xIkR7zg5lhtFvWgzMHNup3lKSqq6a/c/k1dJRgDfsLc=;
        b=OAiHS/nSmpqHFH949qkvPRDHKimAT91CmO98Ppxv+VVRd9Fcfs+8Cl4AOA+tdMhxPQ
         rZTnlPe3SvbnMR7hpDDXqeQ72koj7ZAb7VidsXjqEXwk1AkYrWiCH4AJLNqUmsCYos8n
         7HVwuWW27Xuxdu6KZ395WxHKrS4lFs2n0u0Z4af/mI5mKXn57k/jqU51tauSmcgXXiAg
         IoSwX1yCywnU/IaUYo4VVs0PHNlgE3EeU0cpCnCKJIn6o4TmUw8R/Td27VKpX4fjpWzO
         WKd5qwqMK70JtFrPsdngN2HR4mbzngQLG0TkYWi/98D7euqY/pSIADFa1B1ujnYLmkmJ
         htWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787497877; x=1788102677;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xIkR7zg5lhtFvWgzMHNup3lKSqq6a/c/k1dJRgDfsLc=;
        b=geuc42bujTvJPYmLQ6Mmi5Lcg6zkI4tH1TIXZBDTZPZdClquHrs2Z4WwjwNQss/fQY
         AeNGEcrMwmy5mNR9+LfclvmN5CdWBQpyrDbsoMC4WcAC0J/kyeKkbtQibXVoqx9Blpq5
         6fzi3iaR1PfhM6JPhzO1Gmzx+kOLXgx0mBdgqhKMirvHSxXdok1OuAx+4aeTKemFRp5R
         FWdkoMVpnQbTO4E1JYvfxUt3bkCliDhNtnu2Z1UmkkwwKZ9Uj1X8WybX9pO9Xw9YvNGK
         9I8pdHTZEVAWFsuLaXOl8s4+paPlftdqkMEwbs3iIbNLj9V3DiaopHW1OY7Yf/HkuQVD
         gTAw==
X-Gm-Message-State: AFuF++ng0hmmG2bFyCvCtFo9ejLfbycTHQABedzWvJhrs90D06DrBzrH
	9OttukLSGEYRT/X1HOeXSyWkWRm48+4awTSBrAZBOxQIcrbQ6lTr2lsfRpLk+rOM383LUn0ZpM8
	hCzzyxXQ35ROJiU1RYJszQdSL3EXxt+6ATd80Pmz3rTduwehQHMxDTSxUlBk=
X-Gm-Gg: AR+sD11SrgkID8w7XVlRIIj3BNDvRN8nxCAwfnOK4ivy+dPs8xxk3sDl2EH69u9D2+m
	p04gbphkH0ipzew+EMpYPU5W14sU46ZE46Hp5U3KeOJ8OAFGGU9ZzQeRzPQnxNvjtvsoRJVGmRG
	cR3+gzMcHDqYPDFm1gZd1n4vDNn4j0nvDp98ExO3Awb76PRhQRoTqKMPpnlCml9l5gMsSE2s2xl
	Z1ckbnU7yhHo+2kzmmP8gnfxKJz1WgjkUK7O8uuPoFAGYFKLAA5arhe5fqN31wV35EnzvIUf3f9
	P+QJqNDRNf1ptleaMlBuqOfzmGR/AL6pENZjJmhwwmVe6fgVUyLNSWMwc7SZo9DfJTBp0PpSVaD
	/YlymD/Am1LnhPKNB2F/wz0UkD9nfslCzuVzwYP8jztpldqf+sliPN4op
X-Received: by 2002:a05:622a:1f91:b0:52d:8c01:5238 with SMTP id
 d75a77b69052e-52e09cb983fmr112871311cf.33.1787497876233; Sun, 23 Aug 2026
 08:11:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260823101809.26802-1-shlomojune6@gmail.com>
In-Reply-To: <20260823101809.26802-1-shlomojune6@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 23 Aug 2026 17:11:04 +0200
X-Gm-Features: AcwNN1XEn31QwNoOjATtV2OBczN_PVRdSeHeaGm1GS7qzu4XZoVeex3ZR6dO9QY
Message-ID: <CANn89iJALGUB4jYyRWWMQENyNqBtSChOTiBwFzOVs-s6uX9Eig@mail.gmail.com>
Subject: Re: [PATCH net 1/1] net: Don't deliver IPv6 packets to IPv4 sockets
To: Shihuang Liu <shlomojune6@gmail.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Joe Stringer <joe@wand.net.nz>, Alexei Starovoitov <ast@kernel.org>, Martin KaFai Lau <kafai@fb.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 23, 2026 at 12:18=E2=80=AFPM Shihuang Liu <shlomojune6@gmail.co=
m> wrote:
>
> bpf_sk_assign() allows a TC ingress program to attach an arbitrary
> hashed socket to an skb, without checking that the socket family
> matches the packet's network layer. As a result, an IPv6 UDP packet
> can be assigned to an AF_INET UDP socket: udpv6_rcv() steals the
> socket via inet6_steal_sock(), which also lacks a family check, and
> queues the IPv6 skb on the AF_INET socket.
>
> recvmsg() on that socket then runs the IPv4 udp_recvmsg(), which
> interprets the IPv6 skb control block as IPv4 IP options. When
> IP_RETOPTS is enabled on the target socket, __ip_options_echo()
> copies up to 153 bytes of attacker-controlled data from the IPv6
> Destination Options extension header into the 40-byte option-data
> area of the stack-allocated optbuf in ip_cmsg_recv_retopts():
>
>

Really you need to ask your LLM to not slow down linux fast paths.

Fix bpf_sk_assign() and bpf_sk_assign_tcp_reqsk() instead.

Thank you.

pw-bot: cr
