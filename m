Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793343181;
	b=MZ9jPVK1v5MJBzTv8vdQ2gRbNlXzPLBcXQs5129410RMYCDghl9FOLIh1ihPWbfcrtmY
	 0EJ0YFLJotexaRS+0DsefLNPYTs9jWG7dj3mdpaQVckeTrwyZgtuVtEEr0lOpzeIL0QAZ
	 zc53DF9zV4BMl5oaQuEtjohzdTPYsFq4e7UamPyrsPmWD4PDWZeD+5F7pDWgaCPQlSMGr
	 6v3crk0Nh+/SYjkrc5VcQtLvuENWsTiz1oed6AxBnr6p/H2WvMGC96ZGOyG7WYGkA7XgL
	 C3l3oZmZF1wtmlH1oTD9Lbp0eXMe4QxpXTrKKmmzmA9O3adk9jtEFbZLdADxkg8bp9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793343181;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=qXtTOic1CSe7iLEVcnI3wJflAV0GHEPp/NEkAFGsTr8=;
	b=jbVi9pdhyHA1lZu+dL/KUFaf7jPC+4B+8hPURRlyg5VHybZrzelWG4zn1DgtKyYd844J
	 Rp9JgSOWl3hXlHhh32eL9gONxSrlnhNCoJ72nomR5AvCdSe01tudO91rnvqHcfuGUhl36
	 S72DJSvBxq1/0A0qNJioZJZRHKRu3L86SdYrT45WHgKM+VjuFKaYaARXuavH5Y8tsdiej
	 w9kqroLNWrUmCGNY64xnrkEsxFDAD6Kzci5LZZcTC1B/QTbpSAQ8KYiZOhBzR11hTDs7e
	 Fpm/owwlF0o/hXFkCsUdmRYfQlmysNADlgDYGaTngtcdS3wQ+hvw7vP0ni/9VpBIS2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--starchang.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Jz3f5tt1;
	arc=none smtp.remote-ip=209.85.210.200
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4A8606A31A
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 06:53:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F4A8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--starchang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Jz3f5tt1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8a05c820ecbso526354b3a.0
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 23:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793343180; x=1793947980; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qXtTOic1CSe7iLEVcnI3wJflAV0GHEPp/NEkAFGsTr8=;
        b=Jz3f5tt1lHW+sWpdjFrp/X5c88hmABgX7JHsD7mDSt47kbWHamUxbvuWabR2amylU4
         nkNf/8Y3zBaBkhXHHUWRxIo5MifNOVHrfNduzXa2/EbM3WZMA/slrw1ieeNGCn1GWHVr
         ztwsHOUt2qfoWlJX3I/JmNDPzaU1Hh4rePYHpYsaI8noOYuxYGq5UmL36OuEU6/wEtmo
         rIKbzHUtrYHRTN/t8jkTN+tsRSAjBduhj0GjhMXZ7nLrQTjQ8bOfDufhPIikR1Q8kDWV
         OdGXW7iV5f4Kp3s0Eox69lhelltwncOSxY2acXtRLwf1xjwZ1Cp8StPU0+8eP5mlkice
         EmjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793343180; x=1793947980;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qXtTOic1CSe7iLEVcnI3wJflAV0GHEPp/NEkAFGsTr8=;
        b=1kl6pMxe0IArxkOBmSk6A6WZ1DCBKaRooqNq2lA9VhtevMbbHx84G9h7ZgwAN3P8X9
         pPO6GZeR5ZaXlXbPxBc5/Ki895wLRzioi7YsEJISYE8UBobC6nyWfox2E8PK4AF0UvPt
         v8BYdSYsaRm5gqnFv7hf7g14S5krC93eMxi10qbb35366Cuyd2ulvRM2iLDgV85ARHAW
         LNPBd3tjTCXFe+kJuyMnpMDgRxJUbtolo9pVQea66bNMuZep6kcN8GRcRIGhuz24JNpR
         hDaQdBRzaoRlz0/G5W75ROSLZo2SwpWolhcq1GWvZD/pqHQCi8pfTYNN+SCvYEpAusgB
         4RCg==
X-Gm-Message-State: AFq9FYLTXUBVTDpqO2dEqeTfL6qc2CDsSBs4gGBDr/I3zp1Wrx/Zulbc
	n4TusOeZ9ecEh3LZLyKBF5JZ2ZUe2ONl8kJ53PhkEYePUXU+kadP5nIXig0yDybAaFHMrF29mfb
	hG7aqu6MxQOGyVXy2Sw==
X-Received: from pfbkt3.prod.google.com ([2002:a05:6a00:4ba3:b0:8a0:2311:b0be])
 (user=starchang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1f0b:b0:89e:779b:d0f with SMTP id d2e1a72fcca58-8a9beb69d8fmr1284653b3a.37.1793343180250;
 Thu, 29 Oct 2026 23:53:00 -0700 (PDT)
Date: Fri, 30 Oct 2026 06:52:58 +0000
In-Reply-To: <65cf2338-7bb4-3151-f3b1-ef171bb5723b@ssi.bg>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261026150539.1357037-1-starchang@google.com>
 <20261027015619.1745984-1-starchang@google.com> <5c1fe870-39ff-e83e-e479-0e1f0fed6a83@ssi.bg>
 <20261028061644.2997812-1-starchang@google.com> <f631e178-d9ec-f335-9163-c44a9e6c58af@ssi.bg>
 <20261030030715.604215-1-starchang@google.com>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261030065258.818406-1-starchang@google.com>
Subject: Re: [PATCH net v4] net: Fix Hole-196 vulnerability by dropping
 unicast ARP/IP in L2 BMC
From: Star Chang <starchang@google.com>
To: ja@ssi.bg
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, johannes@sipsolutions.net, johannes.berg@intel.com, 
	linux-kernel@vger.kernel.org, wangroger@google.com, starchang@google.com
Content-Type: text/plain; charset="utf-8"

Hi Julian,

Thank you! Your point is spot-on: in a shared-key Wi-Fi network, an attacker
can simply broadcast a forged GARP reply (sip == tip == gateway_ip) to poison
the gateway MAC for all peers. Giving GARP an exemption indeed leaves a door open.

We verified the Android / mobile use case and confirmed that completely
disallowing neighbor learning from L2 BMC is safe:
- Gateway validation: Android relies on NUD (Neighbor Unreachability Detection)
  unicast probes and unicast replies (PACKET_HOST), never on broadcast replies.
- Wi-Fi Roaming: Roaming clients *send* GARP to notify the AP/switch; they do
  not need to receive broadcast GARP.
- Router failover: NUD naturally detects stale neighbor state and re-probes
  via unicast, recovering within seconds.

For v6, following your guidance:
1. L2 BMC ARP Replies:
   Drop all of them unconditionally (including GARP) with
   SKB_DROP_REASON_UNICAST_IN_L2_MULTICAST.
2. L2 BMC ARP Requests:
   Process and send replies as usual, but suppress updating/creating neighbor
   cache entries.

Does this match your vision for v6? If so, I will prepare the patch accordingly.

Best regards,
Star Chang
