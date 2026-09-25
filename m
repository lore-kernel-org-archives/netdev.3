Received: from mail-qv2-f43.google.com (mail-qv2-f43.google.com [74.125.230.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889F2282F21
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 12:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790337838; cv=none; b=bZr2STi33dj28FIpjzi4h/4WyHg46XFt7AQsH0DWtNg/ywReGVh6PbUe+dbKeG1nQhZVPYcjCo4yxhpRskOHygwmGAoqJeJW5wXnxqNp6LE6A+idN6ZjTWH2YUMV/CbCRqmvVaJFi149gxlb0OQj6CqYOlG3KvNKOgh1Wv5+itc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790337838; c=relaxed/simple;
	bh=ixwmkNZ3SWDZVz8mQfPlOlJTV0BDbUAdCzjM6VcNE+M=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Q3dMcYiLQmWmZvwioQxHlrgIwHoAKLt6CfO93OwFV8YyNdLcpoI3nyfd4MoXxR317vXOx/3YEwqRT49jfHXZ+DptxzpeD2m89hgJ753hA2LL7j8UwhLOKMngQve6/VmeWQvxA7BcfyRwg6vcT50HG4Y34Kog8fR6B0BT3oimncM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gqwsL1MD; arc=none smtp.client-ip=74.125.230.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqwsL1MD"
Received: by mail-qv2-f43.google.com with SMTP id 6a1803df08f44-91415b09bf9so7178746d6.3
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 05:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790337832; x=1790942632; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YdWP4IV1+oqFik4nzEL8bohta4om7bbzxqnMeqGI3WY=;
        b=gqwsL1MDoFSow8VaQWh/J/FH40JCAmn2g94E01++CaTbjhc0kJlAlwgZiGwaVMwRf7
         HahbO+VCohFpHvjGSiuNzTNhueHhCf0ejva6V7D1wb5dJaJSkbvt05VbNcETbCp3BrVo
         shLpOa2hmyBYrw+3TSHZicM2qod062VzUcexke5bOw22QNmQ9VXkY0yl+JyXTrZhTubK
         1eaG8EyW42z176QwOHVTLl/Ul29Nc2t/n7GBffe2vc3Lpl/1u+b0cmGPc+oTU+I8QXds
         KWD7HWB0jE8XGAdH/XDE8uJMp6pq7Ms0pRlrBRgZpE02BIim73QVjamEacudWsesUfZj
         i7tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790337832; x=1790942632;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YdWP4IV1+oqFik4nzEL8bohta4om7bbzxqnMeqGI3WY=;
        b=aq7L9bbOqd2b/Ug2uSXnJAZaYqOujb0xepVVLbkoVmiVN33oBwyH2/XeT4kJnbO78d
         lR/YF0d/Eydaq3JezFbg+CW2plxLaORk4XiPv6qzi6o7tZs1GZEw/UajbFl1m92WDQW+
         /E1/Od2MYilMs52xCLHTzbUoC1JHaleaITMHapk7xCVfzaiFDcpTJhgjOSfLolGEsD9D
         0EwQUZ5Qp+LnZc2UR1iMgt6NIE6wKGWkrPE3LOYl5CA7vbTwUVIU74e4e8affPCp+oJ9
         gQ9+mAaglxgLjMTKnT8G4UhhP8CY8E1JoJaxtbN0E4Af8ffutfk+urVX16VCzRjP8TXO
         OEJg==
X-Gm-Message-State: AFuF++lgiRveIPkRVQqTuwy7ekRSYtbnAgZ9msZguVEeVvW+GYJ74pXh
	3rGmM8YB/zmjBVZhEnxVUQcYuvxcDUHIi/hpPD+ONZUfQ+qzWTKue0JB
X-Gm-Gg: AYBFou3EE+nZCC3wKspCUxzAvTf6+O7YdQn4zLuKN3dd4vu27946TJ9ZkAXCU2qHXRh
	085kx/VEwaZoUW+QFOA1zSDE+A6b+op8qCmekVPduKOOJJRq6HldQGhBkCfbGKkwCkcJlkH3ghX
	7f6huLrx9ekEJ0pqI2IfqoYLXLDfadgTXrZnzzqnMnGetNNdIgVVrMK9xweJ8m/qkYgijCpGs/I
	GFtrLif76r0BN9zHSU6NGCL0rIc2Z9qUtTk5jEeycR6XOGfhmEWw/DgzOGoCJVWnNJdYQqu94Pm
	UgPzWheckwNMsgr8sf9jojiAMKQZFAfE/AXJmdV3/llRkJSq/MJe1o+Nj4MS9qypfia2ThNi100
	3mAfLW0BNtX50HIJsJr0XI+U+o1228cDXsfQLKnZ+/2p4R8C1K8kDTAhr3GgpFevLmxXd9KxcbZ
	WTudgBUlCuO5r2BYRPSFDQ0EU+HtzWGbdC0i7+cHgh5gQ5pAIzzC1wkQwDzEFLm54xO87Sdjjad
	3U=
X-Received: by 2002:a05:6214:c82:b0:914:15ce:ed88 with SMTP id 6a1803df08f44-9142f664440mr38476586d6.3.1790337831716;
        Fri, 25 Sep 2026 05:03:51 -0700 (PDT)
Received: from localhost ([2600:4040:9399:4000:e553:72e5:7d37:c7ef])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91430dacc51sm15231996d6.11.2026.09.25.05.03.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2026 05:03:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 25 Sep 2026 08:03:49 -0400
Message-Id: <DLODSKPY6ON6.1G6SP3CFFLCPJ@gmail.com>
Cc: <netdev@vger.kernel.org>, "Alexei Starovoitov" <ast@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, "Kuniyuki Iwashima" <kuniyu@google.com>,
 "Paolo Abeni" <pabeni@redhat.com>, "Stanislav Fomichev" <sdf@fomichev.me>,
 <bpf@vger.kernel.org>, <kernel-team@cloudflare.com>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "John Fastabend" <john.fastabend@gmail.com>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Simon Horman"
 <horms@kernel.org>, "Jesper Dangaard Brouer" <hawk@kernel.org>, "Willem de
 Bruijn" <willemdebruijn.kernel@gmail.com>, "Florian Westphal"
 <fw@strlen.de>, "Jack Wang" <163wangjack@gmail.com>
Subject: Re: [PATCH net-next v2 03/14] bpf: Make BPF skb extension survive
 packet scrubbing
From: "Daniel Zahka" <daniel.zahka@gmail.com>
To: "Jakub Sitnicki" <jakub@cloudflare.com>, "Daniel Zahka"
 <daniel.zahka@gmail.com>
X-Mailer: aerc 0.21.0-threadmapfix
References: <20260910-bpf-meta-inside-skb-ext-v2-0-0b21e42180b0@cloudflare.com> <20260910-bpf-meta-inside-skb-ext-v2-3-0b21e42180b0@cloudflare.com> <DLMVTU0WA4OA.BWWVXT5BYT8V@gmail.com> <87fqyypp67.fsf@cloudflare.com>
In-Reply-To: <87fqyypp67.fsf@cloudflare.com>

On Thu Sep 24, 2026 at 12:52 PM EDT, Jakub Sitnicki wrote:
> Hi Daniel,
>
> On Wed, Sep 23, 2026 at 01:46 PM -04, Daniel Zahka wrote:
>> On Thu Sep 10, 2026 at 10:02 AM EDT, Jakub Sitnicki wrote:
>>> skb_scrub_packet() drops all skb extensions unconditionally via
>>> skb_ext_reset(). It runs on tunnel encap/decap (ip_tunnel_rcv, vxlan_rc=
v,
>>> etc.) and cross-netns forwarding (dev_forward_skb).
>>>
>>> This makes it impossible for a BPF program to pass metadata via bpf_skb=
_ext
>>> through a tunnel or across a netns boundary. The extension is always lo=
st
>>> at the scrub point.
>>>
>>> Introduce skb_ext_scrub(), a selective variant of skb_ext_reset(). It
>>> deletes every extension except SKB_EXT_BPF. Scrubbing is safe when the
>>> extension slab is shared with clones: deleting an extension only clears=
 the
>>> per-skb active_extensions bit, and the shared slab payload is released
>>> lazily by __skb_ext_put() once the last reference goes away.
>>>
>>> Replace the skb_ext_reset() call in skb_scrub_packet() with skb_ext_scr=
ub()
>>> and also switch udp_try_make_stateless() to skb_ext_scrub() as well, so=
 the
>>> BPF metadata survives queueing onto a UDP socket receive queue and stay=
s
>>> readable there (e.g. for a sockmap verdict program). Only mark the skb
>>> stateless when no extension survives the scrub. Otherwise skb_consume_u=
dp()
>>> would take the __consume_stateless_skb() fast path, which skips
>>> skb_release_head_state(), and leak the extension slab.
>>>
>>> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
>>> ---
>>
>> Hello Jakub,
>> What are your current plans for this series? This commit solves the same
>> problem I have with wanting to preserve the PSP skb extension across
>> netns forwarding.
>
> I've implemented Alexei's idea of skb-lifecycle tracepoints that run
> only when an skb is marked/traced. Currently putting final touches on it
> before sending it out for the first round of feedback. You can take
> sneak peek at it on GH [1] to see if it meets your needs.
>
> The CPU overhead is lower compared to the skb extension, at least in my
> local runs, and the kernel changes are simpler, so it seems like a win
> overall:
>
> |                  | gated skb tps    | bpf skb ext      |
> |------------------|------------------|------------------|
> | **busy**         | **+5.44 =C2=B1 3.16** | **+8.01 =C2=B1 4.75** |
> | sys              | +2.62 =C2=B1 2.06     | +3.67 =C2=B1 2.76     |
> | soft             | +2.89 =C2=B1 1.43     | +3.83 =C2=B1 2.10     |
> | ns/pkt @146k pps | **+=E2=89=88 373**       | **+=E2=89=88 549**       =
|
>
> I'll be giving an update on it at LPC [1], if you're attending, and of
> course will keep you posted here on the ML.
>
> -jkbs
>
> [1] https://github.com/jsitnicki/linux/commits/gated-skb-tracepoints-2026=
-09-24/
> [2] https://lpc.events/event/20/contributions/2549/

Very cool. Thanks for sharing. So it seems your new approach will not
use skb extensions, and this commit will go away :(

I still have a need for this behavior of persisting certain skb
extensions through scrubbing. I haven't considered all of my options
yet, but I suspect the approach in this commit will work basically as
is. If you are going to abandon this commit, would you be ok if I
included it in a series of my own for PSP? I would, of course, leave you
as the commit author, or give you whatever other form attribution you
prefer.
