Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792916307;
	b=06tREgWeW7zqN1lrGeSshstbq4JFFxG3aDKPgRCM6F3dUdkzss5/IXGYvWiTQr/ZKPII
	 ji44upBUtBwl8ugoy+/ear2X7TJDcd6XM/wxiT2moQERdBQXrPbzk95d612Lw5xam6WTS
	 eGfDoj7GyAJ/GEYDa5dkYHlMyeaUXEFfu4eXvhHrvRm3eSZFPYCLlyOK7b/flAadeL5On
	 Pd5UlptmkFWyTkpDiuABnYq00RvRBeOhzeExvI/h9FSZVjiwN6hrOwNgXF6zhTUFeq1Ve
	 dkLChYlSQE+O0SXKm1a7tN3OzOFQqxhOH3m0jCGoGWwA2C68fG/vwbNGv90ekbkVRdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792916307;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=AsNHdaP0DaFxZmA1z43ju3qP0T8QtZgJyo6DJslfBS0=;
	b=D0FwYNONyqGs9jqAretWo47zzmumS1S5KZ3Q/ODKHOo1SjqRLW6mZp1jGDlHYkvUZuMh
	 7a29XezW3oJA7RLa6My+wqBo2HI3jPW7X/Uux9mx7n1u5ct8L+3a6G1JAlW/+XgTIC2Kr
	 xZ6A4925OrJZp25i0SEymsFm8dDngzzKN8ka5ElWVkSD1lnx8l0+kXGt0uJcqmTq6aaaN
	 vAINy+pmvMV6hpACYG0io3/zfurHLJkyy0hOx2SkF7OGr35ePeq5ZUmEQB+O6SkMMmUeN
	 wR4djpKSc7RHEvQUwJTd/u8k+/svl2A5hBPQdO5LFGbi1SNCQiocG1Gj0FtwnQi25pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="iDpVIF/u";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F75606A31B
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 08:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iDpVIF/u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9D8E1F01828
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 08:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792916305;
	bh=AsNHdaP0DaFxZmA1z43ju3qP0T8QtZgJyo6DJslfBS0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=iDpVIF/uED/tlWSmFDuxYuTsYyyrxCFcKdCZ6yyTtTxppFfSQIW4ReAgMvbdX15Xv
	 C1ttBxQjy3LadLmngcNn1y1fulirinzAImSxwT92/R/mf1yXo6ioVwd2KtL8xEeMfA
	 T+6tavEiO1DxB4HXZUBG/bwgWPY2SDFh6DvuIrBbbWcgZzDnkkyXq5ptIsbMrLQcrs
	 gUBtoPqIZV/lCiXOPfQjrUhnA6t6zUIh3GfQaRvopr87xPw8cy7mWasRkKgO+Hz3cB
	 n2OPRvSgNOzIL9hOFd1lxkBjXT06OKkFuIedYTxQmjpIg75bDF3u70Sqng29+xRALK
	 n6YbHi45QKM7w==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-4a6f2825dd6so489712fac.2
        for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 01:18:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxLCu1BeJZ7BepB+MFtgiZwOe6gyeGFGeARlSFTILhoRWIyDZ7gzSJckkWD9JbNcAtgB4n40wg=@vger.kernel.org
X-Gm-Message-State: AFq9FYLKLYSdvKC+F72RhsyL+VKR+RvzgtYEPNH7g6+8dpwFVrel2qn8
	Uo+qiMpi4URuMMVO8BSfc59B8Wv1z1JjNBSM0XO58Cd9e+5HTJIW20hwHowowgTL4tyFpT1MLLJ
	IIqoZPywqfRaCIuyUSL4wE0PQFJy/tI0=
X-Received: by 2002:a05:6870:a70c:b0:49e:59ea:71f3 with SMTP id
 586e51a60fabf-4a83f5199aamr2400955fac.40.1792916305053; Sun, 25 Oct 2026
 01:18:25 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <0bdcbe2ab5ffc86ba7190fe25476bcebcb967310.1792844270.git.mst@redhat.com>
In-Reply-To: <0bdcbe2ab5ffc86ba7190fe25476bcebcb967310.1792844270.git.mst@redhat.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Sun, 25 Oct 2026 09:18:14 +0100
X-Gmail-Original-Message-ID: <CAL4WiipHjseFcNaqaufAf5C7d3J5e6aLZBTsehJuJyR2m7G1Hg@mail.gmail.com>
X-Gm-Features: AclHuK8D0EtYNyshwYTKsg-IsiHwgRYjfcghygIB__I_5tlQJCxm8A4sK_Kydf8
Message-ID: <CAL4WiipHjseFcNaqaufAf5C7d3J5e6aLZBTsehJuJyR2m7G1Hg@mail.gmail.com>
Subject: Re: [PATCH net] skbuff: keep accesses through unset transport header
 in bounds
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Claude Code <noreply@anthropic.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le sam. 24 oct. 2026 =C3=A0 14:56, Michael S. Tsirkin <mst@redhat.com> a =
=C3=A9crit :
>
> Commit 2170a1f09148 ("net: no longer reset transport_header in
> __netif_receive_skb_core()") stopped the receive path from pretending
> that an unset transport header starts at the network header - but only
> on CONFIG_DEBUG_NET=3Dy builds, the idea being that fuzzers and CI could
> catch stacks reading a transport header where none was ever established.
> And the plan is to drop this for release as well.
>
> Indeed, under KASAN, an access through the unset offset produces a
> slab-out-of-bounds splat, which is how these bugs are usually found.
> But a regular debug build has no such safety net: the accesses land at
> skb->head + 0xffff, some 64K past the packet data.
>
> I don't think release builds are exposed to oob in this way, but I want
> to make the stack a bit more robust if yes.


This is not a net candidate: there is no bug in release builds, since
__netif_receive_skb_core() still resets the transport header when
CONFIG_DEBUG_NET is not set. The Fixes: tag points to a commit doing
exactly what it was meant to do.

>  While I appreciate a nice
> KASAN splat as much as the next developer, making even a debug kernel do
> oob accesses was never the point of the exercise.
>
> Make skb_transport_header(), and its inner variant, verify and WARN,
> then fall back to the network header position when the transport header
> was not set. This way, accesses stay within the packet.

This adds a test and a conditional branch in a very hot helper
(tcp_hdr(), udp_hdr(), skb_transport_offset()...), inlined in hundreds
of places, for all builds, to protect CONFIG_DEBUG_NET=3Dy builds only.

Falling back to the network header is also what 2170a1f09148 wanted
to stop doing: pretending transport and network headers are the same
is wrong, and silently hides the bug after the first WARN_ON_ONCE().
KASAN would no longer report anything.

>
> An extra benefit is that release and debug kernels now behave
> identically if an unset transport header is ever reached,
> avoids heisenbugs.
>

Not really, the fallback path is only reachable on CONFIG_DEBUG_NET=3Dy
builds.

If you have an actual report (syzbot, KASAN, or a stack trace from a
debug build), please share it, and we will fix the caller that uses
an unset transport header. That is the whole point of the debug check.

pw-bot: rejected

> Fixes: 2170a1f09148 ("net: no longer reset transport_header in __netif_re=
ceive_skb_core()")
> Cc: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Co-Authored-By: Claude Code <noreply@anthropic.com>
> ---
>  include/linux/skbuff.h | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index a3ff380d43f0..cbfeb17d86f7 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -2993,6 +2993,12 @@ static inline void skb_reset_mac_len(struct sk_buf=
f *skb)
>  static inline unsigned char *skb_inner_transport_header(const struct sk_=
buff
>                                                         *skb)
>  {
> +       if (unlikely(skb->inner_transport_header =3D=3D
> +                    (typeof(skb->inner_transport_header))~0U)) {


Inner offsets do not use ~0 as an 'unset' marker, they are zeroed.

> +               DEBUG_NET_WARN_ON_ONCE(1);
> +               return skb->head + skb->inner_network_header;
> +       }
> +
>         return skb->head + skb->inner_transport_header;
>  }
>
> @@ -3072,7 +3078,11 @@ static inline void skb_unset_transport_header(stru=
ct sk_buff *skb)
>
>  static inline unsigned char *skb_transport_header(const struct sk_buff *=
skb)
>  {
> -       DEBUG_NET_WARN_ON_ONCE(!skb_transport_header_was_set(skb));
> +       if (unlikely(!skb_transport_header_was_set(skb))) {
> +               DEBUG_NET_WARN_ON_ONCE(1);
> +               return skb->head + skb->network_header;
> +       }
> +
>         return skb->head + skb->transport_header;
>  }
>
> --
> MST
>
