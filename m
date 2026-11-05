Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793876297;
	b=E+kMH3Yht9zOxtFI+wXdLSKcoDLTlBvBGi7eLx9mlPuCky+fGqZ+Iq/uAj9V3visSvgh
	 CuuEfIcq0mVkExrcKVXcMgnpnEuvoNy1xUqDtTU62Ncl1pz2vGAEEnjhRVSpiCpN73IUs
	 ehiVdzT5eRdADb8QMHK51VF/FeOsiFq31rUYljzvjDmWG5w/KHJB2n50Dcx4oD2MIHyJg
	 hcmUJl8RJWf/QLIEx3BQM0K1bm9tS9hxJ7qgG/fny8GYsLpoTYLZyAntvnfhzZ/SEPbFr
	 5UUnMCg+54NM+sjaXw4LQhE7RvRfRMtxeZTk9Psn5x+pPWBVNEu50qhhfG4llwc23PQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793876297;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lNM3+b6l7cj+vrA9YlqTwqxAWDbif1TufQothTfjcdI=;
	b=qPSkNOw+6VQZ7AuvtooRTpLlv3pEMXuA3f+noAHKJAkEk3E91RLRhMqnZzhmp6IISlSF
	 1F0Dy+S+UJCTXYdpQmOSDAEh3xXalaXaz7n/bZZpmHAILo6KtYMaF57PKaoVArv0+DHtu
	 R0x238NxNSfHHg6KwBz+bP4V2HP1rXYlT8iVZN/U95C+rQ/PtoSx5db8bO279CSbnlaQL
	 p8XH/Z31kF4ELf4PRjQBVUqZiBYzE50vcFAmofgZ7ZAEj6zMCDtkgbMO5bTtstkqbH1qv
	 qx/ePTbJ9a5HVyo4gI3fXVE3FiVBEowItEyKGP5sPSPeXcgfThPLCQnjMG9T00TdWMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="K71ocXZ/";
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E812E606A329
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 10:58:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E812E606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K71ocXZ/
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3ac77270fbfso1045819a91.2
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 02:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793876296; x=1794481096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lNM3+b6l7cj+vrA9YlqTwqxAWDbif1TufQothTfjcdI=;
        b=K71ocXZ/HS49uXPUvftmHhF6iKBXr20U2JrbygokCE2ws0bmPHGf31dFDsS4e7vYBc
         kSuozUaxk9asDfi4t2/Ux/IkhEG8uqRsxrbJly3oQTEWxu3Nsq1+tKv2FJO2Wk0lURai
         bFuhYa4q7U1qi+zB3Oj+st3oMFSydBcfOv1QFkO/wb6Fx0IyndGwbtQNTlQYqhILV/qh
         EqjP6HeieKytlaUU2OmmHKBfeuKEFg3LjpvkGiXYTaFdrgdao9hygCU9DVztjYRvk2LP
         rFbb7HrHCcnOUFlZC53KkxG6+2jt2tGFAkzvXdABUjmdvkPgsnnvf9/lrvsW2F79q+Pi
         vsAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793876296; x=1794481096;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lNM3+b6l7cj+vrA9YlqTwqxAWDbif1TufQothTfjcdI=;
        b=HUb2ycK7ZFxIun/45TYRNoHsUyRoUSfSnGNP9ZogkPdm8VswcHvEMCPjEj6Z92a1yS
         fOmSORt+1GMNlNDCCSV0S09J0uQPxV7jicqXFx0mfWvFScnbcf25v0U5abhnACISQlv6
         GHO+lMo3EG9lsyBvs+VxwreffV8AWc+g6/7z16DLrRDpziq+cvPso+FTHoM+5CknQm8d
         /JN4EsUxBq80/PqOh+G4CL9pudCPunfEyZ8gaeoPcfrVi7uT6pRD4Nx1Cu0qt28tbMKh
         UJfAnK6+i6mdwyKFIYDzRd87Snm6nKKVMWqGCaF/mh+FMPsM9I+z60Wl6QkNjjNuUdB1
         tolQ==
X-Forwarded-Encrypted: i=1; AKwUvByAu5xh34FAny25zuz7zGAVEGg2QS3sDjjcPZbCsRxyGhAiIJHQcBRCG/s7nQKu7WSRRm/ELuY=@vger.kernel.org
X-Gm-Message-State: APuU4Z99J8UiR7tLdYghkuDZSkkDV0956h6U6Rweh1zg5K0Sc6k/Ksuo
	N4ot00ftvLYHhu/0CUuNQUYr1rvy5VaUNzMgx+wqtpG77nbF2EmwMezd
X-Gm-Gg: AYBFou0UVI1JSC2ZdpJuX2Wln4pa1wNg09NZXEYV2XhqhPwBTw9cmkYqw2s2prkl2MC
	bKHKbJw/bRX8Lt4qIgDy1xVNZIvlqUHdYLKxd+2dEjup161wOezVpV35OSJJD7Yq4isSP1BmVDz
	NEVBYfnssdgOpSebTk1tEmZsp5M+Rk+BLZk1tpChYJmWpiOgioj0NLLDNitplT9/UxNrYxh2Tmg
	2TKwkEZfiE0azLiPYNWvhE7rIKPkOoU8EY8PJi495gl3vbdSwcoqp0uqgiRZik88hGI6MYShFel
	XrOfkK2fYE3JJ3XVJy+ErM9/kNjL4LzGI/rQDf14hUHFwKR4lU6rnppHXx56JmZzPw18O0PcR3w
	1uB7lrs7HPiK+Y0PZY4jhBp/yBtY9VoJbAI0L1ZyjlXHUe7Pn28vd50dyWh3cQUprFJu/z9k/SS
	vRGHebHaUBZg75ZnGnKEDAL+VYp2N8K+lTWwVeE+zUj8jNWIJc2iqOloljatRdukJ47e3Zc3eg0
	SS9BRUkbyvRn/QXSTySaibevrOo21LNmiP8Qc6kXDVmsTO0qBPDu5J0nZT6lSP11y3fhVEw0lnp
	xYqXRmP1yfZT6293ZKnWYZscwmFBnrLt7kyLH1895069+I1a
X-Received: by 2002:a17:90b:518b:b0:3ac:ea3b:f28b with SMTP id 98e67ed59e1d1-3ae897b6653mr14961496a91.24.1793876296249;
        Thu, 05 Nov 2026 02:58:16 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b32b6507sm3777513a91.16.2026.11.05.02.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 02:58:15 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: David Heidelberg <david@ixit.cz>
Cc: oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>
Subject: [PATCH] nfc: pn533: validate response length before parsing DEP ATR_RES
Date: Thu,  5 Nov 2026 19:58:05 +0900
Message-ID: <20261105105805.1450120-1-hj351016@gmail.com>
X-Mailer: git-send-email 2.43.0
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

From: Hyunjung Ko <hj351016@gmail.com>

pn533_poll_dep_complete() and pn533_in_dep_link_up_complete() cast
resp->data to a struct pn533_cmd_jump_dep_response and read its fixed
17-byte header (status, tg, nfcid3t[10], didt, bst, brt, to, ppt)
without first checking that resp->len covers that header.

On a short or truncated response the handlers read bytes beyond the
received frame:

  - rsp->status is dereferenced with no minimum-length check;
  - for a success status, memcpy(nfc_target.nfcid1, rsp->nfcid3t, 10)
    copies 10 bytes from offset 2, so for resp->len < 12 it reads past
    the valid response data. Those bytes are then handed to userspace
    via nfc_targets_found() (netlink), which can disclose stale buffer
    contents.

target_gt_len = resp->len - 17 additionally underflows (it is u8) when
resp->len < 17. That path is mitigated downstream --
nfc_set_remote_general_bytes() -> nfc_llcp_set_remote_gb() rejects the
resulting out-of-range length -- so the subtraction does not by itself
over-read rsp->gt[]; the fixed-field reads above are unguarded
regardless.

A valid ATR_RES always carries the full 17-byte fixed header (the
general bytes, if present, start at offset 17), so reject any response
shorter than sizeof(*rsp) before parsing it. pn533_rf_complete()-style
handlers in this file already length-check resp->len before use (e.g.
the ATR_REQ_GB_OFFSET check in pn533_init_target_complete()).

Found by code review; not reproduced.

Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 drivers/nfc/pn533/pn533.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/nfc/pn533/pn533.c b/drivers/nfc/pn533/pn533.c
--- a/drivers/nfc/pn533/pn533.c
+++ b/drivers/nfc/pn533/pn533.c
@@ -1309,7 +1309,12 @@ static int pn533_poll_dep_complete(struct pn533 *dev, void *arg,
 	memset(&nfc_target, 0, sizeof(struct nfc_target));

 	rsp = (struct pn533_cmd_jump_dep_response *)resp->data;

+	if (resp->len < sizeof(*rsp)) {
+		rc = -EINVAL;
+		goto error;
+	}
+
 	rc = rsp->status & PN533_CMD_RET_MASK;
 	if (rc != PN533_CMD_RET_SUCCESS) {
 		/* Not target found, turn radio off */
@@ -1929,7 +1929,12 @@ static int pn533_in_dep_link_up_complete(struct pn533 *dev, void *arg,
 	}

 	rsp = (struct pn533_cmd_jump_dep_response *)resp->data;

+	if (resp->len < sizeof(*rsp)) {
+		rc = -EINVAL;
+		goto error;
+	}
+
 	rc = rsp->status & PN533_CMD_RET_MASK;
 	if (rc != PN533_CMD_RET_SUCCESS) {
 		nfc_err(dev->dev,
