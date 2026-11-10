Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794280977;
	b=cZFoqQu3XIXyFNF3uQTPCGL/tZioFd9Oi4dTUn6o3SvAzv7ije5cFZeehfjlmDkiJAmM
	 0DcLbyKNTJW1UrS5ZHcmLjg6vpGGGIuq/J26+VSFsv4KKy7dyJKqM3EQpfujTYqiFIsqU
	 hYp1pNd1LSHqtsdos8Vv8SmUyH30XtKYiJ1Xb4o6qic+ZUDN+BoT5zr9fJNB1T59Wvgx0
	 ReVPw2UREQVFCbaLoVnvdAL5EWu26wc7PnFDWNAHKaHGeYgv5R+oO5GUWfxgromLpL8dz
	 lqP1scKheBBLdGkMPXU7IXqTZS/uFinXbYA3f4fQnWi3ZPI4ye7r3ZrwIjfgbB0+Ebw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794280977;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=DtfYu0W5Kmyhf/+6XGl64f23+1lZUgHE+Y3HUa4dZWI=;
	b=mYadxXv1mhnybTDBzZ2ZX/hhrbiHCnIcWv9BwD75EC7SlPg4WozFf0o03EE8o1fsFPf1
	 HJ26NO8xfkTNoRMArJiygcFRu/UIzDK765DpOCguO96c3AyaTKcUW3XCvqOumCOY2Vags
	 EwGbg28yCVLqA/z8DhcKfkIpmcHKOCjwfqur9eQw0jHTZ4cR/nkabQa4jOR3YNsOsh5J7
	 D35eoMtiQFgTImZ6VvVNXZ1Tcc/xeatoEDt0JVjmoJvlPkQs6H0mUlBbKZuOK1/dbx8DX
	 E1EcENzp7AoZbLHMk9wJGgUY4WXR6KR93X8+m6SlS84I67rIHiZOto5LbM7nlmXPIMg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k8+BFxpx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74E960A260E;
	Tue, 10 Nov 2026 03:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k8+BFxpx
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794280976;
	b=KKleJ4a/eZ3VmKUSzk+xmkFXIHMt7gguLZd5OSYoakbFavlMvVx3jzoH0zjdSrzxnXY6
	 S0XbC2AH1j0dqK7k7eBgdDv8xPR9zR57R4hWg1vDugdMhu1eMl8m6shducNqFXrwNbJqk
	 csK2lnQXs9Eq4yBM0c1dHnBT84CynH+P04OIuMo+N6QSu6SjDA36i89Y6eMuqyDIc+FKh
	 ewG1lc8r7h/WwdTy/rZ2XKlEnOc4PWiKkV74Sukqt+i8KO5LsGkr0x+T36+1RyydbvdJP
	 AH51OU3tXBEWUy4f1vKQTAUOLof+BkhhWd1NFmI+g0bQb8pDO2XpDg2bmj+FjnyE8/A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794280976;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=DtfYu0W5Kmyhf/+6XGl64f23+1lZUgHE+Y3HUa4dZWI=;
	b=fFH1SU7iIq9EdMMIYTTjmqFr/2V+ENBZmG8/qgfgFRIXLysqB80odvEUvLwYbQZpubt1
	 lNxhEpF2diQtKANS/c/zT31pz9LbFsQz6la03bcekDFggjX7cXeAPQGOucIX0hqDWjEo0
	 jVm0sIR1E0PfBkwyjGktyuxFm4N5VFSrOqVWmVK/SkMKvo4F8Pa0vd45Ajicg4C2PcOAJ
	 2Ex0NbDR4Noz6tpIpJzMaIdwwR0ubFD/6XlPWNB1A5lf/Gbefq0PWAn6FYt7NqpgX1jZa
	 7EiiBFAI3GXO2SRKiKLgtpqGCTRzI/p7TyVct0iAxZ+FA9u/03Yw/1IMlZaCVdGlQ9g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 5EFAC1F008BF;
	Tue, 10 Nov 2026 03:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794280976;
	bh=DtfYu0W5Kmyhf/+6XGl64f23+1lZUgHE+Y3HUa4dZWI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=k8+BFxpxvIjWbdUCMtMCKdX+eEVA6GjBbU4WEOF/hyTEY2QlxwvC8yWQ89Bg1esvb
	 u9NeoynIhQYR17JWB7YzyjyjFRuxD2X3rTj8c1sDazZxHePV4ZScQqajg/vJCGB9It
	 MpIeJHmupCuEjMW8L7fXVBpPUXBz3DPU4TqsPMxI+y1LMCZYyNHQDYhZ5j52zm0ph6
	 m+AFZUOMmdWWNAQCODNlo26ym9p4E4SBSM5F4c5IEL8ivQrk/JOPn9Du3J+B4vsF9k
	 8tSzQfL7H5dAqHRYm4NippkzACufndAlrmiatneBcSMOilQO8M9CHhiK1cOgwgacUw
	 nS43XeeGdklRQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id E431C487B1;
	Tue, 10 Nov 2026 03:22:54 +0000 (UTC)
From: Joas Antonio dos Santos via B4 Relay <devnull+joasantonio108.gmail.com@kernel.org>
Date: Tue, 10 Nov 2026 03:22:56 +0000
Subject: [PATCH RESEND v2 2/2] nfc: st21nfca: prevent double completion of
 SE APDU request
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
Message-Id: <20261110-st21nfca-v2-v2-2-cf9102b314cb@gmail.com>
References: <20261110-st21nfca-v2-v2-0-cf9102b314cb@gmail.com>
In-Reply-To: <20261110-st21nfca-v2-v2-0-cf9102b314cb@gmail.com>
To: joasantonio108@gmail.com, david@ixit.cz, krzk@kernel.org
Cc: oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, horms@kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794280974; l=2168;
 i=joasantonio108@gmail.com; s=20261031; h=from:subject:message-id;
 bh=vFtcDmj/HhhskQoZyc9H4wJhx0PE7EpKs3FCfz2WE98=;
 b=rIUPhYTo2Yupd9x65BjIKJkqYAv/BbFe27BYJ5yIfo518AhBAtOVvFU0haXFeFjxMrvmFSICD
 k6/wF5ymG0YCcR5F7nxwpnNDJm1SmdWGyI8+f2OPFJHddEZaMfTQ/Qr
X-Developer-Key: i=joasantonio108@gmail.com; a=ed25519;
 pk=ZxAznJT/FcPPdzLrDDFJQm4LLjjHVGBBqDSG3TXS23w=
X-Endpoint-Received: by B4 Relay for joasantonio108@gmail.com/20261031 with
 auth_id=1371
X-Original-From: Joas Antonio dos Santos <joasantonio108@gmail.com>
Reply-To: joasantonio108@gmail.com
Content-Transfer-Encoding: 7bit

From: Joas Antonio dos Santos <joasantonio108@gmail.com>

Use the spinlock added in the previous commit to prevent completing an
SE APDU request more than once.  Without this, the timeout work handler
(st21nfca_se_wt_work) and the EVT_TRANSMIT_DATA event handler can race
and both invoke the callback, leading to a use-after-free or double-free
of the callback context.

Check bwi_active under the lock in both completion paths and bail out if
the request was already completed.  Also reject a new SE APDU request in
st21nfca_hci_se_io() while one is already in progress by returning
-EBUSY.

Found by LLM-assisted manual code review.

Fixes: 2130fb97fecf ("NFC: st21nfca: Adding support for secure element")
Cc: Simon Horman <horms@kernel.org>
Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
---
 drivers/nfc/st21nfca/se.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/nfc/st21nfca/se.c b/drivers/nfc/st21nfca/se.c
index 03a30f797ff8..3be77420e956 100644
--- a/drivers/nfc/st21nfca/se.c
+++ b/drivers/nfc/st21nfca/se.c
@@ -228,6 +228,10 @@ int st21nfca_hci_se_io(struct nfc_hci_dev *hdev, u32 se_idx,
 	switch (se_idx) {
 	case ST21NFCA_ESE_HOST_ID:
 		spin_lock(&info->se_info.se_lock);
+		if (info->se_info.bwi_active) {
+			spin_unlock(&info->se_info.se_lock);
+			return -EBUSY;
+		}
 		info->se_info.cb = cb;
 		info->se_info.cb_context = cb_context;
 		info->se_info.bwi_active = true;
@@ -269,6 +273,10 @@ static void st21nfca_se_wt_work(struct work_struct *work)
 						se_info.timeout_work);
 
 	spin_lock(&info->se_info.se_lock);
+	if (!info->se_info.bwi_active) {
+		spin_unlock(&info->se_info.se_lock);
+		return;
+	}
 	info->se_info.bwi_active = false;
 	cb = info->se_info.cb;
 	cb_context = info->se_info.cb_context;
@@ -395,6 +403,10 @@ int st21nfca_apdu_reader_event_received(struct nfc_hci_dev *hdev,
 		cancel_work_sync(&info->se_info.timeout_work);
 
 		spin_lock(&info->se_info.se_lock);
+		if (!info->se_info.bwi_active) {
+			spin_unlock(&info->se_info.se_lock);
+			break;
+		}
 		info->se_info.bwi_active = false;
 		cb = info->se_info.cb;
 		cb_context = info->se_info.cb_context;

-- 
2.43.0


