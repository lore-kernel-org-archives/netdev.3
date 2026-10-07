Received: from 20.mo582.mail-out.ovh.net (20.mo582.mail-out.ovh.net [178.32.124.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44484963A2
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 14:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.32.124.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791381982; cv=none; b=u85rRaPCvZ0VjZ7W1013Yh/9jstd7g25mKajGdlH0JTmYOvuFfZQq4GLBZo0IwITqfOmSR8RsBW/y1bKN+YtygCroWOGI8Ch+x0smKeESeKyq9Yk0xh3uiIn9RqM7mZCQ3m5RMNeUZIQ90/OsdTtt5hB11E7X63QebNoQSTrgIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791381982; c=relaxed/simple;
	bh=8XVo3VXJbaP35ZiQot+7BNw7O8XKthfb7HoGm02RZv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A44JUtIYspCX6gf4xTDikc18oRNWVmmDGIJu/N9Z8bW4AE4FTBGBAfXxRnGzleoc6LEiiy3iX0zPomgnY+XktX7YcA7tfFZEh2CKVLTSGO3K57/0dNYuw58k08vPMfsz/+D95dQ5TzMvYSgCBBu0lI9S/uXFRxxgkMp4BWGXGTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=armadeus.com; spf=pass smtp.mailfrom=armadeus.com; dkim=pass (2048-bit key) header.d=armadeus.com header.i=@armadeus.com header.b=M2aa7kAN; arc=none smtp.client-ip=178.32.124.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=armadeus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=armadeus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armadeus.com header.i=@armadeus.com header.b="M2aa7kAN"
Received: from director6.ghost.mail-out.ovh.net (unknown [10.110.43.105])
	by mo582.mail-out.ovh.net (Postfix) with ESMTP id 4j05LH6fpZz5vSK
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 08:06:31 +0000 (UTC)
Received: from ghost-submission-c7b579475-2zl45 (unknown [10.111.174.233])
	by director6.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 80E8D80198;
	Wed,  7 Oct 2026 08:06:31 +0000 (UTC)
Received: from armadeus.com ([37.59.142.98])
	by ghost-submission-c7b579475-2zl45 with ESMTPSA
	id bU/oEYf9xWq3ZiMAH+Tg5w
	(envelope-from <sebastien.royen@armadeus.com>); Wed, 07 Oct 2026 08:06:31 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-98R002ece8b947-55b7-42b0-bff4-44bc33981532,
                    B32B15828624AAAA34B98E078BA586767154A32B) smtp.auth=sebastien.royen@armadeus.com
X-OVh-ClientIp:92.148.202.163
From: Sebastien Royen <sebastien.royen@armadeus.com>
To: Woojung Huh <woojung.huh@microchip.com>
Cc: netdev@vger.kernel.org,
	Sebastien Royen <sebastien.royen@armadeus.com>,
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net v2] net: dsa: microchip: fix KSZ8765 fiber detection
Date: Wed,  7 Oct 2026 10:05:57 +0200
Message-ID: <20261007080557.15719-1-sebastien.royen@armadeus.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261006130006.134847-1-sebastien.royen@armadeus.com>
References: <20261006130006.134847-1-sebastien.royen@armadeus.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 18268570415425860653
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFDu9TABPtyXTS8+YKNCM1mivulsw9CC6edfSfRX6AlAt5+Xzc+UxjT1EAyVUv3On1PS01YVyixGm4fZ4Y6T/4E8pw+SuiPGQlcihzQoq1TAK+r++XMqXe+OdLRsClEZ+K/33BGDtIYa4//sBduXwsLzcyTCLtrPB2ls5047OPUPtmX1Crfff7iDe/sjUsFlxTwCwwellYYVFb6IfC2l++/p+cI+vmQsPFoty0NxaiwVwEYbVlFN/3WjkQJJGsDUzXegz+B5IvLoPloKGGEkCv64lc0nP5Oy5yZ/cUSqWb2zikFrZDpWuYhcpT2Pr5XLy6p5lsGDOoGrCuJugqlcNMcPYbgW/t+TXWErRzWXmbEJDK3l9mIIikuSgoeRArVSBa0YfU5OF7o6Bwr4RcPEEeENYIa15C5yWFSOsgcSD9z8nt4upfEJEu+2w4tiWtncX5x0S2w4vLYCs5qyk8kjt3bsjPErRhsslNxTzulw2ju04MLcEBYddoQigV04ahS52QX9ZhAIoQ46TXGMmgc4Ny6YBugAlERBzl6xy/KwD8o80LTiYryWyJCAjGgFehL0Rp6BgwMvJziobkcZ8IIgbl2FU14d5er8AQiBPFqT8IAH+jhh++eYeu0eScnY5GT0718OZNpzs5W6C162bkiBH7XgX+lQ4pyj6z2bPFFPb/kmw
DKIM-Signature: a=rsa-sha256; bh=sGqNB2rokEDSrK3dTsTsfFSD4B4auDXZuioQ0K6jETA=;
 c=relaxed/relaxed; d=armadeus.com; h=From; s=ovhmo103079-selector1;
 t=1791360391; v=1;
 b=M2aa7kANY6di+QKdK3aLFGAYzEhEg5myPL2TwbSp3CSNByZyUfN/hYEHJxWQQ+T83ASBpSU2
 wQn2Ijsg5krf4koEAQvL9SIHIgjerwmCV/MRWRjeDiz/n7Af5jwVoxDs0wz0VngWJbDm3JTOTxZ
 IX28f5eF3jc9R3AnDvDoGwX6F+tZ838etPco5h57qXN/fvHn6kRuedgQQrBOnEq/b4T1f+jtzY1
 T+d5fgKXMI1LyxaOlbPDX5AWl8+2N30+9uUbYteL4G6wk+JvkDvSQd7Oa9FvAbszzBlHwjekKlx
 1k9NXWs7F//zOl0bLaFfZQoj5HrjuiPc6o2QXHRIQyTHQ==

The KSZ8765 is similar to the KSZ8795 but has two fiber ports.

KSZ8_PORT_STATUS_0 is used to detect fiber mode. It is currently
defined as 0x08, which is the Global Control 6 MIB Control register
and has bit 7 defined as Flush Counter.

Set KSZ8_PORT_STATUS_0 to 0x18, which is the Port 1 Status 0 register
where bit 7 is the Fiber Mode bit.

Fixes: 91a98917a883 ("net: dsa: microchip: move switch chip_id detection to ksz_common")
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Signed-off-by: Sebastien Royen <sebastien.royen@armadeus.com>
---
 drivers/net/dsa/microchip/ksz_common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index cbe98494578c..f6104f714a8d 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -853,7 +853,7 @@ static inline bool ksz_is_sgmii_port(struct ksz_device *dev, int port)
 #define KSZ88_FAMILY_ID			0x88
 #define KSZ8895_FAMILY_ID		0x95
 
-#define KSZ8_PORT_STATUS_0		0x08
+#define KSZ8_PORT_STATUS_0		0x18
 #define KSZ8_PORT_FIBER_MODE		BIT(7)
 
 #define SW_CHIP_ID_M			GENMASK(7, 4)
-- 
2.43.0

