Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793560868;
	b=o4jpbspjmnBNrWwTpD/Ex7a88kADQe1UILwyOhujbAwtdYBoAt4YClzYPfE0bXl+Ca8O
	 ihAH10nCx8j5tOwQWw0xBROcrB10e8Goy3p5rjZhiUqpelmuesVABpwe153M1wudl+qru
	 j42sYB+jyM7hWUwhJ/JHO62fGd2fyQZYsUDmy6KQ1311L1mfM48+2KzSVt0CFmxhIEjeH
	 x20gPYd1X2sojRn3EVlVbrqZlwUMlblnJx820ZrdebSWnyBtnfVyoAMFNsqe95+319xNq
	 3VoWots0Mfi9eVCHphb8sIa7IKe4HwPedOyNIbSX0h4cMbV6rUwmKwi84+ambOeQHGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560868;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=DFLLbX6mAbQ0jCV7LiEZmOooBbXiKj6J/ISxTH/9yE0=;
	b=m/tw2qwhklf63gdRaRhfXhrby/eA6Ji4KmYdqDoWjkQTvAyafaXgEYlQJOMiYK5R4Ty8
	 e6qB9y/SHYuf2gkFXtZQjPJLIpLQDtg/GfkCqk0l7CoPsK6NNs+WdihjhdiKfozae5z34
	 7Wfgq4dvSlVSgJh+1QNWqj/7dz4AnOFLHi0JToRUanYgdU8+WXD0WrwC9ws3x4PytHRyM
	 t1LqOYNr3AUDMQAvFo5ZgDzFw9FkRPearGe2c0ysDbHn6DE0UxzIWIk5TSWMaK+w7Pce0
	 6GUABXP+6uK0QqNAqGqnXIaYXVsBaPfnd38BQ7BvxyB/7slR1T9UVkY8InlN83GzS/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pIdlpv23;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30A4606A327
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 19:21:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C30A4606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pIdlpv23
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cc4be0e5351so803432a12.0
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 11:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793560867; x=1794165667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DFLLbX6mAbQ0jCV7LiEZmOooBbXiKj6J/ISxTH/9yE0=;
        b=pIdlpv23hyRj6iU5yvB/XBxl0TyThVnfXGRcF6Uk+rZpVLTrnbHJ/7S1F+bdMKtXpA
         s45sf0lR3YCcSgBvvRagmuywyiCVDe3wGB1UdWZ1FF+P5Kr6MrTDHAY4wvUHxCZl1hg6
         xvk4H5yxlQXFfaAbDD6l8ElgOcsEp4LnwacxLtJ4azwMfCu6bpOYUMfxlD20nriToNkQ
         5C0p9TbQYNvRxDDuTEO+vMVvTS7yvQ7ZTDLY/inL7IiTwn48rKej/IW3PWuR25H8qwqM
         KND5NOhRIZ2+RXl505R+CAkVMpsDwSMadxziOfz14CHIkfbXrpauPKhWhzzVa3CFvL2C
         OeBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793560867; x=1794165667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DFLLbX6mAbQ0jCV7LiEZmOooBbXiKj6J/ISxTH/9yE0=;
        b=uWbCbD9/Eueypg1XOUUewpb8N3xEmL51h2tjN5xzfWMLEgkJqxvKxxaA9mxGSc6qxV
         gSckYu5yxQtaKLGkYQWUanl4GqObMHSIf2RIVyxvln/TAZuP9juqIUQF4DHm5eSei1O6
         D9pRUhPmvE6GvUutwS5q63JWyjKf7ecQyl7JhTJGNeO6aZ97Zyb0UMVEcKAWGjSpAk1I
         oSkBgvlrZmWwo/do1xvNt01t9SNkigMfhzKqjQRoWg/qDGPcBp9SrrvuiDMBkdAd9uE9
         En9ImNeHC52kGzw+Gz0rREL/x/8L0/PQkGqzmWI1GDHocyIoOA0zMqw3Ab0LXzxFS2B5
         QFQA==
X-Forwarded-Encrypted: i=1; AKwUvBzp9hZFqjreedx6MLL8JaEKWGpKkyUDkfrRc2rfkioTu7trQSTwyD8sumJoC0hRNX8bEdB8kGM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+e5vYdU4davlhXxwUy7OF4KlO4cND6lvvxqgCeTLdll3RgJSnY
	GYjiWEA/chnFNf3E+n/BD3NBwpFUzptJ2MDwm12tmmfipNcFii8Pt8k8
X-Gm-Gg: AYBFou2aMVSjuw43MaoQtifTu1yDTxn94NXM9QtLsoTUcOu3CLy0+DP5iVGvxe3q8oO
	ooSICinCNtuMnTozVeBtSLqb4Qy5uSlKYhU9ahi4cbwZwuTrUQcqvEGn0sPuktUpoSmM0l1pfqo
	yGa/YS+t5ER0JWoNwlCBaOjgXN9+KIgKYXplzb3piPvcl2L6nqoal84LHaMdLVMFpTF5q445i68
	Vn274A6OlnkQePVDhJmM+0XcPN/S5zuvsheTE4ytb/iDPinpPgDn+TFX0MFRWxnaetrISVAe6Q9
	qwJKPyMhMPaYxQEQXzJjMcWPAX4iPazn4sa4vuYXft6nftyVXzOgIEFYCCJM75qlUk8jb6hcBNR
	jC+s/DmJNoUyKq1Zcy/nCsHyv9dGuQb0aqKouYqhyqoz9QtuM40mej/zBq+DsuKY3taXBW54TlX
	CFyXKCvFjVuNi4a95vk1egvozF4z1x3DBmyAKg0/Bh66n+Hh9pKpnb64b4UjiSgMWn9PV4EuC/O
	hxLfwIHLr07Fi/feovbO0HA/wd/Yy67qRhAYxHZwhGgxDbjVv2UfbXoT3ApeDrtXIQdXFvl+AJN
	mp5rIjcNMYl1nZQk2M9VlEBFy2hWeygK+vhqohrx8+oCMFBG1sFkHzJ1SQpXBWS0q4QUDGXRZy3
	KU4zUMvxA3+qHuZwIaBhtzF2mL1y8AavKw0H+sKA3Eue43iCtRGkAlUI4YESkrnwfanmtF7dyZw
	==
X-Received: by 2002:a17:90b:28c7:b0:3a0:a912:e759 with SMTP id 98e67ed59e1d1-3ae897ee62amr6770112a91.25.1793560866933;
        Sun, 01 Nov 2026 11:21:06 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845984absm11157931a91.10.2026.11.01.11.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:21:06 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	jiayuan.chen@linux.dev,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kuniyu@google.com,
	willemb@google.com,
	matttbe@kernel.org,
	mptcp@lists.linux.dev,
	mason@kernel.org,
	josef@toxicpanda.com
Subject: [PATCH bpf 01/15] bpf, sockmap: Write sg.start when recvmsg() faults
Date: Sun,  1 Nov 2026 19:20:43 +0000
Message-ID: <20261101192057.2296489-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261101192057.2296489-1-alexei.starovoitov@gmail.com>
References: <20261101192057.2296489-1-alexei.starovoitov@gmail.com>
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

From: Josef Bacik <josef@toxicpanda.com>

__sk_msg_recvmsg() copies an sk_msg to the user buffer and starts at
sg.start. After a full copy of an element it calls put_page(), unless an
skb owns the page. It handles 0 copied bytes as a fault. It writes the new
sg.start after the loop, but not when copy_page_to_iter() faults.

  element    0: length 0, put_page()   1: fault here   2: not copied
  sg.start   ^ today                   ^ this patch

Each subsequent call copies 0 bytes from element 0 and returns -EFAULT. The
user cannot read the rest of the data. sk_msg_free() starts at sg.start
too. It calls put_page() for element 0 again and can free a page in use.

Write sg.start in the fault path too. The commit in the Fixes tag removed
this write. Do not write it for MSG_PEEK, which changes no element.

Fixes: c9c89dcd872e ("bpf, sockmap: Fix partial copy_page_to_iter so progress can still be made")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/core/skmsg.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index df385a5a961e..f03519468ad1 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -443,6 +443,9 @@ int __sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg
 			if (copy)
 				copy = copy_page_to_iter(page, sge->offset, copy, iter);
 			if (!copy) {
+				/* The elements in front of i are used up */
+				if (!peek)
+					msg_rx->sg.start = i;
 				copied = copied ? copied : -EFAULT;
 				goto out;
 			}
-- 
2.55.0

