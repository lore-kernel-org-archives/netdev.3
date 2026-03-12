Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FB2375AD7;
	Thu, 12 Mar 2026 01:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773280093; cv=none; b=OHs3v60DpikgjWWWxoW6uLm/m73U57wj1zYCrHfqaH2fH3iroFOctwK+ZNdW6jfv6S+uC5PGY136S3bhMSc5WVqwkr7AmzSIDEvJivtJKDRGRacly0XHdPawL/HmgS0wcQ9oYoEjBiU9IU5AUnS93Dz5v6Lq8Kgbs3wH/tGB178=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773280093; c=relaxed/simple;
	bh=Vx7fSOtrEq/ysKCdLzlL96fWyTgovBKyuaLAsRzU6xM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M3IuW4cHOqcLHxmM9B3yzPfAnV/j8hyoCvOI+PD+heeFOWjkmcTp/SaAPGwe5fA5YUEgLzFsO3RAj25SGfPMKkaw74yppm+Z0Z2x69vQq3SKJpaBK8dTioXuEgQzIxsUV1HB6i/1oD6Ai4Rw1ll8+NR/jhfnkOR9gri0lhzXEhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7Jgg549; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7Jgg549"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AB52C4CEF7;
	Thu, 12 Mar 2026 01:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773280092;
	bh=Vx7fSOtrEq/ysKCdLzlL96fWyTgovBKyuaLAsRzU6xM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I7Jgg549Ad0tjxX4GtP+G/L0pm5PfwFP+KWt0R8MrhrtOumdRiooewdSQtxf8KNIm
	 TF6XDKgrqXTYKXU9d3Hz1QKqHWABy4QDuCqPLbOUJ+L3dNm+VuNHL9mAbGqR8L8QQN
	 EqlhsDDg7T14UHCR6UNR1YVAns42aVBCTvKYWYwjXLbQYDpODgCLJIsCrL/2ACarMJ
	 kIK4ikVOb7g9hKB3ldCWefvFZ3glAyP1dSjtQmREctwW1DgHuJUYIlBOReHosRfRl1
	 NyG6JAU1AFIxlfFCLmc3UMW29UPW9eeZupQcXR4tiyPvB1vN/XyxrSENUTd2XJp+mU
	 1jEXrg1+S5q2w==
From: Chuck Lever <cel@kernel.org>
To: john.fastabend@gmail.com,
	kuba@kernel.org,
	sd@queasysnail.net
Cc: netdev@vger.kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH v3 6/8] tls: Flush backlog before tls_rx_rec_wait in read_sock
Date: Wed, 11 Mar 2026 21:48:02 -0400
Message-ID: <20260312014804.5083-7-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260312014804.5083-1-cel@kernel.org>
References: <20260312014804.5083-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

While lock_sock is held during read_sock, incoming TCP segments
land on sk->sk_backlog rather than sk->sk_receive_queue.
tls_rx_rec_wait() inspects only sk_receive_queue, so backlog
data remains invisible until release_sock() drains it, forcing
an extra workqueue cycle for records that arrive during
decryption.

Calling sk_flush_backlog() before tls_rx_rec_wait() moves
backlog data into sk_receive_queue, where tls_strp_check_rcv()
can parse it immediately. The existing tls_read_flush_backlog
call after decryption is retained for TCP window management.

Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/tls/tls_sw.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 43d37b0e6d59..7e1560d5ab79 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2387,6 +2387,11 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 		} else {
 			struct tls_decrypt_arg darg;
 
+			/* Drain backlog so segments that arrived while the
+			 * lock was held appear on sk_receive_queue before
+			 * tls_rx_rec_wait waits for a new record.
+			 */
+			sk_flush_backlog(sk);
 			err = tls_rx_rec_wait(sk, NULL, true, released);
 			if (err <= 0)
 				goto read_sock_end;
-- 
2.52.0

