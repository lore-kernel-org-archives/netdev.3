Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792445221;
	b=jo2hcI1vFMgL6bIA+TCDanqqxCBqH30VqJA7KzaXtaEtA24pnBzVwsFUC6xSvodjxuSU
	 dL1gzogUKmJHlwNOjeC7KYNioaDP0sVRGF9OuYZ/9nD07kVNgnM/sVwxqBj98y0R0ho/I
	 hJKlrynpKOXDeZ1FXCm9y+G7ih1gVbnEmmbBRQZqmHgiUGi9o3oNZR3wyKkfx4w8EuBl5
	 AotVPq89Q/10zvlltVmPnwfXAbE+3azaOnIMJPMFCxu7Pc7A9ZAn/UunGHvBN3LrJ4JFx
	 yn9ddjNgtAbR/wzwXMiWx036j4WISkB5B0UxjZqQpudkJNjWz/EE888Mze1DVNAt0gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792445221;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=B1di3TzqQctz9kRhw9bHhZony65keKfMNyZ1xG2QpHc=;
	b=47fOHSB4aX7/69SZfmRTeumG9iCjS6D3H1BZWrWZPscdgR3dbTEoG5TWPQ/FvWkZoqxc
	 CCeTrlKInJ9VVizSdTBNQqhWOhFm6hZSzECMemHwRuzVuUtUP+XiQy2BcONtZfxeEHHKR
	 rw1Gfw5ogMBagpksYsHJhUzm2DR3nzAANQzfkm43UUCo+NKWgSg2dnkz1G41cZ2imbfMC
	 S4iuiBCHW0LTUdc2uUTrSZK7r4KgG2KzB3BxPde1ms1Rz//RKux8DuztD54B5ichukgG5
	 Qe7+gNKy5NYxaPi58VOZN/HYgiSB7PdqGITOhj8p8yW6LEkNryYsxdaG3YWsuog5ddQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=purestorage.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=Aiq0g5mn;
	arc=none smtp.remote-ip=209.85.222.225
Received: from mail-qk1-f225.google.com (mail-qk1-f225.google.com [209.85.222.225])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14AC606A320
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 21:27:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A14AC606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=Aiq0g5mn
Received: by mail-qk1-f225.google.com with SMTP id af79cd13be357-93f259cdc86so255513485a.3
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 14:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1792445219; x=1793050019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=B1di3TzqQctz9kRhw9bHhZony65keKfMNyZ1xG2QpHc=;
        b=Aiq0g5mn7Rs59UC2OpY9CbSeZkTswP6agDSe+3tzwqeLbEwvT01TpO/yWQzvz8gXFw
         2kDjt3M0eHMaFW0PRCDpZtIQJFNA9Xpq1VMedxtvY0JQWY8JJTjLYee8l2HLt4fL3QDc
         DF4ZHHrKcpARgLnNA92KEaEU7OBAZebRu5J+O9yEVpyY284BPmAMTI+qU9TRzK6K3VHB
         BpamgmWdZYIZDGo3L/mziUHl5okRPu5lir8ewFFwH7cwPpikUVK0DxPl8xcGaNloHANs
         dWQnBA1rz9qWsHm88e11G8/N+fq3A6N7tNHEUtZzEWlS+d4mCwSD0C753wQzD/npBlJF
         lPEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792445219; x=1793050019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B1di3TzqQctz9kRhw9bHhZony65keKfMNyZ1xG2QpHc=;
        b=jcbFej5bLqCTfpv8nqXTbibabhkCG9Ym6Qw6Cdgdge9hvC+9cmDyPpO2tP0260v5X4
         c0ULvrJrSM9z47tb0kKTNUvLbSvNZETWZIP5yF/8YR6fkySNgAJqNlRuPdB0biWM74LR
         zbslAJy2fo2aTckT8ywATayy8c6uj4VLapWl7KYOFn4np8RQ2zC1NVjLincpH5gLEWCe
         WIoc03L2e7vAQmy4mwXCG4k5NvIpKEO/orEKyCYBwi8+2IpSg/9wTV2AanGkrcYqK5fV
         weQtaAvpTVli5AwKHheEGdvsQUxZn+dGBGBvfFRtmMkbX73x53MhNcvYm6tpCfmILXqe
         GXfg==
X-Gm-Message-State: AFq9FYJXQxECi8P+T1i2O6WdM5m6t7/VdTsPDinhEaHyJERKIkI7exPk
	daGrmhHwNjgv+3vNRiPdypiQFx6izND5dtxdceczbIYxAAP72lusTedtKRxVAxMyqPMax93esSj
	2OQk8k2nbK8pojZNRC6XfPRDk3Nmd5GZF5rMU
X-Gm-Gg: AYBFou1Nsnp/zzau3ZGZQJB71jU9SpeAMu7XPPqFG8zqVWfDd/HBS0u1LBxurQyiacI
	41Ov9CvhVZZu1bsXVzB8vwFt8KePiNGhYa8cQskHWFgmOugyeIwsHqiYSG+OGtnAjP2c9Him5LO
	DYsD55FHYpMISkvxr1c9C4rrgy3TF7ZkN86KwXBa/XjcxisPzTFvYMEOIc6wnJ6GqDI+WHfNToZ
	cjWGK+OErYtgMQJPtvOGM2yp+VsQQlpbptTPIHGHm2dp+t6LdVGJOTglfmXWzp+P656TdCaXNFR
	iZkL3zH+JcGSILpflwYAWLp+5+KNWoTGXMsrRkzcSwZ6k+TdJaOit2h6UsTHoYfcujxYXycHmLU
	M85n1UF7o+WF9NWjvans5rC5B0QAiZGZn9j0=
X-Received: by 2002:a05:620a:3710:b0:93f:43a4:a479 with SMTP id af79cd13be357-93f43a4a615mr460264585a.66.1792445219472;
        Mon, 19 Oct 2026 14:26:59 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-93f4b03ee6esm8517385a.17.2026.10.19.14.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 14:26:59 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-rjethwani.dev.purestorage.com (dev-rjethwani.dev.purestorage.com [10.17.2.234])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id C3AF0402B8;
	Mon, 19 Oct 2026 15:26:58 -0600 (MDT)
Received: by dev-rjethwani.dev.purestorage.com (Postfix, from userid 1557719937)
	id BB53CDC0D6A; Mon, 19 Oct 2026 15:26:58 -0600 (MDT)
From: Rishikesh Jethwani <rjethwani@purestorage.com>
To: netdev@vger.kernel.org
Cc: john.fastabend@gmail.com,
	kuba@kernel.org,
	sd@queasysnail.net,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Rishikesh Jethwani <rjethwani@purestorage.com>
Subject: [PATCH net] tls: device: keep tls_sw_fallback() from encrypting its own output
Date: Mon, 19 Oct 2026 15:26:51 -0600
Message-ID: <20261019212651.733565-1-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.50.1
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

A socket offloaded through a bond has every skb validated twice, once
at the master and again at the slave. tls_validate_xmit_skb() passes
the master-level call through for that reason (netif_is_bond_master()),
but tls_validate_xmit_skb_sw(), the validator tls_device_down()
installs, calls tls_sw_fallback() unconditionally, so it encrypts the
master-level ciphertext a second time with the same rcd_sn and IV. This
cancels the CTR keystream and exposes plaintext on the wire. For a
complete record encrypted twice in one skb, the second pass also
generates a valid GCM tag, so the peer accepts corrupted data without
an authentication failure.

Guard on the content rather than the device. Offload plaintext always
carries the decrypted bit (tls_push_data() and
tls_device_write_space() send with MSG_SENDPAGE_DECRYPTED), so
tls_sw_fallback() can pass through any skb without it: such a skb needs
no offload encryption. complete_skb() now clears the bit that
skb_copy_header() copied from the plaintext original, so the fallback's
own output passes through any later validation pass untouched. This
also does not rely on every path validating a skb at both the master
and the slave.

Tested on two hosts back to back over a mlx5 port, the only slave of
a bond0 (balance-xor, layer3+4), so each transmit is validated at the
master and again at the slave. Run from each host as sender, a TLS 1.2
AES-GCM-128 TX socket kept open across an administrative bounce of the
slave leaked every later record as plaintext before the fix; after it
each record is encrypted exactly once and the kTLS peer reads the
stream intact.

Fixes: c55dcdd435aa ("net/tls: Fix use-after-free after the TLS device goes down and up")
Cc: stable@vger.kernel.org # needs commit fc6d80eb5044 ("tcp: prevent collapsing skbs across boundary in rtx queue")
Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
---
 net/tls/tls_device_fallback.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/net/tls/tls_device_fallback.c b/net/tls/tls_device_fallback.c
index 3b7d0ab2bcf1..24fba12febd1 100644
--- a/net/tls/tls_device_fallback.c
+++ b/net/tls/tls_device_fallback.c
@@ -192,6 +192,14 @@ static void complete_skb(struct sk_buff *nskb, struct sk_buff *skb, int headln)
 	skb->destructor = NULL;
 	skb->sk = NULL;
 
+	/* nskb carries ciphertext now, but skb_copy_header() inherited the
+	 * plaintext original's decrypted bit. Clear it so the bit keeps meaning
+	 * "still-plaintext, needs an encryptor": a requeued nskb would otherwise
+	 * be re-validated and encrypted a second time on any re-entry into
+	 * tls_sw_fallback().
+	 */
+	nskb->decrypted = 0;
+
 	update_chksum(nskb, headln);
 
 	/* sock_efree means skb must gone through skb_orphan_partial() */
@@ -371,6 +379,17 @@ static struct sk_buff *tls_sw_fallback(struct sock *sk, struct sk_buff *skb)
 	s32 sync_size = 0;
 	u64 rcd_sn;
 
+	/* Only skbs carrying the decrypted bit hold plaintext that awaits
+	 * offload encryption; anything else needs no work here. That
+	 * includes this function's own output (complete_skb() clears the
+	 * bit skb_copy_header() inherited), which is seen again when a skb
+	 * is validated a second time, e.g. a bond master handing it to a
+	 * slave via bond_dev_queue_xmit(). fill_sg_in() would map it back
+	 * onto its own record by tcp_seq, reusing rcd_sn and IV.
+	 */
+	if (!skb_is_decrypted(skb))
+		return skb;
+
 	/* worst case is:
 	 * MAX_SKB_FRAGS in tls_record_info
 	 * MAX_SKB_FRAGS + 1 in SKB head and frags.
-- 
2.50.1

