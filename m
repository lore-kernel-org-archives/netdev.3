Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793827613;
	b=0B8EKrwP7nDtPHJWAsJGFwqoMZFv/oVt/cGBXCAh8By9xnS+eBHOdGd/L3f88OMlsvhA
	 59LXi92BLmC2cSNuTXdYOHEAWka926AeZ+Ywim90k7dJtTMJdUPqCLkohTX2vEPJuOqcd
	 xVzrfAeZrqxsWrM8c6ctLKDeoVsmSu8Cgs7Cm/5SV6qSdGFqGQuhv39SuBUaT6akkQteD
	 J6Lh0fjXEJRAxxTO3LBrWBzIUeUBQICk0KSpCISn6RH4GULp2avXDbNMRVCli3UhfJXXH
	 BmiIH41lqhBlnevAZTSrUx5HAL6o0cS0cHSLGXwZPdR8Cnkx6KXWJjCZZOhog4vuN6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793827613;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=Fx8mwjCrbZCWbiZSWWBXN0aiI/C9oFeig/QmjdPJVek=;
	b=FNOKnGDHgiCsSJvzvnSpMiojm6jwp9fKro1zS57m3O3I/BrbLNF4yBnJaU/2iMvEjoxZ
	 bW0EsywWjaPkwsM57OPxjC+qOdpw4auEcmzqSZo2xUJxUhLrVZg4U5lLFnXwiryJ1msIT
	 d1Q8HBPd2U1mKHKC3j0mPg8o9iLupaWDtcLQBI7nIDjcF5UeTRBj9pGm+zksm9tXyKdTQ
	 kmjKTYvY1XvxUwCSMEIHOz5+ECVTWTTGjvNosyr+PAkHBP3z97qpCVD2J/1dnWAeaMPMG
	 ynoAiok7d8wTR/8iv7f2C3ewvI2MK2vM7fCfO7iv0cLaXmc3QulIzs9jPewJLDYUDPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Vy+SWiVb;
	arc=none smtp.remote-ip=209.85.160.170
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB8A606B2DE
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 21:26:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FB8A606B2DE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Vy+SWiVb
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-53cd0c8614eso7737401cf.0
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 13:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793827612; x=1794432412; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Fx8mwjCrbZCWbiZSWWBXN0aiI/C9oFeig/QmjdPJVek=;
        b=Vy+SWiVb/NpXstpdw56lw+criQ5VLmL5fI7nn0T68KlPT3t+Dt/ZXXIrVA+Cb9oTH4
         TPCa6A3seRH9NuwzLYB4U8f/OShYV6IlQIso/owGoN/zGKf8RjT/HHAYQiFq6Md9/AGx
         OQu+WfEphT/kKjXP8GvKBBFJyiAVMrQefdiWdJmUUcdvKTLoDsWtPAZotnQX9UJOrzaQ
         xRONIbMdbEwkr1WI3Kg4PeBEsFZ5Y37wda519hWTRbTA9zS4VszXsqzBXwuK7HvvH0Qa
         FvCJLDSn4KAlIWnCl9a6eAaYBJKX17NVHsnq7L+bnHg+v812XRAWefqQg5U2r0LgvExP
         /fLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793827612; x=1794432412;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fx8mwjCrbZCWbiZSWWBXN0aiI/C9oFeig/QmjdPJVek=;
        b=KrhoVu3M2ixsK35Wpx690BB0EYFsI1zMZFHFDV1w2a80U4Xxe0aFQjnJgua0CItO9a
         z5lh+amCf4q2xD+gDUxFx7hJR1lScUCKp7FnfbEJ08zSk62W7iJ/9Da9dzGwgXMaMbqq
         mc+Bf97aORrv5lVJ9EkKBxnr31pf9ianD5EaykZj9ukRBtR2JTryDHiIUypq71rTvBzP
         C44o9PU/G8bsU1hGn6GvFVr923h2xN9JE6aBXcPcCsVcPMPcIWlOC614bflyfdMMgHQz
         qQj/h2I77gGMtwtJO1YJnVYrUg4tf7hs/dlXQvWGNnNwy8FRGHagysyh/yn2PcONjr2Z
         KOQw==
X-Forwarded-Encrypted: i=1; AKwUvBzDRcSeuO2ByDdyzk68HiS0/jGzFSBqAtkqH8/mfNyK3GpQiHiw9l+q2ZcoYbBprJBWJ6bW8w8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9cu/x3EV8JSq0RAO9j+Ou66ZC/ZXgDVDwihpnT16yInNXcsZbO
	v6UcG2Q+jdwgazL8B1fh1XImrIYWv85KO9CDLoq0Igj0BREvifLLjJX4
X-Gm-Gg: AYBFou2bphzgng+wp5te5MjdMZotsZIB/8i+sgGp3hS4OGLbdL5S3jokuLSKtqa3QZl
	Mjykl3jWKn6u9XP6jsD68MCFCPSt+BUpXmAYIw8L5Smsg8tZPZ+Zw/dsUTdo8uwwzDxfIuFENnx
	oYtwlb+0wC0kouPyPZjpokFmrw2/xV8fu1DlLWVLWhxpTA69kFX5BqR48iPx1GcX7ZAmokbVb4H
	DHeZJZV6KrbQCUUOLopfaCIjH1u5fCmYZ1eWNxWGqg9OIk0LrGGUO1AMNfFbHViMYX95tRBxCyx
	g0knonK85qiYFPpsoYmtFXyFPgXRH+SBZSlaNW4x6Sht7uCIQkIJY8XB51Yq90G+4QwSpf+rD/v
	sn5BBpLzDmbk1aBmJrx4PC+masHL8VjhpMVlRvBeorckygK2t8hiKOP1DPr9KGlBWksU8cJD7Ww
	kp3spxFcrqJmJnNzcb1Ky1rqQzZXthl1SIUsx0FPgCWOo6SzEYKWCLbmdSZ7jIhUWv7QAGLqD7x
	vBrhOUIJd2N8f/dgZ4xGpsOM2lrqY3hEAZ78WGAYVdqm3/+wcL6UWJy/w3I9CFxHNf/mKhhEZFk
	ibyQUNvKmtc4YyJX
X-Received: by 2002:a05:622a:2510:b0:533:8bf0:e6 with SMTP id d75a77b69052e-542b6a703c1mr284677281cf.35.1793827611998;
        Wed, 04 Nov 2026 13:26:51 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::4:a8c5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54b10c4dcddsm34508841cf.20.2026.11.04.13.26.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 13:26:51 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Nov 2026 16:26:50 -0500
Message-Id: <DMMQTFS3ULM2.3HSJGB1UT085M@gmail.com>
Cc: "Simon Horman" <horms@kernel.org>, "Jakub Sitnicki"
 <jakub@cloudflare.com>, "Daniel Zahka" <daniel.zahka@gmail.com>, "Willem de
 Bruijn" <willemb@google.com>, <netdev@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>
Subject: Re: [PATCH net v2 2/2] selftests/net: psp: test bidirectional data
 transfer
From: "Daniel Zahka" <daniel.zahka@gmail.com>
To: "Wei Wang" <weiwan@google.com>, "David S . Miller"
 <davem@davemloft.net>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni"
 <pabeni@redhat.com>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "Shuah Khan"
 <shuah@kernel.org>
X-Mailer: aerc 0.21.0-threadmapfix
References: <20261030043145.2185700-1-weiwan@google.com>
 <20261030043145.2185700-3-weiwan@google.com>
In-Reply-To: <20261030043145.2185700-3-weiwan@google.com>

On Fri Oct 30, 2026 at 12:31 AM EDT, Wei Wang wrote:
> _data_basic_send() and _data_basic_send_netkit_psp_assoc() currently
> only verify unidirectional data transmission from the test socket to
> psp_responder. As a result, they do not exercise the receive path for
> PSP-encrypted TCP data segments arriving at the test socket (such as
> packets redirected across a netkit interface associated via dev-assoc,
> which relies on SKB_EXT_PSP surviving packet scrubbing).
>
> Use the existing "data echo" command in psp_responder to verify that the
> test socket can also receive PSP-encrypted data from the peer in both
> _data_basic_send() and _data_basic_send_netkit_psp_assoc().
>
> Signed-off-by: Wei Wang <weiwan@google.com>
> ---
>  tools/testing/selftests/drivers/net/psp.py | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/tools/testing/selftests/drivers/net/psp.py b/tools/testing/s=
elftests/drivers/net/psp.py
> index 473500901879..e507951b440b 100755
> --- a/tools/testing/selftests/drivers/net/psp.py
> +++ b/tools/testing/selftests/drivers/net/psp.py
> @@ -120,6 +120,12 @@ def _check_data_rx(cfg, exp_len):
>      ksft_eq(read_len, exp_len)
> =20
> =20
> +def _check_data_echo(cfg, s):
> +    _send_with_ack(cfg, b'data echo\0')
> +    s.settimeout(1.0)

I'm not a huge fan of setting the blocking timeout here. If we are going
to set a timeout it should be when the socket is created. Otherwise this
function has an unexpected side-effect. Another option is to use non
blocking reads with timeout like:

def _recv_careful(s, target, timeout=3D2):
    """Read exactly target bytes, tolerating short reads"""
    data =3D b''
    end =3D time.monotonic() + timeout
    while time.monotonic() < end:
        try:
            data +=3D s.recv(target - len(data), socket.MSG_DONTWAIT)
            if len(data) =3D=3D target:
                return data
        except BlockingIOError:
            time.sleep(0.001)
    raise KsftFailEx(f"short read, got {len(data)} of {target} bytes")


def _req_echo(cfg, s):
    """Ask the peer to echo, and check the reply arrives intact"""
    _send_with_ack(cfg, b'data echo\0')
    ksft_eq(_recv_careful(s, 5), b'echo\0')

> +    ksft_eq(s.recv(5), b'echo\0')
> +
> +
>  def _check_data_outq(s, exp_len, force_wait=3DFalse):
>      outq =3D 0
>      for _ in range(10):
> @@ -478,6 +484,7 @@ def _data_basic_send(cfg, version, ipver):
> =20
>      data_len =3D _send_careful(cfg, s, 100)
>      _check_data_rx(cfg, data_len)
> +    _check_data_echo(cfg, s)
>      _close_psp_conn(cfg, s)
> =20
> =20
> @@ -726,6 +733,7 @@ def _data_basic_send_netkit_psp_assoc(cfg, version, i=
pver):
> =20
>          data_len =3D _send_careful(cfg, sock, 100)
>          _check_data_rx(cfg, data_len)
> +        _check_data_echo(cfg, sock)
>          _close_psp_conn(cfg, sock)
> =20
> =20

I'm ok with the approach overall. The coverage is sufficient for the
purposes of the series.
