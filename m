Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3DA3368AC
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 13:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790257661; cv=none; b=RcdRokdR97llUS6j5MuTRhM7VmnuknKvedjn0toFQIqErhBVS5lbdU0srwke8rIpo6rC+mk64PIbWKvjnmXpfGxFePkOBQMd3YLA65vfCXfTMOldM+CgCGrbTTmXd4ar1zzbL5M2nRbXLynFamWQp3X/R6PcJZT6nsuciRfIXNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790257661; c=relaxed/simple;
	bh=Bu02msQjigUXe33lxgRwwBSAON2v8RjmFPGCWgmDk9g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SttRfAWRiFlVPxbIIbp95lh2hcla/UgvtpOYkeo8UgLKGKH2gv9lY2dHPOosKwQ/Du6AWUtugaPOiHpu2+E6sdSFqyVHgDhn/g86pF1S7vdKnBjyji07w/yyazklwggqQQMVMWgePIS25AE0AFmj7ikqv5XRsghn6IbQLnWBWWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EHEeWjIp; arc=none smtp.client-ip=209.85.222.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EHEeWjIp"
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93a0312937eso251704685a.1
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 06:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790257659; x=1790862459; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PIoeQJHCqJ1fzWpOzBa7lWmrzpe+EUhCsJ7YXP8YLe8=;
        b=EHEeWjIp9wCuHR/kGXNNWRjmUMENg9gNu8W9p2kW5p5VGJ4+79fWhS9NjyjNWcHdiq
         kY62pJxdtbnETPmjy0d9qLQPuEz2KC4qrBmc8OF9VvoRd3R112xp6KiE2ZquETXPc4zN
         R0NGliv3C3FT4V4AXOq5DIUvlXwWGEtvGy0kkwL1A4oP1B1DpyGeZMCNZvV/1sENd2zA
         nkA3s4qh1E/osAfwePdsN75cb1NWoBd7h8/k4LH1Enfc1EzbSDV/ZZOdIBe4Ha+OqmFv
         TNTEkVqksT8IOT4P8QFBME4h94McSJFdJZdd15NwZFT1lSS67m5v15yQUSZGov6d+QfL
         e8/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790257659; x=1790862459;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PIoeQJHCqJ1fzWpOzBa7lWmrzpe+EUhCsJ7YXP8YLe8=;
        b=BdMhf4n4qxsPDQFedh/MAO+9HRit9azkOwxgRBK+pJXuEdB3JBnlzSJEDjWNnGjDhG
         Ihbuh7C27BSsjstfGL3DBbu7HvMmjsBjyQzMQzaxVCgqFcYiBCNJH+leIBuLq3yRrh+/
         YTZzBpzTjNOIaqI9s4ANZGNitTboRFVrSlWzl9kybvhf8FC4hox/Jy5/OerqgCs7wMW0
         ol9UfZwMvqW9HN6GyFZJQ2siywer756A3mPjr/Pur664dpgG1xxTEqur/W8qtmMjvTDq
         BZBRLbtzBDkchnyf+OLVWD/SQxyIiNBugSyEG6WOdKotaQVW81Xah3Vr7FRayt0BCRJN
         W/+A==
X-Forwarded-Encrypted: i=1; AKwUvBwnpmLqI7rg+y/ZHQgEfsuCgodVgW0XkKebLNaO6xXq4Wzv4PaPQ8NNp9jbnNsOLtK0eIMckLk=@vger.kernel.org
X-Gm-Message-State: AFuF++mrFJOXlyKqKsmFs/ZGZsVEAeuwtB1aDSMOOdejbVbJ3rLQzHHE
	PEbPVBQhdkpMbw09iUabTgP90M+p2NSQ9dxk/50BRVNOIgWG9I4uthZhjeeA3o2lSx4pT6cb8AP
	Bj01m9CE2LdHJkg==
X-Received: from qkww21.prod.google.com ([2002:a05:620a:955:b0:93c:2816:8853])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4006:b0:939:fd0e:9fd7 with SMTP id af79cd13be357-93c363e7faamr293961085a.43.1790257658393;
 Thu, 24 Sep 2026 06:47:38 -0700 (PDT)
Date: Thu, 24 Sep 2026 13:47:25 +0000
In-Reply-To: <20260924134729.2047213-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924134729.2047213-1-edumazet@google.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260924134729.2047213-6-edumazet@google.com>
Subject: [PATCH v2 net-next 5/9] dlm: use sk_set_nospace() and sk_clear_nospace()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Use the new helpers instead of open coding the SOCK_NOSPACE
manipulation, so that TCP can later maintain a cheaper private
copy of this bit.

No functional change intended.

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 fs/dlm/lowcomms.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index abe9ae4c643fae061d2e168c03219a4f4e1bc007..6aa68a24acab574429664acc3f5ecc25ddd1553d 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -519,7 +519,7 @@ static void lowcomms_write_space(struct sock *sk)
 {
 	struct connection *con = sock2con(sk);
 
-	clear_bit(SOCK_NOSPACE, &con->sock->flags);
+	sk_clear_nospace(sk);
 
 	spin_lock_bh(&con->writequeue_lock);
 	if (test_and_clear_bit(CF_APP_LIMITED, &con->flags))
@@ -1394,7 +1394,7 @@ static int send_to_sock(struct connection *con)
 			/* Notify TCP that we're limited by the
 			 * application window size.
 			 */
-			set_bit(SOCK_NOSPACE, &con->sock->sk->sk_socket->flags);
+			sk_set_nospace(con->sock->sk);
 			con->sock->sk->sk_write_pending++;
 
 			clear_bit(CF_SEND_PENDING, &con->flags);
-- 
2.56.0.rc1.310.g51773c2048-goog

