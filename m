Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.71.1.220
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794573155;
	b=QR4Bow7hujbi2lvLJE5rK4kCk0bzJNq3ndYevgKj01DlizzINsLd4uh/0H3xywPp15M6
	 h5hT0GYngOZhIwFVhzEzqiPfkwbMRQ30w6A1DvR9KyG4gWLZ1LHPtPvwQxjQjcFaD5gCJ
	 ppGNRoBUrfJ0JDOCLxYcNCYXQI3I564zlOUdbuROtqXXwqf0gH1jwZvFd7gxANjGBMhsX
	 T6NiT5k2GiYCBQPmIGgHZgm8ObsNFx5QKAkH2YJUjvnLKpWXNz3ZYLRdLAEycTInFRwcL
	 oX7CtpG5m9SngcgK6clZ6fVa7hy6Oa+7genZpBgsRFVk6DKZ5Ct5XD3CnIhx9k5FaLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794573155;
	h=DMARC-Filter:Received:X-Barracuda-Envelope-From:
	 X-Barracuda-Effective-Source-IP:X-Barracuda-Apparent-Source-IP:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:X-ASG-Orig-Subj:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Barracuda-Connect:X-Barracuda-Start-Time:
	 X-Barracuda-Encrypted:X-Barracuda-URL:X-Virus-Scanned:
	 X-Barracuda-Scan-Msg-Size:X-Barracuda-BRTS-Status:X-ASG-Debug-ID:
	 X-Barracuda-Spam-Score:X-Barracuda-Spam-Status:
	 X-Barracuda-Spam-Report;
	bh=fTObSstseTAkYID/0/JZqlfNrdA5Jxa0Vj8Hrik0+jY=;
	b=LEO/sbEG5ufjHd9hWdrjwWhJh2hWOdiHlxX1dr2so00MVCU6PJIW6ftbWiXBb5fmwOf0
	 4hDb6SEk097iGwUDQ5iiLmv2dWHdYmAST2Lc/2Sncl+cXyW6Rx7XG8slUXCgMJjmgNe94
	 mBWeUD1geDYtYPpJO/j0fkfhtMf+Tr4m+w26J4U/9q9WQrscWvDZNtW/i/RpXQ+8uJrSr
	 fR8C3XTSbMHI5ULAFgbVo77IkRVRAdDHxQhfoJyzKCUUbn3Sp3d1wjTIPECt743yZ9fLb
	 fhHGgmQoqTUNiLh3gA3MwWL/87upptuFptvQbwtQe0KSrEOz/60h6kiu9fZnutqLgXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=vandijck-laurijssen.be;
	spf=pass smtp.mailfrom=vandijck-laurijssen.be;
	dkim=pass header.d=vandijck-laurijssen.be header.i=@vandijck-laurijssen.be header.a=rsa-sha256 header.s=default header.b=agICvhWd;
	arc=none smtp.remote-ip=212.71.1.220
Received: from relay-b03.edpnet.be (relay-b03.edpnet.be [212.71.1.220])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885FD606A31C
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 12:32:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 885FD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vandijck-laurijssen.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vandijck-laurijssen.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vandijck-laurijssen.be header.i=@vandijck-laurijssen.be header.a=rsa-sha256 header.s=default header.b=agICvhWd
Received: from srv21.vandijck-laurijssen.be ([213.219.153.140]) by relay-b03.edpnet.be with ESMTP id JP7kYEYFkJC2TD3Q (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO) for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 13:32:27 +0100 (CET)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: UNKNOWN[213.219.153.140]
X-Barracuda-Apparent-Source-IP: 213.219.153.140
Received: from fwg.vandijck-laurijssen.be (fwg.vandijck-laurijssen.be [IPv6:fd01::dab3:2fff:febd:d001])
	by srv21.vandijck-laurijssen.be (Postfix) with ESMTPSA id D6E85B22171;
	Fri, 13 Nov 2026 13:32:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=vandijck-laurijssen.be; s=default; t=1794573146;
	bh=H7j/vbq6rAbi4s4b+GnbkZcrAybx9bFxGTyqcrFinAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=agICvhWdR8xNuPMmepPMAamqlF4hPPctkj8hjiOvCAkjS+7F5xJXXFw9soR2JHwQi
	 tPV5kZsGrQkAjVjuYs3dKWWYAUpDu9rqndXpc6bEE3xu+8KJGwnuUWiUGu8ML7l5Qj
	 sh+P4I6ixLjo9rpfB8sBgVL7ARjgxEBWCovKv/73d/qFoF1cXFKEP7CuxMukIl2oqs
	 trS8elGiES9yOIo1Tdp/Eq+WCLgIE6yyTdNhGLz64ia5v7i1+toqUUO3PZOKcDMEdf
	 fXzeMqVDNkanDhNpzp9N1j4+/hU3cyJXCXeqrz9Gf5NKTno3IKZfLnAhR2d1fK49ee
	 xEcTGL5E2JlOA==
From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To: netdev@vger.kernel.org
Cc: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: [PATCH 2/2] ip address: proto filters rejects items wihtout proto
Date: Fri, 13 Nov 2026 13:32:00 +0100
X-ASG-Orig-Subj: [PATCH 2/2] ip address: proto filters rejects items wihtout proto
Message-ID: <20261113123200.17784-2-dev.kurt@vandijck-laurijssen.be>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261113123200.17784-1-dev.kurt@vandijck-laurijssen.be>
References: <20261113123200.17784-1-dev.kurt@vandijck-laurijssen.be>
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
X-Barracuda-Start-Time: 1794573147
X-Barracuda-Encrypted: TLS_AES_256_GCM_SHA384
X-Barracuda-URL: https://212.71.1.220:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 1956
X-Barracuda-BRTS-Status: 1
X-ASG-Debug-ID: 1794573147-382369751fa5a60001-BZBGGp
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=10.0 QUARANTINE_LEVEL=10.0 KILL_LEVEL=7.0 test= 
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.125474
	Rule breakdown below
	  pts rule name              description
	 ---- ---------------------- --------------------------------------------------
	

Signed-off-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
---
 ip/ipaddress.c           | 19 ++++++++++++++++---
 man/man8/ip-address.8.in |  5 +++--
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/ip/ipaddress.c b/ip/ipaddress.c
index e9d9c2e5..4a4a87d9 100644
--- a/ip/ipaddress.c
+++ b/ip/ipaddress.c
@@ -1542,9 +1542,13 @@ int print_addrinfo(struct nlmsghdr *n, void *arg)
 
 	if (filter.family && filter.family != ifa->ifa_family)
 		return 0;
-	if (filter.have_proto && rta_tb[IFA_PROTO] &&
-	    filter.proto != rta_getattr_u8(rta_tb[IFA_PROTO]))
-		return 0;
+	if (filter.have_proto) {
+		__u8 proto = rta_tb[IFA_PROTO] ?
+			rta_getattr_u8(rta_tb[IFA_PROTO]) : IFAPROT_UNSPEC;
+
+		if (filter.proto != proto)
+			return 0;
+	}
 
 	if (ifa_label_match_rta(ifa->ifa_index, rta_tb[IFA_LABEL]))
 		return 0;
@@ -1929,6 +1933,15 @@ static void ipaddr_filter(struct nlmsg_chain *linfo, struct nlmsg_chain *ainfo)
 			if ((filter.flags ^ ifa_flags) & filter.flagmask)
 				continue;
 
+			if (filter.have_proto) {
+				__u8 proto = tb[IFA_PROTO] ?
+					rta_getattr_u8(tb[IFA_PROTO]) :
+					IFAPROT_UNSPEC;
+
+				if (filter.proto != proto)
+					continue;
+			}
+
 			if (ifa_label_match_rta(ifa->ifa_index, tb[IFA_LABEL]))
 				continue;
 
diff --git a/man/man8/ip-address.8.in b/man/man8/ip-address.8.in
index 79942c1a..55cb7e63 100644
--- a/man/man8/ip-address.8.in
+++ b/man/man8/ip-address.8.in
@@ -449,8 +449,9 @@ This is an alias for
 
 .TP
 .BI proto " ADDRPROTO"
-Only show addresses with a given protocol, or those for which the kernel
-response did not include protocol. See the corresponding argument to
+Only show addresses with a given protocol. Addresses for which the kernel
+response did not include protocol are considered to have protocol 0. See the
+corresponding argument to
 .B ip address add
 for details about address protocols.
 
-- 
2.55.0

