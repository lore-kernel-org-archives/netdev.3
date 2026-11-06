Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793925210;
	b=Ljh6WuJvu4KHSmrcFtlLghj+GXeOQYbJYkAyZN4fAYhQX7J6cSfcCWbQoY9HeQe6Irdt
	 8fJSSlQZ/1riWp0NUqhX2c6sa1BizjwEhh13GiuSf0kwaHzHB4lstkiyNeI21NTJJCI/p
	 8s7OLr2c67af4mCCP88yGEM07NdxIC5oso9CdLvdC1a2MQFvrQwvY3YMntgVJcvfvHVdk
	 kQyPrsyC/q0rzi1pI4yFGlffDqCuIe2DmfvQJibY208+R+3Zljann6VXufdN1172zJgSZ
	 By3oZl2ZKY1rTGLSCJnCzS9j50B+rlDp1H3gphgnj8drDp8RRSjbDQ1xG2LURB/dO1g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793925210;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=SwtNDvLuC8dzEY+y1VuPyC8x8lvTjr4xeYCs0VMxuA0=;
	b=uzUGd89YpejGx3MZzUXm98so2kEtsGzjS51DMYw+2RRmjZc2hsI7M2n6awVpysgpcWx8
	 VlS8eg/Gmwyisld+Yt9ydPEqEERFWIhuve9yq0CLY6qu/udE0Gi5VZC9Ae5WqQeAbYa3B
	 xqokf8bDHUGXET+NdhlMU0aLq/G6xQ/uHwSk+PSgkyrJWv9dlCT1P9XChsuFTOnXxy8cL
	 DiUyFWP6ezbyKfRFdqxHe4Yw09zSViv/fNIO9TqBuPzg77h+SSVJ7uuMg7ZX2rf4iOPdc
	 8UXTVXXi7sPnC66bYSCLckgPxcB+KKxBI1Gk7phZIRf23buekO1VxqhDAkW/VyX0spA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Ywu+sHfE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.174
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA39606A326
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 00:33:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1AA39606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Ywu+sHfE
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-54492d8a988so6741cf.0
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 16:33:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793925208; cv=none;
        d=google.com; s=arc-20260327;
        b=ZBGJHUdm+xC8N0ZTZF7eBIQ/7aYLzBthibxo397cYpUwU5zbO4EiHlB+kSZhzmghlG
         kuaX3CK/XeHTE8p84Ypzgs5Z9YQZ1pEvKgoWbkYcZFFLUnFce884SODn44Omk/5d3jLb
         OzxpHMuzLCTR2LlravdYscMNSHvlt0FBu917xKvdr6EM3C9h8SBdu6Eqykf5mz6Qv+xI
         W3X7oNW+APjbW1uY5jSX+KQZDdfWVnJAU9MFhUENBl/ZFvsS/vG8sq+bZp9kJQHolPkM
         zFovYjf2UdTtUupWCWs8Ak2DJaZ8qEmn0rbVFGYrFX/7TqdUXO9XUMH+CkG2mYT84vHK
         b80Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SwtNDvLuC8dzEY+y1VuPyC8x8lvTjr4xeYCs0VMxuA0=;
        fh=xCJ8XCF5PEPtLZtOavhKHuH0UYKJDAWSgIjpSnLUm28=;
        b=d1JP4Yi5IrnUKLstFb/yejlW2vFhZQY1gIdQrjZhMQBxhIzCqkHcqkt6/tDZ5gay+0
         K1M5jqWW/QILyslYpJn4hLl2StxQ5Z+Ai7ZM/FeT7yFmLhTxNWjaKMs/0/gFeL+0mXAD
         Xwx1CRDE7scj1/w2UccoA+bIDkIL7vtv7WUCwdddMeo6yWbkdA6IjtuPfxJfmM2R1EV/
         Cu/FXOcut8dvGsAbwikSIc+ciC6iuC/OuaVroIgPnHdwRk/X/DWlRB9uydwR+qEhdpUR
         4ltAWKTaM7rBiGI4Ce6xToFlKc5Bfvk7l5gBJX5ox/56fU1cr4zjcxnEwwML4fG3y9SA
         TLMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793925208; x=1794530008; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SwtNDvLuC8dzEY+y1VuPyC8x8lvTjr4xeYCs0VMxuA0=;
        b=Ywu+sHfEQDyswjTmGQokotF0uy7u7pCMR1FBPVPt/uNsbambe0jjQhrWBXTfquzB9N
         GZiNFD1lNrI+2ZdS1Tv/9mkxSh4zUclo/6ejLOo1qkntPK9yqrWWXXyXztvxwgcxo34P
         swCeIhL4ZNgjdIjw4H28L0g4fpaRDpvIgx+zfmvZiie+4msOl8OOKP5KfViJ3jVQpIee
         axQztJfZmKw5NBT3LA1Dzunq0a0wGb6S8okE4abdMKE60zQWa4351nRk4RjQCjKBY/TV
         8iO0zjweZMJabLuprxT9KX6flJRTA9R93M9WhgzMUf3ANqix4ArOKDfhKDBzVT8wAXGr
         9Pow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793925208; x=1794530008;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SwtNDvLuC8dzEY+y1VuPyC8x8lvTjr4xeYCs0VMxuA0=;
        b=GCYZuC/N1KDhXqIO+0jeiHxd3YD1fPRuvV4DMs4EQDij2rsytBHvoX0PKoKBU9LJ7p
         1+Phh9vsp448anTfNlXX+VkDQBVEWF3zXDGwsxJ2HMy48ByvzuN3Qee9ugVypt6Jrvgg
         Wn1suwrROIJVstvfYPuHQkeaKd9muFQAa1UfnfSIoWU/oUF0/AulNCct6Y8BLZ4GLQwD
         PY2MuyZSFGZvWfoiDdH+Fd00Su6ilIMB/CjGN87ahEHyM4NrEUDdRaNNYTSmbWzyepZK
         VX2RlLyRE+PxwxSxUugqAP/XjAGYlJkpWAwHIKOZ98QI0kY7Ws1oNRoH2I7Jg14LgxDX
         U2Xg==
X-Forwarded-Encrypted: i=1; AKwUvBzYPqmo2WrY6akFZYFVEj6s/qCI2YIMFfQumbhA/vc+7YkcV9fAO7BibpXMmjmPtY0bgvN2NuE=@vger.kernel.org
X-Gm-Message-State: APuU4Z8qZcGVdYCkskhaIsRh1y+qURWt5EL44UysS2k4y5TNFiBW7qWw
	m2ZaLf94bOawLGfxa3bxCWMtvQElotQm3bE/i0CvaTjhhzYXFQHgG2uCV2bkQSMAHLXTPbYYIsK
	MK0nCAbrTkzJnjL3sg5lXoYN67f+UGnL2WVC63O7b
X-Gm-Gg: AYBFou2/kbqgfGebJ+r+RHqbKsJJ2Z3bo5fdNEBefyH2bqoUXNyebP5ingNnyZ0U08l
	1ax06ubMykq3ML/9JBJhJkC+Zq0+nUJNAm9G2Nup6eKf3SGNfLSkEyzyOLDMzKxoOwBdm6Z7Pt+
	SE/Scj8hWsL2x1w17R///SedL4UsaRXRmQxfT9CM5H4xeLMQ9aO9bvWM1knHYMEbP670jkPmMGl
	w4qg50CR71cv7qCDUhA5bzrjGF9oF/zTrCRiqDuPhtAeoM3wX+AF+p9OpVlvsCml4SNdcRPSVwC
	HNBZYtQl6CKJQZ8pD0mDoqA0a7hkvq+Mnpf6+GKybKEdwr7jCKGKnQws0qgV9a8gSlColngKfEc
	WjJ6Ypem+hnTW5hCHdJSGPw7wHjgh2LNmXkc=
X-Received: by 2002:a05:622a:4012:b0:542:fc60:fe23 with SMTP id
 d75a77b69052e-54e1aca53b6mr6923411cf.3.1793925207042; Thu, 05 Nov 2026
 16:33:27 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030043145.2185700-1-weiwan@google.com> <20261030043145.2185700-3-weiwan@google.com>
 <DMMQTFS3ULM2.3HSJGB1UT085M@gmail.com>
In-Reply-To: <DMMQTFS3ULM2.3HSJGB1UT085M@gmail.com>
From: Wei Wang <weiwan@google.com>
Date: Thu, 5 Nov 2026 16:33:16 -0800
X-Gm-Features: AclHuK9xp-pEOHgQDu3wgVgSsasOVenE5wfE8_PWHekQkM41Loq5TSIyXBPNcLU
Message-ID: <CAEA6p_DCmSskWz5VUOQTmgcnsFDTKH3mSnOdxOxEJg2CU4k0vA@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] selftests/net: psp: test bidirectional data transfer
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 1:26=E2=80=AFPM Daniel Zahka <daniel.zahka@gmail.com=
> wrote:
>
> On Fri Oct 30, 2026 at 12:31 AM EDT, Wei Wang wrote:
> > _data_basic_send() and _data_basic_send_netkit_psp_assoc() currently
> > only verify unidirectional data transmission from the test socket to
> > psp_responder. As a result, they do not exercise the receive path for
> > PSP-encrypted TCP data segments arriving at the test socket (such as
> > packets redirected across a netkit interface associated via dev-assoc,
> > which relies on SKB_EXT_PSP surviving packet scrubbing).
> >
> > Use the existing "data echo" command in psp_responder to verify that th=
e
> > test socket can also receive PSP-encrypted data from the peer in both
> > _data_basic_send() and _data_basic_send_netkit_psp_assoc().
> >
> > Signed-off-by: Wei Wang <weiwan@google.com>
> > ---
> >  tools/testing/selftests/drivers/net/psp.py | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/tools/testing/selftests/drivers/net/psp.py b/tools/testing=
/selftests/drivers/net/psp.py
> > index 473500901879..e507951b440b 100755
> > --- a/tools/testing/selftests/drivers/net/psp.py
> > +++ b/tools/testing/selftests/drivers/net/psp.py
> > @@ -120,6 +120,12 @@ def _check_data_rx(cfg, exp_len):
> >      ksft_eq(read_len, exp_len)
> >
> >
> > +def _check_data_echo(cfg, s):
> > +    _send_with_ack(cfg, b'data echo\0')
> > +    s.settimeout(1.0)
>
> I'm not a huge fan of setting the blocking timeout here. If we are going
> to set a timeout it should be when the socket is created. Otherwise this
> function has an unexpected side-effect. Another option is to use non
> blocking reads with timeout like:
>

Will switch to non blocking reads in next version.

> def _recv_careful(s, target, timeout=3D2):
>     """Read exactly target bytes, tolerating short reads"""
>     data =3D b''
>     end =3D time.monotonic() + timeout
>     while time.monotonic() < end:
>         try:
>             data +=3D s.recv(target - len(data), socket.MSG_DONTWAIT)
>             if len(data) =3D=3D target:
>                 return data
>         except BlockingIOError:
>             time.sleep(0.001)
>     raise KsftFailEx(f"short read, got {len(data)} of {target} bytes")
>
>
> def _req_echo(cfg, s):
>     """Ask the peer to echo, and check the reply arrives intact"""
>     _send_with_ack(cfg, b'data echo\0')
>     ksft_eq(_recv_careful(s, 5), b'echo\0')
>
> > +    ksft_eq(s.recv(5), b'echo\0')
> > +
> > +
> >  def _check_data_outq(s, exp_len, force_wait=3DFalse):
> >      outq =3D 0
> >      for _ in range(10):
> > @@ -478,6 +484,7 @@ def _data_basic_send(cfg, version, ipver):
> >
> >      data_len =3D _send_careful(cfg, s, 100)
> >      _check_data_rx(cfg, data_len)
> > +    _check_data_echo(cfg, s)
> >      _close_psp_conn(cfg, s)
> >
> >
> > @@ -726,6 +733,7 @@ def _data_basic_send_netkit_psp_assoc(cfg, version,=
 ipver):
> >
> >          data_len =3D _send_careful(cfg, sock, 100)
> >          _check_data_rx(cfg, data_len)
> > +        _check_data_echo(cfg, sock)
> >          _close_psp_conn(cfg, sock)
> >
> >
>
> I'm ok with the approach overall. The coverage is sufficient for the
> purposes of the series.
