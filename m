Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794253730;
	b=xxiBrD+SLBcuE/ekIm3Z0k2gbmHVAsB7SmHM6X06Fj0RMCg6CxcqV43CeLUl+udbaU7r
	 aTeLRKARtAN74nrkRtURGlcie7Tp5lVTk1cjyscibQXHDJYyMJ35+6V7atEpGeYqMBnng
	 f9XdCz1ZzoRZTQK1T2Kn5JT/IxF97Yw2KSQ2RRd/seucFq2Q4dmZx9uUE+jALTMGcLS+B
	 RDhhhqebW2JsJGugsNQXafCKUwalA2RQxjrss/ByKNnyXlYg5tkNYJzCYbJwa3M+uG2DC
	 o0pDK/heT2qXOAZxzeSHu3Cnq2QfqZNybN+sZlKFUMVbsnjigiN46xi3Ek5V1q5mmig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794253730;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=CSRtMtlF+ByoNSybcSp5RPlobIyfbjmSYQic9q5nQeg=;
	b=RpW+fCnznMEi17ELzAKUtpMpxYbQErOZXurxUB5VAQB2UWUfuqMhcpCasELzrNZw6O8D
	 pxHX8PUSVOzIsXs3qztwaLApfROxRSgsUO89m72uG1V+Uoubxm3CtmQa1TF4VYFTK9hGO
	 m7SgJdiWEqtTUkX2D57Sr9B0bwe7XGwyBcZ+y5yDNn9a5erznkrCodPI4cfR6IReX5ouD
	 OkcadlPQ9ujDWSj7cL8aGpCqBZpQF/iBqLYlX3h3fTQJy6aTqanLzhHjrDcEwUiryged6
	 vImZfCaIzROP7sdTGJxR+rJqQH/7naGTyIipK0KdgCQAstgrIQicbp1VMK/LB578M9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QtaJIGVl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2928606A325
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 19:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QtaJIGVl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFB9D1F008A7;
	Mon,  9 Nov 2026 19:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794253729;
	bh=CSRtMtlF+ByoNSybcSp5RPlobIyfbjmSYQic9q5nQeg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QtaJIGVlNomKVZ7q8DUBDOVFeDTaxD2G+SiB457BkpMZYZvT6UtT/CyM/s4bVtFMn
	 B8zDkATsbXpbkj/afM99iZoNRjk7tKse6ItXKne5hRck6HFtcPmiBxmHz22iQ24q1P
	 I5fb13uLOsdPXGB+NWSqFssAB5E+g+rPlLH9s/AvKDipPs0wXZXITmHgHmXPW1/WUM
	 eO7qzo2ZY8qvMFo8ofuH0eC20PWfhzBik1fHqUSFlyCgfU+cnrxXmb/w7cTBd6waFG
	 5i7Hs7AKamMWe4gHS5xAxu8SuuY34zwc8xAzv8FKAC97LrdvPicCw+pGnVKjtYytkO
	 oXL8mCDuvVdjQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	kameroncarr@linux.microsoft.com,
	ernis@linux.microsoft.com,
	Jakub Kicinski <kuba@kernel.org>,
	stable+noautosel@kernel.org
Subject: [PATCH net-next v2 1/5] hv_netvsc: fix the program refcount when the VF refuses XDP
Date: Mon,  9 Nov 2026 11:48:39 -0800
Message-ID: <20261109194843.1353592-2-kuba@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109194843.1353592-1-kuba@kernel.org>
References: <20261109194843.1353592-1-kuba@kernel.org>
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

ndo_bpf() takes over the reference it is passed only on success, the
caller puts it back itself on failure. netvsc_xdp_set() takes that one
plus num_chn - 1 more for its channels, and the rollback after the VF
refuses the program clears the channels again, putting all num_chn of
them. dev_xdp_install() then puts the one it passed in a second time,
and the program can be freed while the fd which loaded it still points
at it.

The VF refuses a program netvsc has already committed to when the
program is single-buffer and the VF has header-data split enabled, when
the VF has a memory provider bound, or when the VF's driver has
conditions of its own.

The rollback clears the channels rather than putting back the program
they ran before, too. A refused replace or removal then leaves the
synthetic path running no program at all, while the core and the VF
keep the old one. Put the old program back instead.

Reported by Sashiko during core rework. Unverified and untested.

Cc: stable+noautosel@kernel.org # untested fix to unlikely driver error path
Fixes: 184367dce4f7 ("hv_netvsc: Fix XDP refcnt for synthetic and VF NICs")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - put the old program back on the channels rather than clearing them
   (Kameron)
 - reword the comment on the extra reference, it's the caller's, which
   isn't always the core
 - Tested-by tags from v1 not carried over, the rollback changed
v1: https://lore.kernel.org/20261001014131.310771-2-kuba@kernel.org
---
 drivers/net/hyperv/netvsc_bpf.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/net/hyperv/netvsc_bpf.c b/drivers/net/hyperv/netvsc_bpf.c
index 1dd3755d9e6d..fcc60729384e 100644
--- a/drivers/net/hyperv/netvsc_bpf.c
+++ b/drivers/net/hyperv/netvsc_bpf.c
@@ -197,6 +197,7 @@ int netvsc_bpf(struct net_device *dev, struct netdev_bpf *bpf)
 	struct netvsc_device *nvdev = rtnl_dereference(ndevctx->nvdev);
 	struct net_device *vf_netdev = rtnl_dereference(ndevctx->vf_netdev);
 	struct netlink_ext_ack *extack = bpf->extack;
+	struct bpf_prog *old_prog;
 	int ret;
 
 	if (!nvdev || nvdev->destroy) {
@@ -205,10 +206,17 @@ int netvsc_bpf(struct net_device *dev, struct netdev_bpf *bpf)
 
 	switch (bpf->command) {
 	case XDP_SETUP_PROG:
+		/* Hold on to the old program, to put it back on the channels
+		 * if the VF refuses the change.
+		 */
+		old_prog = netvsc_xdp_get(nvdev);
+		if (old_prog)
+			bpf_prog_inc(old_prog);
+
 		ret = netvsc_xdp_set(dev, bpf->prog, extack, nvdev);
 
 		if (ret)
-			return ret;
+			goto put_old_prog;
 
 		ret = netvsc_vf_setxdp(vf_netdev, bpf->prog);
 
@@ -216,9 +224,22 @@ int netvsc_bpf(struct net_device *dev, struct netdev_bpf *bpf)
 			netdev_err(dev, "vf_setxdp failed:%d\n", ret);
 			NL_SET_ERR_MSG_MOD(extack, "vf_setxdp failed");
 
-			netvsc_xdp_set(dev, NULL, extack, nvdev);
+			/* The caller hands us its reference to bpf->prog only
+			 * on success, take one so that putting the num_chn
+			 * channel references below doesn't consume it.
+			 */
+			if (bpf->prog)
+				bpf_prog_inc(bpf->prog);
+			/* Can't fail, old_prog has passed the same checks
+			 * before. The channels take over our reference to it.
+			 */
+			netvsc_xdp_set(dev, old_prog, extack, nvdev);
+			return ret;
 		}
 
+put_old_prog:
+		if (old_prog)
+			bpf_prog_put(old_prog);
 		return ret;
 
 	default:
-- 
2.56.0

