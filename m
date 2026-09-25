Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A670E345CCD
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 06:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790316242; cv=none; b=Aqu8vYB/v7sEtRWBBTzyu3Xn8paGfmAduUzMNvetXn2PBabO0v8fVfakrDOUIqJlObjUDULdjpq+ck09P4OuVYpkSX0tGb6x1qs+4lVd4IGgfpK4Zcz3AUsVAkTDfzh9OXcHqIntLVBmZ/HfNL0hZxMjfgJdp4aeVFYFOjS2bIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790316242; c=relaxed/simple;
	bh=0yEq65dm5gu/6cmk1zcVrT/PR9DQuPYk2z+17Qf+ZwE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dGb7rMHhyiI78e6sFHyei6mmeumXfH4GAPAnzYngOMdgWCH3pmMQjlVAdq6yj3bWc4Sq0FgILyDiFiFHCNE53/6SzbLhomI5/z3T+KZBh3I4UR3nwXKcbbX/HcEcGeTxp69oMy9v5xV//MMYrRRno0dZ05dnNVeJaBcQkoS9Gkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YgBb2aYS; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YgBb2aYS"
Received: by mail-pj2-f42.google.com with SMTP id 98e67ed59e1d1-396ccd5cf02so316244a91.3
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 23:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790316241; x=1790921041; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YX0ImicVUeZdVwTA8b7/T6h8EvuFhmwYqGLh6Gs2JEw=;
        b=YgBb2aYSqKL9Ao30ZJTNRAgC75coQxHK7kXXuzw0cE9SYB6rfV/VZ9zyQu2l3HexGP
         /+rwpq6xHxPC+XDtclWaR2YjALTeOxy0J0yUzlx8miC1CBQyAB0PbbfRDhPLxua4io04
         fEfUzGreLCeArcC35aZWlMLBkTFzrRuTJ5Liog47umHwLMYrXVL6P5Cx8jp0FG1mvz1J
         pYDrUf5Mst0cmV9QTaheVi1RrGIMP6gMTMaSHTlijMedqv0V3A4cGiqVRJIMh5h8Gl0C
         vHERhaeQMN/jWuxoKgwKj56vj+BMVM854LuL2hHWDWW2kGhut0LHRXHMIBdkP2zbH/aq
         xTvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790316241; x=1790921041;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YX0ImicVUeZdVwTA8b7/T6h8EvuFhmwYqGLh6Gs2JEw=;
        b=qd4qcUluWOgso2YbFyWJqPiO6NCYL7vV+Ut6Yf+4zkcISdGmnZoN3KnH8vNubrVa6w
         cb4oidJJ0LRAZI9h9fGa6S+PQVmUFgjaG2t5u1mcLgsA6DnknGZFByQiUBc0to5GkX4d
         0am13lTnNvwwmZwDctYTOwbaMyPRyzmz+CyGlvbh/sMHwGQif7dDZVk+93KA/KBSZ25S
         67dya94dHVMUWIdgG3EpApUKdFdtQ+QF+O1sER39YGHR/VQjSs4/eCoFGb1WXMLFBmLb
         RgJkooIPpB5Cwt6HEWX/IXZKy4rY4XwOzOsF61iSNFseu5oQdX6rH9Mhms/qrl+3HE3o
         lsJg==
X-Forwarded-Encrypted: i=1; AKwUvBy+colNqqKLtlN3Y3ImgrYiYoTRsOd46gt3l3+OifGfozctSt2dppisEMuF8odEN7x/UXH9Fig=@vger.kernel.org
X-Gm-Message-State: AFuF++l1fS0Foecbg37PcVvM5lzCIst2/xCFrpDNnH5wiilc30zL6+Gf
	FXkHIVyiKzoNDNDe2wkIIijc7AFgfd5nIPWjBnjwLOxQsjZJptXgujpS98oxg+Lc
X-Gm-Gg: AYBFou07ybIVnA6hXhBsqD94ELYoEhoIhvGy6U4y9rpmV+Ql/tia+HLxzEFW/pk3AzA
	Rw9RWraM/FauWXch9AsfK1tAkESfDRdizM5QCGQ5Gsp3oOXYpOBUPjLqgtp4WpwzMSI0qmO2+4o
	bl9AqGLMGrBi2GxqIZWhbzmi13OVSgNZTCLhAv46KvizZJOpR5qjxZ9oAkpIDfNX1KfjdI8pdyO
	H+F/KfbSe150MzPdld4OqFfm5WdUI9Lqw3G2MstdZXzLELXuMN88i9iA9HbaYr6VoZNq0qN61EY
	+Z85thB2cinbfylS/fKjiJeXWhQQmwIVq0oqm+lV8Yr6vVz6251+LYrMOP4T+eqtqcqxppmZZjv
	4T3dzrSgg9zT+yglnUGeS3qWzZrNv3gqfosGlGxl/nDLyOu7yxCH6MHKJIM6Tu4V6x8HR7O4oey
	Gc6moHdSWM80PzirqUPPss9n4R8Yim7jkKksTc7I/z2zsJ5SHdQv471R9FM3d5bhn5D33RMMff6
	4s6EKXwDiXBdK5u1No=
X-Received: by 2002:a17:90b:54cd:b0:39e:6c69:f480 with SMTP id 98e67ed59e1d1-3a098d53c7bmr4592776a91.63.1790316240842;
        Thu, 24 Sep 2026 23:04:00 -0700 (PDT)
Received: from [163.43.103.131] ([163.43.103.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b898cabesm2467490a91.0.2026.09.24.23.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 23:04:00 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Subject: [PATCH RFC iproute2-next v4 0/2] seg6: add support for the SRv6
 End.MAP behavior under seg6mobile encap
Date: Fri, 25 Sep 2026 15:03:57 +0900
Message-Id: <20260925-seg6-mobile-end-map-v4-0-ba4951d28871@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM0OtmoC/23OwWrDMAwG4FcpPs9DVmY72Wkw6AP0OnaIYzn1a
 OJgp6Gj5N3neIeVkaOE/u/XnSWKnhJ7PdxZpMUnH8Y8vDwdWHdux564t3lmCKhAYsUT9YoPwfg
 LcRotH9qJKyelAuOMqonl5BTJ+VtRP9jp+L7t/BTDdSbkI91m9vl7la7mi7p5K9huzj7NIX6XZ
 xZR0qVXC9jtXQQH3mhALV1lazBv/dD6y3MXhtKw4J/RgNg3MBsgDbZW16ZB/G9UD4bQ+0aVDe0
 soKkNSK0fjXVdfwBthc+FZgEAAA==
X-Change-ID: 20260523-seg6-mobile-end-map-6f5560bfb68e
To: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org
Cc: Andrea Mayer <andrea.mayer@uniroma2.it>, 
 Andrea Mayer <andrea@common-net.org>, 
 Yuya Kusakabe <yuya.kusakabe@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2305;
 i=yuya.kusakabe@gmail.com; h=from:subject:message-id;
 bh=0yEq65dm5gu/6cmk1zcVrT/PR9DQuPYk2z+17Qf+ZwE=;
 b=owEBbQKS/ZANAwAIASrX0XUqXRtNAcsmYgBqtg7Ozdrwa9Q6XiHe6WGJpxN/N8HQxl9LbgQuk
 ADhO10bENaJAjMEAAEIAB0WIQTaB7usAfxNKMeqa6Yq19F1Kl0bTQUCarYOzgAKCRAq19F1Kl0b
 TfyCEADZF3TCv1RiI9fZmG3Nafmik/PaFu6/BJ9aFUM6HqAQrDZu9jemQ/wifdLnX7Y4fTDbIJq
 E9+KTE/OJ5VAYYGFToTY/9W3DoiRi6rVmLslVZGABv+lbwUKtayQvR3OtJz8Jrin2M4Ni6Zn4Jw
 z9TTIbiA4BnQWdVwLBMIbOy8v2N+s2Nh+6Jo45FjMighccPq000uvy7U8bwlbXjNPNj3nRXs3d2
 bXN/CLR+UljRe+fdMtjGzluzeaUgVddb4zOfKogMUElaS1mViNv+DirUq0i5vh7z1U1a1CkkE7+
 D/XGdBsVv1UROEFe+CHusKTB4MhwAdQimDgVC+0xMlgCpkL7orYZ7m2nhvYMM9GFlT0WPapxCjC
 vS6fZUGCPe0X4lkE7BR8Fi3qukw2QqPCcgKgIRsk6U/85R/BFeOadhxJktnpI9/deF9TiDOkuzt
 yxq/h9MUremfkilpBac+Kx6xhYeXMO17a/JKEobsDzJCL7LR5Jawqj5YWZMVuglAIgWNwwq1GMN
 54vgBr5zVN4t3R2QEd7kPKjYYcgakrZRdbnCh7JnnF1EGq+lPhvh+tvJi+MDL9cxhHmtqcJ5MXc
 WQ/sCf9xs9Yw81ILWOw2pKtztqdUbNItFn9kAWWQ/qycreko9mdr5tVzA2xphfb0MQ/KQhhmmQ5
 5OrWKz7DweHKJCQ==
X-Developer-Key: i=yuya.kusakabe@gmail.com; a=openpgp;
 fpr=DA07BBAC01FC4D28C7AA6BA62AD7D1752A5D1B4D

This series adds support for the "seg6mobile" lightweight tunnel, the
iproute2 counterpart of the SRv6 Mobile User Plane (RFC 9433) kernel
RFC series [1], starting with the End.MAP behavior.

Patch 1 imports the new UAPI headers as a standalone patch so it can
be dropped once the matching kernel header lands.  The selftest in
the kernel series needs the "seg6mobile" keyword to run.

[1] https://lore.kernel.org/netdev/20260925-seg6-mobile-end-map-v4-0-457733c08586@gmail.com/

Signed-off-by: Yuya Kusakabe <yuya.kusakabe@gmail.com>
---
Changes in v4:
- Reject End.MAP without mapped_sid in the parser [Stephen]
- Drop the optional parameter token from the man page synopsis so
  that usage, man page and parser agree [Stephen]
- Link to v3: https://lore.kernel.org/r/20260917-seg6-mobile-end-map-v3-0-7fd02b8b0577@gmail.com

Changes in v3:
- Repost alongside the kernel v3; this series is unchanged
- Link to v2: https://lore.kernel.org/r/20260901-seg6-mobile-end-map-v2-0-05b2ad78b922@gmail.com

Changes in v2:
- Sync the UAPI header with the kernel v2 series (comment wording
  only).
- Document seg6mobile in the man page the way seg6local is: the
  "count" attribute in the synopsis, an ENCAP_SEG6MOBILE grammar
  entry, and End.MAP wording aligned with RFC 9433.
- Align the counters helper comment with the seg6local one.
- Rename the nh6 attribute and keyword to mapped_sid to match the
  RFC 9433 "mapped SID" wording and avoid clashing with the
  SEG6_LOCAL_NH6 nexthop semantics.
- Add Assisted-by tags.
- Link to v1: https://lore.kernel.org/r/20260710-seg6-mobile-end-map-v1-0-970275f3d80b@gmail.com

---
Yuya Kusakabe (2):
      uapi: sync lwtunnel.h and add seg6_mobile.h
      seg6: add support for the End.MAP behavior under seg6mobile encap

 include/uapi/linux/lwtunnel.h    |   1 +
 include/uapi/linux/seg6_mobile.h |  61 ++++++++++++++
 ip/iproute.c                     |   6 +-
 ip/iproute_lwtunnel.c            | 178 +++++++++++++++++++++++++++++++++++++++
 man/man8/ip-route.8.in           |  32 ++++++-
 5 files changed, 275 insertions(+), 3 deletions(-)
---
base-commit: 204a721033556114c81c47d00375f2d52e98e463
change-id: 20260523-seg6-mobile-end-map-6f5560bfb68e

Best regards,
--  
Yuya Kusakabe <yuya.kusakabe@gmail.com>

