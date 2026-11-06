Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793990076;
	b=A93srDPTCbK0Uld/RSHW7/EzBvD4SfSM8HFKU/C05xsPOA8ou56qMXdOCf+Na/GMdutR
	 XY5iw2enR4Yet8rz1J5M/KBvr3hDCUSNwt/tuf7TMhXlRc5CGMGG9cgcYwAeH9gz/jyKO
	 V4qKN7rvnY7hR0hr7NKl9YxhklY7hxyubRKmT88j9822TlwTtrS8C7Qb7zjwqqXedgy8q
	 YxjWtsSNaoOJ46xYi39QlBZiE8ICLR3auQFB6nSIZizZXhlt06ZYA5njwWmCywL9Zu476
	 PtkhW5IfAh+8e74yHJ1A3aGeqUba8kFGm1iK4N5pL4md93eocYhUlJT4knxpNOjXK9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793990076;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=+c0xWdkkcKoTE4Rdj27Yc3MLhE6rmfRXOfJT2CGVuAQ=;
	b=iEC0cfJHj5DqEieEtEKxbw2lMx5oJDJL3up5whRaLV1tPoEiDfMzXwPwX2psryuUd18i
	 R8QlQ8PK7uH4nb+HVpiS5APkbqW4oq5WQJUQ8kA+TCBmsi7jFhOD9prJS/F4DUufLxANg
	 9ieJki6zrLrGavWj9+jz71fluKx63mVfMrDHzcgKkPKy8wUBMwSwMAK4pc+gc1QXkyBPj
	 FLFpJuVd2EUYYAhZTR0BZOmMRYA/33+S48Fx52acBPzo7IiJ4swlvPsPngDAEmNZ9tvCA
	 /7UtJH8vNKubU51zdyn+JoO+Eex7YIWj/AmKdP60sGmmJ8nFlbFFNqYZEv5kl3508Hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=azEJaddf;
	arc=none smtp.remote-ip=209.85.219.44
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95BA606A332
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 18:34:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D95BA606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=azEJaddf
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-91c847584b8so10193656d6.0
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 10:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793990075; x=1794594875; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+c0xWdkkcKoTE4Rdj27Yc3MLhE6rmfRXOfJT2CGVuAQ=;
        b=azEJaddfPLszRG2YEd8X8XX3QNSmADkhMqqQkz8WJCqDHCX/yElegKK2JUmNUFCVFn
         1m9uk2k/p4dq4w3fJAA/u/LJ3eU7HusdduRCkLAdoeLqlRTmain3Uqa0I68B02+FRZjN
         iz+KKvNA8NWhZE+WAdsdD77VmTCugNNKnPrerZfcB2h7EcelHiX5fEb4Rx1oJuYFUAkl
         nqZXZGuHeNLKXtxcXQ2MZVRcRDisv+8FiLqCpkzml5h6bYhW6O6CeuCKbMBPGtv4XmJK
         Bp4PO2afCpZFU6DuKRKSo4n/5AT3FCs/rRv0Vms0kdAB3NGupdnhqglYZoGMUaE+OrJ4
         yZog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793990075; x=1794594875;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+c0xWdkkcKoTE4Rdj27Yc3MLhE6rmfRXOfJT2CGVuAQ=;
        b=XRy5Bfjn3spxxl9dVPHGYzKLihT0gHrkiYhrgSJbuJH5ndWob5qxvs4zyGXNP5uJb0
         Y2iLVh4Mn17iCQRmTogjtOBYgRXl+m7lRH2XstEKFXIPNJjM1RsTqaKloe7HsnWbTJQr
         bEk71M0r0FNHu2xbm+xwKw4VMNIdfqMWKA/XjGX4JO6vSMTGXpbcH8HSFWr7JChIU8/K
         vOzS4EBs2LQqCY/eK6z/pNplYU/AvLhLGqiOTd0pInxJ9cVydlBCqPqTyOSckXFjmF7s
         GMIJL9J54uFpnMttHH7qNQci7qMS4D4NnzqNpJysYUSobvdH5excQi+jJvDOp89U5izx
         lRQw==
X-Forwarded-Encrypted: i=1; AL+hErHfPCcH+xi/awrr8HSMN5x+1hb+2uqprg0s31eZNZp2WlT3bPDhxabYn1hczauxaoYxql1lToc=@vger.kernel.org
X-Gm-Message-State: APuU4Z81jMo3rLnDwiy7fzoYJYiuaItW6Y28RWpbJN6DT5OSRpl83NlV
	2Dj5dQkqaVyi4p/JRFshqNkxUSjb7gz3cB+0XG48tNPnv7dloRefewOq
X-Gm-Gg: AYBFou2zrOsgsgT1wsSfyxuxXfkR75GKK0459YRt0o5Lf1NtaOjK6bTr9KJ2LMwPke8
	qXZ5SmizO+xF5adQrTWfv5ifR183v0Mo/FpDHBNN+pVsO9hg8fHKDZdZPg9draa+05rf8QA0Ypk
	HCyFgMH/37eQMpHbhA/2BnxTgEsx+BbQNql07Qql+9IgjKuwnveKdL6v0bdiTg652ndCLf8eLny
	S0qpjGauBWEXUnZOQeepdI8XyK0Mz0N9JS+WrAi1ebMMomBYcRR0sHUpH4K6LUU7lV8JGKiIyJs
	owPbh7la2ycyL1opRXE08UKD2/+zvEgU38sOdpv8sMVtR0duvncQz28VeG4EZL3S9Eec+hQxy33
	R1lFP6xh83IMzNHMWYSsRX3KHvBHE6sdgItfg1Njxd6+iALY3Phou/XPmdERLaPLgH7BLRjFdCh
	jcieiiZhPPfzDYluM6dHsBcqIBmWBO+wNWd8MGCTeOs4YUHI9ZXGMjJFekGpnuL11vlU/JL32yE
	2CBhRJ8a27nmuzGqXrv/mN3naGgLRSPO0b7QEb3gsWp+LKLxJ5xoiYZGaMPgRkZnm087XhwaEl+
	mj53tuwJyXFERcoGeA==
X-Received: by 2002:ad4:4ee7:0:b0:91b:bcf5:a733 with SMTP id 6a1803df08f44-91ea9304f4amr50544826d6.2.1793990074822;
        Fri, 06 Nov 2026 10:34:34 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::5:81c8])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ea6900b00sm26542996d6.4.2026.11.06.10.34.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 10:34:34 -0800 (PST)
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
Date: Fri, 06 Nov 2026 13:34:33 -0500
Message-Id: <DMOCEM7IQVOS.I2QH7FT8FT8S@gmail.com>
Cc: "Simon Horman" <horms@kernel.org>, "Jakub Sitnicki"
 <jakub@cloudflare.com>, "Daniel Zahka" <daniel.zahka@gmail.com>, "Willem de
 Bruijn" <willemb@google.com>, <netdev@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>
Subject: Re: [PATCH net v3 2/2] selftests/net: psp: test bidirectional data
 transfer
From: "Daniel Zahka" <daniel.zahka@gmail.com>
To: "Wei Wang" <weiwan@google.com>, "David S . Miller"
 <davem@davemloft.net>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni"
 <pabeni@redhat.com>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "Shuah Khan"
 <shuah@kernel.org>
X-Mailer: aerc 0.21.0-threadmapfix
References: <20261106182007.374660-1-weiwan@google.com>
 <20261106182007.374660-3-weiwan@google.com>
In-Reply-To: <20261106182007.374660-3-weiwan@google.com>

On Fri Nov 6, 2026 at 1:20 PM EST, Wei Wang wrote:
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

Reviewed-by: Daniel Zahka <daniel.zahka@gmail.com>

> ---
>  tools/testing/selftests/drivers/net/psp.py | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/tools/testing/selftests/drivers/net/psp.py b/tools/testing/s=
elftests/drivers/net/psp.py
> index 473500901879..c114d2245135 100755
> --- a/tools/testing/selftests/drivers/net/psp.py
> +++ b/tools/testing/selftests/drivers/net/psp.py
> @@ -120,6 +120,26 @@ def _check_data_rx(cfg, exp_len):
>      ksft_eq(read_len, exp_len)
> =20
> =20
> +def _recv_careful(s, target, timeout=3D2):
> +    """Read exactly target bytes, tolerating short reads"""
> +    data =3D b''
> +    end =3D time.monotonic() + timeout
> +    while time.monotonic() < end:
> +        try:
> +            data +=3D s.recv(target - len(data), socket.MSG_DONTWAIT)
> +            if len(data) =3D=3D target:
> +                return data
> +        except BlockingIOError:
> +            time.sleep(0.001)
> +    raise KsftFailEx(f"short read, got {len(data)} of {target} bytes")
> +
> +
> +def _req_echo(cfg, s):
> +    """Ask the peer to echo, and check the reply arrives intact"""
> +    _send_with_ack(cfg, b'data echo\0')
> +    ksft_eq(_recv_careful(s, 5), b'echo\0')
> +
> +
>  def _check_data_outq(s, exp_len, force_wait=3DFalse):
>      outq =3D 0
>      for _ in range(10):
> @@ -478,6 +498,7 @@ def _data_basic_send(cfg, version, ipver):
> =20
>      data_len =3D _send_careful(cfg, s, 100)
>      _check_data_rx(cfg, data_len)
> +    _req_echo(cfg, s)
>      _close_psp_conn(cfg, s)
> =20
> =20
> @@ -726,6 +747,7 @@ def _data_basic_send_netkit_psp_assoc(cfg, version, i=
pver):
> =20
>          data_len =3D _send_careful(cfg, sock, 100)
>          _check_data_rx(cfg, data_len)
> +        _req_echo(cfg, sock)
>          _close_psp_conn(cfg, sock)
> =20
> =20

