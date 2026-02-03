Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF571F16B
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 05:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770096134; cv=none; b=QIGRuDE7mo5avyW31aLxHJdEV63G3fbdLRukFD+WiF4rhtU/6NrTOZk53MS/P3BdicaovcswD+JQZQKmZM7AD1nNWenCEm9X3UCk1tvgQH0688tsr1HwFaNht+iPFewNbcS2kfjsgI03k6s2278+VQwdtunM9WyAsapOIZxMtqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770096134; c=relaxed/simple;
	bh=30b/3PWJjMyC3nlaauRXcKUbSsRvBMLNoWdSONXUd+A=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=DBnpfvvzjj2mmD6Fb/3XGp4D7gz+/i2xS7CW2B+xzD4RaLF8w60eHaJBTet+dVQaXSt9J4haQEMfz49KsCLw/N41WdF4M1EkQiJwSq2oRvL68NcyNVvsjS7ypu4AU/OoZPM2APF+hroPTOoEwA2Tze02dUeA0CWyLuU6R2QR7RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qi3mswEj; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qi3mswEj"
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8c277fe676eso1578280885a.0
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 21:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770096132; x=1770700932; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LQeLA0VbvE2nuWnzt2gI/rk7zwQAGvGjEBBq3EtRqNs=;
        b=qi3mswEj1NJlZ4s4jDj9pdAm5oA+ljvMhc7fIZZUK3y54votS9aXdEW+OvOGYEAh9D
         NWS2u5Tdf6Phx4zgAr8qeDEwsU9xWG8IBRqTSsdgGc4GfJSIOtSkbU+fMXNw8FOInCNW
         SdtJU+zSfYrbI4rkW9ZoHuEPoFbNdLLXO1VDcDfQRAkXSjbJ5ClZ31oI0A3mHUKUDisQ
         xdAJuvq7hGxNqdgBGJlci7BGv2Ca9brfeX0qhfRF28PeVYz5os4BLcD6MmZgQ3iuyvsM
         HfZs5UAwHQzJCi73NeScnawVafKYcbCAGqtr1NHbzCYIA7Q6ViB++LRWwODwhyTsJSCI
         Ptzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770096132; x=1770700932;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LQeLA0VbvE2nuWnzt2gI/rk7zwQAGvGjEBBq3EtRqNs=;
        b=ATWw0M20UiXZI7n75J+0BEAm7hv8W14iv6SqbLcUzOHAbxoHTVzCIUFXLEgJVw/OV5
         WUyrf1lvHqjlX7omE7uuRqtZEnT4LL8m2VOAIy78cLo3yKDa8XEbnd6Ch8xL9ghI7lS9
         qxFEHPQiDioYLqr4bbr8AElxcjrLhpotWTvXJitGSRZHXpMEyZy0vlc5SG+fb6f1t3i7
         H7GYIw+ralANzHCKykkf/e9G3HFZ3HUY9nzn6aa2wM1B/jKWKJQ1jnO+66QIIMmU+10o
         n5C1ASQab6zLxzMGjpUqZW+pPLJ2O+BzVQeZv77FM1FIcy+2kMIpcqNSer+DKOFJN4Gm
         iF1A==
X-Forwarded-Encrypted: i=1; AJvYcCVQAZAD+fiC5dzubEi/IvE0ur3Li1cRWTLC2e5JR8Fha+yuVCJRgY1xFp2+LZtdGI2mdWLnuTw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1bztvkhSEccv0vJPp5XqrYmmJYijeWGgOnOW6w7vtSbdJei7Y
	56Sffw9N/67nDX1cU3UG7TIMI/F3eLvvOZqgCtYYPw6NyCmJ9cic5lMW1e4BaEh8uCufyVJtOuC
	mbTRilcgU95B9rQ==
X-Received: from qkpi16.prod.google.com ([2002:a05:620a:27d0:b0:8c7:e89:a07f])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:258b:b0:8c7:fdc:e87c with SMTP id af79cd13be357-8c9eb2eecaemr1641305085a.51.1770096131738;
 Mon, 02 Feb 2026 21:22:11 -0800 (PST)
Date: Tue,  3 Feb 2026 05:22:06 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260203052210.3684125-1-edumazet@google.com>
Subject: [PATCH v2 net-next 0/4] tcp: remove net/core/request_sock.c and no
 longer inline __reqsk_free()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

After DCCP removal, net/core/request_sock.c makes no more sense.

Move reqsk_queue_alloc() and reqsk_fastopen_remove() to TCP files.

Then put __reqsk_free() out of line to save ~2 Kbytes of text.

Eric Dumazet (4):
  inet: move reqsk_queue_alloc() to net/ipv4/inet_connection_sock.c
  tcp: move reqsk_fastopen_remove to net/ipv4/tcp_fastopen.c
  net: get rid of net/core/request_sock.c
  tcp: move __reqsk_free() out of line

 include/net/request_sock.h      |  11 +--
 net/core/Makefile               |   2 +-
 net/core/request_sock.c         | 127 --------------------------------
 net/ipv4/inet_connection_sock.c |  19 +++++
 net/ipv4/tcp_fastopen.c         |  86 +++++++++++++++++++++
 5 files changed, 107 insertions(+), 138 deletions(-)
 delete mode 100644 net/core/request_sock.c

-- 
2.53.0.rc1.225.gd81095ad13-goog

