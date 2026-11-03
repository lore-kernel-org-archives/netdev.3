Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793711132;
	b=ea1o/wqCN/69TKiC8PUyDb+alsXeJAamEdhwxS8R82rmZLoele3lerovUwuK7Ay4KXPe
	 O+Xc5fbynvcYLKZIO5stdNO2xapZeHUqYQS7J7ucdCtsiUGU+XOnCPwyz2YHuzMaTPMbw
	 mbja340JQPnzYjNkLh3qFYURA4lEXANxI6FgetDSMeIpAxSya16ewhsyt6+LmA0aI+VE5
	 TYcQSK/PzWk0OVmageEwO5m5n7ZjhTj8xGvp4eRu8avx5cULeEnxnMvCeWye5ictd8qBu
	 /3UKnc586fZvK291cewrJWUQoMjljkw5Do/QBrIQ0LJ/lvlUJw3jZTZA3NyYuIhWNgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793711132;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=5G2U21klRa6bS/WuYbdKcyXo8Ne1lDiDAh1zG2l5QTA=;
	b=XWtA8g1Kse+crnEpIJAbPL66rqAsYUvsENzp77IY4TT4NC2lFwIoYBI4Mr4VIiXCV86n
	 KwqOm4emviyWXrhCMTsFTJKH8VEjSRm2bX6495D12mbf0UBshi5MeJS5T9+q943assVpm
	 3PQy8TqHf7gulLN0JOz8lPNviWnriySvJxzLKhUYLM2G/sTeTfZdpMfVjfnFEpKzlbEXD
	 KSnqnZLWUUmh2Y5BjUAuZ7YkTzEiDgVORWLVa9B0Mr3LrG5fMBxPLu/DeRAGKsid4+XYZ
	 QHZrpQevOMuVqgHW9v1qSPpUHAxZBzc9+jJ8Yazo1WFcYPPcLD70dpc5UJb2tN12mYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="GanND/y/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2426D606A326
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 13:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GanND/y/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0D7A1F0093A
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 13:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793711131;
	bh=5G2U21klRa6bS/WuYbdKcyXo8Ne1lDiDAh1zG2l5QTA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=GanND/y/SbfPpRIHv1sS6NJJzV466INwqASwl/mdcOP245Xg2gmebhiHmG6Ukxdgq
	 FauuMbZU+MEjNLs8Jr1UGx59VL/GorW9bHVNv9cX+WSzsxsRmE699k+6/5L5+wVwsb
	 SrSyFEZk3n8A7/WP09z4rQtHqtzgQWiNJb0FNbGWUU6yzaaOFLu5RV+0nXP0XuSjdm
	 Edk+ZRYel3jWcmIO6BRaxT85U/88h0C56T3pPp63d2EeyO5sMxtTiFYxKJCHzwtTr1
	 G49PSh031fDeT5R4M7v3lQvIWXAcxch/cgmwptMQOxst8KA2BxOWXr3Rxx/L3UjWI1
	 WCaKpGuZTWujQ==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-4a77dcc4ca0so2268497fac.2
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 05:05:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBzP9icWm6BVAnn/qab5BWoN0NbqW7lVFP5KYDPukAYnDWBOabSJva+DQJMe5Yy+HVxeVcN18+8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8j0nmv7dZe5rAgTpbwnDwPR8mn/bIO5nv2ksMiQ42cyhZfMrp+
	QxGlo629uulJOuNjuhPNrj0wYCHc+AryVhIAWde0hQtU4BYfwt5k/pcw8IbKUHgoSE1c5wvf87S
	wQEDc0tnKlKfDbPPIRV8+lhiik6qj9gA=
X-Received: by 2002:a05:6870:b3ee:b0:49d:ff8c:205e with SMTP id
 586e51a60fabf-4a9076f98femr7400533fac.29.1793711131109; Tue, 03 Nov 2026
 05:05:31 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1792838740.git.julius@bairaktaris.de> <b27640960edcb8e072fdd2e8d282c1deee747b8a.1792838740.git.julius@bairaktaris.de>
 <20261103124346.GJ865646@horms.kernel.org>
In-Reply-To: <20261103124346.GJ865646@horms.kernel.org>
From: Eric Dumazet <edumazet@kernel.org>
Date: Tue, 3 Nov 2026 14:05:19 +0100
X-Gmail-Original-Message-ID: <CAL4Wiiq46pgkuy3KRQsa4MWsa_XXOozggwc99ymr_2VPfry0RQ@mail.gmail.com>
X-Gm-Features: AclHuK_3GVdIdupsfLo9PLF7Zsk-VOT8s8u3_nPLqcTZx17uLr-LX-xxpRUnjLk
Message-ID: <CAL4Wiiq46pgkuy3KRQsa4MWsa_XXOozggwc99ymr_2VPfry0RQ@mail.gmail.com>
Subject: Re: [PATCH net v4 1/4] net: make room for the tunnel header in skb_segment_list()
To: Simon Horman <horms@kernel.org>
Cc: Julius Bairaktaris <julius@bairaktaris.de>, netdev@vger.kernel.org, dsahern@kernel.org, 
	idosch@nvidia.com, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	steffen.klassert@secunet.com, willemb@google.com, jiayuan.chen@linux.dev, 
	mfleming@cloudflare.com, almasrymina@google.com, bigeasy@linutronix.de, 
	richardbgobert@gmail.com, ecree.xilinx@gmail.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mar. 3 nov. 2026 =C3=A0 13:43, Simon Horman <horms@kernel.org> a =C3=A9c=
rit :
>
> On Sun, Nov 01, 2026 at 05:42:29PM +0100, Julius Bairaktaris wrote:
> > skb_segment_list() pushes each frag_list member back to the outer MAC
> > header and copies the tunnel headers in front of it, but never checks
> > that the member has the headroom. A fraglist GRO packet forwarded into
> > a tunnel and segmented in software then hits skb_under_panic() on IPIP,
> > and on VXLAN the copy writes before the member's head (KASAN:
> > slab-out-of-bounds write in skb_segment_list()).
> >
> > Call skb_cow_head() on each member before pushing it.
> >
> > Fixes: 3a1296a38d0c ("net: Support GRO/GSO fraglist chaining.")
> > Signed-off-by: Julius Bairaktaris <julius@bairaktaris.de>
>
> Reviewed-by: Simon Horman <horms@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@kernel.org>

Thanks!
