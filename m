Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.59.229
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794211420;
	b=mZOs6lbJkpKGSQtvXHE33mgjr0RH2Dl95sfSjwv2PTHbDO/0f23x67Puh5kNzFohPiSK
	 HQL8EmpXwSqIVMyzxuurno5mrir/NYVDQaP2hQ35cvs9xQxBDuIZHeDpKC4B/xhoKSJNq
	 GmxC5x8SFHgQ+JgxGYKMUSDmw2E/+brQg3mpyYcdfal8rFgtIJOK/MBNpw+8AiAG6RYE6
	 lpA/6tSxdRpIMPn1f/iK8Rip4TDBFK357WN06ki27rRwx0II93DFhNnKV+At9vtm0jy5x
	 RKW2SHBIDkp4rMkGHbhPQnh/4tlC6+Dvg88nIyTA63GRKV5btlwnb/JC5AaOtUH8uOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794211420;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=v6KKqToKGo8Bq+7uS18iytYt/WCdZocHopxHXD1VQ/Q=;
	b=P+JKfMxCtEu+gqaRBmXrig0vHlpZ914UTdFRmj+4X53ieNj77809/1a6okV7jG2sOU9H
	 QVx6b8OkQT7mh9cZbEBVDokVQhbh1UEwgHIpMti4hN03NVMfmvYl3/m66Q79RsN5Pi8V/
	 8mKXitMU3/SLiV1KvjhWU3l0wsyaXiJ59aWjDgJfJ0AphNejzCYWRtEeaoS+MN9zg5IA0
	 Y2eNaiouxCIjPEF2nADs/6kWfJZHocH3EdainEHiWiIaPTvsSEUUAjYueeGEGcUscIpio
	 9O1OzDWrAOOjj0RBFpSDJYdydm1g02rbk37OR1qrJFrBClMC6yaZaY6QDDEKsnTSzzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=1wt.eu;
	spf=pass smtp.mailfrom=1wt.eu;
	dkim=pass header.d=1wt.eu header.i=@1wt.eu header.a=rsa-sha256 header.s=mail header.b=paLTLiV4;
	arc=none smtp.remote-ip=51.159.59.229
Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13E1606EE8B;
	Mon,  9 Nov 2026 08:03:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B13E1606EE8B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.a=rsa-sha256 header.s=mail header.b=paLTLiV4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1794211414; bh=v6KKqToKGo8Bq+7uS18iytYt/WCdZocHopxHXD1VQ/Q=;
	h=From:Message-ID:From;
	b=paLTLiV4FtQ3E7jkombjeDgJVx4QG+UMFQSW4ikzO0Q18HtZR1ETPyQ7QbjSP2h6z
	 3UlPflO/L+aZPMqPjKjlruhzJd48L+S5GyjsprFeSOHkDHicHmIT/t93fJt7xCq57h
	 j/ZJEhGE17JS4lDqNMIb20/m5t/FTS6RzLa4BdQY=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id 3D2E9C095F;
	Mon, 09 Nov 2026 09:03:34 +0100 (CET)
From: Willy Tarreau <w@1wt.eu>
To: Jonathan Corbet <corbet@lwn.net>
Cc: skhan@linuxfoundation.org, Randy Dunlap <rdunlap@infradead.org>,
        workflows@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        gregkh@linuxfoundation.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH 08/14] docs: security-bugs: explain what to do when a report gets no response
Date: Mon,  9 Nov 2026 09:02:34 +0100
Message-ID: <20261109080240.29444-9-w@1wt.eu>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261109080240.29444-1-w@1wt.eu>
References: <20261109080240.29444-1-w@1wt.eu>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some reports get lost, especially those with attachments or HTML, and
reporters sometimes wait for weeks for a response that will never come.
Since reports are private, the reporter has no other way to know if the
report was delivered than asking. The doc only mentioned resending a
message with no response within a week, in the middle of the rules
about copying the security team.

Let's explain it in "After sending the report": wait for a week, since
some maintainers are overloaded or only work in their spare time, then
resend the report with the security team in Cc. Also suggest to drop
any attachment and double-check the output format.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 Documentation/process/security-bugs.rst | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/Documentation/process/security-bugs.rst b/Documentation/process/security-bugs.rst
index 6f5b5e492ed3d..11c385630855e 100644
--- a/Documentation/process/security-bugs.rst
+++ b/Documentation/process/security-bugs.rst
@@ -275,9 +275,7 @@ security team in any of the following cases:
     this impact, and you will need to share any information you have;
 
   * you are seeking specific help, such as when resending a message which got
-    no response within a week (and please do not ask for feedback before such
-    a delay, some subsystems have a long report queue, and some maintainers can
-    only read them on spare time).
+    no response within a week (see "After sending the report").
 
 In other cases, i.e. when a report of clear impact is sent to a larger
 team of clearly identified maintainers, it is not necessary to Cc: the
@@ -385,6 +383,19 @@ run additional tests.  Reports where the reporter does not respond promptly
 or cannot effectively discuss their findings may be abandoned if the
 communication does not quickly improve.
 
+Messages sometimes get lost, especially those containing attachments or HTML.
+Since the report is private, you have no other way to know whether it was
+delivered than to ask. However, some subsystems have a long report queue, some
+maintainers are overloaded or only work in their spare time, so please wait for
+a week without any response before resending your report with the security team
+in Cc: (see above). In this case, be clear about the fact that it is a resend,
+and if possible, provide a reference to the original message. Better double
+check that the message is sent in plain text, and drop any attachment when
+resending, to increase the chances of successful delivery. In any case, please
+do not ask for proper receipt before this delay. This will not make your report
+be processed faster, will add extra load on maintainers and all you risk is
+your future messages being ignored.
+
 Disclosure and embargoed information
 ------------------------------------
 
-- 
2.52.0

