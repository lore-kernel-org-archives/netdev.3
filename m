Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CAF3ED3B4
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 10:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789986143; cv=none; b=QD2qp40cZNkez7ke1dc5a2kei5gvDHiwFRoVhVKw4lh3wB6l5rnQ6PpoWDzHnFkr3LgfdptioWcV6soW0Ayg6cpw8Zc7Ln4KZpePMfL2gzQT+A5dX1/c9y6q+6ekh1PO02ag9di4jq7QSYzlrNzQ/BaxS8oooid192nahAHgVcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789986143; c=relaxed/simple;
	bh=EJp3+H9D4wJtiVI3+F2TJgfmGhZjBtmEzSK9+YkEsi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u6JuuD/gKtA7uZdLnl3y5re4qoI4UnCanc8gye/Sjx7gcn8drfw+sVFcXqlpXmmbbDPqlpyfP3k33VJvyzMex2YDJeuFaQk3BdMPVaH2wmjx2CTobciz4Ux6dsHuYq177T5FudZCB8TspSul/RTIMZv9xDXMHz5aHidFmWtfjZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=e4gYHovQ; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="e4gYHovQ"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843c2790ccso1660739f8f.1
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 03:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1789986140; x=1790590940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lYFvtU9n4zu0mcg1+Fd4tCSLOtClK+cubMOCd9Sfz8M=;
        b=e4gYHovQw7g91kcV2nArafXmbbUtr0lsP9B3pKjK7oMJdMbNGenlzjaSXCbgY/+P7z
         DhdCzHwcxxE8tCLu5Ed888NZofjsmnXdk8Mb1UhniN3R/Gs9OToOvBs5GAUAGKrMFboX
         K2TZEWkUMHbQ3pydRaQHgIesRF16HWZRjvjvGeR4WKAdV1IVNtv7/mdsjHyd0Ss/8Qla
         vGPuJjnJ49jDGolYBTpIERCh7/2xmL5pKvZYwgqKBLmbGsUZaOU37G2tDcQDV+2UmeU/
         DO3Hfbc89OktluE6SsII99rS89R5mETxgj9hlqV34xNdJL9co3w47VN9l/00XVjqiRjF
         ndqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789986140; x=1790590940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lYFvtU9n4zu0mcg1+Fd4tCSLOtClK+cubMOCd9Sfz8M=;
        b=XOf+/V5RIVSUgLRqn5SAKe5PGHeoBq+TrYKcOe+Ji68r5cWJckGbmjAr3GqzI9byqE
         deHMn3A1s2StD0thyOPebaZAb/aki1waGprd9o5HBxz+q4gLTEOOUsmpfS66K6mGFfTb
         0W2Gk+F+2s3AKeWfWqyPsa25ms5OkxV09nTlr+niIjCIGxLZdQxacEDpDPSi3eCKg3Ed
         UC6EgwwX3ysCVnZLslHWRxTA9/ZXRV5Ekm5cv872mSqDk2zU777g+fpqxsZdoOYLL5R/
         PRTesvrtPjtDOk0+zwMlJl4I6Z/lnZx5hblTPnD7Bja1ruPZGpxNxah0yGaJbGNDngVD
         cnRw==
X-Gm-Message-State: AFuF++kIOLwxlTU+uhpcNmQ70iMV+32vHOvqsxawYefZBWOVRDG/KWpP
	r+JlcMKllvVMjPM8utHdKnipe5rviTOHmGFDYT1JYL0ntzROCJCDpFR2B7xCS6peGTa/sAvM9y8
	ceE4vvSIWEKKBxy+8BVI8YMrh5SyTVqcvbmi7EXFYfdMg1w4uJH7oZbtDja4k1wEnPWk=
X-Gm-Gg: AYBFou0vPTVeuec6q1UbngIcjN4BGc1Jq8Q1Ugf+iI93qSzH2vw6D8RMkWCQVDbB7Zd
	S+gkVC2s7ciTRBR5FlxwusbX34YsZJhexzytttm1ZtZzuaoe5PmIbHbMoAQEqd4BdwsT/QdkqCS
	Gf56Gh0BY22Ho6PtZQ+bZuXVjbhRTHPh/rRbqk/ZTfSMFGMPwKqWZL2dLO1iXHE3p5fEfOR0lRf
	42euTTkqw98vtg9xRdpzJpgHt56x3h5/yoWCajWLBzzyTaJqLE9baQTq4rz3xnRGJh/uOohvGSy
	737vQEWWqFtYdN4p4xdiNpKktTx3kGkI5BTUivm9asvcwyZxT701VBEwmrs2BCIzRwYnjeK8jON
	oGJRIR2H5UvaVHCLgSGX+i9pfm3obsWX5vZy5wTdmQ7tiP2VtXLz99cUqrl2fUiYbDuM57W7im2
	/86yZRqvvepP7oO081c2ce1XCy0So4AlYEsLJTCB+2FFQWx1GGB3DnwJxq/90f5aiqUgM8On0S+
	jrJ5ImBOM0=
X-Received: by 2002:a05:6000:1785:b0:487:27f6:a4e6 with SMTP id ffacd0b85a97d-48727f6a6c8mr8157277f8f.54.1789986140298;
        Mon, 21 Sep 2026 03:22:20 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:b03b:2cfc:7208:2ecf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48724583fffsm20925476f8f.23.2026.09.21.03.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 03:22:19 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Ralf Lici <ralf@mandelbit.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net 02/11] ovpn: skip UDP source validation for unspecified addresses
Date: Mon, 21 Sep 2026 12:22:03 +0200
Message-ID: <20260921102215.3599702-3-antonio@openvpn.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921102215.3599702-1-antonio@openvpn.net>
References: <20260921102215.3599702-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ralf Lici <ralf@mandelbit.com>

ovpn validates the cached local UDP source address before reusing or
refreshing a peer dst cache. This is only meaningful when a concrete
source address is selected.

For IPv6, calling ipv6_chk_addr with :: checks whether the unspecified
address itself is configured on the host. A peer may legitimately have
bind->local.ipv6 set to :: when no local endpoint was configured or
after a stale learned address was cleared. In that case the source
should be left unspecified and selected by ip6_dst_lookup_flow().

For IPv4, inet_confirm_addr(..., local = 0, ...) asks for local address
autoselection rather than validating a chosen source. Skip the precheck
there as well and let ip_route_output_flow select or reject the source.

Only validate non-zero/non-any source addresses.

Fixes: 08857b5ec5d9 ("ovpn: implement basic TX path (UDP)")
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/udp.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index 7f69e8890b5b..df4750dabd1e 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -161,8 +161,8 @@ static int ovpn_udp4_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 	if (rt)
 		goto transmit;
 
-	if (unlikely(!inet_confirm_addr(sock_net(sk), NULL, 0, fl.saddr,
-					RT_SCOPE_HOST))) {
+	if (fl.saddr && unlikely(!inet_confirm_addr(sock_net(sk), NULL, 0,
+						    fl.saddr, RT_SCOPE_HOST))) {
 		/* we may end up here when the cached address is not usable
 		 * anymore. In this case we reset address/cache and perform a
 		 * new look up
@@ -238,7 +238,8 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 	if (dst)
 		goto transmit;
 
-	if (unlikely(!ipv6_chk_addr(sock_net(sk), &fl.saddr, NULL, 0))) {
+	if (!ipv6_addr_any(&fl.saddr) &&
+	    unlikely(!ipv6_chk_addr(sock_net(sk), &fl.saddr, NULL, 0))) {
 		/* we may end up here when the cached address is not usable
 		 * anymore. In this case we reset address/cache and perform a
 		 * new look up
-- 
2.55.0

