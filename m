Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03FE361DBF;
	Mon, 23 Feb 2026 11:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771846412; cv=none; b=FBkPSWrt3iKNi6SODziibvz5P0VKcfLJnNIXiD9RmFTp5Ws1Rp5WYpcctTZux8YoHwEgs7v3hgEbwXFkzfXQHXyzPPCkRcZd6MILxBozUGYt2OZM0mJW8IJwvrzNlQg4C8mJ09sdzxU5Jg9rMorc3SOyuePVNwCC3HLLj4oy9VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771846412; c=relaxed/simple;
	bh=U+UlFoMSZ7je+gYxQXUTxIPqvWZ92YEu86tieN3JurQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S+f/CjwZeOoO08f0OEsra6fNbe7wrl0o9ZZH6KVsdFTUUf2+qDtYEtXPViE3EmfrqUEF3NP+PdjB2uJkhp57wJaSXJxehWey5uLY38ZTt8ARAXRtlkP17be6uQ+332UttuzlQwYtfU9c3a9uXrdyfrhINerUogBmK0EB46LyTMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ljOcsLMh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ljOcsLMh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B3C0C116C6;
	Mon, 23 Feb 2026 11:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771846411;
	bh=U+UlFoMSZ7je+gYxQXUTxIPqvWZ92YEu86tieN3JurQ=;
	h=From:To:Cc:Subject:Date:From;
	b=ljOcsLMhZU5OymfzZqAl2DddPF0El+LMOGrrguLAMtOvPOuhd1Nvgm70kR4lqa0Ex
	 7NsChBAJXzRI7wTK4APCn3x8zpHenC4jZNPV2BLt2y709dcdfQZL48zfDIFx7zqr4v
	 78LPjVtFIwbmeGnDg6YNfETKSeNk9UaWkB6/yjnM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	stable <stable@kernel.org>
Subject: [PATCH net] net: mctp: usb: properly drop the usb interface on probe error
Date: Mon, 23 Feb 2026 12:33:19 +0100
Message-ID: <2026022319-turbofan-darkened-206d@gregkh>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=872; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=U+UlFoMSZ7je+gYxQXUTxIPqvWZ92YEu86tieN3JurQ=; b=owGbwMvMwCRo6H6F97bub03G02pJDJlzrP67PPQUE03nPbH98E+VFf1zUp9wzDe+9Dtj5pt5X 099Ez1T0RHLwiDIxCArpsjyZRvP0f0VhxS9DG1Pw8xhZQIZwsDFKQATkTZlmKd86En2jdaryn12 pmtkbbTT3t6On8Ww4Kq4420T1pu7jdcmsv86bhP96mGXEgA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

When an error happens in mctp_usb_probe() the reference count on the usb
interface structure needs to be properly dropped as it was incremented
earlier in the function.

Cc: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: Matt Johnston <matt@codeconstruct.com.au>
Cc: stable <stable@kernel.org>
Assisted-by: gkh_clanker_2000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/mctp/mctp-usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/mctp/mctp-usb.c b/drivers/net/mctp/mctp-usb.c
index ef860cfc629f..eef17ae89298 100644
--- a/drivers/net/mctp/mctp-usb.c
+++ b/drivers/net/mctp/mctp-usb.c
@@ -355,6 +355,7 @@ static int mctp_usb_probe(struct usb_interface *intf,
 	usb_free_urb(dev->tx_urb);
 	usb_free_urb(dev->rx_urb);
 	free_netdev(netdev);
+	usb_put_dev(dev->usbdev);
 	return rc;
 }
 
-- 
2.53.0

