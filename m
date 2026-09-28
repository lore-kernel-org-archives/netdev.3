Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6674E80B5
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 16:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790611569; cv=none; b=XDVjdt8eQAjZJCtDtr/1Tlva8c0UEcBuxdimIinmf6ekjgcz3YRtMEyzktDZxCYM5BBTEYHpn2tuMv9Fm/RyBVru2l5/ZkH7ZKAvS76kEZshAKh9jAg8xMefHLQpwrvF3VSMEZROiIsGF5SIz9YNL3RBZS69Wv12R+WTwVM0SZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790611569; c=relaxed/simple;
	bh=m0g2lQoOm17jPojWnNyE6G9tE1ON2MpFuH0j4E4VLUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Glww3lp/V4WjDj4o7flWf8azGwpPhnn1BEfqOIbVJY9SrWTjvhko20U3VBArND2I21G8Ys7tWHsm32L2uboV+r/PjHPXyFGsxzfVz1uJ1MrmXXn/xB5gf6pUn4opqsGpU545NijPu/5C6WWzn/bXBK0Q1TSf2zWV8/XR9fZRHlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hjKNiif3; arc=none smtp.client-ip=209.85.216.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hjKNiif3"
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-3a0e8165edcso1154765a91.0
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 09:06:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790611564; x=1791216364;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uYFGHhDrYW4spVBqeeXPiq/CnoroPamkXfFYd0wPgSE=;
        b=SLJ+l1UTWQZqi1LaUemtVGNz4av0DyKRRifLt6Qf2wTgcrpR+eg0xjWQLARk64TCxv
         rBZ0TisVxIV2o4WpcJUtz1XrnStty6cYOebx0I8+Z9UORoPRlajeu4gNJTf4Jk+5s9bc
         u6c9XfAKlgGgt5QkJQU6pTj7F+Qntgi8FsWLGhmvH2/nnhs96aeVQImesRnYGFQDAKZ9
         BUGvRGSz4fqksr/rZBZe7YFzNzuRhMNflcQq1cYAF7PaUF6rupufTonEdY5x/o26myeG
         2feIt+BYdT35Ibt6W7rYUX05yHKo4RrCiyfKDf0/cQ5Pms7jfvzbTNKMD4hZa60l9le8
         66ZQ==
X-Forwarded-Encrypted: i=1; AKwUvBwPwavZ6ysoKa5VaFGQqi2zV9MtIgacWkwJLfveIKhLu+tc/+FB2l4utR/q2SYwGyrLsnOwoEo=@vger.kernel.org
X-Gm-Message-State: AFq9FYID8BqfYhzQ/9rtg8MISIaheHw/SvYae+B+BcT1v7y+YxxAjxHL
	2dbj63NkiLffu//6Ne2BGbw4/Q2loc2Nq5EVwQSyZyRVIZj04isEI2uDNaI7+JM9NsFdbi+qU0X
	cGstXRlHU1HEKMHXrvlFaG6P5ERPnJCay05ELgLozr5B00v3BWUF8k8LkB0otXbhBRR4wVi0IVX
	uiUxp4QcvUcY+0ZZDGQPbFmZy46DHFEbOLLgHCkOFeHgN1Dqi2PzmPAyL1bqhCcKMkGdyLWn2nz
	GDPkcTZu9+b37LZug==
X-Gm-Gg: AYBFou1DbWGbzYSFph6mze/T1cjXZHk/pecS15cHoUJnP/QkY0LdBLBY5ajtkDMyk1j
	TCjFe75/G986NGWZoUPUfJkjFJ5Y7mhDoqgBHW++fjLeZPC1aKSZJJsjNwaI6zqnTQEdOntN9Sp
	Npbwh5TPdSt/n0M4MtyNX7Q0FxbwbrdIbYwriIxnbevoj1uKDzPSmiWzk91/31E3SeH16v2msSq
	boWEtcwwwJIrMFSdljGJcbhaiTL3Nnrkf/NH+XRHQDBe/yAmJO5xrxN9u9LNim8+Xu7b8P4NRSH
	Guq8UmAcHph2ATZGio9Tb4oMGJ7hDQjIHgs/3UvnZf3s0/t3y970vof8WykwqAzz1K5U+Ja/U4r
	jppYbpK2XOBPouk0UPWHlDod1PoMmW3tORQd5Cr112taUmZCeFajGu1woJl659rgzIFo8f8s1it
	R8PmfaHWS0lpH0hI/7bGNz6kxOdx27LeG0LQTH5svWUZBy
X-Received: by 2002:a17:90b:2c88:b0:39e:b15:7950 with SMTP id 98e67ed59e1d1-3a0bb5789eamr8029579a91.23.1790611563821;
        Mon, 28 Sep 2026 09:06:03 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-cc78774027csm6357117a12.3.2026.09.28.09.06.03
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2026 09:06:03 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4887b0303b0so1820338f8f.3
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 09:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790611561; x=1791216361; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uYFGHhDrYW4spVBqeeXPiq/CnoroPamkXfFYd0wPgSE=;
        b=hjKNiif37BDx7495LpCHrb7wP8sxTdSvFZDJbgFA0qDDehaXBQkQInpQkH/3eGWF5g
         Ytf182pJClSlt1rMlG907Zm+iafq/70V5N9FgbLNs8S91ros0yD7HLisF6jpzyQXOXpf
         E09QA3q6HqTS2Jar6GKvAau5BLMwch0CYs9E4=
X-Forwarded-Encrypted: i=1; AKwUvBz36sco3H/iXnsXjlXHrBaLLWdOC8QHdRNolnwaTpBDzOuMWGbsPhZiCaV59Frl1UMdRaDKN+0=@vger.kernel.org
X-Received: by 2002:a05:6000:1863:b0:487:342:d142 with SMTP id ffacd0b85a97d-4887175ae72mr27528189f8f.44.1790611561480;
        Mon, 28 Sep 2026 09:06:01 -0700 (PDT)
X-Received: by 2002:a05:6000:1863:b0:487:342:d142 with SMTP id
 ffacd0b85a97d-4887175ae72mr27528130f8f.44.1790611561094; Mon, 28 Sep 2026
 09:06:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260926093343.292181-1-maxime.chevallier@bootlin.com>
In-Reply-To: <20260926093343.292181-1-maxime.chevallier@bootlin.com>
From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Date: Mon, 28 Sep 2026 09:05:48 -0700
X-Gm-Features: AclHuK_zXW_8lFu1d1nKKvNyidTRNhEd5jYX4yiuAclqxwSthRuYcoa0n6_htZs
Message-ID: <CAMdnO-Ji=8dNp8TPEbjggZFkBm5AniqdCKKdHbGStt7WnsqkGw@mail.gmail.com>
Subject: Re: [PATCH net] net: stmmac: Don't set or get RSS parameters when not supported
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Russell King <linux@armlinux.org.uk>, thomas.petazzoni@bootlin.com, 
	=?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000141d8f065c8d3e2a"

--000000000000141d8f065c8d3e2a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Maxime,
On Sat, Sep 26, 2026 at 2:34=E2=80=AFAM Maxime Chevallier
<maxime.chevallier@bootlin.com> wrote:
>
> The RSS kselftests fail on stmmac, and this is partly due to the driver
> reporting bogus data for the RSS ops :
>
>  - ethtool -x reports an indirection table and a key while the hardware
>    doesn't have any of that
>  - ethtool -X fails with -EINVAL.
>
> Let's return early in the rss ops if we know the hardware and platform
> don't support RSS.
>
> Note that RSS is currently not supported on any devices upstream, so
> code that was already useless is now effectively dead. It has been the
> case since 2019 when the code was added, as platforms need to set rss_en
> in their plat data, and no glue ever did that.
>
> Russell King ran a poll in february 2026 [1] asking if the code should
> be dropped, without any reply going in either direction.
>
> Jitendra Vegiraju from Broadcom sent 9 iterations of a Broadcom PCIe glue
> driver [2] that actually sets rss_en =3D 1, so there's some hope that thi=
s
> may be used in the future.

>
> [1] : https://lore.kernel.org/netdev/aYd4BkAeNW6d0iIC@shell.armlinux.org.=
uk/
> [2] : https://lore.kernel.org/netdev/20260402213629.1996133-1-jitendra.ve=
giraju@broadcom.com/
>
> Fixes: 76067459c686 ("net: stmmac: Implement RSS and enable it in XGMAC c=
ore")
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
> Jitendra, do you have plans to continue iterating on the BCM8958x glue ?

Yes, we plan to resubmit the BCM8958x glue driver patches.
We paused it for a while. But, we are planning to test with the latest
net-next and submit the patches again.
Thanks,
Jitendra
>
> Thanks,
>
> Maxime
>
>  drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drive=
rs/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> index 1be5310ca766..4e917a448271 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> @@ -927,6 +927,9 @@ static u32 stmmac_get_rxfh_key_size(struct net_device=
 *dev)
>  {
>         struct stmmac_priv *priv =3D netdev_priv(dev);
>
> +       if (!priv->dma_cap.rssen || !priv->plat->rss_en)
> +               return 0;
> +
>         return sizeof(priv->rss.key);
>  }
>
> @@ -934,6 +937,9 @@ static u32 stmmac_get_rxfh_indir_size(struct net_devi=
ce *dev)
>  {
>         struct stmmac_priv *priv =3D netdev_priv(dev);
>
> +       if (!priv->dma_cap.rssen || !priv->plat->rss_en)
> +               return 0;
> +
>         return ARRAY_SIZE(priv->rss.table);
>  }
>
> @@ -943,6 +949,9 @@ static int stmmac_get_rxfh(struct net_device *dev,
>         struct stmmac_priv *priv =3D netdev_priv(dev);
>         int i;
>
> +       if (!priv->dma_cap.rssen || !priv->plat->rss_en)
> +               return -EOPNOTSUPP;
> +
>         if (rxfh->indir) {
>                 for (i =3D 0; i < ARRAY_SIZE(priv->rss.table); i++)
>                         rxfh->indir[i] =3D priv->rss.table[i];
> @@ -962,6 +971,9 @@ static int stmmac_set_rxfh(struct net_device *dev,
>         struct stmmac_priv *priv =3D netdev_priv(dev);
>         int i;
>
> +       if (!priv->dma_cap.rssen || !priv->plat->rss_en)
> +               return -EOPNOTSUPP;
> +
>         if (rxfh->hfunc !=3D ETH_RSS_HASH_NO_CHANGE &&
>             rxfh->hfunc !=3D ETH_RSS_HASH_TOP)
>                 return -EOPNOTSUPP;
> --
> 2.55.0
>

--000000000000141d8f065c8d3e2a
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGozCCBIug
AwIBAgIMVrsZAz+H2ecMN0c/MA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI1MDcyODE0MzE0NVoXDTI3MDcyOTE0MzE0NVowgeYxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzERMA8GA1UEBBMIVmVnaXJhanUxETAPBgNVBCoTCEppdGVuZHJhMRYwFAYDVQQKEw1CUk9B
RENPTSBJTkMuMScwJQYDVQQDDB5qaXRlbmRyYS52ZWdpcmFqdUBicm9hZGNvbS5jb20xLTArBgkq
hkiG9w0BCQEWHmppdGVuZHJhLnZlZ2lyYWp1QGJyb2FkY29tLmNvbTCCASIwDQYJKoZIhvcNAQEB
BQADggEPADCCAQoCggEBANhkkGE04sPq89nJztbjCqCQlL3136zyS/FHf2u7+DuhUYKV8nmbYruD
Kyf9ZvPFUBo0BvKCL15B5hfAV2tm+jycw9VUPZ54FGZJfL3vuhOA3qQLZc+oR/6Z66A9wGvDaR8w
U0H2IT9SH5SfDDnN5Uw/bso62vh8q86eB+kaCcxwGTL87NCru2e2fN+m52D+UtsokZJfpQyQiDIV
cYRWo3N3PsbtVXXU/i3mbzxukqb33SEhcuj2MhG75rIL9cxxvVT4MCrNHkSgO1m9kWQXTaOO1zB0
YI9JRYG8Rd5JczLO8U5uzTFHV7ohP95K5JIPP3cNuSF0ubp8BuG4kUfM77ECAwEAAaOCAeIwggHe
MA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEF
BQcwAoY6aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2Ey
MDIzLmNydDA5BggrBgEFBQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNt
aW1lY2EyMDIzMGUGA1UdIAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoD
AjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBB
BgNVHR8EOjA4MDagNKAyhjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNh
MjAyMy5jcmwwKQYDVR0RBCIwIIEeaml0ZW5kcmEudmVnaXJhanVAYnJvYWRjb20uY29tMBMGA1Ud
JQQMMAoGCCsGAQUFBwMEMB8GA1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQW
BBS5q1NehKQCfxeM0f2EPNdZy2n8tjANBgkqhkiG9w0BAQsFAAOCAgEAAQI566BWWgv6BncHXnnG
hZTmLuDHrZXnBf+MvgPh0BC+tCXy/aG9Tp6p3O2gK3nn5bUyshLt3GLtC/5Jk9j1t7AeLC6/cK2p
Gr+E1Pz6/qNR5+CSm6D63Gnxgt5UfSSmAw/03NC8dTYE31PkqKksU2rWkmUg6rLm0OE6pI3N4YGI
EVh6Sdq9OXyswGryWF7GZVgxLvk5Est5vYfGiyYIExJeIKT9x1u1ofH8E8fP2OhEdeiESTphiRu6
fd777V9h3ANr8L9XQmpghVn2qu8+Jid2zhGQLEn+Nu5hCApYGJMWkVREJGtKNfnl/IrL1gDOcfe7
nlfIISZama3WMmSDJ2ZYprZ92ZfBpwHMF7TY6NK/5wJRlXPdAW7ZdXPfZTenjWcoUkUKYNnSLw53
xEjZ5CsMjLxbpGOyJLRGIR0uxY4V1658d3AmKcZpS39X+BMALzFhRcwhmqxuTgxzAacmYZA1KAwb
HchXc0eQFO+SyFd+RzEirFrwcq0oBTmjkZetpfd/5HQs8fQYlkqGleG414vGSPYgyaFk6W8Qdzgg
/+2n7vOS2POP3GehKB3qNVG34DyENGvdhYf2coLLq14gNc/R5YETH8bBibsLniO0owNO6nuOfOeI
10PYVPEZlHamnlE3OwojfANIYxIMxq6fxwFf1i9ILxM9dcFJXsLbgXExggJXMIICUwIBATBiMFIx
CzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxT
aWduIEdDQyBSNiBTTUlNRSBDQSAyMDIzAgxWuxkDP4fZ5ww3Rz8wDQYJYIZIAWUDBAIBBQCggccw
LwYJKoZIhvcNAQkEMSIEIEVlTWtiH45PPCADlIL8DMefbs1EU0B7fGsm7RcUtQ2qMBgGCSqGSIb3
DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDkyODE2MDYwMVowXAYJKoZIhvcN
AQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0D
BzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAF+Z7TSBQbDzY9pV
eOy6qIU+9MZDOF8wZy3I9mkkYYhJXWIgBk4+0awXzuHZKCP25knWVJ1uORMc0cJD4gx42WA1wMag
mkT6LyVMW/uFqsu3UcEHvWgcrRVpMbbkd0cKyzjhVrdoGBqtLDYv6TktGFuytUjs33y+1Q2+K3I0
1PywsT1jm+LiTSikuPQGffYfh+YujEBCIQAS9lPu3Wv8ESUYmF+ulH2HMEss9CUJvBkGY6js+WxA
qGo3YV0CBZMTTSwPqs1h0DIy578KwrRbSs0klJqEKEbEQVBCTUhQrg0UffBwyQtcXHzZgEFFeckj
TGS2hbxP/ozNHXQJXI4/pGo=
--000000000000141d8f065c8d3e2a--
