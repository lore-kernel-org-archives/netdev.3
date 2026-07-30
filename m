Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE57C3F4DD2
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 09:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785402137; cv=none; b=Fa5AFSex+Iu7EQMbf+aG1J4sJKnKPRQidI47PtaUkC+hTvxqgv0BB5Y3VXKFuhu2nB3FPEIJjnm6TYe2QpsQ1tsvOcURrC4F74Fnq8r34E94FZCvNIzfKeptF+/Sr7NBr/uhweC9hV7XsoLvokBD6/GGrQubsOn3ia1aUgmXA5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785402137; c=relaxed/simple;
	bh=7ZO1Hs1qH/JY5i06DvrUJ0HS2+O7RV7KvSY9xWkAOOg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SnlzLTOFGom+7ccg342jeXJ20OcgAiYJzIsDT1vgRuqxvEcBKZ9Luqx+6jjucD60k6PuSWmnlFbspHA28iwIZ7LZHHUphhKGe+cGR/LLi/vWXwybvVHqRiYBdqI0rWsq0ptTqXZmAl7uW/v/ggYF//3UcFBNg2YhObv1o8J/oFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NX1/GIS+; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NX1/GIS+"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-848593533cbso1228477b3a.3
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 02:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785402135; x=1786006935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2nznSY9JJdaXURervFAHNSIkzxfbF08nZ/1yUlKod9U=;
        b=NX1/GIS+D8NPxnH5WEAY7ulKY6AKBfK8f3kYRsCtV0DwBHvNOjWWWfhtN+gKQ4yIDt
         Z+zU8tBHy6CC5VXnP6duB10uuQ+ajzCTSN0oA4t9CzmcIKfUi9Mxpc3+fnZBhXbA3dHX
         H0rUq0puhK1AYWyYUJoRl24kbK2TSabUaMe84tJ9AVkSpjrik18gBquEI1k+IcRAmmSP
         p4vty3hZqZT1HrAJzgbHoKWode3AFo/xQWkDPN0mWcAq6A+hPOpZyy9rq4jHH43S3NPD
         8DB6ZUBQeRvYq2A1R1xoLhyjjQhU+DFjk00MptHW2j05JRaoAHYfJn7U5n4cbrqn5ZoF
         yGiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785402135; x=1786006935;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2nznSY9JJdaXURervFAHNSIkzxfbF08nZ/1yUlKod9U=;
        b=ZQRPj6lrBWZneIQBAEGHJWSqKF73OBHqkydaM0gIlzpWBnlNUDREX7Imr26BlOv1YJ
         UfrPo1q5gMtiLjfMa9M63jBqLeLaqMSP3Sow9Hy+h0x6i9dlOyTe7AAqAJPSUC1Ezi4d
         oq8q49tvTizpjSigVsd8Dr56M9b4DrB/wlNjkLgstwuUYXM9Bgbo99g4ZkPLszew1iqz
         snmgFlKc0ynRtbQv79QJ4mNeytvlXRao6DZFmyM3aOFdDmAuoE0L+Aab+hZiG0UfYiqa
         u2yjhD1snHGPBZqXYI9+CDkp90w63BRIa5UXmOKZmFCrmglD7y/Tn/OqTchCNz73AkBo
         giEw==
X-Gm-Message-State: AOJu0YwVgwP8revs0b1QRYs3oe69Vqxxxq0p0GpVkDHCDz5u+cwjLJYL
	mq6vbBopiS077JaJtPtL4XB/8ypG9CXovDqdNxKjFlVkH8NEh9kx2jplbCPfTdqAepo/WD9F
X-Gm-Gg: AR+sD10DD8bcqyURZoon5yCm57voCz4pibcPrVda8GGTzC+nOUDMuE28hH+U857W/ip
	G1szGY78ND2CCeoNlEuIHktxG2Cd82mTm5Hgb8fH61F8wazOmjgxSIDDKUHC778N40Vms5nQBCq
	eT5KPZTxbpzWWpSmcya28pJdCkZC3iN4HPMD1nAV5JO3+RVJIF7XjaP7JogyfgrAdxtv0eQLq0j
	DfmId9k2uPWu8u0X+BJ5Vg1C+L/hS3qEp80WlE6Ym43jqkjbPov4Osht3QOzy8H0srt5fDg+m8p
	yZ5eDIGNPwTKYMGhiBWy+gA/vTPkNApwMNcItoKhz7MEf8b39lgHA7Xde3iFzT384zkxEJqPacJ
	pGI7JtIqUQebuLmid6GJJ8EY3RLxu6OkO6LPWsCFsW3dhmeIabL79ztdpbNvzL9FcBnedwbud6x
	sKub8mEuhHWVuAkXoxsm4SroLKH5+1sx2sipU16qcadi8km7ZHL/sMLXcMTE0FV2Pm1UojucwRH
	7Hbt5ON6qFGqXOfM09pw8hvPw==
X-Received: by 2002:a05:6a00:a15:b0:848:6b76:592f with SMTP id d2e1a72fcca58-84ebc1eb894mr1674847b3a.5.1785402134967;
        Thu, 30 Jul 2026 02:02:14 -0700 (PDT)
Received: from JUNVYYANG-MC1.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea0375d6csm2743552b3a.43.2026.07.30.02.02.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 Jul 2026 02:02:14 -0700 (PDT)
From: Jun Yang <juny24602@gmail.com>
To: netdev@vger.kernel.org
Cc: Jun Yang <junvyyang@tencent.com>,
	stable@kernel.org,
	TencentOS Corvus AI <corvus@tencent.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Vlad Yasevich <vladislav.yasevich@hp.com>,
	linux-sctp@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] sctp: bound the auth_chunks copy length in SCTP_LOCAL_AUTH_CHUNKS
Date: Thu, 30 Jul 2026 17:01:47 +0800
Message-ID: <20260730090149.24040-1-juny24602@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jun Yang <junvyyang@tencent.com>

sctp_getsockopt_local_auth_chunks() copies ntohs(length) -
sizeof(paramhdr) bytes out of ch->chunks without bounding the count.
For an association ch is the fixed-size asoc->c.auth_chunks[] array
(sizeof(struct sctp_paramhdr) + SCTP_AUTH_MAX_CHUNKS bytes), whose length
field is restored from the received state cookie by sctp_unpack_cookie()
and is not validated against the array size.  A cookie carrying an
oversized length makes copy_to_user() read past the array (out-of-bounds
read).

Bound the chunk count to SCTP_AUTH_MAX_CHUNKS before the copy.  That is
the most valid chunk bytes either source can hold, so legitimate output
is unchanged, and it also covers a stored length smaller than the
parameter header, which would otherwise underflow.

Fixes: 65b07e5d0d09 ("[SCTP]: API updates to suport SCTP-AUTH extensions.")
Cc: stable@kernel.org
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Signed-off-by: Jun Yang <junvyyang@tencent.com>
---
 net/sctp/socket.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 9a6da4e0d741..3e9dacb772a0 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -7109,6 +7109,12 @@ static int sctp_getsockopt_local_auth_chunks(struct sock *sk, int len,
 		goto num;
 
 	num_chunks = ntohs(ch->param_hdr.length) - sizeof(struct sctp_paramhdr);
+	/* asoc->c.auth_chunks[] holds at most SCTP_AUTH_MAX_CHUNKS bytes but its
+	 * length is restored from the state cookie and is not bounded here;
+	 * clamp so an oversized length cannot read past the array.
+	 */
+	if (num_chunks > SCTP_AUTH_MAX_CHUNKS)
+		num_chunks = SCTP_AUTH_MAX_CHUNKS;
 	if (len < sizeof(struct sctp_authchunks) + num_chunks)
 		return -EINVAL;
 
-- 
2.55.0

