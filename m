Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76EF360EF7
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 01:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788314239; cv=none; b=DyKVMJ/l5nLBNytF8uNok+dlyxkbeLkRkgwZI69uUi1tox4x7UAQDlHG6gUx7PEfH2L5jS9Q4m9KAXy1rSiBi1zm1CDbbSH9RPld6t0ihLB/3kpx/2IQYBNGfTFdjuKaXSs6zogicdf+ioFLFeujZK2UbD+rT4WHU75djy3YWHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788314239; c=relaxed/simple;
	bh=BbAaCQB7dbM5OXIrUKctmQd49Nq9NQDn7kVzcUeO+rY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W4CTnKlc6oniDm8iwxx/wDilBLzFK+ESOWBWSXhc3q6h0oIXn0dXshw8NqdOl8RT3+rgaWML3930w0+mTl1rgM+KaaQdBxpmhjFaAi7NkmSMnzfd6h0CKWMmGwWFJJlriFB6taI4/wE2KRS6J02Il4QTU3oBKP+cCplxKrMreZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=dGdZoZ3v; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="dGdZoZ3v"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2d944747d41so5540595ad.0
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 18:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1788314232; x=1788919032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=P0K3a0PFyIF8VGBlxiVsFCDBZmt3O9FnRDsP9ifnbj0=;
        b=dGdZoZ3vFIb2KISyBUB5T/fh31fs22aWPM07ZFxZomzhha79WpdM1ToCux02oMqMMi
         PgrSNUgoo2WFawWqvjF4XUcGRQTqkBWgVDO3s0YmjGjjK0yIx/6bYAPFu96eNMm2Qw7J
         2B9qdq01/PufyKEEoi6wB1ajwvL+rYwQS6qdpga7oRlpWiZkLnjyoV0GEfStPk0wI56r
         RoGWcS36QrdP5Ky6+V5Y23fFPG4hr3lzGBD7Q3YGznPqMajv2c+fpB+I6CClPsKD2Fxe
         cpIDbD2pP5c/BWd//GMttc6U53p7AYa4ypGKA9XtMmRdUJG7IZelGC7VyJJvf2FxhfI+
         BppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788314232; x=1788919032;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P0K3a0PFyIF8VGBlxiVsFCDBZmt3O9FnRDsP9ifnbj0=;
        b=ifumDeKfEgxOUOIVwiMfTbsLqjUJOn3vUQYQVoM8+xnhQeGzOo/hWWbbV/aaCJCVHu
         LAVgRHjKjXd5yW0ZA+d2Zk07W2PyrEp/zwbR5KCdkDANj1U7NIXq1GZHBYdtulDAdl8j
         P2Y7LzfRnPi6Gk9aLmWzFIVAUXzyDv1R5wdgSndNMx2jA0MY5PsyxbJMnirEEU8Mw0bQ
         bHKyxu+XoJwMHBcEKCCez1gJLL4hcoNwPCivKkHSGP9woWKSjX43pkuiUndIquOMKUmB
         1MKs2Z401ISFwh6M/e9D78D1koKB60p1/9t/bG+/n3G3+YW2tIwErIc/rpGn0EZ0BJk2
         wlSA==
X-Gm-Message-State: AFuF++npea0iHMGmyYiMhiCW/RdUFsFflgJT9SATr617oMweAf9EAZ8i
	3KcMlzv1YPyl2u9F7+ka5oC7Z/426FLI15JhbDq+zgAc5RsYkMhjHTB+QLkTAaRDYPfHsHfd6hT
	LiM6FJCk=
X-Gm-Gg: AYBFou0ka4Q0vhBTgs/5O7edUH4EH5rSabloD7NMFZDvklfQcNSQqsVcGxE0jDXk+1U
	8xVkCLBtOOyWRDqNojDrXQoiY2ItwAPYqGaxgIiPifLfpG/UI2vNqzKta57xLvbzbFBuJxd1zh6
	cyl9YdCFUXLLQp2TQTlmw7L6shxSLUhIoEZiUmbbHjluXTSom1jFeP6nOwph+pzmh1ggm8PQWsZ
	a6895ZuFohrhGmOOeWzw5Groi0kuQBj7Ivy8CVAVyEhR3ji5pXsaP0KDu9ThegOmptc4WxYtuD8
	lr8pdyZUs4IZcmBSjQZiRolw600PBC36oRAcUTxuKZr9MbkPFdgi12VJDZqW2dvgfkF0swT7KV5
	VBsOyR/u13XjeMxc8C9B1JMrrZtKhd9ZSvn9ZZTF6GCLrorLjo7TXmEYbiZOzqVnWcXWGM4GgQ1
	Rgt6AclpGgp+KlhUgNaKZhRUci5yk1Valg6AkwkT0Wl+CaV0bVSeA=
X-Received: by 2002:a17:90b:5384:b0:398:ceef:edbd with SMTP id 98e67ed59e1d1-39aee1bbae0mr2087119a91.18.1788314232120;
        Tue, 01 Sep 2026 18:57:12 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:6::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990d76622csm8876306a91.11.2026.09.01.18.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 18:57:11 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	colin.winegarden@broadcom.com,
	rukhsana.ansari@broadcom.com,
	linux-kernel@vger.kernel.org,
	raphaelcf@meta.com,
	Joe Damato <joe@dama.to>
Subject: [PATCH net v5 0/6] Fix a variety of TPA bugs
Date: Tue,  1 Sep 2026 18:56:43 -0700
Message-ID: <20260902015652.2421609-1-joe@dama.to>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

I am sending this series as an extension to my v4 [1] which was just 1 patch.

Note that patch 5 of this series can now cause the device to fail closed if
memory is tight; bnxt_init_nic propagates an error that was previously
swallowed and fails closed instead of succeeding in a degraded state. If the
maintainers want the device to come up with a partially populated rx_tpa[],
then patch 5 can be dropped and this series can still be applied
and will otherwise work as intended.

This series addresses a variety of bugs orbiting the TPA code in the bnxt
driver that Sashiko (or Clashiko or whatever) pointed out and the series ends
with the patch from the v4 [1].

A lot of the noise generated by the AIs while reviewing my v4 are unrelated
bugs with different fixes tags that, IMHO, distract a bit from the crash at
boot that is currently occurring with Thor2 hardware on recent kernels.

That said, I've tried to wrangle this series together which I hope will solve
most of the important bugs the AIs are feeling something about.

I do not know what other rabbit holes the AIs will find when I submit this
series, but if there is some reasonable stop-gap that we can get applied to
fix the crashes on Thor2 (while I iterate on the rest of the bugs at the
pleasure of the AIs) that would be excellent.

I boot tested this on a Thor1 and a Thor2 machine and there were no crashes at
boot.

Thanks,
Joe

[1]: https://lore.kernel.org/all/20260828190900.1767611-1-joe@dama.to/

Joe Damato (6):
  bnxt_en: Only restore LRO if the device supports TPA
  bnxt_en: Don't free the live ring's TPA state on queue restart failure
  bnxt_en: Propagate TPA buffer allocation failures in
    bnxt_queue_mem_alloc()
  bnxt_en: Handle buffer allocation failure in bnxt_rx_ring_reset()
  bnxt_en: Propagate RX ring init failures in bnxt_init_nic()
  bnxt_en: Bound SW TPA IDs to prevent crashes

 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 57 +++++++++++++++++------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  2 +-
 2 files changed, 43 insertions(+), 16 deletions(-)


base-commit: 1d2929d0850fff683b8aff051275945e65f082c8
-- 
2.53.0-Meta

