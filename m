Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E43736A34F
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 16:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785255003; cv=none; b=nR8FmtlQmpsY5rvkeB7r8K6Qp7NWPcWSSrN/w7BlXNqNkbbb5pckK6xxlZdi0h34M+6TjHktzgEszFCDgmla7U7vwPV/7DecRINX/RqMf35apvEEA2OxVSqqkLPiDRS1lstV4wz3qslmkeagxswsA6yCMobb2jpsXnvwG+lX29c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785255003; c=relaxed/simple;
	bh=UYlqUNEm0YyG3FPPau/Ebm32GWInJ+TUqYC8ieCIhbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YOqvJlMOJXULEt3WW56zakplYSwPrQ2BovotYwQ0SE3nxEMdRDzlrz6vz0523BTFCXRlYqDvzYmsNdWFZlvjQos1ZdMFaSdFOT46v9LyQ2CAh8yR3LVW9EDQRCT2vji4xq66WCjT4xiaHL8+vxDT2lNSErsEGSoJt0fyJcXghtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=eKveRZzf; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="eKveRZzf"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-84862b0d5f8so3330327b3a.3
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 09:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1785255000; x=1785859800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vUfz/Uk5z02XF6bLGMzCGPFjLe2D8UKrXP08L9Xjsvw=;
        b=eKveRZzfM0dPMwK89rx2SKxQQRLTteG3pbaXcH1EU2EbTaX7q3x2KpJ2cHAoFt3Hm8
         Ml3/ep3WJ+Bamd8KKysorOj34QwzvaN7IlV/RceUKcxaYXZlFKM7Rg49QB1c6uowV0R3
         UGKdx/exCBTkbRj30pm6w6YkFsFvkt0SYd0/1IeqZXrmfxMRq/tN/lfH2HHVQr1c/w66
         jpOhaIh/DqDYcqnUZUVE4SMEM1NZUxHv5R7TWmF9+UmMkUtocJ3m6xuo9VlQ5TacKu7e
         OkMI+cqRLEfQTFG0FV0LkysVJGhuWL0xdwkm9nqusg0i+DYYQAH+sBJrhzuNdCGUTiW7
         6RHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785255000; x=1785859800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vUfz/Uk5z02XF6bLGMzCGPFjLe2D8UKrXP08L9Xjsvw=;
        b=GuWx+HhIpm2T54QkINlf47KfF9kjm/qMaoHTYpPq65whWntHOa8gIXlZW/L3zKOYTO
         tjQWQrxRTD7JIeXhvgunn9iK/RLwww41UDlQiyD70FzKjDQ/kuVSPkxBHHLPzbEjReq8
         NXECtbZJv/Hg+y6e4XTKT3wh8R79dYnrZekn5Kwy8pFhVmZj2JhPozD1ZNR9Aax+7Nsx
         jUuBsfxKkWt2a1g0wJQodk6pBnaOCEuhu/ZTR797KNKPIfwocjH5u1ByKpWveveVvL/B
         Vym0HRMFYrclZa9imn8Yhq51STW1CnJ+BoaWaRprqqmrHyi8H89fqcUE7REr11JlskMa
         g4hw==
X-Gm-Message-State: AOJu0YxVrgGhOOEQWHDL8JSkxptWBwXiaAUu+N/p2Pnqq6ukSqY6DAb2
	KSwxCqLXTylbN7tJXvHHxouP37pdeXUbWhKR6ofeSoKG/QPz549GrP5Vwz/VCQ0rKfcHoiaJEbP
	sGvKVxxnTPxfA
X-Gm-Gg: AR+sD12h0l3Kt45bJO34GwR8pwxIcds+aOIcT+xfjF4YQuauNsVnVW1km62Gcfw6DuI
	umdp11ZgpnQM43/5z6JA8R3cB8XZwnQP9d2JzjweliCvLa+c9cdstURiuppvXsHO91tSHX/s9Nd
	Br6WPEmg0Md/MMllSjhTzVsYzi2dJlSNuZn08heDO7k8DVJxPuTcLMAik9Eg9UwpvlFj+ispIQw
	vHvyswasTapGmKpimjJ4KuPh2Iev5z+Gk9svHNC4K7EGBKO7cpySuHNUa4WITAXdek6jWHcM4X2
	DnqG3DROAChVNU96lMzbCI04jV9bq/gmzeJXlCK8Zw/4nAo+jLFkrWJhvKFgnHPTHx9TregwNz4
	OAEZ5uYSj5YTaxqvd1vZHO+fbKe9eYxHbnrZf2t/G5if3RV5V+opMM8Z+W4QRbU88zxV/og==
X-Received: by 2002:a05:6a00:ac89:b0:848:2eac:bfb2 with SMTP id d2e1a72fcca58-84e93107604mr3275386b3a.13.1785255000349;
        Tue, 28 Jul 2026 09:10:00 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:46::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea0054afesm170583b3a.17.2026.07.28.09.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 09:09:59 -0700 (PDT)
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
Subject: [PATCH net-next 3/5] selftests/net: psock_snd: unify on recvmsg()
Date: Tue, 28 Jul 2026 09:09:28 -0700
Message-ID: <20260728160935.4128982-4-joe@dama.to>
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

Don't maintain two RX paths in do_rx(). Unify on recvmsg() and pass aux
data only when needed.

No functional change.

Signed-off-by: Joe Damato <joe@dama.to>
---
 tools/testing/selftests/net/psock_snd.c | 28 ++++++++++---------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/net/psock_snd.c b/tools/testing/selftests/net/psock_snd.c
index d506ea19491b..b2593daca603 100644
--- a/tools/testing/selftests/net/psock_snd.c
+++ b/tools/testing/selftests/net/psock_snd.c
@@ -314,25 +314,22 @@ static void do_rx(int fd, int expected_len, char *expected, bool is_psock)
 {
 	char cmsg_buf[1024] __attribute__((aligned(8))) = {};
 	bool aux = is_psock && cfg_aux_data;
-	struct msghdr msg = {};
-	struct iovec iov[1];
+	struct iovec iov = {
+		.iov_base = rbuf,
+		.iov_len = sizeof(rbuf),
+	};
+	struct msghdr msg = {
+		.msg_iov = &iov,
+		.msg_iovlen = 1,
+	};
 	int ret;
 
 	if (aux) {
-		iov[0].iov_base = rbuf;
-		iov[0].iov_len = sizeof(rbuf);
-
-		msg.msg_iov = iov;
-		msg.msg_iovlen = 1;
-
 		msg.msg_control = cmsg_buf;
 		msg.msg_controllen = sizeof(cmsg_buf);
-
-		ret = recvmsg(fd, &msg, 0);
-	} else {
-		ret = recv(fd, rbuf, sizeof(rbuf), 0);
 	}
 
+	ret = recvmsg(fd, &msg, 0);
 	if (ret == -1)
 		error(1, errno, "recv");
 	if (ret != expected_len)
@@ -341,11 +338,8 @@ static void do_rx(int fd, int expected_len, char *expected, bool is_psock)
 	if (memcmp(rbuf, expected, ret))
 		error(1, 0, "recv: data mismatch");
 
-	if (aux) {
-		struct cmsghdr *cmsg = CMSG_FIRSTHDR(&msg);
-
-		check_aux_data(cmsg, expected_len);
-	}
+	if (aux)
+		check_aux_data(CMSG_FIRSTHDR(&msg), expected_len);
 
 	fprintf(stderr, "rx: %u\n", ret);
 }
-- 
2.53.0-Meta

