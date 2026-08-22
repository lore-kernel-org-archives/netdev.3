Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BAC376BD7
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 10:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787396250; cv=none; b=nuWzOASRNutd29YlaUaFRlTBOua6ikRVP+MSNjKYuMFZx7KyX8IHKuKTDmyeHRPeyDQvvu0G0Hv0ihpvfdBnLSvSf6R1S6lJqCiLDsDFr8frL7s/ylAUUSLHoQ3Vtmk542V7LFf7SLTYzCvFTupGVIAhUCz6qbAlcT8h6SvbS4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787396250; c=relaxed/simple;
	bh=w28Ds6TwSg5vhaehEToShlIYcxMLiUafeD0DIb6h33c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b63vR3v+P7VmrvoVULGRVzyWkeZBf7sFqpRCwawuyBvA6i/OwgSozds2zv/G64S0FTyWM9p+/o53WQWe3Zysv/0qKmB/nhXgqiiSU8NUJhh2TGQX63XLkhG29nO43LvbDy1kCHOo+F6DE/jQkHKJdW5stHk6Q0lBdULmopWLbBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pN7CczXb; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pN7CczXb"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47f93b2fe4cso775349f8f.0
        for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 03:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787396247; x=1788001047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=X9+SGmtQFNXu2kf6D5qv5aw97NwAci5EHZMLRp5Pi3c=;
        b=pN7CczXb+ZlwUROgy29zKASQy3QKxLU5ZQkrTVok+noJFn7nCcxbvtSdDv+PFlHvet
         3eYHjdh35KUPBEBM5et4gQgokOIKjvprC8sD+11FyrxOv+eEwi2ftgXVcSjBkqWe282D
         ADsjFjjuZ1GYZCqKmNjoDKTEwmSnIXAit8jlcO4M3vz9mwuf0XKlBjbACfbdrq4x8ZME
         /9LtuTEJxuZHU3F03QiCaXhsXcQBruWlWFzu+D+Aw71NRpKnoKoyWF95iq0SH0phfcxJ
         NZHURxUuB3vLFRZVI/EBNxEiQO8PrnVTEJYYpZqHv/PQWneJBpr8bzqco/85f+BuyZzV
         bg3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787396247; x=1788001047;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X9+SGmtQFNXu2kf6D5qv5aw97NwAci5EHZMLRp5Pi3c=;
        b=XqpgUs/MSO3Y+11mhnaY3CeuSK6IPf4CJzx9DZ5Cc84eMy5UvEGE7JRrZiZBG6RrOR
         6OaLsAjRtSfnFcxh1rjc9T7Ux7V6T2s4WMxoaL9/ixDyP8gUu+1EzkgD2Q9IPKJ0GyzU
         a2A1BZmLTehVi7B5V89oKsePoIZnfXvYAwexGqxxeVfRY8k5vo+ZTc3aylbx4NJFCugA
         03kGCmZNKyTOtMm3sCJzMlQFeF+IrS0W7LOKnVKU9vNhitQTolf+gNH4MFk/qAk0PdzI
         to++bfWUtdJigW8xN4knVSZme/hrW9fhjD7y2kvb9iCsc5Kpiln7yA0vmgw05rhlXQ+f
         6RHQ==
X-Forwarded-Encrypted: i=1; AHgh+RoiNhQY1Jjj6YxfQEuzoDFar8Q7y1f7gExZCk7nu6NKV871sYhINAbLSaAAm6Dnw7tyzl25mOo=@vger.kernel.org
X-Gm-Message-State: AFuF++lBtU/bgyhQAQq2Kmp+9coZP8mEbXUHr/NtJk0BAnBInZGPyCix
	HVjgCeKbGtMBjd0QP8UAjUaAb609mqAV3S/K1pohLZGk+UzRk+wIJyrh
X-Gm-Gg: AR+sD13Zp2+gQs99cKVjQdKiDkxsmzaHkM5JQxdqieiCKwVrFJumHuUmHggKq9yTC8s
	pc+KYoXQNmN9YN8MJ+Jv7pma2Xf/mefIZUKYiHFOaV67/UprDdxlBAv/lhE0oYkvZYtfNsJDr+I
	ldNJNQ+I0qkwrnDZxgnZyRdZCHrDRxM3PfNZsaRkBUWlHdRAI2LL3GbEV6pnyWAdEWbQmEbRce0
	AnEEG1lUL0NstRPRVSeM9+K+X06LozuyxDqLBtv8f5DIPZ7IUqArR9n08cL4LDhrE+y2nYNe68K
	f5Aol9MOND+vD17FdpHl+P1zBYgkt3ry+cLLgwumesokPpNBobPrlOFIuhDjFiabtxjXxaaLKqQ
	MEtEGJiXIXwueBtGJlcH9ty8VO+TxdLk2r6OCE2EHbH3n0PTxrMcB0kUViv6rnhDMNynJ6lCmbk
	hui53a2sThTYC+TStMtlQ621ncOeZpgS8Mb19Fcwtj3hcadCbkfoPWg06MBmVnRx37l/pFf+9sa
	Q0dZo/pkKO/wBW/VYl+3LnCSL5W1pmtEFtaTbiFC5w+QM4MVucf/cmdtynO6cT7i4D8qrLa5iP/
	kw==
X-Received: by 2002:a05:6000:601:b0:482:a8b1:aa6d with SMTP id ffacd0b85a97d-482c81bd354mr4693426f8f.10.1787396247277;
        Sat, 22 Aug 2026 03:57:27 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482c9c146f1sm1766220f8f.33.2026.08.22.03.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 03:57:25 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Cc: asml.silence@gmail.com,
	Mina Almasry <almasrymina@google.com>
Subject: [PATCH net 1/1] tcp: reject non zerocopy devmem tx
Date: Sat, 22 Aug 2026 11:57:20 +0100
Message-ID: <ddb2d77e49974232b7f379851dc9809c953a6649.1787396169.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Device memory send doesn't work without zero copy, prevent
tcp_sendmsg_locked() from falling back to the copy mode for devmem in
case there is no NETIF_F_SG. Currently, it'd try to copy from iovec
filled with dma-buf offsets, which would normally fail with EFAULT, but
it's still better to handle it more explicitly. A recent net-iov / page
mixing fix also needs this patch.

Fixes: bd61848900bff ("net: devmem: Implement TX path")
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 net/ipv4/tcp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 455441f1b694..f403830af65f 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1162,6 +1162,10 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 					binding = NULL;
 					goto out_err;
 				}
+				if (zc != MSG_ZEROCOPY) {
+					err = -EOPNOTSUPP;
+					goto out_err;
+				}
 			}
 		}
 	} else if (unlikely(msg->msg_flags & MSG_SPLICE_PAGES) && size) {
-- 
2.54.0

