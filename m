Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970BA40D57A;
	Thu,  9 Jul 2026 12:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783599378; cv=none; b=NUy+s5pdcU3joXbP1Kv+sDjnDsPT8OdSwsgU9iLrrp/Wj5P/KehJEFioGn6U9OsaRsgjwdf+aNYOhw5Pu8SFKHET0S9pxjRP0mccXE1eDy3asG0oh1YnRX8OriUXgnfenEtXEWteEqyoiFZhoG6uEMX5qsjQ2JKJMzA0REswWes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783599378; c=relaxed/simple;
	bh=zC0bllH3F6STJxD5onSKiQv5l+HmDCXkkpVhSSayUoA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R7ZjBud0KNOw9mDU5RCoHy0ehp7rQECxYI2E5q25L2u6yN4QXvYCoBfvbesmr52cbjgL6h1iDyAHrZrPLbnJJfXhOrOmb4vHL55qNDQKX9FDEku7unfflUU0TWznVzb7G3UjwFNooMgZI89V6tyrqY051ZawfibOki37dzI4xjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=NRvX2LXD; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=P3zjLN9p; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="NRvX2LXD";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="P3zjLN9p"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gwv7y2sgXzMlH0;
	Thu, 09 Jul 2026 14:16:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1783599374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TIKYh7bdzb1GqnHcNjvgZriOdWEV/taPUf9EBER8f/U=;
	b=NRvX2LXDTzPmrdt+VzXXkMsXHwRED1GB58uWJZ1WRqbcrfUnvGXZRe0zJrQfaYW0c2YtBy
	69/ZM8my+xiA00P+lM9SGQzkFTpR+MkgTlJipq0ppUG6Q/6pvujilDaQup8unKWegf/N/q
	Q2IeuVLsyqCfTnbY5Gu/YFug8rfizGKNhb9BmwP4di5whM8y6mslISoYFSTwzq3qGN/65s
	QbiRdXK2dTga642Cd6oSD2U8BIOv1YqkGPWNj62eFXdb2Hq6DU2zy8JFofEKMePZx8fapx
	1yFzD48o7to7xr6eBmyLFiB8/D5orFmyT/0jYLM1bT7U3YUeT+rIpCTDD87bXQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=P3zjLN9p;
	spf=pass (outgoing_mbo_mout: domain of manuelebner@mailbox.org designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=manuelebner@mailbox.org
From: Manuel Ebner <manuelebner@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1783599373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TIKYh7bdzb1GqnHcNjvgZriOdWEV/taPUf9EBER8f/U=;
	b=P3zjLN9p/6qA7WUv2Jf47rwhssBmSzqJBEE33Y9uQEitaQ256IxhzTdmkjnwe8/Rqjx4ls
	4BsMRl450Al1T1iyu3vm9r36ypEcUhHFoyaYZyFBcWBlT3GqMT8O673Gw+i9oJB+7POOe0
	w7ftzjQ8GnKZgKZZ0AotDcXBJFwyNUsF8muF8VWl/0YzJ9aTAhGZfkB0LGEGeOM9Zqfej8
	ll/Vo0mUL4htUx+l4QhO9B/ca7jVZAZ9m6ib3JgOKN/aHBsS8NWCwyUgmt3JRpyqlrWz+C
	OzFYosbQQjMqrLcuqAlxHAtfUwNczF9cFMrLAtDBXGBM7hGNkw6EMFiOM6eTcg==
To: Vladimir Oltean <olteanv@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: Manuel Ebner <manuelebner@mailbox.org>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] docs: packing: fix brackets
Date: Thu,  9 Jul 2026 14:14:27 +0200
Message-ID: <20260709121427.391749-2-manuelebner@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: cae762e11b1dbf13211
X-MBO-RS-META: okdtj4i4mge8yh5q7qt4ff5paagia6z1
X-Rspamd-Queue-Id: 4gwv7y2sgXzMlH0

Add two ')' to nested functions in code block.

Signed-off-by: Manuel Ebner <manuelebner@mailbox.org>
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

