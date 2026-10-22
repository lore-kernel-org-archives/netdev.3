Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792682238;
	b=SoADABqiZhLhuG+96R1b77EidePJp1bR5pQppU0dp8v6tpueOb9tYNKHRMSkWyEK9DZQ
	 1qryxzuABqeejW4a8pULw3arGof9IsW+/213jbqArVxtxxtl5ye1PxGqgQkmo3KHb2tru
	 YA7MyNMPlolGdE9089FFwTGR2Okhn/vVLwIx/zx3N1i/vlPlfotbOSUgAqCY6XAMLUh+9
	 /cYtcVgLY6Nzc64rdlwPbesCrtrFfk+0OZo8+5kgN00Zw6ctCwYwfYGxdYNcBOzziPxsf
	 btjhVlsWmSi12TiSeEOaTiKsWX2VI4Mb+ZqYkMeNAGIqUJ+04ADDlw6lV2F1w15mMVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792682238;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=BMS/vcyNjL65g3dFxx4/6BCGx6UhCt4NMD1MWFw7eU4=;
	b=Y2QDOBCZcYzN/BNGlqyjjf2dVRnzBC/V4J2sQEYzvdwYcD6WVYysYaqoUs9FZBvA8LYH
	 0ru4N1R+1l/CsfQqjqcooOKdmDvHWWwt60AGhunrB78zRUMMnuqoGSxxSexPvPrA0Am9d
	 BD/6pPbBHXCkE27TOARQ1B9xLB+zMte8qGqYZTYzgnoua1A10m3M+dMXLUegvnaFyJN0f
	 oFOtgczxM/QrYWsfvY48fmCDbwTPi9glVzYp3hfm3Z9NWu6FUIKRXpuEdwgLBHIXwmqHi
	 SnlIMPL4bseDNnsZOMUYfZDwCovNRrIsclSNo9nl0KzKwWiyGn1eQ8A5HdZAg9RAyrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Wx1O1+FM;
	arc=none smtp.remote-ip=209.85.160.42
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DEB606BE5C
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 15:17:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5DEB606BE5C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Wx1O1+FM
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-4a77dcc4ca0so1010293fac.2
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 08:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792682236; x=1793287036; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BMS/vcyNjL65g3dFxx4/6BCGx6UhCt4NMD1MWFw7eU4=;
        b=Wx1O1+FMyZDScU8yOmfV1Q9LgiIGBYATJsmvHDSdfQLw9D6zzhLXOL4WRUMvRWCk1N
         BOUparZ5VbQsgEyxbMXvQUiC9mtbfJwGARxaVpbhYWjSz5CB5eidZ726LXeO5Hk/J48x
         5DTFUiVaRM19shYNGeI0PMqotn11D/oes60yH/PrzEUZZpeb9jntHVL7EkrAuuilPJ3x
         bA7kzxZlBuwnnXjP2clrGR2l8qNs8zCnZd2noylOWLMnNT2sBlqiHTXwyWzEPQd0j66J
         +T2lGLzOp0FsepD/IPAv4T9zk+JDuDd/kUxqtcZae1+UT0haTHRDw+Yz/tK/NYD5TPP6
         6gXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792682236; x=1793287036;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BMS/vcyNjL65g3dFxx4/6BCGx6UhCt4NMD1MWFw7eU4=;
        b=WWsxx5sgTRffxdbKHadyuggRmPthkiIFV0ENSXKfBZpP4mwmT0+pMp6m5aTHFtwfEO
         aXTtqM4JPchz4KfEnrG2agWJEfJrDoMMCLwModzPnG8NdttdLctKxLX5gvYfoxJ57Du2
         Aatw9Ds6q5Awsu4d9osilUmDgiZ59c0cJtT0pv0vi/b8ip4NfAkM2ZSO5fRSC9tT4rW/
         Npn9D0yR78oNb4SEgekEFIsDy2t2buqrt+CtXX077m5MCM7oukjljNO+eN8KZyHkz8vE
         mbmJG6y02ssBTamtJAVW6CtbKnlCIIpWhOvNenbZXlJmJedi3ayB2qdVv9PVKiHdgJJr
         EjSw==
X-Gm-Message-State: AFq9FYI8q5+xGUs/uqTgtbi6h4uAUTCAKIG+gkvNMga59B8M9UfGc+H2
	WvctPqAE2I9ZoyJo/lt2HU6ytHj+e3QAaxedUOi2cREkdp5dJNgfy+jz
X-Gm-Gg: AYBFou0z8Z7PuPztwDY80xgG8hIq1r4zhG9+YvptneNUps3EaY56wEhFJA+Y3jRZ5xg
	rpbPQqYNdynCGmVy1IeN9+CHc1JHesa0skTJ63hZQJuYqaZbFfQsGTKv0XfVahe1NI/Cp6tiB6c
	kvA0M1lZkY/mJioPuXwk26h3QN0aOOhVvut64oE6rIHwYjSsqyyexW8KsRhJz4K4kIEuWCA5aWp
	giRI5obePnuPBFqevCfe6BrvRLpHMPVwScizvvhtwIGH18aWR+yJfBtmLdaVF9jpM+Rx/iCMuRo
	HakRIqe1SHdAJlBs+2GjCt3wXkCrfW/Jljc/aoExRt0iIl1i+M6HnhlznnaqL9CdG21PnPIF8sq
	gKrHbsf35Fl3X+zBVb/xQF8c/rYvjP9pII410KyBCsIQdbANMJ99l2qE8zNvTLmjg8N0T7/OoI5
	V0p/JSTpEN8jGl6mHzHxzfVSa8omC+y6US/GB/DZ5hG672w5TkV0B3TQ5p8zeILqu7u4IRWzuaN
	/VESZhbQneVr25jOYj/w5M+W9a380YVeWEvCZPDpH93mZuDcsrtRnUS8AoIVk0HRfMbTBYlGmIR
	WzRqjkmTTlWsgTAUUF2O0DWE72wV3IMVcwjb72nVHlwBicOqwsNQ/HQJQBh4CZN3joYfQaqemiZ
	8x1yehdu/V9j2m73+oEWYf0M+HKfwU06rot02wcmJ1/+JDHWphtGkQCNnFUjPqrDITUa7J++eO6
	les6Hse8/8Huki6rG/7PEs+Q/s
X-Received: by 2002:a05:6870:888d:b0:49e:45d7:f3c with SMTP id 586e51a60fabf-4a7dc214264mr3893477fac.28.1792682236551;
        Thu, 22 Oct 2026 08:17:16 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a7d5eb8fc0sm4685631fac.1.2026.10.22.08.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 08:17:00 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 22 Oct 2026 09:16:45 -0600
Subject: [PATCH net v5 5/5] ptp: vclock: preserve missing hardware
 timestamps
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
Message-Id: <20261022-ptp-vclock-sampling-v5-5-06ceace17bac@gmail.com>
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

Socket timestamp delivery converts hardware timestamps to a bound
virtual clock before checking whether a hardware timestamp is present.
A zero timestamp means that the packet has no hardware timestamp, but
timecounter_cyc2time() can turn that zero into a nonzero virtual time.
The socket then reports a hardware timestamp which was never supplied.

Return zero without conversion when the input timestamp is absent.
This also covers skb_get_tx_timestamp(), which checks for an absent
timestamp after the same conversion.

This was identified during review of virtual clock sampling changes.

Fixes: d7c088265588 ("net: socket: support hardware timestamp conversion to PHC bound")
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/ptp/ptp_vclock.c         | 2 ++
 include/linux/ptp_clock_kernel.h | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ptp/ptp_vclock.c b/drivers/ptp/ptp_vclock.c
index 4e98f119de72..b863880c0541 100644
--- a/drivers/ptp/ptp_vclock.c
+++ b/drivers/ptp/ptp_vclock.c
@@ -320,6 +320,8 @@ ktime_t ptp_convert_timestamp(const ktime_t *hwtstamp, int vclock_index)
 	u64 ns;
 
 	ns = ktime_to_ns(*hwtstamp);
+	if (!ns)
+		return 0;
 
 	srcu_idx = srcu_read_lock(&vclock_srcu);
 
diff --git a/include/linux/ptp_clock_kernel.h b/include/linux/ptp_clock_kernel.h
index 36a27a910595..56f6ab1855d3 100644
--- a/include/linux/ptp_clock_kernel.h
+++ b/include/linux/ptp_clock_kernel.h
@@ -496,7 +496,7 @@ int ptp_get_vclocks_index(int pclock_index, int **vclock_index);
  * @hwtstamp:     timestamp
  * @vclock_index: phc index of ptp vclock.
  *
- * Returns: converted timestamp, or 0 on error.
+ * Returns: converted timestamp, or 0 if @hwtstamp is zero or on error.
  */
 ktime_t ptp_convert_timestamp(const ktime_t *hwtstamp, int vclock_index);
 #else

-- 
2.53.0

