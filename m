Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59393FC5D3
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 13:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789565308; cv=none; b=nX9s8HxmEZ7rUzwXWo5pTHHf1sshXREN+0qeIUOgNV68Gp0LNISDM0mEfEGrVdfMulMzkqU6CelWLF95CpXNYYNpqGresGGg9rDCKk6pi80fUq8qJzoltmXvi0eozxT4YGMXBcZNHbinNlBm9AjblbfA5upcq/gIMhWgY/baECI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789565308; c=relaxed/simple;
	bh=l/LXM0UEiteD6i4RRBp0oeYHPBmHxdvfFdfiGJgSMCg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pGhiBpPUD14BjPPlzqq7Onmt7KrTAx6CHa1t8dYFMeEvZ9dNM6GmradWeAUmEU1Gx0M28jowDEvXzLr5+HLO8oBYCK8Vq6Lj0/OE7vZxQ1u9Y0xi9kGgC2IxB5D8up1FkQRght1ebGh2r6zLtSNFhYePedF6qpxIXIQxDC60A6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dh8iPTOc; arc=none smtp.client-ip=209.85.160.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dh8iPTOc"
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-52fb8f67601so75899891cf.3
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 06:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789565306; x=1790170106; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6zayj5brIJIhqZZGoXG9TglnoJxeqpq7PPCjQnBCMMI=;
        b=dh8iPTOcynBKGyVbs6U6tlQoI8jKGJJpccaPNgAM7dP+sRNpAvbwvUXPKAaw3RHPln
         xsO/y35cKiAall7PR/u/Alpn/y3jVB8hMr80w5575D/pxwjiDT0uUSyYLUDsRXlOtOXm
         kDyi8jdRhI2HEMKPFJ+W1oFyJyqfyKbia5WW1QRxWF8k7m1eOiwldfne+jtbg8zo2sPm
         HKRHXAasshuKFKIZO2MKmwCL8saenSPDRyZTDJAw/PBDEN7lpyaTst61obKhM6nvaD33
         JbV/Io0UAdFwNcbHGkv2GV5NfxGVYsp96bLZ9YA8mLNsfYKj0ddSYn01YKkkKqS/TA+D
         uqHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789565306; x=1790170106;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6zayj5brIJIhqZZGoXG9TglnoJxeqpq7PPCjQnBCMMI=;
        b=vCBL78tijF0+QafRdBUV/4aen+xmtq18Z6lhs3T6Dxxz12oZ30Rhre31umGdOGIe5e
         6en3zuMbFs+/U/nvxvLC9Pb3jfk2pmtuHyIBaY86LiuckHURQJLx3b6A58X4cCSDOwSR
         QmtbMmptIzQ31PxRGUs9KZVYdES7iDq3/+PpCZJ9SQEV5PZO+Tl2++QJwhXNAD0Vw9qG
         ATv1Qc5RztnPQ00GRqG6RbGetHdz9H2oXs8kxVDsXGwL1Jlz3O9NYrHxUsOwu2kxJaXF
         s31RhMkd1oz9jyIL5o4graZcapS2GXj9A+hTHyydFJSJnhj8sDjBI3Sn7rDaqQfRdMEM
         DqXw==
X-Forwarded-Encrypted: i=1; AKwUvByNsrMveN2+ZPNi+CM6k3uBDtx60E/T3tBUNYlp0LAiC6Pi+Q5cjC0DW7kqPCA5Fv0WMgurFVY=@vger.kernel.org
X-Gm-Message-State: AFuF++na4EYknfeuM/p/wL+tAf2pXTFqKHIwpkL4Qyft+dkstoRGLEFZ
	s9siUOpJHvo6PAsuFPur9m8FJWZSHACRCIRQVjH6ON7cU63Sg6gRi8/OCVt4wPx91gOZHepWNXZ
	YH4s5xAGJIjCBDg==
X-Received: from qvbpr3.prod.google.com ([2002:a05:6214:1403:b0:912:12e9:f14b])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:490:b0:530:42e6:b18c with SMTP id d75a77b69052e-5327eef32ecmr45935961cf.42.1789565305323;
 Wed, 16 Sep 2026 06:28:25 -0700 (PDT)
Date: Wed, 16 Sep 2026 13:28:21 +0000
In-Reply-To: <20260916132822.1791040-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260916132822.1791040-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260916132822.1791040-2-edumazet@google.com>
Subject: [PATCH net-next 1/2] hsr: annotate data-race around hsr->sequence_nr
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

hsr->sequence_nr is incremented from the transmit paths under
hsr->seqnr_lock, but hsr_fill_info() reads it without holding
this lock.

Use WRITE_ONCE() in the two writers, so that a matching
READ_ONCE() can be used in hsr_fill_info().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/hsr/hsr_device.c  | 2 +-
 net/hsr/hsr_forward.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index d14de44e14b7a9f451cf24fdd20b70d77eb623b7..fc512204600cd83b08bcaaff28bcaf44ea044f1d 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -333,7 +333,7 @@ static void send_hsr_supervision_frame(struct hsr_port *port,
 		hsr->sup_sequence_nr++;
 	} else {
 		hsr_stag->sequence_nr = htons(hsr->sequence_nr);
-		hsr->sequence_nr++;
+		WRITE_ONCE(hsr->sequence_nr, hsr->sequence_nr + 1);
 	}
 
 	hsr_stag->tlv.HSR_TLV_type = type;
diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index 7734a521a96c23f6a9c18c03ae239fb12e55bee0..44f6d9c83180a6316b06afef1af9bbdb2e340f75 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -645,7 +645,7 @@ static void handle_std_frame(struct sk_buff *skb,
 		/* Sequence nr for the master/interlink node */
 		lockdep_assert_held(&hsr->seqnr_lock);
 		frame->sequence_nr = hsr->sequence_nr;
-		hsr->sequence_nr++;
+		WRITE_ONCE(hsr->sequence_nr, hsr->sequence_nr + 1);
 	}
 }
 
-- 
2.55.0.1032.g73a4cd73de-goog

