Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794007732;
	b=Gf9JDvf6Wc1YU+OCEESO+hCv1RSATqhbqqQdRTRDpFZRXzxDgqJkXDru8PncTlQ5l+JP
	 0D+o8qUS2FYjoZ21LvcZ/9+Lj1IXudFBuEPGVoqA7Fi+g8hAHFnn2kxb01qAm6PY2O4Yn
	 CLMW057jotVPxXyI/xWWTM7Og5mMTBQJ5TTCryRLqZpfvry1TjK7gTXlJQ4mqdBrxMGE3
	 n9gmQ5gvV+5mo7wt429KhaF8aQCxIn0sjH+QW4THcrkzyBOPRi13NpYprz+PAl1XxSADj
	 zaLjZpKxPgKRYNn2DQme1dKJVLRaCPQyunY51OqsYFWqT0WC9la4dDGXvJ1TDdAYTYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794007732;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 X-Relaying-Domain:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4Owt92U9/K297y9PboHuFVnZHHyIFy57q0eKvHeAnyg=;
	b=MJZ/whQ3K8RBq68zxA5EYkPqVt0OgCCkPUL0yogfHVsse+GS9Uy8q8Beq7HT48rup8lp
	 XvNdZ9LKR/40jyuLouJKjuokbZ21fYkAr+ELcJfyDgZzJP2192Vc0+jean1GYQfJri4BK
	 pU1x7A28BzOhT0jVHqUzKQZH8vuiIIqxqV0Fx0GhYs5LGjdVBWZscVtkpOAKFkNk4Y0nl
	 Jib74T8mX15yYq+qDC9V4GvM88OWIaeWDxCQZQSmMHFeVLP+URCPX/3fnMZhcfOuHkBV3
	 0IIkDsPEgrP0LKrGUKX0Pd+AJcVMb+Vm4xbkn25Az1OKmwrM9dRPVdqpqmMQsIU7XzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=everpuredata.com;
	spf=pass smtp.mailfrom=everpuredata.com;
	arc=none smtp.remote-ip=209.85.215.225
Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com [209.85.215.225])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32A6606A326
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 23:28:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A32A6606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=everpuredata.com
Received: by mail-pg1-f225.google.com with SMTP id 41be03b00d2f7-cc4aa18f9afso497701a12.3
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 15:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everpuredata.com; s=google; t=1794007725; x=1794612525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4Owt92U9/K297y9PboHuFVnZHHyIFy57q0eKvHeAnyg=;
        b=FT3qLASnVzV2WkcjaX4fdn5pExpQa2aPIoICyH7HJcCgDJhoKHRKPnkqy3pfCM92Sz
         XrWxGI1XuggIzkunX6YXWHYVdIxzKz3wpEpEDEoKR1Vu0AnIV3DtJ27ClBpUhi2XBw1L
         SAW3B4URVCNC/VyXGQnobGy5TYxKKpHfB+Q6+WAuEldmafVCe2GSmAvwCuYHqfJ7q0w1
         OENfvn/lTsssfQz4AQTAI371aHjQTrmN1Uzoy8K60rhO3smeUkG/4QI3zbGpxuCD2Y4O
         tfMahpU+yjmKtI/aahOU9kepOVa0+zJZ8/W4BhQnsIDcLZdYU8FPOvKoysZOcJ5wIaY3
         y4Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794007725; x=1794612525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4Owt92U9/K297y9PboHuFVnZHHyIFy57q0eKvHeAnyg=;
        b=nIdQESn/fyyzuJp5AY5ymPBh3E0hEjtcDCbXp8DL8IU4iSDanI2xomHpULXjE2Tt5+
         UkuUAL6a8Lhn9GFakDEgsdVlitIy7XartujOnP5wqRN/sM+5gQlVoQbrlSVufECGs2Kk
         Iy04IkW47S5RDvvze0IhVYp8Xu+rKRcaRXwtOyDtp2KhWWF1EyrtyWEBv8xgIjbUz00N
         EPjuoAvHUJajYhWMIrDAu88Mion0S+K3ZtJfAmEdIyyPdXu6ATtJrb5EzLlfN6x0nM2L
         Cd0VnRZJ+NX/WxAcAC2qyo1Seh0hqa6E/p/fYYNClhtOyzxTmV1uXQx8NRzqti3lGim4
         b9tg==
X-Forwarded-Encrypted: i=1; AL+hErGP9pxmkr3Tg4hRfySonEkCRRiHXhdq1ejARQS9LU5YI4sTxfabodQUhS28qU93EnYkncxnXsY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+6dpsrREU5WVQDF7b2Rsfp1GR2eMq4NObzkYQA0mbvZiwDpkVr
	an+BDzr6BnZewyutPU3zqSiiyxeZd4PIP7dSaDaHYWDWpiWXBE19gZ7jRMc4cfghno6E1iwkrD4
	pPDCgK44n4jquf1YUogamUfVq1L63Ox6poc1R
X-Gm-Gg: AYBFou2l7prSU2aoYD6buVPpek7nuP179uVWpIYfRRaIA/E8fZq456m5OJeUXWmcCmM
	K8+/qMWppGw1i5+YUBd4GZNxoTKVqwXIq/9dqF+3M9k14+ehHa7i5lmQS6EhtHL8opTVJqVqwwG
	cX3Ok0U06beOAn92SXf/xtH7zDBKem9JgBcnm8NHICLY5RfBcA+3/rKVeWdB2sMvbbIC8MKec5O
	/kvhD8utXz7L5Up2JO4oHRUks2mnF29cvGBRUdKjvUOaXS+nTtnOXXpWDo5CadOyqzXZFAK8ihB
	gbCzaEZ5nrCxLOP16qwL00bXTs8ZzWZj1xEHXV9MfgwexSruGrQsF3Gme23LMu/fJHnTgjNW7+b
	tpZVVi6zpRRXPhJ9jhCtwJiY2SgNRgL8LKq1xVmM=
X-Received: by 2002:a17:90b:5107:b0:3b0:ce1c:e74f with SMTP id 98e67ed59e1d1-3b0db6ee67bmr3731051a91.27.1794007724872;
        Fri, 06 Nov 2026 15:28:44 -0800 (PST)
Received: from c14-smtp-2023.dev.purestorage.com ([208.88.158.129])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b1057a07e4sm394446a91.2.2026.11.06.15.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 15:28:44 -0800 (PST)
X-Relaying-Domain: everpuredata.com
Received: from irdv-tmenninger.dev.purestorage.com (irdv-tmenninger.dev.purestorage.com [10.32.149.15])
	by c14-smtp-2023.dev.purestorage.com (Postfix) with ESMTPS id 4D12234039C;
	Fri,  6 Nov 2026 15:28:44 -0800 (PST)
From: Tim Menninger <tmenninger@everpuredata.com>
To: trondmy@kernel.org,
	anna@kernel.org
Cc: cel@kernel.org,
	ebadger@everpuredata.com,
	jcurley@everpuredata.com,
	jlayton@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org,
	slingappa@everpuredata.com
Subject: [PATCH v3 2/2] NFSv4/flexfiles: limit transport disconnects when cancelling I/O
Date: Fri,  6 Nov 2026 23:28:43 +0000
Message-ID: <20261106232844.2176820-3-tmenninger@everpuredata.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106232844.2176820-1-tmenninger@everpuredata.com>
References: <20261106232844.2176820-1-tmenninger@everpuredata.com>
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
index 4419ded8fe586..5c289737366f2 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -2611,10 +2611,9 @@ static void ff_layout_cancel_io(struct pnfs_layout_segment *lseg,
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

