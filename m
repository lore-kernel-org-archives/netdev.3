Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2563CB91F
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 16:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785255006; cv=none; b=EMXquQexESiwkcLibf6YIZEYGXvfWPevt1S0hvm7w/uawOe+y1A9hqCn4Yaeo2+gHTOtbR6tBBv9T/7aFeK/kvYzElPkP2CYrZeQpwjLMNAN97hiOKBLSTYtTIpiUem0L1ccEZK227vHbFXfpNURFQvOfddwsSXhAy83aSrE3Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785255006; c=relaxed/simple;
	bh=N0wg7mFoykZMR+qCLMWcv1TjeWrSykKHKXS77ThXo9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oSn4tjT8v57S3wj7l21yj1pChXdhhBs3gGtjE9cKnZV8rbZXl3VMwjNKzBJniflu9sQ7lqC4evaenxX/QZoujzQrBC0LbceVV53sE5z0TGrA5Ct2wg9dblj38o363Q24yDtK6NP2UqGSyic7zeEIc0dohDlULcVCRprbg21GIPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=vN4XM+wT; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="vN4XM+wT"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cc73e322dbso694695ad.1
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 09:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1785255003; x=1785859803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2c1LdkzfayYKy1So3RR2qY5zFyV6+EB1Mt91oezqd3g=;
        b=vN4XM+wTgiA3NatFvXAWZljos3C/CaJWKPXIw8v+yTCtwhclDTMDrANJFnlUrhVBfH
         8ZQvDDvVw0lUhBi6deySAZVvRn6gonParu+M9Gh29PHTY8wJbK5g2V+KlNXh4baHZ/7u
         vckolR9PrWGRrCY9wg5NDV9Qgn6nwgocGQNZrz9N4vAL+kEaFKbqyYFdnQLR6ZXieLQf
         aN+zeKEzaEd82oGnSZhEyh7bujG49Bezo/sDRtO5L6cbXwfQPCmYAhjfASIoKzMTs1v3
         Fep/lHR2769k0UzOjkTcPDNdK2+rSpcG8b5P7jCskL/LKahbX8CWr5sO8VpzRZsK39Kr
         YNqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785255003; x=1785859803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2c1LdkzfayYKy1So3RR2qY5zFyV6+EB1Mt91oezqd3g=;
        b=rc1CJfEU9KVHeXcMQwdw1dRhPGdUMtKYJNjVEXSJz2hG0bopm1Myj3oKRvKGIyM5CD
         yMA8dT5tpUDzwx8nVMnWoP7rbi/UnZ8v5OZEVBHVsN2NXFw0X2ZVC0E1f9Ekil73+LFx
         IbPSybOVVRero5o9vu9NN4VMwZIlkSh6oj/U1nTnoNJ5TmqwDozQ0Ey4vaXQfCMRhCiK
         pJKCK6EEj2kGFqCrp8oZ/TxhAIbuQ1+8kxPIeHQ0VAdfywtGj5FASzWc4BbN4lfHkM9X
         NjQAHfcFAXd3m3LLCAS5ZTEWW1tQKRGwXrQ5Wc/jx8DRvBqAPQPktKPeH+Oqwp9Q49yU
         dstA==
X-Gm-Message-State: AOJu0YysOmLUokaTV5QiwKZ9PeuaET00q7oOqqvLObdml+aLz85stj2b
	jH+Pnkj+ROk8SaV7iggH5aJKhcE3uvaJN2SE0dspqi/t/ZL2FPhHxDg7dzLwrRoMbMXtKoTaPMp
	48kCTw05uuIDg
X-Gm-Gg: AR+sD10PSVZJ2WppByeEfUuB1NvSNpv6kn6Yh6V9qrxG6Eusp7w6kHTNK2C2EG1m6IF
	7+adbHptt43GLCoYt/6mrE1TLciJilK89XjqWgZE+kSJDUZByduDZfBh3G8T6OXtAgDiBqsGL3N
	hN2yj8Kl7Sh060/p+COBEbLz3neB6+Aa0lolqvnfpaOKpyFaDQbgGmcnREUzGLC/1RAKsHNFYAU
	vk2Pglnw2qAnGf3mod6lUi193kHL/Zw+3Lx4nXbWG5g+EX43oHZbvctSSSvmH09VofmjqQhh4z4
	Z5c7vEcZqIoh0aZ6JmYBUNdRnSAZHUp4Lj4Dh4a3ZYSMnKZBwLQHphWnm+9Aq/k+bm1Dui+Hg8a
	81TMTLHXsNgDXNzkPKcOQRtA6/OkPK44FVusVYV7enuBrcI8qtHzcYzkkg43HT8BJaHhs
X-Received: by 2002:a17:903:1b2e:b0:2ca:cbfd:7311 with SMTP id d9443c01a7336-2d015ed91efmr34673335ad.46.1785255002564;
        Tue, 28 Jul 2026 09:10:02 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:8::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde7f4420sm54470355ad.66.2026.07.28.09.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 09:10:01 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: andrew+netdev@lunn.ch,
	willemb@google.com,
	linux-kselftest@vger.kernel.org,
	Joe Damato <joe@dama.to>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 4/5] selftests/net: psock_snd: Verify sll_pkttype
Date: Tue, 28 Jul 2026 09:09:29 -0700
Message-ID: <20260728160935.4128982-5-joe@dama.to>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728160935.4128982-1-joe@dama.to>
References: <20260728160935.4128982-1-joe@dama.to>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend do_rx() to take an expected packet type. Existing callers pass -1
to skip the check.

Signed-off-by: Joe Damato <joe@dama.to>
---
 tools/testing/selftests/net/psock_snd.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/psock_snd.c b/tools/testing/selftests/net/psock_snd.c
index b2593daca603..f23877942ea3 100644
--- a/tools/testing/selftests/net/psock_snd.c
+++ b/tools/testing/selftests/net/psock_snd.c
@@ -310,10 +310,13 @@ static void check_aux_data(struct cmsghdr *cmsg, int expected_len)
 		error(1, 0, "cmsg tp_snaplen != %u", expected_len);
 }
 
-static void do_rx(int fd, int expected_len, char *expected, bool is_psock)
+/* expected_pkttype < 0 skips the sll_pkttype check. */
+static void do_rx(int fd, int expected_len, char *expected, bool is_psock,
+		  int expected_pkttype)
 {
 	char cmsg_buf[1024] __attribute__((aligned(8))) = {};
 	bool aux = is_psock && cfg_aux_data;
+	struct sockaddr_ll saddr = {};
 	struct iovec iov = {
 		.iov_base = rbuf,
 		.iov_len = sizeof(rbuf),
@@ -328,6 +331,10 @@ static void do_rx(int fd, int expected_len, char *expected, bool is_psock)
 		msg.msg_control = cmsg_buf;
 		msg.msg_controllen = sizeof(cmsg_buf);
 	}
+	if (is_psock) {
+		msg.msg_name = &saddr;
+		msg.msg_namelen = sizeof(saddr);
+	}
 
 	ret = recvmsg(fd, &msg, 0);
 	if (ret == -1)
@@ -341,6 +348,10 @@ static void do_rx(int fd, int expected_len, char *expected, bool is_psock)
 	if (aux)
 		check_aux_data(CMSG_FIRSTHDR(&msg), expected_len);
 
+	if (expected_pkttype >= 0 && saddr.sll_pkttype != expected_pkttype)
+		error(1, 0, "recv: sll_pkttype %d != %d",
+		      saddr.sll_pkttype, expected_pkttype);
+
 	fprintf(stderr, "rx: %u\n", ret);
 }
 
@@ -492,11 +503,11 @@ static void run_test(void)
 	/* BPF filter accepts only this length, vlan changes MAC */
 	if (cfg_payload_len == DATA_LEN && !cfg_use_vlan) {
 		do_rx(fds, total_len - sizeof(struct virtio_net_hdr),
-		      tbuf + sizeof(struct virtio_net_hdr), true);
+		      tbuf + sizeof(struct virtio_net_hdr), true, -1);
 		check_packet_stats(fds, 1);
 	}
 
-	do_rx(fdr, cfg_payload_len, tbuf + total_len - cfg_payload_len, false);
+	do_rx(fdr, cfg_payload_len, tbuf + total_len - cfg_payload_len, false, -1);
 
 out:
 	if (close(fds))
-- 
2.53.0-Meta

