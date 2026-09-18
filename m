Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6CD4FDA76
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 14:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789743524; cv=none; b=SXttzdA5YgRQcHeK/NPb+RDE6W+VBjHzfW/YLbWxVH2jzI1yF8lsf+dIDtCIZU4PUHhtppjgbw4KlyeTTe4IqPgpegmaMRQdCVsSezmF/kYX+O4gmDGv2mHEGooiEPBVblG7D6XNWE6537cGqHW6zabAfxcCGiHICcD22ydpexY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789743524; c=relaxed/simple;
	bh=zoNTVsFn2L8ZQUpNzfD8JMrdLAz6HTNoSDK6XN9I9T0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tf9Ci9ii36nmtY07XYYe8Wgo7nkVu9WR/v+W5cqub9sdXdpVT0mL1QLA3UKO2hrSAXCAFJGuFxRh9b4uTEOkCirVtxp+uRaMyZR4FAZWBbD5fbxfNFyrX7f2e5zEE9L92phl+QyXgomutkLW5i2xkRwQRSp+f0SPg3WkdApPzQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=seKNOR9/; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="seKNOR9/"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39b2ad83dc6so778096a91.0
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 07:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789743522; x=1790348322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eGf6+GV3IIEO6NYP1DELXeYxIupStmMlcHdqZNWtH0E=;
        b=seKNOR9/8koI9tnFQ+ChF4kzmXWLW/oMqCfWRNRvrhNMXMKs5caedlQKhbwKh/8NvT
         NALCpmoTabo2+S9Yr0z7Kp/tpU27nAfy1y/dpxvi/cB4OAfxNpENWXht5S9Wo7mMRgeW
         uDM2oXvfUNZj2GmMmSfreSp/fgrJhuHEBVXtd0rjQQLn168N1QqxdwdSUn7M7FXGv5rj
         AIplP5pblejPuTRq23D6rlxU6wRtA8dSfMs1Dt8OUwPIVPF+WkXVjB5nFHNDNrjSwgYa
         xJHEBk5mAO28is4YBNy83EYUnvm3wzyZhodH3fOZOoBpOKKN4l9SpUdIvvxLo7MRlSYI
         a6fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789743522; x=1790348322;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eGf6+GV3IIEO6NYP1DELXeYxIupStmMlcHdqZNWtH0E=;
        b=VvxYgwefBFUC+bwcIePM4RI1gZLzFmKkHBUtchNT6lgytKHvyz9Q3nx3xIlLbr0++P
         TioUYVQ6zrnIAC2cLYy/jelH8BnCNhI0iJOI0w1op2Yp96fbrTiSymv16203kz1Kx+CE
         /gbWqcGqtc0eOzCRTTMhhYlOlyNd0MJKzQyKNSMH01k9UdUxZZnQvVEjdfoVwzgAgn8D
         vMfhPQ9lYriwMg0YfyB/Pb00KFmoxOablEURjoOClf1TF5qjfao3w1wvF0z/ZdHmSww6
         9YREqRYUTbHIoMydoyrjWLLu7mh5OrXvyi4qM+eobGf+vx14bfSP9yBIzmo5xxaCcalq
         CKEw==
X-Forwarded-Encrypted: i=1; AKwUvByl8As8XINxOaNykYmt9MjVDWgiWBUIGJ9eDhQUOqDyCnvhkk1ik7DthzbfIT3amqK6k+RhaN0=@vger.kernel.org
X-Gm-Message-State: AFuF++k4ubindE9PRkMEpH1Cjmfgh/FX0S+Aq4ROGu04FfYjW2801gSH
	Cl6yV1BAi3pqH68vs5joQ1WbnB68+1sXqTjjle4PodT3MF4gnuLtRl58IHPIA+usJNTGvQ==
X-Gm-Gg: AYBFou1eyUN7ZcRQ+wrthtBfqaWklCk30hwbLbTIyNt/nUlWqrtvM9B/1GwHagrUW0h
	uT/JunzQfYO0JScbRje1hwT2i9ON5IiJJtoirqcbl8x+XJTCz66BzgtdySnBagIbszQjwaChEnr
	i3lYT1PQX4OPs1gp7OMGbqJaMzcxTYiu3zmsN8Xum+PiTNZNscVlPTjcKO9eE4DKA2ZvtAvJcUu
	dHi1ENPi25tECz15MT+9ObhKUYdhVL/NNwIHNzX/Qijf+2GYm5XdiE/vHE2J37JxrfTsxuRkqdF
	BN1wlMDx+IwNUF2nPvZYc3+YZZqIakUBHcW7YSmMz1J1VsXMZkQNbbRTeu9QtEpHmEMtyi+TbGs
	S/BufAkknUA24rLaoo3nHbze82/JdO+Yksxwk7UvnkUf/nUud63OZCQQnvJyaQxTwtLLKQUUrxQ
	tgWOcYOPfFPd4sq3RJYxRvGGhu1miqh0TBWKnpxIXPJ+I3Xs6LmaMRb2gX/okW+4f6QomJf7vey
	9mFKI9q/U0ZgX7ZoyWNB2dY7Fy6Ukr7
X-Received: by 2002:a17:90b:3ccb:b0:39e:4c7e:f03e with SMTP id 98e67ed59e1d1-39e54f2158bmr6529020a91.27.1789743521728;
        Fri, 18 Sep 2026 07:58:41 -0700 (PDT)
Received: from 192.168.50.3 ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e5a50c9fasm3954108a91.8.2026.09.18.07.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 07:58:41 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: linux-afs@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	stable@vger.kernel.org,
	co+c09f7e87f6209a56@bugs.sh
Subject: [PATCH net] rxrpc: rxgk: Initialize challenge control message
Date: Fri, 18 Sep 2026 22:57:07 +0800
Message-ID: <20260918145705.1511737-3-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rxgk_challenge_to_recvmsg() copies the complete rxgk_challenge structure
into an RXRPC_CHALLENGED control message.  The pad member of the embedded
rxrpc_challenge is not assigned, so the copy can disclose one byte of
kernel stack memory to userspace.

Initialize the whole structure before filling its meaningful fields so
that the reserved byte is always zero.

Cc: stable@vger.kernel.org
Fixes: 9d1d2b59341f ("rxrpc: rxgk: Implement the yfs-rxgk security class (GSSAPI)")
Reported-by: <co+c09f7e87f6209a56@bugs.sh>
Assisted-by: LLM
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/rxrpc/rxgk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rxrpc/rxgk.c b/net/rxrpc/rxgk.c
index 77a67ace1d248..799772b0d8472 100644
--- a/net/rxrpc/rxgk.c
+++ b/net/rxrpc/rxgk.c
@@ -756,7 +756,7 @@ static int rxgk_challenge_to_recvmsg(struct rxrpc_connection *conn,
 				     struct sk_buff *challenge,
 				     struct msghdr *msg)
 {
-	struct rxgk_challenge chall;
+	struct rxgk_challenge chall = {};
 
 	chall.base.service_id		= conn->service_id;
 	chall.base.security_index	= conn->security_ix;
-- 
2.55.0

