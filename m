Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794513650;
	b=BVoGJYtpSdPN8H/DdP+lFqsv22yp3xBfugFrIFjXP5ulzVk6i5yCd6mg4mBj6ZbBchca
	 i3lI8OkKBZ3qSUJ57OkXLfX83l8y0wz5AEoYa+AM5cmU0wERSKIpkASADe2DKgPcvntqT
	 jR6JJo3GLyxwNAkVbqEeLDvGVFEuJ+aIOISePH4GP7ufNQ2TANblgJRYFxxF4efq2RSAA
	 y3CXw00xbQFHSdSEMCyUISgWTC8FC+hWY4rfZzxJmyxK4iBiHa+vE4Ttj48qMupa5z1KR
	 D4O7FOhx30UYFLS07LVfQPtQDJGAf1f/CYsmxsE+beXZ+InwPGbwM3r8gFYIZlbzdsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794513650;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=UqJ1UZJImrnjV82Sxx/gHnjsXofKa5flLX/yxWE4r7Q=;
	b=bBH+p2kqKgC6tBWK1+QUlBmtlJjesI2IjKEo/8ux1f3Fi2Z4I+f+GjfgjaIxizfyhbnH
	 5fKaTbfUBAct9WsfBfbZoFdwVrZ6Tjyl3wq0XdsBSUXylULds8PswlIq2UrPTyZpmlLCP
	 Rc4hG41RZki3NH55LnsomVBjj5cLL23zm7LKLzPQKTHBF2nabKxj3T12DzftNt+ypNinF
	 sLyyO6B7lV7gl3yorzo2obOZdKwxAmaUjYV2+Hihz6wgloGWWgEuZnRLVsiZuwvaJNXf1
	 HYO60yMzNnZg80Dle7TWoVZFYKY5JVAfkCrlcEjM2uPZqt/a8c5t8n+yt8/UiKzjLHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=o5yZfNOS;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBECF606A321
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 20:00:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBECF606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=o5yZfNOS
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3ac9f49b984so116495a91.1
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 12:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794513649; x=1795118449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UqJ1UZJImrnjV82Sxx/gHnjsXofKa5flLX/yxWE4r7Q=;
        b=o5yZfNOSp1hwed46uC5BB9D7U8CxCOtlroJmvZ7S8L5JmYLSUVRr6x6QBOWpjHydmN
         wHk89+AgtAOIjYdNuXB934DPWNNh0NWu4Ufa5XpVpJasXT8G3JbPTQJY/kTxa+G9UcWR
         h59DSgtRHvAPF2rpF+BMPn04OZJG/lG6xq3jdFq1TQbeIyOmvIZCfDyzWLvMDuXH9ZhZ
         xzGIuEyKLcaouHjltqJZ+jGb8/kOs/FnhdppaFaxTruP4hgfYUZx0wLZwHSalg8qkM4k
         o3ddyLPYy4RdlUiPjCJsre/+BMK5d84eRexjzcOkAwN3zoUYXrHH6wk5pHf35Hqp4+cl
         ZAhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794513649; x=1795118449;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UqJ1UZJImrnjV82Sxx/gHnjsXofKa5flLX/yxWE4r7Q=;
        b=UeedzwLN8JDhmiDMJJIUeUVDrORLtL4myjFkrYOzOxzg/w+lm3ihY22061V9x2pmny
         cmVGWiZSsOFkYZaYjDAS7fv/V6sUE6XqugSZblCJ3PJ+6WP2kVDVqO0I1ycZqJQvzokm
         2NRrJztjjFv6W/I8cvWnVUTB/xMp3R5bge5s1Gc7OM4Y1oCFg/RpQc7Fr7X+GJlC5dDu
         tum7D+p+dPxZ/HLWfgp5Ktmq/So3vq9aPkV9W9nJFLTgp1cDZolnQ9i5E/t1uvT9sBDZ
         1rom1LjZU7o+lj0YatVVv0bg9oDVPTrMVFmvPP/S2pE7FLWGJf0vYdjeMJJsHmB+GE94
         V8VQ==
X-Gm-Message-State: APuU4Z+L2MIrNgQXKr4cHNcbvPthHXqku0yKGOEDFkRnghWznA0xZzh5
	HhDJBSa3oLUJwOZAnDfilYkFqNZqwTlt8ilKzegDlJF7BdhhOsGzg0aeaMzaGrpMPBrOubIaJE6
	U4wDX
X-Gm-Gg: AYBFou0E6BHYSXjHpgWI82aTJECPqK/anhfNryt7zCfQ4rmn7mKlYoQy3Z7WHaAEb4j
	wShDKcYu+kgFPHn1suYDfYZeJTpF0B8H+iDonJSkz7p4vgFhrxvDkxGrawY5sWWGVrEfrJ7lDfW
	vuuizKPJFEdYtT7FY2FxKqO8EoY0jAFFqtJsKewOosvWy1tjpeoFS5hR4rno+F40Lt1sN+MNKi0
	y9wy+TCU3gtMvhV4H0fSA2LzHUiooxMire3wY4RMVODeQ+8DJyb5ENu8v2H7MqDtWxNsLxjUNGq
	d1HmqxnCqOgg9016fYWgfPduUP+aL5hts1HdZASju1sM5ouZrfdvoLbFHbnwqumoxeX4o3IZr3k
	WWOQJUOTgj7qODUjX2o9/zYtG92rWoVP0wwkigtZOPa9X1ZjsOlJxZx/JUosNSO/XfhyMFnnej+
	guENxgowfyihZzVsLQYrm6LP2+d8eEq1KvDsLzV2RRcEhRiBbNscK+/Sh7XnS+qkx55eFatlZMg
	wvUh/P3CYB9K1b1VhVJUgqCfMSapSdoOHZymFETi3CipN/I+3jgJAS7W50MuUfdEGWESuahUL5a
	TMala3Pkzxir1pEVYh5qJJk73Ml5pz73EZFDIHsflD8O+nEjTSslxxE5/+pqbgQ/MCgq198=
X-Received: by 2002:a17:90b:4c8b:b0:3ac:9ed8:f30e with SMTP id 98e67ed59e1d1-3b1b0d07d05mr68262a91.35.1794513648631;
        Thu, 12 Nov 2026 12:00:48 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d27d26sm5967123a91.13.2026.11.12.12.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 12:00:48 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 00/11] ss fixes from an OSS scan
Date: Thu, 12 Nov 2026 11:59:13 -0800
Message-ID: <20261112200046.2164391-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

Fixes for the ss findings of scan iproute2-20261015-004, plus bugs
found while confirming them.

The biggest change is removing the fallback /proc parsing.
It was buggy and fixing it is not worth bothering.
Every family ss lists that way has had sock_diag support since well before
the oldest supported LTS kernel, and the parsers were untested and
trusted file contents that an unprivileged user can partly control.
A kernel built without netlink socket diagnostics now gets an error
instead of a silent fallback.

The rest escape names chosen by whoever owns the socket, bound state
and type values from the kernel before indexing name tables, stop
treating a netlink port id as the owner's pid, and size the
TCPDIAG_FILE read buffer to the record while rejecting lengths the
parser cannot use.

Stephen Hemminger (11):
  ss: fix double close on sock_diag send failure
  ss: drop /proc fallback for socket listing
  ss: escape names chosen by the socket owner
  ss: size the TCPDIAG_FILE buffer to the record
  ss: replay all dumps in TCPDIAG_FILE
  ss: bound state and type name lookups
  ss: fix rpcbind service cache
  ss: read socket SELinux context only for -z
  ss: check owner before naming a netlink socket
  ss: keep following events after ENOBUFS
  ss: report a failed SCTP or MPTCP dump

 lib/escape.c                  |   7 +-
 man/man8/ss.8                 |   3 +-
 misc/ss.c                     | 884 +++++++++-------------------------
 testsuite/tests/ss/ssfilter.t |  26 +-
 4 files changed, 249 insertions(+), 671 deletions(-)

-- 
2.53.0

