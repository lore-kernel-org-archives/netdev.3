Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1FC49EC4D
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 20:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789417479; cv=none; b=UHcAt0mQPElDdvNyLu44PEBZq1sTvnKRMCn/nY46rGcidFY/MAYF2Q4DG5IkxBMGQ0xghFj+hHnwRpGMsTspDg6Qj1zJqv9IRkknR36YkMz/qfSAyiTsZoaQydO4R/hR3YdkPgc4w1jhPnHB+eQCAR1nA7ODDIns5QlbKNSJuI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789417479; c=relaxed/simple;
	bh=x+jz7UKcqq0rDrzoYYBYh3A5KCcmjzm/9GvSwZsW/zE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EfN23ASj2STE7bIA4EA9oWMl793AC3fMFtwG3rYoxfs6QytCLato59rszF6C16qKq4p2FBQZbsHXpHiWHZzDGugPitQA2gMuxxUmSc/yWjbbFJWsL8ategdJZf4chNT59AI5iZq/gwunzNFcISDBxKRTjq0cEcAoR9IsTJm9tQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=BkXgEy3d; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="BkXgEy3d"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843c3ea1f6so1109694f8f.0
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 13:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1789417470; x=1790022270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=szNLjYOWpVIGeVzTm6wu2jNgdA0Q8lKnYCuvZd0lPlE=;
        b=BkXgEy3deTn5FchhgyrNMfNOPPOLEQdxlXU4rt01af/u5VGJYHwUQ7lSVmztHlY1dl
         1ebwYqYoAvWimTJw4al3OC6PUZ4dH4tVj/l1aLwbDTQjAHzfw1A/ObJrvAOK1gRKg2ED
         w3lRhFbaDH2DFWn4jsIah7VG7IHEafN9ZsgIE3zySBHfMAzLJ1dNKD7UiAiLpLd1GCM3
         Bs3rl8L3RTLy2zOzKkTlZLKPBrTr7IxoYpnTt0Wx3Uz+W+flgwci+IKGExCW7awVkIx9
         hYqG+B7TtmCmhsvfUBuwzAhIENDUYIjacoqqsFWNSyH6C1Bn+qF1TjxbIeuev/0S6F7R
         FlrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789417470; x=1790022270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=szNLjYOWpVIGeVzTm6wu2jNgdA0Q8lKnYCuvZd0lPlE=;
        b=fI/xw0XguSy+KFcECTQ1IuyOg6DtQSKdsenD4/Wbzt1fpSiw0481XFUzYCbc9EjqSk
         HeJffTGqbkYBbV3o21speyLBcgf9Vr+fw9wslLvaO7FKv4sJ6rAgBooSkbvJKi0AbL3e
         r4adknPag9oZvUtWR2v25hUZbvMG9NYeLU0VrBmxiVtCLIJANioXdYX2w1VeUY01uqFx
         5icAX3Z6I+vepxrkSNnZ+sc+KliYZpBXKqTKZVFRzTCSS5Vi9qgwc3JF+Ru1mEE+07hc
         btkQo5jsLvws6hJCmhriCzO0yrCOcGYe5AuccGVeSgc7L+/r+NHqc5QsHlnzyVlIw+rH
         bSPw==
X-Gm-Message-State: AFuF++kCFbEltT1CwT8/plD1HdVjza7Q8A1rN6m9IbYBADA2oYFxDThj
	s7i5eXIL5jY/+dwbbWOv6jVoD771DqpBOfCVsAZ7IVbtgStSTCFEAtPl9s7KquqImDEbw4pTjjm
	v19RhNWl5SqjkQ4k=
X-Gm-Gg: AYBFou1j/1G5B3VdYC1M4V1oRWZmLJCxtyi0LY5O1rUpNZgbJ9ZsbIxT788jrXdDmN3
	7LTn9CckVLOxTOyl9AXW3pZfU9fQEgyOqyd9Yv6ccfpR+bZuvkkorl1iI9TmOowBpc5So7jRwz6
	KIMRGsIz3RNZ/g3tYkM58y4myGgWzxmM43GTlMTKuWOdbGHhJlejffKZeHPEHc4JCMB7XGTeHOE
	QybJ1cGKUfj8S38ciU4ebbn0qld+fwyqb0qmUhFnXh1HIOgdcANPRPAIKFRd7DXGbmN7guuDG+t
	DNtywMtowOTL2FrtF3Za++ljE6fcfsTOUYaVqxIxiBY0MNeYv2+POPSLKk+oqmpQRAvkIJceCf9
	dOQmx39w0UqliOEJC4hYuj5VsOAwCmvpoCnXBgEjlFc65qbvH8jubp7XAazgSYEYSN/ftyV/ZgP
	rZdBktRIlGiNbui3k3q+wDkmbEOlPgKgUhLmmolAE/dAZlru5CKA==
X-Received: by 2002:a05:6000:4282:b0:485:95b7:fe8 with SMTP id ffacd0b85a97d-48702b1665bmr5620151f8f.25.1789417469778;
        Mon, 14 Sep 2026 13:24:29 -0700 (PDT)
Received: from remote-01 ([84.17.55.229])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb34fdd2sm29328458f8f.28.2026.09.14.13.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 13:24:29 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: netdev@vger.kernel.org
Cc: chester.a.unal@arinc9.com,
	daniel@makrotopia.org,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Aleksei Sviridkin <f@lex.la>
Subject: [PATCH net 2/2] net: dsa: mt7530: unregister the switch before freeing its MDIO IRQs
Date: Mon, 14 Sep 2026 23:24:21 +0300
Message-ID: <20260914202421.2737079-3-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914202421.2737079-1-f@lex.la>
References: <20260914202421.2737079-1-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mt7530_remove_common() disposes the per-PHY interrupt mappings first and
unregisters the switch second, but phylib only frees those interrupts
inside dsa_unregister_switch(). Unbinding the driver therefore frees
descriptors that are still in use, and the switch's own regmap-irq thread
takes a nested interrupt on one that is already gone.

Fixes: ba751e28d442 ("net: dsa: mt7530: add interrupt support")
Signed-off-by: Aleksei Sviridkin <f@lex.la>
Assisted-by: LLM
---
Found on a Netcraze NC-1012 (MT7981B + MT7531, 6.18.44) directly behind the
regulator fix in patch 1: with that one applied the unbind stops faulting in
mt7530_remove() and reaches the teardown, where the kernel says what is wrong
in words before it dies.

  # echo mdio-bus:1f > /sys/bus/mdio_bus/drivers/mt7530-mdio/unbind
  remove_proc_entry: removing non-empty directory 'irq/81', leaking at least
    'mt7530-0:02'
  WARNING: CPU: 0 PID: 4629 at remove_proc_entry+0x1d0/0x1f0
  ...
   mt7530_remove_common+0x1c/0x30
   mt7530_remove+0x24/0x90
   mdio_remove+0x20/0x40
   unbind_store+0xac/0xb0

  Unable to handle kernel read from unreadable memory at virtual address
    00000000000000ac
  pc : handle_nested_irq+0x28/0x168
  Kernel panic - not syncing: Oops: Fatal exception

The WARN comes from unregister_irq_proc() under irq_free_descs(), fired for a
mapping that a PHY still holds. The captured record shows one, for
mt7530-0:02, and already carries the W taint bit, so at least one earlier WARN
fell outside the ramoops window. 294 ms later the switch's own regmap-irq
thread - PID 627, Comm irq/53-mt7530 - takes a nested interrupt for a mapping
that is already gone: irq_find_mapping() returns 0, irq_to_desc() returns NULL
and handle_nested_irq() locks desc->lock without checking, which is the read
at +0xac in the trace. Both timestamps are from the same ramoops record.

Reach is wider than the board that found it. mt7530_remove_common() is called
from both front ends - mt7530-mdio.c and mt7530-mmio.c - so it covers the MMIO
parts as well, which have no regulators at all and never meet the defect patch
1 fixes.

What decides whether a given switch is hit is not the irq_domain but whether
the PHY interrupts are mapped on it. Either mt7530_setup_mdio_irq() created
those mappings, which it only does when the devicetree has no mdio node under
the switch, or OF created them from per-PHY interrupts properties when it has
one. A switch with an irq_domain and neither is left alone: irq_find_mapping()
returns 0 for every port and irq_dispose_mapping(0) returns at once. The
teardown is guarded on the domain alone, so it walks that loop either way.

Tested on the board above, with both patches applied. Two unbind/bind cycles
back to back: each unbind removed mdio-bus:1f from the driver directory and
took lan1-lan4 with it, each bind brought them back, and the two cabled ports
relinked at 1Gbps/full. uptime went from 167 to 183 across both cycles without
resetting, and
pstore gained no new record. dmesg carries one unrelated WARN, from
sysfs_remove_link() under dsa_user_destroy() - a separate DSA
teardown-ordering defect, handled on its own - and it fired once, on the first
unbind, not on the second.

Not tested: any MMIO part - there is no MT7988, EN7581, AN7583 or EN7528
hardware here. The object file was checked instead:
after the change mt7530_remove_common() calls dsa_unregister_switch() first
and only then tests priv->irq_domain and calls mt7530_free_mdio_irq().
Built with W=1, no warnings; checkpatch --strict clean.

 drivers/net/dsa/mt7530.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 3e61eb3c2b1e..90fd04665ebf 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -3593,11 +3593,11 @@ EXPORT_SYMBOL_GPL(mt7530_probe_common);
 void
 mt7530_remove_common(struct mt7530_priv *priv)
 {
+	dsa_unregister_switch(priv->ds);
+
 	if (priv->irq_domain)
 		mt7530_free_mdio_irq(priv);
 
-	dsa_unregister_switch(priv->ds);
-
 	mutex_destroy(&priv->reg_mutex);
 }
 EXPORT_SYMBOL_GPL(mt7530_remove_common);
-- 
2.53.0

