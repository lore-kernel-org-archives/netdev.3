Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794477893;
	b=BQr0lTyi8drg1ragX+Na0tWGFBiS4U+vHUDG2zxXp5rQ2BINkGPAZKvgANB4+0zljZI2
	 IBzETBVJYSzbvLOy0uvmpTnSoUWG4fZpkRUYWJQGxp5n73ZH0RY5gaA5xL/9OjXr25qCZ
	 97+9Cf5ft9ZlrhuJFJGs3NoakJ4eIiZICuss56tv2N4vaACkdtBk/SK4sMHbSJ8gmx14h
	 OmkQRCxOg4S01RmiAWrGwTzRg1AqsVkjPj84JA6X8/SJ+5qr9g1z8PmV4KZW69eQJhHb3
	 T3RfAB7+9wTVtz5GWj3snxbPqQG2gPGjj/xglRZxipnzEHbUw62lGkOhJ0mv5E0WgPQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794477893;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=NBN+ait1vnoTBJpyFDKCXrZkJDvsdxTXfqwXVO+djQA=;
	b=0OoqBUkFSHyURp7Hj79+Fqm0jZ3Wc4X4KoOTP/yo3JwDlkPr8il/DCNOpoEC8MoxfKQD
	 9KlwtPMiyh1fJOfX9dXfVgYXNppijfSQow62DlIlgvw9u8Sj4NH7FSslRyEN+PIv6i3+d
	 /a0yR3QwCYVoyYzLnWmTX4OR8baElaXFXP+XtXfDTqDLVi6FHCR0gfbA7iM6cDV7t+s5R
	 VWwP2fN8uYSUAULJwCDRuuRoWQaIWcaqSoAf3Md1Gy7GTn86Mk10J/9+Y9u9wpMRi5tFu
	 MRU801+gyr1QuiiPjzHpGRvv/xel7U5S7xfiKRLIS3SU985B8uXPIY/mTFloutfH3Sw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tgla4Qya;
	arc=fail smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B1E606A323;
	Thu, 12 Nov 2026 10:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tgla4Qya
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794477893;
	b=Qppcik8BOBo9jGhMxI8CJytgjES9e5xFumsbryYlE86DWESzKZuktbKE3nhuRoi3Hn0X
	 vJ8wWMGb3A528M8IeuNjpO2fScXHKPitr176EAgHPJlxuUcR3fQWwCNKDWML5AO887p8R
	 wZIZSusEac8/5/j6rMebZOMvMpz27VBXxN3XwFMrgliMmktVi2B6hs186LtZQNaSUu+JM
	 aC2wid7AREjp5QummgHiJSwAvMML9Dq6mBE8X8WrZYnSLXtH2TbJp0U1fBYE8ic9WGX2Y
	 H1KfPrP1LPAeYgQJRtvzH8fO6eE7paKs9w9jFmpNSAOVc21nuXN7awKnWroOPt+OKbA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794477893;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=NBN+ait1vnoTBJpyFDKCXrZkJDvsdxTXfqwXVO+djQA=;
	b=rj5RSIMEuyh42Ih85i50j6WR2q874iYKNbwANGpkbbQPAvoIcTVpi4LKb7mw6ehGCa7v
	 Kr2QEsC8wkTaVyuW4Ypithg2HR0C8mwcuxwWMGLxspU3mvz0X5MmgYP2WuEo91HKh0FdA
	 5Ka85MDYw2dyU/clbB7FKytOCmNcYLPWKrOw+o7RKsA2O0rIEMjlpuOQuZ5nS6GLRxnzD
	 i0Xm+sxfySz2GuPDImB5RdnoR57Jqoqpzoi/SgzlYJnRwGeyzXSRGseFBdseu8dw0FBhT
	 7+CNuoymBXkNKBG5WHJ1wv23GnSV1fITSP+hZpvOIZ572h6dwz2Q8ft5JvHUd+vcRyA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 97B2C1F00A05;
	Thu, 12 Nov 2026 10:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794477893;
	bh=NBN+ait1vnoTBJpyFDKCXrZkJDvsdxTXfqwXVO+djQA=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=Tgla4QyawhwHRk+ClDd1ZWHhF7CNLrZoz9nUrpN6aE8M1gAdvZ3sbPBaxWfyBSUI6
	 nl8IRgThN+EIuCFjQtft8vdPVYRbEuNVtymf5N+k5wQ1QtWYmHt5k4vdIZllZBACsN
	 na4E/KABrUTrKV56VZtVkrKTpg6o13SU5P4FYXDCkDbA0HrSMH0OVulUwwkCSX2T7R
	 evdea6dqlCdCvpD5rVAtn6cDd7D23Sq+itIW6gYTf5/PuBiyG9rAaxyRUeamvuoxb4
	 d46UZpU6v/FfAPZk6UQAfCnKvjYwKEmndcXd/mCDUMjXeURSo2VPlFyBJg4MRU2DlQ
	 wf8ODlkWsWX+A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 2935A49454;
	Thu, 12 Nov 2026 10:04:52 +0000 (UTC)
From: Suyuan Wang via B4 Relay <devnull+shyckless.gmail.com@kernel.org>
Subject: [PATCH net 0/2] nfc: llcp: clone LSM attributes; st21nfca: fix skb
 leak
Date: Thu, 12 Nov 2026 10:04:47 +0000
Message-Id: <20261112-nfc-v1-0-ab0ef166f382@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD+P9WoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQ0Mj3by0ZF0TAyMTY5PkNNM0c0sloMqCotS0zAqwKdFKeaklSrEQweL
 SpKzU5BKQfqXaWgCGgPcdbAAAAA==
X-Change-ID: 20261112-nfc-402434cf5f79
To: netdev@vger.kernel.org, david@ixit.cz
Cc: edumazet@kernel.org, kuba@kernel.org, horms@kernel.org, 
 oe-linux-nfc@lists.linux.dev, linux-kernel@vger.kernel.org, 
 pabeni@redhat.com, davem@davemloft.net
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794477891; l=1045;
 i=shyckless@gmail.com; s=default; h=from:subject:message-id;
 bh=B38C6ONQmhZ5MxbMTghSPgEXPV1HxFO4pL6qucWz2bg=;
 b=g5PE+Tt1to59OrPXU0EY0UM620cssI/6vUBUL6uWiUgm6jHzBvfJZhO7JsqNS+vpp3fLXE11t
 wnt7fL8T3E/ANAZMy4wnSNuSe6su9GbtCG5arKSjOtM+s7pDaIJRhbp
X-Developer-Key: i=shyckless@gmail.com; a=ed25519;
 pk=pMtccVGiWES3bV+7YBFuBclkvq2n2HBHQ5azaBrK2lY=
X-Endpoint-Received: by B4 Relay for shyckless@gmail.com/default with
 auth_id=1498
X-Original-From: Suyuan Wang <shyckless@gmail.com>
Reply-To: shyckless@gmail.com

Hi,

Two unrelated NFC fixes. Both came out of a static analysis run, and I
checked them by hand on next-20261109.

The first one makes LLCP accepted sockets inherit the listener's LSM
attributes. nfc_llcp_recv_connect() never calls security_sk_clone(),
which bluetooth, iucv and vsock all had to add for the same reason.

The second one plugs an skb leak in st21nfca: the ATR_REQ skb is never
freed after the HCI layer has copied it.

Both are compile tested only. I don't have ST21NFCA hardware, and I
haven't set up SELinux with an LLCP peer to test the first one.

Thanks,
Suyuan

---
Suyuan Wang (2):
      nfc: llcp: Clone LSM attributes to newly created child sockets
      nfc: st21nfca: Free the ATR_REQ skb after sending it

 drivers/nfc/st21nfca/dep.c | 9 ++++++---
 net/nfc/llcp_core.c        | 3 +++
 2 files changed, 9 insertions(+), 3 deletions(-)
---
base-commit: 630059a5a632377b9b7b487baccde92b7ae1dd47
change-id: 20261112-nfc-402434cf5f79

Best regards,
--  
Suyuan Wang <shyckless@gmail.com>


