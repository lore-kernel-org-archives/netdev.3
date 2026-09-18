Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08953DD849
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 13:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789739377; cv=none; b=RReRKUfWAP4uS4Cbpzr9G84H9v8v4kHR2aFbHXW6gUjKhcpsB0lJYGT0jm6tGXUsw1z4gdd1MjPFdeEi0DJIoHr1P6zu33oZHHICZRdfqBLuR1ip9BujpNJn4oBIQYM3+2b0u+AEBE3NsoLiAHiICdF9lLRM3PKLIgqfAioPyB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789739377; c=relaxed/simple;
	bh=Ep+wq/i2umiA8YS7Pl1zPbiNgVmnMR53naO/aGKJnfw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZTVobsSAoIJ6Xqa0NrgsC8pIjnlDPxyy0AVyAPvy4PC/zAaSF1A/XjKehry+iSzUCI8IlDF/R+xgJSVw6gaeg+TB6M6tjTI+/JOAnIYe0XAdPF6FLRuPFudtVvzRF15xJ6Oua2QujFZOV2vTESKcTM9SwoCPBszTp66/9Hy9JI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dHTR+nNn; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHTR+nNn"
Received: by mail-pz2-f42.google.com with SMTP id d2e1a72fcca58-86e6d007703so689607b3a.0
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 06:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789739374; x=1790344174; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FZ2x5YA1Wkn+XLaTMl1C5PiwQkP5R3MNLqBp+wmPsGk=;
        b=dHTR+nNnvAj0ZAW1rFW/ydcNrcY/lehNv6RPuL0etSjAiewifT6Oyh+vEVj+ctkwRm
         0iLCr5H+j1zj3p4EPRcEUvGh2bQbS7dZKSJTHtRgnoTFd13dbjyK8g6mnOfeCbdl5HCH
         D8zWjgMHagCOuxt6Pxlal48PBlV2gL3d+tbSbNLN0ir48NzKC1E5sOXkOd4EQxITV0fe
         pbsVvB+3tKBfyaxZy2JeFscNlkuj4PoayAQdoH3qI/pkVllPNIrBtA6nN50OeUUDGpTj
         xOi6A1fTSJQx/Ltih73tOvKHRQOzCBJ11kwAvyMZD55LmN8oe5TeYvrtIF5mWfGZXDzo
         qbOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789739374; x=1790344174;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=FZ2x5YA1Wkn+XLaTMl1C5PiwQkP5R3MNLqBp+wmPsGk=;
        b=ocyIgvcoFBpsj27X7BBkLanKMZ9ulNi3xQK6DWwUaBTyK7B0Pg2+o0+FKiEFWFksRe
         MQo8FHytSi3Ee3znuAQYutLmD2vg6VHmcyu6bLOBOZj80zV2rLZKTmSL4B9OF21tCrUq
         ff8Td3MegBiwyhzDUGb7XoSLGFQe7TRPaiI4/DnJEfUIMXhHz9XSEoPMFrgKwNHuRulw
         d9y02S65pxqN775wzvaPp8xae8dMRZYuB0NGv0XERLqMipNv5xRACQArQdL55jlBHabp
         9V/SqAk0St8nTNuroJMktHl9KQaN6hhQLuSLFPlkWULAeDCRjwH2GGGlvPbsbMfT6IK2
         LrZw==
X-Forwarded-Encrypted: i=1; AKwUvByjWF3Ttus6m4xNqAzD8fYzTMpA88flz9DzWNNARzFqGOAYCbhu8K6WDqv+P3a2iY2qikYAWTs=@vger.kernel.org
X-Gm-Message-State: AFuF++nlvKeRljpgS099JfHcV/m7jGC82oRKY58xG3LoAJlxLBS1Keot
	8Wlgr1sOqI5B8LSCzQ+ntgRg6YAfuYBjtdGy2LpEkBGdfO1NX4V7YynX
X-Gm-Gg: AYBFou0m/QBB/s/L6eHjaHQT0orZ82q+ekCIY+acypU3xfyT1ovTHQTewG8cuaB5O3O
	PmIu/n9XF2que/AfsAGxsAqlZjK7NYLoWDmFpWFv6o8Qu/EO9A5cPdt7d/h5a94oLbpTnFmwaWX
	+KIl/sNgPcGbx72TG6U0CpnAjRBUbjsu/2m8qSW0l3DbdZjdrku9tk+dwc+EEUEnzn2XAv/I2dI
	MpgZeNi/Q+IEe4R6+emFxpUt8U0kvhMV58tzz5vQHovu5wrN2bKCT95SMZz5M7FEFCm9cEiq1EF
	sy2kMTRYmC8KUwBQTyHGW34O+vD2PfXcfZRfEgWBWYb/MVo02g0RxleL4yovqls8eHJi71eKU1X
	rkNzlids14FZ/Uxts9lopft3CQjrRIpFWXQy/ztr/32h226aXgGETrwp6lu67e2slUiFYCV+E4S
	4ETwWdRrk6lTtXyC0i4je8Ub2ef1ufaRe+enqvB/+N8K6eCqTDKw7U5rxDZq4S2uKgecwhd5ztf
	JTiOfFxLw==
X-Received: by 2002:a05:6a00:2d26:b0:857:72f8:dc99 with SMTP id d2e1a72fcca58-874dddfd214mr5511344b3a.26.1789739373932;
        Fri, 18 Sep 2026 06:49:33 -0700 (PDT)
Received: from [163.43.103.131] ([163.43.103.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-875cf12d57bsm888878b3a.1.2026.09.18.06.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 06:49:33 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Date: Fri, 18 Sep 2026 22:49:30 +0900
Subject: [PATCH net] selftests: net: fix CONFIG_SYSCTL sort order in
 configs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-selftests-net-config-sort-v1-1-968ea6e8c1b7@gmail.com>
X-B4-Tracking: v=1; b=H4sIAGpBrWoC/yWM0QrCMBAEf6XcswdNLGr9FemDJpt6IonkThFK/
 92oj7PszEKKKlA6dgtVvESl5AZu01G4nvMMltiYfO93/egOrLgng5pyhnEoOcnMWqrxEN0W0aV
 h9Htq/qMiyfvXPlE70/Qf9Xm5Idi3Suv6AeYWqSyCAAAA
X-Change-ID: 20260918-selftests-net-config-sort-4d13ed1f4927
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Oleg Nesterov <oleg@redhat.com>, Joel Granados <joel.granados@kernel.org>, 
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yuya Kusakabe <yuya.kusakabe@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1797;
 i=yuya.kusakabe@gmail.com; h=from:subject:message-id;
 bh=Ep+wq/i2umiA8YS7Pl1zPbiNgVmnMR53naO/aGKJnfw=;
 b=owEBbQKS/ZANAwAIASrX0XUqXRtNAcsmYgBqrUFr4VG06BZEuZlW16iTbpLGKfNzDeuCZJWZ8
 h0XS22oePeJAjMEAAEIAB0WIQTaB7usAfxNKMeqa6Yq19F1Kl0bTQUCaq1BawAKCRAq19F1Kl0b
 TbH3D/4vwDjKgb51jQAQukW1Lr1H3sYEgNU2J4cJ5vAJctFgsT8JFa3uwrQl9iMWVZJgLPtfyeX
 Co8L1xtmER6SdKxVhJaRQFbnI6plvU6ESGuthghGbw02CuSd+e8GmrplFDl6UL10bZLatncJF7M
 9NPAGQuaZP738D7UmRhzqlZCNjij7temifArHwwwkpobD9z1yqe9IuqUNlaNgzYW8J24GGlEQij
 RzYTaoOy/9rW5leTuMSc+N4rG1KM7YAADRbURMvhjNDsf4154KeYRwHHkDI7EpWbvo9gBw59ER6
 kxV+yodMa7NyXegA1gcsGjHO49e48ZalxKjjFYZnXFCe7ndcVCYoS3ImQSIIpUlSgJp3N1B/3tv
 eaksZQ7bUlzer483RJkc+Gsz5OklacaiiCzKC4zqBO8HIYeetpWrBbF/U3ZcXUPT+HKjO61cxHi
 5y7ymRKsFQxT96iLf2eN8z4zPAkdSVfC9DfRMb00z/7xGJexzrWBLUwD1Nh7MUzjpGqsx/Yb5UX
 4C0YR5kenl6Dxux7HP0UlxIwJ0U0paaquE8ImVCnPDXG6D5g1vgxPAqR08R5H9O0ot+GkvGEpqs
 G581Ei+zYX56lGE5N55pAQnpJ7gPdsqBcP4sQn0fcdu008iwVI1D6I2GC0NwsjIdd/MJFK6fQvv
 nThWWOF3UQOtDyw==
X-Developer-Key: i=yuya.kusakabe@gmail.com; a=openpgp;
 fpr=DA07BBAC01FC4D28C7AA6BA62AD7D1752A5D1B4D

Commit 8d75c338f0bc ("sysctl: remove CONFIG_PROC_SYSCTL, it just mirrors
CONFIG_SYSCTL") renamed CONFIG_PROC_SYSCTL to CONFIG_SYSCTL in place,
which left the entry out of alphabetical order in the net and
packetdrill configs. The netdev CI check for sorted selftest configs
now fails for every patch that touches either file.

Fixes: 8d75c338f0bc ("sysctl: remove CONFIG_PROC_SYSCTL, it just mirrors CONFIG_SYSCTL")
Assisted-by: LLM
Signed-off-by: Yuya Kusakabe <yuya.kusakabe@gmail.com>
---
 tools/testing/selftests/net/config             | 2 +-
 tools/testing/selftests/net/packetdrill/config | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index 30d5fcb09a83..737e7e6327b3 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -118,10 +118,10 @@ CONFIG_NFT_NAT=m
 CONFIG_NUMA=y
 CONFIG_OPENVSWITCH=m
 CONFIG_PAGE_POOL_STATS=y
-CONFIG_SYSCTL=y
 CONFIG_PSAMPLE=m
 CONFIG_RPS=y
 CONFIG_SYN_COOKIES=y
+CONFIG_SYSCTL=y
 CONFIG_SYSFS=y
 CONFIG_TAP=m
 CONFIG_TCP_CONG_DCTCP=y
diff --git a/tools/testing/selftests/net/packetdrill/config b/tools/testing/selftests/net/packetdrill/config
index 83dde525c53c..b7df8bf30920 100644
--- a/tools/testing/selftests/net/packetdrill/config
+++ b/tools/testing/selftests/net/packetdrill/config
@@ -4,8 +4,8 @@ CONFIG_IPV6=y
 CONFIG_NET_NS=y
 CONFIG_NET_SCH_FIFO=y
 CONFIG_NET_SCH_FQ=y
-CONFIG_SYSCTL=y
 CONFIG_SYN_COOKIES=y
+CONFIG_SYSCTL=y
 CONFIG_TCP_CONG_CUBIC=y
 CONFIG_TCP_MD5SIG=y
 CONFIG_TUN=y

---
base-commit: 46bc52d13594848023e681860df8700c8db14354
change-id: 20260918-selftests-net-config-sort-4d13ed1f4927

Best regards,
--  
Yuya Kusakabe <yuya.kusakabe@gmail.com>

