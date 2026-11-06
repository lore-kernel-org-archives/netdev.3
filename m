Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793969255;
	b=fichG8xNPxjJzKGPfoGmoQZNDmwS2WJk5Q/4ylcXWzqJ6fRRDZw7vfk6NqPCM+wIZoZ2
	 aU/fKX69Td7AH9jWEplVcBo85RVFPdpQbT9YVo4yQsoz7c/3LijnfPraopEpf2gl4cI2y
	 U46grwGIVBu1sT/eQ3hb1WeOV+qSjclWeqVaNBpcWfaVrBlD9DzSiGq8spmLezMxnQEWe
	 jFtOSCzGDeuJP5ZSHOr/CDCCA9RuECpG6evy1GZl1IlpN1kJHT+0VlpwzwPNVIAWg/tAA
	 UAtk+Bq5V7vZdp6epAuk1Yh5VOR3sSFPTvqcX9BS8T2SUUk+IBNprD40YP5dwYWO4xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793969255;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Jbz4ViRXJQJmGQTHmz/n4fB3e11Y7YXX3ix7TPBKr/Q=;
	b=PmKq/XhcvahWRZNKsfxXBKeUkA/FM7jddIRnwxh9Oh723MyZG9tvOUvq+aNFDS/n6taa
	 j8rw7+/3V4PpE/6tNJ9KuYq3DNJSztw7mmBSG/D9+oDg3BYZNYPitQxzmmUKR8U7oLSjI
	 uvvTHF4M/ZIhSIjAtKyktfw7h9dEB4UxXIWjVGKFYHX9QcHT+3MVRL3h21nPuTPl83CIU
	 KZRD3pgYaZr5aptzanNtbuBkrHtVNcYgTfi9r45SsfNXgGontMU50EqTqgVABHBxPS+HZ
	 tO3gE8tE3j2eM2HgfgnkeTH1+xOTr9A8Qfl2OOkJjK0U6e+5vUMWGVDTmfh961mJhvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GYE8JxpC;
	arc=none smtp.remote-ip=74.125.229.4
Received: from mail-dy2-f4.google.com (mail-dy2-f4.google.com [74.125.229.4])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3575E606A33D
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 12:47:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3575E606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GYE8JxpC
Received: by mail-dy2-f4.google.com with SMTP id 5a478bee46e88-370231dbf90so193530eec.0
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 04:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793969254; x=1794574054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jbz4ViRXJQJmGQTHmz/n4fB3e11Y7YXX3ix7TPBKr/Q=;
        b=GYE8JxpC/XsGkeI4sBpOQ6DJvE77JIlVnRsWlvafhf3pFfJET9MlXd8nPF2d5DgUP+
         30WS2GXdlDp5aokJ22hMIPfJsRLfyGU0uIcm0w+YRP3oBnt0PJjqL0VfCVv6cMUmRwdc
         1cnijDYPjmej/v5Qh8w8xNAlXKNpPqzt0UALSXJ2Wij/wThr1iZrHgNX2RsIv6YvstCf
         65nNWEzTdciPyY6MSNg6KVCUPq/yYaxwVJrQ3Twvabjqwr7fcYH0ABw6WLAInNcndsbv
         lGmqZIkfUzo/vmfc90H6TitpSeBrfZGWZ0O+q+qM7jL8CdR5Sf6dX3kw+KbaUpskv2MQ
         wnDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793969254; x=1794574054;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jbz4ViRXJQJmGQTHmz/n4fB3e11Y7YXX3ix7TPBKr/Q=;
        b=ScVjUFYRkGVQ8Jwuq006Cu0uGXwZXuk3gtJ44o7A/m3zQRRM2k6hX+rOQczN0pDco5
         z4IfLUqujJ67Kq4ALCu1gTkwbrgi63ur1Y8tssuRVd5/zFpUZFZ2trcmby3BspBVK67h
         MbU0yo83iPxxvjjT2LV2pFS+aQCwcbsrPOLnFjlaPceLBIpfPdky/lUfATse3SgLnAIg
         8Y+0J5wMMMi2T86UZD2pmA7NplyclnjanKRvSln8kdXJrteqS7mmggrIYk49Ij1ZGcHa
         1ecVc6nW4hz9ILxuTXvJe/Pl+xfVrn2FUrLeupoByYaD4LKzERcsKn5s/QesW14Jew2r
         fzSw==
X-Forwarded-Encrypted: i=1; AL+hErEUFm2K99fr2jCqFjc8Qd4Kb4n1moN/0a+pjjarQg7efmVcS/Mi/TTuYMoXNXvwG3fCHscHSG4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/XhMroHUMtJhIMJumL7VOmgu7tbrlYqb5S7G8swZlMJRLX/k7K
	DcIFtJaVZComScqWJCmxVk8h+DLKXYk6TBkH0ZxVuVY2e1LWihkz08GeJu7afVw/YwY=
X-Gm-Gg: AYBFou1eQoy8Mvln/fTh54U76MKYMTHwybz23EPYnJIh0dQmL/FaX/rRVkY+zH+T1UX
	blPNhsGjw6Nosn4TZ97ytFHhuqcfinj26g6urlxZ9hHl6gpbJ5IF8+tAHXVkLBF0Ni83waLtoWF
	qIjA1Q40ImEcKuAl1QpWWJh3JqUkiG4q3xTlKRfGUXK86haeJEgjP1YCe0g7AE8eizYKXIXbPmg
	BcM2YwbJRl5JrdneNJNEB5Tc60K0/pJF2u5cacSc7baXwzEjbOiME6pP0qXWR0zSRB1nqsJzK4w
	EVP9hP9+mHJnY1xDoG3df1/mf6AXSn74xpAouVAp/Bhauaol2U8+IZeGfdrOV6nn1fb69O3pPvB
	dheclwosmLDeHzciYkMVSmLzNKyFZzpir+4mh3bALwo+yDydjZuiZ6NgeqONbSyE2UCkU82rxI4
	UBON6jeBX0c7H9nx/Z1O82qV7L8w+xj5rthHWsiSkyEZVibny3/UimY4YcYTPfJwKuFxVr6fuTM
	L05cDq/82qFuP/bYXxl8HYDQSogSmC7j5QOy+Te4VjSa1sWhXBNvCpztckETjLR6QM89vT9hR4L
	hy6Al7GP5HBqMYnqcmI0v3vEfV1pXZ/TRaaDwGxAA5hLSvdIMxjupOrZLJIsmqAhaaVWLiIViPr
	IPoMBqwlrhCrCnGYFLerW5dRbul+crBDQsKEKYA==
X-Received: by 2002:a05:7300:ea18:b0:36a:12c4:8bdd with SMTP id 5a478bee46e88-36f7554337amr3612023eec.21.1793969254337;
        Fri, 06 Nov 2026 04:47:34 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa30138fesm6844272eec.0.2026.11.06.04.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 04:47:33 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: davem@davemloft.net
Cc: edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	n05ec@lzu.edu.cn,
	ylong030@ucr.edu,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sashiko-bot@kernel.org,
	dennylin0707@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH net] vlan: prevent cross-netns MII register writes
Date: Fri,  6 Nov 2026 12:46:39 +0000
Message-ID: <20261106124639.12584-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
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

vlan_dev_ioctl() forwards SIOCSMIIREG to the underlying real
device without checking whether the VLAN device and real device
belong to the same network namespace.

A VLAN device can be moved into another network namespace while
its real device remains in the host namespace. This allows a
process with the required privileges in the VLAN device's
namespace to modify PHY registers on the host's real device.

Reject SIOCSMIIREG when the two devices belong to different
network namespaces. Preserve MII reads across namespaces and
allow MII writes when both devices belong to the same namespace.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 net/8021q/vlan_dev.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index bca0a3693636..0d0904103302 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -416,9 +416,12 @@ static int vlan_dev_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 	ifrr.ifr_ifru = ifr->ifr_ifru;
 
 	switch (cmd) {
+	case SIOCSMIIREG:
+		if (!net_eq(dev_net(dev), dev_net(real_dev)))
+			break;
+		fallthrough;
 	case SIOCGMIIPHY:
 	case SIOCGMIIREG:
-	case SIOCSMIIREG:
 		err = dev_eth_ioctl(real_dev, &ifrr, cmd);
 		break;
 	}
-- 
2.43.0

