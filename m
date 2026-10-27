Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793144987;
	b=EERfOPHmfFjK1Kfmi2QC7W2vak+gtoZvuWHCNYvZIhZevNEz8quxrbrg5oWWrMQd2XBF
	 eSg3dmQYeE4WiPf8hhJ/ybCmKiwuc6DXycH1/XO1mTzQKwfQBBXb6XH6hyflO51Hdnlg2
	 mRHD/GDaLiyH5x5zLd/FZPTuL58DWCLplKQVgGGIkBLLiyqTXj1lOpF4kKd+gW6vfLY2T
	 RYBml2cRegd6M1wQBf9nosWLCanQboEfu6QO9a1+p9EOQ1+zFKwzK4etRgpI7UkL7S1XV
	 azn230XnaaBqzokDwNe3jzFdvSgeutbv3viP67Wj/4Cs49WzKQftTElr60mfyHFIa6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793144987;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=5UfrvjmPQqfo+IBDkK9qNrzC/Bn49zrz+L3WmDPaiYE=;
	b=nDakAojj6kmr0hhj12X/gXLeybB1Nmn5epkFS76fyFUk1zir438snRKDbMD2Swx/ik5X
	 FYM6BvDB+HPIJSWGcqGPRjoy3MXidsi70p6y1Gb+QA41PGDRrFNvAvQa6Al5dVbr6ISYe
	 oDlTkG4W1wTddryirpooXq/6cHS70wImRV/Ev2rxuLoSYRtt2+Dz38USVhZdD7bHqPJy3
	 cGEpkaq4dxutRQaQYf+X0ArbpSMLZtLpjRcxhwmyltBXE9RpeIG4NJhI2sdfQc/je0X3e
	 uMFTR7i44YPQ8Kg354K55B9g3fh15lzeotvmFB6u9r6N1LMnFEmkESlRcddm+LuyXuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XTSgYPVs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EC5606A31A
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 23:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XTSgYPVs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 819DF1F01825;
	Tue, 27 Oct 2026 23:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793144987;
	bh=5UfrvjmPQqfo+IBDkK9qNrzC/Bn49zrz+L3WmDPaiYE=;
	h=From:To:Cc:Subject:Date;
	b=XTSgYPVsxihpb+0lZrgGRmf6bHIrt7CxNG1yuf16W/3N27v19BHZFIc12HKggmTI6
	 vw3FGrLqsXeG3w+cjoD6KCBU4ivMdmNeY1ZjyV6LdflG523FcPAXpS+B/5fRuBUeX4
	 pclxcO+0HPTYXzBfnUn2CZmFiKplcZ0/YuYbiNZ5kQZwGNyFWtn7PpwyM0nCnbE+8J
	 Dc7uJIOhq4+FOcYVJbSomb+Cv8A7flXDFKVQGYdgCTR6F2Zh8mHP26dssHC2X7IBO8
	 FuHyzTQ9gPqW7q64W4Dd6NFWk0isvfGM/At+EWoXHsPnRkb7pzFoLu3SCvu4KelTSh
	 P8rWMJ4QKIxPw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	eddie.wai@broadcom.com,
	prashant@broadcom.com,
	huangjw@broadcom.com,
	gospo@broadcom.com,
	brett.creeley@amd.com,
	ap420073@gmail.com,
	joe@dama.to,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 0/5] eth: bnxt: fix Rx buffer leaks under OOM
Date: Tue, 27 Oct 2026 16:49:35 -0700
Message-ID: <20261027234940.1267225-1-kuba@kernel.org>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit bd3beb5c8691 ("eth: bnxt: disable rx-copybreak by default")
changed the defaults putting users on buggy(ier) driver paths.

Fix various ways bnxt may leak buffers under OOM. The first patch
fixes the real bug that was hit in production. Second patch fixes
an issue I hit while testing the first one. The next 3 patches
fix other Rx buffer leaks pointed out by an LLM during review.

I have a few more fixes for issues surfaced during review
(misplaced DMA syncs and bad event handling). I'll post those
separately.

Jakub Kicinski (5):
  eth: bnxt: recycle agg buffers when Rx head buffer allocation fails
  eth: bnxt: resize Rx head buffers when rx-copybreak changes
  eth: bnxt: don't leak buffers when XDP agg buffer allocation fails
  eth: bnxt: free XDP frags when xdp_do_redirect() fails
  eth: bnxt: hand XDP frags over to the copybreak skb

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 58 +++++++++++++------
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |  1 +
 3 files changed, 41 insertions(+), 19 deletions(-)

-- 
2.56.0

