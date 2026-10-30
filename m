Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793334712;
	b=Oyx6BCmtLhPnlftIkYuLNupw1RlFsTa2caT/YbkOTGxWZEOi59kOX+qqLdNKzYDpp/p8
	 Xq6dx0MQUzx9bZMKZF3x5tROo85HgN0QoOTEaUQUPQuHFIBL8Kdk7Q1DK/ls+q94ioVJ+
	 RzKnXYmy91SlqjRJosPX7GTqzJvxBUphm98p3IIPp3owQCu1x2QmtJFGTkaHM/ItDQ0i3
	 ubr5IRcyTtYPBCN6E+WVJh3FhbGypRzjOtwxFmNjzeKzHtHtDh+tg3BBhn4L4EnwUJ3hy
	 43jj8tanI7qE8PmPmRRWOrDOeax/J5ENHHbvykvSRC6fAhbKW7Qjr3MqU8WIgRST1Gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793334712;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=bMdKaLnci5rE3Vyxt1ztOm4nlJPbyxipNoi6qOdT6zs=;
	b=GbjTkswY/hm9V2TqXHScCqs86y3O67RzeQyvuijpCPzgoU2L6WmczC9mo/2e142p5vNK
	 7qW958hkKIXqD9NCrPs6ZAIbBdTmgilPLq93/kqJaNDnmWaZ+Ppu0V9reDgURj9ghBnXA
	 Zg+xQvJqYXO6u6YnNqcxA+SWwStFXRhB2D890t5vxD02qcXHJ2lwHkL3DYLk2LPYXTbgS
	 NuKUKX9RbQ/zUI43i0hMSWlu+xtnqw80eSWMxYwYoW9ene+lfvqPH39HACIPooAMPZato
	 0C8wBeOv51Azmdg+kenyoUhJZzKYRR7bRYADRjirji9OXdc/W5y7fi4CjUqEqyC229Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--weiwan.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JdVCMErj;
	arc=none smtp.remote-ip=209.85.214.198
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593CD606A339
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 04:31:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 593CD606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--weiwan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JdVCMErj
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2e869e00005so5915475ad.2
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 21:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793334712; x=1793939512; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bMdKaLnci5rE3Vyxt1ztOm4nlJPbyxipNoi6qOdT6zs=;
        b=JdVCMErjF+4JfBwV8owjnae0AaqwdnF512qEm9m1iEtGtFSWg8l3O6IrJNSWb80veq
         MC4Sw+oX8BcfqD29ZeDuqldB2IC0M3nfP6NyUFw3NLeEVKlpeux+CoUrSHR+KjvXfA1x
         WBzvXZK33fVOfJDNPQ1nkguTbsTOz1/xEk81NpWcgxrmaiayGRUMPMJsSc9KQ2d8EjAk
         hUAJ8Bp0DAMOWvjKB1Lyz6IFb11j/a662N7Pk/sbC93uY3iD+Yi2rIDJdQevUvzFpcYK
         ZtEn02hE6EdRygHmDjUXwGEGj9Cu5nMdKBDGu3Xi1ZL9jXzaiiNRBXlWB9RYkYjScP/p
         BRnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793334712; x=1793939512;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bMdKaLnci5rE3Vyxt1ztOm4nlJPbyxipNoi6qOdT6zs=;
        b=G2VKYHAg5VH7MJKF+U1dy15GrsXCDwArUGmMxhJv62K6857JiyOkZVmuxgdRAdO5ey
         QS3Nmd/eDgKQnkOunNY4aoYRKXcvYwGaMG6/TCFo/N96+NkWwLVphFvWaieXCsxW9KHQ
         PdKVhFgn6qd2GTcTlEZqBudxGGOhYHQF/KJ/80P4m4Gf40FNEnScmR6gHhCR6VDrNhT3
         0BvY5jWakZlTeTqOY+CU3N16w+oamaSSOzdsPUXjv5r7hrHfne3hnazPR7LqfStHFJW+
         bduPeT5laLW1ZvMerIcqJfEH2ky9KqTCTrOjtwdLt+7jdA4zegMnI+9jsXvo4zwuztJk
         4SDw==
X-Forwarded-Encrypted: i=1; AKwUvBxXQ0EuZBa145M8Pb8GrAq1oYjKZTXUhWAkO6oKzyeJkHMkDuHn4utkt1kLaEKczkV3jHNxrsM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJPFRjUXe6JiK3JmDhYZxN5NER4Sk12aGSpTgrgBTdEy+B1fs7M
	M186zETe8EzeLnwfxin6/FRqW4v4X1qnVqnB0fzBDPnM0znXew++48JcnL+kJ255d57P4HAdH2K
	nYxDzGw==
X-Received: from plkg13.prod.google.com ([2002:a17:903:19cd:b0:2e8:1f84:7c18])
 (user=weiwan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3c27:b0:2e9:460e:ca57
 with SMTP id d9443c01a7336-2eb36426e0bmr13063885ad.15.1793334711324; Thu, 29
 Oct 2026 21:31:51 -0700 (PDT)
Date: Fri, 30 Oct 2026 04:31:45 +0000
In-Reply-To: <20261030043145.2185700-1-weiwan@google.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261030043145.2185700-1-weiwan@google.com>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261030043145.2185700-3-weiwan@google.com>
Subject: [PATCH net v2 2/2] selftests/net: psp: test bidirectional data transfer
From: Wei Wang <weiwan@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Daniel Zahka <daniel.zahka@gmail.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Wei Wang <weiwan@google.com>
Content-Type: text/plain; charset="UTF-8"

_data_basic_send() and _data_basic_send_netkit_psp_assoc() currently
only verify unidirectional data transmission from the test socket to
psp_responder. As a result, they do not exercise the receive path for
PSP-encrypted TCP data segments arriving at the test socket (such as
packets redirected across a netkit interface associated via dev-assoc,
which relies on SKB_EXT_PSP surviving packet scrubbing).

Use the existing "data echo" command in psp_responder to verify that the
test socket can also receive PSP-encrypted data from the peer in both
_data_basic_send() and _data_basic_send_netkit_psp_assoc().

Signed-off-by: Wei Wang <weiwan@google.com>
---
 tools/testing/selftests/drivers/net/psp.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/psp.py b/tools/testing/selftests/drivers/net/psp.py
index 473500901879..e507951b440b 100755
--- a/tools/testing/selftests/drivers/net/psp.py
+++ b/tools/testing/selftests/drivers/net/psp.py
@@ -120,6 +120,12 @@ def _check_data_rx(cfg, exp_len):
     ksft_eq(read_len, exp_len)
 
 
+def _check_data_echo(cfg, s):
+    _send_with_ack(cfg, b'data echo\0')
+    s.settimeout(1.0)
+    ksft_eq(s.recv(5), b'echo\0')
+
+
 def _check_data_outq(s, exp_len, force_wait=False):
     outq = 0
     for _ in range(10):
@@ -478,6 +484,7 @@ def _data_basic_send(cfg, version, ipver):
 
     data_len = _send_careful(cfg, s, 100)
     _check_data_rx(cfg, data_len)
+    _check_data_echo(cfg, s)
     _close_psp_conn(cfg, s)
 
 
@@ -726,6 +733,7 @@ def _data_basic_send_netkit_psp_assoc(cfg, version, ipver):
 
         data_len = _send_careful(cfg, sock, 100)
         _check_data_rx(cfg, data_len)
+        _check_data_echo(cfg, sock)
         _close_psp_conn(cfg, sock)
 
 
-- 
2.56.0.317.g454f8302e1-goog

