Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECBD3F1643
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 02:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789440417; cv=none; b=WqwrHbIk/33eUJ1+UgV8w42vbzVYSct8BcO+px7kqwwIVGL/ba/yHOI8ImwaGhB6Vaf2yNtLHYP85GVVIgC7/nldEq0NDBjwOwc7xe+zIAs5VbXFr8QU/tr2PgPDpfkjHF+vrlJltzupIetiTahJXvWO+eqOZKrcCyzXKHTg6o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789440417; c=relaxed/simple;
	bh=EvCGUfYobnpKbJPog1pnp9SiK1TmGyI3G138UCETfx4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S6wR4MfoPNfZeJL6cdtQgByK0gvj6UTOrj18ODRQGAx1peiTZo7mUXdSNh7bGP3SAGjnUMELxEWvtBL97UzNpkirSGgAi6L45sRMbHOmJCk2UmyWcwGmBeA467HcDCkWcXJqRKR1XJI/YAgRpnuyPyCA4Z4OXeZIKGGY/wZo9AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YnBmshwy; arc=none smtp.client-ip=74.125.227.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YnBmshwy"
Received: by mail-pj2-f8.google.com with SMTP id 98e67ed59e1d1-398b9f722abso1468468a91.0
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 19:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789440415; x=1790045215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bdnfdWQ7aFIGJcehUyHks4PfwhVkJCqnuvAgqmPxcmg=;
        b=YnBmshwydRiNFmVfTYgp21GL8eZNcmeSem4jUbqtAFmiSSyvr/i4aR8SORLlxhu2YC
         IJ/oLVzG8Sd5RgFW5YVGD2pnOjs3/X3Y4bKfAYjuifRsUIqwFV3RZ/eoy+QYs/oDvKTE
         IuR2rYwYAIHFFhH75irKrbkwhQABNa3Vgususw9G2PIElRM0Fygq8bTlmnzJoxie2XCJ
         +ot4HKF27WDT0nkd8s5slxQUthk7QWBMhVfJKh+RqWaasme+rzdmVksldvSCWPHuz832
         KFAKc5qsI11EkaKf+NK1sB6drZ/w1B/zVUgSBdLsaPLNVI8rA9n5PkeaWn2xPfIMezW4
         P3kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789440415; x=1790045215;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bdnfdWQ7aFIGJcehUyHks4PfwhVkJCqnuvAgqmPxcmg=;
        b=SIyGw3dQHRGHgCnbV16GGFuH4plse1r3pKvZRxY+Oz8XAtKLpB/FGARRPoZte9jsjf
         NB6/mKrbdIOrTPis+2f9ewB1vYgx9LLoRY6mzCP0oiNZ1pQt1VfP7KROlMDrj2K029El
         DDkFsr48TTKPF1QDlV3wrFHY7flISUOlNKy7YMwD1E6ogQMdrQMwo+SdOrnnRAVCumNV
         d28WS9iygplQZfAKrMGF3UYKHtURvH80r6GVV4N9WoSd77iyrkgBMSjPw0/7YUtrJFac
         uKm601gN0ZIqO4PyagcO938Zo7vtWzHTxOsLyPA4MYyuw7BmWklb26+cwJRs/+XWMdKA
         yuzw==
X-Forwarded-Encrypted: i=1; AKwUvBxvwNIENhqVzK3o74GWanDzgshXqa0vFJqP0JH1JhKKjXrxGxaXrPOq5AEmpwQCIDFg5M3L4D4=@vger.kernel.org
X-Gm-Message-State: AFuF++lCWzgHe9xW5IF24E3fxf2qd3VY+h6asqS1fWxr4TWJ5dZClNRx
	tlg6d5nlyitvNq4ALs0v7SjF98ZEmrCm+liFN6JkOFfkRaEK7Fa0ayqI
X-Gm-Gg: AYBFou2YyUTBskUW3OfkOph1OD9CE4Pq6pXpUOubYvRF+FN3cvyOI6iRHuE8cYYGECP
	+YWTzl7MxkXRKFwXrhVlAL3J1vdwsKUhqdPBKwRpJuyr8qc//gYEh7hCvZzQRjM+TuyxGMPoiSt
	whp4IiPuedr9ozNWn1g3dy1sNKBoxLjUrn0cZq2nmXsXVRx65HNHBDnDT3URESbUtNIOKt8bLCO
	Zcm5ArmcWvVM21+5bQYiY8dQDYesoahLUP5/cnnidY8/JakzhHqs44dEtKunwGSlm1njUs1my2a
	5kdXjk7u6537M7d8mYsrYpgFimJjdg5ZqkoMCemsQqVtQ0U5RnN7h4JCgKI52ocmBMFvMl9OanR
	duk65VXxI2lJ7UeihXGRHwF8Xnz+qq/nv8mb6jPU7nmqhLJ/1g5hIsARjBU6D10m9avXBAqIGxy
	h5eYWTkqk5sLyz6mBXZdLDfChE2xCHxhewp2kZII9RYhognD0zrHFqZKjeGxYufPr0mAWj8BpOV
	8fwMClWsbVKxVVY8cAass8umVGHXZtT+LOMPpITq5t5jRBW9IRsDRBlJIvISxsiR39lRQ7ZnR1a
	WsGzqBHSMdsBNzbrJwIpF/N+LQuM3aS5tC0QDvChVATJ2U/xy7UmuHfNL2Tl32VFOCJhsyqUoPl
	g
X-Received: by 2002:a17:90b:35ca:b0:39d:fb87:569f with SMTP id 98e67ed59e1d1-39dfb8757a9mr5547646a91.12.1789440415328;
        Mon, 14 Sep 2026 19:46:55 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4ed79absm33213571eec.17.2026.09.14.19.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 19:46:54 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Michael Grzeschik <mgr@kernel.org>,
	Denis Benato <benato.denis96@gmail.com>,
	netdev@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH] net: fealnx: remove never-true 486 CPU check
Date: Mon, 14 Sep 2026 19:46:33 -0700
Message-ID: <20260915024638.198865-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The fealnx driver contains a check for boot_cpu_data.x86 <= 4.
This field encodes the x86 generation (3 = 386, 4 = 486, etc).
Therefore, since 486 support was removed from the kernel in commit
8b793a92d862 ("x86/cpu: Remove M486/M486SX/ELAN support"), the
condition is always true. Remove the check.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/net/ethernet/fealnx.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/fealnx.c b/drivers/net/ethernet/fealnx.c
index bdc38aac5850..708b61f21915 100644
--- a/drivers/net/ethernet/fealnx.c
+++ b/drivers/net/ethernet/fealnx.c
@@ -839,8 +839,7 @@ static int netdev_open(struct net_device *dev)
 
 	/* Initialize other registers. */
 	/* Configure the PCI bus bursts and FIFO thresholds.
-	   486: Set 8 longword burst.
-	   586: no burst limit.
+	   No burst limit.
 	   Burst length 5:3
 	   0 0 0   1
 	   0 0 1   4
@@ -858,13 +857,7 @@ static int netdev_open(struct net_device *dev)
 #ifdef __BIG_ENDIAN
 	np->bcrvalue |= 0x04;	/* big-endian */
 #endif
-
-#if defined(__i386__) && !defined(MODULE) && !defined(CONFIG_UML)
-	if (boot_cpu_data.x86 <= 4)
-		np->crvalue = 0xa00;
-	else
-#endif
-		np->crvalue = 0xe00;	/* rx 128 burst length */
+	np->crvalue = 0xe00;	/* rx 128 burst length */
 
 
 // 89/12/29 add,
-- 
2.43.0

