Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1E63E5A38
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 17:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791395629; cv=none; b=PD8RlgGRfdOy9g7tUpuP+wcL1en508Kv9CEVOwToyPuqbSJ6ObIENG3fT9UI1RFcYhDELmFJ7vbpbLVo8k8z0wT/MBy28EG1QgZB7WEgupCG9fm5ICVvh+j4syhB6plnSQw9UcugnUGP1uYpxuHkJBTZFRBWeZWPKwGj6kn/o5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791395629; c=relaxed/simple;
	bh=2T8Uml0NShGNDvWiMP4NXducNTo6aIMaISEXdT4NZNo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=brdFyZGeGd3HGxMH2UF1S9rDSrkX5tXsMLYcQ3pOJ4XtQeCVOavJUo2G2IjH0Xb3YCwxOgvhWb/mDbS5bFvGAEGraQmJ3XZXs9Ayfm46d8HfGY40JTgKqAO1dCqQEvMfv2eFNVGAO2L+8rCzuOnba6hkFSyimeTEnerMV90dhTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ADXn2KaD; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ADXn2KaD"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-34c89609923so2616549eec.1
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 10:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791395628; x=1792000428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+gmgxmP0+2UXMwCdLFQZo3obMVJ/yu9W4LFjtiv3dxs=;
        b=ADXn2KaDWP/+D02ixgxH/48YDvW9wiwDGK4bbktJXhuM2Svd1iEJj7/W69UtK/G3nX
         DF8vSmhusadvvW9nCEX4XdCa5W9hf3ZD67waPhU55YUzvhC6dbrX7E+bvKZnE2r+6wMu
         yzQv95D4H9r9gQ+vEsR2b7WHtHWmxNtCSZImi9wm1a+n5KlDoNDZv87ez+ktX/Y3RMGw
         5SWDBfwcVs9to1CdsawSqqG86ubyo/OhVJUPcPe3wpvLUuBTwBPXmy3njam6D3Rjz4eo
         Q7ca6XX0gOxaF3puKf6G4OMedzsE6LhNpkv4azKtRlOj5rR8xJTNVDvnxqE/79X5AEqu
         FLkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791395628; x=1792000428;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+gmgxmP0+2UXMwCdLFQZo3obMVJ/yu9W4LFjtiv3dxs=;
        b=vp69JBNogBNbNdklTr6gpHuxpq9RUjcju8NLhpG1D5225HpfSj9dZFzQkHJfZ0/cAR
         w6XPDL0byPq2zcxVhR/njf5WRCKpvOEpHVZ8DUZ7duiawNwyQugF0JxJpzlCNVMznb+z
         GMKbqvLCOZI3So0XROPOgxe+CLYsWqtiQTEN+kRVUGYYIJDUiwo9HzzQXGEjcaX0NzuP
         xHxsB3zBvM4Ns+LUtuxJp5WbOXmUaYwVGJwnycPblkmnzx8HDs63riZxVIIOE4iuMtrH
         Zl6Ari8iqBXCWtlN5kPFlSqeRer/CFpvrWPJSeM/vZH2YlzSfqlAjKD0fy+jYq1acuo8
         A4kA==
X-Forwarded-Encrypted: i=1; AKwUvBwDXQfMgLt8yUeWj10XE46ipL7L8/DxLXBqpeRExBbew+Ur1qny/C7yPjRulYq9etGbuG1g0L0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJZbgCY38SR3i7f8qUUWnV7NWoLo7hbTMgW+9wbR7VLahBSeIkN
	gO7R8X4HvtM+IBpoJn2bnL8oNYJRCDiNURmzKIWYE51LvRYDquVXDxas
X-Gm-Gg: AYBFou0LhEa2Z97S8Eg+8Z3wewu1dtpltMiFTY4ZoBaYWFZhGdNoYo6hGNejsPcILRN
	RzSiB/wDpIjXIQ0q09QAT0pN6FrnvMMUpZPGg9LROUdSyzgBq/LPWmXFEZ/WN4pgT/idFzMX9UO
	TqD8f8MQgEZfgKjxtE5cd+7IMTv6o17OAPmrJTbSVNAeeOYzUFyeshvavsutVa8GA62N8wBgDmg
	SGiHEBKtz0M2SAUG4/Y9zZOZq4MQJB3kG6YX6364oAijLJj2ypB2BB7c5BbsDuI/KAShtDRJaC0
	kkRs0Pmp7Hb8qcaDI53dSseJyZIFe0SSjslJ8tnv57SaXoi/vhiI277JCaSWwd1bIN7/o7ETmxl
	k6gUN0/pFkHtj+REzWTxo8bMtauYt5gtZE1N7/CiI/UrTLSFKbhPNzjVt7a5PNCKHk3G9RiNwkY
	ulBAWP0XGDqGJNcAaze5/+RMX/DBKng0INrfkpoegUGkhTjxa5aD9Uy18cA2YzORlGTCj6qxgBJ
	D30HOfhY5GyiOqDLmWlR/1T8Hyi2gEE5dcXqCD216bE1homxkrUcxVDXTmQJuezk16VJK0WO6Sp
	Kyfo5iI4x/cMQku5aKO2TI07rel5MQ==
X-Received: by 2002:a05:7301:3d12:b0:342:645a:5cf with SMTP id 5a478bee46e88-3515dbd00c9mr4952275eec.1.1791395627340;
        Wed, 07 Oct 2026 10:53:47 -0700 (PDT)
Received: from kapoor.iiserb.ac.in ([203.18.51.214])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3515af90521sm16129669eec.19.2026.10.07.10.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 10:53:46 -0700 (PDT)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Edward Cree <ecree.xilinx@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-net-drivers@amd.com,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [PATCH net-next v2] sfc: fix stale kernel-doc member names in net_driver.h
Date: Wed,  7 Oct 2026 23:23:34 +0530
Message-ID: <20261007175338.28683-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several kernel-doc comments in net_driver.h describe struct members that
have since been renamed or removed, and the EFX_MAX_FRAME_LEN() comment
is separated from the macro by the EFX_FRAME_PAD define. kernel-doc
reports:

  Excess struct member 'state' description in 'efx_channel'
  Excess struct member 'state_lock' description in 'efx_channel'
  Excess struct member 'indir_table' description in 'efx_rss_context'
  Excess struct member 'irq_rx_mod_step_us' description in 'efx_nic'
  Excess struct member 'tx_queue' description in 'efx_nic'
  Excess struct member 'rx_queue' description in 'efx_nic'
  Excess struct member 'extra_channel_types' description in 'efx_nic'
  expecting prototype for EFX_MAX_FRAME_LEN(). Prototype was for
  EFX_FRAME_PAD() instead

along with "not described" warnings for the renamed members.

Fix the member names to match the structs, drop the entries for members
that no longer exist, and move the EFX_FRAME_PAD define above the
EFX_MAX_FRAME_LEN() comment, documenting its @mtu parameter.

kernel-doc -Wall also reports three members that are not described
because nothing in the driver uses them any more, so remove them rather
than document them:

  - efx_channel::busy_poll_state, left behind when commit e7fe9491261e
    ("sfc: get rid of custom busy polling code") removed its users.
    @state and @state_lock above were its old kernel-doc entries.
  - efx_tx_queue::flush_outstanding, only used by the Falcon/Siena
    flush code, which commit 36ff6393292d ("sfc: Move Siena specific
    files") moved into siena/ with its own copy of the struct.
  - efx_rx_queue::min_overfill, whose kernel-doc entry and only
    assignment were removed by commit ecc910f520ba ("sfc: Make the dmaq
    size a run-time setting (rather than compile-time)").

The warnings were found with scripts/kernel-doc -Wall. I don't have sfc
hardware; this is compile-tested only.

No functional change.

Assisted-by: LLM
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
Changes in v2:
- Remove busy_poll_state, flush_outstanding and min_overfill, which are
  unused, instead of leaving them undocumented (Simon)
- Use the Assisted-by format from coding-assistants.rst

net_driver.h has further members with no kernel-doc description,
mostly in struct efx_nic and struct efx_nic_type. Those are in use, so
I'll document them in a separate patch.

W=1 build of drivers/net/ethernet/sfc/ shows no new warnings.

v1: https://lore.kernel.org/all/20261003055443.144554-1-kapoorarnav43@gmail.com/

 drivers/net/ethernet/sfc/net_driver.h | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
index 3964b2c56609..71144bb4c6c8 100644
--- a/drivers/net/ethernet/sfc/net_driver.h
+++ b/drivers/net/ethernet/sfc/net_driver.h
@@ -314,7 +314,6 @@ struct efx_tx_queue {
 	/* Members shared between paths and sometimes updated */
 	unsigned int empty_read_count ____cacheline_aligned_in_smp;
 #define EFX_EMPTY_COUNT_VALID 0x80000000
-	atomic_t flush_outstanding;
 };
 
 #define EFX_TX_CB_ORDER	7
@@ -431,7 +430,6 @@ struct efx_rx_queue {
 	unsigned int max_fill;
 	unsigned int fast_fill_trigger;
 	unsigned int min_fill;
-	unsigned int min_overfill;
 	unsigned int recycle_count;
 	struct timer_list slow_fill;
 	unsigned int slow_fill_count;
@@ -467,8 +465,6 @@ enum efx_sync_events_state {
  * @irq_moderation_us: IRQ moderation value (in microseconds)
  * @napi_dev: Net device used with NAPI
  * @napi_str: NAPI control structure
- * @state: state for NAPI vs busy polling
- * @state_lock: lock protecting @state
  * @eventq: Event queue buffer
  * @eventq_mask: Event queue pointer mask
  * @eventq_read_ptr: Event queue read pointer
@@ -526,9 +522,6 @@ struct efx_channel {
 	unsigned int irq_moderation_us;
 	struct net_device *napi_dev;
 	struct napi_struct napi_str;
-#ifdef CONFIG_NET_RX_BUSY_POLL
-	unsigned long busy_poll_state;
-#endif
 	struct efx_buffer eventq;
 	unsigned int eventq_mask;
 	unsigned int eventq_read_ptr;
@@ -788,7 +781,7 @@ struct efx_rss_context_priv {
  * struct efx_rss_context - an RSS context
  * @priv: hardware-specific state
  * @rx_hash_key: Toeplitz hash key for this RSS context
- * @indir_table: Indirection table for this RSS context
+ * @rx_indir_table: Indirection table for this RSS context
  */
 struct efx_rss_context {
 	struct efx_rss_context_priv priv;
@@ -881,16 +874,14 @@ struct efx_mae;
  * @timer_max_ns: Interrupt timer maximum value, in nanoseconds
  * @irq_rx_adaptive: Adaptive IRQ moderation enabled for RX event queues
  * @irqs_hooked: Channel interrupts are hooked
- * @irq_rx_mod_step_us: Step size for IRQ moderation for RX event queues
+ * @irq_mod_step_us: Step size for IRQ moderation for RX event queues
  * @irq_rx_moderation_us: IRQ moderation time for RX event queues
  * @msg_enable: Log message enable flags
  * @state: Device state number (%STATE_*). Serialised by the rtnl_lock.
  * @reset_pending: Bitmask for pending resets
- * @tx_queue: TX DMA queues
- * @rx_queue: RX DMA queues
  * @channel: Channels
  * @msi_context: Context for each MSI
- * @extra_channel_types: Types of extra (non-traffic) channels that
+ * @extra_channel_type: Types of extra (non-traffic) channels that
  *	should be allocated for this NIC
  * @mae: Details of the Match Action Engine
  * @xdp_tx_queue_count: Number of entries in %xdp_tx_queues.
@@ -1711,8 +1702,11 @@ efx_rx_buf_next(struct efx_rx_queue *rx_queue, struct efx_rx_buffer *rx_buf)
 		return rx_buf + 1;
 }
 
+#define EFX_FRAME_PAD	16
+
 /**
  * EFX_MAX_FRAME_LEN - calculate maximum frame length
+ * @mtu: MTU to calculate the maximum frame length for
  *
  * This calculates the maximum frame length that will be used for a
  * given MTU.  The frame length will be equal to the MTU plus a
@@ -1726,9 +1720,8 @@ efx_rx_buf_next(struct efx_rx_queue *rx_queue, struct efx_rx_buffer *rx_buf)
  * Re-clocking by the XGXS on RX can reduce an IPG to 32 bits (half an
  * XGMII cycle).  If the frame length reaches the maximum value in the
  * same cycle, the XMAC can miss the IPG altogether.  We work around
- * this by adding a further 16 bytes.
+ * this by adding a further 16 bytes (EFX_FRAME_PAD).
  */
-#define EFX_FRAME_PAD	16
 #define EFX_MAX_FRAME_LEN(mtu) \
 	(ALIGN(((mtu) + ETH_HLEN + VLAN_HLEN + ETH_FCS_LEN + EFX_FRAME_PAD), 8))
 
-- 
2.53.0

