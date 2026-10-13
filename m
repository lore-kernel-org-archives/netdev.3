Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE94453ECFE
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 19:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791919192; cv=none; b=iGPvNKpPzgF6e7Wa6UMA5eyehRbe31dmKrta5voct+vaZqvEPczjkM4DbA+6ZaQalEuia2qBk7+12OIBoeTjcWgGFLci9UpubeZazsA3hRRfjaY2BURz900ypDOSgjSbv6e2GEwJ6kwIV7voatnTQjYFw6xxwDGJ3r9XkiB+JHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791919192; c=relaxed/simple;
	bh=gIMYuS9JxR7CPdiCa2tA60WVNZMmxDlDk7M0OBLgqkE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K+gDqsSIdSUKnICuBE/roVLnBIslKa7xIsS7J4ZCGjJQa+TLsypMkL5WC0s8d1V4xBGtGRHv1iEnVAX3AF/7gsY4bRbiZyLhKvUaWilWQEgL+Q9X3RekxdZXCh7OPyowQzI0jmLKmayR4Ayi23mrQh7d9apklqk2nFGnyXQcwnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OJlO8KcF; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJlO8KcF"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6dfd530a2d5so1800112eaf.3
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 12:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791919189; x=1792523989; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ye8Z53vHx1EFOnkJGmfg97MMg0sWXfEXyW1OqzDyMg8=;
        b=OJlO8KcFaiEJ9lDwYyzG5TxxXC12aPyIkDuFaOQOoyBV58DOrmfiR+XEKSVWGXW5DJ
         KeZojC9RjJSPzmi8sB3C0h2PAT6j/eL2j/4S/l7Xpr3Idjm9EmdfS8geUT04MK59LQhY
         lOrQm3zAQhBhMzwXxPlj3/vLTMdtoOBcH5AVGQuHDCawc33WlQND1lGmCtku1uFV+4AD
         AcLV+Qjc2YPnW9jsHn+rh8pBKuQ9Q4vrFR102SrAK52szslUHouwcRtyr40e5X3INgSP
         qAhuNwJ1oIjnlmrrHNj11YCoPv0MSDcvMpM9rsUcCck+fx4x9GlpW8Xr6W0+kv19HNbH
         Epfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791919189; x=1792523989;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ye8Z53vHx1EFOnkJGmfg97MMg0sWXfEXyW1OqzDyMg8=;
        b=GxUS3x5WG2fp7BKrFEjoq7RD+xzDMBIwBA5fThniOJLVOUXXjNvmNukkmyYyabyC4J
         udOHPnaXmhr+RqS4NaV1+08pc99dbz2FMCIwM7/rpg3muq88qWsaN/bLoeHfAJR1840j
         GtFYpWNhR+GbjaFLr4FfxFPy7d1ZB4w7bwgW5wthSKlQU1fh79DLbbMuNn/48hxVzAij
         /rE2YF655mp4W1JIpSYLD6NFCDggbLriik3/2eNDlzqml3PHVY9AFh7r0u2e5pH77qjK
         yu105QZbPsyvpAEx//8i9FBBZmOUwGiVD5wDU8tr5RG/NhMKX95LZM5ueDGMQoBmiuyo
         psZQ==
X-Gm-Message-State: AFq9FYK9yTqLpJvsmp/+0mQc0lC6qbE/cta6TGvSrxU0HhY11/yhtUck
	g3yXCSMoQETcOW1paHp2wHWELfjWPlcuOUrd/EikN6SDPpejXzQHSbZzFTShpwfg
X-Gm-Gg: AYBFou1usmcnfuqDzfu9Ckoc2YbAMpGHgCy9yBjKiWCqc/iJPle1dx9LG21KmhJfYfS
	Yw7trG0wpgks1u/HZ13KCEk/69Huh83gSwiABjFvLT0JNNxgY3ZH68SdAs3IGpHOOnzYpcJify0
	ttWmSxamhkj4aRtwMpvuVyPhvega445K4IXCNi98PqPbZX1IWb9/d9Ul9Lp9kOX6qMxdViPtQGY
	gh0im5I+uktsDyxrklcXyWDUCUmAds/V9Bhyt5lYQ/Fh8CV0bYBgGC22ZTZHyjx7tLNe6qO2iFf
	IyUUPj0h4o9XaaFD/qluB6FohOkOqMT8MRJRp3hR6XMx1tEZVWXqbLwHLtNdBfpH7xk3s3tRJ7Z
	gd81JUJqN0VxRcLbUiamk18zAOMJ/hUk20NFejQZ3zc7qQIKCMFFsMPOT/ub85SZB9yBa/KSBRe
	2WiWPMprcmJGfPUadg7QqG2BEbHVTlt/kSr2K6aUYYKK+nzTO4GSnUhnqN+PhxUsyE3Ds0f5Jsv
	zPhDWJ4hILp6qAERI4MRyA794BXDHez7TzWC2Ym/vSEqqQ5DbZ0ZWXjRard9UUV5vIcN6vtvB+P
	tUvGLnWqpAg8RrmyExarJNxQsYANodcloWztB1lcj0r1Bmxv1D2IEt2PpFxSSLCcYmHQaYhtlQb
	D8/5fpL/ZtnlcMse6yUIm
X-Received: by 2002:a05:6820:1a0f:b0:6df:428f:f17d with SMTP id 006d021491bc7-6ef0e9e3183mr9476815eaf.15.1791919189604;
        Tue, 13 Oct 2026 12:19:49 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-83039a3dfa1sm13280507a34.18.2026.10.13.12.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 12:19:49 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 13 Oct 2026 13:19:45 -0600
Subject: [PATCH net v3 1/5] ptp: drain virtual clock sysfs operations
 before unregistering children
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-ptp-vclock-sampling-v3-1-d3ee4ea62fc6@gmail.com>
References: <20261013-ptp-vclock-sampling-v3-0-d3ee4ea62fc6@gmail.com>
In-Reply-To: <20261013-ptp-vclock-sampling-v3-0-d3ee4ea62fc6@gmail.com>
To: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Yangbo Lu <yangbo.lu@nxp.com>, 
 Miroslav Lichvar <mlichvar@redhat.com>
Cc: Eric Dumazet <edumazet@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, 
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

