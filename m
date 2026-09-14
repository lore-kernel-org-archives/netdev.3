Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EE23F823C;
	Mon, 14 Sep 2026 12:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789388424; cv=none; b=kK4PW/tsrFNozfukQpZGZJmkukyFfDV8Vwa9UdnSMarAVQf39IhoHgdLBcO5+px7UVk6TZNCJkHcMmws1rIdwD1wDpR5NspBhcODxDf5B33GzUgTRTyco+mgkcNlWpgIafYXnLc7mS4vMlDLlf7DvEm72koUGb+j/yCly8Q7BGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789388424; c=relaxed/simple;
	bh=eNjw1ajc9YKgliV28VMb9regtb6t3iITggEL8WiBKvY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=R2a/gnpGYrorv8QqUltxyVvN9kYG06+eCp0Lg2wxV38qHTqp5gie263k8ztH6diPnJQqIRqKqliZE7soiaOIrDVzZ+PGWJy3QCCGnHQRLmtxTLOlQ1HmKskuTnQFiPrB4oEt+FjqPMua5kEJ37fJGEZUR10z6MoYECiC4SV3Dpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=AdWUVjWk; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="AdWUVjWk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=FZBuO/3aoAcdyhkrYbzvwt+T+bG/4YUuyX6esQSDOv0=; b=AdWUVjWkGm3eYHVoPWg7iP6iB4
	uxnUfCayH0Qd5MX7WYkgrJULTVlG1MQjil6e3Lbwz6pSrHZwymtshzJi1Sx+s6PD3WZbp6JAIxiXY
	zrsN/Ye9We4Evyp8PNXxt5E8WqfkeSK8jTi3dF88N+TMlyeiZlJArvqkyYqV7ImENYmy66gRbAtVm
	p3AKBTRxurSpin7f56gZIxa21+tDEjJtCmhruaisbyQkOcjjkn/CrL1/eE4NjSgbxQLqAMTOK8JpT
	Kmxfn3ffxKa8OxBdXAYIEpvXoE7RaArSLQ0Amea8fn0OsCU4G662UorBxjb74V2sreMTCBVKq3n+d
	LpBOkahQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1x65fQ-003btj-2r;
	Mon, 14 Sep 2026 12:20:14 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v2 0/2] net: a sockopt_t quirk for the options
 that write past optlen
Date: Mon, 14 Sep 2026 05:20:06 -0700
Message-Id: <20260914-getsockopt_phase6-v2-0-e48befc9602e@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHfmp2oC/23NQQrDIBBA0avIrGMZhdokq96jhGJ0mgwFDSqSE
 nL3gt12/eH9AzIlpgyjOCBR5cwxwCh0J8CtNiwk2cMoQKM2OOAgFyo5unfcynNbbSYj3c0Nxmo
 1o9HQCdgSvXhv5gMCFRloLzB1AlbOJaZPm1XV+s9V+MetSqIk0ytSqP117u+eZrbhEtMC03meX
 4jZ3E29AAAA
X-Change-ID: 20260909-getsockopt_phase6-c7c96a21b062
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
 Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 david.laight.linux@gmail.com, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.16-dev-f8e9d
X-Developer-Signature: v=1; a=openpgp-sha256; l=2804; i=leitao@debian.org;
 h=from:subject:message-id; bh=eNjw1ajc9YKgliV28VMb9regtb6t3iITggEL8WiBKvY=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqp+Z4KZjqnVpPkEUAKR2oocQxyL+fNfX/hErNx
 JgaKqkphfiJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaqfmeAAKCRA1o5Of/Hh3
 bU2jD/0TIG2rmpW//KlvLxznlMUbjNvNzJXpztVoefoowgcDd1uAHRJHifD/bR9d4Ay0feVq3CX
 rq3blHwfMXW99X22jFxtHQPHK42birvcnvP3JdfSRmA5I4w/PyMKRx7RzlYJVz3JySIIGv6Kcoe
 8eLhK5oOQNsPI3k8uveK+UR3m+PI8HW+lalwjwc08uhkODgzTwJeh+jfYnwkkHHQSNAlLaB67WD
 vZVlR8mZ6catVwJw/WA3KjutL/4xwXycReYptRal7esnr3al2kN8OkT1RVxY8BUbIcgsPoAXiNc
 gyKnFdgacO+1wdVqjxaJ4wo0H0cxhKHOA4GT10pPZWZ2st278RCRf6/nmZ2YGZfT/YzI+8jgcER
 lwnjaDEoXEOnzIIlogCAp3jKcnStzTPJJHMPkelU0XXW7uXs1prxiFO5oHotFwaG08sSCfvhHT+
 pOkKGWLw80bUS/+ZStLuc/TVxHNBxPIfqYyEEGNSVnqFSE3yOdKcpatcTZnla6Ht/P97yd7aRd/
 PyGV+S83Q0nKbKslSJQ4etfcz7kDvEgkeq/ASE4XrsIcA0AMzRZ8wVR1NJ+VTP4XT+lWWfjw6Qy
 CLXiaXRnRdbQsxe3kZbU+phffsThzcF2g9a3Td2/qR+CWzodjv1tHe7YQxEYxCFhAEZxMUykQLa
 mmMyJvEjVs4xuMA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

This series continues the migration of our protocols to sockopt_t, as
described in [1].

There are some protocols that use optlen as the header size, and the real
buffer size comes from a field inside the header. This means a bug, given
that optlen should be the full buffer size, but there are indications [2]
that we have programs that use the bad behaviour above, and we want to
avoid breaking them (or, honestly, avoid being cursed by Linus).

That said, create a quirk helper that preserves the same behaviour, even
using sockopt_t. The way to do it is simple:

1) Only do it for userspace callers (ubuf), otherwise a bug here will
   corrupt the kernel instead of a simple SIGSEGV.
2) Expand optval mid-air based on the header field.

IP_MSFILTER is the first user, and the smallest one: a single caller, no
compat variant, and a reply written front to back. MCAST_MSFILTER on ipv4
and ipv6 comes next, and TCP_AO_GET_KEYS has the same shape. Do this
quirk on IP_MSFILTER to make sure the dynamic is ok, so, we can expand
it later.

None of this is meant to change what userspace sees.

Link: https://lore.kernel.org/all/20260401-getsockopt-v2-0-611df6771aff@debian.org/ [1]
Link: https://lore.kernel.org/all/20260806-mcast_fix-v1-0-bed0a5518e57@debian.org/ [2]

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v2:
- sockopt_expand_out() measures the request against opt->optlen instead
  of the iterator's remaining count, and asserts that nothing has been
  written through iter_out yet. Comparing against the remaining count
  made the verdict depend on how far a callback had already got, and a
  late call would rewind the write cursor to the head of optval.
- Cap the requested size at INT_MAX, since optlen and the getsockopt ABI
  are int.
- do_ip_getsockopt() writes optlen back only when ip_mc_msfget()
  succeeded. Without the guard, a read-only optlen turned -EINVAL,
  -ENODEV and -EADDRNOTAVAIL into -EFAULT.
- Name IP_MSFILTER in patch 1, document the WARN_ON_ONCE() and that no
  in-tree path reaches it, and mention sockptr_to_sockopt() losing its
  static.
- Link to v1: https://patch.msgid.link/20260910-getsockopt_phase6-v1-0-e681e102d5b8@debian.org

---
Breno Leitao (2):
      net: add sockopt_expand_out()
      ipv4: igmp: convert ip_mc_msfget() to sockopt_t

 include/linux/igmp.h   |  3 ++-
 include/linux/net.h    | 32 ++++++++++++++++++++++++++++++++
 net/ipv4/igmp.c        | 23 ++++++++++++++---------
 net/ipv4/ip_sockglue.c | 10 +++++++++-
 net/socket.c           |  4 ++--
 5 files changed, 59 insertions(+), 13 deletions(-)
---
base-commit: 548b86839f7fb819a4d6c83b71c73ec378d24275
change-id: 20260909-getsockopt_phase6-c7c96a21b062

Best regards,
--  
Breno Leitao <leitao@debian.org>

