Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515C7279DB1
	for <netdev@vger.kernel.org>; Sun, 19 Jul 2026 22:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784498549; cv=none; b=YzFi8BPcXlZbCXE6paAQAVdmevgV2Ado79KW59AWzr9jjMlpFusBgrdTxHfqIGw6AJQXQ0ErxVgS+1Kw2welHxSXNQhdsKPPDIhHlc+4NwUJeqgQWvC78cTMh9NVrb9JG18UufckzitPclav/zvOXWI6HDdeQ8zbNJwdPMJ7obY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784498549; c=relaxed/simple;
	bh=0w+3lDYbj5Tk1FVUEhvs9fuaoqfoYazTfOE0hL658ps=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D5b/+ClSeanxvZeXsQbnCkx6gRq2UzKmyMGxH52qIgjsxGO91y5LaJSWwv2Nps3uS1wqub73MLKXIqKhSf81aaM4WwRXvrVmvG+yzNqZ0qR57q4/zwj1Gt3qcQUwCYWwfoWWyZnej8r2LUX8nN8Qtb1ohPBeqL6ZtYD1d60omnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZJM3fmfg; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJM3fmfg"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c9d1fff21edso6165684a12.1
        for <netdev@vger.kernel.org>; Sun, 19 Jul 2026 15:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784498548; x=1785103348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZfvhkooxWj3CsP9ZhhIe5Neuekb+2Nv4jVoCxZTmOkA=;
        b=ZJM3fmfgYwHqQWUHphdytUiCB2LMtJBGbKL44OG1RqC104Jk4FQPnZz2D7OSq81aoh
         swpedFNom5QSmb2aAYc5Ii94fUV75vJ/yctVavIoeQrrJcoZTvYWvGd4cwfoRkVLkjnz
         VDKFHe/e6i6QwvJCyM7fu6nayNUdvhobnVpa6hk9TYiI/P2xi1LMhAiadx8N8atIwqEu
         8Q07gFpBAEZ3BRun4IXHCbfY6D9GnZ8wJyerU5GyE8lGtDVyhH76bKV4pY/V4+nQFDlJ
         wr8BZVf81egXOEqorGeBTpel/dc5ZFDEMiSaAWJLXtCUWuEm1MkE0ayLrcCL3AWTARxO
         wVQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784498548; x=1785103348;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZfvhkooxWj3CsP9ZhhIe5Neuekb+2Nv4jVoCxZTmOkA=;
        b=N+IbrINLxJ5ypgJxiVNrNG9JziET1CXeCdGq1HlQDEkMt1sRupSfswfRmK3d4ro4Ih
         QXmqLdVD7Jq7KiA/JHi3Wn5GOGiRpIeaXFd/nmkqNP4LqX1lupDhTzI0ER9cfCNpgAfZ
         tC41SCaKvYrtH6YXuklHh7x7oHruEuHTBeVxExuLieKK7GPp5qxwE9i1f6m+auvjG3mA
         UJzzUoJ1CJPB+7m8q8N9UtnLlwTQqxywn4cGR2ebUsQlLLPkeezAU1lLuDYXSc+ZytbK
         I7zjUUNvtrD0Et4Knpb0Y2X5PIDU37Dv56IAfBjA/l3OXQG1/gkFUgopPTAzuJgvaEld
         GYDQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqqxudf5c4p9MOAtB1TVwwXIbqVEVosFIL/Ru4ZQPh67/FfH1j7CoR/3E4fexp9k2jhkVExIto=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2HOkVRykrbMz0fRGcT83mgZh0i7wo8mgkjsYEscXrtyJp46Yk
	wr8b0SE5IOyLGHqB12CDroSm35aNOTBaZHkSwfkY16b3dln5ZibO63/G
X-Gm-Gg: AfdE7cn7WKcWd+nMEe0FpCwm1mixk/mkVh5r4zsaowqTwT1J59OpqTJTWDWvjmqIjWz
	FuCTmU84YtlbR54viBPpi0bQsr00JsIdU0bcWEAul5AgzKL3ikNDthHlObNqQ7gK1429fjq/isB
	V/UjJ/63gUFa9zrwpQsfx5mvSOcCaxElz7Iu5LTcwXRQ2S0Bt7MY858jsIAcp+CnTLoecHSan3b
	phvMon7YG7EThntgKut/NHugCEkvjxK3Mk5fDjZF/Pfdg34WCrpdsq3Zg6auVEcTXjT0lxYsmp9
	91egTXBF6eE6MicucsrvGeHlUBiFyjFUHLqDo8J+LDQ8D+I0wiC4+wMdAkzFNUAYi5KOtsbs/SL
	yECJqnSJR4vEqYhJem0GSOyaUn4beOGZE7wpOt4rXRFEiyGllnHbA/T6q1R1BA1wDC3uGh+Fez9
	NAPoA=
X-Received: by 2002:a05:6a21:a382:b0:3bf:96c6:78a9 with SMTP id adf61e73a8af0-3c3ad665b3fmr11748627637.2.1784498547566;
        Sun, 19 Jul 2026 15:02:27 -0700 (PDT)
Received: from phi.nguyendp ([116.86.160.247])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a1de21asm29507484eec.23.2026.07.19.15.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 15:02:27 -0700 (PDT)
From: Nguyen Dinh Phi <phind.uet@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Nguyen Dinh Phi <phind.uet@gmail.com>,
	syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] vsock: use sock_error() to consume sk_err after connect timeout
Date: Mon, 20 Jul 2026 05:57:47 +0800
Message-ID: <20260719220103.684489-1-phind.uet@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After vsock_connect() exits the wait loop due to sk->sk_err being
set, the error was read but not cleared. This left sk->sk_err set
for subsequent operations.
Switch to sock_error() which atomically reads and clears sk->sk_err,
so the error is consumed when returned.

Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
Reported-by: syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com
---
 net/vmw_vsock/af_vsock.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 622dbd046799..43eddc33ed12 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1847,14 +1847,11 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
 		prepare_to_wait(sk_sleep(sk), &wait, TASK_INTERRUPTIBLE);
 	}
 
-	if (sk->sk_err) {
-		err = -sk->sk_err;
+	err = sock_error(sk);
+	if (err) {
 		sk->sk_state = TCP_CLOSE;
 		sock->state = SS_UNCONNECTED;
-	} else {
-		err = 0;
 	}
-
 out_wait:
 	finish_wait(sk_sleep(sk), &wait);
 out:
-- 
2.53.0

