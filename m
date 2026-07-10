Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A973A6B65;
	Fri, 10 Jul 2026 06:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783663562; cv=none; b=aHs5i+apiAInU6zESQKMtbyN/fEiLLvZUsZ/arGqfEJCFOc+yQHIsnlc4FdLJtzSPt2Pr9w8pjr9MF5t/R/SCLmjwPmjIVhMkOwjlbYxyKyP+QzMVhNHYdQ4ac/jIN68NAO5AcK6uiE7HNY28+w5Lw+IWtCbfjhgSLTioAA+Jyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783663562; c=relaxed/simple;
	bh=sZgn80uGZ5bN6mebqldL+gMcSR7f26CP9F7FJbqhlVM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f6KcnsHDz47pp6q3nI15Y9wIbm5ZxudnhVLxbjFD0T+48pz/ZXBSG9ZvUJGWA2K7a0Wr8gG8itRe3CI8MY5KffvLEwDgzT172PUkjhMqNYg2XXIwWHU/KYnZPjeIQ4nSX0P6T9p6wFkGk8LFZzS/ltxN7+PG3jku1ih7H5GYQWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=s/WmvID9; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=ODjyAngL; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="s/WmvID9";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ODjyAngL"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gxLt73d5gzMlG2;
	Fri, 10 Jul 2026 08:05:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1783663551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Uv2CbFZ7cH3Hmd7yy3md8uk9BC4HCnVVFcTQsrjqWoY=;
	b=s/WmvID9WitnpOyHV9ZQxHRKWt7qlkm04M3fXWa61Tv6OXQyqmQLIQmupfab+UjwqE+jPl
	xhUj+55vajyExpLiU6Tg7Gs8tmt/Rm+O8IF4D2yC2wdFm80B5NXH63By688pFaadQFdepB
	lJeYlZ39X1LWVpJvULF6fh8PzA8INOumEmXu1mkbgfE6IRgiR8EqsoxpFX0ceh3aGzgK6X
	0eTalNyRX5izDF8CAJHAyHSb/8tJ1FYtZBbXge7tlVYFEwA59INO3igJk5/uYqoXVahDpv
	iRn++V6dcrrD9pNkH2/HtshYQwGNXgENzjLk0B4i+89Ozj0R7avqcjY0r8cejQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=ODjyAngL;
	spf=pass (outgoing_mbo_mout: domain of manuelebner@mailbox.org designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=manuelebner@mailbox.org
From: Manuel Ebner <manuelebner@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1783663549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Uv2CbFZ7cH3Hmd7yy3md8uk9BC4HCnVVFcTQsrjqWoY=;
	b=ODjyAngLp71lLFv80JVaydUlqe2888YYgflFmJP1zkzPEzWpsjmGbBqMQ9adLrsHBD9jY7
	Bj5BA//CKWm3w5Qu9dqer7wKb9UrGvaimr8PvGPzogU4nTnONgSN5aOZsllRIpVF+lvxDz
	S5GEjQACZx7MJFmuZ18tnUnZoeodRgbZo5XC8CsZg3nm89mSM87AshyV7hyUN9+SDThKPA
	uqwzLf3f+9zj7NjDI85acU5AVzHd6N+kqF5724ldpcASxdnjz9HcM3+O5iA4YIHT8d78+j
	m4noIgJZ7gcWHL0Qvj8YDOyVKjBoUoHGvT4ISxEs9ISVJkJO9ic+E0k8qt9YWQ==
To: Vladimir Oltean <olteanv@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>
Cc: Manuel Ebner <manuelebner@mailbox.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Randy Dunlap <rdunlap@infradead.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] docs: packing: fix brackets
Date: Fri, 10 Jul 2026 08:03:46 +0200
Message-ID: <20260710060346.417669-2-manuelebner@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 63237ca027c07557ae0
X-MBO-RS-META: uxm6haoodbhcxhy8owyphy5q3f7g64sx
X-Rspamd-Queue-Id: 4gxLt73d5gzMlG2

Add two ')' to nested functions in code block.

Fixes: a9ad2a8dfb43 ("lib: packing: document recently added APIs")
Signed-off-by: Manuel Ebner <manuelebner@mailbox.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
---
[v3]
 fix subject
 add Acked-by
[v2]
 add Fixes tag.
 add Reviewed-by.
[v1]
 https://lore.kernel.org/all/20260709121427.391749-2-manuelebner@mailbox.org/
---
 Documentation/core-api/packing.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/core-api/packing.rst b/Documentation/core-api/packing.rst
index f68f1e08fef9..cff1a262efce 100644
--- a/Documentation/core-api/packing.rst
+++ b/Documentation/core-api/packing.rst
@@ -330,7 +330,7 @@ Here is an example of how to use the fields APIs:
 
    void unpack_your_data(const packed_buf_t *buf, struct data *unpacked)
    {
-           BUILD_BUG_ON(sizeof(*buf) != SIZE;
+           BUILD_BUG_ON(sizeof(*buf) != SIZE);
 
            unpack_fields(buf, sizeof(*buf), unpacked, fields,
                          QUIRK_LITTLE_ENDIAN);
@@ -338,7 +338,7 @@ Here is an example of how to use the fields APIs:
 
    void pack_your_data(const struct data *unpacked, packed_buf_t *buf)
    {
-           BUILD_BUG_ON(sizeof(*buf) != SIZE;
+           BUILD_BUG_ON(sizeof(*buf) != SIZE);
 
            pack_fields(buf, sizeof(*buf), unpacked, fields,
                        QUIRK_LITTLE_ENDIAN);
-- 
2.54.0

