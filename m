Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC7748164A
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 10:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792233483; cv=pass; b=r/jEtfgcu1Yh11HhTd5DXe0AnmlRR9mP7lCsgd4vyq2WycWLye0qBUKLbI7fi/B/fD/si1CvNPlH7RDGOyc1FmyPpnwrrv9dElPjdSaN6XGaM7LnuybST+c/as9dD5p99lybHSfyp2tYaaZ+6MQwZnQt6lPLRycPaWe0PVjmigQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792233483; c=relaxed/simple;
	bh=lpQm89oJ+ypIsAu728Xi2E+HeQLkTJDqgEphRq69EuQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yh2NOc1NmWOWluxxIgcn21WQDkJHCPok0iGbC41qu+41WFnEOarYPl1PO8QR2OUpLU7XscnELn2Tzp4xeXLdBku4IeEjX7bv6BcEC/2WYox6ryK1hXJNcfhNc+dhbHAajcojKGwlgOAk/DW9Og8Dih++ZY5tD6vVZVtyH2wx9v8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de; spf=pass smtp.mailfrom=bairaktaris.de; dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b=uSrfBAHd; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b="uSrfBAHd"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-677af43eed4so712389d50.0
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 03:37:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792233478; cv=none;
        d=google.com; s=arc-20260327;
        b=UChUi/iPYC+ct3UEdSSeBQJauDGBstzONn72f3q5g+z6isn57juky/Ap0Dh8g0dIZH
         1kB2xZTaI2+c5faETJYY7blM3IGCeWvaAdtKADGXEMyMLy4bQSXJ7vtkZ0iJXZwrsiRv
         v9JmXwV+ROUcd8T14/cFpA4xuPqt6ZvEehSY1EbusPIDCZFr3nb3JyHEAzwJ4lQ9C7Sl
         947OQkQAq4KtWX/rV7L4G01v+d96o1Tt6QKdBLnPF2jmJlqmuQ57uZKaC6lefIbpyWx3
         a/x62utK2P1d2FIeA4zAaKVcIof3mMDAee5UC7U/FUBd2msw/Y6d/I9ia9dCyEYtmDyk
         rIuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=MRmDjnl0l5zRiljfJEoqVKQPlK3YrtzEIxHy6EIjrqI=;
        fh=f63B4qZ28w/TVzr9Ti5Ypf0TwAOTps4djB1Shj/8bhE=;
        b=PwKFOYWQZyHGGP6qnn2MuWNBpqdFganiQiUg/TCdw+J99lzzKdvhMGpE2iE+/19MRJ
         UtyTT5rnrWHMU/pKX36lWFqb2aPveRdDSMK706FVbMjb4bbWT89UZxQiggEiwdVc88Cw
         94Sa3T5DzJjQTBVmUU0afbwpc4rpkF28qcwWy0zOf9MAhGz8O1VLZkxT8x+GFLhRMcya
         K1kL8JfP5+VpWGlq74V/o4Eqw/vChfqiXZn9WvFvm91UumcQYGIhVHHEer033Vacr+O3
         Ex4JkTctfU6Fi8HGJ/ntbcNqEgRI3lFv/a6zkMK4GqKLE3mORY4LfxPvvW9m1WApNQp4
         clWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1792233478; x=1792838278; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MRmDjnl0l5zRiljfJEoqVKQPlK3YrtzEIxHy6EIjrqI=;
        b=uSrfBAHdi1kw9pdt1rRTCQCehVBqjUEphMkLAn0rsLnrx+5ggEOimnaLY1KxVWaqt7
         MFA9g3PukgfK3de9suYNHp+wRQhMIdnXuVX8piqOwIdbYoqI2aqQis6r2p672DZUm2gs
         3XwloHvq4YrTg3wNq36EM1Ac+3ovf92RV0JIPE+C+vAtZdA5Q7Xe8XUdEhLA5Q5N1QfF
         shmTiDwC8XYNrOrNQi/qLkSkYM0BcY8Fciu14sFA2gEaD8tz18+6oM3O9/eBUwfYd0Gf
         6B30H42afOEQhvlU/HpurAov8omsrFT8lMItKRtDOtI48x/FfVgxst8Y5MwIW4GG26eG
         jUuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792233478; x=1792838278;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MRmDjnl0l5zRiljfJEoqVKQPlK3YrtzEIxHy6EIjrqI=;
        b=mF/CrvFl+Nvo5jziMYkKzTmVeGbyarvnGuk7CoLmFYXZ67qvuMpGM8bcJEpab7lwAt
         RDzw1nDv+wWBKm7Q2pAODBcbxpbWGCRlFKDq4pcwyA/2PAFThLyo2NoE1B/IuwMEv0RS
         Dt5wz6w4wqpKfTaK5JjAL8LiVtnrcR+/tkHSoWyp7O6J3lWcdmT0X1C+Cf49o/x1l85A
         fmPOoDAP9hLP+gBkmnZ7W0xXn2OaLIx8AUNUGa3VJf3vf8sumbzT7mP8g/1FvfFzf3OO
         Kh1+Uc71Y8PzDldCJCeRvuyViTIIw+h0SMFnfi1kixkNzO4iab3KJGcyAGrU0i2XCin/
         lxHQ==
X-Forwarded-Encrypted: i=1; AKwUvBy8/dhp8bsTHuQSbxHyexskQs4SJMpZXpLYVN7kOQeYYzKUR6BU2K/ZVKEQfPRDKUGoxukTVwo=@vger.kernel.org
X-Gm-Message-State: AFq9FYIDhq1+wKdcoEKHu1cTHxyiwhFnm1mCfyjH7XBKGLe3RObLkk2N
	Bw5vW+NI6agZ5Eq0H+tBRG7NPU+9N2Dw34zcBGb3AAZMO7amoSR6tTc4AXKXXEL8y+xFwMMiLNo
	w+JI5du1PuLDBeADzUyn0bZn9Al/I0VvE/wEstlVan2Be3e8vPbbJh2Fp
X-Gm-Gg: AYBFou1mzLsQJC5hYmq8cO001ISbtTQFBmhQbOINCC42sTO6AA6mSSn0L+yxyA5F7rh
	1zz9cWB5c29J9LjRZ4wcDlGQw51Wh/hFShK90uzKvyDzmJXWYh5PE1YY8qorBQwBX4O6L9vwWse
	zn/VyB6uBc9fNHnD2ey2QIt9AXMpaRn11Veg/q9Aio/ef5FN9mY6KJdKZHzh3tdeTbVK0Up+bjQ
	m97RIGhFqO1HbbI4qsnuUHQ0zobkfSkLorcp81S1Kkx+Qu4lhp9s0VIIZSUX/JiUy/tV05RwFn2
	Fx03tHP2emgQEXGZF83c6pt/SEihalnPnqycwuC/g9iA8/0vD++/z632+iENYceJzsh7clHQRYn
	9UfUVSpGnM0ZGq4tc/KN4nIf+bOR66Q4iJ4ise8ewQRYwSZEaGbctj4bDSaLyOzwWlP8FnfiNyk
	D7XEdANUa8NdcD5GHxDSoWSBtj/xk6JoAJRJBpqtfOlwTsCyO6zLYCA9R5lFyzMoUa3cX6fSiyu
	19iOAJzCOY4QD297D2XODff6EvBhVveMcfgnoEtYjbV4sgMtSCElzj8WK6VIeNOY5Bi8Gzz7G0l
	irLvSd0yGngi0A==
X-Received: by 2002:a05:690e:4812:b0:677:ac49:ebc4 with SMTP id
 956f58d0204a3-679ca883777mr533948d50.67.1792233478237; Sat, 17 Oct 2026
 03:37:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261004171628.3544978-1-julius@bairaktaris.de>
In-Reply-To: <20261004171628.3544978-1-julius@bairaktaris.de>
From: Julius Bairaktaris <julius@bairaktaris.de>
Date: Sat, 17 Oct 2026 10:37:21 +0000
X-Gm-Features: AclHuK82J-XBozK4zoTEoCCy3jbA2RmbzrDB-Adm8RVieBFQXiCNHqYkufTba4U
Message-ID: <CAC1t37JvSaXzbp_spXteQojKL6EvRLLUrwvwSO5e9pcJ4cpaPQ@mail.gmail.com>
Subject: Re: [PATCH nf-next v2 0/4] netfilter: offload a TCP flow whose reply
 is never seen
To: pablo@netfilter.org, netfilter-devel@vger.kernel.org
Cc: kadlec@netfilter.org, fw@strlen.de, coreteam@netfilter.org, 
	netdev@vger.kernel.org, geldot@protonmail.com, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Pablo,

gentle ping on v2. Let me know if you'd like anything changed.

Thanks,
Julius


Am So., 4. Okt. 2026 um 17:16 Uhr schrieb Julius Bairaktaris
<julius@bairaktaris.de>:
>
> A router that sees only one direction of a TCP connection, because the
> reply takes another path, cannot offload it: conntrack marks the
> client's ACK after the SYN invalid, and the flowtable only takes assured
> TCP connections. The setup this comes from is two subnets on one L2
> segment, with the server answering over the shared segment.
>
> The series adds no TCP state:
> - patch 1 hands that ACK to the existing loose pickup in tcp_new(),
>   gated by nf_conntrack_tcp_loose, as if the SYN had not been seen
> - patch 2 keeps the reply direction of such a flow on the classic path
>   until the connection is assured, as act_ct does for UDP
> - patch 3 offloads the connection in the original direction and caps
>   the timeout handed back to conntrack at UNACK, as
>   nf_conntrack_tcp_packet() does
> - patch 4 adds a selftest, which fails without patches 1 to 3
>
> Pablo, on v1 you asked how TCP tracking copes without the reply
> direction, and guessed right that the goal is flowtable offload. The
> connection is tracked like a loose mid-stream pickup today: window
> checks are off in both directions, and a FIN or RST still takes the
> flow off the flowtable.
>
> This series was written with the help of an AI coding assistant. I have
> reviewed and tested it.
>
> Changes in v2:
> - patch 2: the XDP flowtable lookup does not return the held reply tuple
> - patch 3: cap the conntrack timeout at UNACK while no reply was seen
> - rebased onto nf-next
>
> v1: https://lore.kernel.org/netfilter-devel/20260910090052.2034970-1-julius@bairaktaris.de/
>
> Gary Dotzler (2):
>   netfilter: conntrack: pick up a TCP flow whose SYN was never answered
>   netfilter: nft_flow_offload: offload a TCP flow that has no reply
>
> Julius Bairaktaris (2):
>   netfilter: flowtable: promote a flow offloaded in one direction only
>   selftests: netfilter: cover a TCP flow whose reply is never seen
>
>  include/net/netfilter/nf_conntrack_l4proto.h  |  9 +++
>  net/netfilter/nf_conntrack_proto_tcp.c        | 16 ++++
>  net/netfilter/nf_flow_table_bpf.c             |  4 +
>  net/netfilter/nf_flow_table_core.c            |  5 ++
>  net/netfilter/nf_flow_table_ip.c              | 26 +++++++
>  net/netfilter/nft_flow_offload.c              |  6 +-
>  .../selftests/net/netfilter/nft_flowtable.sh  | 75 +++++++++++++++++++
>  7 files changed, 139 insertions(+), 2 deletions(-)
>
>
> base-commit: 87b80c2f6b05cad9f0ff9136709c62a0f59923e3
> --
> 2.53.0
>
