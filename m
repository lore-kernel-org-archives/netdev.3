Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2804C10C6
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 15:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790349853; cv=none; b=H4RFoKmDuUh2HGzdLzMWaeYRqJxBN9KBDJiKZCcRmAlxaag8fDW7km0RFmvboTvDaAdilqOp/Hu/wRmC3ZhNTtKGCJ4ntvBKmSVqt9M+Rimocf0jO9Gr/DSk/lMeTZgFt4FSZXnlgL3NAcx+G5jzECkOXSj5LCM1aTl7dkszikY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790349853; c=relaxed/simple;
	bh=gnXIFxNj0f+9/sIwBuR0kWygKjn6ND0POLoXGVjDgHo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rt9NyiBQBA/iYe7Ksk8cLXUuxADaafgAzZn3kUde5Mjjykvr3ygWm/QjyOyT99tuMcZZ8cxKafarbzXBtzwyu2f2qVZWg0uJxQLot997frrZwvrZrnZDONPLOjnSJlgC6GARxs/SfdhbP+Y31A1504ukM8/Q8GRwpvRZNVUNYek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=SG7DBCC2; arc=none smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="SG7DBCC2"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c2af3a4f193so66415966b.3
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 08:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1790349849; x=1790954649; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LVKVdTfVgge5LbrHqsqXvmQeab/dTYns0kONplxXyYM=;
        b=SG7DBCC22H9OHxMYJE1L/7pmynvcxHbnpt42HqB/4Hjq12DjonGN0HI7SHxIXk2w/x
         TJra3W5PCFQks6ij3G3uGn9ieRukskVoZvGo9AocWZaSXPva8VpAoyc+yiQXItQmnEgq
         cCfQF3nGkOEBMzZvqAceirV6gliKo5gTI0QwHuFpaw/3nidehAqkggo+mhEVagWfsHYu
         3RrFcDDOoqyeWjtE2PfZmh5lwgNeTPOXE+UdBu2SvejGcW4u0Y7n9yACupN5ISiQ4bTO
         fSqnFB7yn3n+vZm95FbYH3dsU3Gf32ViNsaTr0k8k/O94+3Hma6gx5x82UsxI6MGjUHx
         1CwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790349849; x=1790954649;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LVKVdTfVgge5LbrHqsqXvmQeab/dTYns0kONplxXyYM=;
        b=fkRd2h0R4NdOWNtzkmZS9DppRmBZqV2mQbitS5X5YNZQWvlLsano7t7QC3Kr6qQW2I
         Lx1ohp24xHt161wOowIaBHBzp/nRJv25GPk1qBFitSU+lMlo1FJs3yxg8sUZvUumZ1wh
         Vv0iw5bkQrok5rH1X0ieu066PGiuYCk4cCBVYazZPKpBSCQ7DEXv6oi2ROnyar1ONz+1
         GSefwlEclrFWsgIym/arTXiZxlVRhHz7G/yYYMnqahNcG3ZhAKv+VxBcW/3aCFRIbdgh
         tH3QBf3ou++5uHqyVDXsBgyZtxoUqiwl4cB+AEUp1xnRBK7SHImcAmHLBYvt1bz/BM71
         vC/A==
X-Gm-Message-State: AFuF++l0hsQc1p5+Gfn86Uvqqm9EOcPu5NTHoejQo7sn1TEwrFVBOtWf
	gXMat5obZniNol6S3UjN/tqtno4Qhezm7Q0rZBttHwVytcMR45mTIVkHuSW3eXJp7ck=
X-Gm-Gg: AYBFou1IgPpu78ddMZ73Mn57I3Scpn2V7MJmX90g2y8gEASy5GnCEHVUXzqJ+UNtOTn
	J1r/+SyYN9JRDef/MWhUSKGel1FllSDBudPN3qs2ZQbsA6H2hoVELEXXJW240KIgQK54UZMgXi3
	EJIkOLYDV/LcvzCXrR9LCcRaGybz0xddskPIywFezVpARWHGagkbp22WTNXxLlZJU27zDN/lKmK
	7A8ceR1Qsx9PdX/HcDEdp0QlYjbQdtCG2yL33QLOQK7zzEgsy8OXq3gRw6XOWRHAXB1J9LVukth
	gydSF9bvoCHUP64KOm9F7DTR7vwZWfnq/tdH9ED3ClV8aYZli4dcAnq/jRPHT8U/o4cSTvpu41O
	wBAZ8/XQqv7PA/f8mImUzktXI2YlhT6w6iJCLmOshZF6cnFeKvV9Yx8wbx0rookKZKceKcpBQK1
	rbHtYhyD1KZQpXM/gL9bxtuXYRZztgq2Eq3gBDeMVOc9VRsOu0xkAM972y2tXC/gFFbZgXR6lP
X-Received: by 2002:a17:907:3d05:b0:c29:583a:c291 with SMTP id a640c23a62f3a-c2ac24d0b01mr598278066b.21.1790349848022;
        Fri, 25 Sep 2026 08:24:08 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2ae77ff064sm129043066b.48.2026.09.25.08.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 08:24:07 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: "Daniel Zahka" <daniel.zahka@gmail.com>
Cc: <netdev@vger.kernel.org>,  "Alexei Starovoitov" <ast@kernel.org>,
  "Jakub Kicinski" <kuba@kernel.org>,  "Kuniyuki Iwashima"
 <kuniyu@google.com>,  "Paolo Abeni" <pabeni@redhat.com>,  "Stanislav
 Fomichev" <sdf@fomichev.me>,  <bpf@vger.kernel.org>,
  <kernel-team@cloudflare.com>,  "Daniel Borkmann" <daniel@iogearbox.net>,
  "John Fastabend" <john.fastabend@gmail.com>,  "Andrii Nakryiko"
 <andrii@kernel.org>,  "Eduard Zingerman" <eddyz87@gmail.com>,  "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>,  "Martin KaFai Lau"
 <martin.lau@linux.dev>,  "Song Liu" <song@kernel.org>,  "Yonghong Song"
 <yonghong.song@linux.dev>,  "Jiri Olsa" <jolsa@kernel.org>,  "Emil
 Tsalapatis" <emil@etsalapatis.com>,  "David S. Miller"
 <davem@davemloft.net>,  "Eric Dumazet" <edumazet@google.com>,  "Simon
 Horman" <horms@kernel.org>,  "Jesper Dangaard Brouer" <hawk@kernel.org>,
  "Willem de Bruijn" <willemdebruijn.kernel@gmail.com>,  "Florian Westphal"
 <fw@strlen.de>,  "Jack Wang" <163wangjack@gmail.com>
Subject: Re: [PATCH net-next v2 03/14] bpf: Make BPF skb extension survive
 packet scrubbing
In-Reply-To: <DLODSKPY6ON6.1G6SP3CFFLCPJ@gmail.com> (Daniel Zahka's message of
	"Fri, 25 Sep 2026 08:03:49 -0400")
References: <20260910-bpf-meta-inside-skb-ext-v2-0-0b21e42180b0@cloudflare.com>
	<20260910-bpf-meta-inside-skb-ext-v2-3-0b21e42180b0@cloudflare.com>
	<DLMVTU0WA4OA.BWWVXT5BYT8V@gmail.com> <87fqyypp67.fsf@cloudflare.com>
	<DLODSKPY6ON6.1G6SP3CFFLCPJ@gmail.com>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Fri, 25 Sep 2026 17:24:06 +0200
Message-ID: <87pky14and.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 08:03 AM -04, Daniel Zahka wrote:
> On Thu Sep 24, 2026 at 12:52 PM EDT, Jakub Sitnicki wrote:
>> Hi Daniel,
>>
>> On Wed, Sep 23, 2026 at 01:46 PM -04, Daniel Zahka wrote:
>>> On Thu Sep 10, 2026 at 10:02 AM EDT, Jakub Sitnicki wrote:
>>>> skb_scrub_packet() drops all skb extensions unconditionally via
>>>> skb_ext_reset(). It runs on tunnel encap/decap (ip_tunnel_rcv, vxlan_r=
cv,
>>>> etc.) and cross-netns forwarding (dev_forward_skb).
>>>>
>>>> This makes it impossible for a BPF program to pass metadata via bpf_sk=
b_ext
>>>> through a tunnel or across a netns boundary. The extension is always l=
ost
>>>> at the scrub point.
>>>>
>>>> Introduce skb_ext_scrub(), a selective variant of skb_ext_reset(). It
>>>> deletes every extension except SKB_EXT_BPF. Scrubbing is safe when the
>>>> extension slab is shared with clones: deleting an extension only clear=
s the
>>>> per-skb active_extensions bit, and the shared slab payload is released
>>>> lazily by __skb_ext_put() once the last reference goes away.
>>>>
>>>> Replace the skb_ext_reset() call in skb_scrub_packet() with skb_ext_sc=
rub()
>>>> and also switch udp_try_make_stateless() to skb_ext_scrub() as well, s=
o the
>>>> BPF metadata survives queueing onto a UDP socket receive queue and sta=
ys
>>>> readable there (e.g. for a sockmap verdict program). Only mark the skb
>>>> stateless when no extension survives the scrub. Otherwise skb_consume_=
udp()
>>>> would take the __consume_stateless_skb() fast path, which skips
>>>> skb_release_head_state(), and leak the extension slab.
>>>>
>>>> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
>>>> ---
>>>
>>> Hello Jakub,
>>> What are your current plans for this series? This commit solves the same
>>> problem I have with wanting to preserve the PSP skb extension across
>>> netns forwarding.
>>
>> I've implemented Alexei's idea of skb-lifecycle tracepoints that run
>> only when an skb is marked/traced. Currently putting final touches on it
>> before sending it out for the first round of feedback. You can take
>> sneak peek at it on GH [1] to see if it meets your needs.
>>
>> The CPU overhead is lower compared to the skb extension, at least in my
>> local runs, and the kernel changes are simpler, so it seems like a win
>> overall:
>>
>> |                  | gated skb tps    | bpf skb ext      |
>> |------------------|------------------|------------------|
>> | **busy**         | **+5.44 =C2=B1 3.16** | **+8.01 =C2=B1 4.75** |
>> | sys              | +2.62 =C2=B1 2.06     | +3.67 =C2=B1 2.76     |
>> | soft             | +2.89 =C2=B1 1.43     | +3.83 =C2=B1 2.10     |
>> | ns/pkt @146k pps | **+=E2=89=88 373**       | **+=E2=89=88 549**      =
 |
>>
>> I'll be giving an update on it at LPC [1], if you're attending, and of
>> course will keep you posted here on the ML.
>>
>> -jkbs
>>
>> [1] https://github.com/jsitnicki/linux/commits/gated-skb-tracepoints-202=
6-09-24/
>> [2] https://lpc.events/event/20/contributions/2549/
>
> Very cool. Thanks for sharing. So it seems your new approach will not
> use skb extensions, and this commit will go away :(
>
> I still have a need for this behavior of persisting certain skb
> extensions through scrubbing. I haven't considered all of my options
> yet, but I suspect the approach in this commit will work basically as
> is. If you are going to abandon this commit, would you be ok if I
> included it in a series of my own for PSP? I would, of course, leave you
> as the commit author, or give you whatever other form attribution you
> prefer.

Ah, I see now. I thought for a moment we were talking about extracting
some PSP state and passing it using BPF metadata.

Feel free to reuse & remix. I think it's enough if you link to the
original posting.
