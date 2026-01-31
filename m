Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8FD2F3C02
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 19:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769887067; cv=none; b=PteyO6Tg/An/VHqSwMmqweOhbBLtJL44w5EXeirjHP/gtrDiYHfrX+P9u7eWXkjVQNlOBtcBfzJWGC70ejyyptZ+qaTJ/g2ugNI4s6eW8EKjDXFMQO1n0gDSMq1cm3HgAv0OXiswLHtOOMS+sV7aBvCnvqEO72r+9ZAvgM9/FPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769887067; c=relaxed/simple;
	bh=xYbgmt55asvWoQ51zDF+uSwxbldhUytYpyhc+Tlkee8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B+SCSvhLQGASarYlhmDm4i4JNC0tUCaf0flbOgGTHBOOQhP0EbwQuAfVSkgAgkAOecCRhDZztzD1xF1XLeOjF4fmlf4UTOFZ0h3OcPW1kff02iDeepGFWKu7R03jCpgi8v3IUHJcbQBLeRyd61ENu0quAP2HhFwmTDLPV/k6ook=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gb8cKpzn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gb8cKpzn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F3E1C4CEF1;
	Sat, 31 Jan 2026 19:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769887066;
	bh=xYbgmt55asvWoQ51zDF+uSwxbldhUytYpyhc+Tlkee8=;
	h=From:To:Cc:Subject:Date:From;
	b=Gb8cKpznG1bVPVKVy0hZn8obLBhznrSqwuo9qtCNm8HGNraWr79Q8DZqgtiI5LtCw
	 H2nw/5ooTttyKhHC23ZouSB4+nZTppr84VFPYcnIVBHAoKGM+08xebFn5Et/hd1cmM
	 vX/xPfBG9EOajQoY6FYKbg5v8mDBCkjll2upgeOY3PbAe4UMkxyYNu6D3BE80WDCtt
	 4RCnKmx91vnE+vnpDJn7YWSl6sGXwCJfQMgohRcTXddEQ5vJiQxpAZRv5ls0PkA+8G
	 5xmDK6pP5L51zgFR5IAhC35jUZN2MOUZunxfPbeOm+uXWY7NDVi4Oz5BdJUxIGLCnn
	 rR8dO+BfEz1Nw==
From: David Ahern <dsahern@kernel.org>
To: stephen@networkplumber.org
Cc: netdev@vger.kernel.org,
	David Ahern <dsahern@kernel.org>
Subject: [PATCH iproute2] man: Fix spelling in tipc-link man page
Date: Sat, 31 Jan 2026 12:17:40 -0700
Message-ID: <20260131191741.32416-1-dsahern@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: David Ahern <dsahern@kernel.org>
---
 man/man8/tipc-link.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/man/man8/tipc-link.8 b/man/man8/tipc-link.8
index ac6c7a2b..bf11a179 100644
--- a/man/man8/tipc-link.8
+++ b/man/man8/tipc-link.8
@@ -208,7 +208,7 @@ packets in the intervals
 .sp
 
 .B nacks
-- Number of negative acknowledgement (NACK) packets sent and received by the
+- Number of negative acknowledgment (NACK) packets sent and received by the
 link
 .sp
 
-- 
2.43.0

