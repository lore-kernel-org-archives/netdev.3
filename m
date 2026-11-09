Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794232529;
	b=X9M3XYWvTnVrtw2Fr3imFItYmszhYOD1vmqzY0x1oA/l/g2L9G5qwPD+w02aQl82Phvr
	 PIivufpVLoXBleUuXyxdKEE5gBXbLinzBXPxdUJkv6RM1Yj1S9eQDggY4JVMXj/BZz3rM
	 daSS7rSsgcyI1F6C8hR/MenMVJxS9+tOfmcWkG2WJZkYV4jAH3Fti5tQ5M0SM1uXy+Obe
	 Uv0z6d/fygAwlJfbs6bzXou1G7zlvIiOHmMfcDsT3m7efAiZiCpcVsnf1Qp4MNiWrOqY9
	 wJIeqUQr/+DcjT9yMTmvtE4rLxMDrwG+azuD7GnEcPIUPzxv67Xb6a6ixHRzC86ak7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794232529;
	h=DMARC-Filter:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Debian-User;
	bh=Urhk3pQv0WWCXFwDQnJzg2CReRgBNAAQkqsxBvtLHgU=;
	b=p1RARMAhc4hcKMMZNGh2/tIqlMLV0Nc4rgPp8fapIQJJVXo8U9rhlSZfk8UPdR9+z5gz
	 vctXoqHOeK1gpybkpScEEJIzPEkqtiuLJ+Nyqqa+vpS8koa3VndPDBvycy8R0xV6FChYB
	 jackV2MVRdkDWLXHLI01q4MAD+rsd+SoOOASrA7r14jS6V4lSyDr5UvxHRQaX5bgAeBpb
	 SpILuzRkzNKKLmDGC2Z6UiF/PD3vE5DeN3h0CFEWHWMfc/rkkuGkpDyMnHePCml2aG0GC
	 MngTbARThx/DaHRPelKe3ZIiJKDiFfqSx/3SMfsc9pPmBJMUgQra9qKiPtdGvnH6Gvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=Gz4Mdcek;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054E6606A321;
	Mon,  9 Nov 2026 13:55:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 054E6606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=Gz4Mdcek
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=Urhk3pQv0WWCXFwDQnJzg2CReRgBNAAQkqsxBvtLHgU=; b=Gz4MdcekBFxwVXqzy4QnM4TA0/
	scgCEkTPwboRTPW55j9E4U0HS6JZnACpt1miiYtkV2rBmj4LRCv5ZNlY5dHoyn26yKupbP5DzGWfF
	bwz+v2Jb1hNdOYLadaBmCaaO2AOtUT5sFvaCTMQKvMsMN4JpLo1LMPx1IhF8sOVNhSl7chluDhJBL
	UbDaeryB3nwHLUAzABSUPRMYctu+vd3KGX7FPt4XWNB8nTA1YIHLKBmz0CnhuOxvTesJulbtlMiky
	UC2cPgaUlBWF2AToPpemoq5IX8GFkX6u6gtIHXtKThcWfSMx7vf+khNYWlUU5lH35x7xdkQ9+ogme
	870AelUw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xQPqF-00BfYq-0p;
	Mon, 09 Nov 2026 13:55:24 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH RESEND v2 0/2] nfc: llcp: Move to .getsockopt_iter
Date: Mon, 09 Nov 2026 05:50:36 -0800
Message-Id: <20261109-getsockopt_phase3-v2-0-d0f74c6e0f37@debian.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALHP8WoC/22NvQ6CMBgAX6X5ZmpKy59MDrI66GiIoeUrVBNK2
 ko0hHc3oKPr5XI3g0dn0ENJZnA4GW/sACXhEQHVN0OH1LRQEuCMZyxnGe0weKsedgy3sW88Cio
 SncsUpUAmISIwOtTmtTWvcK4u1ekI9Zf7p7yjCmtwNXvjg3XvbT7Fm//7FH8+U0wZbQuxTzTXK
 k2TQ4vSNMPOug7qZVk+c0jzL80AAAA=
X-Change-ID: 20260706-getsockopt_phase3-34f7b5eb3e0b
To: David Heidelberg <david@ixit.cz>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Eric Dumazet <edumazet@kernel.org>, Eric Dumazet <edumazet@kernel.org>
Cc: oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, sdf.kernel@gmail.com, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3600; i=leitao@debian.org;
 h=from:subject:message-id; bh=KmyCNgAppzjlVUyp/45pHqKJwpLKu26CS4a6FV1ckhs=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBq8dDHO+Q2sGoQcflZ//uFSV9vBWhzELFnwHRLh
 JK9cskBc1uJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCavHQxwAKCRA1o5Of/Hh3
 bX+7EACeij6JKi300dvJKWegDxJmJAN2CoUgMdhLX02HkHL1iQzCSq6C8qS6lyaZi34TUv6TznM
 VN8IswsqY6y0VxHzsIsVk4MIJUrA6an1vlxvFMd/MLho5jyCCh2CttlwlmHnjAX9n4CxWEzozR8
 KFVUCLs3ZJ6XLbDXYB/nXs8K8PCU+ILqbiY1SQ27PZlpGeYKYtenXIb08iLLyX5fBsmrvRWCsA6
 cKjcdPVVt8A1bz0Ng0KSohqxmyajKCERi9NbPKkAbBWgikNrA8uhRnTndgM9Kf8iP5RK/uFu2yr
 oTpYJziWHQw9LmC/8LA7K+gy/heLelM6E0W2V3ZGRQehV9sfbjAgK5OFme+CVIDX+L1ZNYGAckM
 hfokDfbx6r3ZYzZHSYGnp6U+H4mSrKvJ2yIRBh5tn+BOrNwK2vM5ZEo2YJylvCpG+cg2E/TC97p
 h9s0dnenkwqTkTkR1cNSWplfur4GsLvfVfef+8k5+R6bWrRH8lcHraWubCho4FtFKe8pogbrRde
 jMJR0+M8t2/2mLB+cHNxdaaUBcfIOlkZU/Dp7AcaMbQ2d46BMpjmh19JU669bA6yQorso9Xp5/8
 jVoWhKZxi/+kgX45sJvi8n8pP7T5hJ1KjVM/31nO0J9ELOmuupGqJElerRN/5VhOGoz22Jm/1Sl
 Db4QbnX7Ppw9dCQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Continue to convert the protocols to getsockopt_iter callback.

Proto llcp is one of the last to be converted, and it was waiting for
the following fixes to land first, avoiding merge conflicts.

 * commit 36812527052c ("nfc: llcp: read llcp_sock->local under the
   socket lock in getsockopt")
 * commit 99985bfa8336 ("nfc: llcp: avoid userspace overflow on invalid
   optlen")

Now that they have landed, let's move llcp to .getsockopt_iter callback

Regarding the whole project migration, this is where we are:

Missing proto_ops migration (as of net-next)

net/can/isotp.c:2064                          isotp_ops                  (.getsockopt = isotp_getsockopt)  [1]
net/can/j1939/socket.c:1375                   j1939_ops                  (.getsockopt = j1939_sk_getsockopt) [1]
net/ieee802154/socket.c:411                   ieee802154_raw_ops         (.getsockopt = sock_common_getsockopt)
net/ieee802154/socket.c:987                   ieee802154_dgram_ops       (.getsockopt = sock_common_getsockopt)
net/ipv4/af_inet.c:1058                       inet_stream_ops            (.getsockopt = sock_common_getsockopt)
net/ipv4/af_inet.c:1094                       inet_dgram_ops             (.getsockopt = sock_common_getsockopt)
net/ipv4/af_inet.c:1126                       inet_sockraw_ops           (.getsockopt = sock_common_getsockopt)
net/ipv6/af_inet6.c:656                       inet6_stream_ops           (.getsockopt = sock_common_getsockopt)
net/ipv6/af_inet6.c:692                       inet6_dgram_ops            (.getsockopt = sock_common_getsockopt)
net/ipv6/raw.c:1290                           inet6_sockraw_ops          (.getsockopt = sock_common_getsockopt)
net/l2tp/l2tp_ip.c:628                        l2tp_ip_ops                (.getsockopt = sock_common_getsockopt)
net/l2tp/l2tp_ip6.c:757                       l2tp_ip6_ops               (.getsockopt = sock_common_getsockopt)
net/mptcp/protocol.c:4753                     mptcp_stream_ops           (.getsockopt = sock_common_getsockopt)
net/mptcp/protocol.c:4862                     mptcp_v6_stream_ops        (.getsockopt = sock_common_getsockopt)
net/phonet/socket.c:451                       phonet_stream_ops          (.getsockopt = sock_common_getsockopt)
net/sctp/ipv6.c:1047                          inet6_seqpacket_ops        (.getsockopt = sock_common_getsockopt)
net/sctp/protocol.c:1106                      inet_seqpacket_ops         (.getsockopt = sock_common_getsockopt)
net/smc/af_smc.c:3345                         smc_sock_ops               (.getsockopt = smc_getsockopt)
net/smc/smc_inet.c:36                         smc_inet_stream_ops        (.getsockopt = smc_getsockopt)
net/smc/smc_inet.c:84                         smc_inet6_stream_ops       (.getsockopt = smc_getsockopt)

Link: https://lore.kernel.org/all/20260507-getsock_two_can-v1-0-3c2ae9edfadc@debian.org/ [1]

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v2:
- Rebase on net-next, no code change
- Link to v1: https://patch.msgid.link/20260708-getsockopt_phase3-v1-0-d8394f2fc554@debian.org

---
Breno Leitao (2):
      nfc: llcp: widen getsockopt value locals to u32
      nfc: llcp: convert to getsockopt_iter

 net/nfc/llcp_sock.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)
---
base-commit: fa5196392691051963726787944db872420dfa75
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git main
change-id: 20260706-getsockopt_phase3-34f7b5eb3e0b

Best regards,
--  
Breno Leitao <leitao@debian.org>

