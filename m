Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83104363C6C
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 11:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782127108; cv=none; b=sX7uutqHp81cb2PMjlXox2dgY1iyw8CxGCbyTTlPNs1pUzPqADLoENtPDp0AgpLXNzG4rVnXFmNUnmK81TKTn7rVkpBMbJVlc/N70RsM9IqZMtVfiOLsihK+O1DMpWmQzhJnX42MS7MWgqX9Maaq+HpkTjjM5rJGWH1H5IqO40w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782127108; c=relaxed/simple;
	bh=VkrQ4QLTrba2ED2hU/U1NjA9SRNKxByeoqUgPzS6Of0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Wxj6RIDsJ76FVoAta00V34x9Ypi36tJS7kj2dk8DZRl7NE53x8PXNcINMJM9aVIF38PGuGYpK9ryo0zFxXLp22SwZfy6usowvxeYas3KXNA7CvWioHxuvaBw3l890rEh8qq3JGOmnhcOU8yDFE3Oz4uhWGv52sqvIExt1zgRyZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FB7aD5ru; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FB7aD5ru"
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-51a0d024b84so18356491cf.2
        for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 04:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782127106; x=1782731906; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PtQD75Vy0SursIDZ1uPjEm2IPfha3T12IlYFRRqNWzw=;
        b=FB7aD5ruq5iXagn/yOXqxwP6HG59V9NJSltTuoxBETnWMstFnd6N4FfbH6qyK8Trmp
         5y3Wwa3jTf8ucH05mIMiHzz5TD50LzOpX4cEXq4zoCS+/FyZCP2zUa8LhKs1wB6J3nde
         7VkC/NKxATNdxaRGsTNnAlrr6yR2ymbNG6fF4ASFSk/CxAJHJ2wN4qbp+Q9EgQYNOCPY
         sm7MJdHEjRypB0HERwKJolv73LRGwvH4btexlV9GQlY+dq2Z2jhDUR16gfGhliV8/pAW
         5GOEnNSjXkkjWI4iDiQMoYm8Wpob/c6kUVLXHw0EVR/Tm27fKY7vOR7mXDa38fjiqijP
         1MZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782127106; x=1782731906;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PtQD75Vy0SursIDZ1uPjEm2IPfha3T12IlYFRRqNWzw=;
        b=rKx2WYfHtkBGSo3OazHDSyZnIlRnNuGoSAzs7lYYtwKg7LfKnrRfE+EIeXYIkdEMsF
         xVYF7izxzhWPfd8AozLynbPpoVlfZzua280DYimI2lwFsxPDyNp8LPWk8j9mu9NY9fJi
         BA6SNgaFKAY4t7UhSm2DTSch/LIPsVB3/f552Zj+r2TcuJarCKOOl4wl2gbztRtrWaqH
         BolFR6DKA/PyhvVRzr8D9uy2LZpLR0HRcPExi7IhN9CNvKV+tIRLu7WkbEihkDhabb1S
         Krc8M7Y925Oe1s6r1Ej8Gdj467f5dIP+XsVTaz9BJ5J4PDPZUzA74GhPaO/hN67xbLI2
         TXUg==
X-Forwarded-Encrypted: i=1; AFNElJ+NVF2jtjJwDEo9OvxWY2ClsMzLBvrltOCVntUiPfo4+bZBv60xHIi4trRArWpNIjyFQ0Jumss=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnfRPw/fEfPAhmveiLN43ILUsCOY6C9bZfjBSE0cvMHl/qs/bC
	Q3cXjEUupMKxsVNQUzNaBZZTpGKmRj1A1ej3WFT2XInKHI7OpD4m9KaurxmSBU/5pGsCQFjcQbV
	29kCDlEKjuNl+ig==
X-Received: from qtiy1.prod.google.com ([2002:ac8:1281:0:b0:50e:5ea2:deec])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:141:b0:517:899b:7f7f with SMTP id d75a77b69052e-519e4bec592mr211925721cf.34.1782127106113;
 Mon, 22 Jun 2026 04:18:26 -0700 (PDT)
Date: Mon, 22 Jun 2026 11:18:25 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.786.g65d90a0328-goog
Message-ID: <20260622111825.88337-1-edumazet@google.com>
Subject: [PATCH net] veth: fix NAPI leak in XDP enable error path
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Guenter Roeck <groeck@google.com>, 
	"=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?=" <bjorn.topel@intel.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Tariq Toukan <tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

During XDP enablement in veth, if xdp_rxq_info_reg() or
xdp_rxq_info_reg_mem_model() fails, the driver rolls back the changes.

However, the rollback loop:
	for (i--; i >=3D start; i--) {

decrements the loop index 'i' before the first iteration. This
correctly skips unregistering the rxq for the failed index 'i' (as
registration failed or was already cleaned up), but it also
erroneously skips calling netif_napi_deli() for rq[i].xdp_napi.

Since netif_napi_add() was already called for index 'i', this leaves
a dangling napi_struct in the device's napi_list. When the veth
device is later destroyed, the freed queue memory (which contains the
leaked NAPI structure) can be reused.

The subsequent device teardown iterates the NAPI list and
corrupts the reallocated memory, leading to UAF.

Fix this by explicitly deleting the NAPI association for the failed
index 'i' before rolling back the successfully configured queues.

Fixes: b02e5a0ebb17 ("xsk: Propagate napi_id to XDP socket Rx path")
Reported-by: Guenter Roeck <groeck@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/veth.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 0cfb19b760dd54eb896f469c02bb02ecf5eef504..1c5142149175369a642342849ad=
dfbb9c07404bc 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1137,6 +1137,8 @@ static int veth_enable_xdp_range(struct net_device *d=
ev, int start, int end,
 err_reg_mem:
 	xdp_rxq_info_unreg(&priv->rq[i].xdp_rxq);
 err_rxq_reg:
+	if (!napi_already_on)
+		netif_napi_del(&priv->rq[i].xdp_napi);
 	for (i--; i >=3D start; i--) {
 		struct veth_rq *rq =3D &priv->rq[i];
=20
--=20
2.55.0.rc0.786.g65d90a0328-goog

