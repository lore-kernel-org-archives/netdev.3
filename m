Received: from acj35aaf123.lhr1.oracleemaildelivery.com (acj35aaf123.lhr1.oracleemaildelivery.com [130.35.116.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A576530674B
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 13:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.35.116.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778850533; cv=none; b=VubqHCSw0BTi0RUM02MnfWYnBbofs8iQPJ3WHxXt/br676FinZQj2s4L8Pzz0NA1qAHgGRPH76sssiIx4UX3m6p+Ykwq0MWfSfCKCjr9zD35jzn/7PF9f/BY2tVadEcQopUpUEMilb/eH3Z5L4W19UOc+DV1R5aRSedvZqAyIqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778850533; c=relaxed/simple;
	bh=fhyHfyW5NgKKHtnkNTA8/XP0rmI/Np861eMFIdMbxAE=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version:Content-type; b=oUDWY3FB/xDWoX3Xq3OGvYl6OsYlGPTeVmXE/gMgKxMaSFpToTcuzsuy5jkPyrXnsSmDo8pySrKUgLRMqlv5ql9RU/yXhhCE1G7MdOYfORNw9WObJbpIY7G7gKiXDKPuzSoyLujjNSYiDJ2WFmi7Fhg7jbafjOf6Fhj4KjTHlDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raczylo.com; spf=pass smtp.mailfrom=lhr1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=raczylo.com header.i=@raczylo.com header.b=ZK96z2wW; dkim=pass (2048-bit key) header.d=lhr1.rp.oracleemaildelivery.com header.i=@lhr1.rp.oracleemaildelivery.com header.b=FUnauE+I; arc=none smtp.client-ip=130.35.116.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raczylo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lhr1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raczylo.com header.i=@raczylo.com header.b="ZK96z2wW";
	dkim=pass (2048-bit key) header.d=lhr1.rp.oracleemaildelivery.com header.i=@lhr1.rp.oracleemaildelivery.com header.b="FUnauE+I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=oracle-uk-012026;
 d=raczylo.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=WmCkvmN6o6bO9QADm6W/QC4PRSk13s/99dA2BWd17CM=;
 b=ZK96z2wWLtcgsms7cW9HgLYLPhYwqbfZ+L4Hox6lZXc3uYpGVv49ni1N0aVVJGKJd1ivE6DTLJHE
   fWX/GsYz8GsC7FYU6V6RaDivdQt6/rf+Q6V638tYsVcOnue9m84od18porbpCMnLo2EsKTtdTdxp
   phGyEFsnhyj6LSHA4z0j58MiFKqDhh200Lpk04vZpyVkIqzA1wqnBV0C3QOwxutYEr8WBRr8eWKT
   Z93b0R6BymLoA3UCssj3HHL3+OQwmQOiFhc+ycUWsl8fOJDWlMi9h/Vk1GZSjNlRJZnzSeO1b52q
   ApQMdJOQsNaS9qnyIpy6l/9tSe9ReiWrWRKqBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-lhr-20191104;
 d=lhr1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=WmCkvmN6o6bO9QADm6W/QC4PRSk13s/99dA2BWd17CM=;
 b=FUnauE+IcHzKNv1NWpI3gInAWC307+jB9iEcl4VeNd0BwkCtzeD5MVjd3kccUG9yuS1CY527t8G1
   IWAF0bNABu1BOTyLuFCQj8XPRmpqqxroLurzuWe0x64/bC5QjsdtluWKguE9KXwTBWtNJR1jgYYo
   GoNoOc+misW24uEoLxUPJJdGxBI5C5TjLYpuOT6K4HgtJCkJxtSfHhe7vpiGOf/aaX1LsIt3l5eT
   rwJVWdG/KkW+ZxFx619oqMyGXpmI1eHy479vi14IjNnRsBQACzl/gbxeHap0aDJfRjZmu6tctsph
   aBLd4LvdSycPpV+VX4m+QoeYQE7RMf2B/HpPSw==
Received: by omta-ad2-fd1-1401-uk-london-1.omtaad2.vcndplhr.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20260212 64bit (built Feb 12
 2026))
 with ESMTPS id <0TF21VYGOXUQAXA0@omta-ad2-fd1-1401-uk-london-1.omtaad2.vcndplhr.oraclevcn.com> for
 netdev@vger.kernel.org; Fri, 15 May 2026 13:08:50 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Lukasz Raczylo <lukasz@raczylo.com>
To: netdev@vger.kernel.org
Cc: Theo Lebrun <theo.lebrun@bootlin.com>,
	Andrea della Porta <andrea.porta@suse.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,	linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v2 3/3] net: macb: add TX stall watchdog to
 recover from lost TCOMP interrupts
Date: Fri, 15 May 2026 14:08:49 +0100
Message-id: <20260515130849.920-1-lukasz@raczylo.com>
X-Mailer: git-send-email 2.54.0
In-reply-to: <20260514215459.36109-4-lukasz@raczylo.com>
References: <20260514215459.36109-1-lukasz@raczylo.com>
 <20260514215459.36109-4-lukasz@raczylo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAFF3HPCkK227CD7Se5cCyOO/blLikgODObmwE6SfhbsjUFD20BWLFJliQfsfrvY
 BFb1EX9GcB+16PC4cMFuM4XkUsoI59cMbEc0dTguTmLh8AztN1yrID+AhpyrA/6E
 oPw85TvWYEiAfAkoBNIvtKaV7qx0LP+FR8DKM1j0BK1QpthmUcjS4BDqu3rjixHj
 J1Z6d3jrYjIqUkOFqmOhWHv/562DrGjmqiLO5+29OxYrL3hVQOkFxFRt/w8cDfWH
 CYtJjeNaD01vIzwy0bxLZWFpkmwjnFbf3EsKdqpQfiqzWkdkNRAuuokBLC+MwCoC
 56xJY+PEVnOzRE10ZDMLFJBRtYVz6FORJJKr53YcmZTs72zpl+6liOBNR39QAIcq
 Ns6rjggMJiaEukv73k3q/SdikVn2X2QeM01k+fuBG3rYJVnyjlUKySv7o0c/nj8=

self NACK

This patch references netdev_warn_ratelimited(), which does not exist
in mainline net-next or in raspberrypi/linux rpi-6.18.y -- no
netdev_*_ratelimited() helper is defined.  I confused it with the
existing net_warn_ratelimited() / pr_warn_ratelimited() /
dev_warn_ratelimited() family while authoring v2.  The result fails
to build with implicit-function-declaration on every kernel that
includes <linux/netdevice.h>.

The bug was caught by John Laur via an independent build test on the
Talos Linux Pi 5 build and reported at:

  https://github.com/siderolabs/sbc-raspberrypi/issues/91#issuecomment-4456874307

I incorrectly tried to address this by sending a standalone fix-up
patch to netdev as:

  https://lore.kernel.org/netdev/20260515095336.92237-1-lukasz@raczylo.com/T/

Andrew Lunn pointed out that this is not the correct workflow on
netdev -- the right thing to do is self-NACK the broken patch on the
original thread, wait 24 hours, and resend the whole series as v3.
Apologies for the noise; this reply is that self-NACK.

Patches 1/3 and 2/3 do not reference netdev_warn_ratelimited() and
are unaffected by this build break; their content stands.  In v3:

  * 3/3 will use `if (printk_ratelimit()) netdev_warn(...)` in place
    of the non-existent netdev_warn_ratelimited(), matching the
    semantics intended in v2 (bounded log noise, retains the netdev
    prefix in the message).
  * The standalone fix-up patch above (Message-ID
    <20260515095336.92237-1-lukasz@raczylo.com>) should be considered
    withdrawn -- v3 supersedes it.
  * Cover letter will carry a changelog noting the v2->v3 delta and
    this self-NACK.

I will send v3 no earlier than 24 hours from this message, per
Andrew's guidance and standard netdev practice.

Signed-off-by: Lukasz Raczylo <lukasz@raczylo.com>
