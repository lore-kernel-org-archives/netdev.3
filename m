Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675D037AA61;
	Thu,  5 Mar 2026 11:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772709065; cv=none; b=hw3+aai2MUQZLH1AujH3j1h8DDX9Ikp/dthoICv1KrO3ydwQ5514lgMMJ5k+09LKRm/9AehiQa1/OEU90Zd4YZAvU6aflkG+X40H9dcctLgtYUSm/glFBhUyiRfeeTWez05dK/hrJsaj3ze0qhTLTLB6kfOM1AMM3C9Av5liWyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772709065; c=relaxed/simple;
	bh=5RY/r4RCsZ9s55nHJ9uCkyMOfP2sbLfPKJgqn+zReeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sHFc5gjhtyfEKtrkF2OWBy+z2h9vY8Yx0W1C2oxwE0hJs+f+B626pcIRFSn3+dxbshu/9bbuddnu170uUT4fChtF9KUYgCfYInqZ7xXkjshF/RVbGck4tSzt440h/IEy7VxIywKPAPEdYcsLH7anG28/X7jm0eqYVILtzITvZ6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fAC1KDy+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAC1KDy+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 144DAC2BC9E;
	Thu,  5 Mar 2026 11:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772709065;
	bh=5RY/r4RCsZ9s55nHJ9uCkyMOfP2sbLfPKJgqn+zReeA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fAC1KDy+mbT9/Fv3tIyRP1mj1bAbhfYm59ysfXkiD6tl17SbUEDA3ozQsYbCVAdvl
	 /POzviJ/PzOy1mF+h0HNpVSa3RhndEmaUPKtq72em6NjOia5LAOOjshZf8ugy2DJL0
	 YTTuUlRxbA63MjYCUr937UEzR2LndgwXthbzxJYUiChR47avpxmFLDeG+4K19mDcYI
	 UdpqxnztZLKdcd3J4ySYAwe6QmtWCACNB+8jKNHZ7ErwZ36gOIDuGljpR4BayvbMK5
	 1pSs2DFT2NRkmmU1+Vg4pAB5IRXfGULsAqMS5xEzFJc6+4oainncMsr4fA3ZQey9wp
	 86nsHDb2WcyeQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vy6be-000000004hd-3d2D;
	Thu, 05 Mar 2026 12:11:02 +0100
From: Johan Hovold <johan@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 1/2] nfc: pn533: drop redundant device reference
Date: Thu,  5 Mar 2026 12:10:18 +0100
Message-ID: <20260305111019.18030-2-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260305111019.18030-1-johan@kernel.org>
References: <20260305111019.18030-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Driver core holds a reference to the USB interface and its parent USB
device while the interface is bound to a driver and there is no need to
take additional references unless the structures are needed after
disconnect.

Drop the redundant device reference to reduce cargo culting, make it
easier to spot drivers where an extra reference is needed, and reduce
the risk of memory leaks when drivers fail to release it.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/nfc/pn533/usb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nfc/pn533/usb.c b/drivers/nfc/pn533/usb.c
index 0f12f86ebb02..0ff2f0d7caf4 100644
--- a/drivers/nfc/pn533/usb.c
+++ b/drivers/nfc/pn533/usb.c
@@ -500,7 +500,7 @@ static int pn533_usb_probe(struct usb_interface *interface,
 	if (!in_buf)
 		return -ENOMEM;
 
-	phy->udev = usb_get_dev(interface_to_usbdev(interface));
+	phy->udev = interface_to_usbdev(interface);
 	phy->interface = interface;
 
 	iface_desc = interface->cur_altsetting;
@@ -600,7 +600,6 @@ static int pn533_usb_probe(struct usb_interface *interface,
 	usb_free_urb(phy->in_urb);
 	usb_free_urb(phy->out_urb);
 	usb_free_urb(phy->ack_urb);
-	usb_put_dev(phy->udev);
 	kfree(in_buf);
 	kfree(phy->ack_buffer);
 
@@ -628,7 +627,6 @@ static void pn533_usb_disconnect(struct usb_interface *interface)
 	usb_free_urb(phy->out_urb);
 	usb_free_urb(phy->ack_urb);
 	kfree(phy->ack_buffer);
-	usb_put_dev(phy->udev);
 
 	nfc_info(&interface->dev, "NXP PN533 NFC device disconnected\n");
 }
-- 
2.52.0

