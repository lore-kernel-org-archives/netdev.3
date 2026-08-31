Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4033C09EA
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 08:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788166363; cv=none; b=hgXhMoKrvxhntS/5r5F+B5oxVvADKhUR3SbPTOf0u4tIs0EMLn4Ox+EmeJg6vtLJ0/t4uF03qUSdXZ31HAQCL3xiZBqLydhefw4Dk5pldcSXHYwGCXepokJwDsyOXWINwHPZQe+S5SUn8aVf3uAcUTnya+XTxf7gcsJxZDk13CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788166363; c=relaxed/simple;
	bh=cKoXIHb2ZuYycMu8ZqrpbWLAyXEe2FutGWvTbc17nDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ea23SoOmJbbKDXgWtVIXNBD72xF9ZfvSb/i3jbW2Ue4ngfZhsEUALgAv3Su6lQKLzQo2pxZo3DxhOguys2Y+dYPV0KMqzZlb80jXQ9DYXrh4375qu4mj/lW/7Ldli1E1z9bhmX2QlorEjIeoz7cEpcRQqJVNF7WVYthE+/VqdNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XaXMfyo+; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XaXMfyo+"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-482e5733a5aso1893789f8f.0
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 01:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788166359; x=1788771159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rX7O4Cyu214edbufKKR6tV50lN9glgVksMzMntzrD6w=;
        b=XaXMfyo+lEkcQOa1TZb/plqpI2z9SfhTjBTiZYLhCihSreDPBLAWx+QI0t5ezIc1jC
         6NVAk7WvZ9Or9h5MsVmLEmYQQp4fs30ItWJn6T0j2ru/pdISuvqg3sIXY8bfaLMgUhBQ
         mCBSyu3oVhGrsvkBROUtQueM3GNeCA81kpQ67Vx0x7IlKTcekK7Yev4R/yp2a+N40fl4
         Bj8BA5GEazznuzWDTiP0gLt1NksCXsnFmRJkGHyi/x2qG8K1mbWLXr86kTME1xioK6LM
         /fh9Z4XTyzdAY1o61rf8KZ4NSZ7RS5Fshm5LoG22xyY5Jac/D01ejhVCIuQHDeZb33s5
         i6Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788166359; x=1788771159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rX7O4Cyu214edbufKKR6tV50lN9glgVksMzMntzrD6w=;
        b=NQed4OCbOoAABAkjMyGVQm5bHwQCWr1FWRa0kRypmN5KYcBsmCIUHldFbiiGf3b/aG
         gl5XgUo6bfijEgBqQOe+M5d9nZnfjfUJxjEIwz07qJsTt03TfCi3qULpqilufodqMby+
         QCbYGm5jbnqOKkE3w/F2xvG1FrUyz9HkgXgtqmP++XxBoOjFZLXquZf/oFrkuzyeabff
         rVUDt4N7f5MMRVu/9aXsQbf+obhhBIjbREQCXxRU/yyIZyLSKKIcr8FZ2hg1rkdmfZo3
         STahtuHwjZwJg6P7errJ25XeLyroKwhLVVZj/OrNugvE3K2YyGv3enswiAxrPhCrC1JZ
         f8kA==
X-Forwarded-Encrypted: i=1; AKwUvByJEOFNRMTg8BJGJJTlTR3LtmDCBX5nYXugQ9IKuZUDALgs8v3295WKmrP/utd6Wyh+Ty4J2Ds=@vger.kernel.org
X-Gm-Message-State: AFuF++l1kQmv6HPHg7SKottuGpU2fF06LZCQ1/EjUZF46J5ioNwpY6zW
	w0Yz0ZJ8ou+LpGk3vhzyRqevcxtsmyEzJW9BnjAa9ZLhU0HBj4LW86Qm
X-Gm-Gg: AYBFou0ZLkWa78s1QtZxb0ZYb1/cvwyQq732AaYC9v4f43nl/1rbHunAEbVDiJBhkl7
	6Zzuf0RCaFnMObTQjv+zIKr5T3Ck8fxG4DA0qAgxUyJ2jnyr6mvnBBvgM7zMxQNTsadp/8QQSL6
	zM49rPd9l0uk2nMc+RAb/4I6dKRB1gZ9uI4Qa+GP6wn2FjteJWI3cNyZSr1rKB2d+cxM3iY4RaG
	qMDoJ1D5Sgi6t92RH7boit3+VChJVYxhlJJ1ENS5LuWY4hGiC/7aL76TBy4fnGcsQXLk+IbQegE
	NRQOLGtSbIQqV8cMpqrL2GFmu9QDsEYuVusFC7whPyqmSruURmpQapEk/DobkmJll4cHJeDvbYe
	ugGOZb1+xbZSa1cvapjEyuE1RhgtqXHMvTFHTusniHXyBmSdduI9I4ih3uq+Lfgeb4PxgPYuaOW
	MUAiUwPqkvIwTERbJKE8TLudTJFDc+HqCEpqYAMWNCs2xhlJwVToSMy0/HZHQhtX4=
X-Received: by 2002:a05:6000:4b10:b0:483:8040:449a with SMTP id ffacd0b85a97d-4843efbb9efmr2786355f8f.12.1788166358924;
        Mon, 31 Aug 2026 01:52:38 -0700 (PDT)
Received: from SVR.localdomain ([185.179.67.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-484397f33fesm7786600f8f.15.2026.08.31.01.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 01:52:38 -0700 (PDT)
Sender: Semih Baskan <strstgs@gmail.com>
From: Semih Baskan <strst.gs@gmail.com>
To: florian.fainelli@broadcom.com,
	jonas.gorski@gmail.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: vladimir.oltean@nxp.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3 1/2] net: dsa: let drivers offload 8021q uppers on standalone ports
Date: Mon, 31 Aug 2026 11:52:16 +0300
Message-ID: <20260831085217.391-2-strst.gs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831085217.391-1-strst.gs@gmail.com>
References: <20260831085217.391-1-strst.gs@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before v5.15, DSA delivered the VIDs of 8021q uppers to switch
drivers unconditionally: user ports advertised
NETIF_F_HW_VLAN_CTAG_FILTER, the 8021q layer reported upper VIDs to
.ndo_vlan_rx_add_vid, and .port_vlan_add programmed them whether or
not a bridge had enabled VLAN filtering. Commit 06cfb2df7eb0 ("net:
dsa: don't advertise 'rx-vlan-filter' when not needed") stopped the
delivery for standalone ports and commit f089652b6b16 ("net: dsa: b53:
do not program vlans when vlan filtering is off") stopped the
programming, on the model that a standalone port is VLAN-unaware and
any 8021q upper is a software VLAN.

That model does not fit hardware whose VID lookup cannot be turned off.
b53 keeps its lookup enabled at all times, because disabling it moves
the ARL to shared VLAN learning: the hash that selects the ARL slot then
treats every VID as 0, entries keyed by a real VID become unreachable,
and the hardware table drifts away from the bridge fdb. With the lookup
active, a tagged frame whose VID is absent from the table is discarded
before it reaches the CPU, measured on bcm5301x. Such a port is never
VLAN-unaware, whatever the bridge asked for. Commit 06cfb2df7eb0 ("net:
dsa: don't advertise 'rx-vlan-filter' when not needed") lists the
reasons a driver may keep it on, and this is its first case, standalone
ports that would otherwise drop VLAN-tagged traffic, except that here
the VLAN awareness is held on by the silicon itself rather than by a
VLAN-aware bridge elsewhere on the switch.

The existing opt-in, ds->needs_standalone_vlan_filtering, is not a
fit. It exists for hellcreek, whose traffic separation depends on
per-port VLANs, so standalone operation there needs the
vlan_filtering state itself forced on:
dsa_port_reset_vlan_filtering() forces vlan_filtering=1 when a port
leaves a VLAN-unaware bridge, and with vlan_filtering_is_global that
lands the whole switch in the state hellcreek wants. On b53 the same
flip is a user-visible mode change for every port on the switch:
bridge VLANs that were committed while inactive become enforced, and
the unknown-VID ingress drop modes turn on chip-wide.
b53 needs the VIDs, not the state.

Add ds->needs_standalone_vlan_offload for that narrower need. It
advertises NETIF_F_HW_VLAN_CTAG_FILTER on user ports permanently, so
upper VIDs reach .port_vlan_add again, and it leaves the
vlan_filtering state alone. This restores the pre-v5.15 delivery
pipeline for drivers that opt in and changes nothing for drivers
that do not.

A permanent feature bit also means dsa_user_manage_vlan_filtering()
must not run on vlan_filtering toggles of such a switch. The
ds->ops->port_vlan_filtering call is unchanged and the driver still
sees every toggle; what is skipped only toggles the feature bit and
replays or clears the VID list, and both halves are wrong when the
bit never goes away. The replay re-adds VIDs that were never cleared,
so vlan_vid_add() refcounts every upper VID twice. The clear strips
the feature bit and the VIDs from a port that happens to be bridged
at toggle time, and its uppers then stay dead even after it leaves
the bridge, because nothing re-offloads them once the feature bit is
gone. Both effects were measured on bcm5301x hardware. The conduit
change path keeps its explicit teardown and restore of the 8021q
upper VLANs, and now runs it for every port of such a switch,
bridged or not, because with the permanent feature bit every port
with uppers has VLANs on the CPU port.

Fixes: 06cfb2df7eb0 ("net: dsa: don't advertise 'rx-vlan-filter' when not needed")
Cc: stable@vger.kernel.org
Signed-off-by: Semih Baskan <strst.gs@gmail.com>
---
 include/net/dsa.h |  3 +++
 net/dsa/port.c    | 22 +++++++++++++++-------
 net/dsa/user.c    |  4 +++-
 3 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index 7507d632e7c6..67a01fc5f81e 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -405,6 +405,9 @@ struct dsa_switch {
 	/* Keep VLAN filtering enabled on ports not offloading any upper */
 	u32			needs_standalone_vlan_filtering:1;
 
+	/* Offload 8021q uppers of standalone ports even when not filtering */
+	u32			needs_standalone_vlan_offload:1;
+
 	/* Pass .port_vlan_add and .port_vlan_del to drivers even for bridges
 	 * that have vlan_filtering=0. All drivers should ideally set this (and
 	 * then the option would get removed), but it is unknown whether this
diff --git a/net/dsa/port.c b/net/dsa/port.c
index 1f5536c0dffc..e61abc7c74f7 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -831,6 +831,9 @@ int dsa_port_vlan_filtering(struct dsa_port *dp, bool vlan_filtering,
 			if (!user)
 				continue;
 
+			if (ds->needs_standalone_vlan_offload)
+				continue;
+
 			err = dsa_user_manage_vlan_filtering(user,
 							     vlan_filtering);
 			if (err)
@@ -839,10 +842,12 @@ int dsa_port_vlan_filtering(struct dsa_port *dp, bool vlan_filtering,
 	} else {
 		dp->vlan_filtering = vlan_filtering;
 
-		err = dsa_user_manage_vlan_filtering(dp->user,
-						     vlan_filtering);
-		if (err)
-			goto restore;
+		if (!ds->needs_standalone_vlan_offload) {
+			err = dsa_user_manage_vlan_filtering(dp->user,
+							     vlan_filtering);
+			if (err)
+				goto restore;
+		}
 	}
 
 	return 0;
@@ -1445,10 +1450,13 @@ int dsa_port_change_conduit(struct dsa_port *dp, struct net_device *conduit,
 
 	/* The port might still be VLAN filtering even if it's no longer
 	 * under a bridge, either due to ds->vlan_filtering_is_global or
-	 * ds->needs_standalone_vlan_filtering. In turn this means VLANs
-	 * on the CPU port.
+	 * ds->needs_standalone_vlan_filtering, and every port of a
+	 * ds->needs_standalone_vlan_offload switch keeps its 8021q upper
+	 * VLANs whether bridged or not. In turn this means VLANs on the
+	 * CPU port.
 	 */
-	vlan_filtering = dsa_port_is_vlan_filtering(dp);
+	vlan_filtering = dsa_port_is_vlan_filtering(dp) ||
+			 ds->needs_standalone_vlan_offload;
 	if (vlan_filtering) {
 		err = dsa_user_manage_vlan_filtering(dev, false);
 		if (err) {
diff --git a/net/dsa/user.c b/net/dsa/user.c
index 041f9060c8ef..fda6ba4fdd13 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -1946,6 +1946,7 @@ static int dsa_user_clear_vlan(struct net_device *vdev, int vid, void *arg)
  *
  * - If standalone (this includes software bridge, software LAG):
  *     - if ds->needs_standalone_vlan_filtering = true, OR if
+ *       ds->needs_standalone_vlan_offload = true, OR if
  *       (ds->vlan_filtering_is_global = true AND there are bridges spanning
  *       this switch chip which have vlan_filtering=1)
  *         - the 8021q upper VLANs
@@ -2717,7 +2718,8 @@ void dsa_user_setup_tagger(struct net_device *user)
 	user->hw_features |= NETIF_F_HW_TC;
 	if (user->needed_tailroom)
 		user->features &= ~(NETIF_F_SG | NETIF_F_FRAGLIST);
-	if (ds->needs_standalone_vlan_filtering)
+	if (ds->needs_standalone_vlan_filtering ||
+	    ds->needs_standalone_vlan_offload)
 		user->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
 
 	user->lltx = true;
-- 
2.53.0.windows.1

