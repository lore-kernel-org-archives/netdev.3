Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794441795;
	b=BuMBfdsJAPT1iHQkzYtZSXgKz1mN6snB0sDTFqrrCesQbipvy33Li/z6B2neC7eqhsFt
	 jk3s4t9Boh6F8lmunwnWn16iCPlA/na+PevWYLVA47UnSHjxupdBXP1TwFOD3Rw/s4sn5
	 nAo20mG7T5QAjCEfFBTc/G7+ZXd8+Fn/hY6qIUzCa1PSnY5veRY2fPLqZmOcgLhInlx9L
	 sS1tmG5dIGX4U0YWTwMmbnVMBF4TeDJNVx+g+yIDyX6AjVY2J/b1tQaY2Dz9FfjZh4sVw
	 g+jrUCf6+GqJ2RA60yD8KP7JEgk8rZfeXijJwZGbcDKdOUu135THm+3SpvXX0TOThgw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794441795;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=tSGqJI9Sfy6jLqsvt9BVccCgWOo1O99X2AFDHy843oU=;
	b=Oz2O2P9R7IE1BjAh7dqQaBv9Z+KmizOlrcT4TqxML8lIZ1QM0mKS/kyNXLMUQvyQOKwj
	 2EuVi/sTOhmVSnjSVy9d1ypg+d3FzmXn7Orb6Cgu/g04NRtZDFHhujMML/EsM4iyOX/s8
	 CiRnF2r9ixnilHMZCzbNjpYwQKOPIsW/O7IupsX2HPaCnmdbhkX7zdOxdbAsMg+c/Atu5
	 rSropOrB1eCmmf12gyIQRirvOBrDg7BkV9DJjqB2W1m5rN2sXiqyX7qOgo3C3F1XJJuQU
	 SB1JmVFzr2MdDuZAMYZDSWyQ184QS0vYR0id2jp4w5NCCq++SP+NGmBJUemhFHamlLA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=cILHLZST;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.46
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54439606A31C
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 00:03:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54439606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=cILHLZST
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6d68de53053so2431881eaf.0
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 16:03:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794441794; cv=none;
        d=google.com; s=arc-20260327;
        b=n7osXNv/Kl53hPL0tyqGbNtKXGk0kBT4OJ97kx4wlzcqd/LWppAbRsI2Wsis68/jW1
         LGU7oyEJ/I3SXHWLSWFOxdPX1xuzTUtqhSzerikUA7Q6tkwHBZy67TrYQe1G0VEX2EzA
         zgI/ThrXOmCzuUukMOkhCbJgvslRynPSSs9oZUtCRDavQsJ1t06TdPiw7SDoCt+BXbui
         XiRDak7E76lkpplGlyMylAR8NVp1P5M1Of0yA3zwntZP8c6hOFPJ9h3Bhvmnd26MHGT4
         Zm7XYhO5zZnU0fmIQqF72HNrSH6ondOfQ2GrpWf5wCtFWwaNdAx0MWdLM/4/2nrrpHN/
         dOTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=tSGqJI9Sfy6jLqsvt9BVccCgWOo1O99X2AFDHy843oU=;
        fh=tkt5PdKGATPDOnsxY4azLJsnq1m9VpGjON3YARdn/oc=;
        b=qbxQvUEdU3f2xCkm5RPr4TcXjP3663T2uVcNWYtmH1K74gSQCZWt9PSairjQRZGnRc
         lO/uBU5r+9IqhbDVz1Q5U8CYr/sSf9Q6KHPDe0AzfkC/2unz80hqWbP4oJ7h+HdYVRoL
         dHHTk8v92qBiJcYBOWWgdKoRxnBi46dFxm37aYm9lxE1UFcsDOyrbh6oJUuFsSr4btqQ
         DT/SVCSOY5HGo+DZa4a0HYdKJcBQhji3kcO/1IONlbaNlPvs5K3A/vWzwQZv2pjgGPTd
         z7/onG3leHRQ99oUJ0xdKnIkVLV/yD+Ks2yi/KvyzfeepEq2pUIeLqErSybrrPKb3+aF
         1ScA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1794441794; x=1795046594; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tSGqJI9Sfy6jLqsvt9BVccCgWOo1O99X2AFDHy843oU=;
        b=cILHLZSTnKQEkbe7N+Oc0kZd1YMJ90v+inoo8hnd/du4Q8+TI7ThmqwGF7mc5pC4Zc
         p3RST8uK9+o/pASznYLtV0Z7weQjU6OIrJgytinvIk4otwF+rNEOKoimbWWnNMqH5buJ
         xCLw9HMNTcZlZTRHoJrN6pcicTv9FCZZeYbCVTLEV3d1vbtkvmzglrLY0Rw0y2iTXn+U
         z7pDnxzc2gWXMtz92BavIWrAnQ1cEvS0+M9IK0CPUjNYAYrv8VaJisHOkU80CgP/RKfw
         MyqjjMvpkeYtcCpkYSm24Gf8unvyyVbX7NIxTeOG3ssNop+SIoW1Unp6JfOBJr+qi4OR
         Btjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794441794; x=1795046594;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tSGqJI9Sfy6jLqsvt9BVccCgWOo1O99X2AFDHy843oU=;
        b=0vBMLGSucreahSMcwIt5+vLsBKmSouTJmPrSH29i5v7NdDFWWxZgEzcNLZ07Ah0Gpq
         fvdtop+n8rFxTG500VGhob9j811XadqmeGTV2U6nU6jCGniXGEGUBfIbAcy507kwFDbk
         Uf2cu4RD2pLB+itNxgntnxxWw1v+couSxJwopFWmPKtbHd7QVFpVO93uzZGWOsMm+FPE
         VhmbiGy43AVH/6zWOsSpQX91yYFf6crRRtgg3fh3wIbUXLBlU/s3l5I13m4Dm9XVLPXj
         OZmfU1GJndzE+Fv+2fgJGqIIeaj4s2Od6fWMQVzr7Tp5gSPz1oCZxlOgz8uJl52BOuWd
         Z2rw==
X-Forwarded-Encrypted: i=1; AL+hErHcxGM43ImiPZU5EaJ73P4gA5MKK1al/zp/1i9J1QZNs/xa/wjRE+AJH0Xy5a5fab5kEjuxCf8=@vger.kernel.org
X-Gm-Message-State: APuU4Z95jhRMfRLgekMc/U9jcH//Itn1+8cnna2E1OZqE+EZEuqdWRPs
	WnTdkYitb8L4sw2DL6qbNKXt4Ocq8Rokt3b2aSdTsHn3Kb+o4wsqm5WKHxc+OkkL0+D1A3LEaAi
	NmT/bk40GR1KzZ6n5Q+fAuE3XhwV3LE/gPBkQ28AJzg==
X-Gm-Gg: AYBFou1Gejr2+qaROGXJZjz3xyxyIvFAPTyjXAQWNWM80o1EAFbS090IfZ3lDOMOz7A
	RAzS05rnHHZCW1p05DfA2kCHpCUNCuCA2SpTT2rAgjUS+8qfPkxO4mve4pn8bsEbOLBM4zcIAG2
	wMcFiZMYQcb1LmLPTyQDiQnbscIpOqxzRF9lOBtAYeZv0+NG37G1kGydM4ISDe5lwXx4O3dd4Xi
	5gybzozms96GZ8/KgJBM3IW/9vjy9Ry2/xxFXECJnFplgbjPVsPG/ah/22D39w06VGT/NNaDYPW
	QuONPKNrYfxwH1uq365C/KhAdUtF506DL8OVB2i7vgatulmKBnIvE7cfveFeGBX009OLOt4cSNM
	g6UsPb34VqDRlz4TVLCxELfT1xdqCSGTERMZ7EJakw2I8gAM33ppWBLETUVunrA9asRU/wJLhQ+
	S2H4V8VROpqA==
X-Received: by 2002:a05:6820:1341:b0:70d:8086:e48e with SMTP id
 006d021491bc7-7191784f4c9mr2405201eaf.20.1794441794070; Wed, 11 Nov 2026
 16:03:14 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1794020868.git.tianyi@cloudflare.com> <e90e748e0aefa7cbe1c2b31b8c7902ccf135c3f2.1794020868.git.tianyi@cloudflare.com>
 <willemdebruijn.kernel.1d64e7848503b@gmail.com> <20261107182526.69543-1-tianyi@cloudflare.com>
 <willemdebruijn.kernel.2c6a653eb65fa@gmail.com> <20261108190831.3f991a13@phoenix.local>
 <20261109154909.32748-1-tianyi@cloudflare.com> <avTOvr+yy+2j8xrQ@dev-dsk-dkeogh-ai2-36d3b9a7.us-west-2.amazon.com>
 <avTSBFpR2t7PO9tx@dev-dsk-dkeogh-ai2-36d3b9a7.us-west-2.amazon.com>
 <CAG4wq-d+LtEi-omGwzgqx14rCp_4J9HztGMpa8ioMsviaPw+ZQ@mail.gmail.com> <avT4CezZCiRhvCXw@dev-dsk-dkeogh-ai2-36d3b9a7.us-west-2.amazon.com>
In-Reply-To: <avT4CezZCiRhvCXw@dev-dsk-dkeogh-ai2-36d3b9a7.us-west-2.amazon.com>
From: Tianyi Gao <tianyi@cloudflare.com>
Date: Thu, 12 Nov 2026 00:03:02 +0000
X-Gm-Features: AclHuK_s8wIPjsY9dzqaekzO2VZaPxMJTb6Tg8Z4dNlh8vuXp1Ar6fObcRSwolA
Message-ID: <CAG4wq-cyLyxnnmhPvL+ZNmnXGjBp=OsbBNE=16j6WRSVJ8uv3w@mail.gmail.com>
Subject: Re: [PATCH net-next 1/8] net: add tx_extra_headroom and LL_ALLOC_SPACE()
To: David Keogh <dkeogh@amazon.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Simon Horman <horms@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	David Woodhouse <dwmw2@infradead.org>, Dragos Tatulea <dtatulea@nvidia.com>, 
	Nimrod Oren <noren@nvidia.com>, Alasdair McWilliam <alasdair@mcwilliam.dev>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, Alexei Starovoitov <ast@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Donald Hunter <donald.hunter@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Breno Leitao <leitao@debian.org>, 
	=?UTF-8?B?QXNiasO4cm4gU2xvdGggVMO4bm5lc2Vu?= <ast@fiberby.net>, 
	Danielle Ratson <danieller@nvidia.com>, Kuniyuki Iwashima <kuniyu@google.com>, bpf@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@cloudflare.com, nh-open-source@amazon.com
Content-Type: text/plain; charset="UTF-8"

On Wed, Nov 11, 2026 at 11:19:37PM +0000, David Keogh wrote:
> On Wed, Nov 11, 2026 at 09:41:32PM +0000, Tianyi Gao wrote:
>> By the way, I plan to support tcx only in this series. A tcx program
>> is attached to one device, so the kernel knows which device to update
>> on attach. A cls_bpf filter can sit in a tc block that is shared by
>> several devices, which is harder to handle.
>
> tcx only is fine with us. Our chain is attached with cls_bpf today.
> Rather than move it, the simplest option for us is a separate tcx
> program on each device that carries only the tag and returns
> TCX_NEXT, so the existing tc chain still runs after it. A few
> questions so we can check that this works with v2:

Yes, this works.

> 1. Is the tag read for programs attached with BPF_PROG_ATTACH as well
>    as with BPF_LINK_CREATE? "bpftool net attach tcx_egress" uses
>    BPF_PROG_ATTACH, so a startup script could do the whole setup
>    without keeping a link pinned.

Yes.

> 2. When several programs are attached at the same tcx hook, is the
>    value the largest tag among them, and is it recomputed when one of
>    them is detached or replaced?

It is the sum of the tags, because each tcx program can push headers.

Yes, it is recomputed.

> 3. What is the exact form of the tag: which BTF element it must be
>    attached to, and the string format? It would help to have that
>    documented, since programs will depend on it.

This is the form I plan to use, and I will document it in v2:

SEC("tcx/egress")
__attribute__((btf_decl_tag("tx_extra_headroom:64")))
int headroom(struct __sk_buff *skb)
{
return TCX_NEXT;
}

The tag is a BTF decl tag on the main function of the program, and the
value is a decimal number of bytes. The kernel ignores tags on tail
call targets.

> 4. Is there an upper bound on the value, and is a larger value
>    rejected at attach time with an error, or clamped?

The upper bound is still NETDEV_TX_EXTRA_HEADROOM_MAX (512 bytes).

- A tag above 512 is rejected with -EINVAL in tcx_prog_attach(),
  tcx_link_attach() and tcx_link_update() in kernel/bpf/tcx.c.
- Several tags, XDP on the veth peer and VETH_INFO_TX_EXTRA_HEADROOM
  can add up to more than 512. The total is then clamped to 512 in
  netdev_update_tx_extra_headroom() in net/core/dev.c.

Thanks,
Tianyi
