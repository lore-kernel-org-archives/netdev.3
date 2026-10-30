Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793328010;
	b=QpM2RaQFAbeYKevjFTG05CSpHLVeb+nC4/7SoC3v9+JgEw7Jje/coUHlHBFEw7P4xq2l
	 ErKd1Ldp+mEqnxQUC1HD9EtetXHdcNF/JzNh1IhzqMQtOqIooUgV6ed12qYTD4Abmyt0j
	 yJhV8aUTYROg4qjB1CE++j55HkyO/m37zS2NqllXpVFwuJ2HrTEN54TyA1TJ6czq8dsOn
	 zhzCam07uaoJSPwj/hM77Ryt2FwJS+EMYTNZF9sekaXeBzPGnCly4JTsQLS+SS3tis9E0
	 Z1IPyQVdNeDjBQhoOCSyBO4WL6O0Q5cAJS8kdyzSc2odL+2A1mH/rNmwaGil9MH/oZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793328010;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=YSAh+y1tZ3U19Rc97yZ2/Ifnxo6JWkQYI8MOkedjj2I=;
	b=QtnsTQ6qT5SsFxu03myzASo9Mj+Q1ZdIizpx1wELGJ2gXxz6fqjUbd9W4HPsddzmhlwL
	 u8gp7suhZrGMr2b9z6cy65xEYQ7Mbl+H4gGVt+4WZVGNwgAb8fblWu/vYEzoypcShHwF0
	 TDAtyIiVm8NEzTO7DcRcSZKr7Vu9s//GyiY2mxzEJUW5c8FvBuu1J2I+j+ErWi1iFHpDf
	 eqc862XxlO3Q7RJFsp0VpdRzgemmiz/6GEAsNF12i3JvBkrkMLWXJgAfCLAd/p8qSAbSL
	 s/YqkXRG8aZG4fh31Kkae5LclGuwRqXs4QDzI9sZJQ3Ms/kN0yGvjXnUn8Ql8IG+hzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U5MbUX9R;
	arc=none smtp.remote-ip=209.85.221.174
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86783606A31D
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 02:40:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86783606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U5MbUX9R
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5ec690faf85so83471e0c.0
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 19:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793328009; x=1793932809; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YSAh+y1tZ3U19Rc97yZ2/Ifnxo6JWkQYI8MOkedjj2I=;
        b=U5MbUX9RhTMavnColAP3lfJm4DLBU/va00boE654w4KsCKHYF9mOCar0j6U6c2nj5D
         YAEoP9o/Qyz1vOcRjNWQweKGCPCzaqSYkT894bv1xFIkfOTc+GFNj+ChNYatPJMVtU1C
         Uv+4gov1Yi6757H7wlMMuiGeNMyjzCjICuuHBQ3AX6pHx+0mumwjMiskSii6eflVIdXh
         6UibHggjHYA+U2wESaxbMQNyR69xBfWawi4ktDujjVoEhLOK3ar6kXP39fdGZLVt5Gw3
         iCh+qdby1o6OZYLrhUj+YtQTba3Z0ANX5mND6Xu/8JNnUWvRD/zLFAiEJCboS131id3Z
         phRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793328009; x=1793932809;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YSAh+y1tZ3U19Rc97yZ2/Ifnxo6JWkQYI8MOkedjj2I=;
        b=1QoHW6YFCpprh821/Nl4ErX5Wre4ZUl0DCvuzzl1CwG6SYFNyRhS9zz3kwPxLDlONl
         TBlARWHLojwlfBj7/FkwI0Al7kZw8dMmKTL4waHYYs4v1WGo2qru9GTOuJhHO38kmXmT
         LSk2IF0my+fN/Kr3YK71jcx8DlHErwOCvniMrUBsd1lP8i1DT8+vMUpVsCkvsGE54egX
         D5gBKw7s1hM2K4rpzywtmrq9eHckSF8PpynuBcLVBjKmNwiqSfMpJBuK0juQZ7+08QrD
         Q6+1mJm/PLz95OHlg1/4xj+y31ucOEdCOqnO4wfCSHX/BW21VEApGCL9uK98hfjr8p2u
         tYdA==
X-Forwarded-Encrypted: i=1; AKwUvBxI2K9aDTn6iYRKD/iZWlYn06dbaRXWMzA3hJ4aTZHOW5S+/FSUgg/fA4YJf7zXq2StV/+gorA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJW4zCtf0slv8FrLpAoJ6Z8ujqnsDeyRUQZG3RxxBeqC+zOLczl
	RRLvXXes/I3drWWwSqo+dGNJ4HcB1tFIgNMDXkzxUki4+lVZNHnWb97GVVAJ7ZKe
X-Gm-Gg: AYBFou1NBD7w3EFiqHf6pZAwovUosLoVmVAeiSkOtQMH9K0JQ3zaL1NkgmCWS4fBksT
	dSO7s8nVfMqfwY/Q8DyePOPXHXwetKlMRO4+iCsr5TLdpE2Y9WCoPez/WINXkOwelmMWmAEo+eW
	LLvHEcPVHqMDb0sDBavILktl8HaemP9uD4DXBH1yj+lpalUxlEWvUWfqkC2UX6sKD2UCZGryJOp
	xXWqXgQ5LvwC751rG3mhsZanDlytw9yoVjOzW0YpsNpS7U+L5tuJidzPIx2WaztRkNpFCxOV7o1
	rMe+z6MrbU/UNiYHcw93PHBcLSPW6Mk+0Lu+Ahh5RCBM/+pG9LDFOPy0wf8sp8XYKdkZjIeKvQj
	1GfQrJannO7W4E0fa4HMSqz16NqwLlhz/aFjEwI/wqqAydxzoMrGcQvLFClsKITj+zpYnBRh9YB
	QJBcIZpMNlMwDBNz6ucUB6EKjhWFfLsiUmBVDNM79al6K1tp2Y3I1Wt/5OpfCeH8362sIl8Kmse
	zmyVu4NRueGB/qR6m0Xskm6O18a2PGFqQewR2zuuYFmfxQVfjm/JnpbIaK8bKMrvAOx7sbcqM5N
	+DncaURaqzaCp+AkPuRNJlmc9BmksOzGvMq0zUZPxeU1W3NaUSRMsQRvnppesygj0YfT0jRfcsp
	LTOLKF0QdGntxYkak7rsoMfBjOtq9
X-Received: by 2002:a05:6122:1b0c:b0:5c9:a60b:e5c8 with SMTP id 71dfb90a1353d-5ec6893b14cmr559247e0c.11.1793328009288;
        Thu, 29 Oct 2026 19:40:09 -0700 (PDT)
Received: from macbook-pro-de-joas.local ([2804:7f0:b101:c5e8:ccdf:2b09:f69e:4902])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec69c5d183sm963735e0c.13.2026.10.29.19.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 19:40:08 -0700 (PDT)
From: Joas Antonio dos Santos <joasantonio108@gmail.com>
To: David Heidelberg <david@ixit.cz>
Cc: David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Fan Wu <fanwu01@zju.edu.cn>,
 oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 [PATCH net] nfc: st21nfca: complete a pending SE APDU request only once
Date: Thu, 29 Oct 2026 23:40:02 -0300
Message-ID: <179332800288.52644.8728400883396719965@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

st21nfca_hci_se_io() stores the netlink callback and its context in
info->se_info and arms the BWI timer.  The request is then completed
either by st21nfca_se_wt_work(), when the timer expires, or by an
EVT_TRANSMIT_DATA event on the APDU reader gate.  Neither checks that a
request is still pending, and the callback, se_io_cb(), frees its
context every time it is called.

So when the secure element answers after the timeout, the response
calls se_io_cb() again on the context the timeout already freed, and
frees it a second time.  The same happens if the controller sends two
EVT_TRANSMIT_DATA events for one request.  An EVT_TRANSMIT_DATA, or a
timer armed by EVT_WTX_REQUEST, with no request pending calls the
callback on the context of an earlier, already completed request, or
calls a NULL callback if there never was one.

With st21nfca on a virtual phy and an emulated controller answering an
NFC_CMD_SE_IO request 4 s after it was sent (the default timeout is
3.2 s):

  BUG: KASAN: slab-use-after-free in se_io_cb+0x2ec/0x334
  Read of size 4 at addr fff00000c5277da0 by task kworker/3:1/59
  Workqueue: events nfc_hci_msg_rx_work
  Call trace:
   se_io_cb+0x2ec/0x334
   st21nfca_apdu_reader_event_received+0x1ec/0x248
   st21nfca_hci_event_received+0xb0/0x300
   nfc_hci_event_received+0xb8/0x30c
   ...
  Freed by task 59:
   kfree+0x214/0x498
   se_io_cb+0x2bc/0x334
   st21nfca_se_wt_work+0x14c/0x1d4

and for an EVT_TRANSMIT_DATA without a request:

  Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
  pc : 0x0
  lr : st21nfca_apdu_reader_event_received+0x1ec/0x248

Use bwi_active, which st21nfca_hci_se_io() sets, to tell whether a
request is pending, and clear it in whichever of the two paths
completes the request first.  The event handler already stops the timer
and waits for the timeout work before looking at it.  Also complete the
request with the error if sending EVT_SE_END_OF_APDU_TRANSFER fails
rather than never calling the callback, which leaked the context.

Fixes: 2130fb97fecf ("NFC: st21nfca: Adding support for secure element")
Cc: stable@vger.kernel.org
Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
Assisted-by: Yaga Agent HackerSec Claude:claude-opus-5-5
---
Tested on arm64 QEMU with KASAN, with a test-only module that registers
st21nfca through st21nfca_hci_probe() on a virtual phy (LLC nop) and a
userspace controller emulator (DEV_UP, ENABLE_SE, SE_IO over netlink).
Without the patch: slab-use-after-free in se_io_cb() for a late and for
a duplicated EVT_TRANSMIT_DATA, NULL pointer call for an unsolicited one.
With it all three are quiet and a normal SE_IO exchange still works.
Not tested on hardware.

st-nci has the same pattern; Fan Wu's pending "nfc: st-nci: drain SE
timers before NCI teardown" v2 already makes bwi_active an ownership
token there, so this only touches st21nfca.

 drivers/nfc/st21nfca/se.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/nfc/st21nfca/se.c b/drivers/nfc/st21nfca/se.c
index 7154bc1d6..4261ed1d9 100644
--- a/drivers/nfc/st21nfca/se.c
+++ b/drivers/nfc/st21nfca/se.c
@@ -264,6 +264,12 @@ static void st21nfca_se_wt_work(struct work_struct *work)
 						struct st21nfca_hci_info,
 						se_info.timeout_work);
 
+	/* The timer can also be armed by EVT_WTX_REQUEST while no
+	 * st21nfca_hci_se_io() is pending.
+	 */
+	if (!info->se_info.bwi_active)
+		return;
+
 	info->se_info.bwi_active = false;
 
 	if (!info->se_info.xch_error) {
@@ -383,11 +389,20 @@ int st21nfca_apdu_reader_event_received(struct nfc_hci_dev *hdev,
 	case ST21NFCA_EVT_TRANSMIT_DATA:
 		timer_delete_sync(&info->se_info.bwi_timer);
 		cancel_work_sync(&info->se_info.timeout_work);
+		/* Only complete a pending st21nfca_hci_se_io(), and only once:
+		 * the timeout work may already have completed it, and the
+		 * callback frees its context.
+		 */
+		if (!info->se_info.bwi_active)
+			break;
+
 		info->se_info.bwi_active = false;
 		r = nfc_hci_send_event(hdev, ST21NFCA_DEVICE_MGNT_GATE,
 				ST21NFCA_EVT_SE_END_OF_APDU_TRANSFER, NULL, 0);
-		if (r < 0)
+		if (r < 0) {
+			info->se_info.cb(info->se_info.cb_context, NULL, 0, r);
 			goto exit;
+		}
 
 		info->se_info.cb(info->se_info.cb_context,
 			skb->data, skb->len, 0);
-- 
2.43.0

