Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A765631065B;
	Thu, 26 Mar 2026 13:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774533071; cv=none; b=Z7jA9nIqRstjAyjg/wcITMnWQLFsWZoVWuO2JpUda9HGbbPjAWXugjerh72Sjmq2CyOcbEOKgF/aXilVbUthTeJCBjXGGL46cfdubdNgmJpXwaIKefFEuHPUSWMWEHFt9nSyvHVcx3q7QbMavonSBpiY9//n5i2D1wkiyN810FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774533071; c=relaxed/simple;
	bh=jiLVEzDzHDZPGnoP7mb55lkJ+Rbb62sBUfVjghFNLAI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Of2gtYzShcKMNSij0K6aSMSY/v3gV5V5dtkw1uoNZjTzJRKh1kCixCQqiMyxySPDPygC1nupUyzVkd7bLY0Mi+O80ZRtQmU2RdAZNroW7uYP1r8N4RmymfOTmGVzbltzIttLTM55aQ8MTtDT+FOXBY9dZJsneO6IxMpmCfuT3HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJmAg929; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJmAg929"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDB5DC116C6;
	Thu, 26 Mar 2026 13:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774533071;
	bh=jiLVEzDzHDZPGnoP7mb55lkJ+Rbb62sBUfVjghFNLAI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oJmAg929t3GqARJ4rsvGsDFw8nqSJxZqbL/2QYWMovj7D5YtrNXrYjB5NO15M/oSg
	 MHg9m+2NPoAYDG93iCbGYP7DVjYc4vOXyWjOgclaa+EgD+sG1O/NUC/IkZvadKzKjH
	 ZCSsMpaJ+0rrM2x5FDYPvFkm20PK4kzJf0fT5Bmo17MUvZKo470zSpuiX4kw07SAaK
	 KLpzeqn7DPm0qlGCtWRsWbBMkHn4+YvUyMVmiGSNd+gyEzYqkfpk0bavIf/+ep3+gi
	 tC48clC8t7iWra+MstVqdqEs8VmpfkAl/wfa+qdZFJlTxYNpO8GaB0igd9O5Kys5Ds
	 6ZbX4d68fGwRw==
From: Chuck Lever <cel@kernel.org>
Date: Thu, 26 Mar 2026 09:50:51 -0400
Subject: [PATCH net-next v6 6/6] tls: Flush backlog before waiting for a
 new record
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-tls-read-sock-v6-6-fd887b9e7f06@oracle.com>
References: <20260326-tls-read-sock-v6-0-fd887b9e7f06@oracle.com>
In-Reply-To: <20260326-tls-read-sock-v6-0-fd887b9e7f06@oracle.com>
To: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net
Cc: netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev, 
 Chuck Lever <chuck.lever@oracle.com>, Hannes Reinecke <hare@suse.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1346;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=zVo2aWZU16cWfzKR5efuUXrBNgjYfftgJHVqojqViVA=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBpxTnK+zZakvzfptNBnELREwywLEDi04Wpfc3dy
 LEnvCDE+7mJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCacU5ygAKCRAzarMzb2Z/
 l1N3D/40RUfqq5O6VNsoZUQppDf3uPn3aNar3diGLlDuyisCSKGgW8C+8LXRsdPUYWIGnwahRJe
 EnqXmzPscItI3YJT3X/BrlNMpOmrzByt4huQzhcDCMtU6lWMkiMHR5TuiNfYL2QmxQ4xeBYHkb/
 QRrZU6oycsNgglHQ+l7t8Zlkz8yfnDQFcUTq/deikF/jwsm7usgZyeK2XvD5kkek++3HG1eSL9/
 9LcEy3klfx5kEb8yAfkulN3n+QeVIW9kLyss3liH5HSAHRPpkblDYswd3GpKsi+IrY9emtzh2XW
 Wql502aja8+oD1ny1jMmQ9QWgp6h2WDgb4RM47dGn8U/hkY8jklM/PFUHFsiJKV6PTdyv4YRV3a
 1KLLwbbOzyI+kNxbsVeZr/YAIUtic0M9qVRDJ7d6LP29QjMDdwlK3IVQiqIr/r1E8pMPs4/Hnt/
 4ERhEKL94xTQddftPwuC0R5F4Ehb22WLXnFTJ7b/9RRMg16qKG/gm9U6J5h1OJkwo7tndatuxiU
 j/2gRtzLWBRqYe7pMoHHqo0oZjO1LvbEGmSutjMMNGbwEypRR7pD0TOmRpAPJlHPclJ+1tmLg2M
 uOMgQkoXRfUm2Edn7vJfKni89CQMmVMp2UxYA1pvx2oehfdzXozcVOD8R0NEwK1go7SUe8AX8dH
 yBtZVJCZxoxNwAQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97

From: Chuck Lever <chuck.lever@oracle.com>

While lock_sock is held, incoming TCP segments land on
sk->sk_backlog rather than sk->sk_receive_queue.
tls_rx_rec_wait() inspects only sk_receive_queue, so
backlog data remains invisible. For non-blocking callers
(read_sock, and recvmsg or splice_read with MSG_DONTWAIT)
this causes a spurious -EAGAIN. For blocking callers it
forces an unnecessary sleep/wakeup cycle.

Flush the backlog inside tls_rx_rec_wait() before checking
sk_receive_queue so the strparser can parse newly-arrived
segments immediately. On the next loop iteration
tls_read_flush_backlog() may redundantly flush, but this
path is cold and the cost is negligible.

Suggested-by: Sabrina Dubroca <sd@queasysnail.net>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/tls/tls_sw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 8fb2f2a93846..e15adf250d78 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1372,6 +1372,8 @@ tls_rx_rec_wait(struct sock *sk, struct sk_psock *psock, bool nonblock,
 		if (ret < 0)
 			return ret;
 
+		if (sk_flush_backlog(sk))
+			released = true;
 		if (!skb_queue_empty(&sk->sk_receive_queue)) {
 			/* Defer notification to the exit point;
 			 * this thread will consume the record

-- 
2.53.0

