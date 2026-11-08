Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794174327;
	b=4B6BG1S35k+V68RPELvWfWwrvo+8VAKRZpBJWajgP0rVd6Tfk4JOe1fBsNFJgd0OWeDw
	 HakdtHurUbYb9v+EKsSSuTqQGYQ3qPyrpNS/6bhVTYdYjq/N5wCtxUoor+5jShSQqxml5
	 OhtvVdGZoMym672aXZDPh3DpNQKHxU05ilrDn40CkrIfzBOTxQyTXwHZcTthg1iqdG/kG
	 f7BuEYwxgg6CaicPzlN5wEAXeV42fxRXGIwm80/2HCKPyDvM2jKa0IhjFr/QtBBzfke3W
	 65nSGzLLKuxKTBMRqbsmB2D7DXwcu/6WqOrNebz4F0TzuTNsEpYOaxxmF0tTixOTuDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794174327;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Z6qsKejGug2sNisulG4c9FY0DKxN3PKWlr+7E8JUKfo=;
	b=r43PzSbvqesH1W0krXnHFmskgkVOPV+pmi6uy34ytWwMMIV18jt05o1u9I+CbS6/mOOX
	 n1N44I6OApT3+BbdDeVMiWA3WBW6nRrSrdbSkVgH3aP466cVSAvDuB/68MoScQP9JOlwZ
	 bppx4WYzis4tIC9mHpSgeiDYR6x7hzU+zR1M98AwKHp8GfyxLg2J707a4Qpyv09oTBq0A
	 5+s5alkK1fUSzZSy0H9PpYHclJ9Yq4rReBj7bYUHs7v9SXMqsZIyUjKNfKjihNR918UZ3
	 N7zxDc6GvfEbk9QQSyHk6GuBoqknFxVDtlTnfZMxSnV2zuT+2iT3vhWhcPSIYHi5mnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uIniuxtr;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCFF606D802
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 21:45:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBCFF606D802
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uIniuxtr
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e977109392so1249145ad.0
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 13:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794174326; x=1794779126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z6qsKejGug2sNisulG4c9FY0DKxN3PKWlr+7E8JUKfo=;
        b=uIniuxtriHntxbvbeL4mp3CAX2eRTO0I5fFcfZVvz2hPhBdp1WMReQspbGh3OA/697
         Nt2FYUMaMvD/ay8l06g6dmEBj+iF+qLcsTM70HXrZd9VW/21vxZKKwizgxzuH6ahvOoY
         s6qmvE07gW5Oi8FegF2dVg8Qrm5+2SLnXYHwthn9P5zmh6R7fk+Yj9KiinzWUMdh81+3
         FZjALoM2XuA5m6a9+kNH1ZMzUwf4U3AKyGNZilrbjZ4g5OKg+oScvtI1WEBL1XdmyBlV
         mlhqsNBkrLHZhtJifxqETkodXBvZaDQcIJd4ZxIUA06Bz95dDh0mcM6ywQaM08NAO/Kf
         trFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794174326; x=1794779126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z6qsKejGug2sNisulG4c9FY0DKxN3PKWlr+7E8JUKfo=;
        b=d54nawuA5hfGvUKMEJqN2tgwkrDapu3tpG09RxALpCF9T9LDOZg8srw09PEW0ORKkV
         NztcVOyMGokBLe9yzavBBsFcIJPnHzQu8jpIYaAN9MFNES5b5o4+1Y2+iItbdwJ7irDD
         zIsXG8DL70ny8zujnj4mbpqk131N0xzQst5OoH9t19zp3/16plktc8xj4xe6dPVR0Fo0
         R51VyveqLJMkVBSDz/m/00dwA0j2N/ub40ZXJ4xwXqnrFTrOI53uiVPIYwrNqStZA/Oe
         iIPLtpBfKUfFPLP4rZgNCsZsVBmyla/gzw2FtLjnyXZKW7eq1X1tta7fNmzLqrHbu3+n
         sCdQ==
X-Gm-Message-State: APuU4Z+oAr9lYN2Uo7g5XWfo8a0vyk8xqljPGHQP4BY4XQJMbcvIl5IJ
	mmPVbBDitEtqCUgKnLrY61Z066hy9oK3mtBHvE8i/zS2zRyEjDXTttgwM9TOvg==
X-Gm-Gg: AYBFou0q+BYhYIuXoHcEd3tAVHQwpTAAoctDq4ye9hzeSELYrpb8Y4QmVp5iMae0I5P
	g18w3+1TwFO3e3Tm3jYVu/Ol5KIFwT/A+jHCgbheeKvzaPfVW3d4AWdhZFFps+j2wZL6wNzX6KS
	TCEncQNatjZSMOrTzWDXy7gIgeXvvb8dWi3h3a1tWh9XA9sXwSpoZrx6U261Cb3A7DgQ2/c0kUC
	Me0Vbt9S83tdKW7rYU7Y0Q800gvOqXF/zRsx38yt7bIEkx1s0Mv7nne41hpJLcKskUV33QFfLAh
	ORT667hYw7PA1k5jh8MqFvR3Of+yBo9j4EAYJqSFL/5gIOulQsDY7M3zpQ++7aEUXmDWQQ44ben
	dvZxYuh2aruwrujufspkR+VASnf7ZtqXow+Em6MKKLi/COXA/TUVwUIMR3azCG5+vVFwJGYEJ8k
	F73f96YJT8TD3YzmyxgUD4Si+a2BKF+dlaDFNqzL7Y+A8iy8S1bV0dNRG+mZ14OR/MtzxkPsjNk
	TRApiY/ph1LcXJCNBMqgaDWQ7U8vRQvHpFVPpwWaHKA8ZA2uvFuXi8VBOYbgJ2mLeeG92JGtLg1
	6TTPdz+Ty42lOIQwBK9sBKD+IC1yJ5kHT65xkCk7/Tx4t20xRg5aakQyDQnFUPRWknU5kGnkaM4
	w
X-Received: by 2002:a17:90a:dfc4:b0:3b0:a7da:d244 with SMTP id 98e67ed59e1d1-3b12d4beabdmr2746884a91.30.1794174325799;
        Sun, 08 Nov 2026 13:45:25 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76a0:28::1d2:30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1034718f8sm4619463a91.4.2026.11.08.13.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 13:45:25 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 6/7] net: dsa: motorcomm: Report inconsistency on bridge join failure
Date: Mon,  9 Nov 2026 05:44:46 +0800
Message-ID: <20261108214450.1662362-7-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261108214450.1662362-1-mmyangfl@gmail.com>
References: <20261108214450.1662362-1-mmyangfl@gmail.com>
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

DSA does not send bridge_leave when port_bridge_join fails, so a join
that fails midway leaves the port half configured. Rolling back from the
driver would just issue more register accesses that can fail the same
way. Set an extack message on failure instead.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/chip.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index 46534127d070..3d4aa79ac026 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -1433,6 +1433,11 @@ yt921x_dsa_port_bridge_join(struct dsa_switch *ds, int port,
 	res = yt921x_bridge_join(priv, port, ports_mask);
 	mutex_unlock(&priv->reg_lock);
 
+	/* DSA does not send bridge_leave when join fails */
+	if (res)
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Fatal IO error; hardware no longer consistent");
+
 	return res;
 }
 
-- 
2.53.0

