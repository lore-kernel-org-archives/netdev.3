Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CC44A9D64
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 09:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789551494; cv=none; b=nxbERNcpt3/f4vWxizn2esCySZT3BgsILYKuVFteBPvkYEsek1AJrIuL63mkPYnfkxBBrByAqSUwmVBESHK2gElLFZ6eYKcKzURTPt78QcA/quLrYGNIW+zslVhAIcKEhH61jlZeuZdiNNwhlEe6LhgFplZi2CDClcqUTyH2vyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789551494; c=relaxed/simple;
	bh=3baOdg974HUmmv9l9qSuEzqtxn1tDQf7zOw13pNLG+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xsmk6W+77Cij7z0HuUWY/T1lYs5GSb/6I468PUZ7THuAqRIEb6NG7M9GAg1Vjoc8fDNes5nCtDKBuVD1oZ8zxa8a+W17sqg0iUsKRtAnMm6a4fY3+hu8Zt4NuDddGStqD9OISR7jeXrinRrRz0MFBq3LgidxnVG2Unv5o74f21E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P6ZgmRH/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z6PYw+Y/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P6ZgmRH/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z6PYw+Y/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789551480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WcdoeGcksDypeiVaN/UwL2ap9YHkvKvd99bqBDhenTA=;
	b=P6ZgmRH/Q7NHLLSuyoBl23sYrhAUHcNUh1w4vmuDf++eUoP7kRgDiqdby6icN4lkq9uA6r
	8cjdYKltpR+Nwz1+WecEdmQKs6ZktuynVVCAwUhXr8oARwTOviz/g6T4DKG1+/B8W6X+dE
	bq51DGrUH8ooI3AmBfhbJWTMZptYtf8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-yrCw1OUANgiBnIUNXUybfQ-1; Wed, 16 Sep 2026 05:37:58 -0400
X-MC-Unique: yrCw1OUANgiBnIUNXUybfQ-1
X-Mimecast-MFC-AGG-ID: yrCw1OUANgiBnIUNXUybfQ_1789551477
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c2580a59d0dso544837266b.0
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 02:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789551477; x=1790156277; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WcdoeGcksDypeiVaN/UwL2ap9YHkvKvd99bqBDhenTA=;
        b=Z6PYw+Y/6RtRCvIkzScPaC88xcn0FwTkyHY2dYnNVMTwKfdAV4ElprMuDEzSkiRRwo
         hdv2aOD/A+XKfekaf4h6QskyhA1h0XjMciijEIlkO3G5peCVRjuNi6yChvkWxE6zNj04
         OJMHqdDBFpO0ZGTZCyKDjmtje7R0cEgFeS99wWk+KsHo/90/+Wz9qKymyKtyp+0gEXiS
         1d/4mtadBoiguu6Jlqq6CrVmbES8HcIWBjFdCoUUh/zJ61YL0OCeECkYv/rcUBbTPv0K
         uYKDBb7hDQV4jrh1nDbmPoyeTtaxo2ToRg7pymF/2ZJs5s1pSKDka4EiLGfeAzPJvM4h
         kaog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789551477; x=1790156277;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WcdoeGcksDypeiVaN/UwL2ap9YHkvKvd99bqBDhenTA=;
        b=skOqB3b8e1ze2K3FRtOucwtyaXq0u01EIKPAwDkxfmRwpa+d2Oxj/gFEJPpgXE3yH5
         dCFuFFmMr1IQh1L7FGcXJRHKr7OrDC5MTR63WwE62JYJc5joPbrbEKIuqed3j9P1kueI
         VoKvsEoRoDkwOqOFeP2ycXSPQv17btpHdKst0yXwSHPXXMM0dH7ohqjMmeuyI/Z7mEKp
         FkG5ioEypkAAyjNAg1+QO4UtLKpwq2Vv59WnvzaBZvAToF+Vw1A0XSPS2xhgJRirPQKF
         8NtdcP37QtcAgZSz2yrTNEOTLoq+Cvyy6oOHTh8sW8cStaVshMP0grlw3pP/cBXntg2Z
         Z1ig==
X-Gm-Message-State: AFuF++mQAzj9IgmIjmzjxvz0wba48AZTPtc8cGlZgIPjarFXfy33ymT4
	QZdzs9nsbu/yy5cZoitc+aU/DeOBN2PxSUz+oFI99hQqbI7dXkXDa4BG+2Pm9S+fDrIlCxVPOeo
	3HH4+SVKc/doHvF2uxQjWomSmJuQzXaWzaK22ywJZRaUw/LzKF6cyfX8KJw==
X-Gm-Gg: AYBFou0D/xgXXMfMPDwggfSfTWLsLY9JocrvaVy05zprBGiPm7g9h4/0lxm7dEZ+lsf
	df+oO5XJzrB0HglgbFo0Y5fjwU83zKk4oNIPhRWP7RLMrC1JsB5gZiJaFqum3sa4wlfNl07iBhW
	sPMxQ1TXZV9m0T1ls7XO7yAwC2mQP8OslZsSksfF3HUaG5XBU0EUiCdpjSUXGVA5oAaWHgzWzmu
	RGA3hbVqLlI6QGPHt3I95ProW+0Voz0fFm7RArWH+7jxQUh1ILLh4/q8JtMLAbUlFm8o5vYuCrd
	8CQDtkE58B9IWu3jlrHf7ISTuBVdZmDD38WId1sLYzWwY1n4nxVzyfg18Q1PqyeywJFfNo6CVuY
	1UmUBJURihkShaOZTnC6/zrL5qtYwkubjCm+4iKqNfctr4g0c
X-Received: by 2002:a17:907:c78d:b0:c29:43fd:e43b with SMTP id a640c23a62f3a-c29e5392d7amr120300566b.28.1789551477220;
        Wed, 16 Sep 2026 02:37:57 -0700 (PDT)
X-Received: by 2002:a17:907:c78d:b0:c29:43fd:e43b with SMTP id a640c23a62f3a-c29e5392d7amr120297366b.28.1789551476716;
        Wed, 16 Sep 2026 02:37:56 -0700 (PDT)
Received: from [172.16.2.95] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29de6903e2sm97981466b.60.2026.09.16.02.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 02:37:56 -0700 (PDT)
From: Eelco Chaudron <echaudro@redhat.com>
To: Wang Zhan <wang.zhan@smartx.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, keyong.sun@smartx.com,
 Ilya Maximets <i.maximets@ovn.org>, Aaron Conole <aconole@redhat.com>,
 dev@openvswitch.org
Subject: Re: [PATCH net-next v2] openvswitch: raise internal port TSO limit
Date: Wed, 16 Sep 2026 11:37:55 +0200
X-Mailer: MailMate (3.0r7032)
Message-ID: <C381651A-DA84-442F-8F75-577946A0E437@redhat.com>
In-Reply-To: <20260916065844.1380155-1-wang.zhan@smartx.com>
References: <20260916065844.1380155-1-wang.zhan@smartx.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-MS-Reactions: disallow



On 16 Sep 2026, at 8:58, Wang Zhan wrote:

> Set the internal port TSO limit to GSO_MAX_SIZE (512 KB), as for
> loopback and veth. This allows the admin/user to set a GSO limit up to
> this value, to use BIG TCP for traffic routed through the internal port=
=2E
>
> Only the capability limit changes: the IPv4 and IPv6 GSO and GRO limits=

> remain at 64 KiB until changed by the administrator.
>
> Validation used a same-host test with a temporary OVS bridge, a veth pa=
ir,
> and a network namespace:
>
>   TCP client -> OVS internal -> OVS bridge -> veth -> TCP server
>
> The veth endpoints were BIG TCP capable throughout the test, and only t=
he
> OVS internal port limits changed between 64 KiB and 524280 bytes. A sin=
gle
> iperf3 3.19 TCP flow, run separately over IPv4 and IPv6 with six
> alternating runs per state (`-t 15 -O 5`, fixed CPU affinity and port
> tuple), increased throughput by 18.1% for IPv4 and 34.7% for IPv6:
>
>   protocol  BIG TCP off  BIG TCP on   CV off / on
>   TCP/IPv4  65.567 Gbps  77.420 Gbps  1.12% / 0.37%
>   TCP/IPv6  55.355 Gbps  74.568 Gbps  1.20% / 0.68%
>
> Assisted-by: LLM

I think Ilya already mentioned this earlier, but the LLM tag means you ne=
ed to fill in the LLM model name you used.

The rest looks good to me.

//Eelco

> Signed-off-by: Wang Zhan <wang.zhan@smartx.com>
> ---
>
> v2:
> - add an empty line before netif_set_tso_max_size()
> - rebase net-next/main
> - cc all the maintainers
> v1: https://lore.kernel.org/20260910131635.780802-1-wang.zhan@smartx.co=
m/
>
> ---
>  net/openvswitch/vport-internal_dev.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/openvswitch/vport-internal_dev.c b/net/openvswitch/vpo=
rt-internal_dev.c
> index 125d310871e93..77a16d5ebd543 100644
> --- a/net/openvswitch/vport-internal_dev.c
> +++ b/net/openvswitch/vport-internal_dev.c
> @@ -117,6 +117,8 @@ static void do_setup(struct net_device *netdev)
>  	netdev->features |=3D NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_STAG_=
TX;
>  	netdev->hw_features =3D netdev->features;
>
> +	netif_set_tso_max_size(netdev, GSO_MAX_SIZE);
> +
>  	eth_hw_addr_random(netdev);
>  }
>
>
> base-commit: 87b80c2f6b05cad9f0ff9136709c62a0f59923e3
> -- =

> 2.47.3

