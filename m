Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792682210;
	b=urJIdprs3wYKiY9RRheaAULlFq0v7h9Wn1JXrYH1vK45vUJp/KB7/A9LycSFQijvfN26
	 CWfpzgazo4HDzhdAnagYP3YrJgBGZl+n50Ep7kTa2O7w+PNg6+7tthPU5Oy4EgVw8s0ad
	 AK0fJbLedXhLDkzLEF/E2yyxWIqriSgH2guWY4TyAhoI5CBiIFrSrzK8Gd3T5kuPmSoB1
	 hUrvEKd4dRQrz9K3mMQOonsDVN8dRbJLnGznaAq7ByxhDhXK3ek8ofHXf+skyIE53kt0y
	 ZR0hhXdEt6G9WWobztMeLoyZ4OX0UYc3wWNtdKNnxJy7UJni+KuMY6nbFZa2zy8acdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792682210;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=DOHXnXj9H0hCXUUYqqbghfjLZTExI37IMuLDbNTswLI=;
	b=HwwaOwcFCjBudDKruGHCefpKql9tMwDul5UEj8n0M1RayedbxDhWIZruYKIkKMD/RzRb
	 f8QoFZq0AiI/pXkm8mGaCUF5S14tusRd3Dn7O0tLCu7NMvVB+g1rDCkYvXEw97gNr0FKP
	 +YjHUwsjiTMBOe8Nmof4diNuw6gMYk/sBvwrHOhQD3Q3votBEztlDmDJN3KXWCsFwBMi3
	 O0MYpyIv0oOT0JVTyJQuHOlEmGwW3RdOQjZEcfvQbHPe5+zSX20XthKncHx8JHNYv3UsH
	 wQVNCIOURtZ7pjLoNE3J2EQwVo+sPTQCi8vqvLiQVXEC/OgttKzbUs6lG4Dkc0UaqmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=d4iKLn02;
	arc=none smtp.remote-ip=209.85.161.41
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD268606B384
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 15:16:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD268606B384
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=d4iKLn02
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6df5e315bd1so1204189eaf.2
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 08:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792682208; x=1793287008; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DOHXnXj9H0hCXUUYqqbghfjLZTExI37IMuLDbNTswLI=;
        b=d4iKLn02OTqL+KMfhrnOAAthWUA2hmMU3XVU59+ctqrRUNPLQABODb8zadkrhFSRxE
         otlH/r1nXGDgqIRTySVkbFTiQZVHJ8G+sPnbxU5NxbyvujYUud+GBL4hFdEv5u3MfYEj
         hqwhE2MM2lnsTkZZti76o+DGtR+F/jYCGWowrZ2Qyqonne+KHcWV6GljpEfboGurQ/iv
         H/xELW09uua04J3nm2O1Ksf5pgGptGI5q+2I5dvCORCv+r0XhDeQ7J+rw6CfTHytzQx2
         Xx6ImduwR9A7Wrkcw/BsQuep3JMXoUOugOhxufy6I9aARJDj68LwOs+7sfSN56aL5LJO
         1Y2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792682208; x=1793287008;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DOHXnXj9H0hCXUUYqqbghfjLZTExI37IMuLDbNTswLI=;
        b=p3EHpY+gVJE5yYxb5yBItIN4W3YC57QZlIi4hYXFGYJLbOE73XcKZiCo99hq8oWqV/
         E/bSaWC302EFcJgo/1r13exEwKLS68N7thpr6lepuMzSPOJGlcotm070FRAzPdiAa709
         lEy3ei1eKvqj4E5pAdG6MOPP3u3QsybHuPqvrFS3kOJh4UECgEoKduOkbKSbzSiRg0hb
         NDztV+6FFoQR1a1dT294hVIut3dY/QgiCNybD8bnbZTLsxeptcR38YpMd5hhO3XMzIxk
         A5R5Iht/QgZczPl68/tv0k8a7ZFD3plzZbBoshzzzZQLhZw3Y++aOUKsHLZskt6AdUlF
         PLug==
X-Gm-Message-State: AFq9FYKTxTCf7t60yiIKPqM0/I2VRE+utJSH8OgwHcrtR0RKitg0AASo
	A/Uw7QyAiIJ2cpRxDCLrYFeEbuTjbWmQdHY0h9Duz+55tDFXO6NwxuK4
X-Gm-Gg: AYBFou3KnIC6wXuMhJwSFU5cWymCqiRtc8NBm9lmWd5nTUMMTbKkjbPiD/DcFc00b73
	gLAqPwr4+MlwKHxdV1PapSlDnIjFxW0CjXVKTOxvnAdvR7OGUpCZ2pbTQ7u6Ol3Q5T4xn+4ETl2
	rAW/myda7Dfnq1SMMR35soSRLNcFfJp8W/fyeALIWd4HT6rJhFp/C5HjE02myxI9rpwRgNb3I30
	SVk+oWCc/rPs9zheYU4J95r3JyLugljFb4rM0FWV+IuL1Qyjz2UA0qKOZhFHpvtmIgpyrq3QAee
	15XFGcvwAAGpL7sDNQRhc9wDfFvPGCztr5NcfUU8pCFkf9Sjb2nihPe3r/6OPBHNFeSeVIIvjq6
	f14w/rGEj+yATOqANSqV3ZNeEnDLq7yx03uKhmx9EAA613JnmE8TIhmGN1mZxK5sg3rRHPTsGZC
	tu//TXcIW555Z8kTxEC2RtB2iawkeIAw544fUN9dHmmVSA5HMTHMd7VBhWZp56NXoIBriXqFO5Q
	rPG9ZCn8+HfsvjOSHeEbNht3ooP4dO07U4YVqcMpPgC80Mg9ZltbvP8CgzC/9DuMMDckbbrX3B8
	yucqk04UYhGtjCalBZK15/C8r/ri2IGbyDulOc07VUmX5s1wwceQr1IxVRtpX9Ar0QMajwnilg0
	OUdLJAiN7wXE/kyG28eRKpJgc7uAlTVQLpPK4fgWLvtvlq+1zbS4tppJFgw+8Y9TleCZ6Nfj+R/
	hHGPw=
X-Received: by 2002:a05:6820:997:b0:6dd:4f30:258f with SMTP id 006d021491bc7-70940d5b3f2mr3229186eaf.56.1792682208643;
        Thu, 22 Oct 2026 08:16:48 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a7d5eb8fc0sm4685631fac.1.2026.10.22.08.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 08:16:47 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 22 Oct 2026 09:16:41 -0600
Subject: [PATCH net v5 1/5] ptp: drain virtual clock sysfs operations
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
Message-Id: <20261022-ptp-vclock-sampling-v5-1-06ceace17bac@gmail.com>
References: <20261022-ptp-vclock-sampling-v5-0-06ceace17bac@gmail.com>
In-Reply-To: <20261022-ptp-vclock-sampling-v5-0-06ceace17bac@gmail.com>
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

