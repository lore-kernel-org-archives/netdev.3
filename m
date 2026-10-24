Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792862116;
	b=v6a6g6cgOD6Iy9S9WEEcuBbMFuxpFuuyQPWgaCTcicXhb4fXilSI66rpFxPMxIlfMD1h
	 ZPP1ALW9Y2MTJc3NSzXyncIz5nLNn3Id7jwQd44ETWTcKy5S9nHiONDZHuzkXtA3bWPTR
	 IJV7wDMdt47RxfE7dLsZ4OMHLDZ8lmNXkyBYIQ372Mdy/Ql6qr3YB/4nc42WfbUTU52B6
	 Pt2QhZBzeypXeYfnmUNVwUUfv1KENkBVLcmRrcHqnu5NdgyTj6FOS+OzkqVB51dZRTFDs
	 VE4viVgIasxsO3xjhVVX2BlVjgP2f0RpLUU8eItZmq15SUNo6pXkMICEq7WtH42Z8xQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792862116;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=K4HBXAYflJaaht7uckfpuIcFpPVS+5A4K2weg4k2Wz4=;
	b=aL6DTIBxYZjpwllbDBX9g8RsoAQsl/m0bo1ZX7ajNdCVNg5ayK/qFZK6nIpBCXJx7I5H
	 BhfO30V2VlI3e5CvCno3pv65rOzs8VCXFtKCmUo5N0w3ITCNN6bl0TOHGNY2FjHqoNNh5
	 0SC55uLME3riTzWyIwzp7Q6oG7bGFtRhZOwa4BCqaiAb6MVupcixmcwn/2/mwMYULJ9Ks
	 ZAyVtKaf1d8TxvYv1quATQpMiknO21O0gTqnx7bpXgNzQNRYu/omhyK4ibGTHK05rI1Jl
	 DNSGCSShtQRoQr2dcGDeUyccU5oOC1rFyUHQJmpJ49oU5p2NOWJKIMxXEItNaoXWoWw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UOm97Jgo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849A4606A327
	for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 17:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UOm97Jgo
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792862116;
	b=r2+nfbF+cOOnvgALarpNBF/Eucc3qxJuFUEtvVzEJCSSLZVe/blhu3mYND7RxxhUn8t1
	 Ewp3lKCysRqzfAtdoYU1bS6ipuspMcBQ0j9hpXdujjz7MKnJNTVcs9PKE9hBecDsxPTS1
	 hWFCRLdypIehuLylOTj8/HlCdGfQ1AaBWnCXPuDrxXf56BOzNS76NK4oHBKqFQKmF4b6f
	 4izesPirHOnbBkooRx/kuBd568hErC1TIuQo4xIeRUSJUjzFtDBVoFr5f2A/N3wSQeNNY
	 fE2kTx94uT7L13epOEel6Nng4Iiccn+j0QNObhCfu/lxEnUzKUvqrK4BNOFwiv+QBIQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792862116;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=K4HBXAYflJaaht7uckfpuIcFpPVS+5A4K2weg4k2Wz4=;
	b=Ef2w7k6vShsQLD3owErEpDrnfJLXOCLDwkTV11X8zCi8/eYh5G2yXjGGj52lNajC7Vc1
	 fc+279EtB2Gc7PiHx8PNjDVA+zCB8wfpmmvwWfUplG0evcTCKS+CspjLfjr2yArF5tYoQ
	 u3QnyhRHgceALhWAHzLcx3og0ZEpiIutcMrcp/YQ3hV116KJSKJftpTEtjL8aHA0WFpqx
	 DPCdUZWdvk0TH84ysStmWscVMsI6NDyASb8uxJbR2jqVK4nZPTXuWjvHmRIxea4aAxkh+
	 32AXPBcVp4bFnOylkNUJiqF41wXC2TmnPTLLHMkX6TE0IxCuXRpEfjcT9SOb/ck1s9A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C543E1F01825;
	Sat, 24 Oct 2026 17:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792862116;
	bh=K4HBXAYflJaaht7uckfpuIcFpPVS+5A4K2weg4k2Wz4=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=UOm97Jgo3svpK5yMvx0pzge3WW1ROab0rhXReBoAeajcbHDloWqgUUYMRG9RAFa8t
	 NYaulh6qi/YQCXa7+d+zUb1S02utUJxYZXnsJF7tYn3YNobnl1CzCevBGAM2bYDBlm
	 PIV4nVmbEzX5Hy//nlPlls+0JAr8tOSykgzsABjDDA3uT7mUxfQFbntjuC+ecrkq+l
	 ik7ybUei3OFW2GpXHxqL37q04ebE8RMNrURrcaZ2sz4pOYbh5u/biim007sGiVbXXR
	 vOe1sr5qrhFqfwoofern8LOLhxXIr/vA1LaQ8kYuLQyr7D4V8wmsVV20/wFHZiK8tb
	 rO9cVaiJipCOw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 252A444849;
	Sat, 24 Oct 2026 17:15:14 +0000 (UTC)
From: Demos Ra via B4 Relay <devnull+demosthenes.ra.gmail.com@kernel.org>
Subject: [PATCH net 0/2] tools: ynl: generate code for rt-nexthop bucket
 notifications
Date: Sun, 25 Oct 2026 00:13:54 +0700
Message-Id: <20261025-ynl-ntf-bucket-v1-0-65aef308d62c@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqEMBAF0atIr6chBhHxKoOLqD/aKD2SZEQR7
 25w+RZVF0UEQaS2uChglyg/zSg/BQ2z0wksYzZZY+vS2IpPXVmT5/4/LEhsPBrn+6Z2qChHW4C
 X4x1+SZGou+8HeskEN2UAAAA=
X-Change-ID: 20261024-ynl-ntf-bucket-0fe8afb86ae4
To: Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
 Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, 
 Demos Ra <demosthenes.ra@gmail.com>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792862112; l=985;
 i=demosthenes.ra@gmail.com; s=20261019; h=from:subject:message-id;
 bh=/j7E8HCFiSHo7P2rv+DOQ25KZfpsl+WGqu8Wu2cLYgM=;
 b=4HwYBLNilcCI9mMBMV7dd85SXw3g5jEa9ByJAXCL4OjKFTFC/RNpne3cVBPoYzi6zKltz3UWK
 ztXYdU1PogwDYwuy52lrNht0XeUVgBrdaBeFZSdioELcOUuqxBo9Gh3
X-Developer-Key: i=demosthenes.ra@gmail.com; a=ed25519;
 pk=sDKS9AI9zxhWgOqkhc9EOIo6cky+anqccB3VGtDvzCc=
X-Endpoint-Received: by B4 Relay for demosthenes.ra@gmail.com/20261019 with
 auth_id=1235
X-Original-From: Demos Ra <demosthenes.ra@gmail.com>
Reply-To: demosthenes.ra@gmail.com

Commit 457dc9fefe9a ("netlink: specs: Add a spec for nexthops in
rtnetlink") left newnexthopbucket-ntf out of the C code generation,
because ynl-gen could not write a notification table entry for it.
Sashiko pointed out that the generated library then fails at runtime
when the kernel sends that notification to a subscribed socket.

Patch 1 lets ynl-gen handle a classic notification that no request
matches. Patch 2 drops the exclusion.

457dc9fefe9a was pulled in this merge window, hence net.

---
Demos Ra (2):
      tools: ynl-gen-c: handle classic notifications without a matching request
      tools: ynl: generate code for rt-nexthop bucket notifications

 tools/net/ynl/generated/Makefile | 1 -
 tools/net/ynl/pyynl/ynl_gen_c.py | 4 +++-
 2 files changed, 3 insertions(+), 2 deletions(-)
---
base-commit: 7076f684d5132e6a6145e1da2fa74771ecd052e5
change-id: 20261024-ynl-ntf-bucket-0fe8afb86ae4

Best regards,
-- 
Demos Ra <demosthenes.ra@gmail.com>


