Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64203A872B
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 19:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781291365; cv=none; b=ZllXVmJa/QWhuY1eID7evn2ViMO0e4O350JdzVqXlGG+XCdYswi4Ji4VGpyO0X8pHvUGqvnscjF28ibRMMOux9xI0bCUrBPYq4wGYKa049jfHjNTkYSbulCEPsT/l3ERvNW+WfWe4/G2Ul3brWH8Q+xVUt5pqk5faiUGT1zsCcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781291365; c=relaxed/simple;
	bh=NF17neuBAb5a8ZbW82OAWrN4gb0hnuoHKYOLDGcV2ME=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rqYW/cYlBDdP2+P4bSljaXFtSkITjoToTat2870hvhAxgsfkKNc2aWtFUp6ZyhHmUpXuYUYwkYbMavpNQn/yaPN0pJlUPpCFbyKA7R/WLbrnXojEUOXGrQc15mIphvjq5AvR77LoUiUUJnqkgWAB/HVHzWvPhhwDU5KIjw2yHiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XfGaaI4Y; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XfGaaI4Y"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-36baeec21dcso985651a91.3
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 12:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781291363; x=1781896163; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ct/qd6zlmAVpaNbmF/piz+twUpeV9ONsk7D+rB9vo00=;
        b=XfGaaI4YaKaJs0W2t2ZzcMeChSsY7r7x5zdnqPwYr+aE8xm18eUpUlTkIGStsq/cpW
         oloKcRcyjZDquVOKGHpwt/HE5fYR1aFy4gtH1ai+WXS0VElyEbKO/wincPl9dIE9O9tJ
         MA6zY6J1aPzFe+rwZ6+a0P6V98LAxkX/fjpxi42iPVNM5waynI+g8Wm2rFANWpTMlkOt
         1xNL0uIE0iswMuHo0cfEkpfiqcxnfeAlj4M6EDL5tyQRWke8KDj7BmrmksJxGLDUoLQy
         n52S6jNO7H5yb3ZBhMJPpp0BgTT4hDsZo4vuMheQgYfJgf6ZC4BWJrjZNlP9I05GK0nR
         Du0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781291363; x=1781896163;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ct/qd6zlmAVpaNbmF/piz+twUpeV9ONsk7D+rB9vo00=;
        b=BGLAcbzVotD4wxjBDHxP+a4Oap1N26sVkvLm7AZgMGOs1o3wlPpGZyLwyc4eIXOVom
         t3lfv2RjRH/9H3gPZKTdW5nqOOypsXhK0UgjDr8EONglsIojC6XVq76mpfSFlcKub4J9
         vEySGEAdB/3kKPUXxfjDcUblELWeDhJnrEyjD/poZzxJ2+qmhbzaSf8hu2OAK2gH2Ono
         5LCkQYaZfB4YRiqV/ZLJuTt5GSR5bH2F6KefViLyxYvZYLjhT6dtzP4SScMHnHRnAwAu
         povbvNmzmjAZBfK4yWvMk0pgn9I/9NwKCfObBqW9kMw1tKy1M7b3mX5GGEl4Zrjbif53
         d9eg==
X-Forwarded-Encrypted: i=1; AFNElJ/guTnL6e3zlnvnBoTYWv2EmDpbvYf2MqwEbPH379NmpXwlaMX4emIbPg+O3hf5qAi+lXTwF/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOLUaDeNzg7CAkVHEZCo23us307lUvkArnUpcMnb+id8nhk3Vo
	RQyU4QfsofcCzNXcf6blXmRkxrnBklC97n1PSjRHJFZS9eloibKCEjsu
X-Gm-Gg: Acq92OFq1iX8vN+6bm99HS0iHLWNBbdJ0ULlhY0DuHG/UC0F55+LWqcU6BQwX8Fgmkk
	6zX8Q8o6ThVT4yT8k5Uwtnx4HpIAsbSf50M4bALXHoYsz3FJ4KKrzZhj5+yewgzRR/BE0w2B+do
	s5afOrPfVtj1LQi6xCPCirromU8Cdxhl3oX0fV6Czt7kxTA1EBV/bdqPPGt5c6mVHihBK6OrqCO
	epNO50HhS0hoEuOyyBt7RZ3rK+MztQGqnW1UXxTj62CJW/e0K7UDs04HV72HgStjtQydv2GOdMK
	kmhyfQgIbSVO/4UOYbh7Ff2tl0EajpMfhFuKTVvrofSmyIdReYzO6vID4P/pUb4oCDk5eXxoVgK
	aGAa36CW8Bvt6f7esvIxtlenhtOZra8OFj2Oj93QhNibNzeFQeSB4R/rZ4uZTe4AKX9hqRb9ciK
	VGozKIEe6oFAwT4Yq/Wbs=
X-Received: by 2002:a17:90a:dfd0:b0:369:2e00:1ff0 with SMTP id 98e67ed59e1d1-37a024176dbmr4400885a91.6.1781291363277;
        Fri, 12 Jun 2026 12:09:23 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5e::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37a233f58ccsm2848924a91.3.2026.06.12.12.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 12:09:23 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Fri, 12 Jun 2026 12:08:42 -0700
Subject: [PATCH net-next 2/2] selftests/vsock: skip vng setsid workaround
 on >= 1.41
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-vsock-test-update-v1-2-7d7eeed3ac8f@meta.com>
References: <20260612-vsock-test-update-v1-0-7d7eeed3ac8f@meta.com>
In-Reply-To: <20260612-vsock-test-update-v1-0-7d7eeed3ac8f@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

virtme-ng 1.41 ships the upstream fix for the SIGTTOU hang
(https://github.com/arighi/virtme-ng/pull/453), so the setsid wrapper in
vng_dry_run() is no longer needed there. Gate the workaround on the vng
version: setsid is used for vng < 1.41, and vng is invoked directly on
>= 1.41.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index ee69ac9dd3dc..310dfc2a39ad 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -445,8 +445,14 @@ vng_dry_run() {
 	# stopped with SIGTTOU and hangs until kselftest's timer expires.
 	# setsid works around this by launching vng in a new session that has
 	# no controlling terminal, so tcsetattr() succeeds.
+	#
+	# Fixed in 1.41 (https://github.com/arighi/virtme-ng/pull/453).
 
-	setsid -w vng --run "$@" --dry-run &>/dev/null
+	if version_lt "$(vng --version | awk '{print $2}')" "1.41"; then
+		setsid -w vng --run "$@" --dry-run &>/dev/null
+	else
+		vng --run "$@" --dry-run &>/dev/null
+	fi
 }
 
 vm_start() {

-- 
2.53.0-Meta

