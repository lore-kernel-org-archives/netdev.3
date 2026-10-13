Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F24253FD3B
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 19:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791919197; cv=none; b=fB0V/QiSFZoCYFrg9RxFCE5i8aWMiyly7ixvQEDiJ5bnNZqP9yq9rATL2UJR9I45ZhkoDpISFCCqlWDVena27+yRd7F2PhN2XbJNEptoKYi9CIA3913uPuleeQ/VPQfWR3Qa3fGwDSY5kwRHF1Da4lTumoWWxwJpH0WGRPJjq5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791919197; c=relaxed/simple;
	bh=/ETSF3lZyVUeslXXshMG0qVlZ/o+jDPKRJEDhxYGtNw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cXbvwXKOhUIm9ugoiins74SP/VcZuNY+d6KXleIVqumiSOgjgl8wu1IZOzVm+Kth9AOgXSOavsEbl8sUcrlzS/d8aY4pBDzanP9IKCZHfAsgVHZuhzcwayV7jI/4tHfIZu2VuNBOTmmTUB7+cOZX+XWe/eFBqFdkAUPEGEHJojY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=geLDVsNV; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="geLDVsNV"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7f84a55e31aso2028663a34.2
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 12:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791919193; x=1792523993; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SBxyjlKl2tsAQ3iOaWxN0He7F0zON2T03lxEbKDGG0E=;
        b=geLDVsNVd/TtbtMD3PCnRfg9ie/eDj8tY+gJsy47rhUIOpRNtQsvAgoyPnA0S8TT6A
         81jghnNsV45eZ8uCI/D5ITDkYvCyurQLPviLbggX+Xk5XqC+/uxHC9AC10e+fNF+TVfR
         8FWP7l+HP3Oix936LP8J1THAJtpzXYtIE5TyaTizrQWqNBCqEZQXNt/u8oJ0GPp2zL3w
         oOrqtVtg3WKy/Kvij8cFGCp6TU/ymJGoXhdq1QUua9qHrIk31ay9zMSPaCsSnGZem2CP
         XzWOVE1ktLG42nD9FpQs3wIP2PDBphr/j4LONc420JIQy6Jk1UYS9sgRmKxiH6ACFySv
         WmRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791919193; x=1792523993;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SBxyjlKl2tsAQ3iOaWxN0He7F0zON2T03lxEbKDGG0E=;
        b=ig1nEstiJhYD4GypmtQOyLTdgXgXcWxt+Z08zxOcoMpIsTTGThEro6myzJfmUE81g/
         nOo+uP8bN25mbrnSJo5lAHg1XmyjO8xH7EhmzKNJu8e7FBftqsnMvsZx4aoBblIZGYxP
         /zzMP/4lqouP2N1UZDZip8EOoO0S78AQtdKlWHh2ochQPwYptFF05RDuwk8rzqmXZ9rc
         m1ZjW+L8n3AoBfVBu7ObIaZSCrCkrHTvUX+m5bYpDuoyKKjWzwoD+6rdd6McChIq/sEF
         1ngY/ptYuhuy4XiYE0x0T4WD4P4f3wo731haXoJ/TQjuFiJ36qDKbr67nZ5Tvihb2AmL
         vPSw==
X-Gm-Message-State: AFq9FYJpBAwh3fqLYvk/CqjijlWxSQIbB42e+TaNordoQFQhV0jvTqMf
	LGTnSsQ4gDN1JF5FUFqfR0dk5Dnd1mOkn7qL2jBWsr357W1nuqcQknjf+P5QARf6
X-Gm-Gg: AYBFou2UaLaDrgjsT8bZ3cOREQxs6aU9V2oVqjgd+gT23xDAge0P1HRq2CqM5VZHFKk
	VLenbbjwW3mfNTVJxDsOrdSF29eCRmDLnbA2ZHbALRKOrYaT3/jDvFuhZ284t2nlaPTgYWWBFIz
	JkWHlVx78P7CaNjdfwonOgkvNhNshTudUCDpjsz5HIgjoBModcCsh6iT1X3Cv/vVSM4AHsC7J37
	qp0LWdWtrUqxpOHyKZ76qXzpR1/e5mSLBA6tRwZ131j/1xLVZv5mwZrJzztLXgWtaEP47nck+eJ
	6byZwuXqoJnK1uK5EjjOnVeFznCNcsG9gAlin8x4wc3l2Qt/iSoJpXNOxQYi1ONk7udDwgsqSc5
	BdjdGxJjjnn+3BMNyYANKfO/hnHWQYubi8BGTU2TABM2QstAxBTqOkMzwiShMrG2mjnD0ovIH7/
	DMPML3cv9TEO0V5dK3UY3NT3iFoIqI1Fg9Xe6m9CY08oTQO4R0dwVnNP0hmU1MoToi5YtG1GJG9
	/lpMgqIjaenfAkFjGv0S6cbKuXtgB+cW+SdCsXZTo+xXohUjAehD4IW+ctJGfqVYTbQKztFoFgV
	avLNJdjLqVDpMbjCejdqNm+ugPE6R2UCwvJmjY+U/ozzcwxk9tVXMxPOlgJHFlQyaOM8sTpzwwh
	ZM8Kfi9r27Ny5UMbrW+Uy
X-Received: by 2002:a05:6820:4b08:b0:6da:29e4:35a6 with SMTP id 006d021491bc7-6ef0eec6e53mr10221552eaf.52.1791919193469;
        Tue, 13 Oct 2026 12:19:53 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-83039a3dfa1sm13280507a34.18.2026.10.13.12.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 12:19:53 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 13 Oct 2026 13:19:49 -0600
Subject: [PATCH net v3 5/5] ptp: vclock: preserve missing hardware
 timestamps
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-ptp-vclock-sampling-v3-5-d3ee4ea62fc6@gmail.com>
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
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/ptp/ptp_vclock.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ptp/ptp_vclock.c b/drivers/ptp/ptp_vclock.c
index 6675466bc307..4a62047f0ce0 100644
--- a/drivers/ptp/ptp_vclock.c
+++ b/drivers/ptp/ptp_vclock.c
@@ -307,6 +307,8 @@ ktime_t ptp_convert_timestamp(const ktime_t *hwtstamp, int vclock_index)
 	u64 ns;
 
 	ns = ktime_to_ns(*hwtstamp);
+	if (!ns)
+		return 0;
 
 	srcu_idx = srcu_read_lock(&vclock_srcu);
 

-- 
2.53.0

