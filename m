Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB3C3A4F30
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 01:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789696242; cv=none; b=kYvEUUXi0+lp/6uZ+aejwu5wCqmxlwg8h0Xse9mF60JOOTG+KhXaFKT4mbiSUEJ4vSSc4FZpXxWMqDCpphGqkfwxCzsAOq27/bANDGWODQ/OEFSLdRoAAgUYwkKM8ofAKYGcjypgHv7Awr8kyXONf/Ly0qtU5tyPHl3WNhJs/Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789696242; c=relaxed/simple;
	bh=sw31FdwJP25miVLw9vYrEEDQIkFP1uUBKF5WKe/eSGE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fuuKspprJa4Fo9z55RWi7LDkFsNNDf/kuXVu+le20VjPYsi1cw3dc34fxymOXVy8oevBF5JlSTZzxG3NfGD/kpDjw7VZfzvJ49FBHn960SMXbTdmZNziUlH3mfon55HkTBQKHxUmvI3JYi3GzP6VZBp8mEcQPP64Cnpt7C1gyfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=iO2amm8I; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="iO2amm8I"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-484366874b0so78400f8f.2
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 18:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1789696227; x=1790301027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=R1Dphf3wJq4BrmquaAl7H8zsB9cDxJ+RW6Mq3uDSYmM=;
        b=iO2amm8ImVrOz5HafSRuYdaM6VWoD0kLVpo8Ub4Vd9V3j4dFsSQVo19zeCsEGm65R2
         vtKCOB8SmbwSK+kk0gxjTSGlXJa0Cw7TxG28lGx6IQn9DyZiDaTWhKXAnzE4eXGD9YDF
         d2YZPjc9a3Ilydzl5S2JVQjWKYZcP+At/KMpR2VgcEyy1sFH3RRd3RJa90BuZCLmxvXc
         bVEDjz9eqowQiQzKffQL+VhTIzY8Ta66i/WGTPaAKJHSwV2SKAPi1VGaUEiqU9QFqxSS
         RoVHIvDvaKSXQYxL0L3I+VFUhy6t1g7m4/bpXUmm+GWYu8XEkHCnyEiTKmmk67Cr67+C
         3Ddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789696227; x=1790301027;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R1Dphf3wJq4BrmquaAl7H8zsB9cDxJ+RW6Mq3uDSYmM=;
        b=FKRuKKqQfMCheMgLf5Gh3QQ/srkTjCucgvAsEym3+7hX3iBRcE23nYChBELkL1wfS0
         AZKS6+j6eQILMYMCErb+DhtBOYTNeQNPjKW2Y95TaQl4DYbzHKkiNnDzdzUokX8B5yZj
         XRY2tyuerRe1LxRJEcth4eFxXmzLOEGB+WzzV/YA5TBHKoyiBpT/BiSQVNV6vN0Ve1CH
         FXF/nC/V6bMi8iiEaW7hknrN6f6bLnWzv53N26/R04eO5jInZDTsxEF5N6ltUi/5NLYs
         cvsDGgD5TznzbasNPPkJNC5CfZbMP5knYRTj008C50o6ufcm9OmHkkrOZOAhalmT+Xoh
         wW5Q==
X-Gm-Message-State: AFuF++l6KdbHjeMnWXFqA7i359+bkZxNWoiKV6vRlZug83JMkCErhZLO
	KKs3IvOy/wIM6S7vuE0UelaGube3QUfwn/ynxiKrwB3wS/tT/lFMNlokVVT6z3FhHbbfcf2Yzws
	8fpSWNBj05dHG
X-Gm-Gg: AYBFou0erTUGl4z+kGqqujjqeM1J8/hBsNM9pzpvw9DUcgQUIL0R6ioZwrOpR3Ei+7i
	0iMEjm0yau2jGKdHZgPtNiPAqgtFGZZleIZKGcDHmbKIcbwmSC7bvoxUNbafnwFiyuyp8/kZZWQ
	VYFP/nQs3pSLHL59aq+BQdQSjoQ51ybpEVX5irNntrj1fqtK2SzqFwnumZUMiRcs9z0m5pE4Quf
	Ks2zpDX/jT8rf5L6lXBDBmfEujOkHg2S2+waUqApVW95vcSXFBGGznj3OucjSGWvTaV0kvShNLc
	hzMG5ziZRveoCow9bS1b2zB7pN0N2I/rKEEX4pUAZthEMTCdE1yzTo8aze8HrNSQqXui89I39wZ
	VLujtNXPeIwMcs490gZKW7GtAb9j4vYQNK9wUU4sKSFpkrFQ5AOsi3xYubkHOHRjuhi/ImtFZNu
	vQ8k7cWo8VEHJ7N+bp7hv3D48v5LZ/s0F5rGIScojsJOHKVtfzzKwsaSuNGUQz
X-Received: by 2002:a05:6000:4903:b0:486:f301:11df with SMTP id ffacd0b85a97d-4871e20cffbmr1925132f8f.6.1789696226372;
        Thu, 17 Sep 2026 18:50:26 -0700 (PDT)
Received: from remote-01 ([84.17.55.229])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4871ff57926sm70569f8f.14.2026.09.17.18.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 18:50:25 -0700 (PDT)
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
Subject: [PATCH net v2 0/2] net: dsa: mt7530: fix two crashes on driver unbind
Date: Fri, 18 Sep 2026 04:50:18 +0300
Message-ID: <20260918015020.2518315-1-f@lex.la>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unbinding the MT7530 driver from an MT7531 dereferences NULL in
regulator_disable(). On a Netcraze NC-1012 (MT7981B + MT7531, 6.18.44):

  # echo mdio-bus:1f > /sys/bus/mdio_bus/drivers/mt7530-mdio/unbind

oopses there, and the build it was found on sets CONFIG_PANIC_ON_OOPS, so
the board goes down with it. Fix that and the same command gets as far as
mt7530_remove_common(), which disposes interrupt mappings the switch's own
regmap-irq chip still owns; the regmap-irq thread then faults in
handle_nested_irq() later in the same teardown. rmmod reaches both, since
mdio_module_driver() calls .remove on module exit.

Patch 1 is the regulator one. mt7530_probe() requests the core and io
supplies only for ID_MT7530 and mt7530_setup() enables them under the same
test, but mt7530_remove() disables them unconditionally, so on an MT7621 or
an MT7531 both pointers are still NULL from devm_kzalloc(). It reaches the
MDIO front end only.

Patch 2 is the interrupt one, and it reaches further.
mt7530_remove_common() disposes the per-PHY interrupt mappings by hand from
.remove, while the regmap-irq chip that owns the domain is devm-registered
and its parent interrupt is only freed once .remove has returned.
regmap_del_irq_chip() disposes the same mappings itself, in an order that
cannot race, so the driver's call adds nothing but a window. That helper is
called from both front ends, so the defect also covers the MMIO parts -
MT7988, EN7581, AN7583 and EN7528 - which have no regulators and never meet
the first defect at all.

The order is not arbitrary. On an MT7531 the regulator fault happens in the
first thing mt7530_remove() does with the switch, so execution never
reaches the interrupt defect. The second only became visible once the first
was fixed, which is also how both came to be found on one board.

Found and verified there. Without patch 1 the unbind panics in
regulator_disable(); with patch 1 alone the panic moves on to
handle_nested_irq(); with both, three unbind/bind cycles run, two back to
back and a third after a pause. In the two whose dmesg was captured, each
unbind removes the switch from the driver directory and takes lan1 to lan4
with it, each bind brings them back, and lan1 relinks at 1Gbps/full after
both binds, lan4 after the second. uptime rose from 58 to 202 seconds
across the three without resetting and pstore gained no new record. The
third cycle stayed unbound long enough to read the descriptors: no mt7530
line in /proc/interrupts and no irq/79, irq/80 or irq/81 directory, and the
next bind reuses those three numbers - regmap-irq freeing and disposing
what the driver no longer touches. The kernel under test was identified by
the sha256 of its ELF notes section, read from /sys/kernel/notes on the
running board and computed in advance from the flashed image.

What hardware could not answer here. There is no MT7530 or MT7621 part on
this bench, so the ID_MT7530 branch that patch 1 adds was checked by
reading the generated code rather than by running it, and no MMIO part was
available to exercise patch 2 on that front end either. One unrelated WARN
remains across the unbind, from sysfs_remove_link() under
dsa_user_destroy(); it is a separate DSA teardown-ordering defect and is
not addressed here.

v2:
- patch 2 changes shape. Moving dsa_unregister_switch() in front of the
  dispose, as v1 did, only covers the phylib side: the regmap-irq chip is
  devm-registered, so its parent interrupt outlives .remove and the thread
  can still dispatch on a mapping the driver has just disposed. Dropping
  the call is what closes that: regmap_del_irq_chip() walks every hwirq
  below chip->num_irqs and disposes each one that maps, which covers
  whatever the driver created - the driver's own set is the user ports
  below MT7530_NUM_PHYS, hwirq 0 to 2 on the board below - and it does so
  after freeing the parent interrupt and before removing the domain.
- patch 2 points Fixes: at commit 254f6b272e3b ("dsa: mt7530: Utilize
  REGMAP_IRQ for interrupt handling") instead of commit ba751e28d442 ("net:
  dsa: mt7530: add interrupt support"). Before the regmap-irq conversion
  the driver owned the domain and removed it by hand, where
  irq_domain_remove() disposes nothing, so the call was required there; it
  became redundant when regmap-irq took the domain over.
- patch 1: same diff; the trailers are reordered and the message now names
  devm_kzalloc() as where the NULL comes from.
- v1: https://lore.kernel.org/netdev/20260914202421.2737079-1-f@lex.la/

Aleksei Sviridkin (2):
  net: dsa: mt7530: fix NULL dereference on unbind of MT7531 and MT7621
  net: dsa: mt7530: leave the MDIO IRQ mappings to regmap-irq

 drivers/net/dsa/mt7530-mdio.c | 18 ++++++++++--------
 drivers/net/dsa/mt7530.c      |  3 ---
 2 files changed, 10 insertions(+), 11 deletions(-)

-- 
2.53.0

