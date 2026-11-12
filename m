Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794490771;
	b=Skt1Puu8kuDlcmxggfQFrC/A4EHY8tHZNhKTDeLOuj2M6A/e2uLkAe1o60M9RlJ2H7zq
	 VC0Ga/rdMyZ6X0i7GOPuxzfzXZj+j1mMtt3tprc1eEKJXcpho0ZOwz3OptIbAIp63YhWz
	 tmaGtukNWSKK3fmXxGTgImY5XjKWE58pvIy4vWi8qIumWIL43RIpLEwpdWzQ44ycJymyB
	 ans/fR8A9ucB9cSCHVC9gdLHpbph+zbBdaepfnOGBQ5RtK89eYlLKjtp6I9Zdvx0o4Ku/
	 NHcsebHc7DW/ulmY5D67Zj9uEXN7TsmMrvefzW8jdgVsBksCSN0HQCVjoJYQTRLF7fg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794490771;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=UH5LGFLC2YGmLQHgRteBnGRd8wNsSQF63ccA9n9othY=;
	b=tm5MWTsHIoPnZWivIaZco7hhTlBfz2WbSbSYamc1rQ1SWfvruuzA65tvf/cq2v6cGlpT
	 9ck4OLf/6siC1ETgn0GoCVeBOAOg0QYblp3UYsbUvP1d5lI+B1mSthwSgEBFAiKdwzPHx
	 6VWOm6980GfkIZuBUx/59TJ+facbL2scpfWjyWsdYHTo15QbRcYWce9r4J+DZB9pb9yFb
	 K8Z6iP9I/Ut8hpMmoI3+ze3yTbv042Z5DehSIOI8IccpIJ6QPEuO5RKcYKlu4Va6r0TwL
	 pCv4Il2E6JnFHXu/pa32CIDNYcYRZ/QOY1M4UmwxHt0pzKUalVVyPu7EsG8lL52XqUQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f++CrSaM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59042606A885;
	Thu, 12 Nov 2026 13:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f++CrSaM
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794490770;
	b=qX1akCWrM1JFXJun451Z1SuTV8aeoks4kv/y75VAlymOCqT5I5kI7x+T/lAXvBilpCSu
	 vy3WpSQK98VRXByWAQUt2eyXUwq7QeDQQLh7dFFSkzgHoKes0GQWfE+jRc2/+G+tyJkVk
	 R22RN+VtPmaRHx+3jBpIkP9+j8+dOx2h/ZM1LKYgtydE7YWAPDiCMcoJyh6eI1sJlucJq
	 BghDauO4ViQI7P/97FFk/szJG0POot+zdJlH92PLoSxyb6iTC7UoAFX1qQU1SgpMxOp/V
	 dgqSDc4JmBAVB5WMymBKQrUXuIr60wqOXF1L72oQfIVkXbA5+szof4tkZR30S6agS2g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794490770;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=UH5LGFLC2YGmLQHgRteBnGRd8wNsSQF63ccA9n9othY=;
	b=uNlkJhq9q5naoDcjlsrIv3/4wRkUCNKTskuYmRYT/HQ2zmpElZ8LJgcpFcfT33r3ez5h
	 /bYwOs8Q/WfJHBuu2JkM2sT3RJyulAhNG05AcdN51DGayqETAddpCh1xoo6KCvozpARKK
	 AtmLNw5Y/wab7/mK1ktu6hdyiFcRdtrA8MF4+Ql/CF+gURW1C2YG2mddxARsOf75thvna
	 pEQzs5Aic7PS/YIBJSaiVwL5OS5koHFhzwkOhrJZKztP/io31jxadQsGxJF14xbiWdUxp
	 YYG/QMAtMJMvHHTWjE0hAbaabByJPcd+vkIVaUYV4DMFK/xgPTlZKN/MsWxqI1LjIng==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 1D81E1F00A08;
	Thu, 12 Nov 2026 13:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794490770;
	bh=UH5LGFLC2YGmLQHgRteBnGRd8wNsSQF63ccA9n9othY=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=f++CrSaMk8ZtH9exXI3SXtb4AHKEjt8dmX2GQGcfgVVkf5JQMNhe/b1Jr1/o/89hH
	 +cEMBVeEwbG3ABquzVRPuEddBeJq83iMryasXWUMGVB+pcwJWanDG7Shz/bgXbr377
	 cR4nBfjBnLQYd0r+5W3TFBeQy60vtuTcrbZsDDEHgeJLrnKk8pCncV+a5s6lfZC8Zn
	 vqs94vDEymKsek+hnSfZnvAwQjT7Yxq5bkqQhBzeRIxSo0bGNCla5Uwk1GPeIZzVif
	 sP1Vlnn4eFnfmKaFcgorsy+Y1f5T1HmOlWiquBImm9Hq7aZHwZQoM2rrHpEUvnBrMY
	 oiGGPiKXhgjuw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 6E04149514;
	Thu, 12 Nov 2026 13:39:29 +0000 (UTC)
From: Joas Antonio dos Santos via B4 Relay <devnull+joasantonio108.gmail.com@kernel.org>
Subject: [PATCH net v3 0/2] nfc: st21nfca: fix SE APDU request race
 condition
Date: Thu, 12 Nov 2026 13:39:28 +0000
Message-Id: <20261112-st21nfca-v2-v3-0-c81702269e01@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJDB9WoC/22NQQrDIBRErxL+uha1UaSr3qNkIfpNPjSmqEhL8
 O4V14XZvBlm5oSMiTDDfTohYaVMR+xwu0zgNhtXZOQ7g+RSC8ENy0WKGJxlVbIwOxWMFjgLDb3
 xThjoM9aeELHA0s2NcjnSdzxUOaK/Y12cSS8w+KCsV+ax7pZeV3fssLTWfvYTPearAAAA
To: david@ixit.cz, krzk@kernel.org, joasantonio108@gmail.com
Cc: oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, horms@kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794490768; l=2879;
 i=joasantonio108@gmail.com; s=20261031; h=from:subject:message-id;
 bh=dycIAZ67P7dxjyM+e8OFg3HpvpHw09nTXrMGmQMNnPc=;
 b=6yRt9w5P/R9HsMDsNiXb10MzNMRwJYk9eP7zeICOXpcwYmTNQaucAkfBW+Vv2usoxUi0c27Kl
 BIUBdlEkkTtAlciYSNzd11VrdTCmfReHW68CqAYxW3Rz/28EcMYehbj
X-Developer-Key: i=joasantonio108@gmail.com; a=ed25519;
 pk=ZxAznJT/FcPPdzLrDDFJQm4LLjjHVGBBqDSG3TXS23w=
X-Endpoint-Received: by B4 Relay for joasantonio108@gmail.com/20261031 with
 auth_id=1371
X-Original-From: Joas Antonio dos Santos <joasantonio108@gmail.com>
Reply-To: joasantonio108@gmail.com

The BWI timeout work and the EVT_TRANSMIT_DATA handler can both
complete the same SE APDU request.  The callback frees its context, so
the second completion is a use-after-free followed by a double free.

  1/2: Add a spinlock around bwi_active, cb and cb_context in the three
       paths that use them.
  2/2: Use the lock to complete a request only once and to reject
       overlapping requests.

This was found with the help of an LLM-based code review tool (Claude).
I checked the code paths by hand and reviewed the fixes myself.  The
series is build-tested only (W=1, arm64); I do not have the hardware.

Not addressed here, all older than this series and pointed out by the
Sashiko review of v2:

- st21nfca_se_deinit() can leave bwi_timer armed when info is freed
   (it runs before nfc_hci_unregister_device() and only deletes the
   timer when bwi_active is set).  The remove ordering needs its own
   patch.
 - EVT_TRANSMIT_DATA carries no request id, so a response that arrives
   after its request timed out can still be taken for the answer to the
   next request.
 - When nfc_hci_send_event() fails in st21nfca_hci_se_io() the request
   stays pending until the BWI timeout completes it with -ETIME.
 - drivers/nfc/st-nci/se.c has the same double completion.  I will send
   a separate patch for it once the approach here is agreed on.

---
Changes in v3:
- 2/2: free cb_context when a request is rejected with -EBUSY; it was
  leaked (Sashiko).
- 2/2: still send EVT_SE_END_OF_APDU_TRANSFER for a response that
  arrives after the timeout, as before the series; only the callback is
  skipped (Sashiko).
- 1/2: comment on what se_lock protects (checkpatch), commit message
  no longer claims every access is serialized.
- Rebased on v7.4-rc3+, target tree added to the subject.
- Link to v2: https://lore.kernel.org/r/20261110-st21nfca-v2-v2-0-cf9102b314cb@gmail.com

Changes in v2:
- Use a spinlock instead of plain bwi_active flag checks (Simon Horman).
- Split into two patches: locking, then the completion fix.
- Set bwi_active before mod_timer().
- Copy cb/cb_context under the lock, call it after unlocking.
- Reject overlapping se_io requests with -EBUSY.
- Drop the Assisted-by trailer.
- Link to v1: https://lore.kernel.org/r/179332800288.52644.8728400883396719965@gmail.com

---
Joas Antonio dos Santos (2):
      nfc: st21nfca: add spinlock to serialize SE APDU request state
      nfc: st21nfca: prevent double completion of SE APDU request

 drivers/nfc/st21nfca/se.c       | 38 ++++++++++++++++++++++++++++++++++----
 drivers/nfc/st21nfca/st21nfca.h |  2 ++
 2 files changed, 36 insertions(+), 4 deletions(-)
---
base-commit: 9d66f26fefacebfeed15de31c1123451a17ff119
change-id: 20261108-st21nfca-v2-f4c5f861e416

Best regards,
-- 
Joas Antonio dos Santos <joasantonio108@gmail.com>


