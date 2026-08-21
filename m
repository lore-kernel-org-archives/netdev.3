Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DCD47798C
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 10:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787306851; cv=none; b=F4Zqzund2UFGyc0gFSNZg5WRkmQgjBfCbpTgn/WUjZgADueJd5uR5bGXXnMS1Tl7aKZrISlTc5gzkzF0PXiIhGco924XvxESyW3llwfYLPvPE6A2znIKvSFFH3N+oqT7AHxDojQ60bnR5bDM/NGekh0pk8n7ktS6aWVsIjfhhnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787306851; c=relaxed/simple;
	bh=cw/OCEkB3hwDcu02UtKJzWSDrN45dWEQfiVPQMxIPpM=;
	h=Message-ID:MIME-Version:From:To:Cc:Date:Subject:Content-Type; b=BrOYqScTo8GnWvn/Gwy0ilHoTEAfRX8pY7jUviG7AMZlUeJHQmHKZVnITCOW3V/rtDtHRXmsbvTQTJL/iHV3n8eMarr5MJh64eZ2NBvj8soLxkEzF88C87MoxEKC+cwAiCa8o7e7f0FPzsrw3GrI2m66dQ/frz54VOcKklHHTEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FBj6KidU; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBj6KidU"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38e041ea211so731305a91.0
        for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 03:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787306835; x=1787911635; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:date:cc:to:from
         :mime-version:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xLC5C6Z8TsDY7KH1kpXySoBOtQKEhpRRnGXmV/Z0iK0=;
        b=FBj6KidURIVYVqbnCBNQO/5xHz5/Cd3WdKDXT6STcrWmlOucV0cyIigHFsKZxbL+5k
         0SdP9FURJK2HUxBwodJ8uSoQWbkgkT6o9PaJHwsjDiNWUivMKD5BBiSe6pqK3PpEjUHV
         x1TM+NwT5NqHAUS4lnKItriEu5YkEH810wlUOZNhN9S638PTL1N/doXrB9rmE1eOuE70
         CUy5/FpDiPAARMOThiQdIt/WWDGfurJwM6teoG+aL9e/0a1EsyQGeM3QQW87T8H6lWls
         UDzP4Fjnd4yXDYgFAQyYA2QGG2g017oYfajJjL/VpUEoPmLGV1mbpN1bZqsK1RcnUTpe
         RdRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787306835; x=1787911635;
        h=content-transfer-encoding:content-type:subject:date:cc:to:from
         :mime-version:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xLC5C6Z8TsDY7KH1kpXySoBOtQKEhpRRnGXmV/Z0iK0=;
        b=FxupPBHeIoanYOLY8zUWT1wMAvJtNWVRLZc+UQqYCeFcFj0knr1y6yj4U5TRcKVJzZ
         9T/PRa+2oCxRVijTuYGcRbOXqb1SoKYih9F02tor4gj1M28fKFs4FeHAxidSYwHuvKLR
         JrRGTZRBb6Z83fJ2cf7cTYGZK+9lM3o6kk1WfXJsyvJuzXk1j+ny3Np8oLYabaBy0kRr
         +lSab4oQ6DQd7Z8GaX3N16xRGsqTAt0MP3nGjje3tDXhC2x9Sfc9zS2zy5fDOe7sYMqV
         1HSZXJElIxmQb2uiPPrkCaOB6suHeIDDkjscHINBI0LaCKrOENHV0agAjArIa6FW8Kgb
         bZeA==
X-Gm-Message-State: AFuF++nEOa2GMI2F64v8WMLkJX09gbjDeJ7AdzgyDy43jr1eYA84SFbK
	nT5Ca3DFZPdrpAqrNeJsZ7eA+xQnu419ySpzhxmdCyRZhRtrHKdPcdGm
X-Gm-Gg: AR+sD12NtiLh4XBWiF8C2PH2yH9qvr9MtW2SGNwfsgFu9Etn8Br/XkQc/JSItHUawg1
	bQpw2hBlpW3GG2iyzy0Yixw4j273WCZbUR2m1iDuZBvC4OUBZWBUU/1t9HfEc9ItqF1FLnxBfKj
	rIxT6TAI9pTGUVjQEUg4M4DO0F0FhRaU8UL+5c+s91oYL10geD5BsQ4JaP++7HPiSSWpFJXpsi6
	3Z7R78fpm9EgHE1Xr++SnlIMdgLBBLOtjdnOCK4a9af4GWWjepmXqDH5kVbjhlN0+jZedtXmi58
	MilOAL6X09Ia543VXlhk3Q48HyAuJcnDqo9V8WDbJhOSi0ybjGibhvnxlKZkOyFSS/oiOsMe0CM
	GIuLd0wiiKd0YeGqalucxlOnmKoQmIAa2FEvd3oyyXisERfXm4rEHfXLP0LNgPB8NMZEwzCaNd9
	x1gQnNw8PZVY2+6/ujbExmo37GFIV5jI38XXAjyNDXyPbZolpgcJbJ+ohxbu0fUIKu8TX4KkD8U
	Q0NtLizyxEV84/iyyliiONExR5zltDVxKGUqMljGjPR/SMz6e/XUCqX
X-Received: by 2002:a17:90b:6cb:b0:366:3517:1aa2 with SMTP id 98e67ed59e1d1-395c2f13243mr10603400a91.0.1787306835011;
        Fri, 21 Aug 2026 03:07:15 -0700 (PDT)
Received: from manush ([2406:7400:94:f2e0:60f7:d7e:950f:50ce])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1416ad69638sm23110511c88.7.2026.08.21.03.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 03:07:14 -0700 (PDT)
Message-ID: <6a882352.ee10049a.267d65.7a31@mx.google.com>
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
Date: 21 Aug 2026 15:37:14 +0530
Subject: [PATCH v4] net: ethernet: renesas: rswitch: fix device_node
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
v4: Keep the err/if (err < 0) structure as-is instead of collapsi=
ng=0D=0A    it into a single-line check, to keep the diff minimal=
, per Andrew=0D=0A    Lunn's review.=0D=0Av3: Reorder local varia=
ble declarations into reverse Christmas tree=0D=0A    order, per =
Andrew Lunn's review.=0D=0Av2: Rework using for_each_available_ch=
ild_of_node_scoped() instead of=0D=0A    a manual of_node_put(), =
per Andrew Lunn's review.=0D=0A=0D=0A drivers/net/ethernet/renesa=
s/rswitch_main.c | 20 +++++++++-----------=0D=0A 1 file changed, =
10 insertions(+), 10 deletions(-)=0D=0A=0D=0Adiff --git a/drivers=
/net/ethernet/renesas/rswitch_main.c b/drivers/net/ethernet/renes=
as/rswitch_main.c=0D=0Aindex 6fe9648163..1a2b3c4d5e 100644=0D=0A-=
-- a/drivers/net/ethernet/renesas/rswitch_main.c=0D=0A+++ b/drive=
rs/net/ethernet/renesas/rswitch_main.c=0D=0A@@ -1303,8 +1303,9 @@=
=0D=0A /* Call of_node_put(port) after done */=0D=0A static struc=
t device_node *rswitch_get_port_node(struct rswitch_device *rdev)=
=0D=0A {=0D=0A-	struct device_node *ports, *port;=0D=0A-	int err =
=3D 0;=0D=0A+	struct device_node *port =3D NULL;=0D=0A+	struct de=
vice_node *ports;=0D=0A+	int err =3D 0;=0D=0A 	u32 index;=0D=0A=0D=0A=
 	ports =3D of_get_child_by_name(rdev->ndev->dev.parent->of_node,=
=0D=0A@@ -1312,17 +1313,16 @@ static struct device_node *rswitch_=
get_port_node(struct rswitch_device *rdev)=0D=0A 	if (!ports)=0D=0A=
 		return NULL;=0D=0A=0D=0A-	for_each_available_child_of_node(por=
ts, port) {=0D=0A-		err =3D of_property_read_u32(port, "reg", &in=
dex);=0D=0A-		if (err < 0) {=0D=0A-			port =3D NULL;=0D=0A-			got=
o out;=0D=0A-		}=0D=0A-		if (index =3D=3D rdev->etha->index)=0D=0A=
+	for_each_available_child_of_node_scoped(ports, child) {=0D=0A+	=
	err =3D of_property_read_u32(child, "reg", &index);=0D=0A+		if (=
err < 0)=0D=0A 			break;=0D=0A+		if (index =3D=3D rdev->etha->ind=
ex) {=0D=0A+			port =3D of_node_get(child);=0D=0A+			break;=0D=0A=
+		}=0D=0A 	}=0D=0A=0D=0A-out:=0D=0A 	of_node_put(ports);=0D=0A=0D=0A=
 	return port;=0D=0A--=0D=0A2.46.2.windows.1

