Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BFD28467C
	for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 20:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770929964; cv=none; b=aWfc7nRvykDUilcKYszqtQkgjQ9X6bxW2o1ZQPhOwvDNzfiAvI1LMM6yXZeQHKZ8GnM3mxsT3x5UfEvDNYVkawjQgBxdezJ+5hcrc6a+h6vpVhtQuauQP9ruxR6ZUSQzgMAsYn0oHkUcky8hrca353xLUqQEvgUo+DxmJ74UAw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770929964; c=relaxed/simple;
	bh=ziWt0RFFJB//dguhCOZsTWBS7bikbzN56Hn8z31e0xA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=LmETJPS2Z4/spHhY2ltNzQZzzgtLRM4R5R0RT8mf6xj9iVJn8VtvaLF6nFbvfiGmoxoRpjupoj/1YmXGOqn/JOEdoQ2A8II7v1gI4d+apkbYP7VujsnmILQyRM1oUyJZMHskLuc9NoNOBS5R+vo8hQOL/GApODQJCZMBU/ya7Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XWlsljP0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Masf1h3o; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XWlsljP0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Masf1h3o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770929962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tjHShH1itfWbTnxfitY+x2Nc4ZzHnojh1ZRl24kqzEs=;
	b=XWlsljP0ZqmzzKdfRJbew0XegUk2fJn7uSBFkHtAkIvG8qtooCLgdxVE+VpgLGjdeQu4ru
	s4Qq85Nhso4AKKM9UVWDRSVXPIWsjjwTEitgsbGoKHVL9OyAmtovSoFXJbOGX1XjnC24mH
	I9P/1yF86yPVUXL3swavw4oZ19ypGBM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-_BqkzJK-N9uktbe3koKxrg-1; Thu, 12 Feb 2026 15:59:21 -0500
X-MC-Unique: _BqkzJK-N9uktbe3koKxrg-1
X-Mimecast-MFC-AGG-ID: _BqkzJK-N9uktbe3koKxrg_1770929960
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-482ef3af991so1289525e9.0
        for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 12:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770929960; x=1771534760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tjHShH1itfWbTnxfitY+x2Nc4ZzHnojh1ZRl24kqzEs=;
        b=Masf1h3oYMD8qg1vEm8SKgeoD635SLr4JrRs5/cHsaOWDJlLV+kNZGa2vMzJy7wQ06
         zSkY+t61craz1HI68l5uvzkEM97WQzM0LO3/kgs/bGK2Pkz+A15cSd+WoAEW+byB26O/
         3d+peQ667esAoWSqxkrdvTkHF41txVgMbICSmOSdXlcnuVgSw1igRwVDgREJ4H81EYbS
         4Cm/wD/arURB8f8AHMUb1rQEePVkXDNxDMmAPsM4lje5+WYXWXyHg1CIJzahIB7hFpUu
         3scJn2m2mKX9ZoWbKJwe5mJLoNbW1m9hfk7zn2yUdqNVXicIWern20TO1jN4nLGQWMP7
         pRzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770929960; x=1771534760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjHShH1itfWbTnxfitY+x2Nc4ZzHnojh1ZRl24kqzEs=;
        b=BZKHMxh9E+D9KDY4ts+QMO30rhZ6gkP8yb6YXbbq6E2Uh4Jrlq7D50x3KgwKCbjsql
         wjv1dPHSaX2xayWv9S1Os1uNxWPYOChQLMSDtMvB1ipt12M7gZxMBEJHqpDaG1jujZGa
         rIyqCJUcYU5MhjsSoSDIPow+WWeQbuvLuWa75G6LKkdzIQQnbD/v2BY+Xvjtd0sbJZ3O
         dLPWQESTeohMLdOe3YOc1Y8CDLR8dQM236oNOdEjP3xFgwQKyRpyLLwBJRIwHKkLZut1
         AHPrBxSMvrYyjcTfumXsxDeV7CqMdDEkNVfN5+/kjvzmligWBizNhGl6NNKqpkUJKoPm
         FTdQ==
X-Gm-Message-State: AOJu0YxpfYpuKD20wcSCNLUXiJ0WLgkV2bP380q6EaK3m99nMkLihDaU
	1WvpF6ctuPRHYzR0WZRfa8Onzf+5G+MzyduiTozzYWxEPjqPprgvHtQXXKT8zZITji9Yb1gZFsC
	X9Tu81M3A7sSRT4jkPDIJl2yrLVRfdDMOXTzSUSX7UVT559FPIw4lX+YILJCsNIqu1I3KvvYEi2
	95wwF12CI9Uj3f+sxtCs5FMGLdnaUlhPEb8Wnmo4FKLg==
X-Gm-Gg: AZuq6aIp8qvM450qn4kq6F1cw2HzHyjPg3JbkNEkdCZSX1wxAlhlTt85KF944NYsEQ1
	gxic5YQKZpsIXYIsyHEmEP2Rm7DMQj/KbtdZdIcqwpCeZ9Si49V4L8g+XIwdn9/K0Z33xO9tCKy
	JPPATRvWpmYApf8gz2x5qpZNCng3TXJghXHU/1UKWV2dolrdMm+Ar6r+c3BPaNrSY5vcfqCFNYN
	5/EjdoVD0KqF4d3cfKaz1DHI+5qVRiAg+J6MxiFVz1stG71hsSbkX3OEX0OtY57luWmIk0TJeGt
	0xjM8ey60qeEVziF0Vqjp/HrvjdWItV8cR9X37dFDmwfSxENdDw73ghbqWVbOAObObZX8azglHW
	h8pmSao5or7oGUnDXBvxaP51aRQCPGIA9+9BdUEbRzZLuHHbqeWrmo0bBqA==
X-Received: by 2002:a05:600c:81e:b0:477:9a61:fd06 with SMTP id 5b1f17b1804b1-48365fe67abmr42250605e9.8.1770929959774;
        Thu, 12 Feb 2026 12:59:19 -0800 (PST)
X-Received: by 2002:a05:600c:81e:b0:477:9a61:fd06 with SMTP id 5b1f17b1804b1-48365fe67abmr42250385e9.8.1770929959261;
        Thu, 12 Feb 2026 12:59:19 -0800 (PST)
Received: from stex1 (host-82-53-134-58.retail.telecomitalia.it. [82.53.134.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d930902sm189202405e9.15.2026.02.12.12.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 12:59:18 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Stefano Garzarella <sgarzare@redhat.com>,
	virtualization@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH net 0/2] vsock: fix child netns mode initialization and restriction
Date: Thu, 12 Feb 2026 21:59:14 +0100
Message-ID: <20260212205916.97533-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes two issues in the vsock network namespace support
recently introduced by commit eafb64f40ca4 ("vsock: add netns to vsock
core").

Patch 1 fixes `child_ns_mode` being always hardcoded to "global" for new
namespaces, breaking propagation of the "local" mode through nested
namespaces.

Patch 2 prevents a "local" namespace from switching `child_ns_mode` to
"global", which would allow nested namespaces to escape vsock isolation
and access global CIDs.

Stefano Garzarella (2):
  vsock: fix child netns mode initialization
  vsock: prevent child netns mode switch from local to global

 net/vmw_vsock/af_vsock.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

-- 
2.53.0

