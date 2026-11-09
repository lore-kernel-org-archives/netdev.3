Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794194317;
	b=Bfv/XCky4GhHhhte//Z1I+xHLYPyZbe/PUJJIqAXUTJpr0r5swUy3mHXsMECwUKfk4lM
	 EwTwyC0f079YVuaNZHPsxQVwLUQPqy07WlVj2yu1fkXmANZFI+aglj/e5C1F55G4uh6FO
	 hKpn3eAli3StIVswBzsj+kvllAiVkhqWSoqF2DlWxIQPiKSTReG7c1wD2lP92MgPj+jgI
	 P6cSocOXAO7l+KowECRg5+zZNF3640Vo/I+t5X+EiAUeJW7aUCTqUdaAzEzn1FGV0TnWv
	 pij4YoKLNUfjnkg8fKY3OCUukEFkyX4kWCRBbF+XgFUsFJCQr80yI1huEFf87x5VZ5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794194317;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=B2/G4e6cQEPEp/1S6diOduUyv1Y7Tt120AqNMXCf9rs=;
	b=BQIHcvOR8aTGSghH8f8GNUCTlD8kd18Netss/MALlEjRzERgeOzouseI9/iV9R9E+TmC
	 OmSJ25rgqDy49IXVO2oYejYvdbP+NzmU9WMPRVom4voWT0HST9qjYrNZEf97lhDHt7p0L
	 GAOAUL3UNAj4Ll86KIIzMl/5vwNyUn0xbgLzOHTssiqzAaL9YCAJ1EUv85L7IKdCDoMDr
	 LtQi7dGAGj841FCx7FCSGqZtUBPkU1CwaLyUz5IxUwn40HXaXEG4NYmhvKYbhCXopLOPA
	 Q5cwEqEX02TlSJ/gTFx2/onhzPpMMTpa2DPHoFkSeGUSvns7agWNOaVXr0W/FgSPh0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=oLQsMsQf;
	arc=none smtp.remote-ip=111.22.67.137
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B89606A323;
	Mon,  9 Nov 2026 03:18:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9B89606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=oLQsMsQf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=oLQsMsQfTmQ9ALgXqG41DbOBy1tORDEqNQu6msD4mTQsp1zV3MBrs4w5wtnyMLNJRuGaedyTbG/zU
	 rHjfBTOUgg4CzkvcwWB8CIaDvbqAbrNCiGx33E1FwpR/V+8epErZEaHaC1YKuy77UYi9iKW3WT72Ya
	 ToVdiwOf/fUARHsw=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee46af13b8aefb-5fc95;
	Mon, 09 Nov 2026 11:18:34 +0800 (CST)
X-RM-TRANSID:2ee46af13b8aefb-5fc95
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from [198.18.0.73] (unknown[223.108.79.102])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee56af13b884a9-7f23d;
	Mon, 09 Nov 2026 11:18:33 +0800 (CST)
X-RM-TRANSID:2ee56af13b884a9-7f23d
From: Xia Yan <yanxia@cmss.chinamobile.com>
To: netdev@vger.kernel.org,
    oe-linux-nfc@lists.linux.dev
Cc: David Heidelberg <david@ixit.cz>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@kernel.org>,
    Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>,
    Simon Horman <horms@kernel.org>,
    Thierry Escande <thierry.escande@linux.intel.com>,
    Samuel Ortiz <sameo@linux.intel.com>,
    Samuel Ortiz <sameo@rivosinc.com>,
    linux-kernel@vger.kernel.org,
    yana06070@163.com
Subject: [PATCH net-next] NFC: digital: fix target leak after Type 1 Tag discovery
Date: Mon, 09 Nov 2026 03:18:32 +0000
Message-ID: <20261109031832.37642-1-yanxia@cmss.chinamobile.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

digital_in_recv_sens_res() allocates a target for an NFC-A response.
For a Type 1 Tag, it calls digital_target_found() synchronously.
nfc_targets_found() copies the target into dev->targets.

On success, rc is zero and the callback skips kfree(target).
The original allocation is lost when the callback returns.
Each completed Type 1 Tag discovery leaks one struct nfc_target.

Free the target after digital_target_found() returns. Clear the pointer
to avoid freeing it again on the error path. Keep the target for other
tag types, whose discovery continues asynchronously.

Found during a code review of NFC-A target ownership.

Fixes: 2c66daecc409 ("NFC Digital: Add NFC-A technology support")
Signed-off-by: Xia Yan <yanxia@cmss.chinamobile.com>
---
 net/nfc/digital_technology.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/nfc/digital_technology.c b/net/nfc/digital_technology.c
index ae6487c10a25..2d52e390cc67 100644
--- a/net/nfc/digital_technology.c
+++ b/net/nfc/digital_technology.c
@@ -510,10 +510,13 @@ static void digital_in_recv_sens_res(struct nfc_digital_dev *ddev, void *arg,
 		goto exit;
 	}
 
-	if (DIGITAL_SENS_RES_IS_T1T(target->sens_res))
+	if (DIGITAL_SENS_RES_IS_T1T(target->sens_res)) {
 		rc = digital_target_found(ddev, target, NFC_PROTO_JEWEL);
-	else
+		kfree(target);
+		target = NULL;
+	} else {
 		rc = digital_in_send_sdd_req(ddev, target);
+	}
 
 exit:
 	dev_kfree_skb(resp);


