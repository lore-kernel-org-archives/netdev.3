Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081274A3857
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 13:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788529851; cv=none; b=NFUeI3AV/vI1U7hBKZAMbTW4LwcuAfgkIUrM/tpGNn2twGUWvoog5F53OlC6JeFk6L7zyH/tBKWyEOgQ3q9YPxqj63txv2oxZ2HZS14VuDPWXd3ylpaV6LfF97yU17m3H/pEWgdUn0IfVChxAMbqSdYVIj4gP9Bg1JhCqlXfY+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788529851; c=relaxed/simple;
	bh=Z8hNnyHSVmt549ei10OsDc7fux/5aK6L6Q+U/yY2ZJw=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=DjKbfAbCb+OZjaafdNTCtyntLqEWr46dAq+mVA8ClrXWHjDnCJkSVBa1row2IUNIdNZxPET0MQcocNLeAEs+JiuW5hTfe9kboXQ/g0kET1G7OcCJIve3ygI8vHz87ydc1/cSbzO0ZfJ4+NGsGl34RqrJE3eNl4siZR/LlBD2f3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TQFelx79; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQFelx79"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5300bdf61d9so12716991cf.3
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 06:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788529849; x=1789134649; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RloxBmq1OFFdMW2QFzzJPyBKTHQtM11rCubg4Pmtdw0=;
        b=TQFelx79SVUXXk6lPuhJkCpNgaMkUrKUBvxqQfxohmyi9xBVmosK/MQjKHh6cJDyOc
         osRB1ymPJcn7Cv+hbYnmld0znVmwVN20tnZZas/tFaar2aXm2/nV++oBqfK1VEkvVwvk
         FQ2FAmermUrsgjpeDDBOCnSofvfnRQ33piuv0X8JVt5fzJo5EVy7DxWUHVwAHmFbLDkd
         QJ9R9g6p3baFaj4+zUR1I2OWxDOVzISlhO3wADzQkzwf9PJ2CejpVpInaA6xQksstza2
         VNqFu7xMhyFVGbwoRwQVDe2dhEOK/lGGa2GmGTjDnxhc1GLT7kw24Nsod6YXjDxPJX/w
         KLKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788529849; x=1789134649;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RloxBmq1OFFdMW2QFzzJPyBKTHQtM11rCubg4Pmtdw0=;
        b=PgddMZpcjKBioRzwRL3XsG5GB6P/crjkhYzPS2TvDxtjuAGTpbnw/ZHhi3UmA+ROfx
         qsJ4RE+DyiKAsluy4LEuio+wUNa1aosP/UW7qgWFezwDBPE66o91PFC7fUrGc02IqSyC
         OAfoTayhnubmdF3jzEqKaE/dNHP9D25vKoUryelLVu6H0DGKDtU8ZP4xu28ya384bN9P
         zqASrI2RAo2LFidWPaychm2dVbK0tNu+dHvY1mXfgIuKLnK3M8G39BgObUwic52tAIrV
         iKRn2T9Yo8TydZ0NxMzygUzTRV4cHhHpMWearapbN0DFoD7N/9A2GEppfipbAHT2f6XD
         9LpA==
X-Forwarded-Encrypted: i=1; AKwUvBzfgjYL1PJV/tgaYNdZZyNnS4eeY+t5y3UJiFviKgOnp2zB8R1FD1U2u3kJgShtOcvNONweVto=@vger.kernel.org
X-Gm-Message-State: AFuF++mdvozTYFfE1junRU6AqZLKpnrqgjoQlu0w2ecp2MQQibaYvttA
	ZEeFC8n8OO3/7toKz7fpgMp/Z/0OxctCi57F3P0f+35LZYDyphOjJxf5
X-Gm-Gg: AYBFou07UzehnYqxuvWR4fPy4YSWWwZlqGq2ChQ2YoO7u5cYF+2x8kVT36swDuUw0Qe
	ATnvFNK07gxPCoNpeB+hkg9T+im6qWUPx+2bLsMRx7o6r2YY1aZGDHld4yYLIPcK83AlLfeSVub
	buZt5FWRyx1a6Vo0NNcejBEIGY9Sx3PsMNpCCiCNa05TwYkKOE/gDtG7UDfn3hY6jp/jCMjMMao
	JeiwbekjDGYPdaDt0o/mUoWuPICOi1XGGWVAQFSmysKsDQswXw7Sjjm83CLcTbmCS2OH9LUWPM5
	Twt3xZKND+ZJSZvx9F+xitgkC1Cr7gTvCTXDrT/RMFXEWsmrT3TNxJ5J1XSqcswaVCAFC7moFvF
	5qeG1aDnPvBzPPBwLfhqOmOOKEKQ6uKafTe7in7jKjiz6iC4J92Wj4qeGKHUP0JB7/SlkTdlIYS
	ggNmNaaTYcOE1wZvkvZGbWY0JBBV7c8t0+OZSGtPpdbHIkBkvxXmGm8do7+rHNAd4JvQDhQ8AbE
	OA3
X-Received: by 2002:ac8:5945:0:b0:530:42d4:4c9a with SMTP id d75a77b69052e-53054a34924mr61953591cf.44.1788529848638;
        Fri, 04 Sep 2026 06:50:48 -0700 (PDT)
Received: from localhost ([2600:4040:9399:4000:e553:72e5:7d37:c7ef])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-910406940f3sm20714426d6.38.2026.09.04.06.50.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 06:50:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 04 Sep 2026 09:50:45 -0400
Message-Id: <DL6KX0CC3BM1.1GLV02ZNIK4M2@gmail.com>
From: "Daniel Zahka" <daniel.zahka@gmail.com>
To: "Tariq Toukan" <tariqt@nvidia.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 <netdev@vger.kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Sabrina
 Dubroca" <sd@queasysnail.net>
Cc: "Aleksandr Loktionov" <aleksandr.loktionov@intel.com>, "Alexei Lazar"
 <alazar@nvidia.com>, "Alexei Starovoitov" <ast@kernel.org>, "Allison
 Henderson" <allison.henderson@oracle.com>, "Antonio Quartulli"
 <antonio@openvpn.net>, "Anubhav Singh" <anubhavsinggh@google.com>, "Bobby
 Eshleman" <bobbyeshleman@meta.com>, "Boris Pismenny" <borisp@nvidia.com>,
 <bpf@vger.kernel.org>, "Carolina Jubran" <cjubran@nvidia.com>, "Chris Mi"
 <cmi@nvidia.com>, "Cosmin Ratiu" <cratiu@nvidia.com>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Daniel Zahka" <daniel.zahka@gmail.com>, "David
 Wei" <dw@davidwei.uk>, "Doruk Tan Ozturk" <doruk@0sec.ai>, "Dragos Tatulea"
 <dtatulea@nvidia.com>, "Gal Pressman" <gal@nvidia.com>, "Jacob Keller"
 <Jacob.e.keller@intel.com>, "Jesper Dangaard Brouer" <hawk@kernel.org>,
 "Jianbo Liu" <jianbol@nvidia.com>, "John Fastabend"
 <john.fastabend@gmail.com>, "Kees Cook" <kees@kernel.org>, "Lama Kayal"
 <lkayal@nvidia.com>, "Leon Romanovsky" <leon@kernel.org>, "open list"
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-rdma@vger.kernel.org>, "Mark Bloch" <mbloch@nvidia.com>, "Matthieu
 Baerts (NGI0)" <matttbe@kernel.org>, "Patrisious Haddad"
 <phaddad@nvidia.com>, "Petr Machata" <petrm@nvidia.com>, "Raed Salem"
 <raeds@nvidia.com>, "Rahul Rameshbabu" <rrameshbabu@nvidia.com>, "Richard
 Gobert" <richardbgobert@gmail.com>, "Saeed Mahameed" <saeedm@nvidia.com>,
 "Shuah Khan" <shuah@kernel.org>, "Shuah Khan" <skhan@linuxfoundation.org>,
 "Simon Horman" <horms@kernel.org>, "Stanislav Fomichev" <sdf@fomichev.me>,
 "Stanislav Fomichev" <sdf.kernel@gmail.com>, "Willem de Bruijn"
 <willemb@google.com>, "Willem de Bruijn" <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net-next V3 15/15] selftests: drv-net: Add PSP HW GRO
 conformance tests
X-Mailer: aerc 0.21.0-threadmapfix
References: <20260903085215.3691657-1-tariqt@nvidia.com>
 <20260903085215.3691657-16-tariqt@nvidia.com>
In-Reply-To: <20260903085215.3691657-16-tariqt@nvidia.com>

On Thu Sep 3, 2026 at 4:52 AM EDT, Tariq Toukan wrote:
> From: Cosmin Ratiu <cratiu@nvidia.com>
>
> Add PSP conformance tests using the same gro helper binary as gro.py
> does, but in --psp mode. SPIs are procured by psp_gro.py from a real PSP
> device and handed off to the gro sender & receiver. The sender crafts
> and encrypts packets in software, the receiver relies fully on the HW to
> decrypt, decapsulate and do HW GRO.
>
> Because the NIC decrypts and decapsulates before the frames reach the
> receiver AF_PACKET tap, it sees the plain frames and the assertions
> remain exactly the same as gro.py.
>
> So these tests verify, at length, that the device does PSP HW-GRO the
> same way as plain TCP.
>
> Additional PSP-specific tests are defined to check that GRO doesn't
> merge packets across PSP versions, SPIs, encryption-status, etc.
>
> Some tests from gro.py are not included because they don't work:
> - ip_csum: the checksum is recomputed by psp_dev_rcv().
> - tcp_csum: packets are marked with CHECKSUM_UNNECESSARY.
> - ip_frag4/ip_frag6: PSP is incompatible with IP fragmentation.
> - IPv6 extension header tests: PSP doesn't deal with IPv6 ext headers.
>
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  .../testing/selftests/drivers/net/gro_lib.py  |  14 +-
>  .../testing/selftests/drivers/net/hw/Makefile |  17 ++
>  .../selftests/drivers/net/hw/psp_gro.py       | 172 ++++++++++++++++++

There's a chance I don't use the config snippets correctly, but I don't
include configs from parent directories. So maybe add CONFIG_INET_PSP=3Dy
to ./tools/testing/selftests/drivers/net/hw/config?
