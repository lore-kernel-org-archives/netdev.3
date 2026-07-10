Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38EE3FBB6A
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 12:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783685907; cv=none; b=s1mdVW/Jc6yzNR1evbWryxZB4eqmQAx2owd+0AW2okbJFQmlHI62Ry1EQHnlPbKloSLVLN+WqmFyioay6/NpXQb8dnIBo/Q6NqyIYeQfiNlyjWCz2mrLdVgNyoTF2JrsXnMTkHvPfP2BTS/gNhUlaeCx6lMiOMbjt8AFQ8ZS2As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783685907; c=relaxed/simple;
	bh=9SN+V+REhr2OsLoOvJrTk8maUpT32wY8pP0OMF4CJko=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JaurMEWckGZHVn58uEe5szzZnVoPSLKGNMYKdTNZxR6FLXcG+8hgGXU1bSvadhpee6PFMlYkjYMdh6CvVfSxfF3hgqxYwbvSMCP7wR9cO7PGPUuqV9VrYxCV0CUSL8mJXe0kKFYpGuyGB8UIGb4pbEiy3EesD1eHJtyO3qDSmqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sXr1jWkv; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sXr1jWkv"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-848479c9bd5so573529b3a.3
        for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 05:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783685901; x=1784290701; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=D1ve2Jv1wKCMGR2eux0a52sKbThvil31mifXTkYcpJg=;
        b=sXr1jWkv+4q5Io242qq/1yNO8D8GePzJNsGINPv1U5kGzrWy7j36v/bv7GoGyrTies
         /yEhQwhUQUoUJTQdG3n+00fTDNFTPtlQniVKf+K/vrXQ2pFzVK7NR6xhga145Z2SG1lV
         w25NZ+xqrWAjrFXI7pJSsZHooBvt//YySMXhkawNuexbFT38Y38QXMdGbRJ8/0pnBkLC
         U8L2MO7cRyZ8VCGfrpMPX6uOUpG1WbmaOR+QvuhCKKwS7QohU+R1yql7VsvLyUIlpRY7
         Sd95quqz8E/jGq3hdgTKbvPB0Ik33pfxVycVGmczB/8re36JLWPhOoRJiK1bMsOR5r9T
         WFfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783685901; x=1784290701;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=D1ve2Jv1wKCMGR2eux0a52sKbThvil31mifXTkYcpJg=;
        b=mP3Wl5K7V67E3JnKnyBnUcU1dzD34M/9aybD7jN+ReTePaDv2uiaFP6Khc/AZQLgjn
         1U55pOB0h1cqo4egvT/WNfK5sKfOGF0lpaUvEAzOpCBtA6JMHxVFNJJIJUpHAz1gAXaf
         b8KtkuYaY9CkWq9DkUcF7Yobdq9QPe9YPM0I8xNtJ8QcwaTPFZtYCGjEWHmqNyBjB9dh
         miWhPqQJS+PnAmdAi4S4cpBKysVnMesxJjasKlZeDdnCg1+IDsT36RAmtfIoAL1fv81w
         Ijl2RjnSbqH1eUWnQooICzhhd1HQ2gjGUvtBZ1UWX0LqAtz6RmQVZEPeReQ63tqz0CQR
         8LVQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqf3QHqEZSMEfpB1C469c/eWWPmFR+Y6zThl/ll6Qbncs3vLVxos2dZsC7FhFZzdNZDqDmpfRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLhjU7ohcVbdtw3tvRfUYwWY8IhtsaRBeh8HF/VmPm35ydN+YC
	a4xJT6z0enxUQBe0eb1oUIE+yVWofMdu5yhn3o+Sxk3wEWGGXYfhV/z2
X-Gm-Gg: AfdE7cmq/wIzniM234l7WXfAn23rN9EkJUKFhVayeCY4n6eekUFl/wZQJrhMyPuetol
	o1cA54kllwWMfJBbqBeRBQIkBEuzM+aUzf8x9r8dJq4kmIkf6y9dsQohg02Xd2oTZff8yD3dWQ7
	CW6FFJKNCNYj1R0eqQsGRVMttcpUq+wh3libBpyEgycY389z0qgbSrrYU4O/R+UrSL8evu83kAN
	GB/y/SkH2EuJOpQYVlc/ZG7QCHu3U2hQIL+uLdssRuL6k7AlMSXLs3hNodnwb1UBEX+vS0ahExu
	40jl2SFN5ycClgyWwDxFYZ/bcL9MvHL/7NuELt+fa1nafgGdstF6G9W4j7He3to/ehXRhDpbFeS
	9f5mXGRnFaW5q48K5rWjvJ6+fcdVShb+qpjNa7KT1bdlUW6wb77GKtLwkwM75sVFoCI+7AaYCuF
	lJbKVgQL4VO3UbLRWXoSaP9A4=
X-Received: by 2002:a05:6a00:928a:b0:845:2ff5:b66d with SMTP id d2e1a72fcca58-84842f9f0a8mr10683689b3a.35.1783685900841;
        Fri, 10 Jul 2026 05:18:20 -0700 (PDT)
Received: from [163.43.103.131] ([163.43.103.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8480da8bab0sm8600845b3a.8.2026.07.10.05.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 05:18:20 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Subject: [PATCH RFC iproute2-next 0/2] seg6: add support for the SRv6
 End.MAP behavior
Date: Fri, 10 Jul 2026 21:18:17 +0900
Message-Id: <20260710-seg6-mobile-end-map-v1-0-970275f3d80b@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAnjUGoC/yWNQQrCMBREr1L+2g81kiBuBQ/gtrho2mn9YpOQp
 FIovbupLt8wb2alhChIdKlWivhIEu8KHA8Vdc/WjWDpC5Oqlam1OnHCaHjyVt5guJ6nNrAZtDa
 1Haw5g4oZIgZZfqsN3W/XPZMQ/Zyh2GHJ9Pi30mxf6PJ+QNv2Bb+QWiCNAAAA
X-Change-ID: 20260523-seg6-mobile-end-map-6f5560bfb68e
To: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org
Cc: Andrea Mayer <andrea.mayer@uniroma2.it>, 
 Andrea Mayer <andrea@common-net.org>, 
 Yuya Kusakabe <yuya.kusakabe@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1199;
 i=yuya.kusakabe@gmail.com; h=from:subject:message-id;
 bh=9SN+V+REhr2OsLoOvJrTk8maUpT32wY8pP0OMF4CJko=;
 b=owEBbQKS/ZANAwAIASrX0XUqXRtNAcsmYgBqUOMKa4zwyt7nkWRzU0an1NR7AcksgtLlS+LNi
 2Ljiq4n6n+JAjMEAAEIAB0WIQTaB7usAfxNKMeqa6Yq19F1Kl0bTQUCalDjCgAKCRAq19F1Kl0b
 TR5ZEACXDc7BUOop9//NCN4l1GJlM+ZaZ2MSDZJdD0SvDc7vNjG3U4NMKFLohU+Cz+e7714sql1
 j08wQKq2tQ3op6PTMlJ+COIgHLmPF2qMY3uuS9nlMRJbyT18IO/2YxI/E/oYjPhnbqsT3Ku+6Xo
 1EQ3ISVTM5M4Aew54G3b+563+vU/ADMt/1lxsG3OUskJjw9/hTvhPkgv4FHEBjVjG6m5aR9lVS1
 iHff0DwhM4aP8poWgpMbqWgx9Lemqm8ax8b39tuZN9ETbUkmcLVdsXruIahUhwmW0w1yQ3fNMux
 PqfCpi2fd62D+UGu79AP4YRYAqELaPFJgjH1sZ5/cQgU19FOkmrTt9//4R9LTiqy+/uxm6rQGSL
 ySj8/lZlPuyU1joRYIeltnItZmhWeohBmBE+UxM/rKsIILP48eN/F0z1Fe0FvWEewFZEqiQzFsT
 kyTrpq2VI6ixXz3LlpdXTp+uVdeuA4CWEZcV27wdPxIVAWgJvkUP5DA7vs/qICRqVkyDnD6GM0d
 9m8USr3q/mPW8HO82eO++SKtMqJFK6DdxNWYiNfdKwIN/U9Ys/KdgzWlMtuPK38zDYx9wMXQHTK
 CVCQFHu/vtDWnrJ64r9RuPLz1Nx1TbOfXZZ1DBejpJNdB5OBhWWhxauWaxNLIKScFvn4IAvGcs6
 pxrkQ4+2MB3Emcg==
X-Developer-Key: i=yuya.kusakabe@gmail.com; a=openpgp;
 fpr=DA07BBAC01FC4D28C7AA6BA62AD7D1752A5D1B4D

This series adds support for the "seg6mobile" lightweight tunnel, the
iproute2 counterpart of the SRv6 Mobile User Plane (RFC 9433) kernel
RFC series [1], starting with the End.MAP behavior.

Patch 1 imports the new UAPI headers as a standalone patch so it can
be dropped once the matching kernel header lands.  The selftest in
the kernel series needs the "seg6mobile" keyword to run.

[1] https://lore.kernel.org/netdev/20260710-seg6-mobile-end-map-v1-0-99be02d68143@gmail.com/

Signed-off-by: Yuya Kusakabe <yuya.kusakabe@gmail.com>
---
Yuya Kusakabe (2):
      uapi: sync lwtunnel.h and add seg6_mobile.h
      seg6: add support for the End.MAP behavior under seg6mobile encap

 include/uapi/linux/lwtunnel.h    |   1 +
 include/uapi/linux/seg6_mobile.h |  58 +++++++++++++
 ip/iproute.c                     |   6 +-
 ip/iproute_lwtunnel.c            | 173 +++++++++++++++++++++++++++++++++++++++
 man/man8/ip-route.8.in           |  24 ++++++
 5 files changed, 260 insertions(+), 2 deletions(-)
---
base-commit: 37c491d82cebef070173878e167076a1956dcd92
change-id: 20260523-seg6-mobile-end-map-6f5560bfb68e

Best regards,
--  
Yuya Kusakabe <yuya.kusakabe@gmail.com>

