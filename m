Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F930481B1
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 03:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788923796; cv=pass; b=pJXhS2pJVkRr3xlETlxOGDBVOpUi5Ee2zM2Pyg8KxubZ06fN9NWPODfql4eF4kWBtfJYaWpO1mJXatr6xA8NmCkZRjexFkKPEW2D28tSftKnghHvnQYivM7njxrRNe7lsAfketxmEOQLdUrXBn9IvBMgQE8oDFsfP8XIMMcVegc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788923796; c=relaxed/simple;
	bh=kR3rI5ZBhblehYeXOA3quNdN/DYbRWk6KMadfxFPlo8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J7RQ1wcKYeuXK7QzlXfp4IFm0MQs2NciMx5jexxy9ZTSMMENORH67dbcgys3HydU4mzyRK7GgYQWrqxUWU1PthfnTW2ZDwXzTpcq/R8azv8S3SU6O2Vn/1xVBhtr31GykoINSRSrAdO2eoIt+iM0Noyp1jfYYvGwVZINfbqMYB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R5LdeIFZ; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R5LdeIFZ"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747ee1f9bso6132135ad.3
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 20:16:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788923793; cv=none;
        d=google.com; s=arc-20260327;
        b=JX0+4pRlxdSFQr9U94n+jBCQF7G9hCA4taffEHPqcbJkBdyLC1R8MXqGV8EOwt03Lm
         C5bb+9/NvwWac3pwyel0gMQme+15XPHdp88ez9H8iayNRF9DRnFkujOb0Cg0ZbhHV9XF
         b/02v9Tvj7yQBT2UkeFM+xanyerGCrjG58Mjw0pmbCj+E3s35HUXhkRu7l/5mzoYJvtq
         hNUAhndEJP1xUYjh11ITwGX5PHgm7N1b2OxGMHtvXUz6hKuA9I541GrlIap0XiZ4FMRs
         wgD2BupUV6RgtpmKdyK8coI94hpZdb0I+HgRvD9jU4Xw+IayNC8t/qg99nIcLOVdrw6k
         KwHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uUP7EYG2/BuYJ+2rnh8UBitNWg1RgcNvcJgxVe8/WB8=;
        fh=PqoTizU4fixnAkkE3B1FVz4v/VzXPPJZUZECWZt/LDc=;
        b=dgke3CAtzWZMyVzR3Z7yGG5JtNrxE9lKtp/6CKesTWByziIvjN9ntHAsT9m9Ma2CLC
         1s9C5vgs110A5ZxyY8NqEy+RXZIGZtnwyFE+0BQj2nqrO9SUfxDCge8ZJhrTGri8pmPY
         4hdK3tAm0xCs2ekXrRmnG2du+G4wtwYMHQcmMMGoOf04UMzNsoN7EHs0KOgprr1+IAr1
         3I6y25iok7nfmy2IVn+Bxvxtqy/MDaOpQyxbVNn6b4IKBRVTkiPR3hYUfvRjtaOSVSgv
         Zf8SDOXJi1geyykAza0E1maydU3i28uW9gLeKt+qYb7Ojk0uGalYbJG9XJFFPmkT+S/S
         C7xg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788923793; x=1789528593; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uUP7EYG2/BuYJ+2rnh8UBitNWg1RgcNvcJgxVe8/WB8=;
        b=R5LdeIFZlg2IIIrGjR3l5hV1urwf/7goZPQ9vkxedLtToIiSiUMRTxNi99j9r6oHJV
         dknWYidgMPPcsSiT+mHxl4ar8qiIOHIOwYIZKSnf5ujaroQ7iN/Sy46cmT0VqfNsO1SA
         jt0EPw6/fbD1q4+gzXrugOEpZNcpkOHS+v9vHcg8N4yU97psXAQJZRKHvDHbzbmAdYRc
         RKTCqukflG98Grt+wh/CfJ5eBrqpy7xhVAQr4fOgaULjcCuem8vmNGdkiSUr/luLaWDI
         PLxXRNYxFhV3g1ULBETkH5hSM3Jun/MkQGA14x+GIAxf8Ibw/FDLvG+uvx10BDz3J/Ty
         s/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788923793; x=1789528593;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uUP7EYG2/BuYJ+2rnh8UBitNWg1RgcNvcJgxVe8/WB8=;
        b=lI5/qUQmmM63zySJzmATR4gTu91/e2NSCZvhBLo1WPM5SasWnmbY8OA/BCtvGqTHxV
         pRD25zS/DYdrn5hvmCtXx/g8FhCwDK2UiTMbkwOsfS8FasHqFyvUnGxwYPo4pXHJi3ce
         2Q/vAkMAQMhMz2dykRr0F39yvRHlOLpCHGZrJboUGohU7CpUXD+QMYWNdMExEKOc+hIi
         JMBgNDvClLI2fpBZto/uDk02OL7KgAtTvjMQ/4caj2Xfbonw34BLdgR0q4IFXGh0WuyF
         +1H4EQf8AJPwMmevb8IxwzV8nQUaqnn2coKrOLnGctGf4+koLaCE7RZx8tQTCPYgaM1o
         0vqQ==
X-Forwarded-Encrypted: i=1; AKwUvBy25zw25qRxzt2LpJVSZGFxCQrD4TZPbfN+Kdjits0i+0UX8HuwbZPCvwP46eV2PutZgJ+srUo=@vger.kernel.org
X-Gm-Message-State: AFuF++kdOpxuc0ZgVHcmD+t8uhPCbX8UF/AsLkpATL3k02BcasTiEveL
	XdRKM+baOkzE3FR+Q8t6azhBJzGjQJEEUR+oXq8otUalQ7BXhlh2jHN2dF8CLu5srrJP0jUz2QI
	4T8hfleCchT3qM59wBMiTmGvs+TO4eUjJLG2/V9TYVdJo+8+NrfHYjpE3yPA=
X-Gm-Gg: AYBFou25bpGdLpACuAUMMMSDVExSIZ8ZrIjjU6YVAhQqITWzQDgUXqW+fXyME0PMMsk
	+wrytSqb7CNmltwrDXF6PA5ZQ5tSMJ+lZLiwlV5Rr7lr13TxFzhc/r81D/reIGZdXxihIbZg+So
	Q9nFUF/JT6eiiXv8WG5Ab37Ml8Deta5zkMEJ3UNvBTYsxvL5CJ9X3Bh6m291QstLFpdudNeTOYm
	NRb7meAUuuhPh1FjHXyxhlogfAz1GW4L2yRjUS5x2SXEfJyu7gL5nCWqLYAKlXrzTnJ+eMWyVT8
	FaIJxI1zrA5u+6i0oSdJavPf5w4+p960TWD+aUvWZZfgKdhMdhT4qKYcIXz5TmPx
X-Received: by 2002:a17:90b:4a4d:b0:392:b509:b1a5 with SMTP id
 98e67ed59e1d1-39bac34a6d6mr4250028a91.14.1788923792039; Tue, 08 Sep 2026
 20:16:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908181956.1357684-1-kuba@kernel.org>
In-Reply-To: <20260908181956.1357684-1-kuba@kernel.org>
From: Sheena Mohan <sheenamo@google.com>
Date: Tue, 8 Sep 2026 20:16:20 -0700
X-Gm-Features: AcwNN1V_oxZXXw8CItOFCp-irJrBaC0B0lCHygpM6-ISZJc53KtazMqdczCIFe4
Message-ID: <CADWJPTtu1bjng_1LWAbT7QtnkODw2A36Xd5koaiiESK_2ifHhw@mail.gmail.com>
Subject: Re: [PATCH net-next] selftests: drv-net: warn if LOCAL_V6 has DAD or
 not kept on link down
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	adrian.pielech@intel.com, przemyslaw.kitszel@intel.com, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 11:19=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> napi_id.py intermittently fails to start its helper on Intel and Google
> HW runners:
>
>   CMD: /srv/netdev/drivers/net/napi_id_helper 3001::1 37569
>     EXIT: 1
>     STDERR: bind failed: Cannot assign requested address
>
> Either keep_addr_on_down is not set or more likely the address is
> configured without nodad. Having to make sure that all tests
> always wait for DAD after impacting the link would be a whack-a-mole
> so we expect the env to have nodad and keep_addr_on_down set.
>
> Warn about both while validating the environment, and document this.
> We could fail completely but most tests don't impact the link so for
> quick local testing it'd be annoying to have to apply the settings.
> I hope the warninging stikes the right balance.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> Adrian, Sheena, please update the setups scripts for your
> systems. Looks like nodad is missing.
>
> CC: adrian.pielech@intel.com
> CC: sheenamo@google.com
> CC: przemyslaw.kitszel@intel.com
> CCL hramamurthy@google.com
> CC: shuah@kernel.org
> CC: linux-kselftest@vger.kernel.org
> ---
>  .../testing/selftests/drivers/net/README.rst  |  9 +++++++++
>  .../selftests/drivers/net/lib/py/env.py       | 19 +++++++++++++++++++
>  2 files changed, 28 insertions(+)
>
> diff --git a/tools/testing/selftests/drivers/net/README.rst b/tools/testi=
ng/selftests/drivers/net/README.rst
> index c6bed9a985bc..3fe49bce4f3a 100644
> --- a/tools/testing/selftests/drivers/net/README.rst
> +++ b/tools/testing/selftests/drivers/net/README.rst
> @@ -70,6 +70,15 @@ LOCAL_V4, LOCAL_V6, REMOTE_V4, REMOTE_V6
>
>  Local and remote endpoint IP addresses.
>
> +Tests reconfigure the device freely, including taking the link down, and
> +expect the addresses to work immediately afterwards. IPv6 needs help::
> +
> +  ip -6 address add 2001:db8:1::1/64 dev eth0 nodad
> +  sysctl -w net.ipv6.conf.eth0.keep_addr_on_down=3D1
> +
> +Without those the address is flushed when the link goes down, or spends
> +a second unusable while waiting for DAD to finish.
> +
>  LOCAL_PREFIX_V6
>  ~~~~~~~~~~~~~~~
>
> diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/te=
sting/selftests/drivers/net/lib/py/env.py
> index 25903f580b40..6262080a8bf4 100644
> --- a/tools/testing/selftests/drivers/net/lib/py/env.py
> +++ b/tools/testing/selftests/drivers/net/lib/py/env.py
> @@ -239,6 +239,25 @@ from . import bpftool, RtnlFamily, Netlink
>          if missing:
>              raise Exception("Invalid environment, missing configuration:=
", missing,
>                              "Please see tools/testing/selftests/drivers/=
net/README.rst")
> +        if "LOCAL_V6" in self.env:
> +            self._check_v6_env()
> +
> +    def _check_v6_env(self):
> +        """Tests bind() to LOCAL_V6 and bounce the link, it must survive=
 both."""
> +        ifname, addr =3D self.env["NETIF"], self.env["LOCAL_V6"]
> +
> +        def _keep_addr(scope):
> +            with open(f"/proc/sys/net/ipv6/conf/{scope}/keep_addr_on_dow=
n",
> +                      encoding=3D"utf-8") as fp:
> +                return int(fp.read())
> +
> +        # 'all' wins when non-zero, see addrconf_ifdown()
> +        if (_keep_addr("all") or _keep_addr(ifname)) <=3D 0:
> +            ksft_pr(f"WARN: net.ipv6.conf.{ifname}.keep_addr_on_down not=
 set")
> +
> +        dev =3D ip(f"-6 address show dev {ifname} to {addr}", json=3DTru=
e)
> +        if not (dev and dev[0]["addr_info"][0].get("nodad")):
> +            ksft_pr(f"WARN: LOCAL_V6 {addr} not configured with nodad")
>
>      def resolve_remote_ifc(self):
>          v4 =3D v6 =3D None
> --
> 2.55.0
>
Thanks Jakub. We will update the setup scripts on our end to reflect
this configuration.
