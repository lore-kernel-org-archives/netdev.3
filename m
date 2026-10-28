Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793206059;
	b=TQHZw5CyBgHT3UgldIVUNWKzlivhtwRNHoXfEWg9xc0TLjvtBFT6aX6r0c1oyiyB0Cm4
	 HM6b5sw9HLms6RRr9LKMx/maUeTgffGrPQai6wc2ajO21wLGcp9126esDlqBdP8UuI9eM
	 Zt49H3YBqVbGtvcV1otlMeOo/BFqkJFfGUPAtwHP9zkUTFNjjrndZI2NPRgSILHwXWr4L
	 n0ynVuRYjTdc24bxVlSzrWAlwdNQU0wnmOnHsepDNn4C2uZjZm6LrlSvCX7IBoKKMvXHC
	 8tZnm9W2uGztwVvh3KQNjuezWb96pCEruQIcxTKw+iHec96ULqHBLPAm4pDiSwzk3mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793206059;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=YP63UdSvRgH+U6RYpSmgw00Aw6otHrAc8+AYLP+kjNM=;
	b=FTkx5D7Z82QrtqjGRSJudazD5IU1VyhWx1Ds5ieXbfxi9W66rElsl+3Nqf0z2gJoMt45
	 Trg2sg2LBl9+/I5GtcRnxbwJjHkZaipJaegTiUmiO5+Wkq5VywtQD9c/DRWgUcMkKUea7
	 5yWDVwHu0AQM9YguIlw0sTNet2X2FrGA8J+IENbFyYP+RQrrNYace2b39bx1BaRHCyNjI
	 qzmv3YXw+kK/Lf0DfhQFi4eReSNpWL2b+Z07HKlqvmYeMc7zeerghLyQITjPJ8cuvE6Cl
	 mxOpI9aEYcbDSYAfvstrzEtdp1eGw1XTO3YBNdKs1GFaMBfCYtsRS6aAXVg3DZnZa+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lrwSVVTC;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D87606A322
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 16:47:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33D87606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lrwSVVTC
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3acb11973c3so948879a91.3
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 09:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793206058; x=1793810858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YP63UdSvRgH+U6RYpSmgw00Aw6otHrAc8+AYLP+kjNM=;
        b=lrwSVVTCr+mmD5txpvh2KaucEm5yJlU6dn9ubOt13fw4aLxcMETtY2fvTnkU0A7tgY
         KVawglfKWWyeSYXUAytG9qQczSoMLxjfa3dhx8tlwMcYUlL2aH6VclwO4y1zYczieI2p
         Q0Z+FDJ9Sgo2enla6/lk2VAkXYrhQcCrxzME/E0xhasyOvpzQEg1IMCuy+3BcUKtH36l
         EqK0J23H57eMQYKm7iTLG/oaHHyuhswjOv3/x366f+gX7/gfgfGT2XL2wLUO8QYeKNiN
         oEyv2AavkdEI1P327WzfaWwbP3j/bHeNVfnTcerzpcRRjaI0t5TpwCBSzEoklHz/QfEG
         fSuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793206058; x=1793810858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YP63UdSvRgH+U6RYpSmgw00Aw6otHrAc8+AYLP+kjNM=;
        b=pch6gKk7noppq2NNNnDL8X64h1/CEZlwfoF3WzII67WqLYriSS2+cF5+izlgtcY1Zd
         jDlDg2/TM+e5O/kkHRJi99wdZoPClkFAo5xWT4lGYBcyHEkzy5CZ1EV8sYRAJnEcaa64
         trQ+1GogHwg7EmVcpnCDoSGx5ND9uFmTitqYBGNBv/jctcT3z7XsZvyuCEXOCY+chG3X
         pANSHdqiV0rHFCVbbo838ze4hjeDS8DibIvQ2eFz1jrAYt7ei4pGDLrFQd6vH7+shWvz
         IuCccIuH9MMS4n8kJnyjOl6PrexR0AVkdIQVdEtperflxgNAP1ExbtBEARUeTQ4iPZDE
         vL8Q==
X-Forwarded-Encrypted: i=1; AKwUvBx1AMrggMSOcnQkaN8iIA6nmjSuIavyc4gZO5iZbvSpfFT2av2bA2dF4yQUuhuAqBtfHrAWNXA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJaGo9zYl9KXYdvqtw+3dHXeTpbIQ6rFtG3wC/P56y097hhApbb
	9FX88HZmEqjaMoufTxqm7u+XORv4YaDSCdoqzu/lcPyol9v+y613MA69
X-Gm-Gg: AYBFou1Dyh9Qiy8QIpd2e0s1WfOSs8i0V1HoqDwBXzy6DsDMPFLsi5jSlvGsxzfIsJG
	2O+iDs71g2Kf9rIvHNGoEf4Epwp1dKMeHJ4t3rvyGcj2gaO+E8Zf6E4KGlvExKmCCBraIDXqff3
	H3uAKIfIEdJOonQD5ZCN0S+YXPrRbKHxB+MQxUfOM9BIiFDt2P5PTHc8dUhp/hsWdh/KXn1113R
	rtXDzeYb/+wj3i6I5QPtKOQA0e+9rtN5SOuNAikVp9wKVsEIO+oma+lDd7c0nCVxXAmgQqcR3eR
	0NNBcSUevTRDtiNMAHCD9h74ISo4ttFRljOBjD4zTETxra+Vn8rYVcuQtlFGudZD+ud2kJILmWZ
	8w6F2BqwFr0dnf3msYOWWGe/qQ+gMVF/2AAKrZ8MBDqEL/giCK63jNEhgPj//x4os+akfKVPc6+
	cNqZjZ7lr0imw3Q/HtvChmIsWAX2KmjD2Qg6uex/nW8KFUPlpBJPgbUPAui8fhK2lCzvomxV/hK
	46LhOiHGWOcVFIBS2aI6cilh2LyhOHd8ws+6g2yu7oaJXyiHoPC/ZZli4KCoOPmMviqqaECPQEv
	Sc9O5PwJd1epjgl5nKYNspwEVR/qaf5zDY1mU4QvTqGlHw==
X-Received: by 2002:a17:90b:48c6:b0:3ac:86a0:5766 with SMTP id 98e67ed59e1d1-3ae5836cbd4mr2201584a91.63.1793206058606;
        Wed, 28 Oct 2026 09:47:38 -0700 (PDT)
Received: from asahi.tail4da9e3.ts.net ([218.48.198.193])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae579c5b77sm2173048a91.3.2026.10.28.09.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:47:38 -0700 (PDT)
From: "Baek Kyu, Kim" <pocj8ur4in@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Ido Schimmel <idosch@nvidia.com>,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Baek Kyu, Kim" <pocj8ur4in@gmail.com>
Subject: [PATCH net v2 2/2] bridge: cfm: ignore CCM while CC is disabled
Date: Thu, 29 Oct 2026 01:47:30 +0900
Message-ID: <20261028164730.253238-3-pocj8ur4in@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261028164730.253238-1-pocj8ur4in@gmail.com>
References: <20261028164730.253238-1-pocj8ur4in@gmail.com>
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

A valid CCM received after CC is disabled can clear the peer defect
and restart its RX timer. Cancelling pending work does not stop a later
receive from queuing it again. Even with RX work disabled, that receive
can still update peer status and notify userspace.

Keep RX work disabled until CC is explicitly enabled, and skip CCM
processing while CC is disabled. This prevents a later CCM from changing
peer status or restarting RX monitoring.

Fixes: dc32cbb3dbd7 ("bridge: cfm: Kernel space implementation of CFM. CCM frame RX added.")
Signed-off-by: Baek Kyu, Kim <pocj8ur4in@gmail.com>
---
On ARM64 QEMU/KVM with bridge/veth, a valid CCM after the disable ACK
cleared the peer defect on v1 but left it set on the combined v2 kernel.
Re-enabling CC allowed a valid CCM to clear the defect. All 3 status
checks passed on v2; 2 failed on v1 as expected.

 net/bridge/br_cfm.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_cfm.c b/net/bridge/br_cfm.c
index 28b40dbf4073..115cccf1d327 100644
--- a/net/bridge/br_cfm.c
+++ b/net/bridge/br_cfm.c
@@ -150,12 +150,13 @@ static void cc_peer_enable(struct br_cfm_peer_mep *peer_mep)
 	memset(&peer_mep->cc_status, 0, sizeof(peer_mep->cc_status));
 	peer_mep->ccm_rx_count_miss = 0;
 
+	enable_delayed_work(&peer_mep->ccm_rx_dwork);
 	ccm_rx_timer_start(peer_mep);
 }
 
 static void cc_peer_disable(struct br_cfm_peer_mep *peer_mep)
 {
-	cancel_delayed_work_sync(&peer_mep->ccm_rx_dwork);
+	disable_delayed_work_sync(&peer_mep->ccm_rx_dwork);
 }
 
 static struct sk_buff *ccm_frame_build(struct br_cfm_mep *mep,
@@ -414,6 +415,9 @@ int br_cfm_frame_rx(struct net_bridge_port *port, struct sk_buff *skb)
 
 	if (hdr->opcode == BR_CFM_OPCODE_CCM) {
 		/* CCM PDU received. */
+		if (!READ_ONCE(mep->cc_config.enable))
+			return 1;
+
 		/* MA ID is after common header + sequence number + MEP ID */
 		maid = skb_header_pointer(skb,
 					  CFM_CCM_PDU_MAID_OFFSET,
@@ -699,6 +703,8 @@ int br_cfm_cc_peer_mep_add(struct net_bridge *br, const u32 instance,
 	peer_mep->mepid = mepid;
 	peer_mep->mep = mep;
 	INIT_DELAYED_WORK(&peer_mep->ccm_rx_dwork, ccm_rx_work_expired);
+	/* Keep RX work disabled until CC is enabled. */
+	disable_delayed_work(&peer_mep->ccm_rx_dwork);
 
 	if (mep->cc_config.enable)
 		cc_peer_enable(peer_mep);
-- 
2.55.0

