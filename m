Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793977524;
	b=077YrOl5M63BoEInovbFmKCYXqT3hxBqnG/iFBl6bZg/QVaGjxrJ7WMF6BbT2taJQ4pk
	 X8AeqSDy+sgweB1PXw/1hhlQ1YX+a/O3DnoY/wQlVmIRlgh8Z3qWqwkoDCsk4Twwol+vo
	 qyFpCgOKdG6IruzbCgwpbr40gXqAtHR6Y8gKoUbqLqfIyFnilqm5nAkKBQN1uN9CQ/sdO
	 FnIJkLAdq3xD9afBW5knHQbroVmDv1HLU0LvClXrA83/5MfJ8MscQzBwdL0joGTIdGa9s
	 08R+wrbjeOuqPCOfg4egwHAAkcRSvEpB3jjUEEqKjuKg6RYbfDvWYJTssS3OHnEly+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793977524;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=AmiW9emmj8T3laIwBfZf//xv7IetRbnMAUqXEU+CEsc=;
	b=KjcXSydi8N0jZ3mWzHRCDlqyKpXb4BxGpkiu37V8ajRun1Q/sm1mu7Kcip+Lz/OFcXaZ
	 qj3PZEFDcJrjCHSscuvadvd1d3Olw/5girTSLHnwyOFv6XBFXs8xjXJw7QWUtWFqDSJsD
	 jikXuloYUSljMTz+RnqX+LOGtJ4ZhXANFaeHo4zXpOYwlbZrs3F4V/IHLGqZ5EBh3OJ3A
	 wP4mhwRUEHDVaKQawsnF1hc28EQ9aNifb6olvMcCKPhiTFfAs8y1Qgh1++QVFyB4y2so1
	 bmXqcvZB+67r0H2QfclRgzpFeb/ZM3vLj4/zkfyMUbPMzHIVFq6t53yczQ5a8oJk6Yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yGusTcbF;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A60A606D803
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 15:05:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A60A606D803
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yGusTcbF
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a599e9110eso2297515e9.0
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 07:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793977522; x=1794582322; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AmiW9emmj8T3laIwBfZf//xv7IetRbnMAUqXEU+CEsc=;
        b=yGusTcbFvJMxDWFkQqL7/7VJc1srXLp1ZyzkqHljAh9MJgxGv0TdBf2kCq4x40R+8N
         +uwVNgGt4KQHUS6+kqz+zb92xHF/zFdVYC9D+KTiXRelHT/2ym1HxC3v2h9uoS3XyNTV
         Ah2701llocXqBRcfMeIY11U0ipBWRCj4y1vl0MWadrdDFIEZH7PfO5EINmVW3B15CYKF
         smvJXapilCrmhv4OIowo9s8cLk5cus2nG+e2z/akTx0pNMrSVKJbaGKZW9fFRChBjVQ6
         Ye9UsBgrTBmQqcmaBWUkAZhtTnoTfxeRV2ohscUmyF+oHkluWLECHsbSUpXcB4ShUF8q
         BQHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793977522; x=1794582322;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AmiW9emmj8T3laIwBfZf//xv7IetRbnMAUqXEU+CEsc=;
        b=Z9gP+S3H2nyPeVj850cWZ8eQX1Y9+jFIDDyohYkVJwYbjZtTFksaYkREifiq79F1Q6
         fpHi1ZUwvPd5iNIPQKlNt56gNYqcMBKaQuooPhc1EoA9SD3FXB5lhWmLmogpPiS6/nzF
         Oli4yFhb2ZwPuyoNtUI6ojgJnCi3WBMQmdk0Xu6buN0F1l5bqQwQ2aKgpXninvnXis6i
         Xuq6uJOhj4tE6JA4LQdtFwwbFYchDfBua6OxZFT03fZp677hoL8ZFvvs4EMVOm4E7zY7
         GTBOVEDTn+flDjKQr6eIBwkhA09VNCx0lQrX4ppZIvBNBCTAyN9wLqxNRhhnHreS/TcC
         r9LQ==
X-Gm-Message-State: APuU4Z9jQV4w8L4GYkZii1hRDXGfbC9KEvVRiBZJEDTPFxa10zkGT461
	11tLF/nq9A5dLLcgzAYtGFh4V2DAewGatSUwrGtu1TmFu0v5u+RTdE2bikwu+HQX
X-Gm-Gg: AYBFou3fGjjzcviJrLRAs7d9SVGTgkn6vKgq3M5DmQsrA7rzVNG+4NHNf7eTP6/13Sm
	5Q+dt1psD0AsNMsT199XC+bCwosBJcymZenc28Q09iUSXtUHiAYdk3q0EkUnfNpmF19KeO7H4NG
	b/NbetnAWGXpz5QAs2xSMj2jRoOce9W/P+zsogCFU09FHr7N6sU6LK0qjL5ZLrLxqg/eTquyycs
	3CXW9JDAd9go6VBnGyBz1ql+zHxEzq/l9ZQnRTVB3TZ1SIZDc7cwA04dJTpM4SdLujFxxhUGxbE
	tCSdWoCG2Gk3ZcHycf9PfzASZzx/CWUryvgbPbgKlqRqBdjTbsV3t/wNdQ83JTd7QTkHjzBAoTt
	dTqJpl+zNS/L8w6kyCf8ivL58DWNn89RBpNhBT8MfgMyw44cgE28Kl9Xb4rqWqbZxTFzlpXSNbk
	NZfWDfFg8xBMJSElMbUZHS7WjK0a/eJ/dtQszmJ46yco3JmJqyJvzwko01v38FEHbcuC1aS441Y
	B+UTqJ3Kuvupvvi+eykYuPy3TM9VgrOzBynEr5KdAgLsPr5ywVaQGNvkqaFpNFqKo8atEvHxmUn
	wz+hmveO2rGRWadTFPZdJBz06h4Bq0VuIDGyT1Aqyb4T5wekE0tUPhyTvzC+rEkbAlFyVbFr
X-Received: by 2002:a05:600c:c111:b0:4a1:e015:6441 with SMTP id 5b1f17b1804b1-4b6d8a63e17mr41374465e9.0.1793977522560;
        Fri, 06 Nov 2026 07:05:22 -0800 (PST)
Received: from localhost.localdomain ([193.255.169.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b56e58fcc6sm260950305e9.2.2026.11.06.07.05.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Nov 2026 07:05:22 -0800 (PST)
From: =?UTF-8?q?Bilal=20Yaz=C4=B1c=C4=B1o=C4=9Flu?= <ahmetbilalyazicioglu@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	hmohsin@meta.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Bilal=20Yaz=C4=B1c=C4=B1o=C4=9Flu?= <ahmetbilalyazicioglu@gmail.com>
Subject: [PATCH net 2/2] selftests: drv-net: ring_reconfig: skip tx stall test without channel config
Date: Fri,  6 Nov 2026 18:05:09 +0300
Message-ID: <20261106150509.30458-3-ahmetbilalyazicioglu@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106150509.30458-1-ahmetbilalyazicioglu@gmail.com>
References: <20261106150509.30458-1-ahmetbilalyazicioglu@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

reconfig_tx_stall() needs at least two combined channels and already
skips devices which don't report enough of them. On devices whose
driver doesn't implement the ethtool get_channels op (e.g. e1000e)
the initial channels_get call fails with -EOPNOTSUPP instead, which
YNL raises as an NlError, so the test is reported as a failure.

Use the _channels_get_or_skip() helper to skip the test in that case
as well. Other netlink errors are still reported as failures.

The issue was found through AI-assisted source code analysis
(OpenAI Codex) and confirmed on a ThinkPad T480 with an Intel I219-V
(e1000e, 8086:15d8). As for the previous patch, the test function
was run against that device with a stub environment and ethtool set
requests blocked, and is now skipped.

Fixes: c98610c2eb70 ("selftests: drv-net: Test queue stall upon reconfig")
Signed-off-by: Bilal Yazıcıoğlu <ahmetbilalyazicioglu@gmail.com>
---
 tools/testing/selftests/drivers/net/ring_reconfig.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/ring_reconfig.py b/tools/testing/selftests/drivers/net/ring_reconfig.py
index baac20e8d3e..dd6ff6b2b64 100755
--- a/tools/testing/selftests/drivers/net/ring_reconfig.py
+++ b/tools/testing/selftests/drivers/net/ring_reconfig.py
@@ -319,7 +319,7 @@ def reconfig_tx_stall(cfg) -> None:
     other_queue = 0
 
     ehdr = {'header': {'dev-index': cfg.ifindex}}
-    chans = cfg.eth.channels_get(ehdr)
+    chans = _channels_get_or_skip(cfg, ehdr)
 
     if "combined-max" not in chans:
         raise KsftSkipEx("device does not support combined channels")
-- 
2.56.0

