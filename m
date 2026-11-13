Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.71.1.221
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794573152;
	b=CnFizJ+/ROvCM/S2/IxZFOd/sK1ZNvWDVEokjsGkep+wcjIjdEvx4/eZkXKqdAVTc0MB
	 +2w85izNiMskNQsylhSfyAIpzEYI0gCFiKk12eeIAcYtZd3WNrWMecCx/iKANrtAnikY3
	 sF7M8OwOiwlurSiLEdQ3UvE+oR1c67L7y7nS0LFPC18Z+NHJHNjeqA5d/c+3krx4oGmse
	 61vk3vMP/eGLHyVs0zrjvwjvT3XNY+56n58VKfaCTX1wUb1+EQ1rZBWHdUBLWLSpVRjTT
	 wgugztqo7bIPGdxZmyTRWioclaokjj9Vw50rNQZWZK391Ij9WkMH2o/xw8lBIk/AFdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794573152;
	h=DMARC-Filter:Received:X-Barracuda-Envelope-From:
	 X-Barracuda-Effective-Source-IP:X-Barracuda-Apparent-Source-IP:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:X-ASG-Orig-Subj:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Barracuda-Connect:X-Barracuda-Start-Time:X-Barracuda-Encrypted:
	 X-Barracuda-URL:X-Virus-Scanned:X-Barracuda-Scan-Msg-Size:
	 X-Barracuda-BRTS-Status:X-ASG-Debug-ID:X-Barracuda-Spam-Score:
	 X-Barracuda-Spam-Status:X-Barracuda-Spam-Report;
	bh=VK5RuRX23ZpFv9qmAcCmV9k4TH+e6VSSTIscegMjfrA=;
	b=t2al6G3Au41phXkg+XMD5cZxivbuLwSWfUK+6kY9jLjC7+M3XPZ8ESDwvhCvQaIYT1JQ
	 qstUne8YCtCHaoLH84NnAHZngvxhSOpQbyex857GVZIN2dIiSecu7c9qnGxe8H0tB1/bx
	 ex2M5Y0aEVyYRhI5srfHe86Z3WzpBXqEbHeBsNn+q+fQWUY6KOHvlJQ1ClPK0dNRonH5/
	 lSBsNOJnmGiMraXdSNMFQdAZcC/t0eiPRMexGjY4H5wqVwB93AuQ9V5pPHtfa+JCJsjZ8
	 wOvZ7+JBc/6nEQ1eOGAJc/T4cnI7Et4q7JZfz6U361uvXUIwxcG7M0ifAAmDWbJuFdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=vandijck-laurijssen.be;
	spf=pass smtp.mailfrom=vandijck-laurijssen.be;
	dkim=pass header.d=vandijck-laurijssen.be header.i=@vandijck-laurijssen.be header.a=rsa-sha256 header.s=default header.b=RcQ5fL0Z;
	arc=none smtp.remote-ip=212.71.1.221
Received: from relay-b01.edpnet.be (relay-b01.edpnet.be [212.71.1.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F94606A31C
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 12:32:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5F94606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vandijck-laurijssen.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vandijck-laurijssen.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vandijck-laurijssen.be header.i=@vandijck-laurijssen.be header.a=rsa-sha256 header.s=default header.b=RcQ5fL0Z
Received: from srv21.vandijck-laurijssen.be ([213.219.153.140]) by relay-b01.edpnet.be with ESMTP id euhTsssqA8x61gNu (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO) for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 13:32:22 +0100 (CET)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: UNKNOWN[213.219.153.140]
X-Barracuda-Apparent-Source-IP: 213.219.153.140
Received: from fwg.vandijck-laurijssen.be (fwg.vandijck-laurijssen.be [IPv6:fd01::dab3:2fff:febd:d001])
	by srv21.vandijck-laurijssen.be (Postfix) with ESMTPSA id 24B89B2216E;
	Fri, 13 Nov 2026 13:32:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=vandijck-laurijssen.be; s=default; t=1794573142;
	bh=W0BZtYH1XY8kUr2sb2jp2f0V6FGv7gUbZRZxV6b8Y0g=;
	h=From:To:Cc:Subject:Date:From;
	b=RcQ5fL0Z8h9VuvSExUCV0WDcQPqimxB6Mp3zw+2SWIquJtQ/B1eyrGwXABaQ5ppoa
	 EiH/oMV++943yddj3vq+c0IvjhmL28Y5tzo/SMPag/f7AHPyK0TvEaDM/PJrLir9Gs
	 S767cu49V7UScuEpzWRZy8h8ZBqqPNTCw0Cbj7G/3fVe4wpCh4jtlJFqrhoRWWVO/5
	 p6AP754APlYPN6CVlfsj+ZapAjxA1lNljJYyVwPi0U0TmzfNiQe5KQqPO43xc7a4Vf
	 8VqZ9Lqhc0++bHxHtwPMZbkCpYJQx7ZeviH3IJqkw0zk87rPNok5cJoyf5wqAkl6qO
	 IvBMqOOtYPPIQ==
From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To: netdev@vger.kernel.org
Cc: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: [PATCH 1/2] ip address: allow labeled proto arguments
Date: Fri, 13 Nov 2026 13:31:59 +0100
X-ASG-Orig-Subj: [PATCH 1/2] ip address: allow labeled proto arguments
Message-ID: <20261113123200.17784-1-dev.kurt@vandijck-laurijssen.be>
X-Mailer: git-send-email 2.55.0
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
X-Barracuda-Connect: UNKNOWN[213.219.153.140]
X-Barracuda-Start-Time: 1794573142
X-Barracuda-Encrypted: TLS_AES_256_GCM_SHA384
X-Barracuda-URL: https://212.71.1.221:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 603
X-Barracuda-BRTS-Status: 1
X-ASG-Debug-ID: 1794573142-2392346792a6e60001-BZBGGp
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=10.0 QUARANTINE_LEVEL=10.0 KILL_LEVEL=7.0 test= 
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.125474
	Rule breakdown below
	  pts rule name              description
	 ---- ---------------------- --------------------------------------------------
	

Signed-off-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
---
 ip/ipaddress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ip/ipaddress.c b/ip/ipaddress.c
index ff85792f..e9d9c2e5 100644
--- a/ip/ipaddress.c
+++ b/ip/ipaddress.c
@@ -2231,7 +2231,7 @@ static int ipaddr_list_flush_or_save(int argc, char **argv, int action)
 			__u8 proto;
 
 			NEXT_ARG();
-			if (get_u8(&proto, *argv, 0))
+			if (rtnl_addrprot_a2n(&proto, *argv))
 				invarg("\"proto\" value is invalid\n", *argv);
 			filter.have_proto = true;
 			filter.proto = proto;
-- 
2.55.0

