Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345D9156F45
	for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 01:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786757589; cv=none; b=jyFYg8HtE3Y6v8GrsaJAoaeV3XRuoJw+rMV1cxFMFWFkQSIhHfBiz5yRF/gKmw38zmKlAELNBn53K+t6BdRhS7RDO8H/eSnUc5Ck5IgkWdRGNFDGv9OU+f6kXnoT5YWWc0RDdWvJYyuVZ1/ku4kHV1pzTwvCzX3QCr9H39ctt1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786757589; c=relaxed/simple;
	bh=k5v9YMbjNbSDDOOGUT/GdP8HfTxzzdlrDdwtaQ4IVr0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qgjkGAoq7VdlxNgcFd2LHpJH496Yvd9voudY1iGo2RJGMiVCubkiOef/+AlBvBNNafqEOAAFcpJcNXsaE4SE2osRceV0NoOSjnBIgBsbE7+KV09ki2sD2UZfhO14020GosBaLrHryJfrnxYirDoe7GtQKj65BXVle86l/IFrTNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=knRa3gu4; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knRa3gu4"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-498028b3d5eso19452945e9.1
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 18:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786757584; x=1787362384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SIGYB4s+r27dzXsvVBxWuaiKhOOlGAnsc8iJP12SM18=;
        b=knRa3gu4IJLqvEV49+J/h2US2KsqLW68pQepMRpFuoL2Fz+9QI0FxWl0uBxIzIEzZ6
         9S/eH3KfZrYTxjW8vO99ieK4D7J+0xj4e9PlZgawwOtsM+i7QbWD37z92cVJ06DiGpwQ
         hDrntog23N/4o/51/LEqRArElEKfCou5316daAS8yDD0MoA30heWyO0swlz4SiqWGCoa
         +HLBaKTwfxa4qe79Ns4aBS3bt9AtaOl+hmXuaAYQRa/7zOqI40bUS7nYmjWbWCbooPbV
         MIvpfFD8+ZJqt3jVzX3QIy/CX2JrgX0WdnYT+K3OEKQngrMUy2w3CK8BP5/rELyd526/
         h3bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786757584; x=1787362384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SIGYB4s+r27dzXsvVBxWuaiKhOOlGAnsc8iJP12SM18=;
        b=VMSBibWcvPhs0xXyiV7uglokAMAN0l1dgCL8daSBqv32DAFOEqUP9aFarUNFiFVzD6
         7MlKUm4MthNWoxEAHIC81dzCYlkkKbw0ReTT4chu29WnClzrfZIAKRL7S9j8mbzpcAfd
         7+Ju1eJIwo4VtUy5CGCReI5Sq0REnmv2OEj7d4E0JRfcYPcZUhm3K6wei/nPxKdcYOAe
         bpRvx0EWvC1Z8P7rJgQuKTEuOBKL58TKbyCnouBbEcXVLzjSdw1snU6C1OU+A21xLNe6
         uEYXu4AHhqh4CmbF3WqS99P1eDXO1bwPSJLRJS/NXEduKPJNZaeQ6UWulria1n7zFweW
         CAOQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp4Oae6W+ozuQ2V9jU+Nmkdwki+D7Hq/x1aqKxIEa/DNeZTyC1qmup0+v9M3aFp26rEgy9upg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOC3mjKll/1Wj/sUGWcEVf8wCyGRLUBsxpooOnCdaA6bQwaSzQ
	HUlLphkvc8pVsw/fcJgli+YInPhtKrSgr4OsYV6jsHTUPvy/lSkZYHt+
X-Gm-Gg: AR+sD139uOyQDQ5UxlwaNr504Loa/kem1wNQaXbe46OoO7wcdVmRQ0RnRT6zorQ5+HQ
	UATBxe0pb/zeL1DGaWXtubFwoaR+Eor1pGeEcMiT1789gqfUWjwkKkE7FxpZJEFUyBLtQ8kPL64
	ir0q80IXLJlmnYIDYLTBtrn5hZOeXAKy/94SAfvQv4ZXMmzKHu8OZKpy8XWyzBY6uGdDYty1EYy
	jK7r7ompLrnht33roSKzeiYYOgZmuw0DxFV47tjQHiaUktydeGrCgIn4KdRWn/9a0/TPNdGjk+o
	joyQgGyoBbKX2kSpKc/qiZ7aom9urARCrg6a4LC+ko7yKqrFbdRRC+/Zq5adpE096Id3txhTTjy
	TZ+lTb0SZ5s5o52MswzN3TnPaRVQ/PCVOrSNTqj+irOB5HUbSMZWDMFSLlwOtXTcH6OQ1x0J3br
	hBgB1z4mhiHO4Iwnufdvc0eRXb9QPOyfP4wt3kKIunCcrjQJDMto+Dp/DfD+TYwdc0+Ou5imaLT
	NVx6DRMfwUtMQAO7akfdmGyVxOMWJjgGjXQnW5bqG2ohV7sD5FxYE3AG3tz6cH0hvju7QUM2qX8
	0NX6KZCLzlum/qcJmK8zrdNIxjmOKBkpQUq00LzUBoSwMN9+FOlBZa0UysKqLDJx4/Gv
X-Received: by 2002:a05:600c:b99:b0:496:c379:b2a1 with SMTP id 5b1f17b1804b1-49987929903mr135321985e9.2.1786757584407;
        Fri, 14 Aug 2026 18:33:04 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-9d7d-f301-9495-44ec-73e6-1be7.310.pool.telefonica.de. [2a02:3100:9d7d:f301:9495:44ec:73e6:1be7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49987b1a31esm110672885e9.2.2026.08.14.18.33.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 14 Aug 2026 18:33:03 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Simon Horman <horms@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 1/2] net_shaper: fix kernel-doc list indentation
Date: Sat, 15 Aug 2026 03:32:28 +0200
Message-Id: <64f428350ec1450adcd0607f54f30d27a42f129c.1786751700.git.kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <cover.1786751700.git.kmehltretter@gmail.com>
References: <cover.1786751700.git.kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Docutils 0.22.4 reports:

  Documentation/networking/kapi:107:
  ../include/net/net_shaper.h:82:
  ERROR: Unexpected indentation.

Add the required blank line and correct the list indentation.

Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 include/net/net_shaper.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/net/net_shaper.h b/include/net/net_shaper.h
index 05cb625b0fe54..330517a1cb5c2 100644
--- a/include/net/net_shaper.h
+++ b/include/net/net_shaper.h
@@ -80,10 +80,11 @@ struct net_shaper {
  * disallowed at the uAPI level will never be made at the driver level.
  * The shaper core performs automatic reparenting and cleanup, generating
  * additional calls. Notably:
- *  - @group calls in the driver facing API may have nodes as leaves (user is
- *    only allowed to construct groups with queues as leaves)
- *  - @group calls may update leaf's parent if the parent is about
- *    to be removed (re-parenting nodes explicitly is not supported in the uAPI)
+ *
+ * - @group calls in the driver facing API may have nodes as leaves (user is
+ *   only allowed to construct groups with queues as leaves)
+ * - @group calls may update leaf's parent if the parent is about
+ *   to be removed (re-parenting nodes explicitly is not supported in the uAPI)
  *
  * Implicit creation
  * -----------------
-- 
2.53.0
