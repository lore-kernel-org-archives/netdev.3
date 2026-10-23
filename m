Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792739019;
	b=n44fhhy7dPfHdpikFXH1FHZOb0BkV53YOXVMivdCfWavnvphlinzbaCk+j+/dtR5Bvgh
	 7xLBqSIrl/9fT9CwwiPYt7HeC5tOx4Jpcb4kpLkX0gEtA+bu/jjTvi7DO1ut6GItQZrx4
	 8U4JmOZ1U4t5dU9ttBfAIY/2QzLydKx6V+bgg6w0XrCXY/I3yMyotJNaW0VK1v+ze7cAB
	 qCWUGBaurbuYPeAlmRWyemEVuSA/lfziRfMwP2xBVRLItVBmsB9tUrPwNjOQHGrtJUa0g
	 mnr7tKu9nt7tMBx6lZSaY9ng8ovh4ali4bASCZwljFNE8E59AUang/Xzivo9k1A7vSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792739019;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=75R9zmnE1BoYKXTA7IKrCfrOxlvJnACSHeuJYN46sWk=;
	b=CvYyJw36yrABc7/aaErQk6Zc/DK7qTsPyHlerAoJdsbKQgZKpplMn4J85S16cu1F9hzc
	 IejjjBv6fmaXhSirqrDt6hCHlTCbSVELTvXz5r2wYg/yhypjIiubDo03s2OLguIiwpIyJ
	 npSGtaguZ1PbjXcEFbEnpuSNbDWZ5vTmepMx++yfkUSKQZxN71mgvTp3I5ljwaFhVyDy8
	 RVUZwBFADBJ3WX1Qd2Cx+iy54uI+KP2jcHtXayWn+8M7icIXlCW71bZBJhFL6LoIF5cwU
	 HsEkKsFR2ZYFHH6PESBwxY0GjwwhLVV65culmDi4wQdAG875pkal9yPNDw3WlDbD33w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=isugt0NE;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B84E60A3817
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 07:03:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B84E60A3817
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=isugt0NE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792739017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=75R9zmnE1BoYKXTA7IKrCfrOxlvJnACSHeuJYN46sWk=;
	b=isugt0NEn4TSm4NfW8/2g1LE1gku5ED9/PxRoJgBKw78pJTqig9i/Vb/xzt+Zx5G9CeAgZ
	flX5hsVL6ddZ3H+QRLQn3ZQ+K4ddqNSJYSygjl/JEx7ZR5PJe8JlHG2rbZdcwHM7IU6OQ6
	EzrHjgb2MAonCGk4OL7BmqrLA9uCLtw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-207-p1kmpOMoPIuDWuYvxLby-g-1; Fri,
 23 Oct 2026 03:03:33 -0400
X-MC-Unique: p1kmpOMoPIuDWuYvxLby-g-1
X-Mimecast-MFC-AGG-ID: p1kmpOMoPIuDWuYvxLby-g_1792739011
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 627291800624;
	Fri, 23 Oct 2026 07:03:31 +0000 (UTC)
Received: from poros-thinkpadp16vgen1.tpbc.com (unknown [10.44.32.22])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CA9331800347;
	Fri, 23 Oct 2026 07:03:25 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dave Ertman <david.m.ertman@intel.com>,
	Mateusz Palczewski <mateusz.palczewski@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	Rafal Rogalski <rafalx.rogalski@intel.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH iwl-net v2 4/5] ice: do not block on the aux device lock in ethtool set_channels
Date: Fri, 23 Oct 2026 09:02:56 +0200
Message-ID: <20261023070258.730168-5-poros@redhat.com>
In-Reply-To: <20261023070258.730168-1-poros@redhat.com>
References: <20261023070258.730168-1-poros@redhat.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

ice_set_channels() takes the auxiliary device lock to test whether the
RDMA driver is bound, and ethtool ops run with the RTNL lock held. This
is the same inversion against the RDMA auxiliary probe as the one fixed
in ice_send_event_to_aux(), reached through a different caller.

Use device_trylock() and report the device as busy when it fails. The
existing diagnostic is not reused, a contended lock does not mean the
RDMA driver is bound. It is a netdev_dbg(), the condition is transient
and userspace already learns about it from -EBUSY.

Fixes: a6a0974aae42 ("ice: Prevent set_channel from changing queues while RDMA active")
Signed-off-by: Petr Oros <poros@redhat.com>
---
v2:
- rebased on the new patches 1 and 2, the trylock now sits inside the
  pointer test done under adev_mutex

v1: https://lore.kernel.org/all/20261019065301.3983537-3-poros@redhat.com/
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 5482a64c81c95a..dbc662d6233957 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3947,7 +3947,11 @@ static int ice_set_channels(struct net_device *dev, struct ethtool_channels *ch)
 		mutex_lock(&pf->adev_mutex);
 		adev = pf->cdev_info->adev;
 		if (adev) {
-			device_lock(&adev->dev);
+			if (!device_trylock(&adev->dev)) {
+				mutex_unlock(&pf->adev_mutex);
+				netdev_dbg(dev, "RDMA auxiliary device is busy, try again\n");
+				return -EBUSY;
+			}
 			locked = true;
 			if (adev->dev.driver) {
 				netdev_err(dev, "Cannot change channels when RDMA is active\n");
-- 
2.56.0

