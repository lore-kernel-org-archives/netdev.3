Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794268633;
	b=Njr2oPRoH6JMee2A7osbdSh2/W+LZK39c3S9SrC1SsGA//S7eee6IB+kcVa7Im6Fd/69
	 z0bjteYcuY8ZSpaA9UUpJ1j2IUuWP56rNcfUv/39L2mKpnXy3bKrIvlVBEltrNTR0P+b6
	 6b+zA1pxfhd45Nsibdk9DS7E0Who4voLkopNQwj0VzBOjlAkKiwiCSaoQuOvQjmM9Jk7+
	 e+7OCJoTzoPGDQ+k5ZfKvP3sOo/Qh0lxBhtUyK6iUNNa9MnqK3kFOAsJWhmKZqcvwNU7I
	 tAg9du/bq1XlJZC42eO4MU6KGy8YzrX3ZtZdyFXYwN1B6LSeW8PSsvRZtHSQbNyYklA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794268633;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=bUZiKxiN9UwTPTT2/T4hOmDQIJacds4pPM6KBGzyM+M=;
	b=qvENbv8Tl8WwpoEH5t1vV9Lr56HGTcGEWEQWr0zwuvxQhYXYyOjnvjKL/1OAgvOQgqIn
	 tGsxrOlao2PVi8fMaeeRqDtK12fxdBlcqvY5zUiGiIWWJb5aWvUoy3tHn7MGl50aeSu0G
	 dAZLKD0s3CFmu07zNti1HFWePTYHvW99yd0IMwmRafrA/gMsmw0Z6V3bMs31oGqL9m4NS
	 Dxtb458RN0XmSaXH1AO01UKZVCO0DwSpQHfUk+/r8dOWXcOGi344UdmNEHYN1mU8Os7te
	 HY/RNKxDtYrGp51no30zoOJ+HMsbjW7CzADHlfPle5zMWBs+sUV+5EjbOKUSBVZIcow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=04yOWM+k;
	arc=none smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670C560A262B
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 23:57:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 670C560A262B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=04yOWM+k
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c4cb6834eaaso213950766b.2
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 15:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794268632; x=1794873432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bUZiKxiN9UwTPTT2/T4hOmDQIJacds4pPM6KBGzyM+M=;
        b=04yOWM+k/J2vJbOxXUDh0EaGXrGbLl0A81Sa17tERghvsaeSGEUO1m8vCuE+0+wxPp
         HMFndcKqi/rv+gYljgNu4I7TSaM1tkBnQdHQD9w7Iu6SB4UBq2NJrwwHL9hJyNk8Z6Ce
         wOj0pFWEtBGWhXXIV3v/uIBAjos0vitOGtyzqEe9Yyzw0ssFIs8Oxeq/QFZvhMG2qUU+
         9hHHnt73d4ll6A+gbVoYH2CCuGXmjxJ7xktkY/F2hgz2rG5LUc1F57PUedphiSVLw14Z
         WNxPyfzyBWjjULTdAKoRskqhPCQwF0chapsEaP7o7XEpZ5zcFzMNmvWz5HeVNENRAdWv
         ePhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794268632; x=1794873432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bUZiKxiN9UwTPTT2/T4hOmDQIJacds4pPM6KBGzyM+M=;
        b=fQwiahU/1UW01OWTS6VP1H79HntDBBLQ41e4GA0x3FY74Ky6+EiI8XJiPkAcCdrg3m
         3JBLrlo2DJT1AwhAaziqclr79KTtYxRTlrxRzKVXAD5GJLzdCXlo38uBiEaxZ9odeUoL
         t41JWDfezFuEd81daAdfRvs/KvM8zDLwJGzTG6rXVB1ACe5ShEqti8UvklDV3bKXjv6A
         k63NjkbFiOSmfi0chb9Tx7HkFTbugIRoQoZ3uachxtehKhfs6As1ZXSLOEIvkcMb7V0K
         SykScvi+ivK4qWjr3DDz3S7y5exRYJIkfvCSgMiU8n3F5tP99MuMXZBYjF/EDj6T3Bjz
         giAA==
X-Gm-Message-State: APuU4Z90XykAcsAKsSp39HmBIeG3194/wDrPLruG/V/E9rL0q2wjJJg5
	bP7lEnH0IMozJWk42OxooZFGgfvmVAgLoE2uKDlsXZuQRX1Sh3uF38Zk57iERye6
X-Gm-Gg: AYBFou3Pr1m4Jnh519Njq2zjCwI1vQ8zmhVr7p+6MBBLhSm5vyB80wjYzf79I8tIM6u
	1xbJkhirVpJFgtJdZsOXiDD5U2cd/+O2wLVPdTKsp/HpieRCuTnU3iknS/c5kesUq7Lf1jtsUd0
	JGWYB5cNkxm71R5LJyUu/6MDumY6WckSOam7JCgFw3scDSofLiGzD94J7nOD2VB0z+o9LV8z7Wq
	/XWsVtCJ0S4tFXvPOD6B4NFp+JPQaGAhwOMHrZbivKZNgw8xQjoqI53Nv4+NZVPAmhlXW6puSIX
	2PTI94ulDqREnRHgKjNMLlFbWq6HE2QZcyc0CMF/SOJqZ/7E9a8WzvT4Kpbm1i7BAQzbzHdMwsi
	etAfpR37rh6M1427Q/oP/LaieUnlyYDmO9Kn2c6f7UMSZp6gMAxsuQpmgYGFHZ25IBiVtD6ac3e
	Aqd957m1/Au90+onslMa9o4FmQAfHprN0Cdnn+BbZNT6OudFWIa5Eq/ep/THad6Fm5Mt4q++Z8z
	frGinL6270OAJTDpV4NpsGalpj7MdzxGAVw41b6JNjuL9O7xIk3UU2IDpizRYSUdh8eJ+eIo2u5
	9k+QLR9HQxCpUlIvnI0gGPYYibKbsphHbYXki+7G6DlnafyxWnr8CCg=
X-Received: by 2002:a17:906:b2d8:b0:c2a:b1cc:158d with SMTP id a640c23a62f3a-c504964fd7dmr42259166b.32.1794268631803;
        Mon, 09 Nov 2026 15:57:11 -0800 (PST)
Received: from localhost.localdomain ([2a13:e746:396c:c600::8fa])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a56b772sm33725066b.16.2026.11.09.15.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 15:57:11 -0800 (PST)
From: "Kordian Chmielewski (mlody1212)" <kudzo51@gmail.com>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	bcm-kernel-feedback-list@broadcom.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 4/7] net: bcm4908_enet: unmap the buffer of a dropped RX frame
Date: Tue, 10 Nov 2026 00:56:57 +0100
Message-ID: <20261109235700.2586821-5-kudzo51@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109235700.2586821-1-kudzo51@gmail.com>
References: <20261109235700.2586821-1-kudzo51@gmail.com>
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

When poll_rx() drops a frame (too short, or not in a single buffer),
it frees the buffer without unmapping it first, so the memory goes
back to the page allocator while still mapped for the device. Unmap it
as the path for good frames does.

Fixes: 4dc7f09b8bec ("net: broadcom: bcm4908_enet: fix RX path possible mem leak")
Signed-off-by: Kordian Chmielewski (mlody1212) <kudzo51@gmail.com>
---
 drivers/net/ethernet/broadcom/bcm4908_enet.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/broadcom/bcm4908_enet.c b/drivers/net/ethernet/broadcom/bcm4908_enet.c
index 8008b44a4..778920e37 100644
--- a/drivers/net/ethernet/broadcom/bcm4908_enet.c
+++ b/drivers/net/ethernet/broadcom/bcm4908_enet.c
@@ -653,6 +653,7 @@ static int bcm4908_enet_poll_rx(struct napi_struct *napi, int weight)
 
 		if (len < ETH_ZLEN ||
 		    (ctl & (DMA_CTL_STATUS_SOP | DMA_CTL_STATUS_EOP)) != (DMA_CTL_STATUS_SOP | DMA_CTL_STATUS_EOP)) {
+			dma_unmap_single(dev, slot.dma_addr, ENET_RX_BUF_DMA_SIZE, DMA_FROM_DEVICE);
 			skb_free_frag(slot.buf);
 			enet->netdev->stats.rx_dropped++;
 			break;
-- 
2.56.0

