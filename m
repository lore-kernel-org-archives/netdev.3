Received: from mail-wr1-f98.google.com (mail-wr1-f98.google.com [209.85.221.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFE74DA9B6
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 20:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790282732; cv=none; b=Ba0E/vaplomP0Hcn4gnresYt5P0ilFnKxibYDjHw13+oC2ZsqV7p6VAeqW/Uh7Il1n+h6Eu2obLfnqoW0LM92MjXh+NLl2pAK3EIQqAmzN1E1DBQgKC/LdUbWQsfj6FZ/I755VcEZJNc7N2vdtH/kW29hs4t92odIGG1r9hljCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790282732; c=relaxed/simple;
	bh=x8mpSZAEm3eQOopUPKpcZwReGof0vwEsvZSbWVvBWHc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CZ5Goovq7BgWDSLzamRZHiTXVf32MYbGzCFUdSDjA/SkhTtkLJPFTnGImzLwHfDwsxUBtUMZPvv34jJzvuiFumYd8bfCAU3tYScyEwxSzXi57s8mV4iANiSZUDRwSBDbTBLa5WHcz+1FxzmoYf3ik6balinbDmIp/QS8gJzl5MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com; spf=pass smtp.mailfrom=everpuredata.com; dkim=pass (2048-bit key) header.d=everpuredata.com header.i=@everpuredata.com header.b=0Mpxlnct; arc=none smtp.client-ip=209.85.221.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everpuredata.com header.i=@everpuredata.com header.b="0Mpxlnct"
Received: by mail-wr1-f98.google.com with SMTP id ffacd0b85a97d-4870ff37db2so45577f8f.2
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 13:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everpuredata.com; s=google; t=1790282727; x=1790887527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YnoZqdKp0UmU2IbT5SSKBJURWBPbYOiKApgDq7nANGM=;
        b=0MpxlnctDdkia3inaCSKTXt9k6rq4gt6Y92iIW0EoXzEDPX4YWeeobaQBL1p7jWI9s
         giws98nsSbskKp1IJ75VymEwDx6TpWaVANoOaD9x4VDdUuJLENNZfPT3aFL5ZjAh/poa
         I8+aRtqtv6pkUF/fk04cZOvkzksPDzQIoaVUD/EFxHk2X+b9kTjaze7d1hxjrKJ/BHT5
         CGN4GM8Xp4ah9zzVOPwxgKN8jlML0nUFFzRfeaXc+SWj5Bm/6EIsMDWPR9q0QbELwRwI
         U9M2LjUWQPxpfBp2xN+vOMggpKldrmDADJZQSRE3OEe+Aaa/j6T7Y/oaMs6QrOgXtBEM
         usQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790282727; x=1790887527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YnoZqdKp0UmU2IbT5SSKBJURWBPbYOiKApgDq7nANGM=;
        b=Q80IX1dCuHMIkK6Ravk3rLYIkoKBGCnY82J7fvTNjnBsRj36KywpcYXOXR8p7t+xjr
         /i8z8BYZ4yGmuhk0Rj/m5Jwawqc0av+8Svgvwd4NiOcAbglpA2nMe2aAJHYoNampSE8S
         Hamt91BEOWIDuOEMRhizhY+/2R5/6naeaqNAXV/1ChLGwqCmkRZn9WJo/TvDyqyj6nhG
         kDwvKm+4E+MG8ryw4gzZZjwNU+Klo9ko+Io2q52UFDK6k2jyJ6WL48OEYnzfq2cjsF7s
         sz8FSM73SeaQdD8D/em7h2yv55lOE/o4wgTU9l95xNpyEMY1zpT2H7RqvZDVVWe1MiR5
         IhTw==
X-Forwarded-Encrypted: i=1; AKwUvBxNbeCfa9nFS6O5kaqU1xIhmbKCzyixG6U23YQyiD6oHN3zjpAbb6Ngb1J5PfNNTlu1rxRAMvU=@vger.kernel.org
X-Gm-Message-State: AFuF++nP7TbAGIpvmXhnHJG8tecMy4JzdO725Ar0nV/3LdX2gevBTUpe
	cMBYeO15XLwzpwFUPZny6UwOTri/gLkTR4lSVL/GIt6Qto12/vozSSzvLFw9K0fQZflxdOql7mg
	j6fZzQ2HYEfnTnsozQtJkGeiw8Jdd7W3WTL73
X-Gm-Gg: AYBFou3q/3OysREkPa+S2+HmaL64u68QHXSW7LTpPS78+UsDWiIsVHgLRqvAvX35ts6
	Eiq0ZREZNECqPDbNQ4Da/3NKtjwKxI5EzZyFERv4B6TeChryGbOdYcc6nDKCXNhHIUkEM0/rZN7
	222U8VkG7kMkAEWdCLybErCZo3HqzmgeJaXFo/wCG+RDzPvj/d8IYa5iYD4VILoEDF/k5HFgewa
	EHbCV2cdB1bONUD3GfaNZ8QwNJiYgpVuPp4z1ZZozbK+KpcWF9Y+g2JuL6RBEHarIgc/zeO3eVX
	JB+m/ORYpSOudYvrDrFEuSKM69CtY5aXk2GgrsJypQIMOwRixTQTtXz08pXL3pBHpvd0gutvS6E
	LxT57ffzgf0/JfW68oliJWC0EoU63nCb3k30YB5A=
X-Received: by 2002:a05:600c:4745:b0:49d:10d6:fd55 with SMTP id 5b1f17b1804b1-49fe66abd7fmr67822475e9.1.1790282727199;
        Thu, 24 Sep 2026 13:45:27 -0700 (PDT)
Received: from c14-smtp-2023.dev.purestorage.com ([208.88.158.128])
        by smtp-relay.gmail.com with ESMTPS id 5b1f17b1804b1-49fef399dc7sm1175115e9.4.2026.09.24.13.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 13:45:27 -0700 (PDT)
X-Relaying-Domain: everpuredata.com
Received: from irdv-tmenninger.dev.purestorage.com (irdv-tmenninger.dev.purestorage.com [10.32.149.15])
	by c14-smtp-2023.dev.purestorage.com (Postfix) with ESMTPS id AE78A34107D;
	Thu, 24 Sep 2026 13:45:25 -0700 (PDT)
From: Tim Menninger <tmenninger@everpuredata.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Shiva Lingappa <slingappa@everpuredata.com>,
	Eric Badger <ebadger@everpuredata.com>,
	Jon Curley <jcurley@everpuredata.com>
Subject: [PATCH 2/2] NFSv4/flexfiles: limit transport disconnects when cancelling I/O
Date: Thu, 24 Sep 2026 20:45:25 +0000
Message-Id: <20260924204525.3381590-3-tmenninger@everpuredata.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260924204525.3381590-1-tmenninger@everpuredata.com>
References: <20260924204525.3381590-1-tmenninger@everpuredata.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
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
index 7fe8b91fa47c..4f7401680de1 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -2484,10 +2484,9 @@ static void ff_layout_cancel_io(struct pnfs_layout_segment *lseg)
 			clnt = ds_clp->cl_rpcclient;
 			if (!clnt)
 				continue;
-			if (!rpc_cancel_tasks(clnt, -ECANCELED,
-					      ff_layout_match_io, lseg))
-				continue;
-			rpc_clnt_disconnect(clnt);
+			rpc_cancel_tasks_and_disconnect(clnt, -ECANCELED,
+							ff_layout_match_io,
+							lseg);
 		}
 	}
 }
-- 
2.34.1

