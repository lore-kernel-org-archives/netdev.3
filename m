Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792603055;
	b=G2nXA3gA8zKFeRT/HZtMoS4xVO4I+ywbvGBL0Zf9SBYrt4hTy8EJgOuqO2QmreX6aadW
	 fwOauuuRBCPqLEsoIYz6YtRAdtihyF2bDkInHAPPd9FKfGIDOuSBvL00MXVaI1r096n20
	 IrOIdfcUj+p//M5QZa4mQXPwpVwk/TH5A+TQR36oecNCHLXVu/2PsTvp9uXT+r+PJOAEt
	 Br6onW+U70xZtHeItuwCaTfYqMyNRHq6qCboDuvmvA4WJjcB8bT+QiGdAGADqqR6y2Muc
	 EDvx4AlAVySUWUzzWHcCFTX0g5U0BIr/xvwkzYVRNjG5oNiMet8bOauiSdh4wEKFztA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792603055;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=XRup6C3XRPCSpEmzli28tq/JP1tN3ECHcE7lVuoPftk=;
	b=3BsI1yux8xObJR/oAo5t05Lsj1ff3eujklpPzwZsA041TDFcfTgXpsmItVpYzCg9VNVA
	 BkExMKBvw95pA12EuVU5pwFBstbn/wGAJFgWpujNY70uRn2qA8OR0uWRSCPx7jKhiGW6Q
	 RNuG2aEagTPYiD9U0AdJdjQDb5BYVBWmwGSNtwNr/pad8q+uxb1Ui7lPKdWXNFfGY4rzk
	 8lTkrcdArt+sjj2u4ZFe5bD4sIf5wufYSCTQyl5ovfIEElVhFwD1faH3r7Rl1Vr49FbZp
	 QrWOeWZJq0hgBPM3dV3LWkn2gRgNShRZV9xWX3Iz63XpuS//4N6T7frOVJzRW06Fy5Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C2E606A319
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 17:17:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9C2E606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b1aa36fc0eso538a12.0
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 10:17:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792603052; cv=none;
        d=google.com; s=arc-20260327;
        b=DtGqAXYUx0RDGtc3rDiRE8P8euMVF3rm9Pu2sl2fQ7tsJMCoV6y5dyz0tErTkehq7o
         1hGVFMmWXArb7Ggto9u6FdWh50FffubLOYZBhmKsNkNgiEW5nr2rxfp1lRFxTKYrgZl8
         D3Ofyuq8tvUaArL6z2j23GgRCvg59p7viGi333zt7ACPuRpH2rCPYYbcRDzHAIUclKbf
         wiriby0WhVZHvKErwBIyq1Dxu/JjaZ4Aqq4F3J1MHA6y1H+kdlsV9SHrPWeHAEWp34H6
         oBzL7ZFsj7FYAP4mL1BxABiXnAyKmI+Y2/x9y5Wb3s/RklOvIwkmFAB+YTC4VpBxCLlR
         3/Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XRup6C3XRPCSpEmzli28tq/JP1tN3ECHcE7lVuoPftk=;
        fh=5P39wOub7ruPg43UHjjwFVZG1Y5/LoLKLy/bzbkj0CI=;
        b=JV0r8f8yx4A87kj8LAZBTmsHKkEGZSkp9fHdnwjxprXuWwpDrVPQM5z3BPqlpij6bc
         2+G6TE9+PL64Wy0liu9o0WhPXg36DxMZDD97fCO12qE4hu1p3xw5KPp/3XBY/avYGJ+5
         mwD8xZ9bkwUwFGDx6aJsBWwCFmHuZJUGHWP0zBdi+Js2fqVVjL+cJecy9tdPJR3ucGi1
         dvyabPolvDyUoCyVI8sH6YI2uA8mAGwMKvV3zesM7VYB8bu8pJEzuRg2SpdsIz4qjMFF
         c1x5kdR+OEDjsO11FVc7407SvJ+jt52eiqRUZECv2zjTUykty+XQdDoW5CV6pDVRgaXX
         p47Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792603052; x=1793207852; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XRup6C3XRPCSpEmzli28tq/JP1tN3ECHcE7lVuoPftk=;
        b=HY/AavLi1D1D7Dx7qtYdLLnvUaSCh8Dyd0y5DqAqezDILat5p9bMgUFGCCZ/vLZSMw
         a8i0kgwDVTP3m12FUGNvDYdeBYpUxCUCkRJEWSxS7fkV5ylYluUXalk76SU26plnsvjv
         8XRVD9hrUmxNLgbY1iPmu1E11oDtZ9A/62t87hArGu6M3j+lXNRkPg9OcMv644OP2sTm
         Q9iNzJOt17lcMYg/u9RXNViXDBtwDRYVSEd22fiBtfGGnbmZQ2AieoYDDYEmQsPrnj2J
         Ajqa9ZfFo2Wt66sVRRdtAFvXmcOeAS0kZFaU6kjk0Qi6OaCdqUDwzTf1CrZD5FXaua3T
         bInQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792603052; x=1793207852;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XRup6C3XRPCSpEmzli28tq/JP1tN3ECHcE7lVuoPftk=;
        b=hRX8aCRE7/DmK4odOd7WliFATk/d69rDcPLjg2ucaZ+T0NMNVvuwnX6xNndxzsphX/
         oK7w29GsFo44a8kyNOfxaYGTD1dNmcV4R1Qgl/Gl+6VckeswuLg0h095CiDQ5UhqEKh+
         g7kcQIE+pJaIrrweNqFwkVhFcODhPeqBkDgMxrLRAfi0RHcE9w9WacvElzPYnzJWRlCW
         vClkelmMx16WhpbXcxb+PWPwtjVQgAQ4sI45bU46Cq8Jj2LTqPP+KxlacDvStBq0tH4r
         ee2G16eAgjqF3HOFCDwX4tsrAHulokO2YqdX3yq8GoJ6gHBwARZFNbTUclBDK73KUnhQ
         DRpg==
X-Gm-Message-State: AFq9FYKGeI6xGFO948E9hgBZn0RnRis2/bSDUobriFc1lpWuZ2BxW6ZA
	/qM7NXqfwoZSAdnmTqgKqbIdl55nLrJHBAb2hWcLK/MXgGpB6wjq67aG0ZZwNbMIRhIKV+UoZ5D
	P1gdj8DxeMMzYXsdaJ7DhVIl12l3gR7TaWVO/1dp2
X-Gm-Gg: AYBFou3zDM4Xwp152858ZBcg6PPPTZPWezz6lon+c6ijNrj8lcWLQjWD0qP5Kk24+qR
	G4DdrWK4gms2HKzQGe0Op4WqJYRmGLVDehGuCc67vrSYr/On+eMqgdXIKs69h7bvREHCIFjGq0L
	7txWSppCwk7WYpt5bOe+1KZ0zJLrqJCp/BG0+ZQXD/0OYW3WW6GPFB8gvbBPN5pI/0JjgJocanw
	Jbicd59opOXBnyBC+XrBYZk2sDb/TAajEQGge20kapBh3FnxmKAtqh+Dp7Aj0+HSFSoCtAxhvbn
	hnINb2Gt5mrbcozCX+3H9/SGP+RidoTPI7sc5gygipPmpeL07HhgM0HbccD9YCrBY8VitFHIeQz
	8qqSRPEvjrFkHUCEvcr5aODvJT4xkQp7ld/hisAJmNp5f6Kw4//7WbygSq8Fx+GtrN3Q=
X-Received: by 2002:aa7:c2d5:0:b0:6b1:aa31:a627 with SMTP id
 4fb4d7f45d1cf-6b3e8a7add7mr150972a12.4.1792603051505; Wed, 21 Oct 2026
 10:17:31 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021015558.4124825-1-almasrymina@google.com> <03a741b8-f330-4d2c-9254-153934ef0960@redhat.com>
In-Reply-To: <03a741b8-f330-4d2c-9254-153934ef0960@redhat.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 21 Oct 2026 10:17:19 -0700
X-Gm-Features: AclHuK_EJKqmd9KTi_vMc4o-3Uq3hWi-8BHGxz9Vq_xc-8LR-KADjsUH5zxRkyM
Message-ID: <CAHS8izPfDdqb+GLJu0sSPP4ZcwJ6xk_4p5ELCkjq4o98t6GAUQ@mail.gmail.com>
Subject: Re: [PATCH net-next v1 0/2] netmem: rename non-pp ref helpers to *_inc/dec_ref()
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Sabrina Dubroca <sd@queasysnail.net>, 
	Ralf Lici <ralf@mandelbit.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Pavel Begunkov <asml.silence@gmail.com>, Bobby Eshleman <bobbyeshleman@meta.com>, 
	Willem de Bruijn <willemb@google.com>, Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I should have said this in the cover letter, but this was intentional
Paolo. Jakub said that getting this rename in soon may be preferable
so that we don't cause churn for backports:

https://lore.kernel.org/netdev/20261020151352.794bf03b@kernel.org/

--
Thanks,
Mina

On Wed, Oct 21, 2026 at 7:09=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 10/21/26 03:55, Mina Almasry wrote:
> > Rename the net_iov and netmem non-page_pool reference helpers from
> > get/put_net_iov(), net_devmem_get/put_net_iov(), and get/put_netmem() t=
o
> > net_iov_inc/dec_ref(), net_devmem_net_iov_inc/dec_ref(), and
> > netmem_inc/dec_ref() to follow the object_action() naming convention.
> >
> > Use *_inc_ref() and *_dec_ref() rather than netmem_ref() because
> > netmem_ref is already the typedef for the generic network memory handle=
.
> ## Form letter - net-next-closed
>
> The merge window for Linux v7.4 has begun, and the net-next
> tree is now closed for new drivers, features, code refactoring
> and optimizations. We are currently accepting bug fixes only.
>
> Please repost when net-next reopens. There is some uncertainty
> about how long this merge window will last, so please check
> https://netdev.bots.linux.dev/net-next.html
> before reposting. net-next _may_ reopen on Nov 2nd.
>
> See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#=
development-cycle
>


--=20
Thanks,
Mina
