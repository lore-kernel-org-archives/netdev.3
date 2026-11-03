Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793733971;
	b=cKwWLwXr7d31nXKTfIVXw44d5XfH+7M6B+oGYH1YngwwRmOJwv4lT4yB1pE4x2EbWXWz
	 me2BL8txWVYuaDShc0lSWWGLzOA8Zu10BrAOkLYhj6YACp8a1Ceb6r0T4m4KnhdA7iW8Z
	 ab/Qn8Y+nws3ueqn+xWa6F2GZw5uw9t1oLL/YLq4hPPFB0WwUQstgaP/areQLxnnMtfxk
	 s9di4+foyMpjb17E7pTxaw1y0RxgACwWBtjklwXGND31e0sCGBLfMi0rLQoJAqp8ih8UM
	 u00tt16uPDyV67tw8kqSrwNqk0KyvnO1ChyuIuJAUItkGVC9IufgFwbAl5uEOMudnSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793733971;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Eo6VmiARCV/E0+lmU5+H4tJMnPB8p2KHdxisaJd5aXg=;
	b=L34tDRM3nkTpmcKmzNikqHsVcF4DNfc4RWB0yvB/7uobOwSNbuLBKy+OVLE6z0kBRWal
	 jaH4WVS6XvVyYMq+1NsbtXp/iXpdMmQdS3lUkqVMPExwr/EhOzTYzgu7lEi6RhfFW6uay
	 nJlo9dxWZ+TmOfs1+WCa3Q6f3Ku5WKXyUjfOQ+shqY+gKC4Dha20ag3YcseuzlPZQQoGX
	 jmoOGKpTQh5+6qHwmqCbfccg08rtdwD68+8JDoB6YDWRCFd3z228NiJYemJOMvxHhEewV
	 quJ26pNCYDUSttDWaZpLwfRVjkBHwMQeAub83Q47FRjxZ3F5Y12NUKFt8SsCZS8v31g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openai.com;
	spf=pass smtp.mailfrom=openai.com;
	dkim=pass header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=UGt+GH9y;
	arc=none smtp.remote-ip=209.85.161.54
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F28606A326
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 19:26:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8F28606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=UGt+GH9y
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6deb848ddd7so3437894eaf.0
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 11:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1793733968; x=1794338768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Eo6VmiARCV/E0+lmU5+H4tJMnPB8p2KHdxisaJd5aXg=;
        b=UGt+GH9yq1ht0NPyjSAI5qXJmJ8w63K4dOhYvT8/8S6e5QDXUZIUvD14Pb8vIY4Vvv
         q2FVeQuENZUoxFJm4Y2ax5cCNlQBYG7x9wWWMK9tNRbRd7yIX7z+DVpLObbj6DEWZNmd
         EHiCwQfv7yigz+tn9gtH6xoy8VxOJa8MkFby0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793733968; x=1794338768;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Eo6VmiARCV/E0+lmU5+H4tJMnPB8p2KHdxisaJd5aXg=;
        b=tjw/6TDMOc707BJnvDR7h68rKg7SedfqfZWPJkPyoOGPusCQ2wsc6P66/i1RsCqXaT
         CJAGd1AeTNXrCNVaxbj8Nx9vgv2Rtk3Azru1BRosGzvnhCG6fUcBivAN0mCgmWZGUlzC
         Z+yUrfusfDnpwX73du1ANkDQle4J7k6mONh7SmCdrIyGcn11jqW0PkTuzmAVtCj6vQWj
         JO0nwwTtwYRu79phRhxo4XiBgxmMn+FZAwwjowB4uCO37kgtyvstV8yG2Tcd/MkRz7u8
         i1qeOQaB+yXk8uygHF7GD+IrRIC/EXMg/ZB7UvNl5jDih7OOL2SGbU/dpn7N8SGd24n7
         7vgA==
X-Forwarded-Encrypted: i=1; AKwUvBxDvjS2Gs69R8l0OTdz57wfQ5atTUG1Lm6IB1oqN5NY+uHK+i9V8hjDbGi3GlIMxvDoPz03Vko=@vger.kernel.org
X-Gm-Message-State: APuU4Z/IiUqqHFwAUEh9K3Zq0f7wcfOGSlMrXi3B700zRwG4HwkIVgf2
	xt5BtwOLp5Y6+LGhVyFFnvYnoR3UED7Lsz2kiAes+nXe1R52uVpCUkvNHmtoHpkBM+Y=
X-Gm-Gg: AYBFou25RvWqibbM16+FygZris4rw13CT3/LFUC/zN/XcBqGEvYgaVgfeEINGXKiu5T
	+IJwoVZnTmgENPTnKR/yvAvrCxp5Ljn00IsMqudEF9HhV6kucPULi7FLiTqabPuh0CGvbueNxBJ
	GBp0u/kt/WcxAbJje+QG5IREJ2L51COAlQJ2XPpVBxbHQGSZhS+vGzACosG1jxikV4qg1l+EydB
	iGFJWc3N4iAwcMV1JZv+8lY9f3SwgvQrS3kxV1YjIkRqtYanhMiVxAgfrQu6kAvewdvAGtJ4DJB
	CcBJ7QnsoxTINVJeqHkQ7j6nEcA0yb1NRjmn6Rsy2o0mcP1VtFMffT9ddy59Ry/tRqL2E0N6x/4
	QaDrpE/ymb6IZRyRIoM3cv89iArdY+MpcDt59/UFdpMFrGP76PYKOzL3kIsY7WBtv1CQUg0nLHl
	cMbTXP0nbP5xK0fzKXiL+6DgpTMfxXvi2k5xJeEfMcU2MxtkyDrVPLBz0WNHYxcPumchs/XF+YM
	4Ef/MbCqB4uwxQJnQ9fSzfMsGZUllkHCVxzJBbQfE54RXpb8gTuUdKVIkdz8/UJTb44nP48uyVd
	HrgR1BS/vOJAiCrYz5gtRP4RmLz7yxogKjHLz8HP2XogPy1NH2oBqpAqHgdY0MaVWSRhTeyHK03
	X6yxz8D2SyRs4gpCOJntrKQF0gi8ZO80=
X-Received: by 2002:a05:6820:2203:b0:6d7:a325:35f7 with SMTP id 006d021491bc7-714f27636fbmr7710632eaf.81.1793733968248;
        Tue, 03 Nov 2026 11:26:08 -0800 (PST)
Received: from com-75606.corp.openai.org ([199.47.143.14])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-714f2ce869asm12149533eaf.4.2026.11.03.11.26.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Nov 2026 11:26:07 -0800 (PST)
From: Kyle Zeng <kylebot@openai.com>
To: linux-sctp@vger.kernel.org
Cc: lucien.xin@gmail.com,
	marcelo.leitner@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] sctp: avoid requeueing pending control chunks
Date: Tue,  3 Nov 2026 11:26:06 -0800
Message-ID: <20261103192606.92502-1-kylebot@openai.com>
X-Mailer: git-send-email 2.55.0
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

The T4 and RE-CONFIG timeout handlers take a reference to their cached
control chunk and submit it through SCTP_CMD_REPLY. A previous
transmission can still be on the control outqueue when output is corked
or suppressed, or when sctp_packet_transmit_chunk() could not append the
chunk.

sctp_outq_tail() then adds the same list node a second time. Re-adding a
non-tail entry can corrupt the list without being caught by the
insertion-time list checks. A subsequent flush or association teardown
can access an already freed chunk. The ASCONF path is reproducible by an
unprivileged SCTP socket owner in a user/network namespace, with KASAN
reporting a use-after-free in __sctp_outq_teardown().

Check sctp_chunk_pending() in both timeout handlers before taking the
extra reference and issuing SCTP_CMD_REPLY. When the chunk is already
linked, request a deferred outqueue flush instead. Simply omitting the
reply would also omit its uncork at the end of the timeout event. T4
would no longer retry the queued ASCONF, and a migrated, pending
RE-CONFIG could lose its timer until unrelated output flushes the queue.

The flush command acquires a local cork only when the caller has not
already corked the queue. This preserves the existing flush ordering,
transport/error accounting and timer handling without changing the
common enqueue path.

The issue was found by an LLM.

Fixes: 2e3216cd54b1 ("sctp: Follow security requirement of responding with 1 packet")
Fixes: 7b9438de0cd4 ("sctp: add stream reconf timer")
Cc: stable@kernel.org
Suggested-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
v1: https://lore.kernel.org/netdev/20261030042321.74407-1-kylebot@openai.com/
v2: Check pending chunks in the T4 and RE-CONFIG timeout handlers, as
requested. Preserve their deferred output flush with a state-machine
command so pending requests can progress without unrelated traffic.
The common sctp_outq_tail() path is unchanged.

I have a reproducer for this issue and can share by DM.

 include/net/sctp/command.h |  1 +
 net/sctp/sm_sideeffect.c   |  8 ++++++++
 net/sctp/sm_statefuns.c    | 20 ++++++++++++++------
 3 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/include/net/sctp/command.h b/include/net/sctp/command.h
index 2058fabffbf6..abd6cc509183 100644
--- a/include/net/sctp/command.h
+++ b/include/net/sctp/command.h
@@ -39,6 +39,7 @@ enum sctp_verb {
 	SCTP_CMD_CHUNK_ULP,	/* Send a chunk to the sockets layer.  */
 	SCTP_CMD_EVENT_ULP,	/* Send a notification to the sockets layer. */
 	SCTP_CMD_REPLY,		/* Send a chunk to our peer.  */
+	SCTP_CMD_OUTQ_FLUSH,	/* Flush pending output when uncorked. */
 	SCTP_CMD_SEND_PKT,	/* Send a full packet to our peer.  */
 	SCTP_CMD_RETRAN,	/* Mark a transport for retransmission.  */
 	SCTP_CMD_ECN_CE,        /* Do delayed CE processing.   */
diff --git a/net/sctp/sm_sideeffect.c b/net/sctp/sm_sideeffect.c
index 35f540fb15fc..6f19ac78749d 100644
--- a/net/sctp/sm_sideeffect.c
+++ b/net/sctp/sm_sideeffect.c
@@ -1498,6 +1498,14 @@ static int sctp_cmd_interpreter(enum sctp_event_type event_type,
 			sctp_outq_tail(&asoc->outqueue, cmd->obj.chunk, gfp);
 			break;
 
+		case SCTP_CMD_OUTQ_FLUSH:
+			/* Request a flush without taking over an outer cork. */
+			if (!asoc->outqueue.cork) {
+				sctp_outq_cork(&asoc->outqueue);
+				local_cork = 1;
+			}
+			break;
+
 		case SCTP_CMD_SEND_PKT:
 			/* Send a full packet to our peer.  */
 			packet = cmd->obj.packet;
diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
index b2f609f177fb..8b76b7e28504 100644
--- a/net/sctp/sm_statefuns.c
+++ b/net/sctp/sm_statefuns.c
@@ -1122,9 +1122,13 @@ enum sctp_disposition sctp_sf_send_reconf(struct net *net,
 		return SCTP_DISPOSITION_DELETE_TCB;
 	}
 
-	sctp_chunk_hold(asoc->strreset_chunk);
-	sctp_add_cmd_sf(commands, SCTP_CMD_REPLY,
-			SCTP_CHUNK(asoc->strreset_chunk));
+	if (!sctp_chunk_pending(asoc->strreset_chunk)) {
+		sctp_chunk_hold(asoc->strreset_chunk);
+		sctp_add_cmd_sf(commands, SCTP_CMD_REPLY,
+				SCTP_CHUNK(asoc->strreset_chunk));
+	} else {
+		sctp_add_cmd_sf(commands, SCTP_CMD_OUTQ_FLUSH, SCTP_NULL());
+	}
 	sctp_add_cmd_sf(commands, SCTP_CMD_STRIKE, SCTP_TRANSPORT(transport));
 
 	return SCTP_DISPOSITION_CONSUME;
@@ -6197,9 +6201,13 @@ enum sctp_disposition sctp_sf_t4_timer_expire(
 	 * chunk, it MUST be the same (including its serial number) as the last
 	 * ASCONF sent.
 	 */
-	sctp_chunk_hold(asoc->addip_last_asconf);
-	sctp_add_cmd_sf(commands, SCTP_CMD_REPLY,
-			SCTP_CHUNK(asoc->addip_last_asconf));
+	if (!sctp_chunk_pending(asoc->addip_last_asconf)) {
+		sctp_chunk_hold(asoc->addip_last_asconf);
+		sctp_add_cmd_sf(commands, SCTP_CMD_REPLY,
+				SCTP_CHUNK(asoc->addip_last_asconf));
+	} else {
+		sctp_add_cmd_sf(commands, SCTP_CMD_OUTQ_FLUSH, SCTP_NULL());
+	}
 
 	/* ADDIP 4.1 B5) Restart the T-4 RTO timer. Note that if a different
 	 * destination is selected, then the RTO used will be that of the new

base-commit: 05441d697f7f9a927264f4058cbbc6a03dfcac9d
-- 
2.55.0.openai.911.g06873a30d2f3

