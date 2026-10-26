Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793038296;
	b=re29EZ1NX4pPPrpXLsBK12NI94buvzfaqbghFm4jPxrk2yuRdSy/+Aa84bPekPgLIJPr
	 RpaWko4jmdv5nCmwkTk48Jl+9rIXG2cBQD+aF0ECDqX9byZZ8Z0RApaVf8QZalLISNPbb
	 fm2cDen4MMq5CSb7b8SFs7B3gYGgVe7B4v9m6E4u5mJa6L5GSStIgVu9OQ2JvXeZhotEa
	 ys/4chegWHsYHkL6yIiGVCtTVZ8dmXHHCxUnXsXNeGh7fmXIept2p2ML3I1AqoMG4oiJs
	 WmpBygorq2RL2brRjxporzDlMHlqBTe6oJUvhWL7/ztUWGl7UawEf/RSFaqtgg0qVtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793038296;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=DOHXnXj9H0hCXUUYqqbghfjLZTExI37IMuLDbNTswLI=;
	b=KTlZTWoyD4zkk8mzmg2lBersmdF/U1cGlrSVu6zp+OfcE0guyWHq+vfGZ0nDbSEpOmN+
	 eHrP8hheGgPFRh8Z++S4lgZdzgC4REdDemURjgkgeydIWRbyEj/Dq8Mh705MgiJjMHm3B
	 OsqwNpYGnc+tI0KuQvQYbaunpA6kDBfaMDZb0QS9d57PSjqTT88dlkKzLXa3QmjuUXUnY
	 SVuXyt5Ew8955iRDINFBJC9SwJ9debS7Jr18wSNytKH7ZgsHHYxi52JxFwy0zXy+BKxMI
	 q7EKJlOJXk0/8kj7MyHdlYiErb7LPViM2tju9+EcjFNd55k/qsa72FRmEFXPs+xJ2hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ikb8AL2S;
	arc=none smtp.remote-ip=209.85.210.46
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6B1606A322
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 18:11:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E6B1606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ikb8AL2S
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-843ea301d60so2469793a34.0
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 11:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793038294; x=1793643094; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DOHXnXj9H0hCXUUYqqbghfjLZTExI37IMuLDbNTswLI=;
        b=Ikb8AL2SIUHtQX6nKqbGaWfJAD9nof226YhE+4uqJmXEADlwn9CnDUC8ig+jNlWeE8
         4ztJ9NmevX3zWRYsysnHU4jT4oIhXBam7FM+bbNp1hyuR5dZy4fpKvvOjFp8eDJkpxuK
         RaOyGvSNBpso3ZsvmbsCc/4lRQLkNYFg3vLbiTuDNXr2Ru9wdJEJfXXDE96tNGnbdrJn
         I1PkNLonsk/pSdDB0kmubhjkM60Cbo93Bd9at6DrIG7pRbB+/fpIRT9iHPcsqq4dF3DE
         IidDLhkn5F0mg9vv0XN4Xii/N7C04jb4kqvwdoQB1ucBtiwjh04DbiUi4ySpL22WJyQj
         9nWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793038294; x=1793643094;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DOHXnXj9H0hCXUUYqqbghfjLZTExI37IMuLDbNTswLI=;
        b=GHp+KMdvsHFxBPR42vzA99JELZDV12CH7q7O7zsNb2flGry7PlaLYZxNMP/R1Dhvvf
         WhRsdC7oT7cQ/09G71fiU86n8WkYe3spcX+GU25GGB4claNDW1xQoPeTb8/CnqVmi1EF
         wzh1jOOoxsE+Tbv83tOJTrc1WZ0xtkBV3Wfh3r/99ZkXsPC71bm+PjNj+8rUZYUpfzmW
         BHdROt1lepa6bZYK6D6pshzQoKLhXAsoR4CVHWN3XEng3vsP7H8qleDtBBt43Zbkb8fh
         KhrSFpoRgg0p5Qfi5OfHvVBdH3VMLj2SrNCCijR2/s66z+KSKw1MQ2oISTAT1fH1aK06
         uGNg==
X-Gm-Message-State: AFq9FYJCSwLGf2zDiPjpIvN8V8vHANPA039569B66y8Y1OdmV//crI04
	QpdPEwdAws4W8hAeB98DZCE5yatm6CZ42Ujv6u16zpe1D2SQ/j3Z5G21
X-Gm-Gg: AYBFou01g130wI9J5fjG1I+9cUEgSSP1+4qB7iBNlM/gwU8s8JnRTo9sgPXAt+igHD7
	nn2GlocBfOMhGtnaGO8puHBc/oqA3PrbSyEJ6LJmpwP8AsATI0EwKXmWtF81noETDAhhmC5idYA
	uqnObYVu5eTXzIviSqHcYlIowoQZvu8J0vkW+CAF91AVc78XtOrPTI3+wmPcSZYnZ2ULE8S50M5
	WW1A1Rj0RqEHBdmBWk+U6/O83QGJXaTCc1tALudTE6oS1YVPOStWUXSk5AoAmWBo42R3UzgSSu9
	PadsK4KqGolpWFRDKeq7wv+TlH6B0bZlUe3pFVO9V8T255pWTtMLT7CUG/PqDMNAEX1OLJg67rI
	o60u9HioslsUm9LPOT8JeTOLctqn3S9TJ/SVnbw8FKmbMUNhZdigNbxJQKAxMCUPTu96lu8loeH
	FTs7mwjgWuGxwmmilsRzEs8PQjz1q7pbl/7Z76zpg5hZQDrJq/cVfWzCYMEg27eN0SnB3RpP5mb
	bLNidHUf4/FapKoMdPWXyVFx9M1QLeBtyVnRjHwrm+/H03/bVkoWYNHMqzcZbkLAtlgQPGsUOXI
	fOT7SAFASGjOSJ2djvTMU78IOCFQl8XGvfT/arpXr+kGiwzQ0Mg9WmdnVHI3Rla6zcxPxI9G1FC
	mBARvhss4LdHuNnBenI0ZhSCTbMFvuJzWk0x3M92cMezmcB3sSzVqRY7EwfUaVSD0ZRh1OfU1CX
	Uezg==
X-Received: by 2002:a05:6808:4f4c:b0:4bc:cf33:7024 with SMTP id 5614622812f47-55c0032db63mr5825660b6e.42.1793038294530;
        Mon, 26 Oct 2026 11:11:34 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-55c043115bcsm5795251b6e.15.2026.10.26.11.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 11:11:32 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 26 Oct 2026 12:11:27 -0600
Subject: [PATCH net v6 1/5] ptp: drain virtual clock sysfs operations
 before unregistering children
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-ptp-vclock-sampling-v6-1-e705612541f1@gmail.com>
References: <20261026-ptp-vclock-sampling-v6-0-e705612541f1@gmail.com>
In-Reply-To: <20261026-ptp-vclock-sampling-v6-0-e705612541f1@gmail.com>
To: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Yangbo Lu <yangbo.lu@nxp.com>, 
 Miroslav Lichvar <mlichvar@redhat.com>
Cc: Eric Dumazet <edumazet@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

Parent clock removal walks its virtual clocks before removing the
n_vclocks sysfs attribute. The mutex taken by ptp_vclock_in_use() is
released before that walk, so a concurrent sysfs deletion can pick the
same child and unregister and free its ptp_vclock a second time. A
reference held by the device iterator does not protect that separately
allocated virtual clock.

Remove n_vclocks before walking the children. Removing the attribute
prevents new stores and drains stores already running, without holding
n_vclocks_mux across a callback that needs that mutex. Skip virtual
clocks, which do not have this attribute.

This race was found by code inspection of virtual-clock registration
failure cleanup and parent removal.

Fixes: bfcbb76b0f59 ("ptp: unregister virtual clocks when unregistering physical clock.")
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/ptp/ptp_clock.c   | 5 +++++
 drivers/ptp/ptp_private.h | 1 +
 drivers/ptp/ptp_sysfs.c   | 6 ++++++
 3 files changed, 12 insertions(+)

diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index 4111342d64f0..47ffc773065a 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -508,6 +508,11 @@ static int unregister_vclock(struct device *dev, void *data)
 
 int ptp_clock_unregister(struct ptp_clock *ptp)
 {
+	/*
+	 * Stop and drain virtual-clock creation and deletion before walking the
+	 * children. Do not hold n_vclocks_mux while waiting for sysfs callbacks.
+	 */
+	ptp_vclock_remove_sysfs(ptp);
 	if (ptp_vclock_in_use(ptp)) {
 		device_for_each_child(&ptp->dev, NULL, unregister_vclock);
 	}
diff --git a/drivers/ptp/ptp_private.h b/drivers/ptp/ptp_private.h
index db4039d642b4..ec8633126d6b 100644
--- a/drivers/ptp/ptp_private.h
+++ b/drivers/ptp/ptp_private.h
@@ -169,6 +169,7 @@ extern const struct attribute_group *ptp_groups[];
 
 int ptp_populate_pin_groups(struct ptp_clock *ptp);
 void ptp_cleanup_pin_groups(struct ptp_clock *ptp);
+void ptp_vclock_remove_sysfs(struct ptp_clock *ptp);
 
 struct ptp_vclock *ptp_vclock_register(struct ptp_clock *pclock);
 void ptp_vclock_unregister(struct ptp_vclock *vclock);
diff --git a/drivers/ptp/ptp_sysfs.c b/drivers/ptp/ptp_sysfs.c
index dc398c6b7528..53388b123198 100644
--- a/drivers/ptp/ptp_sysfs.c
+++ b/drivers/ptp/ptp_sysfs.c
@@ -263,6 +263,12 @@ static ssize_t n_vclocks_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(n_vclocks);
 
+void ptp_vclock_remove_sysfs(struct ptp_clock *ptp)
+{
+	if (!ptp->is_virtual_clock)
+		device_remove_file(&ptp->dev, &dev_attr_n_vclocks);
+}
+
 static ssize_t max_vclocks_show(struct device *dev,
 				struct device_attribute *attr, char *page)
 {

-- 
2.53.0

