Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41C03B19DB
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 19:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785352646; cv=none; b=MrQhi66zX7GDfeBFtJImJWMx0GEUSKLDU5Dac2QRCaOiCgWyJukou9X8EU/CmoUQXcoDGtliw+teTNiy0Nzr456crFVHRX7dYLRfgrcNH9RETf+PiZy63YAR7b4ojI9/W7O+IbfWKovLNnWgl+nua3jIghvAGBm/fe05KFQpu+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785352646; c=relaxed/simple;
	bh=gLYJ/tvikVJD261WQ8Bnm0r9paDoP2JeP0aFQhh4qUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CZczPndR7NpyM3fzKWcg6XwLcbjLdCXY56UvkNxOFnO1Y7YgYZwbT7Jf3QMDjCh+TuKo0vNnbmwoCbNPjCcMIV4r3hHsOvUtrkCwH3zKgmbu82iQRH79MlQdRQoeWOgMxWFlhptAp33tIJZGycszWG44JhkbgqfEGzSpMxOCjHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJH1K8iK; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJH1K8iK"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-384930ca5e2so1143029a91.3
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 12:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785352644; x=1785957444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8cYrrvUoYS01HckamENfIVCtypmUIu/Ic6/OpmpgsnA=;
        b=cJH1K8iK2Z4qXyMtMIlJoWDxLCGs7RfVxAWhHyh/4M+Co2CZHXVTP6ZcjFT7fBi52k
         DFjIeqEDRIuvUssqPkmRwP7oe/ERPoR4DXfCPrZsx/XX1+ms73kqnoPvfYOrSDhj6Do0
         /skIvKu63mwdYMuAoGef82PcG7uzUa6BRMV9oVV6c7HgyOskfywvenUFWEZpZ/L2XIza
         5ltpU4CXTR9c0NyB7HYuauLoS15AX2u66hK0dAnJy4JWeHWhB/Hmp2IWCDDbLHbMDFM2
         olgEFdgbnDOJ8Kk5ZT5+Q1lx+cObfyFAg2wTdYzXKKkwY4xNPWvSrRWIDnbYdi8oRGjF
         8Xyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785352644; x=1785957444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8cYrrvUoYS01HckamENfIVCtypmUIu/Ic6/OpmpgsnA=;
        b=IJjB+SY+AImHtPfAnD94g9/I3ZMeMKxyTMEFiYzGKrAOkqTdvco0EUJNaWiev3+LV8
         A1hn8loVoA1eb1TfrqLmHSy5aLvGQCveYaJg047DchcJS1vs5Etbs8ef0U1IbzVqxhqS
         eyArtGjrycxQHUvdUf1MWbpucVNy5v9f949SQJ9G+bvkLUFs74xxTByX/VQgDPNps7lA
         O/rfffMue4COVPaGYlkMpTIWKQ3ow9dBS8PHOCvM/b0Ox9gBB5eMil993cI/iByLXx4Q
         DEQyUPFuXWtmxlGXcGuWOmLzaeXEmIy1xlh26uCPs7MJUbaEqFSw8cxdzoXVfUFTeotb
         PN8g==
X-Forwarded-Encrypted: i=1; AHgh+Rrv/+37d6wwhWkfe8hiTKVgp5TAK3vM+f1oUsFiFYo6qyAejQDYUkaQ1MQHc0cuqxLHPYMsny0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjfmMEpS+jPXLXi3b12yCl/7/KpG8aWj9UiUYet+DAPHg3UiLo
	JelEAAtNpJsWaBdjOMvllmkhspp9tUGt32UjWsTeg3dTgdhSNZJhLYKu+kSTHg==
X-Gm-Gg: AR+sD13V4z+bLwIdsEYZHqM6R3MZVIZ7kE80vY8pLFWgQ/qswBvTjxFiMem9AnD3tTy
	mnjH3DzoPDu8F6Hkt1E9kKaTMKBriDq0Tqlng1ZXb+drKK3oLxIMybvkBRBx+Pk/OaVzRhC7QbU
	LTl1f9tIm8IBhDJtHV2V4Sc2QJhpK4jt0zycuzY7dmMHFxBd6VMnRgKrT5yq1vyPIVdk5LWHaw3
	5vCRO8ELjBT9jjGog5epTwxgyxobbk42NOGOqav398nUFcTG1KG2JEPFrXA4REs4slhZTWifODm
	jGZsfUDGBhqsYc831lSmwkL/LtyFeNCVIz/ZBJdgz7madMysXk/1bG/9NWQSgRf2mI2wNEQX6eg
	l0i43w0TcfZKvdtSmomSpGX5qUBxn4XDsjIoogqU4VRO6zFHMa3ppcICS7+HfAtKbdmEufa3n+h
	qcuitHTR5Bp1gqNKW/+XaeXssjQu/Tf35bA4Mf8PAB1YgpYxTbjK1o4SM5YGUB0amds7Nq0zzap
	MhkHns=
X-Received: by 2002:a17:90b:5484:b0:38d:a150:ee04 with SMTP id 98e67ed59e1d1-38f99384981mr116539a91.30.1785352643745;
        Wed, 29 Jul 2026 12:17:23 -0700 (PDT)
Received: from bogon ([2408:8207:1832:1b44::c6b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f81543abfsm833349a91.4.2026.07.29.12.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 12:17:22 -0700 (PDT)
Sender: Weiming Shi <thebestswings@gmail.com>
From: Weiming Shi <bestswngs@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: [PATCH v3 0/2] vsock/virtio: fix worker access after virtqueue teardown
Date: Wed, 29 Jul 2026 12:16:53 -0700
Message-ID: <cover.1785352330.git.bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729185831.3247971-1-bestswngs@gmail.com>
References: <20260729185831.3247971-1-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Virtio-vsock workers can remain queued while freeze deletes the
virtqueues.  This series prevents workers delayed across freeze and
restore from retaining pointers to deleted queues, and prevents the RX
worker from refilling its queue after teardown.

Changes in v3:
- Resend the series with proper email threading; no code changes.

Changes in v2:
- Split the worker pointer changes from the RX refill fix because they
  fix different commits.
- Use bd50c5dc182b as the Fixes tag for the worker pointer changes.
- Keep b917507e5ad9 as the Fixes tag for the RX refill fix.
- Use the suggested out_nofill label when rx_run is clear.

Weiming Shi (2):
  vsock/virtio: read virtqueues under worker locks
  vsock/virtio: avoid refilling the RX queue after teardown

 net/vmw_vsock/virtio_transport.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)


base-commit: 51b093a7ba27476e1f639455f005e8d2e75390e4
-- 
2.55.0
