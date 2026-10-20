Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792536878;
	b=tsXo3vCy+iPFG9L4NgSK6627m0sKnRTlzlojn14jNZMCkiJ+AbMGlI5cZneju7ezUaQx
	 ajTKtqr01vnHQfLUnh2rHSrLkM0/9gv/UiTFXGU1Znj/NwVJrqp4SEcI7sQz4qPnzZpQd
	 4+FsGsAVtz93pwfBBIWtuzxkAoK0RDeLOdUg65QdTnHsKde/NEmYGl/T+oLOHYfPDkCCH
	 2rFTfHjsKw3XCatiKV8ePZArH0tt6P60sAt1JJ0ULXbNRjovrNdz+B144BllsAiT62ien
	 X52O5slp14iVYFkGi+peIaO4vy22DczKe+SwDPVU6VxfdHL8Qb+2NtQjznx4ct2nxlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792536878;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=nTY4UiwHZnguYZHnP/ahTYNmkFfFglzVMEyieXYZ2S8=;
	b=A/r/0RSskxqNOeT2RqS+8mtUFK45s9+tT0yXRcdN4IgsL6gRah3giUgKF68wFjiJiBlv
	 F1SYWJ33rQZMZKUL53px43+HR+svDxFR15/JG6499J0mp1NBvWgHMKDehObgWRMTR/JMK
	 /laEhD+idqJq6L7uvY08y5tjqH7znBVMlWGFbuS5EHALaANrgM+NNDJ26xOrHDLINMl9N
	 LNdfHUi8gqbutlpDk09U9PNMod4lH+c77NtpUm9VMvoEbNEYJzash4JDMFeLYiPPqsss8
	 mbgydNrc+ViGSMtOuB/SSBDjMVKmXUBFOOL+dmIIJNIXjCOo+2zmpMSVJrCrqYVaY3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=YzT96xX8;
	arc=none smtp.remote-ip=209.85.216.100
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9B3606A319
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 22:54:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD9B3606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=YzT96xX8
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-3ad41b47541so127389a91.1
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 15:54:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792536877; x=1793141677;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nTY4UiwHZnguYZHnP/ahTYNmkFfFglzVMEyieXYZ2S8=;
        b=Bh3pHaXZ1/+06spo3UOv7QgeWIxRGZHSHS+aivDPdK31u3k8/+YkmdNgsV78+eDXj6
         1H2YUOm1ldUY9+L0Y+TrnGsh+e5P6hLYUKJyUHHb2BY6Zk8FfX7+xYOKl3LMKI68lG+M
         Nq09NeyteZJfM6g/kTQtPCl9w0kTphENG5e429WY+GHjxMgVzpu3sqSnqdCewKcm9eE1
         p5M/P4Pmn9JUCnXa8yuWYj91GoSgAR9lC6Sg9pkNA0Xn9Q4thPSIynw4QmADAPg+/IE7
         1Z/ZBLsknle7hohgLm6HAOWPkccFrz2J5wR0DAYjpl89SVdnkTLJeeMvyRJYX65BZgqa
         IUow==
X-Gm-Message-State: AFq9FYKf0RiD0GZjvVRF9CRMDNhjT3N8DMKmC14DSsGIVTXgLs+/XtJ9
	esgn0geqeVghKwxkNdMtoz8zrNkCJaRsKsg0MXYGjbbMHVMuU+/kv0KruzOytaiQd4CwYnnvBgY
	0SRGDnFtQ/h3LPYb08OkgJYm8f14WrgUS/OSWs67NVUsW06X1VQdCCHk2ZoRehJuCj65Gsl9Z48
	5Yv9Y3eMsjDPxf7eDkILQtQlOkE4S22SjPletUXGNYqhncgxvTH4Gwn2K4MrZevDaJf0r556NaJ
	5aEXZGzNg0=
X-Gm-Gg: AYBFou19WmRuoeUzrn4om3eqmtM4seyLo0wSDWW2Kc2KCRA8OBsT/qLYF7ixI6RJ0Vb
	yLpeKA3ZwMnSOqe4qFxgQcMyv/fd7qY3cO7c82J7lBehlmY+CBU5kSQ/rAkBIM3DUSJzcAIJa3+
	lXDMvwAqwFqluSOy1diEWJNkFq4MYxSJTx6w9HBNLHM6McoNPfDAlIOgSUA0OVSYE9o8q7EQA1Q
	0ZcJbSak3XoGzK1wndygZFPPpm6XgD4Vli3IF/wwuNxTUONLaqZ+fswBy4jQiFqW2gjMP17ZSU2
	daVkwChC1B1qNMzaP5Tcdoz4EIKPuZKRSLLna0NQzuqIaTiiVgx6yk8Pvrt0VgJ4yKuNOTEMNE+
	UdKKYOk4lWGJwQdykBJXUJxpaYhVpu8+OffXuw7SKx/YC42rTZuKzNtT3l057rNtFJ8XTJhJ+CA
	mLOaiSy4l0C4e0TjVy6VBRBsYGVl76WhKoFnhUuw==
X-Received: by 2002:a17:90b:4c49:b0:3ab:a188:b8b7 with SMTP id 98e67ed59e1d1-3ad86f1bbf2mr272360a91.22.1792536876998;
        Tue, 20 Oct 2026 15:54:36 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ad81f69d2fsm617265a91.3.2026.10.20.15.54.36
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Oct 2026 15:54:36 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-341eff9e381so153644eec.1
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 15:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1792536875; x=1793141675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nTY4UiwHZnguYZHnP/ahTYNmkFfFglzVMEyieXYZ2S8=;
        b=YzT96xX8TG4hzXTrL0v08jZ62xwhimj7jIlxZ14sOkUN2OsaToGIZdDYLbg28LWf5j
         lywh+1P5baM4fcU4+uQi0RYj5xYhv4tyxEySl4wp/Ps0ShhcIMUukwIjwqnsWCBHUJ42
         TCC2VKUsJ7eaY/mqAAEgk+k5C7sLmSZjjrPGs=
X-Received: by 2002:a05:7300:828a:b0:367:185e:867a with SMTP id 5a478bee46e88-3674f21c1f2mr822737eec.38.1792536875037;
        Tue, 20 Oct 2026 15:54:35 -0700 (PDT)
X-Received: by 2002:a05:7300:828a:b0:367:185e:867a with SMTP id 5a478bee46e88-3674f21c1f2mr822695eec.38.1792536874251;
        Tue, 20 Oct 2026 15:54:34 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-367405ee5eesm1496843eec.8.2026.10.20.15.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 15:54:33 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com
Subject: [PATCH net] MAINTAINERS: Update Michael Chan's email for tg3
Date: Tue, 20 Oct 2026 15:53:58 -0700
Message-ID: <20261020225358.1130051-1-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.54.0
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
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

My old email address doesn't work anymore.  Update it to the current
working one.

Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 .mailmap    | 1 +
 MAINTAINERS | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 0a0be49bc4de..16c3e6599082 100644
--- a/.mailmap
+++ b/.mailmap
@@ -638,6 +638,7 @@ Mayuresh Janorkar <mayur@ti.com>
 Md Sadre Alam <quic_mdalam@quicinc.com> <mdalam@codeaurora.org>
 Miaoqing Pan <quic_miaoqing@quicinc.com> <miaoqing@codeaurora.org>
 Michael Buesch <m@bues.ch>
+Michael Chan <michael.chan@broadcom.com> <mchan@broadcom.com>
 Michael Grzeschik <mgr@kernel.org> <m.grzeschik@pengutronix.de>
 Michael Grzeschik <mgr@kernel.org> <mgr@pengutronix.de>
 Michael Riesch <michael.riesch@collabora.com> <michael.riesch@wolfvision.net>
diff --git a/MAINTAINERS b/MAINTAINERS
index 00b440be0d46..4941eeec4a0a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5623,7 +5623,7 @@ F:	drivers/net/ethernet/broadcom/unimac.h
 
 BROADCOM TG3 GIGABIT ETHERNET DRIVER
 M:	Pavan Chebbi <pavan.chebbi@broadcom.com>
-M:	Michael Chan <mchan@broadcom.com>
+M:	Michael Chan <michael.chan@broadcom.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/broadcom/tg3.*
-- 
2.51.0

