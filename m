Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB77423ABBE
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 00:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780965469; cv=none; b=ODw6c6pryG16I76TufLU8P+TyUEPkGwMBppH5+r3yLiS91hrw2dwnE9avJ+ITndLZkn7QOUi3D0SPNdXau8OCNBijADzMJxV/B4GdbTF9+DeXNoKifz5ZVcvDJr72ckl8XyTBIFuSf5WE7PmC8FLELR8836zWuql9nJ7ynBfP60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780965469; c=relaxed/simple;
	bh=7dVCoz27J6syQHd7WaarXukg1B93myoCROqxRVJuNgM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tbk1riXTYjXQUTsHChors4ZVcP2+DNshRRzqp8Fic+zl48bmLwRgQqW/sdR9+ttSCBtGnWm05RmRJKsMvSleTRZfN1aW/aj2M6hS4zUFhGZcbsbpAoblhm+WXnOkSGvQCPxbcPB4LAKtQtQFZZZXy/N8F6IpgIpHQYBHs/DQ7+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=P5iNWwlG; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="P5iNWwlG"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8ccf18ef922so70584706d6.3
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 17:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1780965467; x=1781570267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cqiPHXkggCXQQpn1mhD4wgCcbTS6X06hPuE4jN0yLYU=;
        b=P5iNWwlGX7l3Ri9su3/+LREfWC6deVG42HFZlLXorPWW/n27q+hdYtRULwbaVi36sY
         h2XBAOFsqh4Nfu2MkriOVkNGZrbGbRxIVKsiaxMo+9W2yZXG5RDrxf3UECXmrSjgyMQr
         HBBxOkFklLGHz0UVDBuSdCaxSn3AQ7VxsBBu3g+ZWbEBT7z38RpQqgQ6WkMxbU0BIX00
         MJPUsfH163ThQjPfBIpx7dyzqm4Ast1Ehpr6O4uV/GwF/rnGDsL+W1ZUV2znPshmlvT4
         O3nKUYTnv3hHXTK8llKub7zloCNaZIV1gyfAZWfx+njXaVAjh6EXzK2SpJV71XVsTVeZ
         ApMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780965467; x=1781570267;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cqiPHXkggCXQQpn1mhD4wgCcbTS6X06hPuE4jN0yLYU=;
        b=sO+ljYjrCLV6x1cXk28zQlwaN74Ey8yPPuXbRZov9GyV4Xu8YVhKpdl44Q3zj00g6j
         3mMYd6S5+xCLDAyw4A7tqzmiOvI8t4oN0a1ldNRHHKXP+6SesrD8Nx3wXy53vNK3dHFK
         rM0ZuFHdbRq5+MFbcQNMfLFokvwRJ2aDwWJfm/Eljgl4FJEyjiOFcxUXBHRVeiS8Cg4b
         s9wkQRHIBNpYWLQWI86VFRpg7rcXEQ+EscRMM1LdimqTuh6gbRcXtqUt9I8pB5VJYlTd
         9CD+Xnd17vWBv7MHnCnIpJ7cmu3VpkLDbI3tzGHT9Q7gL6gqPlmY7ny7bPPjSw/1enQo
         S+UQ==
X-Forwarded-Encrypted: i=1; AFNElJ96TPNPbTgdxmz1dqFQRrpkY3++ToTNThAda73Xvo40xLmTlGD7hQ5zqRAy5jRBVD2BGjJ6LXo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1g5ydx69gOkzW0U5spD2+QYIobuHaAHGyKpoxKD62W+GueZDR
	4SCvnLgT3o76Xvum9KuGCf5S8btO515GyRAQyym6CslWcqZbIimi9nneT00BtQpBrcE=
X-Gm-Gg: Acq92OG/l1DG6mL6mB5aif07Q83Vrve+A/sXH0AeAUIMuL+JpnaBocg6LKdfhX8ZmRe
	YVX7yA2y2Pa3VLx1nolezY9jjC98QnN6vqXnGm15oRXoDSu+gwKVkVE/4a/CR7ijSGzfEzkH6F3
	TPQUOOuqS4XfTL+LVYTBvfLax0OcE5n5xnwWkcNL7xZTCt0HpMGMdhEgO3cYGoPuVkadTXK0gmy
	r8F4jf0KifpXW5MCcNqrQJeekSf8aDEyhZzSgTBi/MT32yGeVzfMnRE8vL4ZMT9m1dU9U8xIHMk
	4+4UuA9YFVD97BkpXn45ceWxGUbwXFXgLYDVAEploT4XDdZAL6iIKH30lruYzsa1zljQlvTQcfe
	+3lOQ6rV1ESiImBuFExqe4CtJyxdhQjadHkBjhvwp9d7HBJGkdRE8zI+FTxoTixJ6YzTDRXM93I
	SrMXeBz5SMZzsT7e8de1MCEtMrOzncKjLJfn/dUQ==
X-Received: by 2002:a05:620a:480a:b0:915:83b1:fc30 with SMTP id af79cd13be357-915a9e0e8ecmr2996308185a.55.1780965466934;
        Mon, 08 Jun 2026 17:37:46 -0700 (PDT)
Received: from localhost ([161.35.96.86])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-9158a40d566sm1894363685a.47.2026.06.08.17.37.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 17:37:45 -0700 (PDT)
From: Samuel Moelius <sam.moelius@trailofbits.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Samuel Moelius <sam.moelius@trailofbits.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org (open list:TC subsystem),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] net/sched: dualpi2: clear stale classification on filter miss
Date: Tue,  9 Jun 2026 00:36:59 +0000
Message-ID: <20260609003658.1237966.5506cf1b9345.dualpi2-filter-no-match@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DualPI2 leaves previous classification state attached to an skb when
filter classification returns no match.  The enqueue path can then act
on stale state from an earlier classification attempt.

A filter miss should fall back to the default path without reusing old
per-packet classification data.

Clear the classification result when the filter lookup does not match.

Assisted-by: Codex:gpt-5.5-cyber-preview
Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
---
 net/sched/sch_dualpi2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c
index a22489c14458..8d345a8ee4e9 100644
--- a/net/sched/sch_dualpi2.c
+++ b/net/sched/sch_dualpi2.c
@@ -378,6 +378,8 @@ static int dualpi2_skb_classify(struct dualpi2_sched_data *q,
 #endif
 		cb->classified = TC_H_MIN(res.classid) < __DUALPI2_C_MAX ?
 			TC_H_MIN(res.classid) : DUALPI2_C_CLASSIC;
+	} else {
+		cb->classified = DUALPI2_C_CLASSIC;
 	}
 	return NET_XMIT_SUCCESS;
 }
-- 
2.43.0

