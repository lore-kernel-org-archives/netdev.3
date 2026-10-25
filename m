Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792901132;
	b=SxSjwAJxrw07RieFYFVjh6GyYInQnDSUIjDThdskHZK5f77WeHVo4BGDvqRCkRsOgJ0P
	 6gutxIeviI8SLVl++Ni2KqeLxP6O0K44buqg0sLLt2W6TrAH+ACAF5aLCu3pN58S1tInF
	 o5uCSg2hsxqAarKxd0zGzuAi7BwHA9MduqJthFjc12aUY8FjUdZ5gKlxIQ2zyDWl+GYTn
	 nQT9dxxjf8dB+5rlnqxRp+edKha4Ap/BwgFBWRaUlWNo4dww8oYTfIfY6j0i7UUuwiyBx
	 qV33rWMONM/NnfA1WJbpCEcFxSOJm9ptsL3he8qAZE64orcrIP3voL7m7Mfzveno1Qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792901132;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=gTPwTs6KQ9y0OogJsarYNN8wQnpNX/uHSQbAgmpcfg8=;
	b=H3JrZ1fKGRdfGl8hPJg76ck7/s7e5tlurNC5dP4CGS8qRhLPQGz4THjLS44ojb6nfeQ7
	 GFw/BBm5quHqyQ8Nr5nKGtoQa9/v67fD6Yf7qKIDgRKXrG6oUPurN/OcxqSUYYXiTvFLK
	 NOnp8dafIpQwoonTgsKcVmLUAhdvoZaot5Fyxg8vK+KjOsrFU1Wy68wKpo0XiQ6RwIfY0
	 1EJ2d9WpAh/EDEi3KxcXWtPVAJ6J9duxESLIf+T1BBHcMkpoVqTRYq2fO2Gcwnogts6di
	 fQuKlrCOQxkXFgeEQbrWIabKcI/0tcZvgkvagheJmmHKH/zifDLchB2jMbrttHCuBQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--weiwan.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=WruFuch8;
	arc=none smtp.remote-ip=209.85.210.197
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A27606A33F
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 04:05:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75A27606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--weiwan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=WruFuch8
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-89fb6a45c48so2001077b3a.1
        for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 21:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792901132; x=1793505932; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gTPwTs6KQ9y0OogJsarYNN8wQnpNX/uHSQbAgmpcfg8=;
        b=WruFuch8yfURzb8ZGFIy5pQuDQ0rbwdUz8UzGedqewcmOlonpl+TOvKkBhHCS8k7zx
         QbbfksQH3++GId6saBoRpRwOtzWEtX6yya4XyH7zRfW4znWbi+Q6wbCwCu+HvfT+/oKa
         f0hgXQ+kVNIdVUPgt6H528AxLSEoLJsjnCiGSjrqwSNnUW3DvSvSQUhb/pK44zMMW8ys
         IU1zTOsnm/isPBN2KEbK7VvbwTpV1hE9bKnRPuVQCWg2TcEvKIk/jy2iJKswN6mOKNv9
         08xshmL2GCo1FzaG8S91+IEuypW7MhOx//Z2sjjDb8PiuxjMeKILtghCGZ0KoUs1yqsZ
         hrsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792901132; x=1793505932;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gTPwTs6KQ9y0OogJsarYNN8wQnpNX/uHSQbAgmpcfg8=;
        b=pghuJpXzTQLrTw3NMPh6rFmWv7LL6hR6VN87FEAKf4UCF1E7iH7p7TbzVAhINjBcX1
         3jZgZsPu32ht1IvEBYM3SGk5dP9eAxNXF6hsXV/RYxqR/JCsZtgApyL0Ra7KXWOfuRXD
         u79U7D35zOxx69qIOR99XUsykpM1Si8Mkez1RBNB4Mgb6Hh7pdvymSAH/8XQVSaTEElM
         THU9frb8R/IdBzpxFbxkZ2nXdS+vCKH/xZESwfgYX9+WxQAjxL62IgAGgH6jFIvVzWLi
         c0oFVvP4P7RfqpFtHlVwHpe0eCj/HW/r3CpBpnekZpZFIQlRExKPqnsbBHXDEJm3ugkS
         losA==
X-Forwarded-Encrypted: i=1; AKwUvBzVItswSYGTe82g6eDguYGaJSXulcVPNJf9ubA4WCUJBe/SmS6buJH/b6ZnkjLzA0qCzbbPHjo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLA0Sc4wvqNZ2bZloxiStqcCh38iWqsGVNr9tnQ9np2DVvkfpXw
	4X6vbQt3hDIYRkFoxyn9O0P36nGQmszstUHySibVzl+qD/XF+VB6Zum73YurGLq2xj9vDFoEWMU
	mzW0Wcw==
X-Received: from pfbeb23.prod.google.com ([2002:a05:6a00:4c97:b0:894:b24f:9540])
 (user=weiwan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:b56:b0:89c:6036:c63
 with SMTP id d2e1a72fcca58-8a366d7a4e4mr2631352b3a.32.1792901131466; Sat, 24
 Oct 2026 21:05:31 -0700 (PDT)
Date: Sun, 25 Oct 2026 04:05:23 +0000
In-Reply-To: <20261025040523.678027-1-weiwan@google.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261025040523.678027-1-weiwan@google.com>
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
Message-ID: <20261025040523.678027-3-weiwan@google.com>
Subject: [PATCH net 2/2] selftests/net: psp: test bidirectional data transfer
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
packets redirected across a netkit interface associated via dev-assoc).

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
2.56.0.257.gf7497c7d27-goog

