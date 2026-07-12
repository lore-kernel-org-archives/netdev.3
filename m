Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C476E33E367
	for <netdev@vger.kernel.org>; Sun, 12 Jul 2026 02:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783822427; cv=none; b=Qi+QDt7Iyo/NKOGArhXdcRLLjfPmLPzFM2HeCYaOTLLZa6JL7Oe+6w7Vrl5AH+Qxp5jWMQ7+mIoJuruw04mLhUP14CaWWJwgfIJXf7w39Q6sFPY+jGH7/3BCIkdTPn2OBcmXGyZw0SYhRfMrYRPf5nzsFhDt0LX6xctDFOGv4lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783822427; c=relaxed/simple;
	bh=h+R4TiK1wkOqZCjs6EVZzvzUcLoT+6vOrKkU78fIyfo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hxfWukYBhQ9MxQUxsnOcouHDkAKRMzHbKRVbdZ9zY2wvF4JcLfTjfDynrIvVWhxqXTpklNfkkuiGd29pB6B3fzOyLXCyJmPnJa86GWx+uClpNjf33G3aNSqz9TiZJeASpVeuXCUEpToEhFSaJ5F9YPQ4Mfq8MAIeGX4KagqQSzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; arc=none smtp.client-ip=160.80.4.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Received: from localhost.localdomain ([160.80.103.126])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 66C2DKlx015953;
	Sun, 12 Jul 2026 04:13:25 +0200
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Stefano Salsano <stefano.salsano@uniroma2.it>,
        Ahmed Abdelsalam <ahabdels@cisco.com>,
        Paolo Lungaroni <paolo.lungaroni@uniroma2.it>,
        Justin Iurman <justin.iurman@6wind.com>,
        Anthony Doeraene <anthony.doeraene@uclouvain.be>,
        Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: [PATCH iproute2-next 0/2] seg6: add support for lookup attribute in SRv6 encap routes
Date: Sun, 12 Jul 2026 04:11:53 +0200
Message-Id: <20260712021155.7621-1-andrea.mayer@uniroma2.it>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean

This series adds the optional "lookup" attribute to seg6 encap routes.
It selects the FIB table used to look up the route for the first SID,
that is the outer IPv6 destination of the encapsulated packet. The
attribute accepts a table number or a table name.

Examples:

  # SID route installed in the underlay table 500
  ip -6 route add fc00::100/128 via fd00::1 dev veth0 table 500

  # encap route in vrf-100; the first SID is looked up in table 500
  ip -6 route add cafe::1/128 vrf vrf-100 \
      encap seg6 mode encap segs fc00::100 lookup 500 dev veth0

  # or if the SID is already handled by the main table
  ip -6 route add cafe::1/128 vrf vrf-100 \
      encap seg6 mode encap segs fc00::100 lookup main dev veth0

The kernel companion series, adding the SEG6_IPTUNNEL_TABLE attribute, is
posted for net-next:

  https://lore.kernel.org/all/20260711162907.6521-1-andrea.mayer@uniroma2.it/T/

The first patch adds the attribute, the second documents it in the
ip-route man page.

Thanks,
Andrea

Andrea Mayer (2):
  seg6: add support for lookup attribute in SRv6 encap routes
  seg6: man: document the lookup attribute for SRv6 encap routes

 ip/iproute.c           |  1 +
 ip/iproute_lwtunnel.c  | 22 +++++++++++++++++++++-
 man/man8/ip-route.8.in | 16 +++++++++++++++-
 3 files changed, 37 insertions(+), 2 deletions(-)

-- 
2.20.1

