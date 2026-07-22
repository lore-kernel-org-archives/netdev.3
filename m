Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C712C35676A
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 14:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784729868; cv=none; b=JuNLa89pY//HxxTaOVPNsxMuA6ADhI6SsedPvwiGQyAEFKaP4Zkn2pl1WD63GIVPWFXi6qW75jUylsKm6qIgCY5gFpZo6fwC5FGuJjgR/Oigvp1NbwwTAMN1FoDueaBw0YZyrje5oyzVqZ5TCo3qZXWIGbcbdnJvG+cBpAxZdvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784729868; c=relaxed/simple;
	bh=aH8UcjszgIBrGeBMhwyqf+X3ZD47i9IrgoA+orYyiLM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=XlqFnyJUsLOOX/9otNz7jiHS8Hof0SnBIzjMY49FZnFN3WNUOvKNH4gLWRLtVbA5c+ljARn7am2wLftfJdzsaQWJKRPZ3Ay+rVphejL/Gq0kzJan0QmE5En4/ofm3Xpe4kz9SuY9QRQv0eEk0vPYuchHhbNSmie1UpNbXVB8qe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MyVWbxtb; arc=none smtp.client-ip=209.85.222.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MyVWbxtb"
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e62e3459fso2191167085a.0
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 07:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784729865; x=1785334665; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=i1YDknR4M2L6eaOXoyl8YhUpJHW9LlyoLKbniSckgdw=;
        b=MyVWbxtbOvCArbS3x9R2iJKnOrP+oVzcl8k+fRca5iUcLP5KGzElR4U8eMS76zDQgH
         PZiBfZvEWu+Po26KchqIFAm05unSqx4zBQgLyAnG1BIm/Nyh6UbcJJyA/X2n+djnljT6
         uTrRjm1/VlAoxHfHyQDiVpunv6kw/et/ihtt1g6HeyV5L/79RtpJiO4fQxhChOBQMCJP
         aRtOdZAzyB4ohClG6XM+PdFwP1AheopOYouCxf8IOo1Kj69gEoUvSY9nJMJ5ryDAHao7
         qm36NgfFBh3x5YCde3u1HGgH28+83mUvxjALcQRbbvfTtOqakKvh6tp3Ru5Eu6TPqIXD
         cYcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784729865; x=1785334665;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i1YDknR4M2L6eaOXoyl8YhUpJHW9LlyoLKbniSckgdw=;
        b=joUCv6U+t9EsxlOBIwxMSJ3A6/GXDydPNDBtttnMpRs3sW+iERp/V7rG9MOQqG87L4
         UZGN1Zm2K07fpItamS4qeS6ka1X7Ju1kAkmEHThCl5Pptsms7iKhs24O4+ZFUkGfWOkK
         d5KxSBwz/0QmK/JUqLJOZYOQoWJjdiB1ZyM1bN+YWMdgXLYKMjiyqfEatATux5CmllG5
         2tFDprMpbv5XU4DlkP1aAB9em2HtEnRKKXn9JKDYSZ/kWlfzRldRYT0BrwrM4l2esowH
         onJQsNebgaYnLxuLOPSsoVBFE5y8utezg4c6s/ulZDhc0vUtRBdanzp32ml+TIybjW84
         Og3A==
X-Forwarded-Encrypted: i=1; AHgh+RohYUVnGWXRY/gDdbXYZ7AhrvAfuI6mMg8n3B2coAt1bRxPD7QoUAJC18Wd4yYYvJkTEnAG4wU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHL8sfCCzMN/7vDH8fSHFjswOjOEI+lTd0smtkb4eV0JnKX8Gu
	9qzx+A6wdiOw/TdA5tvi0sAWH9eac0kweBpimFAR79pCd1B6mARXNSwrf3DGj2gS56xRHxTJ5tT
	eU1rg68YRNfRUmA==
X-Received: from qkaw4-n2.prod.google.com ([2002:a05:620a:a2c4:20b0:92e:6af1:b53e])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:318a:b0:92e:6a33:7118 with SMTP id af79cd13be357-930b3ee734dmr2185676285a.30.1784729864909;
 Wed, 22 Jul 2026 07:17:44 -0700 (PDT)
Date: Wed, 22 Jul 2026 14:17:41 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260722141743.3266924-1-edumazet@google.com>
Subject: [PATCH v2 net 0/2] drop_monitor: take care of 32bit kernels
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This series fixes two drop_monitor issues on 32-bit architectures:

- Patch 1 uses nla_total_size_64bit() for PC and TIMESTAMP attributes to
  account for alignment padding added by nla_put_u64_64bit(), avoiding
  potential skb_over_panic() crashes.

- Patch 2 moves u64_stats updates before spin_unlock_irqrestore(), ensuring
  local interrupts are disabled to prevent seqcount corruption from nested
  interrupts in probe context.

Eric Dumazet (2):
  drop_monitor: fix size calculations for 64-bit attributes
  drop_monitor: perform u64_stats updates under IRQ-disabled section

 net/core/drop_monitor.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

-- 
2.55.0.229.g6434b31f56-goog

