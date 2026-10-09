Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354184EDCC5
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 16:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791564181; cv=pass; b=Nt7rLppZ95OUej5VfBHBjiDrNWjAv/K7ACh/d76kSHOX7xk/WXZML7i9yBqqFiAfnTnmvDp8mxGIGyxYZXT3v/iJ7pPO5DOzmnrCmDy3cV8rP3jSPn1t9I82sjXaLGx/Xs+lYVsC4B4d7Kwtoe/MLYKDklRmzqDDcXZdcdKo8dg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791564181; c=relaxed/simple;
	bh=8yVafqw/tymMZHiBDDTV1POQxrFPmsVlSQFwXIA6JgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dgghro1UCeq07mECLq73Raj1ejBlgbklh6oBQgFA1gVx3zb5XaVsJ6VOuMByCGeT6Vvgh/Wl/UMN9mnuwpkKLKDwWfebmidy4uA/uMYyNH9dLNx5bggjYS00K+gRPPZnlZJy+vtx4AXq4DbpUSYwxT0JbxoTzlJtkLPXVwyUj+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CYy98r9I; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CYy98r9I"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6ae14cdc63aso12973a12.1
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 09:42:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791564178; cv=none;
        d=google.com; s=arc-20260327;
        b=sJfu0qHXt7hD6MF1SX3sflxSp5yoyqlJjh1xs3a7tIxF2/il15gf3lU9bxDLKlWmYL
         YZQg/5j99AXTtqOXEzLusO9v2Nw9/FWNwzOLfhojIUxFie/S1Le795owH1psHebFET8Q
         O5Tg3jvbURl3nM85BZJzNQMiJXjUxqMqbqQ2DU2rEUA8nzV/8Od6RIG7aTPvG37PbtaA
         eASBrrGKfPyUSomnWWi3YHKb88z5E6IPAkeVkrzNv43gSJR43d/dM5z9M92W2Dv1tQjf
         gdxwwCfZ3vLpX0IGMi1UDFnzXyyD0E3+c9TZn3gpDZUp78Z9PIu7yu5tFtOCQWZGImB9
         HvmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8yVafqw/tymMZHiBDDTV1POQxrFPmsVlSQFwXIA6JgY=;
        fh=FEAnrE2ujmYG5+k+3V5ON09DnokEKZXWQl1WWaDVTsU=;
        b=h+bTjdAB0C5ZWxdB+D9awKXlEkQEgzBoDZ4HOGmf+YsKGf4UQwqYhNmlm6+iCe/XtO
         qN2D9EvTVYw1QVQQ9bUicozWv1bbSabQnSM2hkNvOKLJjnOk9YF39wl+dGNQip7VKfxo
         v69XhlJwA4kj6tvCNOZmLMf8+1QeuEdDOIyC0TkGJahkmYun12X2xBW7sMnQNajVCXiS
         fVM/RIRihKiqZwpI2GdSPE2+yd+ipcXZhmQZA2qsazevlmlwyFTQVqX0PG8bkJ6HVIBV
         C75J4QRzenPXdPbIYWUgvUmPy3FIXewhxksp6xZeFo4coURMx5Av6IMeBKqjosgKq1hx
         hBHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791564178; x=1792168978; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8yVafqw/tymMZHiBDDTV1POQxrFPmsVlSQFwXIA6JgY=;
        b=CYy98r9IJfEnurNzNStEF1xcp4Z2bhfU5tIS/5Qkj1YvCO5RwuY3PzCnEkisRbTpsw
         P9qoUg8wkhoUkSi3ugQHHUvIsgiurnNAIueYz/HwXLM4EBd2sthNhi7p9Ro7tFAVIu35
         57WdtKULZkCZDP0ZtlX4p3rGTIgudWfh/VeS423w84ibFdLCRbQgX5s+YzDxD6k4rgSL
         Mj8g68bRZNysAUn8vQNr+qF2WbNAC8PVsvRYm5PoTD/kwXFDd9QPFY5vb17ksWm7z7m8
         DIJH6+bSPKp9YXu6k/J4z7aSQjD70oFJl3fLHjlRUxNvOwqwQiv/neliemiVzJYOO1GI
         +uPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791564178; x=1792168978;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8yVafqw/tymMZHiBDDTV1POQxrFPmsVlSQFwXIA6JgY=;
        b=bwnUsFRVmlOAzDyebvfLIfQM3Z9H4ttt1FPgl7RLk5/jFSZ4JIH3eJSlJrYtrtAuqf
         S1tJgL0EDF8cfrzMt0TP36DzytzEn9KbzWAUYIKL59ZP8yN/GEWA+3M/JrgkzdVK5FsF
         oJATbXsAxhldc1d96dP1VOn0c5Ixswowq+g/8VkCdy32ttax+Lq7PFUdlC1mR80t/Qld
         a8KENbAAKCRmsaNsSQ6+PqzW0n4kJLe5IBe0KUrQHuGvQGBkizIcX1PWh1BTVCVnL4GL
         fkwhzu/f6AsWHENpkWhfWt18phQtEnM5JRHtGUeTGdFR0O4HLddGpc8QADUNOyN2xhbd
         UN9A==
X-Forwarded-Encrypted: i=1; AKwUvBwnowXGAzgbQy/mA3etWX9zUp6DWlxnseHoGyzcB7wEX8q8IewIiEopPl0Al0hdKXbNRkvqhYY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKEde5GAqzYdl0R30GEPgLvix9m5RcTPOlhOrCWpFkvU52BBVn9
	Ks5dYzBIhr5u5CRtYsde+20juoeJ0jPhOVTYcraiSpkrHwrBZHqaarfQDjZUHGEP0HTCJF3n1QN
	NkSLIccB8QSU+UPMjHI0ENamYqE7IRqjqiDLOwu11
X-Gm-Gg: AYBFou0GsF1QHRrg/aDaXysjFG4kAHAxNsXIqtI9nKWjy7dtDvoihYDX9bFrNKJ+s3N
	VX0Wp5j0BArR+f0JOQl29jWPE/hus/9M3HjiIlrnQtntQeWdi+Hd0p687OdjGR/SpLOudR1dsU4
	BQ15CLPWdr/o/NIyKBUFmvt3ERKQ4xdaFZ6GgSLo4lRPE7JH8+ajr5BjDfIqwA52SZpgG9dsJbA
	dVLJdKrP3UgQU4JwE48B9QVFCaQ1xzjVtBWFdt7a4pG0tpLYeMO/0y8EJn0mqe/ePHg8DRkZg7C
	dWlz+UxheUthGTy9or1M+Z40W7WPBr0uHaIx7sw9CVQRVsp/LKhQRg==
X-Received: by 2002:a05:6402:c553:20b0:6aa:b72b:d762 with SMTP id
 4fb4d7f45d1cf-6b1776e1bf1mr53790a12.1.1791564177860; Fri, 09 Oct 2026
 09:42:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008132815.654147-1-tariqt@nvidia.com>
In-Reply-To: <20261008132815.654147-1-tariqt@nvidia.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 9 Oct 2026 09:42:46 -0700
X-Gm-Features: AclHuK9YIcoqyRx7ZdV1TYGtJevv7ew5G8vshJKEoIcRV7Km280vcnLyswG0lkU
Message-ID: <CAHS8izNSo4YzXxD3C6c2HohdOfH2GK1M=51biuevLUk3vz5k4g@mail.gmail.com>
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

On Thu, Oct 8, 2026 at 6:28=E2=80=AFAM Tariq Toukan <tariqt@nvidia.com> wro=
te:
>
> Hi,
>
> This patch series by Dragos adds data direct support for netdev devices,
> allowing a mlx5 netdev to issue DMA commands through multiple paths.
> This feature is critical for improving performance and reaching line
> rate in certain environments where issuing PCI transactions over one
> path may be significantly faster than over another. These differences
> can arise from various PCI generations in the system or the specific
> system topology.
>
> Data direct for netdev will work with devmem by returning the data
> direct DMA device instead of the DMA device of the NIC. Each PF netdev
> registers its own data direct device and support for RX and TX datapath
> is added. The feature is selected through a new data direct priv flag.
>
> The feature is enabled though a ethtool private flag. When this flag
> is enabled, the driver will return the data direct device in the
> ndo_queue_get_dma_dev op.
>
> During data_direct device unbind, a re-creation of the channels is
> triggered.
>
> A note about the unbind: it does not does not tear down dmabuf bindings
> attached to the data direct device; the recreated channels will still
> pick up the binding via rxq->mp_params and post DMA addresses from the
> data direct IOMMU domain to the PF, causing IOMMU faults. A devmem
> revoke hook is needed to close those bindings before the switch. This is
> out of scope for this series.
>

Elaborate on this please. Are you referring to the fact that on
page_pool_scrub we unmap the netmems dma-mapped by the page-pool, but
we don't unmap the netmems dma-mapped by the memory provider?

What's the impact of leaving this unfixed? Is the machine going to
crash if the device goes away but we don't unmap the dmabuf?
--=20
Thanks,
Mina
