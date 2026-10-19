Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC6B4F6486
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 13:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792418077; cv=pass; b=bKUdpdasJtKp1t/NNkyXj+9f/Rn+7wlfWTZZ954PGSWk+J8oVgStyWn5IS/PjYxso7ChLV0dvNGUeawJ4XrjEtknWl+P62//b/prNXKx6rYxJHFWjo7QsmPG4t9sht/2QeRgj3meV0lpiBpNoz8ntRpZ9QIGe4KhIa9fbU63KVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792418077; c=relaxed/simple;
	bh=gvwoY48v8HtjEGBanR0EVPc+UxSyK5a07IZl2skoMZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gmDaN37lp+pQejdaLFui/EWDjwiqfx8QnkZpfjlyhRTAudqXdEzacMqGKX6pZcBEU72kDNgG6lquWZQ59arsSHcD9vgAOnkSB4zrtpNR7AdMSzKPc3XUCJlPV+K0ytY7NuZy/kmEJT4ib8mzjvwcD2hSiY2Z1Yg7TqtC1gAdSaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uNpXCGQP; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uNpXCGQP"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5337fa12431so402701cf.1
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 06:54:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792418074; cv=none;
        d=google.com; s=arc-20260327;
        b=sQgNQNYWzbvlobCNf7DoavTxVs6UWUymCHvzZVPNzumcE6rnSxBV8mdWz4p1Kn89Ez
         Rv6JWn9JLFjwk5RqZeABRY25mybwP9VsJjLASzeuyfa+rrgO8OfW7AZAf9zl2oZji/lb
         bTBpAZt/FFI9w0+x+/OVhDufuqjub01FIANnf+9JdnVjm1DZtmSwWaSPX0MLbnQbC2J/
         NPsMfSPQ1KzQEMJMSlaSj98pufmgYKaZCGX4O68mA4wWUKJQ7WEBbBo2znC7ju8WhE4n
         ATJUwJKoPmPeqaoB74aGwvQqwQJgjx8wLlSdR57ORJAnxxTej7dLj8TIukgq3grH13DH
         6EfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0kEytU5LeiM3vhSLHRfNg06oRQOFH8XdzJ+MdOl7cWw=;
        fh=0Pr3NAAL3/ASf12Ysq73Kx4oGjHnLEgkwhEBmjtcBZE=;
        b=gCoMfXlDCaK9+tUbNIdJUOETweRw/p5DzojssIIC+/o9uERBNKd44SIwLExqb598GM
         1fhgokLqCgQDJ1/IpJ9C1er21rPd4U/L7MWmT1OBlFlyolRZZW8DvDenjQc0hD7xKvOy
         EcAuSK1RcYUquE8EtLBs1a8gvE8ukulv0l4N98qXVX8d00VGXb9cnDP3vWRnmEm62lK1
         vPXQQLOlQUd1FnApZEi52yjYqxGAYy7CPfOK1py/+SoIs40TiNvalOnYggZIkP1S+fqS
         0dOtYlFq9RJgnlIvsq9FFJZJe6yMzRGk0/pzsw740dxHLyEw9cvlTeLDnq5hTrrNTesN
         FL7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792418074; x=1793022874; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0kEytU5LeiM3vhSLHRfNg06oRQOFH8XdzJ+MdOl7cWw=;
        b=uNpXCGQPcR1FBHrB7LaE+WHjBB52uC8BjnVVPYEmtek8ERcmSeijJ9LBLLm3BTxAqr
         aPAH3DCoH57rKYO2v9WsiafoGqkCwWxfh85xiwk/SzfB5nR7V9ZNVdQRB9d08PwdyJYz
         YeqQhUu/UVlD/Cbdavi/XdKRN+hGNO91HLRAihExCMqkd9RhcWL29TXISP/KuI83Z7YE
         k0U66OxR055W3AkvkRdfYmr1meUrsTDI1N1wTb7gd5MfJzteXs6T3i4yaL8DNRyOsMZm
         SMY5kub6Zj+WrgsJ203Oafz3t4jeM+JWEF5bWZIAFcuOQktMCKCM2eJUR9tBEjSR1Pym
         /aKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792418074; x=1793022874;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0kEytU5LeiM3vhSLHRfNg06oRQOFH8XdzJ+MdOl7cWw=;
        b=r+FzftVzs8/Xj7lormLx5tnYAUUrU6D1m0jLZY5XimIhYxE1roWjOUs23bP/c2Zxqi
         YOM+uU2kzfd4DlKpxby/LPbFdcXwwOUVnm7jo9bOzj22zudrm47cJajq/ggmQ2wFq9ok
         o99/vTr2Xid7EoPmA3s/yDpyFyopYy0GvwubUXb2wP1K4/FLFF+QPxToWwOmNIPNPrnx
         Zcjc/FoLglnRwe9tm3bjoNLUDeLVrAkqq1QPBCo/RWzdlgRiRPiLNAEpTp5quHXqXMKR
         ZUaswqkX4ao6X4RGu4mfNpjSxPXxcfPnKOcWfnZkfncoTKOUSUgyQIaHg0Ecw9k3YGIL
         UINg==
X-Forwarded-Encrypted: i=1; AKwUvBxjmCSDgpQeCt1H3joP3JzeYtLStao3lX7BXeeybimW9sqOiDcqZQUG35lWcycPZ4jOpBaV5rc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLpNUXybizKxOouvcCZ4FV0wUIJ7TLMOcHqJ+U5S9IklWIOjx24
	6r3soZDjq6dKC4BnsHuTTj0dJTYfUKI3MMlrpkrUSAYOzUFwGkSbuNVsQoSNekAkZnaNNh8wV1D
	q/PKV0D85qRYwetTj3CSK99KGVNYWX2aDQEliaYWv
X-Gm-Gg: AYBFou19zLvydjQPK3KA/msLMhrE5NSLC9pjhYMliaZI/+3eDvQ+a5vpboh8eY1mapD
	xTaQTpHflemKTIwtNjo38qzXUwZKsLraPp86VMPk7xkAHPRkER9ioACqmpKOb1f9M2wuwtPaXKj
	TGkS8WOcIU5j/UPc0yg1LnbQtI8byZOt9ijjD8OtVN5g2OdZeUE2OcWUY2pX7O1/4tqZ+6yj0FI
	gVEuRWIdsN63BSyN4qG7w27oaVXTtXxtgAxRFygsu1XhQ1AwcAU8L4B00Uv1pblnED08/o8quFq
	9BZwlc2kqybKRzgILy9Av6UYxKfZ5AvYpZACkwvdngQyQHLozvVTdj2z+IfSM5wvzgGUnfq7GJX
	yne21TFXvz+LYIPzD7/1YXLYC3y4U2nIF0LHfjmM2zGXvlDwQJ8QedOU=
X-Received: by 2002:a05:622a:228b:b0:532:eff9:ca08 with SMTP id
 d75a77b69052e-536465dfce9mr41062201cf.12.1792418073474; Mon, 19 Oct 2026
 06:54:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261018211514.2817293-1-chia-yu.chang@nokia-bell-labs.com> <20261018211514.2817293-2-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20261018211514.2817293-2-chia-yu.chang@nokia-bell-labs.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Mon, 19 Oct 2026 09:54:16 -0400
X-Gm-Features: AclHuK-yKHKszrAvQ0DWznhcRsJCvVm21RfRVRcavHBDlb8PKd3FVpjc1os6wtY
Message-ID: <CADVnQy=jqk0vZUsG6JKv44cBbnR5pG5+7Tvacohuz3tzFpF6pQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/3] tcp: accecn: Add ece_delta to rate_sample
To: chia-yu.chang@nokia-bell-labs.com
Cc: ihor.solodrai@linux.dev, john.fastabend@gmail.com, jakub@cloudflare.com, 
	jiayuan.chen@linux.dev, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, emil@etsalapatis.com, linux-kselftest@vger.kernel.org, 
	shuah@kernel.org, horms@kernel.org, dsahern@kernel.org, pabeni@redhat.com, 
	jhs@mojatatu.com, stephen@networkplumber.org, davem@davemloft.net, 
	edumazet@google.com, andrew+netdev@lunn.ch, donald.hunter@gmail.com, 
	kuniyu@google.com, ij@kernel.org, koen.de_schepper@nokia-bell-labs.com, 
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
	Jason_Livingood@comcast.com, vidhi_goel@apple.com, Mike_Rudolph@comcast.com, 
	Jeff_Howe@comcast.com, srichard@netapp.com, 
	Olivier Tilmans <olivier.tilmans@nokia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 18, 2026 at 5:15=E2=80=AFPM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Ilpo J=C3=A4rvinen <ij@kernel.org>

Thanks for the patch. I agree this will be useful for congestion
control modules using L4S ECN. For example, I see this field is used
by Prague in https://github.com/L4STeam/linux/blob/testing/net/ipv4/tcp_pra=
gue.c
.... is that the current URL for the code?

> Include echoed CE count into rate_sample. Replace local ecn_count
> variable with it.

I'd suggest a clearer commit message, like:

Include in rate_sample a count of the number of segments that were
newly marked, on this ACK, as having been CE (congestion experienced).
Replace local ecn_count variable with it. This signal will be useful,
in upcoming patches, for congestion control modules, like Prague,
which want to process AccECN-style ECN signals.

>
> Co-developed-by: Olivier Tilmans <olivier.tilmans@nokia.com>
> Signed-off-by: Olivier Tilmans <olivier.tilmans@nokia.com>
> Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> ---
>  include/net/tcp.h    |  1 +
>  net/ipv4/tcp_input.c | 41 +++++++++++++++++++----------------------
>  2 files changed, 20 insertions(+), 22 deletions(-)
>
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 0265c27a5fd7..1838389a9d8a 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -1346,6 +1346,7 @@ struct rate_sample {
>         int  losses;            /* number of packets marked lost upon ACK=
 */
>         u32  acked_sacked;      /* number of packets newly (S)ACKed upon =
ACK */
>         u32  prior_in_flight;   /* in flight before this ACK */
> +       u32  ece_delta;         /* is this ACK echoing some received CE? =
*/


This comment seems incorrect. It implies the value is a boolean, but
it's a count.

I'd suggest renaming the field for clarity, to something like
acked_sacked_ece, since AFAIK it is the subset of the packets in
acked_sacked that were marked as CE.

So, for clarity/readability, I'd suggest renaming it, and placing the
field immediately below acked_sacked, and reworking the comment to be
like:

        u32  acked_sacked;      /* number of packets newly (S)ACKed upon AC=
K */
        u32  acked_sacked_ece;  /* number of packets ECE-marked upon ACK */

>         u32  last_end_seq;      /* end_seq of most recently ACKed packet =
*/
>         bool is_app_limited;    /* is sample from packet with bubble in p=
ipe? */
>         bool is_retrans;        /* is sample from retransmission? */
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 02ec0b0116d1..a5a7302050c4 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -588,9 +588,10 @@ static u32 __tcp_accecn_process(struct sock *sk, con=
st struct sk_buff *skb,
>         return safe_delta;
>  }
>
> -static u32 tcp_accecn_process(struct sock *sk, const struct sk_buff *skb=
,
> -                             u32 delivered_pkts, u32 delivered_bytes,
> -                             u64 prior_bytes_acked, int *flag)
> +static void tcp_accecn_process(struct sock *sk, struct rate_sample *rs,
> +                              const struct sk_buff *skb, u32 delivered_p=
kts,
> +                              u32 delivered_bytes, u64 prior_bytes_acked=
,
> +                              int *flag)
>  {
>         struct tcp_sock *tp =3D tcp_sk(sk);
>         u32 delta;
> @@ -600,11 +601,11 @@ static u32 tcp_accecn_process(struct sock *sk, cons=
t struct sk_buff *skb,
>         if (delta > 0) {
>                 tcp_count_delivered_ce(tp, delta);
>                 *flag |=3D FLAG_ECE;
> +               rs->ece_delta =3D delta;
>                 /* Recalculate header predictor */
>                 if (tp->pred_flags)
>                         tcp_fast_path_on(tp);
>         }
> -       return delta;
>  }


Does this compile? Did you try to compile this patch? This removes the
only "return" statement from a function that returns a value. Looks
like invalid C to me. :-)

>
>  /* Buffer size and advertised window tuning.
> @@ -4220,8 +4221,8 @@ static void tcp_xmit_recovery(struct sock *sk, int =
rexmit)
>  }
>
>  /* Returns the number of packets newly acked or sacked by the current AC=
K */
> -static u32 tcp_newly_delivered(struct sock *sk, u32 prior_delivered,
> -                              u32 ecn_count, int flag)
> +static u32 tcp_newly_delivered(struct sock *sk, struct rate_sample *rs,
> +                              u32 prior_delivered, int flag)
>  {
>         const struct net *net =3D sock_net(sk);
>         struct tcp_sock *tp =3D tcp_sk(sk);
> @@ -4232,8 +4233,8 @@ static u32 tcp_newly_delivered(struct sock *sk, u32=
 prior_delivered,
>
>         if (flag & FLAG_ECE) {
>                 if (tcp_ecn_mode_rfc3168(tp))


This (tcp_ecn_mode_rfc3168(tp)) expression seems to suggest that the
value will not be available for AccECN connections. How will Prague
use this rs->ece_delta field if it's only available for rfc3168 ECN?

I suggest addressing this so that the rs->ece_delta is updated if
tcp_ecn_mode_any(), and putting that change in a new commit, placed
before this commit in this patch series.

>
> -                       ecn_count =3D delivered;
> -               NET_ADD_STATS(net, LINUX_MIB_TCPDELIVEREDCE, ecn_count);
> +                       rs->ece_delta =3D delivered;
> +               NET_ADD_STATS(net, LINUX_MIB_TCPDELIVEREDCE, rs->ece_delt=
a);
>         }
>
>         return delivered;
> @@ -4288,7 +4289,7 @@ static int tcp_ack(struct sock *sk, const struct sk=
_buff *skb, int flag)
>         struct inet_connection_sock *icsk =3D inet_csk(sk);
>         struct tcp_sock *tp =3D tcp_sk(sk);
>         struct tcp_sacktag_state sack_state;
> -       struct rate_sample rs =3D { .prior_delivered =3D 0 };
> +       struct rate_sample rs =3D { .prior_delivered =3D 0, .ece_delta =
=3D 0 };

Adding the ece_delta field here in the initializer is redundant.

According to the C99 standard (ISO/IEC 9899:1999, Section 6.7.9,
paragraph 21), if an aggregate or union contains fewer initializers
than there are members, the remaining fields are implicitly
initialized the same as objects that have static storage duration.
When you explicitly initialize even a single scalar field (whether to
zero or any other value) using a designated initializer, you trigger
the C language rule for partial initialization. Arithmetic/Scalar
types (integers, floats) are initialized to 0.

Thanks again for the patch.

Best,
neal
