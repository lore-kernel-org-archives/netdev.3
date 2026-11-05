Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793844172;
	b=1ZamHVMokAgxNwRiHCyKTD4303UqgQnRe/boNe40kjZAOsYI5t4KHAYLWCIB6yxCggVm
	 tGRU8aKVmnHOmaNvweacflxhTeSEIk3qm9RtPWkXVMTBF7c+Zn/NzsS6KFy9H8HYbcYEd
	 fUT95OyTlGQ8HK68NQqOR8UhhjbhnNH5DUMj5uxP9HdHq/TxmbNEkHKLjfcftQNH1tdbA
	 AQWKujT5rcK2Sz8zaBn8Ukdj+TBhMA+zzDLMCX2hZBeCwgLznKYlMvyBLbX47TV1UkhFl
	 YVeW0tURwJroghKWsSaqWxvY01TFlDTV04uQ2tI7rPJr9ZmdPt/yNstOvnwEDb4CJXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793844172;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 X-Relaying-Domain:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HpFmULoD3PKNQA7nQ1ArjNPpfG8VSqQMXNJlOpOCtTU=;
	b=5fukwRTGSR3QmK2NjXAB/PWMqWzLXVKcUCbdaeUDExNigny9Sd1mSs72c7feewvd0BMy
	 E8+NqpvrpgplOOaIn5o3qSeQxN8l8B+LKUeA7gp49FEaLjH/6Vqeu6sJyW/P7eC8pD47S
	 rnI3v/h927SLK6KXrGT5O2rqPu+LfReW/A7mgaFETVgG4qNOLJwL93AvJ/ThnlP51oNmc
	 KMkQt121Ws8H+AXZXPfWajOvBTC7OWiennL6QZoXHyPvtNpxX86uLNa8mDbm10c2st57J
	 OOTPk4BR6emSaaXVpyiDE2DuipanRZA7jOIvDfmPHi2BRn2iCXiiimb+QWkBeSiB2cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=purestorage.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=LB5J9swY;
	arc=none smtp.remote-ip=209.85.216.97
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FF6606D82C
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 02:02:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21FF6606D82C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=LB5J9swY
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-3ae7626d14aso823260a91.2
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 18:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1793844170; x=1794448970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HpFmULoD3PKNQA7nQ1ArjNPpfG8VSqQMXNJlOpOCtTU=;
        b=LB5J9swYrhk+rpnpdAYM+m0KVsDTZ4C4Bx7BBtl7ax5j0XJo3KQPDhhX9bb/vANb28
         0lI6V+bsivTqCXJGHe+zZ6dhF6Gk2pj5Myax/kQCbQ60k/qk39nTK0zwl9vMccqEUTKE
         qBgeSix2/DhK4pR9v61LNGXde4KVGpC5HEkEjsAqPUNokSdH+Td6JupmHX5KaZ67VwvZ
         y4gu4MuZe5VFL6+Zr1zIFhvKUoYpdUX9CdjScI/p8xyXdVUkIiekxfQRIxxQtLmWPQ4d
         K9+6SsRG3ctncHS3Mnugm2i5sdt07SJ2zKS1ypflTGEaHhsWY04HetPYUFp1yU2ZiGIx
         0wOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793844170; x=1794448970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HpFmULoD3PKNQA7nQ1ArjNPpfG8VSqQMXNJlOpOCtTU=;
        b=PPPXJZScyzpxdzCEKxYJdZW6ZBxiWzqwB3bdVFQa6EnbstAbY+dWI/Hlws8HDUJnIX
         BqrbeJy4vSJq2CYls9KLlYWRkjbktHR+LemyVsPq4TpsjSfyIpx0btadkq4sIIRbwF9j
         YQqZ9w32ynuVAq2S8rijXeWVPPoXDcb6bW4YTCBDocOakt/RW1mJWvVQVR9onRfSROZ/
         8+3XOrac+vdeC4ZxhElGsAavNYc4NUeZKSARSvHdju3Oh4/VKEkUMBlpoj3A6R6KeMEU
         R9uRSF3jqwBEbiAcfyVyBYtWmMi4fJG3k5aAcACZO+fJ7cv1EZPs4cyoE6WVVJV57Euq
         6p4w==
X-Forwarded-Encrypted: i=1; AKwUvByOuM/PZC1Q5FgzDBP+y/gVP8hWqywKFJykbAPxuEUgzcIQCoSS8xynslg2xBQUEhUvnkO0jMY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+W3N3QQGJWtmC2M5HGAObH5O4iJCK1qPGt6gKCyNdWHS7QlqVe
	9RjsfHU7LgnI2+ipaj2V9/DM68iVcLH5zKHE4KRKmAIT3r9U/YI5CkpOiQhclOqzJuHkYs1bSpf
	aII8uCXI/s3a0Z1FmjfZGx5a0cnobbfPHiNws
X-Gm-Gg: AYBFou3SBNfVVWJWXnYrlNrzg29FOfP5XpF+APSCPXhBePVtil4gzoOmqrlyGSLEtLM
	0Gp01ERw3G+ftepllx5nXUciPW2KYFbRVXcT/dtOZEH32zbc2SCpUMK+2yfjeBiAKaDm7dYPTHk
	sqIRcBeBQBGYNONLaNn5tqn/IKK2V8UISg2I0hODyfATgFvDwH27heJG2Q4jc4pEGooNWyjDXK3
	jZZK1YZA+YhRh64FDqus6re+16m40QUKJhcviVpVspHK0Wb3Fa9spyS9tcdpeJpFEP4x+hXVix+
	XBTCoYLyFX4KD8LU+lcHp+9310nxWLpY1bvJ3FC12GLWA1eQyFG1UOLpb48EIBjpywGp1L1+9z8
	HgyM5Yj6LUWtABK3XppA9nuKxAytEu7lxLdt2Dw==
X-Received: by 2002:a17:90b:4d05:b0:3ad:c482:ae93 with SMTP id 98e67ed59e1d1-3ae897f55f1mr15463825a91.27.1793844170366;
        Wed, 04 Nov 2026 18:02:50 -0800 (PST)
Received: from c14-smtp-2023.dev.purestorage.com ([208.88.158.129])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b0b93e8cf1sm370875a91.8.2026.11.04.18.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 18:02:50 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from irdv-tmenninger.dev.purestorage.com (irdv-tmenninger.dev.purestorage.com [10.32.149.15])
	by c14-smtp-2023.dev.purestorage.com (Postfix) with ESMTPS id A268D340292;
	Wed,  4 Nov 2026 18:02:49 -0800 (PST)
From: tmenninger@purestorage.com
To: anna@kernel.org,
	trondmy@kernel.org
Cc: cel@kernel.org,
	ebadger@everpuredata.com,
	jcurley@everpuredata.com,
	jlayton@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org,
	slingappa@everpuredata.com,
	Tim Menninger <tmenninger@everpuredata.com>
Subject: [PATCH v2 2/2] NFSv4/flexfiles: limit transport disconnects when cancelling I/O
Date: Thu,  5 Nov 2026 02:02:49 +0000
Message-ID: <20261105020249.2607367-3-tmenninger@purestorage.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105020249.2607367-1-tmenninger@purestorage.com>
References: <20261105020249.2607367-1-tmenninger@purestorage.com>
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

From: Tim Menninger <tmenninger@everpuredata.com>

ff_layout_cancel_io() cancels RPC tasks associated with a recalled or
revoked layout segment. If any matching tasks are found, it then calls
rpc_clnt_disconnect().

rpc_clnt_disconnect() disconnects every transport attached to the RPC
client. A data server client can have multiple transports, while the
cancelled requests may have used only a subset of them. Cancelling I/O
for one layout segment can therefore disrupt unrelated I/O using other
transports belonging to the same data server client.

This is particularly disruptive with RPC/RDMA during data server
recovery, where unnecessary transport disconnects can result in repeated
reconnect activity on otherwise unaffected connections.

Use rpc_cancel_tasks_and_disconnect() instead. Matching tasks are still
cancelled, but only matching requests belonging to that client that
remain on the transport transmit or receive queues are marked for
disconnect. When such a request is released, SUNRPC conditionally
disconnects the connection generation on which that request was sent.

This preserves cancellation and draining of I/O associated with the
layout segment without disconnecting unrelated transports attached to
the same RPC client.

Fixes: b739a5bd9d9f ("NFSv4/flexfiles: Cancel I/O if the layout is recalled or revoked")
Signed-off-by: Tim Menninger <tmenninger@everpuredata.com>
---
 fs/nfs/flexfilelayout/flexfilelayout.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 9492d6bc1d1a7..700f0e4606e8f 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -2599,10 +2599,9 @@ static void ff_layout_cancel_io(struct pnfs_layout_segment *lseg,
 			clnt = ds_clp->cl_rpcclient;
 			if (!clnt)
 				goto next;
-			if (!rpc_cancel_tasks(clnt, -ECANCELED,
-					      ff_layout_match_io, lseg))
-				goto next;
-			rpc_clnt_disconnect(clnt);
+			rpc_cancel_tasks_and_disconnect(clnt, -ECANCELED,
+							ff_layout_match_io,
+							lseg);
 next:
 			nfs4_ff_layout_put_deviceid(mirror_ds);
 		}
-- 
2.53.0

