Received: from eidolon.nox.tf (eidolon.nox.tf [185.142.180.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAA8385D7C
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 12:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783946761; cv=none; b=qhFXVE5Jvn9aCUex8cbXERBWioqs0VY7pPXR2KXQoxNU8mP3x+asZCGE1hGlkHty2XhZSOsttVv708CSq168S/CSNA50TKLFnAG6V83k9N+pUUMstEebK+cRY8BqM/DiuAsRO00KpDGk/+JrdwT09X6df+LDQt3ClEsylzLoPrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783946761; c=relaxed/simple;
	bh=pWm0ChJyB8PHmvDlDUj89RkzlTNGHzp95bKBeqNbe+E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hyg5XR8vSt8blxXmJngo5MY0mxtcMIedvTpr0XbZKwJa3RksnrjRr5zmpRC10u6cV+429WZ25Q9VkthXZQkvgGpLys8SNBBlrqtAuL3GhZxNLFIQeQ8XVq7VhjjL+pJXsfROhKNwxw2TqhdDG6a3nX+JvxawYw2t3lSTFB4vub4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=diac24.net; spf=pass smtp.mailfrom=diac24.net; arc=none smtp.client-ip=185.142.180.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=diac24.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=diac24.net
Received: from [2a07:2ec0:2185:8e:f1c9:c246:22b4:8471] (helo=alea)
	by eidolon.nox.tf with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <equinox@diac24.net>)
	id 1wjG2j-00000001VUh-0q6p;
	Mon, 13 Jul 2026 14:45:53 +0200
Received: from equinox by alea with local (Exim 4.99.2)
	(envelope-from <equinox@diac24.net>)
	id 1wjG2h-00000001wUs-2y04;
	Mon, 13 Jul 2026 14:45:51 +0200
From: David 'equinox' Lamparter <equinox@diac24.net>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [RFC net-next] llc: jumbo frame support
Date: Mon, 13 Jul 2026 14:43:37 +0200
Message-ID: <20260713124545.462790-1-equinox@diac24.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,


this is a somewhat random stab at 802.1AC / jumbo frame support for LLC.
It kinda fell out as a side effect from poking at FRRouting's IS-IS
socket use.  Unfortunately even if this gets picked up right now, it'll
be quite a bit of time before we can even consider using it there.  (And
it's not clear that it'll go that way.)

Regardless, it's a tiny change & my messing around with things
effectively got me the selftest too.

The fact that AF_LLC can't be used in a network namespace is a bit of a
problem though (haven't looked at how much work that would be, unlike
the jumbo frame support this didn't fall out "for free"), and so is the
fact that AF_LLC is on limited maintenance...

It's an RFC.  Comments appreciated.

Cheers,


equi (David)

(waves from netdevconf in Rome)

