Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793444954;
	b=Q4J5MbP0w1VYadMjA84sx4Zu/i6e5oJITeRTCGKgB7F3fy7jHP1Qs/FP4wKVCHiMicEV
	 c5gA7d8YP4OHJVwQ2uoZwoHiAn147hevqOdyFsNnXH6ML/FgzfinYAnfsDRXS1Rm45wuA
	 kENExn7QVSBKnQHm8x+1vltLBhmLHP97LdsECAJsO2GwoP/6PVq4UG+Kx90lZ/dsD+xo8
	 0250w9CjBtJRAhlrXicnyQmuG3VmyMCCuRqchULjN5rRsEU/lOgdFFOz603xfRFRj+xmg
	 de1in/k2VcX6/5gy/WanJrZZV/mW1NQ2HOkigkHcTX2HlAYP43aL3E2LnWIRa4CYtUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793444954;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dBEoy5iqEE1c+mW/hlhl+h0UQlikvbw3e87Ek3myWuU=;
	b=EBn/hIImGL6MtFfF93+VdOz4pm+tYxrDQX9hLLYhfmn0rO9ZwuKsfOWxn1P4YSW4UXvz
	 pFOMRdEz0kPEB/T7GrVaOd0cKHCuB7HhMc/NMUFbdwCFilto31AFLexPm+MXOFMZRmKn5
	 qIcX6rnGa7IBmghW6Qdn2V/3wvTnR9Lxg77RxaNP84rkjrQJ8w73dwPyg1BlX/KIv0WWE
	 OxYhb4fX+bs1uDJBPVKi4arrQw6uOVm/go+BRJrEMqAVkYHA6emLPVyjm3mpUdsf/V1Q7
	 NVAz2JTs389DDNT12smeT2mMu9/VLq+FDHeundTfIz6yXrmcrP45ZtgdnZAp2iC2BjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ezJTXjiW;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA9E606A31A
	for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 11:09:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDA9E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ezJTXjiW
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48e00eee27dso759767f8f.0
        for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 04:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793444952; x=1794049752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dBEoy5iqEE1c+mW/hlhl+h0UQlikvbw3e87Ek3myWuU=;
        b=ezJTXjiWRX8u+57GIh7lc8J3gcmuICa9M7RIvDGzkt0/p5VD5AbZAA2FwdQpjtbuhs
         DGx44hX8P5+dpvioF9cVeF/+hb76i62fTCVxjZi/X17CwRKjhL+4XvYTGlG7cgASRHz0
         QWuN5OIxzwoPZllg6vSVrsvNqQ+R8ZC5Nq4H5MrwBxDE9tDIk7IgBvVGTB1PATvSuK2Q
         txtV5ekYGFUU12sYQdighPpchg+Q4iSU/YU3WCL4VUubYe4PeRss1juPO0EX8q8XTcJK
         ZSQMNq/+LryLcLwci96Q73ed8JCe0dD0IgAN0Z33BKcs5ZysNrOHMxK0yva/T6hEv1kV
         6AcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793444952; x=1794049752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dBEoy5iqEE1c+mW/hlhl+h0UQlikvbw3e87Ek3myWuU=;
        b=sc3VxPSQm2Qrme+y5l24O8FKxxx8A4CpQrF8kx7G14UfRAHYGrrIJ5DU/kPIPxedzP
         IG9ndSkwZR7+E9jYFeAQn/3MlkwHir9N4+htAsGfQ/aleWijGnsCvmq9AjNy/3DdlzXn
         hwg5H1XAKnqlu32aSV3r1Ui3a6yI9c5EOtxF0zuYl+C9Wved7s22QBzY0TppHI1MOEow
         cuJZeLuqKI4ZBf+5mmF1L9JEELLu5/v6v2k96b76slwbc8ofO74ZswEN7pBsM1yDqrwQ
         sQQUlLFdaMpHuP5DGAiTp+plnuCszkrTPeJlgOMHYlXaq8cv9A/zpoXIDNTxIMdlpZdn
         ho9w==
X-Gm-Message-State: AFq9FYLR3ValM1eL7sGcGiLY/Oe1Tt86iuxVLSLZ2UddVLslssdK+83Q
	tPdDl4JTH2amdtqaafbfqeVTY+vsFZSrvjyr7uKe++FVPm6zS0wGXyv3yVneK4SyzzXIjg==
X-Gm-Gg: AYBFou3doUhPfvISOCHAwKDtJzVLEQHuPqqLnrwv80J2d6N8n2jTqung5v9CvGxRqAS
	RHcddwhL8c47CsE8wUa6++tJjPuI3J1o0cD0qgD/gZ7+txN3OrIyi4AbjxmSe7373nAtVsy1FE5
	nRxhW/mD2efeJvIfYXN/4NUnvponsQZa8e9zU7SHaRSW7tKLTDtrgEKoWfjheQZqj2Wv4VbAe4O
	Vm/ZM7blq0WfNU+yuotDXiWlaZJRll/sGsEmKYGY/uXt0DMYGu/hb8kG1bN0mAtnGy0K5iO7cxJ
	ggCGhGvPH6WR/wDn9RS5nS2Cav1/jLJda2orsELwUVA2b01FP2cIvlNzQPF6Na4d0gLevdxGCX1
	55p1YZeu9zlRjRSmPz/4I4Kv5s23KcINPWKNdENhobYqRNL9Ou4PeuF334WK4kBXNSCYClMlz7B
	P5ZwVt0QwH3TTenq2ECvXhYAvwrLfebywEW7qmqfMZVdPDHLrqXNcDjTaHfKe2tURhvfYB5D1EU
	XLSlGWSNbEgJeSjWT2i6Vg9VMmWdisgAl9RS+Ox7eRG2ZSMtIihZSVbUarehSUT3sQZ+/pzdazI
	X1tre6Ut6jOGR0fBFet4JIhxJIkWGu98AcYJHCsA/qF4xj8hTTgM22ixUQ5UKGeQKw==
X-Received: by 2002:a5d:64e4:0:b0:48d:bae6:d7ba with SMTP id ffacd0b85a97d-48e6e3041edmr11132647f8f.26.1793444952037;
        Sat, 31 Oct 2026 04:09:12 -0700 (PDT)
Received: from localhost.localdomain ([2a06:c701:4773:6f00:c8d4:ec29:293e:f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b728f9sm8190774f8f.10.2026.10.31.04.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 04:09:11 -0700 (PDT)
From: Avi Weiss <thnkslprpt@gmail.com>
To: netdev@vger.kernel.org
Cc: edumazet@kernel.org,
	kuniyu@google.com,
	pabeni@redhat.com,
	willemb@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	Avi Weiss <thnkslprpt@gmail.com>
Subject: [PATCH net 2/2] net: check the recvmsg LSM hook for every recvmmsg entry
Date: Sat, 31 Oct 2026 13:08:41 +0200
Message-ID: <edbdf4f4075565b1fb5925d7e311d6f315151a48.1793444262.git.thnkslprpt@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0b1a91e7fa0de128c6e2bd3ae2f5c960a5c0f883.1793444262.git.thnkslprpt@gmail.com>
References: <0b1a91e7fa0de128c6e2bd3ae2f5c960a5c0f883.1793444262.git.thnkslprpt@gmail.com>
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

do_recvmmsg() passes the number of received datagrams as the nosec
argument to ___sys_recvmsg(). After the first datagram, this bypasses
security_socket_recvmsg() even when a later entry requests a larger
receive buffer that would be rejected by an LSM policy.

Pass zero for both native and compat entries so each receive goes
through the security check. Remove the first-datagram-only comment.

Fixes: a2e2725541fa ("net: Introduce recvmmsg socket syscall")
Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
---
 net/socket.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index c2a85224ab55..fff80fbca1a8 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -3057,13 +3057,10 @@ static int do_recvmmsg(int fd, struct mmsghdr __user *mmsg,
 	compat_entry = (struct compat_mmsghdr __user *)mmsg;
 
 	while (datagrams < vlen) {
-		/*
-		 * No need to ask LSM for more than the first datagram.
-		 */
 		if (MSG_CMSG_COMPAT & flags) {
 			err = ___sys_recvmsg(sock, (struct user_msghdr __user *)compat_entry,
 					     &msg_sys, flags & ~MSG_WAITFORONE,
-					     datagrams);
+					     0);
 			if (err < 0)
 				break;
 			err = put_user(err, &compat_entry->msg_len);
@@ -3072,7 +3069,7 @@ static int do_recvmmsg(int fd, struct mmsghdr __user *mmsg,
 			err = ___sys_recvmsg(sock,
 					     (struct user_msghdr __user *)entry,
 					     &msg_sys, flags & ~MSG_WAITFORONE,
-					     datagrams);
+					     0);
 			if (err < 0)
 				break;
 			err = put_user(err, &entry->msg_len);
-- 
2.43.0

