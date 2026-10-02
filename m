Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5BCCA6B
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 01:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790903102; cv=none; b=uBa1es9K3uUcJW9GzCX6vdzGKuCf7PVdQlAt0fsVlydy2vufIVLXEjlqU/azPxyd+ymCTZ3jmunjNDZJnhnFMRMdflqcFOsfmHAv+9XpqVZ3D2aosta8Lsw7Scsc+mM7zKzx7tTMz2M2a00EOv9ze//4egbkpCV+nvzdaQvFtto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790903102; c=relaxed/simple;
	bh=70E4JEwJRhITrayTFGxFr/Ka+e6/XGMShGQ5vKZGBZc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lwpgXMbo76vQ7VX2y/xt6XqSSWy/ZDtR8CDvTp7fZVotsIUkXpS1+YWjrXAc/TWjQ198+fQbx5ygNsIgKlrxnoNz8eMC8Y3mreA9KxkIT3m1WzPTHpIdgV7IYDjod7K+BFlsbxkUY8wbO7lKl/bBJM/anl/W/rk+MdiTl035m/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fv/gSVkw; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fv/gSVkw"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc4c3304784so3078112a12.3
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 18:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790903101; x=1791507901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cGNX4KL8GRa1VIINdGkPoVIRrpUVCsPABrTMa/jeOp8=;
        b=Fv/gSVkwZLBzjHeKivXsZKpxWt+zzMFQ2md9GZKSnGlD49HEDu738K9QCRd+H2G2Q1
         lz/OV/Lq5EXTpJYM02vxisOfzEIHB0IUNoetE1h75dIuAZNRwN/uYvVkhs+1VN30+Ltg
         we2m7WNHUquY3N6LpHBZP2DSqmTxi246x2W+H+ZKoSlb2taTk0bXfCR3oRFt1gTur22x
         ueRmmbuCAFtwsBq4yNTO76Cw0bwMv7dgX6AEX18F7S339+W1FOvWaLy2DQC6OfCUTZQC
         +r/h+fLNoYz8t2UjRtRg2LdzfgtzdA2c3/E9nZ4/3uDN4THJTBu/9pM0hUxnOdRRbkQa
         XJ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790903101; x=1791507901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cGNX4KL8GRa1VIINdGkPoVIRrpUVCsPABrTMa/jeOp8=;
        b=MlsDWSObqD4GJJsRyvORjW8fCr38foT2D1sgnidZauj3daLd3lQioA4K9Btkn57hvC
         OeHBG2AkkEBU7zN95+SbaEEJBE8r3rVfM81On+5ZGPNQBhyAilYJAquF70KjQglbpk2Q
         mBErQkrs8ceDgmQb1p0IAg4vsyGtX/nXPPPpBYcszUCe71BBimXg0wwbtfXpZjugm7J1
         p0O7QZtkwo1cQaKfUh4R2PjlkyK6x1Z+BhzGtKulJksMks9k87clx5iS47+nZTke7aBh
         TrYUP9JyzCoNcdrlK9bxDFzVCQWTeGvEutT/zzyNPoNamFC1T7ePLcGpgwot1yIFNuRR
         bBCA==
X-Forwarded-Encrypted: i=1; AKwUvBzwdTD2lT24uBeZPdABKrUJIPhD4CjYiQDWUfj8vq2ddym/3l5Y7/h4OUn+hGjEB5mCYoPZtO8=@vger.kernel.org
X-Gm-Message-State: AFq9FYI5ynLtLwPP0uQkmTBGiM6MsrEaThAHRxEMSuGh1yqnr+MR075+
	CEgFn4wN/aE0i5QlkP4AdsMVvzVUTW9wAxFfvUig7dixvHzqnbGFarXT
X-Gm-Gg: AYBFou3q1O9EVJZJUj/GwCw+IjB+OBE3bXK+Cy+O7SGm/eWJXd+LVydHOv9MHQM+1oR
	/eaT5wwR8kDAuFrPwU/FeEuAKUyccAty5vPtF9XOwJzGpH7hoX1ha71SYxECKNsHA4gpfKbZsI0
	OhK5NU90aqGuzCh/YPZeKxpCToO6646MMufU3X9l/iRPnTRlWI0o8pk0Sb3rzDw8aI3XTBQEfSG
	f0dWQSS3G/KPeSsn3ZrS6NI/HiY5IaztC6I5SD4rMRVT+YMcqaTc/mRy8PUbvUnuXBJlG24ATp7
	6Vl9FvPpunMzQVG+DvNZSQ8YHh+iskA7OPQVyHB63BIZDRUXBKvfMuunvkXFY5LR96zNUEO9avh
	CVuskJ0uzY63u3U+I3cQkwdjbVANVeZdSHMV8BTnUDPdkv8O58wiRE9BNxCt3Rsd2UpPhD9O2/u
	MtvG2ZzL2qLtkdFUuWuXIEyfl/YV1iOFWFm/bSYfIIdTKO6xVq9A66caVnXzWhxR7hWPaZGqdWg
	GCQqRbxRuw=
X-Received: by 2002:a17:90b:1e53:b0:3a0:a055:1741 with SMTP id 98e67ed59e1d1-3a6ceaff95dmr666070a91.27.1790903100692;
        Thu, 01 Oct 2026 18:05:00 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a6cd44c23esm1587388a91.4.2026.10.01.18.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 18:05:00 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: marcelo.leitner@gmail.com,
	lucien.xin@gmail.com
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	nhorman@tuxdriver.com,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daehyeon Ko <4ncienth@gmail.com>
Subject: [PATCH net] sctp: revalidate output stream after association connect wait
Date: Fri,  2 Oct 2026 10:04:49 +0900
Message-ID: <20261002010449.3689454-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When message interleaving is enabled, the first send waits for association
establishment before building its data chunks.  The wait drops the socket
lock, and handshake processing can reduce the output stream count to the
peer-advertised inbound stream count.  sctp_stream_init() then frees the
extension of every removed stream.

The sender currently resumes with the stream that it checked before the
wait.  If the peer removed that stream, sctp_outq_tail() later dereferences
its NULL extension.  Fatal-oops policies then panic the host.

KASAN: null-ptr-deref in range [0x38-0x3f]
RIP: sctp_outq_tail+0x49e/0xaa0
Call Trace:
 sctp_primitive_SEND
 sctp_sendmsg_to_asoc
 sctp_sendmsg

Revalidate the output stream after the association connect wait.  Return
EINVAL if it falls outside the negotiated range.  This matches the pre-wait
check.

Fixes: 668c9beb9020 ("sctp: implement assign_number for sctp_stream_interleave")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
 net/sctp/socket.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 4652fd90d9a6c..394d31cb698e0 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -1848,6 +1848,11 @@ static int sctp_sendmsg_to_asoc(struct sctp_association *asoc,
 				err = -ESRCH;
 				goto err;
 			}
+			if (unlikely(sinfo->sinfo_stream >=
+				     asoc->stream.outcnt)) {
+				err = -EINVAL;
+				goto err;
+			}
 		} else {
 			wait_connect = true;
 		}
