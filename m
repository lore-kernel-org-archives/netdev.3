Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049D53E5A32
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 23:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791590070; cv=pass; b=Hbn/gLlxrDEUdfveuxQRfwVzd9o5m//tpWWFPywD1SpJt4a8se+WRDpXOJqH5COVNCMCnb2BXQxzoELCcLIbUan3YvIrOVfy94giu/O1nTcZd8jXkxGbPZeLuJXWGX4wDS6BxjsMHNQGFxLAt03d8fQryOsRYJTTRrAVGlJkYTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791590070; c=relaxed/simple;
	bh=6BbAOFR5ozv9YI2gjZqVkZoLPCjlp6tmsusKEhB3G6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S0s9hFmDDEb+ZZlzrWliXSvRhl2M+QTpdMxNuiOhITnFSI4qTj0C9oKJzLu/5h+GU9/6Y8H0QkM29nmkyNHQd6l54QfCOW1eBJH3Cg6/WKnQeF5LGtAb9B4/14P6EIP0D2+tPmrJoQ8xZPbgHYX56+ijyHObi4XGB331r7Io+Ks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qXmx/vWV; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qXmx/vWV"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6aae147ef9dso1286a12.0
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 16:54:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791590067; cv=none;
        d=google.com; s=arc-20260327;
        b=e1T63m6lt/8b9LqYu/tiShznFUrzsEs/C3BfxotrbI8BzyZqoQQ3QlHLTBgZfTMEcl
         ipPVsZvrA1Wr2FLgTIQSa7XwtQJ2gw6Dq3lcRZbMHEYwHWlF6gXSm0/q24Q9lfZHkXGu
         uvM6fLF8MEKk74U2BzreSsLNqVoqsl7CLu+D1lOFtFkiKvyWpzUIvKuKj1QpBAPWpItW
         5wUqbK5QeKk4/BqjzM50GEHwWQueHxfYNsA5AEKHc+BsmEts9+QsEN/5Y2+6UvSJ4igQ
         OYBXBHjbpVDCJZpbq0mdjZ3t4Y6kqlWfqW09zZ3Jgcqp/UEcoPpU+fu50CPjeIzYYPCb
         HVPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6BbAOFR5ozv9YI2gjZqVkZoLPCjlp6tmsusKEhB3G6Y=;
        fh=rrNP30epYdOaKbf99fCjWZZ3lcUL1xzKYew/aIJxob0=;
        b=ViYNCE/wB1P+hTMtfaAvoovSAiH0iOzlfVG/oAhYL05gW1FSkP94zkcVz3KSxsDh1H
         ePMi9R+4W9SY2ybYbvz83vlnjE9whMRETgqzZndqSHJWr4+jytctn0sf/bAqqVg3sh9R
         1IX3/BkkJwO4yA8qic80t4F64V5kjwcFG2FfzpJl2z5lLXeApMAREMd5A23SeVj8w/yy
         bEdCkVsxoMDNMgaojHeLiLZlR8Rtfk66DHUH0PBvtZ5zrP6A1mVSO/4IQaqH5lh1I5lJ
         y6rLH7A21iUAn2JAlCykm6GjJbcDNiXkJKYpakyEb6LEPitVqvCnLPKHfYZrK5SDeIQb
         A/tA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791590067; x=1792194867; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6BbAOFR5ozv9YI2gjZqVkZoLPCjlp6tmsusKEhB3G6Y=;
        b=qXmx/vWV0JJ5vLM3ox63kUAd6fadJkJAAwe2nPT3Rf5U0A4Q4Jw4YeABgEL5+euiOd
         dZs6rFvAd1+S4vPSdl28nKc+wMCqCvaImodHgr636n7a3UuA33QuqdcldgvGp2wCWbIf
         zBB8MviyksypDmJV1C+6V76SBNby1CcBvTY47GPFJb6jSkEGm0iTcCyB7JKaR/u3W0e1
         S+39FEuvIImesddZZPBVOjLGub96lPi5LDNYRxYHFnytz5woC81bc5P1QeJY7gsHR/ts
         orDd7Vh/eE7SIxPzqpvy4YU7xGpvqBIUJWFQFlL80SqDsmqYULnVZsPVPCm3X5EUrg6M
         FYmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791590067; x=1792194867;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6BbAOFR5ozv9YI2gjZqVkZoLPCjlp6tmsusKEhB3G6Y=;
        b=TwJbHzuMnbJ7/g917LzBPg+egn7cxDCFWo1p0bYa97eg97B4bP88xo8fZqSsZh18fH
         jSOYvHNaH78lFrOcBClMSNgwe/UALfHN6Yks6Piyp/uuFNvGadKXbW990qEisxAhBZml
         kqmaIMmHEij4mF0z9XpeRTm+Z8mLUYjfL+Whdx5Ipzp3uscrmgFrr0Pz7H700+2b+I8i
         UzKnTip7hd6Ww3UcEF2EzvtMPLA/w1zkOoYimydf+XTdXEJEManc4tPtcQp0qMAaolCV
         peGuLcj9GTjbWScurKtcmtC8p56tAuWGTTicI1XrxAqu6iuyV+f8cAx3KpDxKAcvofFU
         OwFA==
X-Forwarded-Encrypted: i=1; AKwUvBx+KH8KsKpcjICL5TZXGbAOGiKwyTQiumwp30f9hS0MKJndj1cgUJ3rO4Kbr3ObaxJzW9GTLJs=@vger.kernel.org
X-Gm-Message-State: AFq9FYLU8atwxU7GNLIF9/7hBEdlKoFo2bPpQOomfaw0tNQn/atTECjY
	QUBh9ontQGwAFZoyCgnOnZ6kh//HvM1KlPwvcZAOOtAVgydz3p6mL0G9DSxsU+p7Sj1f7yZVpTP
	KCm4Qirzbkg3DnCJiqyCBYQlQs369ftz5tLYlWDI2
X-Gm-Gg: AYBFou1DCgzLec2nHqXAFQFDyifpIzgOYwmD1gp/C/Y3nj0Qjf3NXD9f8EuP65u7VbV
	c3CyG0o05tll2ytzln/hWuFDen3MIlABYN4hJy3RqH9TRW5F3THzKxfoCkb4CWN+u76sftY6+s8
	KdsbOio5gRRkhCRR+uVxoQNY00cRiEiANlQTlSMa4ej5oDdxaBTr6+ak1ghDqBwTD+mReKQu0Zu
	LjQJVH28sISl7mrYprE3xL2jtlYDiEvLiC0ATteX9dOsqyKgeltsqeYh/IFZWJVDDn8iXxlUtqO
	Hfd7o7hFf4VXnxLOpnEu16e1CjAWVfb8aZy6jGQTn5/N9Qj4YfQWS5NKIV/zFUVT
X-Received: by 2002:a05:6402:1492:b0:6af:afce:184f with SMTP id
 4fb4d7f45d1cf-6b1988f1271mr5875a12.3.1791590066657; Fri, 09 Oct 2026 16:54:26
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008132815.654147-1-tariqt@nvidia.com> <CAHS8izNSo4YzXxD3C6c2HohdOfH2GK1M=51biuevLUk3vz5k4g@mail.gmail.com>
In-Reply-To: <CAHS8izNSo4YzXxD3C6c2HohdOfH2GK1M=51biuevLUk3vz5k4g@mail.gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 9 Oct 2026 16:54:15 -0700
X-Gm-Features: AclHuK_ZzbZd-uX5EqoDdsPJuuPhovZF16107otVMYSWFJ0lAZEAV_UPEgtn00I
Message-ID: <CAHS8izMKNeEmJM0wOgtoz9_3WRLUOqP0PEDMn5SZ+hXTKTwSyw@mail.gmail.com>
Subject: Re: [PATCH net-next 00/10] net/mlx5e: Add netdev support for data direct
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Paolo Abeni <pabeni@redhat.com>, Bobby Eshleman <bobbyeshleman@meta.com>, 
	Byungchul Park <byungchul@sk.com>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>, Gal Pressman <gal@nvidia.com>, 
	Jacob Keller <Jacob.e.keller@intel.com>, Kees Cook <kees@kernel.org>, 
	Leon Romanovsky <leon@kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>, 
	Matt Fleming <mfleming@cloudflare.com>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Shivaji Kant <shivajikant@google.com>, 
	Simon Horman <horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Stanislav Fomichev <sdf.kernel@gmail.com>, William Tu <witu@nvidia.com>, 
	Yue Haibing <yuehaibing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 9, 2026 at 9:42=E2=80=AFAM Mina Almasry <almasrymina@google.com=
> wrote:
>
> On Thu, Oct 8, 2026 at 6:28=E2=80=AFAM Tariq Toukan <tariqt@nvidia.com> w=
rote:
> >
> > Hi,
> >
> > This patch series by Dragos adds data direct support for netdev devices=
,
> > allowing a mlx5 netdev to issue DMA commands through multiple paths.
> > This feature is critical for improving performance and reaching line
> > rate in certain environments where issuing PCI transactions over one
> > path may be significantly faster than over another. These differences
> > can arise from various PCI generations in the system or the specific
> > system topology.
> >
> > Data direct for netdev will work with devmem by returning the data
> > direct DMA device instead of the DMA device of the NIC. Each PF netdev
> > registers its own data direct device and support for RX and TX datapath
> > is added. The feature is selected through a new data direct priv flag.
> >
> > The feature is enabled though a ethtool private flag. When this flag
> > is enabled, the driver will return the data direct device in the
> > ndo_queue_get_dma_dev op.
> >
> > During data_direct device unbind, a re-creation of the channels is
> > triggered.
> >
> > A note about the unbind: it does not does not tear down dmabuf bindings
> > attached to the data direct device; the recreated channels will still
> > pick up the binding via rxq->mp_params and post DMA addresses from the
> > data direct IOMMU domain to the PF, causing IOMMU faults. A devmem
> > revoke hook is needed to close those bindings before the switch. This i=
s
> > out of scope for this series.
> >
>
> Elaborate on this please. Are you referring to the fact that on
> page_pool_scrub we unmap the netmems dma-mapped by the page-pool, but
> we don't unmap the netmems dma-mapped by the memory provider?
>
> What's the impact of leaving this unfixed? Is the machine going to
> crash if the device goes away but we don't unmap the dmabuf?

Oh, you're referring to an even different bug than the one I had in
mind. (I'll see if I can submit a fix for the bug I had in mind).

But in general I think not addressing the issue you're referring to is
way too messy. I think we do indeed need to unbind the dma-buf if the
dma-dev is going away. The invariant should be that the
binding->attachment->dev should not change at all during the entire
lifetime of the binding. We already 'revoke' the dma-buf binding if
the netdev is going away, sorta (there is a bug there I need to fix.
The uninstall function in the provider doesn't actually unmap the
dma-buf :sad face:).

I've worked with my LLM to suggest some changes that (we think) make
this work, but you may disagree. I'll post the suggestions. But please
I think this should be handled one way or another.

--=20
Thanks,
Mina
