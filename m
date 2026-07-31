Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92EE3E1D07
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 12:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785502175; cv=none; b=AZnW9D0UckL5sPHExB1FMUKxZFHdXmNONIdzArlVEhE4wAs/UToI7T+TQxZuyYst9GwJSRoI6k0oKOcNMIcSwGaEhvFi/GxUMw4T1CN2kNBPczyCCvxgT48C8Is0sMPBrE+yhBETh9plXHXvd49fNdZowR8WbeBwSnd5x6N43iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785502175; c=relaxed/simple;
	bh=BNdgwU6k/E3eXdatb2JdfRENJOEjhEhkuX6KrFY1Lus=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O5m3XX+eZElaYoqEIMWVwMv/04wGSx00h9W/IXs939m4BOvZ3UhUURvL6+SaF4Sqwe6z+V6kmEvM2eYdfNdjHJI7EsphQOIfh6kqYwR951KLgeZfXuCH5p/TpvJHyrc+yOjPLz14u93EoKWfAY2Botma88Td2nrGXiqBa/wpFiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hsqvYynR; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hsqvYynR"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-81e8fa1b8d6so12862987b3.1
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 05:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785502172; x=1786106972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VtdjD1e/vpmmj2husgdgiPdzsCCitvPPyPIwmj8O8Ws=;
        b=hsqvYynRlZI3W9T/QZG/5BX7kmtNmnrWVQj3vclL53bXUZckPqexd1SJItegbAfJEm
         9jaSVx6AxIHrEUzUYTQzjfmRAJ4VN6+qeqPZGaO1T1qABd2nAW81uJDE0CN0NUf304xb
         9fPQftD16CPxmB5qGkIWU9DXRzf5+uwbqX1eCab/6ty2n2wGftWpZmOZtrD1mla+BBL0
         yiDydad0eBs3bWM+D2eCY3Gtrh/tAuxGsrvxf38YYUFhTVR4Rxn79fLo3jz2lVzGS4df
         COztivuXGuKLtMWtukUqy5XpUBy+H7rS/w+xTdgPSgxn4VCWQVR8R7OdNpBGfZGBjLp9
         LPVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785502172; x=1786106972;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VtdjD1e/vpmmj2husgdgiPdzsCCitvPPyPIwmj8O8Ws=;
        b=Qk70FXonyvR8BhTekxafPPL7RjzCGxanfAE/8f8Xu0PUBN6FzK6CeO0gWE9ey0VDUm
         TAy5tNdmnhi9Z2J1vUozeqwCQMrkrBPGXZIQareha48xwOJZO5mSyRYvIYloPRFYyzN7
         FM2hZ4i3JB/xBqy5sDABCQpeZMVt+vdOsnxbjI/A8gyhEI2+K3J3dLg9oqeOo0ZYXHIa
         ar5tDYr1p9g7kY37Ad4MwjdLE3LslFv+MOZjeEQK4Y4geFl8c1s3Vm0omHYHhKLRsm74
         Iian5cLCU0ces4HsPVIcY/QpoWufpsI0UpKg8uwrtoGpHur22Wxh8d9tBkVhlpGusLF7
         Ls5g==
X-Gm-Message-State: AOJu0YynaT/z7zCMu6a1h3V2/UEdtO9DL/6hWZ4CWSk3llk66OoqVNg5
	T7TKTNyFdeGhOfLdoZq+TdUPYfnd1ALpH+OGMABu6xwYXbQacfPlC6hD
X-Gm-Gg: AR+sD12NdwZ7yg8zBYd6PvTAOnkiNeVXgepFeWEvSRfUZVyagPOsOqsu6XA0NvVxixv
	kMvMkQjZ8dgy9zfXehAj2WL0NHNDtaKaSbmRc49KdzMeW1oZSpPM3IJJ8ijSRwy/MJXsWsbk3Ij
	E39edLcV8UepJTnkAzMLVlOdbxXtm8j8fCp9rZ/hBJn/JSgL5NZPUmfP3g86URTnlf+nED3aC8W
	qHueMa7sVuPYmygm7TsqBYclhmZ7oyNECGz5nmrnVQnsi92sjV/QS1JaRJ66TeQR4vD7GhDFa7P
	XgYoEq4ipyxyjPW9SjxqQCRwM+KjWsV2GSBVyHhW6/nd7gQd2qysqAuQmu+aq9EHkbwMPYZIQxY
	5dP2XaWwM/F8d9VVtsffY65rMoK7PWwci1FwmiTmsV2CpyhfI46Y4wdOORi21uNG/Vv4IsXIXPQ
	v5DYbomzwj8CaJhcRcjTr0getDKFamKovgq3BY0wVi
X-Received: by 2002:a05:690c:4b85:b0:81e:98d3:cac7 with SMTP id 00721157ae682-81fcbfb5b1fmr14136117b3.12.1785502172163;
        Fri, 31 Jul 2026 05:49:32 -0700 (PDT)
Received: from devobuntu.lan ([2600:6c5c:6b00:316::23])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fcd108f0bsm5695367b3.35.2026.07.31.05.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 05:49:31 -0700 (PDT)
From: Matt Vollrath <tactii@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Matt Vollrath <tactii@gmail.com>
Subject: [PATCH iwl-next 0/3] iavf: defer loading netmem_desc
Date: Fri, 31 Jul 2026 08:41:06 -0400
Message-ID: <20260731124109.99065-1-tactii@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a few places libeth and the iavf driver inspect which page pool is
attached to a netmem_ref. This forces an immediate load of the
netmem_desc struct for each buffer in the Rx loop.

Defer or eliminate these loads of netmem_desc from the driver fast path
by using the page_pool ref in the first cache line of iavf_ring instead.

There are only two paths out of the Rx loop where netmem_desc needs to
be consumed:
* The "very rare" case of libeth_rx_sync_for_cpu calling
  libeth_rx_recycle_slow and indicating that there was no data. This
  could be similarly factored out, but not by this series.
* GRO merging a frame into an existing aggregate stream. In this case,
  the cold load of netmem_desc may overlap the payload prefetch started
  by iavf_build_skb, which is now no longer dependent on netmem_desc to
  start.

Matt Vollrath (3):
  libeth: add __libeth_rx_sync_for_cpu
  iavf: use __libeth_rx_sync_for_cpu
  iavf: use cached page_pool ref in skb helpers

 drivers/net/ethernet/intel/iavf/iavf_txrx.c | 18 ++++++----
 include/net/libeth/rx.h                     | 37 +++++++++++++++------
 2 files changed, 37 insertions(+), 18 deletions(-)


base-commit: 5c458073553f0ef74f5c8db1bd459c87c722a299
-- 
2.43.0

