Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792557670;
	b=PEamzPD409ybck0aVO4aaVoQK7d0uC29wtnTGK0807pDM0WBa4JyLDyoeKb2m8h+w3vH
	 IOe/HKDo3bIdopAU5Cov9uzdxf3p4h2Nvqq04KQlfeLfj5NNXCx1Wh+3h94eOl4khLefV
	 I185Z4Yea0rnF8OrB5rbcliGf5UkAzDtgAXj48d2pbGPzlktgcvkFdcp5ZdalOE9NLTTe
	 tP2bcJ/O1oy5oYxrzDoCO5W9oXc4SQievsrI9Sjba9ObnXdrea7dnVJCs/6YqUtbZkBlq
	 PYm7OfE1H3G7MdxFXpzh5udmbszGcfzSog+FqjYAYLkyUfIhVCe45ZT/v119W/VQZxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792557670;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=VYwyO6zRa3bxwVQowJw7fJ4qd8WNL2nwZ1G8viTF+08=;
	b=FMyRMbOvJM5u6INUJZqymd7Zps59bKl9mXgZBHmqY9WayP6eDxm60jj1lyW9aOFhLjIg
	 hDJsSjXsh9pxtVZ9cOI2xuRabCtY2RFErBf3MMTGrpR0vKECdQg0YwtnJ7a22ZO4/3Xdh
	 emfJeTt2GdgCG3etxIWPzH+q21AgNZ90Nxh6UddOVPIsMsSgQThjGq2qBI/gXNq4fzMt3
	 KvyxCfNvgV/JJF/LHjkfCDAgpxrvIVDo+VEl0VT77xunJH4mn6fnW30mQEAr7hdi/7TbU
	 wqg55EuTMfY2Vxtd8Pzvgic8gfUdamb9VA1o7JkR++CoQ3l3wKerJuTpQVwWCS2Tt7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ibStA+EJ;
	arc=none smtp.remote-ip=74.125.229.7
Received: from mail-dy2-f7.google.com (mail-dy2-f7.google.com [74.125.229.7])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F78606A319
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 04:41:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07F78606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ibStA+EJ
Received: by mail-dy2-f7.google.com with SMTP id 5a478bee46e88-366469e3569so113213eec.0
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 21:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792557669; x=1793162469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VYwyO6zRa3bxwVQowJw7fJ4qd8WNL2nwZ1G8viTF+08=;
        b=ibStA+EJmtURDyKyNKluYxwsIGqYsrPAyII5X0JcxyRGaOOCUOMhnn4wDofLwxNO3u
         yaaW0JOaSC6qyUhainjUDTXkiJsCRlOpPZl06vJk0LOvR4sw/DepvSjaGhepYnQEJcWy
         6tqMwyfrafRT9Q8Z0bLmbY6Lv183mlyT8ncaRtHaJWZ6naLuaICUGinGJihq2sdDbGxp
         +CEJkKOoI6KJiidNaHy0f/0i9zSNv6fJoEKjKC7NX25U7TkGqZtJLTvbReA1/zejOB3h
         5a+T/gNN4PYnq9J9mRm964pGqZNbxm2RLv0vXWsN4ievTzGuOQgGp2DTzG8qce69gJOQ
         cBvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792557669; x=1793162469;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VYwyO6zRa3bxwVQowJw7fJ4qd8WNL2nwZ1G8viTF+08=;
        b=EG78apTZMSFA/WOcZd0r0qB2kmYfqmymRsPeR7j126i91rh11jMaUoD2RjhavT4syD
         DuDuklKcEIHilH1SnAAfZlEhcRkXVA2hjXQbDiaqdCHtyERt3HxfrVNeYuSOZZQGRPMf
         8JBGWB/X/e/6kfMhq5xGGSYSLm+j0miX+JApssEKiSzzCXOJggZ8YmImTOMgrDiYnQy3
         +EWWls/N4KKvjUdBzF8fWunMfXPRLyILBtdLsIfOptfpyP+aK0YGMus0qM+/fcME9qNe
         C4g7wGCuQlg3fwHSlPGlTf23CGPamcDvrQpitWA/SGM2oTG7Q1B5oZDRF8q/BBgH+Jjq
         S3kA==
X-Gm-Message-State: AFq9FYLEkuOew2OTNwMsnilibNUTK5UxMzrSwBRZ/o+shInLhpxzlrCX
	4li9zMxNcLPxPY8GrNHJjAhV+RJqd7jqow5OPMSwk9dcKB95X5POmDoiQmj7FKmM
X-Gm-Gg: AYBFou3UOa0vcEBrR0789woyYOs0TptNs2QWgihWUUPsVxnk7s+zveO9jD67hAI6Pem
	7ki6jWsMJD+bbr0rArSNXTIcJdViHgfxTPmuPJf+aBvHb/zDfAHZalNZARsTed0MyX9o1qUiNvN
	LsIw/JK/6D3CQz9Tfg+fw4ta8VHxa8iW4K7nmiIP4OAJu9Xf4690P3TBa7C2DwEk/0KQG6tFieW
	R6DxGPSDpyxwkRYvZwAlspIJnNUZ7Ghg+3pzc2FybfnEJKo4BPHhI2eLW7wkhcFxGCWjDN1Omoc
	tqDAK0oaeepz7ILEaCfPWvrHosjLSUUbY2oJK7Sfy6M17MOjFPnonlbztQZ80LXK3CIfDYYqhHm
	NjB3FDVFBqhJdOCbEUTpGd4AXFZuaFd08vpUEZc8dql8N/DgHVvGCr/nfa+49Vd4age0DWYkcrH
	odlF/9rZ2ELp9zARG+48p4azpvlNX27kiU0J6k3Hk//4ByrlailWNvC8fE2sswrVifzLxXN4RgY
	7a+qKpQ4gj8mSTgZm8OtD6QURYbtd8NeMHtDm0yI16sVYkhwIT0slvcOfHyCJXIT+EkZTSTGhS0
	thYhJvpYCXH7c/5rTw==
X-Received: by 2002:a05:701b:2405:b0:174:7d98:fe9b with SMTP id a92af1059eb24-190a50ef6a2mr1184112c88.22.1792557668938;
        Tue, 20 Oct 2026 21:41:08 -0700 (PDT)
Received: from prpatel-thinkpadp1gen7.rmtin.csb ([103.158.138.158])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-19035926fe9sm2589560c88.2.2026.10.20.21.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 21:41:08 -0700 (PDT)
From: Prijesh Patel <prijeshpatel.dev@gmail.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	stephen@networkplumber.org,
	prpatel@redhat.com,
	Prijesh Patel <prijeshpatel.dev@gmail.com>
Subject: [PATCH iproute2-next] man: ss.8: document delack timer name
Date: Wed, 21 Oct 2026 10:10:30 +0530
Message-ID: <20261021044030.46065-1-prijeshpatel.dev@gmail.com>
X-Mailer: git-send-email 2.56.0
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

The delayed ACK timer ("delack") was added to tcp_timer_print() in
commit 37c010d59a44 ("ss: add support for TCP delack timers"). Add
it to the list of timer names in the man page alongside the existing
on/keepalive/timewait/persist/unknown entries.

Signed-off-by: Prijesh Patel <prijeshpatel.dev@gmail.com>
Assisted-by: Claude:claude-sonnet-5
---
 man/man8/ss.8 | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/man/man8/ss.8 b/man/man8/ss.8
index 3871612d..54af744a 100644
--- a/man/man8/ss.8
+++ b/man/man8/ss.8
@@ -55,7 +55,7 @@ timer:(<timer_name>,<expire_time>,<retrans>)
 .P
 .TP
 .B <timer_name>
-the name of the timer, there are five kinds of timer names:
+the name of the timer, there are six kinds of timer names:
 .RS
 .P
 .B on
@@ -68,6 +68,8 @@ timer and tail loss probe timer
 .P
 .BR persist ": zero window probe timer"
 .P
+.BR delack ": delayed ACK timer"
+.P
 .BR unknown ": none of the above timers"
 .RE
 .TP
-- 
2.56.0

