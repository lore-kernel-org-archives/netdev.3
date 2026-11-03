Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793702215;
	b=1Wn05pyf7r1XuZTQTbBR3pPZFN+EWRN6SiwP3cRFaY0diyZNfq7fuHgPM6G65MLeWBm6
	 w5SbBK2Xx9B3vD/mwFG2x+dWs/aXCWtfSImL/QgC/zp/RpYGipRM+mDBDbqz0t8vaz7M7
	 otWz2xSmx0hNmzc72c8hZjsSBMbnZcuvempDuuRV+13EB43vVheUiS7RCSe/bl4h5MB7q
	 D5aLlGYUK/gfk7eMDX56l3KHVM9xW/CRzYM5Yyrms8v+LHUHta6nLl/QysPBRauqz0E0R
	 oPxz7TV4RJmmOFolC3uIEe6gFjMgtDcjwmCi5tqSwpRJgPRE7CgS7jjPbs0nCtAP/Tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702215;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=eLiAEV/6tssOikmW05VAqNxjxiGwd3x7azUvrveuosI=;
	b=KKUbU0NhC/4bRxRvVuKdzPhGfe0QiAs76rNdPlFjZt9bFvxHlns+ZxaXMU+4zDNJydWl
	 4+xGJtapabSxuAwwurvwc/PbkPPrR4UUfcpIokrDXNvXGlnq5A7BmW2ZvJBXY7+LIuJOc
	 lWvkPChCz4XF6sPb9yZqGSg+3FO3HQtbpOWGpJeIq70Kq+YJIAgZWgbhOfs1xU+FyQwXF
	 pTjH/e0P7Guh9VEgsn5XW5c+67AdHj9gno9zuaH7BVle2FFoc2YGwZxpIVqR9GOG+NdFS
	 feE4OacbvsqZvCE05CUMjFUrH4h4FlXNaTl7U8eGaFhByzDLjbuC/SYRF9YqU/0JPVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HIamycCT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2456606A828
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 10:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HIamycCT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B06F51F0093A
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 10:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793702214;
	bh=eLiAEV/6tssOikmW05VAqNxjxiGwd3x7azUvrveuosI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=HIamycCTV5WRtyENf7aNYTLda6FsYdBU5EO39gz7lKOBNuGksukSgsxSRihNOwqEo
	 kE3YQaihOTHNSpVBF8WSUJ+5zwqx2mQP9PBDPPt7VNfWcTLPjA/jt61vdS5MjNoawA
	 yE6FftoXS08Iyq1tsJYlxXLsfeR8n+81luszvIUpIPyqamxM+1Yi0d5dyaln2VeLmC
	 Tkyeq6TnpWynPsqdGxFF14t2o2w4o3YAnDYKyY98Ic4/2N2RpyJQi5RtiYn7wHcj9T
	 mZbBi33IWDYzPf1LhInorZk65L/hadQrq7lLwwfotJKYWlp5xXRMlJTf4jYqeLhpoQ
	 uoet2npMyAjAg==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6ddef424972so2891056eaf.3
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 02:36:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBxkNLKxPjDblLeKE+/Z9xggzThHBXY68VUM41vnKlq7wnnGBVAfm+CDXqcUZY7kis3JfITJsTk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/m85XP/5t4vvHQ7f7jamw9eT/k23A3FahmpgnC6wj/pgqpSbMB
	I+j9AFEZP3XzhJ+thQZQvDTRYiDfDl0JUIfezU3JvKtq0DHrBPaACa4CBqSU+7FwfHLMTFzZG2I
	r5UofRlHeTdurrsFZ8EMJhcQsVz3ebjM=
X-Received: by 2002:a05:6820:1343:b0:6f9:59ee:cfb7 with SMTP id
 006d021491bc7-714f29880c0mr6574515eaf.23.1793702214029; Tue, 03 Nov 2026
 02:36:54 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030111528.2850082-1-edumazet@kernel.org> <179363987528.3131.2987776489427079887@kernel.org>
 <967aa8d5-582f-43bf-a8ff-8ab68aad747e@redhat.com>
In-Reply-To: <967aa8d5-582f-43bf-a8ff-8ab68aad747e@redhat.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Tue, 3 Nov 2026 11:36:43 +0100
X-Gmail-Original-Message-ID: <CAL4WiirrH_zWGZmQ3=TB+xL71N0MeM6M0-zem-54koVzkBTm1Q@mail.gmail.com>
X-Gm-Features: AclHuK_Q98vaVQ85TOyfrsXNPTG-ZY2ACxx00_N7Id8Hl4sQTnySoA_FfNbg9y8
Message-ID: <CAL4WiirrH_zWGZmQ3=TB+xL71N0MeM6M0-zem-54koVzkBTm1Q@mail.gmail.com>
Subject: Re: [PATCH v2 net] tcp: bound snd_cwnd_clamp to TCP_MAX_SND_CWND
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev-bot+sashiko@kernel.org, davem@davemloft.net, kuba@kernel.org, 
	ncardwell@google.com, kuniyu@google.com, horms@kernel.org, 
	netdev@vger.kernel.org, mason@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mar. 3 nov. 2026 =C3=A0 10:51, Paolo Abeni <pabeni@redhat.com> a =C3=A9c=
rit :
>
> On 11/2/26 18:17, netdev-bot+sashiko@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 2 potential
> > issue(s) to consider.
> >
> > Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 1
> >
> > If you believe none of the issues are legitimate, please reply to each
> > issue of Medium severity or higher and explain why the AI is wrong.
> > If any of them are legitimate and you plan to respin, please let patchw=
ork
> > know by including "pw-bot: cr" as a separate line at the end of your re=
ply
> > (one such reply per series is enough).
> >
> > - [Medium] BPF struct_ops congestion control programs can still store a=
ny
> >    u32 into snd_cwnd and snd_ssthresh, skipping both snd_cwnd_clamp and=
=E2=80=A6
> > - [Low] Some CC u32 arithmetic can still overflow with cwnd at or below
> >    TCP_MAX_SND_CWND, which contradicts the new tcp.h comment saying CC=
=E2=80=A6
> >
> > --
> >
> > tcp: bound snd_cwnd_clamp to TCP_MAX_SND_CWND
> >
> > This patch gives snd_cwnd_clamp a finite default of TCP_MAX_SND_CWND
> > (2^20 packets) instead of ~0. It also caps the locked RTAX_CWND metric
> > and the TCP_BPF_IW and TCP_BPF_SNDCWND_CLAMP setsockopt paths. The goal
> > is to keep the u32 cwnd arithmetic in congestion control modules from
> > wrapping.
> >
> >> diff --git a/include/net/tcp.h b/include/net/tcp.h
> >> index 3560adddf8215..5c9203aae8341 100644
> >> --- a/include/net/tcp.h
> >> +++ b/include/net/tcp.h
> >> @@ -1554,6 +1554,15 @@ static inline unsigned int tcp_packets_in_fligh=
t(const struct tcp_sock *tp)
> >>
> >>   #define TCP_INFINITE_SSTHRESH      0x7fffffff
> >>
> >> +/* Default and maximum snd_cwnd_clamp, in packets.
> >> + * A peer can not advertise more than 65535 << 14 bytes, so a larger
> >> + * cwnd is useless with any MSS of 1024 bytes or more.
> >> + * Congestion control modules multiply cwnd by u32 factors up to 2047
> >> + * (cwnd * (BICTCP_BETA_SCALE + beta) in CUBIC), and CUBIC's
> >> + * bictcp_update() expects cwnd to stay below about one million packe=
ts.
> >> + */
> >> +#define TCP_MAX_SND_CWND    (1U << 20)
> >
> > [Severity: Low]
> > Does the "factors up to 2047" sizing hold for CUBIC's bictcp_update()
> > with valid beta values?
> >
> > cubictcp_register() in net/ipv4/tcp_cubic.c accepts beta in [0, 1023],
> > then computes:
> >
> >       beta_scale =3D 8 * (BICTCP_BETA_SCALE + b) / 3
> >               / (BICTCP_BETA_SCALE - b);
> >
> > For beta=3D1023 this gives beta_scale =3D 5458. bictcp_update() then do=
es
> > this in u32:
> >
> >               delta =3D (cwnd * scale) >> 3;
> >
> > With that scale, the product wraps for cwnd above about 786,906, which
> > is below TCP_MAX_SND_CWND. For cwnd =3D 800000, delta comes out as
> > 8,929,088 instead of 545,800,000. The ack_cnt loop then inflates
> > ca->tcp_cwnd and pushes ca->cnt down toward 2, so cwnd grows too fast
> > near the clamp.
> >
> > beta is also module_param(beta, int, 0644) in both tcp_cubic.c and
> > tcp_bic.c, and a write at runtime is not validated. If beta > 1023 is
> > written later, cwnd * (BICTCP_BETA_SCALE + beta) in
> > cubictcp_recalc_ssthresh() can wrap at cwnd =3D 2^20.
> >
> > In BIC, beta=3D4096 makes cwnd * beta in bictcp_recalc_ssthresh() wrap =
to
> > 0 at cwnd =3D 2^20, which returns an ssthresh of 2. That beta value mak=
es
> > no sense anyway, though.
> >
> > All of these need privileged module tuning, and the effect stays within
> > CC behaviour.
>
> My understanding is that the last sentence makes this comment mostly
> irrelevant.
>
> >>   static inline u32 tcp_snd_cwnd(const struct tcp_sock *tp)
> >>   {
> >>      return tp->snd_cwnd;
> >> diff --git a/net/core/filter.c b/net/core/filter.c
> >> index 09c60a58c82ab..96f9ba67095a2 100644
> >> --- a/net/core/filter.c
> >> +++ b/net/core/filter.c
> >> @@ -5590,11 +5590,12 @@ static int bpf_sol_tcp_setsockopt(struct sock =
*sk, int optname,
> >>      case TCP_BPF_IW:
> >>              if (val <=3D 0 || tp->data_segs_out > tp->syn_data)
> >>                      return -EINVAL;
> >> -            tcp_snd_cwnd_set(tp, val);
> >> +            tcp_snd_cwnd_set(tp, min_t(u32, val, tp->snd_cwnd_clamp))=
;
> >>              break;
> >>      case TCP_BPF_SNDCWND_CLAMP:
> >>              if (val <=3D 0)
> >>                      return -EINVAL;
> >> +            val =3D min_t(u32, val, TCP_MAX_SND_CWND);
> >>              tp->snd_cwnd_clamp =3D val;
> >>              WRITE_ONCE(tp->snd_ssthresh, val);
> >>              break;
> >
> > [Severity: Medium]
> > The commit message says the patch will "cap the metric and BPF paths
> > that set it or set cwnd directly". Does that also cover struct_ops
> > congestion control programs?
> >
> > bpf_tcp_ca_btf_struct_access() in net/ipv4/bpf_tcp_ca.c only checks
> > that the store stays inside the field:
> >
> >       case offsetof(struct tcp_sock, snd_cwnd):
> >               end =3D offsetofend(struct tcp_sock, snd_cwnd);
> >               break;
> >       ...
> >       case offsetof(struct tcp_sock, snd_ssthresh):
> >               end =3D offsetofend(struct tcp_sock, snd_ssthresh);
> >               break;
> >
> > So a BPF CC can still store any u32 into snd_cwnd and snd_ssthresh.
> > Those stores skip both snd_cwnd_clamp and TCP_MAX_SND_CWND.
> >
> > The native functions named in the commit message are exported as kfuncs
> > to BPF_PROG_TYPE_STRUCT_OPS: cubictcp_recalc_ssthresh(),
> > cubictcp_cong_avoid() and dctcp_ssthresh(). Take snd_cwnd =3D 1 << 24 a=
nd
> > the default dctcp_alpha of 1024. In dctcp_ssthresh(), cwnd * dctcp_alph=
a
> > wraps to 0 and ssthresh =3D=3D cwnd, which is the failure the commit me=
ssage
> > describes.
> >
> > tcp_reinit_congestion_control() doesn't reset snd_cwnd either. Switchin=
g
> > from a BPF CC to native CUBIC, DCTCP or BIC would carry an oversized
> > cwnd into their ->ssthresh() handlers.
> >
> > There is a worse case in bictcp_update(). With the default beta_scale o=
f
> > 15 and snd_cwnd =3D 0x88888889, cwnd * 15 wraps to 7, so delta is 0:
> >
> >               delta =3D (cwnd * scale) >> 3;
> >               while (ca->ack_cnt > delta) {
> >                       ca->ack_cnt -=3D delta;
> >                       ca->tcp_cwnd++;
> >               }
> >
> > Can this loop spin forever? A struct_ops CC could reach it by writing
> > snd_cwnd and setting snd_ssthresh =3D 1. It would then call the
> > cubictcp_cong_avoid() kfunc with acked >=3D 1 while the flow is cwnd
> > limited. The CPU would then spin in native code during ACK processing,
> > where the verifier's loop limits do not apply.
> >
> > Loading a struct_ops program needs CAP_BPF plus CAP_PERFMON, or a
> > delegated BPF token. A cwnd of 0 can also reach the kfunc hang, and an
> > upper cap would not fix that.
> >
> > Should the bound also be enforced on the struct_ops write path, or in
> > these kfuncs?
> This items looks like a separate thing deserving a separate fix.

Agreed, I am working on a follow up.
