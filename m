Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB26311C32
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 13:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788529409; cv=none; b=t3jofHN40JUZPRYKhPMyRCbWNe21j5emrdWCHoJdXSsgXb5NMbCFLkldQMPZ0Y6O4WfGHdaiONXS67nmvepvSSHGf3iUd7y0kOro3XsL1UMgSQuNWgS95w6tQMc1H1SOBWdz2ItyrJWAwe4WwVAlq/vUvZThIYCmttIbYj7qRd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788529409; c=relaxed/simple;
	bh=SjxnNmbIiUZboiW8Wxo/2EyPVm1fhcST5bcm5I38Ejs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=atZyF94+YU9zIv48ayVRCDVJwkiNEPhoPn0NWy2kqxMZFziOQ3UlBBubAx4Nk5wxvxSSlCw0n8AbacaZZmvij6jkV87G+3UoW/JuJaQ4llPpZ2b+lopBlBm6a6Y+TntGTV/toBjPS5ne51N+6paZmYDyMF5lm6iA8ITpv5zNBmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mr1ilyVT; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mr1ilyVT"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-482dbe4d247so610969f8f.2
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 06:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788529406; x=1789134206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YKpycEAIwIhjcrTNAGCaUi5vKcj6WBRk6Vdxa162qsM=;
        b=Mr1ilyVTeAthcpC0c8QL6fkuM4ORlO7hCL29h3imRSASLqx2C+s/oBjN1/UyD3TjYO
         A2HQuh2j5odyCgDSUK8lrzREokR8cKnRxIa1T/KjqAme6yh+4Wv1nCcxvp0aGItcI2w3
         H91/FOCdw/BC6LocdCSvWbxvLiOS1zDmZqUXLSRa+0OqyVY0DItyOsa2vcOMQFLXrtbq
         HvZ2NoYmdJuySAuOhxEm8gVQxhsu5P41mZ8PzVFCermTFLFjl6BF9xPicPklEukC/pP2
         UGVmIGYtpYDAaPfKJ57D12bdfSOQ6jofltzp2b+wbWV2xwqBgR3avlVV7BTpxHOGfpo/
         iOvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788529406; x=1789134206;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YKpycEAIwIhjcrTNAGCaUi5vKcj6WBRk6Vdxa162qsM=;
        b=QjGxCyQyJAIYNHXD2kIBDSB4nWhDW4x+DrdZr7wbeqxWeKE2k/mpdomzQbWRL0S+PK
         TkZUgMylkr29ftK7pSzfq1+HPSXsJ6onqbmpOe7MKdcXgymR2VO6fsGeXNqBYluaesVh
         21uc5J7ZtUNK2rJoTh9MYQHTjCFtqn0WVfQIBhOHrGVqIhL/6axRC9DHxtYdIOvdv0c1
         9/DQzKVFBM7hCMlT5SR7bQl3sHiBRw4J2s/dgw8XDAoUnOFuoyi+k2t53ZXNkIFfgGIk
         JEv+FOSKczPJqX3M143xVi6lTzO/gh41saM8m6dc54qjqjWoIxq71xRcxmVLpflEIBob
         cqDg==
X-Forwarded-Encrypted: i=1; AKwUvBxQ5fc8hs+G1B4mz/g/kOfSvtf13nhmyn8N7Hami9F8imtP6pBTClGcSBAT9aKZI0SX8xgLMek=@vger.kernel.org
X-Gm-Message-State: AFuF++nul3dDM4b1Z+lHAsZgE1epUfHCp13rV/ZCIuO7JZV9Yyt45TLX
	fDmyh/NiU55uTRuqt2zly/TjUNJgycjj2mZbRpgua9iKc591uD3LLsCH
X-Gm-Gg: AYBFou02vj5Pl3hLarfzwKhFVqd8vN+ZYlcvPnzyvIfqs1gLn+1dlWbDhftc9r58TyE
	uCBCdkeMXKHGyByCHmaCBIFTqFLQiBeIAX9ibw5jLBs7QD4ytCUIpWC7tn2FnLMeIhGHtbBbNAX
	nJf1ng98mRYqmgE3wJjchri44w+D5gW8CnuUxnXE3k9DwUUoJTlehCL4kIDidr1t6uK56I0KaWR
	jnh5UEjQyOYoEXdSMq+Fetrk0jEJkUjSEftbTPXiMVCO5BlD1MQF9Rk8HAseXNeI3kQSSrySrES
	bpHzZGyhsxe1zx2joizxD34G4c8HwO05tP1Xzo5cGidl8p+M2YCQtpoHPojH7vibHYMV/Kdt8me
	U5yL0Cfx/m10IZGIzZjKRaMUjHcSRIt401eWM+I0A02E41GsGe6bA4PEww7nG8SOnVtL9EexuIv
	/2Z/Ek8daecJ3sLzyColtww7AVEp9h9m4ZMhOT8Xew2O+vH7l+gYiNzo2nBYXtPxe4ZFMJXW8Y5
	d9VfZAB+jTWJHS3iwAMkuyWIf6/nQDFw/LT+/e5et3AgiZfqFd0TLg2F3CI3Qnc
X-Received: by 2002:a05:6000:4b11:b0:484:3310:c4fe with SMTP id ffacd0b85a97d-4858709b13amr13279003f8f.25.1788529405026;
        Fri, 04 Sep 2026 06:43:25 -0700 (PDT)
Received: from 127.network ([161.12.45.16])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883c074asm6318603f8f.23.2026.09.04.06.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 06:43:22 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Cc: asml.silence@gmail.com,
	Mina Almasry <almasrymina@google.com>
Subject: [PATCH net v2 1/1] tcp: reject non zerocopy devmem tx
Date: Fri,  4 Sep 2026 14:43:07 +0100
Message-ID: <fdc2478d8f21268d7078556409887d8e6ba0ad32.1788529053.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Devmem tcp tx doesn't work without zero-copy, however it's not currently
enforced if NETIF_F_SG isn't present. In this case, tcp_sendmsg_locked()
will try the copy path and try to copy data from an iovec which consists
of offsets into the dma-buf and would normally fail. Moreover,
d9c56501c72fd ("net: tcp: block mixing readable and unreadable frags")
relies on that and assumes that the devmem binding is present IFF we're
using the zero-copy path, which can be used to mix net-iov and pages in
a single skb, and break invariants. Let's reject devmem tx without
zero-copy.

Note, the parameter check the patch is modifying is too loose, we can
create an io_uring request with dmabuf_id and all ZC flags, but which
won't have the binding. We replace it with stricter validation.

Fixes: bd61848900bff ("net: devmem: Implement TX path")
Fixes: d9c56501c72fd ("net: tcp: block mixing readable and unreadable frags")
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---

v2: combine with post ubuf assignment dmabuf_id checks

 net/ipv4/tcp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index b4237d0e994d..10f58281be17 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1169,8 +1169,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 			zc = MSG_SPLICE_PAGES;
 	}
 
-	if (!sockc_err && sockc.dmabuf_id &&
-	    (!(flags & MSG_ZEROCOPY) || !sock_flag(sk, SOCK_ZEROCOPY))) {
+	if (!sockc_err && sockc.dmabuf_id && (zc != MSG_ZEROCOPY || !binding)) {
 		err = -EINVAL;
 		goto out_err;
 	}
-- 
2.54.0

