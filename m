Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6424657EE
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 14:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785855499; cv=none; b=iHKRQpuyz0BmRmBD9mJJxNTGFbhucgG2CiVHEh2SV7meHevgXdQnXFSovMUo4HdVYr43a2e2eKus8MKnZoSJsLT+PXMElyXpkzWXYkkRrLKcyrbPKlWLATSuS5bgYBi0/du7Vs2VMwnAKGpsPtPLgMJ1Vovc09TQ7ghkqaWz4RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785855499; c=relaxed/simple;
	bh=i8YEuBxqxH/iW+Xmfj7P2o/m0xuSGhUsZxcXHd8ELfk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nlHWn61YC6kaNJxpBMp5EN6K2uIR6SnlmlcZs23o6EcJrkufTO00v9ZN4E+o4sueTgLiS6CdeguanvVcbvjPZPmPBX+eH9M1LZHpQE1rDeRgUXsuVrUnWj7H0ma3HrsOTXkFpyvCdm8/ea1gsq1qCmlapo/pPjCv+6YFQ8SNy0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iO/MmGB9; arc=none smtp.client-ip=209.85.222.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iO/MmGB9"
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-934979ee9f1so397441085a.2
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 07:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785855488; x=1786460288; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Mbp67Duo3j2+QLj6rlnu719BPTvVeJ0wZW3lDNOVhbk=;
        b=iO/MmGB9DQ7aJJpQwBW9pEtIzETdL5EJKigUVxtRkBOfXL27yihMoTqjeYLwqa0mF9
         RAW5lqZaXlbnvchegzTtHfp52lS4Y260cINkrWzoGDc7UIzDMtxXi/IPR+UABsA1gLlz
         m4EGcr0Nh4EE9CW/mpsSdA8wcQUWqdeNvvHCwr6MY8neQWz3yF2tRjmHL8+QWNmlrxnH
         ktF6zy8ImsTXWcFGDlvnl403Y9156pMD/dkhXkyfpeUeqx8zBFDm32CmXNx1dmSUZWZk
         dBIje3rmwTl5dAD7bog5U4AvEAjA3oSfbn5Dq7BvwfpMBKTrcX1SArylXzTn0PLt8APo
         TRoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785855488; x=1786460288;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mbp67Duo3j2+QLj6rlnu719BPTvVeJ0wZW3lDNOVhbk=;
        b=ogiVqgLckq9/heLnzlNNwUXXqSkNUJBJxK7aIdqhivRdI+VGcNs96LQ9ThvmAXKBQG
         6qveDJrh5DFoYJ6d9r6An9+QYLthh94YSkt3EmeI1ycRm540WXyNEFCCllUBUkBs9LIy
         pXle6wzsPcQ++No/v74bg6USXnN/i0YU5iH1DBRV7MwfbO6cx/96HZDovEweVqd2LnIe
         Ojnk73VEe9sFO4seDcCvDovi1KkE6JnLckWJDEcSHMGz5ID6Yfg/hV9hN10SWXE0vA0T
         6QZ5+5B435Xw2ixgBuzlmvEm8RpBi51C35qkOtqwLfP0RZDLF3XdeQbmhVwJXgWgyWYj
         pQiA==
X-Forwarded-Encrypted: i=1; AHgh+RoRDS74yCSXQUHDHTCzBZvWg7oG+l3ES5/KfSze3sQWOBZvYXUJWI7bAcz/7hN6B94gwRrKJQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YySM3Lq1NsahhcIxEEr6cK6n1wZdt1HIOc6pQ4kcT+qt6MDJV13
	a+nFDBZRTLzAmy8B5Fy3SEWTAJZFscJK2lSGnCxapTJYwj9Se3wtX7uQcWjMaTWpSFn2Txmx0Gy
	46u8WDTDxuBotyg==
X-Received: from qkpf16.prod.google.com ([2002:a05:620a:2810:b0:934:9942:422f])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:1b9c:b0:92e:e559:fe6b with SMTP id af79cd13be357-934a075711dmr3024207885a.7.1785855487599;
 Tue, 04 Aug 2026 07:58:07 -0700 (PDT)
Date: Tue,  4 Aug 2026 14:58:06 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260804145806.2112004-1-edumazet@google.com>
Subject: [PATCH net] net/atm: fix slab-out-of-bounds read in vcc_setsockopt()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+6c98d6eb7aabb6b1ad39@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

vcc_setsockopt() never checked optlen for ATM-specific options (SO_ATMQOS
and SO_SETCLP) and called copy_from_sockptr() assuming optval contained
sufficient space for struct atm_qos or unsigned long.

While copy_from_user() previously copied from a user buffer without checking
optlen, the introduction of sockptr_t and cgroup BPF setsockopt filters allows
optval to point to a kernel memory buffer allocated with a reduced optlen.
Because copy_from_sockptr() on kernel pointers uses memcpy(), this leads to a
KASAN slab-out-of-bounds read when optlen is smaller than the expected structure
size.

Fix this by using copy_safe_from_sockptr(), which validates that optlen is at
least the expected size before copying.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+6c98d6eb7aabb6b1ad39@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6a71fd31.9511d2ce.1fc5b9.033c.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/atm/common.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/atm/common.c b/net/atm/common.c
index c7f92405daf050ecd2a507e41efdd622ab8dc6a8..6a0c5184c0d6380deaa95f68cb97c7745b4f7b56 100644
--- a/net/atm/common.c
+++ b/net/atm/common.c
@@ -722,8 +722,9 @@ int vcc_setsockopt(struct socket *sock, int level, int optname,
 	{
 		struct atm_qos qos;
 
-		if (copy_from_sockptr(&qos, optval, sizeof(qos)))
-			return -EFAULT;
+		error = copy_safe_from_sockptr(&qos, sizeof(qos), optval, optlen);
+		if (error)
+			return error;
 		error = check_qos(&qos);
 		if (error)
 			return error;
@@ -737,8 +738,9 @@ int vcc_setsockopt(struct socket *sock, int level, int optname,
 		return 0;
 	}
 	case SO_SETCLP:
-		if (copy_from_sockptr(&value, optval, sizeof(value)))
-			return -EFAULT;
+		error = copy_safe_from_sockptr(&value, sizeof(value), optval, optlen);
+		if (error)
+			return error;
 		if (value)
 			vcc->atm_options |= ATM_ATMOPT_CLP;
 		else
-- 
2.55.0.571.g244d577d93-goog

