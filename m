Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794480579;
	b=0KvwtHJvItvabubCBfZeOK9aRvZ6HEAf5xDLb42aFdBYp9h+0bxLrzOvL2egOLIsB2dV
	 myF5k+M0J145KhTj0JO/2mNt5u+1XeHnBYuqS6zGABaGrLzuwsJoju+VPjhU68AfDfuLc
	 IOTupIjXyHEO/Jh+rnEdpTo2ekr2QqG+e9zajIsJxpsnTpmiOhm3+S0hVfk3TTNDFae7J
	 6bLk9yfV8ECZrDpmK8n3muwmJUcqt0ylkK83/87PNxWFr0jyqjEAX39QWGcGkB8JZqnK5
	 EYHml0ss+5Zyp6O5pO/BXw7EvBYube/iVE6qJx4aAnipWF/lStbPs7yjVTTFVS3ppBQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794480579;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=FEtDWOCZqPhjvsvxprvXZxQh6BiXZmmXMKDopOlOztk=;
	b=hEM/QVNCVBZZtSP18G7H8BQFSrBxEdzYffUuiRln/Q5XBi0zqt4MVJywkfeY4z7KfESM
	 D4DguVqoT9tbhtcz0CpqFEB+a8uIIJx9ieqbY1u6U3DFRbu7q/77lU0T/Qqw79O66mdzT
	 yIxrh8pwkL6xrDwYB+XH4rJR6qU8pbIs2LAhSnVSRfy6LXH44J3h6mYC59tBS+qhelqlV
	 O2+cvqgievxaLKLAhu9V7ZhU9mFUQT1xmUNvi0hjfqWje/XOxCK2FHOeT/YJa6R5GyIpo
	 bVGX4nqED6LV1MPNgil+//JjFDMIAEf1hdpfz0jdYbrt5TcJIbjFkksjxy57IjrhbvQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=Tqj5nvAp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.170
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123D4606A323
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 10:49:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 123D4606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=Tqj5nvAp
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8b32bc605d9so1830666b3a.2
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 02:49:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794480578; cv=none;
        d=google.com; s=arc-20260327;
        b=g63seoPunjWYfRuYCE+KFYxe9E7HU6AoS4K9B74pjetZ5QO0F1OpdqUdEdPfye3xUn
         pVInjV9mAiAaPqd/68rOYRNkwlEqPOMIpaAHIWBw5UZ8ODA/KtcEJl0BJbbil0TAqJxS
         klGSz4wVTYIMaEuFhorQi6qPJKXwwnP5xJlXVse8UQjtei5uvUXSyH6etydbDjjGJj3f
         4c8aM57q7ntxfMwA3gbP6C7ebBgxE2wA5Qmy59Y5jsOg0Pif/qCoJtLyMesyKOocLyGw
         U86uyM5qScYocarTdCbTe5LuFYra4xiG+jOzhE0cQQOKuAjzeZzhcAtKA75pB7h7jIZI
         zMBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FEtDWOCZqPhjvsvxprvXZxQh6BiXZmmXMKDopOlOztk=;
        fh=iGykyabEy1dGb0yUcsMNklzt+4seZ3AundnDkmRvUu0=;
        b=QRuv1l9wcJFKXSY/EiNEqHYA7fRKlNkPTseU1rqZdrABdHTiR95bqdYAqmJyq0FliS
         Z0qyZYylTx0Ym+s7S3ViieOI4zjmOWX3i7j736duqWg2QlIz1R7OQrVjGK8fPhFy32yN
         E+WDHD+h3hk1/bxgTsZqXg36AyVeZdeY27zyYgdQVqi0YTKqSNFmrGkCk+VgNcVtrDXW
         VgEVwWREd4m6yda8ynEHWQoqwxSeV7KC/CN8OjKdthY0RxH1RRjUDLSgUeXgdorPQWMs
         yQplUUOjjqrF5A1PKquYYd33gAouuWn5yVKQ4P2JnW53NLu8Bg0zMz5hoOxBlhBMrwuj
         TmPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1794480578; x=1795085378; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FEtDWOCZqPhjvsvxprvXZxQh6BiXZmmXMKDopOlOztk=;
        b=Tqj5nvApRnLaXKJqnt1MtDcVgtOxG9b6FS3RhbrQh5OZklRpQEZx6UBwMAO9PmjJvf
         ArxcVMnUGE12W/1CQHNBzLA8ggTDyzZy+qk6SjvayMiejqah/j/hEhrJJDpdh8BtWUGI
         J9kO4ui3tsJ78QlVZXP12CxS4RXKWeUwe8wh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794480578; x=1795085378;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FEtDWOCZqPhjvsvxprvXZxQh6BiXZmmXMKDopOlOztk=;
        b=mKd4WiDB45NVF+E5IKYAZnmASOCklUKjQRCZiv87SazgXaqdKUE8PK1J/sMsy/SxpP
         k6/1w2a/bWwEBCxvVq3ixBKZrAgOU9rg+VEFMUgFV4U0T1SECu/0q8IduI6VlHOG780g
         Z/6fdDWs3bAM0C2kME6v2NyP6ZYb9CjbrNbGiSHfD7S0EUJlPpx7n9QW9Ts8EGdsugaG
         cecFc6e1qfIkRwpS0E1TqQBSLun2AhGNz1MVqBgXtxRXL3UEuMWUWiD9aVAaDIL3XL3U
         DNEgB4j8uRfR7cvpRn8fyRM/1X5fMv6IOXIOFwMslk9YGJuoE1NWQxPSrY74ku41nkVE
         thHg==
X-Gm-Message-State: APuU4Z8goXuAIf5AN51OQXNAV4Dl/B0WnmQz8mLPD2QQVPu0q8pZgz09
	FmL2II3SMZOdZ0IyEzQvLPpeicRGMSERK8qUNQA0+ZuckCLJ5FX9I6ipANLWmhqwtlU8+eVaz6j
	uZwBLWJ01zC6EaJGchDUKxiEhMLbYAt95H+jKrRPN
X-Gm-Gg: AYBFou08GmuDRHuSF9doxVpHDSywbujhZ4zmuGmCEHGDBHZv/PWnVXzdwFcQ9gwt3us
	lFfJOktQWspBzCnFjkJifKdrPolYkUF7vPWb+LVfCXDPJoXKRfYXXRskLuFVUql703QfWR5IecY
	AhrJFwPZxwpVdKHjTBJVW5utI9qJsIMGnGuqoNCnmpAM0S+0zxkMCThUuxF/kSV2oQxYRfuoCBO
	Rq0hYpLEbBIMBYyq9EcxJ7u3+lrjcddWywcNyd29lBOueqBTJ0kbr3ItZLsoF1xoKqD2Nx/LaJP
	yGXTMm2WVlMS8+hwjjc2VigQcQOa/mTkIk5dtQBWYvPfKv2BNNTzeQe9YxrZ6OC2VjtZQGc2wmW
	BXXzutfr45zg7U1jhwI28fhgacvJX9IW5HsbLkA9XfoPb8Y/Ega0nx0V4hv/yNQKp//HG8FW4+0
	IAYAFE5SfD3yYDm+PKoQhlyEF0slqD3uCW2aJf
X-Received: by 2002:a05:6a00:1c9d:b0:881:e266:c3c5 with SMTP id
 d2e1a72fcca58-8bc19dcf4d4mr4999096b3a.2.1794480578075; Thu, 12 Nov 2026
 02:49:38 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CORE-9NOG.v1.r0.20261111073528@mojatatu.com> <CORE-9NOG.v1.r0.20261111073528-1@mojatatu.com>
 <avTfQjFQYR2NNdRg@chamomile>
In-Reply-To: <avTfQjFQYR2NNdRg@chamomile>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 12 Nov 2026 05:49:26 -0500
X-Gm-Features: AclHuK9omPXMn0HkBh9zI32g8JDs_xDABa01ADFsm-x2ufsLQpfFXolnA1YvCdk
Message-ID: <CAM0EoMm3hK1P_-gTz9R3oo528t_rqfX4BWfJN9odCdm27iTtww@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] netfilter: nft_fwd_netdev: drop the stale
 dst when steering to a device
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netdev@vger.kernel.org, Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	Victor Nogueira <victor@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 4:33=E2=80=AFPM Pablo Neira Ayuso <pablo@netfilter.=
org> wrote:
>
> On Wed, Nov 11, 2026 at 09:16:37AM -0500, Jamal Hadi Salim wrote:
> > This is a followup of the review of the teql arp-queue fix as reported
> > by Sashiko.
> >
> > The issue: the neighbour variant of fwd rewrites skb->dev to the
> > configured output device and calls neigh_xmit(), but leaves the skb's
> > dst untouched. If that device's neighbour for the configured nexthop is
> > incomplete, the packet is parked on the neighbour's arp_queue while the
> > stale dst still describes the device the packet was routed through.
> > Draining the queue re-looks the neighbour up from that dst, so the fram=
e
> > is built with the routed device's link-layer header and then transmitte=
d
> > on the configured device. The packet leaves with another device's
> > addresses.
> >
> > The Fix: drop the dst before the device switch. Both lookup inputs the
> > neighbour transmission needs, the device and the nexthop, are supplied
> > by the rule, so the route dst is never consulted. Without it the queue
> > drain keeps the parking neighbour and the frame carries the configured
> > device's addresses.
> >
> > Conditions to recreate the bug: two network namespaces, A (10.10.0.1/24=
)
> > and B (10.1.0.1/24) in one, their veth peers in the other with only A's
> > peer addressed (10.10.0.2/24) so B's nexthop cannot be resolved by ARP.
> > Resolve A's neighbour for 10.10.0.2 as permanent, then load this rulese=
t
> > on A:
> >
> >     table netdev t {
> >             chain c {
> >                     type filter hook egress device va priority 0
> >                     policy accept
> >                     fwd ip to 10.1.0.2 device vb
> >             }
> >     }
> >
> > Send one packet to 10.10.0.2. It is parked on B's incomplete neighbour
> > for 10.1.0.2; once that neighbour becomes valid the frame leaves B
> > carrying A's source address and A's neighbour as the destination.
> >
> > Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
> > Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-6HS9.=
v3.r0.20261103062649-2@mojatatu.com
> > Link: https://lore.kernel.org/netdev/QDISC-6HS9.v3.r0.20261103062649-2@=
mojatatu.com/
> > Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > ---
> >  net/netfilter/nft_fwd_netdev.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/net/netfilter/nft_fwd_netdev.c b/net/netfilter/nft_fwd_net=
dev.c
> > index a48c2f765bba..ad4d61d64cdd 100644
> > --- a/net/netfilter/nft_fwd_netdev.c
> > +++ b/net/netfilter/nft_fwd_netdev.c
> > @@ -175,6 +175,7 @@ static void nft_fwd_neigh_eval(const struct nft_exp=
r *expr,
> >               }
> >       }
> >
>
> Does this need a check for skb_dst_valid()? I think it is valid to
> attach a template dst here for tunneling?
>

You are correct (I think you mean skb_valid_dst()). Same guard needed
with the second (ebpf) patch.

pw-bot: cr

cheers,
jamal
> > +     skb_dst_drop(skb);
> >       skb->dev =3D dev;
> >       skb_clear_tstamp(skb);
> >
> > --
> > 2.43.0
> >
