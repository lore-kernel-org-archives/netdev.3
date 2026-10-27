Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793098065;
	b=NlnGtvFOOC6G6xfdWRZGNL/D9dDkaFwcddHqIHDyOR0ofv6AWTs0U5pR6zb6evYX57Cc
	 er64Uez7PZcMMVl+ueu7KrvL+YDePtSChvy64PpvAwksovSQoMMJiGimh5ZPwmT6F7nGY
	 gcuPus9O8OnGM6SQ8qnN8lLBplfoXRruakLnbW29JTeU4gNbXg/sBxnmylhzBy24JI5um
	 JaHwIbjliLIzXXG85KsNSotHKFhqoDL1Ij9uz/FoUlDV/FpQoZylD5Nk6my67FsAe7Ha6
	 TQr+K5GWP+sHJB8gwIEcvZ3KhGJiqwtsTljPFr0XOBgwnmZ/STdmQAs3rHf8MHpwCIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793098065;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=31yePHJkZvVIMPqk+qU1LWlJ9GBJamyVeNTyh7KlbfM=;
	b=J0GC4IpGsBf7HQUXGHLEHPxBaZPg0I068KfflJd8JysdPneIcf9mrS+NFnT9DxzGw3bD
	 GMycVAel6wri1i6c8gxjE33HNI9jTOv+3PktsV4g7Ime0w3DiB/ZNjt1zNnwYn7lg6itB
	 +Eu7yInHXUGpih97XqpSMrIUdMfltf3TgiYmBZhN3pYm5FhCJKmeGIlzMu5OSnUcrvCMX
	 +/51+G42uIlp7p7CYWt6IKff0W8C4FUc/wIkmKFXsxhSGxq3Tw8EspoocULJJ42nOWnVv
	 UarGzcPS9oexkQaxNXgqfAjaNA0OxoumDPQ4kE51cFichDivubw+fS18ym8qp8xFfyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nv9rbupi;
	arc=none smtp.remote-ip=74.125.231.136
Received: from mail-oo2-f8.google.com (mail-oo2-f8.google.com [74.125.231.136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A4B606A32F
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 10:47:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92A4B606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nv9rbupi
Received: by mail-oo2-f8.google.com with SMTP id 006d021491bc7-6debc457754so1634639eaf.0
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 03:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793098063; x=1793702863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=31yePHJkZvVIMPqk+qU1LWlJ9GBJamyVeNTyh7KlbfM=;
        b=nv9rbupi+ErQQzelJi+myJQTS+9F61QxOVOWKDArpr6CskZuZxl7X+alV1TdNTdN9R
         +4/q256sSuKxfiNWGbkZVJIArsvnOzyun9qOyjB9AzykLR0T444643LiJcufHYdOfE0P
         /WGRcjXnyR5E9cEREYWGr9ruXm/MONtTYCXSpJ8ecgs4E8ft6hCKx6YLB3ab3O96ON+L
         hGWoVn2m5nY2HwJb7uREQxhgrk+nhbhEQ+kZdj+stW6nFirl9A6YWeAw3drYoyldwc+U
         15BMmktxdaiiaipNAp9w98JtQrcGJ+I7Lwlaga2fOf4qf12ATD6/pFGOvdJf2jqy88cd
         VYmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793098063; x=1793702863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=31yePHJkZvVIMPqk+qU1LWlJ9GBJamyVeNTyh7KlbfM=;
        b=jM4DZlcY5EgNlHAmUodgjRl4kLMF2A8Pe4VhULILUDJ3IKl+RTfeG0SQ4TRX7hnQJb
         JyyNShTp04bIgbhvmKO6MCeqrDSUlD9taW4EvTfMd0Bdt2E1ZiF+cTYW2DoQPe+Xs8JA
         CRFYxOJ2IEA0DiTW1t2tt11kxiZe9f2KB+aa7c9ppdoxosXomJ9SONjRXVk+guco7y1U
         VLk2UeD+8xMkMtaN9L3hy7E1GjhbeJq7d43x5jap6lYKUIQdnwKMvA76rimH6to6DXkp
         4tzPZKZAFbiqCtSa6l/mKuT2RhcBXX2Q1C0ib4ODXi6ge+tOWj/eDISzL42PW3FaGL/6
         ONqQ==
X-Gm-Message-State: AFq9FYIpIm1PB/ZQE7IhOjwgAJzuaNapXMAXNF1xLSI6EYSkajXK7aY+
	pQNY5jzTJYC5RJ+Q8Pqd8Po2+3cHbX4QEiWk2WRo8AfHG+iEY1rGte7z
X-Gm-Gg: AYBFou0SgRLy4iLqwRaC/DXUC+Lt3qgMuw+4ie6V3JdcNsMzYX0ChTzRiuTPwySy9PG
	0SfMSCkh0GZ0jtPoAs+tInQW5Scn5N67Vj1bBN7yptmYLrJvpPfL/urGrSHDUmY7u2nSWW4NRCB
	iASl2+fLXF9dYSgfXIdKnlSpgOcDU8NwaC95OQwkD5svcUTrzDuDcr86v8XYCwCLRw9Q7cU2wUZ
	XgR2ePoC6LDwEpjYahiBGpOdhnp4r+AwZFTEdsCOWWdzVZ/r21hQ1OMzCWCZ6nxRp8oAnCI/P7v
	BwnaVbszf+4Y/28ohUWAvhgo0uN34tAhxjbYl61/Dyrvb0tAf3Uv2z8IpoXyDDpn/i1f6r+gRF0
	geiX51N7YDDZz3tel7VBIUqwLM6NOYjGCusUYHckPj3qz8rCcW/eFZ1yBHWAbWQG4tqDI3JEii/
	8woFLqZp354C2DIGih71m+AujPsEac0bBXUDibZ6YzDVVXt5LPnucH7hsDn8NVyfcNhmht3Jyn4
	C9gkDSK1Myrj+TxCm402cb7DriDJxxa8NWA24mw+dnbulp9xDLIQ7SXquxFoNiZKLLQ6VQUtODJ
	UaypG2fFDwL80yRzQx0=
X-Received: by 2002:a05:6820:1c84:b0:6b1:a812:9871 with SMTP id 006d021491bc7-70da9e1b77emr3695466eaf.18.1793098063493;
        Tue, 27 Oct 2026 03:47:43 -0700 (PDT)
Received: from localhost.localdomain ([14.116.239.36])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a842e89b77sm6597299fac.2.2026.10.27.03.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 03:47:41 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: Ido Schimmel <idosch@nvidia.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Petr Machata <petrm@nvidia.com>,
	Ferruh Yigit <ferruh.yigit@amd.com>,
	Antoine Tenart <atenart@redhat.com>,
	Seungwon Bae <qotmddnjs@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v4 2/2] vxlan: reject VNI add when the default fdb entry is nexthop-backed
Date: Tue, 27 Oct 2026 18:47:13 +0800
Message-ID: <20261027104713.328028-2-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261027104713.328028-1-bsdhenrymartin@gmail.com>
References: <20261027104713.328028-1-bsdhenrymartin@gmail.com>
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

vxlan_vni_add() installs the new VNI - hash table insert, group list,
socket attach and the RTM_NEWTUNNEL notification - before calling
vxlan_vni_update_group(), which in turn calls
vxlan_update_default_fdb_entry() to store the group (or the device's
default remote) into the all-zeros fdb entry of that VNI.

Now that vxlan_fdb_update_existing() rejects appending a remote to a
nexthop-backed default entry, the group store can fail with
-EOPNOTSUPP after the VNI has already been installed and announced,
leaving it half-installed: present in the tables and announced, but
with no remote stored and no multicast join.

Check whether the default fdb entry for the VNI is backed by a
nexthop before installing the VNI, and reject the add up front.

Note: the missing unwind in vxlan_vni_add() predates this series;
this check avoids giving user space a deterministic way to reach it.

Cc: stable@vger.kernel.org
Fixes: 1274e1cc4226 ("vxlan: ecmp support for mac fdb entries")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---

v4: new patch; the failure path was made reachable by patch 1, so
    guard it before the VNI is installed (sashiko review of v2).

 drivers/net/vxlan/vxlan_core.c      | 14 ++++++++++++++
 drivers/net/vxlan/vxlan_private.h   |  2 ++
 drivers/net/vxlan/vxlan_vnifilter.c | 14 ++++++++++++++
 3 files changed, 30 insertions(+)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 3390e341d1e58..13143085065f6 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -422,6 +422,20 @@ static struct vxlan_fdb *vxlan_find_mac(struct vxlan_dev *vxlan,
 	return f;
 }
 
+bool vxlan_fdb_entry_nh_backed(struct vxlan_dev *vxlan, const u8 *mac,
+			       __be32 vni)
+{
+	struct vxlan_fdb *f;
+	bool ret;
+
+	spin_lock_bh(&vxlan->hash_lock);
+	f = vxlan_find_mac(vxlan, mac, vni);
+	ret = f && rcu_access_pointer(f->nh);
+	spin_unlock_bh(&vxlan->hash_lock);
+
+	return ret;
+}
+
 /* caller should hold vxlan->hash_lock */
 static struct vxlan_rdst *vxlan_fdb_find_rdst(struct vxlan_fdb *f,
 					      union vxlan_addr *ip, __be16 port,

diff --git a/drivers/net/vxlan/vxlan_private.h b/drivers/net/vxlan/vxlan_private.h
index b1eec22163608..0454689965aeb 100644
--- a/drivers/net/vxlan/vxlan_private.h
+++ b/drivers/net/vxlan/vxlan_private.h
@@ -11,6 +11,8 @@
 
 extern unsigned int vxlan_net_id;
 extern const u8 all_zeros_mac[ETH_ALEN + 2];
+bool vxlan_fdb_entry_nh_backed(struct vxlan_dev *vxlan,
+			       const u8 *mac, __be32 vni);
 extern const struct rhashtable_params vxlan_vni_rht_params;
 
 #define PORT_HASH_BITS	8

diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
index dd94085e08865..f07ae2a6a59ed 100644
--- a/drivers/net/vxlan/vxlan_vnifilter.c
+++ b/drivers/net/vxlan/vxlan_vnifilter.c
@@ -737,6 +737,20 @@ static int vxlan_vni_add(struct vxlan_dev *vxlan,
 		return err;
 	}
 
+	/* A default fdb entry that is backed by a nexthop group can
+	 * never take a remote; reject before the VNI is installed,
+	 * otherwise a failure in vxlan_vni_update_group() would leave
+	 * the VNI half-installed.
+	 */
+	if ((group && !vxlan_addr_any(group)) ||
+	    !vxlan_addr_any(&vxlan->cfg.remote_ip)) {
+		if (vxlan_fdb_entry_nh_backed(vxlan, all_zeros_mac, v)) {
+			NL_SET_ERR_MSG(extack,
+				       "Cannot add a remote to a nexthop fdb entry");
+			return -EOPNOTSUPP;
+		}
+	}
+
 	vninode = vxlan_vni_alloc(vxlan, v);
 	if (!vninode)
 		return -ENOMEM;
-- 
2.43.7
