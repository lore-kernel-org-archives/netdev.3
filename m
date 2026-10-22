Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792662422;
	b=dyj/ISABaKNmbm0j89meVMHH4x9yBUDNPj1XqeimaVlmRBzxtZ13+s78tRG4tdqj3Se8
	 5HrQFRuU6kucYDeouFQf8Meujco5Cfa76Vx2SJ+w5HwEDxgHi77f0ayC/t9nnAOIOWcZw
	 YnEhp2CvCJ1ssmAEe6I5aiA05N+VHrJSuB3HBbarX6G61kX+f9BXLMFCssOYo96s+LDP1
	 xZZUJKKK48Ijxmvg9NTYgqZkwFqBzBR9Q39vPxCNe8OSN5swHqol4F+VcsFRwLxB/f+ht
	 YXIgbcgAF0/b6isAGuCEvVHYDNADbVgQ1gqdcln8DLQ8yaMfqykOXii4Mu199ZCqyKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792662422;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ZI+JZekW1eZfbo1bldDDqc0Ftl2TSNYfVIbUC7r6vEQ=;
	b=j/W/tQoXCS9HjOnsyFCmsexrRBywYPMm309zN1WZ/OVnI293HIVLQwLUCVbiEAN9nF5D
	 JNkET9kq8K/b1lWHIpQY+sa3+p72ERFncDL02/xa0FiwXgXQmfsf+tjrMHwcKJoLaAeEV
	 hwsrCf313kjHRZ6aUtkLMHtzqsrdZbi4Pu0i6QAe9DJqe3+gqwmYSsvL3/Jixc50ayvDh
	 l8FtETTbZAxDpk//hzbcNYgZ5nVTjcmT8PPhn2whx9Z8N7nwnu92mE7Q57VTlDjOcjKhf
	 3xf5BdAuIlewFSY4lMLLOlwCEPpBWRVHiXxT9aiSHDpEnWQkO8OFomMSy4oZ74OOwfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GH+tkpgA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56CE606A319
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 09:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GH+tkpgA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66BC61F000C4
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 09:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792662421;
	bh=ZI+JZekW1eZfbo1bldDDqc0Ftl2TSNYfVIbUC7r6vEQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=GH+tkpgAkeH8LCyMCUx+YpCn8KdMGJBCt142r+op0FUZwHVmG6b3JUEdWzFXx3AmM
	 FALiF/arNrDYyP5GPG8oMSH46wTG9/rE/W5AdaYVoiSIdv3hyk3x+XBb3r+F4a0CV7
	 W5u97Wr4miWrwDU6jwspTUy/nFQuwbOKXMz1bew71N3nQwfl8VM71jLdi37ypDFy0V
	 otejX7o1II7+4PK2KaS1pK8I9uQx/NkdLWFQCdWojeTpvS9ZYbwVXMsu6NvG6tsFRS
	 93xSPsaBoYGo3IpKNBz7BmSaEtPK2gFwqVotQF1muopnPUlVeHsEGyVVfbHrZL0Kap
	 6RiNezIP0bVOA==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-483a66818edso842806fac.0
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 02:47:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxFAb+9xnIfCC2RlKo0eMtjK9Taab0/VNUa5nvf3koljHUolx9KcawSItrJ8nZsFOUCJAZThEg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ1nuRDlX9CajEkBIUv9Eo+VRReLPz3fT6Q4mw5YOs7Sgk360N+
	8zsh0E6hDb3v0z/1hdjnC2pW/KD37OUsLHQr8H+ZvdTMFFa0PxEFKhMQ+PG0dWnLDKDlbVE3lhu
	3HMkIjn1HCIJx0rI6xRu9Xf7lYrQYvd0=
X-Received: by 2002:a05:6870:46a4:b0:48f:e0e5:a1fb with SMTP id
 586e51a60fabf-4a7dc274bd8mr3147537fac.47.1792662420576; Thu, 22 Oct 2026
 02:47:00 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <2ab9dc5f5b5e9f50d7a4aa02a6b6759fc86314c7.1792658454.git.gnault@redhat.com>
In-Reply-To: <2ab9dc5f5b5e9f50d7a4aa02a6b6759fc86314c7.1792658454.git.gnault@redhat.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Thu, 22 Oct 2026 11:46:48 +0200
X-Gmail-Original-Message-ID: <CAL4WiirZKwGSP6w5vtbEQ-KXY3qR_ie3HuyRuF_JVEoC3PiO4A@mail.gmail.com>
X-Gm-Features: AclHuK9Di-G6SVDUx4CAa-CRfPvVmvRGHRFyWobXl5XXwhsuhCBggXh88wv6Nrs
Message-ID: <CAL4WiirZKwGSP6w5vtbEQ-KXY3qR_ie3HuyRuF_JVEoC3PiO4A@mail.gmail.com>
Subject: Re: [PATCH net] tcp: Fix dup-ack detection on non-SACK bidirectional
 data transfer.
To: Guillaume Nault <gnault@redhat.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Tom Williams <Tom.D.Williams@morganstanley.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 22 oct. 2026 =C3=A0 10:49, Guillaume Nault <gnault@redhat.com> a =
=C3=A9crit :
>
> When receiving a pure ack from a peer that also sends data, we can
> have SEG.SEQ > SND.WL1, even though the segment contains no data. This
> makes tcp_may_update_window() return true (because of the
> "after(ack_seq, tp->snd_wl1)" condition), and tcp_ack_update_window()
> then adds FLAG_WIN_UPDATE to the segment set of flags, even when
> there's no window update.

Nice catch. This also matches RFC 5681 dupack definition, (e):
"the advertised window in the incoming acknowledgment equals the
advertised window in the last incoming acknowledgment".
Maybe worth quoting in the changelog.

>
> Since FLAG_WIN_UPDATE prevents the segment from being considered as
> dup-ack (as it's part of FLAG_NOT_DUP), this can inhibit fast
> retransmit on non-SACK connections, making recovery very slow as it
> now entirely relies on RTO.
>
> Avoid this scenario by setting FLAG_WIN_UPDATE only when a window
> update actually occurs. Pure acks with SEG.SEQ > SND.WL1 can now
> be detected as dup-ack and trigger fast retransmission.
>
> Add packetdrill selftest. Before this patch, the 1001:2001 segment was
> retransmitted upon RTO, now it's sent right after reception of the
> third duplicate ack.
>
> Thanks to Tom Williams for the investigation help and initial
> reproducer.
>
> Reported-by: Tom Williams <Tom.D.Williams@MorganStanley.com>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Guillaume Nault <gnault@redhat.com>
> ---
>  net/ipv4/tcp_input.c                          |  2 +-
>  .../tcp_bidir_fast_retransmit_nosack.pkt      | 42 +++++++++++++++++++
>  2 files changed, 43 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/net/packetdrill/tcp_bidir_fas=
t_retransmit_nosack.pkt
>
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 99baf14afdfd..ef20bb5a0523 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -3959,11 +3959,11 @@ static int tcp_ack_update_window(struct sock *sk,=
 const struct sk_buff *skb, u32
>                 nwin <<=3D tp->rx_opt.snd_wscale;
>
>         if (tcp_may_update_window(tp, ack, ack_seq, nwin)) {
> -               flag |=3D FLAG_WIN_UPDATE;
>                 tcp_update_wl(tp, ack_seq);
>
>                 if (tp->snd_wnd !=3D nwin) {
>                         tp->snd_wnd =3D nwin;
> +                       flag |=3D FLAG_WIN_UPDATE;

One behavior change to keep in mind: because of the "|| !nwin" clause
in tcp_may_update_window(), every zero-window ACK used to carry
FLAG_WIN_UPDATE and was never considered as a dupack.
After this patch, repeated "win 0" ACKs at snd_una with outstanding
data (receiver dropping in-flight packets because its queue is full)
will be counted as dupacks and can trigger fast retransmit + cwnd
reduction while the peer is simply stalled.
This is RFC compliant, I think this is fine, but a packetdrill test
covering this case would be nice.

Also, the header-prediction branch in tcp_ack() still sets
FLAG_WIN_UPDATE unconditionally, so CA_ACK_WIN_UPDATE (only visible to
BPF CC) is now inconsistent between fast and slow paths.

It is quite sad that some TCP stacks do not use SACK in 2026.
They will still be dealing with decade old bugs.

I am unsure if this is a net candidate, perhaps Neal and Kuniyuki can
give their thoughts.
