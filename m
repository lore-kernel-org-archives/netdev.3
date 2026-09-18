Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5333B42E0
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 01:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789696249; cv=none; b=AeMXrFtIpaA6Q/raY3sQp1n2IQo/OtFQudksBdIzE26qoMb8+U9wG8cFty1KcoOyqsRZexnEFCo7sXJYPhjLm8JFXtDM8hgjBkKSDDBMJI4WSWdeimRN9CqJSNpw4oP99Io1hZuY+mc78ao+upEqYwwvpK+24ewaBD0MDP/8eFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789696249; c=relaxed/simple;
	bh=tMNt3WgDbWiLcST77Z8fyAfuth/lQG6KwaNQU/at8DU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FB5rYcs4uALvFOrE5F/v2QSbO17DOfrYhWxnT6FIQ/4j78K+wzulrK1lzZ8aiWfMD7CVufZqGO/hs10i33USu2S68pRnDxlkPiPRykxJaeyzDaXiYw0DnaU4xmSxo4YqkRhrkAgoaQ2VftcJrJYftFEjnXiodC0yBmpIjfrUmww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=MU8borQr; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="MU8borQr"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49d097b4939so1162165e9.0
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 18:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1789696229; x=1790301029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hQ1vqCiYyinbzAJglQK3AA19n9BUGKxeEFgjB2l0094=;
        b=MU8borQr/X2O7px/QHE+Dnlw+yUW7QZVC3g9Zf4taZzmyFAhLhoyfDlbSF/s8M7QD+
         gmAlzwAvQQ5/OwT4N1SY5pextTdIgf/FxhbIrStd9PoR0PeITQbkF2/Vi3BeFw+z1wYs
         6Xz+FiBlN5R/pybFClTR6cppyC//ui5/kAm5+KiSVBGifnSHBPjDwpGunfTPLxGmPuMB
         BbeURsz94ca6JfQ8OnR9Xz4IbfEe7SbAnTDctj3uIpapoknPTt86XhhvO7B3pwF+QKTx
         Aq5ONPqBaIST/Sley2F0ktkVYpDH726MR4iwRUni+qGSBYQvvgJ26B2dlm0QUqeIEcB+
         wXDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789696229; x=1790301029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hQ1vqCiYyinbzAJglQK3AA19n9BUGKxeEFgjB2l0094=;
        b=OBm3nLkMOPbYmoqelgXcbTH+vabvnRnTinKTlYogCBuiE+pjQQMbdVxjKQaILzlSqk
         1cPHDE49IT8vJWeM/KyHXpr3TYTEo0VuVj02k3GSteAhv7x3n0vFFDSDFZJgyDHGUi+g
         wZT3XN767qGqTZmq7V8TelespVMVREBDz/dze12CSS071X7ijkq1dbNCXwlAq21V2Cd/
         4gZAdOmqMcppjWVIdnbMnbf19TlfGggmhoMXl+o66K6OQxChpZGT4FF9okMRAavp24eS
         Pqm8HnS/BrIcHLTjNY1eSMqxAHcUgtn/mDpSX1wFmrA/CYpOmas3GaWWnj4hcCNNkLxD
         E0Sg==
X-Gm-Message-State: AFuF++mlopyVIZrtXoH9Mzo6CYcSLxSaV96BK9j5fdB4uVlEZA54t6TF
	5h8bCCrf+Rcs3/PWQukax+AfPt2tLV7ZLIZPKQ5NhZWLyCAg6xnTRtkxAZUae5aKA/Vgl7ODZdf
	0C9kDLgJaEJE2
X-Gm-Gg: AYBFou3BpCdeVg2rJvoumVcDA4ubj7pPD5XI/cQsWj/wYz9u1btIyK8Rb+ZjAXrf2Rr
	gbSUcYt4sP5NIfhjXB+JKCnZeCvxjWlaY9vPh/6TrkjPsGcxtRC9bA1uYDAP5xVAjLLs84+7EpD
	6Ly5rvKvuYxcrVgJeGGyMMp1hA2KZij9f1j4n0Eizt7YMpo8yOIfcESIyu0l/G5ZciLqersubLX
	sxgPwOZabZilOzg2a/Jq6jCMzrNqU7KQonUjSeNfoCorSlKiWnYuGXLzxqQ1NuH9nNwF9sgdtP9
	ItNC7dFb/rhOTlWibMGp0zSG6wzLBkpjKcDVXeu160koN3QDfpi4nODQdOlojMvJdfe3E4kZfzm
	dZ4WbTi0hruWUJiJ4z77yxAnY+XZUvphvVdTMqbDDD60/1EYb3syDxaVnxlB1dMaBa0fxGU/xg7
	t/sI1DrP8Yy+9IiX1uuKx5Anv9RmO8Kllz4Rx2wtEzX2oetKbGvw==
X-Received: by 2002:a05:600c:4e46:b0:49e:642a:4f6f with SMTP id 5b1f17b1804b1-49fc585e9edmr7361175e9.33.1789696229219;
        Thu, 17 Sep 2026 18:50:29 -0700 (PDT)
Received: from remote-01 ([84.17.55.229])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4871ff57926sm70569f8f.14.2026.09.17.18.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 18:50:28 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: netdev@vger.kernel.org
Cc: chester.a.unal@arinc9.com,
	daniel@makrotopia.org,
	andrew@lunn.ch,
	olteanv@gmail.com,
	gerg@kernel.org,
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
Subject: [PATCH net v2 2/2] net: dsa: mt7530: leave the MDIO IRQ mappings to regmap-irq
Date: Fri, 18 Sep 2026 04:50:20 +0300
Message-ID: <20260918015020.2518315-3-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260918015020.2518315-1-f@lex.la>
References: <20260918015020.2518315-1-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mt7530_remove_common() disposes the per-PHY interrupt mappings from
.remove, but the regmap-irq chip that owns the domain is devm-registered,
so its parent interrupt is only freed once .remove has returned. The
switch's own regmap-irq thread can therefore still dispatch on a mapping
that is already gone: irq_find_mapping() returns 0, irq_to_desc() returns
NULL and handle_nested_irq() locks desc->lock without checking it. The
attached PHYs have not given those interrupts back yet either, which the
kernel warns about a moment before the fault.

regmap_del_irq_chip() disposes the same mappings itself, after freeing the
parent interrupt and before removing the domain, so there is nothing left
for the driver to do here. Until it runs the descriptors stay alive, and a
late dispatch on one of them is harmless: dsa_unregister_switch() has freed
the PHY handlers by then, so handle_nested_irq() finds no action and
returns.

Fixes: 254f6b272e3b ("dsa: mt7530: Utilize REGMAP_IRQ for interrupt handling")
Assisted-by: LLM
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---
Found on a Netcraze NC-1012 (MT7981B + MT7531, 6.18.44) directly behind the
regulator fix in patch 1: with that one applied the unbind stops faulting
in mt7530_remove() and reaches the teardown, where the kernel says what is
wrong in words before it dies.

  # echo mdio-bus:1f > /sys/bus/mdio_bus/drivers/mt7530-mdio/unbind
  remove_proc_entry: removing non-empty directory 'irq/81', leaking at least
    'mt7530-0:02'
  WARNING: CPU: 0 PID: 4629 at remove_proc_entry+0x1d0/0x1f0
  ...
  Call trace:
   remove_proc_entry+0x1d0/0x1f0 (P)
   unregister_irq_proc+0xd0/0x104
   free_desc+0x38/0xa0
   irq_free_descs+0x64/0x98
   irq_dispose_mapping+0x70/0x14c
   mt7530_free_mdio_irq+0x5c/0x60
   mt7530_remove_common+0x1c/0x30
   mt7530_remove+0x24/0x90
   mdio_remove+0x20/0x40
   device_remove+0x68/0x80
   device_release_driver_internal+0x1cc/0x220
   device_driver_detach+0x14/0x20
   unbind_store+0xac/0xb0
   ...

  Unable to handle kernel read from unreadable memory at virtual address
    00000000000000ac
  pc : handle_nested_irq+0x28/0x168
  ...
  Call trace:
   handle_nested_irq+0x28/0x168 (P)
   regmap_irq_thread+0x19c/0x2e8
   irq_thread_fn+0x28/0x88
   irq_thread+0x18c/0x28c
   kthread+0xe4/0x1ac
   ret_from_fork+0x10/0x20
  Kernel panic - not syncing: Oops: Fatal exception

The WARN comes from unregister_irq_proc() under irq_free_descs(), fired for
a mapping a PHY still holds. The captured record shows one, for
mt7530-0:02, and already carries the W taint bit, so at least one earlier
WARN fell outside the ramoops window. Later in the same teardown, and in
the same ramoops record, the switch's own regmap-irq thread - PID 627, Comm
irq/53-mt7530 - dispatches for a mapping that is already gone:
irq_find_mapping() returns 0, irq_to_desc() returns NULL and
handle_nested_irq() takes desc->lock on it, which is the read at virtual
address 0xac in the trace.

The mappings regmap-irq disposes are a superset of the driver's.
mt7530_setup_mdio_irq() maps hwirq p for each user port p below
MT7530_NUM_PHYS - at most 0 to 4, and 0 to 2 on the board below, since the
loop tests ds->phys_mii_mask. regmap_del_irq_chip() walks hwirq 0 to
chip->num_irqs and skips only entries whose mask is zero; mt7530_irqs[] is
written with designated initialisers up to [31], so num_irqs is 32 with 12
zero-mask holes, none of them below 5 - hwirq 0 to 4 carry masks 0x1 to
0x10. A devicetree that gives the PHYs their own interrupts lands on the
same hwirqs, since regmap_domain_ops uses irq_domain_xlate_onetwocell;
today the driver disposes those too without ever having created them, and
after this patch the remove path no longer does. mt7530_free_mdio_irq()
does nothing but dispose - it neither removes the domain nor clears
bus->irq[] - so the call is the whole of what goes away.

The devres order is the right way round as well: mt7530_setup_irq()
registers the chip before mt7530_setup_mdio() registers the bus, so the bus
is released first and the chip after, and regmap_del_irq_chip() frees the
parent interrupt before it disposes anything.

Fixes names the regmap-irq conversion rather than the 2021 commit that put
this call in .remove. Before 254f6b272e3b the driver created the domain
with irq_domain_add_linear() and tore it down in mt7530_free_irq_common(),
where irq_domain_remove() disposes nothing, so mt7530_free_mdio_irq() was
required there. The conversion handed both the parent interrupt and the
domain to regmap-irq and left the call behind.

The two remaining callers are error paths in mt7530_setup_mdio() and
mt753x_setup(), reached before probe completes, and only one of them can
run in a given probe: a failing mt7530_setup_mdio() returns from
mt753x_setup() before the second is reached. An early dispose there costs
nothing anyway, because regmap_del_irq_chip() looks each hwirq up again and
only disposes the ones that still map. Dropping those calls is a cleanup,
not a fix, so they stay.

Tested on the board above with both patches applied, on a kernel identified
by the sha256 of its ELF notes section - read from /sys/kernel/notes on the
running board and computed in advance from the flashed image. Three
unbind/bind cycles. In the two whose dmesg was captured, each unbind
dropped mdio-bus:1f from the driver directory and took lan1 to lan4 with
it, each bind brought them back, lan1 relinked at 1Gbps/full after both and
lan4 after the second; the third logged interrupt descriptors instead, as
below. uptime rose from 58 to 202 seconds across the three cycles without
resetting and pstore gained no record. At the end of the two logged cycles
dmesg carried no handle_nested_irq, no Oops and no remove_proc_entry line,
against 82 lines mentioning mt7530 in that same dmesg, so those zeros are
absences and not a broken grep; the third cycle re-read the first two
counters, still zero, against 91. One unrelated WARN remains, on the first
unbind only: sysfs_remove_link() under dsa_user_destroy(), a separate DSA
teardown-ordering defect.

The third cycle was left unbound for a moment to look at the descriptors.
/proc/interrupts then had no mt7530 line at all - the parent 53 gone along
with the per-PHY 79, 80 and 81 - and /proc/irq had lost those three
directories; the next bind came back on the same three numbers. That is
regmap_del_irq_chip() doing both the free and the dispose once the driver
stopped doing half of it by hand. Had it not, the directories would have
stayed behind and the rebind would have taken the next free virqs.

What this board cannot show is the race itself. The window is narrow, and
reordering the two calls instead of removing one ran just as clean here.
The panic quoted above is what the unfixed path does, captured on the same
board and the same base with only patch 1 applied. Both kernels also
carried a local debug msleep() in phy_remove(), left over from unrelated
work in the same tree. It only widens the window this patch closes:
phy_remove() runs after .remove has returned and before
regmap_del_irq_chip() frees the parent interrupt, which is exactly the span
an early dispose leaves open. The clean runs, the WARN and the descriptor
readings do not depend on it; the panic quoted above was captured with it
in place.

Not tested: any MMIO part - there is no MT7988, EN7581, AN7583 or EN7528
hardware here. The object file was read instead: mt7530_remove_common() now
compiles to a single call to dsa_unregister_switch(), and
mt7530_free_mdio_irq() keeps its two remaining callers. Built with W=1, no
warnings; checkpatch --strict clean.

 drivers/net/dsa/mt7530.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 3e61eb3c2b1e..96832852c65a 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -3593,9 +3593,6 @@ EXPORT_SYMBOL_GPL(mt7530_probe_common);
 void
 mt7530_remove_common(struct mt7530_priv *priv)
 {
-	if (priv->irq_domain)
-		mt7530_free_mdio_irq(priv);
-
 	dsa_unregister_switch(priv->ds);
 
 	mutex_destroy(&priv->reg_mutex);
-- 
2.53.0

