Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0C5443AA7
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 15:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787759586; cv=pass; b=KowvyNrrNAZpWNR/3YH1QcnllFZOZvRO48zDdXhnfstDMdX9uPUD8BOunYNcW4OVoykwPy7oiKB0UxaCClBwLtWzTSpfDqEGIsfkdaX/mk/qdQ+wVf9X0jcQRiwWkVpscS3NjCf7lCh4olBsDgAnxc/BcRwjVOPKU70+E9QRhA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787759586; c=relaxed/simple;
	bh=nhzcmQbfSdSCC3/voOcltTc6ecAvxBkF++UsUwC1yIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EOwKoLAiw429F8/fSMCRVuLporWE0om5UqZ3qdO0pShEQd+KNKN+pJcZ0ZFvoDtSH/9mmkTOzinHnBUwHTLK3NH0hlOJQgdq5k+57CVpwOqq/9Pcc14lJ1sDwTxH6VOiKYkmCsBbZMBJLUULSK7EOYvXPWBS85QHoWlCZ7xaqXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wkXFL+8j; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wkXFL+8j"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5218927884fso11318041cf.3
        for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 08:53:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787759583; cv=none;
        d=google.com; s=arc-20260327;
        b=JTNEPFRzYsx7XGZwTY1AYpmIUFqCnsN4b5tV8E5//NZIRzCFZc91on7AWYWlL6J9JT
         nYP8/D88adcR5YhTWb0NId4NmGedNt26L4+25lALvnPUq/z6yiebk0eIWBy0ky9GfT8e
         X9eUKLX3jLbA5Xmsy4r5mgnHccezCeymjpVDa8hcugPnleM+owjAhzfg1/dOyLTAa9vj
         79RvgXXp2FiZ14ZmnQq5A/pyhP5v6BB076Wi/O8vaU6YF3iyOqIENjnQ3px06EawV44z
         rMICHtyN74zSIN1ghy60wFglWdtWw/3UNFrOHrK/NegIDD3zhco/UDTnbgEgjxS0W7xh
         6lww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/A1U78CmUVxnpdrZlvgInM8HciZ9zbDyKtBI4yHBqq8=;
        fh=thUfcEwzc9XSLXaq/DZZh2Zm+o1U8RGXvmsIYtbOlyI=;
        b=d7Clz7T4CmPgSUOD5WlVzsfEcf3hF1pjxOK10GKw/WG4r2c6IoX6amabirKIljBzbv
         SNlfYJ/NuNrMV/iX8WP4YaIoH5NwZNxWlo9NvHQgPLApxHEK/Yjn/HifFF1cFcE6TswG
         eXhakLQeJPzz6UezR2WjEdd4F5jrNBR1qrVNvbc7feCWC2r7JjkZCnVEPpOdkD9Cnhm8
         DS+A0oOFgj6ddYpx/gnxsOa2EhyhtBBdiGfHTmt0+XRtsciQ8VMBHshtLYgUzEsllX9y
         sKMPl3rd98VyZEuF9KUl5I9l6CmoZGhMsCGA6abJqU4C3IxUmaot3cKBuyc2/If8lDu7
         giVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787759583; x=1788364383; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/A1U78CmUVxnpdrZlvgInM8HciZ9zbDyKtBI4yHBqq8=;
        b=wkXFL+8jVVLQMfdobSGanytS1RBg4CdFQzvlALUAfrMJi/BOtQyuc0szzf78+vW+4p
         /HECmtwNvfcYXTEMByQQD014I91DwSHoa6CLwODjWUNoH7Fa+E2bDZNYOSU//wC9gVTU
         65EhvxE3JOxdc4DvGCP1VLMpjcFkPBtKxzKxFt8Tr4/Q3sFPiZZCUTrXGL/iwPiN8HWn
         Mq8QAUuwEiHGbesY0Nyk7iGsAP3o4Kq6D4AxG36f94U6Ssm4Np1y6KSNs99HhGFsposO
         8GXPxD9R1uBQhGaI6L+PFGm/V3ZfcVLAiOBgbnDuWOz8EU4gslKDxOsRRLeWcWMXdS4i
         vmLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787759583; x=1788364383;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/A1U78CmUVxnpdrZlvgInM8HciZ9zbDyKtBI4yHBqq8=;
        b=FdC7sWMPqfGw7n8H169+XxxttZa6jvcs7VIDTfzj3SII1rJ5JElbf5FehOAr9zo1xI
         TAxd8GN6nqZLatVBvaCOsB4f1i/MgRl2/ZbkP+P216i+FY/6b9Klx/XAalD6JUdn7CxY
         cAdqUPuOKUEB3I0CRIlO1yM37iroCXydgm6fRuC19y1UizTlF9dxPGDJJXtf6J2YfVMt
         8Pkmhgum2YTLGhLhO0Sey8iwEKY4LEmjtJMvPvpr2MlcwhQ9SBcw09852bkJPSIVzHJg
         lJnUp+Y9fv1l5+tuYUfm0lL/M/kpkLCjPf73J2dIrIkzc0pQzFjkOStQpLhvyfxKFbFh
         ftTA==
X-Gm-Message-State: AFuF++kGF/lFdEF2xpohKYlpbR85yY8pR0dG4WLNOJtlfXYCsFtPEnpS
	Gro1D/LljsvjuoJj87iEAvo6J9nl6bziGuwoRbM2lS2Wmkl4dVB/CrK8qmDLfciHVRDGn5YsbKQ
	JwmSOAjfVEAuvnBfArbFDqM9Le9PowUtW++ie4CAcxW+G5RYg4V2Yzdosm6k=
X-Gm-Gg: AR+sD131xaR6MBoWa3X9SZlMpENN8iP0g0ymnRXjZSOwjNASi4HecYgNPDJz3HB0Ekh
	9kALw/UqSSdEVWqotnLGzU3c6XrJmfcLpor2N6Hrqn2IfGEZgB8XtWXBOplAlZvfrRf1WYNLgAg
	+jP3YACz4C1IDxZjUguzGzyF1worpXX5PTDQEe4QEPwlnvbMXpOOqGZm8cZDTknkfda4q+AN8Fm
	wnUxMTGO8vIGPQBn2t3UlUY4NpItLH7CSXZ4l5eCiGA6WtT5Qs9kjL0qscnLRRwaVIsTvUtyibE
	o/B9XE//FSP8ETeZx/g8fqvJZ/yord3lEO884U71nmlqQ8RJ5EhV0yd45fZ/+tfYX7zRdBvvICt
	NHnWcyI+8Bt2wct1obX6eVJnHswb84V5y6TMcAO3/6Xeadz6QVPFlxXEdWn0=
X-Received: by 2002:a05:622a:a905:b0:52f:9e5c:3402 with SMTP id
 d75a77b69052e-52f9e5c3d24mr21245771cf.23.1787759582224; Wed, 26 Aug 2026
 08:53:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826141145.67823-1-jiayuan.chen@linux.dev> <20260826141145.67823-2-jiayuan.chen@linux.dev>
In-Reply-To: <20260826141145.67823-2-jiayuan.chen@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 26 Aug 2026 17:52:51 +0200
X-Gm-Features: AcwNN1Udvbdfj1DbWjOiCAJ8x73rQxJ0GSWWRifRu8ry20zOWq2VrfeuYmkOmP4
Message-ID: <CANn89iLAZMNspMM_cf+Y6-JVY5gO3sB98sjWQx-BLQhGWySE7g@mail.gmail.com>
Subject: Re: [PATCH net 2/2] selftests/net: packetdrill: add tcp_urg_ptr_retransmit
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Yuchung Cheng <ycheng@google.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 4:12=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
> Drive a connection into urgent mode and force a multi-segment retransmit,
> checking that each retransmitted segment keeps its own urg_ptr.
>
> The test asserts the fixed behaviour: the hole is retransmitted as two
> independent skbs, each with its own urg_ptr (5001 and 4001) and no PSH.
> An unpatched kernel instead sends one super-skb whose GSO split copies
> urg_ptr onto the second segment and also sets PSH there, so on an unpatch=
ed
> kernel the mismatch shows up on the PSH bit (actual P.U ... urg 5001) bef=
ore
> the urg_ptr:
>
>         tcp_urg_ptr_retransmit.pkt:63: live packet field tcp_psh:
>                 expected: 0 (0x0) vs actual: 1 (0x1)
>         script packet:  .U 1001:2001(1000) ack 1
>         actual packet:  P.U 1001:2001(1000) ack 1 win 1050
>
> After the fix the retransmit carries a per-segment urg_ptr and the test
> passes.
>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  .../packetdrill/tcp_urg_ptr_retransmit.pkt    | 65 +++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 tools/testing/selftests/net/packetdrill/tcp_urg_ptr_r=
etransmit.pkt
>
> diff --git a/tools/testing/selftests/net/packetdrill/tcp_urg_ptr_retransm=
it.pkt b/tools/testing/selftests/net/packetdrill/tcp_urg_ptr_retransmit.pkt
> new file mode 100644
> index 000000000000..22f750ce09c1
> --- /dev/null
> +++ b/tools/testing/selftests/net/packetdrill/tcp_urg_ptr_retransmit.pkt
> @@ -0,0 +1,65 @@
> +// SPDX-License-Identifier: GPL-2.0
> +--ip_version=3Dipv4
> +//
> +// Reproduce urg_ptr being copied across segments on a multi-segment ret=
ransmit
> +// in urgent mode (regression since 10d3be569243).
> +//
> +//   server (kernel, under test)                 client (packetdrill)
> +//     |  write(5000): 1:1001 .. 4001:5001            |     mss 1000 fro=
m
> +//     | -------------------------------------------> |     the client S=
YN
> +//     |  send(MSG_OOB): 5001:5002 urg 1              |     snd_up =3D 5=
002
> +//     | -------------------------------------------> |
> +//     |            SACK 2001:5002, leaving hole 1:2001|
> +//     | <------------------------------------------- |
> +//     |  retransmit hole 1:2001 as ONE skb:          |
> +//     |    seq=3D1, 2 segments, urg_ptr =3D 5002-1 =3D 5001|
> +//     |  tun tso off -> software GSO splits it:      |
> +//     |    seg A  1:1001    urg_ptr 5001  (correct)  |
> +//     |    seg B  1001:2001 urg_ptr ?                |
> +//     |        want 5002-1001 =3D 4001                 |
> +//     |        bug  inherits 5001  <- caught here    |
> +//     | -------------------------------------------> |
> +//
> +
> +`./defaults.sh`
> +
> +    0 socket(..., SOCK_STREAM, IPPROTO_TCP) =3D 3
> +   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) =3D 0
> +   +0 bind(3, ..., ...) =3D 0
> +   +0 listen(3, 1) =3D 0
> +
> +// 1. client force mss=3D1000
> +  +.1 < S 0:0(0) win 32792 <mss 1000,sackOK,nop,nop,nop,wscale 7>
> +   +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
> +  +.1 < . 1:1(0) ack 1 win 320
> +   +0 accept(3, ..., ...) =3D 4
> +
> +// 2. server sends 5000 bytes; TSO on, so packetdrill sees whole super-s=
kbs
> +   +0 write(4, ..., 5000) =3D 5000
> +   +0 > P. 1:5001(5000) ack 1
> +
> +// 3. server send OOB
> +   +0 send(4, ..., 1, MSG_OOB) =3D 1
> +   +0 > PU. 5001:5002(1) ack 1 urg 1
> +
> +// We could disable GSO at the start of the script, but then the PSH fla=
g on
> +// the 5 initial server segments is not deterministic and hard to match.=
 Keep
> +// TSO on for the initial send (one super-skb, stable PSH) and disable i=
t only
> +// here, so software GSO splits the retransmit and each segment's urg_pt=
r is
> +// checked on the wire.
> +   +0 `ethtool -K tun0 tso off gso off gro off lro off 2>/dev/null`

nit: I suspect "ethtool -K tun0 tso off" is enough.

Reviewed-by: Eric Dumazet <edumazet@google.com>
