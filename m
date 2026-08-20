Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89A6344D95
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 05:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787203583; cv=none; b=QtRWTrHohTpYdwHwqFPmNyHY4/RoPYRJX7MhU7BoVzsAylqxLvxRD8Bz2jVA1hNQTEwtWgpX5mAm2ZuZm6VKdCS/iqUSOKwDe05Q1OjqNbHIvpx7havJGtIDLG3C/Aui0KInDFz4N3wEvscBVIYI7XrHpJoKbjWMLYazTbcbJHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787203583; c=relaxed/simple;
	bh=g3+VErzrmJ1Q7QbqM7CpgNSO1hDsSL3qFerYtNpT1TA=;
	h=Message-ID:MIME-Version:From:To:Cc:Date:Subject:Content-Type; b=SX2YsveVON7J8I8D2gbFsRHdKInjY8NCdXvdh7ph0xmzx8LU4z98YEsKwzEf2Ni8EBiC3QaaoEM1kt0jcTgddF/SRmoKCLmQE0+axPEtk169TGKjTJ0BYpVugs93FuCLjLTohi3ULTaBqgBxEX6KWIOux+wOJbbHvZS43tSn+2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I8Qzvbxf; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I8Qzvbxf"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cfbbdfa60bso13648565ad.3
        for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 22:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787203580; x=1787808380; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:date:cc:to:from
         :mime-version:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mHAUdvChFETP+1wGAbo+mta0XNMI5vFtvZjL1xhL7MI=;
        b=I8Qzvbxf6DJfLJAlDV9CDCBiWLzjjg1pQCw8NHiiLDtXChEqqzLO6yBi/MbGXjY4jt
         1nkc5lfuP3xBWZgWsSW6YDDT77ufrcraNgYOa07Yj545szdUodaaTE4yNJcqc6alXof3
         qT6T4w55PbLbL5/YuvelZQoEO/s5p9KCd88Q7MDdZTG569ZZhg7oNA1Na+zl/UqNbzLK
         25MRxHlem8VdpNGK/YqYkvT5WcgoYJxxAbYYIdODWO075In+F6StZ1rxgoy8NX8TXo9y
         gZI4H2vy4YeBoAkU1eMK1NlP524/cXCIpObknmKyNT3kUP68sIc7Jzl40Jvma888pV5z
         e2kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787203580; x=1787808380;
        h=content-transfer-encoding:content-type:subject:date:cc:to:from
         :mime-version:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mHAUdvChFETP+1wGAbo+mta0XNMI5vFtvZjL1xhL7MI=;
        b=tHp5E6RAp7knsuKRnFHUzV7KQwxZ/usmMbgBJngCDg6ZsKkQBgMw5GMKz5S8rwrSB+
         2OysK3V1zC/G/icMyQECsxo9cuj65JjZ0EdWXLb9zlPZXfPhhEPjbgbGF2Qcj6UOtOJ+
         hny21fZYbzQFQMoStQELjcJf/HoJAOYIqqVGt2NAX3aAwWReobo5eO74N/32u0ViK0lc
         RVTUQQ/E0pXw4nzQpfSv7QpqDN+D8SR+TZPZDdW/ouyBs+cvIPF1MXPUwiPdzoMKO5Wx
         3PNShNi/8mldFM383hdpGeJwn2IQV3yBJujS3jpuV4w3+CNCEP287BvvHnmo+UDLpliY
         VD+A==
X-Gm-Message-State: AFuF++kBwm4MiOvI/JpeQwirrEwROmrVv6tOuyeG6xOqGdy8x/GB86ZG
	7BXEGE7/WdzI6+SOK8fqvM9I19XRhOB4DldDsY1p2kXaLlrCo2IEYkM4
X-Gm-Gg: AR+sD10XWadJFpsNhcINB2StqrJLIJvbt08t2ewVA7BJw/9EDk//6gkTA9vDce/pGGZ
	WGsuUNWdhYhGaJSqWEKcrSEURGty1w8HNhEDTnYc8WI2Ux4VdiFrrzhwe0VxW4rEeZTsfXsNpOi
	WW5Pf4nmWk7gT1k3QDHg4C1b4L01e08kyXr3N4PW0p4nD97e0mYT5ItQikv3vanQzxN1r0RIL0V
	xnqyXL6XqiuEwhHkQeiv06o+gQ10RULY/10Upx1peDbXSwIGYWyvRu/28lgzYJf2MhtY0LOENgp
	pmCyGjx85a21fVhwjrbLUYVsZCKYgN/cL+HP29Cs3ncpaS8VyVpHuM6XwJx2xx1LuvzVupQC+0C
	BUqHy90kgzs6gmAkJ5YbNJtslKUHVBP+hs2UezxOzZ1d5bynJVaNfq2NaIef6c8W5vUKVvPdmvZ
	3OljBJBbF2m7z47Slhsm/7dWdgQTummpB5v25L2L8X95tgmdUwrc7yLvH/zFLswGOLVFwUtqvEC
	aYlWNxUfdUs5mXmuUbKfiOzl0y66avNopWnDhf71B+Z7XxgQG+Tq3t8bQ==
X-Received: by 2002:a17:90b:3c47:b0:38f:1a2e:6e56 with SMTP id 98e67ed59e1d1-395813f4f3dmr19559280a91.9.1787203580000;
        Wed, 19 Aug 2026 22:26:20 -0700 (PDT)
Received: from manush ([2406:7400:94:f2e0:d835:beab:fb3c:3432])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1416ad53874sm20588987c88.4.2026.08.19.22.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 22:26:19 -0700 (PDT)
Message-ID: <6a868ffb.2915925c.31ad32.38af@mx.google.com>
X-Mailer: git-send-email-equivalent-ps1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Manush Prajwal" <manushprajwal555@gmail.com>
To: yoshihiro.shimoda.uh@renesas.com, michael.dege@renesas.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Date: 20 Aug 2026 10:56:19 +0530
Subject: [PATCH v3] net: ethernet: renesas: rswitch: fix device_node
 refcount leak in rswitch_get_port_node()
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On an of_property_read_u32() failure, rswitch_get_port_node() set=
 port=0D=0Ato NULL and jumped to the out label before releasing t=
he reference the=0D=0Afor_each_available_child_of_node() iterator=
 was holding on it. Once=0D=0Aport was overwritten with NULL, tha=
t reference could never be=0D=0Areleased since out: only put "por=
ts", the parent node.=0D=0A=0D=0ARework the function around for_e=
ach_available_child_of_node_scoped()=0D=0Ainstead of adding a man=
ual of_node_put(), so the iterator's reference=0D=0Ais dropped au=
tomatically on every exit path. Since port is the=0D=0Afunction's=
 return value, take an explicit reference with of_node_get()=0D=0A=
on the match before breaking out of the loop.=0D=0A=0D=0ASigned-o=
ff-by: Manush Prajwal <manushprajwal555@gmail.com>=0D=0A---=0D=0A=
v3: Reorder local variable declarations into reverse Christmas tr=
ee=0D=0A    order, per Andrew Lunn's review.=0D=0Av2: Rework usin=
g for_each_available_child_of_node_scoped() instead of=0D=0A    a=
 manual of_node_put(), per Andrew Lunn's review.=0D=0A=0D=0A driv=
ers/net/ethernet/renesas/rswitch_main.c | 20 +++++++++-----------=
=0D=0A 1 file changed, 9 insertions(+), 11 deletions(-)=0D=0A=0D=0A=
diff --git a/drivers/net/ethernet/renesas/rswitch_main.c b/driver=
s/net/ethernet/renesas/rswitch_main.c=0D=0Aindex 6fe9648163..ffdc=
42f430 100644=0D=0A--- a/drivers/net/ethernet/renesas/rswitch_mai=
n.c=0D=0A+++ b/drivers/net/ethernet/renesas/rswitch_main.c=0D=0A@=
@ -1303,8 +1303,8 @@=0D=0A /* Call of_node_put(port) after done *=
/=0D=0A static struct device_node *rswitch_get_port_node(struct r=
switch_device *rdev)=0D=0A {=0D=0A-	struct device_node *ports, *p=
ort;=0D=0A-	int err =3D 0;=0D=0A+	struct device_node *port =3D NU=
LL;=0D=0A+	struct device_node *ports;=0D=0A 	u32 index;=0D=0A=0D=0A=
 	ports =3D of_get_child_by_name(rdev->ndev->dev.parent->of_node,=
=0D=0A@@ -1312,17 +1312,15 @@ static struct device_node *rswitch_=
get_port_node(struct rswitch_device *rdev)=0D=0A 	if (!ports)=0D=0A=
 		return NULL;=0D=0A=0D=0A-	for_each_available_child_of_node(por=
ts, port) {=0D=0A-		err =3D of_property_read_u32(port, "reg", &in=
dex);=0D=0A-		if (err < 0) {=0D=0A-			port =3D NULL;=0D=0A-			got=
o out;=0D=0A-		}=0D=0A-		if (index =3D=3D rdev->etha->index)=0D=0A=
+	for_each_available_child_of_node_scoped(ports, child) {=0D=0A+	=
	if (of_property_read_u32(child, "reg", &index))=0D=0A+			break;=0D=0A=
+		if (index =3D=3D rdev->etha->index) {=0D=0A+			port =3D of_nod=
e_get(child);=0D=0A 			break;=0D=0A+		}=0D=0A 	}=0D=0A=0D=0A-out:=
=0D=0A 	of_node_put(ports);=0D=0A=0D=0A 	return port;=0D=0A--=0D=0A=
2.46.2.windows.1

