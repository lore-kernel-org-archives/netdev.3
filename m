Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209DB542EE8
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 12:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790080054; cv=none; b=bbUX1x2umzYy/xUwI/0zo2aWX7RWJ8zLqK1sxEAJWoM4U39/Yh/BOlJ5H/3/ujkLrC6S6B1HkhuHucV+p+s2zGiHTk2A0nDe2X6wTM8+0q1gM9wcI6WXU01ACKciE3B6JfqRvhc5qNR16lw7+D2dE57FeMY4stAsT7LcvYFvGx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790080054; c=relaxed/simple;
	bh=SPuw+H1S1IFp5nmlP4vBEDjkvVb9reNfTaYk8525kmo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EO0nKtqLZqMG1U5bmIElxowiggfAsj9ZdUGLyox/9LvkKNFtj1B9yjvEDRkYirCQaoU8qGispogONGmnMNaHgR5Xmu6ZDfg6csH+FButRT7DYdXRvd5WVP+lizFhuF/A913+LM2fM766XNK5QOC64BeW4cHSHXuIxbCmFdbs6t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oT8SdHq3; arc=none smtp.client-ip=209.85.222.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oT8SdHq3"
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-9394ad7f64aso609170785a.3
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 05:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790080050; x=1790684850; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L/g1ysmImjdP6VaiuuJVBH67pBG2aeWcKv6AGGiurMc=;
        b=oT8SdHq3BQT2H9bxjakyInDL0Ly3L8ixeD7l24V3i686riATL3Q4ZLua5dLS+I04Ob
         YG/MJufv9bPCWr5M/UJexX9KM77u0Jvv//diLW/I0t4CvJjC86f9k7QzCCXifqe29M5c
         G+CbNwmU+IZpD8YfprZerTmuS0QeR093kmAcnzfYdF7zwbJkq/RGZkMCsqz+Dfahbcyp
         NzIFsvO3v+QQGv7Df7CuZdvFyZitUOGkv476ochspt4cBTNjOLxN3jY2pBIQa3KL75sr
         VoRdN2dSgDnfgVGgrnL5tqvuvbBu6/KQacu5QHIetfplELCqQ1ExnM4GiN1Omqbra/gD
         qydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790080050; x=1790684850;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L/g1ysmImjdP6VaiuuJVBH67pBG2aeWcKv6AGGiurMc=;
        b=cVk6hmdt+3iPl8uP5apSE/MRkEIhqmOj58jQ0OHGIwx1ULR5dpvA4IGLVc45V2xgAD
         qeI8Fe+hP8EEE0hn+nQsaXpIHdsXaijXIwqRUCKcBbHpmiW8/Vc/EXcQH+eHIbil+i++
         c+1WNLFnZkaTyX2T6+5nStNvrQeZ8bnDBHliA9uFgUthS1uQ5Qpmcvo5vvMp0Ente/yx
         vZhKZV8mffejjeb8BN6lJQIQjGslsb8yB279s2TlvRivs02fxnehTJ00oQfg0hqok1fG
         S6mvDlCG5npMILd/K5vQPumZ5qYz0NjiemS9Pw8fwoVyo6xA7IXCDW8FlP7bnsSVjxPP
         c1kw==
X-Forwarded-Encrypted: i=1; AKwUvBxRFDBw02v/9to0YC7S1BUDaSITbe/Nx7JvlpMnkX3w9hup8OhafGAVU5tLV43ixtE/2uaDFBU=@vger.kernel.org
X-Gm-Message-State: AFuF++muXCIFb6MkS+mrjEGZD8G7DGsTsQwMzoP5aLWXYlCiP1eSO6Hy
	TBAjZoyCqn38m5R1vgVXg2lrXvairsHNKx6MBhFk20GnG9KfJHpTQZBv8KZkQwyuaP/lHogqHId
	S1Ay2K3+a6YvIMg==
X-Received: from qkcbr5-n2.prod.google.com ([2002:a05:620a:90c5:20b0:93a:1516:4782])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4144:b0:93b:d79b:9a64 with SMTP id af79cd13be357-93c15f89958mr482010785a.69.1790080049553;
 Tue, 22 Sep 2026 05:27:29 -0700 (PDT)
Date: Tue, 22 Sep 2026 12:27:16 +0000
In-Reply-To: <20260922122721.3568295-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260922122721.3568295-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260922122721.3568295-6-edumazet@google.com>
Subject: [PATCH net-next 5/9] dlm: use sk_set_nospace() and sk_clear_nospace()
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
2.55.0.1082.g2b9226bbc0-goog

