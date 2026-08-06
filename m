Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28E83A6B6F
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 15:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786029432; cv=none; b=pwZJk4941GWUfZV5Q7PQWF95IGokX0UyRfrLQCZlJtnTHeZfmbMQqm/PefooFJ8Ure1wbHdZyinwt+PoDJsxaG24ImM0pfAIcCxnD3UOm6eDI7PF6yfiEmh6gNCw2dT8XN13cAezYs0WGvb00dDv/tIxwmpbFD5yIF54nyo+I48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786029432; c=relaxed/simple;
	bh=A8IYp+WDBc4rHKZWEDslyqjqd0kvXWVBGZp7ZdQ5v+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TshwbFT00oikfY4fQumKoSxXLtFhrhHrvoBwn8DkWzdvNT5d2xf7DHxP/TE+DmFJPWGH0ZlqyB4Kfl1Pso+2E1WCaTSfu3puqzMjD7xDeIfRmXXLYpDJX/daRbQx6vFN4cgjLEgESVmrpddc7qCOSg34TuK1dSTXRnZYD3wfpiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hlaNPimo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hlaNPimo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786029429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vum/2/17v7wUDHYG+zqyg62gHOPYRpIv37Oqr+QwlSg=;
	b=hlaNPimo4OZq7AgDTYVYQ1ZVxaCe9VlyjkLizrqbMzrJwtbLXiUqh/IuDNLRczc2ZPvwKg
	mfWmWTnjjlLsAOQY/0HG66EqjheMsbio221uuW2n8K1nWMhRY2B9usHSbVqMhCvYDvzJYn
	38ZRCas2zwp1iLAaCXVVK0MeyAN92Ss=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-478-rZd4QpmiN-Wdks1TULKlrQ-1; Thu,
 06 Aug 2026 11:16:54 -0400
X-MC-Unique: rZd4QpmiN-Wdks1TULKlrQ-1
X-Mimecast-MFC-AGG-ID: rZd4QpmiN-Wdks1TULKlrQ_1786029412
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 47872180049D;
	Thu,  6 Aug 2026 15:16:52 +0000 (UTC)
Received: from bgrech-thinkpadp1gen3.rmtustx.csb (unknown [10.2.16.127])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 167881956094;
	Thu,  6 Aug 2026 15:16:49 +0000 (UTC)
From: Brian Grech <bgrech@redhat.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org
Cc: horms@kernel.org,
	sjpark@amazon.de,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Brian Grech <bgrech@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH net v3] selftests/net: fin_ack_lat: fix latency threshold typo
Date: Thu,  6 Aug 2026 10:16:45 -0500
Message-ID: <20260806151645.4172900-1-bgrech@redhat.com>
In-Reply-To: <20260804220108.1630366-1-bgrech@redhat.com>
References: <20260804220108.1630366-1-bgrech@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The commit message for af8c8a450bf4 ("selftests: net: Add FIN_ACK
processing order related latency spike test") states: "if the latency
is larger than 1 second (spike), print a message". However the code
uses a threshold of 100000 us (100 ms), not 1000000 us (1 s).

The lower threshold causes false positives on slower hardware where
normal connection latency occasionally exceeds 100 ms but never
approaches the 1 s spike that indicates the actual FIN/ACK race bug.

Fix the threshold to match the documented intent.

Fixes: af8c8a450bf4 ("selftests: net: Add FIN_ACK processing order related latency spike test")
Cc: stable@vger.kernel.org
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Brian Grech <bgrech@redhat.com>
---
v3: Added Fixes tag, referenced original commit message wording per reviewer feedback
v2: Added missing maintainer CCs

 tools/testing/selftests/net/fin_ack_lat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/fin_ack_lat.c b/tools/testing/selftests/net/fin_ack_lat.c
index 70187494b57a..4117332eb1a9 100644
--- a/tools/testing/selftests/net/fin_ack_lat.c
+++ b/tools/testing/selftests/net/fin_ack_lat.c
@@ -69,7 +69,7 @@ static void client(int port)
 		lat = timediff(start, end);
 		sum_lat += lat;
 		nr_lat++;
-		if (lat < 100000)
+		if (lat < 1000000)
 			goto close;
 
 		if (getsockname(sock, (struct sockaddr *)&laddr, &len) == -1)
-- 
2.55.0

