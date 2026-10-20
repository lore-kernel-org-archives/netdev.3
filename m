Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792511199;
	b=ybiWeYS9FoBfzVta85Y69tVbm75UWbkzfFvnP8C64DxgXFNQuEH1HFmE2FbJW2DpM+K9
	 tclInuaSYGlZfsnPHwO17lOXEdoungDjFDJSqm9j6PVDuH8sY+5Negv5B4Y3gbFecoT+c
	 o+ityRKPg4rTz1Ct3BiSk0SNn7BOmsgJucbgL+n7+o0AOBah264Ry6HLvL2b3UmWql8LG
	 N9Y+yRGQttupsalTO/gsBhmI+0qM9uGRTvNDDtIn0Rm8jpdXFTKvFXmPK9dwg+ED7ngDd
	 2CEN9iresTM1uZvb6AOio0gHKqFZFtJCT29RCP0OqUS79+eJe/xU7lXRr6rWLZk7Hkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792511199;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=aGEmASzWRrA6RMd8qvtFd7Ful29mkFjMKyxvzUs3bdA=;
	b=Zn+Jbr+vzwWQXcr5F8Wr+8CK7BYyPmQtmPkorgZCBIxTJm6e44IPKDFMGtAhueDM6UvN
	 Obw4hhmSv48SwEKR7luCesYIBgdra0prJ9F5WKDmiSHNihT3yQmOoWjeXeGAvI1KyQX+x
	 CCzzm5M96EqQ2OIG2b8IughH+W4fh02lH+nBlsZfeqF4B52XhmWhgEZ/Hd0V/y8J/c5nY
	 xz/qgaLBoy1GUFdBoGkDDMc73P3qvdGwurDK2jMXkow6/riVe2GrXIG3PXpnL5Oedz++z
	 ZCbOJH/T5b4n6K3qi241FQp8TnUQE9gMiTknl36W7CTpczF/RCntpstz9y9EjEGlWCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=RITa9ujN;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E924606A31C
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 15:46:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E924606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=RITa9ujN
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3a0aaa0fd13so2907013a91.2
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 08:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792511199; x=1793115999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aGEmASzWRrA6RMd8qvtFd7Ful29mkFjMKyxvzUs3bdA=;
        b=RITa9ujNzjY1Nwub29wpH9TLKAn5/80NUn9K5ykpL1ata2ygOVp6DpVmXpkdaAtUIu
         A9JwZ0Y1TDU7qj9xG8IYtqvxHfFOwwZb6kWdJe3kcHLPEBuJMtg22XlLi4i1C3vEZ9qR
         Q7g1y5j3D0Jy+DEgXqMo44WMELPayfUy48VMrY22REoeDcRKNV3OCegOGytiUiv6OLVC
         3hs8dnTs3UfC/aCedcMHjaBRiTxTMU2RuL0+xQaWJ0WwJgdBOfYh9UG7biz35R0cqst2
         ImVTlyQNhK9WkMxXbVWhXjCGWONIrJRT2Wk3FWAfQrPQsurrieSogy7z19q7Lyfdjfkc
         Pgpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792511199; x=1793115999;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aGEmASzWRrA6RMd8qvtFd7Ful29mkFjMKyxvzUs3bdA=;
        b=AevhqQPnkzioEJnkQ2vagmX2xTjHCP6MHRdLaoEDZPTWipkbuQNlfTpVB2P9rkfC43
         kXcFme7Vx3yjLb3q6ag3FQaTOLcd+A7O7uE6mShXWyqvLXoBGYSefgNGqfTEP26o3GSs
         bF2K24ZReZSUwZV8BxCmL2URrHByIB3xu8BNT+Jb/pIqWfrInZwa98XDjvEhb4h1YyEO
         8axfx/j6NxPpVzdGHJSkTqLaGfKhmtQCvaB0h4qQEl0jepBXb2baKtNEPj6nmi2i4sAU
         gM9GEvSf9H4sWlrCnLsUL0BCeq54BZOsTLDfYDZe4LLJVWoytacbyXGo+CgCkxxZFrvh
         5UnQ==
X-Gm-Message-State: AFq9FYJVP60toqfhiwzp+QgqdwfjhwC3Mm68g0JtbxthHrmsKSEFpe1m
	Yxy2IwfgmC4/g9FnK2cBT06YLS2SktB8P+Ruvpdds9NsOjJ2tpY9OpljlejxuBAD5z65N6aFSkM
	BilQu8Yg=
X-Gm-Gg: AYBFou2XcOwrtf6cmFx4b8RLOx2QyMhNZ7GUgh3+RRHFJG8sdI7UgwBm2qIz5offaVy
	2m6ARahirIw2rX/+y/WDIZQORvTSduuwflkBLM3zJ4PO1IlHxf78Q3calSOIL3qOzduZEQrBvVQ
	GRZBkWT/siWO0yMclYN/9QmIBX0LZZ9ZXa4fVeac9C1GhILPGV+sCmzaVAMpAj7MnHsBLIIDDdP
	Rpvv3lzY6cSRMSGIkgyqXDkZNc15OaGxoGus2fK7qSW2/kr0Tx6NGLboR/W0RCTMlqvVRp+zT77
	RzifykNquNujj0JBVujAp4QJbHWvOyzGjeCcnnKzUu0VfXOjn2U4nNOUGyosEjX0vt7F5JHZLmD
	onPm+/2oK+lyZ2yx85ak9vGZqg4d/c2bX9id+1lNJAvw0G++P/YmQ9gJVk6sExr/2r2JzFOPC+T
	4aZPnR0QIa9g3b22jTAR6wEuMpgnyX8VkNCbzSPFA3O3qGEebqtT0yMXDB4+Ca+tKTIZsByeJBn
	uuIFHNHXNoWFwBu0fz5pkLABL3R6N7ZTRQ+Fw==
X-Received: by 2002:a17:90b:2e03:b0:3ac:adce:60bb with SMTP id 98e67ed59e1d1-3aceeb95d84mr7889002a91.23.1792511198565;
        Tue, 20 Oct 2026 08:46:38 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad80214aefsm154493a91.3.2026.10.20.08.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 08:46:38 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Claude <noreply@anthropic.com>
Subject: [PATCH iproute] iptunnel: use worst case buffer for tunnel ioctls
Date: Tue, 20 Oct 2026 08:46:35 -0700
Message-ID: <20261020154636.1097849-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tunnel ioctls are device private, so the kernel fills in
whatever parameter structure the device uses, and that can be
the larger IPv6 struct ip6_tnl_parm2 when an IPv4 tunnel was expected.
Ust a worst case union similar to commit 8cc2eac6 ("iptunnel: detect
protocol mismatch on tunnel change") already uses on the change
path for add, del and show as well.

Reported-by: Anthropic OSS scanner
Assisted-by: Claude <noreply@anthropic.com>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 ip/iptunnel.c | 50 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 19 deletions(-)

diff --git a/ip/iptunnel.c b/ip/iptunnel.c
index b6da1459..8d590704 100644
--- a/ip/iptunnel.c
+++ b/ip/iptunnel.c
@@ -24,6 +24,18 @@
 #include "ip_common.h"
 #include "tunnel.h"
 
+/*
+ * The tunnel ioctls are device private: the driver of whatever device
+ * owns the name decides how many bytes it copies to ifru_data.  The
+ * name may belong to an IPv6 tunnel (user error, or a rename between
+ * the link dump and the ioctl), so always give the kernel a buffer
+ * large enough for any tunnel parameter block.
+ */
+union ip_tnl_parm {
+	struct ip_tunnel_parm ip_tnl;
+	struct ip6_tnl_parm2 ip6_tnl;
+};
+
 static void usage(void) __attribute__((noreturn));
 
 static void usage(void)
@@ -173,10 +185,7 @@ static int parse_args(int argc, char **argv, int cmd, struct ip_tunnel_parm *p)
 			if (get_ifname(p->name, *argv))
 				invarg("\"name\" not a valid ifname", *argv);
 			if (cmd == SIOCCHGTUNNEL && count == 0) {
-				union {
-					struct ip_tunnel_parm ip_tnl;
-					struct ip6_tnl_parm2 ip6_tnl;
-				} old_p = {};
+				union ip_tnl_parm old_p = {};
 
 				if (tnl_get_ioctl(*argv, &old_p))
 					return -1;
@@ -260,35 +269,37 @@ static const char *tnl_defname(const struct ip_tunnel_parm *p)
 
 static int do_add(int cmd, int argc, char **argv)
 {
-	struct ip_tunnel_parm p;
+	union ip_tnl_parm u = {};
+	struct ip_tunnel_parm *p = &u.ip_tnl;
 	const char *basedev;
 
-	if (parse_args(argc, argv, cmd, &p) < 0)
+	if (parse_args(argc, argv, cmd, p) < 0)
 		return -1;
 
-	if (p.iph.ttl && p.iph.frag_off == 0) {
+	if (p->iph.ttl && p->iph.frag_off == 0) {
 		fprintf(stderr, "ttl != 0 and nopmtudisc are incompatible\n");
 		return -1;
 	}
 
-	basedev = tnl_defname(&p);
+	basedev = tnl_defname(p);
 	if (!basedev) {
 		fprintf(stderr,
 			"cannot determine tunnel mode (ipip, gre, vti or sit)\n");
 		return -1;
 	}
 
-	return tnl_add_ioctl(cmd, basedev, p.name, &p);
+	return tnl_add_ioctl(cmd, basedev, p->name, &u);
 }
 
 static int do_del(int argc, char **argv)
 {
-	struct ip_tunnel_parm p;
+	union ip_tnl_parm u = {};
+	struct ip_tunnel_parm *p = &u.ip_tnl;
 
-	if (parse_args(argc, argv, SIOCDELTUNNEL, &p) < 0)
+	if (parse_args(argc, argv, SIOCDELTUNNEL, p) < 0)
 		return -1;
 
-	return tnl_del_ioctl(tnl_defname(&p) ? : p.name, p.name, &p);
+	return tnl_del_ioctl(tnl_defname(p) ? : p->name, p->name, &u);
 }
 
 static void print_tunnel(const void *t)
@@ -410,17 +421,18 @@ static bool ip_tunnel_parm_match(const struct tnl_print_nlmsg_info *info)
 
 static int do_show(int argc, char **argv)
 {
-	struct ip_tunnel_parm p, p1;
+	union ip_tnl_parm u = {}, u1 = {};
+	struct ip_tunnel_parm *p = &u.ip_tnl;
 	const char *basedev;
 
-	if (parse_args(argc, argv, SIOCGETTUNNEL, &p) < 0)
+	if (parse_args(argc, argv, SIOCGETTUNNEL, p) < 0)
 		return -1;
 
-	basedev = tnl_defname(&p);
+	basedev = tnl_defname(p);
 	if (!basedev) {
 		struct tnl_print_nlmsg_info info = {
-			.p1    = &p,
-			.p2    = &p1,
+			.p1    = p,
+			.p2    = &u1,
 			.init  = ip_tunnel_parm_initialize,
 			.match = ip_tunnel_parm_match,
 			.print = print_tunnel,
@@ -429,10 +441,10 @@ static int do_show(int argc, char **argv)
 		return do_tunnels_list(&info);
 	}
 
-	if (tnl_get_ioctl(p.name[0] ? p.name : basedev, &p))
+	if (tnl_get_ioctl(p->name[0] ? p->name : basedev, &u))
 		return -1;
 
-	print_tunnel(&p);
+	print_tunnel(p);
 	fputc('\n', stdout);
 	return 0;
 }
-- 
2.53.0

