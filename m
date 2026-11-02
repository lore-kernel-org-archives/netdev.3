Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793635127;
	b=SZMboMY9H5TXgSXQqsn6CjYqBirwJdyUjTnCZRZw9A+bjjNQywzIPqFOJkNdiJqt5RXO
	 RDxHq1D8AWtwFFwvYACYIrB9v8SMS7cAJ8mm+5+blOIzGrWN+PRuLo6mCyt8rGUBHP622
	 WPRBLTXSsNTzrRxuzaJOyBttoxr0Iv9/qug3V9NPC0XvmmKvLz2kIU/WEyZofj/putrs1
	 6Q4VdimWTxBatKPtMgIG3AfMnsQA2hhsH47nBv8rj0FHsU/GD6qfJpbP+7CMXxR2wLvkD
	 1eVS6bSutjAazyLm/BmuGmabxqNSeKs1Ma9geYVXN3Q4ejce5HRVfIPu8HwkZbqpzqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793635127;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YfFUwr93Vcj0jqj/f2BhJnmtIuEuXP2aOzsozQyEEdU=;
	b=mM2gcyks/Q2hKXBXhUAEVLk5pq+n3AeyQbE3MBkxdM88tXqKEt2iYolhwelFuSIk7yfL
	 IODLt8mT6rdcRFXiuZK15THLac1eqLYfqVfl0dVdRFz1zUaEOoGrEtRaJMow9n3Fl2Ae1
	 mBOh7ynf/O38INph3DJm67stjIgu/PJtm5LxEA6Qdqh80pxeOAymH18ev4sVyq7IpfGI1
	 0EDMqS1cyyiSF/b5jIDFI7x8DSs8oOQw35FsaQu0FDLW0Ry+EjDihLtKExZYOhSjKnL3P
	 jRm58YGXFHbay1ZkNjhmnLOfz+cvLseE/TiogC9Xx/szYE1DUHqvMW9QCxo/Ldz7Vlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rngf56Pp;
	arc=none smtp.remote-ip=209.85.215.180
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E683960BA913
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 15:58:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E683960BA913
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rngf56Pp
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cd8ca57ef64so1761185a12.0
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 07:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793635126; x=1794239926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YfFUwr93Vcj0jqj/f2BhJnmtIuEuXP2aOzsozQyEEdU=;
        b=Rngf56PpU4IGjFdOCYHAQULBmDzlyozEeMPqw0mVhu7drgDF9CoiKq/+hT4IYGoz0F
         QcRQREfmYdBYWnQgJTFjALPHA88iIDJheI19XzEt6WifTEAttfHQglU+sqiNBrRd/rVr
         yzxu7PVrXWD9M6KZmJuoYSs/kAUixqF6DrFO0tR63VEEr/D3s3oHpjaNICGD/nwe+6U5
         KulvG0Hw2n7vPgJV5/ZULkHLSu20wLYJ5USTgpKp5dSBxFNtfwjAC9hqdHTFIcKibOkM
         SmT6mRmYUpmWDI4OYzlNo18W5rROkfBZlBLYdA/lRcr4cKkchGVZoLLdCcN7ld9Rb/bV
         RlLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793635126; x=1794239926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YfFUwr93Vcj0jqj/f2BhJnmtIuEuXP2aOzsozQyEEdU=;
        b=jjmDZJn4jxjH5FinRzkKxR+gLsauTBQ12pMBIf5wE9LUDcUifSQmfpIWlkuemCZre8
         KbCfTdb+wSp7XttqZCOi+O25QDLnIPRDvTnerU4buR6HoNWyGG5zJB6z+wIbgCHk8jO3
         8IJWgI+QfGfKXH9yUk++M6Fx+afweh4C5w6XhOJLSxZJZDdhEtBx/5bqxlYv0N9oKf76
         4UpMSStfpGerHfp9dZPGxHIWh4s3dor5dGBbshnCx7qp0zF26aZp679AKwKrHvdCCduR
         p6Vx8FigXiB2PNGJV11dTgSjbEavdDHJGQ7oNXOWsYWX02p4kfKlABn8sGYoohAEA0lV
         NEbQ==
X-Gm-Message-State: APuU4Z/SxUxooSPOrVyimxrhSNHvGMcbYzd6DHtwBI1O1rNY3GSzfkpk
	oEN9UYPn6kKW8F5oBzT+ALzyItAAk7yIYMli9k44dgOjdATkLvdwsZZea1Au1w==
X-Gm-Gg: AYBFou0+yC+jnj4/PNar51cuNBBeO4LeJpMF+HfAwzHmfeTiPcJHDPPZ5a6fmDioD+k
	gbmam9diSDRZvq7k5R5zYDXv9emZI50DletxECfuN3ZwsjXNs36E/iGIu72+Ha4NX9ZzRA3wE6j
	aRuPwM9qIboLBPbpRHMs6TCIYLk/qEgtJimiopjvd6jDnbhW5wsCi46Y3OBPOR5AfRvQ0zGXz3w
	kLSmlTbIWskx2Mzei+dTZmN0qpC5+snD8LTb0KOWDw7yv+h/kPn5PuAVrh+dsl4rJoRVHh2QhqC
	zuyyHsAjRhdIddeNN5pdtPGRn578yKDEmemHUADf6zg34BoXfL05CNV6ef/InsCCT+LXR0GfCaX
	+55qN5w/DqiW0F5amTwEO7ZbsUAKKuZFbMh1GVvjW6Q8sm5kXe8C6QeaMemPDtKDENXvSFxz72J
	decMNyjcJnaabE2jMczGeel1B4A88lJg6nxhyIiWKTVmBWcpfXlRNj2ftSn5W1KYDj1tt4K+qUB
	XASAm9g85j3Z1VEJKYi/q5p+TD0PbvHr8MayaOjoHXrqdiyXflfP1U28tfqMtQ4Q7axBicKUyk7
	wOWr+unE+K6USRhk84gz7w5g9kXnYy+qFT3tusl38KgOFJa705/3
X-Received: by 2002:a17:90b:184c:b0:3ae:3b3d:c617 with SMTP id 98e67ed59e1d1-3ae89778667mr5392634a91.29.1793635126023;
        Mon, 02 Nov 2026 07:58:46 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:7680:28::4:396])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e7d429fsm19183949a91.2.2026.11.02.07.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 07:58:45 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 5/6] net: dsa: tag_yt921x: handle FDB suspend copy tag code
Date: Mon,  2 Nov 2026 23:56:37 +0800
Message-ID: <20261102155641.3682626-6-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261102155641.3682626-1-mmyangfl@gmail.com>
References: <20261102155641.3682626-1-mmyangfl@gmail.com>
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

Prepare for upcoming MAC Authentication Bypass feature.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 net/dsa/tag_yt921x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/dsa/tag_yt921x.c b/net/dsa/tag_yt921x.c
index 294784ab6694..b8a5b6cdb5c5 100644
--- a/net/dsa/tag_yt921x.c
+++ b/net/dsa/tag_yt921x.c
@@ -49,6 +49,7 @@
  */
 enum yt921x_tag_code {
 	YT921X_TAG_CODE_FORWARD = 0,
+	YT921X_TAG_CODE_LEARN_SUSPEND = 0x16,
 	YT921X_TAG_CODE_ACL = 0x17,
 	YT921X_TAG_CODE_UNK_UCAST = 0x19,
 	YT921X_TAG_CODE_UNK_MCAST = 0x1a,
@@ -135,6 +136,7 @@ yt921x_tag_rcv(struct sk_buff *skb, struct net_device *netdev)
 			/* Already forwarded by hardware */
 			dsa_default_offload_fwd_mark(skb);
 			break;
+		case YT921X_TAG_CODE_LEARN_SUSPEND:
 		case YT921X_TAG_CODE_ACL:
 		case YT921X_TAG_CODE_UNK_UCAST:
 		case YT921X_TAG_CODE_UNK_MCAST:
-- 
2.53.0

