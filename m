Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793604091;
	b=O9slnGQGNm+saLt/Q0uSxNoNn1JvS4vMqE6gleOoMXO/Bt28Ttuzq+MdgmIqdZh8WVcp
	 FA1PKFT+2pFE2Ko2qqDNpXgOXOOEg0X6hoDolCilJBAWUfkSk8cqgHDvQbK+31nkT1q/m
	 In4fcqKWFTvy98uLk5Pq5qloE03iSHB+I85RYvrO54mYl0QJPT5e1rLM/iVrQfPXwHrk/
	 uhsWyQitm8+ZbcZe+gQh7PY+1K6lRd6QsT16OOYkwQdclj3oY533+QOOZ4MXZRbf9d5YW
	 OFTD55aqHP137j0ayMUA2KVL7uIe7ve0wrIgO0ahC0sV5qQXHrQ8mB+9bndEHXsSOGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793604091;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=sdirJ0jP7o+YHEJCnK7VR6r1ybPNKkJjwR4pGDyhi74=;
	b=TUHoDAzUn6bgeW7ZkiWe5wWG8DmR6eyAAqRC+ydXtftxO1iTmZiN7/OeZXKatzzEQGCb
	 hwf4wz1Xa+CvmzGuJXsNyUP63k4BOA9MtLsXxb4hUJSELaDMqBQSYWuxD+6wqRP5ABS2Y
	 uQ5eqUkRyF8TGpzOkHzqeVgHzCiimrG6vZi+wZOkJ3WO2HSUnycyBQRVhmu7wha67ccuw
	 Kgv5ebi18nK3+pCLWaPekohFXQRbCavKMt/njwO7Th15kWt6pcaGEb5rNd/9d3pP1JyFH
	 +GPi1DhTVpgocKseXoA+hte0SuMUJg23uhDm+jq/dVYSYatGrrTBiUSonyyfNWwkE1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HiBvqIK3;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B9A606A329
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 07:21:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1B9A606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HiBvqIK3
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3adf5f6833cso1355121a91.0
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 23:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793604090; x=1794208890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sdirJ0jP7o+YHEJCnK7VR6r1ybPNKkJjwR4pGDyhi74=;
        b=HiBvqIK3Zg4oQgilDh0mFc4euQ5jy/ea3q8Q1UMieO305xm2B9TfDL5rHhuPUtPsns
         HMX3n3uYUrRd8TchZ4moNiCCrtqPFvwfnhbkg8rBNi560+OEcapv7/cM0y1E9vIHjfSm
         xZ/ODBvPNEvQYWOBJ+UtuuxgpRS/uV6qO7w3+UHHH3laYLuZAP+PXNpqo2E8EwYWHGrH
         ebr7vDxhIfYFo04TMsM73qDN5RX8D9sDURjtKFYwrURUlHumaL9r+u74Y48o68KYr8IF
         JJp+ZtK4nIadae9myAdsFSbz2nzcWJyJy39/8XocOmEzbKbdpY3ObsW0Km0TgKe91w39
         8D9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793604090; x=1794208890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sdirJ0jP7o+YHEJCnK7VR6r1ybPNKkJjwR4pGDyhi74=;
        b=exzdKxJ3p1ge/CVWbB9ZSFuynCkAkIGmu7kStjmJHSHK6D1KluENi1+pAEXkahLdqK
         d4UpEICpDf6tvnpx6vNBZoXIK3mw3CfDuGjbz2UQ3ZwxiXj8gCGO8E4swt3M6qgATlZr
         OYkCVIj0SYSHZYkICn6rZBELhpC3tI1vQwCE1GSrSxkDSCUWyTt1w2FgAZhGGzJ8uRWZ
         vPmjaxHWn4kegBfFB3+FIJZgvZo4/sRFKsldmaK5BLFXoLxfGBw6XKaAN4W0Al/Cw5cd
         dbRI9lKZgZn1ygR3bWYUN/4+80DM+jf3RSjmE/jKYOefSzPuMlB7pVC+kM0IQJTgvk2S
         6G1w==
X-Forwarded-Encrypted: i=1; AKwUvBygP4tj7y+eYfrnIyyG1A4rqLpFXJFcCPYlltaMTonmiYGB+eOLGm2s3fBJXD8oF/MaizTxl6c=@vger.kernel.org
X-Gm-Message-State: APuU4Z8CdmMFmAHhAWZjkSKWl+iG3rDR+yQffNVSjnVeMPi2p0C2DFC9
	WAg8+d/nTfvrBqQ3Qka1CuWQzN4+FZHLS/HKP5FLre1e8XTyMVkkFV93
X-Gm-Gg: AYBFou0Zn1DYyFq5kcW7/6WsO+XKSvgGILjXDnT0cNTT1a8dmdPiE6TAgKaTdR8pIhH
	4idn83LFseRLLnj8joB84zzujYE1R6BV6PYRuC8WEi9HTaTtbU34swpftVHWAG3AoV3L0D8Z60e
	6uP4VKzT2DOI75kSl0cL5g692OBVavI4kVkSST5l2WsPFMe8rfyiJTivE3E4suk/RCO0UoQ1qX1
	WjNNbJ11nWJuOXmQoaTUauErBFtlwJN93BjygCIkTOW5M1FnC+mkOZLIw6tpYnlp8VlGrsv3iLr
	ZrnOT3KB+tH6IXOSLDbW/hna+x9zfedrCdnar8qACOSoOFgDJQ/MC/hcrqgC0VvynP6v+JTy3lo
	TAyCzWr/CXxST4xLqQctZwov16IB2E0AXGsEk68aJXkpl+K6sFo4PdMnemBdqEnYlH7NG7PjJ6Z
	HwOPKPZCwB9Lc6I0zw22cqbeykyghILRXtNiPt1wZnhFEza3zdWQaV+9JEa8xnH9AHesLSFHkmH
	jrkj6eGz40Y5GpL5vZuhAm/Lff7IsLLFCH8lXHbKgy2ngGpk/7KH4OIxRdouKVtQnRUowOeGQmi
	2Re2Ucea/S9J2E85rsW7R1xuBTa5H6R/Cw4Q3HzbU61Bttxx6+2m57BTaSHuF4HMW9+uGx0Gco8
	s6rTJDL/StXDPqLlc2mrug7e+pOe4dOWK3jyVm9SaFJyyioiO1BBrfqxIzlUNYVi09GL/lXNjpC
	us
X-Received: by 2002:a17:90b:4b8a:b0:3ac:1c76:61c3 with SMTP id 98e67ed59e1d1-3ae8974656dmr6955366a91.27.1793604090070;
        Sun, 01 Nov 2026 23:21:30 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e7d5b8csm18000578a91.1.2026.11.01.23.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 23:21:29 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	jiayuan.chen@linux.dev,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kuniyu@google.com,
	willemb@google.com,
	matttbe@kernel.org,
	mptcp@lists.linux.dev,
	mason@kernel.org,
	josef@toxicpanda.com
Subject: [PATCH bpf v2 02/15] bpf, sockmap: Don't let an SK_DROP verdict stick
Date: Mon,  2 Nov 2026 07:20:59 +0000
Message-ID: <20261102072112.4160195-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>
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

From: Josef Bacik <josef@toxicpanda.com>

The verdict of an sk_msg prog is valid for one message, or for the bytes
that bpf_msg_apply_bytes() requests. These bytes can come from many
sendmsg() calls. Thus tcp_bpf_send_verdict() keeps the verdict in
psock->eval and runs the prog only when psock->eval is __SK_NONE. The code
that resets psock->eval is after the switch statement, but the __SK_DROP
branch returns before that code. Then sendmsg() drops all subsequent
messages with -EACCES and does not run the prog.

Reset psock->eval when apply_bytes is 0, as the __SK_REDIRECT branch does.

Fixes: 4f738adba30a ("bpf: create tcp_bpf_ulp allowing BPF to monitor socket TX/RX data")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/ipv4/tcp_bpf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 8cf63a9e7fed..d90bcc911b36 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -509,6 +509,9 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
 	default:
 		sk_msg_free(sk, msg);
 		sk_msg_apply_bytes(psock, tosend);
+		/* The verdict holds for apply_bytes, not for ever */
+		if (!psock->apply_bytes)
+			psock->eval = __SK_NONE;
 		*copied -= (tosend + delta);
 		return -EACCES;
 	}
-- 
2.55.0

