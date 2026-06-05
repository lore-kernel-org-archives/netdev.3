Received: from eidolon.nox.tf (eidolon.nox.tf [185.142.180.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADED3B71B1
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 16:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780678390; cv=none; b=F94uySVSjXRqZqip5aI2h77m+hAmeGPgBAmMwXHokwFwwbIH+c/W/KlIyGrqfGzjBQNc8iQyHBl2J7UJ9DNcUmYycYa9aZv+CySzKLHo+KLRNM1+dII5ouF37LI4eFGbTlkI1uy/MGe+3Sut5bNL4PfnDIlfEUiXd1uCHY8HhhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780678390; c=relaxed/simple;
	bh=3YgQOYP4xXwMeX8FdVkgzOsBF/Im4M3INp1Vqgc7jck=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bydzoJy646LQwfmmaoSenTrZ5Sk8s+/iQj2C1a03nzOTHg7hCJ2n7VBnqn6zZkwp2fEBVRUBk6wOhVPe+KaR6pPjKJGXBESZbwsogaNYSBoxG8GpTnHRlpI7Fqane+9XNhwnEMc1Mk4wHgoWzvqsjItlYfOOfUlqB29hwGLpo5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=diac24.net; spf=pass smtp.mailfrom=diac24.net; arc=none smtp.client-ip=185.142.180.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=diac24.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=diac24.net
Received: from [2a0e:c5c1:0:101:92af:12c8:1e35:e3a8] (helo=alea)
	by eidolon.nox.tf with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <equinox@diac24.net>)
	id 1wVXi9-00000003x9n-0BRG;
	Fri, 05 Jun 2026 18:47:57 +0200
Received: from equinox by alea with local (Exim 4.99.2)
	(envelope-from <equinox@diac24.net>)
	id 1wVXcN-00000000L80-0ZWb;
	Fri, 05 Jun 2026 18:41:59 +0200
From: David 'equinox' Lamparter <equinox@diac24.net>
To: netdev@vger.kernel.org
Cc: David 'equinox' Lamparter <equinox@diac24.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH] if_ether.h: add 802.1AC, warn about GRE 0x00FE
Date: Fri,  5 Jun 2026 18:41:44 +0200
Message-ID: <20260605164144.81184-1-equinox@diac24.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Because LLC wasn't complicated/annoying enough, there's 2 more
"ethertypes" being used for it:

- 0x8870 is pretty "normal", it got standardized in
  802.1AC-2016/Cor1-2018 for transporting LLC frames > 1500 bytes.
  It simply replaces the length value (which is no longer encoded, and
  must now be derived from the packet.)  The actual value dates back to
  2001; https://datatracker.ietf.org/doc/html/draft-ietf-isis-ext-eth-01
  (it was used without "proper" standardization for a long time)

- 0x00fe is a doozy - actually "invalid" depending on how you look at
  it; it's used in GRE (and possibly GENEVE) tunnels to transport the
  IS-IS routing protocol.  https://seclists.org/tcpdump/2002/q4/61 is
  the best/oldest source I could find.  It's inspired by the 0xfe SAP
  value, a GRE packet with protocol 0x00fe is followed by a payload "as
  if" it was Ethernet with "<length> 0xfe 0xfe 0x03".  (Again the length
  isn't encoded explicitly anymore.)

The 0x00fe value is quite close to other values the kernel is using
internally for various things (after all they "won't clash for 1500
types").  Except this one does clash, and if someone unknowingly starts
using it for something internal... we end up in a world of pain in
getting IS-IS running on GRE tunnels.  Hence the "WARNING".

Signed-off-by: David 'equinox' Lamparter <equinox@diac24.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: David S. Miller <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
---
 include/uapi/linux/if_ether.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/uapi/linux/if_ether.h b/include/uapi/linux/if_ether.h
index fb5efc8e06cc..1ffac52c39df 100644
--- a/include/uapi/linux/if_ether.h
+++ b/include/uapi/linux/if_ether.h
@@ -82,6 +82,7 @@
 #define ETH_P_PPP_DISC	0x8863		/* PPPoE discovery messages     */
 #define ETH_P_PPP_SES	0x8864		/* PPPoE session messages	*/
 #define ETH_P_LINK_CTL	0x886c		/* HPNA, wlan link local tunnel */
+#define ETH_P_8021AC	0x8870		/* 802.1AC LLC > 1500 bytes     */
 #define ETH_P_ATMFATE	0x8884		/* Frame-based ATM Transport
 					 * over Ethernet
 					 */
@@ -164,6 +165,10 @@
 #define ETH_P_MCTP	0x00FA		/* Management component transport
 					 * protocol packets
 					 */
+#define ETH_P_GRE_OSI	0x00FE		/* GRE tunnels: LLC "fe fe 03" analog,
+					 * used primarily for IS-IS over GRE
+					 * WARNING: not internal, used on wire!
+					 */
 
 /*
  *	This is an Ethernet frame header.
-- 
2.53.0

