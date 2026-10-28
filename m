Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.202
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793186212;
	b=NJkys3DYqZ2aQ941R20u4qVgymplXJzuirt/VLnsIPgdTuHBdsSD6rq6txay9dvmJ1db
	 YTePY85tpRa98RkfqnQz2TDMG9mBSljtn4lYa85Kb+CNcIyRXr4adNnxaZozWg2VqCMxs
	 ryrLvfcjhREfypA48GPc0VbM72G4UefdY5YbMPdh3eE9WtXo33RTIML3P7VP2NPRG7c8/
	 RqBoZP9sWx5OdetMEgkrrTKAL5dPGjb9QYqw/zy2l/fFeEAIxqpDGlcfPXwMIeeCisxG6
	 j4H/IpRFOGeDwnsxgzkUSeWjfmqG1YMjsPtlGMI/XMw9jMEFz//mzqTbGHEyGEOsxcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793186212;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GR/yFWtGsd7tJ+Usqsgdls8RQ503SxfITShiJgwMejs=;
	b=tdj9Lrsqzf2sowORkzVdOAR3dXN6MNFLzY8Ki4j+YAyHLkntOqmgLl6YyebfR6fTc/WY
	 lg7cq6Up7GMqZsLhG4fEIJsYuTKk+OV/43b2zqLVSYTn6Lz+fRbW+iGjOatPpyYb/qpzz
	 o0xKkLPRzMTa4FyQxiBjVzlQzsfW2/pyFhLNYqRjBjcgrTIVrQAQ2geCLeo0y3oPRm7RO
	 9bRzCyxeGr1AySMjSWri7gjMSkCxiYhyXQAUy1/Fa0FxS5zJxuDG9vwSMBWtu6q715Uvy
	 p5TbiSF0d74INYCdjPN3WCyvcYRyjDEws5ntVOHV/jRyiKYUOpURHt0KPvLGYIxTE4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TuFDdViG;
	arc=none smtp.remote-ip=74.125.231.202
Received: from mail-oi2-f10.google.com (mail-oi2-f10.google.com [74.125.231.202])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A10606A324
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 11:16:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89A10606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TuFDdViG
Received: by mail-oi2-f10.google.com with SMTP id 5614622812f47-4f742fc5d09so229599b6e.0
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 04:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793186211; x=1793791011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GR/yFWtGsd7tJ+Usqsgdls8RQ503SxfITShiJgwMejs=;
        b=TuFDdViGJGEL+b0nZfQKqmZyadWwdWMzBmFH+Mn7eeNaUHjaDgL07albXg0moMw9or
         9+JnvbXMRY6g0zpKWR8JMQ42xGk5CNHlmUj/wJkDMVIGSfuCf62/EwBaUIbB6CGDC0Ct
         cRRYLOBnhn+a1dyNi9s1oq/Ct4znyKZrx46NhV2gQhuDiEgOGEjkLp5guXAz3sUjbDKx
         icJWDFuwZdM+esbT/v1I1mXHJPIiH6N//3grhqxjAe4CIN4W+6sxnaVFF9gq93XKOKKq
         XHY1R737tLhs0APhGCAPhqF2V7EzZPPt18ruafFAY7KQxTCJPS3wmSYZgHCn+6DO8FmP
         p0Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793186211; x=1793791011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GR/yFWtGsd7tJ+Usqsgdls8RQ503SxfITShiJgwMejs=;
        b=QMh2XH1C4HJnaNB8zo7g0vqClMkXExbPP9DT58t7t+V//Y8k0D02IeUTVKblNiFyn+
         1iXnN6fzV1ER4cvTSj+6dSoHkQRuQa2m6EwM2ZYVfN6PsFgfdsuGXzbLvTjhuLB/hjns
         LA9DRtd1D9hwLndkuxPLouPpF+R10N2egoRLXvd+u3rvpAxogbJkEN9UrpfvCNfukF/I
         Q3UFSJ4lByoGvvWfVTZZICeOcDRAyftx1gZLm0fnc1+lEEMn4VLb/okAi8A9+YWVLppL
         7+chi7N41RrhWi8d8YNIy4/I0lcpgKm/MGm9sZeGdhVk0G9uMFtwR22VVlqXIfFu0xUe
         hZOQ==
X-Gm-Message-State: AFq9FYLdo6+KvcV657i4SseXflZcoKXLprMvNDh2Ll9R0tX/9SMNslcS
	Rfsm++SNot8MzrQ0ua5kM2gXjw1CUHF5oH6/kDJlitQbSjSQ7rJcDQf9
X-Gm-Gg: AYBFou01REHGZs3F6ShRA/aLYI/F4ZzKnTMSgthOQ/mCmT5Heal/ZGUgSh5Ty6JUYl/
	jYUY1lgLsgQAv/YreWnvfCVflEkXjPFvNfr3v/KpWqhvpFuJwpj1RhB5dyxaWdrTAtI0e6YZiSS
	fQ1uExXM3agaKN5yZLwo8Ecoes8ZIkgH/sul5xO93jakDhxEdSSu9NV3KSve9oRemSBP6laLpsk
	eDFx8C8on2oz5UKmpn6fcmY2m0kSrHfApWvvg1d4xAlJjNeNHTVEuvCFjP0iT05b+zE/s+BfU2W
	NAls1Nj8UEnyi0C40xQkqPLdWc5e0BYhETZRwzxRJ1C1xExUSHgUSF9wLAzRoB21g3abKbzMREJ
	zjK67wt1go+V/1sTgiuiZGehwcPspYUvar7IDVL6NMZmBKMpEA7/TPd7tu+fzThqjnS5drqoPg5
	J7SLONJxBpBDKoUI7iyXmat1GHPdt+oyM1l9gOPpk11RggUocPi8Rk9Csg/QYcdwe03XpsyWpaL
	4df5yq6AeEw8wLdKSJkA8ACF+WQ+s4lWOJzsloqVjVMY9wYPCwR4WCVL13kEtnKC/XCPKNYiSxO
	BzKdM9dE2gbwc9NiLQTh8WwKpIwoo+FwLF+8EeVBTLQ0Qnr6e3duO2TyE6VWFn5ipQ68
X-Received: by 2002:a05:6808:2229:b0:4c3:6d56:77c2 with SMTP id 5614622812f47-56382d8e3b4mr1287682b6e.41.1793186211387;
        Wed, 28 Oct 2026 04:16:51 -0700 (PDT)
Received: from localhost.localdomain ([14.116.239.34])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a8b77ac4e4sm2003351fac.3.2026.10.28.04.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 04:16:49 -0700 (PDT)
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
Subject: [PATCH net v5 2/2] vxlan: reject VNI add when the default fdb entry is nexthop-backed
Date: Wed, 28 Oct 2026 19:16:26 +0800
Message-ID: <20261028111626.3460759-2-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261028111626.3460759-1-bsdhenrymartin@gmail.com>
References: <20261028111626.3460759-1-bsdhenrymartin@gmail.com>
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

v5: fix a build error on current net/main: vxlan->cfg became an
    RCU-managed pointer, so reference the function-local cfg
    (reported by kernel test robot).

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
+	    !vxlan_addr_any(&cfg->remote_ip)) {
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
