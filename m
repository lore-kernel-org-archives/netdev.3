Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793223367;
	b=AQzVSzJmoROrqNILBFDExfEErtz2B7nkDazpuBvp25+OG71dSByKNwitYx+/GQBitGYI
	 vcCR+HebjHdVoxIhvyHzNDKTHvGKXgQRYnL8+Xy/RESqmEpoI2002SJkpt6Hh6AOBvccG
	 f6VHXLbZTzbaxtC/mXmPhCP1Evn7Idi5gH01JSzaQSYYY8XOhOML9omU4X++8P0ELSM+8
	 hjZfYZkNWRDJ9cK1X5Uqw7agM0IyWyCWm4DgUbEHDvryXgliy/2pi8M90fC/Z7e23nDIS
	 Y4+4T0NQHOSkuIjzkMSxX26tldKXElS3daZhXjWF3pvLhoKxctRbMYTOiG4lph1q26Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793223367;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Subject:From:To:Cc:
	 Date:Message-ID:In-Reply-To:References:User-Agent:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=iuRE5e4D91PVpa56+W16RmW8bTwn0KvmGTt79ShEut0=;
	b=nmT1Ez561xCeXpnkFOiqu0fDPH3iyIzNg1rUDICTDPJ/AeHdHyYr5SuB5XvSmvZuRqXa
	 nmNVNV/FCUQlG7AHXCQuHH7OaMkPZMqedQcrTSIhCDJu5sX7U6EtivyQjl+dJWUvUZv27
	 lVnxq9hsBVoTpEcoeLFtB/h7ZQw2o6bWu+ZWGZRQdel5MVWZJeOfRDJBjY+5Hee0ATyxy
	 A1rbmklj79Pf8GFPNPAgwEbYpKKnttcz6gwKC9gwICLLszHBxMZ7W6Fj0g0cq0XXJO8yi
	 9IXj9b3zOVzw8Pq6Uhf+VZlU7mbOVzfuQld2R7XAyiwhTqYrc23dkvDX8TpPHOW//OA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZLqZgG7Z;
	arc=none smtp.remote-ip=209.85.215.172
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2F7606A31A
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 21:36:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C2F7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZLqZgG7Z
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cc1bc88a20eso938283a12.3
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 14:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793223366; x=1793828166; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=iuRE5e4D91PVpa56+W16RmW8bTwn0KvmGTt79ShEut0=;
        b=ZLqZgG7ZUDGG+0TVvAUaNNzGlZHJcEmMZXXLlX9U1QXqoXxp+G5wRZkp/ahUiMJhGA
         Fegh83hWOVeLzbeo753Rh2Bqo1BwQczoI9qAk1yR+ZkOAHujhPECtIQGGhBojKTorRSO
         junP5sgVSfKoEQ5b/Hn+UVjygZf3tz3ADlKamuCAzWzqeQLnN4Ubhz66DBFM+/jzoitt
         lKrJ1lXpPjB1t68khMF8Joieyyw378rwnBvLgQm4gRqChmB2EQQoeyyVZrtqUv/WrISW
         owoNR4T1PmxgYz1hmuuzS5vv2VCIZ+SPV3jXYy913/eZgTmI341r2bCnlUTGGrOOnJxa
         2FmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793223366; x=1793828166;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iuRE5e4D91PVpa56+W16RmW8bTwn0KvmGTt79ShEut0=;
        b=Bxn1OtFz4MCvu2DVR4yHPaszPEkc+RRgiJkMg0VKiRSACWyXUK/EEc0I+SDOcslqe9
         ZoQqhnsO47rgP+WtZpxX8+n1mwtv8Tts8nm6PcQkMw13YGa/GNkHd7K5WIfRNdyPv+oS
         K1swE+8y3q/B1Y6io1XN97FCtgPrMfnSEcHsa5mtgKhS3emO5AovjbNp9hWE0GYaUQGB
         t5zfGpQeZWN48hxQaF67GDrP5sqJLxN05uRHHztEgLR9KJa8vLiB/1s6RBOH08bCuYZw
         2hW+7QndgzWOeFQFCrKTekLAoePmtedj+LGCyogJ3G4QQRd0kedUiNo8afg+AgjN/z+k
         pTiQ==
X-Gm-Message-State: AFq9FYI4xW2NQg/pm0Ho6rHCcLANTAG4JdVWBBoa2LsVVepVAbZXEgJe
	XGGNQoxAQlDlEQTVMyGEHJ1QSZGHXbB/KiTrwlk/A/+X6oarWj1Ui0vh
X-Gm-Gg: AYBFou0IbFvbC0docLLNZr/XJlhriupgYHHbhl03Iy7a15my8o3w098h8v027LQPhHV
	nJNqEFHYynqaF7GT2a5u363ZpccUzqiB2BRXntwBCZCulVKgWWerOoiiZq6kHTd364/8V0/t4Bt
	Bs5NDTsGpwffMAtVTd9pplzRASMyBwMV04wn/enDYJN8AkdbD1msFzesQGtGeCWjuq1dqEo2sDC
	YdKhd4lYJynNk2vIGnY2wRBtGami/ztRJPy5S7epA0LJ6bN1XOdesGdvPY669SYBlmnQuVPv0dW
	Imvoh/TrahtjR4m/NyUfUjQ8pNOLdKRWHeUJtiRBdVkB02vE5DDpg3f9qiiWHtPkdeGi1EvSApC
	pDXCbZiwMNr5fdTsADW5IwbAtVTHl5QO2M2SmZytCeywxuz83CYcYnoweU+1EnZeSTq+Ka1gk4L
	noAK6A6Yj7mf1XdjZKzt+zULY4EpnYm0o2taXWO8KUKnQpipAV48CHimyBysNRKQvVYEI1WYOkX
	3dwD1432w0krxX8JAHTFvtXIDFf4NiE7qO430BWrRvandFSrhiTmfguVF51fP1tEtwfG3a9+88s
	mwFQcWU1+qtaFN6abe3J16/xtwb7o1+nhP1YATTK/4GL1p3ps18qodZZvGmig/R/cUL4wOVA/oc
	JHjgJM/6HXx43q5oe8IiB10TX326vU4f4DZCGcfWDqf1cStGUNfs1lXPMQnUfy71sM0Q=
X-Received: by 2002:a05:6a20:9185:b0:3e2:a9cc:3ece with SMTP id adf61e73a8af0-3e90226cd92mr3430097637.23.1793223366451;
        Wed, 28 Oct 2026 14:36:06 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c1:38c:400:22f5:2de:b9c3:f27c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a6a6c03c09sm1567067b3a.35.2026.10.28.14.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 14:36:05 -0700 (PDT)
Subject: [net PATCH 01/13] fbnic: Reject a short MAC address attribute from
 firmware
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, kernel-team@meta.com, kuba@kernel.org, pabeni@redhat.com
Date: Wed, 28 Oct 2026 14:36:03 -0700
Message-ID: 
 <179322336327.40667.6639719339988113582.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <179322311834.40667.5383039334126572422.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <179322311834.40667.5383039334126572422.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
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

From: Alexander Duyck <alexanderduyck@fb.com>

The TLV validator accepts an FBNIC_TLV_BINARY attribute of any length
from 1 up to the size in its index entry, so a MAC address attribute
shorter than ETH_ALEN passes it. The fbnic_tlv_attr_addr_copy function
then copies ETH_ALEN bytes regardless, reading past the end of the
attribute and, for the last attribute in a message, past the end of the
message.

Check the length in the fbnic_tlv_attr_addr_copy function and have it
return an error. The fbnic_fw_parse_bmc_addrs function stages the
addresses locally and only copies them out once all of them have parsed,
so a bad address leaves the previous set in place instead of half of a
new one.

Fixes: 20d2e88cc746 ("eth: fbnic: Add initial messaging to notify FW of our presence")
Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c  |   16 ++++++++++------
 drivers/net/ethernet/meta/fbnic/fbnic_tlv.c |   21 +++++++++++++++++----
 drivers/net/ethernet/meta/fbnic/fbnic_tlv.h |    2 +-
 3 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
index 49b8813a3564..bcbeb0814b82 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
@@ -596,6 +596,7 @@ static int fbnic_fw_parse_bmc_addrs(u8 bmc_mac_addr[][ETH_ALEN],
 {
 	int attr_len = le16_to_cpu(attr->hdr.len) / sizeof(u32) - 1;
 	struct fbnic_tlv_msg *mac_results[8];
+	u8 mac_addr[8][ETH_ALEN] = {};
 	int err, i = 0;
 
 	/* Make sure we have enough room to process all the MAC addresses */
@@ -609,13 +610,16 @@ static int fbnic_fw_parse_bmc_addrs(u8 bmc_mac_addr[][ETH_ALEN],
 	if (err)
 		return err;
 
-	/* Copy results into MAC addr array */
-	for (i = 0; i < len && mac_results[i]; i++)
-		fbnic_tlv_attr_addr_copy(bmc_mac_addr[i], mac_results[i]);
+	/* Stage the addresses so a bad one leaves the old set untouched.
+	 * Unused entries stay zeroed.
+	 */
+	for (i = 0; i < len && mac_results[i]; i++) {
+		err = fbnic_tlv_attr_addr_copy(mac_addr[i], mac_results[i]);
+		if (err)
+			return err;
+	}
 
-	/* Zero remaining unused addresses */
-	while (i < len)
-		eth_zero_addr(bmc_mac_addr[i++]);
+	memcpy(bmc_mac_addr, mac_addr, len * ETH_ALEN);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_tlv.c b/drivers/net/ethernet/meta/fbnic/fbnic_tlv.c
index 3ef3935c0419..e1ef134ddb94 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_tlv.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_tlv.c
@@ -724,12 +724,25 @@ struct fbnic_tlv_msg *fbnic_tlv_test_create(struct fbnic_dev *fbd)
 	return NULL;
 }
 
-void fbnic_tlv_attr_addr_copy(u8 *dest, struct fbnic_tlv_msg *src)
+/**
+ * fbnic_tlv_attr_addr_copy - Copy a MAC address out of an attribute
+ * @dest: Buffer of ETH_ALEN bytes to copy the address into
+ * @src: Attribute holding the address
+ *
+ * The validator accepts a binary attribute of any length up to the size in
+ * its index entry, so a short MAC address gets through it. Check the length
+ * here rather than read past the end of the attribute.
+ *
+ * Return: zero on success, or -EINVAL if the attribute is not ETH_ALEN long.
+ **/
+int fbnic_tlv_attr_addr_copy(u8 *dest, struct fbnic_tlv_msg *src)
 {
-	u8 *mac_addr;
+	if (le16_to_cpu(src->hdr.len) != sizeof(*src) + ETH_ALEN)
+		return -EINVAL;
+
+	memcpy(dest, fbnic_tlv_attr_get_value_ptr(src), ETH_ALEN);
 
-	mac_addr = fbnic_tlv_attr_get_value_ptr(src);
-	memcpy(dest, mac_addr, ETH_ALEN);
+	return 0;
 }
 
 /**
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_tlv.h b/drivers/net/ethernet/meta/fbnic/fbnic_tlv.h
index 9c4e4759394a..baf8e8b40b90 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_tlv.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_tlv.h
@@ -136,7 +136,7 @@ int fbnic_tlv_attr_put_string(struct fbnic_tlv_msg *msg, u16 attr_id,
 struct fbnic_tlv_msg *fbnic_tlv_attr_nest_start(struct fbnic_tlv_msg *msg,
 						u16 attr_id);
 void fbnic_tlv_attr_nest_stop(struct fbnic_tlv_msg *msg);
-void fbnic_tlv_attr_addr_copy(u8 *dest, struct fbnic_tlv_msg *src);
+int fbnic_tlv_attr_addr_copy(u8 *dest, struct fbnic_tlv_msg *src);
 int fbnic_tlv_attr_parse_array(struct fbnic_tlv_msg *attr, int len,
 			       struct fbnic_tlv_msg **results,
 			       const struct fbnic_tlv_index *tlv_index,


