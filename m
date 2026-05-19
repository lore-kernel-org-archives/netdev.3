Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36155367B7C
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 18:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779216525; cv=none; b=dxaBVjt/nPMJDi/XOPyDDEjsD3TfLFVHHX+/d5gWAzxDfZ9ravul1oiTN3H46PlMjqFUZzGWlRdQeowJgRE2wMfDzXH6GjtjZ3DNsZX3kg6gAckMC6s0LwByBwh8Zv1HZSWtVk12yH+BrmVGLU+kzG+S7FQRlXijLlnXZ55D8qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779216525; c=relaxed/simple;
	bh=+ReRBvwgjN62CEzvlVK3O2mCtDVNfcKsS0SOX61dM8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cBw+yGFiDRsTLJQnHbHX23kmee57/2AFeHMRgSaOLbdWiR1bxDkAOCK+eWrH7NeZLS8fMYm6M4rC1qkfQkB4qNiQg+IRemcyGJxwEv5ucd7Yg+wrD0bsCz0M+UXtJsnW2JPaJbMuAtnWOKNfTyztFaqJJgb1RQf01uzNWJIGqgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZ7nGeIi; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZ7nGeIi"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488af96f6b2so43255185e9.0
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 11:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779216522; x=1779821322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PEdQj3UnvnU4h8yi+M71QNzdIXPY/4/VW20nlE/VJic=;
        b=AZ7nGeIiPiV11tqr5OiXylB0A+LHisu0sWb4Mp+VfffK6ClvXoUdhbfBy1Yw4E1MDV
         ON7K/36Y/BM+zxnmmOZtuAB5jUiJffFnN5hm7ICSxna3KnVCwznNfPDwWd3JO+FckH6J
         dqt1SYuNmA4+u4T1xv7fri/To6BNgBAmp5whuF7v+HjgtUrLK19A1iz6B5bRChb/xpE3
         M63MEbDbewgGwaJ+fs6Ig0JFtdXcN6UjnZEk0iU35Oaq5xr/BCVg+0edxeGFpIcEliQy
         TfPXSSpBdd9MSIGvGAUy8D/eQwUIIyUyC5bSIAiIZKdBT0BQzPtLRrBhzPi6IbNFDyoE
         5MCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779216522; x=1779821322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PEdQj3UnvnU4h8yi+M71QNzdIXPY/4/VW20nlE/VJic=;
        b=BRkY0Wju/k8tg74XVWWYVCyfAESUvYptEps1ZWZbIMfj4l48WLiTHYZn5/OzA33U5k
         PXhcbxBVMPUzmKOGQqc3rlxYxyEEmugclENZCRGOtXrkmtB3+ZcOoqrsc50wAiiUry8L
         M0LuB6TgUDI18jcgT+PD3w7OseQsc5Br+HNETQA+5Q4thfV/gRbzd/MXnI3F8UjSKi2F
         JEuRQXl7EeFtA4SzAQB7nmYVyzaz4IwJvdJvwUQabSEPjaRzTCdkyxvAS6/KErfVt1MZ
         nro9hJd/F3VePA4uAlkVjlFRj+K6YatKKaZ834a0D1NWlfwtq6e+cVSNrY41rgJmFGSA
         r4IA==
X-Gm-Message-State: AOJu0Yw+w2cI0SRAoqAdDQaUw0pIwNgMep6fSfiViuu7ziy3DOchi6fa
	mopJHRP2w7MubPe4ZSYV86lORcVW101AHp2UslHy36dpl1OXMo9GXJ0E
X-Gm-Gg: Acq92OE/wxvrIYftXQlsRBQ+S74MUpgbxcKmKzg2lGg/8nkER8HAhmaHmlQV86RubVl
	7HfeYOc9w0MWg7SBG9qz82Xq231px5S/aOgayX1meBYjycg2o7w/eJDBkk2N0FpWyitFzhYccgJ
	FmR10O7WtgW9lBM9y/RuuaJJ047drPOcFixuLX1QRsCOrB8aldO/XLO45d74zfyv/uuEiFqEvu1
	fpXncRSWN0xE4PhXrqQNakiY6NsktW34RrhbJI4Jz61riiLD2GmmgKqoaGLh4k/moC1t2GbiJKW
	2n2iZXyPSUdYlvfXE9gl3AFv9bjp2dlVOMgBaUGTRl3iQyd0PuQo3bxMY0HgESUkDzCqmJtzAyz
	bwOGIwn6A2TSMoA9vZL6uhLGD4v+GJOQ4Bg0znQcwZO+G8YuQxgganiDRt9CToOYqAjCfjn0dd7
	CKlAhvF05LFKJNe+iZop1Q+fkNOUT+mGBK9hLNPB2uNMTeiYq8MgaYGxpPLQhUpZostPFMpvxaV
	So2fpO3UEeJ
X-Received: by 2002:a05:6000:2902:b0:43f:ea25:20ff with SMTP id ffacd0b85a97d-45e5c594d5dmr32513532f8f.29.1779216522437;
        Tue, 19 May 2026 11:48:42 -0700 (PDT)
Received: from node ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da15a6449sm47420197f8f.37.2026.05.19.11.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 11:48:42 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH v4] Bluetooth: RFCOMM: add minimum length check in rfcomm_recv_frame
Date: Tue, 19 May 2026 14:48:21 -0400
Message-ID: <20260519184821.18925-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519042017.29564-1-meatuni001@gmail.com>
References: <20260519042017.29564-1-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rfcomm_recv_frame() casts skb->data to struct rfcomm_hdr * and
immediately dereferences hdr->addr and hdr->ctrl without first
validating that skb->len is large enough to hold the header. A
remote device can send a crafted short RFCOMM frame over L2CAP to
trigger an out-of-bounds read before any session state is checked.

The FCS trimming code that follows compounds the problem:

        skb->len--; skb->tail--;

If skb->len is already zero the decrement wraps to UINT_MAX, causing
skb_tail_pointer() to return a pointer far outside the skb and
producing a second out-of-bounds read when the FCS byte is consumed.

Replace the open-coded cast with skb_pull_data() which validates
skb->len against sizeof(*hdr) and advances skb->data atomically.
Save the original skb->data as frame_start before the pull so that
__check_fcs() receives the header bytes as required by the RFCOMM
FCS specification. Guard against a missing FCS byte with an explicit
skb->len < 1 check. Replace the unsafe skb->tail decrement and
skb_tail_pointer() call with a direct end-of-data index and skb_trim().

Note: SeungJu Cheon posted a related patch that adds equivalent
length checks inside the individual MCC sub-handlers
(rfcomm_recv_pn, rfcomm_recv_rpn, rfcomm_recv_rls, rfcomm_recv_msc,
rfcomm_recv_mcc). That fix and this one are complementary and
independent; neither subsumes the other.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>

---
v4:
 - Keep no-session comment and add blank line after header/len guard
v3:
 - Replace open-coded cast with skb_pull_data() per Luiz's review
 - Save frame_start before skb_pull_data(); pass it to __check_fcs()
   to preserve correct FCS validation over the header bytes
 - Replace skb->tail decrement with skb_trim() per Luiz's review
v2:
 - Fix GitLint B3: replace tab with spaces in commit body
 - Add Cc: stable@vger.kernel.org
---
 net/bluetooth/rfcomm/core.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index d11bd5337..e78ce11fa 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -1741,7 +1741,8 @@ static int rfcomm_recv_data(struct rfcomm_session *s, u8 dlci, int pf, struct sk
 static struct rfcomm_session *rfcomm_recv_frame(struct rfcomm_session *s,
 						struct sk_buff *skb)
 {
-	struct rfcomm_hdr *hdr = (void *) skb->data;
+	struct rfcomm_hdr *hdr;
+	u8 *frame_start;
 	u8 type, dlci, fcs;
 
 	if (!s) {
@@ -1750,14 +1751,21 @@ static struct rfcomm_session *rfcomm_recv_frame(struct rfcomm_session *s,
 		return s;
 	}
 
+	frame_start = skb->data;
+	hdr = skb_pull_data(skb, sizeof(*hdr));
+	if (!hdr || skb->len < 1) {
+		kfree_skb(skb);
+		return s;
+	}
+
 	dlci = __get_dlci(hdr->addr);
 	type = __get_type(hdr->ctrl);
 
 	/* Trim FCS */
-	skb->len--; skb->tail--;
-	fcs = *(u8 *)skb_tail_pointer(skb);
+	fcs = skb->data[skb->len - 1];
+	skb_trim(skb, skb->len - 1);
 
-	if (__check_fcs(skb->data, type, fcs)) {
+	if (__check_fcs(frame_start, type, fcs)) {
 		BT_ERR("bad checksum in packet");
 		kfree_skb(skb);
 		return s;
-- 
2.54.0

