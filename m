Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405283F9281
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 20:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789417472; cv=none; b=NljAJP5Ou28fpqmz0bb5kVCjMUeL3rQT3/Lt1uNhmJeeJisO3oqFAiY62Fw6vPOQdbPoODU1GKNwwWJDMYIIBxQ3hX0ysadcHeYHaKEM7UQ+HEHaGmX6ZM+AAZYrOEKQ/vexbyieAX+pVtWMUY+t7v2TBLLfwoImr4+DMw9RwQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789417472; c=relaxed/simple;
	bh=g4Or46i4/ZLxYMues/wUC6wr09LRWlxJuvhV/1mJnxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C1OXDdfYIHLDa7Vg2h5YB3jLvg4v+jXYB+VSKrDQLuoUeunxSiadu8PK74ME12i37UnvX6lnHUeJzokd4yjnRXvDfwZBSXkgZhifs8rzvvmYKePaY06BuGrceyp/h2GzaIH9Ce2EeJ+96yUMJSomK4rOMRDbNU66l4LXrZ3K4qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=bW5iPM5/; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="bW5iPM5/"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-486fa798933so1762642f8f.0
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 13:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1789417468; x=1790022268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UwzBQPMstw+H/RPbR8efACs0f1SjwEvwfQ7q2dwrtDg=;
        b=bW5iPM5/fQnvVep0bmW1dvE1RGCKZkfSUzGLI+O0Lsi2aLnD7BTl/FHyq6uFMNe+ah
         ExiiD4ZBK3GiXsNHNBRVhy86Tt8MSdaWi9YG3YivdVwfGZemjKZGwbwx6DmjfRZLqnSE
         lur6L6xjWXFuyILiFYXCqv1Es59ITH/LyjMoQpwvo7hhXgXyiFHMBvZgPfyRpKGy8W0d
         owOqApQdxauQIXrEs3wfiVKNEreta7VxUPIDvyRwpO1ERGYezYRCHNLAdLDYq8jaoyCP
         nhVMbr4cUbOBAOXtw0ubKtnDt9QxH00SUqSQ60AUpEOXiQREPJeqRTJTTG/eP9fGLy/a
         kmDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789417468; x=1790022268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UwzBQPMstw+H/RPbR8efACs0f1SjwEvwfQ7q2dwrtDg=;
        b=2awNMOXTRNqEAcebRWoj3N9dXt6LWgczsPNxN4WUDJp8vAUxpu2tbawOlUHulQrELE
         bmpVza9+7hS9gIpE7be/BQwJ3cb/pQZtr2Npb2/ADmGB5e/9TpYGUCL47BRaSzohUuo0
         Yhg1q5jSgUKm90QQn+kvAm6/c0Z9ckLw8VPlM0HENk3VosPvwegO5zV9/T6hK4UKGYaF
         0UfQa+BLenGa/advWl7321GJ13l0bKIQwh0n/u6lwDpkyMFJkD4USxFM6EfQJ7smjseC
         JXIu4GE7mgLRD3Q4zjbJUJ7jlxuRt7gF3mxruJPsbwDf1yBknJoqV4st3N1ED5mwDD7l
         Bbcg==
X-Gm-Message-State: AFuF++mO/lCwAq3q91+f3pMHgAZa/oUGOF8GzhSrx94wW996uEOfGAgy
	R7kmmYJ4TdvpKKoPM84YjbNNjs8wLuiwcONNQ30Gzs97jmlnk5oTv+6wqX9Y+CmPdMDhBvz7Qt4
	bbLB1yphG5ee2NO0=
X-Gm-Gg: AYBFou3zmFbDOOJqMHuS3WI+yBzBf1x+1CNJsjYINPqpxZm6RrlbDgqU2J938XM4is+
	kD9HatqZWGsEGH60v11d0C5d4cN5z5P0H87YRsHmudNCxs5s4SgWxsjP2J4w0AzlP27pA1UO+2n
	MygYAotab8/qWt2VN0QHu29Llodhg94E8U+ynaMcbFF9xcv/jREboma1pXa9OMovYy7VLQHmB0W
	te15jZjKMh5eWzYCfS2QMN4gRU+B4dw3vtNDMSYw07FFdxUGTfEkanFW5LncmqloETvRWa0U/IM
	2pDNhpzB4sIHX7uue9A1AzUieCKK4lp3eNpjpIs1bxAHV+Cew1bXIFajRNlbv0cPgJwTivLTj3D
	1JbsMhcofFqH9zKr+Wk+JMoPEnFSlR5OEhNTKwcYmMdz5ufkqJpihj+mXlr77tJ71YNDTwV/qyf
	j/QK5uTTuYyAgp8Ei9SpO4FHJwrrePPTPdOV0Bq/NsHzV7fJK/Kw==
X-Received: by 2002:a05:6000:471a:b0:486:f506:2fa8 with SMTP id ffacd0b85a97d-48702ac2429mr5519268f8f.18.1789417468530;
        Mon, 14 Sep 2026 13:24:28 -0700 (PDT)
Received: from remote-01 ([84.17.55.229])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb34fdd2sm29328458f8f.28.2026.09.14.13.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 13:24:28 -0700 (PDT)
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
Subject: [PATCH net 1/2] net: dsa: mt7530: fix NULL dereference on unbind of MT7531 and MT7621
Date: Mon, 14 Sep 2026 23:24:20 +0300
Message-ID: <20260914202421.2737079-2-f@lex.la>
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

The core and io supplies are only requested for ID_MT7530: both the
devm_regulator_get() in probe and the regulator_enable() in
mt7530_setup() are guarded by the switch id, but mt7530_remove()
disables them unconditionally. On an MT7621 or an MT7531 both pointers
are NULL, so rmmod or a sysfs unbind calls regulator_disable() on NULL.

Fixes: ddda1ac116c8 ("net: dsa: mt7530: support the 7530 switch on the Mediatek MT7621 SoC")
Signed-off-by: Aleksei Sviridkin <f@lex.la>
Assisted-by: LLM
---
Found by accident on a Netcraze NC-1012 (MT7981B + MT7531, 6.18.44) while
looking for a way to tear a DSA port down at runtime:

  # echo mdio-bus:1f > /sys/bus/mdio_bus/drivers/mt7530-mdio/unbind
  Unable to handle kernel access to user memory outside uaccess routines
    at virtual address 0000000000000078
  pc : regulator_disable+0x14/0x48
  lr : mt7530_remove+0x1c/0x80
  x0 : 0000000000000000
  Call trace:
   regulator_disable+0x14/0x48 (P)
   mt7530_remove+0x1c/0x80
   mdio_remove+0x20/0x40
   device_release_driver_internal+0x1cc/0x220
   unbind_store+0xac/0xb0
  Kernel panic - not syncing: Oops: Fatal exception

The oops itself is a process-context oops that kills the writing task. It
became a panic and a reboot because OpenWrt's generic kernel config sets
CONFIG_PANIC_ON_OOPS=y and this target does not override it, not because of
anything local to this bench. With CONFIG_REGULATOR=n the stub
regulator_disable() returns 0 and nothing is dereferenced at all -
NET_DSA_MT7530 neither selects nor depends on REGULATOR - so the severity is
config-dependent, and the commit message states the mechanism rather than an
outcome.

x0 is the regulator pointer and regulator_disable() reads regulator->rdev
straight away, so the NULL comes from the field never being assigned rather
than from an error pointer: with CONFIG_REGULATOR=y devm_regulator_get()
hands back a valid pointer or an ERR_PTR, and on anything but ID_MT7530 it
is never called at all.

The same shape applies to MT7621, which mt7530_of_match also binds. The MMIO
driver is unaffected: it makes no regulator calls at all, though it does still
carry the include.

The id test is used rather than a NULL check because the driver already
says "these supplies belong to ID_MT7530" that way in the other two
places it matters: the devm_regulator_get() pair in mt7530_probe() and the
regulator_set_voltage()/regulator_enable() pair in mt7530_setup(). A NULL
check would be a third spelling of the same condition.

Tested on the board above. Without the patch the unbind panics as shown; both
pointers come out of kzalloc and are never assigned on an MT7531, so the fault
is structural rather than timing-dependent. With this patch plus the unrelated
teardown fix described below, the same unbind runs to completion: mdio-bus:1f
leaves /sys/bus/mdio_bus/drivers/mt7530-mdio/, lan1-lan4 disappear, the kernel
prints "DSA: tree 0 torn down", and uptime does not reset. The kernel under
test was identified by the sha256 of its ELF notes section, read from
/sys/kernel/notes on the running board and computed in advance from the image
that was flashed.

dmesg is not silent across that unbind. It gains one WARN - a single cut
here/WARNING/end trace block - from sysfs_remove_link() under
dsa_user_destroy() reaching an already-removed netdev directory: "kernfs: can
not remove 'phydev', no directory". That is a DSA teardown-ordering defect
rather than a regulator one, and in this run it fired on the first unbind
after boot. dmesg is where it shows: pstore gained no new record across the
run, but pstore records only oopses and panics and could not have caught a
WARN.

That run needed one unrelated fix on top, deliberately kept out of this patch:
mt7530_remove_common() frees the MDIO IRQs before dsa_unregister_switch()
hands them back, and the board dies in handle_nested_irq() a few hundred
milliseconds later. With this patch alone, the panic moves from
regulator_disable+0x14 to that second defect, and mt7530_remove is reached at
+0x24/0x90 rather than +0x1c/0x80 - which is the point: the NULL dereference
is gone and execution now gets past it. That second defect is being handled
separately.

Not tested: the ID_MT7530 branch, which must still disable both rails. There
is no MT7530 or MT7621 hardware here, so the disassembly stands in for it -
before the change mt7530_remove() falls from the priv NULL check straight into
ldr x0, [x19, #40] / bl regulator_disable; after it, ldr w0, [x19, #72]
(priv->id) / cbz w0 gates both calls, and ID_MT7530 is 0. Built with W=1, no
warnings; checkpatch --strict clean.

 drivers/net/dsa/mt7530-mdio.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/dsa/mt7530-mdio.c b/drivers/net/dsa/mt7530-mdio.c
index 784dd58a7158..de42f70afcfa 100644
--- a/drivers/net/dsa/mt7530-mdio.c
+++ b/drivers/net/dsa/mt7530-mdio.c
@@ -227,15 +227,17 @@ mt7530_remove(struct mdio_device *mdiodev)
 	if (!priv)
 		return;
 
-	ret = regulator_disable(priv->core_pwr);
-	if (ret < 0)
-		dev_err(priv->dev,
-			"Failed to disable core power: %d\n", ret);
+	if (priv->id == ID_MT7530) {
+		ret = regulator_disable(priv->core_pwr);
+		if (ret < 0)
+			dev_err(priv->dev,
+				"Failed to disable core power: %d\n", ret);
 
-	ret = regulator_disable(priv->io_pwr);
-	if (ret < 0)
-		dev_err(priv->dev, "Failed to disable io pwr: %d\n",
-			ret);
+		ret = regulator_disable(priv->io_pwr);
+		if (ret < 0)
+			dev_err(priv->dev, "Failed to disable io pwr: %d\n",
+				ret);
+	}
 
 	mt7530_remove_common(priv);
 
-- 
2.53.0

