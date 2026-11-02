Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793651509;
	b=e0lKbEurZ6+CbZt12dhLI6wP0kQZJX61uT3kp+bjBZxtVJBavbSOy5Ms3govMV0geBSu
	 GBsiRKlljk9RLXPplqwk5vp/L5hMVXX5kuX/hGh3Rx5jBRKGE1PsYMQl5IRGmJ+kwJ1lx
	 wfhtwcIcqzh2/1SW6pS5UqlW02Df7SenY2ipsQURUBT+m7fxOYfiVnTUsUBoxnR31Bwxr
	 ODaAMbtCLLNR77WiPvbHfM//MwejceZZlqFH4Ez3/iB+7zSr1iqrLE2adS5D1Sa9w5SXL
	 DGDqol7Xww50YGsKU/k4ZeooJjws51TGOIyNer7rBMEK3BzSHHlE3zUIIfLerqmo+Rw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793651509;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=VjG5TvEjkBjtEt0wy1VTgpSv3HtKBsr1B1mB8IreTGM=;
	b=BAqnNINjPpBcXyUf29RkmE1e4HvS2YVUw5yyZTcAVp/z89e4sqAtlwLjUubxWSdnKcE2
	 Hd7bOEoC+Ve0fyMC4Ncxpyp6BdRXlYDzz1ficavB6U9b086sc2SFXgsvNBYYgo3lNjv/K
	 6FvGXOYiymCt2DPIs65sguV00AbisO+iD1hgrKRoHamOWdVmO8NAo5u8Vri1wqkHvpml8
	 EGM3v4daZ4U+gNC6DjpqX3GfYbK2WOywXes/sWb8tCzcYHLXUq7fLZFVdsk3NLRUg6jBx
	 1LrGQaF1oy1QfIPUsfglod3cU10D1SCVgN6wnAMXSBUaW+wAXFACGIkM26cvN+ykD9Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AAJQnj1J;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0798606A329
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 20:31:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0798606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AAJQnj1J
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6b1b12de661so2086a12.0
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 12:31:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793651507; cv=none;
        d=google.com; s=arc-20260327;
        b=dSHpmsh+TfT34X+06kv6NLM2ZLCkWonEmIxHmPaUIwsPkNNPwKeAWoKr2dGHZR0gUI
         Yl/TOuLmlArKH6QSCtzzlpFX+oP+WByVFNzqW9/R6fevEqIb7dU0Rb/LGXh3lt+pgZqp
         plKB8Q+ThODDzEOM4H94i5C5hhnSv6GWi9aXnc8FRz4GHkLnGRD14nuht8XbC4DFiVtk
         V0kIprxd5QMyjX1daX6o/iBsHUf6vlifCog27Owj+Nmv3LBJYqsFtEb2AbIZBu5Ue5Io
         FtFrOJeHbxbiHDDAKDgH47GgVqbRlYosgqzJZMgBapBZFDgOBuN2Z0i6edAv6BplYhMh
         8PMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VjG5TvEjkBjtEt0wy1VTgpSv3HtKBsr1B1mB8IreTGM=;
        fh=rHhMJW1n6ei3x1OHTNkC63ikr42QCKERzDHZXYfMy74=;
        b=k/oV0gJ1KNSVi9p/0PZV6tFUu9nHKwu+4aQeiu2vxywEye/BlddT8jeHJB04z57Rox
         mU+FR+eCGx+RM3/A+gtqI5uPlf7cgnHodFBD1C7Uuyqel3RF+A2j+EFEYZwaKs5ur/eV
         hDyvzBlX8dUfFD6BphTJyc8EgQSIxlUe12T0cYIw8tHE/iaf2JBDy+3wG++Wr+s2WRw9
         deJDDdfUv73CuqJn9y74WgpK//mlL+9ZH8YlDY9r2QDHwfU2fmZXVWKs3j0Fy//V6TvQ
         5s3KWjgdsAxLbSShQJMAWW69YM3r5d+4IApm6+eUfieb9SUwMJyRC3AX0MIhPs3cF5FC
         Jzng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793651507; x=1794256307; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VjG5TvEjkBjtEt0wy1VTgpSv3HtKBsr1B1mB8IreTGM=;
        b=AAJQnj1Ja11T23MVaTLcNycS+cUJrfMpwhSGmHetEgU0YRe4eRGM44pV2rGMMTbVSC
         vTj97Qw6X9pHx3UO3B/YV+Tt5TuvUx76pgo1Ha0VR/atoIse9D55YKYrUSVdYIMNktQW
         /KDFXZfnQ75dvbLD1S2Zsl3r6zjQhaBhJujHDe0GxmQcpzi4mVizJHSC8QnkB9ok0m+h
         uRGb22Jpp7sCGuFp/73CyZ9+yx1sxgJ412AnHSmAuh3TMXnpxkmncKRT254C1vRiFohY
         kQv7YfInJwo0rwgXpcvgCKtx4fLX/FS3PYMpYb+ZM8G4lbfc0fqQEEicCYIsiXPtDUkX
         8eeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793651507; x=1794256307;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VjG5TvEjkBjtEt0wy1VTgpSv3HtKBsr1B1mB8IreTGM=;
        b=pF9rHQha9lPMiwUa1q8xR7SKFZlmZ/xWxoQgO4qVtkvGEKD/O1+zC6Fdj2JavG/TCF
         Ims3RzwjPIQ0ajMR6DXqyw2tp1TEL89edx1zUOHviX9girW7U/8mdpoGgKYCyAPCkvVI
         iahZMm/z1gjF+i1oJ1VgKF9dCgXs7PYNguTOkpmXMsKSMGs0olyWTy6iuARspibsby2s
         V7MN2nobwlLXqIB5lUetC5/jjmWrntoqh/zHimgDqGPejwih03hySstO5JV+xHC1SGq5
         Jwas0d9fqizxOlZNWrZw749ETr6IkcjCUN/V95Wn+hUBL1+E2NZh9C6Yc1d85TOpD+U6
         rHzg==
X-Gm-Message-State: APuU4Z8QBOyjrU8VuUB/cia2N5SR7ynIxBZj3FZvou3zzNQZM40qjKqK
	NWPbgMSKwTHEsMLovEC9jMZFfaibEN45ZY6H5pmEzfX6D5B6YuRSVC4llldYRHVHLRLw3wmk4Jh
	UuVsJL09z0AyorMSt6eVhWGFYzLe4IPF2Mrm3CD1j
X-Gm-Gg: AYBFou0++Vrb0u+n47LkkYZLNbcHEBbNflK+1I5U23rzK343Zw+L4PdxmMHndNVuV9y
	v/3k1uPREPO+ipD7qyDkOTnavf2Y0YyAzO36ApY0kyF03SvgnGYiaL1bEZth0TvYW5WUwgI3VmI
	XUCm8brHOLDW/yi01cAfR1QF+TtRfe0LgDJTQ9UJSSx650Q2PQ0BOOtB8njPzpcWjX7undfHFg0
	ejf23CmzBXHT2W2+/S1b8TfnLc7XVrviScM3PximRMmUb4//PqajsKC5m4qBkoM/tWn5RyhbZT/
	Ygd0h8mzWx1ef3D84A0wWs4BPqGtA63UKldhUDD7JpcTHNoErTT3U/2XaXP7xEI1qvBEarUjt2v
	86ntPKPiWN0bUJJ1VGKM2YjGcfo4kfGsRAdNymlgTq7oCUc62zRIHqenO/mXyUM6ZOLs=
X-Received: by 2002:aa7:d794:0:b0:6b4:2188:97d0 with SMTP id
 4fb4d7f45d1cf-6b539d22220mr5389a12.6.1793651506561; Mon, 02 Nov 2026 12:31:46
 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102191438.1059771-1-sdf@fomichev.me> <20261102191438.1059771-6-sdf@fomichev.me>
In-Reply-To: <20261102191438.1059771-6-sdf@fomichev.me>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 2 Nov 2026 12:31:35 -0800
X-Gm-Features: AclHuK-pAzMpwpW_Jh3vV_sTtL85J3_WyWyUrIfAoS4gpBHVCa9xsaWfoYFzl4A
Message-ID: <CAHS8izM49sjB7QMv6eD_vws3D-JvR=vi9U=g5_tb-t70hJ=MWw@mail.gmail.com>
Subject: Re: [PATCH net-next 5/7] bnxt_en: limit netmem TX frags to 32KB
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	edumazet@kernel.org, horms@kernel.org, corbet@lwn.net, 
	skhan@linuxfoundation.org, rdunlap@infradead.org, michael.chan@broadcom.com, 
	pavan.chebbi@broadcom.com, sdf@fomichev.me, bobbyeshleman@meta.com, 
	asml.silence@gmail.com, daniel@iogearbox.net, razor@blackwall.org, 
	leitao@debian.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 11:14=E2=80=AFAM Stanislav Fomichev <sdf.kernel@gmai=
l.com> wrote:
>
> The TX BD length field is 16 bits wide. Limit netmem TX frags to the
> largest power of 2 which fits, which keeps 4K aligned frags 4K aligned.
>
> With 64K pages this already applies to PAGE_SIZE net_iovs, whose 64KB
> frags would otherwise wrap the BD length to 0 with BIG TCP.
>
> Tested on a 50Gb/s NIC: devmem TX from a 2MB hugepage-backed udmabuf
> runs at line rate with 2-3 frags per 64KB skb, none above 32KB.
>
> kperf output (sender side, 1 flow):
>
>   client: =3D=3D Source <sender>
>   client:   Tx 46.358 Gbps (174483046400 bytes in 30110590 usec)
>   client:   Rx  0.000 Gbps (0 bytes in 30110590 usec)
>   client:   TCP retrans reord rtt rttvar d_ce snd_wnd cwnd
>   client:           729   153 599     48    0 13893632 3147
>   client:   net CPU 71: usr: 0.03% sys: 0.06% idle:67.62% iow: 0.00% irq:=
 1.12% sirq:31.14%
>   client:   app CPU 72: usr: 0.16% sys: 6.01% idle:90.66% iow: 0.00% irq:=
 0.83% sirq: 2.32%
>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>

Acked-by: Mina Almasry <almasrymina@google.com>


--=20
Thanks,
Mina
