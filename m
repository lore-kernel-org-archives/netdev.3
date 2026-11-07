Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794020737;
	b=oAI+4LWYbEgwEPsbAJswLpHOfVlNF0/sxxTaf1LgVoNCAKnvf5F/niwhp9mDwpyB1Fj3
	 ag4uyVe1ujU0DP3XYYV8ITVj/+WU7WDC0+OnCQ7rU0ZkGsrpyLSFh4FCW87j6oX3SiHDo
	 mlDbEzDAo7ySXv+AWLD92CQ1QpstfIgQDqMYvSPdRz/E+0TtEN3VwXNQi13mvUc/+NlQZ
	 4IxVohctxdWgPR2rTRj5tvxxtTytB+uahyF+/jLz5ER12pZocJF2Q8leF0z8JTHCme4eX
	 RmmI2zw5eM6GY7x57D6K7xvFSyeQoklYHezobu5qa6X0AqxGhmyVY70InzpxQtjsDOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794020737;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rP1Yhc8V6RNptl8ZAiLhF4SuAftOJVbuJVVUglBaikU=;
	b=4T/gIui1QpDIbmUYrmGNcG0b4BZXEbpL+N5rBBh5KeQmKyjP9qOk1mZV+Fz1RDhSV90H
	 IVxfmDKUiZyse9WIF4aPAUtx2VmumslsGzV3BzQebcw7OvdHtTS7ezhJYNviU5lZDLM+E
	 zx22NbWwV3IhO2WGVTiGvSFsoYtk9vpRI/stVkBAlfmV3dnXWTz/oM9kRLgRPOUwoCGZ0
	 JrCZNau4W9M0+G9fMSEciHHdmijGkcsSvMUUClL8a2oVgCpsmGxvEBbQXejXwWxXahexV
	 f+v6kA1u6tSb7/rSrhwiWkLsGWWqLOEPoUYVjqF5UZsczYxCq0y2yv8SqnGzq9AZXLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openai.com;
	spf=pass smtp.mailfrom=openai.com;
	dkim=pass header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=LnwVBnrF;
	arc=none smtp.remote-ip=209.85.161.54
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4625E606A32D
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 03:05:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4625E606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=LnwVBnrF
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6fe4372c5f3so831289eaf.3
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 19:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1794020735; x=1794625535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rP1Yhc8V6RNptl8ZAiLhF4SuAftOJVbuJVVUglBaikU=;
        b=LnwVBnrFVKd4RmmtwNpC5ZIpYUQ3jidty2bj9aG30X4RnNmPVWvtRXkubIjjaFev8e
         PaUNsCLZIbiMUMitEH3IpDfAiaxnytnUnwoYmJnQzGiYfREvafWZ/dSQ2hFI7mcgairU
         p8CuTzrpbPrrSbBINfVDKpwHDcX7tx4rBpBCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794020735; x=1794625535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rP1Yhc8V6RNptl8ZAiLhF4SuAftOJVbuJVVUglBaikU=;
        b=mYPVoTQsZl3hKZ6ErmSpcn0G9e10iGu93tkvUlPEZTQOj/w4bfzaSHkFhA37aaN71u
         OQQNpE9BA+nWWlsu7HsE+lH5RuFiHPpL17kzqfHqurxqaCkcjdMeaESky2DXep0xSDhY
         QmS7FWlTbqnxFO3cTUeBIleaWnSnIbZRRSho0QRonu9klxLgOQYJAWSnD2K3bustes2f
         w5EpJK48rCzpTmZeVdXL+I2+6Py6aPpD0dDOMEfjt4ftWKDjWhKjen0KnX5XWMSVCbIv
         tH4zw4SBGzyz7DFv0KKV3i59YHV9R/+cJQoek+tSu+s+Cf+F35nYF6YgFMRWGYNAY54t
         8sGQ==
X-Forwarded-Encrypted: i=1; AKwUvBwbSGsb7Jy6+/ffqQ284GYhcyuEkKBbjhJyirMh21lHQJw/7AGow04VkX7WqjxjzYYqrjbzrhs=@vger.kernel.org
X-Gm-Message-State: APuU4Z9P0s75P12QKTezeaQZC2wL7/31KggxF/MBy/kjyXLDArzi24aw
	YL8bZQH7IVpy8FBNPXB1CI9zP/eSv9iRO66bktkDvY2Fg7l5kwYqOzy6IHnzPTPXu/o=
X-Gm-Gg: AYBFou0/Bv9kCHNgh2t77IrC0WH8qVaaxup0rBLHy50XFXV0cSGnF33lrBZT6prTUMT
	G2dKsIeTq2GoFcaWpDBRugdAXHLI+g37+V4poNjPC+QRFmjdLy+NPmRidReNzbdQ9zaR2+iadrY
	tNr7v6MJVfCP4RfdnGqI1p3Dd0p4WzgGe/RULcUuoQ06OhVR6Opsl2NNw6mfRrPy2n+k9P/9T7K
	6QrzFWonhBNBgLPfpCb8juv+OXhMyz8e6n0QoEuk9XnAVo9jyoH/8pF3KeKAxzXJEQeUSUKxA+4
	s7IMQElWcDt4rwXapyb3dXvJ+qsoGQHWzIHzpcYH5E14T4gmCe/X+ZXl76cBa9loKruSOWSkk0Q
	5bG07sXlnIwxCVtfanMV4y6iZJV2xRUFZj9jwZ95aT+BE40L4B7S4RzZbw62HPsKp3SL6SeydER
	PA9BNnXPl+uqvnOpbUCI5Qe27sBcE8i4rUlDZ+EZpMC3m+IbxBByO2zkTtm9Z2bCL62AtbI7s99
	haUXWwx+J/y2qxo2kqCqCdPFF8H2ViudCY6PGjOaMKPBdErDLjxiniWphxUAu2hkRfjlmx6keJC
	mz6kqS0mCwHQKYXbJcLpeJWzRDr9j5CYFiDIoYG1Vt/NPazude/29dlXoGvEmDEfEEoXP5H+udg
	A4woda6jKyLYh8krUN3Selz5s9aW83g==
X-Received: by 2002:a05:6820:1621:b0:716:f44b:2dd6 with SMTP id 006d021491bc7-716f44b2f07mr1500290eaf.25.1794020735120;
        Fri, 06 Nov 2026 19:05:35 -0800 (PST)
Received: from com-75606.corp.openai.org ([199.47.143.1])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4ad97a37725sm3581702fac.11.2026.11.06.19.05.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Nov 2026 19:05:34 -0800 (PST)
From: Kyle Zeng <kylebot@openai.com>
To: linux-sctp@vger.kernel.org
Cc: lucien.xin@gmail.com,
	marcelo.leitner@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3] sctp: avoid requeueing pending control chunks
Date: Fri,  6 Nov 2026 19:05:32 -0800
Message-ID: <20261107030532.32310-1-kylebot@openai.com>
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
extra reference and issuing SCTP_CMD_REPLY. If the chunk is already
linked, leave the existing entry for normal output processing. Keep
the remaining timer and error-handling commands unchanged. This also
covers RE-CONFIG retransmission after sctp_assoc_rm_peer() moves the
request to another transport and starts its timer.

The issue was found by an LLM.

Fixes: 2e3216cd54b1 ("sctp: Follow security requirement of responding with 1 packet")
Fixes: 7b9438de0cd4 ("sctp: add stream reconf timer")
Cc: stable@kernel.org
Suggested-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
v1: https://lore.kernel.org/netdev/20261030042321.74407-1-kylebot@openai.com/
v2: Move the pending checks into the T4 and RE-CONFIG timeout handlers.
v3: Drop OUTQ_FLUSH and use the two pending checks as suggested. Leave
already-queued chunks for normal output processing.

I have a reproducer for this issue and can share by DM.

 net/sctp/sm_statefuns.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
index b2f609f177fb..64519fd8f943 100644
--- a/net/sctp/sm_statefuns.c
+++ b/net/sctp/sm_statefuns.c
@@ -1122,9 +1122,11 @@ enum sctp_disposition sctp_sf_send_reconf(struct net *net,
 		return SCTP_DISPOSITION_DELETE_TCB;
 	}
 
-	sctp_chunk_hold(asoc->strreset_chunk);
-	sctp_add_cmd_sf(commands, SCTP_CMD_REPLY,
-			SCTP_CHUNK(asoc->strreset_chunk));
+	if (!sctp_chunk_pending(asoc->strreset_chunk)) {
+		sctp_chunk_hold(asoc->strreset_chunk);
+		sctp_add_cmd_sf(commands, SCTP_CMD_REPLY,
+				SCTP_CHUNK(asoc->strreset_chunk));
+	}
 	sctp_add_cmd_sf(commands, SCTP_CMD_STRIKE, SCTP_TRANSPORT(transport));
 
 	return SCTP_DISPOSITION_CONSUME;
@@ -6197,9 +6199,11 @@ enum sctp_disposition sctp_sf_t4_timer_expire(
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
+	}
 
 	/* ADDIP 4.1 B5) Restart the T-4 RTO timer. Note that if a different
 	 * destination is selected, then the RTO used will be that of the new

base-commit: 05441d697f7f9a927264f4058cbbc6a03dfcac9d
-- 
2.55.0.openai.911.g06873a30d2f3

