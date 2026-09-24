Received: from mail-pj2-f31.google.com (mail-pj2-f31.google.com [74.125.227.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B72C3DDDB0
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 06:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790230969; cv=none; b=FaQKQZbny4r20Sqd02rwO5grBP7uJ7+yd0/bMOR2K8jw/oNOOeEZ7ePg5NiA0wmULuPJDSamyBAIUh3QZ4l3QNW1FeBoI4kKl7KgyA9apU/SMnsbm8NV/4Q/P2vz65RmMDX3Bl5e5T36Ivmv5Hl77wy4RXvFJqURpQI3L7Iz0Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790230969; c=relaxed/simple;
	bh=PA4WHdZL97fHMVeMYVBzQqDhDDVdPEHyHKSQZGzkDpc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oQfHVVHSxQFc8MGL3GL9JZN+OacNYXxWUx+Fk6GqQewe+CNOVTPG390OWO5cGYFLtwt+v0IsQYJNUx1WIkxX0/SOIb0uf2Won2TRx4plVMZalu6JDh8YAHWEyiYL4RRH0C56WvkxBI++7+LfIVxW8CdFhnzAQ12teJJu/wFYDsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/lMUaCK; arc=none smtp.client-ip=74.125.227.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/lMUaCK"
Received: by mail-pj2-f31.google.com with SMTP id d9443c01a7336-2dd53691be5so11189455ad.1
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 23:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790230966; x=1790835766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lD/BJV6m0Rx8++xUr7O227okZULoxqZpRvzaX7SrdP4=;
        b=J/lMUaCKLRVqgLTwn7tCWfXPKoVqIwXhjTL3NImowkZ9JhHlyw844ac6RfSfh8HLP3
         Mt3bOrZ6uZEgDpqBAMpRRoT+GwSGddOCg8wXBPWG+9ln47Ir3XPceFK9iWgYnI4sM/3O
         +H2jKuKGMxhzWUh8P7SF++ZPFFWYP9RUuqbxITCIZQ5W/5EzGGToADbwY+66YHqeB4Ab
         EfnVWHqQ1K1Ps+zYx9wxfdq9VJZYHnJDgvqJ04ehiz0g8FBUUoaBoP3AnH6AaWsBzRuH
         18Pomi4cSznbemu1YMdknR3ycJz1RXxlDggZ1KziOjFiNyDo10DQepCerIFOAYF0q4sq
         hmxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790230966; x=1790835766;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lD/BJV6m0Rx8++xUr7O227okZULoxqZpRvzaX7SrdP4=;
        b=eArGOM5LNcYdg6avSvkcFKqXw88E4hM/gElk0eI56n6F08G2XPnMXEwRfoHvK5wJEV
         wsl/Id0sK45Hs8ZcKiZvFOHWM1QllED0W+U0tTpfIHx8Lps09aBAumeHXWuxvs/QDAS4
         ncsJt+qL/CRQRnj7Je+koxLVdVmu5w95Q8YlKOOqAhCQAds48lUYnrj8ZE+p1AFQ3bn4
         /5ZxfVFedeIIhCK7T7SMxMGmSb1fEVzTlxqd4QEKAVs+4IKsypRMvH2bs/tlAnmM1s5R
         v3IkZ8fBV28goN9pvgdb84nbLpBq9pQCM4kNaIVYPV0MAxE2tkO+fPfujniF62ny2jin
         zQKQ==
X-Forwarded-Encrypted: i=1; AKwUvBx4G+MEnm+SQxHSP/HgxqprFRXZoVfR1+DC+NnGwcikx6ETNS42bkBPpiAm0FNkCFNVZlPpUrE=@vger.kernel.org
X-Gm-Message-State: AFuF++kPlYXTMg4eaD9E19REGNh6x46lAw+9MPJItAqgg1rlCcFToo+1
	2kZCDL2cfcCyvHsO/VeXCbIaIlIdmVgv9SabXSLGWNniq9jlmYjLvW0X
X-Gm-Gg: AYBFou2hgwvvkvndag2dgs4FCIFMQKNjS4QIiMzCYxr4WnRmOsjQxtUhj80hQtiFVbc
	SInABCqFIN56V5p74MHz2yp9jJMI5EkCGVTzMgBhs0X9uKGCaG5bnqrKB3xm5Dij0ivdn8fi/80
	TxBMjZRjLxviKXuRe1ePtAl+OT0baakSgw4Y8OUkh3FsaR5gcln26fESaxp+xYcodBKj+/m2LRD
	NuO2K9fpAQrXuOfmg6Z/ik24LOpgynO6Iqnr7PwZfCD2kVG2sjI4C81Isvq05CcTaRdnXm2w6hM
	xO6Lj0D9Fa1G7dckXS+xLbeDV/0ibvU8czMaQ8ZfmWfla3TQt6dtCf4EFvm/C2E28ag5pKGbrTd
	WJjaUbNyHFgJZKH/StKHo3IfYztJmjpiu9JVxoonAWEWEQ406p5Z2nqcR8XMfx9buFRMf7VfkSq
	yA3Hr6jpM9cY5HEm7NRR374RnsErAzGkbylk1aNU5W7HqJJ+WiGoBqAIOxPLwwBoa8rlC3S9lD7
	VEjOR+MHmok1qFpErE0V2rtQZuuAPn1O8PS9gYXEP2lLJYLMqIazTzPEet3pC5WB+Kx7Bl4ObSD
	NyjhRdQrow==
X-Received: by 2002:a17:902:fc48:b0:2d9:484:861d with SMTP id d9443c01a7336-2df7e24f14cmr11867725ad.10.1790230966408;
        Wed, 23 Sep 2026 23:22:46 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (67.51.127.34.bc.googleusercontent.com. [34.127.51.67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a5d7a48sm21220615ad.48.2026.09.23.23.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 23:22:45 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: h.morris@cascoda.com,
	alex.aring@gmail.com,
	miquel.raynal@bootlin.com,
	stefan@datenfreihafen.org
Cc: david.laight.linux@gmail.com,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH net v3 0/3] ieee802154: ca8210: fix stack and slab out-of-bounds accesses
Date: Thu, 24 Sep 2026 06:22:41 +0000
Message-ID: <20260924062244.2444225-1-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes three out-of-bounds access bugs in the Cascoda CA8210
IEEE 802.15.4 driver:

1. Reject received SPI packets with len > sizeof(struct mac_message) in
   ca8210_rx_done() instead of checking len > CA8210_SPI_BUF_SIZE (256),
   preventing a stack buffer overflow when copying a synchronous response
   into priv->sync_command_response (a struct mac_message on the caller's
   stack) and matching the actual SPI transfer length
   (cas_ctl->transfer.len = sizeof(struct mac_message)).
2. Initialize lenvar = 1 in ca8210_get_ed() and validate
   hw_attribute_length against *hw_attribute_length in
   hwme_get_request_sync() before memcpy() to prevent overflowing the
   caller's stack buffer.
3. Validate the received SPI frame length len upfront at the start of
   ca8210_skb_rx() before reading data_ind or allocating the skb.

Changes in v3:
- Patch 1/3: Check len > sizeof(struct mac_message) in ca8210_rx_done()
  where dev_crit() logs "Received packet len (%u) erroneously long" and
  drops the packet, instead of silently truncating the memcpy() with
  min_t(), addressing David Laight's feedback.

Changes in v2:
- Split the ca8210 fixes into three single-issue patches (1/3..3/3) and
  addressed Miquel Raynal's review comments on patches 2/3 and 3/3.

Hui Peng (3):
  ieee802154: ca8210: prevent stack buffer overflow in ca8210_rx_done()
  ieee802154: ca8210: prevent stack buffer overflow in
    hwme_get_request_sync()
  ieee802154: ca8210: validate data_ind length upfront in
    ca8210_skb_rx()

 drivers/net/ieee802154/ca8210.c | 39 +++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 12 deletions(-)

-- 
2.49.0
