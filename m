Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.188.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794260325;
	b=ap/y4ecGq7e0j8dRKj0ATp/Nq09y1jMoOZtMnE95UgchDGJlsZ4ye5FtebE20+v/CN98
	 M4tG0fKHVQzrFJqO16QKfimfI13BUnffsOFEHsniwEKZQ1noKOpWZxoUhD31I4mxs7sk1
	 q/W5V45avitI9cWQGuMjkrlkFFRZ8en9vspeqmXh3hryfo1ZLxtbvCRkZq9KsSHTnEHQv
	 hTyT9BsKf7iUMmiMBU5t+3Bb3yVGsuilSnJPTK7LOvizEowxE7NRqJpRLkbVJeRqAHPHL
	 tH8Qkr4BKcZgeMWq21SiwuZvhZXllF5vMTztqwiw+G9/iccbGa2j/sy0lI3vJKCjQpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794260325;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-Get-Message-Sender-Via:
	 X-Authenticated-Sender:X-Source:X-Source-Args:X-Source-Dir;
	bh=k7Wh9srWpnIpNuXMJqXefydfIgxiTocR4gjfGUw2Pb8=;
	b=zTMYAwX3toTBD3sy886Mu9u/Q31JCcCX97oYsu+93yxxOQXPjLe01u7nGrxLyU+B5omK
	 p55O/sfYraZv9pcM9R+kkCGDGLGyyZqbScv2xTMTNOhv9UI7a2S7G68fSLapH03s0aCd+
	 caCF/1kof/KUkFnkU4ZNEB4ne++eNkATkGGLcYA+W4LWKQC7fIM19e3tYhLmDtFdxjT8I
	 CXDOQsej4B+AMny/snfWlEYLGFaW5i0qrbk8yqEjmqTLI8116KgBbCmcPZbgnuinW4rIL
	 18U5eWwKIvlVj4B7K358mf1JYGfbRwrdr0VuYYO517dvdIS3zSUU33sda8650bG4Z0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cyber.gouv.fr;
	spf=pass smtp.mailfrom=oss.cyber.gouv.fr;
	dkim=pass header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=J6hvdKHR;
	arc=none smtp.remote-ip=51.159.188.251
Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE4A606A325;
	Mon,  9 Nov 2026 21:38:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDE4A606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=J6hvdKHR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Sender:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=k7Wh9srWpnIpNuXMJqXefydfIgxiTocR4gjfGUw2Pb8=; b=J6hvdKHR9wXW/u+g9iSF4bPcaE
	wCVzFZiWVOMkxE6lu5YRgzXa8QfzUfgek5/6tq9cHzP5G3uF8xpA4k78few0UK5pSq7h5gs1NWwFd
	+IDU54RdEra8wntUNiL8gv2Cy6MLzOsYlE5LVpia9Ijv0CpXVjyNV9+N9R/wRBNzXRJisXWtrGwLP
	U9PQpjOkVrcJk7Nld/rHYLkNRvjWE5JpInmYaScQOjTvnDrGCLMzTnMmXWRDydixAu5dy9Arbx766
	F/W5Q4Q7Hn6N0V1pp+gmW3Clbf5H6JD36IzVQFcdMmLiUVm0D5QrrSkZMZXG38cEcvxN/SPEgBK97
	i6H3BOcQ==;
Received: from [151.115.150.205] (port=40012 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1xQX4d-0000000FGXi-1Bs7;
	Mon, 09 Nov 2026 22:38:42 +0100
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
Subject: [PATCH net v4 0/2] xfrm: fix IPv6 atomic fragment policy handling
Date: Mon,  9 Nov 2026 21:38:01 +0000
Message-ID: <20261109213803.1785516-2-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: git-send-email 2.47.3
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
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

This series fixes two IPv6 fragment issues in XFRM session decoding.

Patch 1 restores upper-layer protocol decoding for IPv6 first
fragments.

Patch 2 builds on Patch 1 and restores ports, ICMPv6 type and code,
and GRE keys for atomic fragments, while leaving them unset for real
fragments.

Changes in v4 after a review from Sashiko:
- Patch 1: unchanged.
- Patch 2: Use skb_header_pointer() and remove the XFRM pull to fix
  local input decoding and avoid stale header pointers.

v1: https://lore.kernel.org/all/20261101230745.2043474-2-Jeremy.Jean@oss.cyber.gouv.fr/
v2: https://lore.kernel.org/all/20261103225842.3204446-2-Jeremy.Jean@oss.cyber.gouv.fr/
v3: https://lore.kernel.org/all/20261106202910.723098-2-Jeremy.Jean@oss.cyber.gouv.fr/

Jérémy Jean (2):
  xfrm: fix IPv6 first-fragment protocol decode
  xfrm: fix selector matching for IPv6 atomic fragments

 include/net/ipv6.h      |  1 +
 net/ipv6/exthdrs_core.c | 25 ++++++++++----------
 net/xfrm/xfrm_policy.c  | 51 ++++++++++++++++++++++++++++++-----------
 3 files changed, 51 insertions(+), 26 deletions(-)

-- 
2.47.3

