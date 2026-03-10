Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BC343901F
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 08:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773132912; cv=pass; b=DiPnWIqSDqJjLOcepaPdnFs+06L7DkY40RpbHin/l55LqmQSZrigt5NU/z5HwuTzMDZNdF8+/dIacZ1RhHvxC31iPcUu74Bp6qAF6o2VR3pqr957H3vCJHw7didxoHNgR5hGYQ4OITtQ91PMpIBCWwbx5y3+aqXNU+4RNDsx24Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773132912; c=relaxed/simple;
	bh=MTpfFIjKFrgdOM/fNUp2/tdXoh0iY9f5YiOgrsaFrPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xp+T+cHQEne5UFQBrl4thekjic0rQepLc70xbfU4FQIlQDbyVVLGS3B2LhwqBcf9oLbOWv0cEI+nGvXJlmX4KxVIrZTOghZzN9BDwYmwCXmkhJfDSuuhTw7IyRDIpIwNM/tGuVPu3FXtSrSTAOvlRv9ndzc58hahd7i/0wm2U+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Na+svgUq; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Na+svgUq"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5062fc5d86aso110066151cf.1
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 01:55:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773132910; cv=none;
        d=google.com; s=arc-20240605;
        b=CY8U1H2uPUb3Qk1WZvbFztNU0C1OOXYrJOy/nJcBqJat9EtQz81fKKuHV/Z6/Cc6iK
         tnk1Nu5UmXFxc5QOyKj6h6BMBW2EOEXUrYwi6DVRTF8DWRrfoO6Lk6UrFTe+vLRsdOL7
         8QeyhClU3ev47OuVzLc57p6EQEE/qjCXigVJ+3v1GWP2G3Oynr38esUeF/asnRs/XH1i
         qlEgSqZpqI0wYVq91zXC0P9FPqb5Ce97WkyEmQ8Y4t5mlrUjxAu1AUU+h1yWvo55ekIr
         XTKRwthS1uQuDBfIlGPmxKbUywQYvJ1m73qGQYMDhgqESOt1As9T32YBhn/BJVN6Rtx8
         cRNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=57HCSNZqdX/pE4pNruhHCDIUKjmgpBGDki8+akqS8UU=;
        fh=eMqTKOD6vvlGgFh6s8l3liXx4Jo22wjYpLVpYFQt71Q=;
        b=cwF9dy2tInACc8VvkxkzyHvcO8uvgSzibkCj32PzUOrOnmUvyXx3MEcWIFrzS/LKJD
         ySQCOLI4DUdwup3QvB063GqWOrDR4ck5DgUuAoEon+i0LXSv2NWXChfeUnSL+QaGTBEt
         TAadSWU4ZHgMnLhd9x0T8CRHAGcvDxXLMPPN+sZkQdgXOKYU0mOPJ5i/uvV2DYmG1v5h
         IjBlto5jhSd5yUYIKmko83GxV/L92u9DGEltEhvDWraSSybFBc/vRZYerwNdrn1GlYSB
         qSNAJkrwbP7BvxisWaFdcbdzIYWIYB0sidgMK/H2+f5J8pcy5NG6WpiBg9Hwq52qoDsA
         Fhhw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773132910; x=1773737710; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=57HCSNZqdX/pE4pNruhHCDIUKjmgpBGDki8+akqS8UU=;
        b=Na+svgUq44IuBfIMo7Klc0RYjv/TsrLaKTwoey9HZ0bXK0wo8C00IFs3Jv1+ms5dUl
         p/DxQp3wfeVNluCcoAGu/2FXSmUm/2wMM+kB6H3jBWhMue0QQ+mw+JOHsqUP8RDahWNg
         d1FV6Pzd3gC8T6rvTQbp3BtxxlinrVXfspaik3PpSNVS8dVuJI+d2dkPIRRMq71r0reR
         D17ZozN5YC22WBM94XO85aaydhrSSAvotl3mRbTHdAxspt28345+x9xEIRCMXUs9CRUv
         6T/AgUH90TpT1ktJphoZEbnR5EqPORJVZTozklqgPWOMa9Q+rotpTUnE5HlycLQJ7aaB
         wpRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773132910; x=1773737710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=57HCSNZqdX/pE4pNruhHCDIUKjmgpBGDki8+akqS8UU=;
        b=EjhSsKO1iaA4oXBJWTWwNcw3k4qVd4g9mGx+kHgttXXxoPV9PPZjROZbuzfSjbx/bM
         Y+7MlbJDxx+DVLmuK9RWSKvNS/nX/DCQ+2ndeRxexh2u32hb74ArcwUF9W4sW/L9y8VI
         4YdK7jxxVSt2wMg2qY2dfJ2W7xuoJ3VfgrNOFwbG5Pq8PJHPUfI02N1VQHoCzrKA/UIP
         BNoUo5Pmr7D5cHKmwQy0Ns35X8Xw8TrW3VbmQIOZYjXt5cuI+uH3chORQEzdEDf0XFbi
         tH8XnQr5cm3hJjFu201YrAC1Rf2j6++GAoaAorgL0W9nFv2Cc1eJDi3cbLE5p9Zjcv9A
         b0MQ==
X-Forwarded-Encrypted: i=1; AJvYcCXa1k8go+cAa/46u0zZDi+2ZmzalxFY9yv/vQf85owNmtMOMxcEVTCx4OCZ4gfziWKE8UXisi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpoVt/8CHu4FsIr6TigJKwUksdKIbPmuJd3lrX4gzqlznhup77
	gJcvHUGfi7cBFxb3N+wVvpkH/idepzPZ55gC9pD9GGEOFGf2kpdMrfJ4RcOoIZn4C+HfrNr9rlh
	068JPjvKeZl18WKkHuecgQ3T0j01XMEHHExzYureT
X-Gm-Gg: ATEYQzyVfBnnRHhEuLkNuz7Y44qqtM7FAsWwaOBrJh/dUiPYoGPDlU2Yc96RAKdGyz6
	2kCxQAzmXjvTaeeDRiTrbnzHb68Yk0Elwm3QY2ET2IKGs2UsMpTBwG0219Efwvk75s34BVI2rTp
	77Eop28rzK0EsrBk/XtfMU8VNQplQd/UB2tOYm0ttxqyHeC4Q5Nb6fZ+WFg5VCs6V1R1Xuue5/P
	qkN6iEXp5uXB9gpFkM/DRgJX1VGmebWvJdSrsDwINyygOyjPsiNoB3EFCeY7KiUq5ljAmKgONlh
	ghWghAc=
X-Received: by 2002:a05:622a:283:b0:509:272b:b3ef with SMTP id
 d75a77b69052e-509272bb73bmr26369351cf.35.1773132909710; Tue, 10 Mar 2026
 01:55:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309-tcp_rfc7323_retract_wnd_rfc-v3-0-4c7f96b1ec69@gmail.com> <20260309-tcp_rfc7323_retract_wnd_rfc-v3-6-4c7f96b1ec69@gmail.com>
In-Reply-To: <20260309-tcp_rfc7323_retract_wnd_rfc-v3-6-4c7f96b1ec69@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 10 Mar 2026 09:54:58 +0100
X-Gm-Features: AaiRm52hpqwFLhiGxunf2HDckqwt_QrtXyTul6g4VBswXcYgEk1a2sH7NGzoxSg
Message-ID: <CANn89i+PypF1cK4mnp8L_eCG_z+3Aj6uxJoohm_=DwGfR1=4FA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 6/6] selftests/net: packetdrill: add tcp_rcv_neg_window.pkt
To: gmbnomis@gmail.com
Cc: Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, David Ahern <dsahern@kernel.org>, 
	Jon Maloy <jmaloy@redhat.com>, Jason Xing <kerneljasonxing@gmail.com>, mfreemon@cloudflare.com, 
	Shuah Khan <shuah@kernel.org>, Stefano Brivio <sbrivio@redhat.com>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 9:03=E2=80=AFAM Simon Baatz via B4 Relay
<devnull+gmbnomis.gmail.com@kernel.org> wrote:
>
> From: Simon Baatz <gmbnomis@gmail.com>
>
> The test ensures we correctly apply the maximum advertised window limit
> when rcv_nxt advances past rcv_mwnd_seq, so that the "usable window"
> is properly clamped to zero rather than becoming negative.
>
> Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
> ---
>  .../net/packetdrill/tcp_rcv_neg_window.pkt         | 26 ++++++++++++++++=
++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/tools/testing/selftests/net/packetdrill/tcp_rcv_neg_window.p=
kt b/tools/testing/selftests/net/packetdrill/tcp_rcv_neg_window.pkt
> new file mode 100644
> index 0000000000000000000000000000000000000000..15a9b4938f16d175ac54f3fd1=
92ed2b59b0a4399
> --- /dev/null
> +++ b/tools/testing/selftests/net/packetdrill/tcp_rcv_neg_window.pkt
> @@ -0,0 +1,26 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +--mss=3D1000
> +
> +`./defaults.sh`
> +
> +// Establish a connection.
> +   +0 socket(..., SOCK_STREAM, IPPROTO_TCP) =3D 3
> +   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) =3D 0
> +   +0 setsockopt(3, SOL_SOCKET, SO_RCVBUF, [20000], 4) =3D 0
> +   +0 bind(3, ..., ...) =3D 0
> +   +0 listen(3, 1) =3D 0
> +
> +   +0 < S 0:0(0) win 32792 <mss 1000,nop,wscale 7>
> +   +0 > S. 0:0(0) ack 1 win 18980 <mss 1460,nop,wscale 0>
> +  +.1 < . 1:1(0) ack 1 win 257
> +
> +   +0 accept(3, ..., ...) =3D 4
> +
> +// A too big packet is accepted if the receive queue is empty
> +   +0 < P. 1:20001(20000) ack 1 win 257

We do not see the answer, it seems this test is not complete ?

> +// Send a RST immediately so that there is no rcv_wup/rcv_mwnd_seq updat=
e yet
> +   +0 < R. 20001:20001(0) ack 1 win 257
> +
> +  +.1 %{ assert tcpi_state =3D=3D TCP_CLOSE, tcpi_state }%
> +
>
> --
> 2.53.0
>
>
