Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9EE443C2C
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 10:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789124229; cv=none; b=X6qyh8e5lfMzfxMjye0FZvYjx0zeBOgW40v9BOgxqwm1KZFirE6m4uC9qaOoEgoPrgv5vodBMz0YqEhIzMM3ZGPT8xRqyz/W8B9iG8IB/fQrWqaw/WvW1mbVsXq/jwqfwLyIf4dq/gpDF57h8JFeGCtM6PWE2jTRs+quxR5JkYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789124229; c=relaxed/simple;
	bh=ujhajdxsDtMtcxp5FbkMYUT3/SFZiAv/3XqaRDnCtSE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=caUbSjzPvn79kJuE5pSLBtKOf92DERssQeavMIJqEsp3sQcMeTBuajS3fcPSjMVlBZg1aH4CU8HXTp/BqhUaz37aHpqS0thuh2DIjlME2CDhrPeOOIeIUo9FNwH0u1aLyseYLmYAlxxbAPqdZwR8QkvL/n5tqx3vbRiJRhZl82o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XC0PfUe/; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XC0PfUe/"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-91058dd77a2so10233696d6.3
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 03:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789124227; x=1789729027; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3rQKPjczWN0Jvqf2b9cJEEAba6rDBL2mDgyS8mK50Vs=;
        b=XC0PfUe/dzSmZiOJUoiWadjsgOKdiu7B5tx4Em2SXzzg3u8h+zw0DSOE5iQu2cQ7A5
         ySf6Ymr0csJ9qZBHWj1gkj/+LRonv94C3KMHvuGyHI+dldYzdCl3+RmRH0j9lfQpHanb
         pg8f7EQIleh+9tjyRQtKPuOzTNfPekGW+y9SCdZ84ZLxI67BLvLh2637zQjZOWF/W//Z
         KklU2rAvVGBF5S38OfrTnf2gjOdkoZKYb+O9U+iIHlzP1HphhGHBWBSdGoFXCi3ujUqC
         x8FaBgfbgKX83sndFeKdz51RhHKaXCOLNf13M90JFUH4ix/XSp6bMyn7qqJKWtdCwkxx
         2DNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789124227; x=1789729027;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3rQKPjczWN0Jvqf2b9cJEEAba6rDBL2mDgyS8mK50Vs=;
        b=ZsgDaDs5jVrJDg/fHitSBBu8zTlwZt/DjnMT7gABHxtyyXRzCSWv+4D2N6vFGQovPM
         12hXzxZi9zAzS5bSVu3cTJI+a0sVmrOMRBsri2VJuwJ5Xy/vC1wTubQ7VZ3xX5RDtxGF
         Uo4isceRJs+C66KAEAh0pac/enE9EwB2KPOgAM4nU4S4DgDEgLciaEC/07zEyX59Gysf
         E7N35/bsprd+yNLMc/TbWl3NQDBmcXGP91MAy8WM2g7ZUY1U6TB+CzOpBglBgqDclKa0
         +kCArl2jzRjbuy8h3CiW2mzz/e8wiaOnvaIr+eFedxY0Zz7zKKN0SuQPQQ+ZWs3HkDv8
         UfCw==
X-Forwarded-Encrypted: i=1; AKwUvBzRkw4S05g3vNgrmRhHYU0hGfeBtGxLUxVU0Qm2UZRjvidvkb/42bkZGFIgCqkSDlEGmJa3aDQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lzTAbnN5HcEtz100nL4kZbrfrTqNfsuB2Wy5QPXoSCEDHJGxmv
	k0ALTxNK/b2MygqMr9ckbFCbeq85/R5tgnQpCInUKmgcQ204Vf0AN2HH
X-Gm-Gg: AYBFou0CY3ksRJCNwnrPPspHWwoiPZ6Lmj1P/B9yJ2J3PNOyMzEhUZgKDpynTFRuISo
	QP51eBJjP6CHu5IBfh+qvQyS3C1YkAWLd7RveHGwWHOMI6zD/UXGC1pSc7iLkqFVybZ77BlUANg
	gisGPp/Br9YuPfekTKFtjYSR4XKtCdrewsK4zcGBCwckmiRv8B5ojv9X/Fhcp14Iyc+P16jF/l/
	aBpKjcio9gOx0oZWlQhYlnpOeWvCxHQvP07gfrqO6OwySqkULDDFQVz0eUlHq/bcryG73MvoD1g
	+vM77be4Kh3Q7xx4xM7CGxhj+V4zpO6OtK8KpwxsptBdJtJegMIkYPqYVibg+aBx3UQDnkGf9cM
	ygtRTznkm5iGiJpT0/WaxirJnG0M15BSPTImg/BFWAvr8DEXmHTXlBOLiDEMZQPSw4TC5TrmA9g
	2mjYgecGXCOjbKVSNJLVe5mj+V9OMmstqaC4324WOckYdbKAZAi3etRdtTDhRQYkL5Ifl+8rbnH
	5rC
X-Received: by 2002:a05:6214:ca1:b0:910:6ad9:d6a9 with SMTP id 6a1803df08f44-912120dc4bamr49465616d6.24.1789124227059;
        Fri, 11 Sep 2026 03:57:07 -0700 (PDT)
Received: from localhost ([2600:4040:9399:4000:e553:72e5:7d37:c7ef])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f47a239sm18167066d6.26.2026.09.11.03.57.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2026 03:57:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 11 Sep 2026 06:57:05 -0400
Message-Id: <DLCFLUP26J73.FNVCZ4ALAUHC@gmail.com>
Cc: "Willem de Bruijn" <willemb@google.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net 2/2] selftests: drv-net: psp: test PSP and TCP ULP
 mutual exclusion
From: "Daniel Zahka" <daniel.zahka@gmail.com>
To: "Daniel Zahka" <daniel.zahka@gmail.com>, "Eric Dumazet"
 <edumazet@google.com>, "Neal Cardwell" <ncardwell@google.com>, "Kuniyuki
 Iwashima" <kuniyu@google.com>, "David S. Miller" <davem@davemloft.net>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Simon Horman" <horms@kernel.org>, "Willem de Bruijn"
 <willemdebruijn.kernel@gmail.com>, "Andrew Lunn" <andrew+netdev@lunn.ch>,
 "Shuah Khan" <shuah@kernel.org>
X-Mailer: aerc 0.21.0-threadmapfix
References: <20260910-psp-ktls-fix-v1-0-e3f30aaeca4e@gmail.com>
 <20260910-psp-ktls-fix-v1-2-e3f30aaeca4e@gmail.com>
In-Reply-To: <20260910-psp-ktls-fix-v1-2-e3f30aaeca4e@gmail.com>

On Thu Sep 10, 2026 at 7:46 PM EDT, Daniel Zahka wrote:
> Test both setting PSP after TLS ULP, and TLS ULP after PSP.
>
> Add CONFIG_TLS=3Dy to the drivers/net/config.
>
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
> ---
>  tools/testing/selftests/drivers/net/config |  1 +
>  tools/testing/selftests/drivers/net/psp.py | 46 ++++++++++++++++++++++++=
++++++
>  2 files changed, 47 insertions(+)
>
> diff --git a/tools/testing/selftests/drivers/net/config b/tools/testing/s=
elftests/drivers/net/config
> index b6989c7d3d9d..4838adf27fa1 100644
> --- a/tools/testing/selftests/drivers/net/config
> +++ b/tools/testing/selftests/drivers/net/config
> @@ -21,5 +21,6 @@ CONFIG_NET_SCH_INGRESS=3Dy
>  CONFIG_NET_SCH_PRIO=3Dm
>  CONFIG_PPP=3Dy
>  CONFIG_PPPOE=3Dy
> +CONFIG_TLS=3Dy
>  CONFIG_VLAN_8021Q=3Dm
>  CONFIG_XDP_SOCKETS=3Dy
> diff --git a/tools/testing/selftests/drivers/net/psp.py b/tools/testing/s=
elftests/drivers/net/psp.py
> index 315648a770d0..12b27f2a3fa1 100755
> --- a/tools/testing/selftests/drivers/net/psp.py
> +++ b/tools/testing/selftests/drivers/net/psp.py
> @@ -23,6 +23,8 @@ from lib.py import NetNSEnter
>  from lib.py import bkg, rand_port, wait_port_listen
>  from lib.py import ip
> =20
> +TCP_ULP =3D 31
> +
> =20
>  def _get_outq(s):
>      one =3D b'\0' * 4
> @@ -333,6 +335,50 @@ def assoc_version_mismatch(cfg):
>              ksft_eq(the_exception.nl_msg.error, -errno.EINVAL)
> =20
> =20
> +def _require_tls_ulp():
> +    with socket.create_server(("localhost", 0)) as srv:
> +        with socket.create_connection(srv.getsockname()) as s:

ruff is complaining about the nested 'with' statements. I ran ruff
locally via nipa, but did not get the same result. It seems nipa doesn't
use a ruff config file, and the discrepancy is because I have a
different ruff version. I was able to reproduce by upgrading the
version.

> +            try:
> +                s.setsockopt(socket.SOL_TCP, TCP_ULP, b"tls")
> +            except OSError as exc:
> +                raise KsftSkipEx("kTLS not available") from exc
> +
> +
