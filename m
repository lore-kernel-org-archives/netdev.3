Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5075778F4A
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 09:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788774599; cv=none; b=r1+VcvyyQIzFLboSfUkSlf7PLe/DRi3po0WgIOt+jJN0bqHrEWbKrcKtWU9rSvO7G/cce2Nfs//VFbEFUWyQ2b6RUNx1VGEUqTL4m7cGkqM165DbeEtg/kTvZ//A31Cymmgn7ZpVFTf26Rwr/c125At52xcYCSH5QEUbLoq+yLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788774599; c=relaxed/simple;
	bh=iLBB57PZ5U3pb7SS7fqcg5Rhd7j7cnvqUvLtPUqFASA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XqvaZSIh8ZHua8clY05uGgJc1nLoftgRba4+hRW5imeTduWUFz5UrvnfzsY4pMBqN0iC4EG7ZFV8fAG+mbtbtXq7RppUmcV0JkgdMAqMTTPo6KjcFpkKo3ayeTe0pAk+6N5W0i9JRaSkoDdQ2xbjgQb2JVWMpVExy5RwNrsUcJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MTJPYR6i; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTJPYR6i"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c9e607d81fcso1826171a12.2
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 02:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788774597; x=1789379397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4Rc67cTd4W9vIL1rwpsbclZB6rOxxrOtQ39JEau+6IA=;
        b=MTJPYR6iIZnbMO0pBe1GEdvXpBh2rVdKqq8goORy7mrna5xJVfjce6p3wg1Pltt3uB
         yaWCW6gDSoy6pWE1s2KO+WcyTVLFuEbHbCsEiJkICimER/QsMNcCKk5k/LsyWDrvYCwd
         zwcilDBQNDBTLhH2mLAOeaowZucrOSkvajay2vq5mQ+gYfig4DgN/A/egf53LIChqAyU
         khlOP4ZsRlTkElqaTD5vkDCD1PTFNLacLTZRx6HTMDQQTufbKgL1ZMp4O+G4OkNM3tvC
         g0nH7whtxHkOo4oXx7OWRA1i4O2FwAEeJIRBVDEH7rpApkuTkq+3lvWyZEdJOjaPAFh4
         Abtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788774597; x=1789379397;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4Rc67cTd4W9vIL1rwpsbclZB6rOxxrOtQ39JEau+6IA=;
        b=ceH6aP2+CDVhDrPwNRMIffD+6gl8YovY82g59kwGT2HFLZ92dNLH11EY95VX6hZokg
         GXn18bzeA7tIgYIkCU6OMqrTlBFt4HF/pnExSGxYF9aWnpGWIfoQC0b0B9wOPHXPq8Ml
         t6Gzh8/sMm0o2W/IApd9CgxWtMiFaiWmF/4/eLEDeidVoJSkmOJKW0rkIB0BK0RSOxFw
         H81XhZTzf35WZpnjnPjRCvS73Ly1u1H1ee6wxenPwOiRZv+OJeYZ4WMIOoT0Vznyp/p3
         6ZP9Ek3KYvPq5XNWKmnFfyJSCL4k8LoFTonlU0bkYoSRJ9FebNcHcxEGo66C9TkWCaDB
         SI9A==
X-Forwarded-Encrypted: i=1; AKwUvByYJPpaAkPsgtsJruz9ffEHuxOdTvWgYE5Aqc/3TG8zbfssWZKjEpwhNADz7gynFBwfQJJby4U=@vger.kernel.org
X-Gm-Message-State: AFuF++nim6YjI4z/w1fHXqF6XnJTMNdmQ5yvSMG4zviwmF1piHZ8L2Sa
	093wrGGG0taIGW674Q+8L4HML5mpwDHIEJ4qjGn/i+7kbz4cW0bq91uF
X-Gm-Gg: AYBFou0+onHUfr0mTfUfhcxZfZQuoG4e3hEGHkzphDYGaX1CDm0cayTL9/iZnNP/kSg
	31qtuqZw/pfqg+d+eD3jHgVUVUHW0MBYeIeTnH6HPlu5cEt8dYAusz0dtA+CdX1x6st+GtfEEQb
	bwOgjJ8/wWZDIBI3igGE5C93B++wLALagf2srnwMTzNVFsyf6egN6d32KFuMnxZr5J/PBn6p5ae
	/sB4/zAZDxtpfQ4LtR059Bq7EZ8HAczvwG0AzBIjh1zjC4Jz2zXb9U6EQfJPom0Mca/84oivwFe
	ZBYL/ZwCKlbFSkQDkZpua1Nw4aW0HR32NlKaVR0xgUMe63hJx7iP+MWzIcQhnpKo2+zVMd5dU0U
	c09MZtmxFJeR5LvZowXXUm/Kdjvz1lICDQKcSiDLE7vv00RQbJaSkn9G2Qyyyyzekb8+JK8ybmf
	zZjsdYx6YpGh2gwvRmxT4pqAKGPwCsyvPzzaOheFNsmJ9jKutEBkKy9EYtignuR3wFkT6g40+4j
	5o8upTG7c0W1g==
X-Received: by 2002:a05:6a21:828c:b0:3d1:39e9:b267 with SMTP id adf61e73a8af0-3da39b721f7mr33007088637.3.1788774596398;
        Mon, 07 Sep 2026 02:49:56 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339ac24d7esm41895888eec.15.2026.09.07.02.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 02:49:56 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Harald Welte <laforge@gnumonks.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: osmocom-net-gprs@lists.osmocom.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2] gtp: fix repeated word 'to' in comment
Date: Mon,  7 Sep 2026 15:19:50 +0530
Message-ID: <20260907094950.18606-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop the second 'to', reported by checkpatch.pl as a possible repeated
word. Only touches a comment, no code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---

Notes:
    v2: designate the patch to net-next and use a subject prefix naming the
    component, as maintainer-netdev.rst asks; v1 went out with a bare
    [PATCH] and a "net:" prefix. Rebased onto net-next, diff unchanged.
    
    v1: https://lore.kernel.org/all/20260907063804.26581-1-hemanth.selam@gmail.com/

 drivers/net/gtp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 69fe5717846b..4aff23bcfdd1 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -770,7 +770,7 @@ static int gtp_parse_exthdrs(struct sk_buff *skb, unsigned int *hdrlen)
 	 *
 	 * This length field includes length field size itself (1 byte),
 	 * payload (variable length) and next type (1 byte). The extension
-	 * header is aligned to to 4 bytes.
+	 * header is aligned to 4 bytes.
 	 */
 
 	do {
