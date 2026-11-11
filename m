Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.210
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794405037;
	b=dCb/VyBvXHimZttvBbTDnqX6m5IlkqwFssBlqJU+PonsKO5gePic8wxk+yFwr3UGPO39
	 fv1u1m6dqN1cszJw+x8UpypOvXI1is0tjEBh4nDLh/KP6K9dolUXRYMJ/8HJD9SUXW7sC
	 KrOyLGjUEW3RNYpsN3x9+iS919XrcvVH/CvZKZBoVHzIS+2k/ghumpCUQ3lRAs3EkgIo4
	 cMpg53tKKmam9eMvCPdndulrEhbI43FIY31SliG5DB3peopvimvlBlu2u1wfhQ+ODBTqp
	 6q41Prd/wQ4h1dmCB2GJEhNCTCRI5/x1K1doEN003aPpBz2IHEtn9Q+dhXtzLAjf5kA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794405037;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lrCLdu1Uj8IpYGbohx64Dr8YzwhjD4Aogvb43lGJo8Q=;
	b=nqgdlviKwOAydjqjmaU0WTCOZLH2t+0dh2VEoVVkWpd51RcRIwayD66i8DI8hPSFnRCu
	 BTM8IEW6QkEs+gW1UsyEUxZpD8XsZXRJCuB5aW0EhSR/AwrNrONcR7adA9iN5sNpvGZit
	 mjEitV78GVj0LNzSDC3CC3OwNhU8tbi7EonoOc4uCQg2mCyr6ehQ8/LiAh9FGhX+Es/fh
	 Cc/ZTmzDVVTRKdWzI9SJ6xDnwQPMcNn3xCuu+HBFU5/wI4Hgq7y+bESxiUxcSagSuHyZy
	 DdKZm89oMDfQeS3vaVef1OqzSDL8FKzLW0BODzazxnOLeIOUMucHGTu5w9qsDWU+ueA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=kqNcUF9L;
	arc=none smtp.remote-ip=203.205.221.210
Received: from out203-205-221-210.mail.qq.com (out203-205-221-210.mail.qq.com [203.205.221.210])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124B0606A327
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 13:50:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 124B0606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=kqNcUF9L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794405028; bh=lrCLdu1Uj8IpYGbohx64Dr8YzwhjD4Aogvb43lGJo8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kqNcUF9LH3c2FJM961kN0RmwZ/A17xC4TR3aZ0ekkWginNPBYVEW9qBGaJZsmDuEL
	 LDtQwPWy4uaT9yBL+ve1hW/Puq6Xo6cF7Ds/hsHaRRazD4fNYp9rN0AZ7VteQ4aq3R
	 BnwkXsANz9WdQh5fbFStROqSnH9+lOchM5/Pzs+I=
Received: from ubuntu.. ([112.3.92.91])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id C92862E4; Wed, 11 Nov 2026 21:50:18 +0800
X-QQ-mid: xmsmtpt1794405020thbzufhkb
Message-ID: <tencent_3206E4502773D7AC6F720CF4046674E5A809@qq.com>
X-QQ-XMAILINFO: N6IfSeM/PG+ti4tgBMk5WwFsx315YDPXfk8C9KO/PPtAfGLRF7pWeLMVjvUxKi
	 Jf3o7ksWWEiWBGFB6YfYnXu110+HwBMgktUgSDooryMeuyuu5DpYXrtaPgY+CrFwG+bR+O0wFl2d
	 SlEsLFxPf3EmS94KxvjqbrTqo0X/gs1hlxEGqI0n1YrA2xPXvUw6n910U2us043Lb8mRKHixQqos
	 pL6ItedeLzruUFLwWkaTcIwVA+hObGwveTJh60KYC/c9DSQZBz9OM05Q9lFbL8+24+ouiNEMlig/
	 qUyLe3KjB01hp8KsgfIRN/3jbzgy81LUhKrELNviHnPOzbkIY9p7FQdLwYfcrlMLI82zB4F1Fw1p
	 v3a1/UYliyq8x/FUnTPnxa1MJP56GKfr/ecB5IyUtqP//KreIH7H5Fb/oCBD22NcBeCugxOAXMNz
	 c+wFBXqJiwTHCjKqLuoNUEj+y1jP3dRiAdlAUIhwch9fbP+a7Vxn55LMCORDgK7mM0JVwP6xmYXR
	 Z4G5vdLOmX5TYjZj2ZN9w8yKJ5SGYeFziN/Nbqn00rvASrt2YhBqm1KcLJuG8ZHtbDANt5H4KS2I
	 JwYTa8OL8KdRe/Nb0zJVi2dJ3pWT5/YV4sFVzoIKlOElvCT6yvK85f2BwspmnxUgXUKgPH+hkUfh
	 UoiMd4bSOSvMkfb40b6cXmWefrJ1ix3juvOMWgFpEhDkVEFf+0nMc+xKXi7TMdRCpqLSdIGpr58b
	 KyrrC4Xk0WslsjiPqwHNIt//74n/cB1Hq9G5ZSv4saETqqDwu25cB1xAqDx6aEACZIARPSal60ho
	 wqHnEezjfd1l7KGnn+DGNfLCepAp8Zo+KjG2BxRmye1dfG/wuOl/hTeO82N7ZE+yfu71cBgvBSA/
	 4rIvNDPRXHrjuYTqgUCi8+/mkd7GE5CvBc00n54iO3DxMgvTS3n1RNw2Tl5UCOrFPf08uVm/27Wu
	 tNm+FVWV/A7TtddDoWSwIYtoP9owmJxJAgYh8w97udoVAZB1e+lCnKusoc1ZuRtIo+YF07TWFJHL
	 D9JI6xY5/rDfN69qWmAqMp/X1I/GGShA+NCcl5H9WY3u0j6U1gd7aNbVHECi9dKNoPZJ1PlmRt7u
	 uo3lFgV5ray71CHtyOTMfO6cTc1FAvX1909LNl7zGmgpMR0z360aaQ1Z6lvS3RfYRrc8IamPZjmi
	 sgNLQ=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Congjie Zhou <zcjie0802@qq.com>
To: netdev@vger.kernel.org
Cc: mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zcjie0802@qq.com
Subject: [PATCH net 2/2] virtio_net: mask callbacks before releasing NAPI ownership
Date: Wed, 11 Nov 2026 21:50:08 +0800
X-OQ-MSGID: <20261111135008.1048054-2-zcjie0802@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_AA4F39DA7ADE330C721C03AAA832B92DD608@qq.com>
References: <tencent_AA4F39DA7ADE330C721C03AAA832B92DD608@qq.com>
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

virtqueue_napi_complete() prepares callbacks before calling
napi_complete_done(), then disables them if completion returns false.
On the hard IRQ deferral path, completion can release NAPI ownership
and arm the watchdog before returning false.

A successor poll can rearm callbacks and complete before the old caller
executes virtqueue_disable_cb(). The stale mask then disables
notifications again. If the one-shot watchdog has already run, no NAPI
owner or timer remains to consume later used entries, causing a
persistent RX stall.

Use napi_complete_done_with_irq_mask() to disable callbacks before
completion can hand NAPI to a successor, and remove the stale mask after
a false return. Keep virtqueue_enable_cb_prepare() before completion:
moving it after ownership release would reintroduce the RX virtqueue
race fixed by commit cbdadbbf0c79 ("virtio_net: fix race in RX VQ
processing").

Signed-off-by: Congjie Zhou <zcjie0802@qq.com>
---
 drivers/net/virtio_net.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index dd2c41ef6..0de6bd95a 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -727,19 +727,23 @@ static void virtqueue_napi_schedule(struct napi_struct *napi,
 	}
 }
 
+static void virtqueue_napi_mask(void *data)
+{
+	virtqueue_disable_cb(data);
+}
+
 static bool virtqueue_napi_complete(struct napi_struct *napi,
 				    struct virtqueue *vq, int processed)
 {
 	int opaque;
 
 	opaque = virtqueue_enable_cb_prepare(vq);
-	if (napi_complete_done(napi, processed)) {
+	if (napi_complete_done_with_irq_mask(napi, processed,
+					     virtqueue_napi_mask, vq)) {
 		if (unlikely(virtqueue_poll(vq, opaque)))
 			virtqueue_napi_schedule(napi, vq);
 		else
 			return true;
-	} else {
-		virtqueue_disable_cb(vq);
 	}
 
 	return false;
-- 
2.43.0

